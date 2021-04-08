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
import spinal.lib.bus.amba3.ahblite.AhbLite3
import spinal.lib.slave

case class data_ram_model(param: CPU_PARAM) extends Component {

  val dmem_ahb = slave(AhbLite3(param.dmem_ahbCfg))

  // We fetch  a word (4 bytes) at a time so reduce the size by 4
  val SIZE = 1 << (param.INSTR_RAM_ADDR_WIDTH - 2)
  val ram = new Mem(Bits(param.INSTR_RAM_DATA_WIDTH bits), SIZE)

  val word_addr = dmem_ahb.HADDR(param.INSTR_RAM_ADDR_WIDTH -1 downto 2)
  // Here we use HSEL to indicate we want to stall the data
  val read_en = dmem_ahb.HSEL

  // Decode logic for write byte enable
  val byte_sel      = dmem_ahb.HADDR(1 downto 0)
  val word_sel      = dmem_ahb.HADDR(1)
  val xfer_byte     = dmem_ahb.HSIZE === B"000"
  val xfer_halfword = dmem_ahb.HSIZE === B"001"
  val xfer_word     = dmem_ahb.HSIZE === B"010"
  val byte_mask     = B"0001" |<< byte_sel
  val halfword_mask = Mux(word_sel, B"1100", B"0011")
  val word_mask     = B"1111"
  val byte_en       = Mux(xfer_byte, byte_mask, Mux(xfer_halfword, halfword_mask, word_mask))


  dmem_ahb.HREADYOUT  := True
  dmem_ahb.HRESP      := False    // Low indicate OKAY

  ram.write(
    address = word_addr,
    data = dmem_ahb.HWDATA,
    enable = dmem_ahb.HWRITE,
    mask = byte_en
  )

  dmem_ahb.HRDATA := ram.readSync(
    address = word_addr,
    enable = ~dmem_ahb.HWRITE
  )
}
