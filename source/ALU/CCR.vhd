-------------------------------------- No neeed for this for Now--------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

--CCR is the flag register
ENTITY CCR IS
	PORT (
		EN, CLK, RESET : IN STD_LOGIC;
		DATA_IN : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		DATA_OUT : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        NOP_FLAG : OUT STD_LOGIC
        );
END ENTITY CCR;
ARCHITECTURE IMP_CCR OF CCR IS

SIGNAL ram : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
	PROCESS (CLK, RESET)
	BEGIN
		IF RESET = '1' THEN
			DATA_OUT <= (OTHERS => '0');
		ELSIF RISING_EDGE(CLK) AND EN = '1' THEN
			DATA_OUT <= DATA_IN;
		END IF;
	END PROCESS;
END IMP_CCR;