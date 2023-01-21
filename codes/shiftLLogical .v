module shiftLLogical( 
	 output [15:0] a,
    input [15:0] b,
    input [3:0] shamt );

   assign a = b << shamt;

endmodule
