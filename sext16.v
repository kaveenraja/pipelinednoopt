module sext16(in, out);

parameter WIDTH = 5;

input [WIDTH-1:0] in;
output[15:0] out;

wire top = out[WIDTH-1];

assign out = {{16-WIDTH{top}}, in};

endmodule
