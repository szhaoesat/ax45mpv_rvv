// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_muxn (
    out,
    sel,
    in
);
parameter N = 2;
parameter W = 8;
localparam SW = $unsigned($clog2(N));
output [W - 1:0] out;
input [SW - 1:0] sel;
input [(N * W) - 1:0] in;





// 0520e310 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [(N * W) - 1:0] tmp;
wire [N - 1:0] sel_onehot;
wire [N - 1:0] nds_unused_sel_onehot;
assign {nds_unused_sel_onehot,sel_onehot} = {{(N - 1){1'b0}},1'b1} << sel;
assign tmp[W - 1:0] = {W{sel_onehot[0]}} & in[W - 1:0];
generate
    genvar i;
    for (i = 1; i < N; i = i + 1) begin:gen_tmp
        assign tmp[i * W +:W] = tmp[(i - 1) * W +:W] | ({W{sel_onehot[i]}} & in[i * W +:W]);
    end
endgenerate
assign out = tmp[(N - 1) * W +:W];
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

