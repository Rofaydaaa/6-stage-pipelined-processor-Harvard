Library IEEE;
use ieee.std_logic_1164.all;

ENTITY Fetch_Decode_Buffer IS
PORT( Clk,Rst,en: IN std_logic;
Instruction_IN: in std_logic_vector (31 downto 0);
Instruction_After: out std_logic_vector (31 downto 0);

IN_Port_IN: in std_logic_vector (15 downto 0);
IN_Port_OUT: out std_logic_vector (15 downto 0)
);
END Fetch_Decode_Buffer;


ARCHITECTURE imp OF Fetch_Decode_Buffer IS
BEGIN
PROCESS (Clk,Rst)
BEGIN
IF Rst = '1' THEN
Instruction_After <= (OTHERS=>'0');
IN_Port_OUT <= (OTHERS=>'0');
ELSIF falling_edge(Clk) THEN
if (en='1') then
Instruction_After <= Instruction_IN;
IN_Port_OUT <= IN_Port_IN;
end if;
END IF;
END PROCESS;
END imp;
