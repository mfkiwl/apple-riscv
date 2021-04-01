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
// - The top level instantiate all the cpu core components.
// - The pipeline logic is written in this file directly to reduce I/O connection.
// - Instruction RAM and Data RAM are out side the cpu core
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._

case class apple_riscv_io(param: CPU_PARAM) extends Bundle {

    // instruction ram
    val inst_ram_wen = out Bool
    val inst_ram_ren = out Bool
    val inst_ram_addr = out UInt(param.INST_RAM_ADDR_WIDTH bits)
    val inst_ram_data_out = out Bits(param.INST_RAM_DATA_WIDTH bits)
    val inst_ram_data_in = in Bits(param.INST_RAM_DATA_WIDTH bits)    // data come 1 cycle after ren

    // data ram
    val data_ram_wen = out Bool
    val data_ram_ren = out Bool
    val data_ram_addr = out UInt(param.DATA_RAM_ADDR_WIDTH bits)
    val data_ram_data_out = out Bits(param.DATA_RAM_DATA_WIDTH bits)
    val data_ram_data_in = in Bits(param.DATA_RAM_DATA_WIDTH bits)    // data come 1 cycle after ren
    val data_ram_byte_enable = out Bits(param.DATA_RAM_DATA_WIDTH / 8 bits)

}

