add wave -position insertpoint  \
sim:/integeration/rst \
sim:/integeration/OUT_Ports \
sim:/integeration/IN_Ports \
sim:/integeration/en \
sim:/integeration/clk
mem load -filltype value -filldata 0001010000001010 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(0)
mem load -filltype value -filldata 0001101010001010 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(1)
mem load -filltype value -filldata 0001101010001010 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(2)
mem load -filltype value -filldata 0001010000000010 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(3)
mem load -filltype value -filldata 0001010000000100 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(4)
mem load -filltype value -filldata 0001010000000110 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(5)
mem load -filltype value -filldata 0001010000001000 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(6)
mem load -filltype value -filldata 0001010000001010 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(7)
mem load -filltype value -filldata 0000010000000000 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(8)
mem load -filltype value -filldata 0000010000000000 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(8)
mem load -filltype value -filldata 0100110010100000 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(9)
mem load -filltype value -filldata 0100110111000000 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(10)
mem load -filltype value -filldata 0100110101010000 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(11)
mem load -filltype value -filldata 0001100100010000 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(12)
mem load -filltype value -filldata 0100100000000010 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(13)
mem load -filltype value -filldata 0100101110000110 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(14)
mem load -filltype value -filldata 0011010010101100 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(15)
mem load -filltype value -filldata 0001100010010000 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(16)
mem load -filltype value -filldata 0000010000000000 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(17)
mem load -filltype value -filldata 0011011010111000 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(18)
mem load -filltype value -filldata 0000010000000000 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(19)
mem load -filltype value -filldata 0000010000000000 -fillradix symbolic /integeration/F/Instruction_Mem0/ram(20)
mem save -o D:/senior1-sem2/Architecture/6-stage-pipelined-processor-Harvard/InstructionMemory.mem -f mti -data symbolic -addr hex /integeration/F/Instruction_Mem0/ram