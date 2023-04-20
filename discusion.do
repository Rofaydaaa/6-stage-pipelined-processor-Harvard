vsim -gui work.integeration
mem load -i D:/senior1-sem2/Architecture/ProjectOnModelSim/InstructionMemory.mem /integeration/F/Instruction_Mem0/ram

add wave -position insertpoint  \
sim:/integeration/rst \
sim:/integeration/clk
add wave -position insertpoint  \
sim:/integeration/F/Instruction_Mem0/PC
add wave -position insertpoint  \
sim:/integeration/F/Instruction_Mem0/Instruction
add wave -position insertpoint  \
sim:/integeration/E/set_CCRM/FLAG_OUT
add wave -position insertpoint  \
sim:/integeration/OUT_Ports
add wave -position insertpoint  \
sim:/integeration/IN_Ports
add wave -position insertpoint  \
sim:/integeration/en

force -freeze sim:/integeration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integeration/rst 1 0
force -freeze sim:/integeration/en 1 0
force -freeze sim:/integeration/IN_Ports 0005 0
run
force -freeze sim:/integeration/rst 0 0
run
run
force -freeze sim:/integeration/IN_Ports FFFE 0
run
run
run
run
force -freeze sim:/integeration/IN_Ports 0001 0
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
force -freeze sim:/integeration/IN_Ports 000F 0
run
force -freeze sim:/integeration/IN_Ports 00C8 0
run
force -freeze sim:/integeration/IN_Ports 001F 0
run
force -freeze sim:/integeration/IN_Ports 00FC 0
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