Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HDUstructural is port(
  rst: IN std_logic;
  memReadDE: IN std_logic; --memRead from decode excute stage
  memReadFD: IN std_logic; --memRead from excute memory stage
  memWriteDE: IN std_logic; --memWrite from decode excute stage
  memWriteFD: IN std_logic; --memWrite from excute memory stage
  freeze_pc: out std_logic; --freeze the pc
  
  stopCU: out std_logic --send a signal to control unit =1
  
);
end entity;

architecture arch of HDUstructural is
    signal memRead: std_logic;
    signal memWrite: std_logic;
begin
    memRead <= memReadDE when memReadFD = '0' else memReadFD;
    memWrite <= memWriteDE when memWriteFD = '0' else memWriteFD;

    process (rst,memRead, memWrite)
    begin
        if (rst = '1') then
            freeze_pc <= '0';
            
            stopCU <= '0';
        else

        if (memRead = '1' or memWrite = '1') then
            freeze_pc <= '1';
            
            stopCU <= '1';
        else
            freeze_pc <= '0';
            
            stopCU <= '0';
            end if;
        end if;
    end process;
end arch;
