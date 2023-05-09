----------------------------------------------------------
--  string s = "Roufy was here, coding in peace <3 <3"; --
--  string deleteIt = "od";                             --
--  size_t pos = str.find(deleteIt);                    --
--  s.replace(pos, deleteIt.length(), "ry");            --
--  cout<<s;                                            --
----------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Execute IS
  PORT (
    clk,rst : IN STD_LOGIC;


    -------------------------From decode execute buffer-------------------------------------
    --Inputs Comming from the DE buffer and used in that stage
    DE_Data1, DE_Data2 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    DE_Immediate : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    DE_RSrc1 : IN std_logic_vector(2 DOWNTO 0);
    DE_RSrc2 : IN std_logic_vector(2 DOWNTO 0);
    --Control signals
    DE_SelectionLines : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    DE_Branch : IN STD_LOGIC;
    DE_No_Cond_Jump : IN STD_LOGIC;
    DE_IMM : IN std_logic;
    DE_INT : IN STD_LOGIC;


    ------------------------From Execute memory1 buffer---------------------------------------
    --Control signals
    EM1_WB_MemtoReg:IN std_logic;
    EM1_INPort:IN std_logic;
    --Input Data
    EM1_Dest:IN std_logic_vector(2 DOWNTO 0);
    EM1_DataOut:IN std_logic_vector(15 DOWNTO 0);
    EM1_InPort_Data: IN std_logic_vector(15 DOWNTO 0);
    ------------------------From memory1 memory2 buffer---------------------------------------
    --Control signal
    M1M2_WB_regtoreg:IN std_logic;
    M1M2_memWrite:IN std_logic;
    M1M2_memRead:IN std_logic;
    M1M2_INPort:IN std_logic;
    --Input Data
    M1M2_Dest:IN std_logic_vector(2 DOWNTO 0);
    M1M2_DataOut: IN std_logic_vector(15 DOWNTO 0);
    M1M2_InPort_Data: IN std_logic_vector(15 DOWNTO 0);
    ------------------------From memory2 writeback buffer-------------------------------------
    --Control signal
    M2WB_WB_MemtoReg:IN std_logic;
    M2WB_INPort:IN std_logic;
    M2WB_RTI:IN std_logic; --used with the ccr(handle it later)
    --Input Data
    M2WB_Dest:IN std_logic_vector(2 DOWNTO 0);
    M2WB_DataOut:IN std_logic_vector(15 DOWNTO 0); --M2WB_dataOut and M2WB_Inport, both hdkhlohom el WB_value of WB stage
    M2WB_InPort_Data: IN std_logic_vector(15 DOWNTO 0);

    --Output Control signals
    PC_Source : OUT STD_LOGIC;
    DataOut : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
  );
END Execute;

ARCHITECTURE IMP_Execute OF Execute IS

----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------Start Components-------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------

    COMPONENT ALU IS
    GENERIC (n : INTEGER := 16);
    PORT (
    A, B : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
    sel : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    cin : IN STD_LOGIC;
    F : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
    cout : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT SET_CCR IS
    GENERIC (n : INTEGER := 16);
	PORT (
        clk,rst : IN STD_LOGIC;
		NOP_FLAG, UNCHANGE_CARRY, FIRSTTIME_FLAG : IN STD_LOGIC; --This flag should preserve the Value of the flag or carry flag
        F_ALU : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		Cout_ALU : IN STD_LOGIC;
		FLAG_OUT : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
		);
    END COMPONENT;

    COMPONENT ForwardUnit is
        port (
            
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
    end COMPONENT;

    COMPONENT Mux8by1 IS 
    Generic ( n : Integer:=16);
    PORT ( in0,in1,in2,in3,in4,in5,in6,in7 : IN std_logic_vector (n-1 DOWNTO 0);
            sel : IN std_logic_vector (2 DOWNTO 0);
            out1 : OUT std_logic_vector (n-1 DOWNTO 0));
    END COMPONENT;

----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------END Components---------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------

    SIGNAL Data_A : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL Data_B : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL dummySignal : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL ALU_OUTPUT : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL C_out : STD_LOGIC;
    SIGNAL NOP_FLAG : STD_LOGIC;
    SIGNAL UNCHANGE_CARRY : STD_LOGIC;
    SIGNAL FIRSTTIME_FLAG : STD_LOGIC;
    SIGNAL FLAG_CCR : STD_LOGIC_VECTOR(2 DOWNTO 0);
    sIGNAL FRWD_OUT_S1 : std_logic_vector(2 DOWNTO 0); --selector signals of muxDataA (the A of the ALU)
    sIGNAL FRWD_OUT_S2 : std_logic_vector(2 DOWNTO 0); --selector signal of muxDataB (the A of the ALU)


    BEGIN 

        -- NOP_FLAG indicates the operations that doesn't change IN the CCR
        process(DE_SelectionLines)
        begin
            if DE_SelectionLines = "1010" or DE_SelectionLines = "1110" or DE_SelectionLines = "1000" then
                NOP_FLAG <= '1';
            else
                NOP_FLAG <= '0';
        end if;
        end process;

        -- UNCHANGE_CARRY indicates the operations that doesn't change IN the Carry flag
        --not, or, and
        process(DE_SelectionLines)
        begin
            if DE_SelectionLines = "1111" or DE_SelectionLines = "0010" or DE_SelectionLines = "0011" then
                UNCHANGE_CARRY <= '1';
            else
                UNCHANGE_CARRY <= '0';
        end if;
        end process;

        -- FIRSTTIME_FLAG indicates that this is the first time to run simulation so it will make the flag 0 even if fout = "0000"
    
        process(DE_SelectionLines)
        begin
            if DE_SelectionLines = "0000" then
                FIRSTTIME_FLAG <= '1';
            else
                FIRSTTIME_FLAG <= '0';
        end if;
        end process;



        forwardData : ForwardUnit PORT MAP (DE_RSrc1, DE_RSrc2, EM1_Dest, M1M2_Dest, M2WB_Dest, EM1_WB_MemtoReg, M1M2_WB_regtoreg, M1M2_memWrite, M1M2_memRead, M2WB_WB_MemtoReg, EM1_INPort, M1M2_INPort, M2WB_INPort, DE_IMM, FRWD_OUT_S1, FRWD_OUT_S2);
        
        Data_A_mux : Mux8by1 PORT MAP(DE_Data1, dummySignal, EM1_DataOut, EM1_InPort_Data, M1M2_DataOut, M1M2_InPort_Data, M2WB_DataOut, M2WB_InPort_Data, FRWD_OUT_S1, Data_A);
        
        Data_B_mux : Mux8by1 PORT MAP(DE_Data2, DE_Immediate, EM1_DataOut, EM1_InPort_Data, M1M2_DataOut, M1M2_InPort_Data, M2WB_DataOut, M2WB_InPort_Data, FRWD_OUT_S2, Data_B);
        
        aluu : ALU GENERIC MAP(16) PORT MAP(Data_A, Data_B, DE_SelectionLines, '0', ALU_OUTPUT, C_out);
        
        set_CCRM: SET_CCR GENERIC MAP(16) PORT MAP(clk,rst, NOP_FLAG, UNCHANGE_CARRY, FIRSTTIME_FLAG, ALU_OUTPUT, C_out, FLAG_CCR);
        DataOut <= ALU_OUTPUT;
        PC_Source <= (FLAG_CCR(0) and DE_Branch) or (FLAG_CCR(2) and DE_Branch) or DE_No_Cond_Jump;



END IMP_Execute;
