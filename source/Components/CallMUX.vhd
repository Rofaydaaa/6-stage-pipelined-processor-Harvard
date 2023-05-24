Library ieee;
Use ieee.std_logic_1164.all;

entity CallMUX IS 
PORT (
        forCall: IN std_logic_vector(15 DOWNTO 0);
        PCforINT: IN std_logic_vector(15 DOWNTO 0);
		call: IN std_logic;
		output: OUT std_logic_vector(15 DOWNTO 0));
END ENTITY CallMUX;

ARCHITECTURE arch of CallMUX IS 
BEGIN
output <= PCforINT WHEN call ='0'
		ELSE forCall;
end arch;
