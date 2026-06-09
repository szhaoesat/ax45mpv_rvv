// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_mux16 (
    out,
    sel,
    in
);
parameter W = 8;
output [W - 1:0] out;
input [3:0] sel;
input [(16 * W) - 1:0] in;





// 1a123ca4 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [W - 1:0] out;
always @* begin
    case (sel)
        4'd0: out = in[0 * W +:W];
        4'd1: out = in[1 * W +:W];
        4'd2: out = in[2 * W +:W];
        4'd3: out = in[3 * W +:W];
        4'd4: out = in[4 * W +:W];
        4'd5: out = in[5 * W +:W];
        4'd6: out = in[6 * W +:W];
        4'd7: out = in[7 * W +:W];
        4'd8: out = in[8 * W +:W];
        4'd9: out = in[9 * W +:W];
        4'd10: out = in[10 * W +:W];
        4'd11: out = in[11 * W +:W];
        4'd12: out = in[12 * W +:W];
        4'd13: out = in[13 * W +:W];
        4'd14: out = in[14 * W +:W];
        4'd15: out = in[15 * W +:W];
        default: out = {W{1'b0}};
    endcase
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

