library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controlUnit is
    port (
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
        ALU_selection:out std_logic_vector(3 downto 0)
    

    );
end controlUnit;

architecture arch of controlUnit is
    constant nop_operation : std_logic_vector(5 downto 0) := "000001";
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
    signal controlSignal: std_logic_vector(15 downto 0);
begin
    with opcode select
        controlSignal <=
            "0000000000001010" when nop_operation,
            "0000000000000100" when setc_operation,
            "0000000000001010" when clrc_operation,
            "0000000000001110" when out_operation,
            "1000000100001010" when in_operation,
            "1000000000001100" when inc_operation,
            "1000000000001101" when dec_operation,
            "1000000000001111" when not_operation,
            "1000000000001110" when mov_operation,
            "1000000000000000" when add_operation,
            "1001000000000000" when iadd_operation,
            "1000000000000001" when sub_operation,
            "1000000000000010" when and_operation,
            "1000000000000011" when or_operation,
            "0010001001001010" when push_operation,
            "1100001000101010" when pop_operation,
            "1001000000001000" when ldm_operation,
            "1100000000001110" when ldd_operation,
            "0010000000001000" when std_operation,
            "0000010000001010" when jz_operation,
            "0000010000011010" when jc_operation,
            "0000100000001010" when jmp_operation,
            "0000101001011010" when call_operation,
            "0100001010101010" when ret_operation,
            "0100001000001010" when rti_operation,
            "0000000000000000" when others;
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

end arch;