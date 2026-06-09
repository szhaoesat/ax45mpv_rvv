// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_pardec32 (
    check_en,
    data,
    parin,
    error
);
input check_en;
input [31:0] data;
input [3:0] parin;
output error;





// f50c098e rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [3:0] s0;
assign s0[0] = ^data[7:0] ^ parin[0];
assign s0[1] = ^data[15:8] ^ parin[1];
assign s0[2] = ^data[23:16] ^ parin[2];
assign s0[3] = ^data[31:24] ^ parin[3];
assign error = |s0 & check_en;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

