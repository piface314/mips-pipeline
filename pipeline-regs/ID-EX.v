//===========================================//
// Registrador de Pipeline - ID/EX - "shall" //
//===========================================//

module rIDEX(
	input wire        clk,
	input wire        reset,

	input wire        RegWriteIn,             //Control - WB
    input wire        MemReadIn, MemWriteIn,  //Control - MEM
    input wire  [3:0] ALUOpIn,                //Control - EX
    input wire        NotEqualIn, IsBranchIn, //Control - EX
	input wire [31:0] ALUVal1In, ALUVal2In,
    input wire [31:0] readReg2In,
    input wire [31:0] branchAddrIn,
    input wire  [4:0] src1In, src2In, destIn,

    output reg        RegWrite,           //Control - WB
    output reg        MemRead, MemWrite,  //Control - MEM
    output reg  [3:0] ALUOp,              //Control - EX
    output reg        NotEqual, IsBranch, //Control - EX
	output reg [31:0] ALUVal1, ALUVal2,
    output reg [31:0] readReg2,
    output reg [31:0] branchAddr,
    output reg  [4:0] src1, src2, dest
);

    always @ (negedge clk) begin
        if (reset) begin
            { RegWrite, MemRead, MemWrite, ALUOp, NotEqual, IsBranch, ALUVal1, ALUVal2, readReg2, branchAddr, src1, src2, dest } <= 0;
        end else begin
            RegWrite    <= RegWriteIn;
            MemRead     <= MemReadIn;
            MemWrite    <= MemWriteIn;
            ALUOp       <= ALUOpIn;
            NotEqual    <= NotEqualIn;
            IsBranch    <= IsBranchIn;
            ALUVal1     <= ALUVal1In;
            ALUVal2     <= ALUVal2In;
            readReg2    <= readReg2In;
            branchAddr  <= branchAddrIn;
            src1        <= src1In;
            src2        <= src2In;
            dest        <= destIn;
        end
    end

endmodule











