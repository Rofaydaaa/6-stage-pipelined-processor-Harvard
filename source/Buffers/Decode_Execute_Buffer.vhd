Library IEEE;
use ieee.std_logic_1164.all;

ENTITY Decode_Excute_Buffer IS
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
        Men_to_Reg:in std_logic;
        Int:in std_logic;
        ------------------ new wires---------------------------
         Rti:in std_logic;
         Rsrc1,Rsrc2: in std_logic_vector(2 downto 0);--adress of src1 and src2 
         memoryWire : in std_logic_vector(15 downto 0);
         forCall : in std_logic_vector(15 downto 0);
         flushSignal: in std_logic; --unhandled yet
        
         IN_Ports: IN STD_LOGIC_VECTOR(15 downto 0);
        -------------------------------------------------
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
        Men_to_Regout:out std_logic;
        Intout:out std_logic;
------------------ new wires---------------------------
         Rtiout:out std_logic;
         Rsrc1out,Rsrc2out: out std_logic_vector(2 downto 0);--adress of src1 and src2 
         memoryWireout : out std_logic_vector(15 downto 0);
         forCallout : out std_logic_vector(15 downto 0);
         IN_Portsout: out STD_LOGIC_VECTOR(15 downto 0);
-------------------------------------------------

        ALU_selectionout:out std_logic_vector(3 downto 0);
        data1out,data2out: out std_logic_vector(15 downto 0); 
        rdstout: out std_logic_vector(2 downto 0); 
        restofIRout: out  std_logic_vector(15 downto 0) 
        
       
);
END Decode_Excute_Buffer;


ARCHITECTURE imp OF Decode_Excute_Buffer IS
BEGIN
PROCESS (clk,rst,flushSignal)
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
Men_to_Regout<='0';
Intout<='0';
Rtiout<='0';
forCallout<= (OTHERS=>'0');
Rsrc1out <= (OTHERS=>'0');
Rsrc2out  <= (OTHERS=>'0');
memoryWireout<=(OTHERS=>'0');
ALU_selectionout <= (OTHERS=>'0');
data1out <= (OTHERS=>'0');
data2out <= (OTHERS=>'0');
rdstout <= (OTHERS=>'0');
restofIRout <= (OTHERS=>'0');
IN_Portsout<=(OTHERS=>'0');

ELsIF  flushSignal='1' then
pushout<='0';
popout<='0';
SPout<='0';
WBout<='0';
memReadout<='0';
memWriteout<='0';
EXout<='0';
branchout<=branch;
portFlagout<='0';
returnOIout<='0';
callout<='0';
No_Cond_Branchout<=No_Cond_Branch;
Men_to_Regout<='0';
Intout<='0';
Rtiout<='0';
forCallout<= (OTHERS=>'0');
Rsrc1out <= (OTHERS=>'0');
Rsrc2out  <= (OTHERS=>'0');
memoryWireout<=(OTHERS=>'0');
ALU_selectionout <= (OTHERS=>'0');
data1out <= (OTHERS=>'0');
data2out <= (OTHERS=>'0');
rdstout <= (OTHERS=>'0');
restofIRout <= (OTHERS=>'0');
IN_Portsout<=(OTHERS=>'0');

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
Men_to_Regout<=Men_to_Reg;
Intout<=Int;
Rtiout<=Rti;
ALU_selectionout <= ALU_selection;
data1out <= data1;
data2out <= data2;
rdstout <= rdst;
restofIRout <= restofIR;
Rsrc1out <=Rsrc1;
Rsrc2out  <= Rsrc2;
memoryWireout<=memoryWire;
IN_Portsout<=IN_Ports;
forCallout<=forCall;
end if;
END IF;
END PROCESS;
END imp;