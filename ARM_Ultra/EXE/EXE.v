module EXE(
    input clk,
    input [3:0] EXE_CMD,
    input MEM_R_EN, MEM_W_EN,
    input [31:0] PC,
    input [31:0] Val_Rn, Val_Rm,
    input imm,
    input [11:0] Shift_operand,
    input [23:0] Signed_imm_24,
    input C_in,
    input S_ID,
    input [1:0] sel_src1, sel_src2,
    input [31:0] Val_in_MEM, Val_in_WB,
    
    output [31:0] ALU_result, Br_addr,
    output [3:0] status,
    output [31:0] Val_Rm_Out
    );
    wire [3:0] status_temp;
    wire [31 : 0] Val2;
    wire selmem;
    wire [31:0] ALU_Val1, Val_Rm_new;
    assign ALU_Val1 = (sel_src1 == 2'd1) ? Val_in_MEM :
                     (sel_src1 == 2'd2) ? Val_in_WB : Val_Rn;

    assign Val_Rm_new = (sel_src2 == 2'd1) ? Val_in_MEM :
                    (sel_src2 == 2'd2) ? Val_in_WB : Val_Rm;

    assign Val_Rm_Out = Val_Rm_new;
    ALU A1U(.Val1(ALU_Val1), .Val2(Val2), .EXE_CMD(EXE_CMD), .ALU_Res(ALU_result), .Z(status_temp[2]), .N(status_temp[3]), .C(C_in), .Cout(status_temp[1]), .V(status_temp[0]));
    Val2Gen V2G(.Val_Rm(Val_Rm_new), .imm(imm), .selmem(selmem), .Shift_operand(Shift_operand), .Val2(Val2));
    assign selmem = MEM_R_EN | MEM_W_EN;

    adder AD2 (.op1(PC), .op2(Signed_imm_24), .out(Br_addr));
    Status_Reg SR11(.clk(clk), .status_bit(status_temp), .S(S_ID),  .N(status[3]), .Z(status[2]), .C(status[1]), .V(status[0]));


endmodule