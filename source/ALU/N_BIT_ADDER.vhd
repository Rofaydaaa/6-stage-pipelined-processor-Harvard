LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY N_BIT_ADDER IS
Generic ( n : Integer:=16);
	PORT (x,y : IN   std_logic_vector (n-1 downto 0);
	cin: IN std_logic;
	s: OUT std_logic_vector (n-1 downto 0);
	cout : OUT std_logic);
END N_BIT_ADDER;

ARCHITECTURE IMP OF N_BIT_ADDER  IS
	component ONE_BIT_ADDER  is
		PORT (a,b,cin : IN  std_logic;
		s, cout : OUT std_logic );
	END component;

	signal carry : std_logic_vector (n-1 downto 0);

	BEGIN
		sum0: ONE_BIT_ADDER PORT MAP(x(0), y(0), cin, s(0), carry(0));
		loop2: FOR i IN 1 TO n-1 GENERATE
						sumx: ONE_BIT_ADDER PORT MAP(x(i),y(i),carry(i-1),s(i),carry(i));
		END GENERATE;
	cout <= carry(n-1);
END IMP;