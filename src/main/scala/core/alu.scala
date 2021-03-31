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
    val alu_imm_sel = in Bool       // Immediate value is selected
}

case class alu(param: CPU_PARAM) extends Component {

    val io = new alu_io(param)

    io.alu_out := 0 // set the default output value for the switch

    // temp variable
    val op1_signed = io.op1.asSInt
    val op2_signed = io.op2.asSInt
    val add_result = op1_signed + op2_signed
    val sub_result = op1_signed - op2_signed

    // Notes: the shift value is in the same field for both R-type and I-type
    // For R-type, it's bit [4:0] of register rs2 and rs2 is op2.
    // For I-type, it's bit [4:0] of the immediate value and the immediate value is chosen as op2.
    val shift_value = io.op2.asUInt(4 downto 0)

    when (io.alu_la_op) {
        switch(io.func3) {
            is(param.LA_F3_AND) {   // AND/ANDI
                io.alu_out := io.op1 & io.op2
            }
            is(param.LA_F3_OR) {    // OR/ORI
                io.alu_out := io.op1 | io.op2
            }
            is(param.LA_F3_XOR) {   // XOR/XORI
                io.alu_out := io.op1 ^ io.op2
            }
            // TODO: Optimize the adder logic?
            is(param.LA_F3_ADD_SUB) {
                when (io.alu_imm_sel) { // ANDI (no SUBI)
                    io.alu_out := add_result.asBits
                }.otherwise { // ADD or SUB
                    when (io.func7(5) === True) { // SUB
                        io.alu_out := sub_result.asBits
                    }.otherwise { // ADD
                        io.alu_out := add_result.asBits
                    }
                }
            }
            is(param.LA_F3_SR) {    // SRL, SRA, SRLI, SRLAI
                when(io.func7(5) === True) {   // SRA, SRAI - arithmetic right shift
                    io.alu_out := (io.op1.asSInt >> shift_value).asBits
                }.otherwise {   // SRL, SRLI - logic right shift
                    io.alu_out := io.op1 |>> shift_value
                }
            }
            is(param.LA_F3_SL) {    // SLL, SLLI
                io.alu_out := io.op1 |<< shift_value
            }
            is(param.LA_F3_SLT) {   // SLT, SLTI
                io.alu_out := 0
                io.alu_out(0) := (op1_signed < op2_signed)
            }
            is(param.LA_F3_SLTU) {   // SLTU, SLTUI
                io.alu_out := 0
                io.alu_out(0) := (io.op1.asUInt < io.op2.asUInt)
            }
        }
    }
}