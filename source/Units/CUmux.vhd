library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CUmux is
    port (
        stopCU: in std_logic;
        push: in std_logic;
        pop: in std_logic;
        SP: in std_logic;
        WB: in std_logic;
        memRead: in std_logic;
        memWrite: in std_logic;
        EX: in std_logic;
        branch: in std_logic;
        portFlag: in std_logic;
        returnOI: in std_logic;
        call: in std_logic;
        No_Cond_Branch: in std_logic;
        Men_to_Reg: in std_logic;
        Int: in std_logic;
        Ret: in std_logic;
        ALU_selection: in std_logic_vector(3 downto 0);

        pushout: out std_logic;
        popout: out std_logic;
        SPout: out std_logic;
        WBout: out std_logic;
        memReadout: out std_logic;
        memWriteout: out std_logic;
        EXout: out std_logic;
        branchout: out std_logic;
        portFlagout: out std_logic;
        returnOIout: out std_logic;
        callout: out std_logic;
        No_Cond_Branchout: out std_logic;
        Men_to_Regout: out std_logic;
        Intout: out std_logic;
        Retout: out std_logic;
        ALU_selectionout: out std_logic_vector(3 downto 0)
    );
end CUmux;

architecture arch of CUmux is
begin
    process(stopCU, push, pop, SP, WB, memRead, memWrite, EX, branch, portFlag, returnOI, call, No_Cond_Branch, Men_to_Reg, Int, Ret, ALU_selection)
    begin
        if stopCU = '1' then 
            pushout <= '0';
            popout <= '0';
            SPout <= '0';
            WBout <= '0';
            memReadout <= '0';
            memWriteout <= '0';
            EXout <= '0';
            branchout <= '0';
            portFlagout <= '0';
            returnOIout <= '0';
            callout <= '0';
            No_Cond_Branchout <= '0';
            Men_to_Regout <= '0';
            Intout <= '0';
            Retout <= '0';
            ALU_selectionout <= (others => '0');
        elsif stopCU = '0' then 
            pushout <= push;
            popout <= pop;
            SPout <= SP;
            WBout <= WB;
            memReadout <= memRead;
            memWriteout <= memWrite;
            EXout <= EX;
            branchout <= branch;
            portFlagout <= portFlag;
            returnOIout <= returnOI;
            callout <= call;
            No_Cond_Branchout <= No_Cond_Branch;
            Men_to_Regout <= Men_to_Reg;
            Intout <= Int;
            Retout <= Ret;
            ALU_selectionout <= ALU_selection;
        end if;
    end process;
end arch;