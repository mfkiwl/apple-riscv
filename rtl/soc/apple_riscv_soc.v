// Generator : SpinalHDL v1.4.3    git head : adf552d8f500e7419fff395b7049228e4bc5de26
// Component : apple_riscv_soc
// Git hash  : afc6a1340f667ef1c0daba53f68fbf164ec0350d



module apple_riscv_soc (
  input               clk,
  input               reset
);
  wire                cpu_core_io_inst_ram_wen;
  wire                cpu_core_io_inst_ram_ren;
  wire       [9:0]    cpu_core_io_inst_ram_addr;
  wire                cpu_core_io_inst_ram_enable;
  wire       [31:0]   cpu_core_io_inst_ram_data_out;
  wire                cpu_core_io_data_ram_wen;
  wire                cpu_core_io_data_ram_ren;
  wire       [19:0]   cpu_core_io_data_ram_addr;
  wire       [31:0]   cpu_core_io_data_ram_data_out;
  wire       [3:0]    cpu_core_io_data_ram_byte_enable;
  wire       [31:0]   instruction_ram_io_data_out;
  wire       [31:0]   data_ram_io_data_out;

  apple_riscv cpu_core (
    .io_inst_ram_wen            (cpu_core_io_inst_ram_wen               ), //o
    .io_inst_ram_ren            (cpu_core_io_inst_ram_ren               ), //o
    .io_inst_ram_addr           (cpu_core_io_inst_ram_addr[9:0]         ), //o
    .io_inst_ram_enable         (cpu_core_io_inst_ram_enable            ), //o
    .io_inst_ram_data_out       (cpu_core_io_inst_ram_data_out[31:0]    ), //o
    .io_inst_ram_data_in        (instruction_ram_io_data_out[31:0]      ), //i
    .io_data_ram_wen            (cpu_core_io_data_ram_wen               ), //o
    .io_data_ram_ren            (cpu_core_io_data_ram_ren               ), //o
    .io_data_ram_addr           (cpu_core_io_data_ram_addr[19:0]        ), //o
    .io_data_ram_data_out       (cpu_core_io_data_ram_data_out[31:0]    ), //o
    .io_data_ram_data_in        (data_ram_io_data_out[31:0]             ), //i
    .io_data_ram_byte_enable    (cpu_core_io_data_ram_byte_enable[3:0]  ), //o
    .clk                        (clk                                    ), //i
    .reset                      (reset                                  )  //i
  );
  instruction_ram_model instruction_ram (
    .io_wen         (cpu_core_io_inst_ram_wen             ), //i
    .io_ren         (cpu_core_io_inst_ram_ren             ), //i
    .io_enable      (cpu_core_io_inst_ram_enable          ), //i
    .io_addr        (cpu_core_io_inst_ram_addr[9:0]       ), //i
    .io_data_out    (instruction_ram_io_data_out[31:0]    ), //o
    .io_data_in     (cpu_core_io_inst_ram_data_out[31:0]  ), //i
    .clk            (clk                                  ), //i
    .reset          (reset                                )  //i
  );
  data_ram_model data_ram (
    .io_wen         (cpu_core_io_data_ram_wen               ), //i
    .io_ren         (cpu_core_io_data_ram_ren               ), //i
    .io_addr        (cpu_core_io_data_ram_addr[19:0]        ), //i
    .io_byte_en     (cpu_core_io_data_ram_byte_enable[3:0]  ), //i
    .io_data_out    (data_ram_io_data_out[31:0]             ), //o
    .io_data_in     (cpu_core_io_data_ram_data_out[31:0]    ), //i
    .clk            (clk                                    ), //i
    .reset          (reset                                  )  //i
  );

endmodule

