//======================================//
//     Processador MIPS com Pipeline    //
//======================================//
// Implementação por:                   //
//   Caio Augusto Moreira Campos - 3042 //
//   Henrique de Souza Santana   - 3051 //
//======================================//
//     Simulação do Caminho de Dados    //
//======================================//

`include "main.v"

module MIPSsim();
	
	reg clk;
	reg reset;

	datapath dp(clk, reset);

	integer i;

	initial begin
		clk = 0;
		reset = 0;

		$dumpfile("sim.vcd");
		$dumpvars(0,MIPSsim);
        for (i = 0; i < 32; i = i + 1) begin
            $dumpvars(1,dp.stage_ID.registerFile.registers[i]);
        end

		for (i = 0; i < 8; i = i + 1) begin
            $dumpvars(2,dp.stage_MEM.data_memory.memory[i]);
        end

		#1 reset = 1;
		#2 reset = 0;

		#1700 $finish;

	end

	always
		#1 clk = ~clk;

endmodule