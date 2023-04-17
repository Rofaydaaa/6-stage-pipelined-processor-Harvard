Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is port(
input: in std_logic_vector (15 downto 0);
output: out std_logic_vector (15 downto 0);
Reset: in std_logic;
clk: in std_logic
);
end entity;

Architecture Imp of PC is
BEGIN

PROCESS (Clk,Reset)
BEGIN
IF Reset = '1' THEN
output <= (others => '0');
ELSIF rising_edge(Clk) THEN
output<= input;
END IF;
END PROCESS;

end Imp;