module data_ram_model (
  input               io_wen,
  input               io_ren,
  input      [19:0]   io_addr,
  input      [3:0]    io_byte_en,
  output     [31:0]   io_data_out,
  input      [31:0]   io_data_in,
  input               clk,
  input               reset
);
  reg        [31:0]   _zz_1;
  reg [7:0] ram_symbol0 [0:1048575];
  reg [7:0] ram_symbol1 [0:1048575];
  reg [7:0] ram_symbol2 [0:1048575];
  reg [7:0] ram_symbol3 [0:1048575];
  reg [7:0] _zz_2;
  reg [7:0] _zz_3;
  reg [7:0] _zz_4;
  reg [7:0] _zz_5;

  always @ (*) begin
    _zz_1 = {_zz_5, _zz_4, _zz_3, _zz_2};
  end
  always @ (posedge clk) begin
    if(io_byte_en[0] && io_wen) begin
      ram_symbol0[io_addr] <= io_data_in[7 : 0];
    end
    if(io_byte_en[1] && io_wen) begin
      ram_symbol1[io_addr] <= io_data_in[15 : 8];
    end
    if(io_byte_en[2] && io_wen) begin
      ram_symbol2[io_addr] <= io_data_in[23 : 16];
    end
    if(io_byte_en[3] && io_wen) begin
      ram_symbol3[io_addr] <= io_data_in[31 : 24];
    end
  end

  always @ (posedge clk) begin
    if(io_ren) begin
      _zz_2 <= ram_symbol0[io_addr];
      _zz_3 <= ram_symbol1[io_addr];
      _zz_4 <= ram_symbol2[io_addr];
      _zz_5 <= ram_symbol3[io_addr];
    end
  end

  assign io_data_out = _zz_1;

endmodule

module instruction_ram_model (
  input               io_wen,
  input               io_ren,
  input               io_enable,
  input      [9:0]    io_addr,
  output     [31:0]   io_data_out,
  input      [31:0]   io_data_in,
  input               clk,
  input               reset
);
  reg        [31:0]   _zz_2;
  wire                _zz_3;
  wire       [7:0]    ram_addr;
  wire                _zz_1;
  reg [31:0] ram [0:255];

  assign _zz_3 = (io_wen && io_enable);
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

  assign ram_addr = io_addr[9 : 2];
  assign _zz_1 = (io_ren && io_enable);
  assign io_data_out = _zz_2;

endmodule

