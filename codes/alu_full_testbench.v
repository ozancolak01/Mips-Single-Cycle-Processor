`define DELAY 20

module alu_full_testbench();
	
reg [15:0] a, b;
reg [5:0] func;
reg [3:0] shamt;
reg rType;
reg [2:0] fromContr;

wire [15:0] result;
wire zero;
	
alu_full aluTest(a, b, func, shamt, rType, fromContr, result, zero);

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
	
initial begin

//ADD
//a, b, func, shamt, rType, fromContr
a = 16'h5BF3; b = 16'h0011; fromContr=000; rType=1; shamt=0000; func=100000;
#`DELAY;
a = 16'h0000; b = 16'h5678; fromContr=000; rType=1; shamt=0000; func=100000;
#`DELAY;

//SW LW ADDİ
//a, b, func, shamt, rType, fromContr
a = 16'h5BF3; b = 16'h0011; fromContr=010; rType=0; shamt=0000; func=000000;
#`DELAY;
a = 16'h0000; b = 16'h5678; fromContr=010; rType=0; shamt=0000; func=000000;
#`DELAY;

//SUB
a = 16'hAF23; b = 16'h0023; fromContr=000; rType=1; shamt=0000; func=100010;
#`DELAY;
a = 16'hFFFF; b = 16'hFFFF; fromContr=000; rType=1; shamt=0000; func=100010;
#`DELAY;

//BEQ BNE
a = 16'hAF23; b = 16'h0022; fromContr=100; rType=0; shamt=0000; func=000000;
#`DELAY;
a = 16'hFFFF; b = 16'hFFFF; fromContr=100; rType=0; shamt=0000; func=000000;
#`DELAY;

//SRL
a = 16'h0001; b = 16'h0002; fromContr=000; rType=1; shamt=0001; func=000010;
#`DELAY;
a = 16'h0002; b = 16'h0007; fromContr=000; rType=1; shamt=0002; func=000010;
#`DELAY;

//ADD
a = 16'h5BF3; b = 16'h0011; fromContr=000; rType=1; shamt=0000; func=100000;
#`DELAY;
a = 16'h0000; b = 16'h5678; fromContr=000; rType=1; shamt=0000; func=100000;
#`DELAY;

//AND
a = 16'h0000; b = 16'h1234; fromContr=000; rType=1; shamt=0000; func=100100;
#`DELAY;
a = 16'h2ABF; b = 16'h2ABF; fromContr=000; rType=1; shamt=0000; func=100100;
#`DELAY;

//OR
a = 16'h0000; b = 16'h1234; fromContr=000; rType=1; shamt=0000; func=100101;
#`DELAY;
a = 16'h2ABF; b = 16'h2ABF; fromContr=000; rType=1; shamt=0000; func=100101;
#`DELAY;

//SLT
a = 16'h3BFC; b = 16'h4212; fromContr=000; rType=1; shamt=0000; func=101010;
#`DELAY;
a = 16'h000F; b = 16'h0001; fromContr=000; rType=1; shamt=0000; func=101010;
#`DELAY;

//SLL
a = 16'h0001; b = 16'h0002; fromContr=000; rType=1; shamt=0001; func=000000;
#`DELAY;
a = 16'h0002; b = 16'h0007; fromContr=000; rType=1; shamt=0002; func=000000;
#`DELAY;



end

initial
begin

$monitor("Results: time= %2d, a= %8h, b= %8h, result= %8h, fromContr= %3b, func= %6b, rType= %1b, shamt= %4b, zero= %1b", $time, a, b, result, 
																																					fromContr, func, rType, shamt, zero);
end
 

endmodule
