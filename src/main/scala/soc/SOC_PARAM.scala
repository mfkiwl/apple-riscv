///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: SOC_PARAM
//
// Author: Heqing Huang
// Date Created: 04/19/2021
//
// ================== Description ==================
//
// Define basic parameters for the SOC
//
///////////////////////////////////////////////////////////////////////////////////////////////////


package soc

import sib._

class SOC_PARAM {
  val NAME = "apple-riscv-soc"

  ////////////////////////////////////////////////////////////////////////////
  //                              Bus Address                               //
  ////////////////////////////////////////////////////////////////////////////
  val XLEN = 32
  val ADDR_WIDTH = XLEN
  val DATA_WIDTH = XLEN

  val INSTR_RAM_DATA_WIDTH = DATA_WIDTH
  val INSTR_RAM_ADDR_WIDTH = 16                // 64KB Instruction RAM for now
  val DATA_RAM_DATA_WIDTH  = DATA_WIDTH
  val DATA_RAM_ADDR_WIDTH  = 16                // 64KB Data RAM for now

  val SIB_CPU_LO  = Integer.parseInt("00000000", 16)
  val SIB_CPU_HI  = Integer.parseInt("7FFFFFFF", 16)  // Integer can only hold upto 7FFFFFFFF

  val SIB_IMEM_LO = Integer.parseInt("00000000", 16)
  val SIB_IMEM_HI = Integer.parseInt("00FFFFFF", 16)

  val SIB_DMEM_LO = Integer.parseInt("01000000", 16)
  val SIB_DMEM_HI = Integer.parseInt("01FFFFFF", 16)

  /*
  val APB_CLIC_LO = B"32'h02000000"
  val APB_CLIC_HI = B"32'h02000FFF"
  val APB_PLIC_LO = B"32'h02001000"
  val APB_PLIC_HI = B"32'h02001FFF"
  val APB_TMR_LO  = B"32'h02002000"
  val APB_TMR_HI  = B"32'h02002FFF"
  val APB_GPIO_LO = B"32'h02003000"
  val APB_GPIO_HI = B"32'h02003FFF"
  val APB_UART_LO = B"32'h02004000"
  val APB_UART_HI = B"32'h02004FFF"

  val SIB2APB_BRDG1_LO = B"32'h02000000"
  */

  // ========================== //
  //       SIB Bus Config       //
  // ========================== //
  val imemSibCfg = SibConfig(
    addressWidth = INSTR_RAM_ADDR_WIDTH,
    dataWidth    = INSTR_RAM_DATA_WIDTH,
    addr_lo      = SIB_IMEM_LO,
    addr_hi      = SIB_IMEM_HI
  )

  val dmemSibCfg = SibConfig(
    addressWidth = DATA_RAM_ADDR_WIDTH,
    dataWidth    = DATA_RAM_DATA_WIDTH,
    addr_lo      = SIB_DMEM_LO,
    addr_hi      = SIB_DMEM_HI
  )

  val cpuSibCfg = SibConfig(
    addressWidth = XLEN,
    dataWidth    = XLEN,
    addr_lo      = SIB_CPU_LO,
    addr_hi      = SIB_CPU_HI
  )

  // FIXME
  val clicSibCfg = SibConfig(
    addressWidth = DATA_RAM_ADDR_WIDTH,
    dataWidth    = DATA_RAM_DATA_WIDTH
  )
}
