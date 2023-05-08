library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
ENTITY integeration IS
PORT(
clk,rst,en : IN std_logic;
IN_Ports: IN STD_LOGIC_VECTOR(15 downto 0);
OUT_Ports: OUT STD_LOGIC_VECTOR(15 downto 0);
Interrupt: IN STD_LOGIC
);
END integeration;

ARCHITECTURE arch OF integeration IS


--Flush signals
signal Flush_withtOr : std_logic;
signal Flush_WithoutOr : std_logic;

---Define the signals for input of every buffer
--F/D

--D/E
signal DE_For_call: std_logic_vector(15 downto 0);
signal DE_RTI: std_logic;
signal DE_RET: std_logic;
signal DE_WB_MemtoReg         : std_logic;     
signal DE_Call            : std_logic;
signal DE_Push            : std_logic;
signal DE_Pop               : std_logic;
signal DE_INT               : std_logic;
signal DE_WB_RegToReg       : std_logic;
signal DE_memRead: std_logic;
signal DE_memWrite: std_logic;
signal DE_SP              : std_logic;
signal DE_Branch            : std_logic;
signal DE_Imm                 : std_logic;
signal DE_In_port             : std_logic_vector(15 downto 0);
signal DE_SelectionLines      : std_logic_vector(3 downto 0);    
signal DE_No_cond_jum         : std_logic;      
signal DE_Data1               : std_logic_vector(15 downto 0);        
signal DE_Data_2              : std_logic_vector(15 downto 0);      
signal DE_ImmediateValue      : std_logic_vector(15 downto 0);        
signal DE_RS1                 : std_logic_vector(2 downto 0);          
signal DE_RS2                 : std_logic_vector(2 downto 0);              
signal DE_Rdst                : std_logic_vector(2 downto 0);                
signal DE_M1                  : std_logic_vector(15 downto 0);            

--E/M1
signal EM_for_call: std_logic_vector(15 downto 0);
signal EM_RTI: std_logic;
signal EM_RET: std_logic;
signal EM_PUSH: std_logic;
signal EM_POP: std_logic;
signal EM_Call: std_logic;
signal EM_INT: std_logic;
signal EM_WB_MemtoReg: std_logic;
signal EM_WB_RegtoReg: std_logic;
signal EM_In_port: std_logic;
signal EM_memRead: std_logic;
signal EM_memWrite: std_logic;
signal EM_SP: std_logic;
signal EM_data_out: std_logic_vector(15 downto 0);
signal EM_data1: std_logic_vector(15 downto 0);
signal EM_Rdst: std_logic_vector(2 downto 0);
signal EM_M1: std_logic_vector(15 downto 0);

--M1/M2
signal MM_RTI: std_logic;
signal MM_call: std_logic;
signal MM_RET: std_logic;
signal MM_INT: std_logic;
signal MM_WB_MemtoReg: std_logic;
signal MM_WB_RegtoReg: std_logic;
signal MM_memRead: std_logic;
signal MM_memWrite: std_logic;
signal MM_data32: std_logic(31 downto 0);
signal MM_data_out: std_logic_vector(15 downto 0);
signal MM_Rdst: std_logic_vector(2 downto 0);
signal MM_M1: std_logic_vector(15 downto 0);
signal MM_InPort: std_logic_vector(15 downto 0);

--MemWB
signal MWB_RTI: std_logic;
signal MWB_call: std_logic;
signal MWB_memRead: std_logic;
signal MWB_memWrite: std_logic;
signal MWB_RET: std_logic;
signal MWB_INT: std_logic;
signal MWB_WB_MemtoReg: std_logic;
signal MWB_WB_RegtoReg: std_logic;
signal MWB_ReadData: std_logic(31 downto 0);
signal MWB_data_out: std_logic_vector(15 downto 0);
signal MWB_InPort: std_logic_vector(15 downto 0); 
signal MWB_Rdst: std_logic_vector(2 downto 0);
signal MWB_M1: std_logic_vector(15 downto 0);

--Define signals for input of every stage
--Ay stage gayelha input mn bara 8ir el buffer


