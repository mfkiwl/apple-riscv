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
import spinal.lib._
import sib._
import core._
import ip._



case class apple_riscv_soc(soc_param: SOC_PARAM, cpu_param: CPU_PARAM) extends Component {

    // CPU core
    val cpu_core = apple_riscv(cpu_param)
    cpu_core.io.external_interrupt  := False
    cpu_core.io.timer_interrupt     := False
    cpu_core.io.software_interrupt  := False
    cpu_core.io.debug_interrupt     := False

    // soc component instance
    val imem_inst = imem(soc_param)
    val dmem_inst = dmem(soc_param)
    val clic_isnt = clic(soc_param)

    // Imem debug bus
    val imem_dbg_sib = slave(Sib(soc_param.imemSibCfg))
    imem_dbg_sib <> imem_inst.imem_dbg_sib

    // imem switch
    val imemClientSibCfg = Array(soc_param.imemSibCfg)
    val imem_switch = Sib_switch1tN(soc_param.cpuSibCfg, imemClientSibCfg)

    // imem bus connection
    imem_switch.hostSib <> cpu_core.imem_sib
    imem_switch.clientSib(0) <> imem_inst.imem_cpu_sib

    // dmem bus switch
    val dmemClientSibCfg = Array(soc_param.dmemSibCfg, soc_param.clicSibCfg)
    val dmem_switch = Sib_switch1tN(soc_param.cpuSibCfg, dmemClientSibCfg)

    // dmem bus connection
    dmem_switch.hostSib <> cpu_core.dmem_sib            // To CPU
    dmem_switch.clientSib(0) <> dmem_inst.dmem_sib      // To dmem
    dmem_switch.clientSib(1) <> clic_isnt.clic_sib      // To CLIC
}