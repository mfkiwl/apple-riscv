module apple_riscv_soc_tb ();

parameter DATA_RAM_ADDR_WIDTH = 12;
parameter DATA_RAM_SIZE = 1 << (DATA_RAM_ADDR_WIDTH);
parameter INSTR_RAM_ADDR_WIDTH = 12;
parameter INSTR_RAM_SIZE = 1 << (INSTR_RAM_ADDR_WIDTH);

reg clk;
reg reset;
reg [7:0] data_ram [0:DATA_RAM_SIZE-1];
reg [7:0] instr_ram [0:DATA_RAM_SIZE-1];

integer im = 0;
integer dm = 0;

apple_riscv_soc DUT_apple_riscv_soc(.*);

`ifdef COCOTB_SIM
initial begin
  $dumpfile ("DUT_apple_riscv_soc.vcd");
  $dumpvars (0, DUT_apple_riscv_soc);
end
`endif

`ifdef LOAD_INSTR_RAM
initial begin
  $display("Loading instruction ram verilog file");
  $readmemh("instr_ram.rom", instr_ram);
  $display("[INFO] Loading Instruction RAM Done");
  for (im = 0; im < INSTR_RAM_SIZE; im = im + 4) begin
    DUT_apple_riscv_soc.imem_inst.ram[im/4] = {instr_ram[im+3], instr_ram[im+2],instr_ram[im+1],instr_ram[im]};
  end
end
`endif

`ifdef LOAD_DATA_RAM
initial begin
  $display("Loading Data ram verilog file");
  $readmemh("data_ram.rom", data_ram);
  for (dm = 0; dm < DATA_RAM_SIZE; dm = dm + 4) begin
    DUT_apple_riscv_soc.dmem_inst.ram_symbol3[dm/4] = data_ram[dm+3];
    DUT_apple_riscv_soc.dmem_inst.ram_symbol2[dm/4] = data_ram[dm+2];
    DUT_apple_riscv_soc.dmem_inst.ram_symbol1[dm/4] = data_ram[dm+1];
    DUT_apple_riscv_soc.dmem_inst.ram_symbol0[dm/4] = data_ram[dm];
  end
  $display("[INFO] Loading Data RAM Done");
  //for (dm = 0; dm < 20; dm = dm + 1) begin
  //  $dumpvars(0, data_ram[dm]);
  //end
end
`endif

  reg      [15:0]   imem_dbg_sib_addr      = 'b0;
  reg               imem_dbg_sib_sel       = 'b0;
  reg               imem_dbg_sib_enable    = 'b0;
  reg               imem_dbg_sib_write     = 'b0;
  reg      [31:0]   imem_dbg_sib_wdata     = 'b0;
  reg      [3:0]    imem_dbg_sib_mask      = 'b0;
  wire     [31:0]   imem_dbg_sib_rdata;
  wire              imem_dbg_sib_ready;
  wire              imem_dbg_sib_resp;

  wire     [31:0]   gpio0_port_gpio;
  wire     [31:0]   gpio1_port_gpio;
  wire              uart_port_txd;
  reg               uart_port_rxd = 'b0;

endmodule

