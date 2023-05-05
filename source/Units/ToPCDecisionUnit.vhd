Library ieee;
Use ieee.std_logic_1164.all;

entity ToPCDecisionUnit IS 
PORT (
        Add: IN std_logic_vector(15 DOWNTO 0);
        Branch_Address: IN std_logic_vector(15 DOWNTO 0);
        M_of_1: IN std_logic_vector(15 DOWNTO 0);
        WB_Rdst: IN std_logic_vector(15 DOWNTO 0);
        WB_Data: IN std_logic_vector(15 DOWNTO 0);
		Int,Call,Ret,Branch: IN std_logic;
		To_PC: OUT std_logic_vector(15 DOWNTO 0));
END ENTITY ToPCDecisionUnit;

ARCHITECTURE arch of ToPCDecisionUnit IS 
begin
process(Int,Call,Ret,Branch)
begin
    if(Int='1') then
        To_PC <= M_of_1;
    elsif(Call='1') then
        To_PC <= WB_Rdst;
    elsif(Ret='1') then
        To_PC <= WB_Data;
    elsif(Branch='1') then
        To_PC <= Branch_Address;
    else
        To_PC <= Add;
    end if;
end process;
end arch;
