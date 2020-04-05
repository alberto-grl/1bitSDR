#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file C:/Users/Rinaldi-i3/lattice/FPGASDR_3/impl1/launch_synplify.tcl
#-- Written on Sat Jan  4 14:07:08 2020

project -close
set filename "C:/Users/Rinaldi-i3/lattice/FPGASDR_3/impl1/impl1_syn.prj"
if ([file exists "$filename"]) {
	project -load "$filename"
	project_file -remove *
} else {
	project -new "$filename"
}
set create_new 0

#device options
set_option -technology MACHXO2
set_option -part LCMXO2_7000HE
set_option -package TG144C
set_option -speed_grade -4

if {$create_new == 1} {
#-- add synthesis options
	set_option -symbolic_fsm_compiler true
	set_option -resource_sharing true
	set_option -vlog_std v2001
	set_option -frequency auto
	set_option -maxfan 1000
	set_option -auto_constrain_io 0
	set_option -disable_io_insertion false
	set_option -retiming false; set_option -pipe true
	set_option -force_gsr false
	set_option -compiler_compatible 0
	set_option -dup false
	
	set_option -default_enum_encoding default
	
	
	
	set_option -write_apr_constraint 1
	set_option -fix_gated_and_generated_clocks 1
	set_option -update_models_cp 0
	set_option -resolve_multiple_driver 0
	
	
}
#-- add_file options
set_option -include_path "C:/Users/Rinaldi-i3/lattice/FPGASDR_3"
add_file -verilog "C:/Users/Rinaldi-i3/lattice/FPGASDR_3/impl1/source/top.v"
add_file -verilog "C:/Users/Rinaldi-i3/lattice/FPGASDR_3/impl1/source/UartRX.v"
add_file -verilog "C:/Users/Rinaldi-i3/lattice/FPGASDR_3/impl1/source/UartTX.v"
add_file -verilog "C:/Users/Rinaldi-i3/lattice/FPGASDR_3/NCO.v"
add_file -verilog "C:/Users/Rinaldi-i3/lattice/FPGASDR_3/Mixer.v"
add_file -verilog "C:/Users/Rinaldi-i3/lattice/FPGASDR_3/SinCos.v"
add_file -verilog "C:/Users/Rinaldi-i3/lattice/FPGASDR_3/CIC.v"
add_file -verilog "C:/Users/Rinaldi-i3/lattice/FPGASDR_3/PWM.v"
add_file -verilog "C:/Users/Rinaldi-i3/lattice/FPGASDR_3/HP_shift.v"
add_file -verilog "C:/Users/Rinaldi-i3/lattice/FPGASDR_3/frequency_select.v"
add_file -verilog "C:/Users/Rinaldi-i3/lattice/FPGASDR_3/PLL.v"
add_file -verilog "C:/Users/Rinaldi-i3/lattice/FPGASDR_3/CarrierPLL.v"
#-- top module name
set_option -top_module {top}
project -result_file {C:/Users/Rinaldi-i3/lattice/FPGASDR_3/impl1/impl1.edi}
project -save "$filename"
