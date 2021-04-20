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
import mem._
import spinal.lib.bus.amba3.ahblite.AhbLite3
import spinal.lib.slave

case class apple_riscv_soc(soc_param: SOC_PARAM, cpu_param: CPU_PARAM) extends Component {

    val imem_dbg_ahb = slave(AhbLite3(cpu_param.imem_ahbCfg))

    // CPU core
    val cpu_core = apple_riscv(cpu_param)
    cpu_core.io.external_interrupt  := False
    cpu_core.io.timer_interrupt     := False
    cpu_core.io.software_interrupt  := False
    cpu_core.io.debug_interrupt     := False

    // bus controller
    val soc_bus_ctrl_inst = soc_bus_ctrl(soc_param, cpu_param)
    soc_bus_ctrl_inst.imem_from_cpu_ahb <> cpu_core.imem_ahb
    soc_bus_ctrl_inst.dmem_from_cpu_ahb <> cpu_core.dmem_ahb

    // Instruction RAM
    val imem_inst = imem(cpu_param)
    soc_bus_ctrl_inst.bus_ctrl_to_imem_ahb <> imem_inst.imem_cpu_ahb
    imem_dbg_ahb <> imem_inst.imem_dbg_ahb

    // Data RAM
    val dmem_inst = dmem(cpu_param)
    soc_bus_ctrl_inst.bus_ctrl_to_dmem_ahb <> dmem_inst.dmem_ahb
}