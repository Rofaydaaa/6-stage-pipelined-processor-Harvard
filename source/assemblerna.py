
import string

opCodes = {
    "NOP": "000000",
    "SETC": "000010",
    "CLRC": "000011",
    "OUT": "000100",
    "IN": "000101",
    "INC": "000110",
    "DEC": "000111",
    "NOT": "001000",
    "MOV": "001001",
    "ADD": "001010",
    "IADD": "001011",
    "SUB": "001100",
    "AND": "001101",
    "OR": "001110",
    "PUSH": "001111",
    "POP": "010000",
    "LDM": "010001",
    "LDD": "010010",
    "STD": "010011",
    "JZ": "010100",
    "JC": "010101",
    "JMP": "010110",
    "CALL": "010111",
    "RET": "011000",
    "RTI": "011001"
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
# instruction types
noOperandinst = ["NOP", "SETC", "CLRC", "RET", "RTI"]
oneOperandinst = ["OUT", "IN", "PUSH", "POP", "JZ", "JC", "JMP", "CALL"]
twoOperandinst = ["NOT", "INC", "DEC", "MOV", "LDM", "LDD", "STD"]
threeOperandinst = ["ADD", "IADD", "SUB", "AND", "OR"]

# .org 1
# 100
# .org 100
# INC
# IN
# ADD

# didn't add yet the reset and interupt signals into a certain category
# to add inside the instructions correctly after the main function to be written into the .mem file later
correctInstructions = []


def mainfunc():

    for i in range(65536):
        correctInstructions.append("0000000000000000")

    file = input("Enter your fileName: ")  # test cases given file name
    # assuming .org 2 if not specified
    index = 2
    with open(file, 'r') as f:
        for line in f:  # enumerate over each line

            # line clean up
            if line == '\n':
                continue
            line = line.replace(',', ' ')
            words = line.split()

            if len(words) == 0:
                continue

            if (words[0] == ".org"):
                index = int(words[1], 16)  # convert from hexa to decimal
            elif (words[0] in noOperandinst):
                if words[0] in opCodes:
                    correctInstructions[index] = opCodes[words[0]]+"0000000000"
                    index += 1
                else:
                    # handle the case where the key does not exist
                    pass

            elif (words[0] in oneOperandinst):
                if (words[0] == "IN" or words[0] == "POP"):
                    if words[1] in registers:
                        correctInstructions[index] = opCodes[words[0]
                                                             ]+"000000"+registers[words[1]]+"0"
                        index += 1
                    else:
                        # handle the case where the key does not exist
                        pass
                elif (words[0] == "OUT" or words[0] == "PUSH"):
                    if words[1] in registers:
                        correctInstructions[index] = opCodes[words[0]
                                                             ]+registers[words[1]]+"0000000"
                        index += 1
                    else:
                        # handle the case where the key does not exist
                        pass

                elif (words[0] == "JZ" or words[0]

                        == "JC" or words[0] == "JMP" or words[0] == "CALL"):
                    if words[1] in registers:
                        correctInstructions[index] = opCodes[words[0]
                                                             ]+registers[words[1]]+"0000000"
                        index += 1
                    else:
                        # handle the case where the key does not exist
                        pass

            elif (words[0] in twoOperandinst):
                if (words[0] == "NOT" or words[0] == "INC" or words[0] == "DEC" or words[0] == "MOV" or words[0] == "LDD"):
                    if words[1] in registers and words[2] in registers:
                        correctInstructions[index] = opCodes[words[0]] + \
                            registers[words[2]]+"000"+registers[words[1]]+"0"
                        index += 1
                    else:
                        # handle the case where the key does not exist
                        pass
                elif (words[0] == "LDM"):
                    if words[1] in registers:
                        correctInstructions[index] = opCodes[words[0]
                                                             ]+"XXXXXX"+registers[words[1]]+"0"
                        index += 1
                        if len(words) > 2:
                            correctInstructions[index] = bin(
                                int(words[2], 16))[2:].zfill(16)
                            index += 1

                elif (words[0] == "STD"):
                    if words[1] in registers and words[2] in registers:
                        correctInstructions[index] = opCodes[words[0]] + \
                            registers[words[2]]+registers[words[1]]+"0000"
                        index += 1
                    else:
                        # handle the case where the key does not exist
                        pass

            elif (words[0] in threeOperandinst):
                if (words[0] == "ADD" or words[0] == "SUB" or words[0] == "AND" or words[0] == "OR"):
                    if words[1] in registers and words[2] in registers and words[3] in registers:
                        correctInstructions[index] = opCodes[words[0]] + \
                            registers[words[2]]+registers[words[3]] + \
                            registers[words[1]]+"0"
                        index += 1
                    else:
                        # handle the case where the key does not exist
                        pass

                elif (words[0] == "IADD"):
                    if words[1] in registers and words[2] in registers:
                        correctInstructions[index] = opCodes[words[0]] + \
                            registers[words[2]]+"000"+registers[words[1]]+"0"
                        index += 1
                        if len(words) > 3:
                            correctInstructions[index] = bin(
                                int(words[3], 16))[2:].zfill(16)
                            index += 1

            elif (all(c in string.hexdigits for c in words[0])):
                correctInstructions[index] = bin(
                    int(words[0], 16))[2:].zfill(16)
                index += 1
    generateMemFile()


def generateMemFile():
    with open("output.mem", 'w') as f:
        f.write(
            "// memory data file (do not edit the following line - required for mem load use)\n")
        f.write("// instance=/integeration/F/Instruction_Mem0/ram\n")
        f.write(
            "// format=mti addressradix=h dataradix=s version=1.0 wordsperline=65536\n")
        f.write("00000000: ")
        for i in range(len(correctInstructions)):
            f.write(correctInstructions[i] + " ")


mainfunc()
