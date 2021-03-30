///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: apple_riscv
//
// Author: Heqing Huang
// Date Created: 03/29/2021
//
// ================== Description ==================
//
// The top level of the cpu core.
//
// - The top level instantiate all the components.
// - The pipeline logic is written in this file to reduce I/O connection.
// - Instruction RAM and Data RAM are out side the cpu core
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._

case class apple_riscv_io(param: CPU_PARAM) extends Bundle {

    // instruction ram
    val inst_ram_wen    = out Bool
    val inst_ram_ren    = out Bool
    val inst_ram_addr   = out UInt(param.INST_RAM_ADDR_WIDTH bits)
    val inst_ram_data_out = out Bits(param.INST_RAM_DATA_WIDTH bits)
    val inst_ram_data_in = in Bits(param.INST_RAM_DATA_WIDTH bits)    // data come 1 cycle after ren

    // data ram
    val data_ram_wen    = out Bool
    val data_ram_ren    = out Bool
    val data_ram_addr   = out UInt(param.INST_RAM_ADDR_WIDTH bits)
    val data_ram_data_out = out Bits(param.INST_RAM_DATA_WIDTH bits)
    val data_ram_data_in = in Bits(param.INST_RAM_DATA_WIDTH bits)    // data come 1 cycle after ren

}

case class apple_riscv (param: CPU_PARAM) extends Component {

    val io = new apple_riscv_io(param)

    // =========================
    // Wire Declaration
    // =========================
    val pipe_stall = Bool       // pipeline stall indicator
    pipe_stall := False // FIXME
    val not_pipe_stall = !pipe_stall

    // =========================
    // IF Stage Logic
    // =========================

    // program counter
    val pc_inst = program_counter(param)
    pc_inst.io.branch := False
    pc_inst.io.stall := False
    pc_inst.io.pc_in := 0

    // instruction RAM
    io.inst_ram_wen := False
    io.inst_ram_ren := True
    io.inst_ram_addr := pc_inst.io.pc_out(param.INST_RAM_ADDR_WIDTH - 1 downto 0)
    io.inst_ram_data_out := 0

    // =========================
    // IF/ID Pipeline
    // =========================
    val if_id_pc = Reg(UInt(param.PC_WIDTH bits)) init 0
    
    when(not_pipe_stall) {
        if_id_pc := pc_inst.io.pc_out
    }

    // =========================
    // ID stage
    // =========================

    // instruction ram has 1 read latency so data come from the ram directly instead of the pipe stage
    val id_instruction = io.inst_ram_data_out

    // Decoder
    val decoder_inst = instruction_decoder(param)
    decoder_inst.io.inst := id_instruction

    // register file instance
    val register_file_inst = register_file(param)
    register_file_inst.io.rs1_addr := decoder_inst.io.rs1.asUInt
    register_file_inst.io.rs2_addr := decoder_inst.io.rs2.asUInt
    val rs1_data_out = register_file_inst.io.rs1_data_out
    val rs2_data_out = register_file_inst.io.rs2_data_out

    // =========================
    // ID/EX Pipeline
    // =========================

    // instruction field
    val id_ex_rd           = Reg(Bits(5 bits))
    val id_ex_func3        = Reg(Bits(3 bits))
    val id_ex_rs1          = Reg(Bits(5 bits))
    val id_ex_rs2          = Reg(Bits(5 bits))
    val id_ex_func7        = Reg(Bits(7 bits))
    // decoded control signal
    val id_ex_rs1_wen      = Reg(Bool) init False
    val id_ex_rs2_wen      = Reg(Bool) init False
    val id_ex_data_ram_wen = Reg(Bool) init False
    val id_ex_data_ram_ren = Reg(Bool) init False
    val id_ex_alu_la_op    = Reg(Bool) init False
    val id_ex_alu_mem_op   = Reg(Bool) init False
    // register file value
    val id_ex_op1          = Reg(Bits(param.DATA_WIDTH bits))
    val id_ex_op2          = Reg(Bits(param.DATA_WIDTH bits))

    when(not_pipe_stall) {
        id_ex_rd              := decoder_inst.io.rd
        id_ex_func3           := decoder_inst.io.func3
        id_ex_rs1             := decoder_inst.io.rs1
        id_ex_rs2             := decoder_inst.io.rs2
        id_ex_func7           := decoder_inst.io.func7
        id_ex_rs1_wen         := decoder_inst.io.rs1_wen
        id_ex_rs2_wen         := decoder_inst.io.rs2_wen
        id_ex_data_ram_wen    := decoder_inst.io.data_ram_wen
        id_ex_data_ram_ren    := decoder_inst.io.data_ram_ren
        id_ex_alu_la_op       := decoder_inst.io.alu_la_op
        id_ex_alu_mem_op      := decoder_inst.io.alu_mem_op
        id_ex_op1             := register_file_inst.io.rs1_data_out
        // Register re-timing:
        // We select the immediate value and register value at ID stage instead of EX stage
        id_ex_op2             := Mux(decoder_inst.io.imm_sel, decoder_inst.io.imm,
                                    register_file_inst.io.rs2_data_out)
    }

    // =========================
    // EX stage
    // =========================

    val alu_inst = alu(param)
    alu_inst.io.op1         := id_ex_op1
    alu_inst.io.op2         := id_ex_op2
    alu_inst.io.func3       := id_ex_func3
    alu_inst.io.func7       := id_ex_func7
    alu_inst.io.alu_la_op   := id_ex_alu_la_op
    alu_inst.io.alu_mem_op  := id_ex_alu_mem_op

    // =========================
    // EX/Mem Pipeline
    // =========================

    // control signal
    val ex_mem_rs1_wen      = RegNextWhen(id_ex_rs1_wen, not_pipe_stall) init False
    val ex_mem_rs2_wen      = RegNextWhen(id_ex_rs2_wen, not_pipe_stall) init False
    val ex_mem_data_ram_wen = RegNextWhen(id_ex_data_ram_wen, not_pipe_stall) init False
    val ex_mem_data_ram_ren = RegNextWhen(id_ex_data_ram_ren, not_pipe_stall) init False
    // data signal
    val ex_mem_alu_out      = RegNextWhen(alu_inst.io.alu_out, not_pipe_stall)

    // =========================
    // Mem stage
    // =========================

    // Data RAM Logic
    io.data_ram_addr     := ex_mem_alu_out.asUInt(param.DATA_RAM_ADDR_WIDTH - 1 downto 0)
    io.data_ram_data_out := 0
    io.data_ram_wen := ex_mem_data_ram_wen
    io.data_ram_ren := ex_mem_data_ram_ren

    // =========================
    // Mem/WB stage
    // =========================
    // control signal       
    val mem_wb_rs1_wen      = RegNextWhen(ex_mem_rs1_wen, not_pipe_stall) init False
    val mem_wb_rs2_wen      = RegNextWhen(ex_mem_rs2_wen, not_pipe_stall) init False
    // data signal
    val mem_wb_alu_out      = RegNextWhen(ex_mem_alu_out, not_pipe_stall)

    // =========================
    // WB stage
    // =========================

    // Write back to register
    register_file_inst.io.rs1_wen := mem_wb_rs1_wen
    register_file_inst.io.rs2_wen := mem_wb_rs2_wen
    register_file_inst.io.rs1_data_in := mem_wb_alu_out
    register_file_inst.io.rs2_data_in := mem_wb_alu_out
}