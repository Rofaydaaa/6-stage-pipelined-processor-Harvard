Library IEEE;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY decodeStage IS
PORT (
clk,Rst,en: IN std_logic;
Instruction_After: in std_logic_vector (31 downto 0);
writeReg: in std_logic_vector(2 downto 0); --des
WBvalue: in std_logic_vector(15 downto 0); --value coming back from the WB blobk
--OUTS
  push: out std_logic;
  pop: out std_logic;
  SP: out std_logic;
  WB: out std_logic;
  memRead: out std_logic;
  memWrite: out std_logic;
  EX:out std_logic;
  branch:out std_logic;
  portFlag:out std_logic;
  returnOI:out std_logic;
  call:out std_logic;
  No_Cond_Branch:out std_logic;
  ALU_selection:out std_logic_vector(3 downto 0);
  data1,data2:out std_logic_vector(15 downto 0);
  rdst: out std_logic_vector(2 downto 0);
  restOfInstruction_After:out std_logic_vector(15 downto 0)
);
END  decodeStage;

ARCHITECTURE arch OF decodeStage IS

signal pushwire,popwire,SPwire,WBwire,memReadwire,memWritewire,EXwire,branchwire,portFlagwire,returnOIwire,callwire,No_Cond_Branchwire :std_logic;
signal ALU_selectionwire : std_logic_vector(3 downto 0);
signal data1wire,data2wire : std_logic_vector(15 downto 0);
BEGIN

CU :entity work.controlUnit port map (Instruction_After(31 downto 26),pushwire,popwire,SPwire,WBwire,memReadwire,memWritewire,EXwire,branchwire,portFlagwire,returnOIwire,callwire,No_Cond_Branchwire,ALU_selectionwire);
RF : entity work.registerFile port map (clk,rst,writeReg,en,Instruction_After(25 downto 23),Instruction_After(22 downto 20),WBvalue,data1wire,data2wire);
buff: entity work.decodeExcuteBuffer port map (clk,rst,en,pushwire,popwire,SPwire,WBwire,memReadwire,memWritewire,EXwire,branchwire,portFlagwire,returnOIwire,callwire,No_Cond_Branchwire,ALU_selectionwire,data1wire,data2wire,Instruction_After(19 downto 17),Instruction_After(15 downto 0)
,push,pop,SP,WB,memRead,memWrite,EX,branch,portFlag,returnOI,call,No_Cond_Branch,ALU_selection,data1,data2,rdst, restOfInstruction_After);

END arch;
