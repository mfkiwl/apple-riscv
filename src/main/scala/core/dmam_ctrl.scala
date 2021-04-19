///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: data memory controller
//
// Author: Heqing Huang
// Date Created: 03/31/2021
//
// ================== Description ==================
//
// Data Memory Controller
//
// - Logic to handle byte and half word access to memory
// - We always read/write the whole word from/to memory so the address to the memory is aligned
//   to word address (lower 2 bits is always 0)
// - ASSUMPTION: CPU need to give the aligned address to memory controller
// - The byte enable controls the byte being written into memory
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._
import spinal.lib.bus.amba3.ahblite.AhbLite3
import spinal.lib.master

case class dmem_ctrl_io(param: CPU_PARAM) extends Bundle {

  // CPU side
  val cpu2mc_wr              = in Bool
  val cpu2mc_rd              = in Bool
  val cpu2mc_addr            = in UInt(param.DATA_RAM_ADDR_WIDTH bits)
  val cpu2mc_data            = in Bits(param.DATA_RAM_DATA_WIDTH bits)
  val mc2cpu_data            = out Bits(param.DATA_RAM_DATA_WIDTH bits)
  val cpu2mc_mem_LS_byte     = in Bool
  val cpu2mc_mem_LS_halfword = in Bool
  val cpu2mc_mem_LW_unsigned = in Bool

  // Exception
  val load_addr_misalign     = out Bool
  val store_addr_misalign    = out Bool
}

