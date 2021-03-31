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

###############################
# Test suites
###############################

@cocotb.test()
async def test_or(dut):
    """ Simple ORI/OR instruction test """
    await run_test(dut, or1.imem_data, or1.expected_register)

