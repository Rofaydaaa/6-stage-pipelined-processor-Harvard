Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is port(
freeze_hdu_data,freeze_hdu_structural: IN std_logic;
Rst: in std_logic;
M_Of_0: in std_logic_vector (15 downto 0);
input: in std_logic_vector (15 downto 0);
output: out std_logic_vector (15 downto 0);
clk: in std_logic
);
end entity;

Architecture Imp of PC is
    type ram_type is array (0 to 0) of std_logic_vector(15 downto 0);
    signal ram : ram_type;
BEGIN

PROCESS (Clk, Rst)
BEGIN
IF Rst = '1' THEN
    output<= M_Of_0;
    ram(0) <= M_Of_0;
ELSIF rising_edge(Clk) THEN
    IF freeze_hdu_data = '1' OR freeze_hdu_structural= '1' THEN
        output<= ram(0);
    ELSE
        output<= input;
        ram(0) <= input;
    END IF;
END IF;
END PROCESS;
end Imp;