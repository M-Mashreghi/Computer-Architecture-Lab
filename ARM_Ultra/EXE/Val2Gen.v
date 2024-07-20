module Val2Gen(input [31:0] Val_Rm, input imm, input selmem, input [11:0] Shift_operand , output reg[31:0] Val2 );
    wire [4 : 0] shift_imm; 
    wire [1 : 0] shift;
    wire [4 : 0] rotate;
    wire [31 : 0] temp;
	 wire [63 : 0] rotate_temp;
	 wire [63 : 0] shift_temp;
    wire [7 : 0] immed_8;

    assign immed_8 = Shift_operand[7 : 0];
    assign shift = Shift_operand[6:5];
    assign shift_imm = Shift_operand[11:7];
    assign rotate = shift_imm[4 : 1] << 1;
	 assign rotate_temp = {{24{1'b0}},immed_8, {24{1'b0}},immed_8} >> rotate;
    assign shift_temp =  {Val_Rm, Val_Rm} >> shift_imm;


    always@(*)begin
        if(selmem) begin
            ///////////////////////////////CHECK_HERE///////////////////////////
            Val2 =  {{20{Shift_operand[11]}} ,Shift_operand};
            //Val2 = Shift_operand;
        end
        else if(imm) begin 
            Val2 = rotate_temp[31 : 0];
        end
        else begin
           Val2 = (shift == 2'b00) ? Val_Rm << shift_imm :
                            (shift == 2'b01) ? Val_Rm >> shift_imm:
                            (shift == 2'b10) ? Val_Rm >>> shift_imm :
                            (shift == 2'b11) ? shift_temp[31 : 0] : 32'b0;
        end

        /*case({selmem, imm})
            2'b00 : Val2 =  (shift == 2'b00) ? Val_Rm << shift_imm :
                            (shift == 2'b01) ? Val_Rm >> shift_imm:
                            (shift == 2'b10) ? Val_Rm >>> shift_imm :
                            (shift == 2'b11) ? shift_temp[31 : 0] : 32'b0;
            2'b01 : Val2 = rotate_temp[31 : 0];
            2'b10 : Val2 = Val_Rm;
            2'b11 : Val2 = Val_Rm;
				
        endcase
*/
    end
endmodule