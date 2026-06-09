// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_gen_ones (
    en,
    in,
    num,
    out
);
parameter MAX_NUM = 8;
parameter N = 8;
parameter W = 4;
input en;
input [N - 1:0] in;
input [W - 1:0] num;
output [N - 1:0] out;





// dc111277 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [2 ** W - 1:0] gen_max_num;
wire [MAX_NUM:0] gen_ones;
wire [N * 2 - 1:0] ext_out;
wire [$clog2(N) - 1:0] shift_num;
kv_onehot2bin #(
    .N(N)
) u_shift_num (
    .out(shift_num),
    .in(in)
);
assign gen_max_num = 1'b1 << num;
assign gen_ones = gen_max_num[MAX_NUM:0] - {{MAX_NUM{1'b0}},1'b1};
assign ext_out = {{N * 2 - MAX_NUM{1'b0}},gen_ones[MAX_NUM - 1:0]} << {{N * 2 - $clog2(N){1'b0}},shift_num};
assign out = {N{en}} & (ext_out[N * 2 - 1:N] | ext_out[N - 1:0]);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

