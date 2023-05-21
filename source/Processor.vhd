library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
ENTITY integeration IS
PORT(
clk,rst,en : IN std_logic;
IN_Port: IN STD_LOGIC_VECTOR(15 downto 0);
OUT_Port: OUT STD_LOGIC_VECTOR(15 downto 0);
Interrupt: IN STD_LOGIC
);
END integeration;

ARCHITECTURE arch OF integeration IS


---Define the signals for input of every buffer
--F/D

signal Output_from_FD_For_call: std_logic_vector(15 downto 0);
signal Output_From_FD_Instruction: std_logic_vector(31 downto 0);
signal Output_from_FD_Inport: std_logic_vector(15 downto 0);
signal Output_From_FD_INT: std_logic;

--D/E
signal output_from_DE_For_call: std_logic_vector(15 downto 0);
signal output_from_DE_RTI: std_logic;
signal output_from_DE_RET: std_logic;
signal output_from_DE_WB_MemtoReg         : std_logic;     
signal output_from_DE_Call            : std_logic;
signal output_from_DE_Push            : std_logic;
signal output_from_DE_Pop               : std_logic;
signal output_from_DE_INT               : std_logic;
signal output_from_DE_WB_RegToReg       : std_logic;
signal output_from_DE_memRead: std_logic;
signal output_from_DE_memWrite: std_logic;
signal output_from_DE_SP              : std_logic;
signal output_from_DE_Branch            : std_logic;
signal output_from_DE_Imm                 : std_logic;
signal output_from_DE_PortFlag                 : std_logic;
signal output_from_DE_In_port             : std_logic_vector(15 downto 0);
signal output_from_DE_SelectionLines      : std_logic_vector(3 downto 0);    
signal output_from_DE_No_cond_jum         : std_logic;      
signal output_from_DE_Data1               : std_logic_vector(15 downto 0);        
signal output_from_DE_Data2              : std_logic_vector(15 downto 0);      
signal output_from_DE_ImmediateValue      : std_logic_vector(15 downto 0);        
signal output_from_DE_RS1                 : std_logic_vector(2 downto 0);          
signal output_from_DE_RS2                 : std_logic_vector(2 downto 0);              
signal output_from_DE_Rdst                : std_logic_vector(2 downto 0);                
signal output_from_DE_M1                  : std_logic_vector(15 downto 0); 

--E/M1
signal output_from_EM_for_call: std_logic_vector(15 downto 0);
signal output_from_EM_RTI: std_logic;
signal output_from_EM_RET: std_logic;
signal output_from_EM_PUSH: std_logic;
signal output_from_EM_POP: std_logic;
signal output_from_EM_Call: std_logic;
signal output_from_EM_INT: std_logic;
signal output_from_EM_WB_MemtoReg: std_logic;
signal output_from_EM_WB_RegtoReg: std_logic;
signal output_from_EM_portFlag: std_logic;
signal output_from_EM_memRead: std_logic;
signal output_from_EM_memWrite: std_logic;
signal output_from_EM_SP: std_logic;
signal output_from_EM_Inport: std_logic_vector(15 downto 0);
signal output_from_EM_data_out: std_logic_vector(15 downto 0);
signal output_from_EM_data1: std_logic_vector(15 downto 0);
signal output_from_EM_Rdst: std_logic_vector(2 downto 0);
signal output_from_EM_M1: std_logic_vector(15 downto 0);


--M1/M2
signal output_from_MM_RTI: std_logic;
signal output_from_MM_call: std_logic;
signal output_from_MM_RET: std_logic;
signal output_from_MM_INT: std_logic;
signal output_from_MM_WB_MemtoReg: std_logic;
signal output_from_MM_WB_RegtoReg: std_logic;
signal output_from_MM_memRead: std_logic;
signal output_from_MM_memWrite: std_logic;
signal output_from_MM_portFlag: std_logic;
signal output_from_MM_data32: std_logic_vector(31 downto 0);
signal output_from_MM_data_out: std_logic_vector(15 downto 0);
signal output_from_MM_Rdst: std_logic_vector(2 downto 0);
signal output_from_MM_M1: std_logic_vector(15 downto 0);
signal output_from_MM_InPort: std_logic_vector(15 downto 0);


--Define signals output of last buffer
signal Output_from_MWB_RTI: std_logic;
signal Output_from_MWB_Ret: std_logic;
signal Output_from_MWB_call: std_logic;
signal Output_from_MWB_WBregToreg: std_logic;
signal Output_from_MWB_memToreg: std_logic;
signal Output_from_MWB_Int: std_logic;
signal Output_from_MWB_Portflag: std_logic;
signal Output_from_MWB_data_out: std_logic_vector(15 downto 0);
signal Output_from_MWB_ReadDataAfter32: std_logic_vector(31 downto 0);
signal Output_from_MWB_Inport: std_logic_vector(15 downto 0);
signal Output_from_MWB_M1: std_logic_vector(15 downto 0);
signal Output_from_MWB_Rdst: std_logic_vector(2 downto 0);

