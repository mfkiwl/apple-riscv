///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: apple_riscv
//
// Author: Heqing Huang
// Date Created: 04/07/2021
//
// ================== Description ==================
//
// Instruction Memory Controller
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._
import spinal.lib.bus.amba3.ahblite._
import spinal.lib.{master, slave}

case class imem_ctrl_io(param: CPU_PARAM) extends Bundle {

  // CPU side
  val cpu2mc_addr = in UInt(param.XLEN bits)
  val cpu2mc_en   = in Bool
  val mc2cpu_data = out Bits(param.XLEN bits)
}

case class imem_ctrl(param: CPU_PARAM) extends Component {
  val io = imem_ctrl_io(param)
  val imem_ahb = master(AhbLite3(param.imem_ahbCfg))

  // Master signals
  imem_ahb.HSEL       := io.cpu2mc_en
  imem_ahb.HADDR      := io.cpu2mc_addr
  imem_ahb.HBURST     := B"000"   // Single burst
  imem_ahb.HMASTLOCK  := False
  imem_ahb.HPROT      := B"0011"  // Set to 0011 as recommended by the AHB-lite SPEC:
                                  // the master sets HPROT to b0011 to correspond to a non-cacheable,
                                  // non-bufferable, privileged, data access
  imem_ahb.HSIZE      := B"010"   // Word - 32 bits
  imem_ahb.HTRANS     := B"10"    // Set to NONSEQ
  imem_ahb.HWDATA     := 0        // Fixed to zero, We are not writing to I-mem through this port
  imem_ahb.HWRITE     := False    // Fixed to zero, We are not writing to I-mem through this port

  // Slave signals
  io.mc2cpu_data      := imem_ahb.HRDATA

  val imem_hready     = imem_ahb.HREADY    // This should always be 1
  val imem_hresp      = imem_ahb.HRESP     // This should always be 0
  val imem_data_vld   = imem_hready & ~imem_hresp
}