BEGIN
F: entity work.Fetch port map(clk,rst,Instruction_out_Fetch);
FDBuffer: entity work.Fetch_Decode_Buffer port map(clk,rst,en,Instruction_out_Fetch,fetchOut_FDBUFFER);

D: entity work.Decode port map(clk, rst, WB_after_MWBuffer,Men_to_Regout_MWBuffer, fetchOut_FDBUFFER, Rdst_after_MWBuffer, WBvalue_WB, push_Decode, pop_Decode,
  SP_Decode, WB_Decode, memRead_Decode, memWrite_Decode, EX_Decode, branch_Decode, portFlag_Decode, returnOI_Decode, call_Decode,
  No_Cond_Branch_Decode, ALU_selection_Decode, Men_to_Reg_Decode,
  Int_Decode, data1_Decode, data2_Decode, rdst_Decode, restOfInstruction_After_Decode);
  
--DEBuffer: entity work.Decode_Execute_Buffer port map(clk, rst, en, );

E: entity work.Execute port map(clk,rst, data1_Decode, data2_Decode, restOfInstruction_After_Decode, ALU_selection_Decode, EX_Decode, branch_Decode, 
 No_Cond_Branch_Decode, PC_Source_Execute, DataOut_Execute);

EMBuffer: entity work.Execute_Memory_Buffer port map(clk, rst, en, push_Decode, pop_Decode,
SP_Decode, WB_Decode, memRead_Decode, memWrite_Decode, portFlag_Decode, returnOI_Decode, call_Decode,
 Men_to_Reg_Decode, Int_Decode, DataOut_Execute, data1_Decode, rdst_Decode, pushOut_EMBuffer, popOut_EMBuffer, SPOut_EMBuffer, WBOut_EMBuffer, 
 memReadOut_EMBuffer, memWriteOut_EMBuffer, portFlagOut_EMBuffer, returnOIOut_EMBuffer, callOut_EMBuffer, 
 Men_to_Regout_EMBuffer, Intout_EMBuffer, dataoutOut_EMBuffer, WriteDataOut_EMBuffer, rdstOut_EMBuffer);

M: entity work.MemoryStage port map(clk, rst, memReadOut_EMBuffer, memWriteOut_EMBuffer, SPOut_EMBuffer, pushOut_EMBuffer, popOut_EMBuffer, callOut_EMBuffer,
WriteDataOut_EMBuffer, dataoutOut_EMBuffer, read_data_M);

MMBuffer: entity work.Mem_Mem_Buffer port map(clk, rst, en, WBOut_EMBuffer, rdstOut_EMBuffer, dataoutOut_EMBuffer, read_data_M, Men_to_Regout_EMBuffer,Intout_EMBuffer, portFlagOut_EMBuffer, 
 returnOIOut_EMBuffer, callOut_EMBuffer, Data_out_after_MMBuffer,Read_data_after_MMBuffer, Rdst_after_MMBuffer, WB_after_MMBuffer, Men_to_Regout_MMBuffer, Intout_MMBuffer, 
 portFlagout_MMBuffer, returnOIout_MMBuffer, callout_MMBuffer);

MwBuffer: entity work.Mem_WB_Buffer port map(clk, rst, en, WB_after_MMBuffer,Data_out_after_MMBuffer,Read_data_after_MMBuffer, Rdst_after_MMBuffer, Men_to_Regout_MMBuffer, Intout_MMBuffer, 
 portFlagout_MMBuffer, returnOIout_MMBuffer, callout_MMBuffer, Rdst_after_MWBuffer, WB_after_MWBuffer, Data_out_after_MWBuffer, Read_data_after_MWBuffer, Men_to_Regout_MWBuffer, Intout_MWBuffer, 
 portFlagout_MWBuffer, returnOIout_MWBuffer, callout_MWBuffer);

WB: entity work.WriteBack port map(Read_data_after_MWBuffer, Data_out_after_MWBuffer, Men_to_Regout_MWBuffer, portFlagout_MWBuffer, IN_Ports, WBvalue_WB, OUT_Ports);


END arch;