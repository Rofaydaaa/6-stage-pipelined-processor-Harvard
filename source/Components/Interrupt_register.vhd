Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Interrupt_register is port(
input: in std_logic;
output: out std_logic
);
end entity;

Architecture arch of Interrupt_register is
    type ram_type is array (0 to 0) of std_logic;
    signal ram : ram_type := (others => '0');
BEGIN 
PROCESS(input)
BEGIN
if input = '1' then
    ram(0) <= input;
end if;
END PROCESS;
    output <= ram(0); -- Assign the output value
END arch;