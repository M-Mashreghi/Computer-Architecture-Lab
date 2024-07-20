module FW (
    input [3:0] src1, src2, Dest_WB, Dest_MEM,
    input WB_EN_WB, WB_EN_MEM,
    input FW_en,
    
    output reg [1:0] sel_src1, sel_src2
    );

    always @(*) begin
        sel_src1 = 2'b0;
        sel_src2 = 2'b0;
        if (FW_en) begin
            sel_src1 = ((src1 == Dest_MEM) && WB_EN_MEM) ? 2'd1 :
                        ((src1 == Dest_WB) && WB_EN_WB) ? 2'd2 : 2'd0;
            
            sel_src2 = ((src2 == Dest_MEM) && WB_EN_MEM) ? 2'd1 :
                        ((src2 == Dest_WB) && WB_EN_WB) ? 2'd2 : 2'd0;
        end
    end

endmodule