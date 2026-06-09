// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfmis_lane_top (
    lane_id,
    vfmis_f1_lane_cmp_bit,
    vfmis_lane_cross_data,
    vfmis_lane_share_data,
    vfmis_lane_vs2_data,
    vfmis_lane_vs2_sel,
    vfmis_lane_vs2_x2_bdata,
    vfmis_lane_vs2_x4_bdata,
    vfmis_lane_vs2_x8_bdata,
    vfmis_standby_ready,
    vpu_vfmis_clk,
    vpu_reset_n,
    vfmis_cmt_kill,
    vfmis_cmt_valid,
    vfmis_f1_cmp_bit,
    vfmis_cmt_op1,
    vfmis_dispatch_ctrl,
    vfmis_dispatch_frm,
    vfmis_dispatch_op1,
    vfmis_dispatch_op1_hazard,
    vfmis_dispatch_ready,
    vfmis_dispatch_v0t_e_mask,
    vfmis_dispatch_v0t_sew16,
    vfmis_dispatch_v0t_sew32,
    vfmis_dispatch_v0t_sew64,
    vfmis_dispatch_v0t_sew8,
    vfmis_dispatch_valid,
    vfmis_dispatch_vd_len,
    vfmis_vs1_rdata,
    vfmis_vs1_rlast,
    vfmis_vs1_rready,
    vfmis_vs1_rvalid,
    vfmis_vs2_rdata,
    vfmis_vs2_rlast,
    vfmis_vs2_rready,
    vfmis_vs2_rvalid,
    vfmis_vs2_wide_rdata,
    vfmis_vs3_rdata,
    vfmis_vs3_rlast,
    vfmis_vs3_rready,
    vfmis_vs3_rvalid,
    vfmis_flag_set,
    vfmis_vd_wdata,
    vfmis_vd_wmask,
    vfmis_vd_wready,
    vfmis_vd_wvalid
);
parameter FELEN = 64;
parameter IELEN = 64;
parameter XLEN = 64;
parameter FLEN = 64;
parameter VLEN = 1024;
parameter DLEN = 512;
parameter VRF_LW = 4;
localparam ELEN = (FELEN == 64) ? 64 : (IELEN == 64) ? 64 : 32;
input [31:0] lane_id;
input [DLEN / 16 - 1:0] vfmis_f1_lane_cmp_bit;
input [127:0] vfmis_lane_cross_data;
output [63:0] vfmis_lane_share_data;
output [63:0] vfmis_lane_vs2_data;
output [2:0] vfmis_lane_vs2_sel;
input [31:0] vfmis_lane_vs2_x2_bdata;
input [15:0] vfmis_lane_vs2_x4_bdata;
input [7:0] vfmis_lane_vs2_x8_bdata;
output vfmis_standby_ready;
input vpu_vfmis_clk;
input vpu_reset_n;
input vfmis_cmt_kill;
input vfmis_cmt_valid;
output [3:0] vfmis_f1_cmp_bit;
input [(XLEN - 1):0] vfmis_cmt_op1;
input [(71 - 1):0] vfmis_dispatch_ctrl;
input [2:0] vfmis_dispatch_frm;
input [(XLEN - 1):0] vfmis_dispatch_op1;
input vfmis_dispatch_op1_hazard;
output vfmis_dispatch_ready;
input [63:0] vfmis_dispatch_v0t_e_mask;
input [63:0] vfmis_dispatch_v0t_sew16;
input [31:0] vfmis_dispatch_v0t_sew32;
input [15:0] vfmis_dispatch_v0t_sew64;
input [127:0] vfmis_dispatch_v0t_sew8;
input vfmis_dispatch_valid;
input [(VRF_LW - 1):0] vfmis_dispatch_vd_len;
input [63:0] vfmis_vs1_rdata;
input vfmis_vs1_rlast;
output vfmis_vs1_rready;
input vfmis_vs1_rvalid;
input [63:0] vfmis_vs2_rdata;
input vfmis_vs2_rlast;
output vfmis_vs2_rready;
input vfmis_vs2_rvalid;
input [31:0] vfmis_vs2_wide_rdata;
input [63:0] vfmis_vs3_rdata;
input vfmis_vs3_rlast;
output vfmis_vs3_rready;
input vfmis_vs3_rvalid;
output [4:0] vfmis_flag_set;
output [63:0] vfmis_vd_wdata;
output [7:0] vfmis_vd_wmask;
input vfmis_vd_wready;
output vfmis_vd_wvalid;





