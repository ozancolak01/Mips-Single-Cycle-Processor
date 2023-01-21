module alu_full(
	input [15:0] inA,
	input [15:0] inB,
	input [5:0] func,
	input [3:0] shamt,
	input rType,
	input [2:0] fromContr,
	output [15:0] result,
	output zero);
	
	wire [2:0] sel;
	wire branchInstr;
	
	alu_control ctrl_alu(.funct(func), .aluOP(fromContr), .aluSel(sel));

	alu16 alu(inA, inB, shamt ,sel[2], sel[1], sel[0], result);
	
	and and1(branchInstr, fromContr[2], ~fromContr[1], ~fromContr[0]);
	and and2(zero, branchInstr, ~result[0]);
endmodule
	
	