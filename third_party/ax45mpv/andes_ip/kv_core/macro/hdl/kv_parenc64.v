// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_parenc64 (
    data,
    dataout
);
input [63:0] data;
output [7:0] dataout;





// 742f5928 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


assign dataout[0] = ^data[7:0];
assign dataout[1] = ^data[15:8];
assign dataout[2] = ^data[23:16];
assign dataout[3] = ^data[31:24];
assign dataout[4] = ^data[39:32];
assign dataout[5] = ^data[47:40];
assign dataout[6] = ^data[55:48];
assign dataout[7] = ^data[63:56];
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

