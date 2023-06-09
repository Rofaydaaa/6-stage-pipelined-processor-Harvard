Library IEEE;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY WriteBack IS
PORT (
readData : in std_logic_vector( 31 downto 0);
dataOut : in std_logic_vector( 15 downto 0);
Men_to_Reg,portFlag:in std_logic;
inPort : in std_logic_vector( 15 downto 0);

WBvalue, outPort,CCR: out std_logic_vector( 15 downto 0)
);
END  WriteBack;

ARCHITECTURE arch OF WriteBack IS

signal outputwire:std_logic_vector(15 downto 0);
BEGIN
Mux1U :  entity work.Mux2x1 GENERIC MAP(16) PORT MAP(dataOut,readData(15 downto 0),Men_to_Reg,outputwire);
Mux2U :  entity work.Mux2x1 GENERIC MAP(16) PORT MAP(outputwire,inPort,portFlag,WBvalue);
outPort<=dataOut;

CCR<=readData(31 downto 16);
END arch;