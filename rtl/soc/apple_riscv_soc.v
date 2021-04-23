// Generator : SpinalHDL v1.4.3    git head : adf552d8f500e7419fff395b7049228e4bc5de26
// Component : apple_riscv_soc
// Git hash  : 0e89cd2ec4361c870a7cd4384f8401808f77fa20


`define br_imm_type_e_defaultEncoding_type [1:0]
`define br_imm_type_e_defaultEncoding_JTYPE 2'b00
`define br_imm_type_e_defaultEncoding_BTYPE 2'b01
`define br_imm_type_e_defaultEncoding_ITYPE 2'b10

`define alu_imm_type_e_defaultEncoding_type [2:0]
`define alu_imm_type_e_defaultEncoding_ITYPE 3'b000
`define alu_imm_type_e_defaultEncoding_STYPE 3'b001
`define alu_imm_type_e_defaultEncoding_UTYPE 3'b010
`define alu_imm_type_e_defaultEncoding_FOUR 3'b011
`define alu_imm_type_e_defaultEncoding_ZERO 3'b100

`define UartStopType_defaultEncoding_type [0:0]
`define UartStopType_defaultEncoding_ONE 1'b0
`define UartStopType_defaultEncoding_TWO 1'b1

`define UartParityType_defaultEncoding_type [1:0]
`define UartParityType_defaultEncoding_NONE 2'b00
`define UartParityType_defaultEncoding_EVEN 2'b01
`define UartParityType_defaultEncoding_ODD 2'b10

`define UartCtrlTxState_defaultEncoding_type [2:0]
`define UartCtrlTxState_defaultEncoding_IDLE 3'b000
`define UartCtrlTxState_defaultEncoding_START 3'b001
`define UartCtrlTxState_defaultEncoding_DATA 3'b010
`define UartCtrlTxState_defaultEncoding_PARITY 3'b011
`define UartCtrlTxState_defaultEncoding_STOP 3'b100

`define UartCtrlRxState_defaultEncoding_type [2:0]
`define UartCtrlRxState_defaultEncoding_IDLE 3'b000
`define UartCtrlRxState_defaultEncoding_START 3'b001
`define UartCtrlRxState_defaultEncoding_DATA 3'b010
`define UartCtrlRxState_defaultEncoding_PARITY 3'b011
`define UartCtrlRxState_defaultEncoding_STOP 3'b100


module apple_riscv_soc (
  output              uart_port_txd,
  input               uart_port_rxd,
  input               imem_dbg_sib_sel,
  input               imem_dbg_sib_enable,
  input               imem_dbg_sib_write,
  input      [3:0]    imem_dbg_sib_mask,
  input      [15:0]   imem_dbg_sib_addr,
  input      [31:0]   imem_dbg_sib_wdata,
  output     [31:0]   imem_dbg_sib_rdata,
  output              imem_dbg_sib_ready,
  output              imem_dbg_sib_resp,
   inout     [31:0]   gpio_port_gpio,
  input               clk,
  input               reset
);
  wire                _zz_36;
  wire                _zz_37;
  wire                cpu_core_imem_sib_sel;
  wire                cpu_core_imem_sib_enable;
  wire                cpu_core_imem_sib_write;
  wire       [3:0]    cpu_core_imem_sib_mask;
  wire       [31:0]   cpu_core_imem_sib_wdata;
  wire       [31:0]   cpu_core_imem_sib_addr;
  wire                cpu_core_dmem_sib_sel;
  wire                cpu_core_dmem_sib_enable;
  wire                cpu_core_dmem_sib_write;
  wire       [3:0]    cpu_core_dmem_sib_mask;
  wire       [31:0]   cpu_core_dmem_sib_wdata;
  wire       [31:0]   cpu_core_dmem_sib_addr;
  wire       [31:0]   imem_inst_imem_cpu_sib_rdata;
  wire                imem_inst_imem_cpu_sib_ready;
  wire                imem_inst_imem_cpu_sib_resp;
  wire       [31:0]   imem_inst_imem_dbg_sib_rdata;
  wire                imem_inst_imem_dbg_sib_ready;
  wire                imem_inst_imem_dbg_sib_resp;
  wire       [31:0]   dmem_inst_dmem_sib_rdata;
  wire                dmem_inst_dmem_sib_ready;
  wire                dmem_inst_dmem_sib_resp;
  wire                clic_inst_io_software_interrupt;
  wire                clic_inst_io_timer_interrupt;
  wire       [31:0]   clic_inst_clic_sib_rdata;
  wire                clic_inst_clic_sib_ready;
  wire                clic_inst_clic_sib_resp;
  wire       [31:0]   gpio_inst_io_gpio_write;
  wire       [31:0]   gpio_inst_io_gpio_writeEnable;
  wire                gpio_inst_io_gpio_int_pe;
  wire       [31:0]   gpio_inst_gpio_sib_rdata;
  wire                gpio_inst_gpio_sib_ready;
  wire                gpio_inst_gpio_sib_resp;
  wire                timer_inst_io_timer_interrupt;
  wire       [31:0]   timer_inst_timer_sib_rdata;
  wire                timer_inst_timer_sib_ready;
  wire                timer_inst_timer_sib_resp;
  wire                uart_inst_uart_txd;
  wire       [31:0]   uart_inst_uart_sib_rdata;
  wire                uart_inst_uart_sib_ready;
  wire                uart_inst_uart_sib_resp;
  wire       [31:0]   imem_switch_hostSib_rdata;
  wire                imem_switch_hostSib_ready;
  wire                imem_switch_hostSib_resp;
  wire                imem_switch_clientSib_0_sel;
  wire                imem_switch_clientSib_0_enable;
  wire                imem_switch_clientSib_0_write;
  wire       [3:0]    imem_switch_clientSib_0_mask;
  wire       [31:0]   imem_switch_clientSib_0_wdata;
  wire       [15:0]   imem_switch_clientSib_0_addr;
  wire       [31:0]   dmem_switch_hostSib_rdata;
  wire                dmem_switch_hostSib_ready;
  wire                dmem_switch_hostSib_resp;
  wire                dmem_switch_clientSib_0_sel;
  wire                dmem_switch_clientSib_0_enable;
  wire                dmem_switch_clientSib_0_write;
  wire       [3:0]    dmem_switch_clientSib_0_mask;
  wire       [31:0]   dmem_switch_clientSib_0_wdata;
  wire       [15:0]   dmem_switch_clientSib_0_addr;
  wire                dmem_switch_clientSib_1_sel;
  wire                dmem_switch_clientSib_1_enable;
  wire                dmem_switch_clientSib_1_write;
  wire       [3:0]    dmem_switch_clientSib_1_mask;
  wire       [31:0]   dmem_switch_clientSib_1_wdata;
  wire       [11:0]   dmem_switch_clientSib_1_addr;
  wire                dmem_switch_clientSib_2_sel;
  wire                dmem_switch_clientSib_2_enable;
  wire                dmem_switch_clientSib_2_write;
  wire       [3:0]    dmem_switch_clientSib_2_mask;
  wire       [31:0]   dmem_switch_clientSib_2_wdata;
  wire       [15:0]   dmem_switch_clientSib_2_addr;
  wire       [31:0]   perip_switch_hostSib_rdata;
  wire                perip_switch_hostSib_ready;
  wire                perip_switch_hostSib_resp;
  wire                perip_switch_clientSib_0_sel;
  wire                perip_switch_clientSib_0_enable;
  wire                perip_switch_clientSib_0_write;
  wire       [3:0]    perip_switch_clientSib_0_mask;
  wire       [31:0]   perip_switch_clientSib_0_wdata;
  wire       [11:0]   perip_switch_clientSib_0_addr;
  wire                perip_switch_clientSib_1_sel;
  wire                perip_switch_clientSib_1_enable;
  wire                perip_switch_clientSib_1_write;
  wire       [3:0]    perip_switch_clientSib_1_mask;
  wire       [31:0]   perip_switch_clientSib_1_wdata;
  wire       [11:0]   perip_switch_clientSib_1_addr;
  wire                perip_switch_clientSib_2_sel;
  wire                perip_switch_clientSib_2_enable;
  wire                perip_switch_clientSib_2_write;
  wire       [3:0]    perip_switch_clientSib_2_mask;
  wire       [31:0]   perip_switch_clientSib_2_wdata;
  wire       [11:0]   perip_switch_clientSib_2_addr;
  reg                 _zz_1;
  reg                 _zz_2;
  reg                 _zz_3;
  reg                 _zz_4;
  reg                 _zz_5;
  reg                 _zz_6;
  reg                 _zz_7;
  reg                 _zz_8;
  reg                 _zz_9;
  reg                 _zz_10;
  reg                 _zz_11;
  reg                 _zz_12;
  reg                 _zz_13;
  reg                 _zz_14;
  reg                 _zz_15;
  reg                 _zz_16;
  reg                 _zz_17;
  reg                 _zz_18;
  reg                 _zz_19;
  reg                 _zz_20;
  reg                 _zz_21;
  reg                 _zz_22;
  reg                 _zz_23;
  reg                 _zz_24;
  reg                 _zz_25;
  reg                 _zz_26;
  reg                 _zz_27;
  reg                 _zz_28;
  reg                 _zz_29;
  reg                 _zz_30;
  reg                 _zz_31;
  reg                 _zz_32;
  wire       [31:0]   _zz_33;
  wire       [31:0]   _zz_34;
  wire       [31:0]   _zz_35;

  apple_riscv cpu_core (
    .io_external_interrupt    (_zz_36                           ), //i
    .io_timer_interrupt       (clic_inst_io_timer_interrupt     ), //i
    .io_software_interrupt    (clic_inst_io_software_interrupt  ), //i
    .io_debug_interrupt       (_zz_37                           ), //i
    .imem_sib_sel             (cpu_core_imem_sib_sel            ), //o
    .imem_sib_enable          (cpu_core_imem_sib_enable         ), //o
    .imem_sib_write           (cpu_core_imem_sib_write          ), //o
    .imem_sib_mask            (cpu_core_imem_sib_mask[3:0]      ), //o
    .imem_sib_addr            (cpu_core_imem_sib_addr[31:0]     ), //o
    .imem_sib_wdata           (cpu_core_imem_sib_wdata[31:0]    ), //o
    .imem_sib_rdata           (imem_switch_hostSib_rdata[31:0]  ), //i
    .imem_sib_ready           (imem_switch_hostSib_ready        ), //i
    .imem_sib_resp            (imem_switch_hostSib_resp         ), //i
    .dmem_sib_sel             (cpu_core_dmem_sib_sel            ), //o
    .dmem_sib_enable          (cpu_core_dmem_sib_enable         ), //o
    .dmem_sib_write           (cpu_core_dmem_sib_write          ), //o
    .dmem_sib_mask            (cpu_core_dmem_sib_mask[3:0]      ), //o
    .dmem_sib_addr            (cpu_core_dmem_sib_addr[31:0]     ), //o
    .dmem_sib_wdata           (cpu_core_dmem_sib_wdata[31:0]    ), //o
    .dmem_sib_rdata           (dmem_switch_hostSib_rdata[31:0]  ), //i
    .dmem_sib_ready           (dmem_switch_hostSib_ready        ), //i
    .dmem_sib_resp            (dmem_switch_hostSib_resp         ), //i
    .clk                      (clk                              ), //i
    .reset                    (reset                            )  //i
  );
  imem imem_inst (
    .imem_cpu_sib_sel       (imem_switch_clientSib_0_sel          ), //i
    .imem_cpu_sib_enable    (imem_switch_clientSib_0_enable       ), //i
    .imem_cpu_sib_write     (imem_switch_clientSib_0_write        ), //i
    .imem_cpu_sib_mask      (imem_switch_clientSib_0_mask[3:0]    ), //i
    .imem_cpu_sib_addr      (imem_switch_clientSib_0_addr[15:0]   ), //i
    .imem_cpu_sib_wdata     (imem_switch_clientSib_0_wdata[31:0]  ), //i
    .imem_cpu_sib_rdata     (imem_inst_imem_cpu_sib_rdata[31:0]   ), //o
    .imem_cpu_sib_ready     (imem_inst_imem_cpu_sib_ready         ), //o
    .imem_cpu_sib_resp      (imem_inst_imem_cpu_sib_resp          ), //o
    .imem_dbg_sib_sel       (imem_dbg_sib_sel                     ), //i
    .imem_dbg_sib_enable    (imem_dbg_sib_enable                  ), //i
    .imem_dbg_sib_write     (imem_dbg_sib_write                   ), //i
    .imem_dbg_sib_mask      (imem_dbg_sib_mask[3:0]               ), //i
    .imem_dbg_sib_addr      (imem_dbg_sib_addr[15:0]              ), //i
    .imem_dbg_sib_wdata     (imem_dbg_sib_wdata[31:0]             ), //i
    .imem_dbg_sib_rdata     (imem_inst_imem_dbg_sib_rdata[31:0]   ), //o
    .imem_dbg_sib_ready     (imem_inst_imem_dbg_sib_ready         ), //o
    .imem_dbg_sib_resp      (imem_inst_imem_dbg_sib_resp          ), //o
    .clk                    (clk                                  ), //i
    .reset                  (reset                                )  //i
  );
  dmem dmem_inst (
    .dmem_sib_sel       (dmem_switch_clientSib_0_sel          ), //i
    .dmem_sib_enable    (dmem_switch_clientSib_0_enable       ), //i
    .dmem_sib_write     (dmem_switch_clientSib_0_write        ), //i
    .dmem_sib_mask      (dmem_switch_clientSib_0_mask[3:0]    ), //i
    .dmem_sib_addr      (dmem_switch_clientSib_0_addr[15:0]   ), //i
    .dmem_sib_wdata     (dmem_switch_clientSib_0_wdata[31:0]  ), //i
    .dmem_sib_rdata     (dmem_inst_dmem_sib_rdata[31:0]       ), //o
    .dmem_sib_ready     (dmem_inst_dmem_sib_ready             ), //o
    .dmem_sib_resp      (dmem_inst_dmem_sib_resp              ), //o
    .clk                (clk                                  ), //i
    .reset              (reset                                )  //i
  );
  clic clic_inst (
    .io_software_interrupt    (clic_inst_io_software_interrupt      ), //o
    .io_timer_interrupt       (clic_inst_io_timer_interrupt         ), //o
    .clic_sib_sel             (dmem_switch_clientSib_1_sel          ), //i
    .clic_sib_enable          (dmem_switch_clientSib_1_enable       ), //i
    .clic_sib_write           (dmem_switch_clientSib_1_write        ), //i
    .clic_sib_mask            (dmem_switch_clientSib_1_mask[3:0]    ), //i
    .clic_sib_addr            (dmem_switch_clientSib_1_addr[11:0]   ), //i
    .clic_sib_wdata           (dmem_switch_clientSib_1_wdata[31:0]  ), //i
    .clic_sib_rdata           (clic_inst_clic_sib_rdata[31:0]       ), //o
    .clic_sib_ready           (clic_inst_clic_sib_ready             ), //o
    .clic_sib_resp            (clic_inst_clic_sib_resp              ), //o
    .clk                      (clk                                  ), //i
    .reset                    (reset                                )  //i
  );
  gpio gpio_inst (
    .io_gpio_read           (_zz_33[31:0]                          ), //i
    .io_gpio_write          (gpio_inst_io_gpio_write[31:0]         ), //o
    .io_gpio_writeEnable    (gpio_inst_io_gpio_writeEnable[31:0]   ), //o
    .io_gpio_int_pe         (gpio_inst_io_gpio_int_pe              ), //o
    .gpio_sib_sel           (perip_switch_clientSib_1_sel          ), //i
    .gpio_sib_enable        (perip_switch_clientSib_1_enable       ), //i
    .gpio_sib_write         (perip_switch_clientSib_1_write        ), //i
    .gpio_sib_mask          (perip_switch_clientSib_1_mask[3:0]    ), //i
    .gpio_sib_addr          (perip_switch_clientSib_1_addr[11:0]   ), //i
    .gpio_sib_wdata         (perip_switch_clientSib_1_wdata[31:0]  ), //i
    .gpio_sib_rdata         (gpio_inst_gpio_sib_rdata[31:0]        ), //o
    .gpio_sib_ready         (gpio_inst_gpio_sib_ready              ), //o
    .gpio_sib_resp          (gpio_inst_gpio_sib_resp               ), //o
    .clk                    (clk                                   ), //i
    .reset                  (reset                                 )  //i
  );
  timer timer_inst (
    .io_timer_interrupt    (timer_inst_io_timer_interrupt         ), //o
    .timer_sib_sel         (perip_switch_clientSib_0_sel          ), //i
    .timer_sib_enable      (perip_switch_clientSib_0_enable       ), //i
    .timer_sib_write       (perip_switch_clientSib_0_write        ), //i
    .timer_sib_mask        (perip_switch_clientSib_0_mask[3:0]    ), //i
    .timer_sib_addr        (perip_switch_clientSib_0_addr[11:0]   ), //i
    .timer_sib_wdata       (perip_switch_clientSib_0_wdata[31:0]  ), //i
    .timer_sib_rdata       (timer_inst_timer_sib_rdata[31:0]      ), //o
    .timer_sib_ready       (timer_inst_timer_sib_ready            ), //o
    .timer_sib_resp        (timer_inst_timer_sib_resp             ), //o
    .clk                   (clk                                   ), //i
    .reset                 (reset                                 )  //i
  );
  SibUart uart_inst (
    .uart_txd           (uart_inst_uart_txd                    ), //o
    .uart_rxd           (uart_port_rxd                         ), //i
    .uart_sib_sel       (perip_switch_clientSib_2_sel          ), //i
    .uart_sib_enable    (perip_switch_clientSib_2_enable       ), //i
    .uart_sib_write     (perip_switch_clientSib_2_write        ), //i
    .uart_sib_mask      (perip_switch_clientSib_2_mask[3:0]    ), //i
    .uart_sib_addr      (perip_switch_clientSib_2_addr[11:0]   ), //i
    .uart_sib_wdata     (perip_switch_clientSib_2_wdata[31:0]  ), //i
    .uart_sib_rdata     (uart_inst_uart_sib_rdata[31:0]        ), //o
    .uart_sib_ready     (uart_inst_uart_sib_ready              ), //o
    .uart_sib_resp      (uart_inst_uart_sib_resp               ), //o
    .clk                (clk                                   ), //i
    .reset              (reset                                 )  //i
  );
  Sib_decoder imem_switch (
    .hostSib_sel           (cpu_core_imem_sib_sel                ), //i
    .hostSib_enable        (cpu_core_imem_sib_enable             ), //i
    .hostSib_write         (cpu_core_imem_sib_write              ), //i
    .hostSib_mask          (cpu_core_imem_sib_mask[3:0]          ), //i
    .hostSib_addr          (cpu_core_imem_sib_addr[31:0]         ), //i
    .hostSib_wdata         (cpu_core_imem_sib_wdata[31:0]        ), //i
    .hostSib_rdata         (imem_switch_hostSib_rdata[31:0]      ), //o
    .hostSib_ready         (imem_switch_hostSib_ready            ), //o
    .hostSib_resp          (imem_switch_hostSib_resp             ), //o
    .clientSib_0_sel       (imem_switch_clientSib_0_sel          ), //o
    .clientSib_0_enable    (imem_switch_clientSib_0_enable       ), //o
    .clientSib_0_write     (imem_switch_clientSib_0_write        ), //o
    .clientSib_0_mask      (imem_switch_clientSib_0_mask[3:0]    ), //o
    .clientSib_0_addr      (imem_switch_clientSib_0_addr[15:0]   ), //o
    .clientSib_0_wdata     (imem_switch_clientSib_0_wdata[31:0]  ), //o
    .clientSib_0_rdata     (imem_inst_imem_cpu_sib_rdata[31:0]   ), //i
    .clientSib_0_ready     (imem_inst_imem_cpu_sib_ready         ), //i
    .clientSib_0_resp      (imem_inst_imem_cpu_sib_resp          ), //i
    .clk                   (clk                                  ), //i
    .reset                 (reset                                )  //i
  );
  Sib_decoder_1 dmem_switch (
    .hostSib_sel           (cpu_core_dmem_sib_sel                ), //i
    .hostSib_enable        (cpu_core_dmem_sib_enable             ), //i
    .hostSib_write         (cpu_core_dmem_sib_write              ), //i
    .hostSib_mask          (cpu_core_dmem_sib_mask[3:0]          ), //i
    .hostSib_addr          (cpu_core_dmem_sib_addr[31:0]         ), //i
    .hostSib_wdata         (cpu_core_dmem_sib_wdata[31:0]        ), //i
    .hostSib_rdata         (dmem_switch_hostSib_rdata[31:0]      ), //o
    .hostSib_ready         (dmem_switch_hostSib_ready            ), //o
    .hostSib_resp          (dmem_switch_hostSib_resp             ), //o
    .clientSib_0_sel       (dmem_switch_clientSib_0_sel          ), //o
    .clientSib_0_enable    (dmem_switch_clientSib_0_enable       ), //o
    .clientSib_0_write     (dmem_switch_clientSib_0_write        ), //o
    .clientSib_0_mask      (dmem_switch_clientSib_0_mask[3:0]    ), //o
    .clientSib_0_addr      (dmem_switch_clientSib_0_addr[15:0]   ), //o
    .clientSib_0_wdata     (dmem_switch_clientSib_0_wdata[31:0]  ), //o
    .clientSib_0_rdata     (dmem_inst_dmem_sib_rdata[31:0]       ), //i
    .clientSib_0_ready     (dmem_inst_dmem_sib_ready             ), //i
    .clientSib_0_resp      (dmem_inst_dmem_sib_resp              ), //i
    .clientSib_1_sel       (dmem_switch_clientSib_1_sel          ), //o
    .clientSib_1_enable    (dmem_switch_clientSib_1_enable       ), //o
    .clientSib_1_write     (dmem_switch_clientSib_1_write        ), //o
    .clientSib_1_mask      (dmem_switch_clientSib_1_mask[3:0]    ), //o
    .clientSib_1_addr      (dmem_switch_clientSib_1_addr[11:0]   ), //o
    .clientSib_1_wdata     (dmem_switch_clientSib_1_wdata[31:0]  ), //o
    .clientSib_1_rdata     (clic_inst_clic_sib_rdata[31:0]       ), //i
    .clientSib_1_ready     (clic_inst_clic_sib_ready             ), //i
    .clientSib_1_resp      (clic_inst_clic_sib_resp              ), //i
    .clientSib_2_sel       (dmem_switch_clientSib_2_sel          ), //o
    .clientSib_2_enable    (dmem_switch_clientSib_2_enable       ), //o
    .clientSib_2_write     (dmem_switch_clientSib_2_write        ), //o
    .clientSib_2_mask      (dmem_switch_clientSib_2_mask[3:0]    ), //o
    .clientSib_2_addr      (dmem_switch_clientSib_2_addr[15:0]   ), //o
    .clientSib_2_wdata     (dmem_switch_clientSib_2_wdata[31:0]  ), //o
    .clientSib_2_rdata     (perip_switch_hostSib_rdata[31:0]     ), //i
    .clientSib_2_ready     (perip_switch_hostSib_ready           ), //i
    .clientSib_2_resp      (perip_switch_hostSib_resp            ), //i
    .clk                   (clk                                  ), //i
    .reset                 (reset                                )  //i
  );
  Sib_decoder_2 perip_switch (
    .hostSib_sel           (dmem_switch_clientSib_2_sel           ), //i
    .hostSib_enable        (dmem_switch_clientSib_2_enable        ), //i
    .hostSib_write         (dmem_switch_clientSib_2_write         ), //i
    .hostSib_mask          (dmem_switch_clientSib_2_mask[3:0]     ), //i
    .hostSib_addr          (dmem_switch_clientSib_2_addr[15:0]    ), //i
    .hostSib_wdata         (dmem_switch_clientSib_2_wdata[31:0]   ), //i
    .hostSib_rdata         (perip_switch_hostSib_rdata[31:0]      ), //o
    .hostSib_ready         (perip_switch_hostSib_ready            ), //o
    .hostSib_resp          (perip_switch_hostSib_resp             ), //o
    .clientSib_0_sel       (perip_switch_clientSib_0_sel          ), //o
    .clientSib_0_enable    (perip_switch_clientSib_0_enable       ), //o
    .clientSib_0_write     (perip_switch_clientSib_0_write        ), //o
    .clientSib_0_mask      (perip_switch_clientSib_0_mask[3:0]    ), //o
    .clientSib_0_addr      (perip_switch_clientSib_0_addr[11:0]   ), //o
    .clientSib_0_wdata     (perip_switch_clientSib_0_wdata[31:0]  ), //o
    .clientSib_0_rdata     (timer_inst_timer_sib_rdata[31:0]      ), //i
    .clientSib_0_ready     (timer_inst_timer_sib_ready            ), //i
    .clientSib_0_resp      (timer_inst_timer_sib_resp             ), //i
    .clientSib_1_sel       (perip_switch_clientSib_1_sel          ), //o
    .clientSib_1_enable    (perip_switch_clientSib_1_enable       ), //o
    .clientSib_1_write     (perip_switch_clientSib_1_write        ), //o
    .clientSib_1_mask      (perip_switch_clientSib_1_mask[3:0]    ), //o
    .clientSib_1_addr      (perip_switch_clientSib_1_addr[11:0]   ), //o
    .clientSib_1_wdata     (perip_switch_clientSib_1_wdata[31:0]  ), //o
    .clientSib_1_rdata     (gpio_inst_gpio_sib_rdata[31:0]        ), //i
    .clientSib_1_ready     (gpio_inst_gpio_sib_ready              ), //i
    .clientSib_1_resp      (gpio_inst_gpio_sib_resp               ), //i
    .clientSib_2_sel       (perip_switch_clientSib_2_sel          ), //o
    .clientSib_2_enable    (perip_switch_clientSib_2_enable       ), //o
    .clientSib_2_write     (perip_switch_clientSib_2_write        ), //o
    .clientSib_2_mask      (perip_switch_clientSib_2_mask[3:0]    ), //o
    .clientSib_2_addr      (perip_switch_clientSib_2_addr[11:0]   ), //o
    .clientSib_2_wdata     (perip_switch_clientSib_2_wdata[31:0]  ), //o
    .clientSib_2_rdata     (uart_inst_uart_sib_rdata[31:0]        ), //i
    .clientSib_2_ready     (uart_inst_uart_sib_ready              ), //i
    .clientSib_2_resp      (uart_inst_uart_sib_resp               ), //i
    .clk                   (clk                                   ), //i
    .reset                 (reset                                 )  //i
  );
  assign gpio_port_gpio[0] = _zz_32 ? _zz_34[0] : 1'bz;
  assign gpio_port_gpio[1] = _zz_31 ? _zz_34[1] : 1'bz;
  assign gpio_port_gpio[2] = _zz_30 ? _zz_34[2] : 1'bz;
  assign gpio_port_gpio[3] = _zz_29 ? _zz_34[3] : 1'bz;
  assign gpio_port_gpio[4] = _zz_28 ? _zz_34[4] : 1'bz;
  assign gpio_port_gpio[5] = _zz_27 ? _zz_34[5] : 1'bz;
  assign gpio_port_gpio[6] = _zz_26 ? _zz_34[6] : 1'bz;
  assign gpio_port_gpio[7] = _zz_25 ? _zz_34[7] : 1'bz;
  assign gpio_port_gpio[8] = _zz_24 ? _zz_34[8] : 1'bz;
  assign gpio_port_gpio[9] = _zz_23 ? _zz_34[9] : 1'bz;
  assign gpio_port_gpio[10] = _zz_22 ? _zz_34[10] : 1'bz;
  assign gpio_port_gpio[11] = _zz_21 ? _zz_34[11] : 1'bz;
  assign gpio_port_gpio[12] = _zz_20 ? _zz_34[12] : 1'bz;
  assign gpio_port_gpio[13] = _zz_19 ? _zz_34[13] : 1'bz;
  assign gpio_port_gpio[14] = _zz_18 ? _zz_34[14] : 1'bz;
  assign gpio_port_gpio[15] = _zz_17 ? _zz_34[15] : 1'bz;
  assign gpio_port_gpio[16] = _zz_16 ? _zz_34[16] : 1'bz;
  assign gpio_port_gpio[17] = _zz_15 ? _zz_34[17] : 1'bz;
  assign gpio_port_gpio[18] = _zz_14 ? _zz_34[18] : 1'bz;
  assign gpio_port_gpio[19] = _zz_13 ? _zz_34[19] : 1'bz;
  assign gpio_port_gpio[20] = _zz_12 ? _zz_34[20] : 1'bz;
  assign gpio_port_gpio[21] = _zz_11 ? _zz_34[21] : 1'bz;
  assign gpio_port_gpio[22] = _zz_10 ? _zz_34[22] : 1'bz;
  assign gpio_port_gpio[23] = _zz_9 ? _zz_34[23] : 1'bz;
  assign gpio_port_gpio[24] = _zz_8 ? _zz_34[24] : 1'bz;
  assign gpio_port_gpio[25] = _zz_7 ? _zz_34[25] : 1'bz;
  assign gpio_port_gpio[26] = _zz_6 ? _zz_34[26] : 1'bz;
  assign gpio_port_gpio[27] = _zz_5 ? _zz_34[27] : 1'bz;
  assign gpio_port_gpio[28] = _zz_4 ? _zz_34[28] : 1'bz;
  assign gpio_port_gpio[29] = _zz_3 ? _zz_34[29] : 1'bz;
  assign gpio_port_gpio[30] = _zz_2 ? _zz_34[30] : 1'bz;
  assign gpio_port_gpio[31] = _zz_1 ? _zz_34[31] : 1'bz;
  always @ (*) begin
    _zz_1 = 1'b0;
    if(_zz_35[31])begin
      _zz_1 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_2 = 1'b0;
    if(_zz_35[30])begin
      _zz_2 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_3 = 1'b0;
    if(_zz_35[29])begin
      _zz_3 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_4 = 1'b0;
    if(_zz_35[28])begin
      _zz_4 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_5 = 1'b0;
    if(_zz_35[27])begin
      _zz_5 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_6 = 1'b0;
    if(_zz_35[26])begin
      _zz_6 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_7 = 1'b0;
    if(_zz_35[25])begin
      _zz_7 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_8 = 1'b0;
    if(_zz_35[24])begin
      _zz_8 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_9 = 1'b0;
    if(_zz_35[23])begin
      _zz_9 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_10 = 1'b0;
    if(_zz_35[22])begin
      _zz_10 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_11 = 1'b0;
    if(_zz_35[21])begin
      _zz_11 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_12 = 1'b0;
    if(_zz_35[20])begin
      _zz_12 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_13 = 1'b0;
    if(_zz_35[19])begin
      _zz_13 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_14 = 1'b0;
    if(_zz_35[18])begin
      _zz_14 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_15 = 1'b0;
    if(_zz_35[17])begin
      _zz_15 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_16 = 1'b0;
    if(_zz_35[16])begin
      _zz_16 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_17 = 1'b0;
    if(_zz_35[15])begin
      _zz_17 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_18 = 1'b0;
    if(_zz_35[14])begin
      _zz_18 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_19 = 1'b0;
    if(_zz_35[13])begin
      _zz_19 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_20 = 1'b0;
    if(_zz_35[12])begin
      _zz_20 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_21 = 1'b0;
    if(_zz_35[11])begin
      _zz_21 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_22 = 1'b0;
    if(_zz_35[10])begin
      _zz_22 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_23 = 1'b0;
    if(_zz_35[9])begin
      _zz_23 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_24 = 1'b0;
    if(_zz_35[8])begin
      _zz_24 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_25 = 1'b0;
    if(_zz_35[7])begin
      _zz_25 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_26 = 1'b0;
    if(_zz_35[6])begin
      _zz_26 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_27 = 1'b0;
    if(_zz_35[5])begin
      _zz_27 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_28 = 1'b0;
    if(_zz_35[4])begin
      _zz_28 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_29 = 1'b0;
    if(_zz_35[3])begin
      _zz_29 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_30 = 1'b0;
    if(_zz_35[2])begin
      _zz_30 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_31 = 1'b0;
    if(_zz_35[1])begin
      _zz_31 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_32 = 1'b0;
    if(_zz_35[0])begin
      _zz_32 = 1'b1;
    end
  end

  assign imem_dbg_sib_rdata = imem_inst_imem_dbg_sib_rdata;
  assign imem_dbg_sib_ready = imem_inst_imem_dbg_sib_ready;
  assign imem_dbg_sib_resp = imem_inst_imem_dbg_sib_resp;
  assign _zz_34 = gpio_inst_io_gpio_write;
  assign _zz_35 = gpio_inst_io_gpio_writeEnable;
  assign uart_port_txd = uart_inst_uart_txd;
  assign _zz_36 = 1'b0;
  assign _zz_37 = 1'b0;
  assign _zz_33 = gpio_port_gpio;

endmodule

module Sib_decoder_2 (
  input               hostSib_sel,
  input               hostSib_enable,
  input               hostSib_write,
  input      [3:0]    hostSib_mask,
  input      [15:0]   hostSib_addr,
  input      [31:0]   hostSib_wdata,
  output     [31:0]   hostSib_rdata,
  output              hostSib_ready,
  output              hostSib_resp,
  output              clientSib_0_sel,
  output              clientSib_0_enable,
  output              clientSib_0_write,
  output     [3:0]    clientSib_0_mask,
  output     [11:0]   clientSib_0_addr,
  output     [31:0]   clientSib_0_wdata,
  input      [31:0]   clientSib_0_rdata,
  input               clientSib_0_ready,
  input               clientSib_0_resp,
  output              clientSib_1_sel,
  output              clientSib_1_enable,
  output              clientSib_1_write,
  output     [3:0]    clientSib_1_mask,
  output     [11:0]   clientSib_1_addr,
  output     [31:0]   clientSib_1_wdata,
  input      [31:0]   clientSib_1_rdata,
  input               clientSib_1_ready,
  input               clientSib_1_resp,
  output              clientSib_2_sel,
  output              clientSib_2_enable,
  output              clientSib_2_write,
  output     [3:0]    clientSib_2_mask,
  output     [11:0]   clientSib_2_addr,
  output     [31:0]   clientSib_2_wdata,
  input      [31:0]   clientSib_2_rdata,
  input               clientSib_2_ready,
  input               clientSib_2_resp,
  input               clk,
  input               reset
);
  reg        [31:0]   _zz_6;
  reg                 _zz_7;
  reg                 _zz_8;
  wire       [1:0]    _zz_9;
  reg        [2:0]    dec_sel;
  reg        [2:0]    dec_sel_ff;
  wire                dec_good;
  wire                _zz_1;
  wire                _zz_2;
  wire                _zz_3;
  wire                _zz_4;
  wire       [1:0]    _zz_5;

  assign _zz_9 = {_zz_2,_zz_1};
  always @(*) begin
    case(_zz_9)
      2'b00 : begin
        _zz_6 = clientSib_0_rdata;
      end
      2'b01 : begin
        _zz_6 = clientSib_1_rdata;
      end
      default : begin
        _zz_6 = clientSib_2_rdata;
      end
    endcase
  end

  always @(*) begin
    case(_zz_5)
      2'b00 : begin
        _zz_7 = clientSib_0_resp;
        _zz_8 = clientSib_0_ready;
      end
      2'b01 : begin
        _zz_7 = clientSib_1_resp;
        _zz_8 = clientSib_1_ready;
      end
      default : begin
        _zz_7 = clientSib_2_resp;
        _zz_8 = clientSib_2_ready;
      end
    endcase
  end

  assign dec_good = (dec_sel != 3'b000);
  always @ (*) begin
    dec_sel[0] = ((16'h2000 <= hostSib_addr) && (hostSib_addr <= 16'h2fff));
    dec_sel[1] = ((16'h3000 <= hostSib_addr) && (hostSib_addr <= 16'h3fff));
    dec_sel[2] = ((16'h4000 <= hostSib_addr) && (hostSib_addr <= 16'h4fff));
  end

  assign clientSib_0_write = hostSib_write;
  assign clientSib_0_addr = hostSib_addr[11 : 0];
  assign clientSib_0_wdata = hostSib_wdata;
  assign clientSib_0_enable = hostSib_enable;
  assign clientSib_0_mask = hostSib_mask;
  assign clientSib_0_sel = (hostSib_sel && dec_sel[0]);
  assign clientSib_1_write = hostSib_write;
  assign clientSib_1_addr = hostSib_addr[11 : 0];
  assign clientSib_1_wdata = hostSib_wdata;
  assign clientSib_1_enable = hostSib_enable;
  assign clientSib_1_mask = hostSib_mask;
  assign clientSib_1_sel = (hostSib_sel && dec_sel[1]);
  assign clientSib_2_write = hostSib_write;
  assign clientSib_2_addr = hostSib_addr[11 : 0];
  assign clientSib_2_wdata = hostSib_wdata;
  assign clientSib_2_enable = hostSib_enable;
  assign clientSib_2_mask = hostSib_mask;
  assign clientSib_2_sel = (hostSib_sel && dec_sel[2]);
  assign _zz_1 = dec_sel_ff[1];
  assign _zz_2 = dec_sel_ff[2];
  assign hostSib_rdata = _zz_6;
  assign _zz_3 = dec_sel[1];
  assign _zz_4 = dec_sel[2];
  assign _zz_5 = {_zz_4,_zz_3};
  assign hostSib_resp = (_zz_7 && dec_good);
  assign hostSib_ready = _zz_8;
  always @ (posedge clk) begin
    dec_sel_ff <= dec_sel;
  end


endmodule

module Sib_decoder_1 (
  input               hostSib_sel,
  input               hostSib_enable,
  input               hostSib_write,
  input      [3:0]    hostSib_mask,
  input      [31:0]   hostSib_addr,
  input      [31:0]   hostSib_wdata,
  output     [31:0]   hostSib_rdata,
  output              hostSib_ready,
  output              hostSib_resp,
  output              clientSib_0_sel,
  output              clientSib_0_enable,
  output              clientSib_0_write,
  output     [3:0]    clientSib_0_mask,
  output     [15:0]   clientSib_0_addr,
  output     [31:0]   clientSib_0_wdata,
  input      [31:0]   clientSib_0_rdata,
  input               clientSib_0_ready,
  input               clientSib_0_resp,
  output              clientSib_1_sel,
  output              clientSib_1_enable,
  output              clientSib_1_write,
  output     [3:0]    clientSib_1_mask,
  output     [11:0]   clientSib_1_addr,
  output     [31:0]   clientSib_1_wdata,
  input      [31:0]   clientSib_1_rdata,
  input               clientSib_1_ready,
  input               clientSib_1_resp,
  output              clientSib_2_sel,
  output              clientSib_2_enable,
  output              clientSib_2_write,
  output     [3:0]    clientSib_2_mask,
  output     [15:0]   clientSib_2_addr,
  output     [31:0]   clientSib_2_wdata,
  input      [31:0]   clientSib_2_rdata,
  input               clientSib_2_ready,
  input               clientSib_2_resp,
  input               clk,
  input               reset
);
  reg        [31:0]   _zz_6;
  reg                 _zz_7;
  reg                 _zz_8;
  wire       [1:0]    _zz_9;
  reg        [2:0]    dec_sel;
  reg        [2:0]    dec_sel_ff;
  wire                dec_good;
  wire                _zz_1;
  wire                _zz_2;
  wire                _zz_3;
  wire                _zz_4;
  wire       [1:0]    _zz_5;

  assign _zz_9 = {_zz_2,_zz_1};
  always @(*) begin
    case(_zz_9)
      2'b00 : begin
        _zz_6 = clientSib_0_rdata;
      end
      2'b01 : begin
        _zz_6 = clientSib_1_rdata;
      end
      default : begin
        _zz_6 = clientSib_2_rdata;
      end
    endcase
  end

  always @(*) begin
    case(_zz_5)
      2'b00 : begin
        _zz_7 = clientSib_0_resp;
        _zz_8 = clientSib_0_ready;
      end
      2'b01 : begin
        _zz_7 = clientSib_1_resp;
        _zz_8 = clientSib_1_ready;
      end
      default : begin
        _zz_7 = clientSib_2_resp;
        _zz_8 = clientSib_2_ready;
      end
    endcase
  end

  assign dec_good = (dec_sel != 3'b000);
  always @ (*) begin
    dec_sel[0] = ((32'h01000000 <= hostSib_addr) && (hostSib_addr <= 32'h01ffffff));
    dec_sel[1] = ((32'h02000000 <= hostSib_addr) && (hostSib_addr <= 32'h02000fff));
    dec_sel[2] = ((32'h02002000 <= hostSib_addr) && (hostSib_addr <= 32'h02004fff));
  end

  assign clientSib_0_write = hostSib_write;
  assign clientSib_0_addr = hostSib_addr[15 : 0];
  assign clientSib_0_wdata = hostSib_wdata;
  assign clientSib_0_enable = hostSib_enable;
  assign clientSib_0_mask = hostSib_mask;
  assign clientSib_0_sel = (hostSib_sel && dec_sel[0]);
  assign clientSib_1_write = hostSib_write;
  assign clientSib_1_addr = hostSib_addr[11 : 0];
  assign clientSib_1_wdata = hostSib_wdata;
  assign clientSib_1_enable = hostSib_enable;
  assign clientSib_1_mask = hostSib_mask;
  assign clientSib_1_sel = (hostSib_sel && dec_sel[1]);
  assign clientSib_2_write = hostSib_write;
  assign clientSib_2_addr = hostSib_addr[15 : 0];
  assign clientSib_2_wdata = hostSib_wdata;
  assign clientSib_2_enable = hostSib_enable;
  assign clientSib_2_mask = hostSib_mask;
  assign clientSib_2_sel = (hostSib_sel && dec_sel[2]);
  assign _zz_1 = dec_sel_ff[1];
  assign _zz_2 = dec_sel_ff[2];
  assign hostSib_rdata = _zz_6;
  assign _zz_3 = dec_sel[1];
  assign _zz_4 = dec_sel[2];
  assign _zz_5 = {_zz_4,_zz_3};
  assign hostSib_resp = (_zz_7 && dec_good);
  assign hostSib_ready = _zz_8;
  always @ (posedge clk) begin
    dec_sel_ff <= dec_sel;
  end


endmodule

module Sib_decoder (
  input               hostSib_sel,
  input               hostSib_enable,
  input               hostSib_write,
  input      [3:0]    hostSib_mask,
  input      [31:0]   hostSib_addr,
  input      [31:0]   hostSib_wdata,
  output     [31:0]   hostSib_rdata,
  output              hostSib_ready,
  output              hostSib_resp,
  output              clientSib_0_sel,
  output              clientSib_0_enable,
  output              clientSib_0_write,
  output     [3:0]    clientSib_0_mask,
  output     [15:0]   clientSib_0_addr,
  output     [31:0]   clientSib_0_wdata,
  input      [31:0]   clientSib_0_rdata,
  input               clientSib_0_ready,
  input               clientSib_0_resp,
  input               clk,
  input               reset
);
  wire       [0:0]    dec_sel;
  reg        [0:0]    dec_sel_ff;
  wire                dec_good;

  assign dec_good = (dec_sel != 1'b0);
  assign dec_sel[0] = ((32'h0 <= hostSib_addr) && (hostSib_addr <= 32'h00ffffff));
  assign clientSib_0_write = hostSib_write;
  assign clientSib_0_addr = hostSib_addr[15 : 0];
  assign clientSib_0_wdata = hostSib_wdata;
  assign clientSib_0_enable = hostSib_enable;
  assign clientSib_0_mask = hostSib_mask;
  assign clientSib_0_sel = (hostSib_sel && dec_sel[0]);
  assign hostSib_rdata = clientSib_0_rdata;
  assign hostSib_resp = (clientSib_0_resp && dec_good);
  assign hostSib_ready = clientSib_0_ready;
  always @ (posedge clk) begin
    dec_sel_ff <= dec_sel;
  end


endmodule

module SibUart (
  output              uart_txd,
  input               uart_rxd,
  input               uart_sib_sel,
  input               uart_sib_enable,
  input               uart_sib_write,
  input      [3:0]    uart_sib_mask,
  input      [11:0]   uart_sib_addr,
  input      [31:0]   uart_sib_wdata,
  output     [31:0]   uart_sib_rdata,
  output              uart_sib_ready,
  output reg          uart_sib_resp,
  input               clk,
  input               reset
);
  wire                _zz_5;
  wire       [7:0]    _zz_6;
  wire                _zz_7;
  reg                 _zz_8;
  wire                _zz_9;
  wire                uartCtrl_1_io_write_ready;
  wire                uartCtrl_1_io_read_valid;
  wire       [7:0]    uartCtrl_1_io_read_payload;
  wire                uartCtrl_1_io_uart_txd;
  wire                uartCtrl_1_io_readError;
  wire                uartCtrl_1_io_readBreak;
  wire                streamFifo_2_io_push_ready;
  wire                streamFifo_2_io_pop_valid;
  wire       [7:0]    streamFifo_2_io_pop_payload;
  wire       [3:0]    streamFifo_2_io_occupancy;
  wire       [3:0]    streamFifo_2_io_availability;
  wire                uartCtrl_1_io_read_queueWithOccupancy_io_push_ready;
  wire                uartCtrl_1_io_read_queueWithOccupancy_io_pop_valid;
  wire       [7:0]    uartCtrl_1_io_read_queueWithOccupancy_io_pop_payload;
  wire       [3:0]    uartCtrl_1_io_read_queueWithOccupancy_io_occupancy;
  wire       [3:0]    uartCtrl_1_io_read_queueWithOccupancy_io_availability;
  wire       [0:0]    _zz_10;
  wire       [0:0]    _zz_11;
  wire       [0:0]    _zz_12;
  wire       [0:0]    _zz_13;
  wire                busCtrl_doWrite;
  wire                busCtrl_doRead;
  reg        [31:0]   busCtrl_rdata;
  reg        [31:0]   busCtrl_rdata_regNext;
  reg                 rx_avail_int_en;
  reg                 rx_full_int_en;
  reg                 rx_en;
  reg                 tx_en;
  reg        [2:0]    uartCtrl_1_io_config_frame_driver_dataLength;
  reg        `UartStopType_defaultEncoding_type uartCtrl_1_io_config_frame_driver_stop;
  reg        `UartParityType_defaultEncoding_type uartCtrl_1_io_config_frame_driver_parity;
  reg        [19:0]   uartCtrl_1_io_config_clockDivider_driver;
  reg                 _zz_1;
  wire                txFull;
  wire                rxFull;
  wire                rxEmpty;
  wire       [5:0]    _zz_2;
  wire       `UartStopType_defaultEncoding_type _zz_3;
  wire       `UartParityType_defaultEncoding_type _zz_4;
  `ifndef SYNTHESIS
  reg [23:0] uartCtrl_1_io_config_frame_driver_stop_string;
  reg [31:0] uartCtrl_1_io_config_frame_driver_parity_string;
  reg [23:0] _zz_3_string;
  reg [31:0] _zz_4_string;
  `endif


  assign _zz_10 = uart_sib_wdata[0 : 0];
  assign _zz_11 = uart_sib_wdata[1 : 1];
  assign _zz_12 = uart_sib_wdata[4 : 4];
  assign _zz_13 = uart_sib_wdata[5 : 5];
  UartCtrl uartCtrl_1 (
    .io_config_frame_dataLength    (uartCtrl_1_io_config_frame_driver_dataLength[2:0]    ), //i
    .io_config_frame_stop          (uartCtrl_1_io_config_frame_driver_stop               ), //i
    .io_config_frame_parity        (uartCtrl_1_io_config_frame_driver_parity[1:0]        ), //i
    .io_config_clockDivider        (uartCtrl_1_io_config_clockDivider_driver[19:0]       ), //i
    .io_write_valid                (streamFifo_2_io_pop_valid                            ), //i
    .io_write_ready                (uartCtrl_1_io_write_ready                            ), //o
    .io_write_payload              (streamFifo_2_io_pop_payload[7:0]                     ), //i
    .io_read_valid                 (uartCtrl_1_io_read_valid                             ), //o
    .io_read_ready                 (uartCtrl_1_io_read_queueWithOccupancy_io_push_ready  ), //i
    .io_read_payload               (uartCtrl_1_io_read_payload[7:0]                      ), //o
    .io_uart_txd                   (uartCtrl_1_io_uart_txd                               ), //o
    .io_uart_rxd                   (uart_rxd                                             ), //i
    .io_readError                  (uartCtrl_1_io_readError                              ), //o
    .io_writeBreak                 (_zz_5                                                ), //i
    .io_readBreak                  (uartCtrl_1_io_readBreak                              ), //o
    .clk                           (clk                                                  ), //i
    .reset                         (reset                                                )  //i
  );
  StreamFifo streamFifo_2 (
    .io_push_valid      (_zz_1                              ), //i
    .io_push_ready      (streamFifo_2_io_push_ready         ), //o
    .io_push_payload    (_zz_6[7:0]                         ), //i
    .io_pop_valid       (streamFifo_2_io_pop_valid          ), //o
    .io_pop_ready       (uartCtrl_1_io_write_ready          ), //i
    .io_pop_payload     (streamFifo_2_io_pop_payload[7:0]   ), //o
    .io_flush           (_zz_7                              ), //i
    .io_occupancy       (streamFifo_2_io_occupancy[3:0]     ), //o
    .io_availability    (streamFifo_2_io_availability[3:0]  ), //o
    .clk                (clk                                ), //i
    .reset              (reset                              )  //i
  );
  StreamFifo uartCtrl_1_io_read_queueWithOccupancy (
    .io_push_valid      (uartCtrl_1_io_read_valid                                    ), //i
    .io_push_ready      (uartCtrl_1_io_read_queueWithOccupancy_io_push_ready         ), //o
    .io_push_payload    (uartCtrl_1_io_read_payload[7:0]                             ), //i
    .io_pop_valid       (uartCtrl_1_io_read_queueWithOccupancy_io_pop_valid          ), //o
    .io_pop_ready       (_zz_8                                                       ), //i
    .io_pop_payload     (uartCtrl_1_io_read_queueWithOccupancy_io_pop_payload[7:0]   ), //o
    .io_flush           (_zz_9                                                       ), //i
    .io_occupancy       (uartCtrl_1_io_read_queueWithOccupancy_io_occupancy[3:0]     ), //o
    .io_availability    (uartCtrl_1_io_read_queueWithOccupancy_io_availability[3:0]  ), //o
    .clk                (clk                                                         ), //i
    .reset              (reset                                                       )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(uartCtrl_1_io_config_frame_driver_stop)
      `UartStopType_defaultEncoding_ONE : uartCtrl_1_io_config_frame_driver_stop_string = "ONE";
      `UartStopType_defaultEncoding_TWO : uartCtrl_1_io_config_frame_driver_stop_string = "TWO";
      default : uartCtrl_1_io_config_frame_driver_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(uartCtrl_1_io_config_frame_driver_parity)
      `UartParityType_defaultEncoding_NONE : uartCtrl_1_io_config_frame_driver_parity_string = "NONE";
      `UartParityType_defaultEncoding_EVEN : uartCtrl_1_io_config_frame_driver_parity_string = "EVEN";
      `UartParityType_defaultEncoding_ODD : uartCtrl_1_io_config_frame_driver_parity_string = "ODD ";
      default : uartCtrl_1_io_config_frame_driver_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_3)
      `UartStopType_defaultEncoding_ONE : _zz_3_string = "ONE";
      `UartStopType_defaultEncoding_TWO : _zz_3_string = "TWO";
      default : _zz_3_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_4)
      `UartParityType_defaultEncoding_NONE : _zz_4_string = "NONE";
      `UartParityType_defaultEncoding_EVEN : _zz_4_string = "EVEN";
      `UartParityType_defaultEncoding_ODD : _zz_4_string = "ODD ";
      default : _zz_4_string = "????";
    endcase
  end
  `endif

  assign busCtrl_doWrite = (((uart_sib_sel && uart_sib_enable) && uart_sib_ready) && uart_sib_write);
  assign busCtrl_doRead = (((uart_sib_sel && uart_sib_enable) && uart_sib_ready) && (! uart_sib_write));
  always @ (*) begin
    busCtrl_rdata = 32'h0;
    case(uart_sib_addr)
      12'h0 : begin
        busCtrl_rdata[0 : 0] = rx_avail_int_en;
        busCtrl_rdata[1 : 1] = rx_full_int_en;
        busCtrl_rdata[4 : 4] = rx_en;
        busCtrl_rdata[5 : 5] = tx_en;
      end
      12'h004 : begin
        busCtrl_rdata[5 : 0] = {uartCtrl_1_io_config_frame_driver_parity,{uartCtrl_1_io_config_frame_driver_stop,uartCtrl_1_io_config_frame_driver_dataLength}};
      end
      12'h008 : begin
        busCtrl_rdata[19 : 0] = uartCtrl_1_io_config_clockDivider_driver;
      end
      12'h00c : begin
        busCtrl_rdata[31 : 31] = (uartCtrl_1_io_read_queueWithOccupancy_io_pop_valid ^ 1'b0);
        busCtrl_rdata[7 : 0] = uartCtrl_1_io_read_queueWithOccupancy_io_pop_payload;
        busCtrl_rdata[11 : 8] = uartCtrl_1_io_read_queueWithOccupancy_io_occupancy;
      end
      12'h010 : begin
        busCtrl_rdata[0 : 0] = (! rxEmpty);
        busCtrl_rdata[1 : 1] = rxFull;
        busCtrl_rdata[4 : 4] = txFull;
        busCtrl_rdata[5 : 5] = rxEmpty;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    uart_sib_resp = 1'b0;
    case(uart_sib_addr)
      12'h0 : begin
        uart_sib_resp = 1'b1;
      end
      12'h004 : begin
        uart_sib_resp = 1'b1;
      end
      12'h008 : begin
        uart_sib_resp = 1'b1;
      end
      12'h00c : begin
        uart_sib_resp = 1'b1;
      end
      12'h010 : begin
        uart_sib_resp = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign uart_sib_ready = 1'b1;
  assign uart_sib_rdata = busCtrl_rdata_regNext;
  assign uart_txd = uartCtrl_1_io_uart_txd;
  assign _zz_5 = 1'b0;
  always @ (*) begin
    _zz_1 = 1'b0;
    case(uart_sib_addr)
      12'h008 : begin
        if(busCtrl_doWrite)begin
          _zz_1 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign _zz_6 = uart_sib_wdata[7 : 0];
  always @ (*) begin
    _zz_8 = 1'b0;
    case(uart_sib_addr)
      12'h00c : begin
        if(busCtrl_doRead)begin
          _zz_8 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign txFull = (streamFifo_2_io_availability == 4'b0000);
  assign rxFull = (uartCtrl_1_io_read_queueWithOccupancy_io_occupancy == 4'b1000);
  assign rxEmpty = (uartCtrl_1_io_read_queueWithOccupancy_io_occupancy == 4'b0000);
  assign _zz_2 = uart_sib_wdata[5 : 0];
  assign _zz_3 = _zz_2[3 : 3];
  assign _zz_4 = _zz_2[5 : 4];
  assign _zz_7 = 1'b0;
  assign _zz_9 = 1'b0;
  always @ (posedge clk) begin
    busCtrl_rdata_regNext <= busCtrl_rdata;
    case(uart_sib_addr)
      12'h004 : begin
        if(busCtrl_doWrite)begin
          uartCtrl_1_io_config_frame_driver_dataLength <= _zz_2[2 : 0];
          uartCtrl_1_io_config_frame_driver_stop <= _zz_3;
          uartCtrl_1_io_config_frame_driver_parity <= _zz_4;
        end
      end
      12'h008 : begin
        if(busCtrl_doWrite)begin
          uartCtrl_1_io_config_clockDivider_driver <= uart_sib_wdata[19 : 0];
        end
      end
      default : begin
      end
    endcase
  end

  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      rx_avail_int_en <= 1'b1;
      rx_full_int_en <= 1'b1;
      rx_en <= 1'b1;
      tx_en <= 1'b1;
    end else begin
      case(uart_sib_addr)
        12'h0 : begin
          if(busCtrl_doWrite)begin
            rx_avail_int_en <= _zz_10[0];
            rx_full_int_en <= _zz_11[0];
            rx_en <= _zz_12[0];
            tx_en <= _zz_13[0];
          end
        end
        default : begin
        end
      endcase
    end
  end


endmodule

module timer (
  output              io_timer_interrupt,
  input               timer_sib_sel,
  input               timer_sib_enable,
  input               timer_sib_write,
  input      [3:0]    timer_sib_mask,
  input      [11:0]   timer_sib_addr,
  input      [31:0]   timer_sib_wdata,
  output     [31:0]   timer_sib_rdata,
  output              timer_sib_ready,
  output reg          timer_sib_resp,
  input               clk,
  input               reset
);
  wire       [0:0]    _zz_3;
  wire       [0:0]    _zz_4;
  wire       [31:0]   _zz_5;
  wire       [31:0]   _zz_6;
  wire       [31:0]   _zz_7;
  wire       [31:0]   _zz_8;
  wire       [31:0]   _zz_9;
  wire       [31:0]   _zz_10;
  wire       [31:0]   _zz_11;
  wire       [31:0]   _zz_12;
  wire                busCtrl_doWrite;
  wire                busCtrl_doRead;
  reg        [31:0]   busCtrl_rdata;
  reg        [31:0]   busCtrl_rdata_regNext;
  reg                 en;
  reg                 int_en;
  reg                 int_pe;
  reg        [63:0]   timerval;
  wire       [63:0]   _zz_1;
  reg        [63:0]   timercmp;
  wire       [63:0]   _zz_2;

  assign _zz_3 = timer_sib_wdata[0 : 0];
  assign _zz_4 = timer_sib_wdata[1 : 1];
  assign _zz_5 = timer_sib_wdata[31 : 0];
  assign _zz_6 = _zz_5;
  assign _zz_7 = timer_sib_wdata[31 : 0];
  assign _zz_8 = _zz_7;
  assign _zz_9 = timer_sib_wdata[31 : 0];
  assign _zz_10 = _zz_9;
  assign _zz_11 = timer_sib_wdata[31 : 0];
  assign _zz_12 = _zz_11;
  assign busCtrl_doWrite = (((timer_sib_sel && timer_sib_enable) && timer_sib_ready) && timer_sib_write);
  assign busCtrl_doRead = (((timer_sib_sel && timer_sib_enable) && timer_sib_ready) && (! timer_sib_write));
  always @ (*) begin
    busCtrl_rdata = 32'h0;
    case(timer_sib_addr)
      12'h0 : begin
        busCtrl_rdata[0 : 0] = en;
        busCtrl_rdata[1 : 1] = int_en;
        busCtrl_rdata[4 : 4] = int_pe;
      end
      12'h004 : begin
        busCtrl_rdata[31 : 0] = _zz_1[31 : 0];
      end
      12'h008 : begin
        busCtrl_rdata[31 : 0] = _zz_1[63 : 32];
      end
      12'h00c : begin
        busCtrl_rdata[31 : 0] = _zz_2[31 : 0];
      end
      12'h010 : begin
        busCtrl_rdata[31 : 0] = _zz_2[63 : 32];
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    timer_sib_resp = 1'b0;
    case(timer_sib_addr)
      12'h0 : begin
        timer_sib_resp = 1'b1;
      end
      12'h004 : begin
        timer_sib_resp = 1'b1;
      end
      12'h008 : begin
        timer_sib_resp = 1'b1;
      end
      12'h00c : begin
        timer_sib_resp = 1'b1;
      end
      12'h010 : begin
        timer_sib_resp = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign timer_sib_ready = 1'b1;
  assign timer_sib_rdata = busCtrl_rdata_regNext;
  assign _zz_1 = timerval;
  assign _zz_2 = timercmp;
  assign io_timer_interrupt = int_pe;
  always @ (posedge clk) begin
    busCtrl_rdata_regNext <= busCtrl_rdata;
    int_pe <= (((timercmp <= timerval) && (timercmp != 64'h0)) && int_en);
    case(timer_sib_addr)
      12'h00c : begin
        if(busCtrl_doWrite)begin
          timercmp[31 : 0] <= _zz_10;
        end
      end
      12'h010 : begin
        if(busCtrl_doWrite)begin
          timercmp[63 : 32] <= _zz_12;
        end
      end
      default : begin
      end
    endcase
  end

  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      en <= 1'b0;
      int_en <= 1'b0;
      timerval <= 64'h0;
    end else begin
      if(en)begin
        timerval <= (timerval + 64'h0000000000000001);
      end
      case(timer_sib_addr)
        12'h0 : begin
          if(busCtrl_doWrite)begin
            en <= _zz_3[0];
            int_en <= _zz_4[0];
          end
        end
        12'h004 : begin
          if(busCtrl_doWrite)begin
            timerval[31 : 0] <= _zz_6;
          end
        end
        12'h008 : begin
          if(busCtrl_doWrite)begin
            timerval[63 : 32] <= _zz_8;
          end
        end
        default : begin
        end
      endcase
    end
  end


endmodule

module gpio (
  input      [31:0]   io_gpio_read,
  output     [31:0]   io_gpio_write,
  output     [31:0]   io_gpio_writeEnable,
  output              io_gpio_int_pe,
  input               gpio_sib_sel,
  input               gpio_sib_enable,
  input               gpio_sib_write,
  input      [3:0]    gpio_sib_mask,
  input      [11:0]   gpio_sib_addr,
  input      [31:0]   gpio_sib_wdata,
  output     [31:0]   gpio_sib_rdata,
  output              gpio_sib_ready,
  output reg          gpio_sib_resp,
  input               clk,
  input               reset
);
  wire                busCtrl_doWrite;
  wire                busCtrl_doRead;
  reg        [31:0]   busCtrl_rdata;
  reg        [31:0]   busCtrl_rdata_regNext;
  wire                gpio_value_0;
  wire                gpio_value_1;
  wire                gpio_value_2;
  wire                gpio_value_3;
  wire                gpio_value_4;
  wire                gpio_value_5;
  wire                gpio_value_6;
  wire                gpio_value_7;
  wire                gpio_value_8;
  wire                gpio_value_9;
  wire                gpio_value_10;
  wire                gpio_value_11;
  wire                gpio_value_12;
  wire                gpio_value_13;
  wire                gpio_value_14;
  wire                gpio_value_15;
  wire                gpio_value_16;
  wire                gpio_value_17;
  wire                gpio_value_18;
  wire                gpio_value_19;
  wire                gpio_value_20;
  wire                gpio_value_21;
  wire                gpio_value_22;
  wire                gpio_value_23;
  wire                gpio_value_24;
  wire                gpio_value_25;
  wire                gpio_value_26;
  wire                gpio_value_27;
  wire                gpio_value_28;
  wire                gpio_value_29;
  wire                gpio_value_30;
  wire                gpio_value_31;
  reg        [31:0]   _zz_1;
  reg        [31:0]   io_gpio_writeEnable_driver;
  wire                hi_int_int_aggr;
  wire                lo_int_int_aggr;
  wire                ri_int_int_aggr;
  wire                fa_int_int_aggr;

  assign busCtrl_doWrite = (((gpio_sib_sel && gpio_sib_enable) && gpio_sib_ready) && gpio_sib_write);
  assign busCtrl_doRead = (((gpio_sib_sel && gpio_sib_enable) && gpio_sib_ready) && (! gpio_sib_write));
  always @ (*) begin
    busCtrl_rdata = 32'h0;
    case(gpio_sib_addr)
      12'h0 : begin
        busCtrl_rdata[31 : 0] = io_gpio_read;
      end
      12'h004 : begin
        busCtrl_rdata[31 : 0] = io_gpio_writeEnable_driver;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    gpio_sib_resp = 1'b0;
    case(gpio_sib_addr)
      12'h0 : begin
        gpio_sib_resp = 1'b1;
      end
      12'h004 : begin
        gpio_sib_resp = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign gpio_sib_ready = 1'b1;
  assign gpio_sib_rdata = busCtrl_rdata_regNext;
  assign gpio_value_0 = io_gpio_read[0];
  assign gpio_value_1 = io_gpio_read[1];
  assign gpio_value_2 = io_gpio_read[2];
  assign gpio_value_3 = io_gpio_read[3];
  assign gpio_value_4 = io_gpio_read[4];
  assign gpio_value_5 = io_gpio_read[5];
  assign gpio_value_6 = io_gpio_read[6];
  assign gpio_value_7 = io_gpio_read[7];
  assign gpio_value_8 = io_gpio_read[8];
  assign gpio_value_9 = io_gpio_read[9];
  assign gpio_value_10 = io_gpio_read[10];
  assign gpio_value_11 = io_gpio_read[11];
  assign gpio_value_12 = io_gpio_read[12];
  assign gpio_value_13 = io_gpio_read[13];
  assign gpio_value_14 = io_gpio_read[14];
  assign gpio_value_15 = io_gpio_read[15];
  assign gpio_value_16 = io_gpio_read[16];
  assign gpio_value_17 = io_gpio_read[17];
  assign gpio_value_18 = io_gpio_read[18];
  assign gpio_value_19 = io_gpio_read[19];
  assign gpio_value_20 = io_gpio_read[20];
  assign gpio_value_21 = io_gpio_read[21];
  assign gpio_value_22 = io_gpio_read[22];
  assign gpio_value_23 = io_gpio_read[23];
  assign gpio_value_24 = io_gpio_read[24];
  assign gpio_value_25 = io_gpio_read[25];
  assign gpio_value_26 = io_gpio_read[26];
  assign gpio_value_27 = io_gpio_read[27];
  assign gpio_value_28 = io_gpio_read[28];
  assign gpio_value_29 = io_gpio_read[29];
  assign gpio_value_30 = io_gpio_read[30];
  assign gpio_value_31 = io_gpio_read[31];
  assign io_gpio_write = _zz_1;
  assign io_gpio_writeEnable = io_gpio_writeEnable_driver;
  assign hi_int_int_aggr = 1'b0;
  assign lo_int_int_aggr = 1'b0;
  assign ri_int_int_aggr = 1'b0;
  assign fa_int_int_aggr = 1'b0;
  assign io_gpio_int_pe = (((hi_int_int_aggr || lo_int_int_aggr) || ri_int_int_aggr) || fa_int_int_aggr);
  always @ (posedge clk) begin
    busCtrl_rdata_regNext <= busCtrl_rdata;
    case(gpio_sib_addr)
      12'h0 : begin
        if(busCtrl_doWrite)begin
          _zz_1 <= gpio_sib_wdata[31 : 0];
        end
      end
      12'h004 : begin
        if(busCtrl_doWrite)begin
          io_gpio_writeEnable_driver <= gpio_sib_wdata[31 : 0];
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module clic (
  output              io_software_interrupt,
  output              io_timer_interrupt,
  input               clic_sib_sel,
  input               clic_sib_enable,
  input               clic_sib_write,
  input      [3:0]    clic_sib_mask,
  input      [11:0]   clic_sib_addr,
  input      [31:0]   clic_sib_wdata,
  output     [31:0]   clic_sib_rdata,
  output              clic_sib_ready,
  output reg          clic_sib_resp,
  input               clk,
  input               reset
);
  wire       [0:0]    _zz_3;
  wire       [31:0]   _zz_4;
  wire       [31:0]   _zz_5;
  wire       [31:0]   _zz_6;
  wire       [31:0]   _zz_7;
  wire       [31:0]   _zz_8;
  wire       [31:0]   _zz_9;
  wire       [31:0]   _zz_10;
  wire       [31:0]   _zz_11;
  wire                busCtrl_doWrite;
  wire                busCtrl_doRead;
  reg        [31:0]   busCtrl_rdata;
  reg        [31:0]   busCtrl_rdata_regNext;
  reg                 msip;
  reg        [63:0]   mtime;
  wire       [63:0]   _zz_1;
  reg        [63:0]   mtimecmp;
  wire       [63:0]   _zz_2;

  assign _zz_3 = clic_sib_wdata[0 : 0];
  assign _zz_4 = clic_sib_wdata[31 : 0];
  assign _zz_5 = _zz_4;
  assign _zz_6 = clic_sib_wdata[31 : 0];
  assign _zz_7 = _zz_6;
  assign _zz_8 = clic_sib_wdata[31 : 0];
  assign _zz_9 = _zz_8;
  assign _zz_10 = clic_sib_wdata[31 : 0];
  assign _zz_11 = _zz_10;
  assign busCtrl_doWrite = (((clic_sib_sel && clic_sib_enable) && clic_sib_ready) && clic_sib_write);
  assign busCtrl_doRead = (((clic_sib_sel && clic_sib_enable) && clic_sib_ready) && (! clic_sib_write));
  always @ (*) begin
    busCtrl_rdata = 32'h0;
    case(clic_sib_addr)
      12'h0 : begin
        busCtrl_rdata[0 : 0] = msip;
      end
      12'h004 : begin
        busCtrl_rdata[31 : 0] = _zz_1[31 : 0];
      end
      12'h008 : begin
        busCtrl_rdata[31 : 0] = _zz_1[63 : 32];
      end
      12'h00c : begin
        busCtrl_rdata[31 : 0] = _zz_2[31 : 0];
      end
      12'h010 : begin
        busCtrl_rdata[31 : 0] = _zz_2[63 : 32];
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    clic_sib_resp = 1'b0;
    case(clic_sib_addr)
      12'h0 : begin
        clic_sib_resp = 1'b1;
      end
      12'h004 : begin
        clic_sib_resp = 1'b1;
      end
      12'h008 : begin
        clic_sib_resp = 1'b1;
      end
      12'h00c : begin
        clic_sib_resp = 1'b1;
      end
      12'h010 : begin
        clic_sib_resp = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign clic_sib_ready = 1'b1;
  assign clic_sib_rdata = busCtrl_rdata_regNext;
  assign _zz_1 = mtime;
  assign _zz_2 = mtimecmp;
  assign io_software_interrupt = msip;
  assign io_timer_interrupt = ((mtimecmp <= mtime) && (mtimecmp != 64'h0));
  always @ (posedge clk) begin
    busCtrl_rdata_regNext <= busCtrl_rdata;
  end

  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      msip <= 1'b0;
      mtime <= 64'h0;
      mtimecmp <= 64'h0;
    end else begin
      mtime <= (mtime + 64'h0000000000000001);
      case(clic_sib_addr)
        12'h0 : begin
          if(busCtrl_doWrite)begin
            msip <= _zz_3[0];
          end
        end
        12'h004 : begin
          if(busCtrl_doWrite)begin
            mtime[31 : 0] <= _zz_5;
          end
        end
        12'h008 : begin
          if(busCtrl_doWrite)begin
            mtime[63 : 32] <= _zz_7;
          end
        end
        12'h00c : begin
          if(busCtrl_doWrite)begin
            mtimecmp[31 : 0] <= _zz_9;
          end
        end
        12'h010 : begin
          if(busCtrl_doWrite)begin
            mtimecmp[63 : 32] <= _zz_11;
          end
        end
        default : begin
        end
      endcase
    end
  end


endmodule

module dmem (
  input               dmem_sib_sel,
  input               dmem_sib_enable,
  input               dmem_sib_write,
  input      [3:0]    dmem_sib_mask,
  input      [15:0]   dmem_sib_addr,
  input      [31:0]   dmem_sib_wdata,
  output     [31:0]   dmem_sib_rdata,
  output              dmem_sib_ready,
  output              dmem_sib_resp,
  input               clk,
  input               reset
);
  reg        [31:0]   _zz_2;
  wire       [13:0]   word_addr;
  wire       [1:0]    byte_sel;
  wire                word_sel;
  wire                _zz_1;
  reg [7:0] ram_symbol0 [0:16383];
  reg [7:0] ram_symbol1 [0:16383];
  reg [7:0] ram_symbol2 [0:16383];
  reg [7:0] ram_symbol3 [0:16383];
  reg [7:0] _zz_3;
  reg [7:0] _zz_4;
  reg [7:0] _zz_5;
  reg [7:0] _zz_6;

  always @ (*) begin
    _zz_2 = {_zz_6, _zz_5, _zz_4, _zz_3};
  end
  always @ (posedge clk) begin
    if(dmem_sib_mask[0] && dmem_sib_write) begin
      ram_symbol0[word_addr] <= dmem_sib_wdata[7 : 0];
    end
    if(dmem_sib_mask[1] && dmem_sib_write) begin
      ram_symbol1[word_addr] <= dmem_sib_wdata[15 : 8];
    end
    if(dmem_sib_mask[2] && dmem_sib_write) begin
      ram_symbol2[word_addr] <= dmem_sib_wdata[23 : 16];
    end
    if(dmem_sib_mask[3] && dmem_sib_write) begin
      ram_symbol3[word_addr] <= dmem_sib_wdata[31 : 24];
    end
  end

  always @ (posedge clk) begin
    if(_zz_1) begin
      _zz_3 <= ram_symbol0[word_addr];
      _zz_4 <= ram_symbol1[word_addr];
      _zz_5 <= ram_symbol2[word_addr];
      _zz_6 <= ram_symbol3[word_addr];
    end
  end

  assign word_addr = dmem_sib_addr[15 : 2];
  assign byte_sel = dmem_sib_addr[1 : 0];
  assign word_sel = dmem_sib_addr[1];
  assign dmem_sib_ready = 1'b1;
  assign dmem_sib_resp = 1'b1;
  assign _zz_1 = ((! dmem_sib_write) && dmem_sib_sel);
  assign dmem_sib_rdata = _zz_2;

endmodule

module imem (
  input               imem_cpu_sib_sel,
  input               imem_cpu_sib_enable,
  input               imem_cpu_sib_write,
  input      [3:0]    imem_cpu_sib_mask,
  input      [15:0]   imem_cpu_sib_addr,
  input      [31:0]   imem_cpu_sib_wdata,
  output     [31:0]   imem_cpu_sib_rdata,
  output              imem_cpu_sib_ready,
  output              imem_cpu_sib_resp,
  input               imem_dbg_sib_sel,
  input               imem_dbg_sib_enable,
  input               imem_dbg_sib_write,
  input      [3:0]    imem_dbg_sib_mask,
  input      [15:0]   imem_dbg_sib_addr,
  input      [31:0]   imem_dbg_sib_wdata,
  output     [31:0]   imem_dbg_sib_rdata,
  output              imem_dbg_sib_ready,
  output              imem_dbg_sib_resp,
  input               clk,
  input               reset
);
  reg        [31:0]   _zz_1;
  reg        [31:0]   _zz_2;
  wire       [13:0]   cpu_word_addr;
  wire                cpu_read_en;
  wire                cpu_write_en;
  wire       [13:0]   dbg_word_addr;
  reg [31:0] ram [0:16383];

  always @ (posedge clk) begin
    if(cpu_write_en) begin
      ram[cpu_word_addr] <= imem_cpu_sib_wdata;
    end
  end

  always @ (posedge clk) begin
    if(cpu_read_en) begin
      _zz_1 <= ram[cpu_word_addr];
    end
  end

  always @ (posedge clk) begin
    if(imem_dbg_sib_write) begin
      ram[dbg_word_addr] <= imem_dbg_sib_wdata;
    end
  end

  always @ (posedge clk) begin
    if(imem_dbg_sib_sel) begin
      _zz_2 <= ram[dbg_word_addr];
    end
  end

  assign cpu_word_addr = imem_cpu_sib_addr[15 : 2];
  assign cpu_read_en = ((imem_cpu_sib_enable && imem_cpu_sib_sel) && (! imem_cpu_sib_write));
  assign cpu_write_en = ((imem_cpu_sib_enable && imem_cpu_sib_sel) && imem_cpu_sib_write);
  assign imem_cpu_sib_ready = 1'b1;
  assign imem_cpu_sib_resp = 1'b1;
  assign imem_cpu_sib_rdata = _zz_1;
  assign dbg_word_addr = imem_dbg_sib_addr[15 : 2];
  assign imem_dbg_sib_ready = 1'b1;
  assign imem_dbg_sib_resp = 1'b1;
  assign imem_dbg_sib_rdata = _zz_2;

endmodule

module apple_riscv (
  input               io_external_interrupt,
  input               io_timer_interrupt,
  input               io_software_interrupt,
  input               io_debug_interrupt,
  output              imem_sib_sel,
  output              imem_sib_enable,
  output              imem_sib_write,
  output     [3:0]    imem_sib_mask,
  output     [31:0]   imem_sib_addr,
  output     [31:0]   imem_sib_wdata,
  input      [31:0]   imem_sib_rdata,
  input               imem_sib_ready,
  input               imem_sib_resp,
  output              dmem_sib_sel,
  output              dmem_sib_enable,
  output              dmem_sib_write,
  output     [3:0]    dmem_sib_mask,
  output     [31:0]   dmem_sib_addr,
  output     [31:0]   dmem_sib_wdata,
  input      [31:0]   dmem_sib_rdata,
  input               dmem_sib_ready,
  input               dmem_sib_resp,
  input               clk,
  input               reset
);
  wire                _zz_1;
  wire                _zz_2;
  wire       [31:0]   _zz_3;
  wire       [31:0]   _zz_4;
  wire                _zz_5;
  wire       [31:0]   pc_inst_io_pc_out;
  wire       [31:0]   imem_ctrl_inst_io_mc2cpu_data;
  wire                imem_ctrl_inst_imem_sib_sel;
  wire                imem_ctrl_inst_imem_sib_enable;
  wire                imem_ctrl_inst_imem_sib_write;
  wire       [3:0]    imem_ctrl_inst_imem_sib_mask;
  wire       [31:0]   imem_ctrl_inst_imem_sib_wdata;
  wire       [31:0]   imem_ctrl_inst_imem_sib_addr;
  wire       [4:0]    instr_dec_inst_io_rd_idx;
  wire       [4:0]    instr_dec_inst_io_rs1_idx;
  wire       [4:0]    instr_dec_inst_io_rs2_idx;
  wire       [31:0]   instr_dec_inst_io_imm_value;
  wire       [20:0]   instr_dec_inst_io_jump_imm_value;
  wire                instr_dec_inst_io_rd_wr;
  wire                instr_dec_inst_io_rs1_rd;
  wire                instr_dec_inst_io_rs2_rd;
  wire                instr_dec_inst_io_data_ram_wr;
  wire                instr_dec_inst_io_data_ram_rd;
  wire                instr_dec_inst_io_data_ram_ld_byte;
  wire                instr_dec_inst_io_data_ram_ld_hword;
  wire                instr_dec_inst_io_data_ram_ld_unsign;
  wire                instr_dec_inst_io_alu_op_and;
  wire                instr_dec_inst_io_alu_op_or;
  wire                instr_dec_inst_io_alu_op_xor;
  wire                instr_dec_inst_io_alu_op_add;
  wire                instr_dec_inst_io_alu_op_sub;
  wire                instr_dec_inst_io_alu_op_sra;
  wire                instr_dec_inst_io_alu_op_srl;
  wire                instr_dec_inst_io_alu_op_sll;
  wire                instr_dec_inst_io_alu_op_slt;
  wire                instr_dec_inst_io_alu_op_sltu;
  wire                instr_dec_inst_io_alu_op_eqt;
  wire                instr_dec_inst_io_alu_op_invb0;
  wire       [1:0]    instr_dec_inst_io_alu_branch_op;
  wire                instr_dec_inst_io_csr_rd;
  wire                instr_dec_inst_io_csr_wr;
  wire                instr_dec_inst_io_csr_rw;
  wire                instr_dec_inst_io_csr_rs;
  wire                instr_dec_inst_io_csr_rc;
  wire                instr_dec_inst_io_csr_sel_imm;
  wire       [11:0]   instr_dec_inst_io_csr_idx;
  wire                instr_dec_inst_io_op2_sel_imm;
  wire                instr_dec_inst_io_op1_sel_pc;
  wire                instr_dec_inst_io_op1_sel_zero;
  wire                instr_dec_inst_io_branch_op;
  wire                instr_dec_inst_io_jal_op;
  wire                instr_dec_inst_io_jalr_op;
  wire                instr_dec_inst_io_mret;
  wire                instr_dec_inst_io_ecall;
  wire                instr_dec_inst_io_ebreak;
  wire                instr_dec_inst_io_invld_instr;
  wire       [31:0]   regfile_inst_io_rs1_data_out;
  wire       [31:0]   regfile_inst_io_rs2_data_out;
  wire       [31:0]   alu_inst_io_alu_out;
  wire       [31:0]   branch_unit_inst_io_target_pc;
  wire                branch_unit_inst_io_branch_taken;
  wire                branch_unit_inst_io_instr_addr_misalign_exception;
  wire       [31:0]   dmem_ctrl_isnt_io_mc2cpu_data;
  wire                dmem_ctrl_isnt_io_load_addr_misalign;
  wire                dmem_ctrl_isnt_io_store_addr_misalign;
  wire                dmem_ctrl_isnt_dmem_sib_sel;
  wire                dmem_ctrl_isnt_dmem_sib_enable;
  wire                dmem_ctrl_isnt_dmem_sib_write;
  wire       [3:0]    dmem_ctrl_isnt_dmem_sib_mask;
  wire       [31:0]   dmem_ctrl_isnt_dmem_sib_wdata;
  wire       [31:0]   dmem_ctrl_isnt_dmem_sib_addr;
  wire       [31:0]   mcsr_inst_io_mcsr_dout;
  wire       [31:0]   mcsr_inst_io_mtvec;
  wire                mcsr_inst_io_mie_meie;
  wire                mcsr_inst_io_mie_mtie;
  wire                mcsr_inst_io_mie_msie;
  wire                mcsr_inst_io_mstatus_mie;
  wire       [31:0]   mcsr_inst_io_mepc;
  wire                trap_ctrl_inst_io_mtrap_enter;
  wire                trap_ctrl_inst_io_mtrap_exit;
  wire       [31:0]   trap_ctrl_inst_io_mtrap_mepc;
  wire       [31:0]   trap_ctrl_inst_io_mtrap_mcause;
  wire       [31:0]   trap_ctrl_inst_io_mtrap_mtval;
  wire                trap_ctrl_inst_io_pc_trap;
  wire       [31:0]   trap_ctrl_inst_io_pc_value;
  wire                trap_ctrl_inst_io_int_flush;
  wire                fu_inst_io_forward_rs1_from_mem;
  wire                fu_inst_io_forward_rs1_from_wb;
  wire                fu_inst_io_forward_rs2_from_mem;
  wire                fu_inst_io_forward_rs2_from_wb;
  wire                hdu_inst_io_if_valid;
  wire                hdu_inst_io_id_valid;
  wire                hdu_inst_io_ex_valid;
  wire                hdu_inst_io_mem_valid;
  wire                hdu_inst_io_wb_valid;
  wire                hdu_inst_io_if_pipe_stall;
  wire                hdu_inst_io_id_pipe_stall;
  wire                hdu_inst_io_ex_pipe_stall;
  wire                hdu_inst_io_mem_pipe_stall;
  wire                hdu_inst_io_wb_pipe_stall;
  wire       [4:0]    _zz_6;
  wire       [31:0]   _zz_7;
  wire       [0:0]    _zz_8;
  wire                if_instr_valid;
  wire                id_instr_valid;
  wire                ex_instr_valid;
  wire                mem_instr_valid;
  wire                wb_instr_valid;
  wire                if_pipe_stall;
  wire                id_pipe_stall;
  wire                ex_pipe_stall;
  wire                mem_pipe_stall;
  wire                wb_pipe_stall;
  wire                if_pipe_run;
  wire                id_pipe_run;
  wire                ex_pipe_run;
  wire                mem_pipe_run;
  wire                wb_pipe_run;
  wire       [31:0]   target_pc;
  wire                branch_taken;
  reg        [31:0]   if2id_pc;
  reg                 if2id_instr_valid;
  reg                 id2ex_instr_valid;
  reg                 id2ex_rd_wr;
  reg                 id2ex_data_ram_wr;
  reg                 id2ex_data_ram_rd;
  reg                 id2ex_rs1_rd;
  reg                 id2ex_rs2_rd;
  reg                 id2ex_branch_op;
  reg                 id2ex_jal_op;
  reg                 id2ex_jalr_op;
  reg                 id2ex_mret;
  reg                 id2ex_ecall;
  reg                 id2ex_ebreak;
  reg                 id2ex_csr_wr;
  reg                 id2ex_csr_rd;
  reg                 id2ex_csr_rw;
  reg                 id2ex_csr_rs;
  reg                 id2ex_csr_rc;
  reg                 id2ex_csr_sel_imm;
  reg        [11:0]   id2ex_csr_idx;
  reg        [4:0]    id2ex_rd_idx;
  reg        [4:0]    id2ex_rs1_idx;
  reg        [4:0]    id2ex_rs2_idx;
  reg                 id2ex_alu_op_and;
  reg                 id2ex_alu_op_or;
  reg                 id2ex_alu_op_xor;
  reg                 id2ex_alu_op_add;
  reg                 id2ex_alu_op_sub;
  reg                 id2ex_alu_op_sra;
  reg                 id2ex_alu_op_srl;
  reg                 id2ex_alu_op_sll;
  reg                 id2ex_alu_op_slt;
  reg                 id2ex_alu_op_sltu;
  reg                 id2ex_alu_op_eqt;
  reg                 id2ex_alu_op_invb0;
  reg                 id2ex_data_ram_ld_byte;
  reg                 id2ex_data_ram_ld_hword;
  reg                 id2ex_data_ram_ld_unsign;
  reg        [31:0]   id2ex_rs1_value;
  reg        [31:0]   id2ex_rs2_value;
  reg        [31:0]   id2ex_imm_value;
  reg        [20:0]   id2ex_brjp_imm_value;
  reg        [31:0]   id2ex_pc;
  reg                 id2ex_op2_sel_imm;
  reg                 id2ex_op1_sel_pc;
  reg                 id2ex_op1_sel_zero;
  reg        [31:0]   id2ex_instr;
  reg                 id2ex_illegal_instr_exception;
  wire       [31:0]   ex_rs1_value_forwarded;
  wire       [31:0]   ex_rs2_value_forwarded;
  wire       [31:0]   alu_operand1_muxout;
  wire       [31:0]   alu_operand2_muxout;
  wire                ex_exception;
  reg                 ex2mem_instr_valid;
  reg                 ex2mem_rd_wr;
  reg                 ex2mem_data_ram_wr;
  reg                 ex2mem_data_ram_rd;
  reg                 ex2mem_mret;
  reg                 ex2mem_ecall;
  reg                 ex2mem_ebreak;
  reg                 ex2mem_csr_wr;
  reg                 ex2mem_csr_rd;
  reg                 ex2mem_csr_rw;
  reg                 ex2mem_csr_rs;
  reg                 ex2mem_csr_rc;
  reg                 ex2mem_csr_sel_imm;
  reg        [11:0]   ex2mem_csr_idx;
  reg        [31:0]   ex2mem_rs1_value;
  reg        [31:0]   ex2mem_alu_out;
  reg        [4:0]    ex2mem_rs1_idx;
  reg        [4:0]    ex2mem_rs2_idx;
  reg        [4:0]    ex2mem_rd_idx;
  reg        [31:0]   ex2mem_rs2_value;
  reg        [31:0]   ex2mem_pc;
  reg        [31:0]   ex2mem_instr;
  reg                 ex2mem_data_ram_ld_byte;
  reg                 ex2mem_data_ram_ld_hword;
  reg                 ex2mem_data_ram_ld_unsign;
  reg                 ex2mem_illegal_instr_exception;
  reg                 ex2mem_instr_addr_misalign_exception;
  wire       [31:0]   dmem_addr;
  wire                mem_exception;
  reg                 mem2wb_instr_valid;
  reg                 mem2wb_rd_wr;
  reg                 mem2wb_data_ram_rd;
  reg                 mem2wb_mret;
  reg                 mem2wb_ecall;
  reg                 mem2wb_ebreak;
  reg                 mem2wb_csr_wr;
  reg                 mem2wb_csr_rd;
  reg                 mem2wb_csr_rw;
  reg                 mem2wb_csr_rs;
  reg                 mem2wb_csr_rc;
  reg                 mem2wb_csr_sel_imm;
  reg        [11:0]   mem2wb_csr_idx;
  reg        [4:0]    mem2wb_rs1_idx;
  reg        [31:0]   mem2wb_rs1_value;
  reg        [31:0]   mem2wb_alu_out;
  reg        [4:0]    mem2wb_rd_idx;
  reg        [31:0]   mem2wb_pc;
  reg        [31:0]   mem2wb_instr;
  reg        [31:0]   mem2wb_dmem_addr;
  reg                 mem2wb_illegal_instr_exception;
  reg                 mem2wb_instr_addr_misalign_exception;
  reg                 mem2wb_load_addr_misalign;
  reg                 mem2wb_store_addr_misalign;
  wire       [31:0]   mcsr_data;
  wire       [31:0]   mcsr_masked_set;
  wire       [31:0]   mcsr_masked_clear;
  wire                from_csr;
  wire       [31:0]   wb_rd_wr_data;
  wire                wb_exception;

  assign _zz_6 = mem2wb_rs1_idx;
  assign _zz_7 = {27'd0, _zz_6};
  assign _zz_8 = 1'b0;
  program_counter pc_inst (
    .io_branch_pc_in    (target_pc[31:0]                   ), //i
    .io_trap_pc_in      (trap_ctrl_inst_io_pc_value[31:0]  ), //i
    .io_branch          (branch_taken                      ), //i
    .io_trap            (trap_ctrl_inst_io_pc_trap         ), //i
    .io_stall           (if_pipe_stall                     ), //i
    .io_pc_out          (pc_inst_io_pc_out[31:0]           ), //o
    .clk                (clk                               ), //i
    .reset              (reset                             )  //i
  );
  imem_ctrl imem_ctrl_inst (
    .io_cpu2mc_addr     (pc_inst_io_pc_out[31:0]              ), //i
    .io_cpu2mc_en       (if_pipe_run                          ), //i
    .io_mc2cpu_data     (imem_ctrl_inst_io_mc2cpu_data[31:0]  ), //o
    .imem_sib_sel       (imem_ctrl_inst_imem_sib_sel          ), //o
    .imem_sib_enable    (imem_ctrl_inst_imem_sib_enable       ), //o
    .imem_sib_write     (imem_ctrl_inst_imem_sib_write        ), //o
    .imem_sib_mask      (imem_ctrl_inst_imem_sib_mask[3:0]    ), //o
    .imem_sib_addr      (imem_ctrl_inst_imem_sib_addr[31:0]   ), //o
    .imem_sib_wdata     (imem_ctrl_inst_imem_sib_wdata[31:0]  ), //o
    .imem_sib_rdata     (imem_sib_rdata[31:0]                 ), //i
    .imem_sib_ready     (imem_sib_ready                       ), //i
    .imem_sib_resp      (imem_sib_resp                        )  //i
  );
  instr_dec instr_dec_inst (
    .io_instr                 (imem_ctrl_inst_io_mc2cpu_data[31:0]     ), //i
    .io_instr_vld             (if2id_instr_valid                       ), //i
    .io_rd_idx                (instr_dec_inst_io_rd_idx[4:0]           ), //o
    .io_rs1_idx               (instr_dec_inst_io_rs1_idx[4:0]          ), //o
    .io_rs2_idx               (instr_dec_inst_io_rs2_idx[4:0]          ), //o
    .io_imm_value             (instr_dec_inst_io_imm_value[31:0]       ), //o
    .io_jump_imm_value        (instr_dec_inst_io_jump_imm_value[20:0]  ), //o
    .io_rd_wr                 (instr_dec_inst_io_rd_wr                 ), //o
    .io_rs1_rd                (instr_dec_inst_io_rs1_rd                ), //o
    .io_rs2_rd                (instr_dec_inst_io_rs2_rd                ), //o
    .io_data_ram_wr           (instr_dec_inst_io_data_ram_wr           ), //o
    .io_data_ram_rd           (instr_dec_inst_io_data_ram_rd           ), //o
    .io_data_ram_ld_byte      (instr_dec_inst_io_data_ram_ld_byte      ), //o
    .io_data_ram_ld_hword     (instr_dec_inst_io_data_ram_ld_hword     ), //o
    .io_data_ram_ld_unsign    (instr_dec_inst_io_data_ram_ld_unsign    ), //o
    .io_alu_op_and            (instr_dec_inst_io_alu_op_and            ), //o
    .io_alu_op_or             (instr_dec_inst_io_alu_op_or             ), //o
    .io_alu_op_xor            (instr_dec_inst_io_alu_op_xor            ), //o
    .io_alu_op_add            (instr_dec_inst_io_alu_op_add            ), //o
    .io_alu_op_sub            (instr_dec_inst_io_alu_op_sub            ), //o
    .io_alu_op_sra            (instr_dec_inst_io_alu_op_sra            ), //o
    .io_alu_op_srl            (instr_dec_inst_io_alu_op_srl            ), //o
    .io_alu_op_sll            (instr_dec_inst_io_alu_op_sll            ), //o
    .io_alu_op_slt            (instr_dec_inst_io_alu_op_slt            ), //o
    .io_alu_op_sltu           (instr_dec_inst_io_alu_op_sltu           ), //o
    .io_alu_op_eqt            (instr_dec_inst_io_alu_op_eqt            ), //o
    .io_alu_op_invb0          (instr_dec_inst_io_alu_op_invb0          ), //o
    .io_alu_branch_op         (instr_dec_inst_io_alu_branch_op[1:0]    ), //o
    .io_csr_rd                (instr_dec_inst_io_csr_rd                ), //o
    .io_csr_wr                (instr_dec_inst_io_csr_wr                ), //o
    .io_csr_rw                (instr_dec_inst_io_csr_rw                ), //o
    .io_csr_rs                (instr_dec_inst_io_csr_rs                ), //o
    .io_csr_rc                (instr_dec_inst_io_csr_rc                ), //o
    .io_csr_sel_imm           (instr_dec_inst_io_csr_sel_imm           ), //o
    .io_csr_idx               (instr_dec_inst_io_csr_idx[11:0]         ), //o
    .io_op2_sel_imm           (instr_dec_inst_io_op2_sel_imm           ), //o
    .io_op1_sel_pc            (instr_dec_inst_io_op1_sel_pc            ), //o
    .io_op1_sel_zero          (instr_dec_inst_io_op1_sel_zero          ), //o
    .io_branch_op             (instr_dec_inst_io_branch_op             ), //o
    .io_jal_op                (instr_dec_inst_io_jal_op                ), //o
    .io_jalr_op               (instr_dec_inst_io_jalr_op               ), //o
    .io_mret                  (instr_dec_inst_io_mret                  ), //o
    .io_ecall                 (instr_dec_inst_io_ecall                 ), //o
    .io_ebreak                (instr_dec_inst_io_ebreak                ), //o
    .io_invld_instr           (instr_dec_inst_io_invld_instr           )  //o
  );
  regfile regfile_inst (
    .io_rs1_rd_addr         (instr_dec_inst_io_rs1_idx[4:0]      ), //i
    .io_rs1_data_out        (regfile_inst_io_rs1_data_out[31:0]  ), //o
    .io_rs2_rd_addr         (instr_dec_inst_io_rs2_idx[4:0]      ), //i
    .io_rs2_data_out        (regfile_inst_io_rs2_data_out[31:0]  ), //o
    .io_register_wr         (_zz_1                               ), //i
    .io_register_wr_addr    (mem2wb_rd_idx[4:0]                  ), //i
    .io_rd_in               (wb_rd_wr_data[31:0]                 ), //i
    .clk                    (clk                                 ), //i
    .reset                  (reset                               )  //i
  );
  alu alu_inst (
    .io_operand_1       (alu_operand1_muxout[31:0]  ), //i
    .io_operand_2       (alu_operand2_muxout[31:0]  ), //i
    .io_alu_out         (alu_inst_io_alu_out[31:0]  ), //o
    .io_alu_op_and      (id2ex_alu_op_and           ), //i
    .io_alu_op_or       (id2ex_alu_op_or            ), //i
    .io_alu_op_xor      (id2ex_alu_op_xor           ), //i
    .io_alu_op_add      (id2ex_alu_op_add           ), //i
    .io_alu_op_sub      (id2ex_alu_op_sub           ), //i
    .io_alu_op_sra      (id2ex_alu_op_sra           ), //i
    .io_alu_op_srl      (id2ex_alu_op_srl           ), //i
    .io_alu_op_sll      (id2ex_alu_op_sll           ), //i
    .io_alu_op_slt      (id2ex_alu_op_slt           ), //i
    .io_alu_op_sltu     (id2ex_alu_op_sltu          ), //i
    .io_alu_op_eqt      (id2ex_alu_op_eqt           ), //i
    .io_alu_op_invb0    (id2ex_alu_op_invb0         )  //i
  );
  branch_unit branch_unit_inst (
    .io_branch_result                    (_zz_2                                              ), //i
    .io_current_pc                       (id2ex_pc[31:0]                                     ), //i
    .io_imm_value                        (id2ex_brjp_imm_value[20:0]                         ), //i
    .io_rs1_value                        (ex_rs1_value_forwarded[31:0]                       ), //i
    .io_br_op                            (id2ex_branch_op                                    ), //i
    .io_jal_op                           (id2ex_jal_op                                       ), //i
    .io_jalr_op                          (id2ex_jalr_op                                      ), //i
    .io_target_pc                        (branch_unit_inst_io_target_pc[31:0]                ), //o
    .io_branch_taken                     (branch_unit_inst_io_branch_taken                   ), //o
    .io_instr_addr_misalign_exception    (branch_unit_inst_io_instr_addr_misalign_exception  )  //o
  );
  dmem_ctrl dmem_ctrl_isnt (
    .io_cpu2mc_wr                 (ex2mem_data_ram_wr                     ), //i
    .io_cpu2mc_rd                 (ex2mem_data_ram_rd                     ), //i
    .io_cpu2mc_addr               (dmem_addr[31:0]                        ), //i
    .io_cpu2mc_data               (ex2mem_rs2_value[31:0]                 ), //i
    .io_mc2cpu_data               (dmem_ctrl_isnt_io_mc2cpu_data[31:0]    ), //o
    .io_cpu2mc_mem_LS_byte        (ex2mem_data_ram_ld_byte                ), //i
    .io_cpu2mc_mem_LS_halfword    (ex2mem_data_ram_ld_hword               ), //i
    .io_cpu2mc_mem_LW_unsigned    (ex2mem_data_ram_ld_unsign              ), //i
    .io_load_addr_misalign        (dmem_ctrl_isnt_io_load_addr_misalign   ), //o
    .io_store_addr_misalign       (dmem_ctrl_isnt_io_store_addr_misalign  ), //o
    .dmem_sib_sel                 (dmem_ctrl_isnt_dmem_sib_sel            ), //o
    .dmem_sib_enable              (dmem_ctrl_isnt_dmem_sib_enable         ), //o
    .dmem_sib_write               (dmem_ctrl_isnt_dmem_sib_write          ), //o
    .dmem_sib_mask                (dmem_ctrl_isnt_dmem_sib_mask[3:0]      ), //o
    .dmem_sib_addr                (dmem_ctrl_isnt_dmem_sib_addr[31:0]     ), //o
    .dmem_sib_wdata               (dmem_ctrl_isnt_dmem_sib_wdata[31:0]    ), //o
    .dmem_sib_rdata               (dmem_sib_rdata[31:0]                   ), //i
    .dmem_sib_ready               (dmem_sib_ready                         ), //i
    .dmem_sib_resp                (dmem_sib_resp                          ), //i
    .clk                          (clk                                    ), //i
    .reset                        (reset                                  )  //i
  );
  mcsr mcsr_inst (
    .io_mcsr_addr             (mem2wb_csr_idx[11:0]                  ), //i
    .io_mcsr_din              (_zz_3[31:0]                           ), //i
    .io_mcsr_wen              (mem2wb_csr_wr                         ), //i
    .io_mcsr_dout             (mcsr_inst_io_mcsr_dout[31:0]          ), //o
    .io_mtrap_enter           (trap_ctrl_inst_io_mtrap_enter         ), //i
    .io_mtrap_exit            (trap_ctrl_inst_io_mtrap_exit          ), //i
    .io_mtrap_mepc            (trap_ctrl_inst_io_mtrap_mepc[31:0]    ), //i
    .io_mtrap_mcause          (trap_ctrl_inst_io_mtrap_mcause[31:0]  ), //i
    .io_mtrap_mtval           (trap_ctrl_inst_io_mtrap_mtval[31:0]   ), //i
    .io_external_interrupt    (io_external_interrupt                 ), //i
    .io_timer_interrupt       (io_timer_interrupt                    ), //i
    .io_software_interrupt    (io_software_interrupt                 ), //i
    .io_mtvec                 (mcsr_inst_io_mtvec[31:0]              ), //o
    .io_mie_meie              (mcsr_inst_io_mie_meie                 ), //o
    .io_mie_mtie              (mcsr_inst_io_mie_mtie                 ), //o
    .io_mie_msie              (mcsr_inst_io_mie_msie                 ), //o
    .io_mstatus_mie           (mcsr_inst_io_mstatus_mie              ), //o
    .io_mepc                  (mcsr_inst_io_mepc[31:0]               ), //o
    .io_hartId                (_zz_4[31:0]                           ), //i
    .clk                      (clk                                   ), //i
    .reset                    (reset                                 )  //i
  );
  trap_ctrl trap_ctrl_inst (
    .io_load_addr_misalign               (mem2wb_load_addr_misalign             ), //i
    .io_store_addr_misalign              (mem2wb_store_addr_misalign            ), //i
    .io_illegal_instr_exception          (mem2wb_illegal_instr_exception        ), //i
    .io_instr_addr_misalign_exception    (mem2wb_instr_addr_misalign_exception  ), //i
    .io_external_interrupt               (io_external_interrupt                 ), //i
    .io_timer_interrupt                  (io_timer_interrupt                    ), //i
    .io_software_interrupt               (io_software_interrupt                 ), //i
    .io_debug_interrupt                  (io_debug_interrupt                    ), //i
    .io_mret                             (mem2wb_mret                           ), //i
    .io_ecall                            (mem2wb_ecall                          ), //i
    .io_wb_pc                            (mem2wb_pc[31:0]                       ), //i
    .io_wb_instr                         (mem2wb_instr[31:0]                    ), //i
    .io_wb_dmem_addr                     (mem2wb_dmem_addr[31:0]                ), //i
    .io_mie_meie                         (mcsr_inst_io_mie_meie                 ), //i
    .io_mie_mtie                         (mcsr_inst_io_mie_mtie                 ), //i
    .io_mie_msie                         (mcsr_inst_io_mie_msie                 ), //i
    .io_mstatus_mie                      (mcsr_inst_io_mstatus_mie              ), //i
    .io_mepc                             (mcsr_inst_io_mepc[31:0]               ), //i
    .io_mtvec                            (mcsr_inst_io_mtvec[31:0]              ), //i
    .io_mtrap_enter                      (trap_ctrl_inst_io_mtrap_enter         ), //o
    .io_mtrap_exit                       (trap_ctrl_inst_io_mtrap_exit          ), //o
    .io_mtrap_mepc                       (trap_ctrl_inst_io_mtrap_mepc[31:0]    ), //o
    .io_mtrap_mcause                     (trap_ctrl_inst_io_mtrap_mcause[31:0]  ), //o
    .io_mtrap_mtval                      (trap_ctrl_inst_io_mtrap_mtval[31:0]   ), //o
    .io_pc_trap                          (trap_ctrl_inst_io_pc_trap             ), //o
    .io_pc_value                         (trap_ctrl_inst_io_pc_value[31:0]      ), //o
    .io_int_flush                        (trap_ctrl_inst_io_int_flush           )  //o
  );
  fu fu_inst (
    .io_ex_rs1_idx              (id2ex_rs1_idx[4:0]               ), //i
    .io_ex_rs2_idx              (id2ex_rs2_idx[4:0]               ), //i
    .io_mem_rd_idx              (ex2mem_rd_idx[4:0]               ), //i
    .io_wb_rd_idx               (mem2wb_rd_idx[4:0]               ), //i
    .io_ex_rs1_rd               (id2ex_rs1_rd                     ), //i
    .io_ex_rs2_rd               (id2ex_rs2_rd                     ), //i
    .io_mem_rd_wr               (ex2mem_rd_wr                     ), //i
    .io_wb_rd_wr                (_zz_5                            ), //i
    .io_forward_rs1_from_mem    (fu_inst_io_forward_rs1_from_mem  ), //o
    .io_forward_rs1_from_wb     (fu_inst_io_forward_rs1_from_wb   ), //o
    .io_forward_rs2_from_mem    (fu_inst_io_forward_rs2_from_mem  ), //o
    .io_forward_rs2_from_wb     (fu_inst_io_forward_rs2_from_wb   )  //o
  );
  hdu hdu_inst (
    .io_if_valid          (hdu_inst_io_if_valid            ), //o
    .io_id_valid          (hdu_inst_io_id_valid            ), //o
    .io_ex_valid          (hdu_inst_io_ex_valid            ), //o
    .io_mem_valid         (hdu_inst_io_mem_valid           ), //o
    .io_wb_valid          (hdu_inst_io_wb_valid            ), //o
    .io_if_pipe_stall     (hdu_inst_io_if_pipe_stall       ), //o
    .io_id_pipe_stall     (hdu_inst_io_id_pipe_stall       ), //o
    .io_ex_pipe_stall     (hdu_inst_io_ex_pipe_stall       ), //o
    .io_mem_pipe_stall    (hdu_inst_io_mem_pipe_stall      ), //o
    .io_wb_pipe_stall     (hdu_inst_io_wb_pipe_stall       ), //o
    .io_branch_taken      (branch_taken                    ), //i
    .io_id_rs1_rd         (instr_dec_inst_io_rs1_rd        ), //i
    .io_id_rs2_rd         (instr_dec_inst_io_rs2_rd        ), //i
    .io_ex_dmem_rd        (id2ex_data_ram_rd               ), //i
    .io_id_rs1_idx        (instr_dec_inst_io_rs1_idx[4:0]  ), //i
    .io_id_rs2_idx        (instr_dec_inst_io_rs2_idx[4:0]  ), //i
    .io_ex_rd_idx         (id2ex_rd_idx[4:0]               ), //i
    .io_mem_rd_idx        (ex2mem_rd_idx[4:0]              ), //i
    .io_ex_csr_rd         (id2ex_csr_rd                    ), //i
    .io_mem_csr_rd        (ex2mem_csr_rd                   ), //i
    .io_id_exception      (instr_dec_inst_io_invld_instr   ), //i
    .io_ex_exception      (ex_exception                    ), //i
    .io_mem_exception     (mem_exception                   ), //i
    .io_wb_exception      (wb_exception                    ), //i
    .io_ex_mret           (id2ex_mret                      ), //i
    .io_mem_mret          (ex2mem_mret                     ), //i
    .io_wb_mret           (mem2wb_mret                     ), //i
    .io_ex_ecall          (id2ex_mret                      ), //i
    .io_mem_ecall         (ex2mem_mret                     ), //i
    .io_wb_ecall          (mem2wb_mret                     ), //i
    .io_ex_ebreak         (id2ex_mret                      ), //i
    .io_mem_ebreak        (ex2mem_mret                     ), //i
    .io_wb_ebreak         (mem2wb_mret                     ), //i
    .io_int_flush         (trap_ctrl_inst_io_int_flush     )  //i
  );
  assign if_pipe_run = (! if_pipe_stall);
  assign id_pipe_run = (! id_pipe_stall);
  assign ex_pipe_run = (! ex_pipe_stall);
  assign mem_pipe_run = (! mem_pipe_stall);
  assign wb_pipe_run = (! wb_pipe_stall);
  assign imem_sib_sel = imem_ctrl_inst_imem_sib_sel;
  assign imem_sib_enable = imem_ctrl_inst_imem_sib_enable;
  assign imem_sib_write = imem_ctrl_inst_imem_sib_write;
  assign imem_sib_mask = imem_ctrl_inst_imem_sib_mask;
  assign imem_sib_addr = imem_ctrl_inst_imem_sib_addr;
  assign imem_sib_wdata = imem_ctrl_inst_imem_sib_wdata;
  assign alu_operand1_muxout = (id2ex_op1_sel_zero ? 32'h0 : (id2ex_op1_sel_pc ? id2ex_pc : ex_rs1_value_forwarded));
  assign alu_operand2_muxout = (id2ex_op2_sel_imm ? id2ex_imm_value : ex_rs2_value_forwarded);
  assign _zz_2 = alu_inst_io_alu_out[0];
  assign target_pc = branch_unit_inst_io_target_pc;
  assign branch_taken = branch_unit_inst_io_branch_taken;
  assign ex_exception = (id2ex_illegal_instr_exception || branch_unit_inst_io_instr_addr_misalign_exception);
  assign dmem_addr = ex2mem_alu_out;
  assign dmem_sib_sel = dmem_ctrl_isnt_dmem_sib_sel;
  assign dmem_sib_enable = dmem_ctrl_isnt_dmem_sib_enable;
  assign dmem_sib_write = dmem_ctrl_isnt_dmem_sib_write;
  assign dmem_sib_mask = dmem_ctrl_isnt_dmem_sib_mask;
  assign dmem_sib_addr = dmem_ctrl_isnt_dmem_sib_addr;
  assign dmem_sib_wdata = dmem_ctrl_isnt_dmem_sib_wdata;
  assign mem_exception = (((ex2mem_illegal_instr_exception || ex2mem_instr_addr_misalign_exception) || dmem_ctrl_isnt_io_load_addr_misalign) || dmem_ctrl_isnt_io_store_addr_misalign);
  assign mcsr_data = (mem2wb_csr_sel_imm ? _zz_7 : mem2wb_rs1_value);
  assign mcsr_masked_set = (mcsr_inst_io_mcsr_dout | mcsr_data);
  assign mcsr_masked_clear = (mcsr_inst_io_mcsr_dout & (~ mcsr_data));
  assign _zz_3 = (mem2wb_csr_rw ? mcsr_data : (mem2wb_csr_rs ? mcsr_masked_set : mcsr_masked_clear));
  assign _zz_4 = {31'd0, _zz_8};
  assign _zz_1 = (mem2wb_rd_wr && wb_instr_valid);
  assign from_csr = ((mem2wb_csr_rw || mem2wb_csr_rs) || mem2wb_csr_rc);
  assign wb_rd_wr_data = (mem2wb_data_ram_rd ? dmem_ctrl_isnt_io_mc2cpu_data : (from_csr ? mcsr_inst_io_mcsr_dout : mem2wb_alu_out));
  assign wb_exception = (((mem2wb_illegal_instr_exception || mem2wb_instr_addr_misalign_exception) || mem2wb_load_addr_misalign) || mem2wb_store_addr_misalign);
  assign _zz_5 = (mem2wb_rd_wr && wb_instr_valid);
  assign ex_rs1_value_forwarded = (fu_inst_io_forward_rs1_from_mem ? ex2mem_alu_out : (fu_inst_io_forward_rs1_from_wb ? wb_rd_wr_data : id2ex_rs1_value));
  assign ex_rs2_value_forwarded = (fu_inst_io_forward_rs2_from_mem ? ex2mem_alu_out : (fu_inst_io_forward_rs2_from_wb ? wb_rd_wr_data : id2ex_rs2_value));
  assign if_instr_valid = (hdu_inst_io_if_valid && (! branch_unit_inst_io_instr_addr_misalign_exception));
  assign id_instr_valid = ((if2id_instr_valid && hdu_inst_io_id_valid) && (! instr_dec_inst_io_invld_instr));
  assign ex_instr_valid = (id2ex_instr_valid && hdu_inst_io_ex_valid);
  assign mem_instr_valid = (ex2mem_instr_valid && hdu_inst_io_mem_valid);
  assign wb_instr_valid = (mem2wb_instr_valid && hdu_inst_io_wb_valid);
  assign if_pipe_stall = hdu_inst_io_if_pipe_stall;
  assign id_pipe_stall = hdu_inst_io_id_pipe_stall;
  assign ex_pipe_stall = hdu_inst_io_ex_pipe_stall;
  assign mem_pipe_stall = hdu_inst_io_mem_pipe_stall;
  assign wb_pipe_stall = hdu_inst_io_wb_pipe_stall;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      if2id_pc <= 32'h0;
      if2id_instr_valid <= 1'b0;
      id2ex_instr_valid <= 1'b0;
      id2ex_rd_wr <= 1'b0;
      id2ex_data_ram_wr <= 1'b0;
      id2ex_data_ram_rd <= 1'b0;
      id2ex_rs1_rd <= 1'b0;
      id2ex_rs2_rd <= 1'b0;
      id2ex_branch_op <= 1'b0;
      id2ex_jal_op <= 1'b0;
      id2ex_jalr_op <= 1'b0;
      id2ex_mret <= 1'b0;
      id2ex_ecall <= 1'b0;
      id2ex_ebreak <= 1'b0;
      id2ex_csr_wr <= 1'b0;
      id2ex_csr_rd <= 1'b0;
      id2ex_illegal_instr_exception <= 1'b0;
      ex2mem_instr_valid <= 1'b0;
      ex2mem_rd_wr <= 1'b0;
      ex2mem_data_ram_wr <= 1'b0;
      ex2mem_data_ram_rd <= 1'b0;
      ex2mem_mret <= 1'b0;
      ex2mem_ecall <= 1'b0;
      ex2mem_ebreak <= 1'b0;
      ex2mem_csr_wr <= 1'b0;
      ex2mem_csr_rd <= 1'b0;
      ex2mem_illegal_instr_exception <= 1'b0;
      ex2mem_instr_addr_misalign_exception <= 1'b0;
      mem2wb_instr_valid <= 1'b0;
      mem2wb_rd_wr <= 1'b0;
      mem2wb_data_ram_rd <= 1'b0;
      mem2wb_mret <= 1'b0;
      mem2wb_ecall <= 1'b0;
      mem2wb_ebreak <= 1'b0;
      mem2wb_csr_wr <= 1'b0;
      mem2wb_csr_rd <= 1'b0;
      mem2wb_illegal_instr_exception <= 1'b0;
      mem2wb_instr_addr_misalign_exception <= 1'b0;
      mem2wb_load_addr_misalign <= 1'b0;
      mem2wb_store_addr_misalign <= 1'b0;
    end else begin
      if(id_pipe_run)begin
        if2id_pc <= pc_inst_io_pc_out;
      end
      if(id_pipe_run)begin
        if2id_instr_valid <= if_instr_valid;
      end
      if(ex_pipe_run)begin
        id2ex_instr_valid <= id_instr_valid;
      end
      if(ex_pipe_run)begin
        id2ex_rd_wr <= (instr_dec_inst_io_rd_wr && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_data_ram_wr <= (instr_dec_inst_io_data_ram_wr && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_data_ram_rd <= (instr_dec_inst_io_data_ram_rd && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_rs1_rd <= (instr_dec_inst_io_rs1_rd && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_rs2_rd <= (instr_dec_inst_io_rs2_rd && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_branch_op <= (instr_dec_inst_io_branch_op && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_jal_op <= (instr_dec_inst_io_jal_op && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_jalr_op <= (instr_dec_inst_io_jalr_op && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_mret <= (instr_dec_inst_io_mret && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_ecall <= (instr_dec_inst_io_ecall && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_ebreak <= (instr_dec_inst_io_ebreak && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_csr_wr <= (instr_dec_inst_io_csr_wr && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_csr_rd <= (instr_dec_inst_io_csr_rd && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_illegal_instr_exception <= (instr_dec_inst_io_invld_instr && id_instr_valid);
      end
      if(mem_pipe_run)begin
        ex2mem_instr_valid <= ex_instr_valid;
      end
      if(mem_pipe_run)begin
        ex2mem_rd_wr <= (id2ex_rd_wr && ex_instr_valid);
      end
      if(mem_pipe_run)begin
        ex2mem_data_ram_wr <= (id2ex_data_ram_wr && ex_instr_valid);
      end
      if(mem_pipe_run)begin
        ex2mem_data_ram_rd <= (id2ex_data_ram_rd && ex_instr_valid);
      end
      if(mem_pipe_run)begin
        ex2mem_mret <= (id2ex_mret && ex_instr_valid);
      end
      if(mem_pipe_run)begin
        ex2mem_ecall <= (id2ex_ecall && ex_instr_valid);
      end
      if(mem_pipe_run)begin
        ex2mem_ebreak <= (id2ex_ebreak && ex_instr_valid);
      end
      if(mem_pipe_run)begin
        ex2mem_csr_wr <= (id2ex_csr_wr && ex_instr_valid);
      end
      if(mem_pipe_run)begin
        ex2mem_csr_rd <= (id2ex_csr_rd && ex_instr_valid);
      end
      if(mem_pipe_run)begin
        ex2mem_illegal_instr_exception <= (id2ex_illegal_instr_exception && ex_instr_valid);
      end
      if(mem_pipe_run)begin
        ex2mem_instr_addr_misalign_exception <= (branch_unit_inst_io_instr_addr_misalign_exception && ex_instr_valid);
      end
      if(wb_pipe_run)begin
        mem2wb_instr_valid <= mem_instr_valid;
      end
      if(wb_pipe_run)begin
        mem2wb_rd_wr <= (ex2mem_rd_wr && mem_instr_valid);
      end
      if(wb_pipe_run)begin
        mem2wb_data_ram_rd <= (ex2mem_data_ram_rd && mem_instr_valid);
      end
      if(wb_pipe_run)begin
        mem2wb_mret <= (ex2mem_mret && mem_instr_valid);
      end
      if(wb_pipe_run)begin
        mem2wb_ecall <= (ex2mem_ecall && mem_instr_valid);
      end
      if(wb_pipe_run)begin
        mem2wb_ebreak <= (ex2mem_ebreak && mem_instr_valid);
      end
      if(wb_pipe_run)begin
        mem2wb_csr_wr <= (ex2mem_csr_wr && mem_instr_valid);
      end
      if(wb_pipe_run)begin
        mem2wb_csr_rd <= (ex2mem_csr_rd && mem_instr_valid);
      end
      if(wb_pipe_run)begin
        mem2wb_illegal_instr_exception <= (ex2mem_illegal_instr_exception && mem_instr_valid);
      end
      if(mem_pipe_run)begin
        mem2wb_instr_addr_misalign_exception <= (ex2mem_instr_addr_misalign_exception && mem_instr_valid);
      end
      if(mem_pipe_run)begin
        mem2wb_load_addr_misalign <= (dmem_ctrl_isnt_io_load_addr_misalign && mem_instr_valid);
      end
      if(mem_pipe_run)begin
        mem2wb_store_addr_misalign <= (dmem_ctrl_isnt_io_store_addr_misalign && mem_instr_valid);
      end
    end
  end

  always @ (posedge clk) begin
    if(ex_pipe_run)begin
      id2ex_csr_rw <= instr_dec_inst_io_csr_rw;
    end
    if(ex_pipe_run)begin
      id2ex_csr_rs <= instr_dec_inst_io_csr_rs;
    end
    if(ex_pipe_run)begin
      id2ex_csr_rc <= instr_dec_inst_io_csr_rc;
    end
    if(ex_pipe_run)begin
      id2ex_csr_sel_imm <= instr_dec_inst_io_csr_sel_imm;
    end
    if(ex_pipe_run)begin
      id2ex_csr_idx <= instr_dec_inst_io_csr_idx;
    end
    if(ex_pipe_run)begin
      id2ex_rd_idx <= instr_dec_inst_io_rd_idx;
    end
    if(ex_pipe_run)begin
      id2ex_rs1_idx <= instr_dec_inst_io_rs1_idx;
    end
    if(ex_pipe_run)begin
      id2ex_rs2_idx <= instr_dec_inst_io_rs2_idx;
    end
    if(ex_pipe_run)begin
      id2ex_alu_op_and <= instr_dec_inst_io_alu_op_and;
    end
    if(ex_pipe_run)begin
      id2ex_alu_op_or <= instr_dec_inst_io_alu_op_or;
    end
    if(ex_pipe_run)begin
      id2ex_alu_op_xor <= instr_dec_inst_io_alu_op_xor;
    end
    if(ex_pipe_run)begin
      id2ex_alu_op_add <= instr_dec_inst_io_alu_op_add;
    end
    if(ex_pipe_run)begin
      id2ex_alu_op_sub <= instr_dec_inst_io_alu_op_sub;
    end
    if(ex_pipe_run)begin
      id2ex_alu_op_sra <= instr_dec_inst_io_alu_op_sra;
    end
    if(ex_pipe_run)begin
      id2ex_alu_op_srl <= instr_dec_inst_io_alu_op_srl;
    end
    if(ex_pipe_run)begin
      id2ex_alu_op_sll <= instr_dec_inst_io_alu_op_sll;
    end
    if(ex_pipe_run)begin
      id2ex_alu_op_slt <= instr_dec_inst_io_alu_op_slt;
    end
    if(ex_pipe_run)begin
      id2ex_alu_op_sltu <= instr_dec_inst_io_alu_op_sltu;
    end
    if(ex_pipe_run)begin
      id2ex_alu_op_eqt <= instr_dec_inst_io_alu_op_eqt;
    end
    if(ex_pipe_run)begin
      id2ex_alu_op_invb0 <= instr_dec_inst_io_alu_op_invb0;
    end
    if(ex_pipe_run)begin
      id2ex_data_ram_ld_byte <= instr_dec_inst_io_data_ram_ld_byte;
    end
    if(ex_pipe_run)begin
      id2ex_data_ram_ld_hword <= instr_dec_inst_io_data_ram_ld_hword;
    end
    if(ex_pipe_run)begin
      id2ex_data_ram_ld_unsign <= instr_dec_inst_io_data_ram_ld_unsign;
    end
    if(ex_pipe_run)begin
      id2ex_rs1_value <= regfile_inst_io_rs1_data_out;
    end
    if(ex_pipe_run)begin
      id2ex_rs2_value <= regfile_inst_io_rs2_data_out;
    end
    if(ex_pipe_run)begin
      id2ex_imm_value <= instr_dec_inst_io_imm_value;
    end
    if(ex_pipe_run)begin
      id2ex_brjp_imm_value <= instr_dec_inst_io_jump_imm_value;
    end
    if(ex_pipe_run)begin
      id2ex_pc <= if2id_pc;
    end
    if(ex_pipe_run)begin
      id2ex_op2_sel_imm <= instr_dec_inst_io_op2_sel_imm;
    end
    if(ex_pipe_run)begin
      id2ex_op1_sel_pc <= instr_dec_inst_io_op1_sel_pc;
    end
    if(ex_pipe_run)begin
      id2ex_op1_sel_zero <= instr_dec_inst_io_op1_sel_zero;
    end
    if(ex_pipe_run)begin
      id2ex_instr <= imem_ctrl_inst_io_mc2cpu_data;
    end
    if(mem_pipe_run)begin
      ex2mem_csr_rw <= id2ex_csr_rw;
    end
    if(mem_pipe_run)begin
      ex2mem_csr_rs <= id2ex_csr_rs;
    end
    if(mem_pipe_run)begin
      ex2mem_csr_rc <= id2ex_csr_rc;
    end
    if(mem_pipe_run)begin
      ex2mem_csr_sel_imm <= id2ex_csr_sel_imm;
    end
    if(mem_pipe_run)begin
      ex2mem_csr_idx <= id2ex_csr_idx;
    end
    if(mem_pipe_run)begin
      ex2mem_rs1_value <= ex_rs1_value_forwarded;
    end
    if(mem_pipe_run)begin
      ex2mem_alu_out <= alu_inst_io_alu_out;
    end
    if(mem_pipe_run)begin
      ex2mem_rs1_idx <= id2ex_rs1_idx;
    end
    if(mem_pipe_run)begin
      ex2mem_rs2_idx <= id2ex_rs2_idx;
    end
    if(mem_pipe_run)begin
      ex2mem_rd_idx <= id2ex_rd_idx;
    end
    if(mem_pipe_run)begin
      ex2mem_rs2_value <= ex_rs2_value_forwarded;
    end
    if(mem_pipe_run)begin
      ex2mem_pc <= id2ex_pc;
    end
    if(mem_pipe_run)begin
      ex2mem_instr <= id2ex_instr;
    end
    if(mem_pipe_run)begin
      ex2mem_data_ram_ld_byte <= id2ex_data_ram_ld_byte;
    end
    if(mem_pipe_run)begin
      ex2mem_data_ram_ld_hword <= id2ex_data_ram_ld_hword;
    end
    if(mem_pipe_run)begin
      ex2mem_data_ram_ld_unsign <= id2ex_data_ram_ld_unsign;
    end
    if(wb_pipe_run)begin
      mem2wb_csr_rw <= ex2mem_csr_rw;
    end
    if(wb_pipe_run)begin
      mem2wb_csr_rs <= ex2mem_csr_rs;
    end
    if(wb_pipe_run)begin
      mem2wb_csr_rc <= ex2mem_csr_rc;
    end
    if(wb_pipe_run)begin
      mem2wb_csr_sel_imm <= ex2mem_csr_sel_imm;
    end
    if(wb_pipe_run)begin
      mem2wb_csr_idx <= ex2mem_csr_idx;
    end
    if(wb_pipe_run)begin
      mem2wb_rs1_idx <= ex2mem_rs1_idx;
    end
    if(wb_pipe_run)begin
      mem2wb_rs1_value <= ex2mem_rs1_value;
    end
    if(wb_pipe_run)begin
      mem2wb_alu_out <= ex2mem_alu_out;
    end
    if(wb_pipe_run)begin
      mem2wb_rd_idx <= ex2mem_rd_idx;
    end
    if(wb_pipe_run)begin
      mem2wb_pc <= ex2mem_pc;
    end
    if(wb_pipe_run)begin
      mem2wb_instr <= ex2mem_instr;
    end
    if(wb_pipe_run)begin
      mem2wb_dmem_addr <= dmem_addr;
    end
  end


endmodule

//StreamFifo replaced by StreamFifo

module StreamFifo (
  input               io_push_valid,
  output              io_push_ready,
  input      [7:0]    io_push_payload,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [7:0]    io_pop_payload,
  input               io_flush,
  output     [3:0]    io_occupancy,
  output     [3:0]    io_availability,
  input               clk,
  input               reset
);
  reg        [7:0]    _zz_3;
  wire       [0:0]    _zz_4;
  wire       [2:0]    _zz_5;
  wire       [0:0]    _zz_6;
  wire       [2:0]    _zz_7;
  wire       [2:0]    _zz_8;
  wire                _zz_9;
  reg                 _zz_1;
  reg                 logic_pushPtr_willIncrement;
  reg                 logic_pushPtr_willClear;
  reg        [2:0]    logic_pushPtr_valueNext;
  reg        [2:0]    logic_pushPtr_value;
  wire                logic_pushPtr_willOverflowIfInc;
  wire                logic_pushPtr_willOverflow;
  reg                 logic_popPtr_willIncrement;
  reg                 logic_popPtr_willClear;
  reg        [2:0]    logic_popPtr_valueNext;
  reg        [2:0]    logic_popPtr_value;
  wire                logic_popPtr_willOverflowIfInc;
  wire                logic_popPtr_willOverflow;
  wire                logic_ptrMatch;
  reg                 logic_risingOccupancy;
  wire                logic_pushing;
  wire                logic_popping;
  wire                logic_empty;
  wire                logic_full;
  reg                 _zz_2;
  wire       [2:0]    logic_ptrDif;
  reg [7:0] logic_ram [0:7];

  assign _zz_4 = logic_pushPtr_willIncrement;
  assign _zz_5 = {2'd0, _zz_4};
  assign _zz_6 = logic_popPtr_willIncrement;
  assign _zz_7 = {2'd0, _zz_6};
  assign _zz_8 = (logic_popPtr_value - logic_pushPtr_value);
  assign _zz_9 = 1'b1;
  always @ (posedge clk) begin
    if(_zz_9) begin
      _zz_3 <= logic_ram[logic_popPtr_valueNext];
    end
  end

  always @ (posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_pushPtr_value] <= io_push_payload;
    end
  end

  always @ (*) begin
    _zz_1 = 1'b0;
    if(logic_pushing)begin
      _zz_1 = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willIncrement = 1'b0;
    if(logic_pushing)begin
      logic_pushPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_pushPtr_willClear = 1'b1;
    end
  end

  assign logic_pushPtr_willOverflowIfInc = (logic_pushPtr_value == 3'b111);
  assign logic_pushPtr_willOverflow = (logic_pushPtr_willOverflowIfInc && logic_pushPtr_willIncrement);
  always @ (*) begin
    logic_pushPtr_valueNext = (logic_pushPtr_value + _zz_5);
    if(logic_pushPtr_willClear)begin
      logic_pushPtr_valueNext = 3'b000;
    end
  end

  always @ (*) begin
    logic_popPtr_willIncrement = 1'b0;
    if(logic_popping)begin
      logic_popPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_popPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_popPtr_willClear = 1'b1;
    end
  end

  assign logic_popPtr_willOverflowIfInc = (logic_popPtr_value == 3'b111);
  assign logic_popPtr_willOverflow = (logic_popPtr_willOverflowIfInc && logic_popPtr_willIncrement);
  always @ (*) begin
    logic_popPtr_valueNext = (logic_popPtr_value + _zz_7);
    if(logic_popPtr_willClear)begin
      logic_popPtr_valueNext = 3'b000;
    end
  end

  assign logic_ptrMatch = (logic_pushPtr_value == logic_popPtr_value);
  assign logic_pushing = (io_push_valid && io_push_ready);
  assign logic_popping = (io_pop_valid && io_pop_ready);
  assign logic_empty = (logic_ptrMatch && (! logic_risingOccupancy));
  assign logic_full = (logic_ptrMatch && logic_risingOccupancy);
  assign io_push_ready = (! logic_full);
  assign io_pop_valid = ((! logic_empty) && (! (_zz_2 && (! logic_full))));
  assign io_pop_payload = _zz_3;
  assign logic_ptrDif = (logic_pushPtr_value - logic_popPtr_value);
  assign io_occupancy = {(logic_risingOccupancy && logic_ptrMatch),logic_ptrDif};
  assign io_availability = {((! logic_risingOccupancy) && logic_ptrMatch),_zz_8};
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      logic_pushPtr_value <= 3'b000;
      logic_popPtr_value <= 3'b000;
      logic_risingOccupancy <= 1'b0;
      _zz_2 <= 1'b0;
    end else begin
      logic_pushPtr_value <= logic_pushPtr_valueNext;
      logic_popPtr_value <= logic_popPtr_valueNext;
      _zz_2 <= (logic_popPtr_valueNext == logic_pushPtr_value);
      if((logic_pushing != logic_popping))begin
        logic_risingOccupancy <= logic_pushing;
      end
      if(io_flush)begin
        logic_risingOccupancy <= 1'b0;
      end
    end
  end


endmodule

module UartCtrl (
  input      [2:0]    io_config_frame_dataLength,
  input      `UartStopType_defaultEncoding_type io_config_frame_stop,
  input      `UartParityType_defaultEncoding_type io_config_frame_parity,
  input      [19:0]   io_config_clockDivider,
  input               io_write_valid,
  output reg          io_write_ready,
  input      [7:0]    io_write_payload,
  output              io_read_valid,
  input               io_read_ready,
  output     [7:0]    io_read_payload,
  output              io_uart_txd,
  input               io_uart_rxd,
  output              io_readError,
  input               io_writeBreak,
  output              io_readBreak,
  input               clk,
  input               reset
);
  wire                _zz_1;
  wire                tx_io_write_ready;
  wire                tx_io_txd;
  wire                rx_io_read_valid;
  wire       [7:0]    rx_io_read_payload;
  wire                rx_io_rts;
  wire                rx_io_error;
  wire                rx_io_break;
  reg        [19:0]   clockDivider_counter;
  wire                clockDivider_tick;
  reg                 io_write_thrown_valid;
  wire                io_write_thrown_ready;
  wire       [7:0]    io_write_thrown_payload;
  `ifndef SYNTHESIS
  reg [23:0] io_config_frame_stop_string;
  reg [31:0] io_config_frame_parity_string;
  `endif


  UartCtrlTx tx (
    .io_configFrame_dataLength    (io_config_frame_dataLength[2:0]  ), //i
    .io_configFrame_stop          (io_config_frame_stop             ), //i
    .io_configFrame_parity        (io_config_frame_parity[1:0]      ), //i
    .io_samplingTick              (clockDivider_tick                ), //i
    .io_write_valid               (io_write_thrown_valid            ), //i
    .io_write_ready               (tx_io_write_ready                ), //o
    .io_write_payload             (io_write_thrown_payload[7:0]     ), //i
    .io_cts                       (_zz_1                            ), //i
    .io_txd                       (tx_io_txd                        ), //o
    .io_break                     (io_writeBreak                    ), //i
    .clk                          (clk                              ), //i
    .reset                        (reset                            )  //i
  );
  UartCtrlRx rx (
    .io_configFrame_dataLength    (io_config_frame_dataLength[2:0]  ), //i
    .io_configFrame_stop          (io_config_frame_stop             ), //i
    .io_configFrame_parity        (io_config_frame_parity[1:0]      ), //i
    .io_samplingTick              (clockDivider_tick                ), //i
    .io_read_valid                (rx_io_read_valid                 ), //o
    .io_read_ready                (io_read_ready                    ), //i
    .io_read_payload              (rx_io_read_payload[7:0]          ), //o
    .io_rxd                       (io_uart_rxd                      ), //i
    .io_rts                       (rx_io_rts                        ), //o
    .io_error                     (rx_io_error                      ), //o
    .io_break                     (rx_io_break                      ), //o
    .clk                          (clk                              ), //i
    .reset                        (reset                            )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_config_frame_stop)
      `UartStopType_defaultEncoding_ONE : io_config_frame_stop_string = "ONE";
      `UartStopType_defaultEncoding_TWO : io_config_frame_stop_string = "TWO";
      default : io_config_frame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_config_frame_parity)
      `UartParityType_defaultEncoding_NONE : io_config_frame_parity_string = "NONE";
      `UartParityType_defaultEncoding_EVEN : io_config_frame_parity_string = "EVEN";
      `UartParityType_defaultEncoding_ODD : io_config_frame_parity_string = "ODD ";
      default : io_config_frame_parity_string = "????";
    endcase
  end
  `endif

  assign clockDivider_tick = (clockDivider_counter == 20'h0);
  always @ (*) begin
    io_write_thrown_valid = io_write_valid;
    if(rx_io_break)begin
      io_write_thrown_valid = 1'b0;
    end
  end

  always @ (*) begin
    io_write_ready = io_write_thrown_ready;
    if(rx_io_break)begin
      io_write_ready = 1'b1;
    end
  end

  assign io_write_thrown_payload = io_write_payload;
  assign io_write_thrown_ready = tx_io_write_ready;
  assign io_read_valid = rx_io_read_valid;
  assign io_read_payload = rx_io_read_payload;
  assign io_uart_txd = tx_io_txd;
  assign io_readError = rx_io_error;
  assign _zz_1 = 1'b0;
  assign io_readBreak = rx_io_break;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      clockDivider_counter <= 20'h0;
    end else begin
      clockDivider_counter <= (clockDivider_counter - 20'h00001);
      if(clockDivider_tick)begin
        clockDivider_counter <= io_config_clockDivider;
      end
    end
  end


endmodule

module hdu (
  output              io_if_valid,
  output              io_id_valid,
  output              io_ex_valid,
  output              io_mem_valid,
  output              io_wb_valid,
  output              io_if_pipe_stall,
  output              io_id_pipe_stall,
  output              io_ex_pipe_stall,
  output              io_mem_pipe_stall,
  output              io_wb_pipe_stall,
  input               io_branch_taken,
  input               io_id_rs1_rd,
  input               io_id_rs2_rd,
  input               io_ex_dmem_rd,
  input      [4:0]    io_id_rs1_idx,
  input      [4:0]    io_id_rs2_idx,
  input      [4:0]    io_ex_rd_idx,
  input      [4:0]    io_mem_rd_idx,
  input               io_ex_csr_rd,
  input               io_mem_csr_rd,
  input               io_id_exception,
  input               io_ex_exception,
  input               io_mem_exception,
  input               io_wb_exception,
  input               io_ex_mret,
  input               io_mem_mret,
  input               io_wb_mret,
  input               io_ex_ecall,
  input               io_mem_ecall,
  input               io_wb_ecall,
  input               io_ex_ebreak,
  input               io_mem_ebreak,
  input               io_wb_ebreak,
  input               io_int_flush
);
  wire                id_rs1_depends_on_ex_rd;
  wire                id_rs2_depends_on_ex_rd;
  wire                stall_on_load_dependence;
  wire                id_rs1_depends_on_mem_rd;
  wire                id_rs2_depends_on_mem_rd;
  wire                id_rs1_depends_on_csr;
  wire                id_rs2_depends_on_csr;
  wire                stall_on_csr_dependence;
  wire                exception_flush_ex;
  wire                exception_flush_id;
  wire                exception_flush_if;
  wire                sys_flush_mem;
  wire                sys_flush_ex;
  wire                sys_flush_id;
  wire                trap_flush_if;
  wire                trap_flush_id;
  wire                trap_flush_ex;
  wire                trap_flush_mem;

  assign id_rs1_depends_on_ex_rd = ((io_id_rs1_idx == io_ex_rd_idx) && io_id_rs1_rd);
  assign id_rs2_depends_on_ex_rd = ((io_id_rs2_idx == io_ex_rd_idx) && io_id_rs2_rd);
  assign stall_on_load_dependence = ((id_rs1_depends_on_ex_rd || id_rs2_depends_on_ex_rd) && io_ex_dmem_rd);
  assign id_rs1_depends_on_mem_rd = ((io_id_rs1_idx == io_mem_rd_idx) && io_id_rs1_rd);
  assign id_rs2_depends_on_mem_rd = ((io_id_rs2_idx == io_mem_rd_idx) && io_id_rs2_rd);
  assign id_rs1_depends_on_csr = ((id_rs1_depends_on_ex_rd && io_ex_csr_rd) || (id_rs1_depends_on_mem_rd && io_mem_csr_rd));
  assign id_rs2_depends_on_csr = ((id_rs2_depends_on_ex_rd && io_ex_csr_rd) || (id_rs2_depends_on_mem_rd && io_mem_csr_rd));
  assign stall_on_csr_dependence = (id_rs2_depends_on_csr || id_rs1_depends_on_csr);
  assign exception_flush_ex = (io_mem_exception || io_wb_exception);
  assign exception_flush_id = (io_ex_exception || exception_flush_ex);
  assign exception_flush_if = (io_id_exception || exception_flush_id);
  assign sys_flush_mem = ((io_wb_mret || io_wb_ebreak) || io_wb_ecall);
  assign sys_flush_ex = (((io_mem_mret || io_mem_ebreak) || io_mem_ecall) || sys_flush_mem);
  assign sys_flush_id = (((io_ex_mret || io_ex_ebreak) || io_ex_ecall) || sys_flush_ex);
  assign trap_flush_if = ((sys_flush_id || exception_flush_if) || io_int_flush);
  assign trap_flush_id = ((sys_flush_id || exception_flush_id) || io_int_flush);
  assign trap_flush_ex = ((sys_flush_ex || exception_flush_ex) || io_int_flush);
  assign trap_flush_mem = ((sys_flush_mem || io_wb_exception) || io_int_flush);
  assign io_if_pipe_stall = (stall_on_load_dependence || stall_on_csr_dependence);
  assign io_id_pipe_stall = (stall_on_load_dependence || stall_on_csr_dependence);
  assign io_ex_pipe_stall = 1'b0;
  assign io_mem_pipe_stall = 1'b0;
  assign io_wb_pipe_stall = 1'b0;
  assign io_if_valid = ((! io_branch_taken) && (! trap_flush_if));
  assign io_id_valid = ((((! io_branch_taken) && (! stall_on_load_dependence)) && (! stall_on_csr_dependence)) && (! trap_flush_id));
  assign io_ex_valid = (! trap_flush_ex);
  assign io_mem_valid = (! trap_flush_mem);
  assign io_wb_valid = (! io_wb_exception);

endmodule

module fu (
  input      [4:0]    io_ex_rs1_idx,
  input      [4:0]    io_ex_rs2_idx,
  input      [4:0]    io_mem_rd_idx,
  input      [4:0]    io_wb_rd_idx,
  input               io_ex_rs1_rd,
  input               io_ex_rs2_rd,
  input               io_mem_rd_wr,
  input               io_wb_rd_wr,
  output              io_forward_rs1_from_mem,
  output              io_forward_rs1_from_wb,
  output              io_forward_rs2_from_mem,
  output              io_forward_rs2_from_wb
);
  wire                rs1_nonzero;
  wire                rs1_match_mem;
  wire                rs1_match_wb;
  wire                rs2_nonzero;
  wire                rs2_match_mem;
  wire                rs2_match_wb;

  assign rs1_nonzero = (io_ex_rs1_idx != 5'h0);
  assign rs1_match_mem = ((io_ex_rs1_idx == io_mem_rd_idx) && rs1_nonzero);
  assign rs1_match_wb = ((io_ex_rs1_idx == io_wb_rd_idx) && rs1_nonzero);
  assign io_forward_rs1_from_mem = ((io_ex_rs1_rd && rs1_match_mem) && io_mem_rd_wr);
  assign io_forward_rs1_from_wb = ((io_ex_rs1_rd && rs1_match_wb) && io_wb_rd_wr);
  assign rs2_nonzero = (io_ex_rs2_idx != 5'h0);
  assign rs2_match_mem = ((io_ex_rs2_idx == io_mem_rd_idx) && rs2_nonzero);
  assign rs2_match_wb = ((io_ex_rs2_idx == io_wb_rd_idx) && rs2_nonzero);
  assign io_forward_rs2_from_mem = ((io_ex_rs2_rd && rs2_match_mem) && io_mem_rd_wr);
  assign io_forward_rs2_from_wb = ((io_ex_rs2_rd && rs2_match_wb) && io_wb_rd_wr);

endmodule

module trap_ctrl (
  input               io_load_addr_misalign,
  input               io_store_addr_misalign,
  input               io_illegal_instr_exception,
  input               io_instr_addr_misalign_exception,
  input               io_external_interrupt,
  input               io_timer_interrupt,
  input               io_software_interrupt,
  input               io_debug_interrupt,
  input               io_mret,
  input               io_ecall,
  input      [31:0]   io_wb_pc,
  input      [31:0]   io_wb_instr,
  input      [31:0]   io_wb_dmem_addr,
  input               io_mie_meie,
  input               io_mie_mtie,
  input               io_mie_msie,
  input               io_mstatus_mie,
  input      [31:0]   io_mepc,
  input      [31:0]   io_mtvec,
  output              io_mtrap_enter,
  output              io_mtrap_exit,
  output     [31:0]   io_mtrap_mepc,
  output     [31:0]   io_mtrap_mcause,
  output     [31:0]   io_mtrap_mtval,
  output              io_pc_trap,
  output     [31:0]   io_pc_value,
  output              io_int_flush
);
  wire       [29:0]   _zz_1;
  wire       [31:0]   _zz_2;
  wire                dmem_addr_exception;
  wire                exception;
  wire       [31:0]   dmem_addr_extended;
  wire                external_interrupt_masked;
  wire                timer_interrupt_masked;
  wire                software_interrupt_masked;
  wire                debug_interrupt_masked;
  wire                interrupt;
  wire       [31:0]   pc_plus_4;
  wire       [30:0]   external_interrupt_mask;
  wire       [30:0]   timer_interrupt_mask;
  wire       [30:0]   software_interrupt_mask;
  wire       [30:0]   interrupt_code;
  wire       [30:0]   load_addr_misalign_mask;
  wire       [30:0]   store_addr_misalign_mask;
  wire       [30:0]   illegal_instr_mask;
  wire       [30:0]   instr_addr_misalign_mask;
  wire       [30:0]   ecall_mask;
  wire       [30:0]   exceptions_code;
  wire       [30:0]   exception_code;
  wire       [29:0]   mtvec_base;

  assign _zz_1 = mtvec_base;
  assign _zz_2 = {2'd0, _zz_1};
  assign dmem_addr_exception = (io_load_addr_misalign || io_store_addr_misalign);
  assign exception = ((dmem_addr_exception || io_illegal_instr_exception) || io_instr_addr_misalign_exception);
  assign dmem_addr_extended = io_wb_dmem_addr;
  assign external_interrupt_masked = ((io_external_interrupt && io_mstatus_mie) && io_mie_meie);
  assign timer_interrupt_masked = ((io_timer_interrupt && io_mstatus_mie) && io_mie_mtie);
  assign software_interrupt_masked = ((io_software_interrupt && io_mstatus_mie) && io_mie_msie);
  assign debug_interrupt_masked = (io_debug_interrupt && io_mstatus_mie);
  assign interrupt = (((external_interrupt_masked || timer_interrupt_masked) || software_interrupt_masked) || debug_interrupt_masked);
  assign pc_plus_4 = (io_wb_pc + 32'h00000004);
  assign external_interrupt_mask = (external_interrupt_masked ? 31'h7fffffff : 31'h0);
  assign timer_interrupt_mask = (timer_interrupt_masked ? 31'h7fffffff : 31'h0);
  assign software_interrupt_mask = (software_interrupt_masked ? 31'h7fffffff : 31'h0);
  assign interrupt_code = (((external_interrupt_mask & 31'h0000000b) | (timer_interrupt_mask & 31'h00000007)) | (software_interrupt_mask & 31'h00000003));
  assign load_addr_misalign_mask = (io_load_addr_misalign ? 31'h7fffffff : 31'h0);
  assign store_addr_misalign_mask = (io_store_addr_misalign ? 31'h7fffffff : 31'h0);
  assign illegal_instr_mask = (io_instr_addr_misalign_exception ? 31'h7fffffff : 31'h0);
  assign instr_addr_misalign_mask = (io_instr_addr_misalign_exception ? 31'h7fffffff : 31'h0);
  assign ecall_mask = (io_ecall ? 31'h7fffffff : 31'h0);
  assign exceptions_code = (((((load_addr_misalign_mask & 31'h00000004) | (store_addr_misalign_mask & 31'h00000006)) | (illegal_instr_mask & 31'h00000002)) | (instr_addr_misalign_mask & 31'h0)) | (ecall_mask & 31'h0000000b));
  assign exception_code = (interrupt_code | exceptions_code);
  assign io_mtrap_enter = ((exception || interrupt) || io_ecall);
  assign io_mtrap_exit = io_mret;
  assign io_mtrap_mepc = ((exception || io_ecall) ? io_wb_pc : pc_plus_4);
  assign io_mtrap_mcause = {interrupt,exception_code};
  assign io_mtrap_mtval = (io_illegal_instr_exception ? io_wb_instr : dmem_addr_extended);
  assign io_pc_trap = (io_mtrap_enter || io_mtrap_exit);
  assign mtvec_base = io_mtvec[31 : 2];
  assign io_pc_value = (io_mret ? io_mepc : _zz_2);
  assign io_int_flush = interrupt;

endmodule

module mcsr (
  input      [11:0]   io_mcsr_addr,
  input      [31:0]   io_mcsr_din,
  input               io_mcsr_wen,
  output reg [31:0]   io_mcsr_dout,
  input               io_mtrap_enter,
  input               io_mtrap_exit,
  input      [31:0]   io_mtrap_mepc,
  input      [31:0]   io_mtrap_mcause,
  input      [31:0]   io_mtrap_mtval,
  input               io_external_interrupt,
  input               io_timer_interrupt,
  input               io_software_interrupt,
  output     [31:0]   io_mtvec,
  output              io_mie_meie,
  output              io_mie_mtie,
  output              io_mie_msie,
  output              io_mstatus_mie,
  output     [31:0]   io_mepc,
  input      [31:0]   io_hartId,
  input               clk,
  input               reset
);
  wire       [31:0]   mvendorid;
  wire       [31:0]   marchid;
  wire       [31:0]   mimpid;
  reg        [31:0]   mstatus;
  reg        [31:0]   misa;
  reg        [31:0]   mie;
  reg        [31:0]   mtvec;
  reg        [31:0]   mscratch;
  reg        [31:0]   mepc;
  reg        [31:0]   mcause;
  reg        [31:0]   mtval;
  reg        [31:0]   mip;
  wire                mstatus_wen;
  wire                mie_wen;
  wire                mtvec_wen;
  wire                mscratch_wen;
  wire                mepc_wen;
  wire                mcause_wen;
  wire                mtval_wen;
  function [31:0] zz_misa(input dummy);
    begin
      zz_misa = 32'h0;
      zz_misa[31 : 30] = 2'b01;
    end
  endfunction
  wire [31:0] _zz_1;

  assign mvendorid = 32'h0;
  assign marchid = 32'h0;
  assign mimpid = 32'h0;
  assign _zz_1 = zz_misa(1'b0);
  always @ (*) misa = _zz_1;
  always @ (*) begin
    case(io_mcsr_addr)
      12'hf11 : begin
        io_mcsr_dout = mvendorid;
      end
      12'hf12 : begin
        io_mcsr_dout = marchid;
      end
      12'hf13 : begin
        io_mcsr_dout = mimpid;
      end
      12'hf14 : begin
        io_mcsr_dout = io_hartId;
      end
      12'h300 : begin
        io_mcsr_dout = mstatus;
      end
      12'h301 : begin
        io_mcsr_dout = misa;
      end
      12'h304 : begin
        io_mcsr_dout = mie;
      end
      12'h305 : begin
        io_mcsr_dout = mtvec;
      end
      12'h340 : begin
        io_mcsr_dout = mscratch;
      end
      12'h341 : begin
        io_mcsr_dout = mepc;
      end
      12'h342 : begin
        io_mcsr_dout = mcause;
      end
      12'h343 : begin
        io_mcsr_dout = mtval;
      end
      12'h344 : begin
        io_mcsr_dout = mip;
      end
      default : begin
        io_mcsr_dout = mvendorid;
      end
    endcase
  end

  assign mstatus_wen = ((io_mcsr_addr == 12'h300) && io_mcsr_wen);
  assign mie_wen = ((io_mcsr_addr == 12'h304) && io_mcsr_wen);
  assign mtvec_wen = ((io_mcsr_addr == 12'h305) && io_mcsr_wen);
  assign mscratch_wen = ((io_mcsr_addr == 12'h340) && io_mcsr_wen);
  assign mepc_wen = ((io_mcsr_addr == 12'h341) && io_mcsr_wen);
  assign mcause_wen = ((io_mcsr_addr == 12'h342) && io_mcsr_wen);
  assign mtval_wen = ((io_mcsr_addr == 12'h343) && io_mcsr_wen);
  assign io_mtvec = mtvec;
  assign io_mie_meie = mie[11];
  assign io_mie_mtie = mie[7];
  assign io_mie_msie = mie[3];
  assign io_mstatus_mie = mstatus[3];
  assign io_mepc = mepc;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      mstatus <= 32'h0;
      mie <= 32'h0;
      mtvec <= 32'h0;
      mscratch <= 32'h0;
      mepc <= 32'h0;
      mcause <= 32'h0;
      mtval <= 32'h0;
      mip <= 32'h0;
    end else begin
      mstatus[12 : 11] <= 2'b11;
      if(io_mtrap_enter)begin
        mstatus[3] <= 1'b0;
        mstatus[7] <= mstatus[3];
      end else begin
        if(io_mtrap_exit)begin
          mstatus[3] <= mstatus[7];
          mstatus[7] <= 1'b1;
        end else begin
          if(mstatus_wen)begin
            mstatus <= io_mcsr_din;
          end
        end
      end
      if(mie_wen)begin
        mie <= io_mcsr_din;
      end
      if(mtvec_wen)begin
        mtvec <= io_mcsr_din;
      end
      if(mscratch_wen)begin
        mscratch <= io_mcsr_din;
      end
      if(io_mtrap_enter)begin
        mepc <= io_mtrap_mepc;
      end else begin
        if(mepc_wen)begin
          mepc <= io_mcsr_din;
        end
      end
      if(io_mtrap_enter)begin
        mcause <= io_mtrap_mcause;
      end else begin
        if(mcause_wen)begin
          mcause <= io_mcsr_din;
        end
      end
      if(io_mtrap_enter)begin
        mtval <= io_mtrap_mtval;
      end else begin
        if(mtval_wen)begin
          mtval <= io_mcsr_din;
        end
      end
      mip[11] <= (io_external_interrupt && mie[11]);
      mip[7] <= (io_timer_interrupt && mie[7]);
      mip[3] <= (io_software_interrupt && mie[3]);
    end
  end


endmodule

module dmem_ctrl (
  input               io_cpu2mc_wr,
  input               io_cpu2mc_rd,
  input      [31:0]   io_cpu2mc_addr,
  input      [31:0]   io_cpu2mc_data,
  output reg [31:0]   io_mc2cpu_data,
  input               io_cpu2mc_mem_LS_byte,
  input               io_cpu2mc_mem_LS_halfword,
  input               io_cpu2mc_mem_LW_unsigned,
  output              io_load_addr_misalign,
  output              io_store_addr_misalign,
  output              dmem_sib_sel,
  output              dmem_sib_enable,
  output              dmem_sib_write,
  output     [3:0]    dmem_sib_mask,
  output     [31:0]   dmem_sib_addr,
  output reg [31:0]   dmem_sib_wdata,
  input      [31:0]   dmem_sib_rdata,
  input               dmem_sib_ready,
  input               dmem_sib_resp,
  input               clk,
  input               reset
);
  wire       [7:0]    _zz_1;
  wire       [31:0]   _zz_2;
  wire       [7:0]    _zz_3;
  wire       [31:0]   _zz_4;
  wire       [7:0]    _zz_5;
  wire       [31:0]   _zz_6;
  wire       [7:0]    _zz_7;
  wire       [31:0]   _zz_8;
  wire       [15:0]   _zz_9;
  wire       [31:0]   _zz_10;
  wire       [15:0]   _zz_11;
  wire       [31:0]   _zz_12;
  wire       [1:0]    mem_byte_addr;
  reg                 LW_unsigned_s1;
  reg                 LS_byte_s1;
  reg                 LS_halfword_s1;
  reg        [1:0]    mem_byte_addr_s1;
  wire       [7:0]    cpu2mc_data_7_0;
  wire       [15:0]   cpu2mc_data_15_0;
  wire       [7:0]    mem2mc_data_byte0;
  wire       [7:0]    mem2mc_data_byte1;
  wire       [7:0]    mem2mc_data_byte2;
  wire       [7:0]    mem2mc_data_byte3;
  wire       [15:0]   mem2mc_data_hw0;
  wire       [15:0]   mem2mc_data_hw1;
  wire       [31:0]   mem2mc_data_byte0_unsign_ext;
  wire       [31:0]   mem2mc_data_byte1_unsign_ext;
  wire       [31:0]   mem2mc_data_byte2_unsign_ext;
  wire       [31:0]   mem2mc_data_byte3_unsign_ext;
  wire       [31:0]   mem2mc_data_hw0_unsign_ext;
  wire       [31:0]   mem2mc_data_hw1_unsign_ext;
  wire       [31:0]   mem2mc_data_byte0_sign_ext;
  wire       [31:0]   mem2mc_data_byte1_sign_ext;
  wire       [31:0]   mem2mc_data_byte2_sign_ext;
  wire       [31:0]   mem2mc_data_byte3_sign_ext;
  wire       [31:0]   mem2mc_data_hw0_sign_ext;
  wire       [31:0]   mem2mc_data_hw1_sign_ext;
  wire                halfword_addr_misalign;
  wire                word_address_misalign;
  wire                wen;
  wire                ren;
  wire       [3:0]    byte_mask;
  wire       [3:0]    halfword_mask;

  assign _zz_1 = mem2mc_data_byte0;
  assign _zz_2 = {{24{_zz_1[7]}}, _zz_1};
  assign _zz_3 = mem2mc_data_byte1;
  assign _zz_4 = {{24{_zz_3[7]}}, _zz_3};
  assign _zz_5 = mem2mc_data_byte2;
  assign _zz_6 = {{24{_zz_5[7]}}, _zz_5};
  assign _zz_7 = mem2mc_data_byte3;
  assign _zz_8 = {{24{_zz_7[7]}}, _zz_7};
  assign _zz_9 = mem2mc_data_hw0;
  assign _zz_10 = {{16{_zz_9[15]}}, _zz_9};
  assign _zz_11 = mem2mc_data_hw1;
  assign _zz_12 = {{16{_zz_11[15]}}, _zz_11};
  assign mem_byte_addr = io_cpu2mc_addr[1 : 0];
  assign cpu2mc_data_7_0 = io_cpu2mc_data[7 : 0];
  assign cpu2mc_data_15_0 = io_cpu2mc_data[15 : 0];
  assign mem2mc_data_byte0 = dmem_sib_rdata[7 : 0];
  assign mem2mc_data_byte1 = dmem_sib_rdata[15 : 8];
  assign mem2mc_data_byte2 = dmem_sib_rdata[23 : 16];
  assign mem2mc_data_byte3 = dmem_sib_rdata[31 : 24];
  assign mem2mc_data_hw0 = dmem_sib_rdata[15 : 0];
  assign mem2mc_data_hw1 = dmem_sib_rdata[31 : 16];
  assign mem2mc_data_byte0_unsign_ext = {24'd0, mem2mc_data_byte0};
  assign mem2mc_data_byte1_unsign_ext = {24'd0, mem2mc_data_byte1};
  assign mem2mc_data_byte2_unsign_ext = {24'd0, mem2mc_data_byte2};
  assign mem2mc_data_byte3_unsign_ext = {24'd0, mem2mc_data_byte3};
  assign mem2mc_data_hw0_unsign_ext = {16'd0, mem2mc_data_hw0};
  assign mem2mc_data_hw1_unsign_ext = {16'd0, mem2mc_data_hw1};
  assign mem2mc_data_byte0_sign_ext = _zz_2;
  assign mem2mc_data_byte1_sign_ext = _zz_4;
  assign mem2mc_data_byte2_sign_ext = _zz_6;
  assign mem2mc_data_byte3_sign_ext = _zz_8;
  assign mem2mc_data_hw0_sign_ext = _zz_10;
  assign mem2mc_data_hw1_sign_ext = _zz_12;
  always @ (*) begin
    dmem_sib_wdata = io_cpu2mc_data;
    if(io_cpu2mc_mem_LS_byte)begin
      dmem_sib_wdata = {{{cpu2mc_data_7_0,cpu2mc_data_7_0},cpu2mc_data_7_0},cpu2mc_data_7_0};
    end else begin
      if(io_cpu2mc_mem_LS_halfword)begin
        dmem_sib_wdata = {cpu2mc_data_15_0,cpu2mc_data_15_0};
      end
    end
  end

  always @ (*) begin
    io_mc2cpu_data = dmem_sib_rdata;
    if(LS_byte_s1)begin
      case(mem_byte_addr_s1)
        2'b00 : begin
          io_mc2cpu_data = (LW_unsigned_s1 ? mem2mc_data_byte0_unsign_ext : mem2mc_data_byte0_sign_ext);
        end
        2'b01 : begin
          io_mc2cpu_data = (LW_unsigned_s1 ? mem2mc_data_byte1_unsign_ext : mem2mc_data_byte1_sign_ext);
        end
        2'b10 : begin
          io_mc2cpu_data = (LW_unsigned_s1 ? mem2mc_data_byte2_unsign_ext : mem2mc_data_byte2_sign_ext);
        end
        default : begin
          io_mc2cpu_data = (LW_unsigned_s1 ? mem2mc_data_byte3_unsign_ext : mem2mc_data_byte3_sign_ext);
        end
      endcase
    end else begin
      if(LS_halfword_s1)begin
        case(mem_byte_addr_s1)
          2'b00 : begin
            io_mc2cpu_data = (LW_unsigned_s1 ? mem2mc_data_hw0_unsign_ext : mem2mc_data_hw0_sign_ext);
          end
          2'b10 : begin
            io_mc2cpu_data = (LW_unsigned_s1 ? mem2mc_data_hw1_unsign_ext : mem2mc_data_hw1_sign_ext);
          end
          default : begin
          end
        endcase
      end
    end
  end

  assign halfword_addr_misalign = (io_cpu2mc_mem_LS_halfword && io_cpu2mc_addr[0]);
  assign word_address_misalign = ((! (io_cpu2mc_mem_LS_byte || io_cpu2mc_mem_LS_halfword)) && (io_cpu2mc_addr[1 : 0] != 2'b00));
  assign io_load_addr_misalign = (io_cpu2mc_rd && (halfword_addr_misalign || word_address_misalign));
  assign io_store_addr_misalign = (io_cpu2mc_wr && (halfword_addr_misalign || word_address_misalign));
  assign wen = (io_cpu2mc_wr && (! io_store_addr_misalign));
  assign ren = (io_cpu2mc_rd && (! io_load_addr_misalign));
  assign dmem_sib_sel = (wen || ren);
  assign dmem_sib_enable = dmem_sib_sel;
  assign dmem_sib_addr = io_cpu2mc_addr;
  assign dmem_sib_write = wen;
  assign byte_mask = (4'b0001 <<< io_cpu2mc_addr[1 : 0]);
  assign halfword_mask = (io_cpu2mc_addr[1] ? 4'b1100 : 4'b0011);
  assign dmem_sib_mask = (io_cpu2mc_mem_LS_byte ? byte_mask : (io_cpu2mc_mem_LS_halfword ? halfword_mask : 4'b1111));
  always @ (posedge clk) begin
    if(io_cpu2mc_rd)begin
      LW_unsigned_s1 <= io_cpu2mc_mem_LW_unsigned;
    end
    if(io_cpu2mc_rd)begin
      LS_byte_s1 <= io_cpu2mc_mem_LS_byte;
    end
    if(io_cpu2mc_rd)begin
      LS_halfword_s1 <= io_cpu2mc_mem_LS_halfword;
    end
    if(io_cpu2mc_rd)begin
      mem_byte_addr_s1 <= mem_byte_addr;
    end
  end


endmodule

module branch_unit (
  input               io_branch_result,
  input      [31:0]   io_current_pc,
  input      [20:0]   io_imm_value,
  input      [31:0]   io_rs1_value,
  input               io_br_op,
  input               io_jal_op,
  input               io_jalr_op,
  output reg [31:0]   io_target_pc,
  output              io_branch_taken,
  output              io_instr_addr_misalign_exception
);
  wire       [31:0]   _zz_1;
  wire       [31:0]   addr_in;
  wire       [1:0]    pc_1_0;

  assign _zz_1 = {{11{io_imm_value[20]}}, io_imm_value};
  assign io_branch_taken = ((io_jal_op || io_jalr_op) || (io_br_op && io_branch_result));
  assign addr_in = (io_jalr_op ? io_rs1_value : io_current_pc);
  always @ (*) begin
    io_target_pc = (addr_in + _zz_1);
    io_target_pc[0] = 1'b0;
  end

  assign pc_1_0 = io_target_pc[1 : 0];
  assign io_instr_addr_misalign_exception = (io_branch_taken && (pc_1_0 != 2'b00));

endmodule

module alu (
  input      [31:0]   io_operand_1,
  input      [31:0]   io_operand_2,
  output     [31:0]   io_alu_out,
  input               io_alu_op_and,
  input               io_alu_op_or,
  input               io_alu_op_xor,
  input               io_alu_op_add,
  input               io_alu_op_sub,
  input               io_alu_op_sra,
  input               io_alu_op_srl,
  input               io_alu_op_sll,
  input               io_alu_op_slt,
  input               io_alu_op_sltu,
  input               io_alu_op_eqt,
  input               io_alu_op_invb0
);
  wire       [31:0]   op1_signed;
  wire       [31:0]   op2_signed;
  wire       [31:0]   op1_unsigned;
  wire       [31:0]   op2_unsigned;
  wire       [4:0]    shift_value;
  wire       [31:0]   add_result;
  wire       [31:0]   sub_result;
  wire       [31:0]   and_result;
  wire       [31:0]   or_result;
  wire       [31:0]   xor_result;
  wire       [31:0]   sra_result_tmp;
  wire       [31:0]   sra_result;
  wire       [31:0]   srl_result;
  wire       [31:0]   sll_result;
  reg        [31:0]   slt_result;
  reg        [31:0]   sltu_result;
  reg        [31:0]   eqt_result;
  wire       [31:0]   alu_op_and_mask;
  wire       [31:0]   alu_op_or_mask;
  wire       [31:0]   alu_op_xor_mask;
  wire       [31:0]   alu_op_add_mask;
  wire       [31:0]   alu_op_sub_mask;
  wire       [31:0]   alu_op_sra_mask;
  wire       [31:0]   alu_op_srl_mask;
  wire       [31:0]   alu_op_sll_mask;
  wire       [31:0]   alu_op_slt_mask;
  wire       [31:0]   alu_op_sltu_mask;
  wire       [31:0]   alu_op_eqt_mask;
  wire       [31:0]   alu_out_1;
  wire       [31:0]   alu_out_2;

  assign op1_signed = io_operand_1;
  assign op2_signed = io_operand_2;
  assign op1_unsigned = io_operand_1;
  assign op2_unsigned = io_operand_2;
  assign shift_value = op2_unsigned[4 : 0];
  assign add_result = ($signed(op1_signed) + $signed(op2_signed));
  assign sub_result = ($signed(op1_signed) - $signed(op2_signed));
  assign and_result = (io_operand_1 & io_operand_2);
  assign or_result = (io_operand_1 | io_operand_2);
  assign xor_result = (io_operand_1 ^ io_operand_2);
  assign sra_result_tmp = ($signed(op1_signed) >>> shift_value);
  assign sra_result = sra_result_tmp;
  assign srl_result = (io_operand_1 >>> shift_value);
  assign sll_result = (io_operand_1 <<< shift_value);
  always @ (*) begin
    slt_result[31 : 1] = 31'h0;
    slt_result[0] = (($signed(op1_signed) < $signed(op2_signed)) ^ io_alu_op_invb0);
  end

  always @ (*) begin
    sltu_result[31 : 1] = 31'h0;
    sltu_result[0] = ((op1_unsigned < op2_unsigned) ^ io_alu_op_invb0);
  end

  always @ (*) begin
    eqt_result[31 : 1] = 31'h0;
    eqt_result[0] = ((io_operand_1 == io_operand_2) ^ io_alu_op_invb0);
  end

  assign alu_op_and_mask = (io_alu_op_and ? 32'hffffffff : 32'h0);
  assign alu_op_or_mask = (io_alu_op_or ? 32'hffffffff : 32'h0);
  assign alu_op_xor_mask = (io_alu_op_xor ? 32'hffffffff : 32'h0);
  assign alu_op_add_mask = (io_alu_op_add ? 32'hffffffff : 32'h0);
  assign alu_op_sub_mask = (io_alu_op_sub ? 32'hffffffff : 32'h0);
  assign alu_op_sra_mask = (io_alu_op_sra ? 32'hffffffff : 32'h0);
  assign alu_op_srl_mask = (io_alu_op_srl ? 32'hffffffff : 32'h0);
  assign alu_op_sll_mask = (io_alu_op_sll ? 32'hffffffff : 32'h0);
  assign alu_op_slt_mask = (io_alu_op_slt ? 32'hffffffff : 32'h0);
  assign alu_op_sltu_mask = (io_alu_op_sltu ? 32'hffffffff : 32'h0);
  assign alu_op_eqt_mask = (io_alu_op_eqt ? 32'hffffffff : 32'h0);
  assign alu_out_1 = ((((((alu_op_and_mask & and_result) | (alu_op_or_mask & or_result)) | (alu_op_xor_mask & xor_result)) | (alu_op_add_mask & add_result)) | (alu_op_sub_mask & sub_result)) | (alu_op_sra_mask & sra_result));
  assign alu_out_2 = (((((alu_op_srl_mask & srl_result) | (alu_op_sll_mask & sll_result)) | (alu_op_slt_mask & slt_result)) | (alu_op_sltu_mask & sltu_result)) | (alu_op_eqt_mask & eqt_result));
  assign io_alu_out = (alu_out_1 | alu_out_2);

endmodule

module regfile (
  input      [4:0]    io_rs1_rd_addr,
  output reg [31:0]   io_rs1_data_out,
  input      [4:0]    io_rs2_rd_addr,
  output reg [31:0]   io_rs2_data_out,
  input               io_register_wr,
  input      [4:0]    io_register_wr_addr,
  input      [31:0]   io_rd_in,
  input               clk,
  input               reset
);
  wire       [31:0]   _zz_1;
  wire       [31:0]   _zz_2;
  wire       [31:0]   rs1_data;
  wire       [31:0]   rs2_data;
  (* ram_style = "distributed" *) reg [31:0] ram [0:31];

  always @ (posedge clk) begin
    if(io_register_wr) begin
      ram[io_register_wr_addr] <= io_rd_in;
    end
  end

  assign _zz_1 = ram[io_rs1_rd_addr];
  assign _zz_2 = ram[io_rs2_rd_addr];
  assign rs1_data = _zz_1;
  assign rs2_data = _zz_2;
  always @ (*) begin
    if((io_rs1_rd_addr == 5'h0))begin
      io_rs1_data_out = 32'h0;
    end else begin
      if(((io_rs1_rd_addr == io_register_wr_addr) && (io_register_wr == 1'b1)))begin
        io_rs1_data_out = io_rd_in;
      end else begin
        io_rs1_data_out = rs1_data;
      end
    end
  end

  always @ (*) begin
    if((io_rs2_rd_addr == 5'h0))begin
      io_rs2_data_out = 32'h0;
    end else begin
      if(((io_rs2_rd_addr == io_register_wr_addr) && (io_register_wr == 1'b1)))begin
        io_rs2_data_out = io_rd_in;
      end else begin
        io_rs2_data_out = rs2_data;
      end
    end
  end


endmodule

module instr_dec (
  input      [31:0]   io_instr,
  input               io_instr_vld,
  output     [4:0]    io_rd_idx,
  output     [4:0]    io_rs1_idx,
  output     [4:0]    io_rs2_idx,
  output reg [31:0]   io_imm_value,
  output reg [20:0]   io_jump_imm_value,
  output reg          io_rd_wr,
  output reg          io_rs1_rd,
  output reg          io_rs2_rd,
  output reg          io_data_ram_wr,
  output reg          io_data_ram_rd,
  output reg          io_data_ram_ld_byte,
  output reg          io_data_ram_ld_hword,
  output reg          io_data_ram_ld_unsign,
  output reg          io_alu_op_and,
  output reg          io_alu_op_or,
  output reg          io_alu_op_xor,
  output reg          io_alu_op_add,
  output reg          io_alu_op_sub,
  output reg          io_alu_op_sra,
  output reg          io_alu_op_srl,
  output reg          io_alu_op_sll,
  output reg          io_alu_op_slt,
  output reg          io_alu_op_sltu,
  output reg          io_alu_op_eqt,
  output reg          io_alu_op_invb0,
  output     [1:0]    io_alu_branch_op,
  output reg          io_csr_rd,
  output reg          io_csr_wr,
  output reg          io_csr_rw,
  output reg          io_csr_rs,
  output reg          io_csr_rc,
  output reg          io_csr_sel_imm,
  output     [11:0]   io_csr_idx,
  output reg          io_op2_sel_imm,
  output reg          io_op1_sel_pc,
  output reg          io_op1_sel_zero,
  output reg          io_branch_op,
  output reg          io_jal_op,
  output reg          io_jalr_op,
  output reg          io_mret,
  output reg          io_ecall,
  output              io_ebreak,
  output              io_invld_instr
);
  wire                _zz_1;
  wire                _zz_2;
  wire       [11:0]   _zz_3;
  wire       [11:0]   _zz_4;
  wire       [12:0]   _zz_5;
  wire       [6:0]    opcode;
  wire       [2:0]    func3;
  wire       [6:0]    func7;
  wire       [11:0]   func12;
  reg        `br_imm_type_e_defaultEncoding_type br_imm_type;
  reg        `alu_imm_type_e_defaultEncoding_type alu_imm_type;
  wire                func7_not_all_zero;
  wire                rd_isnot_x0;
  wire                rs1_isnot_x0;
  reg                 invld_instr_int;
  wire       [31:0]   i_type_imm;
  wire       [31:0]   s_type_imm;
  wire       [31:0]   u_type_imm;
  wire       [20:0]   b_type_imm;
  wire       [20:0]   j_type_imm;
  `ifndef SYNTHESIS
  reg [39:0] br_imm_type_string;
  reg [39:0] alu_imm_type_string;
  `endif


  assign _zz_1 = (func12 == 12'h302);
  assign _zz_2 = (func12 == 12'h0);
  assign _zz_3 = io_instr[31 : 20];
  assign _zz_4 = {io_instr[31 : 25],io_instr[11 : 7]};
  assign _zz_5 = {{{{io_instr[31],io_instr[7]},io_instr[30 : 25]},io_instr[11 : 8]},1'b0};
  `ifndef SYNTHESIS
  always @(*) begin
    case(br_imm_type)
      `br_imm_type_e_defaultEncoding_JTYPE : br_imm_type_string = "JTYPE";
      `br_imm_type_e_defaultEncoding_BTYPE : br_imm_type_string = "BTYPE";
      `br_imm_type_e_defaultEncoding_ITYPE : br_imm_type_string = "ITYPE";
      default : br_imm_type_string = "?????";
    endcase
  end
  always @(*) begin
    case(alu_imm_type)
      `alu_imm_type_e_defaultEncoding_ITYPE : alu_imm_type_string = "ITYPE";
      `alu_imm_type_e_defaultEncoding_STYPE : alu_imm_type_string = "STYPE";
      `alu_imm_type_e_defaultEncoding_UTYPE : alu_imm_type_string = "UTYPE";
      `alu_imm_type_e_defaultEncoding_FOUR : alu_imm_type_string = "FOUR ";
      `alu_imm_type_e_defaultEncoding_ZERO : alu_imm_type_string = "ZERO ";
      default : alu_imm_type_string = "?????";
    endcase
  end
  `endif

  assign opcode = io_instr[6 : 0];
  assign func3 = io_instr[14 : 12];
  assign func7 = io_instr[31 : 25];
  assign func12 = io_instr[31 : 20];
  assign io_rd_idx = io_instr[11 : 7];
  assign io_rs1_idx = io_instr[19 : 15];
  assign io_rs2_idx = io_instr[24 : 20];
  assign io_csr_idx = io_instr[31 : 20];
  always @ (*) begin
    br_imm_type = `br_imm_type_e_defaultEncoding_JTYPE;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
        br_imm_type = `br_imm_type_e_defaultEncoding_JTYPE;
      end
      7'h67 : begin
        br_imm_type = `br_imm_type_e_defaultEncoding_ITYPE;
      end
      7'h63 : begin
        br_imm_type = `br_imm_type_e_defaultEncoding_BTYPE;
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    alu_imm_type = `alu_imm_type_e_defaultEncoding_FOUR;
    case(opcode)
      7'h37 : begin
        alu_imm_type = `alu_imm_type_e_defaultEncoding_UTYPE;
      end
      7'h17 : begin
        alu_imm_type = `alu_imm_type_e_defaultEncoding_UTYPE;
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
        alu_imm_type = `alu_imm_type_e_defaultEncoding_ITYPE;
      end
      7'h23 : begin
        alu_imm_type = `alu_imm_type_e_defaultEncoding_STYPE;
      end
      7'h13 : begin
        alu_imm_type = `alu_imm_type_e_defaultEncoding_ITYPE;
      end
      7'h33 : begin
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  assign func7_not_all_zero = (func7 != 7'h0);
  assign rd_isnot_x0 = (io_rd_idx != 5'h0);
  assign rs1_isnot_x0 = (io_rs1_idx != 5'h0);
  always @ (*) begin
    invld_instr_int = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
          end
          3'b100 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          default : begin
            invld_instr_int = 1'b1;
          end
        endcase
      end
      7'h03 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b100 : begin
          end
          3'b101 : begin
          end
          default : begin
            invld_instr_int = 1'b1;
          end
        endcase
      end
      7'h23 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
          end
          3'b010 : begin
          end
          default : begin
            invld_instr_int = 1'b1;
          end
        endcase
      end
      7'h13 : begin
        case(func3)
          3'b000 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          3'b001 : begin
          end
          default : begin
            case(func7)
              7'h0 : begin
              end
              7'h20 : begin
              end
              default : begin
                invld_instr_int = 1'b1;
              end
            endcase
          end
        endcase
      end
      7'h33 : begin
        case(func3)
          3'b000 : begin
            case(func7)
              7'h0 : begin
              end
              7'h20 : begin
              end
              default : begin
                invld_instr_int = 1'b1;
              end
            endcase
          end
          3'b001 : begin
            invld_instr_int = func7_not_all_zero;
          end
          3'b010 : begin
            invld_instr_int = func7_not_all_zero;
          end
          3'b011 : begin
            invld_instr_int = func7_not_all_zero;
          end
          3'b100 : begin
            invld_instr_int = func7_not_all_zero;
          end
          3'b101 : begin
            case(func7)
              7'h0 : begin
              end
              7'h20 : begin
              end
              default : begin
                invld_instr_int = 1'b1;
              end
            endcase
          end
          3'b110 : begin
            invld_instr_int = func7_not_all_zero;
          end
          default : begin
            invld_instr_int = func7_not_all_zero;
          end
        endcase
      end
      7'h73 : begin
        case(func3)
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          3'b000 : begin
            if(_zz_1)begin
              invld_instr_int = (rs1_isnot_x0 && rd_isnot_x0);
            end else begin
              if(_zz_2)begin
                invld_instr_int = (rs1_isnot_x0 && rd_isnot_x0);
              end else begin
                invld_instr_int = 1'b1;
              end
            end
          end
          default : begin
            invld_instr_int = 1'b1;
          end
        endcase
      end
      default : begin
        invld_instr_int = 1'b1;
      end
    endcase
  end

  assign io_invld_instr = (invld_instr_int && io_instr_vld);
  always @ (*) begin
    io_rd_wr = 1'b0;
    case(opcode)
      7'h37 : begin
        io_rd_wr = 1'b1;
      end
      7'h17 : begin
        io_rd_wr = 1'b1;
      end
      7'h6f : begin
        io_rd_wr = 1'b1;
      end
      7'h67 : begin
        io_rd_wr = 1'b1;
      end
      7'h63 : begin
      end
      7'h03 : begin
        io_rd_wr = 1'b1;
      end
      7'h23 : begin
      end
      7'h13 : begin
        io_rd_wr = 1'b1;
      end
      7'h33 : begin
        io_rd_wr = 1'b1;
      end
      7'h73 : begin
        case(func3)
          3'b001 : begin
            io_rd_wr = 1'b1;
          end
          3'b010 : begin
            io_rd_wr = 1'b1;
          end
          3'b011 : begin
            io_rd_wr = 1'b1;
          end
          3'b101 : begin
            io_rd_wr = 1'b1;
          end
          3'b110 : begin
            io_rd_wr = 1'b1;
          end
          3'b111 : begin
            io_rd_wr = 1'b1;
          end
          3'b000 : begin
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_rs1_rd = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
        io_rs1_rd = 1'b1;
      end
      7'h63 : begin
        io_rs1_rd = 1'b1;
      end
      7'h03 : begin
        io_rs1_rd = 1'b1;
      end
      7'h23 : begin
        io_rs1_rd = 1'b1;
      end
      7'h13 : begin
        io_rs1_rd = 1'b1;
      end
      7'h33 : begin
        io_rs1_rd = 1'b1;
      end
      7'h73 : begin
        case(func3)
          3'b001 : begin
            io_rs1_rd = 1'b1;
          end
          3'b010 : begin
            io_rs1_rd = 1'b1;
          end
          3'b011 : begin
            io_rs1_rd = 1'b1;
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          3'b000 : begin
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_rs2_rd = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
        io_rs2_rd = 1'b1;
      end
      7'h03 : begin
      end
      7'h23 : begin
        io_rs2_rd = 1'b1;
      end
      7'h13 : begin
      end
      7'h33 : begin
        io_rs2_rd = 1'b1;
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_data_ram_wr = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
        io_data_ram_wr = 1'b1;
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_data_ram_rd = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
        io_data_ram_rd = 1'b1;
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_data_ram_ld_byte = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
        case(func3)
          3'b000 : begin
            io_data_ram_ld_byte = 1'b1;
          end
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b100 : begin
            io_data_ram_ld_byte = 1'b1;
          end
          3'b101 : begin
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
        case(func3)
          3'b000 : begin
            io_data_ram_ld_byte = 1'b1;
          end
          3'b001 : begin
          end
          3'b010 : begin
          end
          default : begin
          end
        endcase
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_data_ram_ld_hword = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
            io_data_ram_ld_hword = 1'b1;
          end
          3'b010 : begin
          end
          3'b100 : begin
          end
          3'b101 : begin
            io_data_ram_ld_hword = 1'b1;
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
            io_data_ram_ld_hword = 1'b1;
          end
          3'b010 : begin
          end
          default : begin
          end
        endcase
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_data_ram_ld_unsign = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b100 : begin
            io_data_ram_ld_unsign = 1'b1;
          end
          3'b101 : begin
            io_data_ram_ld_unsign = 1'b1;
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_alu_op_and = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
        case(func3)
          3'b000 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b110 : begin
          end
          3'b111 : begin
            io_alu_op_and = 1'b1;
          end
          3'b001 : begin
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          default : begin
            io_alu_op_and = 1'b1;
          end
        endcase
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_alu_op_or = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
        case(func3)
          3'b000 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b110 : begin
            io_alu_op_or = 1'b1;
          end
          3'b111 : begin
          end
          3'b001 : begin
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
            io_alu_op_or = 1'b1;
          end
          default : begin
          end
        endcase
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_alu_op_xor = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
        case(func3)
          3'b000 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
            io_alu_op_xor = 1'b1;
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          3'b001 : begin
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
            io_alu_op_xor = 1'b1;
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          default : begin
          end
        endcase
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_alu_op_add = 1'b0;
    case(opcode)
      7'h37 : begin
        io_alu_op_add = 1'b1;
      end
      7'h17 : begin
        io_alu_op_add = 1'b1;
      end
      7'h6f : begin
        io_alu_op_add = 1'b1;
      end
      7'h67 : begin
        io_alu_op_add = 1'b1;
      end
      7'h63 : begin
      end
      7'h03 : begin
        io_alu_op_add = 1'b1;
      end
      7'h23 : begin
        io_alu_op_add = 1'b1;
      end
      7'h13 : begin
        case(func3)
          3'b000 : begin
            io_alu_op_add = 1'b1;
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          3'b001 : begin
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(func3)
          3'b000 : begin
            case(func7)
              7'h0 : begin
                io_alu_op_add = 1'b1;
              end
              7'h20 : begin
              end
              default : begin
              end
            endcase
          end
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          default : begin
          end
        endcase
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_alu_op_sub = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
        case(func3)
          3'b000 : begin
            case(func7)
              7'h0 : begin
              end
              7'h20 : begin
                io_alu_op_sub = 1'b1;
              end
              default : begin
              end
            endcase
          end
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          default : begin
          end
        endcase
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_alu_op_sra = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
        case(func3)
          3'b000 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          3'b001 : begin
          end
          default : begin
            case(func7)
              7'h0 : begin
              end
              7'h20 : begin
                io_alu_op_sra = 1'b1;
              end
              default : begin
              end
            endcase
          end
        endcase
      end
      7'h33 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b101 : begin
            case(func7)
              7'h0 : begin
              end
              7'h20 : begin
                io_alu_op_sra = 1'b1;
              end
              default : begin
              end
            endcase
          end
          3'b110 : begin
          end
          default : begin
          end
        endcase
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_alu_op_srl = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
        case(func3)
          3'b000 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          3'b001 : begin
          end
          default : begin
            case(func7)
              7'h0 : begin
                io_alu_op_srl = 1'b1;
              end
              7'h20 : begin
              end
              default : begin
              end
            endcase
          end
        endcase
      end
      7'h33 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b101 : begin
            case(func7)
              7'h0 : begin
                io_alu_op_srl = 1'b1;
              end
              7'h20 : begin
              end
              default : begin
              end
            endcase
          end
          3'b110 : begin
          end
          default : begin
          end
        endcase
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_alu_op_sll = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
        case(func3)
          3'b000 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          3'b001 : begin
            io_alu_op_sll = 1'b1;
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
            io_alu_op_sll = 1'b1;
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          default : begin
          end
        endcase
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_alu_op_slt = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
          end
          3'b100 : begin
            io_alu_op_slt = 1'b1;
          end
          3'b101 : begin
            io_alu_op_slt = 1'b1;
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          default : begin
          end
        endcase
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
        case(func3)
          3'b000 : begin
          end
          3'b010 : begin
            io_alu_op_slt = 1'b1;
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          3'b001 : begin
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
          end
          3'b010 : begin
            io_alu_op_slt = 1'b1;
          end
          3'b011 : begin
          end
          3'b100 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          default : begin
          end
        endcase
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_alu_op_sltu = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
          end
          3'b100 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
            io_alu_op_sltu = 1'b1;
          end
          3'b111 : begin
            io_alu_op_sltu = 1'b1;
          end
          default : begin
          end
        endcase
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
        case(func3)
          3'b000 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
            io_alu_op_sltu = 1'b1;
          end
          3'b100 : begin
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          3'b001 : begin
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
            io_alu_op_sltu = 1'b1;
          end
          3'b100 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          default : begin
          end
        endcase
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_alu_op_eqt = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
        case(func3)
          3'b000 : begin
            io_alu_op_eqt = 1'b1;
          end
          3'b001 : begin
            io_alu_op_eqt = 1'b1;
          end
          3'b100 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          default : begin
          end
        endcase
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_alu_op_invb0 = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
        case(func3)
          3'b000 : begin
          end
          3'b001 : begin
            io_alu_op_invb0 = 1'b1;
          end
          3'b100 : begin
          end
          3'b101 : begin
            io_alu_op_invb0 = 1'b1;
          end
          3'b110 : begin
          end
          3'b111 : begin
            io_alu_op_invb0 = 1'b1;
          end
          default : begin
          end
        endcase
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_op2_sel_imm = 1'b0;
    case(opcode)
      7'h37 : begin
        io_op2_sel_imm = 1'b1;
      end
      7'h17 : begin
        io_op2_sel_imm = 1'b1;
      end
      7'h6f : begin
        io_op2_sel_imm = 1'b1;
      end
      7'h67 : begin
        io_op2_sel_imm = 1'b1;
      end
      7'h63 : begin
      end
      7'h03 : begin
        io_op2_sel_imm = 1'b1;
      end
      7'h23 : begin
        io_op2_sel_imm = 1'b1;
      end
      7'h13 : begin
        io_op2_sel_imm = 1'b1;
      end
      7'h33 : begin
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_op1_sel_pc = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
        io_op1_sel_pc = 1'b1;
      end
      7'h6f : begin
        io_op1_sel_pc = 1'b1;
      end
      7'h67 : begin
        io_op1_sel_pc = 1'b1;
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_op1_sel_zero = 1'b0;
    case(opcode)
      7'h37 : begin
        io_op1_sel_zero = 1'b1;
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_branch_op = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
        io_branch_op = 1'b1;
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_jal_op = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
        io_jal_op = 1'b1;
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_jalr_op = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
        io_jalr_op = 1'b1;
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_mret = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
        case(func3)
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          3'b000 : begin
            if(_zz_1)begin
              io_mret = 1'b1;
            end
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_ecall = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
        case(func3)
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          3'b000 : begin
            if(! _zz_1) begin
              if(_zz_2)begin
                io_ecall = 1'b1;
              end
            end
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  assign io_ebreak = 1'b0;
  always @ (*) begin
    io_csr_rd = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
        case(func3)
          3'b001 : begin
            io_csr_rd = rd_isnot_x0;
          end
          3'b010 : begin
            io_csr_rd = 1'b1;
          end
          3'b011 : begin
            io_csr_rd = 1'b1;
          end
          3'b101 : begin
            io_csr_rd = rd_isnot_x0;
          end
          3'b110 : begin
            io_csr_rd = 1'b1;
          end
          3'b111 : begin
            io_csr_rd = 1'b1;
          end
          3'b000 : begin
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_csr_wr = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
        case(func3)
          3'b001 : begin
            io_csr_wr = 1'b1;
          end
          3'b010 : begin
            io_csr_wr = rs1_isnot_x0;
          end
          3'b011 : begin
            io_csr_wr = rs1_isnot_x0;
          end
          3'b101 : begin
            io_csr_wr = 1'b1;
          end
          3'b110 : begin
            io_csr_wr = rs1_isnot_x0;
          end
          3'b111 : begin
            io_csr_wr = rs1_isnot_x0;
          end
          3'b000 : begin
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_csr_rw = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
        case(func3)
          3'b001 : begin
            io_csr_rw = 1'b1;
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b101 : begin
            io_csr_rw = 1'b1;
          end
          3'b110 : begin
          end
          3'b111 : begin
          end
          3'b000 : begin
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_csr_rs = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
        case(func3)
          3'b001 : begin
          end
          3'b010 : begin
            io_csr_rs = 1'b1;
          end
          3'b011 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
            io_csr_rs = 1'b1;
          end
          3'b111 : begin
          end
          3'b000 : begin
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_csr_rc = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
        case(func3)
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
            io_csr_rc = 1'b1;
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          3'b111 : begin
            io_csr_rc = 1'b1;
          end
          3'b000 : begin
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_csr_sel_imm = 1'b0;
    case(opcode)
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h6f : begin
      end
      7'h67 : begin
      end
      7'h63 : begin
      end
      7'h03 : begin
      end
      7'h23 : begin
      end
      7'h13 : begin
      end
      7'h33 : begin
      end
      7'h73 : begin
        case(func3)
          3'b001 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b101 : begin
            io_csr_sel_imm = 1'b1;
          end
          3'b110 : begin
            io_csr_sel_imm = 1'b1;
          end
          3'b111 : begin
            io_csr_sel_imm = 1'b1;
          end
          3'b000 : begin
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  assign i_type_imm = {{20{_zz_3[11]}}, _zz_3};
  assign s_type_imm = {{20{_zz_4[11]}}, _zz_4};
  assign u_type_imm = {io_instr[31 : 12],12'h0};
  assign b_type_imm = {{8{_zz_5[12]}}, _zz_5};
  assign j_type_imm = {{{{io_instr[31],io_instr[19 : 12]},io_instr[20]},io_instr[30 : 21]},1'b0};
  always @ (*) begin
    case(alu_imm_type)
      `alu_imm_type_e_defaultEncoding_ITYPE : begin
        io_imm_value = i_type_imm;
      end
      `alu_imm_type_e_defaultEncoding_STYPE : begin
        io_imm_value = s_type_imm;
      end
      `alu_imm_type_e_defaultEncoding_UTYPE : begin
        io_imm_value = u_type_imm;
      end
      default : begin
        io_imm_value = 32'h00000004;
      end
    endcase
  end

  always @ (*) begin
    case(br_imm_type)
      `br_imm_type_e_defaultEncoding_BTYPE : begin
        io_jump_imm_value = b_type_imm;
      end
      `br_imm_type_e_defaultEncoding_ITYPE : begin
        io_jump_imm_value = i_type_imm[20 : 0];
      end
      default : begin
        io_jump_imm_value = j_type_imm;
      end
    endcase
  end


endmodule

module imem_ctrl (
  input      [31:0]   io_cpu2mc_addr,
  input               io_cpu2mc_en,
  output     [31:0]   io_mc2cpu_data,
  output              imem_sib_sel,
  output              imem_sib_enable,
  output              imem_sib_write,
  output     [3:0]    imem_sib_mask,
  output     [31:0]   imem_sib_addr,
  output     [31:0]   imem_sib_wdata,
  input      [31:0]   imem_sib_rdata,
  input               imem_sib_ready,
  input               imem_sib_resp
);

  assign imem_sib_sel = 1'b1;
  assign imem_sib_enable = io_cpu2mc_en;
  assign imem_sib_addr = io_cpu2mc_addr;
  assign imem_sib_wdata = 32'h0;
  assign imem_sib_write = 1'b0;
  assign io_mc2cpu_data = imem_sib_rdata;

endmodule

module program_counter (
  input      [31:0]   io_branch_pc_in,
  input      [31:0]   io_trap_pc_in,
  input               io_branch,
  input               io_trap,
  input               io_stall,
  output     [31:0]   io_pc_out,
  input               clk,
  input               reset
);
  reg        [31:0]   pc;

  assign io_pc_out = pc;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      pc <= 32'h0;
    end else begin
      if((! io_stall))begin
        if(io_branch)begin
          pc <= io_branch_pc_in;
        end else begin
          if(io_trap)begin
            pc <= io_trap_pc_in;
          end else begin
            pc <= (pc + 32'h00000004);
          end
        end
      end
    end
  end


endmodule

module UartCtrlRx (
  input      [2:0]    io_configFrame_dataLength,
  input      `UartStopType_defaultEncoding_type io_configFrame_stop,
  input      `UartParityType_defaultEncoding_type io_configFrame_parity,
  input               io_samplingTick,
  output              io_read_valid,
  input               io_read_ready,
  output     [7:0]    io_read_payload,
  input               io_rxd,
  output              io_rts,
  output reg          io_error,
  output              io_break,
  input               clk,
  input               reset
);
  wire                io_rxd_buffercc_io_dataOut;
  wire                _zz_2;
  wire                _zz_3;
  wire                _zz_4;
  wire                _zz_5;
  wire       [0:0]    _zz_6;
  wire       [2:0]    _zz_7;
  wire                _zz_8;
  wire                _zz_9;
  wire                _zz_10;
  wire                _zz_11;
  wire                _zz_12;
  wire                _zz_13;
  wire                _zz_14;
  reg                 _zz_1;
  wire                sampler_synchroniser;
  wire                sampler_samples_0;
  reg                 sampler_samples_1;
  reg                 sampler_samples_2;
  reg                 sampler_samples_3;
  reg                 sampler_samples_4;
  reg                 sampler_value;
  reg                 sampler_tick;
  reg        [2:0]    bitTimer_counter;
  reg                 bitTimer_tick;
  reg        [2:0]    bitCounter_value;
  reg        [6:0]    break_counter;
  wire                break_valid;
  reg        `UartCtrlRxState_defaultEncoding_type stateMachine_state;
  reg                 stateMachine_parity;
  reg        [7:0]    stateMachine_shifter;
  reg                 stateMachine_validReg;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  `endif


  assign _zz_2 = (stateMachine_parity == sampler_value);
  assign _zz_3 = (! sampler_value);
  assign _zz_4 = ((sampler_tick && (! sampler_value)) && (! break_valid));
  assign _zz_5 = (bitCounter_value == io_configFrame_dataLength);
  assign _zz_6 = ((io_configFrame_stop == `UartStopType_defaultEncoding_ONE) ? 1'b0 : 1'b1);
  assign _zz_7 = {2'd0, _zz_6};
  assign _zz_8 = ((((1'b0 || ((_zz_13 && sampler_samples_1) && sampler_samples_2)) || (((_zz_14 && sampler_samples_0) && sampler_samples_1) && sampler_samples_3)) || (((1'b1 && sampler_samples_0) && sampler_samples_2) && sampler_samples_3)) || (((1'b1 && sampler_samples_1) && sampler_samples_2) && sampler_samples_3));
  assign _zz_9 = (((1'b1 && sampler_samples_0) && sampler_samples_1) && sampler_samples_4);
  assign _zz_10 = ((1'b1 && sampler_samples_0) && sampler_samples_2);
  assign _zz_11 = (1'b1 && sampler_samples_1);
  assign _zz_12 = 1'b1;
  assign _zz_13 = (1'b1 && sampler_samples_0);
  assign _zz_14 = 1'b1;
  BufferCC io_rxd_buffercc (
    .io_dataIn     (io_rxd                      ), //i
    .io_dataOut    (io_rxd_buffercc_io_dataOut  ), //o
    .clk           (clk                         ), //i
    .reset         (reset                       )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      `UartStopType_defaultEncoding_ONE : io_configFrame_stop_string = "ONE";
      `UartStopType_defaultEncoding_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      `UartParityType_defaultEncoding_NONE : io_configFrame_parity_string = "NONE";
      `UartParityType_defaultEncoding_EVEN : io_configFrame_parity_string = "EVEN";
      `UartParityType_defaultEncoding_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      `UartCtrlRxState_defaultEncoding_IDLE : stateMachine_state_string = "IDLE  ";
      `UartCtrlRxState_defaultEncoding_START : stateMachine_state_string = "START ";
      `UartCtrlRxState_defaultEncoding_DATA : stateMachine_state_string = "DATA  ";
      `UartCtrlRxState_defaultEncoding_PARITY : stateMachine_state_string = "PARITY";
      `UartCtrlRxState_defaultEncoding_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  `endif

  always @ (*) begin
    io_error = 1'b0;
    case(stateMachine_state)
      `UartCtrlRxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlRxState_defaultEncoding_START : begin
      end
      `UartCtrlRxState_defaultEncoding_DATA : begin
      end
      `UartCtrlRxState_defaultEncoding_PARITY : begin
        if(bitTimer_tick)begin
          if(! _zz_2) begin
            io_error = 1'b1;
          end
        end
      end
      default : begin
        if(bitTimer_tick)begin
          if(_zz_3)begin
            io_error = 1'b1;
          end
        end
      end
    endcase
  end

  assign io_rts = _zz_1;
  assign sampler_synchroniser = io_rxd_buffercc_io_dataOut;
  assign sampler_samples_0 = sampler_synchroniser;
  always @ (*) begin
    bitTimer_tick = 1'b0;
    if(sampler_tick)begin
      if((bitTimer_counter == 3'b000))begin
        bitTimer_tick = 1'b1;
      end
    end
  end

  assign break_valid = (break_counter == 7'h68);
  assign io_break = break_valid;
  assign io_read_valid = stateMachine_validReg;
  assign io_read_payload = stateMachine_shifter;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      _zz_1 <= 1'b0;
      sampler_samples_1 <= 1'b1;
      sampler_samples_2 <= 1'b1;
      sampler_samples_3 <= 1'b1;
      sampler_samples_4 <= 1'b1;
      sampler_value <= 1'b1;
      sampler_tick <= 1'b0;
      break_counter <= 7'h0;
      stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
      stateMachine_validReg <= 1'b0;
    end else begin
      _zz_1 <= (! io_read_ready);
      if(io_samplingTick)begin
        sampler_samples_1 <= sampler_samples_0;
      end
      if(io_samplingTick)begin
        sampler_samples_2 <= sampler_samples_1;
      end
      if(io_samplingTick)begin
        sampler_samples_3 <= sampler_samples_2;
      end
      if(io_samplingTick)begin
        sampler_samples_4 <= sampler_samples_3;
      end
      sampler_value <= ((((((_zz_8 || _zz_9) || (_zz_10 && sampler_samples_4)) || ((_zz_11 && sampler_samples_2) && sampler_samples_4)) || (((_zz_12 && sampler_samples_0) && sampler_samples_3) && sampler_samples_4)) || (((1'b1 && sampler_samples_1) && sampler_samples_3) && sampler_samples_4)) || (((1'b1 && sampler_samples_2) && sampler_samples_3) && sampler_samples_4));
      sampler_tick <= io_samplingTick;
      if(sampler_value)begin
        break_counter <= 7'h0;
      end else begin
        if((io_samplingTick && (! break_valid)))begin
          break_counter <= (break_counter + 7'h01);
        end
      end
      stateMachine_validReg <= 1'b0;
      case(stateMachine_state)
        `UartCtrlRxState_defaultEncoding_IDLE : begin
          if(_zz_4)begin
            stateMachine_state <= `UartCtrlRxState_defaultEncoding_START;
          end
        end
        `UartCtrlRxState_defaultEncoding_START : begin
          if(bitTimer_tick)begin
            stateMachine_state <= `UartCtrlRxState_defaultEncoding_DATA;
            if((sampler_value == 1'b1))begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
            end
          end
        end
        `UartCtrlRxState_defaultEncoding_DATA : begin
          if(bitTimer_tick)begin
            if(_zz_5)begin
              if((io_configFrame_parity == `UartParityType_defaultEncoding_NONE))begin
                stateMachine_state <= `UartCtrlRxState_defaultEncoding_STOP;
                stateMachine_validReg <= 1'b1;
              end else begin
                stateMachine_state <= `UartCtrlRxState_defaultEncoding_PARITY;
              end
            end
          end
        end
        `UartCtrlRxState_defaultEncoding_PARITY : begin
          if(bitTimer_tick)begin
            if(_zz_2)begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_STOP;
              stateMachine_validReg <= 1'b1;
            end else begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
            end
          end
        end
        default : begin
          if(bitTimer_tick)begin
            if(_zz_3)begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
            end else begin
              if((bitCounter_value == _zz_7))begin
                stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
              end
            end
          end
        end
      endcase
    end
  end

  always @ (posedge clk) begin
    if(sampler_tick)begin
      bitTimer_counter <= (bitTimer_counter - 3'b001);
    end
    if(bitTimer_tick)begin
      bitCounter_value <= (bitCounter_value + 3'b001);
    end
    if(bitTimer_tick)begin
      stateMachine_parity <= (stateMachine_parity ^ sampler_value);
    end
    case(stateMachine_state)
      `UartCtrlRxState_defaultEncoding_IDLE : begin
        if(_zz_4)begin
          bitTimer_counter <= 3'b010;
        end
      end
      `UartCtrlRxState_defaultEncoding_START : begin
        if(bitTimer_tick)begin
          bitCounter_value <= 3'b000;
          stateMachine_parity <= (io_configFrame_parity == `UartParityType_defaultEncoding_ODD);
        end
      end
      `UartCtrlRxState_defaultEncoding_DATA : begin
        if(bitTimer_tick)begin
          stateMachine_shifter[bitCounter_value] <= sampler_value;
          if(_zz_5)begin
            bitCounter_value <= 3'b000;
          end
        end
      end
      `UartCtrlRxState_defaultEncoding_PARITY : begin
        if(bitTimer_tick)begin
          bitCounter_value <= 3'b000;
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module UartCtrlTx (
  input      [2:0]    io_configFrame_dataLength,
  input      `UartStopType_defaultEncoding_type io_configFrame_stop,
  input      `UartParityType_defaultEncoding_type io_configFrame_parity,
  input               io_samplingTick,
  input               io_write_valid,
  output reg          io_write_ready,
  input      [7:0]    io_write_payload,
  input               io_cts,
  output              io_txd,
  input               io_break,
  input               clk,
  input               reset
);
  wire                _zz_2;
  wire       [0:0]    _zz_3;
  wire       [2:0]    _zz_4;
  wire       [0:0]    _zz_5;
  wire       [2:0]    _zz_6;
  reg                 clockDivider_counter_willIncrement;
  wire                clockDivider_counter_willClear;
  reg        [2:0]    clockDivider_counter_valueNext;
  reg        [2:0]    clockDivider_counter_value;
  wire                clockDivider_counter_willOverflowIfInc;
  wire                clockDivider_counter_willOverflow;
  reg        [2:0]    tickCounter_value;
  reg        `UartCtrlTxState_defaultEncoding_type stateMachine_state;
  reg                 stateMachine_parity;
  reg                 stateMachine_txd;
  reg                 _zz_1;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  `endif


  assign _zz_2 = (tickCounter_value == io_configFrame_dataLength);
  assign _zz_3 = clockDivider_counter_willIncrement;
  assign _zz_4 = {2'd0, _zz_3};
  assign _zz_5 = ((io_configFrame_stop == `UartStopType_defaultEncoding_ONE) ? 1'b0 : 1'b1);
  assign _zz_6 = {2'd0, _zz_5};
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      `UartStopType_defaultEncoding_ONE : io_configFrame_stop_string = "ONE";
      `UartStopType_defaultEncoding_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      `UartParityType_defaultEncoding_NONE : io_configFrame_parity_string = "NONE";
      `UartParityType_defaultEncoding_EVEN : io_configFrame_parity_string = "EVEN";
      `UartParityType_defaultEncoding_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : stateMachine_state_string = "IDLE  ";
      `UartCtrlTxState_defaultEncoding_START : stateMachine_state_string = "START ";
      `UartCtrlTxState_defaultEncoding_DATA : stateMachine_state_string = "DATA  ";
      `UartCtrlTxState_defaultEncoding_PARITY : stateMachine_state_string = "PARITY";
      `UartCtrlTxState_defaultEncoding_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  `endif

  always @ (*) begin
    clockDivider_counter_willIncrement = 1'b0;
    if(io_samplingTick)begin
      clockDivider_counter_willIncrement = 1'b1;
    end
  end

  assign clockDivider_counter_willClear = 1'b0;
  assign clockDivider_counter_willOverflowIfInc = (clockDivider_counter_value == 3'b111);
  assign clockDivider_counter_willOverflow = (clockDivider_counter_willOverflowIfInc && clockDivider_counter_willIncrement);
  always @ (*) begin
    clockDivider_counter_valueNext = (clockDivider_counter_value + _zz_4);
    if(clockDivider_counter_willClear)begin
      clockDivider_counter_valueNext = 3'b000;
    end
  end

  always @ (*) begin
    stateMachine_txd = 1'b1;
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlTxState_defaultEncoding_START : begin
        stateMachine_txd = 1'b0;
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        stateMachine_txd = io_write_payload[tickCounter_value];
      end
      `UartCtrlTxState_defaultEncoding_PARITY : begin
        stateMachine_txd = stateMachine_parity;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_write_ready = io_break;
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlTxState_defaultEncoding_START : begin
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        if(clockDivider_counter_willOverflow)begin
          if(_zz_2)begin
            io_write_ready = 1'b1;
          end
        end
      end
      `UartCtrlTxState_defaultEncoding_PARITY : begin
      end
      default : begin
      end
    endcase
  end

  assign io_txd = _zz_1;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      clockDivider_counter_value <= 3'b000;
      stateMachine_state <= `UartCtrlTxState_defaultEncoding_IDLE;
      _zz_1 <= 1'b1;
    end else begin
      clockDivider_counter_value <= clockDivider_counter_valueNext;
      case(stateMachine_state)
        `UartCtrlTxState_defaultEncoding_IDLE : begin
          if(((io_write_valid && (! io_cts)) && clockDivider_counter_willOverflow))begin
            stateMachine_state <= `UartCtrlTxState_defaultEncoding_START;
          end
        end
        `UartCtrlTxState_defaultEncoding_START : begin
          if(clockDivider_counter_willOverflow)begin
            stateMachine_state <= `UartCtrlTxState_defaultEncoding_DATA;
          end
        end
        `UartCtrlTxState_defaultEncoding_DATA : begin
          if(clockDivider_counter_willOverflow)begin
            if(_zz_2)begin
              if((io_configFrame_parity == `UartParityType_defaultEncoding_NONE))begin
                stateMachine_state <= `UartCtrlTxState_defaultEncoding_STOP;
              end else begin
                stateMachine_state <= `UartCtrlTxState_defaultEncoding_PARITY;
              end
            end
          end
        end
        `UartCtrlTxState_defaultEncoding_PARITY : begin
          if(clockDivider_counter_willOverflow)begin
            stateMachine_state <= `UartCtrlTxState_defaultEncoding_STOP;
          end
        end
        default : begin
          if(clockDivider_counter_willOverflow)begin
            if((tickCounter_value == _zz_6))begin
              stateMachine_state <= (io_write_valid ? `UartCtrlTxState_defaultEncoding_START : `UartCtrlTxState_defaultEncoding_IDLE);
            end
          end
        end
      endcase
      _zz_1 <= (stateMachine_txd && (! io_break));
    end
  end

  always @ (posedge clk) begin
    if(clockDivider_counter_willOverflow)begin
      tickCounter_value <= (tickCounter_value + 3'b001);
    end
    if(clockDivider_counter_willOverflow)begin
      stateMachine_parity <= (stateMachine_parity ^ stateMachine_txd);
    end
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlTxState_defaultEncoding_START : begin
        if(clockDivider_counter_willOverflow)begin
          stateMachine_parity <= (io_configFrame_parity == `UartParityType_defaultEncoding_ODD);
          tickCounter_value <= 3'b000;
        end
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        if(clockDivider_counter_willOverflow)begin
          if(_zz_2)begin
            tickCounter_value <= 3'b000;
          end
        end
      end
      `UartCtrlTxState_defaultEncoding_PARITY : begin
        if(clockDivider_counter_willOverflow)begin
          tickCounter_value <= 3'b000;
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module BufferCC (
  input               io_dataIn,
  output              io_dataOut,
  input               clk,
  input               reset
);
  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      buffers_0 <= 1'b0;
      buffers_1 <= 1'b0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule
