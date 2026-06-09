// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_valu_lane_top (
    lane_id,
    valu_lane_cross_result_data,
    valu_lane_mask_result,
    valu_lane_share_result_data,
    valu_lane_vs1_data,
    valu_lane_vs1_wide_bdata,
    valu_lane_vs2_data,
    valu_lane_vs2_wide_bdata,
    valu_mask_result,
    valu_standby_ready,
    vpu_valu_clk,
    vpu_reset_n,
    valu_cmt_kill,
    valu_cmt_valid,
    valu_cmt_op1,
    valu_dispatch_ctrl,
    valu_dispatch_op1,
    valu_dispatch_op1_hazard,
    valu_dispatch_ready,
    valu_dispatch_v0t_e_mask0,
    valu_dispatch_v0t_e_mask1,
    valu_dispatch_v0t_sew16,
    valu_dispatch_v0t_sew32,
    valu_dispatch_v0t_sew64,
    valu_dispatch_v0t_sew8,
    valu_dispatch_valid,
    valu_dispatch_vd_len,
    valu_dispatch_vxrm,
    valu_vs1_rdata,
    valu_vs1_rlast,
    valu_vs1_rready,
    valu_vs1_rvalid,
    valu_vs1_wide_rdata,
    valu_vs2_rdata,
    valu_vs2_rlast,
    valu_vs2_rready,
    valu_vs2_rvalid,
    valu_vs2_wide_rdata,
    valu_vs3_rdata,
    valu_vs3_rlast,
    valu_vs3_rready,
    valu_vs3_rvalid,
    valu_vd_wdata,
    valu_vd_wmask,
    valu_vd_wready,
    valu_vd_wvalid,
    valu_vxsat_set
);
parameter ELEN = 64;
parameter XLEN = 64;
parameter VLEN = 1024;
parameter DLEN = 512;
parameter VRF_LW = 4;
input [31:0] lane_id;
input [127:0] valu_lane_cross_result_data;
input [DLEN / 8 - 1:0] valu_lane_mask_result;
output [63:0] valu_lane_share_result_data;
output [63:0] valu_lane_vs1_data;
input [31:0] valu_lane_vs1_wide_bdata;
output [63:0] valu_lane_vs2_data;
input [31:0] valu_lane_vs2_wide_bdata;
output [7:0] valu_mask_result;
output valu_standby_ready;
input vpu_valu_clk;
input vpu_reset_n;
input valu_cmt_kill;
input valu_cmt_valid;
input [(XLEN - 1):0] valu_cmt_op1;
input [(58 - 1):0] valu_dispatch_ctrl;
input [(XLEN - 1):0] valu_dispatch_op1;
input valu_dispatch_op1_hazard;
output valu_dispatch_ready;
input [63:0] valu_dispatch_v0t_e_mask0;
input [63:0] valu_dispatch_v0t_e_mask1;
input [127:0] valu_dispatch_v0t_sew16;
input [63:0] valu_dispatch_v0t_sew32;
input [31:0] valu_dispatch_v0t_sew64;
input [127:0] valu_dispatch_v0t_sew8;
input valu_dispatch_valid;
input [(VRF_LW - 1):0] valu_dispatch_vd_len;
input [1:0] valu_dispatch_vxrm;
input [63:0] valu_vs1_rdata;
input valu_vs1_rlast;
output valu_vs1_rready;
input valu_vs1_rvalid;
input [31:0] valu_vs1_wide_rdata;
input [63:0] valu_vs2_rdata;
input valu_vs2_rlast;
output valu_vs2_rready;
input valu_vs2_rvalid;
input [31:0] valu_vs2_wide_rdata;
input [63:0] valu_vs3_rdata;
input valu_vs3_rlast;
output valu_vs3_rready;
input valu_vs3_rvalid;
output [63:0] valu_vd_wdata;
output [7:0] valu_vd_wmask;
input valu_vd_wready;
output valu_vd_wvalid;
output valu_vxsat_set;





