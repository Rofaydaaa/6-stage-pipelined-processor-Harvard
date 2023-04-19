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

---Define the signals for output of every stage and buffer
--Signal namming formal (outputvar_stageNameOrBuffer)

--Signals for IN_PORTS passed to all buffer
signal IN_Port_FDBuffer, IN_Port_DEBuffer, IN_Port_EMBuffer, IN_Port_MMBuffer, IN_Port_MWBuffer: std_logic_vector(15 downto 0);

--Fetch stage
signal Instruction_out_Fetch: STD_LOGIC_VECTOR(31 downto 0);

--FDBuffer
signal fetchOut_FDBuffer:std_logic_vector(31 downto 0);

--Decode stage
signal push_Decode: std_logic;
signal pop_Decode: std_logic;
signal SP_Decode: std_logic;
signal WB_Decode: std_logic;
signal memRead_Decode: std_logic;
signal memWrite_Decode: std_logic;
signal EX_Decode: std_logic;
signal branch_Decode: std_logic;
signal portFlag_Decode: std_logic;
signal returnOI_Decode: std_logic;
signal call_Decode: std_logic;
signal No_Cond_Branch_Decode: std_logic;
signal ALU_selection_Decode: std_logic_vector(3 downto 0);
signal Men_to_Reg_Decode: std_logic;
signal Int_Decode: std_logic;
signal data1_Decode,data2_Decode: std_logic_vector(15 downto 0);
signal rdst_Decode: std_logic_vector(2 downto 0);
signal restOfInstruction_After_Decode: std_logic_vector(15 downto 0);


--buffer of decode stage is in in decode stage modulee  3ashan yasmine 3yza kda
-- --DEBuffer
-- signal pushout_DEBuffer: std_logic;
-- signal popout_DEBuffer: std_logic;
-- signal SPout_DEBuffer: std_logic;
-- signal WBout_DEBuffer: std_logic;
-- signal memReadout_DEBuffer: std_logic;
-- signal memWriteout_DEBuffer: std_logic;
-- signal EXout_DEBuffer: std_logic;
-- signal branchout_DEBuffer: std_logic;
-- signal portFlagout_DEBuffer: std_logic;
-- signal returnOIout_DEBuffer: std_logic;
-- signal callout_DEBuffer: std_logic;
-- signal No_Cond_Branchout_DEBuffer: std_logic;
-- signal Men_to_Regout_DEBuffer: std_logic;
-- signal Intout_DEBuffer: std_logic;
-- signal ALU_selectionout_DEBuffer: std_logic_vector(3 downto 0);
-- signal data1out_DEBuffer,data2out_DEBuffer: std_logic_vector(15 downto 0); 
-- signal rdstout_DEBuffer: std_logic_vector(2 downto 0); 
-- signal restofIRout_DEBuffer:  std_logic_vector(15 downto 0); 

--Execute stage
signal PC_Source_Execute : STD_LOGIC;
signal DataOut_Execute : STD_LOGIC_VECTOR (15 DOWNTO 0);

--EMBuffer
signal pushOut_EMBuffer : std_logic;
signal popOut_EMBuffer : std_logic;
signal SPOut_EMBuffer : std_logic;
signal WBOut_EMBuffer : std_logic;
signal memReadOut_EMBuffer : std_logic;
signal memWriteOut_EMBuffer : std_logic;
signal portFlagOut_EMBuffer : std_logic;
signal returnOIOut_EMBuffer : std_logic;
signal callOut_EMBuffer : std_logic;
signal Men_to_Regout_EMBuffer: std_logic;
signal Intout_EMBuffer: std_logic;
signal dataoutOut_EMBuffer : std_logic_vector(15 downto 0); 
signal WriteDataOut_EMBuffer : std_logic_vector(15 downto 0);
signal rdstOut_EMBuffer :std_logic_vector(2 downto 0);
--signal CCROut_EMBuffer : std_logic_vector(15 downto 0); 

--Memory stage

signal read_data_M: std_logic_vector (15 downto 0);

--MMBuffer

signal Data_out_after_MMBuffer,Read_data_after_MMBuffer: std_logic_vector (15 downto 0);
signal Rdst_after_MMBuffer: std_logic_vector (2 downto 0);
signal WB_after_MMBuffer: std_logic;
signal Men_to_Regout_MMBuffer: std_logic;
signal Intout_MMBuffer: std_logic;
signal portFlagout_MMBuffer: std_logic;
signal returnOIout_MMBuffer: std_logic;
signal callout_MMBuffer: std_logic;

