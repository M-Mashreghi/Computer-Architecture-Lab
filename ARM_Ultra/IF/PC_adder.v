module PC_adder #(parameter dataSize=32) (input [dataSize-1:0] op1, op2, output [dataSize-1:0] out );
    assign out = op1 + op2;

endmodule