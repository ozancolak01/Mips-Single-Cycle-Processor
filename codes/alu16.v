module alu16(a, b, shamt ,s2, s1, s0, out);

input [15:0] a, b;
input [3:0] shamt;
input s2, s1, s0;

output [15:0] out;

wire [15:0] add_out, sub_out, mult_out, xor_out, and_out, or_out, slt_out, nor_out, srl_out, sll_out;
wire [15:0] twos_complement;
wire cout_sum, cout_sub, cout_slt, most_significant_bit;

//16 Bit Adder
_16bit_adder adder(.a(a), .b(b), .cin(1'b0), .s(add_out), .cout(cout_sum));


//16 Bit Sub
_16bit_xor xor1(.a(16'hFFFF), .b(b), .out(twos_complement));
_16bit_adder sub1(.a(a), .b(twos_complement), .cin(1'b1), .s(sub_out), .cout(cout_sub));

//16 Bit SRL
shiftRLogical srl( .a(srl_out), .b(b), .shamt(shamt));

//16 Bit Xor
_16bit_xor xor2(.a(a), .b(b), .out(xor_out));

//16 Bit And
_16bit_and and1(.a(a), .b(b), .out(and_out));

//16 Bit Or
_16bit_or or1(.a(a), .b(b), .out(or_out));

//16 Bit SLT
and andx(most_significant_bit, sub_out[15], 1'b1);
_16bit_adder slt(.a(16'h0000), .b(16'h0000), .cin(most_significant_bit), .s(slt_out), .cout(cout_slt));

//16 Bit SRL
shiftLLogical sll(.a(sll_out), .b(b), .shamt(shamt));

	//					F5F4F3F2F1F0			aluOP
	//ADD				100000					000#210
	//SUBSTRACT		100010					001#210
	//SRL				000010					010#210
	//JR				001000					011#210
	//AND				100100					100#210
	//OR				100101					101#210
	//SLT				101010					110#210
	//SLL				000000					111#210

_8x1_mux mux1(.d0(add_out), .d1(sub_out), .d2(srl_out), .d3(16'd0), .d4(and_out), .d5(or_out), .d6(slt_out), .d7(sll_out), .s2(s2), .s1(s1), .s0(s0), .out(out));
endmodule
