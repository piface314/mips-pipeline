//========================//
// Banco de Registradores //
//========================//

module regfile(
    input wire         clk,
    input wire         reset,
    input wire         freeze,
    input wire   [4:0] readAddress1,
    input wire   [4:0] readAddress2,
    input wire         link,
    input wire  [31:0] linkData,
    input wire         regWrite,
    input wire   [4:0] writeAddress,
    input wire  [31:0] writeData,

    output wire [31:0] readData1,
    output wire [31:0] readData2
);

    reg [31:0] registers [31:0];

    assign readData1 = registers[readAddress1];
    assign readData2 = registers[readAddress2];

    always @(negedge clk) begin
        if (reset) begin
            registers[0]  <= 32'h00000000;
            registers[1]  <= 32'h00000000;
            registers[2]  <= 32'h00000000;
            registers[3]  <= 32'h00000000;
            registers[4]  <= 32'h00000000;
            registers[5]  <= 32'h00000000;
            registers[6]  <= 32'h00000000;
            registers[7]  <= 32'h00000000;
            registers[8]  <= 32'h00000000;
            registers[9]  <= 32'h00000000;
            registers[10] <= 32'h00000000;
            registers[11] <= 32'h00000000;
            registers[12] <= 32'h00000000;
            registers[13] <= 32'h00000000;
            registers[14] <= 32'h00000000;
            registers[15] <= 32'h00000000;
            registers[16] <= 32'h00000000;
            registers[17] <= 32'h00000000;
            registers[18] <= 32'h00000000;
            registers[19] <= 32'h00000000;
            registers[20] <= 32'h00000000;
            registers[21] <= 32'h00000000;
            registers[22] <= 32'h00000000;
            registers[23] <= 32'h00000000;
            registers[24] <= 32'h00000000;
            registers[25] <= 32'h00000000;
            registers[26] <= 32'h00000000;
            registers[27] <= 32'h00000000;
            registers[28] <= 32'h00000000;
            registers[29] <= 32'h00000FFC; // Colocar $sp - stack pointer no topo da pilha
            registers[30] <= 32'h00000000;
            registers[31] <= 32'h00000000;
        end else begin
            if (link)
                registers[31] <= linkData;
            
            if (regWrite && writeAddress != 32'h00000000)
                registers[writeAddress] <= writeData;
        end
    end

endmodule
