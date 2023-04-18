Library IEEE;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY Instruction_Mem IS
PORT (
clk,Rst: IN std_logic;
PC: in std_logic_vector (15 downto 0);
Instruction: out std_logic_vector (31 downto 0) 
);
END ENTITY Instruction_Mem;

ARCHITECTURE Imp OF Instruction_Mem is

 TYPE ram_type IS ARRAY(0 TO 4096) of std_logic_vector(15 DOWNTO 0);
 SIGNAL ram : ram_type ;
BEGIN

PROCESS(clk,Rst) IS 
BEGIN
IF Rst = '1' THEN 
	Instruction <= (others => '0');
ELSIF rising_edge(clk) THEN 
    Instruction(31 downto 16) <=  ram(to_integer(unsigned((PC)))) ;
    Instruction(15 downto 0) <=  ram(to_integer(unsigned(std_logic_vector( unsigned(PC) + 1 )))) ;
END IF;
END PROCESS;
END Imp;
