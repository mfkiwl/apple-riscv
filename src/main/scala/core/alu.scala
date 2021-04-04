///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: alu
//
// Author: Heqing Huang
// Date Created: 03/29/2021
//
// ================== Description ==================
//
// ALU
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._

case class alu_io(param: CPU_PARAM) extends Bundle {

    // data input/output
    val op1 = in Bits(param.DATA_WIDTH bits)
    val op2 = in Bits(param.DATA_WIDTH bits)
    val alu_out = out Bits(param.DATA_WIDTH bits)

    // ctrl input/output
    val func3       = in Bits(3 bits)
    val func7       = in Bits(7 bits)
    val alu_la_op   = in Bool       // ALU operation is logic and arithmetic
    val alu_mem_op  = in Bool       // ALU operation is calculating memory address.
    val alu_imm_sel = in Bool       // Immediate value is used
    val alu_br_op   = in Bool       // ALU operation is branch
    val alu_lui_op  = in Bool       // ALU operation is for LUI
    val alu_auipc_op = in Bool      // ALU operation is for AUIPC
}

case class alu(param: CPU_PARAM) extends Component {

    val io = new alu_io(param)

    // Preprocess some value and calculate result
    val op1_signed = io.op1.asSInt
    val op2_signed = io.op2.asSInt
    val op1_unsigned = io.op1.asUInt
    val op2_unsigned = io.op2.asUInt
    val add_result = op1_signed + op2_signed
    val sub_result = op1_signed - op2_signed
    val isAddOp = (io.alu_imm_sel | (~io.alu_imm_sel & (io.func7(5) === False)))
    val beq_result = (io.op1 === io.op2)
    val bne_result = ~beq_result
    val blt_result = (op1_signed < op2_signed)
    val bge_result = ~blt_result
    val bltu_result = (op1_unsigned < op2_unsigned)
    val bgeu_result = ~bltu_result

    // Notes: the shift value is in the same field of op2 for both R-type and I-type
    // For R-type, it's bit [4:0] of register rs2 and rs2 is op2.
    // For I-type, it's bit [4:0] of the immediate value and the immediate value is chosen as op2.
    val shift_value = io.op2.asUInt(4 downto 0)

    // Notes: some R-type and I-type instructions are combined together
    // this is because the mux before op2 has select the correct value based on the instruction type.
    // so here we just need to check the operation, no need to know if it's R-type or I-type (for most of the cases)
    io.alu_out := 0 // set the default output value for the switch
    val alu_op_ctrl = io.alu_la_op ## io.alu_mem_op ## io.alu_br_op ## io.alu_lui_op ## io.alu_auipc_op

    // TODO: Optimize the logic if ALU is the critical path
    // TODO: Check the instruction again based on the RISC-V SPEC
    // TODO: Check if we can optimize the logic, remove redundant computation. => compute common logic first then select here
    // TODO: Check if we can use a better encoding here. Maybe we can decode the logic at the ID stage and create another set of ctrl opcode for ALU
    switch(alu_op_ctrl) {
        // io.alu_la_op
        is (B"10000") {
            switch(io.func3) {
                // AND, ANDI
                is(param.LA_F3_AND) {
                    io.alu_out := io.op1 & io.op2
                }
                // OR, ORI
                is(param.LA_F3_OR) {
                    io.alu_out := io.op1 | io.op2
                }
                // XOR, XORI
                is(param.LA_F3_XOR) {
                    io.alu_out := io.op1 ^ io.op2
                }
                // TODO: Optimize the adder logic?
                // ADD, ADDI, SUB
                is(param.LA_F3_ADD_SUB) {
                    // ANDI (Note: no SUBI instruction)
                    when (isAddOp === True) {
                        io.alu_out := add_result.asBits
                    }.otherwise {
                        io.alu_out := sub_result.asBits
                    }
                }
                // SRL, SRA, SRLI, SRLAI
                is(param.LA_F3_SR) {
                    when(io.func7(5) === True) {   // SRA, SRAI - arithmetic right shift
                        io.alu_out := (io.op1.asSInt >> shift_value).asBits
                    }.otherwise {   // SRL, SRLI - logic right shift
                        io.alu_out := io.op1 |>> shift_value
                    }
                }
                // SLL, SLLI
                is(param.LA_F3_SL) {
                    io.alu_out := io.op1 |<< shift_value
                }
                // SLT, SLTI
                is(param.LA_F3_SLT) {
                    io.alu_out := 0
                    io.alu_out(0) := (op1_signed < op2_signed)
                }
                // SLTU, SLTUI
                is(param.LA_F3_SLTU) {
                    io.alu_out := 0
                    io.alu_out(0) := (io.op1.asUInt < io.op2.asUInt)
                }
            }
        }
        // io.alu_mem_op
        is(B"01000") {
            io.alu_out := add_result.asBits
        }
        // io.alu_br_op
        is(B"00100") {
            switch(io.func3) {
                is(param.BR_F3_BEQ) {
                    io.alu_out(0) := beq_result
                }
                is(param.BR_F3_BNE) {
                    io.alu_out(0) := bne_result
                }
                is(param.BR_F3_BLT) {
                    io.alu_out(0) := blt_result
                }
                is(param.BR_F3_BGE) {
                    io.alu_out(0) := bge_result
                }
                is(param.BR_F3_BLTU) {
                    io.alu_out(0) := bltu_result
                }
                is(param.BR_F3_BGEU) {
                    io.alu_out(0) := bgeu_result
                }
            }
        }
        // io.alu_br_op
        is(B"00010") {
            io.alu_out := io.op2 // op2 is the immediate value
        }
        // io.alu_auipc_op
        is(B"00001") {
            io.alu_out := add_result.asBits
        }
    }
}