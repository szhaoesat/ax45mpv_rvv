// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfdiv (
    vfdiv_standby_ready,
    vpu_vfdiv_clk,
    vpu_reset_n,
    vfdiv_cmt_kill,
    vfdiv_cmt_valid,
    vfdiv_cmt_op1,
    vfdiv_dispatch_ctrl,
    vfdiv_dispatch_frm,
    vfdiv_dispatch_op1,
    vfdiv_dispatch_op1_hazard,
    vfdiv_dispatch_ready,
    vfdiv_dispatch_v0t,
    vfdiv_dispatch_valid,
    vfdiv_dispatch_vd_len,
    vfdiv_dispatch_vs1_len,
    vfdiv_dispatch_vs2_len,
    vfdiv_vs1_rdata,
    vfdiv_vs1_rready,
    vfdiv_vs1_rvalid,
    vfdiv_vs2_rdata,
    vfdiv_vs2_rready,
    vfdiv_vs2_rvalid,
    vfdiv_fflags_set,
    vfdiv_vd_wdata,
    vfdiv_vd_wmask,
    vfdiv_vd_wready,
    vfdiv_vd_wvalid
);
parameter ELEN = 64;
parameter FLEN = 64;
parameter VLEN = 1024;
parameter DLEN = 512;
parameter VRF_LW = 4;
parameter VFDIV_DLEN = 512;
localparam XLEN = 64;
output vfdiv_standby_ready;
input vpu_vfdiv_clk;
input vpu_reset_n;
input vfdiv_cmt_kill;
input vfdiv_cmt_valid;
input [(XLEN - 1):0] vfdiv_cmt_op1;
input [(39 - 1):0] vfdiv_dispatch_ctrl;
input [2:0] vfdiv_dispatch_frm;
input [(XLEN - 1):0] vfdiv_dispatch_op1;
input vfdiv_dispatch_op1_hazard;
output vfdiv_dispatch_ready;
input [(VLEN - 1):0] vfdiv_dispatch_v0t;
input vfdiv_dispatch_valid;
input [(VRF_LW - 1):0] vfdiv_dispatch_vd_len;
input [(VRF_LW - 1):0] vfdiv_dispatch_vs1_len;
input [(VRF_LW - 1):0] vfdiv_dispatch_vs2_len;
input [(DLEN - 1):0] vfdiv_vs1_rdata;
output vfdiv_vs1_rready;
input vfdiv_vs1_rvalid;
input [(DLEN - 1):0] vfdiv_vs2_rdata;
output vfdiv_vs2_rready;
input vfdiv_vs2_rvalid;
output [4:0] vfdiv_fflags_set;
output [(DLEN - 1):0] vfdiv_vd_wdata;
output [(DLEN / 8) - 1:0] vfdiv_vd_wmask;
input vfdiv_vd_wready;
output vfdiv_vd_wvalid;