--Define signals for output of stages:
--fetch
signal Output_from_F_For_call: std_logic_vector (15 downto 0);
signal Output_from_F_Instruction: std_logic_vector(31 downto 0);
signal Output_from_F_PC_For_int: std_logic_vector(15 downto 0);
--Decode
signal Output_from_D_memRead: std_logic;
signal Output_from_D_memWrite: std_logic;

--Execute
signal Output_from_E_PCsource: std_logic;
signal Output_from_E_dataOut: std_logic_vector(15 downto 0);
signal Output_from_E_CCR: std_logic_vector(15 downto 0);

--Memory
signal Output_from_M_readData: std_logic_vector(31 downto 0);

--write back stage
signal Output_from_WB_WBvalue: std_logic_vector(15 downto 0);
signal Output_from_WB_CCR: std_logic_vector(15 downto 0);

--Define signals for units
--Hazard detection unit
signal freeze_pc_hdu: std_logic;
signal stopCu_hdu: std_logic;
--Structural
signal freeze_pc_hsu: std_logic;
signal stopCu_hsu: std_logic;

--utility signals
signal Or_big : std_logic;

--flush signal

signal flushSignal: std_logic;

--stop cu signal 

signal FDbufferstall: std_logic;
signal Or_bigreset: std_logic;
BEGIN

Or_big <= Output_from_E_PCsource or  Output_from_MWB_Int or Output_from_MWB_call or Output_from_MWB_Ret;
Or_bigreset<=Output_from_E_PCsource or  Output_from_MWB_Int or Output_from_MWB_call or Output_from_MWB_Ret or rst;
flushSignal<=Output_from_MWB_Int or Output_from_MWB_call or Output_from_MWB_Ret;
FDbufferstall<= stopCu_hdu or stopCu_hsu or rst or Output_from_E_PCsource or  Output_from_MWB_Int or Output_from_MWB_call or Output_from_MWB_Ret;
-------------------to be rewrittennnnnnnnn -------------------
--------------------Don't forget--------------------
F: entity work.Fetch port map(Interrupt, clk, rst, Output_from_MWB_Int, Output_from_MWB_call, Output_from_MWB_Ret, Or_big, freeze_pc_hdu, freeze_pc_hsu, output_from_DE_Data1, Output_from_MWB_M1,Output_from_MWB_data_out,
                                Output_from_MWB_ReadDataAfter32(15 downto 0),output_from_DE_Imm ,Output_from_F_For_call, Output_from_F_Instruction, Output_from_F_PC_For_int);

FDBuffer: entity work.Fetch_Decode_Buffer port map(clk,FDbufferstall,en, Interrupt, Output_from_F_Instruction,IN_Port, Output_from_F_For_call, Output_From_FD_Instruction, Output_From_FD_INT, Output_from_FD_Inport, Output_from_FD_For_call);


--Decode and D/E buffer are already integrated in the decode module
D: entity work.Decode port map(clk, rst,en, Output_From_FD_INT, Output_from_MWB_WBregToreg, Output_From_FD_Instruction, Output_from_MWB_Rdst, Output_from_WB_WBvalue, Or_bigreset,
                                Output_from_FD_For_call, Output_from_FD_Inport, output_From_DE_Push, output_From_DE_Pop, output_from_DE_SP, output_from_DE_WB_RegToReg, output_from_DE_memRead, output_from_DE_memWrite, 
                                output_from_DE_Imm, output_from_DE_Branch, output_from_DE_PortFlag, output_from_DE_RET, output_from_DE_call, output_from_DE_No_cond_jum, output_from_DE_WB_MemtoReg, output_from_DE_INT, 
                                output_from_DE_RTI, output_from_DE_SelectionLines, output_from_DE_Data1, output_from_DE_Data2, output_from_DE_Rdst, output_from_DE_ImmediateValue, output_from_DE_RS1, output_from_DE_RS2, output_from_DE_M1, 
                                output_from_DE_For_call, output_from_DE_In_port, Output_from_D_memRead, Output_from_D_memWrite);
  
E: entity work.Execute port map(clk,rst, output_from_DE_Data1, output_from_DE_Data2, output_from_DE_ImmediateValue, output_from_DE_RS1, output_from_DE_RS2, 
                                output_from_DE_SelectionLines, output_from_DE_Branch, output_from_DE_No_cond_jum, output_from_DE_Imm, output_from_DE_INT, output_from_EM_WB_RegtoReg, 
                                output_from_EM_portFlag, output_from_EM_Rdst, output_from_EM_data_out, output_from_EM_Inport, output_from_MM_WB_RegtoReg, output_from_MM_memWrite, output_from_MM_memRead, 
                                output_from_MM_portFlag, output_from_MM_Rdst, output_from_MM_data_out, output_from_MM_InPort, Output_from_MWB_WBregToreg, Output_from_MWB_Portflag, Output_from_MWB_RTI, 
                                Output_from_MWB_Rdst, Output_from_MWB_data_out, Output_from_MWB_Inport, Output_from_WB_CCR,Output_from_E_PCsource, Output_from_E_dataOut, Output_from_E_CCR);

