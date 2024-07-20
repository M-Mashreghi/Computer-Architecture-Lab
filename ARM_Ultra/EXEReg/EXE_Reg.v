module EXE_STAGE_REG(
    input clk,rst,
    input WB_EN_in, MEM_R_EN_in, MEM_W_EN_in, 
    input [31:0] ALU_result_in,Val_RM_in,
    input [3:0] Dest_in,ST_val_in,
    input flush, freeze,

    output reg WB_EN, MEM_R_EN, MEM_W_EN,
    output reg [31:0] ALU_result, Val_RM,
    output reg [3:0] Dest,ST_val

);

always@(posedge clk)
    if(rst || flush)begin
        WB_EN <=1'b0;
        MEM_R_EN <= 1'b0;
        MEM_W_EN <= 1'b0;
        ALU_result <= 32'b0;
        Val_RM <= 32'b0;
        ST_val <= 4'b0;
        Dest <= 4'b0;
    end
    else if (~freeze) begin
        Val_RM <= Val_RM_in;
        WB_EN <= WB_EN_in;
        MEM_R_EN <= MEM_R_EN_in;
        MEM_W_EN <= MEM_W_EN_in;
        ALU_result <= ALU_result_in;
        ST_val <= ST_val_in;
        Dest <= Dest_in;
    end




endmodule