// c509932a rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire ex_nxt_cmt;
wire [7:0] valu_ci_byte8;
wire [7:0] valu_mask_byte8;
wire [7:0] valu_nrr_mask_byte8;
wire valu_vs2_red_non_ext;
wire veq_ex_byte_mask_srl;
wire veq_ex_nrr_byte_mask_srl;
wire veq_ex_ready;
wire vrf_vd_kill;
wire vrf_vd_rd;
wire vrf_vd_srl;
wire [63:0] vrf_vd_wdata;
wire vrf_vd_wr;
wire vrf_vs1_kill;
wire vrf_vs1_rd;
wire [63:0] vrf_vs1_wdata;
wire [31:0] vrf_vs1_wide_wdata;
wire vrf_vs1_wide_wr;
wire vrf_vs1_wr;
wire vrf_vs2_kill;
wire vrf_vs2_rd;
wire [63:0] vrf_vs2_wdata;
wire [31:0] vrf_vs2_wide_wdata;
wire vrf_vs2_wide_wr;
wire vrf_vs2_wr;
wire [63:0] wb_us_bit_wen;
wire wb_us_cmtted;
wire wb_us_flag;
wire wb_us_flag_clr;
wire wb_us_flag_update;
wire wb_us_last;
wire [7:0] wb_us_mask_wdata;
wire wb_us_skip;
wire [3:0] wb_us_src;
wire wb_us_valid;
wire [63:0] wb_us_wdata_src0;
wire [63:0] wb_us_wdata_src1;
wire [63:0] wb_us_wdata_src2;
wire [63:0] wb_us_wdata_src3;
wire [31:0] valu_data32;
wire [63:0] valu_data64;
wire [63:0] valu_data64_red;
wire [7:0] valu_mresult;
wire vxsat_set;
wire [127:0] veq_ex_byte_mask;
wire veq_ex_cmt;
wire [(58 - 1):0] veq_ex_ctrl;
wire [(58 - 1):0] veq_ex_ctrl_dup;
wire [63:0] veq_ex_e_mask0;
wire [63:0] veq_ex_e_mask1;
wire veq_ex_flush;
wire [127:0] veq_ex_nrr_byte_mask;
wire [(XLEN - 1):0] veq_ex_nrr_scalar_op;
wire [(58 - 1):0] veq_ex_nxt_ctrl;
wire veq_ex_nxt_valid;
wire [(XLEN - 1):0] veq_ex_scalar_op;
wire veq_ex_scalar_valid;
wire veq_ex_valid;
wire [(VRF_LW - 1):0] veq_ex_vd_len;
wire [1:0] veq_ex_vxrm;
wire vrf_vd_last;
wire [63:0] vrf_vd_rdata;
wire vrf_vd_valid;
wire vrf_vs1_last;
wire [63:0] vrf_vs1_rdata;
wire vrf_vs1_valid;
wire [31:0] vrf_vs1_wide_rdata;
wire vrf_vs2_last;
wire [63:0] vrf_vs2_rdata;
wire vrf_vs2_valid;
wire [31:0] vrf_vs2_wide_rdata;
wire exs_nxt_cmt;
wire wb_standby;
wire wb_us_ready;
kv_valu_ctrl #(
    .DLEN(DLEN),
    .ELEN(ELEN),
    .VLEN(VLEN),
    .VRF_LW(VRF_LW),
    .XLEN(XLEN)
) u_valu_ctrl (
    .vpu_valu_clk(vpu_valu_clk),
    .vpu_reset_n(vpu_reset_n),
    .lane_id(lane_id),
    .valu_standby_ready(valu_standby_ready),
    .valu_cmt_valid(valu_cmt_valid),
    .valu_cmt_kill(valu_cmt_kill),
    .veq_ex_valid(veq_ex_valid),
    .veq_ex_flush(veq_ex_flush),
    .veq_ex_ready(veq_ex_ready),
    .veq_ex_ctrl(veq_ex_ctrl),
    .veq_ex_vd_len(veq_ex_vd_len),
    .veq_ex_byte_mask(veq_ex_byte_mask),
    .veq_ex_nrr_byte_mask(veq_ex_nrr_byte_mask),
    .veq_ex_e_mask0(veq_ex_e_mask0),
    .veq_ex_e_mask1(veq_ex_e_mask1),
    .veq_ex_cmt(veq_ex_cmt),
    .veq_ex_scalar_valid(veq_ex_scalar_valid),
    .veq_ex_byte_mask_srl(veq_ex_byte_mask_srl),
    .veq_ex_nrr_byte_mask_srl(veq_ex_nrr_byte_mask_srl),
    .veq_ex_nxt_valid(veq_ex_nxt_valid),
    .veq_ex_nxt_ctrl(veq_ex_nxt_ctrl),
    .exs_nxt_cmt(exs_nxt_cmt),
    .ex_nxt_cmt(ex_nxt_cmt),
    .wb_us_valid(wb_us_valid),
    .wb_us_ready(wb_us_ready),
    .wb_standby(wb_standby),
    .wb_us_flag_update(wb_us_flag_update),
    .wb_us_flag_clr(wb_us_flag_clr),
    .wb_us_flag(wb_us_flag),
    .wb_us_wdata_src0(wb_us_wdata_src0),
    .wb_us_wdata_src1(wb_us_wdata_src1),
    .wb_us_wdata_src2(wb_us_wdata_src2),
    .wb_us_wdata_src3(wb_us_wdata_src3),
    .wb_us_src(wb_us_src),
    .wb_us_bit_wen(wb_us_bit_wen),
    .wb_us_mask_wdata(wb_us_mask_wdata),
    .wb_us_cmtted(wb_us_cmtted),
    .wb_us_last(wb_us_last),
    .wb_us_skip(wb_us_skip),
    .vrf_vs1_valid(vrf_vs1_valid),
    .vrf_vs1_rd(vrf_vs1_rd),
    .vrf_vs1_kill(vrf_vs1_kill),
    .vrf_vs1_wr(vrf_vs1_wr),
    .vrf_vs1_wdata(vrf_vs1_wdata),
    .vrf_vs1_rdata(vrf_vs1_rdata),
    .vrf_vs1_last(vrf_vs1_last),
    .vrf_vs1_wide_wr(vrf_vs1_wide_wr),
    .vrf_vs1_wide_wdata(vrf_vs1_wide_wdata),
    .vrf_vs2_valid(vrf_vs2_valid),
    .vrf_vs2_rd(vrf_vs2_rd),
    .vrf_vs2_kill(vrf_vs2_kill),
    .vrf_vs2_wr(vrf_vs2_wr),
    .vrf_vs2_wdata(vrf_vs2_wdata),
    .vrf_vs2_rdata(vrf_vs2_rdata),
    .vrf_vs2_last(vrf_vs2_last),
    .vrf_vs2_wide_wr(vrf_vs2_wide_wr),
    .vrf_vs2_wide_wdata(vrf_vs2_wide_wdata),
    .vrf_vs2_wide_rdata(vrf_vs2_wide_rdata),
    .vrf_vd_valid(vrf_vd_valid),
    .vrf_vd_rd(vrf_vd_rd),
    .vrf_vd_kill(vrf_vd_kill),
    .vrf_vd_wr(vrf_vd_wr),
    .vrf_vd_wdata(vrf_vd_wdata),
    .vrf_vd_rdata(vrf_vd_rdata),
    .vrf_vd_last(vrf_vd_last),
    .vrf_vd_srl(vrf_vd_srl),
    .valu_mask_byte8(valu_mask_byte8),
    .valu_nrr_mask_byte8(valu_nrr_mask_byte8),
    .valu_ci_byte8(valu_ci_byte8),
    .valu_vs2_red_non_ext(valu_vs2_red_non_ext),
    .valu_data64(valu_data64),
    .valu_data32(valu_data32),
    .valu_data64_red(valu_data64_red),
    .valu_mresult(valu_mresult),
    .vxsat_set(vxsat_set),
    .valu_mask_result(valu_mask_result),
    .valu_lane_vs2_wide_bdata(valu_lane_vs2_wide_bdata),
    .valu_lane_vs1_wide_bdata(valu_lane_vs1_wide_bdata),
    .valu_lane_vs2_data(valu_lane_vs2_data),
    .valu_lane_vs1_data(valu_lane_vs1_data),
    .valu_lane_mask_result(valu_lane_mask_result),
    .valu_lane_share_result_data(valu_lane_share_result_data),
    .valu_lane_cross_result_data(valu_lane_cross_result_data)
);
kv_valu_veq #(
    .DLEN(DLEN),
    .ELEN(ELEN),
    .VLEN(VLEN),
    .VRF_LW(VRF_LW),
    .XLEN(XLEN)
) u_valu_veq (
    .vpu_valu_clk(vpu_valu_clk),
    .vpu_reset_n(vpu_reset_n),
    .valu_dispatch_valid(valu_dispatch_valid),
    .valu_dispatch_ready(valu_dispatch_ready),
    .valu_dispatch_ctrl(valu_dispatch_ctrl),
    .valu_dispatch_vd_len(valu_dispatch_vd_len),
    .valu_dispatch_vxrm(valu_dispatch_vxrm),
    .valu_dispatch_op1_hazard(valu_dispatch_op1_hazard),
    .valu_dispatch_op1(valu_dispatch_op1),
    .valu_dispatch_v0t_e_mask0(valu_dispatch_v0t_e_mask0),
    .valu_dispatch_v0t_e_mask1(valu_dispatch_v0t_e_mask1),
    .valu_dispatch_v0t_sew8(valu_dispatch_v0t_sew8),
    .valu_dispatch_v0t_sew16(valu_dispatch_v0t_sew16),
    .valu_dispatch_v0t_sew32(valu_dispatch_v0t_sew32),
    .valu_dispatch_v0t_sew64(valu_dispatch_v0t_sew64),
    .valu_cmt_valid(valu_cmt_valid),
    .valu_cmt_kill(valu_cmt_kill),
    .valu_cmt_op1(valu_cmt_op1),
    .ex_nxt_cmt(ex_nxt_cmt),
    .veq_ex_valid(veq_ex_valid),
    .veq_ex_flush(veq_ex_flush),
    .veq_ex_ready(veq_ex_ready),
    .veq_ex_ctrl(veq_ex_ctrl),
    .veq_ex_ctrl_dup(veq_ex_ctrl_dup),
    .veq_ex_vd_len(veq_ex_vd_len),
    .veq_ex_vxrm(veq_ex_vxrm),
    .veq_ex_scalar_valid(veq_ex_scalar_valid),
    .veq_ex_scalar_op(veq_ex_scalar_op),
    .veq_ex_nrr_scalar_op(veq_ex_nrr_scalar_op),
    .veq_ex_byte_mask(veq_ex_byte_mask),
    .veq_ex_nrr_byte_mask(veq_ex_nrr_byte_mask),
    .veq_ex_e_mask0(veq_ex_e_mask0),
    .veq_ex_e_mask1(veq_ex_e_mask1),
    .veq_ex_cmt(veq_ex_cmt),
    .veq_ex_byte_mask_srl(veq_ex_byte_mask_srl),
    .veq_ex_nrr_byte_mask_srl(veq_ex_nrr_byte_mask_srl),
    .veq_ex_nxt_valid(veq_ex_nxt_valid),
    .veq_ex_nxt_ctrl(veq_ex_nxt_ctrl)
);
kv_valu_wb #(
    .DLEN(64)
) u_valu_wb (
    .vpu_valu_clk(vpu_valu_clk),
    .vpu_reset_n(vpu_reset_n),
    .exs_nxt_cmt(exs_nxt_cmt),
    .wb_standby(wb_standby),
    .wb_us_valid(wb_us_valid),
    .wb_us_ready(wb_us_ready),
    .wb_us_flag_update(wb_us_flag_update),
    .wb_us_flag_clr(wb_us_flag_clr),
    .wb_us_flag(wb_us_flag),
    .wb_us_wdata_src0(wb_us_wdata_src0),
    .wb_us_wdata_src1(wb_us_wdata_src1),
    .wb_us_wdata_src2(wb_us_wdata_src2),
    .wb_us_wdata_src3(wb_us_wdata_src3),
    .wb_us_src(wb_us_src),
    .wb_us_bit_wen(wb_us_bit_wen),
    .wb_us_mask_wdata(wb_us_mask_wdata),
    .wb_us_cmtted(wb_us_cmtted),
    .wb_us_last(wb_us_last),
    .wb_us_skip(wb_us_skip),
    .valu_cmt_valid(valu_cmt_valid),
    .valu_cmt_kill(valu_cmt_kill),
    .valu_vd_wvalid(valu_vd_wvalid),
    .valu_vd_wdata(valu_vd_wdata),
    .valu_vd_wmask(valu_vd_wmask),
    .valu_vd_wready(valu_vd_wready),
    .valu_vxsat_set(valu_vxsat_set)
);
kv_valu_vrf_buf u_valu_vrf_buf(
    .vpu_valu_clk(vpu_valu_clk),
    .vpu_reset_n(vpu_reset_n),
    .valu_vs1_rvalid(valu_vs1_rvalid),
    .valu_vs1_rready(valu_vs1_rready),
    .valu_vs1_rdata(valu_vs1_rdata),
    .valu_vs1_wide_rdata(valu_vs1_wide_rdata),
    .valu_vs1_rlast(valu_vs1_rlast),
    .valu_vs2_rvalid(valu_vs2_rvalid),
    .valu_vs2_rready(valu_vs2_rready),
    .valu_vs2_rdata(valu_vs2_rdata),
    .valu_vs2_wide_rdata(valu_vs2_wide_rdata),
    .valu_vs2_rlast(valu_vs2_rlast),
    .valu_vs3_rvalid(valu_vs3_rvalid),
    .valu_vs3_rready(valu_vs3_rready),
    .valu_vs3_rdata(valu_vs3_rdata),
    .valu_vs3_rlast(valu_vs3_rlast),
    .vrf_vs1_valid(vrf_vs1_valid),
    .vrf_vs1_rd(vrf_vs1_rd),
    .vrf_vs1_kill(vrf_vs1_kill),
    .vrf_vs1_rdata(vrf_vs1_rdata),
    .vrf_vs1_last(vrf_vs1_last),
    .vrf_vs1_wdata(vrf_vs1_wdata),
    .vrf_vs1_wr(vrf_vs1_wr),
    .vrf_vs1_wide_wdata(vrf_vs1_wide_wdata),
    .vrf_vs1_wide_rdata(vrf_vs1_wide_rdata),
    .vrf_vs1_wide_wr(vrf_vs1_wide_wr),
    .vrf_vs2_valid(vrf_vs2_valid),
    .vrf_vs2_rd(vrf_vs2_rd),
    .vrf_vs2_kill(vrf_vs2_kill),
    .vrf_vs2_rdata(vrf_vs2_rdata),
    .vrf_vs2_last(vrf_vs2_last),
    .vrf_vs2_wdata(vrf_vs2_wdata),
    .vrf_vs2_wr(vrf_vs2_wr),
    .vrf_vs2_wide_wdata(vrf_vs2_wide_wdata),
    .vrf_vs2_wide_rdata(vrf_vs2_wide_rdata),
    .vrf_vs2_wide_wr(vrf_vs2_wide_wr),
    .vrf_vd_valid(vrf_vd_valid),
    .vrf_vd_rd(vrf_vd_rd),
    .vrf_vd_kill(vrf_vd_kill),
    .vrf_vd_wr(vrf_vd_wr),
    .vrf_vd_wdata(vrf_vd_wdata),
    .vrf_vd_rdata(vrf_vd_rdata),
    .vrf_vd_last(vrf_vd_last),
    .vrf_vd_srl(vrf_vd_srl)
);
kv_valu_lane #(
    .ELEN(ELEN),
    .XLEN(XLEN)
) u_valu_lane (
    .clk(vpu_valu_clk),
    .rstn(vpu_reset_n),
    .valu_mask_byte8(valu_mask_byte8),
    .valu_nrr_mask_byte8(valu_nrr_mask_byte8),
    .valu_ci_byte8(valu_ci_byte8),
    .valu_ve1_veq_scalar_op(veq_ex_scalar_op),
    .valu_ve1_veq_nrr_scalar_op(veq_ex_nrr_scalar_op),
    .valu_ve1_veq_ctrl(veq_ex_ctrl_dup),
    .valu_ve1_veq_vxrm(veq_ex_vxrm),
    .valu_ve1_vs2_red_non_ext(valu_vs2_red_non_ext),
    .valu_vs1_src(vrf_vs1_rdata),
    .valu_vs2_src(vrf_vs2_rdata),
    .valu_vs2_wsrc(vrf_vs2_wide_rdata),
    .valu_vs1_wsrc(vrf_vs1_wide_rdata),
    .valu_data64(valu_data64),
    .valu_data32(valu_data32),
    .valu_data64_red(valu_data64_red),
    .valu_mresult(valu_mresult),
    .vxsat_set(vxsat_set)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

