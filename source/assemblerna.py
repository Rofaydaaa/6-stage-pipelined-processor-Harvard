opCodes={
"NOP":"000001",
"SETC":"000010",
"CLRC":"000011",
"OUT":"000100",
"IN":"000101",
"INC":"000110",
"DEC":"000111",
"NOT":"001000",
"MOV":"001001",
"ADD":"001010",
"IADD":"001011",
"SUB":"001100",
"AND":"001101",
"OR":"001110",
"PUSH":"001111",
"POP":"010000",
"LDM":"010001",
"LDD":"010010",
"STD":"010011",
"JZ":"010100",
"JC":"010101",
"JMP":"010110",
"CALL":"010111",
"RET":"011000",
"RTI":"011001"
}

registers = {
    "R0": "000",
    "R1": "001",
    "R2": "010",
    "R3": "011",
    "R4": "100",
    "R5": "101",
    "R6": "110",
    "R7": "111"
}
#instruction types 
noOperandinst=["Not","SETC","CLRC","RET","RTI"]
oneOperandinst=["OUT","IN","PUSH","POP","JZ","JC","JMP","CALL"]
twoOperandinst=["NOT","INC","DEC","MOV","LDM","LDD","STD"]
threeOperandinst=["ADD","IADD","SUB","AND","OR"]

#didn't add yet the reset and interupt signals into a certain category
correctInstructions=[] #to add inside the instructions correctly after the main function to be written into the .mem file later
def mainfunc():
    file = input("Enter your fileName: ") #test cases given file name
    with open(file, 'r') as f: 
     for line in f: #inumerate over each line
        words = line.split()  # split line into separate words
        if (words[0]in noOperandinst):
           correctInstructions.append(opCodes[words[0]]+"0000000000")
           

        elif (words[0]in oneOperandinst):
           if(words[0]=="IN" or words[0]=="POP" or words[0]=="JZ" or words[0]=="JC" or words[0]=="JMP" or words[0]=="CALL"):
               correctInstructions.append(opCodes[words[0]]+"000000"+registers[words[1]]+"0")
           elif(words[0]=="OUT" or words[0]=="PUSH"):
               correctInstructions.append(opCodes[words[0]]+registers[words[1]]+"0000000")

           

        elif (words[0]in twoOperandinst):
           if(words[0]=="NOT" or words[0]=="INC" or words[0]=="DEC" or words[0]=="MOV" or words[0]=="LDD"):
               correctInstructions.append(opCodes[words[0]]+registers[words[2]]+"000"+registers[words[1]]+"0")
           elif(words[0]=="LDM"):
              correctInstructions.append(opCodes[words[0]]+"000000"+registers[words[1]])
              scale = 16 ## equals to hexadecimal
              num_of_bits = 16
              correctInstructions.append(bin(int(words[2], scale))[2:].zfill(num_of_bits))
              
           elif(words[0]=="STD"):
              correctInstructions.append(opCodes[words[0]]+registers[words[1]]+registers[words[2]]+"0000")
              
           

        elif (words[0]in threeOperandinst):
           if(words[0]=="ADD" or words[0]=="SUB" or words[0]=="AND" or words[0]=="OR"):
              correctInstructions.append(opCodes[words[0]]+registers[words[2]]+registers[words[3]]+registers[words[1]]+"0")
           elif(words[0]=="IADD"):
              correctInstructions.append(opCodes[words[0]]+registers[words[2]]+"000"+registers[words[1]]+"0")
              scale = 16 ## equals to hexadecimal
              num_of_bits = 16
              correctInstructions.append(bin(int(words[3], scale))[2:].zfill(num_of_bits))
              
              
        elif (words[0]=="#"): #case of comments to skip
           continue
           

        elif (words[0]==".ORG"): #case of comments to skip
           


           


        

