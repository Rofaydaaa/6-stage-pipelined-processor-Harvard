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
WB_Data_For_Call: IN std_logic_vector (15 downto 0);
WB_data: IN std_logic_vector (15 downto 0);
For_Call: OUT std_logic_vector (15 downto 0);
Imm_From_Decode_stage: IN std_logic;
Instruction: out std_logic_vector (31 downto 0);
PC_for_INT: out std_logic_vector (15 downto 0)
);
END ENTITY Fetch;

ARCHITECTURE Imp OF Fetch IS

Signal pc_out,Add_sub_Result1,To_PC,Add_sub_Result2,Add_sub_Result_final: std_logic_vector (15 downto 0);
Signal Int_from_Int_Reg: std_logic;
Signal Intermediate_Inst: std_logic_vector (31 downto 0);

COMPONENT Mux2by1 IS 
Generic ( n : Integer:=16);
PORT ( in0,in1 : IN std_logic_vector (n-1 DOWNTO 0);
        sel : IN  std_logic;
        out1 : OUT std_logic_vector (n-1 DOWNTO 0));
END COMPONENT;

BEGIN

PC0 :entity work.PC port map (freeze_hdu_data,freeze_hdu_structural,Rst,Intermediate_Inst(31 downto 16),To_PC,pc_out,clk);

Int_Reg0 : entity work.Interrupt_register port map (Int_port,Int_from_Int_Reg);

AddSUB0 : entity work.Add_Sub port map ('0',b"01",pc_out,Add_sub_Result1);
AddSUB1:  entity work.Add_Sub port map ('0',b"10",pc_out,Add_sub_Result2);
Mux2by10 : Mux2by1 GENERIC MAP(16) PORT MAP(Add_sub_Result1, Add_sub_Result2, Imm_From_Decode_stage, Add_sub_Result_final);

ToPCDecisionUnit0: entity work.ToPCDecisionUnit port map (Add_sub_Result_final,Branch_Addr,M_Of_1,WB_Data_For_Call,WB_data,Int_from_WB,Call,Ret,Branch,To_PC);

Instruction_Mem0 : entity work.Instruction_Mem port map (clk,Rst,Int_from_Int_Reg,pc_out,Intermediate_Inst);

Instruction <= Intermediate_Inst;

For_Call <= Add_sub_Result_final;

PC_for_INT <= pc_out;

END Imp;
