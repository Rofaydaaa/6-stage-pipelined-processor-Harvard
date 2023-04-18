LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Execute IS
  GENERIC (n : INTEGER := 16);
  PORT (
    rst : IN STD_LOGIC;
    Data1, Data2 : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
    Immediate : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);

    --Input Control signals
    sel : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    EX : IN STD_LOGIC;
    Branch : IN STD_LOGIC;
    No_Cond_Jump : IN STD_LOGIC;

    --Output Control signals
    PC_Source : OUT STD_LOGIC;
    DataOut : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0)
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

    COMPONENT Mux2by1 IS 
	Generic ( n : Integer:=16);
	PORT ( in0,in1 : IN std_logic_vector (n-1 DOWNTO 0);
			sel : IN  std_logic;
			out1 : OUT std_logic_vector (n-1 DOWNTO 0));
    END COMPONENT;

    COMPONENT SET_CCR IS
    GENERIC (n : INTEGER := 16);
	PORT (
        rst : IN STD_LOGIC;
		NOP_FLAG : IN STD_LOGIC; --This flag should preserve the Value of the flag
        F_ALU : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		Cout_ALU : IN STD_LOGIC;
		FLAG_OUT : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
		);
    END COMPONENT;


----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------END Components---------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------

    SIGNAL B_MUX_OUTPUT : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
    SIGNAL ALU_OUTPUT : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
    SIGNAL C_out : STD_LOGIC;
    SIGNAL NOP_FLAG : STD_LOGIC;
    SIGNAL FLAG_CCR : STD_LOGIC_VECTOR(2 DOWNTO 0);


    BEGIN 

        -- Check if the selectors are "1010" meaning no operation, then the NOP_FLAG is 1, it will keep the previous value of flag
        -- When calling the module of set_ccr
        process(sel)
        begin
            if sel = "1010" then
                NOP_FLAG <= '1';
            else
                NOP_FLAG <= '0';
        end if;
        end process;
    
        select_2nd_operand : Mux2by1 GENERIC MAP(16) PORT MAP(Data2, Immediate, EX, B_MUX_OUTPUT);
        aluu : ALU GENERIC MAP(16) PORT MAP(Data1, B_MUX_OUTPUT, Sel, '0', ALU_OUTPUT, C_out);
        set_CCRM: SET_CCR GENERIC MAP(16) PORT MAP(rst, NOP_FLAG, ALU_OUTPUT, C_out, FLAG_CCR);

        DataOut <= ALU_OUTPUT;
        PC_Source <= (FLAG_CCR(0) and Branch) or (FLAG_CCR(2) and Branch) or No_Cond_Jump;



END IMP_Execute;