case class dmem_ctrl(param: CPU_PARAM) extends Component {

  val io = dmem_ctrl_io(param)
  val dmem_ahb = master(AhbLite3(param.dmem_ahbCfg))

  // == Store the information for read data process == //
  val mem_byte_addr   = io.cpu2mc_addr(1 downto 0)
  val LW_unsigned_s1  = RegNextWhen(io.cpu2mc_mem_LW_unsigned, io.cpu2mc_rd)
  val LS_byte_s1      = RegNextWhen(io.cpu2mc_mem_LS_byte, io.cpu2mc_rd)
  val LS_halfword_s1  = RegNextWhen(io.cpu2mc_mem_LS_halfword, io.cpu2mc_rd)
  val mem_byte_addr_s1 = RegNextWhen(mem_byte_addr, io.cpu2mc_rd)

  // == Extract the data field == //
  val cpu2mc_data_7_0  = io.cpu2mc_data(7 downto 0)
  val cpu2mc_data_15_0 = io.cpu2mc_data(15 downto 0)

  val mem2mc_data_byte0 = dmem_ahb.HRDATA(7 downto 0)
  val mem2mc_data_byte1 = dmem_ahb.HRDATA(15 downto 8)
  val mem2mc_data_byte2 = dmem_ahb.HRDATA(23 downto 16)
  val mem2mc_data_byte3 = dmem_ahb.HRDATA(31 downto 24)
  val mem2mc_data_hw0   = dmem_ahb.HRDATA(15 downto 0)
  val mem2mc_data_hw1   = dmem_ahb.HRDATA(31 downto 16)

  // == extend the data in advance == //
  val mem2mc_data_byte0_unsign_ext = mem2mc_data_byte0.resize(param.DATA_RAM_DATA_WIDTH)
  val mem2mc_data_byte1_unsign_ext = mem2mc_data_byte1.resize(param.DATA_RAM_DATA_WIDTH)
  val mem2mc_data_byte2_unsign_ext = mem2mc_data_byte2.resize(param.DATA_RAM_DATA_WIDTH)
  val mem2mc_data_byte3_unsign_ext = mem2mc_data_byte3.resize(param.DATA_RAM_DATA_WIDTH)
  val mem2mc_data_hw0_unsign_ext   = mem2mc_data_hw0.resize(param.DATA_RAM_DATA_WIDTH)
  val mem2mc_data_hw1_unsign_ext   = mem2mc_data_hw1.resize(param.DATA_RAM_DATA_WIDTH)

  val mem2mc_data_byte0_sign_ext = mem2mc_data_byte0.asSInt.resize(param.DATA_RAM_DATA_WIDTH).asBits
  val mem2mc_data_byte1_sign_ext = mem2mc_data_byte1.asSInt.resize(param.DATA_RAM_DATA_WIDTH).asBits
  val mem2mc_data_byte2_sign_ext = mem2mc_data_byte2.asSInt.resize(param.DATA_RAM_DATA_WIDTH).asBits
  val mem2mc_data_byte3_sign_ext = mem2mc_data_byte3.asSInt.resize(param.DATA_RAM_DATA_WIDTH).asBits
  val mem2mc_data_hw0_sign_ext   = mem2mc_data_hw0.asSInt.resize(param.DATA_RAM_DATA_WIDTH).asBits
  val mem2mc_data_hw1_sign_ext   = mem2mc_data_hw1.asSInt.resize(param.DATA_RAM_DATA_WIDTH).asBits

  // == Process the write/read data == //
  /* From RISC-V Spec:
    The LW instruction loads a 32-bit value from memory into rd. LH loads a 16-bit value from memory,
    then sign-extends to 32-bits before storing in rd. LHU loads a 16-bit value from memory but then
    zero extends to 32-bits before storing in rd. LB and LBU are defined analogously for 8-bit values.
    The SW, SH, and SB instructions store 32-bit, 16-bit, and 8-bit values from the low bits of register
    rs2 to memory.
  */
  // Write: Since we always access a word in the memory, we need to place the data from the
  //        low bits of rs2 to its corresponding position for byte/half-word access.
  // READ: Since we always access the entire word in the memory, the data returned from the memory
  //       is the entire word, we need to extract the corresponding byte from the word and extends it.

  // Write Data
  dmem_ahb.HWDATA := io.cpu2mc_data
  when(io.cpu2mc_mem_LS_byte) {
    // For simplicity, just set all the byte to the same data
    dmem_ahb.HWDATA := cpu2mc_data_7_0 ## cpu2mc_data_7_0 ## cpu2mc_data_7_0 ## cpu2mc_data_7_0
    /* TODO: Not sure if using the select logic is faster? Can we run synthesis in Quartus to test out?
    switch(mem_byte_addr) {
      // Byte 0
      is(0) {
        dmem_ahb.HWDATA(7 downto 0) := cpu2mc_data_7_0
      }
      // Byte 1
      is(1) {
        dmem_ahb.HWDATA(15 downto 8) := cpu2mc_data_7_0
      }
      // Byte 2
      is(2) {
        dmem_ahb.HWDATA(23 downto 16) := cpu2mc_data_7_0
      }
      // Byte 3
      is(3) {
        dmem_ahb.HWDATA(31 downto 24) := cpu2mc_data_7_0
      }
    }
     */
  }.elsewhen(io.cpu2mc_mem_LS_halfword) {
    // For simplicity, just set all the byte to the same data
    dmem_ahb.HWDATA := cpu2mc_data_15_0 ## cpu2mc_data_15_0
    /*
    switch(mem_byte_addr) {
      // HW 0
      is(0) {
        dmem_ahb.HWDATA(15 downto 0) := cpu2mc_data_15_0
      }
      // HW 1
      is(2) {
        dmem_ahb.HWDATA(31 downto 16) := cpu2mc_data_15_0
      }
    }
     */
  }

  // Read Data
  io.mc2cpu_data := dmem_ahb.HRDATA // Default value
  when(LS_byte_s1) {
    switch(mem_byte_addr_s1) {
      // Byte 0
      is(0) {
        io.mc2cpu_data := Mux(LW_unsigned_s1, mem2mc_data_byte0_unsign_ext, mem2mc_data_byte0_sign_ext)
      }
      // Byte 1
      is(1) {
        io.mc2cpu_data := Mux(LW_unsigned_s1, mem2mc_data_byte1_unsign_ext, mem2mc_data_byte1_sign_ext)
      }
      // Byte 2
      is(2) {
        io.mc2cpu_data := Mux(LW_unsigned_s1, mem2mc_data_byte2_unsign_ext, mem2mc_data_byte2_sign_ext)
      }
      // Byte 3
      is(3) {
        io.mc2cpu_data := Mux(LW_unsigned_s1, mem2mc_data_byte3_unsign_ext, mem2mc_data_byte3_sign_ext)
      }
    }
  }.elsewhen(LS_halfword_s1) {
    switch(mem_byte_addr_s1) {
      // HW 0
      is(0) {
        io.mc2cpu_data := Mux(LW_unsigned_s1, mem2mc_data_hw0_unsign_ext, mem2mc_data_hw0_sign_ext)
      }
      // HW 1
      is(2) {
        io.mc2cpu_data := Mux(LW_unsigned_s1, mem2mc_data_hw1_unsign_ext, mem2mc_data_hw1_sign_ext)
      }
    }
  }

  // == check address alignment == //
  val halfword_addr_misalign = io.cpu2mc_mem_LS_halfword & io.cpu2mc_addr(0)
  val word_address_misalign  = ~(io.cpu2mc_mem_LS_byte | io.cpu2mc_mem_LS_halfword) & (io.cpu2mc_addr(1 downto 0) =/= 0)
  io.load_addr_misalign  := io.cpu2mc_rd & (halfword_addr_misalign | word_address_misalign)
  io.store_addr_misalign := io.cpu2mc_wr & (halfword_addr_misalign | word_address_misalign)

  // == Control Signal == //
  val wen = io.cpu2mc_wr & ~io.store_addr_misalign
  val ren = io.cpu2mc_rd & ~io.load_addr_misalign
  dmem_ahb.HSEL       := wen | ren
  dmem_ahb.HADDR      := io.cpu2mc_addr
  dmem_ahb.HBURST     := B"000"   // Single burst
  dmem_ahb.HMASTLOCK  := False
  dmem_ahb.HPROT      := B"0011"  // Set to 0011 as recommended by the AHB-lite SPEC:
  // the master sets HPROT to b0011 to correspond to a non-cacheable,
  // non-bufferable, privileged, data access
  dmem_ahb.HSIZE      := Mux(io.cpu2mc_mem_LS_byte, B"000", Mux(io.cpu2mc_mem_LS_halfword, B"001", B"010"))
  dmem_ahb.HTRANS     := B"10"    // Set to NONSEQ
  dmem_ahb.HWRITE     := wen

  val imem_hready     = dmem_ahb.HREADY    // This should always be 1
  val imem_hresp      = dmem_ahb.HRESP     // This should always be 0
  val imem_data_vld   = imem_hready & ~imem_hresp
}
