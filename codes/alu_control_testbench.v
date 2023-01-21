`define DELAY 20
module alu_control_testbench(); 
	reg [2:0] aluOP;
	reg [5:0] funct;
	wire [2:0] aluSel;
	
	//Select Inputs for R TYPES:			aluSel
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
	
	//opcode	- aluOP	    	aluSel
	//rType	- 000
	//ori		- 001 -> OR		(101)
	//addi	- 010 -> ADD	(000)
	//lw		- 010 -> ADD 	(000)
	//sw		- 010 -> ADD 	(000)
	//li		- 011 -> ADD 	(000)
	//beq		- 100 -> SUB 	(001)
	//bne		- 100 -> SUB 	(001)
	//j		- 101 -> JR 	(011)
	//jal		- 101 -> JR 	(011)
	//andi	- 110 -> AND 	(100)
	//slti	- 111 -> SLT 	(111)
	
	alu_control test(funct,aluOP,aluSel);
	
	initial
		begin
			aluOP=3'b000;funct=6'b100000;
			#`DELAY;
			aluOP=3'b000;funct=6'b100010;
			#`DELAY;
			aluOP=3'b000;funct=6'b100100;
			#`DELAY;
			aluOP=3'b001;funct=6'b000000;
			#`DELAY;
			aluOP=3'b010;funct=6'b000000;
			#`DELAY;
			aluOP=3'b011;funct=6'b000000;
			#`DELAY;
			aluOP=3'b100;funct=6'b000000;
			#`DELAY;
			aluOP=3'b101;funct=6'b000000;
			#`DELAY;
			aluOP=3'b110;funct=6'b000000;
			#`DELAY;
			aluOP=3'b111;funct=6'b000000;
			#`DELAY;

		end
 
	initial
		begin
			$monitor("time = %2d, aluOP=%3b, funct=%6b, aluSel=%3b", $time, aluOP, funct, aluSel);
		end
		
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
 
endmodule

