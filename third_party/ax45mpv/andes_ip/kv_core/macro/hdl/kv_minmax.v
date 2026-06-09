// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_minmax (
    a,
    b,
    tc,
    min_max,
    result
);
parameter WIDTH = 64;
input [WIDTH - 1:0] a;
input [WIDTH - 1:0] b;
input tc;
input min_max;
output [WIDTH - 1:0] result;





// 1778f622 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [WIDTH:0] s0 = {a[WIDTH - 1] & tc,a};
wire [WIDTH:0] s1 = {b[WIDTH - 1] & tc,b};
wire s2 = ($signed(s0) < $signed(s1));
assign result = (s2 ^ min_max) ? a : b;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

