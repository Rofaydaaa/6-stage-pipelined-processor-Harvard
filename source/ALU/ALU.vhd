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

ENTITY ALU IS
  GENERIC (n : INTEGER := 16);
  PORT (
    A, B : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
    sel : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    cin : IN STD_LOGIC;
    F : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
    cout : OUT STD_LOGIC);
END ALU;

ARCHITECTURE IMP_ALU OF ALU IS
    COMPONENT N_BIT_ADDER IS
    Generic ( n : Integer:=16);
    	PORT (x,y : IN   std_logic_vector (n-1 downto 0);
    	cin: IN std_logic;
    	s: OUT std_logic_vector (n-1 downto 0);
    	cout : OUT std_logic);
    END COMPONENT;

  -- Signals
  -- Make a signal for every Operation selector
  SIGNAL S_add, S_sub, S_inc, S_dec : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
  SIGNAL B_not, B_negative : STD_LOGIC_VECTOR(n - 1 DOWNTO 0); --For (-B)

  SIGNAL C_add, C_sub, C_inc, C_dec, c_B_negative : STD_LOGIC;


BEGIN

    --Get -B to make the subtraction operation
    -- F = A + (-B)
    -- (-B) = not(B) + 1
    B_not <= not B;
    getBnegative : N_BIT_ADDER GENERIC MAP(16) PORT MAP(B_not, x"0001", '0', B_negative, c_B_negative);

    --ALU Operations
    add : N_BIT_ADDER GENERIC MAP(16) PORT MAP(A, B, '0', S_add, C_add);
    sub : N_BIT_ADDER GENERIC MAP(16) PORT MAP(A, B_negative, '0', S_sub, C_sub);
    inc : N_BIT_ADDER GENERIC MAP(16) PORT MAP(A, (OTHERS => '0'), '1', S_inc, C_inc);
    dec : N_BIT_ADDER GENERIC MAP(16) PORT MAP(A, (OTHERS => '1'), '0', S_dec, C_dec);

    -- Set the output and the cout to the suitable values
    -- 1. Reset
    F <= (OTHERS => '0') when sel = "0101"
    -- 2. ADD
        else
        S_add when sel = "0010"
    -- 3. SUB
        else
        S_sub when sel = "0001"
    -- 4. INC
        else
        S_inc when sel = "1100"
    -- 5. DEC
        else
        S_dec when sel = "1101"
    -- 6. MOV
        else
        A when sel = "1110"
    -- 7. NOT
        else
        (not A) when sel = "1111"
    -- 8. AND
        else
        (A and B) when sel = "0010"
    -- 9. OR
        else
        (A or B) when sel = "0011"
    -- 10. SETC --> Set carry flag to 1 and output garbage
        else
        (OTHERS => '0') when sel = "0100"
    -- 11. LDM
        else
        B when sel = "1000"
        else
        (OTHERS => '0');

    -- 1. ADD
    cout <= C_add when sel = "0111"
    -- 2. SUB
        else
        C_sub when sel = "0001"
    -- 3. INC
        else
        C_inc when sel = "1100"
    -- 4. DEC
        else
        C_dec when sel = "1101"
    -- 5. SETC --> Set carry flag to 1 
        else
        '1' when sel = "0100"
    -- 6. CLRC --> set carry flag to 1
        else
        '0' when sel = "0110"   
        else
        cin;

END IMP_ALU;