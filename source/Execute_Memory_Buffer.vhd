Library IEEE;
use ieee.std_logic_1164.all;

ENTITY Execute_Memory_Buffer IS
PORT( 
    clk,Rst,en: IN std_logic;
    -- Buffer INPUT
    push: in std_logic;
    pop: in std_logic;
    SP: in std_logic;
    WB : in std_logic;
    memRead : in std_logic;
    memWrite : in std_logic;
    EX :in std_logic;
    branch :in std_logic;
    portFlag :in std_logic;
    returnOI :in std_logic;
    call :in std_logic;
    dataout : in std_logic_vector(15 downto 0); 
    WriteData : in std_logic_vector(15 downto 0);
    CCR : in std_logic_vector(15 downto 0); 
    rdst : in std_logic_vector(2 downto 0); 
    

    -- BUFFER OUTPU

    pushOut : out std_logic;
    popOut : out std_logic;
    SPOut : out std_logic;
    WBOut : out std_logic;
    memReadOut : out std_logic;
    memWriteOut : out std_logic;
    EXOut : out std_logic;
    branchOut : out std_logic;
    portFlagOut : out std_logic;
    returnOIOut : out std_logic;
    callOut : out std_logic;
    dataoutOut : out std_logic_vector(15 downto 0); 
    WriteDataOut : out std_logic_vector(15 downto 0);
    CCROut : out std_logic_vector(15 downto 0); 
    rdstOut : out std_logic_vector(2 downto 0)
);
END Execute_Memory_Buffer;


ARCHITECTURE imp OF Execute_Memory_Buffer IS
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

    dataoutOut <= (OTHERS=>'0');
    WriteDataOut <= (OTHERS=>'0');
    CCROut <= (OTHERS=>'0');
    rdstOut <= (OTHERS=>'0');

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

    dataoutOut <= dataout;
    WriteDataOut <= WriteData;
    CCROut <= CCR;
    rdstOut <= rdst;

end if;
END IF;
END PROCESS;
END imp;