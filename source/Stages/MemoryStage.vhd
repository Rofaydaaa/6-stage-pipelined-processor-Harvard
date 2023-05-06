Library IEEE;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY MemoryStage IS
PORT (
clk,Rst, Mem_Read,Mem_Write, S_P,Push,Pop,call,RTI,INT: IN std_logic;
Write_data,address_from_ALU,data_from_call, PC_for_int: in std_logic_vector (15 downto 0);
CCR,Rdst: out std_logic_vector (2 downto 0);

--read data was 16 in phase 1
read_data: out std_logic_vector (31 downto 0) 
);
END ENTITY MemoryStage;

ARCHITECTURE Imp OF MemoryStage IS
component Mux2by1 IS 
	Generic ( n : Integer:=16);
	PORT ( in0,in1 : IN std_logic_vector (n-1 DOWNTO 0);
			sel : IN  std_logic;
			out1 : OUT std_logic_vector (n-1 DOWNTO 0));
END component;

component Add_Sub IS
PORT (
sel: IN std_logic;
op2: in std_logic_vector (1 downto 0);
op1: in std_logic_vector (15 downto 0);
output: out std_logic_vector (15 downto 0)  
);
end component;

component SP is port(
input: in std_logic_vector (15 downto 0);
output: out std_logic_vector (15 downto 0);
Reset: in std_logic;
--Enable: in std_logic;
clk: in std_logic
);
end component;
component Mux4by1 IS 
	Generic ( n : Integer:=32);
	PORT ( in0,in1,in2: IN std_logic_vector (n-1 DOWNTO 0);
			sel1,sel0 : IN  std_logic;
			out1 : OUT std_logic_vector (n-1 DOWNTO 0));
END component;


signal address: std_logic_vector(15 downto 0);
signal address_from_SP,Add_sub_Result: std_logic_vector(15 downto 0);

--/////////in phase 1 data_to_write was 16 bits

signal Data_concatenated,data_to_write,Write_data32,data_from_call32: std_logic_vector(31 DOWNTO 0);
signal Push_or_Pop,Push_or_NotPop, INT_or_RTI: std_logic;
signal one_or_two, Push_or_Pop_extend: std_logic_vector(1 DOWNTO 0);
signal add : std_logic_vector(9 downto 0);

--/////////////////////////////////
--1 KB is the length?????

 TYPE ram_type IS ARRAY(0 TO 1023) of std_logic_vector(15 DOWNTO 0);
 SIGNAL ram : ram_type ;

BEGIN

PROCESS(clk,Rst) IS 
BEGIN
IF Rst = '1' THEN 
	ram <= (others=>(others => '0'));

ELSIF rising_edge(clk) THEN 
if  (Mem_Write = '1' and  INT_or_RTI='1') THEN
                ram(to_integer(unsigned((address(9 downto 0))))) <= data_to_write(15 downto 0);
                ram(to_integer(unsigned(address(9 downto 0))) +1)<= data_to_write(31 downto 16);
elsif Mem_Write = '1' THEN
   		ram(to_integer(unsigned((address(9 downto 0))))) <= data_to_write(15 downto 0);

elsif  (Mem_read = '1' and  INT_or_RTI='1') THEN
               read_data(15 downto 0) <= ram(to_integer(unsigned((address(9 downto 0)))));
               read_data(31 downto 16) <=  ram(to_integer(unsigned(address(9 downto 0))) +1);
elsif Mem_read ='1' then
               read_data(15 downto 0) <= ram(to_integer(unsigned((address(9 downto 0)))));
               read_data(31 downto 16) <=(others => '0');
else
	read_data <= (others => '0');
end if;
end if;
END PROCESS;

Mux0: Mux2by1 generic map (16) port map(address_from_ALU,address_from_SP,S_P,address);
--Mux1: Mux2by1 generic map (16) port map(write_data,data_from_call,call,data_to_write);
Mux1: Mux4by1 generic map (32) port map(write_data32, data_from_call32, Data_concatenated,INT,call,data_to_write);

Push_or_Pop_extend<= '0'&Push_or_Pop;
MuxSP: Mux2by1 generic map (2) port map(Push_or_Pop_extend, b"10", INT_or_RTI, one_or_two);


SP0 : SP port map (Add_sub_Result,address_from_SP,rst,clk);

AddSub0 : Add_Sub port map ( Push_or_NotPop,one_or_two ,address_from_SP,Add_sub_Result); 

Push_or_Pop <= Push or Pop;
Push_or_NotPop <= Push or (not Pop); 

INT_or_RTI <= INT or RTI;

--PC from [31:16], Data from [15:0] 
Data_concatenated<=PC_for_int & address_from_ALU;

Write_data32<= x"0000"&Write_data;
data_from_call32<=x"0000" & data_from_call;
--add<=to_integer(unsigned(address(9 downto 0))) +1);

--read_data <= ram(to_integer(unsigned((address)))) when Mem_read <='1';
END Imp;
