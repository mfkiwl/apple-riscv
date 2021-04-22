///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: gpio
//
// Author: Heqing Huang
// Date Created: 04/21/2021
//
// ================== Description ==================
//
// General Purpose IO
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package ip

import soc._
import sib._
import spinal.core._
import spinal.lib._
import spinal.lib.io.TriStateArray

case class gpio_io(soc_param: SOC_PARAM) extends Bundle {
  val gpio_group0 = master(TriStateArray(soc_param.GPIO_WIDTH bits))
}

case class gpio(soc_param: SOC_PARAM) extends Component {

  val io = gpio_io(soc_param)
  val gpio_sib = slave(Sib(soc_param.gpioSibCfg))

  val int = Reg(Bits(2 bits)) // 0
  val gpio_group0 = Reg(Bits(soc_param.GPIO_WIDTH bits))  // 4
  val gpio_group_ctrl = Reg(Bits(soc_param.GPIO_WIDTH bits))  // 8

  // == GPIO read write logic == //
  io.gpio_group0.write := gpio_group0
  io.gpio_group0.writeEnable := gpio_group_ctrl
  gpio_group0 := gpio_group_ctrl & io.gpio_group0.read

  // == GPIO edge detection and interrupt == //
  // FIXME
  int(1) := False

  // == SIB logic == //
  gpio_sib.resp := True
  gpio_sib.rdata := gpio_group0
  when(gpio_sib.sel && gpio_sib.enable) {
    switch(gpio_sib.addr) {
      is(0) {
        when (gpio_sib.write) {int(0) := gpio_sib.wdata(0)}
      }
      is(4) {
        when (gpio_sib.write) {gpio_group0 := gpio_sib.wdata}
      }
      is(8) {
        when (gpio_sib.write) {gpio_group_ctrl := gpio_sib.wdata}
      }
      default {
        gpio_sib.resp := False
      }
    }
  }
  gpio_sib.ready := True // always ready, haha
}
