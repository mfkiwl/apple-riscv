///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: branch unit
//
// Author: Heqing Huang
// Date Created: 04/03/2021
//
// ================== Description ==================
//
// Branch unit.
//
// Calculate the branch address and determine if we branch or not
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._

case class branch_unit_io(param: CPU_PARAM) extends Bundle {
  val branch_result = in Bool                         // Branch result. from alu_out(0)
  val current_pc    = in UInt(param.PC_WIDTH bits)    // pc value for the branch instruction
  val imm_value     = in SInt(param.DATA_WIDTH bits)  // immediate value
  val br_op         = in Bool                         // We get branch instruction
  val target_pc     = out UInt(param.PC_WIDTH bits)
  val branch_taken  = out Bool
  val instruction_address_misaligned_exception = out Bool
}

case class branch_unit(param: CPU_PARAM) extends Component {
  val io = branch_unit_io(param)

  io.branch_taken := (io.br_op & io.branch_result)
  io.target_pc := io.current_pc + io.imm_value.asUInt

  // Check address misaligned exception
  val pc_1_0 = io.target_pc(1 downto 0)
  io.instruction_address_misaligned_exception := (io.branch_taken & (pc_1_0 =/= 0))
}
