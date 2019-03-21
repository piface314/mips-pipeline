//=======================================//
// Estágio de Pipeline - WB - Write Back //
//=======================================//

`include "aux-blocks.v"

module stageWB(
	//Entradas do "pass!" - MEM/WB
	input  wire        MemRead, //Control - WB
	input  wire [31:0] ALUResult,
	input  wire [31:0] memReadData,
	//Saídas para o Banco de Registradores
	output wire [31:0] regWriteData
);

	// Fios e registradores
	//==============================
	// N/A

	// Atribuições
	//==============================
	// N/A

	// Blocos principais
	//==============================
	// N/A

	// Blocos auxiliares
	//==============================
	mux_32bit_2in muxRegWrite(MemRead, ALUResult, memReadData, regWriteData);

endmodule