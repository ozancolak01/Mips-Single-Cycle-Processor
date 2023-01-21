module _8bit_adder(a, b, cin, s, cout);

input [7:0] a, b;
input cin;

output [7:0] s;
output cout;

wire c;

_4bit_adder _4bit_adder1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .s(s[3:0]), .cout(c));
_4bit_adder _4bit_adder2(.a(a[7:4]), .b(b[7:4]), .cin(c), .s(s[7:4]), .cout(cout));

endmodule