// 3a2a65c1 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire f0_nxt_cmt;
wire veq_ex_byte_mask_srl;
wire veq_ex_ready;
wire vfdiv_kill;
wire [VFDIV_DLEN / 8 - 1:0] vfdiv_req_byte_mask;
wire vfdiv_req_valid;
wire vfdiv_resp_ready;
wire vrf_vs1_kill;
wire vrf_vs1_rd;
wire vrf_vs1_srl;
wire vrf_vs2_kill;
wire vrf_vs2_rd;
wire vrf_vs2_srl;
wire [(DLEN - 1):0] wb_us_bit_wen;
wire wb_us_cmtted;
wire [4:0] wb_us_flag;
wire wb_us_flag_clr;
wire wb_us_flag_update;
wire wb_us_last;
wire [(DLEN / 8) - 1:0] wb_us_mask_wdata;
wire wb_us_valid;
wire [(DLEN - 1):0] wb_us_wdata;
wire vfdiv_req_ready;
wire [4:0] vfdiv_resp_flag_set;
wire vfdiv_resp_valid;
wire [(VFDIV_DLEN - 1):0] vfdiv_resp_wdata;
wire [(VLEN - 1):0] veq_ex_byte_mask;
wire veq_ex_cmt;
wire [(39 - 1):0] veq_ex_ctrl;
wire [2:0] veq_ex_frm;
wire [(XLEN - 1):0] veq_ex_op1;
wire veq_ex_op1_valid;
wire veq_ex_valid;
wire [(VRF_LW - 1):0] veq_ex_vd_len;
wire [(VRF_LW - 1):0] veq_ex_vs1_len;
wire [(VRF_LW - 1):0] veq_ex_vs2_len;
wire [(VFDIV_DLEN - 1):0] vrf_vs1_rdata;
wire vrf_vs1_valid;
wire [(VFDIV_DLEN - 1):0] vrf_vs2_rdata;
wire vrf_vs2_valid;
wire exs_nxt_cmt;
wire wb_standby;
wire wb_us_ready;
kv_vfdiv_ctrl #(
    .CLEN(VFDIV_DLEN),
    .DLEN(DLEN),
    .ELEN(ELEN),
    .VLEN(VLEN),
    .VRF_LW(VRF_LW),
    .XLEN(XLEN)
) u_vfdiv_ctrl (
    .vpu_vfdiv_clk(vpu_vfdiv_clk),
    .vpu_reset_n(vpu_reset_n),
    .vfdiv_standby_ready(vfdiv_standby_ready),
    .vfdiv_cmt_valid(vfdiv_cmt_valid),
    .vfdiv_cmt_kill(vfdiv_cmt_kill),
    .veq_ex_valid(veq_ex_valid),
    .veq_ex_ready(veq_ex_ready),
    .veq_ex_ctrl(veq_ex_ctrl),
    .veq_ex_byte_mask(veq_ex_byte_mask),
    .veq_ex_vd_len(veq_ex_vd_len),
    .veq_ex_vs1_len(veq_ex_vs1_len),
    .veq_ex_vs2_len(veq_ex_vs2_len),
    .veq_ex_cmt(veq_ex_cmt),
    .veq_ex_op1_valid(veq_ex_op1_valid),
    .veq_ex_byte_mask_srl(veq_ex_byte_mask_srl),
    .exs_nxt_cmt(exs_nxt_cmt),
    .f0_nxt_cmt(f0_nxt_cmt),
    .wb_standby(wb_standby),
    .wb_us_valid(wb_us_valid),
    .wb_us_ready(wb_us_ready),
    .wb_us_flag_update(wb_us_flag_update),
    .wb_us_flag(wb_us_flag),
    .wb_us_flag_clr(wb_us_flag_clr),
    .wb_us_wdata(wb_us_wdata),
    .wb_us_bit_wen(wb_us_bit_wen),
    .wb_us_mask_wdata(wb_us_mask_wdata),
    .wb_us_cmtted(wb_us_cmtted),
    .wb_us_last(wb_us_last),
    .vrf_vs1_valid(vrf_vs1_valid),
    .vrf_vs1_rd(vrf_vs1_rd),
    .vrf_vs1_kill(vrf_vs1_kill),
    .vrf_vs1_srl(vrf_vs1_srl),
    .vrf_vs2_valid(vrf_vs2_valid),
    .vrf_vs2_rd(vrf_vs2_rd),
    .vrf_vs2_kill(vrf_vs2_kill),
    .vrf_vs2_srl(vrf_vs2_srl),
    .vfdiv_req_valid(vfdiv_req_valid),
    .vfdiv_req_ready(vfdiv_req_ready),
    .vfdiv_req_byte_mask(vfdiv_req_byte_mask),
    .vfdiv_resp_wdata(vfdiv_resp_wdata),
    .vfdiv_resp_valid(vfdiv_resp_valid),
    .vfdiv_resp_ready(vfdiv_resp_ready),
    .vfdiv_resp_flag_set(vfdiv_resp_flag_set),
    .vfdiv_kill(vfdiv_kill)
);
kv_vfdiv_veq #(
    .DLEN(VFDIV_DLEN),
    .ELEN(ELEN),
    .VLEN(VLEN),
    .VRF_LW(VRF_LW),
    .XLEN(XLEN)
) u_vfdiv_veq (
    .vpu_vfdiv_clk(vpu_vfdiv_clk),
    .vpu_reset_n(vpu_reset_n),
    .vfdiv_dispatch_vd_len(vfdiv_dispatch_vd_len),
    .vfdiv_dispatch_vs1_len(vfdiv_dispatch_vs1_len),
    .vfdiv_dispatch_vs2_len(vfdiv_dispatch_vs2_len),
    .vfdiv_dispatch_valid(vfdiv_dispatch_valid),
    .vfdiv_dispatch_ready(vfdiv_dispatch_ready),
    .vfdiv_dispatch_ctrl(vfdiv_dispatch_ctrl),
    .vfdiv_dispatch_frm(vfdiv_dispatch_frm),
    .vfdiv_dispatch_op1_hazard(vfdiv_dispatch_op1_hazard),
    .vfdiv_dispatch_op1(vfdiv_dispatch_op1),
    .vfdiv_dispatch_v0t(vfdiv_dispatch_v0t),
    .vfdiv_cmt_valid(vfdiv_cmt_valid),
    .vfdiv_cmt_kill(vfdiv_cmt_kill),
    .vfdiv_cmt_op1(vfdiv_cmt_op1),
    .f0_nxt_cmt(f0_nxt_cmt),
    .veq_ex_valid(veq_ex_valid),
    .veq_ex_ready(veq_ex_ready),
    .veq_ex_ctrl(veq_ex_ctrl),
    .veq_ex_vd_len(veq_ex_vd_len),
    .veq_ex_vs1_len(veq_ex_vs1_len),
    .veq_ex_vs2_len(veq_ex_vs2_len),
    .veq_ex_frm(veq_ex_frm),
    .veq_ex_op1_valid(veq_ex_op1_valid),
    .veq_ex_op1(veq_ex_op1),
    .veq_ex_byte_mask(veq_ex_byte_mask),
    .veq_ex_cmt(veq_ex_cmt),
    .veq_ex_byte_mask_srl(veq_ex_byte_mask_srl)
);
kv_vfdiv_wb #(
    .DLEN(DLEN)
) u_vfdiv_wb (
    .vpu_vfdiv_clk(vpu_vfdiv_clk),
    .vpu_reset_n(vpu_reset_n),
    .wb_standby(wb_standby),
    .exs_nxt_cmt(exs_nxt_cmt),
    .wb_us_valid(wb_us_valid),
    .wb_us_ready(wb_us_ready),
    .wb_us_wdata(wb_us_wdata),
    .wb_us_bit_wen(wb_us_bit_wen),
    .wb_us_mask_wdata(wb_us_mask_wdata),
    .wb_us_cmtted(wb_us_cmtted),
    .wb_us_last(wb_us_last),
    .wb_us_flag(wb_us_flag),
    .wb_us_flag_clr(wb_us_flag_clr),
    .wb_us_flag_update(wb_us_flag_update),
    .vfdiv_cmt_valid(vfdiv_cmt_valid),
    .vfdiv_cmt_kill(vfdiv_cmt_kill),
    .vfdiv_fflags_set(vfdiv_fflags_set),
    .vfdiv_vd_wvalid(vfdiv_vd_wvalid),
    .vfdiv_vd_wdata(vfdiv_vd_wdata),
    .vfdiv_vd_wmask(vfdiv_vd_wmask),
    .vfdiv_vd_wready(vfdiv_vd_wready)
);
kv_vfdiv_vrf_buf #(
    .CLEN(VFDIV_DLEN),
    .DLEN(DLEN)
) u_vfdiv_vrf_buf (
    .vpu_vfdiv_clk(vpu_vfdiv_clk),
    .vpu_reset_n(vpu_reset_n),
    .vrf_vs1_valid(vrf_vs1_valid),
    .vrf_vs1_rdata(vrf_vs1_rdata),
    .vrf_vs1_srl(vrf_vs1_srl),
    .vrf_vs2_valid(vrf_vs2_valid),
    .vrf_vs2_rdata(vrf_vs2_rdata),
    .vrf_vs2_srl(vrf_vs2_srl),
    .vfdiv_vs1_rvalid(vfdiv_vs1_rvalid),
    .vfdiv_vs1_rready(vfdiv_vs1_rready),
    .vfdiv_vs1_rdata(vfdiv_vs1_rdata),
    .vfdiv_vs2_rvalid(vfdiv_vs2_rvalid),
    .vfdiv_vs2_rready(vfdiv_vs2_rready),
    .vfdiv_vs2_rdata(vfdiv_vs2_rdata),
    .vrf_vs1_rd(vrf_vs1_rd),
    .vrf_vs1_kill(vrf_vs1_kill),
    .vrf_vs2_rd(vrf_vs2_rd),
    .vrf_vs2_kill(vrf_vs2_kill)
);
kv_vfdiv_dlen #(
    .DLEN(VFDIV_DLEN),
    .ELEN(ELEN),
    .FLEN(FLEN),
    .XLEN(XLEN)
) u_vfdiv_dlen (
    .clk(vpu_vfdiv_clk),
    .rstn(vpu_reset_n),
    .vfdiv_req_ex_ctrl(veq_ex_ctrl),
    .vfdiv_req_ex_frm(veq_ex_frm),
    .vfdiv_req_op1(veq_ex_op1),
    .vfdiv_req_vs1_src(vrf_vs1_rdata),
    .vfdiv_req_vs2_src(vrf_vs2_rdata),
    .vfdiv_req_byte_mask(vfdiv_req_byte_mask),
    .vfdiv_req_valid(vfdiv_req_valid),
    .vfdiv_req_ready(vfdiv_req_ready),
    .vfdiv_kill(vfdiv_kill),
    .vfdiv_resp_wdata(vfdiv_resp_wdata),
    .vfdiv_resp_flag_set(vfdiv_resp_flag_set),
    .vfdiv_resp_valid(vfdiv_resp_valid),
    .vfdiv_resp_ready(vfdiv_resp_ready)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

