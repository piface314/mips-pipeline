//==============================================//
// Estágio de Pipeline - IF - Instruction Fetch //
//==============================================//

`include "instruction-fetch/pc.v"
`include "instruction-fetch/inst-mem.v"
`include "aux-blocks.v"

module stageIF(
    input  wire        clk,
    input  wire        reset,

    //Entradas da Unidade de Detecção de Hazard
    input  wire        hazard,
    //Entradas do estágio ID
    input  wire  [1:0] PCSrc,
    input  wire [31:0] jumpAddress,
    input  wire [31:0] jumpReg,
    //Entradas do estágio EX
    input  wire        BranchTaken,
    input  wire [31:0] PCBranch,
    //Saídas para o "You" - IF/ID
    output wire [31:0] PCOut,
    output wire [31:0] inst
);

    // Fios
    //==============================
    wire [31:0] PC;
    wire [31:0] PCplus4;
    wire [31:0] PCNext;
    wire [31:0] branchAddress;

    // Atribuições
    //==============================
    assign PCplus4 = PC + 4;
    assign PCOut = PCplus4;

    // Blocos principais
    //==============================
    progCounter regPC(clk, reset, hazard, PCNext, PC);
    instMem instructionMemory(clk, reset, PC, inst);

    // Blocos auxiliares
    //==============================
    mux_32bit_2in BrSelect(BranchTaken, PCplus4, PCBranch, branchAddress);
    mux_32bit_4in PCSelect((BranchTaken)? 2'b01 : PCSrc, PCplus4, branchAddress, jumpAddress, jumpReg, PCNext);

endmodule
