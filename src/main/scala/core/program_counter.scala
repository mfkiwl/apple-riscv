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

case class pc_io(cfg: cpu_cfg) extends Bundle{
    // IO port
    val pc_in  = in UInt(cfg.PC_WIDTH bits)      // branch address calculated from branch unit
    val branch = in Bool                 // takes the branch/jump
    val stall  = in Bool                  // stall the pc
    val pc_out = out UInt(cfg.PC_WIDTH bits)
}

case class program_counter(cfg: cpu_cfg) extends Component {
    val io    = new pc_io(cfg)

    val pc = Reg(UInt(cfg.PC_WIDTH bits)) init 0
    when(!io.stall) {
        when(io.branch) {
            pc := io.pc_in
        } otherwise {
            pc := pc + 4
        }
    }
    io.pc_out := pc
}
