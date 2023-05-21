library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controlUnit is
    port (
        interuptSignal: in std_logic;
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
        Men_to_Reg:out std_logic;
        Int:out std_logic;
        Rti:out std_logic;
        ALU_selection:out std_logic_vector(3 downto 0)
    );
end controlUnit;

architecture arch of controlUnit is
    constant nop_operation : std_logic_vector(5 downto 0) := "000000";
    constant setc_operation : std_logic_vector(5 downto 0) := "000010";
    constant clrc_operation : std_logic_vector(5 downto 0) := "000011";
    constant out_operation : std_logic_vector(5 downto 0) := "000100";
    constant in_operation : std_logic_vector(5 downto 0) := "000101";
    constant inc_operation : std_logic_vector(5 downto 0) := "000110";
    constant dec_operation : std_logic_vector(5 downto 0) := "000111";
    constant not_operation : std_logic_vector(5 downto 0) := "001000";
    constant mov_operation : std_logic_vector(5 downto 0) := "001001";
    constant add_operation : std_logic_vector(5 downto 0) := "001010";
    constant iadd_operation : std_logic_vector(5 downto 0) := "001011";
    constant sub_operation : std_logic_vector(5 downto 0) := "001100";
    constant and_operation : std_logic_vector(5 downto 0) := "001101";
    constant or_operation : std_logic_vector(5 downto 0) := "001110";
    constant push_operation : std_logic_vector(5 downto 0) := "001111";
    constant pop_operation : std_logic_vector(5 downto 0) := "010000";
    constant ldm_operation : std_logic_vector(5 downto 0) := "010001";
    constant ldd_operation : std_logic_vector(5 downto 0) := "010010";
    constant std_operation : std_logic_vector(5 downto 0) := "010011";
    constant jz_operation : std_logic_vector(5 downto 0) := "010100";
    constant jc_operation : std_logic_vector(5 downto 0) := "010101";
    constant jmp_operation : std_logic_vector(5 downto 0) := "010110";
    constant call_operation : std_logic_vector(5 downto 0) := "010111";
    constant ret_operation : std_logic_vector(5 downto 0) := "011000";
    constant rti_operation : std_logic_vector(5 downto 0) := "011001";
    constant int_operation : std_logic_vector(5 downto 0) := "011010"; --int has no opcode it should be just a wire and that wire if equal 1 ,release that control signal
    signal controlSignal: std_logic_vector(18 downto 0);
begin
process(opcode,interuptSignal)
begin
  
  IF interuptSignal = '1' THEN
    controlSignal <= "0100000001001001010";

    ELSE
  case opcode is
    when nop_operation =>
      controlSignal <= "0000000000000001010";
    when setc_operation =>
      controlSignal <= "0000000000000000100";
    when clrc_operation =>
      controlSignal <= "0000000000000001010";
    when out_operation =>
      controlSignal <= "0000000000000001110";
    when in_operation =>
      controlSignal <= "0001000000100001010";
    when inc_operation =>
      controlSignal <= "0001000000000001100";
    when dec_operation =>
      controlSignal <= "0001000000000001101";
    when not_operation =>
      controlSignal <= "0001000000000001111";
    when mov_operation =>
      controlSignal <= "0001000000000001110";
    when add_operation =>
      controlSignal <= "0001000000000000111";
    when iadd_operation =>
      controlSignal <= "0001001000000000111";
    when sub_operation =>
      controlSignal <= "0001000000000000001";
    when and_operation =>
      controlSignal <= "0001000000000000010";
    when or_operation =>
      controlSignal <= "0001000000000000011";
    when push_operation =>
      controlSignal <= "0000010001001001010";
    when pop_operation =>
      controlSignal <= "0011100001000101010";
    when ldm_operation =>
      controlSignal <= "0001001000000001000";
    when ldd_operation =>
      controlSignal <= "0011100000000001110";
    when std_operation =>
      controlSignal <= "0000010000000001000";
    when jz_operation =>
      controlSignal <= "0000000010000001010";
    when jc_operation =>
      controlSignal <= "0000000010000011010";
    when jmp_operation =>
      controlSignal <= "0000000100000001010";
    when call_operation =>
      controlSignal <= "0000000101001011010";
    when ret_operation =>
      controlSignal <= "0000100001010101010";
    when rti_operation =>
      controlSignal <= "1000100001000001010";
    when int_operation =>
      controlSignal <= "0100000001001001010";
    when others =>
      controlSignal <= "0000000000000000000";
  end case;

end if;
end process;
    WB <= controlSignal(15);
    memRead <= controlSignal(14);
    memWrite <= controlSignal(13);
    EX <= controlSignal(12);
    SP <= controlSignal(9);
    push <= controlSignal(6);
    pop <= controlSignal(5);
    ALU_selection<= controlSignal(3 downto 0);
    branch <= controlSignal(10);
    portFlag<=controlSignal(8);
    returnOI<=controlSignal(7);
    call<=controlSignal(4);
    No_Cond_Branch<=controlSignal(11);
    Men_to_Reg<=controlSignal(16);
    Int<=controlSignal(17);
    Rti<=controlSignal(18);

end arch;