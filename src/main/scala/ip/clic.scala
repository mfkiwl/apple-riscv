///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: clic
//
// Author: Heqing Huang
// Date Created: 04/19/2021
//
// ================== Description ==================
//
// Core Level Interrupt Controller
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package ip

import soc._
import sib._
import spinal.core._
import spinal.lib._

case class clic_io() extends Bundle {
  val software_interrupt = out Bool
  val timer_interrupt = out Bool
}

case class clic(soc_param: SOC_PARAM) extends Component {

  val io = clic_io()
  val clic_sib = slave(Sib(soc_param.clicSibCfg))

  val msip = Reg(Bool) init False
  val mtime = Reg(UInt(soc_param.CLIC_TIMER_WIDTH bits)) init 0
  val mtimecmp = Reg(UInt(soc_param.CLIC_TIMER_WIDTH bits)) init 0
  def mtime_lo = mtime(31 downto 0)
  def mtime_hi = mtime(63 downto 32)
  def mtimecmp_lo = mtimecmp(31 downto 0)
  def mtimecmp_hi = mtimecmp(63 downto 32)

  // only need to use bit 4-2 for the address decode becasue:
  // 1) the address is aligned to 4 bytes (ignore lower 2 bits)
  // 2) the address range is 00, 04, 08, 0C, 10 so only need to check bit 3 - 2
  //val decode_addr = clic_sib.addr(4 downto 2)

  // == timer logic == //
  mtime := mtime + 1

  // == interrupt generation logic == //
  io.software_interrupt := msip
  io.timer_interrupt := (mtime >= mtimecmp) & (mtimecmp =/= 0)

  // == SIB logic == //
  clic_sib.resp := True
  clic_sib.rdata := mtime_lo.asBits
  when(clic_sib.sel && clic_sib.enable) {
    switch(clic_sib.addr) {
      // msip
      is(0) {
        clic_sib.rdata := msip.asBits.resized
        when (clic_sib.write) {msip := clic_sib.wdata(0)}
      }
      // mtime_lo
      is(4) {
        clic_sib.rdata := mtime_lo.asBits
        when (clic_sib.write) {mtime_lo := clic_sib.wdata.asUInt}
      }
      // mtime_hi
      is(8) {
        clic_sib.rdata := mtime_hi.asBits
        when (clic_sib.write) {mtime_hi := clic_sib.wdata.asUInt}
      }
      // mtimecmp_lo
      is(12) {
        clic_sib.rdata := mtimecmp_lo.asBits
        when (clic_sib.write) {mtimecmp_lo := clic_sib.wdata.asUInt}
      }
      // mtimecmp_hi
      is(16) {
        clic_sib.rdata := mtimecmp_hi.asBits
        when (clic_sib.write) {mtimecmp_hi := clic_sib.wdata.asUInt}
      }
      default {
        clic_sib.resp := False
      }
    }
  }
  clic_sib.ready := True // always ready, haha
}
