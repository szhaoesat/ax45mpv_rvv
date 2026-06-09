// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_cross_check (
    check_en,
    addr,
    access_bytes,
    addr_cross_nx,
    remaining_byte,
    avaliable_byte,
    cross_en
);
parameter ADDR_WIDTH = 38;
parameter BYTE_WIDTH = 10;
parameter CROSS_BIT = 4;
localparam CROSS_WIDTH = CROSS_BIT + 1;
localparam W = (BYTE_WIDTH > CROSS_WIDTH) ? BYTE_WIDTH : CROSS_WIDTH;
input check_en;
input [ADDR_WIDTH - 1:0] addr;
input [BYTE_WIDTH - 1:0] access_bytes;
output [ADDR_WIDTH - 1:0] addr_cross_nx;
output [BYTE_WIDTH - 1:0] remaining_byte;
output [BYTE_WIDTH - 1:0] avaliable_byte;
output cross_en;





// b552e16b rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [ADDR_WIDTH - 1:CROSS_BIT] s0;
wire [CROSS_WIDTH - 1:0] s1;
wire [W - 1:0] s2;
wire [W:0] s3;
wire [W - 1:0] s4;
wire [W:0] s5;
wire [W:0] s6;
wire nds_unused_co0;
wire nds_unused_uf0;
generate
    if (BYTE_WIDTH > CROSS_WIDTH) begin:gen_byte_gt_cross
        kv_zero_ext #(
            .OW(W),
            .IW(CROSS_WIDTH)
        ) u_max_byte_zext (
            .out(s2),
            .in(s1)
        );
        assign s4 = access_bytes;
        assign avaliable_byte = {{BYTE_WIDTH - CROSS_WIDTH{1'b0}},s1[CROSS_WIDTH - 1:0]};
        assign remaining_byte = s6[BYTE_WIDTH - 1:0];
    end
    else begin:gen_byte_le_cross
        kv_zero_ext #(
            .OW(W),
            .IW(BYTE_WIDTH)
        ) u_max_byte_zext (
            .out(s4),
            .in(access_bytes)
        );
        assign s2 = s1;
        assign avaliable_byte = s1[BYTE_WIDTH - 1:0];
        assign remaining_byte = s6[BYTE_WIDTH - 1:0];
    end
endgenerate
assign s5 = {1'b1,s4};
assign s3 = {1'b0,s2};
assign {nds_unused_uf0,s6} = s5 - s3;
assign {nds_unused_co0,s0} = addr[ADDR_WIDTH - 1:CROSS_BIT] + {{ADDR_WIDTH - CROSS_BIT - 1{1'b0}},1'b1};
assign addr_cross_nx = {s0,{CROSS_BIT{1'b0}}};
assign s1 = {1'b1,{CROSS_BIT{1'b0}}} - {1'b0,addr[CROSS_BIT - 1:0]};
assign cross_en = check_en & s6[W] & |s6[W - 1:0];
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

