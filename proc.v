/* $Author: sinclair $ */
/* $LastChangedDate: 2020-02-09 17:03:45 -0600 (Sun, 09 Feb 2020) $ */
/* $Rev: 46 $ */

module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input wire clk;
   input wire rst;

   output reg err;


	// WIRES
	wire [15:0] 	int_pc;
	wire [15:0] 	int_instr;

	wire  [15:0] 	int_Imm5;
	wire  [15:0] 	int_Imm8;
	wire  [15:0] 	int_Imm11;
	wire  [15:0] 	int_Reg1;
	wire  [15:0] 	int_Reg2;
	wire  [1:0]  	int_RegSrc;
	wire  [4:0]  	int_to_ALUOP;
	wire  [1:0]  	int_func;
	wire  [1:0]  	int_Bsrc;
	wire  [4:0]	    int_brin;
	wire 		   	int_MemWrt;
	wire 		   	int_ALUJmp;
	wire 		   	int_ImmSrc;
	wire 		   	dec_err;

	wire [15:0] 	int_Out0;
	wire [15:0] 	int_Out1;
	wire [15:0] 	int_Out2;
	wire [15:0] 	int_Out3;

	wire [15:0] 	int_ALUOut;


	wire [15:0] wb_data;
	wire [15:0] wb_pc;
   
  	/* MAIN */

	fetch   fetch0(.pcIN(wb_pc), .clk(clk), .rst(rst), .pcOUT(int_pc), .instruction(int_instr));
	
	decode decode0(.Imm5(int_Imm5), .Imm8(int_Imm8), .Imm11(int_Imm11), .Reg1(int_Reg1), .Reg2(int_Reg2), .RegSrc(int_RegSrc), .to_ALUOP(int_to_ALUOP), .func(int_func), .Bsrc(int_Bsrc), .brin(int_brin), .MemWrt(int_MemWrt), .ALUJmp(int_ALUJmp), .ImmSrc(int_ImmSrc), .err(dec_err), .Instruction(int_instr), .wbdata(wb_data), .clk(clk), .rst(rst));

   	execute execu0(.Out0(int_Out0), .Out3(int_Out3), .ALUOut(int_ALUOut), .PCwb(wb_pc), .PC(int_pc), .to_ALUOP(int_to_ALUOP), .func(int_func), .Reg1(int_Reg1), .Reg2(int_Reg2), .Imm5(int_Imm5), .Imm8(int_Imm8), .Imm11(int_Imm11), .BSrc(int_Bsrc), .brin(int_brin), .ALUJmp(int_ALUJmp), .ImmSrc(int_ImmSrc));

	memory memory0(.Out1(int_Out1), .Out2(int_Out2), .ALUout(int_ALUOut), .wrdata(int_Reg2), .MemWrt(int_MemWrt), .clk(clk), .rst(rst));

	wb 		   wb0(.wbdata(wb_data), .In0(int_Out0), .In1(int_Out1), .In2(int_Out2), .In3(int_Out3), .RegSrc(int_RegSrc));
	
	always @(dec_err)
	begin
		err <= dec_err;
	end

endmodule // proc

// DUMMY LINE FOR REV CONTROL :0:
