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
## Basic test suites for the cpu
##
##################################################################################################

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, Timer
from common import *

###############################
# import instruction ram code
###############################
from imem_data import or1
from imem_data import logic_arithmetic1
from imem_data import logic_arithmetic2

###############################
# Test suites
###############################

@cocotb.test()
async def test_or1(dut):
    """ Simple ORI/OR instruction test """
    await run_test(dut, or1.imem_data, or1.expected_register)

@cocotb.test()
async def test_logic_arithmetic1(dut):
    """ Simple ORI/OR instruction test """
    await run_test(dut, logic_arithmetic1.imem_data, logic_arithmetic1.expected_register, 10000)

@cocotb.test()
async def test_logic_arithmetic2(dut):
    """ Simple ORI/OR instruction test """
    await run_test(dut, logic_arithmetic2.imem_data, logic_arithmetic2.expected_register, 10000)
