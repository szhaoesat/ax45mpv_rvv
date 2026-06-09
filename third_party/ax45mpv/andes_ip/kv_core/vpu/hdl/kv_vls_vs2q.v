// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_vs2q (
    vpu_vlsu_clk,
    vpu_reset_n,
    vlsu_vs2_rdata,
    vlsu_vs2_rvalid,
    vlsq_req_vs2_rready,
    vlsq_req_vs2_addr,
    vlsq_vs2_accept,
    vs2q_not_full,
    vlsq_vs2_dummy_rready,
    vlsq_req_vs2_kill,
    vlsq_req_vs2_dlen_last,
    vlsq_req_vs2_ptr,
    vlsq_req_vs2_shift_valid,
    vlsq_req_vs2_shift_value
);
parameter DLEN = 512;
parameter VS2Q_DEPTH = 1;
input vpu_vlsu_clk;
input vpu_reset_n;
input [(DLEN - 1):0] vlsu_vs2_rdata;
input vlsu_vs2_rvalid;
output vlsq_req_vs2_rready;
output [DLEN - 1:0] vlsq_req_vs2_addr;
input vlsq_vs2_accept;
output vs2q_not_full;
input vlsq_vs2_dummy_rready;
input vlsq_req_vs2_kill;
input vlsq_req_vs2_dlen_last;
input [VS2Q_DEPTH - 1:0] vlsq_req_vs2_ptr;
input vlsq_req_vs2_shift_valid;
input [1:0] vlsq_req_vs2_shift_value;





// ebb9a250 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [VS2Q_DEPTH - 1:0] s0;
wire [VS2Q_DEPTH - 1:0] s1;
wire [VS2Q_DEPTH - 1:0] s2;
wire s3;
wire [VS2Q_DEPTH - 1:0] s4;
wire s5;
wire vs2q_not_full;
wire [VS2Q_DEPTH - 1:0] s6;
wire [(VS2Q_DEPTH * DLEN) - 1:0] s7;
wire s8;
wire [DLEN - 1:0] s9;
wire s10;
wire s11;
kv_mux_onehot #(
    .N(VS2Q_DEPTH),
    .W(1)
) u_vs2_valid (
    .out(s8),
    .sel(vlsq_req_vs2_ptr),
    .in(s6)
);
kv_mux_onehot #(
    .N(VS2Q_DEPTH),
    .W(DLEN)
) u_vs2_addr (
    .out(s9),
    .sel(vlsq_req_vs2_ptr),
    .in(s7)
);
assign vlsq_req_vs2_rready = s8;
assign vlsq_req_vs2_addr = s9;
genvar i;
generate
    for (i = 0; i < VS2Q_DEPTH; i = i + 1) begin:gen_vls_vs2q_ent
        kv_vls_addrq_ent #(
            .W(DLEN)
        ) u_vls_vs2q_ent (
            .vpu_vlsu_clk(vpu_vlsu_clk),
            .vpu_reset_n(vpu_reset_n),
            .enq_valid(s0[i]),
            .deq_valid(s1[i]),
            .shift_valid(s2[i]),
            .shift_value(vlsq_req_vs2_shift_value),
            .enq_addr(vlsu_vs2_rdata),
            .qout_addr_valid(s6[i]),
            .qout_addr(s7[i * DLEN +:DLEN])
        );
    end
endgenerate
generate
    if (VS2Q_DEPTH > 1) begin:gen_vs2_ptr
        assign s3 = s11 & ~vlsq_vs2_dummy_rready;
        kv_cnt_onehot #(
            .N(VS2Q_DEPTH)
        ) u_vs2q_enq_ptr (
            .clk(vpu_vlsu_clk),
            .rst_n(vpu_reset_n),
            .en(s3),
            .up_dn(1'b1),
            .load(1'b0),
            .data({VS2Q_DEPTH{1'b0}}),
            .cnt(s4)
        );
    end
    else begin:gen_vs2_ptr_depth1
        assign s3 = s11 & ~vlsq_vs2_dummy_rready;
        assign s4 = 1'b1;
    end
endgenerate
assign s5 = &s6;
assign vs2q_not_full = ~s5;
assign s10 = (vs2q_not_full & vlsq_vs2_accept);
assign s11 = vlsu_vs2_rvalid & s10;
assign s0 = {VS2Q_DEPTH{s3}} & s4;
assign s1 = {VS2Q_DEPTH{vlsq_req_vs2_dlen_last | vlsq_req_vs2_kill}} & vlsq_req_vs2_ptr;
assign s2 = {VS2Q_DEPTH{vlsq_req_vs2_shift_valid}} & vlsq_req_vs2_ptr;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

