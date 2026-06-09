// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vor (
    out,
    in
);
parameter N = 2;
parameter W = 8;
output [W - 1:0] out;
input [(N * W) - 1:0] in;





// 85a95a84 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [(N * W) - 1:0] s0;
assign s0[W - 1:0] = in[W - 1:0];
generate
    genvar i;
    for (i = 1; i < N; i = i + 1) begin:gen_tmp
        assign s0[i * W +:W] = s0[(i - 1) * W +:W] | in[i * W +:W];
    end
endgenerate
assign out = s0[(N - 1) * W +:W];
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

