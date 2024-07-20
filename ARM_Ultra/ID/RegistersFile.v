module RegistersFile #(parameter WIDTH, parameter SIZE) 
    (input clk, rst, freeze, WB_WB_EN,
     input[$clog2(SIZE)-1 : 0] src1addr, src2addr , Dest_wb,
    input [WIDTH-1:0] WB_Value, output [WIDTH-1:0] Val_Rn, Val_Rm);
    reg [WIDTH-1:0] regfile [SIZE-1:0];
    
    assign Val_Rn = regfile[src1addr];
    assign Val_Rm = regfile[src2addr];
    
    integer i;

    always @(negedge clk) begin
        if (rst) begin
            for (i = 0; i < SIZE ; i = i+1) begin
                regfile[i] <= i;
            end
        end
        else if (WB_WB_EN)
            regfile[Dest_wb] <= WB_Value;

    end

initial begin
    for (i = 0; i < SIZE ; i = i+1) begin
        regfile[i] <= i;
    end
end




endmodule