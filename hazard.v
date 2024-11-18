module hazard(
   	// Outputs
   	PCWrite, IF_ID_Write, nop, IF_ID_Flush,
   	// Inputs
	ReadReg1, ReadReg2, EXWriteReg, MEMWriteReg, WBWriteReg, IDinstr, EXinstr, EXWren, MemWren, WBWren
   );

	input [2:0] ReadReg1;
	input [2:0] ReadReg2;
	input [2:0] EXWriteReg;
	input [2:0] MEMWriteReg;
	input [2:0] WBWriteReg;

	input EXWren;
	input MemWren;
	input WBWren;

	input [15:0] IDinstr;
	input [15:0] EXinstr;

	output PCWrite;
	output IF_ID_Write;
	output nop;
	output IF_ID_Flush;


	wire 		rawdetected;
	wire		cntrldetected;

	assign rawdetected = (EXWren & (ReadReg1 === EXWriteReg | ReadReg2 === EXWriteReg)) | (MemWren & (ReadReg1 === MEMWriteReg | ReadReg2 === MEMWriteReg)) | (WBWren & (ReadReg1 === WBWriteReg | ReadReg2 === WBWriteReg));

	assign PCWrite = ~rawdetected;
	assign IF_ID_Write = ~rawdetected;
	assign nop = rawdetected;

	assign cntrldetected = (IDinstr[15:11] === 5'b01100) | (IDinstr[15:11] === 5'b01101) | (IDinstr[15:11] === 5'b01110) | (IDinstr[15:11] === 5'b01111) | (IDinstr[15:11] === 5'b00100) | (IDinstr[15:11] === 5'b00101) | (IDinstr[15:11] === 5'b00110) | (IDinstr[15:11] === 5'b00111) | (EXinstr[15:11] === 5'b01100) | (EXinstr[15:11] === 5'b01101) | (EXinstr[15:11] === 5'b01110) | (EXinstr[15:11] === 5'b01111) | (EXinstr[15:11] === 5'b00100) | (EXinstr[15:11] === 5'b00101) | (EXinstr[15:11] === 5'b00110) | (EXinstr[15:11] === 5'b00111);
	assign IF_ID_Flush = cntrldetected;

endmodule
