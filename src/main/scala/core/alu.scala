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
    val alu_imm_sel = in Bool       // Immediate value is selected (meaning the instruction has immediate value)
}

case class alu(param: CPU_PARAM) extends Component {

    val io = new alu_io(param)

    // temp variable
    val op1_signed = io.op1.asSInt
    val op2_signed = io.op2.asSInt
    val add_result = op1_signed + op2_signed
    val sub_result = op1_signed - op2_signed

    //
    // Notes: the shift value is in the same field of op2 for both R-type and I-type
    // For R-type, it's bit [4:0] of register rs2 and rs2 is op2.
    // For I-type, it's bit [4:0] of the immediate value and the immediate value is chosen as op2.
    val shift_value = io.op2.asUInt(4 downto 0)
    //

    // Notes: some R-type and I-type instructions are combined together
    // this is because the mux before op2 has select the correct value based on the instruction type.
    // so here we just need to check the operation, no need to know if it's R-type or I-type (for most of the cases)
    io.alu_out := 0 // set the default output value for the switch
    when (io.alu_la_op) {
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
                when (io.alu_imm_sel) {
                    io.alu_out := add_result.asBits
                }.otherwise {
                    // Note: Only bit 5 in func7 differ for ADD and SUB
                    when (io.func7(5) === True) { // SUB
                        io.alu_out := sub_result.asBits
                    }.otherwise { // ADD
                        io.alu_out := add_result.asBits
                    }
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
}