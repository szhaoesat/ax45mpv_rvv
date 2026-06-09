// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_bin2onehot (
    out,
    in
);
parameter N = 8;
localparam W = $unsigned($clog2(N));
output [N - 1:0] out;
input [W - 1:0] in;





// 49fb97d9 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [N - 1:0] nds_unused_zeros;
assign {nds_unused_zeros,out} = {{(N - 1){1'b0}},1'b1} << in;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

