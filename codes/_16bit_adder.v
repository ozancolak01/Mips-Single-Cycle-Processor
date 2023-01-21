module _16bit_adder(a, b, cin, s, cout);

input [15:0] a, b;
input cin;

output [15:0] s;
output cout;

wire c0;

_8bit_adder _8bit_adder1(.a(a[7:0]), .b(b[7:0]), .cin(cin), .s(s[7:0]), .cout(c0));
_8bit_adder _8bit_adder2(.a(a[15:8]), .b(b[15:8]), .cin(c0), .s(s[15:8]), .cout(cout));

endmodule
