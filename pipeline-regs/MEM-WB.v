//============================================//
// Registrador de Pipeline - MEM/WB - "pass!" //
//============================================//

module rMEMWB(
	input wire        clk,
	input wire        reset,

	input wire        RegWriteIn, MemReadIn, //Control - WB
	input wire [31:0] ALUResultIn,
	input wire [31:0] memReadDataIn,
	input wire  [4:0] regWriteAddressIn,

	output reg        RegWrite, MemRead, //Control - WB
	output reg [31:0] ALUResult,
	output reg [31:0] memReadData,
	output reg  [4:0] regWriteAddress
);

	always @ (posedge clk) begin
        if (reset) begin
            { RegWrite, MemRead, ALUResult, memReadData, regWriteAddress } <= 0;
        end else begin
            RegWrite 		<= RegWriteIn;
            MemRead 		<= MemReadIn;
            ALUResult 		<= ALUResultIn;
            memReadData 	<= memReadDataIn;
            regWriteAddress <= regWriteAddressIn; 
        end
    end

endmodule