module apple_riscv (
  output              io_inst_ram_wen,
  output              io_inst_ram_ren,
  output     [9:0]    io_inst_ram_addr,
  output              io_inst_ram_enable,
  output     [31:0]   io_inst_ram_data_out,
  input      [31:0]   io_inst_ram_data_in,
  output              io_data_ram_wen,
  output              io_data_ram_ren,
  output     [19:0]   io_data_ram_addr,
  output     [31:0]   io_data_ram_data_out,
  input      [31:0]   io_data_ram_data_in,
  output     [3:0]    io_data_ram_byte_enable,
  input               clk,
  input               reset
);
  wire       [31:0]   _zz_1;
  wire                _zz_2;
  wire       [31:0]   _zz_3;
  wire       [19:0]   _zz_4;
  wire                _zz_5;
  wire       [31:0]   pc_inst_io_pc_out;
  wire       [6:0]    decoder_inst_io_opcode;
  wire       [4:0]    decoder_inst_io_rd;
  wire       [2:0]    decoder_inst_io_func3;
  wire       [4:0]    decoder_inst_io_rs1;
  wire       [4:0]    decoder_inst_io_rs2;
  wire       [6:0]    decoder_inst_io_func7;
  wire                decoder_inst_io_register_wen;
  wire                decoder_inst_io_register_rs1_ren;
  wire                decoder_inst_io_register_rs2_ren;
  wire                decoder_inst_io_data_ram_wen;
  wire                decoder_inst_io_data_ram_ren;
  wire                decoder_inst_io_data_ram_access_byte;
  wire                decoder_inst_io_data_ram_access_halfword;
  wire                decoder_inst_io_data_ram_load_unsigned;
  wire                decoder_inst_io_imm_sel;
  wire                decoder_inst_io_alu_la_op;
  wire                decoder_inst_io_alu_mem_op;
  wire       [11:0]   decoder_inst_io_imm_11_0;
  wire       [31:0]   register_file_inst_io_rs1_data_out;
  wire       [31:0]   register_file_inst_io_rs2_data_out;
  wire       [31:0]   alu_inst_io_alu_out;
  wire       [31:0]   memory_controller_inst_io_mc2cpu_data;
  wire                memory_controller_inst_io_mc2mem_wen;
  wire                memory_controller_inst_io_mc2mem_ren;
  wire       [19:0]   memory_controller_inst_io_mc2mem_addr;
  wire       [31:0]   memory_controller_inst_io_mc2mem_data;
  wire       [3:0]    memory_controller_inst_io_mc2mem_byte_enable;
  wire       [31:0]   _zz_6;
  wire                if_inst_valid;
  reg                 id_inst_valid;
  wire                ex_inst_valid;
  wire                mem_inst_valid;
  wire                wb_inst_valid;
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
  reg        [31:0]   if_id_pc;
  reg                 if_id_inst_valid;
  reg                 id_ex_inst_valid;
  reg                 id_ex_register_wen;
  reg                 id_ex_data_ram_wen;
  reg                 id_ex_data_ram_ren;
  reg                 id_ex_register_rs1_ren;
  reg                 id_ex_register_rs2_ren;
  reg        [4:0]    id_ex_rd;
  reg        [2:0]    id_ex_func3;
  reg        [4:0]    id_ex_rs1;
  reg        [4:0]    id_ex_rs2;
  reg        [6:0]    id_ex_func7;
  reg                 id_ex_alu_la_op;
  reg                 id_ex_alu_mem_op;
  reg                 id_ex_imm_sel;
  reg                 id_ex_data_ram_access_byte;
  reg                 id_ex_data_ram_access_halfword;
  reg                 id_ex_data_ram_load_unsigned;
  reg        [31:0]   id_ex_rs1_value;
  reg        [31:0]   id_ex_rs2_value;
  reg        [11:0]   id_ex_imm_11_0;
  reg        [31:0]   ex_rs1_value_forwarded;
  reg        [31:0]   ex_rs2_value_forwarded;
  wire       [31:0]   imm;
  reg                 ex_mem_inst_valid;
  reg                 ex_mem_register_wen;
  reg                 ex_mem_data_ram_wen;
  reg                 ex_mem_data_ram_ren;
  reg                 ex_mem_data_ram_access_byte;
  reg                 ex_mem_data_ram_access_halfword;
  reg                 ex_mem_data_ram_load_unsigned;
  reg        [31:0]   ex_mem_alu_out;
  reg        [4:0]    ex_mem_rs1;
  reg        [4:0]    ex_mem_rs2;
  reg        [4:0]    ex_mem_rd;
  reg        [31:0]   ex_mem_rs2_value;
  reg                 mem_wb_inst_valid;
  reg                 mem_wb_register_wen;
  reg                 mem_wb_data_ram_ren;
  reg        [31:0]   mem_wb_alu_out;
  reg        [4:0]    mem_wb_rs1;
  reg        [4:0]    mem_wb_rs2;
  reg        [4:0]    mem_wb_rd;
  wire       [31:0]   wb_rd_wr_data;
  wire                rs1_match_mem;
  wire                rs1_match_wb;
  wire                forward_rs1_from_mem;
  wire                forward_rs1_from_wb;
  wire                rs2_match_mem;
  wire                rs2_match_wb;
  wire                forward_rs2_from_mem;
  wire                forward_rs2_from_wb;
  wire                id_rs1_depends_on_ex_rd;
  wire                id_rs2_depends_on_ex_rd;
  wire                stall_on_load_dependence;

  assign _zz_6 = {{20{id_ex_imm_11_0[11]}}, id_ex_imm_11_0};
  program_counter pc_inst (
    .io_pc_in     (_zz_1[31:0]              ), //i
    .io_branch    (_zz_2                    ), //i
    .io_stall     (if_pipe_stall            ), //i
    .io_pc_out    (pc_inst_io_pc_out[31:0]  ), //o
    .clk          (clk                      ), //i
    .reset        (reset                    )  //i
  );
  instruction_decoder decoder_inst (
    .io_inst                        (io_inst_ram_data_in[31:0]                 ), //i
    .io_opcode                      (decoder_inst_io_opcode[6:0]               ), //o
    .io_rd                          (decoder_inst_io_rd[4:0]                   ), //o
    .io_func3                       (decoder_inst_io_func3[2:0]                ), //o
    .io_rs1                         (decoder_inst_io_rs1[4:0]                  ), //o
    .io_rs2                         (decoder_inst_io_rs2[4:0]                  ), //o
    .io_func7                       (decoder_inst_io_func7[6:0]                ), //o
    .io_register_wen                (decoder_inst_io_register_wen              ), //o
    .io_register_rs1_ren            (decoder_inst_io_register_rs1_ren          ), //o
    .io_register_rs2_ren            (decoder_inst_io_register_rs2_ren          ), //o
    .io_data_ram_wen                (decoder_inst_io_data_ram_wen              ), //o
    .io_data_ram_ren                (decoder_inst_io_data_ram_ren              ), //o
    .io_data_ram_access_byte        (decoder_inst_io_data_ram_access_byte      ), //o
    .io_data_ram_access_halfword    (decoder_inst_io_data_ram_access_halfword  ), //o
    .io_data_ram_load_unsigned      (decoder_inst_io_data_ram_load_unsigned    ), //o
    .io_imm_sel                     (decoder_inst_io_imm_sel                   ), //o
    .io_alu_la_op                   (decoder_inst_io_alu_la_op                 ), //o
    .io_alu_mem_op                  (decoder_inst_io_alu_mem_op                ), //o
    .io_imm_11_0                    (decoder_inst_io_imm_11_0[11:0]            )  //o
  );
  register_file register_file_inst (
    .io_rs1_rd_addr         (decoder_inst_io_rs1[4:0]                  ), //i
    .io_rs1_data_out        (register_file_inst_io_rs1_data_out[31:0]  ), //o
    .io_rs2_rd_addr         (decoder_inst_io_rs2[4:0]                  ), //i
    .io_rs2_data_out        (register_file_inst_io_rs2_data_out[31:0]  ), //o
    .io_register_wen        (mem_wb_register_wen                       ), //i
    .io_register_wr_addr    (mem_wb_rd[4:0]                            ), //i
    .io_rd_in               (wb_rd_wr_data[31:0]                       ), //i
    .clk                    (clk                                       ), //i
    .reset                  (reset                                     )  //i
  );
  alu alu_inst (
    .io_op1            (ex_rs1_value_forwarded[31:0]  ), //i
    .io_op2            (_zz_3[31:0]                   ), //i
    .io_alu_out        (alu_inst_io_alu_out[31:0]     ), //o
    .io_func3          (id_ex_func3[2:0]              ), //i
    .io_func7          (id_ex_func7[6:0]              ), //i
    .io_alu_la_op      (id_ex_alu_la_op               ), //i
    .io_alu_mem_op     (id_ex_alu_mem_op              ), //i
    .io_alu_imm_sel    (id_ex_imm_sel                 )  //i
  );
  memory_controller memory_controller_inst (
    .io_cpu2mc_wen                (ex_mem_data_ram_wen                                ), //i
    .io_cpu2mc_ren                (ex_mem_data_ram_ren                                ), //i
    .io_cpu2mc_addr               (_zz_4[19:0]                                        ), //i
    .io_cpu2mc_data               (ex_mem_rs2_value[31:0]                             ), //i
    .io_mc2cpu_data               (memory_controller_inst_io_mc2cpu_data[31:0]        ), //o
    .io_cpu2mc_mem_LS_byte        (ex_mem_data_ram_access_byte                        ), //i
    .io_cpu2mc_mem_LS_halfword    (ex_mem_data_ram_access_halfword                    ), //i
    .io_cpu2mc_mem_LW_unsigned    (ex_mem_data_ram_load_unsigned                      ), //i
    .io_mc2mem_wen                (memory_controller_inst_io_mc2mem_wen               ), //o
    .io_mc2mem_ren                (memory_controller_inst_io_mc2mem_ren               ), //o
    .io_mc2mem_addr               (memory_controller_inst_io_mc2mem_addr[19:0]        ), //o
    .io_mem2mc_data               (io_data_ram_data_in[31:0]                          ), //i
    .io_mem2mc_data_vld           (_zz_5                                              ), //i
    .io_mc2mem_data               (memory_controller_inst_io_mc2mem_data[31:0]        ), //o
    .io_mc2mem_byte_enable        (memory_controller_inst_io_mc2mem_byte_enable[3:0]  ), //o
    .clk                          (clk                                                ), //i
    .reset                        (reset                                              )  //i
  );
  assign ex_pipe_stall = 1'b0;
  assign mem_pipe_stall = 1'b0;
  assign wb_pipe_stall = 1'b0;
  assign if_pipe_run = (! if_pipe_stall);
  assign id_pipe_run = (! id_pipe_stall);
  assign ex_pipe_run = (! ex_pipe_stall);
  assign mem_pipe_run = (! mem_pipe_stall);
  assign wb_pipe_run = (! wb_pipe_stall);
  assign _zz_2 = 1'b0;
  assign _zz_1 = 32'h0;
  assign io_inst_ram_wen = 1'b0;
  assign io_inst_ram_ren = 1'b1;
  assign io_inst_ram_enable = if_pipe_run;
  assign io_inst_ram_addr = pc_inst_io_pc_out[9 : 0];
  assign io_inst_ram_data_out = 32'h0;
  assign imm = _zz_6;
  assign _zz_3 = (id_ex_imm_sel ? imm : ex_rs2_value_forwarded);
  assign _zz_4 = ex_mem_alu_out[19 : 0];
  assign io_data_ram_wen = memory_controller_inst_io_mc2mem_wen;
  assign io_data_ram_ren = memory_controller_inst_io_mc2mem_ren;
  assign io_data_ram_addr = memory_controller_inst_io_mc2mem_addr;
  assign io_data_ram_data_out = memory_controller_inst_io_mc2mem_data;
  assign io_data_ram_byte_enable = memory_controller_inst_io_mc2mem_byte_enable;
  assign wb_rd_wr_data = (mem_wb_data_ram_ren ? memory_controller_inst_io_mc2cpu_data : mem_wb_alu_out);
  assign rs1_match_mem = (id_ex_rs1 == ex_mem_rd);
  assign rs1_match_wb = (id_ex_rs1 == mem_wb_rd);
  assign forward_rs1_from_mem = ((id_ex_register_rs1_ren && rs1_match_mem) && ex_mem_register_wen);
  assign forward_rs1_from_wb = ((id_ex_register_rs1_ren && rs1_match_wb) && mem_wb_register_wen);
  always @ (*) begin
    if(forward_rs1_from_mem)begin
      ex_rs1_value_forwarded = ex_mem_alu_out;
    end else begin
      if(forward_rs1_from_wb)begin
        ex_rs1_value_forwarded = wb_rd_wr_data;
      end else begin
        ex_rs1_value_forwarded = id_ex_rs1_value;
      end
    end
  end

  assign rs2_match_mem = (id_ex_rs2 == ex_mem_rd);
  assign rs2_match_wb = (id_ex_rs2 == mem_wb_rd);
  assign forward_rs2_from_mem = ((id_ex_register_rs2_ren && rs2_match_mem) && ex_mem_register_wen);
  assign forward_rs2_from_wb = ((id_ex_register_rs2_ren && rs2_match_wb) && mem_wb_register_wen);
  always @ (*) begin
    if(forward_rs2_from_mem)begin
      ex_rs2_value_forwarded = ex_mem_alu_out;
    end else begin
      if(forward_rs2_from_wb)begin
        ex_rs2_value_forwarded = wb_rd_wr_data;
      end else begin
        ex_rs2_value_forwarded = id_ex_rs2_value;
      end
    end
  end

  assign if_inst_valid = 1'b1;
  assign ex_inst_valid = id_ex_inst_valid;
  assign mem_inst_valid = ex_mem_inst_valid;
  assign wb_inst_valid = mem_wb_inst_valid;
  assign id_rs1_depends_on_ex_rd = ((decoder_inst_io_rs1 == id_ex_rd) && decoder_inst_io_register_rs1_ren);
  assign id_rs2_depends_on_ex_rd = ((decoder_inst_io_rs2 == id_ex_rd) && decoder_inst_io_register_rs2_ren);
  assign stall_on_load_dependence = ((id_rs1_depends_on_ex_rd || id_rs2_depends_on_ex_rd) && id_ex_data_ram_ren);
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
      id_inst_valid = 1'b0;
    end else begin
      id_inst_valid = if_id_inst_valid;
    end
  end

  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      if_id_pc <= 32'h0;
      if_id_inst_valid <= 1'b0;
      id_ex_inst_valid <= 1'b0;
      id_ex_register_wen <= 1'b0;
      id_ex_data_ram_wen <= 1'b0;
      id_ex_data_ram_ren <= 1'b0;
      id_ex_register_rs1_ren <= 1'b0;
      id_ex_register_rs2_ren <= 1'b0;
      ex_mem_inst_valid <= 1'b0;
      ex_mem_register_wen <= 1'b0;
      ex_mem_data_ram_wen <= 1'b0;
      ex_mem_data_ram_ren <= 1'b0;
      mem_wb_inst_valid <= 1'b0;
      mem_wb_register_wen <= 1'b0;
      mem_wb_data_ram_ren <= 1'b0;
    end else begin
      if(id_pipe_run)begin
        if_id_pc <= pc_inst_io_pc_out;
      end
      if(id_pipe_run)begin
        if_id_inst_valid <= if_inst_valid;
      end
      if(ex_pipe_run)begin
        id_ex_inst_valid <= id_inst_valid;
      end
      if(ex_pipe_run)begin
        id_ex_register_wen <= (decoder_inst_io_register_wen && id_inst_valid);
      end
      if(ex_pipe_run)begin
        id_ex_data_ram_wen <= (decoder_inst_io_data_ram_wen && id_inst_valid);
      end
      if(ex_pipe_run)begin
        id_ex_data_ram_ren <= (decoder_inst_io_data_ram_ren && id_inst_valid);
      end
      if(ex_pipe_run)begin
        id_ex_register_rs1_ren <= (decoder_inst_io_register_rs1_ren && id_inst_valid);
      end
      if(ex_pipe_run)begin
        id_ex_register_rs2_ren <= (decoder_inst_io_register_rs2_ren && id_inst_valid);
      end
      if(mem_pipe_run)begin
        ex_mem_inst_valid <= ex_inst_valid;
      end
      if(mem_pipe_run)begin
        ex_mem_register_wen <= (id_ex_register_wen && ex_inst_valid);
      end
      if(mem_pipe_run)begin
        ex_mem_data_ram_wen <= (id_ex_data_ram_wen && ex_inst_valid);
      end
      if(mem_pipe_run)begin
        ex_mem_data_ram_ren <= (id_ex_data_ram_ren && ex_inst_valid);
      end
      if(wb_pipe_run)begin
        mem_wb_inst_valid <= mem_inst_valid;
      end
      if(wb_pipe_run)begin
        mem_wb_register_wen <= (ex_mem_register_wen && mem_inst_valid);
      end
      if(wb_pipe_run)begin
        mem_wb_data_ram_ren <= (ex_mem_data_ram_ren && mem_inst_valid);
      end
    end
  end

  always @ (posedge clk) begin
    if(ex_pipe_run)begin
      id_ex_rd <= decoder_inst_io_rd;
    end
    if(ex_pipe_run)begin
      id_ex_func3 <= decoder_inst_io_func3;
    end
    if(ex_pipe_run)begin
      id_ex_rs1 <= decoder_inst_io_rs1;
    end
    if(ex_pipe_run)begin
      id_ex_rs2 <= decoder_inst_io_rs2;
    end
    if(ex_pipe_run)begin
      id_ex_func7 <= decoder_inst_io_func7;
    end
    if(ex_pipe_run)begin
      id_ex_alu_la_op <= decoder_inst_io_alu_la_op;
    end
    if(ex_pipe_run)begin
      id_ex_alu_mem_op <= decoder_inst_io_alu_mem_op;
    end
    if(ex_pipe_run)begin
      id_ex_imm_sel <= decoder_inst_io_imm_sel;
    end
    if(ex_pipe_run)begin
      id_ex_data_ram_access_byte <= decoder_inst_io_data_ram_access_byte;
    end
    if(ex_pipe_run)begin
      id_ex_data_ram_access_halfword <= decoder_inst_io_data_ram_access_halfword;
    end
    if(ex_pipe_run)begin
      id_ex_data_ram_load_unsigned <= decoder_inst_io_data_ram_load_unsigned;
    end
    if(ex_pipe_run)begin
      id_ex_rs1_value <= register_file_inst_io_rs1_data_out;
    end
    if(ex_pipe_run)begin
      id_ex_rs2_value <= register_file_inst_io_rs2_data_out;
    end
    if(ex_pipe_run)begin
      id_ex_imm_11_0 <= decoder_inst_io_imm_11_0;
    end
    if(mem_pipe_run)begin
      ex_mem_data_ram_access_byte <= (id_ex_data_ram_access_byte && ex_inst_valid);
    end
    if(mem_pipe_run)begin
      ex_mem_data_ram_access_halfword <= (id_ex_data_ram_access_halfword && ex_inst_valid);
    end
    if(mem_pipe_run)begin
      ex_mem_data_ram_load_unsigned <= (id_ex_data_ram_load_unsigned && ex_inst_valid);
    end
    if(mem_pipe_run)begin
      ex_mem_alu_out <= alu_inst_io_alu_out;
    end
    if(mem_pipe_run)begin
      ex_mem_rs1 <= id_ex_rs1;
    end
    if(mem_pipe_run)begin
      ex_mem_rs2 <= id_ex_rs2;
    end
    if(mem_pipe_run)begin
      ex_mem_rd <= id_ex_rd;
    end
    if(mem_pipe_run)begin
      ex_mem_rs2_value <= ex_rs2_value_forwarded;
    end
    if(wb_pipe_run)begin
      mem_wb_alu_out <= ex_mem_alu_out;
    end
    if(wb_pipe_run)begin
      mem_wb_rs1 <= ex_mem_rs1;
    end
    if(wb_pipe_run)begin
      mem_wb_rs2 <= ex_mem_rs2;
    end
    if(wb_pipe_run)begin
      mem_wb_rd <= ex_mem_rd;
    end
  end


