Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SP is port(
input: in std_logic_vector (15 downto 0);
output: out std_logic_vector (15 downto 0);
Reset: in std_logic;
--Enable: in std_logic;
clk: in std_logic
);
end entity;

Architecture Imp of SP is

signal sigOut:std_logic_vector(15 downto 0);

BEGIN
PROCESS (Clk,Reset)
BEGIN

IF Reset = '1' THEN
sigOut <= x"03FF";  -- =(2^10)-1

ELSIF rising_edge(Clk) THEN
sigOut<= input;
END IF;

END PROCESS;
output<= sigOut;
end Imp;
