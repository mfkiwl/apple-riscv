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
}

case class alu(param: CPU_PARAM) extends Component {

    val io = new alu_io(param)

    io.alu_out := 0 // set the default output value for the switch

    when (io.alu_la_op) {
        switch(io.func3) {
            is(param.LA_F3_AND) {
                io.alu_out := io.op1 & io.op2
            }
            is(param.LA_F3_OR) {
                io.alu_out := io.op1 | io.op2
            }
            is(param.LA_F3_XOR) {
                io.alu_out := io.op1 ^ io.op2
            }
        }
    }
}