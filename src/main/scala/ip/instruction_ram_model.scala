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
// - Instruction RAM simulation model
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package ip

import core.CPU_PARAM
import spinal.core._

case class instruction_ram_io(param: CPU_PARAM) extends Bundle {
    val wen    = in Bool
    val ren    = in Bool
    val enable = in Bool
    val addr   = in UInt(param.INST_RAM_ADDR_WIDTH bits)
    val data_out = out Bits(param.INST_RAM_DATA_WIDTH bits)
    val data_in = in Bits(param.INST_RAM_DATA_WIDTH bits)    // data come 1 cycle after ren
}

case class instruction_ram_model(param: CPU_PARAM) extends Component {
    val io = instruction_ram_io(param)

    val SIZE = 1 << (param.INST_RAM_ADDR_WIDTH - 2) // We fetch 4 bytes at a time
    val ram = new Mem(Bits(param.INST_RAM_DATA_WIDTH bits), SIZE)
    val ram_addr = io.addr(param.INST_RAM_ADDR_WIDTH -1 downto 2)

    ram.write(
        address = ram_addr,
        data = io.data_in,
        enable = io.wen & io.enable
    )

    io.data_out := ram.readSync(
        address = ram_addr,
        enable = io.ren & io.enable
    )
}
