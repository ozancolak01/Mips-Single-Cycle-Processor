module _4bit_or(a, b, out);

input [3:0] a, b;
output [3:0] out;

or or1(out[0], a[0], b[0]);
or or2(out[1], a[1], b[1]);
or or3(out[2], a[2], b[2]);
or or4(out[3], a[3], b[3]);

endmodule


module _16bit_or(a, b, out);

input [15:0] a, b;
output [15:0] out;

_4bit_or or1( a[3:0], b[3:0], out[3:0]);
_4bit_or or2(a[7:4], b[7:4], out[7:4]);
_4bit_or or3(a[11:8], b[11:8], out[11:8]);
_4bit_or or4(a[15:12], b[15:12], out[15:12]);

endmodule

module _32bit_or(a, b, out);

input [31:0] a, b;
output [31:0] out;

_16bit_or or1(a[15:0], b[15:0], out[15:0]);
_16bit_or or2(a[31:16], b[31:16], out[31:16]);

endmodule
