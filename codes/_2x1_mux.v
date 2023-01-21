module _2x1_mux(d0, d1, S, out);

	//default value 16, can change
	parameter WIDTH = 16;

	input [WIDTH - 1:0] d0;
	input [WIDTH - 1:0] d1;
	input 				  S;
	output [WIDTH - 1:0] out;

	wire [WIDTH - 1:0] w1, w2;

	generate
		genvar i;
		for(i=0; i<WIDTH; i = i+1)
		begin: mux0
			and g0(w1[i], d0[i], ~S);
			and g1(w2[i], d1[i], S);
			or g2(out[i], w1[i], w2[i]);
		end
	endgenerate
	
	//assign out = S ? d1 : d0;

endmodule
