Library IEEE;
use ieee.std_logic_1164.all;

ENTITY Mem_Mem_Buffer IS
PORT( Clk,Rst,en,WB : IN std_logic;
WB_after : out std_logic;
Rdst: in std_logic_vector (2 downto 0);
Rdst_after: out std_logic_vector (2 downto 0);

--Data_out: is data from ALU after being buffered
--Read_data: is data from memory

Data_out,Read_data: in std_logic_vector (15 downto 0);
Data_out_after,Read_data_after: out std_logic_vector (15 downto 0)
);
END Mem_Mem_Buffer;


ARCHITECTURE imp OF Mem_Mem_Buffer IS
BEGIN
PROCESS (Clk,Rst)
BEGIN
IF Rst = '1' THEN
WB_after <= '0';
Rdst_after <= (OTHERS=>'0');
data_out_after <= (OTHERS=>'0');
Read_data_after <= (OTHERS=>'0');
ELSIF falling_edge(Clk) THEN
if (en='1') then
WB_after <= WB;
Rdst_after <= Rdst;
Data_out_after <= Data_out;
Read_data_after <= Read_data;
end if;
END IF;
END PROCESS;
END imp;
