----------------------------------------------------------
--  string s = "Roufy was here, coding in peace <3 <3"; --
--  string deleteIt = "od";                             --
--  size_t pos = str.find(deleteIt);                    --
--  s.replace(pos, deleteIt.length(), "ry");            --
--  cout<<s;                                            --
----------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

-- CCR<2:0>
-- Z<0>:=CCR<0> ; zero flag, change after arithmetic, logical, or shift operations
-- N<0>:=CCR<1> ; negative flag, change after arithmetic, logical, or shift operations
-- C<0>:=CCR<2> ; carry flag, change after arithmetic or shift operations.

ENTITY SET_CCR IS
    GENERIC (n : INTEGER := 16);
	PORT (
		clk,rst : IN STD_LOGIC;
		NOP_FLAG, UNCHANGE_CARRY, FIRSTTIME_FLAG : IN STD_LOGIC; --This flag should preserve the Value of the flag or carry flag
        F_ALU : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		Cout_ALU : IN STD_LOGIC;
		FLAG_OUT : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
		);
END ENTITY SET_CCR;

ARCHITECTURE IMP OF SET_CCR IS

SIGNAL Previous_caryy : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL Flag_Calc : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

	process(clk,rst)
	begin
		if (rst = '1') then
			Previous_caryy <= "000";
		elsif (rising_edge(Clk)) then
			Previous_caryy <= Flag_Calc;
		end if;
	end process;

	--Carry Flag
	Flag_Calc(2) <= '0' when rst ='1'
	else Cout_ALU when (NOP_FLAG = '0' and  UNCHANGE_CARRY = '0')
	else Previous_caryy(2);

	--Negative Flag
	--
	Flag_Calc(1) <= '0' when rst='1'
	else Previous_caryy(1) when NOP_FLAG = '1'
	else F_ALU(n -1);

	--Zero Flag
	Flag_Calc(0) <= '0' when rst = '1'
	else Previous_caryy(0) when NOP_FLAG = '1'
	else '1' when (F_ALU="0000000000000000" and FIRSTTIME_FLAG = '0')
	else '0';

	FLAG_OUT <= Flag_Calc;

END IMP;