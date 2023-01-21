`define DELAY 20
module alu16_testbench();

reg [15:0] a, b;
reg s2, s1, s0;
wire [15:0] out;

alu16 aluTest(.a(a), .b(b), .s2(s2), .s1(s1), .s0(s0), .out(out));

initial begin

//ADD
a = 16'h5BF3; b = 16'h0011; s2 = 0; s1 = 0; s0 = 0;
#`DELAY;
a = 16'h0000; b = 16'h5678; s1 = 0; s1 = 0; s0 = 0;
#`DELAY;

//SUB
a = 16'hAF23; b = 16'h0023; s2 = 0; s1 = 0; s0 = 1;
#`DELAY;
a = 16'hFFFF; b = 16'hFFFF; s2 = 0; s1 = 0; s0 = 1;
#`DELAY;

//MULT, It is not fully implemented, it has a controller and datapath.
a = 16'h0002; b = 16'h0003; s2 = 0; s1 = 1; s0 = 0;
#`DELAY;
a = 16'h0000; b = 16'h5678; s2 = 0; s1 = 1; s0 = 0;
#`DELAY;

//XOR
a = 16'h0101; b = 16'hFFFF; s2 = 0; s1 = 1; s0 = 1;
#`DELAY;
a = 16'h9999; b = 16'h0000; s2 = 0; s1 = 1; s0 = 1;
#`DELAY;

//AND
a = 16'h0000; b = 16'h1234; s2 = 1; s1 = 0; s0 = 0;
#`DELAY;
a = 16'h2ABF; b = 16'h2ABF; s2 = 1; s1 = 0; s0 = 0;
#`DELAY;

//OR
a = 16'h0000; b = 16'h1234; s2 = 1; s1 = 0; s0 = 1;
#`DELAY;
a = 16'h2ABF; b = 16'h2ABF; s2 = 1; s1 = 0; s0 = 1;
#`DELAY;

//SLT
a = 16'h3BFC; b = 16'h4212; s2 = 1; s1 = 1; s0 = 0;
#`DELAY;
a = 16'h000F; b = 16'h0001; s2 = 1; s1 = 1; s0 = 0;
#`DELAY;

//NOR
a = 16'h0000; b = 16'h1234; s2 = 1; s1 = 1; s0 = 1;
#`DELAY;
a = 16'h2ABF; b = 16'h2ABF; s0 = 1; s2 = 1; s0 = 1;
#`DELAY;



end

initial
begin
$monitor("Results: time= %2d, a= %8h, b= %8h, out= %8h, s2= %1b, s1= %1b, s0= %1b", $time, a, b, out, s2, s1, s0);
end
 

endmodule
