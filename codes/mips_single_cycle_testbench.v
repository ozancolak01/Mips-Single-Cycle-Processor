`define DELAY 20
module mips_single_cycle_testbench(); 
	reg clk;
	reg fastClk;
	reg [31:0] instruction;
	wire [15:0] aluOut;
	
	//I do that because in analysis synthesis, it gives an error but in modelsim, it does not and I can simulate it.
	//to test this, uncomment instruction and 2 more fields in mips_single_cycle
	mips_single_cycle processor(aluOut, //instruction, 
													fastClk, clk);

	initial begin

		$readmemb("C:/altera/13.1/mips_single_cycle/data.mem", processor.data_mem.mem);
		$readmemb("C:/altera/13.1/mips_single_cycle/reg.mem", processor.reg16.data);
		//add $3, $1 $2 	000000_0001_0010_0011_0000_100000_0000
		
		instruction = 32'b00000000010010001100001000000000;
		clk=1;
		fastClk=1;
		
	end
	
	always begin 
		#20 clk= ~clk;
		#10 fastClk = ~fastClk;
	end	
 
	initial
		begin
			#100
			$writememb("C:/altera/13.1/mips_single_cycle/data.mem",processor.data_mem.mem);
			$writememb("C:/altera/13.1/mips_single_cycle/reg.mem",processor.reg16.data);
			$display("time = %2d,instruction=%32b, rsAddr=%4b, rtAddr=%4b, rwAddr=%4b\n rs=%d, rt=%d, aluResult= %d and rw=%d", $time, processor.instr, processor.reg16.rsAddr, 
																															  processor.reg16.rtAddr, processor.reg16.rwAddr, processor.reg16.rs, processor.reg16.rt,
																															  aluOut, processor.reg16.wData);
			$stop;
		end
endmodule
	
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
