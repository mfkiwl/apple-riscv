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

## How to run tests in cocotb framework

See README.md under cocotb folder

