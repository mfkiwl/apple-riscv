#=======================================================================
# Makefile for riscv-tests/isa
#-----------------------------------------------------------------------

XLEN := 32

src_dir := .

include $(src_dir)/isa/rv32ui/Makefrag
include $(src_dir)/isa/rv32mi/Makefrag
include $(src_dir)/isa/rv32si/Makefrag
include $(src_dir)/isa/soc/Makefrag

default: all

#--------------------------------------------------------------------
# Build rules
#--------------------------------------------------------------------

#RISCV_PREFIX 	?= riscv$(XLEN)-unknown-linux-gnu-
RISCV_PREFIX 	?= riscv-none-embed-
RISCV_GCC 		?= $(RISCV_PREFIX)gcc
RISCV_GCC_OPTS 	?= -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles
RISCV_OBJDUMP 	?= $(RISCV_PREFIX)objdump --disassemble-all
RISCV_OBJCOPY 	?= $(RISCV_PREFIX)objcopy

vpath %.S $(src_dir)/isa


define compile_template

$$($(1)_tests): $(1)-%: $(1)/%.S
	$$(RISCV_GCC) $(2) $$(RISCV_GCC_OPTS) -I$(src_dir)/isa/macros/scalar -I$(src_dir)/env -T$(src_dir)/env/link.ld $$< -o generated/$$@

$(1)_tests += $$($(1)_p_tests)

$(1)_tests_dump = $$(addsuffix .dump, $$($(1)_tests))

$(1): $$($(1)_tests_dump)

.PHONY: $(1)

tests += $$($(1)_tests)

endef

$(eval $(call compile_template,rv32ui,-march=rv32i -mabi=ilp32))
$(eval $(call compile_template,rv32mi,-march=rv32i -mabi=ilp32))
$(eval $(call compile_template,rv32si,-march=rv32i -mabi=ilp32))
$(eval $(call compile_template,soc,-march=rv32i -mabi=ilp32))

tests_dump = $(addsuffix .dump, $(tests))


all: $(tests_dump) generated

%.dump: %
	$(RISCV_OBJDUMP) generated/$< > generated/$@
	$(RISCV_OBJCOPY) -O verilog generated/$< generated/$<.verilog
	rm -r generated/$<

generated:
	mkdir generated

clean:
	rm -rf generated/*