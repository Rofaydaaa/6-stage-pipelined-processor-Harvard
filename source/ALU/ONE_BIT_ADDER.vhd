----------------------------------------------------------
--  string s = "Roufy was here, coding in peace <3 <3"; --
--  string deleteIt = "od";                             --
--  size_t pos = str.find(deleteIt);                    --
--  s.replace(pos, deleteIt.length(), "ry");            --
--  cout<<s;                                            --
----------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY ONE_BIT_ADDER IS
	PORT (a,b,cin : IN  std_logic;
	s, cout : OUT std_logic );
END ONE_BIT_ADDER;

ARCHITECTURE IMP OF ONE_BIT_ADDER IS
	BEGIN
		s <= a XOR b XOR cin;
		cout <= (a AND b) OR (cin AND (a XOR b));
END IMP;