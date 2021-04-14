///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: instr_dec
//
// Author: Heqing Huang
// Date Created: 03/27/2021
//
// ================== Description ==================
//
// Instruction decoder module
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._

case class instr_dec_io(param: CPU_PARAM) extends Bundle{
    val instr = in Bits(param.DATA_WIDTH bits)   // instruction input

    // Instruction field
    val rd_idx  = out UInt(5 bits)
    val func3   = out Bits(3 bits)
    val rs1_idx = out UInt(5 bits)
    val rs2_idx = out UInt(5 bits)
    val func7   = out Bits(7 bits)
    val imm_value = out SInt(param.DATA_WIDTH bits)     // Immediate value
    val jump_imm_value = out SInt(21 bits)              // Immediate value for jump instruction only

    // Register file control
    val register_wr        = out Bool
    val register_rs1_rd    = out Bool
    val register_rs2_rd    = out Bool

    // Memory control signal
    val data_ram_wr         = out Bool
    val data_ram_rd         = out Bool
    val data_ram_ld_byte    = out Bool         // load/store byte
    val data_ram_ld_hword   = out Bool         // load/store half word
    val data_ram_ld_unsign  = out Bool         // load unsigned

    // ALU control - one-hot encoding
    val alu_op_and  = out Bool
    val alu_op_or   = out Bool
    val alu_op_xor  = out Bool
    val alu_op_add  = out Bool
    val alu_op_sub  = out Bool
    val alu_op_sra  = out Bool
    val alu_op_srl  = out Bool
    val alu_op_sll  = out Bool
    val alu_op_slt  = out Bool
    val alu_op_sltu = out Bool
    val alu_op_eqt  = out Bool
    val alu_op_invb0 = out Bool
    val alu_branch_op = out Bits(2 bits)

    // Other control signal
    val op2_sel_imm  = out Bool
    val op1_sel_pc   = out Bool
    val op1_sel_zero = out Bool
    val branch_op    = out Bool
    val jal_op       = out Bool
    val jalr_op      = out Bool
    val invld_instr = out Bool
}

