add wave -position insertpoint sim:/integeration/*
add wave -position insertpoint sim:/integeration/D/RF/*
mem load -i D:\senior1-sem2\Architecture\ProjectOnModelSim/test.mem /integeration/F/Instruction_Mem0/ram
force -freeze sim:/integeration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integeration/rst 1 0
force -freeze sim:/integeration/en 1 0
force -freeze sim:/integeration/IN_Ports 0005 0
run
force -freeze sim:/integeration/rst 0 0
run
