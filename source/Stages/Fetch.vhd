Library IEEE;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY Fetch IS
PORT (
clk,Rst: IN std_logic;
Instruction: out std_logic_vector (31 downto 0)
);
END ENTITY Fetch;

ARCHITECTURE Imp OF Fetch IS

Signal pc_out,Add_sub_Result: std_logic_vector (15 downto 0);


BEGIN

PC0 :entity work.PC port map (Add_sub_Result,pc_out,rst,clk);

AddSUB0 : entity work.Add_Sub port map ('1','0',pc_out,Add_sub_Result);

Instruction_Mem0 : entity work.Instruction_Mem port map (clk,Rst,pc_out,Instruction);

END Imp;
