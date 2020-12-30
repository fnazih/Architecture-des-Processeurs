-------------------------------------------------------------------------------
-- Title      : DLX_controlpath
-- Project    : 
-------------------------------------------------------------------------------
-- File       : DLX_controlpath.vhd
-- Author     :   <michel agoyan@ROU13572>
-- Company    : 
-- Created    : 2015-11-25
-- Last update: 2019-12-15
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
-- 2019-08-21  1.1      Olivier potin   Modified to implement RISCV pipeline
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.RV32I_constants.all;

entity RV32I_pipeline_controlpath is

  port (
    clk_i         : in  std_logic;
    resetn_i      : in  std_logic;
    instruction_i : in  std_logic_vector(31 downto 0);
    alu_zero_i    : in  std_logic;  -- ALU "zero" signal flag (ALU result operation = 0x0)
    alu_lt_i      : in  std_logic;      -- ALU "less than" signal flag
    alu_control_o : out std_logic_vector(3 downto 0);  -- select ALU operation
    reg_write_o   : out std_logic;      -- Register write enable
    alu_src1_o    : out std_logic_vector(1 downto 0);  -- select ALU operand 1
    alu_src2_o    : out std_logic_vector(0 downto 0);  -- select ALU operand 2
    imm_gen_sel_o : out std_logic_vector(1 downto 0);  --select the type of imm
    mem_we_o      : out std_logic;
    wb_sel_o      : out std_logic_vector(1 downto 0);
    rd_add_o      : out std_logic_vector(4 downto 0);
    stall_o       : out std_logic);

end entity RV32I_pipeline_controlpath;

architecture RV32I_pipeline_controlpath_architecture of RV32I_pipeline_controlpath is
  signal alu_op_s : std_logic_vector(1 downto 0);
  signal Branch_s : std_logic;

  signal inst_dec_s : std_logic_vector(31 downto 0);  --instruction bus decode stage
  signal inst_exe_s : std_logic_vector(31 downto 0);  --instruction bus execute stage
  signal inst_mem_s : std_logic_vector(31 downto 0);  --instruction bus memory stage
  signal inst_wrb_s : std_logic_vector(31 downto 0);  --instruction bus write back stage

  signal stall_s : std_logic;

  signal rs1_add_s : std_logic_vector(4 downto 0);
  signal rs2_add_s : std_logic_vector(4 downto 0);
  signal rd_add_s  : std_logic_vector(4 downto 0);
  
