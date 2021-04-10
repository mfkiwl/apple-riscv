///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: imem
//
// Author: Heqing Huang
// Date Created: 03/30/2021
//
// ================== Description ==================
//
// Instruction RAM
//
// - Instruction RAM
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package mem

import core._
import spinal.core._
import spinal.lib.bus.amba3.ahblite.AhbLite3
import spinal.lib.slave

case class imem(param: CPU_PARAM) extends Component {

    val imem_cpu_ahb = slave(AhbLite3(param.imem_ahbCfg))
    val imem_dbg_ahb = slave(AhbLite3(param.imem_ahbCfg))

    // We fetch  a word (4 bytes) at a time so reduce the size by 4
    val SIZE = 1 << (param.INSTR_RAM_ADDR_WIDTH - 2)
    val ram = new Mem(Bits(param.INSTR_RAM_DATA_WIDTH bits), SIZE)

    // == CPU side Port == //
    val cpu_word_addr = imem_cpu_ahb.HADDR(param.INSTR_RAM_ADDR_WIDTH -1 downto 2)
    val cpu_read_en = imem_cpu_ahb.HSEL // Here we use HSEL to indicate we want to stall the data
    imem_cpu_ahb.HREADYOUT  := True
    imem_cpu_ahb.HRESP      := False    // Low indicate OKAY
    ram.write(
        address = cpu_word_addr,
        data = imem_cpu_ahb.HWDATA,
        enable = imem_cpu_ahb.HWRITE
    )
    imem_cpu_ahb.HRDATA := ram.readSync(
        address = cpu_word_addr,
        enable = cpu_read_en
    )

    // == DBG side Port == //
    val dbg_word_addr = imem_dbg_ahb.HADDR(param.INSTR_RAM_ADDR_WIDTH -1 downto 2)
    val dbg_read_en = imem_dbg_ahb.HSEL // Here we use HSEL to indicate we want to stall the data
    imem_dbg_ahb.HREADYOUT  := True
    imem_dbg_ahb.HRESP      := False    // Low indicate OKAY
    ram.write(
        address = dbg_word_addr,
        data = imem_dbg_ahb.HWDATA,
        enable = imem_dbg_ahb.HWRITE
    )
    imem_dbg_ahb.HRDATA := ram.readSync(
        address = dbg_word_addr,
        enable = dbg_read_en
    )
}
