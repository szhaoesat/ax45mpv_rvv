// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_nooverflow_add (
    a,
    b,
    s
);
parameter EW = 32;
localparam CW = 1;
input [(EW - 1):0] a;
input [(EW - 1):0] b;
output [(EW - 1):0] s;





// 3ef7ec76 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [(CW - 1):0] nds_unused_c;
assign {nds_unused_c,s} = a + b;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

