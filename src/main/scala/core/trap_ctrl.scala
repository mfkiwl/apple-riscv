///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: trap ctrl
//
// Author: Heqing Huang
// Date Created: 04/17/2021
//
// ================== Description ==================
//
// Trap controller.
//
// Process all the exception/interrupt at WB stage
//
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._

case class trap_ctrl_io(param: CPU_PARAM) extends Bundle {

  // exception signal
  val load_addr_misalign                = in Bool
  val store_addr_misalign               = in Bool
  val illegal_instr_exception           = in Bool
  val instr_addr_misalign_exception     = in Bool

  // info
  val wb_pc         = in UInt(param.PC_WIDTH bits)
  val wb_instr      = in Bits(param.XLEN bits)
  val wb_dmem_addr  = in UInt(param.DATA_RAM_ADDR_WIDTH bits)

  // mcsr output
  val mtrap_enter  = out Bool
  val mtrap_exit   = out Bool
  val mtrap_mepc   = out Bits(param.PC_WIDTH bits)
  val mtrap_mcause = out Bits(param.MXLEN bits)
  val mtrap_mtval  = out Bits(param.MXLEN bits)
  val mtrap_mtvec  = in  Bits(param.PC_WIDTH bits)

  // pc control
  val pc_trap     = out Bool
  val pc_value    = out UInt(param.PC_WIDTH bits)
}

case class trap_ctrl(param: CPU_PARAM) extends Component {
  val io = trap_ctrl_io(param)

  val dmem_addr_exception = io.load_addr_misalign | io.store_addr_misalign
  val exception = dmem_addr_exception | io.illegal_instr_exception | io.instr_addr_misalign_exception

  // logic for exception code
  val exception_code = Bits(param.MXLEN - 1 bits)

  io.mtrap_enter  := exception
  io.mtrap_exit   := False // FIXME
  io.mtrap_mepc   := io.wb_pc.asBits // FIXME
  io.mtrap_mcause := False ## exception_code // FIXME
  io.mtrap_mtval  := Mux(io.illegal_instr_exception, io.wb_instr, io.wb_dmem_addr.asBits.resized)

  io.pc_trap      := exception
  io.pc_value     := io.mtrap_mtvec.asUInt.resized

}
