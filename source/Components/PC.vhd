Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is port(
EM_Immediate:  in std_logic;
Immediate: in std_logic;
OPCode_HDU_Struct:  in std_logic_vector (5 downto 0);
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

PROCESS (Clk,freeze_hdu_data,freeze_hdu_structural,Rst)
BEGIN
IF Rst = '1' THEN
    output<= M_Of_0;
    ram(0) <= M_Of_0;
        
ELSIF ((freeze_hdu_data = '1' OR freeze_hdu_structural= '1') and Immediate='1') THEN
output<= std_logic_vector(unsigned(ram(0)) - 2) ;
      
ELSIF freeze_hdu_data = '1' OR freeze_hdu_structural= '1' THEN
    output<= std_logic_vector(unsigned(ram(0)) - 1) ;
    --output <= ram(0);
    
ELSIF (rising_edge(Clk) and EM_Immediate='1') THEN
    output<= std_logic_vector(unsigned(input(0)) + 1) ;
    ram(0) <= std_logic_vector(unsigned(input(0)) + 1) ;

ELSIF rising_edge(Clk) THEN
    output<= input;
    ram(0) <= input;
  
END IF;
END PROCESS;
end Imp;