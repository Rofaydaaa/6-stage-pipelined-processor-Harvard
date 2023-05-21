LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity Imm_Control_Unit is
port(
 Instruction: IN std_logic_vector(31 downto 0);
 isImm:out std_logic
);
end Imm_Control_Unit;

architecture arch of Imm_Control_Unit is
--"001011";
--"010001";
begin
process(Instruction)
begin
if(Instruction(15 downto 10)="001011" or Instruction(15 downto 10)="010001") then
isImm<='1';
else
isImm<='0';
end if;
end process;

end arch;