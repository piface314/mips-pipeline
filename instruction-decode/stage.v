//===============================================//
// Estágio de Pipeline - ID - Instruction Decode //
//===============================================//

`include "instruction-decode/control.v"
`include "instruction-decode/reg-file.v"
`include "aux-blocks.v"

module stageID(
    input  wire        clk,
    input  wire        reset,
    input  wire        hazard,
    //Entradas do "You" - IF/ID
    input  wire [31:0] PC,
    input  wire [31:0] inst,
    //Entradas do WB
    input  wire        WB_RegWrite,
    input  wire  [4:0] WB_WriteAddress,
    input  wire [31:0] WB_WriteData,

    //Saídas para o "shall" - ID/EX
    output wire        RegWrite,           //Control - WB
    output wire        MemRead, MemWrite,  //Control - MEM
    output wire  [3:0] ALUOp,              //Control - EX
    output wire        NotEqual, IsBranch, //Control - EX
    output wire [31:0] ALUVal1, ALUVal2,
    output wire [31:0] regRead2,
    output wire [31:0] branchAddress,
    output wire  [4:0] rsOut, rtOR0, rdORrt,
    //Saídas para o estágio IF
    output wire  [1:0] PCSrc,
    output wire [31:0] jmpAddress,
    output wire [31:0] jmpReg
);

    // Fios
    //==============================-
    //Sinais de controle
    wire ExtType, IsImd, IsShift, Link;
    //Campos da instrução
    wire  [5:0] opcode, funct;         
    wire  [4:0] rs, rt, rd, shamt;
    wire [15:0] imd;
    wire [25:0] address;
    //Saídas do banco de registradores
    wire [31:0] read1, read2;
    
    wire [31:0] imdExt; //Imediato com sinal estendido

    // Atribuições
    //==============================
    //Campos da instrução
    assign opcode   = inst[31:26];
    assign funct    = inst[ 5: 0];
    assign rs       = inst[25:21];
    assign rt       = inst[20:16];
    assign rd       = inst[15:11];
    assign shamt    = inst[10: 6];
    assign imd      = inst[15: 0];
    assign address  = inst[25: 0];
    //Sinais de controle
    assign IsBranch = (PCSrc == 1);
    //Saídas do estágio
    assign regRead2 = read2;
    assign rsOut = rs;
    assign rtOut = rt;
    assign jmpReg = read1;

    // Blocos Principais
    //==============================
    regfile registerFile(clk, reset, hazard, rs, rt, Link, PC, WB_RegWrite, WB_WriteAddress, WB_WriteData, read1, read2);
    ctrl control(opcode, funct, hazard, ALUOp, ExtType, IsImd, IsShift, Link, MemRead, MemWrite, NotEqual, PCSrc, RegWrite);

    // BLocos Auxiliares
    //==============================
    mux_32bit_2in muxVal1(IsShift, read1, {{27'b0},shamt},  ALUVal1);
    mux_32bit_2in muxVal2(IsImd,   read2, imdExt, ALUVal2);

    mux_5bit_2in  muxSrc2(IsImd, rt, 5'b00000, rtOR0);
    mux_5bit_2in  muxDest(IsImd, rd,       rt, rdORrt);

    extSign extend(ExtType, imd, imdExt);

    jFormat jmpFmt(PC, address, jmpAddress);
    bFormat branchFmt(PC, imdExt, branchAddress);

endmodule
