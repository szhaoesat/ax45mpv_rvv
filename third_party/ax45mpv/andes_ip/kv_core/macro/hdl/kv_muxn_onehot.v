// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_muxn_onehot (
    out,
    sel,
    in
);
parameter N = 2;
parameter W = 8;
output [W - 1:0] out;
input [N - 1:0] sel;
input [(N * W) - 1:0] in;





// ab29c594 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [(N * W) - 1:0] s0;
assign s0[W - 1:0] = {W{sel[0]}} & in[W - 1:0];
generate
    genvar i;
    for (i = 1; i < N; i = i + 1) begin:gen_tmp
        assign s0[i * W +:W] = s0[(i - 1) * W +:W] | ({W{sel[i]}} & in[i * W +:W]);
    end
endgenerate
assign out = s0[(N - 1) * W +:W];
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

