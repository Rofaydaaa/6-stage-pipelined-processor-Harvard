Library IEEE;
use ieee.std_logic_1164.all;

ENTITY Fetch_Decode_Buffer IS
PORT( 
    Output_from_F_PC_For_int: in std_logic_vector (15 downto 0);
    Clk,Rst,en,Int_from_Int_reg_in: IN std_logic;
Instruction_IN: in std_logic_vector (31 downto 0);
IN_Port_IN: in std_logic_vector (15 downto 0);
For_call_IN: in std_logic_vector (15 downto 0);

Instruction_After: out std_logic_vector (31 downto 0);
Int_from_Int_reg_out: out std_logic;
IN_Port_OUT: out std_logic_vector (15 downto 0);
For_call_OUT: out std_logic_vector (15 downto 0);
Output_from_F_PC_For_intout: out std_logic_vector (15 downto 0)
);
END Fetch_Decode_Buffer;


ARCHITECTURE imp OF Fetch_Decode_Buffer IS
BEGIN
PROCESS (Clk,Rst)
BEGIN
IF Rst = '1' THEN
Instruction_After <= (OTHERS=>'0');
Int_from_Int_reg_out <= '0';
IN_Port_OUT <= (OTHERS=>'0');
For_call_OUT <= (OTHERS=>'0');
Output_from_F_PC_For_intout<= (OTHERS=>'0');
ELSIF falling_edge(Clk) THEN
if (en='1') then
Int_from_Int_reg_out <= Int_from_Int_reg_in;
Instruction_After <= Instruction_IN;
IN_Port_OUT <= IN_Port_IN;
For_call_OUT <= For_call_IN;
Output_from_F_PC_For_intout<=Output_from_F_PC_For_int;
end if;
END IF;
END PROCESS;
END imp;
