//=========================================//
// Registrador de Pipeline - IF/ID - "You" //
//=========================================//

module rIFID(
    input  wire        clk,
    input  wire        reset,
    input  wire        flush,
    input  wire        freeze,
    
    input  wire [31:0] PCIn,
    input  wire [31:0] instIn,
    
    output reg  [31:0] PC,
    output reg  [31:0] inst
);

    always @(posedge clk) begin
        if (reset) begin
            { PC, inst } <= 0;
        end else if (~freeze) begin
            if (flush) begin
                PC      <= 0;
                inst    <= 0;
            end else begin
                PC      <= PCIn;
                inst    <= instIn;
            end
        end
    end

endmodule