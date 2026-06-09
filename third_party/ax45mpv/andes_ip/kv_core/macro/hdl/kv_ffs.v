// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_ffs (
    out,
    in
);
parameter WIDTH = 8;
output [WIDTH - 1:0] out;
input [WIDTH - 1:0] in;





// b34f0fcb rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


assign out[0] = in[0];
generate
    genvar i;
    for (i = 1; i < WIDTH; i = i + 1) begin:gen_ffs
        assign out[i] = in[i] & ~|in[0 +:i];
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

