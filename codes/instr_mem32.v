// 2^16 word data memory with 16-bit words
module instr_mem32(
	input [9:0]  addr,
	input	clk,
	output reg [31:0] instruction
);

	reg [31:0] mem [0:1023];
	
	always @(posedge clk) 
	begin
		begin
			instruction <= mem[addr];
		end
	end

endmodule
