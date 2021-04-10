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
import spinal.lib.bus.amba3.ahblite._

class CPU_PARAM {

    val NAME = "apple-riscv32"

    //////////////////////////////////////////////////////////////////////////////////
    //                              CPU Core Parameter                              //
    //////////////////////////////////////////////////////////////////////////////////

    // ========================== //
    //  CPU config and Parameter  //
    // ========================== //
    val XLEN       = 32
    val DATA_WIDTH = XLEN
    val PC_WIDTH   = DATA_WIDTH
    val RF_WIDTH   = DATA_WIDTH                 // Register File width
    val RF_SIZE    = 32                         // Register File size
    val RF_ADDR_WDITH   = log2Up(RF_SIZE)       // Register File address width
    val INSTR_RAM_DATA_WIDTH = DATA_WIDTH
    val INSTR_RAM_ADDR_WIDTH = 16               // 64KB Instruction RAM for now
    val DATA_RAM_DATA_WIDTH = DATA_WIDTH
    val DATA_RAM_ADDR_WIDTH = 16                // 64KB Data RAM for now

    // ========================== //
    //       AHB Bus Config       //
    // ========================== //
    val imem_ahbCfg = AhbLite3Config(
        addressWidth = INSTR_RAM_ADDR_WIDTH,
        dataWidth    = INSTR_RAM_DATA_WIDTH
    )
    val dmem_ahbCfg = AhbLite3Config(
        addressWidth = DATA_RAM_ADDR_WIDTH,
        dataWidth    = DATA_RAM_DATA_WIDTH
    )

    //////////////////////////////////////////////////////////////////////////////////
    //                           Constant Definition                                //
    //////////////////////////////////////////////////////////////////////////////////

    // ========================== //
    //     Instruction Decode     //
    // ========================== //

    // == opcode == //
    // TODO: Potential optimization. Remove the "11" bits
    val OP_LOGIC_ARITH      = Integer.parseInt("0110011", 2)        // Logic and arithmetic operation
    val OP_LOGIC_ARITH_IMM  = Integer.parseInt("0010011", 2)        // Logic and arithmetic with immediate number
    val OP_MEM_LOAD         = Integer.parseInt("0000011", 2)        // Load instruction
    val OP_MEM_STORE        = Integer.parseInt("0100011", 2)        // Store instruction
    val OP_BRANCH           = Integer.parseInt("1100011", 2)        // Branch and jump instruction
    val OP_AUIPC            = Integer.parseInt("0010111", 2)        // AUIPC instruction
    val OP_LUI              = Integer.parseInt("0110111", 2)        // LUI instruction
    val OP_JAL              = Integer.parseInt("1101111", 2)        // JAL
    val OP_JALR             = Integer.parseInt("1100111", 2)        // JALR
    val OP_FEANCE           = Integer.parseInt("0001111", 2)        // FANCE

    // == func3 == //
    // Logic arithmetic func3 field
    val LA_F3_AND       = Integer.parseInt("111", 2) // AND
    val LA_F3_OR        = Integer.parseInt("110", 2) // OR
    val LA_F3_XOR       = Integer.parseInt("100", 2) // XOR
    val LA_F3_ADD_SUB   = Integer.parseInt("000", 2) // ADD, SUB
    val LA_F3_SR        = Integer.parseInt("101", 2) // SRL, SRLI, SRA, SRAI
    val LA_F3_SL        = Integer.parseInt("001", 2) // SLL, SLLI
    val LA_F3_SLT       = Integer.parseInt("010", 2) // SLT, SLTI
    val LA_F3_SLTU      = Integer.parseInt("011", 2) // SLTU, SLTIU
    // Load/Store func3 field
    val LS_F3_LB_SB = Integer.parseInt("000", 2) // SB, LB
    val LS_F3_LH_SH = Integer.parseInt("001", 2) // LH, SH
    val LS_F3_LW_SW = Integer.parseInt("010", 2) // LW, SW
    val LS_F3_LBU   = Integer.parseInt("100", 2) // LBU
    val LS_F3_LHU   = Integer.parseInt("101", 2) // LHU
    // Branch func3 field
    val BR_F3_BEQ   = Integer.parseInt("000", 2) // BEQ
    val BR_F3_BNE   = Integer.parseInt("001", 2) // BNE
    val BR_F3_BLT   = Integer.parseInt("100", 2) // BLT
    val BR_F3_BGE   = Integer.parseInt("101", 2) // BGE
    val BR_F3_BLTU  = Integer.parseInt("110", 2) // BLTU
    val BR_F3_BGEU  = Integer.parseInt("111", 2) // BGEU
    // Fence func3 field
    val FE_F3_FENCE =  Integer.parseInt("000", 2) // FENCE
    val FE_F3_FENCEI =  Integer.parseInt("001", 2) // FENCE.I
}