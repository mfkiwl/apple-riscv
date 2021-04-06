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
    instruction_ram.io.wr := cpu_core.io.instr_ram_wr
    instruction_ram.io.rd := cpu_core.io.instr_ram_rd
    instruction_ram.io.enable := cpu_core.io.instr_ram_enable
    instruction_ram.io.addr := cpu_core.io.instr_ram_addr
    instruction_ram.io.data_in := cpu_core.io.instr_ram_data_out
    cpu_core.io.instr_ram_data_in := instruction_ram.io.data_out

    // Data RAM
    val data_ram = data_ram_model(param)
    data_ram.io.wr := cpu_core.io.data_ram_wr
    data_ram.io.rd := cpu_core.io.data_ram_rd
    data_ram.io.addr := cpu_core.io.data_ram_addr
    data_ram.io.data_in := cpu_core.io.data_ram_data_out
    data_ram.io.byte_en := cpu_core.io.data_ram_byte_en
    cpu_core.io.data_ram_data_in := data_ram.io.data_out

}