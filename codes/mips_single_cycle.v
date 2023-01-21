module mips_single_cycle(
	output [15:0] aluOut,
	//input [31:0] instr, //to test the processor, uncomment this
	input fastClk,
	input clk
);

	wire [31:0] instr; //to test the processor, comment this, also comment line 46
	wire [15:0] rs, rt, rtOrImm, result, shCorrOutRs, memOut, toReg;
	wire [2:0] toAlu;
	wire [3:0] wAddr;
	wire		  memWrite, memToReg, aluSrc, rType, regDst, regWr, beq, bne, branch, zero, jump, li;
	
	wire [9:0] PC;
	
	buf buf1 [15:0] (aluOut, result);
	
	// R TYPE
	//rd[17:14] rt[21:18] rs[25:22] opcode[31:26]
	
	//I TYPE
	//imm[17:2] rt[21:18] rs[25:22] opcode[31:26]
	
	//J TYPE
	//addr[25:16] 						  opcode[31:26]
	
	// Next PC block
	next_pc inst_pc(.clk(clk), .instr(instr), .branch(branch), .jump(jump), .pcreg(PC));
	
	// Full Alu module including ALU control that determines select for R-type instructions
	alu_full alu_inst(.inA(rs), .inB(rtOrImm), .func(instr[9:4]), .shamt(instr[13:10]),
							.rType(rType), .fromContr(toAlu), .result(result), .zero(zero));
	
	decide_branch bra_inst(.beq(beq), .bne(bne), .zero(zero), .branch(branch));
	
	
	register16 reg16(.rsAddr(instr[25:22]), .rtAddr(instr[21:18]), .rwAddr(wAddr), .wData(toReg), .fastClk(fastClk), .wEn(regWr), .rs(rs), .rt(rt), .clk(clk));
	
	// Imm or rt selection MUX
	_2x1_mux #(16) alusrc_mux(.d0(rt), .d1(instr[17:2]), .S(aluSrc), .out(rtOrImm));
	
	// Data Memory Instance
	mem16 data_mem(.addr(result), .wData(rt), .clk(clk), .rData(memOut), .wEn(memWrite));
	
	//Instruction Memory
	instr_mem32 instr_mem(.addr(PC), .clk(clk), .instruction(instr));
	
	// Select either Alu out or Mem out
	_2x1_mux #(16) lw_mux(.d0(result), .d1(memOut), .S(memToReg), .out(toReg));
	
	// Select either rdAddr or rtAddr
	_2x1_mux #(4) rtrd_mux(.d0(instr[21:18]), .d1(instr[17:14]), .S(regDst), .out(wAddr));
	
	// Control unit to setup control signals ( selects of the muxes)
	control_unit ctrl(.op(instr[31:26]), .memToReg(memToReg), .toAlu(toAlu), .memWrite(memWrite),
							.aluSrc(aluSrc), .rType(rType), .regWr(regWr), .regDst(regDst), .beq(beq), 
							.bne(bne), .li(li) , .jump(jump));
	
	
endmodule
