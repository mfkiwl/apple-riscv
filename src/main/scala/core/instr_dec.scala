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
    val brjp_imm_value = out SInt(21 bits)              // Immediate value for branch/jump instruction only

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

    // Other control signal
    val op2_sel_imm  = out Bool
    val op1_sel_pc   = out Bool
    val op1_sel_zero = out Bool
    val branch_op    = out Bool
    val jal_op       = out Bool
    val jalr_op      = out Bool
    val invalid_instr = out Bool
}

case class instr_dec(param: CPU_PARAM) extends Component {
    val io = instr_dec_io(param)

    // ============================================
    // Extract each field from the instruction
    // ============================================
    val opcode  = io.instr(6 downto 0)
    io.rd_idx   := io.instr(11 downto 7).asUInt
    io.func3    := io.instr(14 downto 12)
    io.rs1_idx  := io.instr(19 downto 15).asUInt
    io.rs2_idx  := io.instr(24 downto 20).asUInt
    io.func7    := io.instr(31 downto 25)

    // ============================================
    // Main Decoder Logic
    // ============================================

    // == Extract Instruction field == //
    val op_logic_arithm = (opcode === param.OP_LOGIC_ARITH)
    val op_logic_arithm_imm = (opcode === param.OP_LOGIC_ARITH_IMM)
    val op_store = (opcode === param.OP_MEM_STORE)
    val op_load = (opcode === param.OP_MEM_LOAD)
    val op_branch = (opcode === param.OP_BRANCH)
    val op_lui = (opcode === param.OP_LUI)
    val op_auipc = (opcode === param.OP_AUIPC)
    val op_jal = (opcode === param.OP_JAL)
    val op_jalr = (opcode === param.OP_JALR)
    val op_fence = (opcode === param.OP_FEANCE)
    /*
    Note on fence instruction
    Since we are doing in order access, so the memory access order is already satisfied.
    Just treat it as nop instruction.
    */


    // == ALU opcode == //
    /*
    Note 1: Here we do not distinguish btw R type and I type. It is taken cared by the mux before ALU operand 2
    Note 2: BLT/BGE/BLTU/BGEU shares the same slt (set less than) operation and we invert the result if
            it is BGE/BGEU by asserting alu_int_b0
    Note 3: BEQ/BNE shares the same eqt operation and we invert the result for BNE
    Note 4: For JRA/JRAL, alu is going to calculate the value going to register rd which is pc + 4. The jump address
            will be calculated in branch unit. So the decode logic will set the immediate value to 4 for ALU operand2
            and set pc_sel to select pc for ALU operand1.
            By using this method, we can reduce the critical path on the ALU by reducing some mux-ing logic
     */

    val func7_shift_arithm = io.func7(5)
    val func7_subtraction = io.func7(5)

    val logic_slt = (op_logic_arithm | op_logic_arithm_imm) & (io.func3 === param.LA_F3_SLT)
    val branch_slt = op_branch & (io.func3(2 downto 1) === B"10") // Do slt for blt and bge
    val branch_sltu = op_branch & (io.func3(2 downto 1) === B"11") // Do sltu for bltu and bgeu
    val logic_add = op_logic_arithm & (io.func3 === param.LA_F3_ADD_SUB) & ~func7_subtraction
    val logic_add_imm = op_logic_arithm_imm & (io.func3 === param.LA_F3_ADD_SUB)

    io.alu_op_and := (op_logic_arithm | op_logic_arithm_imm) & (io.func3 === param.LA_F3_AND)
    io.alu_op_or := (op_logic_arithm | op_logic_arithm_imm) & (io.func3 === param.LA_F3_OR)
    io.alu_op_xor := (op_logic_arithm | op_logic_arithm_imm) & (io.func3 === param.LA_F3_XOR)
    io.alu_op_add := logic_add | logic_add_imm | op_auipc | op_lui | op_load | op_store | op_jal | op_jalr
    io.alu_op_sub := op_logic_arithm & (io.func3 === param.LA_F3_ADD_SUB) & func7_subtraction
    io.alu_op_sra := (op_logic_arithm | op_logic_arithm_imm) & (io.func3 === param.LA_F3_SR) & func7_shift_arithm
    io.alu_op_srl := (op_logic_arithm | op_logic_arithm_imm) & (io.func3 === param.LA_F3_SR) & ~func7_shift_arithm
    io.alu_op_sll := (op_logic_arithm | op_logic_arithm_imm) & (io.func3 === param.LA_F3_SL)
    io.alu_op_slt := logic_slt | branch_slt
    io.alu_op_sltu := branch_sltu | (op_logic_arithm | op_logic_arithm_imm) & (io.func3 === param.LA_F3_SLTU)
    io.alu_op_eqt := op_branch & (io.func3 === param.BR_F3_BEQ | io.func3 === param.BR_F3_BNE)
    io.alu_op_invb0 := op_branch & (io.func3(0) === True)

    // == Other control signal == //
    io.op1_sel_pc := op_auipc | op_jal | op_jalr
    io.op2_sel_imm := (op_logic_arithm_imm | op_load | op_store | op_lui | op_auipc | op_jal | op_jalr)
    io.op1_sel_zero := op_lui
    io.branch_op := op_branch
    io.jal_op := op_jal
    io.jalr_op := op_jalr
    io.register_wr := (op_logic_arithm | op_logic_arithm_imm | op_load | op_lui | op_auipc | op_jal | op_jalr)
    io.register_rs1_rd := (op_logic_arithm | op_logic_arithm_imm | op_load | op_store | op_branch | op_jalr)
    io.register_rs2_rd := op_logic_arithm | op_store | op_branch
    io.data_ram_wr := op_store
    io.data_ram_rd := op_load
    io.data_ram_ld_byte := (io.func3 === param.LS_F3_LB_SB | io.func3 === param.LS_F3_LBU)
    io.data_ram_ld_hword := (io.func3 === param.LS_F3_LH_SH | io.func3 === param.LS_F3_LHU)
    io.data_ram_ld_unsign := (io.func3 === param.LS_F3_LBU) | (io.func3 === param.LS_F3_LHU)


    // Immediate value
    // Immediate value are always signed extended to 32 bits
    when(op_logic_arithm_imm | op_load) {
        val imm_11_0 = io.instr(31 downto 20).asSInt
        io.imm_value := imm_11_0.resized
    }.elsewhen(op_store) {
        // Immediate value are signed extended to 32 bits for story operation
        val imm_4_0 = io.instr(11 downto 7)
        val imm_11_5 = io.instr(31 downto 25)
        val imm_11_0 = imm_11_5 ## imm_4_0
        io.imm_value := imm_11_0.asSInt.resized
    }.elsewhen(op_jal | op_jalr) {
        io.imm_value := 4
    }.otherwise { // Remaining cases: LUI and AUIPC
        val imm_11_0 = U"12'h0"
        val imm_31_12 = io.instr(31 downto 12)
        io.imm_value := (imm_31_12 ## imm_11_0).asSInt
    }

    when(op_branch) {
        val imm_0           = False
        val imm_4_1         = io.instr(11 downto 8)
        val imm_10_5        = io.instr(30 downto 25)
        val imm_11          = io.instr(7)
        val imm_12          = io.instr(31)
        val imm_12_0        = imm_12 ## imm_11 ## imm_10_5 ## imm_4_1 ## imm_0
        io.brjp_imm_value   := imm_12_0.asSInt.resized
    }.elsewhen(op_jalr){
        val imm_11_0        = io.instr(31 downto 20).asSInt
        io.brjp_imm_value   := imm_11_0.resized
    }.otherwise {   // For JAL
        val imm_0           = False
        val imm_10_1        = io.instr(30 downto 21)
        val imm_11          = io.instr(20)
        val imm_19_12       = io.instr(19 downto 12)
        val imm_20          = io.instr(31)
        val imm_20_0        = imm_20 ## imm_19_12 ## imm_11 ## imm_10_1 ## imm_0
        io.brjp_imm_value   := imm_20_0.asSInt
    }

    // detect invalid instruction
    val invalid_opcode  = ~(op_logic_arithm | op_logic_arithm_imm | op_store | op_load | op_branch |
                           op_lui  | op_auipc | op_jal  | op_jalr | op_fence)
    val invalid_load    = op_load & (io.func3(2 downto 1) === B"11" | io.func3(1 downto 0) === B"11")
    val invalid_store   = op_store & (io.func3(2) === True | io.func3(1 downto 0) === B"11")
    val invalid_branch  = op_branch & (io.func3(2 downto 1) === B"01")
    val invalid_jalr    = op_jalr & (io.func3 =/= B"000")
    val invalid_fence   = op_fence & (io.func3(2 downto 1) =/= B"00")
    // FIXME: logic and immediate type needs more detection
    io.invalid_instr    :=  invalid_opcode | invalid_load | invalid_store | invalid_branch | invalid_jalr | invalid_fence
}