// 2b50996a rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire ex_nxt_cmt;
wire veq_ex_byte_mask_srl;
wire veq_ex_nrr_byte_mask_srl;
wire veq_ex_ready;
wire [7:0] vfmis_f1_byte_mask;
wire [7:0] vfmis_f1_nrr_byte_mask;
wire vfmis_f1_valid;
wire vfmis_f2_stall;
wire vrf_vd_kill;
wire vrf_vd_rd;
wire vrf_vs1_kill;
wire vrf_vs1_rd;
wire [63:0] vrf_vs1_wdata;
wire vrf_vs1_wr;
wire vrf_vs2_kill;
wire vrf_vs2_rd;
wire [63:0] vrf_vs2_wdata;
wire [31:0] vrf_vs2_wide_wdata;
wire vrf_vs2_wide_wr;
wire vrf_vs2_wr;
wire [63:0] wb_us_bit_wen;
wire wb_us_cmtted;
wire [4:0] wb_us_flag;
wire wb_us_flag_clr;
wire wb_us_flag_update;
wire wb_us_last;
wire [7:0] wb_us_mask_wdata;
wire wb_us_skip;
wire [2:0] wb_us_src;
wire wb_us_valid;
wire [63:0] wb_us_wdata_src0;
wire [63:0] wb_us_wdata_src1;
wire [63:0] wb_us_wdata_src2;
wire [4:0] vfmis_f1_flag_set;
wire [63:0] vfmis_f1_wdata;
wire [4:0] vfmis_f2_flag_set;
wire [31:0] vfmis_f2_narrow_wdata;
wire [63:0] vfmis_f2_wdata;
wire [127:0] veq_ex_byte_mask;
wire veq_ex_cmt;
wire [(71 - 1):0] veq_ex_ctrl;
wire [63:0] veq_ex_e_mask;
wire veq_ex_flush;
wire [2:0] veq_ex_frm;
wire [127:0] veq_ex_nrr_byte_mask;
wire [(71 - 1):0] veq_ex_nxt_ctrl;
wire veq_ex_nxt_valid;
wire [(XLEN - 1):0] veq_ex_op1;
wire veq_ex_op1_valid;
wire veq_ex_valid;
wire [(VRF_LW - 1):0] veq_ex_vd_len;
wire vrf_vd_last;
wire [63:0] vrf_vd_rdata;
wire vrf_vd_valid;
wire vrf_vs1_last;
wire [63:0] vrf_vs1_rdata;
wire vrf_vs1_valid;
wire vrf_vs2_last;
wire [63:0] vrf_vs2_rdata;
wire vrf_vs2_valid;
wire [31:0] vrf_vs2_wide_rdata;
wire exs_nxt_cmt;
wire wb_standby;
wire wb_us_ready;
kv_vfmis_ctrl #(
    .DLEN(DLEN),
    .ELEN(ELEN),
    .VLEN(VLEN),
    .VRF_LW(VRF_LW),
    .XLEN(XLEN)
) u_vfmis_ctrl (
    .vpu_vfmis_clk(vpu_vfmis_clk),
    .vpu_reset_n(vpu_reset_n),
    .lane_id(lane_id),
    .vfmis_cmt_valid(vfmis_cmt_valid),
    .vfmis_cmt_kill(vfmis_cmt_kill),
    .vfmis_standby_ready(vfmis_standby_ready),
    .veq_ex_valid(veq_ex_valid),
    .veq_ex_ready(veq_ex_ready),
    .veq_ex_ctrl(veq_ex_ctrl),
    .veq_ex_vd_len(veq_ex_vd_len),
    .veq_ex_byte_mask(veq_ex_byte_mask),
    .veq_ex_nrr_byte_mask(veq_ex_nrr_byte_mask),
    .veq_ex_e_mask(veq_ex_e_mask),
    .veq_ex_cmt(veq_ex_cmt),
    .veq_ex_op1_valid(veq_ex_op1_valid),
    .veq_ex_op1(veq_ex_op1),
    .veq_ex_byte_mask_srl(veq_ex_byte_mask_srl),
    .veq_ex_nrr_byte_mask_srl(veq_ex_nrr_byte_mask_srl),
    .veq_ex_flush(veq_ex_flush),
    .veq_ex_nxt_valid(veq_ex_nxt_valid),
    .veq_ex_nxt_ctrl(veq_ex_nxt_ctrl),
    .exs_nxt_cmt(exs_nxt_cmt),
    .f1_nxt_cmt(ex_nxt_cmt),
    .wb_us_valid(wb_us_valid),
    .wb_us_skip(wb_us_skip),
    .wb_us_ready(wb_us_ready),
    .wb_us_flag(wb_us_flag),
    .wb_us_flag_update(wb_us_flag_update),
    .wb_us_flag_clr(wb_us_flag_clr),
    .wb_us_wdata_src0(wb_us_wdata_src0),
    .wb_us_wdata_src1(wb_us_wdata_src1),
    .wb_us_wdata_src2(wb_us_wdata_src2),
    .wb_us_src(wb_us_src),
    .wb_us_bit_wen(wb_us_bit_wen),
    .wb_us_mask_wdata(wb_us_mask_wdata),
    .wb_us_cmtted(wb_us_cmtted),
    .wb_us_last(wb_us_last),
    .wb_standby(wb_standby),
    .vrf_vs1_valid(vrf_vs1_valid),
    .vrf_vs1_last(vrf_vs1_last),
    .vrf_vs1_rd(vrf_vs1_rd),
    .vrf_vs1_kill(vrf_vs1_kill),
    .vrf_vs1_rdata(vrf_vs1_rdata),
    .vrf_vs1_wr(vrf_vs1_wr),
    .vrf_vs1_wdata(vrf_vs1_wdata),
    .vrf_vs2_valid(vrf_vs2_valid),
    .vrf_vs2_last(vrf_vs2_last),
    .vrf_vs2_rd(vrf_vs2_rd),
    .vrf_vs2_kill(vrf_vs2_kill),
    .vrf_vs2_rdata(vrf_vs2_rdata),
    .vrf_vs2_wr(vrf_vs2_wr),
    .vrf_vs2_wdata(vrf_vs2_wdata),
    .vrf_vs2_wide_wr(vrf_vs2_wide_wr),
    .vrf_vs2_wide_wdata(vrf_vs2_wide_wdata),
    .vrf_vd_valid(vrf_vd_valid),
    .vrf_vd_last(vrf_vd_last),
    .vrf_vd_rd(vrf_vd_rd),
    .vrf_vd_kill(vrf_vd_kill),
    .vrf_vd_rdata(vrf_vd_rdata),
    .vfmis_f1_byte_mask(vfmis_f1_byte_mask),
    .vfmis_f1_nrr_byte_mask(vfmis_f1_nrr_byte_mask),
    .vfmis_f2_stall(vfmis_f2_stall),
    .vfmis_f1_valid(vfmis_f1_valid),
    .vfmis_f1_wdata(vfmis_f1_wdata),
    .vfmis_f1_lane_cmp_bit(vfmis_f1_lane_cmp_bit),
    .vfmis_f1_flag_set(vfmis_f1_flag_set),
    .vfmis_f2_wdata(vfmis_f2_wdata),
    .vfmis_f2_narrow_wdata(vfmis_f2_narrow_wdata),
    .vfmis_f2_flag_set(vfmis_f2_flag_set),
    .vfmis_lane_vs2_x2_bdata(vfmis_lane_vs2_x2_bdata),
    .vfmis_lane_vs2_x4_bdata(vfmis_lane_vs2_x4_bdata),
    .vfmis_lane_vs2_x8_bdata(vfmis_lane_vs2_x8_bdata),
    .vfmis_lane_vs2_data(vfmis_lane_vs2_data),
    .vfmis_lane_vs2_sel(vfmis_lane_vs2_sel),
    .vfmis_lane_share_data(vfmis_lane_share_data),
    .vfmis_lane_cross_data(vfmis_lane_cross_data)
);
kv_vfmis_veq #(
    .DLEN(DLEN),
    .ELEN(ELEN),
    .VLEN(VLEN),
    .VRF_LW(VRF_LW),
    .XLEN(XLEN)
) u_vfmis_veq (
    .vpu_vfmis_clk(vpu_vfmis_clk),
    .vpu_reset_n(vpu_reset_n),
    .vfmis_dispatch_valid(vfmis_dispatch_valid),
    .vfmis_dispatch_ready(vfmis_dispatch_ready),
    .vfmis_dispatch_ctrl(vfmis_dispatch_ctrl),
    .vfmis_dispatch_vd_len(vfmis_dispatch_vd_len),
    .vfmis_dispatch_frm(vfmis_dispatch_frm),
    .vfmis_dispatch_op1_hazard(vfmis_dispatch_op1_hazard),
    .vfmis_dispatch_op1(vfmis_dispatch_op1),
    .vfmis_dispatch_v0t_e_mask(vfmis_dispatch_v0t_e_mask),
    .vfmis_dispatch_v0t_sew8(vfmis_dispatch_v0t_sew8),
    .vfmis_dispatch_v0t_sew16(vfmis_dispatch_v0t_sew16),
    .vfmis_dispatch_v0t_sew32(vfmis_dispatch_v0t_sew32),
    .vfmis_dispatch_v0t_sew64(vfmis_dispatch_v0t_sew64),
    .vfmis_cmt_valid(vfmis_cmt_valid),
    .vfmis_cmt_kill(vfmis_cmt_kill),
    .vfmis_cmt_op1(vfmis_cmt_op1),
    .ex_nxt_cmt(ex_nxt_cmt),
    .veq_ex_valid(veq_ex_valid),
    .veq_ex_flush(veq_ex_flush),
    .veq_ex_ready(veq_ex_ready),
    .veq_ex_ctrl(veq_ex_ctrl),
    .veq_ex_vd_len(veq_ex_vd_len),
    .veq_ex_frm(veq_ex_frm),
    .veq_ex_op1_valid(veq_ex_op1_valid),
    .veq_ex_op1(veq_ex_op1),
    .veq_ex_byte_mask(veq_ex_byte_mask),
    .veq_ex_nrr_byte_mask(veq_ex_nrr_byte_mask),
    .veq_ex_e_mask(veq_ex_e_mask),
    .veq_ex_cmt(veq_ex_cmt),
    .veq_ex_byte_mask_srl(veq_ex_byte_mask_srl),
    .veq_ex_nrr_byte_mask_srl(veq_ex_nrr_byte_mask_srl),
    .veq_ex_nxt_valid(veq_ex_nxt_valid),
    .veq_ex_nxt_ctrl(veq_ex_nxt_ctrl)
);
kv_vfmis_wb #(
    .DLEN(64)
) u_vfmis_wb (
    .vpu_vfmis_clk(vpu_vfmis_clk),
    .vpu_reset_n(vpu_reset_n),
    .wb_standby(wb_standby),
    .exs_nxt_cmt(exs_nxt_cmt),
    .vfmis_flag_set(vfmis_flag_set),
    .wb_us_valid(wb_us_valid),
    .wb_us_ready(wb_us_ready),
    .wb_us_flag(wb_us_flag),
    .wb_us_skip(wb_us_skip),
    .wb_us_flag_update(wb_us_flag_update),
    .wb_us_flag_clr(wb_us_flag_clr),
    .wb_us_wdata_src0(wb_us_wdata_src0),
    .wb_us_wdata_src1(wb_us_wdata_src1),
    .wb_us_wdata_src2(wb_us_wdata_src2),
    .wb_us_src(wb_us_src),
    .wb_us_bit_wen(wb_us_bit_wen),
    .wb_us_mask_wdata(wb_us_mask_wdata),
    .wb_us_cmtted(wb_us_cmtted),
    .wb_us_last(wb_us_last),
    .vfmis_cmt_valid(vfmis_cmt_valid),
    .vfmis_cmt_kill(vfmis_cmt_kill),
    .vfmis_vd_wvalid(vfmis_vd_wvalid),
    .vfmis_vd_wdata(vfmis_vd_wdata),
    .vfmis_vd_wmask(vfmis_vd_wmask),
    .vfmis_vd_wready(vfmis_vd_wready)
);
kv_vfmis_vrf_buf u_vfmis_vrf_buf(
    .vpu_vfmis_clk(vpu_vfmis_clk),
    .vpu_reset_n(vpu_reset_n),
    .vrf_vs1_rdata(vrf_vs1_rdata),
    .vrf_vs2_rdata(vrf_vs2_rdata),
    .vrf_vs2_wide_rdata(vrf_vs2_wide_rdata),
    .vfmis_vs1_rvalid(vfmis_vs1_rvalid),
    .vfmis_vs1_rlast(vfmis_vs1_rlast),
    .vfmis_vs1_rready(vfmis_vs1_rready),
    .vfmis_vs1_rdata(vfmis_vs1_rdata),
    .vfmis_vs2_rvalid(vfmis_vs2_rvalid),
    .vfmis_vs2_rlast(vfmis_vs2_rlast),
    .vfmis_vs2_rready(vfmis_vs2_rready),
    .vfmis_vs2_rdata(vfmis_vs2_rdata),
    .vfmis_vs2_wide_rdata(vfmis_vs2_wide_rdata),
    .vfmis_vs3_rvalid(vfmis_vs3_rvalid),
    .vfmis_vs3_rlast(vfmis_vs3_rlast),
    .vfmis_vs3_rready(vfmis_vs3_rready),
    .vfmis_vs3_rdata(vfmis_vs3_rdata),
    .vrf_vs1_valid(vrf_vs1_valid),
    .vrf_vs1_last(vrf_vs1_last),
    .vrf_vs1_rd(vrf_vs1_rd),
    .vrf_vs1_kill(vrf_vs1_kill),
    .vrf_vs1_wr(vrf_vs1_wr),
    .vrf_vs1_wdata(vrf_vs1_wdata),
    .vrf_vs2_valid(vrf_vs2_valid),
    .vrf_vs2_last(vrf_vs2_last),
    .vrf_vs2_rd(vrf_vs2_rd),
    .vrf_vs2_kill(vrf_vs2_kill),
    .vrf_vs2_wr(vrf_vs2_wr),
    .vrf_vs2_wdata(vrf_vs2_wdata),
    .vrf_vs2_wide_wr(vrf_vs2_wide_wr),
    .vrf_vs2_wide_wdata(vrf_vs2_wide_wdata),
    .vrf_vd_valid(vrf_vd_valid),
    .vrf_vd_last(vrf_vd_last),
    .vrf_vd_rd(vrf_vd_rd),
    .vrf_vd_kill(vrf_vd_kill),
    .vrf_vd_rdata(vrf_vd_rdata)
);
kv_vfmis_lane #(
    .ELEN(ELEN),
    .FELEN(FELEN),
    .IELEN(IELEN),
    .XLEN(XLEN)
) u_vfmis_lane (
    .clk(vpu_vfmis_clk),
    .rstn(vpu_reset_n),
    .vfmis_f1_ex_ctrl(veq_ex_ctrl),
    .vfmis_f1_ex_frm(veq_ex_frm),
    .vfmis_f1_op1(veq_ex_op1),
    .vfmis_vs1_src(vrf_vs1_rdata),
    .vfmis_vs2_src(vrf_vs2_rdata),
    .vfmis_vs2_wsrc(vrf_vs2_wide_rdata),
    .vfmis_f1_byte_mask(vfmis_f1_byte_mask),
    .vfmis_f1_nrr_byte_mask(vfmis_f1_nrr_byte_mask),
    .vfmis_f1_valid(vfmis_f1_valid),
    .vfmis_f2_stall(vfmis_f2_stall),
    .vfmis_f1_wdata(vfmis_f1_wdata),
    .vfmis_f1_cmp_bit(vfmis_f1_cmp_bit),
    .vfmis_f1_flag_set(vfmis_f1_flag_set),
    .vfmis_f2_wdata(vfmis_f2_wdata),
    .vfmis_f2_narrow_wdata(vfmis_f2_narrow_wdata),
    .vfmis_f2_flag_set(vfmis_f2_flag_set)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

