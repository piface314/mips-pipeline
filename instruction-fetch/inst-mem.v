//=======================//
// Memória de Instruções //
//=======================//

module instMem(
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] address,
    
    output wire [31:0] inst
);

    reg [31:0] instructionMemory [255:0];

    assign inst = instructionMemory[address[9:2]];

    always @(negedge clk) begin
        if (reset)
            $readmemb("instruction-fetch/program.txt",instructionMemory);
    end
    
endmodule
