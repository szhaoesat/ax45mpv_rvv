// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vdiv (
    vpu_vdiv_clk,
    vpu_reset_n,
    vdiv_dispatch_valid,
    vdiv_dispatch_op1,
    vdiv_dispatch_ctrl,
    vdiv_dispatch_v0t,
    vdiv_dispatch_op1_hazard,
    vdiv_dispatch_ready,
    vdiv_cmt_valid,
    vdiv_cmt_kill,
    vdiv_cmt_op1,
    vdiv_vs1_rdata,
    vdiv_vs1_rready,
    vdiv_vs1_rvalid,
    vdiv_vs1_rlast,
    vdiv_vs2_rdata,
    vdiv_vs2_rready,
    vdiv_vs2_rvalid,
    vdiv_vs2_rlast,
    vdiv_vd_wvalid,
    vdiv_vd_wlast,
    vdiv_vd_wready,
    vdiv_vd_wdata,
    vdiv_vd_wmask
);
parameter VLEN = 512;
parameter DLEN = 512;
parameter ELEN = 64;
localparam MASK_LEN = DLEN / 8;
localparam DEPTH = 4;
input vpu_vdiv_clk;
input vpu_reset_n;
input vdiv_dispatch_valid;
input [63:0] vdiv_dispatch_op1;
input [(30 - 1):0] vdiv_dispatch_ctrl;
input [VLEN - 1:0] vdiv_dispatch_v0t;
input vdiv_dispatch_op1_hazard;
output vdiv_dispatch_ready;
input vdiv_cmt_valid;
input vdiv_cmt_kill;
input [63:0] vdiv_cmt_op1;
input [(DLEN - 1):0] vdiv_vs1_rdata;
output vdiv_vs1_rready;
input vdiv_vs1_rvalid;
input vdiv_vs1_rlast;
input [(DLEN - 1):0] vdiv_vs2_rdata;
output vdiv_vs2_rready;
input vdiv_vs2_rvalid;
input vdiv_vs2_rlast;
output vdiv_vd_wvalid;
input vdiv_vd_wready;
output [DLEN - 1:0] vdiv_vd_wdata;
output [(DLEN / 8) - 1:0] vdiv_vd_wmask;
input vdiv_vd_wlast;