case class instr_dec(param: CPU_PARAM) extends Component {
    val io = instr_dec_io(param)

    // ============================================
    // Extract each field from the instruction
    // ============================================
    val opcode  = io.instr(6 downto 0)
    val func3   = io.instr(14 downto 12)
    val func7   = io.instr(31 downto 25)
    io.rd_idx   := io.instr(11 downto 7).asUInt
    io.rs1_idx  := io.instr(19 downto 15).asUInt
    io.rs2_idx  := io.instr(24 downto 20).asUInt


    // ============================================
    // Main Decoder Logic
    // ============================================

    // Note:
    // For jump instruction, ALU is used to calculate PC + 4 for the rd register value

    // selecting which immediate to use
    // branch/jump instruction uses R-type, B-type and J-type
    object br_imm_type_e extends SpinalEnum {
        val JTYPE, BTYPE, ITYPE = newElement()
    }
    val br_imm_type = br_imm_type_e()
    br_imm_type := br_imm_type_e.JTYPE

    // alu immediate value, includes I-type, S-type, U-type
    object alu_imm_type_e extends SpinalEnum {
        val ITYPE, STYPE, UTYPE, FOUR = newElement()
    }
    val alu_imm_type = alu_imm_type_e()
    alu_imm_type := alu_imm_type_e.FOUR

    // intermediate logic
    val func7_all_zero = (func7 === 0)

    // default value
    io.register_wr        := False
    io.register_rs1_rd    := False
    io.register_rs2_rd    := False
    io.data_ram_wr        := False
    io.data_ram_rd        := False
    io.data_ram_ld_byte   := False
    io.data_ram_ld_hword  := False
    io.data_ram_ld_unsign := False
    io.alu_op_and         := False
    io.alu_op_or          := False
    io.alu_op_xor         := False
    io.alu_op_add         := False
    io.alu_op_sub         := False
    io.alu_op_sra         := False
    io.alu_op_srl         := False
    io.alu_op_sll         := False
    io.alu_op_slt         := False
    io.alu_op_sltu        := False
    io.alu_op_eqt         := False
    io.alu_op_invb0       := False
    io.op2_sel_imm        := False
    io.op1_sel_pc         := False
    io.op1_sel_zero       := False
    io.branch_op          := False
    io.jal_op             := False
    io.jalr_op            := False
    io.invld_instr        := False

    // The big switch for the opcode decode
    switch(opcode) {
        // LUI
        is(param.OP_LUI) {
            io.alu_op_add   := True
            io.op2_sel_imm  := True
            io.op1_sel_zero := True
            io.register_wr  := True
            alu_imm_type    := alu_imm_type_e.UTYPE
        }
        // AUIPC
        is(param.OP_AUIPC) {
            io.alu_op_add   := True
            io.op1_sel_pc   := True
            io.op2_sel_imm  := True
            io.register_wr  := True
            alu_imm_type    := alu_imm_type_e.UTYPE
        }
        // JAL
        is(param.OP_JAL) {
            io.alu_op_add   := True
            io.op1_sel_pc   := True
            io.op2_sel_imm  := True
            io.register_wr  := True
            io.jal_op       := True
            br_imm_type     := br_imm_type_e.JTYPE
        }
        // JALR
        is(param.OP_JALR) {
            io.jalr_op          := True
            io.alu_op_add       := True
            io.op1_sel_pc       := True
            io.op2_sel_imm      := True
            io.register_wr      := True
            io.register_rs1_rd  := True
            br_imm_type         := br_imm_type_e.ITYPE
        }
        // Branch Instruction
        is(param.OP_BRANCH) {
            io.branch_op        := True
            io.register_rs1_rd  := True
            io.register_rs2_rd  := True
            br_imm_type         := br_imm_type_e.BTYPE
            switch(func3) {
                // BEQ
                is(param.BR_F3_BEQ) {
                    io.alu_op_eqt   := True
                }
                // BNE
                is(param.BR_F3_BNE) {
                    io.alu_op_eqt   := True
                    io.alu_op_invb0 := True
                }
                // BLT
                is(param.BR_F3_BLT) {
                    io.alu_op_slt   := True
                }
                // BGE
                is(param.BR_F3_BGE) {
                    io.alu_op_slt   := True
                    io.alu_op_invb0 := True
                }
                // BLTU
                is(param.BR_F3_BLTU) {
                    io.alu_op_sltu   := True
                }
                // BGEU
                is(param.BR_F3_BGEU) {
                    io.alu_op_sltu  := True
                    io.alu_op_invb0 := True
                }
                default {
                    io.invld_instr := True
                }
            }
        } // End of Branch Instruction
        // Memory Load Instruction
        is(param.OP_MEM_LOAD) {
            io.op2_sel_imm := True
            io.data_ram_rd := True
            io.register_rs1_rd := True
            io.register_wr := True
            io.alu_op_add  := True
            alu_imm_type   := alu_imm_type_e.ITYPE
            switch(func3) {
                // LB
                is(param.LW_F3_LB) {
                    io.data_ram_ld_byte := True
                }
                // LH
                is(param.LW_F3_LH) {
                    io.data_ram_ld_hword := True
                }
                // LW
                is(param.LW_F3_LW) {
                    // Doing Nothing
                }
                // LBU
                is(param.LW_F3_LBU) {
                    io.data_ram_ld_byte := True
                    io.data_ram_ld_unsign := True
                }
                // LHU
                is(param.LW_F3_LHU) {
                    io.data_ram_ld_hword := True
                    io.data_ram_ld_unsign := True
                }
                default {
                    io.invld_instr := True
                }
            }
        } // End of Memory Load Instruction
        // Memory Store Instruction
        is(param.OP_MEM_STORE) {
            io.alu_op_add       := True
            io.op2_sel_imm      := True
            io.register_rs1_rd  := True
            io.register_rs2_rd  := True
            io.data_ram_wr      := True
            alu_imm_type        := alu_imm_type_e.STYPE
            switch(func3) {
                // SB
                is(param.SW_F3_SB) {
                    io.data_ram_ld_byte := True
                }
                // SH
                is(param.SW_F3_SH) {
                    io.data_ram_ld_hword := True
                }
                // SW
                is(param.SW_F3_SW) {
                    // Doing Nothing
                }
                default {
                    io.invld_instr := True
                }
            }
        } // End of Memory Store Instruction
        // I-Type Logic/Arithmetic  Instruction
        is(param.OP_LOGIC_ARITH_IMM) {
            io.op2_sel_imm      := True
            alu_imm_type        := alu_imm_type_e.ITYPE
            io.register_rs1_rd  := True
            io.register_wr      := True
            switch(func3) {
                // ADDI
                is(param.LA_F3_ADD_SUB) {
                    io.alu_op_add   := True
                }
                // SLTI
                is(param.LA_F3_SLT) {
                    io.alu_op_slt   := True
                }
                // SLTIU
                is(param.LA_F3_SLTU) {
                    io.alu_op_sltu  := True
                }
                // XORI
                is(param.LA_F3_XOR) {
                    io.alu_op_xor   := True
                }
                // ORI
                is(param.LA_F3_OR) {
                    io.alu_op_or    := True
                }
                // ANDI
                is(param.LA_F3_AND) {
                    io.alu_op_and   := True
                }
                // SLLI
                is(param.LA_F3_SLL) {
                    io.alu_op_sll   := True
                }
                // SRLI/SRAI
                is(param.LA_F3_SR) {
                    switch(func7) {
                        // SRLI
                        is(param.LA_F7_SRL) {
                            io.alu_op_srl := True
                        }
                        // SRAI
                        is(param.LA_F7_SRA) {
                            io.alu_op_sra := True
                        }
                        default {
                            io.invld_instr := True
                        }
                    }
                }
                // No default required. Complete switch statement
            }
        } // End of I-Type Logic/Arithmetic Instruction
        // R-Type Logic/Arithmetic  Instruction
        is(param.OP_LOGIC_ARITH) {
            io.register_rs1_rd  := True
            io.register_rs2_rd  := True
            io.register_wr      := True
            switch(func3) {
                // ADD/SUB
                is(param.LA_F3_ADD_SUB) {
                    switch(func7) {
                        // ADD
                        is(param.LA_F7_ADD) {
                            io.alu_op_add := True
                        }
                        // SUB
                        is(param.LA_F7_SUB) {
                            io.alu_op_sub := True
                        }
                        default {
                            io.invld_instr := True
                        }
                    }
                }
                // SLL
                is(param.LA_F3_SLL) {
                    io.alu_op_sll   := True
                    io.invld_instr  := func7_all_zero
                }
                // SLT
                is(param.LA_F3_SLT) {
                    io.alu_op_slt   := True
                    io.invld_instr  := func7_all_zero
                }
                // SLTU
                is(param.LA_F3_SLTU) {
                    io.alu_op_sltu  := True
                    io.invld_instr  := func7_all_zero
                }
                // XOR
                is(param.LA_F3_XOR) {
                    io.alu_op_xor   := True
                    io.invld_instr  := func7_all_zero
                }
                // SRL/SRA
                is(param.LA_F3_SR) {
                    switch(func7) {
                        // SRL
                        is(param.LA_F7_SRL) {
                            io.alu_op_srl := True
                        }
                        // SRA
                        is(param.LA_F7_SRA) {
                            io.alu_op_sra := True
                        }
                        default {
                            io.invld_instr := True
                        }
                    }
                }
                // ORI
                is(param.LA_F3_OR) {
                    io.alu_op_or    := True
                    io.invld_instr  := func7_all_zero
                }
                // AND
                is(param.LA_F3_AND) {
                    io.alu_op_and   := True
                    io.invld_instr  := func7_all_zero
                }
                // No default required. Complete switch statement
            }
        } // End of R-Type Logic/Arithmetic Instruction
    }


    // TODO: FENCE Instruction

    val i_type_imm = io.instr(31 downto 20).asSInt.resize(param.DATA_WIDTH)
    val s_type_imm = (io.instr(31 downto 25) ## io.instr(11 downto 7)).asSInt.resize(param.DATA_WIDTH)
    val u_type_imm = (io.instr(31 downto 12) ## U"12'h0").asSInt
    val b_type_imm = (io.instr(31) ## io.instr(7) ## io.instr(30 downto 25) ## io.instr(11 downto 8) ## False).asSInt.resize(21)
    val j_type_imm = (io.instr(31) ## io.instr(19 downto 12) ## io.instr(20) ## io.instr(30 downto 21) ## False).asSInt

    switch(alu_imm_type) {
        is(alu_imm_type_e.ITYPE) {
            io.imm_value := i_type_imm
        }
        is(alu_imm_type_e.STYPE) {
            io.imm_value := s_type_imm
        }
        is(alu_imm_type_e.UTYPE) {
            io.imm_value := u_type_imm
        }
        default {
            io.imm_value := 4
        }
    }

    switch(br_imm_type) {
        is(br_imm_type_e.BTYPE) {
            io.jump_imm_value := b_type_imm
        }
        is(br_imm_type_e.ITYPE) {
            io.jump_imm_value := i_type_imm(20 downto 0)
        }
        default {
            io.jump_imm_value := j_type_imm
        }
    }
}