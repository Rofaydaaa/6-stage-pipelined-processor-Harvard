Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HDUdata is port(
  rdstDE: IN std_logic_vector(2 downto 0); 
  rdstEM: IN std_logic_vector(2 downto 0); 
  memReadDE: IN std_logic; --memRead from decode excute stage
  memReadEM: IN std_logic; --memRead from excute memory stage
  Rsrc1,Rsrc2: in std_logic_vector(2 downto 0);--adress of src1 and src2 
  freeze_pc: out std_logic; --freeze the pc
  stopCU: out std_logic --send a signal to control unit =1

);
end entity;

Architecture arch of HDUdata is
begin
process(rdstDE,rdstEM,memReadDE,memReadEM,Rsrc1,Rsrc2)  
BEGIN
   if ((memReadDE = '1' and ((rdstDE = Rsrc1) or (rdstDE = Rsrc2)))or (memReadEM = '1' and ((rdstEM = Rsrc1) or (rdstEM = Rsrc2))) ) then
        freeze_pc <= '1';
        nop <= '1';
        stopCU <= '1';
    else
        freeze_pc <= '0';
        nop <= '0';
        stopCU <= '0';
    end if;
end process;
end arch;
