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
    val inst_ram_enable = out Bool
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

    // Place holder for inserting NOP instruction
    // The stage prefix indicate if the instruction in the current stage is valid
    val if_inst_valid = Bool
    val id_inst_valid = Bool
    val ex_inst_valid = Bool
    val mem_inst_valid = Bool
    val wb_inst_valid = Bool

    // Place holder for the stall/run signal
    // The stage prefix indicate if we need to stall the pipeline entering this stage
    // For example, id_pipe_stall will stall if_id pipeline stage
    val if_pipe_stall = Bool
    val id_pipe_stall = Bool
    val ex_pipe_stall = False
    val mem_pipe_stall = False
    val wb_pipe_stall = False
    val if_pipe_run = ~if_pipe_stall
    val id_pipe_run = ~id_pipe_stall
    val ex_pipe_run = ~ex_pipe_stall
    val mem_pipe_run = ~mem_pipe_stall
    val wb_pipe_run = ~wb_pipe_stall

    // Place holder for branch/jump related signal
    val target_pc = UInt(param.PC_WIDTH bits)
    val branch_taken = Bool

    // =========================
    // IF Stage
    // =========================

    // == program counter == //
    val pc_inst = program_counter(param)
    pc_inst.io.branch := branch_taken
    pc_inst.io.stall := if_pipe_stall
    pc_inst.io.pc_in := target_pc

    // == instruction RAM == //
    io.inst_ram_wen := False
    io.inst_ram_ren := True
    io.inst_ram_enable := if_pipe_run
    io.inst_ram_addr := pc_inst.io.pc_out(param.INST_RAM_ADDR_WIDTH - 1 downto 0)
    io.inst_ram_data_out := 0

    // =========================
    // IF/ID Pipeline
    // =========================

    val if_id_pc = RegNextWhen(pc_inst.io.pc_out, id_pipe_run) init 0
    val if_id_inst_valid = RegNextWhen(if_inst_valid, id_pipe_run) init False

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

    // == Control signal == //
    val id_ex_inst_valid = RegNextWhen(id_inst_valid, ex_pipe_run) init False
    val id_ex_register_wen = RegNextWhen(decoder_inst.io.register_wen & id_inst_valid, ex_pipe_run) init False
    val id_ex_data_ram_wen = RegNextWhen(decoder_inst.io.data_ram_wen & id_inst_valid, ex_pipe_run) init False
    val id_ex_data_ram_ren = RegNextWhen(decoder_inst.io.data_ram_ren & id_inst_valid, ex_pipe_run) init False
    val id_ex_register_rs1_ren = RegNextWhen(decoder_inst.io.register_rs1_ren & id_inst_valid, ex_pipe_run) init False
    val id_ex_register_rs2_ren = RegNextWhen(decoder_inst.io.register_rs2_ren & id_inst_valid, ex_pipe_run) init False

    // == Other signal == //

    // Instruction field
    val id_ex_rd = RegNextWhen(decoder_inst.io.rd, ex_pipe_run)
    val id_ex_func3 = RegNextWhen(decoder_inst.io.func3, ex_pipe_run)
    val id_ex_rs1 = RegNextWhen(decoder_inst.io.rs1, ex_pipe_run)
    val id_ex_rs2 = RegNextWhen(decoder_inst.io.rs2, ex_pipe_run)
    val id_ex_func7 = RegNextWhen(decoder_inst.io.func7, ex_pipe_run)

    // ALU control signal
    val id_ex_alu_la_op = RegNextWhen(decoder_inst.io.alu_la_op, ex_pipe_run)
    val id_ex_alu_mem_op = RegNextWhen(decoder_inst.io.alu_mem_op, ex_pipe_run)
    val id_ex_imm_sel = RegNextWhen(decoder_inst.io.imm_sel, ex_pipe_run)
    val id_ex_br_op = RegNextWhen(decoder_inst.io.br_op, ex_pipe_run)
    val id_ex_data_ram_access_byte = RegNextWhen(decoder_inst.io.data_ram_access_byte, ex_pipe_run)
    val id_ex_data_ram_access_halfword = RegNextWhen(decoder_inst.io.data_ram_access_halfword, ex_pipe_run)
    val id_ex_data_ram_load_unsigned = RegNextWhen(decoder_inst.io.data_ram_load_unsigned, ex_pipe_run)
    
    // register file value and immediate value
    val id_ex_rs1_value = RegNextWhen(register_file_inst.io.rs1_data_out, ex_pipe_run)
    val id_ex_rs2_value = RegNextWhen(register_file_inst.io.rs2_data_out, ex_pipe_run)
    val id_ex_imm_value = RegNextWhen(decoder_inst.io.imm_value, ex_pipe_run)

    // PC
    val id_ex_pc = RegNextWhen(if_id_pc, ex_pipe_run)

    // =========================
    // EX stage
    // =========================

    // Place holder for the final register value after the forwarding logic
    val ex_rs1_value_forwarded = Bits(param.DATA_WIDTH bits)
    val ex_rs2_value_forwarded = Bits(param.DATA_WIDTH bits)

    // == signed extend the immediate value == //
    val imm_value = (id_ex_imm_value.resize(param.DATA_WIDTH))

    // ALU instance
    val alu_inst = alu(param)
    alu_inst.io.op1 := ex_rs1_value_forwarded
    val alu_op2_mux_out = Mux(id_ex_imm_sel, imm_value.asBits, ex_rs2_value_forwarded)
    alu_inst.io.op2 := alu_op2_mux_out
    alu_inst.io.func3 := id_ex_func3
    alu_inst.io.func7 := id_ex_func7
    alu_inst.io.alu_la_op := id_ex_alu_la_op
    alu_inst.io.alu_mem_op := id_ex_alu_mem_op
    alu_inst.io.alu_imm_sel := id_ex_imm_sel
    alu_inst.io.alu_br_op := id_ex_br_op

    // Branch unit instance
    val branch_unit_inst = branch_unit(param)

    // TODO: Potential optimization. Dedicated branch result calculation instead of using ALU
    branch_unit_inst.io.branch_result := alu_inst.io.alu_out(0)
    branch_unit_inst.io.current_pc := id_ex_pc
    branch_unit_inst.io.imm_value := id_ex_imm_value
    branch_unit_inst.io.br_op := id_ex_br_op
    target_pc := branch_unit_inst.io.target_pc
    branch_taken := branch_unit_inst.io.branch_taken
    // FIXME: Exception Logic // = branch_unit_inst.io.instruction_address_misaligned_exception


    // =========================
    // EX/Mem Pipeline
    // =========================

    // control signal
    val ex_mem_inst_valid = RegNextWhen(ex_inst_valid, mem_pipe_run) init False
    val ex_mem_register_wen = RegNextWhen(id_ex_register_wen & ex_inst_valid, mem_pipe_run) init False
    val ex_mem_data_ram_wen = RegNextWhen(id_ex_data_ram_wen & ex_inst_valid, mem_pipe_run) init False
    val ex_mem_data_ram_ren = RegNextWhen(id_ex_data_ram_ren & ex_inst_valid, mem_pipe_run) init False
    val ex_mem_data_ram_access_byte = RegNextWhen(id_ex_data_ram_access_byte & ex_inst_valid, mem_pipe_run)
    val ex_mem_data_ram_access_halfword = RegNextWhen(id_ex_data_ram_access_halfword & ex_inst_valid, mem_pipe_run)
    val ex_mem_data_ram_load_unsigned = RegNextWhen(id_ex_data_ram_load_unsigned & ex_inst_valid, mem_pipe_run)

    // data signal
    val ex_mem_alu_out = RegNextWhen(alu_inst.io.alu_out, mem_pipe_run)
    val ex_mem_rs1 = RegNextWhen(id_ex_rs1, mem_pipe_run)
    val ex_mem_rs2 = RegNextWhen(id_ex_rs2, mem_pipe_run)
    val ex_mem_rd = RegNextWhen(id_ex_rd, mem_pipe_run)
    val ex_mem_rs2_value = RegNextWhen(ex_rs2_value_forwarded, mem_pipe_run)

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
    memory_controller_inst.io.cpu2mc_mem_LS_byte := ex_mem_data_ram_access_byte
    memory_controller_inst.io.cpu2mc_mem_LS_halfword := ex_mem_data_ram_access_halfword
    memory_controller_inst.io.cpu2mc_mem_LW_unsigned := ex_mem_data_ram_load_unsigned
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

    val mem_wb_inst_valid = RegNextWhen(mem_inst_valid, wb_pipe_run) init False

    // control signal       
    val mem_wb_register_wen = RegNextWhen(ex_mem_register_wen & mem_inst_valid, wb_pipe_run) init False
    val mem_wb_data_ram_ren = RegNextWhen(ex_mem_data_ram_ren & mem_inst_valid, wb_pipe_run) init False

    // data signal
    val mem_wb_alu_out = RegNextWhen(ex_mem_alu_out, wb_pipe_run)
    val mem_wb_rs1 = RegNextWhen(ex_mem_rs1, wb_pipe_run)
    val mem_wb_rs2 = RegNextWhen(ex_mem_rs2, wb_pipe_run)
    val mem_wb_rd = RegNextWhen(ex_mem_rd, wb_pipe_run)

    // =========================
    // WB stage
    // =========================

    // == Write back to register == //
    register_file_inst.io.register_wen := mem_wb_register_wen
    register_file_inst.io.register_wr_addr := mem_wb_rd
    // Select data between memory output and alu output
    val wb_rd_wr_data = Mux(mem_wb_data_ram_ren, memory_controller_inst.io.mc2cpu_data, mem_wb_alu_out)
    register_file_inst.io.rd_in := wb_rd_wr_data

    //////////////////////////////////////////////////////
    //         Other Component / Logic                  //
    //////////////////////////////////////////////////////

    // =========================
    // FU - Forwarding Unit
    // =========================

    // == EX stage == //
    val rs1_match_mem = (id_ex_rs1 === ex_mem_rd)
    val rs1_match_wb = (id_ex_rs1 === mem_wb_rd)
    val forward_rs1_from_mem = id_ex_register_rs1_ren & rs1_match_mem & ex_mem_register_wen
    val forward_rs1_from_wb = id_ex_register_rs1_ren & rs1_match_wb & mem_wb_register_wen
    when(forward_rs1_from_mem) {
        ex_rs1_value_forwarded := ex_mem_alu_out
    }.elsewhen(forward_rs1_from_wb) {
        ex_rs1_value_forwarded := wb_rd_wr_data
    }.otherwise {
        ex_rs1_value_forwarded := id_ex_rs1_value
    }

    val rs2_match_mem = (id_ex_rs2 === ex_mem_rd)
    val rs2_match_wb = (id_ex_rs2 === mem_wb_rd)
    val forward_rs2_from_mem = id_ex_register_rs2_ren & rs2_match_mem & ex_mem_register_wen
    val forward_rs2_from_wb = id_ex_register_rs2_ren & rs2_match_wb & mem_wb_register_wen
    when(forward_rs2_from_mem) {
        ex_rs2_value_forwarded := ex_mem_alu_out
    }.elsewhen(forward_rs2_from_wb) {
        ex_rs2_value_forwarded := wb_rd_wr_data
    }.otherwise {
        ex_rs2_value_forwarded := id_ex_rs2_value
    }

    // =================================
    // HDU - Hazard Detection Unit
    // =================================

    // Default
    if_inst_valid := ~branch_taken
    ex_inst_valid := id_ex_inst_valid
    mem_inst_valid := ex_mem_inst_valid
    wb_inst_valid := mem_wb_inst_valid

    // Case 1: Load dependency
    // If there is immediate data dependence on Load instruction, we need to stall the pipe for one cycle
    // ID   |  EX  |  MEM | WB
    // I1   |  LW  |  OR  | ADD
    // I1   |  NOP |  LW  | OR
    // I2   |  I1  |  NOP | LW
    val id_rs1_depends_on_ex_rd = (decoder_inst.io.rs1 === id_ex_rd) & decoder_inst.io.register_rs1_ren
    val id_rs2_depends_on_ex_rd = (decoder_inst.io.rs2 === id_ex_rd) & decoder_inst.io.register_rs2_ren
    val stall_on_load_dependence = (id_rs1_depends_on_ex_rd | id_rs2_depends_on_ex_rd) & id_ex_data_ram_ren
    // Stall
    when(stall_on_load_dependence) {
        if_pipe_stall := True
        id_pipe_stall := True
    }.otherwise {
        if_pipe_stall := False
        id_pipe_stall := False
    }
    // Insert Nop
    when(stall_on_load_dependence) {
        id_inst_valid := False
    }.otherwise {
        id_inst_valid := if_id_inst_valid & ~branch_taken
    }

    // =================================
    // Branch
    // =================================
}