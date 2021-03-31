///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: Register File
//
// Author: Heqing Huang
// Date Created: 03/27/2021
//
// ================== Description ==================
//
// Register File
//
// - RV32I ISA supports 32 register and each register is 32 bits.
// - Register File has two RW ports
// - x0 is fixed to value ZERO
// - Register File read is async
// - Support internal forwarding
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._

case class rf_io(param: CPU_PARAM) extends Bundle{
    // Parameter
    val ADDR_WIDTH = log2Up(param.RF_SIZE)
    // Read Port A
    val rs1_rd_addr  = in UInt(ADDR_WIDTH bits)
    val rs1_data_out = out Bits(param.RF_WIDTH bits)
    // Read Port B
    val rs2_rd_addr  = in UInt(ADDR_WIDTH bits)
    val rs2_data_out = out Bits(param.RF_WIDTH bits)
    // common
    val register_wen      = in Bool
    val register_wr_addr  = in UInt(ADDR_WIDTH bits)
    val rd_in             = in Bits(param.RF_WIDTH bits)
}

case class register_file(param: CPU_PARAM) extends Component {
    val SIZE  = param.RF_SIZE
    val io    = rf_io(param)

    val rs1_data = Bits(param.RF_WIDTH bits)
    val rs2_data = Bits(param.RF_WIDTH bits)

    // To support two RW ports, this register file design uses two
    // memory with the same write port. So the two memory has the same copy
    // and each read port comes from one memory
    val rs1_ram = Mem(Bits(param.RF_WIDTH bits), wordCount = SIZE)
    val rs2_ram = Mem(Bits(param.RF_WIDTH bits), wordCount = SIZE)

    // RAM A
    rs1_ram.write(
        enable = io.register_wen,
        address = io.register_wr_addr,
        data = io.rd_in
    )
    rs1_data := rs1_ram.readAsync(
        address = io.rs1_rd_addr
    )
    // RAM B
    rs2_ram.write(
        enable = io.register_wen,
        address = io.register_wr_addr,
        data = io.rd_in
    )
    rs2_data := rs2_ram.readAsync(
        address = io.rs2_rd_addr
    )

    // Special logic for x0
    when(io.rs1_rd_addr === 0) {
        io.rs1_data_out := 0
    }.elsewhen((io.rs1_rd_addr === io.register_wr_addr) && (io.register_wen === True)) {
        io.rs1_data_out := io.rd_in
    }.otherwise {
        io.rs1_data_out := rs1_data
    }

    when(io.rs2_rd_addr === 0) {
        io.rs2_data_out := 0
    }.elsewhen((io.rs2_rd_addr === io.register_wr_addr) && (io.register_wen === True)) {
        io.rs2_data_out := io.rd_in
    }.otherwise {
        io.rs2_data_out := rs2_data
    }
}
