//=============================//
// Módulo de blocos auxiliares //
//=============================//

`ifndef AUX_BLOCKS
`define AUX_BLOCKS

// Formata o branch offset para endereço
module bFormat(
    input  wire [31:0] pc,
    input  wire [31:0] b,
    output wire [31:0] address
);

    assign address = pc + {b[29:0],{2'b00}};

endmodule

// Extensor de Sinal ou de Zero
module extSign(
    input wire extendType,
    input wire [15:0] x16b,
    output wire [31:0] x32b
);

    assign x32b = {(extendType)?{16{x16b[15]}}:{16{1'b0}},x16b};

endmodule

// Formato J para endereço
module jFormat(
    input wire [31:0] pc,
    input wire [25:0] j,
    output wire [31:0] address
);

    assign address = {pc[31:28],j[25:0],{2'b00}};

endmodule

// MUX - Multiplexador de 2 entradas, 5 bits cada
module mux_5bit_2in(
    input wire control,
    input wire [4:0] a,b,
    output wire [4:0] selected
);

    assign selected = (control)?b:a;

endmodule

// MUX - Multiplexador de 4 entradas, 7 bits cada
// module mux_7bit_4in(
//     input wire [1:0] control,
//     input wire [6:0] a,b,c,d,
//     output wire [6:0] selected
// );

//     assign selected = (control[1]) ? (control[0]?d:c) : (control[0]?b:a);

// endmodule

// MUX - Multiplexador de 2 entradas, 32 bits cada
module mux_32bit_2in(
    input wire control,
    input wire [31:0] a,b,
    output wire [31:0] selected
);

    assign selected = (control)?b:a;

endmodule

// MUX - Multiplexador de 4 entradas, 32 bits cada
module mux_32bit_4in(
    input wire [1:0] control,
    input wire [31:0] a,b,c,d,
    output wire [31:0] selected
);

    assign selected = (control[1]) ? (control[0]?d:c) : (control[0]?b:a);

endmodule

`endif