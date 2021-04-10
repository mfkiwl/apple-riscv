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
import spinal.lib.bus.amba3.ahblite._
import spinal.lib.master

case class apple_riscv_io(param: CPU_PARAM) extends Bundle {}

case class apple_riscv (param: CPU_PARAM) extends Component {

    val io = apple_riscv_io(param)
    val imem_ahb = master(AhbLite3(param.imem_ahbCfg))
    val dmem_ahb = master(AhbLite3(param.dmem_ahbCfg))

    //////////////////////////////////////////////////////
    //     Pipeline Stage and Component Instantiation   //
    //////////////////////////////////////////////////////

    // =========================
    // Wires
    // =========================

    // Place holder for flush and bubble insertion
    // The stage prefix indicate if the instruction in the current stage is valid
    val if_instr_valid  = Bool
    val id_instr_valid  = Bool
    val ex_instr_valid  = Bool
    val mem_instr_valid = Bool
    val wb_instr_valid  = Bool

    // Place holder for the stall/run signal
    // The stage prefix indicate if we need to stall the pipeline entering this stage
    // For example, id_pipe_stall will stall if2id pipeline stage
    val if_pipe_stall  = Bool
    val id_pipe_stall  = Bool
    val ex_pipe_stall  = Bool
    val mem_pipe_stall = Bool
    val wb_pipe_stall  = Bool
    val if_pipe_run    = ~if_pipe_stall
    val id_pipe_run    = ~id_pipe_stall
    val ex_pipe_run    = ~ex_pipe_stall
    val mem_pipe_run   = ~mem_pipe_stall
    val wb_pipe_run    = ~wb_pipe_stall

    // Place holder for branch/jump related signal
    val target_pc    = UInt(param.PC_WIDTH bits)
    val branch_taken = Bool

    // =========================
    // IF Stage
    // =========================

    // == program counter == //
    val pc_inst = program_counter(param)
    pc_inst.io.branch := branch_taken
    pc_inst.io.stall  := if_pipe_stall
    pc_inst.io.pc_in  := target_pc

    // == instruction RAM Controller == //
    val imem_ctrl_inst = imem_ctrl(param)
    imem_ahb <> imem_ctrl_inst.imem_ahb
    imem_ctrl_inst.io.cpu2mc_addr   := pc_inst.io.pc_out(param.INSTR_RAM_ADDR_WIDTH-1 downto 0)
    imem_ctrl_inst.io.cpu2mc_en     := if_pipe_run


    // =========================
    // IF/ID Pipeline
    // =========================

    val if2id_pc          = RegNextWhen(pc_inst.io.pc_out, id_pipe_run) init 0
    val if2id_instr_valid = RegNextWhen(if_instr_valid, id_pipe_run) init False

    // =========================
    // ID stage
    // =========================

    // == instruction decoder == //
    val instr_dec_inst = instr_dec(param)
    instr_dec_inst.io.instr := imem_ctrl_inst.io.mc2cpu_data

    // == register file == //
    val regfile_inst = regfile(param)
    regfile_inst.io.rs1_rd_addr := instr_dec_inst.io.rs1_idx
    regfile_inst.io.rs2_rd_addr := instr_dec_inst.io.rs2_idx
    val rs1_data_out = regfile_inst.io.rs1_data_out
    val rs2_data_out = regfile_inst.io.rs2_data_out

    // =========================
    // ID/EX Pipeline
    // =========================

    // == Control signal == //
    val id2ex_instr_valid   = RegNextWhen(id_instr_valid, ex_pipe_run) init False
    val id2ex_register_wr   = RegNextWhen(instr_dec_inst.io.register_wr       & id_instr_valid, ex_pipe_run) init False
    val id2ex_data_ram_wr   = RegNextWhen(instr_dec_inst.io.data_ram_wr       & id_instr_valid, ex_pipe_run) init False
    val id2ex_data_ram_rd   = RegNextWhen(instr_dec_inst.io.data_ram_rd       & id_instr_valid, ex_pipe_run) init False
    val id2ex_rs1_rd        = RegNextWhen(instr_dec_inst.io.register_rs1_rd   & id_instr_valid, ex_pipe_run) init False
    val id2ex_rs2_rd        = RegNextWhen(instr_dec_inst.io.register_rs1_rd   & id_instr_valid, ex_pipe_run) init False
    val id2ex_branch_op     = RegNextWhen(instr_dec_inst.io.branch_op         & id_instr_valid, ex_pipe_run) init False
    val id2ex_jal_op        = RegNextWhen(instr_dec_inst.io.jal_op            & id_instr_valid, ex_pipe_run) init False
    val id2ex_jalr_op       = RegNextWhen(instr_dec_inst.io.jalr_op           & id_instr_valid, ex_pipe_run) init False

    // == Other signal == //

    // Instruction field
    val id2ex_rd_idx    = RegNextWhen(instr_dec_inst.io.rd_idx , ex_pipe_run)
    val id2ex_func3     = RegNextWhen(instr_dec_inst.io.func3  , ex_pipe_run)
    val id2ex_rs1_idx   = RegNextWhen(instr_dec_inst.io.rs1_idx, ex_pipe_run)
    val id2ex_rs2_idx   = RegNextWhen(instr_dec_inst.io.rs2_idx, ex_pipe_run)
    val id2ex_func7     = RegNextWhen(instr_dec_inst.io.func7  , ex_pipe_run)

    // ALU control signal
    val id2ex_alu_op_and  = RegNextWhen(instr_dec_inst.io.alu_op_and  , ex_pipe_run)
    val id2ex_alu_op_or   = RegNextWhen(instr_dec_inst.io.alu_op_or   , ex_pipe_run)
    val id2ex_alu_op_xor  = RegNextWhen(instr_dec_inst.io.alu_op_xor  , ex_pipe_run)
    val id2ex_alu_op_add  = RegNextWhen(instr_dec_inst.io.alu_op_add  , ex_pipe_run)
    val id2ex_alu_op_sub  = RegNextWhen(instr_dec_inst.io.alu_op_sub  , ex_pipe_run)
    val id2ex_alu_op_sra  = RegNextWhen(instr_dec_inst.io.alu_op_sra  , ex_pipe_run)
    val id2ex_alu_op_srl  = RegNextWhen(instr_dec_inst.io.alu_op_srl  , ex_pipe_run)
    val id2ex_alu_op_sll  = RegNextWhen(instr_dec_inst.io.alu_op_sll  , ex_pipe_run)
    val id2ex_alu_op_slt  = RegNextWhen(instr_dec_inst.io.alu_op_slt  , ex_pipe_run)
    val id2ex_alu_op_sltu = RegNextWhen(instr_dec_inst.io.alu_op_sltu , ex_pipe_run)
    val id2ex_alu_op_eqt  = RegNextWhen(instr_dec_inst.io.alu_op_eqt  , ex_pipe_run)
    val id2ex_alu_op_invb0 = RegNextWhen(instr_dec_inst.io.alu_op_invb0, ex_pipe_run)

    // Data RAM signal
    val id2ex_data_ram_ld_byte   = RegNextWhen(instr_dec_inst.io.data_ram_ld_byte  , ex_pipe_run)
    val id2ex_data_ram_ld_hword  = RegNextWhen(instr_dec_inst.io.data_ram_ld_hword , ex_pipe_run)
    val id2ex_data_ram_ld_unsign = RegNextWhen(instr_dec_inst.io.data_ram_ld_unsign, ex_pipe_run)

    // register file value and immediate value
    val id2ex_rs1_value = RegNextWhen(regfile_inst.io.rs1_data_out, ex_pipe_run)
    val id2ex_rs2_value = RegNextWhen(regfile_inst.io.rs2_data_out, ex_pipe_run)
    val id2ex_imm_value = RegNextWhen(instr_dec_inst.io.imm_value , ex_pipe_run)
    val id2ex_brjp_imm_value = RegNextWhen(instr_dec_inst.io.brjp_imm_value , ex_pipe_run)

    // Others
    val id2ex_pc            = RegNextWhen(if2id_pc, ex_pipe_run)
    val id2ex_op2_sel_imm   = RegNextWhen(instr_dec_inst.io.op2_sel_imm , ex_pipe_run)
    val id2ex_op1_sel_pc    = RegNextWhen(instr_dec_inst.io.op1_sel_pc  ,  ex_pipe_run)
    val id2ex_op1_sel_zero  = RegNextWhen(instr_dec_inst.io.op1_sel_zero,  ex_pipe_run)

    // =========================
    // EX stage
    // =========================

    // Place holder for the final register value after the forwarding logic
    val ex_rs1_value_forwarded = Bits(param.DATA_WIDTH bits)
    val ex_rs2_value_forwarded = Bits(param.DATA_WIDTH bits)

    // ALU instance
    val alu_inst = alu(param)

    // Mux for the ALU operand
    val alu_operand1_muxout  = Mux(id2ex_op1_sel_zero, B"32'h0", Mux(id2ex_op1_sel_pc, id2ex_pc.asBits, ex_rs1_value_forwarded))
    val alu_operand2_muxout  = Mux(id2ex_op2_sel_imm, id2ex_imm_value.asBits, ex_rs2_value_forwarded)

    alu_inst.io.operand_1    := alu_operand1_muxout
    alu_inst.io.operand_2    := alu_operand2_muxout
    alu_inst.io.alu_op_and   := id2ex_alu_op_and
    alu_inst.io.alu_op_or    := id2ex_alu_op_or
    alu_inst.io.alu_op_xor   := id2ex_alu_op_xor
    alu_inst.io.alu_op_add   := id2ex_alu_op_add
    alu_inst.io.alu_op_sub   := id2ex_alu_op_sub
    alu_inst.io.alu_op_sra   := id2ex_alu_op_sra
    alu_inst.io.alu_op_srl   := id2ex_alu_op_srl
    alu_inst.io.alu_op_sll   := id2ex_alu_op_sll
    alu_inst.io.alu_op_slt   := id2ex_alu_op_slt
    alu_inst.io.alu_op_sltu  := id2ex_alu_op_sltu
    alu_inst.io.alu_op_eqt   := id2ex_alu_op_eqt
    alu_inst.io.alu_op_invb0 := id2ex_alu_op_invb0

    // Branch unit instance
    val branch_unit_inst = branch_unit(param)

    branch_unit_inst.io.branch_result   := alu_inst.io.alu_out(0)
    branch_unit_inst.io.current_pc      := id2ex_pc
    branch_unit_inst.io.imm_value       := id2ex_brjp_imm_value
    branch_unit_inst.io.rs1_value       := ex_rs1_value_forwarded
    branch_unit_inst.io.br_op           := id2ex_branch_op
    branch_unit_inst.io.jal_op          := id2ex_jal_op
    branch_unit_inst.io.jalr_op         := id2ex_jalr_op
    target_pc                           := branch_unit_inst.io.target_pc
    branch_taken                        := branch_unit_inst.io.branch_taken
    // FIXME: Exception Logic // = branch_unit_inst.io.instruction_address_misaligned_exception

    // =========================
    // EX/Mem Pipeline
    // =========================

    // == control signal == //
    val ex2mem_instr_valid          = RegNextWhen(ex_instr_valid, mem_pipe_run) init False
    val ex2mem_rd_wr                = RegNextWhen(id2ex_register_wr         & ex_instr_valid, mem_pipe_run) init False
    val ex2mem_data_ram_wr          = RegNextWhen(id2ex_data_ram_wr         & ex_instr_valid, mem_pipe_run) init False
    val ex2mem_data_ram_rd          = RegNextWhen(id2ex_data_ram_rd         & ex_instr_valid, mem_pipe_run) init False
    val ex2mem_data_ram_ld_byte     = RegNextWhen(id2ex_data_ram_ld_byte    & ex_instr_valid, mem_pipe_run)
    val ex2mem_data_ram_ld_hword    = RegNextWhen(id2ex_data_ram_ld_hword   & ex_instr_valid, mem_pipe_run)
    val ex2mem_data_ram_ld_unsign   = RegNextWhen(id2ex_data_ram_ld_unsign  & ex_instr_valid, mem_pipe_run)

    // == other signal == //
    val ex2mem_alu_out   = RegNextWhen(alu_inst.io.alu_out, mem_pipe_run)
    val ex2mem_rs1_idx   = RegNextWhen(id2ex_rs1_idx, mem_pipe_run)
    val ex2mem_rs2_idx   = RegNextWhen(id2ex_rs2_idx, mem_pipe_run)
    val ex2mem_rd_idx    = RegNextWhen(id2ex_rd_idx, mem_pipe_run)
    val ex2mem_rs2_value = RegNextWhen(ex_rs2_value_forwarded, mem_pipe_run)

    // =========================
    // Mem stage
    // =========================

    // == Memory Controller == //
    val dmem_ctrl_isnt = dmem_ctrl(param)

    dmem_ctrl_isnt.dmem_ahb <> dmem_ahb
    // CPU side
    dmem_ctrl_isnt.io.cpu2mc_wr                 := ex2mem_data_ram_wr
    dmem_ctrl_isnt.io.cpu2mc_rd                 := ex2mem_data_ram_rd
    dmem_ctrl_isnt.io.cpu2mc_addr               := ex2mem_alu_out(param.DATA_RAM_ADDR_WIDTH - 1 downto 0).asUInt   // ALU output is the address
    dmem_ctrl_isnt.io.cpu2mc_data               := ex2mem_rs2_value        // Write data is in rs2
    dmem_ctrl_isnt.io.cpu2mc_mem_LS_byte        := ex2mem_data_ram_ld_byte
    dmem_ctrl_isnt.io.cpu2mc_mem_LS_halfword    := ex2mem_data_ram_ld_hword
    dmem_ctrl_isnt.io.cpu2mc_mem_LW_unsigned    := ex2mem_data_ram_ld_unsign


    // =========================
    // Mem/WB stage
    // =========================

    // control signal
    val mem2wb_instr_valid  = RegNextWhen(mem_instr_valid, wb_pipe_run) init False
    val mem2wb_rd_wr  = RegNextWhen(ex2mem_rd_wr  & mem_instr_valid, wb_pipe_run) init False
    val mem2wb_data_ram_rd  = RegNextWhen(ex2mem_data_ram_rd & mem_instr_valid, wb_pipe_run) init False

    // data signal
    val mem2wb_alu_out  = RegNextWhen(ex2mem_alu_out, wb_pipe_run)
    val mem2wb_rd_idx   = RegNextWhen(ex2mem_rd_idx, wb_pipe_run)

    // =========================
    // WB stage
    // =========================

    // == Write back to register == //
    regfile_inst.io.register_wr := mem2wb_rd_wr
    regfile_inst.io.register_wr_addr := mem2wb_rd_idx
    // Select data between memory output and alu output
    val wb_rd_wr_data = Mux(mem2wb_data_ram_rd, dmem_ctrl_isnt.io.mc2cpu_data, mem2wb_alu_out)
    regfile_inst.io.rd_in := wb_rd_wr_data

    //////////////////////////////////////////////////
    //         Other Components                     //
    //////////////////////////////////////////////////

    // =========================
    // FU - Forwarding Unit
    // =========================

    val fu_inst = fu(param)

    fu_inst.io.ex_rs1_idx := id2ex_rs1_idx
    fu_inst.io.ex_rs2_idx := id2ex_rs2_idx
    fu_inst.io.mem_rd_idx := ex2mem_rd_idx
    fu_inst.io.wb_rd_idx  := mem2wb_rd_idx
    fu_inst.io.ex_rs1_rd  := id2ex_rs1_rd
    fu_inst.io.ex_rs2_rd  := id2ex_rs2_rd
    fu_inst.io.mem_rd_wr  := ex2mem_rd_wr
    fu_inst.io.wb_rd_wr   := mem2wb_rd_wr

    ex_rs1_value_forwarded := Mux(fu_inst.io.forward_rs1_from_mem, ex2mem_alu_out,
                                  Mux(fu_inst.io.forward_rs1_from_wb, wb_rd_wr_data, id2ex_rs1_value))
    ex_rs2_value_forwarded := Mux(fu_inst.io.forward_rs2_from_mem, ex2mem_alu_out,
                                  Mux(fu_inst.io.forward_rs2_from_wb, wb_rd_wr_data, id2ex_rs2_value))

    // ===============================
    // HDU - Hazard Detection Unit  //
    // ===============================

    val hdu_inst = hdu(param)
    hdu_inst.io.branch_taken := branch_taken
    hdu_inst.io.id_rs1_rd    := instr_dec_inst.io.register_rs1_rd
    hdu_inst.io.id_rs2_rd    := instr_dec_inst.io.register_rs2_rd
    hdu_inst.io.id_rs1_idx   := instr_dec_inst.io.rs1_idx
    hdu_inst.io.id_rs2_idx   := instr_dec_inst.io.rs2_idx
    hdu_inst.io.ex_dmem_rd   := id2ex_data_ram_rd
    hdu_inst.io.ex_rd_idx    := id2ex_rd_idx

    // valid signal is ANDing the valid signal from HDU and the valid signal from pipe stage
    if_instr_valid  := hdu_inst.io.if_valid
    id_instr_valid  := if2id_instr_valid  & hdu_inst.io.id_valid
    ex_instr_valid  := id2ex_instr_valid  & hdu_inst.io.ex_valid
    mem_instr_valid := ex2mem_instr_valid & hdu_inst.io.mem_valid
    wb_instr_valid  := mem2wb_instr_valid & hdu_inst.io.wb_valid

    if_pipe_stall  :=  hdu_inst.io.if_pipe_stall
    id_pipe_stall  :=  hdu_inst.io.id_pipe_stall
    ex_pipe_stall  :=  hdu_inst.io.ex_pipe_stall
    mem_pipe_stall :=  hdu_inst.io.mem_pipe_stall
    wb_pipe_stall  :=  hdu_inst.io.wb_pipe_stall
}