begin  -- architecture RV32I_pipeline_controlpath_architecture

  inst_dec_s <= instruction_i;
  --
  rs1_add_s <= inst_dec_s(19 downto 15);
  rs2_add_s <= inst_dec_s(24 downto 20);
  
  -- purpose: pipeline the instruction bus
  -- type   : sequential
  -- inputs : clk_i, resetn_i
  -- outputs: inst_dec_s,inst_exe_s,inst_mem_s,inst_wb_s
  inst_pipeline : process (clk_i, resetn_i) is
  begin  -- process inst_pipeline
    if resetn_i = '0' then                  -- asynchronous reset (active low)
      inst_exe_s <= (others => '0');
      inst_mem_s <= (others => '0');
      inst_wrb_s <= (others => '0');
    elsif clk_i'event and clk_i = '1' then  -- rising clock edge
  
      inst_exe_s <= instruction_i;
      inst_mem_s <= inst_exe_s;
      inst_wrb_s <= inst_mem_s;
    end if;
  end process inst_pipeline;


  stall_s <= '0';
  stall_o <= stall_s;

  -- purpose: generate signals to control the dec_stage of the datapath
  -- type   : combinational
  -- inputs : inst_dec_s
  -- outputs: 
  dec_comb_proc : process (inst_dec_s) is
  begin  -- process dec_comb_proc

    case inst_dec_s(6 downto 0) is
      when RV32I_R_INSTR =>
        alu_src2_o    <= SEL_OP2_RS2;
        alu_src1_o    <= SEL_OP1_RS1;
        imm_gen_sel_o <= (others => '0');  -- don't care about immm gen


      when RV32I_U_INSTR_LUI =>
        alu_src2_o    <= (others => '0');  -- don't care about ALU op2
        alu_src1_o    <= SEL_OP1_IMM;
        imm_gen_sel_o <= IMM20_UNSIGN_U;

      when RV32I_I_INSTR_OPER =>
        alu_src2_o    <= SEL_OP2_IMM;
        alu_src1_o    <= SEL_OP1_RS1;
        imm_gen_sel_o <= IMM12_SIGEXTD_I;


      when others =>
        assert false report "unknown instruction" severity warning;
        alu_src2_o    <= (others => '0');
        alu_src1_o    <= (others => '0');
        imm_gen_sel_o <= (others => '0');

    end case;
  end process dec_comb_proc;

  -- purpose: generate signals to control the exe_stage of the datapath
  -- type   : combinational
  -- inputs : inst_ex_s
  -- outputs: 
  exe_comb_proc : process (inst_exe_s) is
  begin  -- process dec_comb_proc

    case inst_exe_s(6 downto 0) is
      when RV32I_R_INSTR =>
        alu_op_s <= ALU_OP_FUNCT;

      when RV32I_U_INSTR_LUI =>
        alu_op_s <= ALU_OP_COPY;

      when RV32I_I_INSTR_OPER =>
        alu_op_s <= ALU_OP_FUNCT;
      when others =>
        assert false report "unknown instruction" severity warning;
        alu_op_s <= (others => '0');

    end case;
  end process exe_comb_proc;


  -- ALU control process
  -- purpose: control ALU operation according to ALUOp from control process and funct3 bits of ISA
  -- type   : combinational
  -- inputs : alu_op_s, inst_exe_s_i
  -- outputs: alu_control_o
  ALUcontrol : process(alu_op_s, inst_exe_s)
    variable func3_v : std_logic_vector(2 downto 0);
  begin
    func3_v := inst_exe_s(14 downto 12);
    case alu_op_s is
      when ALU_OP_ADD =>
        alu_control_o <= ALU_ADD;

      when ALU_OP_FUNCT =>
        case func3_v is
          when RV32I_FUNCT3_ADD =>
            if (inst_exe_s(6 downto 0) = RV32I_R_INSTR) and (inst_exe_s(30) = '1') then
              alu_control_o <= ALU_SUB;
            else
              alu_control_o <= ALU_ADD;
            end if;
          when RV32I_FUNCT3_OR =>
            alu_control_o <= ALU_OR;
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


  -- purpose: generate signals to control the mem_stage of the datapath
  -- type   : combinational
  -- inputs : inst_mem_s
  -- outputs: 
  mem_comb_proc : process (inst_mem_s) is
  begin  -- process dec_comb_proc

    case inst_mem_s(6 downto 0) is
      when RV32I_R_INSTR =>
        mem_we_o <= WE_0;
        wb_sel_o <= SEL_ALU_TO_REG;
        rd_add_s    <= inst_mem_s(11 downto 7);
        reg_write_o <= WE_1;
      when RV32I_U_INSTR_LUI =>
        mem_we_o <= WE_0;
        wb_sel_o <= SEL_ALU_TO_REG;
        rd_add_s    <= inst_mem_s(11 downto 7);
        reg_write_o <= WE_1;
      when RV32I_I_INSTR_OPER =>
        mem_we_o <= WE_0;
        wb_sel_o <= SEL_ALU_TO_REG;
        rd_add_s    <= inst_mem_s(11 downto 7);
        reg_write_o <= WE_1;
      when others =>
        assert false report "unknown instruction" severity warning;
        mem_we_o <= WE_0;
        wb_sel_o <= (others => '0');
        rd_add_s    <= (others => '0');
        reg_write_o <= WE_0;
        
    end case;
  end process mem_comb_proc;


 rd_add_o <=rd_add_s;
  


end architecture RV32I_pipeline_controlpath_architecture;

