#!/usr/bin/python3
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
## script to run all the instructions
##
##################################################################################################

import os
import subprocess
import shutil

#####################################
# ISA
#####################################

# isa and its run time
rv32ui_isa = [
    ['simple', 2000 ],
    ['xor'   , 10000],
    ['xori'  , 3000 ],
]

# architecture
ARCH = {
    'rv32ui': rv32ui_isa
}

#####################################
# Common variable
#####################################

OUTPUT_DIR  = 'output'

FILES  = [
    'DUT_apple_riscv_soc.vcd',
    'results.xml',
]

RESULT = 'results.xml'

#####################################
# Utility function
#####################################

def clear_all():
    """ Clear all the output """
    shutil.rmtree(OUTPUT_DIR)

def move_result(test, arch):
    """ Move the test result to its own directory """
    path = OUTPUT_DIR + '/' + arch + '/' + test
    if not os.path.isdir(path):
        os.makedirs(path)
    for file in FILES:
        tgt = path + '/' + file
        shutil.move(file, tgt)

def run_test(test, arch, runtime):
    """ invoke makefile to run a test """
    cmd = f'make TESTNAME={test} RISCVARCH={arch} RUNTIME={runtime}'
    os.system(cmd)

def check_result():
    """ Check the test result """
    with open(RESULT) as file:
        contents = file.read()
        search_word = "<failure />"
        file.close()
        return not (search_word in contents)

def one_test(test, arch, runtime):
    """ run all the process for one tests """
    run_test(test, arch, runtime)
    result = check_result()
    move_result(test, arch)
    return result

def one_arch_tests(arch):
    """ run all tests in an arch """
    tests = ARCH[arch]
    results = {}
    for test, runtime in tests:
        result = one_test(test, arch, runtime)
        results[test] = result
    return results

def all_arch_tests(archs):
    results = {}
    for arch in archs.keys():
        result = one_arch_tests(arch)
        results[arch] = result
    return results

def print_result(results):
    translate = {
        True: "PASS",
        False: "FAIL"
    }
    print("=======================================")
    print("==            Tests Result           ==")
    print("=======================================")
    for arch in results.keys():
        print("ISA: " + arch)
        tests = results[arch]
        for test in tests.keys():
            rst = translate[tests[test]]
            print(test + ": " + str(rst))


def main():
    """ Run all the test """
    clear_all()
    results = all_arch_tests(ARCH)
    print_result(results)

main()