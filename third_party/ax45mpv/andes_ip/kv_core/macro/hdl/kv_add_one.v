// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_add_one (
    d,
    q
);
parameter W = 8;
input [W - 1:0] d;
output [W - 1:0] q;





// 30a55ab3 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [W - 1:0] s0;
kv_zero_ext #(
    .OW(W),
    .IW(1)
) u_one_zext (
    .out(s0),
    .in(1'b1)
);
kv_nooverflow_add #(
    .EW(W)
) u_add (
    .a(d),
    .b(s0),
    .s(q)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

