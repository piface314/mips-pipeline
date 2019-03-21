//======================//
// Unidade de Fowarding //
//======================//

module forwardingUnit(
	input wire [4:0] IDEX_src1, IDEX_src2, IDEX_dest,
	input wire       EXMEM_RegWrite,
	input wire [4:0] EXMEM_dest,
	input wire       MEMWB_RegWrite,
	input wire [4:0] MEMWB_dest,

	output reg [1:0] fwdA, fwdB, fwdC
);

	always @(*) begin
		if (EXMEM_RegWrite && EXMEM_dest != 0 && EXMEM_dest == IDEX_src1)
			fwdA <= 1;
		else if (MEMWB_RegWrite && MEMWB_dest != 0 && MEMWB_dest == IDEX_src1)
			fwdA <= 2;
		else
			fwdA <= 0; 

		if (EXMEM_RegWrite && EXMEM_dest != 0 && EXMEM_dest == IDEX_src2)
			fwdB <= 1;
		else if (MEMWB_RegWrite && MEMWB_dest != 0 && MEMWB_dest == IDEX_src2)
			fwdB <= 2;
		else
			fwdB <= 0;

		if (EXMEM_RegWrite && EXMEM_dest != 0 && EXMEM_dest == IDEX_dest)
			fwdC <= 1;
		else if (MEMWB_RegWrite && MEMWB_dest != 0 && MEMWB_dest == IDEX_dest)
			fwdC <= 2;
		else
			fwdC <= 0;
	end

endmodule
