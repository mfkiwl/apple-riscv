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

case class apple_riscv_soc(param: CPU_PARAM) extends Component {

    val imem_dbg_ahb = slave(AhbLite3(param.imem_ahbCfg))

    // CPU core
    val cpu_core = apple_riscv(param)

    // Instruction RAM
    val imem_inst = imem(param)
    cpu_core.imem_ahb <> imem_inst.imem_cpu_ahb
    imem_dbg_ahb <> imem_inst.imem_dbg_ahb

    // Data RAM
    val dmem_inst = dmem(param)
    cpu_core.dmem_ahb <> dmem_inst.dmem_ahb
}