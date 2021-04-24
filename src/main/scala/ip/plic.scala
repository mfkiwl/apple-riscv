///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: plic
//
// Author: Heqing Huang
// Date Created: 04/19/2021
//
// ================== Description ==================
//
// Platform Level Interrupt Controller
//
// A very basic and simple PLIC, not interrupt priority and arbitration.
// Simply oring all the interrupt and generate the external interrupt
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package ip

import sib._
import spinal.core._
import spinal.lib._

case class plic_io() extends Bundle {
  val external_interrupt = out Bool
  val gpio_int           = in Bool
  val timer_int          = in Bool
  val uart_int           = in Bool
}

case class plic_interrupt_gen(busCtrl: SibSlaveFactory, width: Int, addr: Int, interrupt: Bits, intName: String) extends Area {

  // Interrupt Ctrl and Status Register
  val int_en = busCtrl.createReadAndWrite(Bits(width bits), addr    , 0, "PLIC" + intName + "Interrupt Enable")
  val int_pe = busCtrl.createReadAndWrite(Bits(width bits), addr + 4, 0, "PLIC" + intName + "Interrupt Pending")
  // Interrupt Logic
  int_pe   := interrupt
  val int_aggr = int_pe.orR

}

case class plic(sibCfg: SibConfig) extends Component {

  val io = plic_io()
  val plic_sib = slave(Sib(sibCfg))
  val busCtrl  = SibSlaveFactory(plic_sib)

  val timer_int = plic_interrupt_gen(busCtrl, 1, 0x00, io.timer_int.asBits, "Timer")
  val gpio_int  = plic_interrupt_gen(busCtrl, 1, 0x08, io.gpio_int.asBits,  "GPIO")
  val uart_int  = plic_interrupt_gen(busCtrl, 1, 0x10, io.uart_int.asBits,  "Uart")

  io.external_interrupt := timer_int.int_aggr | gpio_int.int_aggr | uart_int.int_aggr
}
