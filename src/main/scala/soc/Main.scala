///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: Main
//
// Author: Heqing Huang
// Date Created: 03/27/2021
//
// ================== Description ==================
//
// Main function for the CPU soc
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package soc

import spinal.core._
import core._

// Run this main to generate the RTL

object Main{
  def main(args: Array[String]) {
    val cpu_param = new CPU_PARAM()
    val soc_param = new SOC_PARAM()
    SpinalConfig(
      targetDirectory = "rtl/soc"
    ).generateVerilog(apple_riscv_soc(soc_param, cpu_param))
  }
}