--MWBuffer
signal Rdst_after_MWBuffer: std_logic_vector (2 downto 0);
signal WB_after_MWBuffer : std_logic;
signal Data_out_after_MWBuffer,Read_data_after_MWBuffer: std_logic_vector (15 downto 0);
signal Men_to_Regout_MWBuffer: std_logic;
signal Intout_MWBuffer: std_logic;
signal portFlagout_MWBuffer: std_logic;
signal returnOIout_MWBuffer: std_logic;
signal callout_MWBuffer: std_logic;

--WB stage
signal WBvalue_WB: std_logic_vector(15 downto 0);

BEGIN
F: entity work.Fetch port map(clk,rst,Instruction_out_Fetch);
FDBuffer: entity work.Fetch_Decode_Buffer port map(clk,rst,en,Instruction_out_Fetch,fetchOut_FDBUFFER, IN_Ports, IN_Port_FDBuffer);

D: entity work.Decode port map(clk, rst, WB_after_MWBuffer, fetchOut_FDBUFFER, Rdst_after_MWBuffer, WBvalue_WB, push_Decode, pop_Decode,
  SP_Decode, WB_Decode, memRead_Decode, memWrite_Decode, EX_Decode, branch_Decode, portFlag_Decode, returnOI_Decode, call_Decode,
  No_Cond_Branch_Decode, ALU_selection_Decode, Men_to_Reg_Decode,
  Int_Decode, data1_Decode, data2_Decode, rdst_Decode, restOfInstruction_After_Decode, IN_Port_FDBuffer,IN_Port_DEBuffer);
  
--DEBuffer: entity work.Decode_Execute_Buffer port map(clk, rst, en, );

E: entity work.Execute port map(clk,rst, data1_Decode, data2_Decode, restOfInstruction_After_Decode, ALU_selection_Decode, EX_Decode, branch_Decode, 
 No_Cond_Branch_Decode, PC_Source_Execute, DataOut_Execute);

EMBuffer: entity work.Execute_Memory_Buffer port map(clk, rst, en, push_Decode, pop_Decode,
SP_Decode, WB_Decode, memRead_Decode, memWrite_Decode, portFlag_Decode, returnOI_Decode, call_Decode,
 Men_to_Reg_Decode, Int_Decode, DataOut_Execute, data1_Decode, rdst_Decode, pushOut_EMBuffer, popOut_EMBuffer, SPOut_EMBuffer, WBOut_EMBuffer, 
 memReadOut_EMBuffer, memWriteOut_EMBuffer, portFlagOut_EMBuffer, returnOIOut_EMBuffer, callOut_EMBuffer, 
 Men_to_Regout_EMBuffer, Intout_EMBuffer, dataoutOut_EMBuffer, WriteDataOut_EMBuffer, rdstOut_EMBuffer, IN_Port_DEBuffer, IN_Port_EMBuffer);

M: entity work.MemoryStage port map(clk, rst, memReadOut_EMBuffer, memWriteOut_EMBuffer, SPOut_EMBuffer, pushOut_EMBuffer, popOut_EMBuffer, callOut_EMBuffer,
WriteDataOut_EMBuffer, dataoutOut_EMBuffer, read_data_M);

MMBuffer: entity work.Mem_Mem_Buffer port map(clk, rst, en, WBOut_EMBuffer, rdstOut_EMBuffer, dataoutOut_EMBuffer, read_data_M, Men_to_Regout_EMBuffer,Intout_EMBuffer, portFlagOut_EMBuffer, 
 returnOIOut_EMBuffer, callOut_EMBuffer, Data_out_after_MMBuffer,Read_data_after_MMBuffer, Rdst_after_MMBuffer, WB_after_MMBuffer, Men_to_Regout_MMBuffer, Intout_MMBuffer, 
 portFlagout_MMBuffer, returnOIout_MMBuffer, callout_MMBuffer, IN_Port_EMBuffer, IN_Port_MMBuffer);

MwBuffer: entity work.Mem_WB_Buffer port map(clk, rst, en, WB_after_MMBuffer,Data_out_after_MMBuffer,Read_data_after_MMBuffer, Rdst_after_MMBuffer, Men_to_Regout_MMBuffer, Intout_MMBuffer, 
 portFlagout_MMBuffer, returnOIout_MMBuffer, callout_MMBuffer, Rdst_after_MWBuffer, WB_after_MWBuffer, Data_out_after_MWBuffer, Read_data_after_MWBuffer, Men_to_Regout_MWBuffer, Intout_MWBuffer, 
 portFlagout_MWBuffer, returnOIout_MWBuffer, callout_MWBuffer, IN_Port_MMBuffer, IN_Port_MWBuffer);

WB: entity work.WriteBack port map(Read_data_after_MWBuffer, Data_out_after_MWBuffer, Men_to_Regout_MWBuffer, portFlagout_MWBuffer, IN_Port_MWBuffer, WBvalue_WB, OUT_Ports);


END arch;