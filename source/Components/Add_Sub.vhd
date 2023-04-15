Library IEEE;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY Add_Sub IS
PORT (
op2,sel: IN std_logic;
op1: in std_logic_vector (15 downto 0);
output: out std_logic_vector (15 downto 0)  
);
end ENTITY Add_Sub;

ARCHITECTURE Imp OF Add_Sub IS
signal Op2_extend:  std_logic_vector (15 downto 0);
BEGIN
op2_extend<=  (0=>op2, Others => '0');

--if push=1 --> sel=1 & subtract 1
--if pop=1 --> sel=0 & add 1
--if push=pop=0 --> sel=1 & subtract 0 

output <= std_logic_vector(unsigned(op1) + unsigned(op2_extend)) when sel<='0'
else  std_logic_vector(unsigned(op1) - unsigned(op2_extend));

END Imp;
