module zext16(in, out);

parameter WIDTH = 5;

input  [WIDTH-1:0] in;
output [15:0] 	   out;

assign out = {{16-WIDTH{1'b0}}, in};

endmodule