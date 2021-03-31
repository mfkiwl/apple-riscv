// Generator : SpinalHDL v1.4.3    git head : adf552d8f500e7419fff395b7049228e4bc5de26
// Component : apple_riscv_soc
// Git hash  : ee023f36401f17ef27c1a91ac224ff7f64039688



module apple_riscv_soc (
  input               clk,
  input               reset
);
  wire                cpu_core_io_inst_ram_wen;
  wire                cpu_core_io_inst_ram_ren;
  wire       [9:0]    cpu_core_io_inst_ram_addr;
  wire       [31:0]   cpu_core_io_inst_ram_data_out;
  wire                cpu_core_io_data_ram_wen;
  wire                cpu_core_io_data_ram_ren;
  wire       [19:0]   cpu_core_io_data_ram_addr;
  wire       [31:0]   cpu_core_io_data_ram_data_out;
  wire       [31:0]   instruction_ram_io_data_out;
  wire       [31:0]   data_ram_io_data_out;

  apple_riscv cpu_core (
    .io_inst_ram_wen         (cpu_core_io_inst_ram_wen             ), //o
    .io_inst_ram_ren         (cpu_core_io_inst_ram_ren             ), //o
    .io_inst_ram_addr        (cpu_core_io_inst_ram_addr[9:0]       ), //o
    .io_inst_ram_data_out    (cpu_core_io_inst_ram_data_out[31:0]  ), //o
    .io_inst_ram_data_in     (instruction_ram_io_data_out[31:0]    ), //i
    .io_data_ram_wen         (cpu_core_io_data_ram_wen             ), //o
    .io_data_ram_ren         (cpu_core_io_data_ram_ren             ), //o
    .io_data_ram_addr        (cpu_core_io_data_ram_addr[19:0]      ), //o
    .io_data_ram_data_out    (cpu_core_io_data_ram_data_out[31:0]  ), //o
    .io_data_ram_data_in     (data_ram_io_data_out[31:0]           ), //i
    .clk                     (clk                                  ), //i
    .reset                   (reset                                )  //i
  );
  instruction_ram_onchip instruction_ram (
    .io_wen         (cpu_core_io_inst_ram_wen             ), //i
    .io_ren         (cpu_core_io_inst_ram_ren             ), //i
    .io_addr        (cpu_core_io_inst_ram_addr[9:0]       ), //i
    .io_data_out    (instruction_ram_io_data_out[31:0]    ), //o
    .io_data_in     (cpu_core_io_inst_ram_data_out[31:0]  ), //i
    .clk            (clk                                  ), //i
    .reset          (reset                                )  //i
  );
  data_ram_onchip data_ram (
    .io_wen         (cpu_core_io_data_ram_wen             ), //i
    .io_ren         (cpu_core_io_data_ram_ren             ), //i
    .io_addr        (cpu_core_io_data_ram_addr[19:0]      ), //i
    .io_data_out    (data_ram_io_data_out[31:0]           ), //o
    .io_data_in     (cpu_core_io_data_ram_data_out[31:0]  ), //i
    .clk            (clk                                  ), //i
    .reset          (reset                                )  //i
  );

endmodule

module data_ram_onchip (
  input               io_wen,
  input               io_ren,
  input      [19:0]   io_addr,
  output     [31:0]   io_data_out,
  input      [31:0]   io_data_in,
  input               clk,
  input               reset
);
  reg        [31:0]   _zz_1;
  reg [31:0] ram [0:1048575];

  always @ (posedge clk) begin
    if(io_wen) begin
      ram[io_addr] <= io_data_in;
    end
  end

  always @ (posedge clk) begin
    if(io_ren) begin
      _zz_1 <= ram[io_addr];
    end
  end

  assign io_data_out = _zz_1;

endmodule

module instruction_ram_onchip (
  input               io_wen,
  input               io_ren,
  input      [9:0]    io_addr,
  output     [31:0]   io_data_out,
  input      [31:0]   io_data_in,
  input               clk,
  input               reset
);
  reg        [31:0]   _zz_1;
  wire       [7:0]    ram_addr;
  reg [31:0] ram [0:255];

  always @ (posedge clk) begin
    if(io_wen) begin
      ram[ram_addr] <= io_data_in;
    end
  end

  always @ (posedge clk) begin
    if(io_ren) begin
      _zz_1 <= ram[ram_addr];
    end
  end

  assign ram_addr = io_addr[9 : 2];
  assign io_data_out = _zz_1;

endmodule

