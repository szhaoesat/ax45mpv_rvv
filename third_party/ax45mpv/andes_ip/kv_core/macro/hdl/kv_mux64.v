// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_mux64 (
    out,
    sel,
    in
);
parameter W = 8;
output [W - 1:0] out;
input [5:0] sel;
input [(64 * W) - 1:0] in;





// a6e20823 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [W - 1:0] out;
always @* begin
    case (sel)
        6'd0: out = in[0 * W +:W];
        6'd1: out = in[1 * W +:W];
        6'd2: out = in[2 * W +:W];
        6'd3: out = in[3 * W +:W];
        6'd4: out = in[4 * W +:W];
        6'd5: out = in[5 * W +:W];
        6'd6: out = in[6 * W +:W];
        6'd7: out = in[7 * W +:W];
        6'd8: out = in[8 * W +:W];
        6'd9: out = in[9 * W +:W];
        6'd10: out = in[10 * W +:W];
        6'd11: out = in[11 * W +:W];
        6'd12: out = in[12 * W +:W];
        6'd13: out = in[13 * W +:W];
        6'd14: out = in[14 * W +:W];
        6'd15: out = in[15 * W +:W];
        6'd16: out = in[16 * W +:W];
        6'd17: out = in[17 * W +:W];
        6'd18: out = in[18 * W +:W];
        6'd19: out = in[19 * W +:W];
        6'd20: out = in[20 * W +:W];
        6'd21: out = in[21 * W +:W];
        6'd22: out = in[22 * W +:W];
        6'd23: out = in[23 * W +:W];
        6'd24: out = in[24 * W +:W];
        6'd25: out = in[25 * W +:W];
        6'd26: out = in[26 * W +:W];
        6'd27: out = in[27 * W +:W];
        6'd28: out = in[28 * W +:W];
        6'd29: out = in[29 * W +:W];
        6'd30: out = in[30 * W +:W];
        6'd31: out = in[31 * W +:W];
        6'd32: out = in[32 * W +:W];
        6'd33: out = in[33 * W +:W];
        6'd34: out = in[34 * W +:W];
        6'd35: out = in[35 * W +:W];
        6'd36: out = in[36 * W +:W];
        6'd37: out = in[37 * W +:W];
        6'd38: out = in[38 * W +:W];
        6'd39: out = in[39 * W +:W];
        6'd40: out = in[40 * W +:W];
        6'd41: out = in[41 * W +:W];
        6'd42: out = in[42 * W +:W];
        6'd43: out = in[43 * W +:W];
        6'd44: out = in[44 * W +:W];
        6'd45: out = in[45 * W +:W];
        6'd46: out = in[46 * W +:W];
        6'd47: out = in[47 * W +:W];
        6'd48: out = in[48 * W +:W];
        6'd49: out = in[49 * W +:W];
        6'd50: out = in[50 * W +:W];
        6'd51: out = in[51 * W +:W];
        6'd52: out = in[52 * W +:W];
        6'd53: out = in[53 * W +:W];
        6'd54: out = in[54 * W +:W];
        6'd55: out = in[55 * W +:W];
        6'd56: out = in[56 * W +:W];
        6'd57: out = in[57 * W +:W];
        6'd58: out = in[58 * W +:W];
        6'd59: out = in[59 * W +:W];
        6'd60: out = in[60 * W +:W];
        6'd61: out = in[61 * W +:W];
        6'd62: out = in[62 * W +:W];
        6'd63: out = in[63 * W +:W];
        default: out = {W{1'b0}};
    endcase
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

