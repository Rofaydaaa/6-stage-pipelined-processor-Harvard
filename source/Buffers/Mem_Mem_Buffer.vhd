Library IEEE;
use ieee.std_logic_1164.all;

ENTITY Mem_Mem_Buffer IS
PORT( Clk,Rst,en,WB,flush : IN std_logic;
Rdst: in std_logic_vector (2 downto 0);
Data_out,M1: in std_logic_vector (15 downto 0);
Read_data: in std_logic_vector (31 downto 0);

memRead : in std_logic;
memWrite : in std_logic;

Mem_to_Reg:in std_logic;
Int:in std_logic;
portFlag:in std_logic;

call:in std_logic;
RTI: in std_logic;
RET: in std_logic;

IN_Port_IN: in std_logic_vector (15 downto 0);

--Data_out: is data from ALU after being buffered
--Read_data: is data from memory
Data_out_after,M1_after: out std_logic_vector (15 downto 0);
Read_data_after: out std_logic_vector (31 downto 0);
Rdst_after: out std_logic_vector (2 downto 0);

WB_after : out std_logic;

memReadOut : out std_logic;
memWriteOut : out std_logic;

Mem_to_Regout:out std_logic;
Intout:out std_logic;
portFlagout:out std_logic;

callout: out std_logic;
RETout: out std_logic;
RTIout: out std_logic;

IN_Port_OUT: out std_logic_vector (15 downto 0)
);
END Mem_Mem_Buffer;


ARCHITECTURE imp OF Mem_Mem_Buffer IS
BEGIN
PROCESS (Clk,Rst,flush)
BEGIN
IF Rst = '1' THEN
WB_after <= '0';
Rdst_after <= (OTHERS=>'0');
data_out_after <= (OTHERS=>'0');
M1_after <= (OTHERS=>'0');
Read_data_after <= (OTHERS=>'0');

memReadout<='0';
memWriteout<='0';

Mem_to_Regout<='0';
Intout<='0';
portFlagout<='0';

callout<='0';
RTIout<='0';
RETout<='0';
IN_Port_OUT <= (OTHERS=>'0');

elsif flush='1' THEN
WB_after <= WB;
Rdst_after <= (OTHERS=>'0');
data_out_after <= (OTHERS=>'0');
M1_after <= (OTHERS=>'0');
Read_data_after <= (OTHERS=>'0');

memReadout<='0';
memWriteout<='0';

Mem_to_Regout<='0';
Intout<='0';
portFlagout<='0';

callout<='0';
RTIout<='0';
RETout<='0';
IN_Port_OUT <= (OTHERS=>'0');

ELSIF falling_edge(Clk) THEN
if (en='1') then
WB_after <= WB;
Rdst_after <= Rdst;
Data_out_after <= Data_out;
Read_data_after <= Read_data;
M1_after<=M1;

memReadout<=memRead;
memWriteout<=memWrite;

Mem_to_Regout<=Mem_to_Reg;
Intout<=Int;
portFlagout<=portFlag;

callout<=call;
RTIout<=RTI;
RETout<=RET;
IN_Port_OUT <= IN_Port_IN;

end if;
END IF;
END PROCESS;
END imp;
