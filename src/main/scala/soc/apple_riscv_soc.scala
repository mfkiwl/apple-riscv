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
    val instruction_ram = instruction_ram_onchip(param)
    instruction_ram.io.wen := cpu_core.io.inst_ram_wen
    instruction_ram.io.ren := cpu_core.io.inst_ram_ren
    instruction_ram.io.addr := cpu_core.io.inst_ram_addr
    instruction_ram.io.data_in := cpu_core.io.inst_ram_data_out
    cpu_core.io.inst_ram_data_in := instruction_ram.io.data_out

    // Data RAM
    val data_ram = data_ram_onchip(param)
    data_ram.io.wen := cpu_core.io.data_ram_wen
    data_ram.io.ren := cpu_core.io.data_ram_ren
    data_ram.io.addr := cpu_core.io.data_ram_addr
    data_ram.io.data_in := cpu_core.io.data_ram_data_out
    cpu_core.io.data_ram_data_in := data_ram.io.data_out

}