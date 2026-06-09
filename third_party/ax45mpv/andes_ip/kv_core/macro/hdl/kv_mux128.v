// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_mux128 (
    out,
    sel,
    in
);
parameter W = 8;
output [W - 1:0] out;
input [6:0] sel;
input [(128 * W) - 1:0] in;





// aa99090a rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [W - 1:0] out;
always @* begin
    case (sel)
        7'd0: out = in[0 * W +:W];
        7'd1: out = in[1 * W +:W];
        7'd2: out = in[2 * W +:W];
        7'd3: out = in[3 * W +:W];
        7'd4: out = in[4 * W +:W];
        7'd5: out = in[5 * W +:W];
        7'd6: out = in[6 * W +:W];
        7'd7: out = in[7 * W +:W];
        7'd8: out = in[8 * W +:W];
        7'd9: out = in[9 * W +:W];
        7'd10: out = in[10 * W +:W];
        7'd11: out = in[11 * W +:W];
        7'd12: out = in[12 * W +:W];
        7'd13: out = in[13 * W +:W];
        7'd14: out = in[14 * W +:W];
        7'd15: out = in[15 * W +:W];
        7'd16: out = in[16 * W +:W];
        7'd17: out = in[17 * W +:W];
        7'd18: out = in[18 * W +:W];
        7'd19: out = in[19 * W +:W];
        7'd20: out = in[20 * W +:W];
        7'd21: out = in[21 * W +:W];
        7'd22: out = in[22 * W +:W];
        7'd23: out = in[23 * W +:W];
        7'd24: out = in[24 * W +:W];
        7'd25: out = in[25 * W +:W];
        7'd26: out = in[26 * W +:W];
        7'd27: out = in[27 * W +:W];
        7'd28: out = in[28 * W +:W];
        7'd29: out = in[29 * W +:W];
        7'd30: out = in[30 * W +:W];
        7'd31: out = in[31 * W +:W];
        7'd32: out = in[32 * W +:W];
        7'd33: out = in[33 * W +:W];
        7'd34: out = in[34 * W +:W];
        7'd35: out = in[35 * W +:W];
        7'd36: out = in[36 * W +:W];
        7'd37: out = in[37 * W +:W];
        7'd38: out = in[38 * W +:W];
        7'd39: out = in[39 * W +:W];
        7'd40: out = in[40 * W +:W];
        7'd41: out = in[41 * W +:W];
        7'd42: out = in[42 * W +:W];
        7'd43: out = in[43 * W +:W];
        7'd44: out = in[44 * W +:W];
        7'd45: out = in[45 * W +:W];
        7'd46: out = in[46 * W +:W];
        7'd47: out = in[47 * W +:W];
        7'd48: out = in[48 * W +:W];
        7'd49: out = in[49 * W +:W];
        7'd50: out = in[50 * W +:W];
        7'd51: out = in[51 * W +:W];
        7'd52: out = in[52 * W +:W];
        7'd53: out = in[53 * W +:W];
        7'd54: out = in[54 * W +:W];
        7'd55: out = in[55 * W +:W];
        7'd56: out = in[56 * W +:W];
        7'd57: out = in[57 * W +:W];
        7'd58: out = in[58 * W +:W];
        7'd59: out = in[59 * W +:W];
        7'd60: out = in[60 * W +:W];
        7'd61: out = in[61 * W +:W];
        7'd62: out = in[62 * W +:W];
        7'd63: out = in[63 * W +:W];
        7'd64: out = in[64 * W +:W];
        7'd65: out = in[65 * W +:W];
        7'd66: out = in[66 * W +:W];
        7'd67: out = in[67 * W +:W];
        7'd68: out = in[68 * W +:W];
        7'd69: out = in[69 * W +:W];
        7'd70: out = in[70 * W +:W];
        7'd71: out = in[71 * W +:W];
        7'd72: out = in[72 * W +:W];
        7'd73: out = in[73 * W +:W];
        7'd74: out = in[74 * W +:W];
        7'd75: out = in[75 * W +:W];
        7'd76: out = in[76 * W +:W];
        7'd77: out = in[77 * W +:W];
        7'd78: out = in[78 * W +:W];
        7'd79: out = in[79 * W +:W];
        7'd80: out = in[80 * W +:W];
        7'd81: out = in[81 * W +:W];
        7'd82: out = in[82 * W +:W];
        7'd83: out = in[83 * W +:W];
        7'd84: out = in[84 * W +:W];
        7'd85: out = in[85 * W +:W];
        7'd86: out = in[86 * W +:W];
        7'd87: out = in[87 * W +:W];
        7'd88: out = in[88 * W +:W];
        7'd89: out = in[89 * W +:W];
        7'd90: out = in[90 * W +:W];
        7'd91: out = in[91 * W +:W];
        7'd92: out = in[92 * W +:W];
        7'd93: out = in[93 * W +:W];
        7'd94: out = in[94 * W +:W];
        7'd95: out = in[95 * W +:W];
        7'd96: out = in[96 * W +:W];
        7'd97: out = in[97 * W +:W];
        7'd98: out = in[98 * W +:W];
        7'd99: out = in[99 * W +:W];
        7'd100: out = in[100 * W +:W];
        7'd101: out = in[101 * W +:W];
        7'd102: out = in[102 * W +:W];
        7'd103: out = in[103 * W +:W];
        7'd104: out = in[104 * W +:W];
        7'd105: out = in[105 * W +:W];
        7'd106: out = in[106 * W +:W];
        7'd107: out = in[107 * W +:W];
        7'd108: out = in[108 * W +:W];
        7'd109: out = in[109 * W +:W];
        7'd110: out = in[110 * W +:W];
        7'd111: out = in[111 * W +:W];
        7'd112: out = in[112 * W +:W];
        7'd113: out = in[113 * W +:W];
        7'd114: out = in[114 * W +:W];
        7'd115: out = in[115 * W +:W];
        7'd116: out = in[116 * W +:W];
        7'd117: out = in[117 * W +:W];
        7'd118: out = in[118 * W +:W];
        7'd119: out = in[119 * W +:W];
        7'd120: out = in[120 * W +:W];
        7'd121: out = in[121 * W +:W];
        7'd122: out = in[122 * W +:W];
        7'd123: out = in[123 * W +:W];
        7'd124: out = in[124 * W +:W];
        7'd125: out = in[125 * W +:W];
        7'd126: out = in[126 * W +:W];
        7'd127: out = in[127 * W +:W];
        default: out = {W{1'b0}};
    endcase
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

