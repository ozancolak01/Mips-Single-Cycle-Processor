module next_pc(
	input clk,
	input [31:0] instr,
	input branch,
	input jump,
	output reg [9:0] pcreg
	);
	
	wire [9:0] branchAddr;
	
	//branchAddr = PC + 4 + imm;
	assign branchAddr = (pcreg + 10'd4 + {instr[11:2]});
	
	always @(posedge clk)
		begin
			if(branch) begin
					pcreg <= branchAddr;
				end
			else if(jump) begin
					pcreg <= instr[25:16];
				end
			else 
				begin
					pcreg <= pcreg + 10'd4;
				end		
		end
		
endmodule
