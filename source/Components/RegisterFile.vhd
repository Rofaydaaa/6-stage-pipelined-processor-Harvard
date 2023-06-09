LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;

entity RegisterFile is
    port (
       clk,rst: in std_logic;
       writeReg: in std_logic_vector(2 downto 0); --des
       WB: in std_logic; --enable
       Men_to_reg: in std_logic;
       Rsrc1,Rsrc2: in std_logic_vector(2 downto 0);--adress of src1and2 
       WBvalue: in std_logic_vector(15 downto 0); --value coming back from the WB blobk
       data1,data2: out std_logic_vector(15 downto 0) --output 
       
    );
end RegisterFile;

ARCHITECTURE arch of RegisterFile IS 
component  registerN IS
PORT( clk,rst ,en: IN std_logic;
  d: IN std_logic_vector(15 downto 0);
 q : OUT std_logic_vector(15 downto 0));
END component;

component decoder is 
port(
    writeAdress : in STD_LOGIC_VECTOR(2 downto 0);
    decEN : out STD_LOGIC_VECTOR(7 downto 0);
    en: IN std_logic
);
end component;

TYPE ram_type IS ARRAY(0 TO 7) of std_logic_vector(15 DOWNTO 0);
SIGNAL ram : ram_type;

signal decEN : std_logic_vector(7 downto 0) ;

BEGIN
decoderU : decoder port map (writeReg,decEN,WB);

PROCESS(clk,Rst) IS 
BEGIN
    IF Rst = '1' THEN 
    	ram <= (others=>(others => '0'));
    ELSIF rising_edge(clk) THEN 
    --Write back
        IF WB = '1' OR Men_to_reg='1' THEN
                   ram(to_integer(unsigned(writeReg))) <= WBvalue;
        End if;
    END IF;
END PROCESS;
    -- read data        
        data1 <= ram(to_integer(unsigned(Rsrc1)))when rst <= '0' else (others => '0');
        data2 <= ram(to_integer(unsigned(Rsrc2)))when rst <= '0' else (others => '0');



-- The problem here is that when there is a write back signal available, el code msh bydkhol fi el else w beltaly data1 w data2 msh by3rfo y2ro mn el ram
-- we will fix it by taking data1 and data2 out of else
    -- ELSIF rising_edge(clk) THEN 
    --     --Write back
    --     IF WB = '1' THEN
    --        		ram(to_integer(unsigned(writeReg))) <= WBvalue;
    --     -- read data        
    --     else
    --         data1 <= ram(to_integer(unsigned(Rsrc1)));
    --         data2 <= ram(to_integer(unsigned(Rsrc2)));
    --     End if;

end arch;