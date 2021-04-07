# Cocotb Tests

This folder contains all the tests using cocotb framework


## How to run tests

### sanity check

```bash
# To run all the sanity tests:
make

# To run individual test, using the following command
# make TESTCASE=<test_name>
# Note: <test_name>  is the tests function name defined in sanity_check.py
# For example:
make TESTCASE=test_logic_arithmetic1
```

### riscv test simple

- Run single tests through cocotb makefile flow

    ```bash
    # make TESTNAME=??? RISCVARCH=??? RUNTIME=???
    #   TESTNAME: test instruction name. e.g. simple, xor, xori
    #   RISCVARCH: riscv isa. e.g. rv32ui
    #   RUNTIME: run time in ns. e.g. 3000. Notes: for some tests, runtime needs to be large enough
    # For example:
    make clean_run
    make TESTNAME=simple RISCVARCH=rv32ui RUNTIME=3000
    make TESTNAME=xor RISCVARCH=rv32ui RUNTIME=10000
    ```

- Run all the tests and check result

    ```bash
    ./run_all.py
    ```

    Result and waveform dump will be placed in `output/<arch>/<test>`

    You can define tests and arch you want to run in `rv32ui_isa` and `ARCH` variable in the python script