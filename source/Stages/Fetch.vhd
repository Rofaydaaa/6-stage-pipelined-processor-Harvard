Library IEEE;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY Fetch IS
PORT (
Int_port: IN std_logic;
clk,Rst,Int_from_WB,Call,Ret,Branch: IN std_logic;
freeze_hdu_data,freeze_hdu_structural: IN std_logic;
Branch_Addr: IN std_logic_vector (15 downto 0);
M_Of_1: IN std_logic_vector (15 downto 0);
WB_Rdst: IN std_logic_vector (15 downto 0);
WB_data: IN std_logic_vector (15 downto 0);
Instruction: out std_logic_vector (31 downto 0)
);
END ENTITY Fetch;

ARCHITECTURE Imp OF Fetch IS

Signal pc_out,Add_sub_Result,To_PC: std_logic_vector (15 downto 0);
Signal Int_from_Int_Reg: std_logic;
Signal Intermediate_Inst: std_logic_vector (31 downto 0);

BEGIN

PC0 :entity work.PC port map (freeze_hdu_data,freeze_hdu_structural,Rst,Intermediate_Inst(31 downto 16),To_PC,pc_out,clk);

Int_Reg0 : entity work.Interrupt_register port map (Int_port,Int_from_Int_Reg);

AddSUB0 : entity work.Add_Sub port map ('1','0',pc_out,Add_sub_Result);

ToPCDecisionUnit0: entity work.ToPCDecisionUnit port map (Add_sub_Result,Branch_Addr,M_Of_1,WB_Rdst,WB_data,Int_from_WB,Call,Ret,Branch,To_PC);

Instruction_Mem0 : entity work.Instruction_Mem port map (clk,Rst,Int_from_Int_Reg,pc_out,Intermediate_Inst);

Instruction <= Intermediate_Inst;

END Imp;
