// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_mux (
    out,
    sel,
    in
);
parameter N = 2;
parameter W = 8;
localparam SW = $unsigned($clog2(N));
output [W - 1:0] out;
input [SW - 1:0] sel;
input [(N * W) - 1:0] in;





// 34b3e9d6 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


generate
    if (N == 8) begin:gen_mux8
        kv_mux8 #(
            .W(W)
        ) u_mux8 (
            .out(out),
            .sel(sel),
            .in(in)
        );
    end
    else if (N == 16) begin:gen_mux16
        kv_mux16 #(
            .W(W)
        ) u_mux16 (
            .out(out),
            .sel(sel),
            .in(in)
        );
    end
    else if (N == 32) begin:gen_mux32
        kv_mux32 #(
            .W(W)
        ) u_mux32 (
            .out(out),
            .sel(sel),
            .in(in)
        );
    end
    else if (N == 64) begin:gen_mux64
        kv_mux64 #(
            .W(W)
        ) u_mux64 (
            .out(out),
            .sel(sel),
            .in(in)
        );
    end
    else if (N == 128) begin:gen_mux128
        kv_mux128 #(
            .W(W)
        ) u_mux128 (
            .out(out),
            .sel(sel),
            .in(in)
        );
    end
    else begin:gen_muxn
        kv_muxn #(
            .N(N),
            .W(W)
        ) u_muxn (
            .out(out),
            .sel(sel),
            .in(in)
        );
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

