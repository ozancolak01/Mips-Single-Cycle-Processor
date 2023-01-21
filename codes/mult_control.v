module mult_control(
	input go,
	input p0,
	input endi,
	input	reset,
	input	CLK,
	output reg write,
	output reg sr,
	output reg increment
);


localparam 	S0 = 3'd0,
				S1 = 3'd1,
				S2 = 3'd2,
				S3 = 3'd3,
				S4 = 3'd4;
				
reg	[2:0] present_state;
reg	[2:0] next_state = S0;

//State Register
always @(posedge CLK)
	begin
	if(reset)
		present_state <= S0;
	else
		present_state <= next_state;
	end

//Next State Logic
always @(*)
	begin
		next_state = S0;
		case(present_state)
				
				S0:
					begin
					if(go)
						next_state = S1;			
					end
					
				
				S1:
					begin
					if(p0)
						next_state = S2;
					else
						next_state = S3;
					end
					
				
				S2:
					begin
						next_state = S3;
					end
					
				
				S3:
					begin
					if(endi)
						next_state = S0;
					else
						next_state = S4;
					end
					
				S4:
					begin
					next_state = S1;
					end
				
			endcase
	end

//Outputs
always @(*)
		begin
			write = 1'b0;
			sr = 1'b0;
			increment = 1'b0;
			case(present_state)
							
				S1:
					begin
					end
								
				
				S2:
					begin
					write = 1'b1;
					end
					
				
				S3:
					begin	
					write = 1'b0;
					sr = 1'b1;
					end
				
				S4:
					begin	
					sr = 1'b0;
					increment = 1'b1;
					end
						
			endcase
			
		end				


endmodule
