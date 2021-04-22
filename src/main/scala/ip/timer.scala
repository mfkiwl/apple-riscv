///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: timer
//
// Author: Heqing Huang
// Date Created: 04/21/2021
//
// ================== Description ==================
//
// Timer
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package ip

import soc._
import sib._
import spinal.core._
import spinal.lib._

case class timer_io() extends Bundle {
  val timer_interrupt = out Bool
}

case class timer(soc_param: SOC_PARAM) extends Component {

  val io = timer_io()
  val timer_sib = slave(Sib(soc_param.timerSibCfg))

  val int = Reg(Bits(2 bits)) init 1  // 0
  val mtime = Reg(UInt(soc_param.TIMER_TIMER_WIDTH bits)) init 0 // 4, 8
  val mtimecmp = Reg(UInt(soc_param.TIMER_TIMER_WIDTH bits)) init 0 // 12, 16
  def mtime_lo = mtime(31 downto 0)
  def mtime_hi = mtime(63 downto 32)
  def mtimecmp_lo = mtimecmp(31 downto 0)
  def mtimecmp_hi = mtimecmp(63 downto 32)

  // only need to use bit 4-2 for the address decode becasue:
  // 1) the address is aligned to 4 bytes (ignore lower 2 bits)
  // 2) the address range is 00, 04, 08, 0C, 10 so only need to check bit 3 - 2
  //val decode_addr = timer_sib.addr(4 downto 2)

  // == timer logic == //
  mtime := mtime + 1

  // == interrupt generation logic == //
  val int_en = int(0) & mtimecmp =/= 0
  int(1) := (mtime >= mtimecmp) & int_en
  io.timer_interrupt := int(1)

  // == SIB logic == //
  timer_sib.resp := True
  timer_sib.rdata := mtime_lo.asBits
  when(timer_sib.sel && timer_sib.enable) {
    switch(timer_sib.addr) {
      // int
      is(0) {
        timer_sib.rdata := int.resized
        when (timer_sib.write) {int(0) := timer_sib.wdata(0)}
      }
      // mtime_lo
      is(4) {
        timer_sib.rdata := mtime_lo.asBits
        when (timer_sib.write) {mtime_lo := timer_sib.wdata.asUInt}
      }
      // mtime_hi
      is(8) {
        timer_sib.rdata := mtime_hi.asBits
        when (timer_sib.write) {mtime_hi := timer_sib.wdata.asUInt}
      }
      // mtimecmp_lo
      is(12) {
        timer_sib.rdata := mtimecmp_lo.asBits
        when (timer_sib.write) {mtimecmp_lo := timer_sib.wdata.asUInt}
      }
      // mtimecmp_hi
      is(16) {
        timer_sib.rdata := mtimecmp_hi.asBits
        when (timer_sib.write) {mtimecmp_hi := timer_sib.wdata.asUInt}
      }
      default {
        timer_sib.resp := False
      }
    }
  }
  timer_sib.ready := True // always ready, haha
}
