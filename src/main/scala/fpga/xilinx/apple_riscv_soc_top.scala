///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: apple_riscv_soc_top
//
// Author: Heqing Huang
// Date Created: 04/26/2021
//
// ================== Description ==================
//
// The SOC top level for FPGA
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package fpga.xilinx

import ip._
import soc._

import spinal.core._
import spinal.lib._
import spinal.lib.com.uart.Uart

case class apple_riscv_soc_top(cfg: soc_cfg) extends Component {

  val io = new Bundle {
    val clk = in Bool
    val gpio0_port = gpio_io(cfg.gpioCfg, useInt = false)
    val gpio1_port = gpio_io(cfg.gpioCfg, useInt = false)
    val uart_port = master(Uart())
  }

  noIoPrefix()

  // Clock domain and PLL
  val clkCtrl = new Area {
    val mmcm_inst = new mmcm
    mmcm_inst.io.clk_in1 := io.clk

    //Create a new clock domain named 'core'
    val coreClockDomain = ClockDomain.internal(
      name = "cpu",
      frequency = FixedFrequency(50 MHz),
      config = ClockDomainConfig(
        clockEdge        = RISING,
        resetKind        = SYNC,
        resetActiveLevel = HIGH
      )
    )

    coreClockDomain.clock := mmcm_inst.io.clk_out1
    coreClockDomain.reset := False
  }

  val cpu = new ClockingArea(clkCtrl.coreClockDomain) {
    val apple_riscv_soc_inst = apple_riscv_soc(cfg)

    apple_riscv_soc_inst.uart_port <> io.uart_port
    apple_riscv_soc_inst.gpio0_port <> io.gpio0_port
    apple_riscv_soc_inst.gpio1_port <> io.gpio1_port

    // tie off the dbg port
    apple_riscv_soc_inst.imem_dbg_sib.sel    := False
    apple_riscv_soc_inst.imem_dbg_sib.enable := False
    apple_riscv_soc_inst.imem_dbg_sib.write  := False
    apple_riscv_soc_inst.imem_dbg_sib.wdata  := 0
    apple_riscv_soc_inst.imem_dbg_sib.addr   := 0
  }


}