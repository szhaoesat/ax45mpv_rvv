// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_parenc32 (
    data,
    dataout
);
input [31:0] data;
output [3:0] dataout;





// 41ccc45e rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


assign dataout[0] = ^data[7:0];
assign dataout[1] = ^data[15:8];
assign dataout[2] = ^data[23:16];
assign dataout[3] = ^data[31:24];
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

