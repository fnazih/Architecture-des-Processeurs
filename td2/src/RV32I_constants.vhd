-------------------------------------------------------------------------------
-- Title      : DLX constants
-- Project    : 
-------------------------------------------------------------------------------
-- File       : DLX_consts.vhd
-- Author     :   <michel agoyan@ROU13572>
-- Company    : 
-- Created    : 2015-11-24
-- Last update: 2019-12-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Constants used for the RV32I degign
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2015-11-24  1.0      michel agoyan   Created
-- 2019-08-21  1.1      olivier potin   Update for 32-bit RISCV 
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-- RV32I Instruction format
-- Register instructions (R)
--___________________________________________________________________________
-- | 31   -   25 | 24  -  20 | 19  -  15 | 14  -  12 | 11   -   7 | 6  -  0 |
--___________________________________________________________________________
--     funct7         rs2         rs1       funct3         rd       opcode 
--___________________________________________________________________________

-- Immediate instructions (I)
--___________________________________________________________________________
-- | 31          -        20 | 19  -  15 | 14  -  12 | 11   -   7 | 6  -  0 |
--___________________________________________________________________________
--         Imm[11:0]            rs1       funct3           rd       opcode 
--___________________________________________________________________________

-- Shift instructions (S)
--___________________________________________________________________________
-- | 31   -   25 | 24  -  20 | 19  -  15 | 14  -  12 | 11   -   7 | 6  -  0 |
--___________________________________________________________________________
--   Imm[11:5]        rs2         rs1       funct3     Imm[4:0]     opcode 
--___________________________________________________________________________

-- Branch instructions (B)
--___________________________________________________________________________
-- | 31   -   25 | 24  -  20 | 19  -  15 | 14  -  12 | 11   -   7 | 6  -  0 |
--___________________________________________________________________________
--   Imm[12|10:5]     rs2         rs1       funct3     Imm[4:1|11]  opcode 
--___________________________________________________________________________

-- Upper instructions (U)
--___________________________________________________________________________
-- | 31                    -                      12 | 11   -   7 | 6  -  0 |
--___________________________________________________________________________
--                      Imm[31:12]                        rd        opcode 
--___________________________________________________________________________

-- Jump instruction (J)
--___________________________________________________________________________
-- | 31                    -                      12 | 11   -   7 | 6  -  0 |
--___________________________________________________________________________
--                 Imm[20|10:1|11|19:12]                  rd        opcode 
--___________________________________________________________________________

