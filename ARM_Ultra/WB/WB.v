module WB_stage(input [31:0] MEM_result, ALU_result, 
input MEM_R_en, output [31:0] out);

assign out = MEM_R_en ? MEM_result : ALU_result;

endmodule