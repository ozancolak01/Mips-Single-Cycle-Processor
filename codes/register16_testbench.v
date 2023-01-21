`define DELAY 20
`define DELAYshort 10
module register16_testbench(); 
	reg [3:0] rsAddr, rtAddr, rwAddr;
	reg [15:0] wData;
	reg fastClk, clk, wEn;
	wire [15:0] rs, rt;

	register16 test (rsAddr, rtAddr, rwAddr, wData, fastClk, clk, wEn, rs, rt);
	
	
	initial begin
		clk = 0;
		wEn=1'b0;
		$readmemb("C:/altera/13.1/mips_single_cycle/reg.mem",test.data);
	end
	always begin 
		#`DELAY clk = ~clk;
		#`DELAYshort fastClk= ~fastClk;
	end
	initial
		begin
			rsAddr=3'd0; rtAddr=3'd1;
			#`DELAY;
			wEn=1'b1; wData=16'b0000000000000001; rwAddr=3'd0;
			#`DELAY;
			rsAddr=3'd0; rtAddr=3'd1;
			#`DELAY;
			$writememb("C:/altera/13.1/mips_single_cycle/reg.mem",test.data);
			#`DELAY;
			rsAddr=3'd0; rtAddr=3'd1;
			#`DELAY;
			$stop;
		end
 
	initial
		begin
			$monitor("time = %2d, rs =%d, rt=%d", $time, rs, rt);
		end
 
endmodule