endmodule

module memory_controller (
  input               io_cpu2mc_wen,
  input               io_cpu2mc_ren,
  input      [19:0]   io_cpu2mc_addr,
  input      [31:0]   io_cpu2mc_data,
  output reg [31:0]   io_mc2cpu_data,
  input               io_cpu2mc_mem_LS_byte,
  input               io_cpu2mc_mem_LS_halfword,
  input               io_cpu2mc_mem_LW_unsigned,
  output              io_mc2mem_wen,
  output              io_mc2mem_ren,
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

  assign io_mc2mem_ren = io_cpu2mc_ren;
  assign io_mc2mem_wen = io_cpu2mc_wen;
  always @ (posedge clk) begin
    if(io_cpu2mc_ren)begin
      LW_unsigned_s1 <= io_cpu2mc_mem_LW_unsigned;
    end
    if(io_cpu2mc_ren)begin
      LS_byte_s1 <= io_cpu2mc_mem_LS_byte;
    end
    if(io_cpu2mc_ren)begin
      LS_halfword_s1 <= io_cpu2mc_mem_LS_halfword;
    end
    if(io_cpu2mc_ren)begin
      mem_byte_addr_s1 <= mem_byte_addr;
    end
  end


endmodule

module alu (
  input      [31:0]   io_op1,
  input      [31:0]   io_op2,
  output reg [31:0]   io_alu_out,
  input      [2:0]    io_func3,
  input      [6:0]    io_func7,
  input               io_alu_la_op,
  input               io_alu_mem_op,
  input               io_alu_imm_sel
);
  wire       [31:0]   _zz_1;
  wire       [31:0]   _zz_2;
  wire       [31:0]   _zz_3;
  wire       [31:0]   op1_signed;
  wire       [31:0]   op2_signed;
  wire       [31:0]   add_result;
  wire       [31:0]   sub_result;
  wire       [4:0]    shift_value;

  assign _zz_1 = io_op2;
  assign _zz_2 = ($signed(_zz_3) >>> shift_value);
  assign _zz_3 = io_op1;
  assign op1_signed = io_op1;
  assign op2_signed = io_op2;
  assign add_result = ($signed(op1_signed) + $signed(op2_signed));
  assign sub_result = ($signed(op1_signed) - $signed(op2_signed));
  assign shift_value = _zz_1[4 : 0];
  always @ (*) begin
    io_alu_out = 32'h0;
    if(io_alu_la_op)begin
      case(io_func3)
        3'b111 : begin
          io_alu_out = (io_op1 & io_op2);
        end
        3'b110 : begin
          io_alu_out = (io_op1 | io_op2);
        end
        3'b100 : begin
          io_alu_out = (io_op1 ^ io_op2);
        end
        3'b000 : begin
          if(io_alu_imm_sel)begin
            io_alu_out = add_result;
          end else begin
            if((io_func7[5] == 1'b1))begin
              io_alu_out = sub_result;
            end else begin
              io_alu_out = add_result;
            end
          end
        end
        3'b101 : begin
          if((io_func7[5] == 1'b1))begin
            io_alu_out = _zz_2;
          end else begin
            io_alu_out = (io_op1 >>> shift_value);
          end
        end
        3'b001 : begin
          io_alu_out = (io_op1 <<< shift_value);
        end
        3'b010 : begin
          io_alu_out = 32'h0;
          io_alu_out[0] = ($signed(op1_signed) < $signed(op2_signed));
        end
        default : begin
          io_alu_out = 32'h0;
          io_alu_out[0] = (io_op1 < io_op2);
        end
      endcase
    end else begin
      if(io_alu_mem_op)begin
        io_alu_out = add_result;
      end
    end
  end


endmodule

module register_file (
  input      [4:0]    io_rs1_rd_addr,
  output reg [31:0]   io_rs1_data_out,
  input      [4:0]    io_rs2_rd_addr,
  output reg [31:0]   io_rs2_data_out,
  input               io_register_wen,
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
    if(io_register_wen) begin
      rs1_ram[io_register_wr_addr] <= io_rd_in;
    end
  end

  assign _zz_1 = rs1_ram[io_rs1_rd_addr];
  always @ (posedge clk) begin
    if(io_register_wen) begin
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
      if(((io_rs1_rd_addr == io_register_wr_addr) && (io_register_wen == 1'b1)))begin
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
      if(((io_rs2_rd_addr == io_register_wr_addr) && (io_register_wen == 1'b1)))begin
        io_rs2_data_out = io_rd_in;
      end else begin
        io_rs2_data_out = rs2_data;
      end
    end
  end


endmodule

module instruction_decoder (
  input      [31:0]   io_inst,
  output     [6:0]    io_opcode,
  output     [4:0]    io_rd,
  output     [2:0]    io_func3,
  output     [4:0]    io_rs1,
  output     [4:0]    io_rs2,
  output     [6:0]    io_func7,
  output              io_register_wen,
  output              io_register_rs1_ren,
  output              io_register_rs2_ren,
  output              io_data_ram_wen,
  output              io_data_ram_ren,
  output              io_data_ram_access_byte,
  output              io_data_ram_access_halfword,
  output              io_data_ram_load_unsigned,
  output              io_imm_sel,
  output              io_alu_la_op,
  output              io_alu_mem_op,
  output reg [11:0]   io_imm_11_0
);
  wire                op_logic_arithm;
  wire                op_logic_arithm_imm;
  wire                op_store;
  wire                op_load;
  wire                op_lui;
  wire                op_auipc;

  assign io_opcode = io_inst[6 : 0];
  assign io_rd = io_inst[11 : 7];
  assign io_func3 = io_inst[14 : 12];
  assign io_rs1 = io_inst[19 : 15];
  assign io_rs2 = io_inst[24 : 20];
  assign io_func7 = io_inst[31 : 25];
  assign op_logic_arithm = (io_opcode == 7'h33);
  assign op_logic_arithm_imm = (io_opcode == 7'h13);
  assign op_store = (io_opcode == 7'h23);
  assign op_load = (io_opcode == 7'h03);
  assign op_lui = (io_opcode == 7'h37);
  assign op_auipc = (io_opcode == 7'h17);
  assign io_imm_sel = ((op_logic_arithm_imm || op_load) || op_store);
  assign io_register_wen = ((op_logic_arithm || op_logic_arithm_imm) || op_load);
  assign io_register_rs1_ren = (((op_logic_arithm || op_logic_arithm_imm) || op_load) || op_store);
  assign io_register_rs2_ren = (op_logic_arithm || op_store);
  assign io_data_ram_wen = op_store;
  assign io_data_ram_ren = op_load;
  assign io_data_ram_access_byte = ((io_func3 == 3'b000) || (io_func3 == 3'b100));
  assign io_data_ram_access_halfword = ((io_func3 == 3'b001) || (io_func3 == 3'b101));
  assign io_data_ram_load_unsigned = ((io_func3 == 3'b100) || (io_func3 == 3'b101));
  assign io_alu_la_op = (op_logic_arithm || op_logic_arithm_imm);
  assign io_alu_mem_op = (op_store || op_load);
  always @ (*) begin
    if((op_logic_arithm_imm || op_load))begin
      io_imm_11_0 = io_inst[31 : 20];
    end else begin
      io_imm_11_0 = {io_inst[31 : 25],io_inst[11 : 7]};
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
