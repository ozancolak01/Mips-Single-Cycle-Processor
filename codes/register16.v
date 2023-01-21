module register16(
	input [3:0] rsAddr,
	input [3:0] rtAddr,
	input [3:0] rwAddr,
	input [15:0] wData,
	input fastClk,
	input clk,
	input wEn,
	output reg [15:0] rs,
	output reg [15:0] rt
);

reg [15:0] data [15:0];


always @(*) 
		begin
			rs <= data[rsAddr];
			rt <= data[rtAddr];
		end

always @(posedge clk)
	begin
		if (wEn)
			begin
				data[rwAddr] <= wData;
			end
	end

endmodule
