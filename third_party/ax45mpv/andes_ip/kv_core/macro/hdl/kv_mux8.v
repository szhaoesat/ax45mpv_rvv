// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_mux8 (
    out,
    sel,
    in
);
parameter W = 8;
output [W - 1:0] out;
input [2:0] sel;
input [(8 * W) - 1:0] in;





// 37acc3b7 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [W - 1:0] out;
always @* begin
    case (sel)
        3'd0: out = in[0 * W +:W];
        3'd1: out = in[1 * W +:W];
        3'd2: out = in[2 * W +:W];
        3'd3: out = in[3 * W +:W];
        3'd4: out = in[4 * W +:W];
        3'd5: out = in[5 * W +:W];
        3'd6: out = in[6 * W +:W];
        3'd7: out = in[7 * W +:W];
        default: out = {W{1'b0}};
    endcase
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

