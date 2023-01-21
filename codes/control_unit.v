module control_unit(
	input [5:0] op,
	output memToReg,
	output memWrite,
	output aluSrc,
	output [2:0] toAlu,
	output rType,
	output regWr,
	output regDst, //1 if R Type
	output beq,
	output bne,
	output jump,
	output li
	);
	
	wire lw, sw, addi, andi, ori, slti, jal; //jal output olcak
	
	and g0(rType,~op[4], ~op[3], ~op[2], ~op[1], ~op[0]);
	and g1(jump, ~op[3], op[1], ~op[0]);
	and g2(jal, ~op[5], op[1], op[0]);
	and g3(beq, ~op[3], op[2], ~op[1], ~op[0]);
	and g19(bne, ~op[3], op[2], ~op[1], op[0]);
	and g4(addi, op[3], ~op[2], ~op[1], ~op[0]);
	and g5(slti, op[3], ~op[2], op[1], ~op[0]);
	and g6(andi, op[3], op[2], ~op[0]);
	and g7(ori, op[3], op[2], op[0]);
	and g8(lw, op[5], ~op[3]);
	and g9(sw, op[5], op[3]);
	and g10(li, op[4]);
	//c15
	buf g11(memToReg, lw);
	buf g12(memWrite, sw);
	buf g13(regDst, rType);
	
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
	or g14(aluSrc, lw, sw, addi, andi, ori, slti); //aluSrc 1 if imm will be used
	or g15(toAlu[0], ori, li, jump, jal, slti);
	or g16(toAlu[1], addi, lw, sw, li, andi, slti);
	or g17(toAlu[2], beq, bne, jump, jal, andi, slti);

	or c18(regWr, rType, lw, sw, addi, andi, ori, slti, li);
	
endmodule