case class apple_riscv (param: CPU_PARAM) extends Component {

    val io = apple_riscv_io(param)

    //////////////////////////////////////////////////////
    //     Pipeline Stage and Component Instantiation   //
    //////////////////////////////////////////////////////

    // =========================
    // Common Wire
    // =========================

    // pipeline stall indicator
    val pipe_stall = False
    val not_pipe_stall = !pipe_stall

    // =========================
    // IF Stage
    // =========================

    // == program counter == //
    val pc_inst = program_counter(param)
    pc_inst.io.branch := False
    pc_inst.io.stall := False
    pc_inst.io.pc_in := 0

    // == instruction RAM == //
    io.inst_ram_wen := False
    io.inst_ram_ren := True
    io.inst_ram_addr := pc_inst.io.pc_out(param.INST_RAM_ADDR_WIDTH - 1 downto 0)
    io.inst_ram_data_out := 0

    // =========================
    // IF/ID Pipeline
    // =========================

    val if_id_pc = RegNextWhen(pc_inst.io.pc_out, not_pipe_stall) init 0

    // =========================
    // ID stage
    // =========================

    // instruction ram has 1 read latency so data come from the ram directly instead of the pipe stage
    val id_instruction = io.inst_ram_data_in

    // == instruction decoder == //
    val decoder_inst = instruction_decoder(param)
    decoder_inst.io.inst := id_instruction

    // == register file == //
    val register_file_inst = register_file(param)
    register_file_inst.io.rs1_rd_addr := decoder_inst.io.rs1
    register_file_inst.io.rs2_rd_addr := decoder_inst.io.rs2
    val rs1_data_out = register_file_inst.io.rs1_data_out
    val rs2_data_out = register_file_inst.io.rs2_data_out

    // =========================
    // ID/EX Pipeline
    // =========================

    // instruction field
    val id_ex_rd = RegNextWhen(decoder_inst.io.rd, not_pipe_stall)
    val id_ex_func3 = RegNextWhen(decoder_inst.io.func3, not_pipe_stall)
    val id_ex_rs1 = RegNextWhen(decoder_inst.io.rs1, not_pipe_stall)
    val id_ex_rs2 = RegNextWhen(decoder_inst.io.rs2, not_pipe_stall)
    val id_ex_func7 = RegNextWhen(decoder_inst.io.func7, not_pipe_stall)

    // decoder signal
    val id_ex_register_wen = RegNextWhen(decoder_inst.io.register_wen, not_pipe_stall) init False
    val id_ex_data_ram_wen = RegNextWhen(decoder_inst.io.data_ram_wen, not_pipe_stall) init False
    val id_ex_data_ram_ren = RegNextWhen(decoder_inst.io.data_ram_ren, not_pipe_stall) init False
    val id_ex_register_rs1_ren = RegNextWhen(decoder_inst.io.register_rs1_ren, not_pipe_stall) init False
    val id_ex_register_rs2_ren = RegNextWhen(decoder_inst.io.register_rs2_ren, not_pipe_stall) init False

    val id_ex_alu_la_op = RegNextWhen(decoder_inst.io.alu_la_op, not_pipe_stall)
    val id_ex_alu_mem_op = RegNextWhen(decoder_inst.io.alu_mem_op, not_pipe_stall)
    val id_ex_imm_sel = RegNextWhen(decoder_inst.io.imm_sel, not_pipe_stall)
    val id_ex_data_ram_access_byte = RegNextWhen(decoder_inst.io.data_ram_access_byte, not_pipe_stall)
    val id_ex_data_ram_access_halfword = RegNextWhen(decoder_inst.io.data_ram_access_halfword, not_pipe_stall)
    val id_ex_data_ram_load_unsigned = RegNextWhen(decoder_inst.io.data_ram_load_unsigned, not_pipe_stall)


    // register file value
    val id_ex_rs1_value = RegNextWhen(register_file_inst.io.rs1_data_out, not_pipe_stall)
    val id_ex_rs2_value = RegNextWhen(register_file_inst.io.rs2_data_out, not_pipe_stall)
    
    // Note: Register re-timing:
    // We select the immediate value and register value at ID stage inst 
    val id_ex_rs2_value_or_imm_next = Mux(decoder_inst.io.imm_sel, decoder_inst.io.imm, register_file_inst.io.rs2_data_out)
    val id_ex_rs2_value_or_imm = RegNextWhen(id_ex_rs2_value_or_imm_next, not_pipe_stall)

    // =========================
    // EX stage
    // =========================

    val id_ex_op1 = Bits(param.DATA_WIDTH bits)
    val id_ex_op2 = Bits(param.DATA_WIDTH bits)

    // ALU instance
    val alu_inst = alu(param)
    alu_inst.io.op1 := id_ex_op1
    alu_inst.io.op2 := id_ex_op2
    alu_inst.io.func3 := id_ex_func3
    alu_inst.io.func7 := id_ex_func7
    alu_inst.io.alu_la_op := id_ex_alu_la_op
    alu_inst.io.alu_mem_op := id_ex_alu_mem_op
    alu_inst.io.alu_imm_sel := id_ex_imm_sel

    // =========================
    // EX/Mem Pipeline
    // =========================

    // control signal
    val ex_mem_register_wen = RegNextWhen(id_ex_register_wen, not_pipe_stall) init False
    val ex_mem_data_ram_wen = RegNextWhen(id_ex_data_ram_wen, not_pipe_stall) init False
    val ex_mem_data_ram_ren = RegNextWhen(id_ex_data_ram_ren, not_pipe_stall) init False
    val ex_mem_data_ram_access_byte = RegNextWhen(id_ex_data_ram_access_byte, not_pipe_stall)
    val ex_mem_data_ram_access_halfword = RegNextWhen(id_ex_data_ram_access_halfword, not_pipe_stall)
    val ex_mem_data_ram_load_unsigned = RegNextWhen(id_ex_data_ram_load_unsigned, not_pipe_stall)

    // data signal
    val ex_mem_alu_out = RegNextWhen(alu_inst.io.alu_out, not_pipe_stall)
    val ex_mem_rs1 = RegNextWhen(id_ex_rs1, not_pipe_stall)
    val ex_mem_rs2 = RegNextWhen(id_ex_rs2, not_pipe_stall)
    val ex_mem_rd = RegNextWhen(id_ex_rd, not_pipe_stall)
    val ex_mem_rs2_value = RegNextWhen(id_ex_rs2_value, not_pipe_stall)

    // =========================
    // Mem stage
    // =========================

    // == Memory Controller == //
    val memory_controller_inst = memory_controller(param)
    // CPU side
    memory_controller_inst.io.cpu2mc_wen := ex_mem_data_ram_wen
    memory_controller_inst.io.cpu2mc_ren := ex_mem_data_ram_ren
    memory_controller_inst.io.cpu2mc_addr := ex_mem_alu_out(param.DATA_RAM_ADDR_WIDTH - 1 downto 0).asUInt   // ALU output is the address
    memory_controller_inst.io.cpu2mc_data := ex_mem_rs2_value        // Write data is in rs2
    memory_controller_inst.io.cpu2mc_LS_byte := ex_mem_data_ram_access_byte
    memory_controller_inst.io.cpu2mc_LS_halfword := ex_mem_data_ram_access_halfword
    memory_controller_inst.io.cpu2mc_LW_unsigned := ex_mem_data_ram_load_unsigned

    // MEM side
    io.data_ram_wen := memory_controller_inst.io.mc2mem_wen
    io.data_ram_ren := memory_controller_inst.io.mc2mem_ren
    io.data_ram_addr := memory_controller_inst.io.mc2mem_addr
    memory_controller_inst.io.mem2mc_data := io.data_ram_data_in
    io.data_ram_data_out := memory_controller_inst.io.mc2mem_data
    io.data_ram_byte_enable := memory_controller_inst.io.mc2mem_byte_enable

    // =========================
    // Mem/WB stage
    // =========================
    // control signal       
    val mem_wb_register_wen = RegNextWhen(ex_mem_register_wen, not_pipe_stall) init False

    // data signal
    val mem_wb_alu_out = RegNextWhen(ex_mem_alu_out, not_pipe_stall)
    val mem_wb_rs1 = RegNextWhen(ex_mem_rs1, not_pipe_stall)
    val mem_wb_rs2 = RegNextWhen(ex_mem_rs2, not_pipe_stall)
    val mem_wb_rd = RegNextWhen(ex_mem_rd, not_pipe_stall)

    // =========================
    // WB stage
    // =========================

    // Write back to register
    register_file_inst.io.register_wen := mem_wb_register_wen
    register_file_inst.io.register_wr_addr := mem_wb_rd
    register_file_inst.io.rd_in := mem_wb_alu_out

    memory_controller_inst.io.mc2cpu_data     

    //////////////////////////////////////////////////////
    //         Other Component / Logic                  //
    //////////////////////////////////////////////////////

    // =========================
    // Forwarding Logic
    // =========================

    val rs1_match_mem = (id_ex_rs1 === ex_mem_rd)
    val rs1_match_wb = (id_ex_rs1 === mem_wb_rd)
    val forward_rs1_from_mem = id_ex_register_rs1_ren & rs1_match_mem
    val forward_rs1_from_wb = id_ex_register_rs1_ren & rs1_match_wb
    when(forward_rs1_from_mem) {
        id_ex_op1 := ex_mem_alu_out
    }.elsewhen(forward_rs1_from_wb) {
        id_ex_op1 := mem_wb_alu_out
    }.otherwise {
        id_ex_op1 := id_ex_rs1_value
    }

    val rs2_match_mem = (id_ex_rs2 === ex_mem_rd)
    val rs2_match_wb = (id_ex_rs2 === mem_wb_rd)
    val forward_rs2_from_mem = id_ex_register_rs2_ren & rs2_match_mem
    val forward_rs2_from_wb = id_ex_register_rs2_ren & rs2_match_wb
    when(forward_rs2_from_mem) {
        id_ex_op2 := ex_mem_alu_out
    }.elsewhen(forward_rs2_from_wb) {
        id_ex_op2 := mem_wb_alu_out
    }.otherwise {
        id_ex_op2 := id_ex_rs2_value_or_imm
    }
}