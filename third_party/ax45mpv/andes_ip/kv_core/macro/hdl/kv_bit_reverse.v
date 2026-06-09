// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_bit_reverse (
    out,
    in
);
parameter W = 8;
output [W - 1:0] out;
input [W - 1:0] in;





// a97d9754 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


generate
    genvar i;
    for (i = 0; i < W; i = i + 1) begin:gen_bit
        assign out[i] = in[W - 1 - i];
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

