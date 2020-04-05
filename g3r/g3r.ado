setenv SIM_WORKING_FOLDER .
set newDesign 0
if {![file exists "C:/Users/user/lattice/FPGASDR/g3r/g3r.adf"]} { 
	design create g3r "C:/Users/user/lattice/FPGASDR"
  set newDesign 1
}
design open "C:/Users/user/lattice/FPGASDR/g3r"
cd "C:/Users/user/lattice/FPGASDR"
designverincludedir -clear
designverlibrarysim -PL -clear
designverlibrarysim -L -clear
designverlibrarysim -PL pmi_work
designverlibrarysim ovi_machxo2
designverdefinemacro -clear
if {$newDesign == 0} { 
  removefile -Y -D *
}
addfile "C:/Users/user/lattice/FPGASDR/impl1/source/TestUart.v"
addfile "C:/Users/user/lattice/FPGASDR/PLL.v"
addfile "C:/Users/user/lattice/FPGASDR/PWM.v"
addfile "C:/Users/user/lattice/FPGASDR/Multiplier.v"
addfile "C:/Users/user/lattice/FPGASDR/HP_IIR.v"
addfile "C:/Users/user/lattice/FPGASDR/CIC.v"
addfile "C:/Users/user/lattice/FPGASDR/Mixer.v"
addfile "C:/Users/user/lattice/FPGASDR/SinCos.v"
addfile "C:/Users/user/lattice/FPGASDR/NCO.v"
addfile "C:/Users/user/lattice/FPGASDR/impl1/source/top.v"
addfile "C:/Users/user/lattice/FPGASDR/impl1/source/UartRX.v"
addfile "C:/Users/user/lattice/FPGASDR/impl1/source/UartTX.v"
vlib "C:/Users/user/lattice/FPGASDR/g3r/work"
set worklib work
adel -all
vlog -dbg -work work "C:/Users/user/lattice/FPGASDR/impl1/source/TestUart.v"
vlog -dbg -work work "C:/Users/user/lattice/FPGASDR/PLL.v"
vlog -dbg -work work "C:/Users/user/lattice/FPGASDR/PWM.v"
vlog -dbg -work work "C:/Users/user/lattice/FPGASDR/Multiplier.v"
vlog -dbg -work work "C:/Users/user/lattice/FPGASDR/HP_IIR.v"
vlog -dbg -work work "C:/Users/user/lattice/FPGASDR/CIC.v"
vlog -dbg -work work "C:/Users/user/lattice/FPGASDR/Mixer.v"
vlog -dbg -work work "C:/Users/user/lattice/FPGASDR/SinCos.v"
vlog -dbg -work work "C:/Users/user/lattice/FPGASDR/NCO.v"
vlog -dbg -work work "C:/Users/user/lattice/FPGASDR/impl1/source/top.v"
vlog -dbg -work work "C:/Users/user/lattice/FPGASDR/impl1/source/UartRX.v"
vlog -dbg -work work "C:/Users/user/lattice/FPGASDR/impl1/source/UartTX.v"
module blinking_led
vsim  +access +r blinking_led   -PL pmi_work -L ovi_machxo2
add wave *
run 1000ns
