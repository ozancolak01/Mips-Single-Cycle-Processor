`define DELAY 20
module control_unit_testbench(); 
	wire memToReg, memWrite, aluSrc, rType, regWr, regDst, beq, bne, jump, li, zeroExtend;
	
	wire [2:0] toAlu;
	reg [5:0] op;

	
	control_unit test(
		op,
		memToReg,
		memWrite,
		aluSrc,
		toAlu,
		rType,
		regWr,
		regDst,
		beq,
		bne,
		jump,
		li
	);

	
	//000000 - RType (add,sub,jr,and,or,sll,srl,slt)
	//000000 - rType	- 000
	//001101	- ori		- 001 -> OR (101)
	//001000 - addi	- 010 -> ADD (000)
	//100011 - lw		- 010 -> ADD (000)
	//101011 - sw		- 010 -> ADD (000)
	//010000 - li		- 011 -> ADD? (000)
	//000100 - beq		- 100 -> SUB (001)
	//000101 - bne		- 100 -> SUB (001)
	//000010 - j		- 101 -> JR (011)
	//000011 - jal		- 101 -> JR (011)
	//001100 - andi	- 110 -> AND (100)
	//001010	- slti	- 111 -> SLT (111)
	
	initial
		begin
			op=6'b000000; //RType
			#`DELAY;
			op=6'b001101; //ori	- 001
			#`DELAY;
			op=6'b001000; //addi	- 010
			#`DELAY;
			op=6'b100011; //lw	- 010
			#`DELAY;
			op=6'b101011; //sw	- 010
			#`DELAY;
			op=6'b010000; //li	- 011
			#`DELAY;
			op=6'b000100; //beq	- 100
			#`DELAY;
			op=6'b000101; //bne	- 100
			#`DELAY;
			op=6'b000010; //j		- 101
			#`DELAY;
			op=6'b000011; //jal	- 101
			#`DELAY;
			op=6'b001100; //andi	- 110
			#`DELAY;
			op=6'b001010; //slti	- 111
			#`DELAY;
			$stop;
		end
 
	initial
		begin
			$monitor("time = %2d, op=%6b,memWrite=%d,aluSrc=%d,toAlu=%3b,rType=%d,regWr=%d,regDst=%d,beq=%d,bne=%d,jump=%d,li=%d", 
		$time, 
		op ,
		memWrite,
		aluSrc,
		toAlu,
		rType,
		regWr,
		regDst,
		beq,
		bne,
		jump,
		li);
		end
 
endmodule