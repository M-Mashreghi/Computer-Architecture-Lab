module ControlUnit (input S_in, input [3 : 0]OPCode, input [1 : 0] Mode, output reg S_out, B, MEM_R_EN, MEM_W_EN, WB_EN, output reg [3 : 0] EXE_CMD);
    localparam NOP = 4'b0000;
    localparam MOV = 4'b1101;
    localparam MVN = 4'b1111;
    localparam ADD = 4'b0100;
    localparam ADC = 4'b0101;
    localparam SUB = 4'b0010;
    localparam SBC = 4'b0110;
    localparam AND = 4'b0000;
    localparam ORR = 4'b1100;
    localparam EOR = 4'b0001;
    localparam CMP = 4'b1010;
    localparam TST = 4'b1000;
    localparam LDR = 4'b0100;
    localparam STR = 4'b0100;
    

    always @(S_in, OPCode, Mode)begin
        {EXE_CMD, WB_EN, MEM_W_EN, MEM_R_EN, B} = 8'b0;
        S_out = S_in;
        if(Mode == 2'b00) begin
            case(OPCode)
                MOV: {EXE_CMD, WB_EN} = {4'b0001, 1'b1};
                MVN: {EXE_CMD, WB_EN} = {4'b1001, 1'b1};
                ADD: {EXE_CMD, WB_EN} = {4'b0010, 1'b1};
                ADC: {EXE_CMD, WB_EN} = {4'b0011, 1'b1};
                SUB: {EXE_CMD, WB_EN} = {4'b0100, 1'b1};
                SBC: {EXE_CMD, WB_EN} = {4'b0101, 1'b1};
                AND: {EXE_CMD, WB_EN} = {4'b0110, 1'b1};
                ORR: {EXE_CMD, WB_EN} = {4'b0111, 1'b1};
                EOR: {EXE_CMD, WB_EN} = {4'b1000, 1'b1};
                CMP: {EXE_CMD, WB_EN, S_out} = {4'b0100, 1'b0, 1'b1};
                TST: {EXE_CMD, WB_EN, S_out} = {4'b0110, 1'b0, 1'b1};
					 default: {EXE_CMD, WB_EN, S_out} = 6'b0;
            endcase
        end
        else if (Mode == 2'b01) begin
            case({OPCode, S_in})
                {LDR, 1'b1} : {EXE_CMD, WB_EN, MEM_R_EN, S_out} = {4'b0010, 1'b1, 1'b1, 1'b1};
                {STR, 1'b0} : {EXE_CMD, WB_EN, MEM_W_EN, S_out} = {4'b0010, 1'b0, 1'b1, 1'b0};
            endcase
        end
        else if (Mode == 2'b10) begin
            case(OPCode[3])
                1'b0: B = 1'b1;
            endcase
        end
        
    end
    



endmodule