mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /instruction_mem/ram(0)
mem load -filltype value -filldata 0000000000000001 -fillradix symbolic /instruction_mem/ram(1)
add wave -position insertpoint  \
sim:/instruction_mem/clk \
sim:/instruction_mem/Rst \
sim:/instruction_mem/PC \
sim:/instruction_mem/Instruction \
sim:/instruction_mem/ram \
force -freeze sim:/instruction_mem/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/instruction_mem/Rst 1 0
force -freeze sim:/instruction_mem/PC 0000 0
run
force -freeze sim:/instruction_mem/Rst 0 0
run