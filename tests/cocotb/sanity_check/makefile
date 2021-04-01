# Makefile

TOPLEVEL_LANG = verilog

REPO_ROOT     = $(shell git rev-parse --show-toplevel)
TB_PATH       = $(REPO_ROOT)/tests/verilog
RTL_SOC_PATH  = $(REPO_ROOT)/rtl/soc

TB_FILES      = $(TB_PATH)/apple_riscv_soc_tb.v
RTL_FILES     = $(RTL_SOC_PATH)/apple_riscv_soc.v

VERILOG_SOURCES += $(TB_FILES)
VERILOG_SOURCES += $(RTL_FILES)

TOPLEVEL = apple_riscv_soc_tb
MODULE   = sanity_check

include $(shell cocotb-config --makefiles)/Makefile.sim

clean_all: clean
	rm -rf *vcd results.xml __pycache__ *.pyc */__pycache__ */*.pyc