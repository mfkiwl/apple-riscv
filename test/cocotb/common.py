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

async def load_imem(dut, imem):
    """ Load the instruction ram data """
    print("[TB-INFO]: Loading Instruction Memory")
    size = len(imem)
    for i in range(size):
        dut.DUT_apple_riscv_soc.instruction_ram.ram[i] = imem[i]
    print(f"[TB-INFO]: Loading Instruction Memory done. Memory size is {size}")

async def check_register(dut, expected):
    """ Check the register file with the expected data """
    for key, value in expected.items():
        assert value == dut.DUT_apple_riscv_soc.cpu_core.register_file_inst.rs1_ram[key]
        assert value == dut.DUT_apple_riscv_soc.cpu_core.register_file_inst.rs2_ram[key]

async def run_test(dut, imm_data, expected_register, runtime=100):
    await load_imem(dut, imm_data)
    clock = Clock(dut.clk, 10, units="ns")  # Create a 10us period clock on port clk
    cocotb.fork(clock.start())  # Start the clock
    await reset(dut)
    await Timer(100, units="ns")
    await check_register(dut, expected_register)