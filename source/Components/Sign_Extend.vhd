LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY Sign_Extend IS
PORT( 
    in_signal : in std_logic_vector(2 downto 0);
    out_signal : out std_logic_vector(15 downto 0)
);
END Sign_Extend;

ARCHITECTURE arch OF Sign_Extend IS
begin
    process(in_signal)
    begin
        case in_signal is
            when "000" =>
                out_signal <= (others => '0');  
            when "001" =>
                out_signal <= "0000000000000001";  
            when "010" =>
                out_signal <= "0000000000000010";  
            when "011" =>
                out_signal <= "0000000000000011";  
            when "100" =>
                out_signal <= "0000000000000100";  
            when "101" =>
                out_signal <= "0000000000000101";  
            when "110" =>
                out_signal <= "0000000000000110";  
            when "111" =>
                out_signal <= "0000000000000111";
            when others =>
                out_signal <= (others => '0');
        end case;
    end process;
END arch;
