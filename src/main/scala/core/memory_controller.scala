///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: memory controller
//
// Author: Heqing Huang
// Date Created: 03/31/2021
//
// ================== Description ==================
//
// Memory Controller
//
// - Logic to handle byte and half word access to memory
// - We always read/write the whole word from/to memory so the address to the memory is aligned
//   to word address (lower 2 bits is always 0)
// - The byte enable controls the byte being written into memory
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._

case class memory_controller_io(param: CPU_PARAM) extends Bundle {

  // CPU side
  val cpu2mc_wen  = in Bool
  val cpu2mc_ren  = in Bool
  val cpu2mc_addr = in UInt(param.DATA_RAM_ADDR_WIDTH bits)
  val cpu2mc_data = in Bits(param.DATA_RAM_DATA_WIDTH bits)
  val mc2cpu_data = out Bits(param.DATA_RAM_DATA_WIDTH bits)
  val mc2cpu_data_vld = out Bool
  val cpu2mc_LS_byte = in Bool
  val cpu2mc_LS_halfword = in Bool
  val cpu2mc_LW_unsigned = in Bool

  // MEM side
  val mc2mem_wen  = out Bool
  val mc2mem_ren  = out Bool
  val mc2mem_addr = out UInt(param.DATA_RAM_ADDR_WIDTH bits)
  val mem2mc_data = in Bits(param.DATA_RAM_DATA_WIDTH bits)
  val mem2mc_data_vld = in Bool
  val mc2mem_data = out Bits(param.DATA_RAM_DATA_WIDTH bits)
  val mc2mem_byte_enable = out Bits(param.DATA_RAM_DATA_WIDTH / 8 bits)
}

case class memory_controller(param: CPU_PARAM) extends Component {

  val io = memory_controller_io(param)

  // == Extract the data field == //
  val cpu2mc_data_7_0  = io.cpu2mc_data(7 downto 0)
  val cpu2mc_data_15_0 = io.cpu2mc_data(15 downto 0)

  val mem2mc_data_byte0 = io.mem2mc_data(7 downto 0)
  val mem2mc_data_byte1 = io.mem2mc_data(15 downto 8)
  val mem2mc_data_byte2 = io.mem2mc_data(23 downto 16)
  val mem2mc_data_byte3 = io.mem2mc_data(31 downto 24)
  val mem2mc_data_hw0   = io.mem2mc_data(15 downto 0)
  val mem2mc_data_hw1   = io.mem2mc_data(31 downto 16)

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

  io.mc2mem_data := io.cpu2mc_data
  io.mc2cpu_data := io.mem2mc_data
  io.mc2mem_byte_enable := B"1111"  // Default byte enable
  io.mc2mem_addr := io.cpu2mc_addr  // Default address mapping
  io.mc2mem_addr(1 downto 0) := 0   // Align the address to word boundary

  val mem_byte_addr = io.cpu2mc_addr(1 downto 0)

  when(io.cpu2mc_LS_byte) {
    // Set the default value to zero, good for debug
    // io.mc2cpu_data := 0 // Can't set this. SpinalHDL will fail. Not sure why.
    io.mc2mem_data := 0
    switch(mem_byte_addr) {
      // Byte 0
      is(0) {
        io.mc2mem_data(7 downto 0) := cpu2mc_data_7_0
        io.mc2cpu_data := Mux(io.cpu2mc_LW_unsigned, mem2mc_data_byte0_unsign_ext, mem2mc_data_byte0_sign_ext)
        io.mc2mem_byte_enable :=  B"0001"
      }
      // Byte 1
      is(1) {
        io.mc2mem_data(15 downto 8) := cpu2mc_data_7_0
        io.mc2cpu_data := Mux(io.cpu2mc_LW_unsigned, mem2mc_data_byte1_unsign_ext, mem2mc_data_byte1_sign_ext)
        io.mc2mem_byte_enable :=  B"0010"
      }
      // Byte 2
      is(2) {
        io.mc2mem_data(23 downto 16) := cpu2mc_data_7_0
        io.mc2cpu_data := Mux(io.cpu2mc_LW_unsigned, mem2mc_data_byte2_unsign_ext, mem2mc_data_byte2_sign_ext)
        io.mc2mem_byte_enable :=  B"0100"
      }
      // Byte 3
      is(3) {
        io.mc2mem_data(31 downto 24) := cpu2mc_data_7_0
        io.mc2cpu_data := Mux(io.cpu2mc_LW_unsigned, mem2mc_data_byte3_unsign_ext, mem2mc_data_byte3_sign_ext)
        io.mc2mem_byte_enable :=  B"1000"
      }
    }
  }.elsewhen(io.cpu2mc_LS_halfword) {
    // Set the default value to zero, good for debug
    io.mc2mem_data := 0
    io.mc2cpu_data := 0
    switch(mem_byte_addr) {
      // HW 0
      is(0) {
        io.mc2mem_data(15 downto 0) := cpu2mc_data_15_0
        io.mc2cpu_data := Mux(io.cpu2mc_LW_unsigned, mem2mc_data_hw0_unsign_ext, mem2mc_data_hw0_sign_ext)
        io.mc2mem_byte_enable :=  B"0011"
      }
      // HW 1
      is(2) {
        io.mc2mem_data(31 downto 16) := cpu2mc_data_15_0
        io.mc2cpu_data := Mux(io.cpu2mc_LW_unsigned, mem2mc_data_hw1_unsign_ext, mem2mc_data_hw1_sign_ext)
        io.mc2mem_byte_enable :=  B"1100"
      }
    }
  }

  // == Other Logic == //
  io.mc2mem_ren := io.cpu2mc_ren
  io.mc2mem_wen := io.cpu2mc_wen
  io.mc2cpu_data_vld := io.mem2mc_data_vld
}
