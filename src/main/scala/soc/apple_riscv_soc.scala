///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: apple_riscv_soc
//
// Author: Heqing Huang
// Date Created: 03/30/2021
//
// ================== Description ==================
//
// The SOC top level
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package soc

import spinal.core._
import core._
import ip._

case class apple_riscv_soc(param: CPU_PARAM) extends Component {

    // CPU core
    val cpu_core = apple_riscv(param)

    // Instruction RAM
    val instruction_ram = instruction_ram_model(param)
    cpu_core.imem_ahb <> instruction_ram.imem_ahb

    // Data RAM
    val data_ram = data_ram_model(param)
    cpu_core.dmem_ahb <> data_ram.dmem_ahb

}