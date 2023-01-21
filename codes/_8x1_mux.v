module _8x1_mux(d0, d1, d2, d3, d4, d5, d6, d7, s2, s1, s0, out);

input [15:0] d0, d1, d2, d3, d4, d5, d6, d7;
input s2, s1, s0;
output [15:0] out;

wire [15:0] w1, w2, w3, w4, w5, w6;

_2x1_mux mux1(.d0(d0), .d1(d1), .S(s0), .out(w1));
_2x1_mux mux2(.d0(d2), .d1(d3), .S(s0), .out(w2));
_2x1_mux mux3(.d0(d4), .d1(d5), .S(s0), .out(w3));
_2x1_mux mux4(.d0(d6), .d1(d7), .S(s0), .out(w4));

_2x1_mux mux5(.d0(w1), .d1(w2), .S(s1), .out(w5));
_2x1_mux mux6(.d0(w3), .d1(w4), .S(s1), .out(w6));

_2x1_mux mux7(.d0(w5), .d1(w6), .S(s2), .out(out));

endmodule
