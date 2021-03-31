##################################################################################################
##
## Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
##
## ~~~ Hardware in SpinalHDL ~~~
##
## Author: Heqing Huang
## Date Created: 03/30/2021
##
## ================== Description ==================
##
## common routine for the testbench
##
##################################################################################################

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, Timer



async def reset(dut, time=20):
    """ Reset the design """
    dut.reset = 1
    await Timer(time, units="ns")
    await FallingEdge(dut.clk)
    dut.reset = 0

def clear_imem(dut, imem_size_to_clear):
    """ Clean the instruction ram """
    print("[TB-INFO]: Cleaning Instruction Memory")
    for i in range(imem_size_to_clear):
        dut.DUT_apple_riscv_soc.instruction_ram.ram[i] = 0
    print(f"[TB-INFO]: Cleaning the Instruction Memory done")

def load_imem(dut, imem):
    """ Load the instruction ram data """
    print("[TB-INFO]: Loading Instruction Memory")
    size = len(imem)
    for i in range(size):
        dut.DUT_apple_riscv_soc.instruction_ram.ram[i] = imem[i]
    print(f"[TB-INFO]: Loading Instruction Memory done. Memory size is {size}")

def print_register(dut, size=32):
    """ Print the register value """
    for i in range(size):
        val1 = dut.DUT_apple_riscv_soc.cpu_core.register_file_inst.rs1_ram[i].value.integer
        val2 = dut.DUT_apple_riscv_soc.cpu_core.register_file_inst.rs2_ram[i].value.integer
        print(f"Register {i}, {val1}, {val2}")

def check_register(dut, expected):
    """ Check the register file with the expected data """
    for key, value in expected.items():
        val1 = dut.DUT_apple_riscv_soc.cpu_core.register_file_inst.rs1_ram[key].value.integer
        val2 = dut.DUT_apple_riscv_soc.cpu_core.register_file_inst.rs2_ram[key].value.integer
        assert value == val1, f"RAM1: Register {key}, Expected: {value}, Actual: {val1}"
        assert value == val2, f"RAM2: Register {key}, Expected: {value}, Actual: {val2}"
        print(f"RAM1: Register {key}, Expected: {value}, Actual: {val1}")

async def run_test(dut, imm_data, expected_register, runtime=400, imem_size_to_clear=100):
    clear_imem(dut, imem_size_to_clear)
    load_imem(dut, imm_data)
    clock = Clock(dut.clk, 10, units="ns")  # Create a 10us period clock on port clk
    cocotb.fork(clock.start())  # Start the clock
    await reset(dut)
    await Timer(runtime, units="ns")
    check_register(dut, expected_register)
    #print_register(dut, 17)