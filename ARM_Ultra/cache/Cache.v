module CacheController(input clk, rst,
    input [31:0] address,
    input [31:0] wdata,
    input MEM_R_EN,
    input MEM_W_EN,
    output [31:0] rdata,
    output ready,

    output [31:0] sram_address,
    output [31:0] sram_wdata,
    output hit,
    input [63:0] sram_rdata,
    input sram_ready
    );

    reg [31:0] MemBlock_0_0 [63:0];
    reg [31:0] MemBlock_0_1 [63:0];
    reg [31:0] MemBlock_1_0 [63:0];
    reg [31:0] MemBlock_1_1 [63:0];

    reg [9:0]  TagBlock_0 [63:0];
    reg [9:0]  TagBlock_1 [63:0];


    reg Valid_0 [63:0];
    reg Valid_1 [63:0];

    reg LRU [63:0];

    wire hit0, hit1;
    wire [9:0] tag;
    wire [5:0] index;
    assign tag = address[18:9];
    assign index = address[8:3];

    assign hit0 = (Valid_0[index] & (TagBlock_0[index] == tag)) & MEM_R_EN;
    assign hit1 = (Valid_1[index] & (TagBlock_1[index] == tag)) & MEM_R_EN;
    assign hit = hit0 | hit1 ; 

    assign ready = hit | sram_ready;

    assign rdata = hit0 ? (address[2] ? MemBlock_0_1[index] : MemBlock_0_0[index]) :
                hit1 ? (address[2] ? MemBlock_1_1[index] : MemBlock_1_0[index]) : 
                address[2] ? sram_rdata[63:32] : sram_rdata[31:0];

    assign sram_wdata = wdata; 
    assign sram_address = address;
    assign write = MEM_W_EN & ~MEM_R_EN;

    integer i;
    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 64; i = i + 1) begin
                MemBlock_0_0[i] <= 32'b0;
                MemBlock_0_1[i] <= 32'b0;
                MemBlock_1_0[i] <= 32'b0;
                MemBlock_1_1[i] <= 32'b0;

                TagBlock_0[i] <= 10'b0;
                TagBlock_1[i] <= 10'b0;


                Valid_0 [i] <= 1'b0;
                Valid_1 [i] <= 1'b0;

                LRU [i] <= 1'b0;
            end
        end
        else if(write) begin
            if(LRU[index]) Valid_1[index] <= 1'b0;
            else Valid_0[index] <= 1'b0;
        end    
        else if(hit0) begin
                LRU[index] <= 1'b0;
        end 
        else if(hit1) begin
                LRU[index] <= 1'b1;
        end
        else if(sram_ready & MEM_R_EN) begin
            if (LRU[index]) begin
                LRU[index] <= 1'b0;
                MemBlock_0_1[index] <= sram_rdata[63:32];
                MemBlock_0_0[index] <= sram_rdata[31:0];
                Valid_0[index] <= 1'b1;
                Valid_1[index] <= 1'b0;

                TagBlock_0[index] <= tag;

            end
            else begin
                LRU[index] <= 1'b1;
                MemBlock_1_1[index] <= sram_rdata[63:32];
                MemBlock_1_0[index] <= sram_rdata[31:0];
                Valid_1[index] <= 1'b1;
                Valid_0[index] <= 1'b0;

                TagBlock_1[index] <= tag;
            end
        end

    end


    // reg [1:0] ps=3'b0 , ns = 3'b0;
    // localparam IDLE=3'd0, MISS=3'd1, HIT=3'd2, WRITE=3'd3;
    // always @(*) begin
    //     ns = IDLE;
    //     case(ps)
    //         IDLE:  ns = write ? WRITE :
    //                     hit ? HIT : MISS;
    //         MISS: ns = sram_ready? IDLE : MISS; 
    //         HIT: ns = ready ? IDLE : HIT;
    //         WRITE: ns = sram_ready? IDLE: WRITE;
    //     endcase
    // end

    // always @(*) begin
        
    //     case(ps)
    //         IDLE:  ns = write ? WRITE :
    //                     hit ? HIT : MISS;
    //         MISS: ns = sram_ready? IDLE : MISS; 
    //         HIT: ns = ready ? IDLE : HIT;
    //         WRITE: ns = sram_ready? IDLE: WRITE;
    //     endcase
    // end


    
    // always @(posedge clk) begin
    //     if (rst)
    //         ps <= IDLE;
    //     else
    //         ps <= ns;
    // end
endmodule