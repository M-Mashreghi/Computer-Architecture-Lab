module ID_STAGE_REG(
    input clk, rst, flush, freeze,
    input WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN,B_IN,S_IN,
    input [31:0] PC_IN,
    input [3:0] EXE_CMD_IN,
    input [31:0] Val_Rn_IN, Val_Rm_IN,
    input imm_IN,
    input [11:0] Shift_operand_IN,
    input [23:0] Signed_imm_24_IN,
    input [3:0] Dest_IN,
    input C_ID_in,
    input [3:0] src1, src2,

    output reg WB_EN, MEM_R_EN, MEM_W_EN,B,S,
    output reg [31:0] PC,
    output reg [3:0] EXE_CMD,
    output reg [31:0] Val_Rn, Val_Rm,
    output reg imm,
    output reg [11:0] Shift_operand,
    output reg [23:0] Signed_imm_24,
    output reg [3:0] Dest,
    output reg C_ID_out,
    output reg [3:0] src1_out, src2_out
  );

    always@(posedge clk)begin
        if(rst || flush)begin
            WB_EN <= 0;
            MEM_R_EN <= 0;
            MEM_W_EN <= 0;
            B <= 0;
            S <= 0;
            PC <= 32'd0;
            EXE_CMD <= 4'd0;
            Val_Rn <= 32'd0;
            Val_Rm <= 32'd0;
            imm <= 0;
            Shift_operand <= 12'd0;
            Signed_imm_24 <= 24'd0;
            Dest <= 4'd0;
            C_ID_out <= 1'b0;
            src1_out <= 4'd0;
            src2_out <= 4'd0;
        end

        else if (~freeze) begin
            WB_EN <= WB_EN_IN;
            MEM_R_EN <= MEM_R_EN_IN;
            MEM_W_EN <= MEM_W_EN_IN;
            B <= B_IN;
            S <= S_IN;
            PC <= PC_IN;
            EXE_CMD <= EXE_CMD_IN;
            Val_Rn <= Val_Rn_IN;
            Val_Rm <= Val_Rm_IN;
            imm <= imm_IN;
            Shift_operand <= Shift_operand_IN;
            Signed_imm_24 <= Signed_imm_24_IN;
            Dest <= Dest_IN;
            C_ID_out <= C_ID_in;
            src1_out <= src1;
            src2_out <= src2;
        end


    end

endmodule


