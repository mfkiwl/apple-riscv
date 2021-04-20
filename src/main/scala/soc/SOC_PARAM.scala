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

import spinal.core._

class SOC_PARAM {
  val NAME = "apple-riscv-soc"

  ////////////////////////////////////////////////////////////////////////////
  //                              Bus Address                               //
  ////////////////////////////////////////////////////////////////////////////
  val ADDR_SIZE = 32

  val AHB_IMEM_LO = Integer.parseInt("00000000", 16)
  val AHB_IMEM_HI = Integer.parseInt("00FFFFFF", 16)

  val AHB_DMEM_LO = Integer.parseInt("01000000", 16)
  val AHB_DMEM_HI = Integer.parseInt("01FFFFFF", 16)

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

  val AHB2APB_BRDG1_LO = B"32'h02000000"
  */

}
