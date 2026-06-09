// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_novf_adder_op3 (
    op1,
    op2,
    op3,
    sum
);
parameter EW = 32;
localparam CW = 2;
input [(EW - 1):0] op1;
input [(EW - 1):0] op2;
input [(EW - 1):0] op3;
output [(EW - 1):0] sum;





// 76f7eae4 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [(CW - 1):0] nds_unused_c;
assign {nds_unused_c,sum} = op1 + op2 + op3;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

