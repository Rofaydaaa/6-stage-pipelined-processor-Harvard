
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


--This Mux takes 3 inputs only not 4--
ENTITY Mux4by1 IS 
	Generic ( n : Integer:=32);
	PORT ( in0,in1,in2 : IN std_logic_vector (n-1 DOWNTO 0);
			sel1,sel0 : IN  std_logic;
			out1 : OUT std_logic_vector (n-1 DOWNTO 0));
END Mux4by1;


ARCHITECTURE when_else_mux OF Mux4by1 is
	BEGIN
		
  out1 <= 	in0 when sel1 = '0' and sel0='0'
else  in1 when sel1='0' and sel0='1'
else in2 when sel1='1' and sel0='0'
	else	in2;
END when_else_mux;

