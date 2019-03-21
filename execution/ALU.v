//================//
// ALU de 32 bits //
//================//

`include "const.v"

module ALU_32bit(
	input  wire [3:0]   control,
	input  wire [31:0]  a,
	input  wire [31:0]  b,
	output reg  [31:0]  result,	
	output wire         zero
);  

    always @(control,a,b) begin
		case (control)
            `ALU_ADD: result <= a + b;
            `ALU_AND: result <= a & b;
            `ALU_LUI: result <= {b[15:0],{16'b0}};
            `ALU_OR:  result <= a | b;
            `ALU_SLL: result <= b << a[4:0];
            `ALU_SLT: result <= (a[31] != b[31]) ? ({{31'b0}, a[31]}) : ({{31'b0}, a < b});
            `ALU_SRA: result <= $signed(b) >>> a[4:0];
            `ALU_SRL: result <= b >> a[4:0];
            `ALU_SUB: result <= a - b;
            default:  result <= 0;
		endcase
	end
	
	assign zero = (result == 0);

endmodule
