//==============================//
// Controle do Caminho de Dados //
//==============================//

`include "const.v"

module ctrl(
    input  wire [5:0] opcode,
    input  wire [5:0] funct,
    input  wire       hazard,
    
    output reg  [3:0] ALUOp,
    output wire       ExtType,
    output reg        IsImd,
    output reg        IsShift,
    output wire       Link,
    output wire       MemRead,
    output wire       MemWrite,
    output wire       NotEqual,
    output reg  [1:0] PCSrc,
    output reg        RegWrite
);

    assign ExtType  = ~hazard & (opcode != `I_ORI);
    assign Link     = ~hazard & (opcode == `I_JAL);
    assign MemRead  = ~hazard & (opcode == `I_LW);
    assign MemWrite = ~hazard & (opcode == `I_SW);
    assign NotEqual = ~hazard & (opcode == `I_BNE);

    always @(*) begin
        if (hazard)
            begin ALUOp <= 0; IsImd <= 0; IsShift <= 0; PCSrc <= 0; RegWrite <= 0; end
        else begin
            case (opcode)
            6'b000000:
                case (funct)
                `I_ADD:  begin ALUOp <= `ALU_ADD; IsImd <= 0; IsShift <= 0; PCSrc <= 0; RegWrite <= 1; end
                `I_AND:  begin ALUOp <= `ALU_AND; IsImd <= 0; IsShift <= 0; PCSrc <= 0; RegWrite <= 1; end
                `I_JR:   begin ALUOp <= 0;        IsImd <= 0; IsShift <= 0; PCSrc <= 3; RegWrite <= 0; end
                `I_OR:   begin ALUOp <= `ALU_OR;  IsImd <= 0; IsShift <= 0; PCSrc <= 0; RegWrite <= 1; end
                `I_SUB:  begin ALUOp <= `ALU_SUB; IsImd <= 0; IsShift <= 0; PCSrc <= 0; RegWrite <= 1; end
                `I_SLL:  begin ALUOp <= `ALU_SLL; IsImd <= 0; IsShift <= 1; PCSrc <= 0; RegWrite <= 1; end
                `I_SLT:  begin ALUOp <= `ALU_SLT; IsImd <= 0; IsShift <= 0; PCSrc <= 0; RegWrite <= 1; end
                `I_SRA:  begin ALUOp <= `ALU_SRA; IsImd <= 0; IsShift <= 1; PCSrc <= 0; RegWrite <= 1; end
                `I_SRL:  begin ALUOp <= `ALU_SRL; IsImd <= 0; IsShift <= 1; PCSrc <= 0; RegWrite <= 1; end
                default: begin ALUOp <= 0;        IsImd <= 0; IsShift <= 0; PCSrc <= 0; RegWrite <= 0; end
                endcase
            `I_ADDI: begin ALUOp <= `ALU_ADD; IsImd <= 1; IsShift <= 0; PCSrc <= 0; RegWrite <= 1; end
            `I_BEQ:  begin ALUOp <= `ALU_SUB; IsImd <= 0; IsShift <= 0; PCSrc <= 1; RegWrite <= 0; end
            `I_BNE:  begin ALUOp <= `ALU_SUB; IsImd <= 0; IsShift <= 0; PCSrc <= 1; RegWrite <= 0; end
            `I_J:    begin ALUOp <= 0;        IsImd <= 0; IsShift <= 0; PCSrc <= 2; RegWrite <= 0; end
            `I_JAL:  begin ALUOp <= 0;        IsImd <= 0; IsShift <= 0; PCSrc <= 2; RegWrite <= 0; end
            `I_LUI:  begin ALUOp <= `ALU_LUI; IsImd <= 1; IsShift <= 0; PCSrc <= 0; RegWrite <= 1; end
            `I_LW:   begin ALUOp <= `ALU_ADD; IsImd <= 1; IsShift <= 0; PCSrc <= 0; RegWrite <= 1; end
            `I_ORI:  begin ALUOp <= `ALU_OR;  IsImd <= 1; IsShift <= 0; PCSrc <= 0; RegWrite <= 1; end
            `I_SW:   begin ALUOp <= `ALU_ADD; IsImd <= 1; IsShift <= 0; PCSrc <= 0; RegWrite <= 0; end
            default: begin ALUOp <= 0;        IsImd <= 0; IsShift <= 0; PCSrc <= 0; RegWrite <= 0; end
            endcase
        end
    end

endmodule
