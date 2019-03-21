//==================//
// Memória de Dados //
//==================//

module dataMem(
    input  wire        clk,
    input  wire        reset,
    input  wire        mem_write,
    input  wire [31:0] address,
    input  wire [31:0] write_data,
    output wire [31:0] read_data
);

    reg	[31:0] memory [1023:0];

	assign read_data = memory[address[11:2]];

    always @(posedge clk) begin
        if (reset)
            $readmemh("memory/data.txt",memory);
    end

    always @(negedge clk) begin
        if (mem_write)
			memory[address[17:2]] <= write_data[31:0];
	end
    
endmodule
