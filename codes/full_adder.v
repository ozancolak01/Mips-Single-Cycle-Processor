module full_adder(a, b, cin, s, cout);

input a, b, cin;
output s, cout;

wire[2:0] w;

half_adder temp(.a(a), .b(b), .s(w[0]), .cout(w[1]));
half_adder result(.a(w[0]), .b(cin), .s(s), .cout(w[2]));

or or1(cout, w[1], w[2]);

endmodule
