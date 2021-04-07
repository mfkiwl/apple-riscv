// Generator : SpinalHDL v1.4.3    git head : adf552d8f500e7419fff395b7049228e4bc5de26
// Component : apple_riscv_soc
// Git hash  : 9dddf5c8472c83861e8e36ebf9cc304d8d0e0e4a



module apple_riscv_soc (
  input               clk,
  input               reset
);
  wire                cpu_core_io_instr_ram_wr;
  wire                cpu_core_io_instr_ram_rd;
  wire       [19:0]   cpu_core_io_instr_ram_addr;
  wire                cpu_core_io_instr_ram_enable;
  wire       [31:0]   cpu_core_io_instr_ram_data_out;
  wire                cpu_core_io_data_ram_wr;
  wire                cpu_core_io_data_ram_rd;
  wire       [19:0]   cpu_core_io_data_ram_addr;
  wire       [31:0]   cpu_core_io_data_ram_data_out;
  wire       [3:0]    cpu_core_io_data_ram_byte_en;
  wire       [31:0]   instruction_ram_io_data_out;
  wire       [31:0]   data_ram_io_data_out;

  apple_riscv cpu_core (
    .io_instr_ram_wr          (cpu_core_io_instr_ram_wr              ), //o
    .io_instr_ram_rd          (cpu_core_io_instr_ram_rd              ), //o
    .io_instr_ram_addr        (cpu_core_io_instr_ram_addr[19:0]      ), //o
    .io_instr_ram_enable      (cpu_core_io_instr_ram_enable          ), //o
    .io_instr_ram_data_out    (cpu_core_io_instr_ram_data_out[31:0]  ), //o
    .io_instr_ram_data_in     (instruction_ram_io_data_out[31:0]     ), //i
    .io_data_ram_wr           (cpu_core_io_data_ram_wr               ), //o
    .io_data_ram_rd           (cpu_core_io_data_ram_rd               ), //o
    .io_data_ram_addr         (cpu_core_io_data_ram_addr[19:0]       ), //o
    .io_data_ram_data_out     (cpu_core_io_data_ram_data_out[31:0]   ), //o
    .io_data_ram_byte_en      (cpu_core_io_data_ram_byte_en[3:0]     ), //o
    .io_data_ram_data_in      (data_ram_io_data_out[31:0]            ), //i
    .clk                      (clk                                   ), //i
    .reset                    (reset                                 )  //i
  );
  instruction_ram_model instruction_ram (
    .io_wr          (cpu_core_io_instr_ram_wr              ), //i
    .io_rd          (cpu_core_io_instr_ram_rd              ), //i
    .io_enable      (cpu_core_io_instr_ram_enable          ), //i
    .io_addr        (cpu_core_io_instr_ram_addr[19:0]      ), //i
    .io_data_out    (instruction_ram_io_data_out[31:0]     ), //o
    .io_data_in     (cpu_core_io_instr_ram_data_out[31:0]  ), //i
    .clk            (clk                                   ), //i
    .reset          (reset                                 )  //i
  );
  data_ram_model data_ram (
    .io_wr          (cpu_core_io_data_ram_wr              ), //i
    .io_rd          (cpu_core_io_data_ram_rd              ), //i
    .io_addr        (cpu_core_io_data_ram_addr[19:0]      ), //i
    .io_byte_en     (cpu_core_io_data_ram_byte_en[3:0]    ), //i
    .io_data_out    (data_ram_io_data_out[31:0]           ), //o
    .io_data_in     (cpu_core_io_data_ram_data_out[31:0]  ), //i
    .clk            (clk                                  ), //i
    .reset          (reset                                )  //i
  );

endmodule

module data_ram_model (
  input               io_wr,
  input               io_rd,
  input      [19:0]   io_addr,
  input      [3:0]    io_byte_en,
  output     [31:0]   io_data_out,
  input      [31:0]   io_data_in,
  input               clk,
  input               reset
);
  reg        [31:0]   _zz_1;
  wire       [17:0]   ram_addr;
  reg [7:0] ram_symbol0 [0:262143];
  reg [7:0] ram_symbol1 [0:262143];
  reg [7:0] ram_symbol2 [0:262143];
  reg [7:0] ram_symbol3 [0:262143];
  reg [7:0] _zz_2;
  reg [7:0] _zz_3;
  reg [7:0] _zz_4;
  reg [7:0] _zz_5;

  always @ (*) begin
    _zz_1 = {_zz_5, _zz_4, _zz_3, _zz_2};
  end
  always @ (posedge clk) begin
    if(io_byte_en[0] && io_wr) begin
      ram_symbol0[ram_addr] <= io_data_in[7 : 0];
    end
    if(io_byte_en[1] && io_wr) begin
      ram_symbol1[ram_addr] <= io_data_in[15 : 8];
    end
    if(io_byte_en[2] && io_wr) begin
      ram_symbol2[ram_addr] <= io_data_in[23 : 16];
    end
    if(io_byte_en[3] && io_wr) begin
      ram_symbol3[ram_addr] <= io_data_in[31 : 24];
    end
  end

  always @ (posedge clk) begin
    if(io_rd) begin
      _zz_2 <= ram_symbol0[ram_addr];
      _zz_3 <= ram_symbol1[ram_addr];
      _zz_4 <= ram_symbol2[ram_addr];
      _zz_5 <= ram_symbol3[ram_addr];
    end
  end

  assign ram_addr = io_addr[19 : 2];
  assign io_data_out = _zz_1;

