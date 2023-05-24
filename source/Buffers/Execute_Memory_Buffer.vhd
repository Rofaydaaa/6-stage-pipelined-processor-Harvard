----------------------------------------------------------
--  string s = "Roufy was here, coding in peace <3 <3"; --
--  string deleteIt = "od";                             --
--  size_t pos = str.find(deleteIt);                    --
--  s.replace(pos, deleteIt.length(), "ry");            --
--  cout<<s;                                            --
----------------------------------------------------------

Library IEEE;
use ieee.std_logic_1164.all;

ENTITY Execute_Memory_Buffer IS
PORT( 
    callMux:in std_logic_vector(15 downto 0);
    clk,Rst,en: IN std_logic;
    -- Buffer INPUT
    push: in std_logic;
    pop: in std_logic;
    SP: in std_logic;
    WB : in std_logic;
    memRead : in std_logic;
    memWrite : in std_logic;
    portFlag :in std_logic;
    returnOI :in std_logic;
    call :in std_logic;
    Men_to_Reg:in std_logic;
    Int:in std_logic;
     ------------------ new wires---------------------------
     Rti:in std_logic;
     memoryWire : in std_logic_vector(15 downto 0);
     forCall : in std_logic_vector(15 downto 0);
     flushSignal: in std_logic; --unhandled yet
     IN_Ports: IN STD_LOGIC_VECTOR(15 downto 0);
    -------------------------------------------------

    dataout : in std_logic_vector(15 downto 0); 
    WriteData : in std_logic_vector(15 downto 0);
    rdst : in std_logic_vector(2 downto 0); 
    --CCR : in std_logic_vector(15 downto 0); 

    -- BUFFER OUTPU

    pushOut : out std_logic;
    popOut : out std_logic;
    SPOut : out std_logic;
    WBOut : out std_logic;
    memReadOut : out std_logic;
    memWriteOut : out std_logic;
    portFlagOut : out std_logic;
    returnOIOut : out std_logic;
    callOut : out std_logic;
    Men_to_Regout:out std_logic;
    Intout:out std_logic;
   ------------------ new wires---------------------------
   Rtiout:out std_logic;
   memoryWireout : out std_logic_vector(15 downto 0);
   forCallout : out std_logic_vector(15 downto 0);
   IN_Portsout: out STD_LOGIC_VECTOR(15 downto 0);
-------------------------------------------------

    dataoutOut : out std_logic_vector(15 downto 0); 
    WriteDataOut : out std_logic_vector(15 downto 0);
    rdstOut : out std_logic_vector(2 downto 0);
    output_from_E_PCsource: in std_logic;
    output_from_EM_PCsource : out std_logic


    --IN_Port_IN: in std_logic_vector (15 downto 0);
    --IN_Port_OUT: out std_logic_vector (15 downto 0)
    --CCROut : out std_logic_vector(15 downto 0); 

);
END Execute_Memory_Buffer;


ARCHITECTURE imp OF Execute_Memory_Buffer IS
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
    portFlagout<='0';
    returnOIout<='0';
    callout<='0';
    Men_to_Regout<='0';
    Intout<='0';
    Rtiout<='0';
    forCallout<=(OTHERS=>'0');
    memoryWireout<=(OTHERS=>'0');
    dataoutOut <= (OTHERS=>'0');
    WriteDataOut <= (OTHERS=>'0');
    --CCROut <= (OTHERS=>'0');
    rdstOut <= (OTHERS=>'0');
    IN_Portsout<=(OTHERS=>'0');
    output_from_EM_PCsource<='0';
ELSIF flushSignal='1' THEN
    pushout<=push;
    popout<=pop;
    SPout<=SP;
    WBout<=WB;
    memReadout<=memRead;
    memWriteout<=memWrite;
    portFlagout<='0';
    returnOIout<='0';
    callout<='0';
    Men_to_Regout<=Men_to_reg;
    Intout<='0';
    Rtiout<='0';
    forCallout<=forCall;
    memoryWireout<=memoryWire;
    dataoutOut <= dataout;
    WriteDataOut <= WriteData;
    --CCROut <= (OTHERS=>'0');
    rdstOut <= (OTHERS=>'0');
    IN_Portsout<=(OTHERS=>'0');
    output_from_EM_PCsource<= output_from_E_PCsource;

ELSIF falling_edge(clk) THEN
if (en='1') then
    pushout<=push;
    popout<=pop;
    SPout<=SP;
    WBout<=WB;
    memReadout<=memRead;
    memWriteout<=memWrite;
    portFlagout<=portFlag;
    returnOIout<=returnOI;
    callout<=call;
    Men_to_Regout<=Men_to_Reg;
    Intout<=Int;
    Rtiout<=Rti;
    memoryWireout<=memoryWire;
    IN_Portsout<=IN_Ports;
    forCallout<=forCall;
    dataoutOut <= dataout;
    WriteDataOut <= WriteData;
    --CCROut <= CCR;
    rdstOut <= rdst;
    output_from_EM_PCsource <= output_from_E_PCsource;
    --IN_Port_OUT <= IN_Port_IN;
    callMuxout<=callMux;
end if;
END IF;
END PROCESS;
END imp;