package RV32I_constants is

  -- RV32I opcodes
  -- R instruction opcode
  constant RV32I_R_INSTR : std_logic_vector(6 downto 0) := "0110011";

  -- Funct7 instruction definition for R instructions
  constant RV32I_FUNCT7_ADD  : std_logic_vector(6 downto 0) := "0000000";
  constant RV32I_FUNCT7_SUB  : std_logic_vector(6 downto 0) := "0100000";
  constant RV32I_FUNCT7_SLL  : std_logic_vector(6 downto 0) := "0000000";
  constant RV32I_FUNCT7_SLT  : std_logic_vector(6 downto 0) := "0000000";
  constant RV32I_FUNCT7_SLTU : std_logic_vector(6 downto 0) := "0000000";
  constant RV32I_FUNCT7_XOR  : std_logic_vector(6 downto 0) := "0000000";
  constant RV32I_FUNCT7_SRL  : std_logic_vector(6 downto 0) := "0000000";
  constant RV32I_FUNCT7_SRA  : std_logic_vector(6 downto 0) := "0100000";
  constant RV32I_FUNCT7_OR   : std_logic_vector(6 downto 0) := "0000000";
  constant RV32I_FUNCT7_AND  : std_logic_vector(6 downto 0) := "0000000";

  -- I instruction opcode
  constant RV32I_I_INSTR_JALR   : std_logic_vector(6 downto 0) := "1100111";
  constant RV32I_I_INSTR_LOAD   : std_logic_vector(6 downto 0) := "0000011";
  constant RV32I_I_INSTR_OPER   : std_logic_vector(6 downto 0) := "0010011";
  constant RV32I_I_INSTR_FENCE  : std_logic_vector(6 downto 0) := "0001111";
  constant RV32I_I_INSTR_ENVCSR : std_logic_vector(6 downto 0) := "1110011";

  -- S instruction opcode
  constant RV32I_S_INSTR : std_logic_vector(6 downto 0) := "0100011";

  -- B instruction opcode
  constant RV32I_B_INSTR : std_logic_vector(6 downto 0) := "1100011";

  -- U instruction opcode
  constant RV32I_U_INSTR_LUI   : std_logic_vector(6 downto 0) := "0110111";
  constant RV32I_U_INSTR_AUIPC : std_logic_vector(6 downto 0) := "0010111";

  -- J instruction opcode
  constant RV32I_J_INSTR : std_logic_vector(6 downto 0) := "1101111";

  -- ALU operations 
  constant ALU_OP_COPY  : std_logic_vector(1 downto 0) := "11";  -- copy RS1 content to ALU output
  constant ALU_OP_FUNCT : std_logic_vector(1 downto 0) := "10";  -- operations depend on funct7
  constant ALU_OP_SUB   : std_logic_vector(1 downto 0) := "01";  -- operation is subtraction 
  constant ALU_OP_ADD   : std_logic_vector(1 downto 0) := "00";  -- compute address calculation (Store and Load instructions)

  -- Immediat Extender
  constant IMM12_SIGEXTD_I : std_logic_vector(1 downto 0) := "00";
  constant IMM12_SIGEXTD_S : std_logic_vector(1 downto 0) := "01";
  constant IMM20_UNSIGN_U  : std_logic_vector(1 downto 0) := "10";
  constant IMM12_SIGEXTD_B : std_logic_vector(1 downto 0) := "11";


  -- Funct3 instruction definitions for I, R instructions
  constant RV32I_FUNCT3_ADD  : std_logic_vector(2 downto 0) := "000";
  constant RV32I_FUNCT3_SUB  : std_logic_vector(2 downto 0) := "000";
  constant RV32I_FUNCT3_SLL  : std_logic_vector(2 downto 0) := "001";
  constant RV32I_FUNCT3_SLT  : std_logic_vector(2 downto 0) := "010";
  constant RV32I_FUNCT3_SLTU : std_logic_vector(2 downto 0) := "011";
  constant RV32I_FUNCT3_XOR  : std_logic_vector(2 downto 0) := "100";
  constant RV32I_FUNCT3_SR   : std_logic_vector(2 downto 0) := "101";
  constant RV32I_FUNCT3_OR   : std_logic_vector(2 downto 0) := "110";
  constant RV32I_FUNCT3_AND  : std_logic_vector(2 downto 0) := "111";

  

  -- Funct3 instruction definitions for LOAD/STORE instructions
  
  constant RV32I_FUNCT3_LS_WORD     : std_logic_vector(2 downto 0) := "010";
 
  --ALU opcodes
  constant ALU_ADD      : std_logic_vector(3 downto 0) := X"1";
  constant ALU_SUB      : std_logic_vector(3 downto 0) := X"2";
  constant ALU_SLLV     : std_logic_vector(3 downto 0) := X"3";
  constant ALU_SRLV     : std_logic_vector(3 downto 0) := X"4";
  constant ALU_SRAV     : std_logic_vector(3 downto 0) := X"5";
  constant ALU_AND      : std_logic_vector(3 downto 0) := X"6";
  constant ALU_OR       : std_logic_vector(3 downto 0) := X"7";
  constant ALU_XOR      : std_logic_vector(3 downto 0) := X"8";
  constant ALU_SLT      : std_logic_vector(3 downto 0) := X"9";
  constant ALU_SLTU     : std_logic_vector(3 downto 0) := X"A";
  constant ALU_COPY_RS1 : std_logic_vector(3 downto 0) := X"B";
  constant ALU_X        : std_logic_vector(3 downto 0) := X"0";

  -- Alu operand1 selector
  constant SEL_OP1_RS1 : std_logic_vector(1 downto 0) := "00";
  constant SEL_OP1_IMM : std_logic_vector(1 downto 0) := "01";
  constant SEL_OP1_PC  : std_logic_vector(1 downto 0) := "10";
  constant SEL_OP1_X   : std_logic_vector(1 downto 0) := "11";


  -- Alu operand2 selector
  constant SEL_OP2_RS2 : std_logic_vector(0 downto 0) := "0";
  constant SEL_OP2_IMM : std_logic_vector(0 downto 0) := "1";

 

  --WE
  constant WE_0 : std_logic := '0';
  constant WE_1 : std_logic := '1';

end package RV32I_constants;
