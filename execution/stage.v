//======================================//
// Estágio de Pipeline - EX - Execution //
//======================================//

`include "execution/ALU.v"
`include "aux-blocks.v"

module stageEX(
	//Entradas do "shall" - ID/EX
    input  wire  [3:0] ALUOp,              //Control - EX
    input  wire        NotEqual, IsBranch, //Control - EX
    input  wire [31:0] IDEX_ALUVal1,IDEX_ALUVal2,
    input  wire [31:0] IDEX_regRead2,
    //Entradas do "not" - EX/MEM
    input  wire [31:0] EXMEM_ForwardVal,
    //Entradas do "pass!" - MEM/WB
    input  wire [31:0] MEMWB_ForwardVal,
    //Entradas da Unidade de Forwarding
    input  wire  [1:0] forwardA,forwardB,forwardC,

	//Saídas para o "not" - EX/MEM
	output wire [31:0] ALUResult,
	output wire [31:0] storeVal,
	//Saídas para o estágio IF
	output wire        BranchTaken
);

	// Fios e registradores
    //==============================
    //ALU
    wire [31:0] ALUVal1, ALUVal2;
    wire        Zero;

    // Atribuições
    //==============================
    assign BranchTaken = (Zero ^ NotEqual) & IsBranch;

    // Blocos principais
    //==============================
    ALU_32bit ALU(ALUOp, ALUVal1, ALUVal2, ALUResult, Zero);

    // Blocos auxiliares
    //==============================
    mux_32bit_4in muxVal1(forwardA, IDEX_ALUVal1,  EXMEM_ForwardVal, MEMWB_ForwardVal, 32'b0, ALUVal1);
    mux_32bit_4in muxVal2(forwardB, IDEX_ALUVal2,  EXMEM_ForwardVal, MEMWB_ForwardVal, 32'b0, ALUVal2);
    mux_32bit_4in muxAddr(forwardC, IDEX_regRead2, EXMEM_ForwardVal, MEMWB_ForwardVal, 32'b0, storeVal);

endmodule