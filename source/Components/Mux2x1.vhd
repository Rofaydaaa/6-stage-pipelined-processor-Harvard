Library ieee;
Use ieee.std_logic_1164.all;

entity Mux2x1 IS 
generic (
n:integer:=10
);
	PORT (
                A: IN std_logic_vector(n-1 DOWNTO 0);
                B: IN std_logic_vector(n-1 DOWNTO 0);
		sel: IN std_logic;
		C: OUT std_logic_vector(n-1 DOWNTO 0));
END ENTITY Mux2x1;

ARCHITECTURE arch of Mux2x1 IS 
BEGIN
	C <= A WHEN sel ='0'
		ELSE B;
end arch;
