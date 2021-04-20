///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: soc_bus_ctrl
//
// Author: Heqing Huang
// Date Created: 04/19/2021
//
// ================== Description ==================
//
// Soc bus controller
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package soc

import core._
import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba3.ahblite.AhbLite3

case class soc_bus_ctrl_io(soc_param: SOC_PARAM, cpu_param: CPU_PARAM) extends Bundle {
  val instr_access_fault = out Bool
  val load_access_fault  = out Bool
  val store_access_fault = out Bool
}

case class soc_bus_ctrl(soc_param: SOC_PARAM, cpu_param: CPU_PARAM) extends Component {
  val io = soc_bus_ctrl_io(soc_param, cpu_param)

  // == defining all the AHB bus == //

  val imem_from_cpu_ahb = slave(AhbLite3(cpu_param.imem_ahbCfg))
  val bus_ctrl_to_imem_ahb = master(AhbLite3(cpu_param.imem_ahbCfg))
  val dmem_from_cpu_ahb = slave(AhbLite3(cpu_param.imem_ahbCfg))
  val bus_ctrl_to_dmem_ahb = master(AhbLite3(cpu_param.imem_ahbCfg))
  //val dmem_to_ahb2apb_brdg_ahb = master(AhbLite3(cpu_param.imem_ahbCfg))

  imem_from_cpu_ahb <> bus_ctrl_to_imem_ahb
  when(imem_from_cpu_ahb.HADDR >= soc_param.AHB_IMEM_LO && imem_from_cpu_ahb.HADDR <= soc_param.AHB_IMEM_HI) {
    bus_ctrl_to_imem_ahb.HSEL := imem_from_cpu_ahb.HSEL
    io.instr_access_fault     := False
  }.otherwise {
    bus_ctrl_to_imem_ahb.HSEL := False
    io.instr_access_fault     := imem_from_cpu_ahb.HSEL
  }

  dmem_from_cpu_ahb <> bus_ctrl_to_dmem_ahb
  when(dmem_from_cpu_ahb.HADDR >= soc_param.AHB_DMEM_LO && dmem_from_cpu_ahb.HADDR <= soc_param.AHB_DMEM_HI) {
    bus_ctrl_to_dmem_ahb.HSEL := dmem_from_cpu_ahb.HSEL
    io.load_access_fault      := False
    io.store_access_fault     := False
  }.otherwise {
    bus_ctrl_to_dmem_ahb.HSEL := False
    io.load_access_fault      := ~dmem_from_cpu_ahb.HWRITE & dmem_from_cpu_ahb.HSEL
    io.store_access_fault     := dmem_from_cpu_ahb.HWRITE & dmem_from_cpu_ahb.HSEL
  }
}
