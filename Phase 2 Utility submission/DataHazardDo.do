vsim -gui work.integeration
mem load -i D:/senior1-sem2/Architecture/6-stage-pipelined-processor-Harvard/source/DataHazard.mem /integeration/F/Instruction_Mem0/ram

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
force -freeze sim:/integeration/rst 0 0
force -freeze sim:/integeration/en 1 0

force -freeze sim:/integeration/IN_Port 0044 0

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
