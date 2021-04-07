##################################################################################################
##
## Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
##
## ~~~ Hardware in SpinalHDL ~~~
##
## Author: Heqing Huang
## Date Created: 04/06/2021
##
## ================== Description ==================
##
## Test using riscv-test
##
##################################################################################################

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, Timer

import os
import subprocess

subprocess_run = subprocess.Popen("git rev-parse --show-toplevel", shell=True, stdout=subprocess.PIPE)
subprocess_return = subprocess_run.stdout.read()
REPO_ROOT = subprocess_return.decode().rstrip()

###############################
# Common function
###############################

def link_rom_file(name):
    """ Link the instruction rom file to the tb directory """
    SRC_FILE = REPO_ROOT + '/tests/riscv-tests-simple/generated/' + name + ".verilog"
    INSTR_ROM_FILE = os.getcwd() + '/instr_ram.rom' # need to link the instruction ram file the the current directory
    if os.path.isfile(INSTR_ROM_FILE):
        os.remove(INSTR_ROM_FILE)
    os.symlink(SRC_FILE, INSTR_ROM_FILE)
    DATA_ROM_FILE = os.getcwd() + '/data_ram.rom' # need to link the instruction ram file the the current directory
    if os.path.isfile(DATA_ROM_FILE):
        os.remove(DATA_ROM_FILE)
    os.symlink(SRC_FILE, DATA_ROM_FILE)

def print_register(dut, size=32):
    """ Print the register value """
    for i in range(size):
        try:
            val1 = dut.DUT_apple_riscv_soc.cpu_core.regfile_inst.rs1_ram[i].value.integer
        except ValueError:
            val1 = 'X'
        try:
            val2 = dut.DUT_apple_riscv_soc.cpu_core.regfile_inst.rs2_ram[i].value.integer
        except ValueError:
            val2 = 'X'
        print(f"Register {i}, {hex(val1)}, {hex(val2)}")

def check_register(dut, expected):
    """ Check the register file with the expected data """
    for key, value in expected.items():
        val1 = dut.DUT_apple_riscv_soc.cpu_core.regfile_inst.rs1_ram[key].value.integer
        val2 = dut.DUT_apple_riscv_soc.cpu_core.regfile_inst.rs2_ram[key].value.integer
        assert value == val1, f"RAM1: Register {key}, Expected: {value}, Actual: {val1}"
        assert value == val2, f"RAM2: Register {key}, Expected: {value}, Actual: {val2}"
        print(f"RAM1: Register {key}, Expected: {value}, Actual: {val1}")

async def reset(dut, time=20):
    """ Reset the design """
    dut.reset = 1
    await Timer(time, units="ns")
    await FallingEdge(dut.clk)
    dut.reset = 0




###############################
# Test suites
###############################

@cocotb.test()
async def run_test(dut):
    runtime = int(os.getenv('RUN_TIME'))
    test = os.getenv('RISCV_ARCH') + '-' + os.getenv('TEST_NAME')
    link_rom_file(test)
    clock = Clock(dut.clk, 10, units="ns")  # Create a 10us period clock on port clk
    cocotb.fork(clock.start())  # Start the clock
    await reset(dut)
    await Timer(runtime, units="ns")
    # This pattern is defined in the TEST_PASS macro
    expected_register = {
        1 : 1,
        2 : 2,
        3 : 3,
    }
    print_register(dut, 32)
    check_register(dut, expected_register)
