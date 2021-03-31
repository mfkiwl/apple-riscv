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
    val inst        = in Bits(param.DATA_WIDTH bits)   // instruction input

    // Instruction field
    val opcode      = out Bits(7 bits)  // FIXME? Do we need this as output?
    val rd          = out UInt(5 bits)
    val func3       = out Bits(3 bits)
    val rs1         = out UInt(5 bits)
    val rs2         = out UInt(5 bits)
    val func7       = out Bits(7 bits)

    // Register file control
    val rs1_wen    = out Bool
    val rs2_wen    = out Bool

    // Memory control
    val data_ram_wen = out Bool
    val data_ram_ren = out Bool

    // ALU control
    val imm_sel         = out Bool      // select immediate number as op2
    val alu_la_op       = out Bool      // ALU operation is logic and arithmetic
    val alu_mem_op      = out Bool      // ALU operation is store and load

    // Other signal
    val imm         = out Bits(param.DATA_WIDTH bits)
}

case class instruction_decoder(param: CPU_PARAM) extends Component {
    val io          = dec_io(param)

    // ============================================
    // Extract each field from the instruction
    // ============================================
    io.opcode  := io.inst(6 downto 0)
    io.rd      := io.inst(11 downto 7).asUInt
    io.func3   := io.inst(14 downto 12)
    io.rs1     := io.inst(19 downto 15).asUInt
    io.rs2     := io.inst(24 downto 20).asUInt
    io.func7   := io.inst(31 downto 25)

    // ============================================     
    // Main Decoder Logic
    // ============================================
    val op_logic_arithm = (io.opcode === param.OP_LOGIC_ARITH)
    val op_logic_arithm_imm = (io.opcode === param.OP_LOGIC_ARITH_IMM)
    val op_store = (io.opcode === param.OP_MEM_STORE)
    val op_load = (io.opcode === param.OP_MEM_LOAD)
    val op_lui = (io.opcode === param.OP_LUI)
    val op_auipc = (io.opcode === param.OP_AUIPC)

    io.imm_sel := op_logic_arithm_imm
    io.rs1_wen := (op_logic_arithm | op_logic_arithm_imm | op_load)     // TODO: Can we simplify this logic?
    io.rs2_wen := io.rs1_wen
    io.data_ram_wen := op_store
    io.data_ram_ren := op_load

    // Some optimization for ALU here. Decode the instruction to just single control signal so
    // ALU can save the timing for decode logic
    io.alu_la_op := op_logic_arithm | op_logic_arithm_imm
    io.alu_mem_op := op_store | op_load

    // Immediate value
    io.imm     := 0 // Default
    when(op_logic_arithm_imm) {
        val lowerBits: SInt = io.inst(31 downto 20).asSInt
        io.imm := (lowerBits.resize(param.DATA_WIDTH)).asBits

    }
}