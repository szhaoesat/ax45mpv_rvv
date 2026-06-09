// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_mux32 (
    out,
    sel,
    in
);
parameter W = 8;
output [W - 1:0] out;
input [4:0] sel;
input [(32 * W) - 1:0] in;





// 71e654e7 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [W - 1:0] out;
always @* begin
    case (sel)
        5'd0: out = in[0 * W +:W];
        5'd1: out = in[1 * W +:W];
        5'd2: out = in[2 * W +:W];
        5'd3: out = in[3 * W +:W];
        5'd4: out = in[4 * W +:W];
        5'd5: out = in[5 * W +:W];
        5'd6: out = in[6 * W +:W];
        5'd7: out = in[7 * W +:W];
        5'd8: out = in[8 * W +:W];
        5'd9: out = in[9 * W +:W];
        5'd10: out = in[10 * W +:W];
        5'd11: out = in[11 * W +:W];
        5'd12: out = in[12 * W +:W];
        5'd13: out = in[13 * W +:W];
        5'd14: out = in[14 * W +:W];
        5'd15: out = in[15 * W +:W];
        5'd16: out = in[16 * W +:W];
        5'd17: out = in[17 * W +:W];
        5'd18: out = in[18 * W +:W];
        5'd19: out = in[19 * W +:W];
        5'd20: out = in[20 * W +:W];
        5'd21: out = in[21 * W +:W];
        5'd22: out = in[22 * W +:W];
        5'd23: out = in[23 * W +:W];
        5'd24: out = in[24 * W +:W];
        5'd25: out = in[25 * W +:W];
        5'd26: out = in[26 * W +:W];
        5'd27: out = in[27 * W +:W];
        5'd28: out = in[28 * W +:W];
        5'd29: out = in[29 * W +:W];
        5'd30: out = in[30 * W +:W];
        5'd31: out = in[31 * W +:W];
        default: out = {W{1'b0}};
    endcase
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

