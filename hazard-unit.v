//===============================//
// Unidade de Detecção de Hazard //
//===============================//

module hazardUnit(
	input  wire       IDEX_MemRead,
	input  wire [4:0] IFID_rs,IFID_rt,
	input  wire [4:0] IDEX_dest,
	output wire       hazard
);

	assign hazard = IDEX_MemRead & (IDEX_dest != 0) & ((IDEX_dest == IFID_rs) | (IDEX_dest == IFID_rt));

endmodule