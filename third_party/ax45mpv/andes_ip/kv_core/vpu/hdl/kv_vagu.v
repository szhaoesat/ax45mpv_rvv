// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vagu (
    addr_op0,
    addr_op1,
    addr_out
);
parameter XLEN = 64;
input [XLEN - 1:0] addr_op0;
input [XLEN - 1:0] addr_op1;
output [XLEN - 1:0] addr_out;





// 6611929a rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


kv_nooverflow_add #(
    .EW(XLEN)
) u_kv_vaddr (
    .s(addr_out),
    .a(addr_op0),
    .b(addr_op1)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

