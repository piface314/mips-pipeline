//====================================//
// Estágio de Pipeline - MEM - Memory //
//====================================//

`include "memory/data-mem.v"

module stageMEM(
	input  wire        clk,
	input  wire        reset,

	//Entradas do "not" - EX/MEM
	input  wire        MemWrite, //Control - MEM
	input  wire [31:0] writeAddress, writeData,

	//Saídas para o "pass!" - MEM/WB
	output wire [31:0] readData
);
	
	// Fios e registradores
	//==============================
	// N/A

	// Atribuições
	//==============================
	// N/A

	// Blocos principais
	//==============================
	dataMem data_memory(clk, reset, MemWrite, writeAddress, writeData, readData);

	// Blocos auxiliares
	//==============================
	// N/A

endmodule
