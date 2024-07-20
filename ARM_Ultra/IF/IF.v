module IF #(parameter WIDTH=32) (input clk, rst, flush, freeze, input [31:0] branch_addr, output [WIDTH-1 :0] inst, PC);
    wire [WIDTH-1 : 0] addr, mux_out;
    Mux #(WIDTH) M1(flush, PC,branch_addr, mux_out);
    RegPC #(WIDTH) RP(clk, rst, freeze , mux_out, addr);
    Instmem #(WIDTH, WIDTH) IM(addr, inst);
    PC_adder #(WIDTH) A1(addr, 32'd4, PC);

endmodule