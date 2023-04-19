add wave -position insertpoint  \
sim:/integeration/clk \
sim:/integeration/rst \
sim:/integeration/en \
sim:/integeration/IN_Ports \
sim:/integeration/OUT_Ports \
sim:/integeration/Interrupt \
sim:/integeration/Instruction_out_Fetch \
sim:/integeration/fetchOut_FDBuffer \
sim:/integeration/push_Decode \
sim:/integeration/pop_Decode \
sim:/integeration/SP_Decode \
sim:/integeration/WB_Decode \
sim:/integeration/memRead_Decode \
sim:/integeration/memWrite_Decode \
sim:/integeration/EX_Decode \
sim:/integeration/branch_Decode \
sim:/integeration/portFlag_Decode \
sim:/integeration/returnOI_Decode \
sim:/integeration/call_Decode \
sim:/integeration/No_Cond_Branch_Decode \
sim:/integeration/ALU_selection_Decode \
sim:/integeration/Men_to_Reg_Decode \
sim:/integeration/Int_Decode \
sim:/integeration/data1_Decode \
sim:/integeration/data2_Decode \
sim:/integeration/rdst_Decode \
sim:/integeration/restOfInstruction_After_Decode \
sim:/integeration/PC_Source_Execute \
sim:/integeration/DataOut_Execute \
sim:/integeration/pushOut_EMBuffer \
sim:/integeration/popOut_EMBuffer \
sim:/integeration/SPOut_EMBuffer \
sim:/integeration/WBOut_EMBuffer \
sim:/integeration/memReadOut_EMBuffer \
sim:/integeration/memWriteOut_EMBuffer \
sim:/integeration/portFlagOut_EMBuffer \
sim:/integeration/returnOIOut_EMBuffer \
sim:/integeration/callOut_EMBuffer \
sim:/integeration/Men_to_Regout_EMBuffer \
sim:/integeration/Intout_EMBuffer \
sim:/integeration/dataoutOut_EMBuffer \
sim:/integeration/WriteDataOut_EMBuffer \
sim:/integeration/rdstOut_EMBuffer \
sim:/integeration/read_data_M \
sim:/integeration/Data_out_after_MMBuffer \
sim:/integeration/Read_data_after_MMBuffer \
sim:/integeration/Rdst_after_MMBuffer \
sim:/integeration/WB_after_MMBuffer \
sim:/integeration/Men_to_Regout_MMBuffer \
sim:/integeration/Intout_MMBuffer \
sim:/integeration/portFlagout_MMBuffer \
sim:/integeration/returnOIout_MMBuffer \
sim:/integeration/callout_MMBuffer \
sim:/integeration/Rdst_after_MWBuffer \
sim:/integeration/WB_after_MWBuffer \
sim:/integeration/Data_out_after_MWBuffer \
sim:/integeration/Read_data_after_MWBuffer \
sim:/integeration/Men_to_Regout_MWBuffer \
sim:/integeration/Intout_MWBuffer \
sim:/integeration/portFlagout_MWBuffer \
sim:/integeration/returnOIout_MWBuffer \
sim:/integeration/callout_MWBuffer \
sim:/integeration/WBvalue_WB
force -freeze sim:/integeration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integeration/rst 1 0
force -freeze sim:/integeration/en 1 0
force -freeze sim:/integeration/IN_Ports FFFE 0
run
force -freeze sim:/integeration/rst 0 0
run