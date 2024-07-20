module RegPC #(parameter dataSize=32) (input clk, rst, freaze, input [dataSize-1:0] PI, output [dataSize-1:0] PO);
    reg [dataSize-1:0] data = 32'd0;
    
    always @(posedge clk, posedge rst) begin 
        if (rst) 
            data <= {dataSize{1'b0}};
        else if(~freaze) data <= PI;
    end

    assign PO = data;

endmodule