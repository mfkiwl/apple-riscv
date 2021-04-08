///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: hazard detection unit
//
// Author: Heqing Huang
// Date Created: 04/08/2021
//
// ================== Description ==================
//
// Hazard Detection Unit
//
// Pipeline Hazard control. Responsible for stalling or flushing pipeline.
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._

case class hdu_io(param: CPU_PARAM) extends Bundle {
  // Control output
  val if_valid  = out Bool
  val id_valid  = out Bool
  val ex_valid  = out Bool
  val mem_valid = out Bool
  val wb_valid  = out Bool

  val if_pipe_stall  = out Bool
  val id_pipe_stall  = out Bool
  val ex_pipe_stall  = out Bool
  val mem_pipe_stall = out Bool
  val wb_pipe_stall  = out Bool

  // input signal
  val branch_taken = in Bool
  val id_rs1_rd  = in Bool          
  val id_rs2_rd  = in Bool
  val ex_dmem_rd = in Bool
  val id_rs1_idx = in UInt(param.RF_ADDR_WDITH bits)
  val id_rs2_idx = in UInt(param.RF_ADDR_WDITH bits)
  val ex_rd_idx = in UInt(param.RF_ADDR_WDITH bits)
}

case class hdu(param: CPU_PARAM) extends Component {
  val io = hdu_io(param)

  // HDU Case 1: Load dependency
  // If there is immediate read data dependence on Load instruction,
  // we need to stall the pipe for one cycle
  // ID   |  EX  |  MEM | WB
  // I1   |  LW  |  OR  | ADD
  // I1   |  NOP |  LW  | OR
  // I2   |  I1  |  NOP | LW
  val id_rs1_depends_on_ex_rd = (io.id_rs1_idx === io.ex_rd_idx) & io.id_rs1_rd
  val id_rs2_depends_on_ex_rd = (io.id_rs2_idx === io.ex_rd_idx) & io.id_rs2_rd
  val stall_on_load_dependence = (id_rs1_depends_on_ex_rd | id_rs2_depends_on_ex_rd) & io.ex_dmem_rd


  // Overall Stall Logic
  io.if_pipe_stall  := stall_on_load_dependence
  io.id_pipe_stall  := stall_on_load_dependence
  io.ex_pipe_stall  := False
  io.mem_pipe_stall := False
  io.wb_pipe_stall  := False

  // Overall Flushing logic
  io.if_valid   := ~io.branch_taken
  io.id_valid   := ~io.branch_taken & ~stall_on_load_dependence
  io.ex_valid   := True
  io.mem_valid  := True
  io.wb_valid   := True
}

