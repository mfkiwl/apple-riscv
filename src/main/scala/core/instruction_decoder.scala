///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: instruction decoder
//
// Author: Heqing Huang
// Date Created: 03/27/2021
//
// ================== Description ==================
//
// Instruction decoder module
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._

case class dec_io(param: CPU_PARAM) extends Bundle{
    val inst = in Bits(param.DATA_WIDTH bits)   // instruction input

    // Instruction field
    val opcode = out Bits(7 bits)  // FIXME? Do we need this as output?
    val rd = out UInt(5 bits)
    val func3 = out Bits(3 bits)
    val rs1 = out UInt(5 bits)
    val rs2 = out UInt(5 bits)
    val func7 = out Bits(7 bits)

    // Register file control
    val register_wen = out Bool
    val register_rs1_ren = out Bool
    val register_rs2_ren = out Bool

    // Memory control
    val data_ram_wen = out Bool
    val data_ram_ren = out Bool
    val data_ram_access_byte = out Bool         // load/store byte
    val data_ram_access_halfword = out Bool     // load/store half word
    val data_ram_load_unsigned = out Bool       // load unsigned

    // ALU control
    val imm_sel = out Bool          // select immediate number as op2
    val alu_la_op = out Bool        // ALU operation is logic and arithmetic
    val alu_mem_op = out Bool       // ALU operation is store and load
    val br_op = out Bool        // ALU operation is branch

    // Other signal
    val imm_value = out SInt(param.DATA_WIDTH bits)   // Immediate value
}

case class instruction_decoder(param: CPU_PARAM) extends Component {
    val io = dec_io(param)

    // ============================================
    // Extract each field from the instruction
    // ============================================
    io.opcode := io.inst(6 downto 0)
    io.rd := io.inst(11 downto 7).asUInt
    io.func3 := io.inst(14 downto 12)
    io.rs1 := io.inst(19 downto 15).asUInt
    io.rs2 := io.inst(24 downto 20).asUInt
    io.func7 := io.inst(31 downto 25)

    // ============================================     
    // Main Decoder Logic
    // ============================================
    val op_logic_arithm = (io.opcode === param.OP_LOGIC_ARITH)
    val op_logic_arithm_imm = (io.opcode === param.OP_LOGIC_ARITH_IMM)
    val op_store = (io.opcode === param.OP_MEM_STORE)
    val op_load = (io.opcode === param.OP_MEM_LOAD)
    val op_branch = (io.opcode === param.OP_BRANCH)
    val op_lui = (io.opcode === param.OP_LUI)
    val op_auipc = (io.opcode === param.OP_AUIPC)

    io.imm_sel := (op_logic_arithm_imm | op_load | op_store)
    io.register_wen := (op_logic_arithm | op_logic_arithm_imm | op_load)     // TODO: Can we simplify this logic?
    io.register_rs1_ren := (op_logic_arithm | op_logic_arithm_imm | op_load | op_store)
    io.register_rs2_ren := op_logic_arithm | op_store
    io.data_ram_wen := op_store
    io.data_ram_ren := op_load
    io.data_ram_access_byte := (io.func3 === param.LS_F3_LB_SB | io.func3 === param.LS_F3_LBU)
    io.data_ram_access_halfword := (io.func3 === param.LS_F3_LH_SH | io.func3 === param.LS_F3_LHU)
    io.data_ram_load_unsigned := (io.func3 === param.LS_F3_LBU) | (io.func3 === param.LS_F3_LHU)

    // Some optimization for ALU here. Decode the instruction to just single control signal so
    // ALU can save the timing for decode logic
    io.alu_la_op := op_logic_arithm | op_logic_arithm_imm
    io.alu_mem_op := op_store | op_load
    io.br_op := op_branch

    // Immediate value
    io.imm_value := 0
    when(op_logic_arithm_imm | op_load) {
        // Immediate value are signed extended to 32 bits for logic/arithmetic operation
        val imm_11_0 = io.inst(31 downto 20).asSInt
        io.imm_value := imm_11_0.resized
    }.elsewhen(op_branch) {
        val imm_0 = False
        val imm_4_1 = io.inst(11 downto 8)
        val imm_10_5 = io.inst(30 downto 25)
        val imm_11 = io.inst(7)
        val imm_12 = io.inst(31)
        val imm_12_0 = imm_12 ## imm_11 ## imm_10_5 ## imm_4_1 ## imm_0
        io.imm_value := imm_12_0.asSInt.resized
    }.elsewhen(op_store) {
        // Immediate value are signed extended to 32 bits for story operation
        val imm_4_0 = io.inst(11 downto 7)
        val imm_11_5 = io.inst(31 downto 25)
        val imm_11_0 = imm_11_5 ## imm_4_0
        io.imm_value := imm_11_0.asSInt.resized
    }

    // FIXME: Need additional logic to determine if the instruction is valid
}