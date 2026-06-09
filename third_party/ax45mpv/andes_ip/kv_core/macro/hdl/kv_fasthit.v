// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_fasthit (
    split_mode,
    a,
    b,
    k,
    hit
);
parameter M = 33;
parameter N = 12;
parameter SPLIT = 0;
input split_mode;
input [M - 1:0] a;
input [M - 1:0] b;
input [M - 1:N] k;
output hit;





// 69be1cbf rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [M - 1:N] s0;
wire [M - 1:N] s1;
wire [N - 1:0] s2;
wire s3;
generate
    genvar i;
    for (i = N; i < M; i = i + 1) begin:gen_hit_dlm_csa_c
        assign s1[i] = (~a[i] & ~b[i] & ~k[i]) | (~a[i] & b[i] & k[i]) | (a[i] & ~b[i] & k[i]) | (a[i] & b[i] & ~k[i]);
        assign s0[i] = (a[i] & b[i]) | (a[i] & ~k[i]) | (b[i] & ~k[i]);
    end
endgenerate
assign {s3,s2} = {1'b0,a[N - 1:0]} + {1'b0,b[N - 1:0]};
generate
    if (SPLIT == 1) begin:gen_split
        assign hit = (~s1[M - 1:N] == {s0[M - 2:N],s3}) & ~(split_mode & s2[N - 1]);
    end
    else begin:gen_split_stub
        assign hit = (~s1[M - 1:N] == {s0[M - 2:N],s3});
    end
endgenerate
wire nds_unused_signals = |{s2,split_mode};
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

