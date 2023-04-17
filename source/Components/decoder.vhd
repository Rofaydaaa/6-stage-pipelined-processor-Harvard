library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity decoder is
port(
    writeAdress : in STD_LOGIC_VECTOR(2 downto 0);
    decEN : out STD_LOGIC_VECTOR(7 downto 0);
    en: IN std_logic
);
end decoder;

architecture bhv of decoder is
begin

PROCESS(en,writeAdress)
begin
    IF(en = '1')THEN
        decEN <= (others => '0');
        case writeAdress is
            when "000" =>
                decEN(0) <= '1';
            when "001" =>
                decEN(1) <= '1';
            when "010" =>
                decEN(2) <= '1';
            when "011" =>
                decEN(3) <= '1';
            when "100" =>
                decEN(4) <= '1';
            when "101" =>
                decEN(5) <= '1';
            when "110" =>
                decEN(6) <= '1';
            when "111" =>
                decEN(7) <= '1';
            when others =>
                null;
        end case;
    END IF;
END PROCESS;

end bhv;
