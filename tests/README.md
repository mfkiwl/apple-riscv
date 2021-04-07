# Test

This directory contains tests for the cpu core and cpu soc

Here is the main structure

## Directory Structures

### Main structure

```text
├── cocotb
│   ├── riscv-test-simple
│   └── sanity_check
├── riscv-tests-simple
└── verilog
```

### cocotb

- riscv-test-simple: Using the modified riscv-test code to test each cpu instruction
- sanity_check: Some simple sanity checks written in riscv asm and translated using the [venus](https://www.kvakil.me/venus/). Check each python file for the asm code.

### riscv-tests-simple

The modified source code from the riscv-test repo. See `README.md` in it for more details

### verilog

Testbench related verilog files

## How to run tests in cocotb

### sanity_check

```bash
# To run all the sanity tests:
make

# To run individual test, using the following command
# make TESTCASE=<test_name>
# Note: <test_name>  is the tests function name defined in sanity_check.py
# For example:
make TESTCASE=test_logic_arithmetic1
```

### riscv-test-simple

```bash
# Here each `make` command can only run one tests.
# Otherwise it will only run the first test and pass the results to the remaining tests
# To run a specific test, use:
# make TESTCASE=<test_name>
# For example:
make TESTCASE=xori
```