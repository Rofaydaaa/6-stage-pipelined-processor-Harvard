vsim -gui work.integeration
#Load memory
mem load -i D:/senior1-sem2/Architecture/6-stage-pipelined-processor-Harvard/test.mem /integeration/F/Instruction_Mem0/ram

#add main waves

add wave -position insertpoint  \
sim:/integeration/WriteDataOut_EMBuffer \
sim:/integeration/WBvalue_WB \
sim:/integeration/WBOut_EMBuffer \
sim:/integeration/WB_Decode \
sim:/integeration/WB_after_MWBuffer \
sim:/integeration/WB_after_MMBuffer \
sim:/integeration/SPOut_EMBuffer \
sim:/integeration/SP_Decode \
sim:/integeration/rst \
sim:/integeration/returnOIout_MWBuffer \
sim:/integeration/returnOIout_MMBuffer \
sim:/integeration/returnOIOut_EMBuffer \
sim:/integeration/returnOI_Decode \
sim:/integeration/restOfInstruction_After_Decode \
sim:/integeration/read_data_M \
sim:/integeration/Read_data_after_MWBuffer \
sim:/integeration/Read_data_after_MMBuffer \
sim:/integeration/rdstOut_EMBuffer \
sim:/integeration/rdst_Decode \
sim:/integeration/Rdst_after_MWBuffer \
sim:/integeration/Rdst_after_MMBuffer \
sim:/integeration/pushOut_EMBuffer \
sim:/integeration/push_Decode \
sim:/integeration/portFlagout_MWBuffer \
sim:/integeration/portFlagout_MMBuffer \
sim:/integeration/portFlagOut_EMBuffer \
sim:/integeration/portFlag_Decode \
sim:/integeration/popOut_EMBuffer \
sim:/integeration/pop_Decode \
sim:/integeration/PC_Source_Execute \
sim:/integeration/OUT_Ports \
sim:/integeration/No_Cond_Branch_Decode \
sim:/integeration/Men_to_Regout_MWBuffer \
sim:/integeration/Men_to_Regout_MMBuffer \
sim:/integeration/Men_to_Regout_EMBuffer \
sim:/integeration/Men_to_Reg_Decode \
sim:/integeration/memWriteOut_EMBuffer \
sim:/integeration/memWrite_Decode \
sim:/integeration/memReadOut_EMBuffer \
sim:/integeration/memRead_Decode \
sim:/integeration/Intout_MWBuffer \
sim:/integeration/Intout_MMBuffer \
sim:/integeration/Intout_EMBuffer \
sim:/integeration/Interrupt \
sim:/integeration/Int_Decode \
sim:/integeration/Instruction_out_Fetch \
sim:/integeration/IN_Ports \
sim:/integeration/fetchOut_FDBuffer \
sim:/integeration/EX_Decode \
sim:/integeration/en \
sim:/integeration/dataoutOut_EMBuffer \
sim:/integeration/DataOut_Execute \
sim:/integeration/Data_out_after_MWBuffer \
sim:/integeration/Data_out_after_MMBuffer \
sim:/integeration/data2_Decode \
sim:/integeration/data1_Decode \
sim:/integeration/clk \
sim:/integeration/callout_MWBuffer \
sim:/integeration/callout_MMBuffer \
sim:/integeration/callOut_EMBuffer \
sim:/integeration/call_Decode \
sim:/integeration/branch_Decode \
sim:/integeration/ALU_selection_Decode \

sim:/integeration/E/set_CCRM/rst \
sim:/integeration/E/set_CCRM/Previous_caryy \
sim:/integeration/E/set_CCRM/NOP_FLAG \
sim:/integeration/E/set_CCRM/n \
sim:/integeration/E/set_CCRM/FLAG_OUT \
sim:/integeration/E/set_CCRM/Flag_Calc \
sim:/integeration/E/set_CCRM/F_ALU \
sim:/integeration/E/set_CCRM/Cout_ALU \
sim:/integeration/E/set_CCRM/clk

#Force 
force -freeze sim:/integeration/rst 1 0
force -freeze sim:/integeration/IN_Ports FFFE 0
force -freeze sim:/integeration/en 1 0
force -freeze sim:/integeration/clk 1 0, 0 {50 ps} -r 100

run

force -freeze sim:/integeration/rst 0 0

run