module apple_riscv (
  output              io_inst_ram_wen,
  output              io_inst_ram_ren,
  output     [9:0]    io_inst_ram_addr,
  output     [31:0]   io_inst_ram_data_out,
  input      [31:0]   io_inst_ram_data_in,
  output              io_data_ram_wen,
  output              io_data_ram_ren,
  output     [19:0]   io_data_ram_addr,
  output     [31:0]   io_data_ram_data_out,
  input      [31:0]   io_data_ram_data_in,
  input               clk,
  input               reset
);
  wire       [31:0]   _zz_1;
  wire                _zz_2;
  wire                _zz_3;
  wire       [31:0]   pc_inst_io_pc_out;
  wire       [6:0]    decoder_inst_io_opcode;
  wire       [4:0]    decoder_inst_io_rd;
  wire       [2:0]    decoder_inst_io_func3;
  wire       [4:0]    decoder_inst_io_rs1;
  wire       [4:0]    decoder_inst_io_rs2;
  wire       [6:0]    decoder_inst_io_func7;
  wire                decoder_inst_io_rs1_wen;
  wire                decoder_inst_io_rs2_wen;
  wire                decoder_inst_io_data_ram_wen;
  wire                decoder_inst_io_data_ram_ren;
  wire                decoder_inst_io_imm_sel;
  wire                decoder_inst_io_alu_la_op;
  wire                decoder_inst_io_alu_mem_op;
  wire       [31:0]   decoder_inst_io_imm;
  wire       [31:0]   register_file_inst_io_rs1_data_out;
  wire       [31:0]   register_file_inst_io_rs2_data_out;
  wire       [31:0]   alu_inst_io_alu_out;
  wire       [31:0]   _zz_4;
  wire                pipe_stall;
  wire                not_pipe_stall;
  reg        [31:0]   if_id_pc;
  reg        [4:0]    id_ex_rd;
  reg        [2:0]    id_ex_func3;
  reg        [4:0]    id_ex_rs1;
  reg        [4:0]    id_ex_rs2;
  reg        [6:0]    id_ex_func7;
  reg                 id_ex_rs1_wen;
  reg                 id_ex_rs2_wen;
  reg                 id_ex_data_ram_wen;
  reg                 id_ex_data_ram_ren;
  reg                 id_ex_alu_la_op;
  reg                 id_ex_alu_mem_op;
  reg                 id_ex_imm_sel;
  reg        [31:0]   id_ex_op1;
  wire       [31:0]   id_ex_op2_next;
  reg        [31:0]   id_ex_op2;
  reg                 ex_mem_rs1_wen;
  reg                 ex_mem_rs2_wen;
  reg                 ex_mem_data_ram_wen;
  reg                 ex_mem_data_ram_ren;
  reg        [31:0]   ex_mem_alu_out;
  reg        [4:0]    ex_mem_rs1;
  reg        [4:0]    ex_mem_rs2;
  reg        [4:0]    ex_mem_rd;
  reg                 mem_wb_rs1_wen;
  reg                 mem_wb_rs2_wen;
  reg        [31:0]   mem_wb_alu_out;
  reg        [4:0]    mem_wb_rs1;
  reg        [4:0]    mem_wb_rs2;
  reg        [4:0]    mem_wb_rd;

  assign _zz_4 = ex_mem_alu_out;
  program_counter pc_inst (
    .io_pc_in     (_zz_1[31:0]              ), //i
    .io_branch    (_zz_2                    ), //i
    .io_stall     (_zz_3                    ), //i
    .io_pc_out    (pc_inst_io_pc_out[31:0]  ), //o
    .clk          (clk                      ), //i
    .reset        (reset                    )  //i
  );
  instruction_decoder decoder_inst (
    .io_inst            (io_inst_ram_data_in[31:0]     ), //i
    .io_opcode          (decoder_inst_io_opcode[6:0]   ), //o
    .io_rd              (decoder_inst_io_rd[4:0]       ), //o
    .io_func3           (decoder_inst_io_func3[2:0]    ), //o
    .io_rs1             (decoder_inst_io_rs1[4:0]      ), //o
    .io_rs2             (decoder_inst_io_rs2[4:0]      ), //o
    .io_func7           (decoder_inst_io_func7[6:0]    ), //o
    .io_rs1_wen         (decoder_inst_io_rs1_wen       ), //o
    .io_rs2_wen         (decoder_inst_io_rs2_wen       ), //o
    .io_data_ram_wen    (decoder_inst_io_data_ram_wen  ), //o
    .io_data_ram_ren    (decoder_inst_io_data_ram_ren  ), //o
    .io_imm_sel         (decoder_inst_io_imm_sel       ), //o
    .io_alu_la_op       (decoder_inst_io_alu_la_op     ), //o
    .io_alu_mem_op      (decoder_inst_io_alu_mem_op    ), //o
    .io_imm             (decoder_inst_io_imm[31:0]     )  //o
  );
  register_file register_file_inst (
    .io_rs1_rd_addr     (decoder_inst_io_rs1[4:0]                  ), //i
    .io_rs1_wr_addr     (mem_wb_rd[4:0]                            ), //i
    .io_rs1_data_in     (mem_wb_alu_out[31:0]                      ), //i
    .io_rs1_wen         (mem_wb_rs1_wen                            ), //i
    .io_rs1_data_out    (register_file_inst_io_rs1_data_out[31:0]  ), //o
    .io_rs2_rd_addr     (decoder_inst_io_rs2[4:0]                  ), //i
    .io_rs2_wr_addr     (mem_wb_rd[4:0]                            ), //i
    .io_rs2_data_in     (mem_wb_alu_out[31:0]                      ), //i
    .io_rs2_wen         (mem_wb_rs2_wen                            ), //i
    .io_rs2_data_out    (register_file_inst_io_rs2_data_out[31:0]  ), //o
    .clk                (clk                                       ), //i
    .reset              (reset                                     )  //i
  );
  alu alu_inst (
    .io_op1            (id_ex_op1[31:0]            ), //i
    .io_op2            (id_ex_op2[31:0]            ), //i
    .io_alu_out        (alu_inst_io_alu_out[31:0]  ), //o
    .io_func3          (id_ex_func3[2:0]           ), //i
    .io_func7          (id_ex_func7[6:0]           ), //i
    .io_alu_la_op      (id_ex_alu_la_op            ), //i
    .io_alu_mem_op     (id_ex_alu_mem_op           ), //i
    .io_alu_imm_sel    (id_ex_imm_sel              )  //i
  );
  assign pipe_stall = 1'b0;
  assign not_pipe_stall = (! pipe_stall);
  assign _zz_2 = 1'b0;
  assign _zz_3 = 1'b0;
  assign _zz_1 = 32'h0;
  assign io_inst_ram_wen = 1'b0;
  assign io_inst_ram_ren = 1'b1;
  assign io_inst_ram_addr = pc_inst_io_pc_out[9 : 0];
  assign io_inst_ram_data_out = 32'h0;
  assign id_ex_op2_next = (decoder_inst_io_imm_sel ? decoder_inst_io_imm : register_file_inst_io_rs2_data_out);
  assign io_data_ram_addr = _zz_4[19 : 0];
  assign io_data_ram_data_out = 32'h0;
  assign io_data_ram_wen = ex_mem_data_ram_wen;
  assign io_data_ram_ren = ex_mem_data_ram_ren;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      if_id_pc <= 32'h0;
      id_ex_rs1_wen <= 1'b0;
      id_ex_rs2_wen <= 1'b0;
      id_ex_data_ram_wen <= 1'b0;
      id_ex_data_ram_ren <= 1'b0;
      id_ex_alu_la_op <= 1'b0;
      id_ex_alu_mem_op <= 1'b0;
      id_ex_imm_sel <= 1'b0;
      ex_mem_rs1_wen <= 1'b0;
      ex_mem_rs2_wen <= 1'b0;
      ex_mem_data_ram_wen <= 1'b0;
      ex_mem_data_ram_ren <= 1'b0;
      mem_wb_rs1_wen <= 1'b0;
      mem_wb_rs2_wen <= 1'b0;
    end else begin
      if(not_pipe_stall)begin
        if_id_pc <= pc_inst_io_pc_out;
      end
      if(not_pipe_stall)begin
        id_ex_rs1_wen <= decoder_inst_io_rs1_wen;
      end
      if(not_pipe_stall)begin
        id_ex_rs2_wen <= decoder_inst_io_rs2_wen;
      end
      if(not_pipe_stall)begin
        id_ex_data_ram_wen <= decoder_inst_io_data_ram_wen;
      end
      if(not_pipe_stall)begin
        id_ex_data_ram_ren <= decoder_inst_io_data_ram_ren;
      end
      if(not_pipe_stall)begin
        id_ex_alu_la_op <= decoder_inst_io_alu_la_op;
      end
      if(not_pipe_stall)begin
        id_ex_alu_mem_op <= decoder_inst_io_alu_mem_op;
      end
      if(not_pipe_stall)begin
        id_ex_imm_sel <= decoder_inst_io_imm_sel;
      end
      if(not_pipe_stall)begin
        ex_mem_rs1_wen <= id_ex_rs1_wen;
      end
      if(not_pipe_stall)begin
        ex_mem_rs2_wen <= id_ex_rs2_wen;
      end
      if(not_pipe_stall)begin
        ex_mem_data_ram_wen <= id_ex_data_ram_wen;
      end
      if(not_pipe_stall)begin
        ex_mem_data_ram_ren <= id_ex_data_ram_ren;
      end
      if(not_pipe_stall)begin
        mem_wb_rs1_wen <= ex_mem_rs1_wen;
      end
      if(not_pipe_stall)begin
        mem_wb_rs2_wen <= ex_mem_rs2_wen;
      end
    end
  end

  always @ (posedge clk) begin
    if(not_pipe_stall)begin
      id_ex_rd <= decoder_inst_io_rd;
    end
    if(not_pipe_stall)begin
      id_ex_func3 <= decoder_inst_io_func3;
    end
    if(not_pipe_stall)begin
      id_ex_rs1 <= decoder_inst_io_rs1;
    end
    if(not_pipe_stall)begin
      id_ex_rs2 <= decoder_inst_io_rs2;
    end
    if(not_pipe_stall)begin
      id_ex_func7 <= decoder_inst_io_func7;
    end
    if(not_pipe_stall)begin
      id_ex_op1 <= register_file_inst_io_rs1_data_out;
    end
    if(not_pipe_stall)begin
      id_ex_op2 <= id_ex_op2_next;
    end
    if(not_pipe_stall)begin
      ex_mem_alu_out <= alu_inst_io_alu_out;
    end
    if(not_pipe_stall)begin
      ex_mem_rs1 <= id_ex_rs1;
    end
    if(not_pipe_stall)begin
      ex_mem_rs2 <= id_ex_rs2;
    end
    if(not_pipe_stall)begin
      ex_mem_rd <= id_ex_rd;
    end
    if(not_pipe_stall)begin
      mem_wb_alu_out <= ex_mem_alu_out;
    end
    if(not_pipe_stall)begin
      mem_wb_rs1 <= ex_mem_rs1;
    end
    if(not_pipe_stall)begin
      mem_wb_rs2 <= ex_mem_rs2;
    end
    if(not_pipe_stall)begin
      mem_wb_rd <= ex_mem_rd;
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
    end
  end

  assign op1_signed = io_op1;
  assign op2_signed = io_op2;
  assign add_result = ($signed(op1_signed) + $signed(op2_signed));
  assign sub_result = ($signed(op1_signed) - $signed(op2_signed));
  assign shift_value = _zz_1[4 : 0];

