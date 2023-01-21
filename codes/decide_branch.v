module decide_branch(
	input beq,
	input bne,
	input zero,
	output branch
	);
	
	wire beqTrue, bneTrue;
	
	//If beq and zero is 1 or bne and not zero is 1, then branch
	and and0(beqTrue, beq, zero);
	and and1(bneTrue, bne, ~zero);
	or result(branch, bneTrue, beqTrue);

endmodule
