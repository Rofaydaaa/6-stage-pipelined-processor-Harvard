Library IEEE;
use ieee.std_logic_1164.all;

ENTITY decodeExcuteBuffer IS
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
        restofIR: in  std_logic_vector(15 downto 0); 
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
        restofIRout: out  std_logic_vector(15 downto 0) 
        
       
);
END decodeExcuteBuffer;


ARCHITECTURE imp OF decodeExcuteBuffer IS
BEGIN
PROCESS (clk,rst)
BEGIN
IF rst = '1' THEN
pushout<='0';
popout<='0';
SPout<='0';
WBout<='0';
memReadout<='0';
memWriteout<='0';
EXout<='0';
branchout<='0';
portFlagout<='0';
returnOIout<='0';
callout<='0';
No_Cond_Branchout<='0';

ALU_selectionout <= (OTHERS=>'0');
data1out <= (OTHERS=>'0');
data2out <= (OTHERS=>'0');
rdstout <= (OTHERS=>'0');
restofIRout <= (OTHERS=>'0');

ELSIF falling_edge(clk) THEN
if (en='1') then
pushout<=push;
popout<=pop;
SPout<=SP;
WBout<=WB;
memReadout<=memRead;
memWriteout<=memWrite;
EXout<=EX;
branchout<=branch;
portFlagout<=portFlag;
returnOIout<=returnOI;
callout<=call;
No_Cond_Branchout<=No_Cond_Branch;

ALU_selectionout <= ALU_selection;
data1out <= data1;
data2out <= data2;
rdstout <= rdst;
restofIRout <= restofIR;

end if;
END IF;
END PROCESS;
END imp;