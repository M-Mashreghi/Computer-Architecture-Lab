module ID(
    input clk, rst, 
    input [31:0] Instruction,
    input [31:0] Result_WB,
    input writeBackEn,
    input [3:0] Dest_wb,
    input hazard,
    input [3:0] SR,
    input freeze,

    output WB_EN, MEM_R_EN, MEM_W_EN,B,S,
    output [3:0] EXE_CMD,
    output [31:0] Val_Rn, Val_Rm,
    output imm,
    output [11:0] Shift_operand,
    output [23:0] Signed_imm_24,
    output [3:0] Dest,
    output [3:0] src1, src2,
    output Two_src);

    wire [8 : 0] Mux_out;
    wire [8 : 0] in1;
    wire Mux_sel;
    wire check_res;
    wire C_WB_EN, C_MEM_R_EN, C_MEM_W_EN,C_B,C_S;
    wire [3:0] C_EXE_CMD;

    ConditionCheck cond_check(.Cond(Instruction[31 : 28]),.Z(SR[2]),.N(SR[3]), .V(SR[0]),.C(SR[1]), .sel(check_res));
    
    assign src1 = Instruction [19 : 16];

    ControlUnit cntrl_unit(Instruction[20], Instruction[24 : 21], Instruction[27 : 26], C_S, C_B, C_MEM_R_EN, C_MEM_W_EN, C_WB_EN, C_EXE_CMD);
    RegistersFile #(32, 16)RegFile(clk, rst, freeze, writeBackEn, src1, src2, Dest_wb, Result_WB, Val_Rn, Val_Rm);
    Mux #(4) M2(MEM_W_EN, Instruction[3 : 0], Instruction[15 : 12], src2);
    Mux #(9)M1(Mux_sel, in1, 9'b0, Mux_out);
    assign in1 = {C_S, C_B, C_MEM_R_EN, C_MEM_W_EN, C_WB_EN, C_EXE_CMD};
    assign Mux_sel = hazard | ~check_res;
    assign S = Mux_out[8];
    assign B = Mux_out[7];
    assign MEM_R_EN = Mux_out[6];
    assign MEM_W_EN = Mux_out[5];
    assign WB_EN =Mux_out[4];
    assign EXE_CMD = Mux_out[3 : 0];
    assign Two_src = MEM_W_EN | (~imm);
    assign imm = Instruction[25];
    assign Dest = Instruction[15:12];
    assign Shift_operand = Instruction[11:0];
    assign Signed_imm_24 = Instruction[23:0];

endmodule