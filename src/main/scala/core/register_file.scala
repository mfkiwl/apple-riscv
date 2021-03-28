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
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._

case class rf_io(cfg: cpu_cfg) extends Bundle{
    // Parameter
    val ADDR_WIDTH = log2Up(cfg.RF_SIZE)
    // Port A
    val rs1_addr     = in UInt(ADDR_WIDTH bits)
    val rs1_data_in  = in Bits(cfg.RF_WIDTH bits)
    val rs1_wen      = in Bool
    val rs1_data_out = out Bits(cfg.RF_WIDTH bits)
    // Port B
    val rs2_addr     = in UInt(ADDR_WIDTH bits)
    val rs2_data_in  = in Bits(cfg.RF_WIDTH bits)
    val rs2_wen      = in Bool
    val rs2_data_out = out Bits(cfg.RF_WIDTH bits)
}

case class register_file(cfg: cpu_cfg) extends Component {
    val SIZE  = cfg.RF_SIZE
    val io    = new rf_io(cfg)

    val rs1_data = Bits(cfg.RF_WIDTH bits)
    val rs2_data = Bits(cfg.RF_WIDTH bits)

    // To support two RW ports, this register file design uses two
    // memory with the same write port. So the two memory has the same copy
    // and each read port comes from one memory
    val rs1_ram = Mem(Bits(cfg.RF_WIDTH bits), wordCount = SIZE)
    val rs2_ram = Mem(Bits(cfg.RF_WIDTH bits), wordCount = SIZE)

    // RAM A
    rs1_ram.write(
        enable = io.rs1_wen,
        address = io.rs1_addr,
        data = io.rs1_data_in
    )
    rs1_data := rs1_ram.readSync(
        address = io.rs1_addr,
        enable = True
    )
    // RAM B
    rs2_ram.write(
        enable = io.rs2_wen,
        address = io.rs2_addr,
        data = io.rs2_data_in
    )
    rs2_data := rs2_ram.readSync(
        address = io.rs2_addr,
        enable = True
    )

    // Special logic for x0
    when(io.rs1_addr === 0) {
        io.rs1_data_out := 0
    } otherwise {
        io.rs1_data_out := rs1_data
    }

    when(io.rs2_addr === 0) {
        io.rs2_data_out := 0
    } otherwise {
        io.rs2_data_out := rs2_data
    }
}
