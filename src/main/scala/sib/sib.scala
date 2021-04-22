///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Author: Heqing Huang
// Date Created: 04/20/2021
//
// ================== Description ==================
//
// SpinalHDL SIB library
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package sib

import spinal.core._
import spinal.lib._

case class SibConfig(addressWidth: Int, dataWidth: Int, addr_lo: Int = 0, addr_hi: Int = 1) {
  def addressType  = UInt(addressWidth bits)
  def dataType     = Bits(dataWidth bits)
  def bytePerWord  = dataWidth / 8
  def symboleRange = log2Up(bytePerWord) - 1 downto 0
  def wordRange    = addressWidth - 1 downto log2Up(bytePerWord)
  assert(addr_lo <= addr_hi, "SIB addr_lo should smaller or equal to addr_hi")
}

/**
 * SIB Master interface
 */
case class SibMaster(config: SibConfig) extends Bundle with IMasterSlave {

  // Address and control
  val sel    = Bool
  val enable = Bool
  val write  = Bool
  val mask   = Bits(config.bytePerWord bits)
  val addr   = UInt(config.addressWidth bits)

  // Data
  val wdata  = Bits(config.dataWidth bits)
  val rdata  = Bits(config.dataWidth bits)

  // Transfer response
  val ready  = Bool
  val resp   = Bool

  override def asMaster(): Unit = {
    out(sel, enable, write, mask, wdata, addr)
    in(rdata, ready, resp)
  }

  def toSib(): Sib = {
    val slave = Sib(config)

    slave.sel    := True
    slave.enable := this.enable
    slave.addr   := this.addr
    slave.write  := this.write
    slave.mask   := this.mask
    slave.wdata  := this.wdata

    this.rdata   := slave.rdata
    this.resp    := slave.resp
    this.ready   := slave.ready

    slave
  }
}

/**
 * SIB interface
 */
case class Sib(config: SibConfig) extends Bundle with IMasterSlave {
  
  // Address and control
  val sel    = Bool
  val enable = Bool
  val write  = Bool
  val mask   = Bits(config.bytePerWord bits)
  val addr   = UInt(config.addressWidth bits)

  // Data
  val wdata  = Bits(config.dataWidth bits)
  val rdata  = Bits(config.dataWidth bits)

  // Transfer response
  val ready  = Bool
  val resp   = Bool

  override def asMaster(): Unit = {
    out(sel, enable, write, mask, wdata, addr)
    in(rdata, ready, resp)
  }

  /**
   * Connect two SIB bus together with the resized of the address
   */
  def <<(that: Sib): Unit = {
    assert(that.config.addressWidth >= this.config.addressWidth, "SIB << : mismatch width address (use remap())")
    assert(this.config.dataWidth == that.config.dataWidth, "SIB << : mismatch data width")

    that.resp   := this.resp
    that.ready  := this.ready
    that.rdata  := this.rdata

    this.sel    := that.sel
    this.enable := that.enable
    this.addr   := that.addr
    this.write  := that.write
    this.mask   := that.mask
    this.wdata  := that.wdata
  }

  def >>(that: Sib): Unit = that << this

  /**
   * Remap a bus
   */
  def remapAddress(remapping: UInt => UInt): Sib = {
    val address = remapping(this.addr)

    val busRemap = Sib(SibConfig(dataWidth = this.config.dataWidth, addressWidth = address.getBitsWidth))

    this.resp   := busRemap.resp
    this.ready  := busRemap.ready
    this.rdata  := busRemap.rdata

    busRemap.sel    := this.sel
    busRemap.enable := this.enable
    busRemap.addr   := address
    busRemap.write  := this.write
    busRemap.mask   := this.mask
    busRemap.wdata  := this.wdata

    busRemap
  }
}

/**
 * SIB 1 to n switch
 */
case class Sib_switch1tN(mainSibCfg: SibConfig, targetSibCfg: Array[SibConfig]) extends Component {

  // defining the interface
  val hostSib = slave(Sib(mainSibCfg))
  val clientSib = targetSibCfg map (x => master(Sib(x)))

  // check if the switch is valid
  assert(mainSibCfg.addressWidth >= targetSibCfg.map(_.addressWidth).max,
    "SIB: The main module address range is smaller then the target module")
  assert(mainSibCfg.dataWidth >= targetSibCfg.map(_.dataWidth).max,
    "SIB: The main module data range is smaller then the target module")

  val num = targetSibCfg.length
  val dec_sel = Bits(num bits)
  val dec_good = dec_sel.orR
  for (i <- 0 until num) {
    dec_sel(i) := (hostSib.addr >= clientSib(i).config.addr_lo) & (hostSib.addr <= clientSib(i).config.addr_hi)
  }

  hostSib.rdata := MuxOH(dec_sel, clientSib.map(_.rdata))
  hostSib.resp  := MuxOH(dec_sel, clientSib.map(_.resp)) & dec_good
  hostSib.ready := MuxOH(dec_sel, clientSib.map(_.ready))

  for (i <- 0 until num) {
    clientSib(i).write  := hostSib.write
    clientSib(i).addr   := hostSib.addr(clientSib(i).config.addressWidth - 1 downto 0)
    clientSib(i).wdata  := hostSib.wdata
    clientSib(i).enable := hostSib.enable
    clientSib(i).mask   := hostSib.mask
    clientSib(i).sel    := hostSib.sel & dec_sel(i)
  }
}
