library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY Decode IS
PORT (
  outputPCint:in std_logic_vector(15 downto 0);
  forCallWB : in std_logic_vector(15 downto 0);
  callWB:IN std_logic;
  stopCU: IN std_logic;
clk,Rst,en: IN std_logic; --en is the WB from WBM
interuptSignal: in std_logic;
reg_to_regin:IN std_logic;
Instruction_After: in std_logic_vector (31 downto 0);
writeReg: in std_logic_vector(2 downto 0); --des
WBvalue: in std_logic_vector(15 downto 0); --value coming back from the WB blobk
flushSignal: in std_logic; --unhandled yet

forCallinput : in std_logic_vector(15 downto 0);
IN_Port: in STD_LOGIC_VECTOR(15 downto 0);
--OUTS
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
  Men_to_Reg:out std_logic;
  Int:out std_logic;
  Rti:out std_logic;
  ALU_selection:out std_logic_vector(3 downto 0);
  data1,data2:out std_logic_vector(15 downto 0);
  rdst: out std_logic_vector(2 downto 0);
  restOfInstruction_After:out std_logic_vector(15 downto 0);
  Rsrc1,Rsrc2: out std_logic_vector(2 downto 0);--adress of src1 and src2 
  memoryWire : out std_logic_vector(15 downto 0);
  forCall : out std_logic_vector(15 downto 0);
  IN_Portsout: out STD_LOGIC_VECTOR(15 downto 0);

  memRead_CU: out std_logic;
  memWrite_CU: out std_logic;
  callMuxout: out STD_LOGIC_VECTOR(15 downto 0)
);
END  Decode;

ARCHITECTURE arch OF Decode IS


----------------------------------------------------------------------------------------------------------
-------------------------------------------Start Components-------------------------------------------------
----------------------------------------------------------------------------------------------------------
COMPONENT controlUnit is
  port (
      interuptSignal: in std_logic;
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
        Men_to_Reg:out std_logic;
        Int:out std_logic;
        Rti:out std_logic;

        ALU_selection:out std_logic_vector(3 downto 0)
    

  );
end COMPONENT;

COMPONENT registerFile is
  port (
     clk,rst: in std_logic;
     writeReg: in std_logic_vector(2 downto 0); --des
     WB: in std_logic; --enable
     Men_to_reg:IN std_logic;
     Rsrc1,Rsrc2: in std_logic_vector(2 downto 0);--adress of src1and2 
     WBvalue: in std_logic_vector(15 downto 0); --value coming back from the WB blobk
     data1,data2: out std_logic_vector(15 downto 0) --output 
     
  );
end COMPONENT;
COMPONENT CallMUX is
  port (
    forCall: IN std_logic_vector(15 DOWNTO 0);
    PCforINT: IN std_logic_vector(15 DOWNTO 0);
    call: IN std_logic;
    output: OUT std_logic_vector(15 DOWNTO 0)
     
  );
end COMPONENT;

COMPONENT CUmux is
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
end COMPONENT;

COMPONENT Decode_Excute_Buffer IS

PORT( callMux:in std_logic_vector(15 downto 0);
clk,rst,en: std_logic;
push: in std_logic;
pop: in std_logic;
SP: in std_logic;
WB: in std_logic;
memRead: in std_logic;
memWrite: in std_logic;
EX:in std_logic;
branch:in std_logic;
portFlag:in std_logic;
returnOI:in std_logic;
call:in std_logic;
No_Cond_Branch:in std_logic;
Men_to_Reg:in std_logic;
Int:in std_logic;
------------------ new wires---------------------------
 Rti:in std_logic;
 Rsrc1,Rsrc2: in std_logic_vector(2 downto 0);--adress of src1 and src2 
 memoryWire : in std_logic_vector(15 downto 0);
 forCall : in std_logic_vector(15 downto 0);
 flushSignal: in std_logic; --unhandled yet

 IN_Ports: IN STD_LOGIC_VECTOR(15 downto 0);
-------------------------------------------------
ALU_selection:in std_logic_vector(3 downto 0);
data1,data2: in std_logic_vector(15 downto 0) ;
rdst: in std_logic_vector(2 downto 0); 
restofIR: in  std_logic_vector(15 downto 0); 

------------------------------------------------------------------
pushout: out std_logic;
popout: out std_logic;
SPout: out std_logic;
WBout: out std_logic;
memReadout: out std_logic;
memWriteout: out std_logic;
EXout:out std_logic;
branchout:out std_logic;
portFlagout:out std_logic;
returnOIout:out std_logic;
callout:out std_logic;
No_Cond_Branchout:out std_logic;
Men_to_Regout:out std_logic;
Intout:out std_logic;
------------------ new wires---------------------------
 Rtiout:out std_logic;
 Rsrc1out,Rsrc2out: out std_logic_vector(2 downto 0);--adress of src1 and src2 
 memoryWireout : out std_logic_vector(15 downto 0);
 forCallout : out std_logic_vector(15 downto 0);
 IN_Portsout: out STD_LOGIC_VECTOR(15 downto 0);
-------------------------------------------------

ALU_selectionout:out std_logic_vector(3 downto 0);
data1out,data2out: out std_logic_vector(15 downto 0); 
rdstout: out std_logic_vector(2 downto 0); 
restofIRout: out  std_logic_vector(15 downto 0) ;
callMuxout:out std_logic_vector(15 downto 0)
);
END COMPONENT;

