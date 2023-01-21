`define DELAY 20
module instr_mem32_testbench(); 
	reg [9:0]  addr;
	reg	clk;
	wire [31:0] instruction;
	
	instr_mem32 test(addr, clk, instruction);
	
	
	initial begin
		clk = 1;
		$readmemb("C:/altera/13.1/mips_single_cycle/instructions.mem",test.mem);
	end
	
	always begin 
		#`DELAY clk = ~clk;
	end
	
	initial
		begin
			addr=10'd0; 
			#`DELAY;
			//reading
			#`DELAY;
			addr=10'd1; 
			#`DELAY;
			//reading
			#`DELAY;
			addr=10'd2;
			#`DELAY;
			$stop;
		end
 
	initial
		begin
			$monitor("time = %2d, addr =%10b, instruction=%32b", $time, addr, instruction);
		end
 
endmodule
