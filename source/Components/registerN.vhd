LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY registerN IS
PORT( clk,rst ,en: IN std_logic;
  d: IN std_logic_vector(15 downto 0);
 q : OUT std_logic_vector(15 downto 0));
END registerN;

ARCHITECTURE arch OF registerN IS
BEGIN PROCESS(clk,rst)
BEGIN
IF(rst = '1') THEN
q <= (others => '0');
ELSIF rising_edge(clk) THEN
IF(en = '1')THEN
q <= d;
END IF;
END IF;
END PROCESS;
END arch;
