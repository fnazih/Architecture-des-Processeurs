-------------------------------------------------------------------------------
-- Title      : DLX_controlpath
-- Project    : 
-------------------------------------------------------------------------------
-- File       : DLX_controlpath.vhd
-- Author     :   <michel agoyan@ROU13572>
-- Company    : 
-- Created    : 2015-11-25
-- Last update: 2019-12-09
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: DLX control path
-------------------------------------------------------------------------------
-- Copyright (c) 2015 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2015-11-25  1.0      michel agoyan   Created
-- 2019-08-21  1.1      Olivier potin   Modified to implement RISCV Monocycle
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.RV32I_constants.all;

entity RV32I_Monocycle_controlpath is

  port (
    instruction_i : in  std_logic_vector(31 downto 0);
    alu_zero_i    : in  std_logic;  -- ALU "zero" signal flag (ALU result operation = 0x0)
    alu_lt_i      : in  std_logic;      -- ALU "less than" signal flag
    alu_src1_o    : out std_logic_vector(1 downto 0);  -- select ALU operand 1
    alu_src2_o    : out std_logic_vector(0 downto 0);  -- select ALU operand 2
    imm_gen_sel_o : out std_logic_vector(1 downto 0);  --select the type of imm
                                                       --generation
    alu_control_o : out std_logic_vector(3 downto 0);  -- select ALU operation
    reg_write_o   : out std_logic);     -- Register write enable

end entity RV32I_Monocycle_controlpath;

architecture RV32I_Monocycle_controlpath_architecture of RV32I_Monocycle_controlpath is
  signal alu_op_s  : std_logic_vector(1 downto 0);
  signal Branch_s : std_logic;
begin  -- architecture RV32I_Monocycle_controlpath_architecture

  
  -- ALU control process
  -- purpose: control ALU operation according to ALUOp from control process and funct3 bits of ISA
  -- type   : combinational
  -- inputs : alu_op_s, Instruction_i
  -- outputs: alu_control_o
  ALUcontrol : process(alu_op_s, Instruction_i)
    variable func3_v : std_logic_vector(2 downto 0);
  begin
    func3_v := Instruction_i(14 downto 12);
    case alu_op_s is
      when ALU_OP_ADD =>
        alu_control_o <= ALU_ADD;
     
      when ALU_OP_FUNCT =>
        case func3_v is
          when "000" =>
            if (Instruction_i(6 downto 0) = RV32I_R_INSTR) and (Instruction_i(30) = '0') then
              alu_control_o <= ALU_ADD;
            end if;
       
          when others =>
            assert false report "instruction-bit [14 - 12] are not well-defined" severity warning;
            alu_control_o <= ALU_X;
        end case;
      when ALU_OP_COPY =>
        alu_control_o <= ALU_COPY_RS1;
      when others =>
        assert false report "ALU operation is not defined" severity warning;
        alu_control_o <= ALU_X;
    end case;
  end process ALUControl;



  -- purpose: implement LUT  to generate  signals to control the datapath
  -- type   : combinational
  -- inputs : Instruction_i
  -- outputs: 
  -- alu_src2_o = 
  -- alu_Src1_o = 
  -- reg_write_o = 
  -- alu_op_s = 
  controlpath_combinational_process : process (Instruction_i) is
  begin
    case Instruction_i(6 downto 0) is
      when RV32I_R_INSTR =>
        alu_src2_o  <= (others => '0');
        alu_src1_o  <= (others => '0');
        imm_gen_sel_o <= (others => '0');  -- don't care about immm gen
        reg_write_o <= WE_1;
        alu_op_s     <= ALU_OP_FUNCT;


    
      when others =>
        assert false report "unknown instruction" severity warning;
        alu_src2_o  <= (others => '0');
        alu_src1_o  <= (others => '0');
        imm_gen_sel_o <= (others => '0'); 
        reg_write_o <= '0';
        alu_op_s     <= (others => '0');

    end case;
  end process controlpath_combinational_process;
end architecture RV32I_Monocycle_controlpath_architecture;

