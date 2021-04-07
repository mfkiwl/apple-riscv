module apple_riscv_soc_tb ();

reg clk;
reg reset;
reg [8*100: 1] INSTR_RAM_FILE = 0;

apple_riscv_soc DUT_apple_riscv_soc(.*);

`ifdef COCOTB_SIM
initial begin
  integer instr_ram_idx = 0;
  $dumpfile ("DUT_apple_riscv_soc.vcd");
  $dumpvars (0, DUT_apple_riscv_soc);
  `ifdef DUMP_INSTR_RAM
    for (instr_ram_idx = 0; instr_ram_idx < 10; instr_ram_idx = instr_ram_idx + 1) begin
      $dumpvars(0, DUT_apple_riscv_soc.instruction_ram.ram[instr_ram_idx]);
    end
  `endif
end
`endif

`ifdef LOAD_INSTR_RAM

initial begin
  INSTR_RAM_FILE = "instr_ram.rom";
  $display("Loading instruction ram verilog file");
  $readmemh(INSTR_RAM_FILE, DUT_apple_riscv_soc.instruction_ram.ram);
  $display("[INFO] Loading Instruction RAM Done");
end

`endif

endmodule

