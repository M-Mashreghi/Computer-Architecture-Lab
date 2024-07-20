module adder(input [31 : 0] op1, input [23 : 0] op2, output [31:0] out );
    
    assign out = op1 + {{6{op2[23]}},op2, 2'b0};

endmodule