EMBuffer: entity work.Execute_Memory_Buffer port map(clk, rst, en, output_from_DE_Push, output_from_DE_Pop, output_from_DE_SP, output_from_DE_WB_RegToReg, output_from_DE_memRead, output_from_DE_memWrite, 
                                                      output_from_DE_PortFlag, output_from_DE_RET, output_from_DE_Call, output_from_DE_WB_MemtoReg, output_from_DE_INT, output_from_DE_RTI, output_from_DE_M1 ,
                                                      output_from_DE_For_call,flushSignal, output_from_DE_In_port, Output_from_E_dataOut, output_from_DE_Data1, 
                                                      output_from_DE_Rdst, output_from_EM_PUSH, output_from_EM_POP, output_from_EM_SP, output_from_EM_WB_RegtoReg, output_from_EM_memRead, output_from_EM_memWrite, output_from_EM_portFlag, 
                                                      output_from_EM_RET, output_from_EM_Call, output_from_EM_WB_MemtoReg, output_from_EM_INT, output_from_EM_RTI, output_from_EM_M1, output_from_EM_for_call, output_from_EM_Inport, output_from_EM_data_out, 
                                                      output_from_EM_data1, output_from_EM_Rdst);


M: entity work.MemoryStage port map(clk, rst, output_from_EM_memRead, output_from_EM_memWrite, output_from_EM_SP, output_from_EM_PUSH, output_from_EM_POP, output_from_EM_Call, output_from_EM_RTI, output_from_EM_INT, output_from_EM_data1, output_from_EM_data_out,
                                     output_from_EM_for_call, Output_from_F_PC_For_int, Output_from_M_readData);

MMBuffer: entity work.Mem_Mem_Buffer port map(clk, rst, en, output_from_EM_WB_RegtoReg,flushSignal , output_from_EM_Rdst, output_from_EM_data_out, output_from_EM_M1, Output_from_M_readData, 
                                                output_from_EM_memRead,output_from_EM_memWrite, output_from_EM_WB_MemtoReg, output_from_EM_INT, output_from_EM_portFlag, output_from_EM_Call, output_from_EM_RTI, output_from_EM_RET, output_from_EM_Inport, 
                                                output_from_MM_data_out, output_from_MM_M1,output_from_MM_data32, output_from_MM_Rdst, output_from_MM_WB_RegtoReg, output_from_MM_memRead, output_from_MM_memWrite, output_from_MM_WB_MemtoReg, output_from_MM_INT, 
                                                output_from_MM_portFlag, output_from_MM_call, output_from_MM_RET, output_from_MM_RTI, output_from_MM_InPort);

MwBuffer: entity work.Mem_WB_Buffer port map(clk, rst, en, Output_from_MM_WB_RegtoReg,flushSignal, output_from_MM_Rdst, output_from_MM_data_out, output_from_MM_M1, output_from_MM_data32, output_from_MM_WB_MemtoReg, 
                                            output_from_MM_INT, output_from_MM_portFlag, output_from_MM_call, output_from_MM_RTI, output_from_MM_RET, output_from_MM_InPort, Output_from_MWB_data_out,  Output_from_MWB_M1, Output_from_MWB_ReadDataAfter32, Output_from_MWB_Rdst, 
                                            Output_from_MWB_WBregToreg, Output_from_MWB_memToreg, Output_from_MWB_Int, Output_from_MWB_Portflag, Output_from_MWB_call, Output_from_MWB_Ret, Output_from_MWB_RTI, Output_from_MWB_Inport);

WB: entity work.WriteBack port map(Output_from_MWB_ReadDataAfter32, Output_from_MWB_data_out, Output_from_MWB_memToreg, Output_from_MWB_Portflag, Output_from_MWB_Inport, Output_from_WB_WBvalue, OUT_Port,Output_from_WB_CCR);


--Hazard unit 
HazardDetectionUnitData: entity work.HDUdata port map(rst,output_from_DE_Rdst, output_from_EM_Rdst, output_from_DE_memRead, output_from_EM_memRead, Output_From_FD_Instruction(25 downto 23),Output_From_FD_Instruction(22 downto 20), freeze_pc_hdu,stopCu_hdu);

HazardDetectionUnitStru: entity work.HDUstructural port map(rst,output_from_DE_memRead, Output_from_D_memRead, output_from_DE_memWrite ,Output_from_D_memWrite, freeze_pc_hsu, stopCu_hsu);

END arch;