library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
ENTITY integeration IS
PORT(
clk,rst: IN std_logic;
IN_Ports: IN STD_LOGIC_VECTOR(16 downto 0);
OUT_Ports: OUT STD_LOGIC_VECTOR(16 downto 0);
Interrupt: IN STD_LOGIC
);
END integeration;



ARCHITECTURE arch OF integeration IS

signal Instruction_out: STD_LOGIC_VECTOR(15 downto 0);
signal instOut:std_logic_vector(15 downto 0);
signal fetchOut:std_logic_vector(15 downto 0);
signal controlsel:std_logic_vector(3 downto 0);
-- will we need an enable?
signal enable:std_logic;
signal writeBackout: STD_LOGIC_VECTOR(2 downto 0);
signal regArrayOut:std_logic_vector(15 downto 0);
signal writeBackdata: STD_LOGIC_VECTOR(15 downto 0);
signal decodeExcuteOut: STD_LOGIC_VECTOR(15 downto 0);
signal excSel:std_logic_vector(3 downto 0);
signal excregwrite:std_logic;
signal excout:std_logic_vector(2 downto 0);
signal ALUOut: STD_LOGIC_VECTOR(15 downto 0);
signal ALUcout:std_logic;
signal WBregout:std_logic;

BEGIN
F0:entity work.Fetch port map(clk,rst,Instruction_out);
FB0:entity work.Fetch_Decode_Buffer port map(clk,rst,enable,Instruction_out,fetchOut);
--UFD:fetchDecoder port map(clk,rst,en,instOut,fetchOut);
--UC: controller port map(fetchOut,controlsel,controlregwrite);
--UregA: regArraytwo port map(clk,rst,WBregout,writeBackout,fetchOut,regArrayOut,writeBackdata);
--UDE: decodeExcute port map(clk,rst,en,regArrayOut,decodeExcuteOut,controlsel,controlregwrite,excSel,excregwrite,fetchOut(6 downto 4),excout);
--UALU: ALU port map(decodeExcuteOut,(others => '0'),'0',excSel,ALUcout,ALUOut);
--UWB: writeBack port map(clk,rst,en,ALUOut,writeBackdata,excregwrite,WBregout,excout,writeBackout);


END arch;