endmodule

module register_file (
  input      [4:0]    io_rs1_rd_addr,
  input      [4:0]    io_rs1_wr_addr,
  input      [31:0]   io_rs1_data_in,
  input               io_rs1_wen,
  output reg [31:0]   io_rs1_data_out,
  input      [4:0]    io_rs2_rd_addr,
  input      [4:0]    io_rs2_wr_addr,
  input      [31:0]   io_rs2_data_in,
  input               io_rs2_wen,
  output reg [31:0]   io_rs2_data_out,
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
    if(io_rs1_wen) begin
      rs1_ram[io_rs1_wr_addr] <= io_rs1_data_in;
    end
  end

  assign _zz_1 = rs1_ram[io_rs1_rd_addr];
  always @ (posedge clk) begin
    if(io_rs2_wen) begin
      rs2_ram[io_rs2_wr_addr] <= io_rs2_data_in;
    end
  end

  assign _zz_2 = rs2_ram[io_rs2_rd_addr];
  assign rs1_data = _zz_1;
  assign rs2_data = _zz_2;
  always @ (*) begin
    if((io_rs1_rd_addr == 5'h0))begin
      io_rs1_data_out = 32'h0;
    end else begin
      io_rs1_data_out = rs1_data;
    end
  end

  always @ (*) begin
    if((io_rs2_rd_addr == 5'h0))begin
      io_rs2_data_out = 32'h0;
    end else begin
      io_rs2_data_out = rs2_data;
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
  output              io_rs1_wen,
  output              io_rs2_wen,
  output              io_data_ram_wen,
  output              io_data_ram_ren,
  output              io_imm_sel,
  output              io_alu_la_op,
  output              io_alu_mem_op,
  output reg [31:0]   io_imm
);
  wire       [11:0]   _zz_1;
  wire       [31:0]   _zz_2;
  wire                op_logic_arithm;
  wire                op_logic_arithm_imm;
  wire                op_store;
  wire                op_load;
  wire                op_lui;
  wire                op_auipc;

  assign _zz_1 = io_inst[31 : 20];
  assign _zz_2 = {{20{_zz_1[11]}}, _zz_1};
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
  assign io_imm_sel = op_logic_arithm_imm;
  assign io_rs1_wen = ((op_logic_arithm || op_logic_arithm_imm) || op_load);
  assign io_rs2_wen = io_rs1_wen;
  assign io_data_ram_wen = op_store;
  assign io_data_ram_ren = op_load;
  assign io_alu_la_op = (op_logic_arithm || op_logic_arithm_imm);
  assign io_alu_mem_op = (op_store || op_load);
  always @ (*) begin
    io_imm = 32'h0;
    if(op_logic_arithm_imm)begin
      io_imm = _zz_2;
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
