module ALU (input [31:0] Val1, Val2, input [3:0] EXE_CMD, input C, output reg [31:0] ALU_Res,output reg Cout, output Z, N, V);

    always @(*) begin
		{Cout, ALU_Res} = 33'b0;
        case (EXE_CMD)
            4'b0001: ALU_Res <= Val2;
            4'b1001: ALU_Res <= ~Val2;
            4'b0010: {Cout, ALU_Res} <= Val1+Val2;
            4'b0011: {Cout, ALU_Res} <= Val1+Val2+ {31'b0 , C};
            4'b0100: {Cout, ALU_Res} <= Val1 - Val2;
            4'b0101: {Cout, ALU_Res} <= Val1 - Val2 - {31'b0, (~C)};
            4'b0110: ALU_Res <= Val1 & Val2;
            4'b0111: ALU_Res <= Val1 | Val2;
            4'b1000: ALU_Res <= Val1 ^ Val2;
            default: {Cout, ALU_Res} <= 33'b0;
        endcase
    end

    assign N = ALU_Res[31];
    assign Z =  ~(|ALU_Res);
    assign V = ((EXE_CMD==4'b0010)||((EXE_CMD==4'b0011))) ? (ALU_Res[31]&&(~Val2[31])&&(~Val1[31]))||((~ALU_Res[31])&&(Val2[31])&&(Val1[31])) :
               ((EXE_CMD==4'b0100)||((EXE_CMD==4'b0101))) ? ((~ALU_Res[31])&&(~Val2[31])&&(Val1[31]))||((ALU_Res[31])&&(Val2[31])&&(~Val1[31])):
               1'b0;
endmodule