//==========================//
// Definições de Constantes //
//==========================//

//Opcodes ou Functs das instruções
//====================================
`define I_ADD  6'b100000
`define I_ADDI 6'b001000
`define I_AND  6'b100100
`define I_BEQ  6'b000100
`define I_BNE  6'b000101
`define I_J    6'b000010
`define I_JAL  6'b000011
`define I_JR   6'b001000
`define I_LUI  6'b001111
`define I_LW   6'b100011
`define I_OR   6'b100101
`define I_ORI  6'b001101
`define I_SUB  6'b100010
`define I_SLL  6'b000000
`define I_SLT  6'b101010
`define I_SRA  6'b000011
`define I_SRL  6'b000010
`define I_SW   6'b101011

//Operações da ALU
//==============================
`define ALU_ADD 0
`define ALU_AND 1
`define ALU_LUI 2
`define ALU_OR  3
`define ALU_SLL 4
`define ALU_SLT 5
`define ALU_SRA 6
`define ALU_SRL 7
`define ALU_SUB 8
