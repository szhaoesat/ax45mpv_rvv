// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_csb (
    out,
    in
);
parameter N = 8;
parameter W = 8;
output [W - 1:0] out;
input [N - 1:0] in;





// dd3a029e rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [N * W - 1:0] s0;
wire [N - 1:1] nds_unused_bit;
assign s0[W - 1:0] = {{W - 1{1'b0}},in[0]};
generate
    genvar i;
    for (i = 1; i < N; i = i + 1) begin:gen_cnt
        assign {nds_unused_bit[i],s0[i * W +:W]} = s0[(i - 1) * W +:W] + {{W - 1{1'b0}},in[i]};
    end
endgenerate
assign out = s0[(N - 1) * W +:W];
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

