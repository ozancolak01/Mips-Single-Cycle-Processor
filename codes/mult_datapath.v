module mult_datapath(mult_res, product_in, write, product_out);

	input [15:0] mult_res;
	input [31:0] product_in;
	input write;
	
	output [31:0] product_out;
	
	wire [15:0] sum, result;
	wire cout;
	
	_2x1_mux mux(.d0(16'd0), .d1(mult_res[15:0]), .S(write), .out(result));
	_32bit_adder a(.a(product_in[31:16]), .b(result[15:0]) , .cin(1'b0), .s(sum), .cout(cout));
	
	assign product_out[14:0] = product_in[15:1];
	assign product_out[31:15] = {1'b0,sum[15:0]};
		
endmodule