----------------------------------------------------------------------------------------------------------
-------------------------------------------End Components-------------------------------------------------
----------------------------------------------------------------------------------------------------------

signal pushwire,popwire,SPwire,WBwire,memReadwire,memWritewire,EXwire,branchwire,portFlagwire,returnOIwire,callwire,No_Cond_Branchwire, Men_to_Regwire,Intwire,Rtiwire:std_logic;
signal ALU_selectionwire : std_logic_vector(3 downto 0);

signal pushwiremux,popwiremux,SPwiremux,WBwiremux,memReadwiremux,memWritewiremux,EXwiremux,branchwiremux,portFlagwiremux,returnOIwiremux,callwiremux,No_Cond_Branchwiremux, Men_to_Regwiremux,Intwiremux,Rtiwiremux:std_logic;
signal ALU_selectionwiremux : std_logic_vector(3 downto 0);

signal data1wire,data2wire : std_logic_vector(15 downto 0);
signal callMuxoutwire: std_logic_vector(15 downto 0);
BEGIN

CU : controlUnit port map (interuptSignal,Instruction_After(31 downto 26),pushwire,popwire,SPwire,WBwire,memReadwire,memWritewire,EXwire,branchwire,portFlagwire,returnOIwire,callwire,No_Cond_Branchwire, Men_to_Regwire,Intwire,Rtiwire ,ALU_selectionwire);
callloop: CallMUX port map(forCallWB,outputPCint,callWB,callMuxoutwire);
cumuxloop : CUmux port map (stopCU,pushwire,popwire,SPwire,WBwire,memReadwire,memWritewire,EXwire,branchwire,portFlagwire,returnOIwire,callwire,No_Cond_Branchwire, Men_to_Regwire,Intwire,Rtiwire ,ALU_selectionwire,pushwiremux,popwiremux,SPwiremux,WBwiremux,memReadwiremux,memWritewiremux,EXwiremux,branchwiremux,portFlagwiremux,returnOIwiremux,callwiremux,No_Cond_Branchwiremux, Men_to_Regwiremux,Intwiremux,Rtiwiremux ,ALU_selectionwiremux);



RF : registerFile port map (clk,rst,writeReg,en,reg_to_regin,Instruction_After(25 downto 23),Instruction_After(22 downto 20),WBvalue,data1wire,data2wire);
buff: Decode_Excute_Buffer port map (callMuxoutwire,clk,rst,'1',pushwiremux,popwiremux,SPwiremux,WBwiremux,memReadwiremux,memWritewiremux,EXwiremux,branchwiremux,portFlagwiremux,returnOIwiremux,callwiremux,No_Cond_Branchwiremux, Men_to_Regwiremux,Intwiremux,Rtiwiremux,Instruction_After(25 downto 23),Instruction_After(22 downto 20),Instruction_After(31 downto 16),forCallinput,flushSignal,IN_Port, ALU_selectionwiremux,data1wire,data2wire,Instruction_After(19 downto 17),Instruction_After(15 downto 0)
,push,pop,SP,WB,memRead,memWrite,EX,branch,portFlag,returnOI,call,No_Cond_Branch, Men_to_Reg,Int,Rti,Rsrc1,Rsrc2,memoryWire, forCall,IN_Portsout,ALU_selection,data1,data2,rdst, restOfInstruction_After,callMuxout);

memRead_CU <= memReadwire;
memWrite_CU <=memWritewire;
END arch;