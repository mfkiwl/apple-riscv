///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: CPU_PARAM
//
// Author: Heqing Huang
// Date Created: 03/27/2021
//
// ================== Description ==================
//
// Define basic parameters for the CPU
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._

class CPU_PARAM {
    val NAME = "apple-riscv32"
    // ==========================
    // Basic CPU config
    // ==========================
    val DATA_WIDTH      = 32                // 32 bit cpu
    // PC
    val PC_WIDTH        = DATA_WIDTH
    // Register
    val RF_WIDTH        = DATA_WIDTH        // Register File width
    val RF_SIZE         = 32                // Register File size
    val RF_ADDR_WDITH   = log2Up(RF_SIZE)   // Register File address width
    // Instruction RAM
    val INST_RAM_DATA_WIDTH = DATA_WIDTH
    val INST_RAM_ADDR_WIDTH = 10            // 4KB Instruction RAM
    // Data RAM
    val DATA_RAM_DATA_WIDTH = DATA_WIDTH
    val DATA_RAM_ADDR_WIDTH = 20            // 4MB Data RAM

    // ==========================
    // Instruction Format
    // ==========================
    // Defining parameter for instruction format
    // will be used by decoder and ALU
    // Opcode
    val OP_LOGIC_ARITH       = Integer.parseInt("0110011", 2)        // Logic and arithmetic operation
    val OP_LOGIC_ARITH_IMM   = Integer.parseInt("0010011", 2)        // Logic and arithmetic with immediate number
    val OP_MEM_LOAD          = Integer.parseInt("0000011", 2)        // Load instruction
    val OP_MEM_STORE         = Integer.parseInt("0100011", 2)        // Store instruction
    val OP_BRANCH            = Integer.parseInt("1100011", 2)        // Branch and jump instruction
    val OP_AUIPC             = Integer.parseInt("0010111", 2)        // AUIPC instruction
    val OP_LUI               = Integer.parseInt("0110111", 2)        // LUI instruction

    // Logic arithmetic func3 field
    val LA_F3_AND      = Integer.parseInt("111", 2) // AND
    val LA_F3_OR       = Integer.parseInt("110", 2) // OR
    val LA_F3_XOR      = Integer.parseInt("100", 2) // XOR
    val LA_F3_ADD_SUB  = Integer.parseInt("000", 2) // ADD, SUB
    val LA_F3_SR       = Integer.parseInt("101", 2) // SRL, SRLI, SRA, SRAI
    val LA_F3_SL       = Integer.parseInt("001", 2) // SLL, SLLI
    val LA_F3_SLT      = Integer.parseInt("010", 2) // SLT, SLTI
    val LA_F3_SLTU     = Integer.parseInt("011", 2) // SLTU, SLTIU
}