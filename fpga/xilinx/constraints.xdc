
#
# Set don't touch on each component so vivado won't merge the hierarchy together
# Remember to remove then to enable optimization in the final build
#
set_property DONT_TOUCH "yes" [get_cells cpu_core/alu_inst]
set_property DONT_TOUCH "yes" [get_cells cpu_core/instr_dec_inst]
set_property DONT_TOUCH "yes" [get_cells cpu_core/regfile_inst]
set_property DONT_TOUCH "yes" [get_cells cpu_core/dmem_ctrl_isnt]
set_property DONT_TOUCH "yes" [get_cells cpu_core/imem_ctrl_inst]
set_property DONT_TOUCH "yes" [get_cells cpu_core/fu_inst]
set_property DONT_TOUCH "yes" [get_cells cpu_core/hdu_inst]
set_property DONT_TOUCH "yes" [get_cells dmem_inst]
set_property DONT_TOUCH "yes" [get_cells imem_inst]