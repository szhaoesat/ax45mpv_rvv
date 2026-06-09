// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_fls (
    out,
    in
);
parameter WIDTH = 8;
output [WIDTH - 1:0] out;
input [WIDTH - 1:0] in;





// e07afb19 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


assign out[WIDTH - 1] = in[WIDTH - 1];
generate
    genvar i;
    for (i = 1; i < WIDTH; i = i + 1) begin:gen_fls
        assign out[(WIDTH - 1) - i] = in[(WIDTH - 1) - i] & ~|in[(WIDTH - 1) -:i];
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

