// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_mux_onehot (
    out,
    sel,
    in
);
parameter N = 2;
parameter W = 8;
output [W - 1:0] out;
input [N - 1:0] sel;
input [(N * W) - 1:0] in;





// 2e9e8c9c rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


generate
    if (N == 2) begin:gen_mux2
        assign out = ({W{sel[0]}} & in[0 * W +:W]) | ({W{sel[1]}} & in[1 * W +:W]);
    end
    else if (N == 3) begin:gen_mux3
        assign out = ({W{sel[0]}} & in[0 * W +:W]) | ({W{sel[1]}} & in[1 * W +:W]) | ({W{sel[2]}} & in[2 * W +:W]);
    end
    else if (N == 4) begin:gen_mux4
        assign out = ({W{sel[0]}} & in[0 * W +:W]) | ({W{sel[1]}} & in[1 * W +:W]) | ({W{sel[2]}} & in[2 * W +:W]) | ({W{sel[3]}} & in[3 * W +:W]);
    end
    else if (N == 5) begin:gen_mux5
        assign out = ({W{sel[0]}} & in[0 * W +:W]) | ({W{sel[1]}} & in[1 * W +:W]) | ({W{sel[2]}} & in[2 * W +:W]) | ({W{sel[3]}} & in[3 * W +:W]) | ({W{sel[4]}} & in[4 * W +:W]);
    end
    else if (N == 6) begin:gen_mux6
        assign out = ({W{sel[0]}} & in[0 * W +:W]) | ({W{sel[1]}} & in[1 * W +:W]) | ({W{sel[2]}} & in[2 * W +:W]) | ({W{sel[3]}} & in[3 * W +:W]) | ({W{sel[4]}} & in[4 * W +:W]) | ({W{sel[5]}} & in[5 * W +:W]);
    end
    else if (N == 7) begin:gen_mux7
        assign out = ({W{sel[0]}} & in[0 * W +:W]) | ({W{sel[1]}} & in[1 * W +:W]) | ({W{sel[2]}} & in[2 * W +:W]) | ({W{sel[3]}} & in[3 * W +:W]) | ({W{sel[4]}} & in[4 * W +:W]) | ({W{sel[5]}} & in[5 * W +:W]) | ({W{sel[6]}} & in[6 * W +:W]);
    end
    else if (N == 8) begin:gen_mux8
        assign out = ({W{sel[0]}} & in[0 * W +:W]) | ({W{sel[1]}} & in[1 * W +:W]) | ({W{sel[2]}} & in[2 * W +:W]) | ({W{sel[3]}} & in[3 * W +:W]) | ({W{sel[4]}} & in[4 * W +:W]) | ({W{sel[5]}} & in[5 * W +:W]) | ({W{sel[6]}} & in[6 * W +:W]) | ({W{sel[7]}} & in[7 * W +:W]);
    end
    else if (N == 9) begin:gen_mux9
        assign out = ({W{sel[0]}} & in[0 * W +:W]) | ({W{sel[1]}} & in[1 * W +:W]) | ({W{sel[2]}} & in[2 * W +:W]) | ({W{sel[3]}} & in[3 * W +:W]) | ({W{sel[4]}} & in[4 * W +:W]) | ({W{sel[5]}} & in[5 * W +:W]) | ({W{sel[6]}} & in[6 * W +:W]) | ({W{sel[7]}} & in[7 * W +:W]) | ({W{sel[8]}} & in[8 * W +:W]);
    end
    else if (N == 10) begin:gen_mux10
        assign out = ({W{sel[0]}} & in[0 * W +:W]) | ({W{sel[1]}} & in[1 * W +:W]) | ({W{sel[2]}} & in[2 * W +:W]) | ({W{sel[3]}} & in[3 * W +:W]) | ({W{sel[4]}} & in[4 * W +:W]) | ({W{sel[5]}} & in[5 * W +:W]) | ({W{sel[6]}} & in[6 * W +:W]) | ({W{sel[7]}} & in[7 * W +:W]) | ({W{sel[8]}} & in[8 * W +:W]) | ({W{sel[9]}} & in[9 * W +:W]);
    end
    else if (N == 11) begin:gen_mux11
        assign out = ({W{sel[0]}} & in[0 * W +:W]) | ({W{sel[1]}} & in[1 * W +:W]) | ({W{sel[2]}} & in[2 * W +:W]) | ({W{sel[3]}} & in[3 * W +:W]) | ({W{sel[4]}} & in[4 * W +:W]) | ({W{sel[5]}} & in[5 * W +:W]) | ({W{sel[6]}} & in[6 * W +:W]) | ({W{sel[7]}} & in[7 * W +:W]) | ({W{sel[8]}} & in[8 * W +:W]) | ({W{sel[9]}} & in[9 * W +:W]) | ({W{sel[10]}} & in[10 * W +:W]);
    end
    else if (N == 12) begin:gen_mux12
        assign out = ({W{sel[0]}} & in[0 * W +:W]) | ({W{sel[1]}} & in[1 * W +:W]) | ({W{sel[2]}} & in[2 * W +:W]) | ({W{sel[3]}} & in[3 * W +:W]) | ({W{sel[4]}} & in[4 * W +:W]) | ({W{sel[5]}} & in[5 * W +:W]) | ({W{sel[6]}} & in[6 * W +:W]) | ({W{sel[7]}} & in[7 * W +:W]) | ({W{sel[8]}} & in[8 * W +:W]) | ({W{sel[9]}} & in[9 * W +:W]) | ({W{sel[10]}} & in[10 * W +:W]) | ({W{sel[11]}} & in[11 * W +:W]);
    end
    else if (N == 13) begin:gen_mux13
        assign out = ({W{sel[0]}} & in[0 * W +:W]) | ({W{sel[1]}} & in[1 * W +:W]) | ({W{sel[2]}} & in[2 * W +:W]) | ({W{sel[3]}} & in[3 * W +:W]) | ({W{sel[4]}} & in[4 * W +:W]) | ({W{sel[5]}} & in[5 * W +:W]) | ({W{sel[6]}} & in[6 * W +:W]) | ({W{sel[7]}} & in[7 * W +:W]) | ({W{sel[8]}} & in[8 * W +:W]) | ({W{sel[9]}} & in[9 * W +:W]) | ({W{sel[10]}} & in[10 * W +:W]) | ({W{sel[11]}} & in[11 * W +:W]) | ({W{sel[12]}} & in[12 * W +:W]);
    end
    else if (N == 14) begin:gen_mux14
        assign out = ({W{sel[0]}} & in[0 * W +:W]) | ({W{sel[1]}} & in[1 * W +:W]) | ({W{sel[2]}} & in[2 * W +:W]) | ({W{sel[3]}} & in[3 * W +:W]) | ({W{sel[4]}} & in[4 * W +:W]) | ({W{sel[5]}} & in[5 * W +:W]) | ({W{sel[6]}} & in[6 * W +:W]) | ({W{sel[7]}} & in[7 * W +:W]) | ({W{sel[8]}} & in[8 * W +:W]) | ({W{sel[9]}} & in[9 * W +:W]) | ({W{sel[10]}} & in[10 * W +:W]) | ({W{sel[11]}} & in[11 * W +:W]) | ({W{sel[12]}} & in[12 * W +:W]) | ({W{sel[13]}} & in[13 * W +:W]);
    end
    else if (N == 15) begin:gen_mux15
        assign out = ({W{sel[0]}} & in[0 * W +:W]) | ({W{sel[1]}} & in[1 * W +:W]) | ({W{sel[2]}} & in[2 * W +:W]) | ({W{sel[3]}} & in[3 * W +:W]) | ({W{sel[4]}} & in[4 * W +:W]) | ({W{sel[5]}} & in[5 * W +:W]) | ({W{sel[6]}} & in[6 * W +:W]) | ({W{sel[7]}} & in[7 * W +:W]) | ({W{sel[8]}} & in[8 * W +:W]) | ({W{sel[9]}} & in[9 * W +:W]) | ({W{sel[10]}} & in[10 * W +:W]) | ({W{sel[11]}} & in[11 * W +:W]) | ({W{sel[12]}} & in[12 * W +:W]) | ({W{sel[13]}} & in[13 * W +:W]) | ({W{sel[14]}} & in[14 * W +:W]);
    end
    else if (N == 16) begin:gen_mux16
        assign out = ({W{sel[0]}} & in[0 * W +:W]) | ({W{sel[1]}} & in[1 * W +:W]) | ({W{sel[2]}} & in[2 * W +:W]) | ({W{sel[3]}} & in[3 * W +:W]) | ({W{sel[4]}} & in[4 * W +:W]) | ({W{sel[5]}} & in[5 * W +:W]) | ({W{sel[6]}} & in[6 * W +:W]) | ({W{sel[7]}} & in[7 * W +:W]) | ({W{sel[8]}} & in[8 * W +:W]) | ({W{sel[9]}} & in[9 * W +:W]) | ({W{sel[10]}} & in[10 * W +:W]) | ({W{sel[11]}} & in[11 * W +:W]) | ({W{sel[12]}} & in[12 * W +:W]) | ({W{sel[13]}} & in[13 * W +:W]) | ({W{sel[14]}} & in[14 * W +:W]) | ({W{sel[15]}} & in[15 * W +:W]);
    end
    else begin:gen_muxn
        kv_muxn_onehot #(
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

