vsim -gui work.integeration
mem load -i {D:/senior1-sem2/Architecture/Project on Modelsim/phase1WithHaz.mem} /integeration/F/Instruction_Mem0/ram

add wave -position insertpoint  \
sim:/integeration/D/RF/ram
add wave -position insertpoint  \
sim:/integeration/rst
add wave -position insertpoint  \
sim:/integeration/en
add wave -position insertpoint  \
sim:/integeration/clk
add wave -position insertpoint  \
sim:/integeration/IN_Port
add wave -position insertpoint  \
sim:/integeration/OUT_Port
add wave -position insertpoint  \
sim:/integeration/E/set_CCRM/FLAG_OUT
add wave -position insertpoint  \
sim:/integeration/Output_from_F_Instruction

force -freeze sim:/integeration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integeration/rst 1 0
run

force -freeze sim:/integeration/en 1 0
force -freeze sim:/integeration/rst 0 0
force -freeze sim:/integeration/Interrupt 0 0 
force -freeze sim:/integeration/IN_Port 0008 0


mem load -filltype value -filldata {0000 } -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(3)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(4)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(5)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(6)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(7)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(8)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(9)
mem load -filltype value -filldata 0 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(11)
mem load -filltype value -filldata 0 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(12)
mem load -filltype value -filldata 0 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(13)
mem load -filltype value -filldata 0 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(14)

mem load -filltype value -filldata {5A80 } -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(2)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(3)

vsim -gui work.integeration
mem load -i {D:/senior1-sem2/Architecture/Project on Modelsim/phase1WithHaz.mem} /integeration/F/Instruction_Mem0/ram

add wave -position insertpoint  \
sim:/integeration/D/RF/ram
add wave -position insertpoint  \
sim:/integeration/rst
add wave -position insertpoint  \
sim:/integeration/en
add wave -position insertpoint  \
sim:/integeration/clk
add wave -position insertpoint  \
sim:/integeration/IN_Port
add wave -position insertpoint  \
sim:/integeration/OUT_Port
add wave -position insertpoint  \
sim:/integeration/E/set_CCRM/FLAG_OUT
add wave -position insertpoint  \
sim:/integeration/Output_from_F_Instruction

force -freeze sim:/integeration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integeration/rst 1 0
run

force -freeze sim:/integeration/en 1 0
force -freeze sim:/integeration/rst 0 0
force -freeze sim:/integeration/Interrupt 0 0 
force -freeze sim:/integeration/IN_Port 0008 0


mem load -filltype value -filldata {0000 } -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(3)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(4)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(5)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(6)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(7)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(8)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(9)
mem load -filltype value -filldata 0 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(11)
mem load -filltype value -filldata 0 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(12)
mem load -filltype value -filldata 0 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(13)
mem load -filltype value -filldata 0 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(14)

mem load -filltype value -filldata {1E8A } -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(2)
mem load -filltype value -filldata 5080 -fillradix hexadecimal /integeration/F/Instruction_Mem0/ram(3)

mem load -filltype value -filldata 000A -fillradix hexadecimal /integeration/D/RF/ram(1)
mem load -filltype value -filldata 0001 -fillradix hexadecimal /integeration/D/RF/ram(5)

