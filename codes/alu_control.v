	//Select Inputs:								aluSel
	//INSTRUCTION 	F5 F4 F3 F2 F1 F0		C2 C1 C0
	//-----------	------------------	--------
	//ADD				100000					000#210
	//SUBSTRACT		100010					001#210
	//SRL				000010					010#210
	//JR				001000					011#210
	//AND				100100					100#210
	//OR				100101					101#210
	//SLT				101010					110#210
	//SLL				000000					111#210
	
	//opcode				- aluOP	    	aluSel
	//000000 - rType	- 000
	//001101	- ori		- 001 -> OR		(101)
	//001000 - addi	- 010 -> ADD	(000)
	//100011 - lw		- 010 -> ADD 	(000)
	//101011 - sw		- 010 -> ADD 	(000)
	//010000 - li		- 011 -> ADD? 	(000)
	//000100 - beq		- 100 -> SUB 	(001)
	//000101 - bne		- 100 -> SUB 	(001)
	//000010 - j		- 101 -> JR 	(011)
	//000011 - jal		- 101 -> JR 	(011)
	//001100 - andi	- 110 -> AND 	(100)
	//001010	- slti	- 111 -> SLT 	(111)


module alu_control(
	input [5:0] funct,
	input [2:0] aluOP,
	output [2:0] aluSel);
	
	assign aluSel[2] = (aluOP[2] & aluOP[1] & ~aluOP[0])
								|(~aluOP[2] & ~aluOP[1] & aluOP[0])
								|(aluOP[2] & aluOP[1] & aluOP[0])
								| (funct[0])
								| (funct[5] & funct[3])
								| (~aluOP[2] & ~aluOP[1] & ~aluOP[0] & ~funct[5] & ~funct[3] & ~funct[1])
								| (funct[2] & ~funct[0]);
	
	assign aluSel[1] =	(aluOP[2] & ~aluOP[1] & aluOP[0])
								|(aluOP[2] & aluOP[1] & aluOP[0])
								| (~funct[5] & funct[1])
								| (~funct[5] & funct[3])
								| (funct[5] & funct[3])
								| (~aluOP[2] & ~aluOP[1] & ~aluOP[0] & ~funct[5] & ~funct[3] & ~funct[1]);
	
	assign aluSel[0] =	(aluOP[2] & ~aluOP[1] & ~aluOP[0])
								|(aluOP[2] & ~aluOP[1] & aluOP[0])
								|(aluOP[2] & aluOP[1] & aluOP[0])
								|(~aluOP[2] & ~aluOP[1] & aluOP[0])
								| (funct[0])
								| (funct[3] & ~funct[1])
								| (funct[5] & ~funct[3] & funct[1])
								| (~aluOP[2] & ~aluOP[1] & ~aluOP[0] & ~funct[5] & ~funct[3] & ~funct[1]);
	

endmodule
