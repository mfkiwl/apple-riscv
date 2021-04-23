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
import ip._
import spinal.lib.io.InOutWrapper

import spinal.lib.bus.regif.AccessType._
import spinal.lib.bus.regif._


// Run this main to generate the RTL

object Main{
  def main(args: Array[String]) {
    val cpu_param = new CPU_PARAM()
    val soc_param = new SOC_PARAM()
    val gpioCfg   = new GpioCfg(false, false, false, false)
    val spinalCfg = SpinalConfig(
      targetDirectory = "rtl/soc"
    ).generateVerilog(InOutWrapper(apple_riscv_soc(soc_param, cpu_param, gpioCfg)))
  }
}