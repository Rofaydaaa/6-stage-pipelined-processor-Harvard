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
  restOfInstruction_After:out std_logic_vector(14 downto 0)
);
END  decodeStage;

ARCHITECTURE arch OF decodeStage IS


component controlUnit is
    port (
        opcode: in std_logic_vector(5 downto 0);
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
        ALU_selection:out std_logic_vector(3 downto 0)
    

    );
end component;

component registerFile is
    port (
       clk,rst: in std_logic;
       writeReg: in std_logic_vector(2 downto 0); --des
       WB: in std_logic; --enable
       Rsrc1,Rsrc2: in std_logic_vector(2 downto 0);--adress of src1and2 
       WBvalue: in std_logic_vector(15 downto 0); --value coming back from the WB blobk
       data1,data2: out std_logic_vector(15 downto 0) --output 
       
    );
end component;

component decodeExcuteBuffer IS
PORT( clk,rst,en: std_logic;
        push: in std_logic;
        pop: in std_logic;
        SP: in std_logic;
        WB: in std_logic;
        memRead: in std_logic;
        memWrite: in std_logic;
        EX:in std_logic;
        branch:in std_logic;
        portFlag:in std_logic;
        returnOI:in std_logic;
        call:in std_logic;
        No_Cond_Branch:in std_logic;
        ALU_selection:in std_logic_vector(3 downto 0);
        data1,data2: in std_logic_vector(15 downto 0) ;
        rdst: in std_logic_vector(2 downto 0); 
        restofIR: in  std_logic_vector(14 downto 0); 
 ------------------------------------------------------------------
        pushout: out std_logic;
        popout: out std_logic;
        SPout: out std_logic;
        WBout: out std_logic;
        memReadout: out std_logic;
        memWriteout: out std_logic;
        EXout:out std_logic;
        branchout:out std_logic;
        portFlagout:out std_logic;
        returnOIout:out std_logic;
        callout:out std_logic;
        No_Cond_Branchout:out std_logic;
        ALU_selectionout:out std_logic_vector(3 downto 0);
        data1out,data2out: out std_logic_vector(15 downto 0); 
        rdstout: out std_logic_vector(2 downto 0); 
        restofIRout: out  std_logic_vector(14 downto 0) 
        
       
);
END component;

signal pushwire,popwire,SPwire,WBwire,memReadwire,memWritewire,EXwire,branchwire,portFlagwire,returnOIwire,callwire,No_Cond_Branchwire :std_logic;
signal ALU_selectionwire : std_logic_vector(3 downto 0);
signal data1wire,data2wire : std_logic_vector(15 downto 0);
BEGIN

CU :entity work.controlUnit port map (Instruction_After(31 downto 26),pushwire,popwire,SPwire,WBwire,memReadwire,memWritewire,EXwire,branchwire,portFlagwire,returnOIwire,callwire,No_Cond_Branchwire,ALU_selectionwire);
RF : entity work.registerFile port map (clk,rst,writeReg,en,Instruction_After(25 downto 23),Instruction_After(23 downto 21),WBvalue,data1wire,data2wire);
buff: entity work.decodeExcuteBuffer port map (clk,rst,en,pushwire,popwire,SPwire,WBwire,memReadwire,memWritewire,EXwire,branchwire,portFlagwire,returnOIwire,callwire,No_Cond_Branchwire,ALU_selectionwire,data1wire,data2wire,Instruction_After(18 downto 16),Instruction_After(14 downto 0)
,push,pop,SP,WB,memRead,memWrite,EX,branch,portFlag,returnOI,call,No_Cond_Branch,ALU_selection,data1,data2,rdst, restOfInstruction_After);

END arch;