// 6f39dbae rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire e1_ex_valid;
wire e1_ex_ready;
wire [DLEN - 1:0] e1_ex_src1;
wire [DLEN - 1:0] e1_ex_src2;
wire [DLEN - 1:0] e1_ex_mask;
wire e1_ex_vrem;
wire e1_ex_sign;
wire [1:0] e1_ex_sew;
wire [2:0] e1_ex_lmul;
wire e1_vs_valid;
wire e1_vs_ready;
wire e1_vs_flush;
wire e1_vs_last;
wire e1_vd_valid;
wire e1_vd_ready;
wire [DLEN - 1:0] e1_vd_data;
wire e1_ex_resp_valid;
wire e1_ex_req_ready;
wire e1_ex_resp_ready;
wire [MASK_LEN - 1:0] e1_vd_mask;
wire e1_cmt_valid;
wire e1_cmt_kill;
wire [DEPTH - 1:0] e1_cmt_id;
wire e1_cmt_ready;
wire [DEPTH - 1:0] e1_ex_id;
wire e1_ex_req_valid;
kv_vdiv_if #(
    .DEPTH(DEPTH),
    .VLEN(VLEN),
    .DLEN(DLEN)
) u_vdiv_if (
    .vpu_vdiv_clk(vpu_vdiv_clk),
    .vpu_reset_n(vpu_reset_n),
    .vdiv_dispatch_valid(vdiv_dispatch_valid),
    .vdiv_dispatch_op1(vdiv_dispatch_op1),
    .vdiv_dispatch_ctrl(vdiv_dispatch_ctrl),
    .vdiv_dispatch_v0t(vdiv_dispatch_v0t),
    .vdiv_dispatch_op1_hazard(vdiv_dispatch_op1_hazard),
    .vdiv_dispatch_ready(vdiv_dispatch_ready),
    .vdiv_cmt_valid(vdiv_cmt_valid),
    .vdiv_cmt_kill(vdiv_cmt_kill),
    .vdiv_cmt_op1(vdiv_cmt_op1),
    .vdiv_vs1_rdata(vdiv_vs1_rdata),
    .vdiv_vs1_rready(vdiv_vs1_rready),
    .vdiv_vs1_rvalid(vdiv_vs1_rvalid),
    .vdiv_vs1_rlast(vdiv_vs1_rlast),
    .vdiv_vs2_rdata(vdiv_vs2_rdata),
    .vdiv_vs2_rready(vdiv_vs2_rready),
    .vdiv_vs2_rvalid(vdiv_vs2_rvalid),
    .vdiv_vs2_rlast(vdiv_vs2_rlast),
    .e1_ex_valid(e1_ex_valid),
    .e1_ex_ready(e1_ex_ready),
    .e1_ex_id(e1_ex_id),
    .e1_cmt_ready(e1_cmt_ready),
    .e1_cmt_valid(e1_cmt_valid),
    .e1_cmt_kill(e1_cmt_kill),
    .e1_cmt_id(e1_cmt_id),
    .e1_vs_valid(e1_vs_valid),
    .e1_vs_ready(e1_vs_ready),
    .e1_vs_flush(e1_vs_flush),
    .e1_vs_last(e1_vs_last),
    .e1_ex_mask(e1_ex_mask),
    .e1_ex_vrem(e1_ex_vrem),
    .e1_ex_sign(e1_ex_sign),
    .e1_ex_sew(e1_ex_sew),
    .e1_ex_lmul(e1_ex_lmul),
    .e1_ex_src1(e1_ex_src1),
    .e1_ex_src2(e1_ex_src2),
    .e1_ex_req(e1_ex_req_valid)
);
kv_vdiv_ctrl #(
    .VLEN(VLEN),
    .DEPTH(DEPTH),
    .DLEN(DLEN)
) u_vdiv_ctrl (
    .vpu_vdiv_clk(vpu_vdiv_clk),
    .vpu_reset_n(vpu_reset_n),
    .e1_ex_valid(e1_ex_valid),
    .e1_ex_ready(e1_ex_ready),
    .e1_ex_id(e1_ex_id),
    .e1_cmt_ready(e1_cmt_ready),
    .e1_cmt_valid(e1_cmt_valid),
    .e1_cmt_kill(e1_cmt_kill),
    .e1_cmt_id(e1_cmt_id),
    .e1_ex_req_valid(e1_ex_req_valid),
    .e1_ex_req_ready(e1_ex_req_ready),
    .e1_ex_resp_valid(e1_ex_resp_valid),
    .e1_ex_resp_ready(e1_ex_resp_ready),
    .e1_vs_valid(e1_vs_valid),
    .e1_vs_ready(e1_vs_ready),
    .e1_vs_flush(e1_vs_flush),
    .e1_vs_last(e1_vs_last),
    .e1_vd_valid(e1_vd_valid),
    .e1_vd_ready(e1_vd_ready)
);
kv_vdiv_op #(
    .ELEN(ELEN),
    .VLEN(VLEN),
    .DLEN(DLEN)
) u_vdiv_op (
    .vpu_vdiv_clk(vpu_vdiv_clk),
    .vpu_reset_n(vpu_reset_n),
    .e0_sew(e1_ex_sew),
    .e0_lmul(e1_ex_lmul),
    .e0_sign(e1_ex_sign),
    .e0_mask(e1_ex_mask),
    .e0_vrem(e1_ex_vrem),
    .e0_src1(e1_ex_src1),
    .e0_src2(e1_ex_src2),
    .e1_ex_wdata(e1_vd_data),
    .e1_ex_resp_valid(e1_ex_resp_valid),
    .e1_ex_resp_ready(e1_ex_resp_ready),
    .e1_ex_req_ready(e1_ex_req_ready),
    .e1_ex_req_valid(e1_ex_req_valid),
    .e1_ex_mask(e1_vd_mask)
);
kv_vdiv_wb #(
    .DEPTH(DEPTH),
    .DLEN(DLEN)
) u_vdiv_wb (
    .vpu_vdiv_clk(vpu_vdiv_clk),
    .vpu_reset_n(vpu_reset_n),
    .e1_vd_valid(e1_vd_valid),
    .e1_vd_ready(e1_vd_ready),
    .e1_vd_data(e1_vd_data),
    .e1_vd_mask(e1_vd_mask),
    .vdiv_vd_wvalid(vdiv_vd_wvalid),
    .vdiv_vd_wready(vdiv_vd_wready),
    .vdiv_vd_wlast(vdiv_vd_wlast),
    .vdiv_vd_wdata(vdiv_vd_wdata),
    .vdiv_vd_wmask(vdiv_vd_wmask)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

