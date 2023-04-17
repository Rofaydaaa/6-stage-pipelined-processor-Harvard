LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;

entity registerFile is
    port (
       clk,rst: in std_logic;
       writeReg: in std_logic_vector(2 downto 0); --des
       WB: in std_logic; --enable
       Rsrc1,Rsrc2: in std_logic_vector(2 downto 0);--adress of src1and2 
       WBvalue: in std_logic_vector(15 downto 0); --value coming back from the WB blobk
       data1,data2: out std_logic_vector(15 downto 0) --output 
       
    );
end registerFile;

ARCHITECTURE arch of registerFile IS 
component registerN is 
PORT( clk,rst ,en: IN std_logic;
  d: IN std_logic_vector(15 downto 0);
  q : OUT std_logic_vector(15 downto 0));
end component;

component decoder is 
port(
    writeAdress : in STD_LOGIC_VECTOR(2 downto 0);
    decEN : out STD_LOGIC_VECTOR(7 downto 0);
    en: IN std_logic
);
end component;
signal wire1,wire2,wire3,wire4,wire5,wire6,wire7,wire8:  std_logic_vector(15 downto 0) ;
signal decEN : std_logic_vector(7 downto 0) ;

BEGIN
decoderU : decoder port map (writeReg,decEN,WB);

U1: registerN port map (clk,rst,decEN(0),WBvalue,wire1);
U2: registerN port map (clk,rst,decEN(1),WBvalue,wire2);
U3: registerN port map (clk,rst,decEN(2),WBvalue,wire3);
U4: registerN port map (clk,rst,decEN(3),WBvalue,wire4);
U5: registerN port map (clk,rst,decEN(4),WBvalue,wire5);
U6: registerN port map (clk,rst,decEN(5),WBvalue,wire6);
U7: registerN port map (clk,rst,decEN(6),WBvalue,wire7);
U8: registerN port map (clk,rst,decEN(7),WBvalue,wire8);

data1<= wire1 when Rsrc1 ="000" else
        wire2 when Rsrc1 ="001" else
        wire3 when Rsrc1 ="010" else
        wire4 when Rsrc1 ="011" else
        wire5 when Rsrc1 ="100" else
        wire6 when Rsrc1 ="101" else
        wire7 when Rsrc1 ="110" else
        wire8 when Rsrc1 ="111" ;

data2<= wire1 when Rsrc2 ="000" else
        wire2 when Rsrc2 ="001" else
        wire3 when Rsrc2 ="010" else
        wire4 when Rsrc2 ="011" else
        wire5 when Rsrc2 ="100" else
        wire6 when Rsrc2 ="101" else
        wire7 when Rsrc2 ="110" else
        wire8 when Rsrc2 ="111" ;

end arch;