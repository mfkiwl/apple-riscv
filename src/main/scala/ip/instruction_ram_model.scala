///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: instruction_ram_model
//
// Author: Heqing Huang
// Date Created: 03/30/2021
//
// ================== Description ==================
//
// Instruction RAM
//
// - Instruction RAM model for simulation
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package ip

import core.CPU_PARAM
import spinal.core._
import spinal.lib.bus.amba3.ahblite.AhbLite3
import spinal.lib.slave

case class instruction_ram_model(param: CPU_PARAM) extends Component {

    val imem_ahb = slave(AhbLite3(param.imem_ahbCfg))

    // We fetch  a word (4 bytes) at a time so reduce the size by 4
    val SIZE = 1 << (param.INSTR_RAM_ADDR_WIDTH - 2)
    val ram = new Mem(Bits(param.INSTR_RAM_DATA_WIDTH bits), SIZE)

    val word_addr = imem_ahb.HADDR(param.INSTR_RAM_ADDR_WIDTH -1 downto 2)
    // Here we use HSEL to indicate we want to stall the data
    val read_en = imem_ahb.HSEL

    imem_ahb.HREADYOUT  := True
    imem_ahb.HRESP      := False    // Low indicate OKAY

    ram.write(
        address = word_addr,
        data = imem_ahb.HWDATA,
        enable = imem_ahb.HWRITE
    )

    imem_ahb.HRDATA := ram.readSync(
        address = word_addr,
        enable = read_en
    )
}
