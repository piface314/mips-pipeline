//==========================================//
// Registrador de Pipeline - EX/MEM - "not" //
//==========================================//

module rEXMEM(
	input wire        clk,
	input wire        reset,

	input wire        RegWriteIn,             //Control - WB
    input wire        MemReadIn, MemWriteIn,  //Control - MEM
    input wire [31:0] ALUResultIn,
    input wire [31:0] storeValIn,
    input wire  [4:0] regWriteAddressIn,

    output reg        RegWrite,             //Control - WB
    output reg        MemRead, MemWrite,    //Control - MEM
    output reg [31:0] ALUResult,
    output reg [31:0] storeVal,
    output reg  [4:0] regWriteAddress
);

	always @(posedge clk) begin
        if (reset) begin
            { RegWrite, MemRead, MemWrite, ALUResult, storeVal, regWriteAddress } <= 0;
        end else begin
            RegWrite 		<= RegWriteIn;
            MemRead 		<= MemReadIn;
            MemWrite 		<= MemWriteIn;
            ALUResult 		<= ALUResultIn;
            storeVal 		<= storeValIn;
            regWriteAddress <= regWriteAddressIn;
        end
    end

endmodule