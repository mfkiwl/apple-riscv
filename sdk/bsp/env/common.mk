.PHONY: all
all: $(TARGET)


REPO_ROOT   = $(shell git rev-parse --show-toplevel)
BSP_BASE    = $(REPO_ROOT)/sdk/bsp
ENV_DIR     = $(BSP_BASE)/env
NEWLIB_DIR  = $(BSP_BASE)/newlib

ASM_SRCS += $(ENV_DIR)/start.S

C_SRCS += $(NEWLIB_DIR)/_exit.c


LINKER_SCRIPT := $(ENV_DIR)/link_bram.lds

INCLUDES += -I$(ENV_DIR)

#LDFLAGS += -T $(LINKER_SCRIPT) -nostartfiles -Wl, --gc-sections  -Wl,--check_sections
LDFLAGS += -T $(LINKER_SCRIPT)  -nostartfiles -Wl,--gc-sections  -Wl,--check-sections
LDFLAGS += -L$(ENV_DIR)

ASM_OBJS     := $(ASM_SRCS:.S=.o)
C_OBJS       := $(C_SRCS:.c=.o)
DUMP_OBJS    := $(C_SRCS:.c=.dump)
VERILOG_OBJS := $(C_SRCS:.c=.verilog)

LINK_OBJS += $(ASM_OBJS) $(C_OBJS)
LINK_DEPS += $(LINKER_SCRIPT)

CLEAN_OBJS += $(TARGET) $(LINK_OBJS) $(DUMP_OBJS) $(VERILOG_OBJS)

CFLAGS += -g
CFLAGS += -march=$(RISCV_ARCH)
CFLAGS += -mabi=$(RISCV_ABI)
CFLAGS += -ffunction-sections -fdata-sections -fno-common

$(TARGET): $(LINK_OBJS) $(LINK_DEPS)
	$(CC) $(CFLAGS) $(INCLUDES) $(LINK_OBJS) -o $@ $(LDFLAGS)
	$(SIZE) $@

$(ASM_OBJS): %.o: %.S
	$(CC) $(CFLAGS) $(INCLUDES) -c -o $@ $<

$(C_OBJS): %.o: %.c)
	$(CC) $(CFLAGS) $(INCLUDES) -include sys/cdefs.h -c -o $@ $<

.PHONY: clean
clean:
	rm -f $(CLEAN_OBJS)