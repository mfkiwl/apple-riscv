///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: data_ram_model
//
// Author: Heqing Huang
// Date Created: 03/30/2021
//
// ================== Description ==================
//
// Data RAM
//
// - Data ram simulation model
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package ip

import core.CPU_PARAM
import spinal.core._

case class data_ram_io(param: CPU_PARAM) extends Bundle {
  val wen    = in Bool
  val ren    = in Bool
  val addr   = in UInt(param.DATA_RAM_ADDR_WIDTH bits)
  val byte_en = in Bits(param.DATA_RAM_DATA_WIDTH / 8 bits)
  val data_out = out Bits(param.DATA_RAM_DATA_WIDTH bits)
  val data_in = in Bits(param.DATA_RAM_DATA_WIDTH bits)    // data come 1 cycle after ren
}

case class data_ram_model(param: CPU_PARAM) extends Component {
  val io = data_ram_io(param)

  val SIZE = 1 << param.DATA_RAM_ADDR_WIDTH
  val ram = new Mem(Bits(param.DATA_RAM_DATA_WIDTH bits), SIZE)

  ram.write(
    address = io.addr,
    data = io.data_in,
    enable = io.wen,
    mask = io.byte_en
  )

  io.data_out := ram.readSync(
    address = io.addr,
    enable = io.ren
  )
}