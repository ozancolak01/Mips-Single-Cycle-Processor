module half_adder(a, b, s, cout);

input a, b;
output s, cout;

xor xor1(s, a, b);
and and1(cout, a, b);

endmodule
