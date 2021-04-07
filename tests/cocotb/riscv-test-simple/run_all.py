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
    ['add'   , 10000],
    ['addi'  , 10000 ],
    ['and'   , 10000],
    ['andi'  , 10000 ],
    ['auipc'  , 10000 ],
    ['beq'  , 10000 ],
    ['bge'  , 10000 ],
    ['bgeu'  , 10000 ],
    ['blt'  , 10000 ],
    ['bltu'  , 10000 ],
    ['bne'  , 10000 ],
    #['fence_i'  , 10000 ],
    ['jal'  , 10000 ],
    ['jalr'  , 10000 ],     # ??? Having x
    ['lb'   , 10000],       # ??? Having x
    ['lbu'  , 10000 ],      # ??? Having x
    ['lh'   , 10000],       # ??? Having x
    ['lhu'  , 10000 ],      # ??? Having x
    ['lui'  , 10000 ],
    ['lw'  , 10000 ],
    ['or'   , 10000],
    ['ori'  , 10000 ],
    ['sb'   , 10000],
    ['sh'  , 10000 ],
    ['simple', 2000 ],
    ['sll'   , 10000],
    ['slli'  , 10000 ],
    ['slt'   , 10000],
    ['slti'  , 10000 ],
    ['sltu'   , 10000],
    ['sltiu'  , 10000 ],
    ['sra'   , 10000],
    ['srai'  , 10000 ],
    ['srl'   , 10000],
    ['srli'  , 10000 ],
    ['sub'   , 10000],
    ['sw'  , 10000 ],
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
    if os.path.isdir(OUTPUT_DIR):
        shutil.rmtree(OUTPUT_DIR)
    os.system("make clean_all")

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
    os.system("make clean_rom")
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
    print("              Tests Result             ")
    print("=======================================")
    for arch in results.keys():
        print("ISA: " + arch)
        tests = results[arch]
        for test in tests.keys():
            rst = translate[tests[test]]
            print(test + ": " + str(rst), end='')
            if rst == 'PASS':
                print()
            else:
                print('    <---- ' + test + ' ---->')


def main():
    """ Run all the test """
    clear_all()
    results = all_arch_tests(ARCH)
    print_result(results)

main()