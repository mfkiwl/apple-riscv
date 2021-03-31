///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: program counter
//
// Author: Heqing Huang
// Date Created: 03/27/2021
//
// ================== Description ==================
//
// PC register
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._

case class pc_io(param: CPU_PARAM) extends Bundle{
    // IO port
    val pc_in  = in UInt(param.PC_WIDTH bits)      // branch address calculated from branch unit
    val branch = in Bool                 // takes the branch/jump
    val stall  = in Bool                  // stall the pc
    val pc_out = out UInt(param.PC_WIDTH bits)
}

case class program_counter(param: CPU_PARAM) extends Component {
    val io    = pc_io(param)

    val pc = Reg(UInt(param.PC_WIDTH bits)) init 0
    when(!io.stall) {
        when(io.branch) {
            pc := io.pc_in
        } otherwise {
            pc := pc + 4
        }
    }
    io.pc_out := pc
}
