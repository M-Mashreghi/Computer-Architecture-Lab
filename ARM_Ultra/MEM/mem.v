module Memory(
    input clk, MEMread, MEMwrite,
    input [31 : 0] address, data, 
    output [31 : 0] MEM_result
);
    reg [31 : 0] mem [63 : 0];
    wire [31:0] TrueAddr = (address >> 2) - 32'd256;
    always@(posedge clk)begin
        if(MEMwrite)
            mem[TrueAddr] <= data;
    end

    assign MEM_result = MEMread ? mem[TrueAddr] : 32'bz;

endmodule