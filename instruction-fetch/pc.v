//======================//
// PC - Program Counter //
//======================//

module progCounter(
    input  wire        clk,
    input  wire        reset,
    input  wire        freeze,
    input  wire [31:0] PCIn,
    
    output reg  [31:0] PC
);

    always @(negedge clk) begin
        if (reset)
            PC <= 0;
        else if (~freeze)
            PC <= PCIn;
    end

endmodule
