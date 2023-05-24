mem load -i G:/Sem8/Arch/Project/6-stage-pipelined-processor-Harvard/source/Control_Hazard.mem /integeration/F/Instruction_Mem0/ram
add wave -position insertpoint sim:/integeration/*
mem load -filltype value -filldata 0002 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(0)
mem load -filltype value -filldata 0002 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(1)
mem load -filltype value -filldata 2484 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(2)
force -freeze sim:/integeration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integeration/rst 1 0
run
mem load -filltype value -filldata 0001 -fillradix hexadecimal /integeration/D/RF/ram(0)
mem load -filltype value -filldata 0002 -fillradix hexadecimal /integeration/D/RF/ram(1)
mem load -filltype value -filldata 0003 -fillradix hexadecimal /integeration/D/RF/ram(2)
mem load -filltype value -filldata 0003 -fillradix hexadecimal /integeration/D/RF/ram(3)
mem load -filltype value -filldata 0004 -fillradix hexadecimal /integeration/D/RF/ram(4)
mem load -filltype value -filldata 0005 -fillradix hexadecimal /integeration/D/RF/ram(5)
mem load -filltype value -filldata 0006 -fillradix hexadecimal /integeration/D/RF/ram(6)
mem load -filltype value -filldata 0007 -fillradix hexadecimal /integeration/D/RF/ram(7)
force -freeze sim:/integeration/en 1 0
force -freeze sim:/integeration/rst 0 0
force -freeze sim:/integeration/Interrupt 0 0 

run
run
run
run
run
run
run
run
run
run
run
