module Status_Reg(input clk, input[3:0] status_bit, input S, output N, Z, C, V);
    reg NR = 0, ZR = 0, CR = 0, VR = 0;
    always @(negedge clk) begin
        if (S) begin
            NR <= status_bit[3];
            ZR <= status_bit[2];
            CR <= status_bit[1];
            VR <= status_bit[0];
        end
    end
    assign {N, Z, C, V} = {NR, ZR, CR, VR};
    

endmodule