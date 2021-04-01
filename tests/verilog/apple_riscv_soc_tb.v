module apple_riscv_soc_tb();

reg clk;
reg reset;

apple_riscv_soc DUT_apple_riscv_soc(.*);

initial begin
  integer idx = 0;
  $dumpfile ("DUT_apple_riscv_soc.vcd");
  $dumpvars (0, DUT_apple_riscv_soc);
  //for (idx = 0; idx < 32; idx = idx + 1)
  //  $dumpvars(0, DUT_apple_riscv_soc.cpu_core.register_file_inst.rs1_ram[idx]);
end

endmodule

