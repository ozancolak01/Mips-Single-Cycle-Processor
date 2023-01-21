// 2^16 word data memory with 16-bit words
module mem16(
	input [15:0]  addr,
	input [15:0]  wData,
	input			  clk,
	input			  wEn,
	output [15:0] rData
);

	reg [15:0] mem [0:65535];
	
	assign rData = mem[addr];
	
	always @(posedge clk) 
	begin
		if(wEn) begin
			mem[addr] <= wData;
			end
	end



endmodule
