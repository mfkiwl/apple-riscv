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
// Main function for the CPU core
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._

// Run this main to generate the RTL

object Main{
  def main(args: Array[String]) {
    val cfg = new cpu_cfg
    SpinalConfig(
      targetDirectory = "rtl/core"
    ).generateVerilog(new program_counter(cfg)).printPruned()

    SpinalConfig(
      targetDirectory = "rtl/core"
    ).generateVerilog(new register_file(cfg)).printPruned()
  }
}