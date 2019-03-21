//======================================//
//     Processador MIPS com Pipeline    //
//======================================//
// Implementação por:                   //
//   Caio Augusto Moreira Campos - 3042 //
//   Henrique de Souza Santana   - 3051 //
//======================================//

// Registradores de Pipeline
//==============================
`include "pipeline-regs/IF-ID.v"
`include "pipeline-regs/ID-EX.v"
`include "pipeline-regs/EX-MEM.v"
`include "pipeline-regs/MEM-WB.v"

// Estágios do Pipeline
//==============================
`include "instruction-fetch/stage.v"
`include "instruction-decode/stage.v"
`include "execution/stage.v"
`include "memory/stage.v"
`include "write-back/stage.v"

// Forwarding e Hazard
//==============================
`include "hazard-unit.v"
`include "forward-unit.v"

module datapath(
	input wire clk,
	input wire reset
);

	// Fios
	//==============================
	//IF - Saídas
	wire [31:0] IF_PC;
	wire [31:0] IF_inst;
	//IF/ID - Saídas
	wire [31:0] IFID_PC;
	wire [31:0] IFID_inst;
	//ID - Saídas
	wire        ID_RegWrite;
    wire        ID_MemRead, ID_MemWrite;
    wire  [3:0] ID_ALUOp;
    wire        ID_NotEqual, ID_IsBranch;
    wire [31:0] ID_ALUVal1, ID_ALUVal2;
    wire [31:0] ID_regRead2;
    wire [31:0] ID_immediate;
    wire  [4:0] ID_rs, ID_rtOR0, ID_rdORrt;
	wire  [1:0] ID_PCSrc;
	wire [31:0] ID_jumpAddress;
	wire [31:0] ID_jumpReg;
	//ID/EX - Saídas
	wire        IDEX_RegWrite;
    wire        IDEX_MemRead, IDEX_MemWrite;
    wire  [3:0] IDEX_ALUOp;
    wire        IDEX_NotEqual, IDEX_IsBranch;
	wire [31:0] IDEX_ALUVal1, IDEX_ALUVal2;
    wire [31:0] IDEX_regRead2;
    wire [31:0] IDEX_branchAddr;
    wire  [4:0] IDEX_src1, IDEX_src2, IDEX_dest;
	//EX - Saídas
	wire [31:0] EX_ALUResult;
	wire [31:0] EX_storeVal;
	wire        EX_BranchTaken;
	//EX/MEM - Saídas
	wire        EXMEM_RegWrite;
	wire        EXMEM_MemRead, EXMEM_MemWrite;
	wire [31:0] EXMEM_ALUResult;
	wire [31:0] EXMEM_storeVal;
	wire  [4:0] EXMEM_regWriteAddress;
	//MEM - Saídas
	wire [31:0] MEM_readData;
	//MEM/WB - Saídas
	wire        MEMWB_RegWrite, MEMWB_MemRead;
	wire [31:0] MEMWB_ALUResult;
	wire [31:0] MEMWB_memReadData;
	wire  [4:0] MEMWB_regWriteAddress;
	//WB - Saídas
    wire [31:0] WB_writeData;
	//Hazard - Saídas
	wire        hazard;
	//Forwarding - Saídas
    wire  [1:0] forwardA, forwardB, forwardC;

	// Estágio IF
	//==============================
	stageIF stage_IF(clk, reset, hazard, ID_PCSrc, ID_jumpAddress, ID_jumpReg, EX_BranchTaken, IDEX_branchAddr,
		IF_PC, IF_inst);

	// IF/ID - "You"
	//==============================
	rIFID reg_IFID(clk, reset, EX_BranchTaken, hazard, IF_PC, IF_inst,
		IFID_PC, IFID_inst);

	// Estágio ID
	//==============================
	stageID stage_ID(clk, reset, hazard, IFID_PC, IFID_inst, MEMWB_RegWrite, MEMWB_regWriteAddress, WB_writeData, 
		ID_RegWrite, ID_MemRead, ID_MemWrite, ID_ALUOp, ID_NotEqual, ID_IsBranch, ID_ALUVal1, ID_ALUVal2,
		ID_regRead2, ID_immediate, ID_rs, ID_rtOR0, ID_rdORrt, ID_PCSrc, ID_jumpAddress, ID_jumpReg);

	// ID/EX - "shall"
	//==============================
	rIDEX reg_IDEX(clk, reset, ID_RegWrite, ID_MemRead, ID_MemWrite, ID_ALUOp, ID_NotEqual, ID_IsBranch,
		ID_ALUVal1, ID_ALUVal2, ID_regRead2, ID_immediate, ID_rs, ID_rtOR0, ID_rdORrt,
		IDEX_RegWrite, IDEX_MemRead, IDEX_MemWrite, IDEX_ALUOp, IDEX_NotEqual, IDEX_IsBranch,
		IDEX_ALUVal1, IDEX_ALUVal2, IDEX_regRead2, IDEX_branchAddr, IDEX_src1, IDEX_src2, IDEX_dest);

	// Estágio EX
	//==============================
	stageEX stage_EX(IDEX_ALUOp, IDEX_NotEqual, IDEX_IsBranch, IDEX_ALUVal1, IDEX_ALUVal2, IDEX_regRead2,
		EXMEM_ALUResult, WB_writeData, forwardA, forwardB, forwardC,
		EX_ALUResult, EX_storeVal, EX_BranchTaken);

	// EX/MEM - "not"
	//==============================
	rEXMEM reg_EXMEM(clk, reset, IDEX_RegWrite, IDEX_MemRead, IDEX_MemWrite, EX_ALUResult, EX_storeVal, IDEX_dest,
		EXMEM_RegWrite, EXMEM_MemRead, EXMEM_MemWrite, EXMEM_ALUResult, EXMEM_storeVal, EXMEM_regWriteAddress);

	// Estágio MEM
	//==============================
	stageMEM stage_MEM(clk, reset, EXMEM_MemWrite, EXMEM_ALUResult, EXMEM_storeVal,
		MEM_readData);

	// MEM/WB - "pass!"
	//==============================
	rMEMWB reg_MEMWB(clk, reset, EXMEM_RegWrite, EXMEM_MemRead, EXMEM_ALUResult, MEM_readData, EXMEM_regWriteAddress,
		MEMWB_RegWrite, MEMWB_MemRead, MEMWB_ALUResult, MEMWB_memReadData, MEMWB_regWriteAddress);

	// Estágio WB
	//==============================
	stageWB stage_WB(MEMWB_MemRead, MEMWB_ALUResult, MEMWB_memReadData,
		WB_writeData);

	// Unidade de Detecção de Hazard
	//==============================
	hazardUnit hazardDet(IDEX_MemRead, IFID_inst[25:21], IFID_inst[20:16], IDEX_dest,
		hazard);

	// Unidade de Forwarding
	//==============================
	forwardingUnit forward(IDEX_src1, IDEX_src2, IDEX_dest, EXMEM_RegWrite, EXMEM_regWriteAddress,
		MEMWB_RegWrite, MEMWB_regWriteAddress,
		forwardA, forwardB, forwardC);

endmodule