endmodule

module instruction_ram_model (
  input               io_wr,
  input               io_rd,
  input               io_enable,
  input      [19:0]   io_addr,
  output     [31:0]   io_data_out,
  input      [31:0]   io_data_in,
  input               clk,
  input               reset
);
  reg        [31:0]   _zz_2;
  wire                _zz_3;
  wire       [17:0]   ram_addr;
  wire                _zz_1;
  reg [31:0] ram [0:262143];

  assign _zz_3 = (io_wr && io_enable);
  always @ (posedge clk) begin
    if(_zz_3) begin
      ram[ram_addr] <= io_data_in;
    end
  end

  always @ (posedge clk) begin
    if(_zz_1) begin
      _zz_2 <= ram[ram_addr];
    end
  end

  assign ram_addr = io_addr[19 : 2];
  assign _zz_1 = (io_rd && io_enable);
  assign io_data_out = _zz_2;

endmodule

module apple_riscv (
  output              io_instr_ram_wr,
  output              io_instr_ram_rd,
  output     [19:0]   io_instr_ram_addr,
  output              io_instr_ram_enable,
  output     [31:0]   io_instr_ram_data_out,
  input      [31:0]   io_instr_ram_data_in,
  output              io_data_ram_wr,
  output              io_data_ram_rd,
  output     [19:0]   io_data_ram_addr,
  output     [31:0]   io_data_ram_data_out,
  output     [3:0]    io_data_ram_byte_en,
  input      [31:0]   io_data_ram_data_in,
  input               clk,
  input               reset
);
  wire                _zz_1;
  wire       [19:0]   _zz_2;
  wire                _zz_3;
  wire       [31:0]   pc_inst_io_pc_out;
  wire       [4:0]    instr_dec_inst_io_rd_idx;
  wire       [2:0]    instr_dec_inst_io_func3;
  wire       [4:0]    instr_dec_inst_io_rs1_idx;
  wire       [4:0]    instr_dec_inst_io_rs2_idx;
  wire       [6:0]    instr_dec_inst_io_func7;
  wire       [31:0]   instr_dec_inst_io_imm_value;
  wire       [20:0]   instr_dec_inst_io_brjp_imm_value;
  wire                instr_dec_inst_io_register_wr;
  wire                instr_dec_inst_io_register_rs1_rd;
  wire                instr_dec_inst_io_register_rs2_rd;
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
  wire                instr_dec_inst_io_op2_sel_imm;
  wire                instr_dec_inst_io_op1_sel_pc;
  wire                instr_dec_inst_io_op1_sel_zero;
  wire                instr_dec_inst_io_branch_op;
  wire                instr_dec_inst_io_jal_op;
  wire                instr_dec_inst_io_jalr_op;
  wire       [31:0]   regfile_inst_io_rs1_data_out;
  wire       [31:0]   regfile_inst_io_rs2_data_out;
  wire       [31:0]   alu_inst_io_alu_out;
  wire       [31:0]   branch_unit_inst_io_target_pc;
  wire                branch_unit_inst_io_branch_taken;
  wire                branch_unit_inst_io_instruction_address_misaligned_exception;
  wire       [31:0]   dram_ctrl_isnt_io_mc2cpu_data;
  wire                dram_ctrl_isnt_io_mc2mem_wr;
  wire                dram_ctrl_isnt_io_mc2mem_rd;
  wire       [19:0]   dram_ctrl_isnt_io_mc2mem_addr;
  wire       [31:0]   dram_ctrl_isnt_io_mc2mem_data;
  wire       [3:0]    dram_ctrl_isnt_io_mc2mem_byte_enable;
  wire                if_instr_valid;
  reg                 id_instr_valid;
  wire                ex_instr_valid;
  wire                mem_instr_valid;
  wire                wb_instr_valid;
  reg                 if_pipe_stall;
  reg                 id_pipe_stall;
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
  reg                 id2ex_register_wr;
  reg                 id2ex_data_ram_wr;
  reg                 id2ex_data_ram_rd;
  reg                 id2ex_register_rs1_rd;
  reg                 id2ex_register_rs2_rd;
  reg                 id2ex_branch_op;
  reg                 id2ex_jal_op;
  reg                 id2ex_jalr_op;
  reg        [4:0]    id2ex_rd;
  reg        [2:0]    id2ex_func3;
  reg        [4:0]    id2ex_rs1;
  reg        [4:0]    id2ex_rs2;
  reg        [6:0]    id2ex_func7;
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
  reg        [31:0]   ex_rs1_value_forwarded;
  reg        [31:0]   ex_rs2_value_forwarded;
  wire       [31:0]   alu_operand1_muxout;
  wire       [31:0]   alu_operand2_muxout;
  reg                 ex2mem_instr_valid;
  reg                 ex2mem_register_wr;
  reg                 ex2mem_data_ram_wr;
  reg                 ex2mem_data_ram_rd;
  reg                 ex2mem_data_ram_ld_byte;
  reg                 ex2mem_data_ram_ld_hword;
  reg                 ex2mem_data_ram_ld_unsign;
  reg        [31:0]   ex2mem_alu_out;
  reg        [4:0]    ex2mem_rs1;
  reg        [4:0]    ex2mem_rs2;
  reg        [4:0]    ex2mem_rd;
  reg        [31:0]   ex2mem_rs2_value;
  reg                 mem2wb_instr_valid;
  reg                 mem2wb_register_wr;
  reg                 mem2wb_data_ram_rd;
  reg        [31:0]   mem2wb_alu_out;
  reg        [4:0]    mem2wb_rd;
  wire       [31:0]   wb_rd_wr_data;
  wire                rs1_nonzero;
  wire                rs1_match_mem;
  wire                rs1_match_wb;
  wire                forward_rs1_from_mem;
  wire                forward_rs1_from_wb;
  wire                rs2_nonzero;
  wire                rs2_match_mem;
  wire                rs2_match_wb;
  wire                forward_rs2_from_mem;
  wire                forward_rs2_from_wb;
  wire                id_rs1_depends_on_ex_rd;
  wire                id_rs2_depends_on_ex_rd;
  wire                stall_on_load_dependence;

  program_counter pc_inst (
    .io_pc_in     (target_pc[31:0]          ), //i
    .io_branch    (branch_taken             ), //i
    .io_stall     (if_pipe_stall            ), //i
    .io_pc_out    (pc_inst_io_pc_out[31:0]  ), //o
    .clk          (clk                      ), //i
    .reset        (reset                    )  //i
  );
  instr_dec instr_dec_inst (
    .io_instr                 (io_instr_ram_data_in[31:0]              ), //i
    .io_rd_idx                (instr_dec_inst_io_rd_idx[4:0]           ), //o
    .io_func3                 (instr_dec_inst_io_func3[2:0]            ), //o
    .io_rs1_idx               (instr_dec_inst_io_rs1_idx[4:0]          ), //o
    .io_rs2_idx               (instr_dec_inst_io_rs2_idx[4:0]          ), //o
    .io_func7                 (instr_dec_inst_io_func7[6:0]            ), //o
    .io_imm_value             (instr_dec_inst_io_imm_value[31:0]       ), //o
    .io_brjp_imm_value        (instr_dec_inst_io_brjp_imm_value[20:0]  ), //o
    .io_register_wr           (instr_dec_inst_io_register_wr           ), //o
    .io_register_rs1_rd       (instr_dec_inst_io_register_rs1_rd       ), //o
    .io_register_rs2_rd       (instr_dec_inst_io_register_rs2_rd       ), //o
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
    .io_op2_sel_imm           (instr_dec_inst_io_op2_sel_imm           ), //o
    .io_op1_sel_pc            (instr_dec_inst_io_op1_sel_pc            ), //o
    .io_op1_sel_zero          (instr_dec_inst_io_op1_sel_zero          ), //o
    .io_branch_op             (instr_dec_inst_io_branch_op             ), //o
    .io_jal_op                (instr_dec_inst_io_jal_op                ), //o
    .io_jalr_op               (instr_dec_inst_io_jalr_op               )  //o
  );
  regfile regfile_inst (
    .io_rs1_rd_addr         (instr_dec_inst_io_rs1_idx[4:0]      ), //i
    .io_rs1_data_out        (regfile_inst_io_rs1_data_out[31:0]  ), //o
    .io_rs2_rd_addr         (instr_dec_inst_io_rs2_idx[4:0]      ), //i
    .io_rs2_data_out        (regfile_inst_io_rs2_data_out[31:0]  ), //o
    .io_register_wr         (mem2wb_register_wr                  ), //i
    .io_register_wr_addr    (mem2wb_rd[4:0]                      ), //i
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
    .io_branch_result                               (_zz_1                                                         ), //i
    .io_current_pc                                  (id2ex_pc[31:0]                                                ), //i
    .io_imm_value                                   (id2ex_brjp_imm_value[20:0]                                    ), //i
    .io_rs1_value                                   (ex_rs1_value_forwarded[31:0]                                  ), //i
    .io_br_op                                       (id2ex_branch_op                                               ), //i
    .io_jal_op                                      (id2ex_jal_op                                                  ), //i
    .io_jalr_op                                     (id2ex_jalr_op                                                 ), //i
    .io_target_pc                                   (branch_unit_inst_io_target_pc[31:0]                           ), //o
    .io_branch_taken                                (branch_unit_inst_io_branch_taken                              ), //o
    .io_instruction_address_misaligned_exception    (branch_unit_inst_io_instruction_address_misaligned_exception  )  //o
  );
  dram_ctrl dram_ctrl_isnt (
    .io_cpu2mc_wr                 (ex2mem_data_ram_wr                         ), //i
    .io_cpu2mc_rd                 (ex2mem_data_ram_rd                         ), //i
    .io_cpu2mc_addr               (_zz_2[19:0]                                ), //i
    .io_cpu2mc_data               (ex2mem_rs2_value[31:0]                     ), //i
    .io_mc2cpu_data               (dram_ctrl_isnt_io_mc2cpu_data[31:0]        ), //o
    .io_cpu2mc_mem_LS_byte        (ex2mem_data_ram_ld_byte                    ), //i
    .io_cpu2mc_mem_LS_halfword    (ex2mem_data_ram_ld_hword                   ), //i
    .io_cpu2mc_mem_LW_unsigned    (ex2mem_data_ram_ld_unsign                  ), //i
    .io_mc2mem_wr                 (dram_ctrl_isnt_io_mc2mem_wr                ), //o
    .io_mc2mem_rd                 (dram_ctrl_isnt_io_mc2mem_rd                ), //o
    .io_mc2mem_addr               (dram_ctrl_isnt_io_mc2mem_addr[19:0]        ), //o
    .io_mem2mc_data               (io_data_ram_data_in[31:0]                  ), //i
    .io_mem2mc_data_vld           (_zz_3                                      ), //i
    .io_mc2mem_data               (dram_ctrl_isnt_io_mc2mem_data[31:0]        ), //o
    .io_mc2mem_byte_enable        (dram_ctrl_isnt_io_mc2mem_byte_enable[3:0]  ), //o
    .clk                          (clk                                        ), //i
    .reset                        (reset                                      )  //i
  );
  assign ex_pipe_stall = 1'b0;
  assign mem_pipe_stall = 1'b0;
  assign wb_pipe_stall = 1'b0;
  assign if_pipe_run = (! if_pipe_stall);
  assign id_pipe_run = (! id_pipe_stall);
  assign ex_pipe_run = (! ex_pipe_stall);
  assign mem_pipe_run = (! mem_pipe_stall);
  assign wb_pipe_run = (! wb_pipe_stall);
  assign io_instr_ram_wr = 1'b0;
  assign io_instr_ram_rd = 1'b1;
  assign io_instr_ram_enable = if_pipe_run;
  assign io_instr_ram_addr = pc_inst_io_pc_out[19 : 0];
  assign io_instr_ram_data_out = 32'h0;
  assign alu_operand1_muxout = (id2ex_op1_sel_zero ? 32'h0 : (id2ex_op1_sel_pc ? id2ex_pc : ex_rs1_value_forwarded));
  assign alu_operand2_muxout = (id2ex_op2_sel_imm ? id2ex_imm_value : ex_rs2_value_forwarded);
  assign _zz_1 = alu_inst_io_alu_out[0];
  assign target_pc = branch_unit_inst_io_target_pc;
  assign branch_taken = branch_unit_inst_io_branch_taken;
  assign _zz_2 = ex2mem_alu_out[19 : 0];
  assign io_data_ram_wr = dram_ctrl_isnt_io_mc2mem_wr;
  assign io_data_ram_rd = dram_ctrl_isnt_io_mc2mem_rd;
  assign io_data_ram_addr = dram_ctrl_isnt_io_mc2mem_addr;
  assign io_data_ram_data_out = dram_ctrl_isnt_io_mc2mem_data;
  assign io_data_ram_byte_en = dram_ctrl_isnt_io_mc2mem_byte_enable;
  assign wb_rd_wr_data = (mem2wb_data_ram_rd ? dram_ctrl_isnt_io_mc2cpu_data : mem2wb_alu_out);
  assign rs1_nonzero = (id2ex_rs1 != 5'h0);
  assign rs1_match_mem = ((id2ex_rs1 == ex2mem_rd) && rs1_nonzero);
  assign rs1_match_wb = ((id2ex_rs1 == mem2wb_rd) && rs1_nonzero);
  assign forward_rs1_from_mem = ((id2ex_register_rs1_rd && rs1_match_mem) && ex2mem_register_wr);
  assign forward_rs1_from_wb = ((id2ex_register_rs1_rd && rs1_match_wb) && mem2wb_register_wr);
  always @ (*) begin
    if(forward_rs1_from_mem)begin
      ex_rs1_value_forwarded = ex2mem_alu_out;
    end else begin
      if(forward_rs1_from_wb)begin
        ex_rs1_value_forwarded = wb_rd_wr_data;
      end else begin
        ex_rs1_value_forwarded = id2ex_rs1_value;
      end
    end
  end

  assign rs2_nonzero = (id2ex_rs2 != 5'h0);
  assign rs2_match_mem = ((id2ex_rs2 == ex2mem_rd) && rs2_nonzero);
  assign rs2_match_wb = ((id2ex_rs2 == mem2wb_rd) && rs2_nonzero);
  assign forward_rs2_from_mem = ((id2ex_register_rs2_rd && rs2_match_mem) && ex2mem_register_wr);
  assign forward_rs2_from_wb = ((id2ex_register_rs2_rd && rs2_match_wb) && mem2wb_register_wr);
  always @ (*) begin
    if(forward_rs2_from_mem)begin
      ex_rs2_value_forwarded = ex2mem_alu_out;
    end else begin
      if(forward_rs2_from_wb)begin
        ex_rs2_value_forwarded = wb_rd_wr_data;
      end else begin
        ex_rs2_value_forwarded = id2ex_rs2_value;
      end
    end
  end

  assign if_instr_valid = (! branch_taken);
  assign ex_instr_valid = id2ex_instr_valid;
  assign mem_instr_valid = ex2mem_instr_valid;
  assign wb_instr_valid = mem2wb_instr_valid;
  assign id_rs1_depends_on_ex_rd = ((instr_dec_inst_io_rs1_idx == id2ex_rd) && instr_dec_inst_io_register_rs1_rd);
  assign id_rs2_depends_on_ex_rd = ((instr_dec_inst_io_rs2_idx == id2ex_rd) && instr_dec_inst_io_register_rs2_rd);
  assign stall_on_load_dependence = ((id_rs1_depends_on_ex_rd || id_rs2_depends_on_ex_rd) && id2ex_data_ram_rd);
  always @ (*) begin
    if(stall_on_load_dependence)begin
      if_pipe_stall = 1'b1;
    end else begin
      if_pipe_stall = 1'b0;
    end
  end

  always @ (*) begin
    if(stall_on_load_dependence)begin
      id_pipe_stall = 1'b1;
    end else begin
      id_pipe_stall = 1'b0;
    end
  end

  always @ (*) begin
    if(stall_on_load_dependence)begin
      id_instr_valid = 1'b0;
    end else begin
      id_instr_valid = (if2id_instr_valid && (! branch_taken));
    end
  end

  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      if2id_pc <= 32'h0;
      if2id_instr_valid <= 1'b0;
      id2ex_instr_valid <= 1'b0;
      id2ex_register_wr <= 1'b0;
      id2ex_data_ram_wr <= 1'b0;
      id2ex_data_ram_rd <= 1'b0;
      id2ex_register_rs1_rd <= 1'b0;
      id2ex_register_rs2_rd <= 1'b0;
      id2ex_branch_op <= 1'b0;
      id2ex_jal_op <= 1'b0;
      id2ex_jalr_op <= 1'b0;
      ex2mem_instr_valid <= 1'b0;
      ex2mem_register_wr <= 1'b0;
      ex2mem_data_ram_wr <= 1'b0;
      ex2mem_data_ram_rd <= 1'b0;
      mem2wb_instr_valid <= 1'b0;
      mem2wb_register_wr <= 1'b0;
      mem2wb_data_ram_rd <= 1'b0;
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
        id2ex_register_wr <= (instr_dec_inst_io_register_wr && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_data_ram_wr <= (instr_dec_inst_io_data_ram_wr && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_data_ram_rd <= (instr_dec_inst_io_data_ram_rd && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_register_rs1_rd <= (instr_dec_inst_io_register_rs1_rd && id_instr_valid);
      end
      if(ex_pipe_run)begin
        id2ex_register_rs2_rd <= (instr_dec_inst_io_register_rs2_rd && id_instr_valid);
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
      if(mem_pipe_run)begin
        ex2mem_instr_valid <= ex_instr_valid;
      end
      if(mem_pipe_run)begin
        ex2mem_register_wr <= (id2ex_register_wr && ex_instr_valid);
      end
      if(mem_pipe_run)begin
        ex2mem_data_ram_wr <= (id2ex_data_ram_wr && ex_instr_valid);
      end
      if(mem_pipe_run)begin
        ex2mem_data_ram_rd <= (id2ex_data_ram_rd && ex_instr_valid);
      end
      if(wb_pipe_run)begin
        mem2wb_instr_valid <= mem_instr_valid;
      end
      if(wb_pipe_run)begin
        mem2wb_register_wr <= (ex2mem_register_wr && mem_instr_valid);
      end
      if(wb_pipe_run)begin
        mem2wb_data_ram_rd <= (ex2mem_data_ram_rd && mem_instr_valid);
      end
    end
  end

  always @ (posedge clk) begin
    if(ex_pipe_run)begin
      id2ex_rd <= instr_dec_inst_io_rd_idx;
    end
    if(ex_pipe_run)begin
      id2ex_func3 <= instr_dec_inst_io_func3;
    end
    if(ex_pipe_run)begin
      id2ex_rs1 <= instr_dec_inst_io_rs1_idx;
    end
    if(ex_pipe_run)begin
      id2ex_rs2 <= instr_dec_inst_io_rs2_idx;
    end
    if(ex_pipe_run)begin
      id2ex_func7 <= instr_dec_inst_io_func7;
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
      id2ex_brjp_imm_value <= instr_dec_inst_io_brjp_imm_value;
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
    if(mem_pipe_run)begin
      ex2mem_data_ram_ld_byte <= (id2ex_data_ram_ld_byte && ex_instr_valid);
    end
    if(mem_pipe_run)begin
      ex2mem_data_ram_ld_hword <= (id2ex_data_ram_ld_hword && ex_instr_valid);
    end
    if(mem_pipe_run)begin
      ex2mem_data_ram_ld_unsign <= (id2ex_data_ram_ld_unsign && ex_instr_valid);
    end
    if(mem_pipe_run)begin
      ex2mem_alu_out <= alu_inst_io_alu_out;
    end
    if(mem_pipe_run)begin
      ex2mem_rs1 <= id2ex_rs1;
    end
    if(mem_pipe_run)begin
      ex2mem_rs2 <= id2ex_rs2;
    end
    if(mem_pipe_run)begin
      ex2mem_rd <= id2ex_rd;
    end
    if(mem_pipe_run)begin
      ex2mem_rs2_value <= ex_rs2_value_forwarded;
    end
    if(wb_pipe_run)begin
      mem2wb_alu_out <= ex2mem_alu_out;
    end
    if(wb_pipe_run)begin
      mem2wb_rd <= ex2mem_rd;
    end
  end


endmodule

module dram_ctrl (
  input               io_cpu2mc_wr,
  input               io_cpu2mc_rd,
  input      [19:0]   io_cpu2mc_addr,
  input      [31:0]   io_cpu2mc_data,
  output reg [31:0]   io_mc2cpu_data,
  input               io_cpu2mc_mem_LS_byte,
  input               io_cpu2mc_mem_LS_halfword,
  input               io_cpu2mc_mem_LW_unsigned,
  output              io_mc2mem_wr,
  output              io_mc2mem_rd,
  output reg [19:0]   io_mc2mem_addr,
  input      [31:0]   io_mem2mc_data,
  input               io_mem2mc_data_vld,
  output reg [31:0]   io_mc2mem_data,
  output reg [3:0]    io_mc2mem_byte_enable,
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
  assign mem2mc_data_byte0 = io_mem2mc_data[7 : 0];
  assign mem2mc_data_byte1 = io_mem2mc_data[15 : 8];
  assign mem2mc_data_byte2 = io_mem2mc_data[23 : 16];
  assign mem2mc_data_byte3 = io_mem2mc_data[31 : 24];
  assign mem2mc_data_hw0 = io_mem2mc_data[15 : 0];
  assign mem2mc_data_hw1 = io_mem2mc_data[31 : 16];
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
    io_mc2mem_data = io_cpu2mc_data;
    if(io_cpu2mc_mem_LS_byte)begin
      case(mem_byte_addr)
        2'b00 : begin
          io_mc2mem_data[7 : 0] = cpu2mc_data_7_0;
        end
        2'b01 : begin
          io_mc2mem_data[15 : 8] = cpu2mc_data_7_0;
        end
        2'b10 : begin
          io_mc2mem_data[23 : 16] = cpu2mc_data_7_0;
        end
        default : begin
          io_mc2mem_data[31 : 24] = cpu2mc_data_7_0;
        end
      endcase
    end else begin
      if(io_cpu2mc_mem_LS_halfword)begin
        case(mem_byte_addr)
          2'b00 : begin
            io_mc2mem_data[15 : 0] = cpu2mc_data_15_0;
          end
          2'b10 : begin
            io_mc2mem_data[31 : 16] = cpu2mc_data_15_0;
          end
          default : begin
          end
        endcase
      end
    end
  end

  always @ (*) begin
    io_mc2cpu_data = io_mem2mc_data;
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

  always @ (*) begin
    io_mc2mem_byte_enable = 4'b1111;
    if(io_cpu2mc_mem_LS_byte)begin
      case(mem_byte_addr)
        2'b00 : begin
          io_mc2mem_byte_enable = 4'b0001;
        end
        2'b01 : begin
          io_mc2mem_byte_enable = 4'b0010;
        end
        2'b10 : begin
          io_mc2mem_byte_enable = 4'b0100;
        end
        default : begin
          io_mc2mem_byte_enable = 4'b1000;
        end
      endcase
    end else begin
      if(io_cpu2mc_mem_LS_halfword)begin
        case(mem_byte_addr)
          2'b00 : begin
            io_mc2mem_byte_enable = 4'b0011;
          end
          2'b10 : begin
            io_mc2mem_byte_enable = 4'b1100;
          end
          default : begin
          end
        endcase
      end
    end
  end

  always @ (*) begin
    io_mc2mem_addr = io_cpu2mc_addr;
    io_mc2mem_addr[1 : 0] = 2'b00;
  end

  assign io_mc2mem_rd = io_cpu2mc_rd;
  assign io_mc2mem_wr = io_cpu2mc_wr;
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
  output              io_instruction_address_misaligned_exception
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
  assign io_instruction_address_misaligned_exception = (io_branch_taken && (pc_1_0 != 2'b00));

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
  (* ram_style = "distributed" *) reg [31:0] rs1_ram [0:31];
  (* ram_style = "distributed" *) reg [31:0] rs2_ram [0:31];

  always @ (posedge clk) begin
    if(io_register_wr) begin
      rs1_ram[io_register_wr_addr] <= io_rd_in;
    end
  end

  assign _zz_1 = rs1_ram[io_rs1_rd_addr];
  always @ (posedge clk) begin
    if(io_register_wr) begin
      rs2_ram[io_register_wr_addr] <= io_rd_in;
    end
  end

  assign _zz_2 = rs2_ram[io_rs2_rd_addr];
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
  output     [4:0]    io_rd_idx,
  output     [2:0]    io_func3,
  output     [4:0]    io_rs1_idx,
  output     [4:0]    io_rs2_idx,
  output     [6:0]    io_func7,
  output reg [31:0]   io_imm_value,
  output reg [20:0]   io_brjp_imm_value,
  output              io_register_wr,
  output              io_register_rs1_rd,
  output              io_register_rs2_rd,
  output              io_data_ram_wr,
  output              io_data_ram_rd,
  output              io_data_ram_ld_byte,
  output              io_data_ram_ld_hword,
  output              io_data_ram_ld_unsign,
  output              io_alu_op_and,
  output              io_alu_op_or,
  output              io_alu_op_xor,
  output              io_alu_op_add,
  output              io_alu_op_sub,
  output              io_alu_op_sra,
  output              io_alu_op_srl,
  output              io_alu_op_sll,
  output              io_alu_op_slt,
  output              io_alu_op_sltu,
  output              io_alu_op_eqt,
  output              io_alu_op_invb0,
  output              io_op2_sel_imm,
  output              io_op1_sel_pc,
  output              io_op1_sel_zero,
  output              io_branch_op,
  output              io_jal_op,
  output              io_jalr_op
);
  wire       [11:0]   _zz_1;
  wire       [11:0]   _zz_2;
  wire       [12:0]   _zz_3;
  wire       [11:0]   _zz_4;
  wire       [6:0]    opcode;
  wire                op_logic_arithm;
  wire                op_logic_arithm_imm;
  wire                op_store;
  wire                op_load;
  wire                op_branch;
  wire                op_lui;
  wire                op_auipc;
  wire                op_jal;
  wire                op_jalr;
  wire                func7_shift_arithm;
  wire                func7_subtraction;
  wire                logic_slt;
  wire                branch_slt;
  wire                branch_sltu;
  wire                logic_add;
  wire                logic_add_imm;

  assign _zz_1 = io_instr[31 : 20];
  assign _zz_2 = {io_instr[31 : 25],io_instr[11 : 7]};
  assign _zz_3 = {{{{io_instr[31],io_instr[7]},io_instr[30 : 25]},io_instr[11 : 8]},1'b0};
  assign _zz_4 = io_instr[31 : 20];
  assign opcode = io_instr[6 : 0];
  assign io_rd_idx = io_instr[11 : 7];
  assign io_func3 = io_instr[14 : 12];
  assign io_rs1_idx = io_instr[19 : 15];
  assign io_rs2_idx = io_instr[24 : 20];
  assign io_func7 = io_instr[31 : 25];
  assign op_logic_arithm = (opcode == 7'h33);
  assign op_logic_arithm_imm = (opcode == 7'h13);
  assign op_store = (opcode == 7'h23);
  assign op_load = (opcode == 7'h03);
  assign op_branch = (opcode == 7'h63);
  assign op_lui = (opcode == 7'h37);
  assign op_auipc = (opcode == 7'h17);
  assign op_jal = (opcode == 7'h6f);
  assign op_jalr = (opcode == 7'h67);
  assign func7_shift_arithm = io_func7[5];
  assign func7_subtraction = io_func7[5];
  assign logic_slt = ((op_logic_arithm || op_logic_arithm_imm) && (io_func3 == 3'b010));
  assign branch_slt = (op_branch && (io_func3[2 : 1] == 2'b10));
  assign branch_sltu = (op_branch && (io_func3[2 : 1] == 2'b11));
  assign logic_add = ((op_logic_arithm && (io_func3 == 3'b000)) && (! func7_subtraction));
  assign logic_add_imm = (op_logic_arithm_imm && (io_func3 == 3'b000));
  assign io_alu_op_and = ((op_logic_arithm || op_logic_arithm_imm) && (io_func3 == 3'b111));
  assign io_alu_op_or = ((op_logic_arithm || op_logic_arithm_imm) && (io_func3 == 3'b110));
  assign io_alu_op_xor = ((op_logic_arithm || op_logic_arithm_imm) && (io_func3 == 3'b100));
  assign io_alu_op_add = (((((((logic_add || logic_add_imm) || op_auipc) || op_lui) || op_load) || op_store) || op_jal) || op_jalr);
  assign io_alu_op_sub = ((op_logic_arithm && (io_func3 == 3'b000)) && func7_subtraction);
  assign io_alu_op_sra = (((op_logic_arithm || op_logic_arithm_imm) && (io_func3 == 3'b101)) && func7_shift_arithm);
  assign io_alu_op_srl = (((op_logic_arithm || op_logic_arithm_imm) && (io_func3 == 3'b101)) && (! func7_shift_arithm));
  assign io_alu_op_sll = ((op_logic_arithm || op_logic_arithm_imm) && (io_func3 == 3'b001));
  assign io_alu_op_slt = (logic_slt || branch_slt);
  assign io_alu_op_sltu = (branch_sltu || ((op_logic_arithm || op_logic_arithm_imm) && (io_func3 == 3'b011)));
  assign io_alu_op_eqt = (op_branch && ((io_func3 == 3'b000) || (io_func3 == 3'b001)));
  assign io_alu_op_invb0 = (op_branch && (io_func3[0] == 1'b1));
  assign io_op1_sel_pc = ((op_auipc || op_jal) || op_jalr);
  assign io_op2_sel_imm = ((((((op_logic_arithm_imm || op_load) || op_store) || op_lui) || op_auipc) || op_jal) || op_jalr);
  assign io_op1_sel_zero = op_lui;
  assign io_branch_op = op_branch;
  assign io_jal_op = op_jal;
  assign io_jalr_op = op_jalr;
  assign io_register_wr = ((((((op_logic_arithm || op_logic_arithm_imm) || op_load) || op_lui) || op_auipc) || op_jal) || op_jalr);
  assign io_register_rs1_rd = (((((op_logic_arithm || op_logic_arithm_imm) || op_load) || op_store) || op_branch) || op_jalr);
  assign io_register_rs2_rd = ((op_logic_arithm || op_store) || op_branch);
  assign io_data_ram_wr = op_store;
  assign io_data_ram_rd = op_load;
  assign io_data_ram_ld_byte = ((io_func3 == 3'b000) || (io_func3 == 3'b100));
  assign io_data_ram_ld_hword = ((io_func3 == 3'b001) || (io_func3 == 3'b101));
  assign io_data_ram_ld_unsign = ((io_func3 == 3'b100) || (io_func3 == 3'b101));
  always @ (*) begin
    if((op_logic_arithm_imm || op_load))begin
      io_imm_value = {{20{_zz_1[11]}}, _zz_1};
    end else begin
      if(op_store)begin
        io_imm_value = {{20{_zz_2[11]}}, _zz_2};
      end else begin
        if((op_jal || op_jalr))begin
          io_imm_value = 32'h00000004;
        end else begin
          io_imm_value = {io_instr[31 : 12],12'h0};
        end
      end
    end
  end

  always @ (*) begin
    if(op_branch)begin
      io_brjp_imm_value = {{8{_zz_3[12]}}, _zz_3};
    end else begin
      if(op_jalr)begin
        io_brjp_imm_value = {{9{_zz_4[11]}}, _zz_4};
      end else begin
        io_brjp_imm_value = {{{{io_instr[31],io_instr[19 : 12]},io_instr[20]},io_instr[30 : 21]},1'b0};
      end
    end
  end


endmodule

module program_counter (
  input      [31:0]   io_pc_in,
  input               io_branch,
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
          pc <= io_pc_in;
        end else begin
          pc <= (pc + 32'h00000004);
        end
      end
    end
  end


endmodule
