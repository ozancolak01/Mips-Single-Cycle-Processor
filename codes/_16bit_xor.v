module _4bit_xor(a, b, out);

input [3:0] a, b;
output [3:0] out;

xor xor1(out[0], a[0], b[0]);
xor xor2(out[1], a[1], b[1]);
xor xor3(out[2], a[2], b[2]);
xor xor4(out[3], a[3], b[3]);

endmodule


module _16bit_xor(a, b, out);

input [15:0] a, b;
output [15:0] out;

_4bit_xor xor1( a[3:0], b[3:0], out[3:0]);
_4bit_xor xor2(a[7:4], b[7:4], out[7:4]);
_4bit_xor xor3(a[11:8], b[11:8], out[11:8]);
_4bit_xor xor4(a[15:12], b[15:12], out[15:12]);

endmodule
