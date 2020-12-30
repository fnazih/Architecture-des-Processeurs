onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /rv32i_tb/RV32I_top_1/clk_i
add wave -noupdate /rv32i_tb/RV32I_top_1/resetn_i
add wave -noupdate /rv32i_tb/RV32I_top_1/Instruction_s
add wave -noupdate /rv32i_tb/RV32I_top_1/alu_control_s
add wave -noupdate /rv32i_tb/RV32I_top_1/reg_write_s
add wave -noupdate /rv32i_tb/RV32I_top_1/alu_src1_s
add wave -noupdate /rv32i_tb/RV32I_top_1/alu_src2_s
add wave -noupdate /rv32i_tb/RV32I_top_1/imm_gen_sel_s
add wave -noupdate /rv32i_tb/RV32I_top_1/alu_zero_s
add wave -noupdate /rv32i_tb/RV32I_top_1/alu_lt_s
add wave -noupdate /rv32i_tb/RV32I_top_1/mem_we_s
add wave -noupdate /rv32i_tb/RV32I_top_1/wb_sel_s
add wave -noupdate /rv32i_tb/RV32I_top_1/rd_add_s
add wave -noupdate /rv32i_tb/RV32I_top_1/stall_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/reg_write_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/alu_src1_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/alu_src2_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/imm_gen_sel_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/mem_we_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/wb_sel_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/rd_add_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/stall_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/instruction_o
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/alu_zero_o
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/alu_lt_o
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/pc_next_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/pc_plus4_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/pc_counter_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/instruction_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/wb_data_s
add wave -noupdate -color Yellow /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/rs1_data_s
add wave -noupdate -color Yellow /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/rs2_data_s
add wave -noupdate -color Gold /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/rs1_add_s
add wave -noupdate -color Gold /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/rs2_add_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/rd_add_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/imm_s
add wave -noupdate -color {Dark Orchid} /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/alu_control_i
add wave -noupdate -color {Dark Orchid} /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/alu_do_s
add wave -noupdate -color {Dark Orchid} /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/alu_op1_data_s
add wave -noupdate -color {Dark Orchid} /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/alu_op2_data_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/mem_do_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/dec_stage_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/exe_stage_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/mem_stage_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/instruction_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/alu_zero_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/alu_lt_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/alu_control_o
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/reg_write_o
add wave -noupdate -color Magenta /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/alu_src1_o
add wave -noupdate -color Magenta /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/alu_src2_o
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/imm_gen_sel_o
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/mem_we_o
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/wb_sel_o
add wave -noupdate -color Coral -itemcolor Orange /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/rd_add_o
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/stall_o
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/alu_op_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/inst_dec_s
add wave -noupdate -color Red /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/inst_exe_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/inst_mem_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/inst_wrb_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/stall_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/reg_file_gen(2)/reg_inst/data_o
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/reg_file_gen(3)/reg_inst/data_o
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/reg_file_gen(4)/reg_inst/data_o
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/reg_file_gen(5)/reg_inst/data_o
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/reg_file_gen(6)/reg_inst/data_o
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/reg_file_gen(2)/reg_inst/en_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/reg_file_gen(3)/reg_inst/en_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/reg_file_gen(4)/reg_inst/en_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/reg_file_gen(5)/reg_inst/en_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/reg_file_gen(6)/reg_inst/en_i
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/sel_s
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/reg_file_gen(6)/reg_inst/data_o
add wave -noupdate /rv32i_tb/RV32I_top_1/RV32I_pipeline_controlpath_1/rd_add_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {219 ns} 0} {{Cursor 2} {438 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 462
configure wave -valuecolwidth 152
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {44 ns} {524 ns}
