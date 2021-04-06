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
    val param = new CPU_PARAM()
    SpinalConfig(
      targetDirectory = "rtl/soc"
    ).generateVerilog(new apple_riscv_soc(param))
  }
}