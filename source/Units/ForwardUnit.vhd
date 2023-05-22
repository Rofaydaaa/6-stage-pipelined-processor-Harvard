--  string s = "Roufy was here, coding in peace <3 <3";
--  string deleteIt = "coding";
--  size_t pos = str.find(deleteIt);
--  s.replace(pos, deleteIt.length(), "crying");
--  cout<<s;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ForwardUnit is
    port (
      
    memReadDE: in std_logic;
    --Addresses coming from buffers that need to be compared
    DE_RSrc1:IN std_logic_vector(2 DOWNTO 0);
    DE_RSrc2:IN std_logic_vector(2 DOWNTO 0);
    EM1_Dest:IN std_logic_vector(2 DOWNTO 0);
    M1M2_Dest:IN std_logic_vector(2 DOWNTO 0);
    M2WB_Dest:IN std_logic_vector(2 DOWNTO 0);


    --Input control signals that need to be accompanied with the addresses comming from buffers
    EM1_WB_Control:IN std_logic;
    M1M2_WB_Control:IN std_logic;
    M1M2_memWrite_Control:IN std_logic;
    M1M2_memRead_Control:IN std_logic;
    M2WB_WB_Control:IN std_logic;

    --We need also to pass the inport control signal of every flag
    EM1_INPort_Control:IN std_logic;
    M1M2_INPort_Control:IN std_logic;
    M2WB_INPort_Control:IN std_logic;

    --Immidiate control signal needed for setting FRWD__OUT_S2 too
    DE_Imm_Control:IN std_logic;

    --Outputs:
    FRWD_OUT_S1 : OUT std_logic_vector(2 DOWNTO 0); --selector of muxDataA (the A of the ALU)
    FRWD_OUT_S2 : OUT std_logic_vector(2 DOWNTO 0) --selector of muxDataB (the A of the ALU)
    );
end ForwardUnit;

architecture arch of ForwardUnit is

    begin
   
    FRWD_OUT_S1 <= "011" WHEN ((DE_RSrc1 = EM1_Dest) and (EM1_INPort_Control = '1'))  -- -- Forward Inport From EM1 buffer
		ELSE "101" WHEN ((DE_RSrc1 = M1M2_Dest) and (M1M2_INPort_Control = '1')) -- Forward Inport From M1M2 buffer
		ELSE "111" WHEN ((DE_RSrc1 = M2WB_Dest) and (M2WB_INPort_Control = '1')) -- Forward Inport From M2WB buffer
    ELSE "010" WHEN ((DE_RSrc1 = EM1_Dest) and (EM1_WB_Control = '1')) and (memReadDE='0') -- Forward data From EM1 buffer
		ELSE "100" WHEN ((DE_RSrc1 = M1M2_Dest) and (M1M2_WB_Control = '1') and (M1M2_memWrite_Control = '1') and (M1M2_memRead_Control = '1')) -- Forward data From M1M2 buffer
		ELSE "110" WHEN ((DE_RSrc1 = M2WB_Dest) and (M2WB_WB_Control = '1')) --  Forward data From M2WB buffer
		ELSE "000" ;  --Read the default Which is Data1

    FRWD_OUT_S2 <= "011" WHEN ((DE_RSrc2 = EM1_Dest) and(EM1_INPort_Control = '1'))  -- -- Forward Inport From EM1 buffer
		ELSE "101" WHEN ((DE_RSrc2 = M1M2_Dest) and (M1M2_INPort_Control = '1')) -- Forward Inport From M1M2 buffer
		ELSE "111" WHEN ((DE_RSrc2 = M2WB_Dest) and (M2WB_INPort_Control = '1')) -- Forward Inport From M2WB buffer
    ELSE "010" WHEN ((DE_RSrc2 = EM1_Dest) and (EM1_WB_Control = '1') and (memReadDE='0') ) -- Forward data From EM1 buffer
		ELSE "100" WHEN ((DE_RSrc2 = M1M2_Dest) and (M1M2_WB_Control = '1') and (M1M2_memWrite_Control = '1') and (M1M2_memRead_Control = '1')) -- Forward data From M1M2 buffer
		ELSE "110" WHEN ((DE_RSrc2 = M2WB_Dest) and (M2WB_WB_Control = '1')) --  Forward data From M2WB buffer
    ELSE "001" WHEN (DE_Imm_Control = '1') --Read the immidiate value okay
		ELSE "000";  --Read the default Which is Data2

end arch;
