Library IEEE;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY Data_Mem IS
PORT (
clk,Rst,Mem_Read,Mem_Write,S_P,Push,Pop,call: IN std_logic;
Write_data,address_from_ALU,data_from_call: in std_logic_vector (15 downto 0);
CCR,Rdst: out std_logic_vector (2 downto 0);
read_data: out std_logic_vector (15 downto 0) 
);
END ENTITY Data_Mem;

ARCHITECTURE Imp OF Data_Mem IS
component Mux2by1 IS 
	Generic ( n : Integer:=16);
	PORT ( in0,in1 : IN std_logic_vector (n-1 DOWNTO 0);
			sel : IN  std_logic;
			out1 : OUT std_logic_vector (n-1 DOWNTO 0));
END component;

component Add_Sub IS
PORT (
op2,sel: IN std_logic;
op1: in std_logic_vector (15 downto 0);
output: out std_logic_vector (15 downto 0)  
);
end component;

component SP is port(
input: in std_logic_vector (15 downto 0);
output: out std_logic_vector (15 downto 0);
Reset: in std_logic;
Enable: in std_logic;
clk: in std_logic
);
end component;

signal address: std_logic_vector(9 downto 0);
signal address_from_SP,Add_sub_Result,data_to_write: std_logic_vector(15 downto 0);
signal Push_or_Pop,Push_or_NotPop: std_logic;

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
IF Mem_Write = '1' THEN
   		ram(to_integer(unsigned((address)))) <= data_to_write;
 	END IF;
END IF;
END PROCESS;

Mux0: Mux2by1 generic map (16) port map(address_from_ALU,address_from_SP,S_P,address);
Mux1: Mux2by1 generic map (16) port map(write_data,data_from_call,call,data_to_write);

SP0 : SP port map (Add_sub_Result,address_from_SP,rst,S_P,clk);

AddSub0 : Add_Sub port map (Push_or_Pop,Push_or_NotPop,address_from_SP,Add_sub_Result); 

Push_or_Pop <= Push or Pop;
Push_or_NotPop <= Push or (not Pop); 

read_data <= ram(to_integer(unsigned((address)))) when Mem_read <='1';
END Imp;
