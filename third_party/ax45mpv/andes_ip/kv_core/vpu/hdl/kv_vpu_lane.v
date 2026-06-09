// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vpu_lane (
    valu_cmt_kill,
    valu_cmt_op1,
    valu_cmt_valid,
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
    valu_lane_cross_result_data,
    valu_lane_mask_result,
    valu_lane_share_result_data,
    valu_lane_vs1_data,
    valu_lane_vs1_wide_bdata,
    valu_lane_vs2_data,
    valu_lane_vs2_wide_bdata,
    valu_mask_result,
    valu_standby_ready,
    valu_vd_wdata,
    valu_vd_wmask,
    valu_vd_wready,
    valu_vd_wvalid,
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
    valu_vxsat_set,
    vpu_valu_clk,
    lane_id,
    vpu_reset_n,
    vfmis_dispatch_frm,
    vfmis_cmt_kill,
    vfmis_cmt_op1,
    vfmis_cmt_valid,
    vfmis_dispatch_ctrl,
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
    vfmis_f1_cmp_bit,
    vfmis_f1_lane_cmp_bit,
    vfmis_flag_set,
    vfmis_lane_cross_data,
    vfmis_lane_share_data,
    vfmis_lane_vs2_data,
    vfmis_lane_vs2_sel,
    vfmis_lane_vs2_x2_bdata,
    vfmis_lane_vs2_x4_bdata,
    vfmis_lane_vs2_x8_bdata,
    vfmis_standby_ready,
    vfmis_vd_wdata,
    vfmis_vd_wmask,
    vfmis_vd_wready,
    vfmis_vd_wvalid,
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
    vpu_vfmis_clk,
    vmac2_cmt_kill,
    vmac2_cmt_op1,
    vmac2_cmt_valid,
    vmac2_dispatch_ctrl,
    vmac2_dispatch_frm,
    vmac2_dispatch_op1,
    vmac2_dispatch_op1_hazard,
    vmac2_dispatch_ready,
    vmac2_dispatch_v0t,
    vmac2_dispatch_valid,
    vmac2_dispatch_vd_len,
    vmac2_dispatch_vxrm,
    vmac2_flag_set,
    vmac2_lane_cross_type,
    vmac2_lane_shift_type,
    vmac2_standby_ready,
    vmac2_vd_wdata,
    vmac2_vd_wmask,
    vmac2_vd_wready,
    vmac2_vd_wvalid,
    vmac2_vs1_lane_cross_data,
    vmac2_vs1_lane_share_data,
    vmac2_vs1_lane_shift_data,
    vmac2_vs1_rdata,
    vmac2_vs1_rlast,
    vmac2_vs1_rready,
    vmac2_vs1_rvalid,
    vmac2_vs2_lane_cross_data,
    vmac2_vs2_lane_share_cross_data,
    vmac2_vs2_lane_share_shift_data,
    vmac2_vs2_lane_shift_data,
    vmac2_vs2_rdata,
    vmac2_vs2_rlast,
    vmac2_vs2_rready,
    vmac2_vs2_rvalid,
    vmac2_vs3_rdata,
    vmac2_vs3_rlast,
    vmac2_vs3_rready,
    vmac2_vs3_rvalid,
    vpu_vmac_clk,
    vmac_cmt_kill,
    vmac_cmt_op1,
    vmac_cmt_valid,
    vmac_dispatch_ctrl,
    vmac_dispatch_frm,
    vmac_dispatch_op1,
    vmac_dispatch_op1_hazard,
    vmac_dispatch_ready,
    vmac_dispatch_v0t,
    vmac_dispatch_valid,
    vmac_dispatch_vd_len,
    vmac_dispatch_vxrm,
    vmac_flag_set,
    vmac_lane_cross_type,
    vmac_lane_shift_type,
    vmac_standby_ready,
    vmac_vd_wdata,
    vmac_vd_wmask,
    vmac_vd_wready,
    vmac_vd_wvalid,
    vmac_vs1_lane_cross_data,
    vmac_vs1_lane_share_data,
    vmac_vs1_lane_shift_data,
    vmac_vs1_rdata,
    vmac_vs1_rlast,
    vmac_vs1_rready,
    vmac_vs1_rvalid,
    vmac_vs2_lane_cross_data,
    vmac_vs2_lane_share_cross_data,
    vmac_vs2_lane_share_shift_data,
    vmac_vs2_lane_shift_data,
    vmac_vs2_rdata,
    vmac_vs2_rlast,
    vmac_vs2_rready,
    vmac_vs2_rvalid,
    vmac_vs3_rdata,
    vmac_vs3_rlast,
    vmac_vs3_rready,
    vmac_vs3_rvalid
);
parameter FLEN = 64;
parameter ELEN = 64;
parameter XLEN = 64;
parameter VLEN = 1024;
parameter DLEN = 512;
parameter FELEN = 32;
parameter VMAC2_TYPE = 0;
parameter VRF_LW = 4;
localparam VIMAC2_SUPPORT = ((VMAC2_TYPE == 2) || (VMAC2_TYPE == 3)) ? 1 : 0;
localparam VFMAC2_SUPPORT = ((VMAC2_TYPE == 1) || (VMAC2_TYPE == 3)) ? 1 : 0;
localparam VFMAC1_SUPPORT = (FELEN != 0) ? 1 : 0;
input valu_cmt_kill;
input [(XLEN - 1):0] valu_cmt_op1;
input valu_cmt_valid;
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
input [127:0] valu_lane_cross_result_data;
input [DLEN / 8 - 1:0] valu_lane_mask_result;
output [63:0] valu_lane_share_result_data;
output [63:0] valu_lane_vs1_data;
input [31:0] valu_lane_vs1_wide_bdata;
output [63:0] valu_lane_vs2_data;
input [31:0] valu_lane_vs2_wide_bdata;
output [7:0] valu_mask_result;
output valu_standby_ready;
output [63:0] valu_vd_wdata;
output [7:0] valu_vd_wmask;
input valu_vd_wready;
output valu_vd_wvalid;
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
output valu_vxsat_set;
input vpu_valu_clk;
input [31:0] lane_id;
input vpu_reset_n;
input [2:0] vfmis_dispatch_frm;
input vfmis_cmt_kill;
input [(XLEN - 1):0] vfmis_cmt_op1;
input vfmis_cmt_valid;
input [(71 - 1):0] vfmis_dispatch_ctrl;
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
output [3:0] vfmis_f1_cmp_bit;
input [DLEN / 16 - 1:0] vfmis_f1_lane_cmp_bit;
output [4:0] vfmis_flag_set;
input [127:0] vfmis_lane_cross_data;
output [63:0] vfmis_lane_share_data;
output [63:0] vfmis_lane_vs2_data;
output [2:0] vfmis_lane_vs2_sel;
input [31:0] vfmis_lane_vs2_x2_bdata;
input [15:0] vfmis_lane_vs2_x4_bdata;
input [7:0] vfmis_lane_vs2_x8_bdata;
output vfmis_standby_ready;
output [63:0] vfmis_vd_wdata;
output [7:0] vfmis_vd_wmask;
input vfmis_vd_wready;
output vfmis_vd_wvalid;
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
input vpu_vfmis_clk;
input vmac2_cmt_kill;
input [(XLEN - 1):0] vmac2_cmt_op1;
input vmac2_cmt_valid;
input [(58 - 1):0] vmac2_dispatch_ctrl;
input [2:0] vmac2_dispatch_frm;
input [(XLEN - 1):0] vmac2_dispatch_op1;
input vmac2_dispatch_op1_hazard;
output vmac2_dispatch_ready;
input [(VLEN - 1):0] vmac2_dispatch_v0t;
input vmac2_dispatch_valid;
input [(VRF_LW - 1):0] vmac2_dispatch_vd_len;
input [1:0] vmac2_dispatch_vxrm;
output [5:0] vmac2_flag_set;
output [3:0] vmac2_lane_cross_type;
output [3:0] vmac2_lane_shift_type;
output vmac2_standby_ready;
output [63:0] vmac2_vd_wdata;
output [7:0] vmac2_vd_wmask;
input vmac2_vd_wready;
output vmac2_vd_wvalid;
input [31:0] vmac2_vs1_lane_cross_data;
output [63:0] vmac2_vs1_lane_share_data;
input [63:0] vmac2_vs1_lane_shift_data;
input [63:0] vmac2_vs1_rdata;
input vmac2_vs1_rlast;
output vmac2_vs1_rready;
input vmac2_vs1_rvalid;
input [31:0] vmac2_vs2_lane_cross_data;
output [63:0] vmac2_vs2_lane_share_cross_data;
output [63:0] vmac2_vs2_lane_share_shift_data;
input [63:0] vmac2_vs2_lane_shift_data;
input [63:0] vmac2_vs2_rdata;
input vmac2_vs2_rlast;
output vmac2_vs2_rready;
input vmac2_vs2_rvalid;
input [63:0] vmac2_vs3_rdata;
input vmac2_vs3_rlast;
output vmac2_vs3_rready;
input vmac2_vs3_rvalid;
input vpu_vmac_clk;
input vmac_cmt_kill;
input [(XLEN - 1):0] vmac_cmt_op1;
input vmac_cmt_valid;
input [(58 - 1):0] vmac_dispatch_ctrl;
input [2:0] vmac_dispatch_frm;
input [(XLEN - 1):0] vmac_dispatch_op1;
input vmac_dispatch_op1_hazard;
output vmac_dispatch_ready;
input [(VLEN - 1):0] vmac_dispatch_v0t;
input vmac_dispatch_valid;
input [(VRF_LW - 1):0] vmac_dispatch_vd_len;
input [1:0] vmac_dispatch_vxrm;
output [5:0] vmac_flag_set;
output [3:0] vmac_lane_cross_type;
output [3:0] vmac_lane_shift_type;
output vmac_standby_ready;
output [63:0] vmac_vd_wdata;
output [7:0] vmac_vd_wmask;
input vmac_vd_wready;
output vmac_vd_wvalid;
input [31:0] vmac_vs1_lane_cross_data;
output [63:0] vmac_vs1_lane_share_data;
input [63:0] vmac_vs1_lane_shift_data;
input [63:0] vmac_vs1_rdata;
input vmac_vs1_rlast;
output vmac_vs1_rready;
input vmac_vs1_rvalid;
input [31:0] vmac_vs2_lane_cross_data;
output [63:0] vmac_vs2_lane_share_cross_data;
output [63:0] vmac_vs2_lane_share_shift_data;
input [63:0] vmac_vs2_lane_shift_data;
input [63:0] vmac_vs2_rdata;
input vmac_vs2_rlast;
output vmac_vs2_rready;
input vmac_vs2_rvalid;
input [63:0] vmac_vs3_rdata;
input vmac_vs3_rlast;
output vmac_vs3_rready;
input vmac_vs3_rvalid;





// 7c6842fa rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


kv_vmac_lane_top #(
    .DLEN(DLEN),
    .FELEN(FELEN),
    .FLEN(FLEN),
    .IELEN(ELEN),
    .VFMAC_SUPPORT(VFMAC1_SUPPORT),
    .VIMAC_SUPPORT(1),
    .VLEN(VLEN),
    .VRF_LW(VRF_LW),
    .XLEN(XLEN)
) u_vmac_lane_top (
    .vpu_vmac_clk(vpu_vmac_clk),
    .vpu_reset_n(vpu_reset_n),
    .lane_id(lane_id),
    .vmac_lane_cross_type(vmac_lane_cross_type),
    .vmac_lane_shift_type(vmac_lane_shift_type),
    .vmac_standby_ready(vmac_standby_ready),
    .vmac_vs1_lane_cross_data(vmac_vs1_lane_cross_data),
    .vmac_vs1_lane_share_data(vmac_vs1_lane_share_data),
    .vmac_vs1_lane_shift_data(vmac_vs1_lane_shift_data),
    .vmac_vs2_lane_cross_data(vmac_vs2_lane_cross_data),
    .vmac_vs2_lane_share_cross_data(vmac_vs2_lane_share_cross_data),
    .vmac_vs2_lane_share_shift_data(vmac_vs2_lane_share_shift_data),
    .vmac_vs2_lane_shift_data(vmac_vs2_lane_shift_data),
    .vmac_cmt_kill(vmac_cmt_kill),
    .vmac_cmt_valid(vmac_cmt_valid),
    .vmac_cmt_op1(vmac_cmt_op1),
    .vmac_dispatch_ctrl(vmac_dispatch_ctrl),
    .vmac_dispatch_frm(vmac_dispatch_frm),
    .vmac_dispatch_op1(vmac_dispatch_op1),
    .vmac_dispatch_op1_hazard(vmac_dispatch_op1_hazard),
    .vmac_dispatch_ready(vmac_dispatch_ready),
    .vmac_dispatch_v0t(vmac_dispatch_v0t),
    .vmac_dispatch_valid(vmac_dispatch_valid),
    .vmac_dispatch_vd_len(vmac_dispatch_vd_len),
    .vmac_dispatch_vxrm(vmac_dispatch_vxrm),
    .vmac_vs1_rdata(vmac_vs1_rdata),
    .vmac_vs1_rlast(vmac_vs1_rlast),
    .vmac_vs1_rready(vmac_vs1_rready),
    .vmac_vs1_rvalid(vmac_vs1_rvalid),
    .vmac_vs2_rdata(vmac_vs2_rdata),
    .vmac_vs2_rlast(vmac_vs2_rlast),
    .vmac_vs2_rready(vmac_vs2_rready),
    .vmac_vs2_rvalid(vmac_vs2_rvalid),
    .vmac_vs3_rdata(vmac_vs3_rdata),
    .vmac_vs3_rlast(vmac_vs3_rlast),
    .vmac_vs3_rready(vmac_vs3_rready),
    .vmac_vs3_rvalid(vmac_vs3_rvalid),
    .vmac_flag_set(vmac_flag_set),
    .vmac_vd_wdata(vmac_vd_wdata),
    .vmac_vd_wmask(vmac_vd_wmask),
    .vmac_vd_wready(vmac_vd_wready),
    .vmac_vd_wvalid(vmac_vd_wvalid)
);
generate
    if (VMAC2_TYPE != 0) begin:gen_vmac2
        kv_vmac_lane_top #(
            .DLEN(DLEN),
            .FELEN(FELEN),
            .FLEN(FLEN),
            .IELEN(ELEN),
            .VFMAC_SUPPORT(VFMAC2_SUPPORT),
            .VIMAC_SUPPORT(VIMAC2_SUPPORT),
            .VLEN(VLEN),
            .VRF_LW(VRF_LW),
            .XLEN(XLEN)
        ) u_vmac2_lane_top (
            .vpu_vmac_clk(vpu_vmac_clk),
            .vpu_reset_n(vpu_reset_n),
            .lane_id(lane_id),
            .vmac_lane_cross_type(vmac2_lane_cross_type),
            .vmac_lane_shift_type(vmac2_lane_shift_type),
            .vmac_standby_ready(vmac2_standby_ready),
            .vmac_vs1_lane_cross_data(vmac2_vs1_lane_cross_data),
            .vmac_vs1_lane_share_data(vmac2_vs1_lane_share_data),
            .vmac_vs1_lane_shift_data(vmac2_vs1_lane_shift_data),
            .vmac_vs2_lane_cross_data(vmac2_vs2_lane_cross_data),
            .vmac_vs2_lane_share_cross_data(vmac2_vs2_lane_share_cross_data),
            .vmac_vs2_lane_share_shift_data(vmac2_vs2_lane_share_shift_data),
            .vmac_vs2_lane_shift_data(vmac2_vs2_lane_shift_data),
            .vmac_cmt_kill(vmac2_cmt_kill),
            .vmac_cmt_valid(vmac2_cmt_valid),
            .vmac_cmt_op1(vmac2_cmt_op1),
            .vmac_dispatch_ctrl(vmac2_dispatch_ctrl),
            .vmac_dispatch_frm(vmac2_dispatch_frm),
            .vmac_dispatch_op1(vmac2_dispatch_op1),
            .vmac_dispatch_op1_hazard(vmac2_dispatch_op1_hazard),
            .vmac_dispatch_ready(vmac2_dispatch_ready),
            .vmac_dispatch_v0t(vmac2_dispatch_v0t),
            .vmac_dispatch_valid(vmac2_dispatch_valid),
            .vmac_dispatch_vd_len(vmac2_dispatch_vd_len),
            .vmac_dispatch_vxrm(vmac2_dispatch_vxrm),
            .vmac_vs1_rdata(vmac2_vs1_rdata),
            .vmac_vs1_rlast(vmac2_vs1_rlast),
            .vmac_vs1_rready(vmac2_vs1_rready),
            .vmac_vs1_rvalid(vmac2_vs1_rvalid),
            .vmac_vs2_rdata(vmac2_vs2_rdata),
            .vmac_vs2_rlast(vmac2_vs2_rlast),
            .vmac_vs2_rready(vmac2_vs2_rready),
            .vmac_vs2_rvalid(vmac2_vs2_rvalid),
            .vmac_vs3_rdata(vmac2_vs3_rdata),
            .vmac_vs3_rlast(vmac2_vs3_rlast),
            .vmac_vs3_rready(vmac2_vs3_rready),
            .vmac_vs3_rvalid(vmac2_vs3_rvalid),
            .vmac_flag_set(vmac2_flag_set),
            .vmac_vd_wdata(vmac2_vd_wdata),
            .vmac_vd_wmask(vmac2_vd_wmask),
            .vmac_vd_wready(vmac2_vd_wready),
            .vmac_vd_wvalid(vmac2_vd_wvalid)
        );
    end
endgenerate
generate
    if (VMAC2_TYPE == 0) begin:gen_vmac2_stub
        kv_vmac_lane_top_stub #(
            .DLEN(DLEN),
            .FELEN(FELEN),
            .FLEN(FLEN),
            .IELEN(ELEN),
            .VFMAC_SUPPORT(VFMAC2_SUPPORT),
            .VIMAC_SUPPORT(VIMAC2_SUPPORT),
            .VLEN(VLEN),
            .VRF_LW(VRF_LW),
            .XLEN(XLEN)
        ) u_vmac2_lane_top_stub (
            .vpu_vmac_clk(vpu_vmac_clk),
            .vpu_reset_n(vpu_reset_n),
            .lane_id(lane_id),
            .vmac_standby_ready(vmac2_standby_ready),
            .vmac_lane_cross_type(vmac2_lane_cross_type),
            .vmac_lane_shift_type(vmac2_lane_shift_type),
            .vmac_vs1_lane_cross_data(vmac2_vs1_lane_cross_data),
            .vmac_vs1_lane_share_data(vmac2_vs1_lane_share_data),
            .vmac_vs1_lane_shift_data(vmac2_vs1_lane_shift_data),
            .vmac_vs2_lane_cross_data(vmac2_vs2_lane_cross_data),
            .vmac_vs2_lane_share_cross_data(vmac2_vs2_lane_share_cross_data),
            .vmac_vs2_lane_share_shift_data(vmac2_vs2_lane_share_shift_data),
            .vmac_vs2_lane_shift_data(vmac2_vs2_lane_shift_data),
            .vmac_cmt_kill(vmac2_cmt_kill),
            .vmac_cmt_valid(vmac2_cmt_valid),
            .vmac_cmt_op1(vmac2_cmt_op1),
            .vmac_dispatch_ctrl(vmac2_dispatch_ctrl),
            .vmac_dispatch_vd_len(vmac2_dispatch_vd_len),
            .vmac_dispatch_frm(vmac2_dispatch_frm),
            .vmac_dispatch_op1(vmac2_dispatch_op1),
            .vmac_dispatch_op1_hazard(vmac2_dispatch_op1_hazard),
            .vmac_dispatch_ready(vmac2_dispatch_ready),
            .vmac_dispatch_v0t(vmac2_dispatch_v0t),
            .vmac_dispatch_valid(vmac2_dispatch_valid),
            .vmac_dispatch_vxrm(vmac2_dispatch_vxrm),
            .vmac_vs1_rdata(vmac2_vs1_rdata),
            .vmac_vs1_rready(vmac2_vs1_rready),
            .vmac_vs1_rvalid(vmac2_vs1_rvalid),
            .vmac_vs1_rlast(vmac2_vs1_rlast),
            .vmac_vs2_rdata(vmac2_vs2_rdata),
            .vmac_vs2_rready(vmac2_vs2_rready),
            .vmac_vs2_rvalid(vmac2_vs2_rvalid),
            .vmac_vs2_rlast(vmac2_vs2_rlast),
            .vmac_vs3_rdata(vmac2_vs3_rdata),
            .vmac_vs3_rready(vmac2_vs3_rready),
            .vmac_vs3_rvalid(vmac2_vs3_rvalid),
            .vmac_vs3_rlast(vmac2_vs3_rlast),
            .vmac_flag_set(vmac2_flag_set),
            .vmac_vd_wdata(vmac2_vd_wdata),
            .vmac_vd_wmask(vmac2_vd_wmask),
            .vmac_vd_wready(vmac2_vd_wready),
            .vmac_vd_wvalid(vmac2_vd_wvalid)
        );
    end
endgenerate
generate
    if (FELEN == 0) begin:gen_vfmis_lane_top_stub
        kv_vfmis_lane_top_stub #(
            .DLEN(DLEN),
            .FELEN(FELEN),
            .FLEN(FLEN),
            .IELEN(ELEN),
            .VLEN(VLEN),
            .VRF_LW(VRF_LW),
            .XLEN(XLEN)
        ) u_vfmis_lane_top_stub (
            .lane_id(lane_id),
            .vfmis_standby_ready(vfmis_standby_ready),
            .vfmis_f1_lane_cmp_bit(vfmis_f1_lane_cmp_bit),
            .vfmis_lane_vs2_data(vfmis_lane_vs2_data),
            .vfmis_lane_vs2_x2_bdata(vfmis_lane_vs2_x2_bdata),
            .vfmis_lane_vs2_x4_bdata(vfmis_lane_vs2_x4_bdata),
            .vfmis_lane_vs2_x8_bdata(vfmis_lane_vs2_x8_bdata),
            .vfmis_lane_vs2_sel(vfmis_lane_vs2_sel),
            .vfmis_lane_cross_data(vfmis_lane_cross_data),
            .vpu_vfmis_clk(vpu_vfmis_clk),
            .vpu_reset_n(vpu_reset_n),
            .vfmis_cmt_kill(vfmis_cmt_kill),
            .vfmis_cmt_valid(vfmis_cmt_valid),
            .vfmis_f1_cmp_bit(vfmis_f1_cmp_bit),
            .vfmis_lane_share_data(vfmis_lane_share_data),
            .vfmis_cmt_op1(vfmis_cmt_op1),
            .vfmis_dispatch_ctrl(vfmis_dispatch_ctrl),
            .vfmis_dispatch_vd_len(vfmis_dispatch_vd_len),
            .vfmis_dispatch_op1(vfmis_dispatch_op1),
            .vfmis_dispatch_op1_hazard(vfmis_dispatch_op1_hazard),
            .vfmis_dispatch_ready(vfmis_dispatch_ready),
            .vfmis_dispatch_v0t_e_mask(vfmis_dispatch_v0t_e_mask),
            .vfmis_dispatch_v0t_sew16(vfmis_dispatch_v0t_sew16),
            .vfmis_dispatch_v0t_sew32(vfmis_dispatch_v0t_sew32),
            .vfmis_dispatch_v0t_sew64(vfmis_dispatch_v0t_sew64),
            .vfmis_dispatch_v0t_sew8(vfmis_dispatch_v0t_sew8),
            .vfmis_dispatch_valid(vfmis_dispatch_valid),
            .vfmis_vs1_rdata(vfmis_vs1_rdata),
            .vfmis_vs1_rready(vfmis_vs1_rready),
            .vfmis_vs1_rvalid(vfmis_vs1_rvalid),
            .vfmis_vs1_rlast(vfmis_vs1_rlast),
            .vfmis_vs2_rdata(vfmis_vs2_rdata),
            .vfmis_vs2_rready(vfmis_vs2_rready),
            .vfmis_vs2_rvalid(vfmis_vs2_rvalid),
            .vfmis_vs2_rlast(vfmis_vs2_rlast),
            .vfmis_vs2_wide_rdata(vfmis_vs2_wide_rdata),
            .vfmis_vs3_rdata(vfmis_vs3_rdata),
            .vfmis_vs3_rready(vfmis_vs3_rready),
            .vfmis_vs3_rvalid(vfmis_vs3_rvalid),
            .vfmis_vs3_rlast(vfmis_vs3_rlast),
            .vfmis_flag_set(vfmis_flag_set),
            .vfmis_vd_wdata(vfmis_vd_wdata),
            .vfmis_vd_wmask(vfmis_vd_wmask),
            .vfmis_vd_wready(vfmis_vd_wready),
            .vfmis_vd_wvalid(vfmis_vd_wvalid)
        );
    end
endgenerate
generate
    if (FELEN != 0) begin:gen_vfmis_lane_top
        kv_vfmis_lane_top #(
            .DLEN(DLEN),
            .FELEN(FELEN),
            .FLEN(FLEN),
            .IELEN(ELEN),
            .VLEN(VLEN),
            .VRF_LW(VRF_LW),
            .XLEN(XLEN)
        ) u_vfmis_lane_top (
            .lane_id(lane_id),
            .vfmis_f1_lane_cmp_bit(vfmis_f1_lane_cmp_bit),
            .vfmis_lane_cross_data(vfmis_lane_cross_data),
            .vfmis_lane_share_data(vfmis_lane_share_data),
            .vfmis_lane_vs2_data(vfmis_lane_vs2_data),
            .vfmis_lane_vs2_sel(vfmis_lane_vs2_sel),
            .vfmis_lane_vs2_x2_bdata(vfmis_lane_vs2_x2_bdata),
            .vfmis_lane_vs2_x4_bdata(vfmis_lane_vs2_x4_bdata),
            .vfmis_lane_vs2_x8_bdata(vfmis_lane_vs2_x8_bdata),
            .vfmis_standby_ready(vfmis_standby_ready),
            .vpu_vfmis_clk(vpu_vfmis_clk),
            .vpu_reset_n(vpu_reset_n),
            .vfmis_cmt_kill(vfmis_cmt_kill),
            .vfmis_cmt_valid(vfmis_cmt_valid),
            .vfmis_f1_cmp_bit(vfmis_f1_cmp_bit),
            .vfmis_cmt_op1(vfmis_cmt_op1),
            .vfmis_dispatch_ctrl(vfmis_dispatch_ctrl),
            .vfmis_dispatch_frm(vfmis_dispatch_frm),
            .vfmis_dispatch_op1(vfmis_dispatch_op1),
            .vfmis_dispatch_op1_hazard(vfmis_dispatch_op1_hazard),
            .vfmis_dispatch_ready(vfmis_dispatch_ready),
            .vfmis_dispatch_v0t_e_mask(vfmis_dispatch_v0t_e_mask),
            .vfmis_dispatch_v0t_sew16(vfmis_dispatch_v0t_sew16),
            .vfmis_dispatch_v0t_sew32(vfmis_dispatch_v0t_sew32),
            .vfmis_dispatch_v0t_sew64(vfmis_dispatch_v0t_sew64),
            .vfmis_dispatch_v0t_sew8(vfmis_dispatch_v0t_sew8),
            .vfmis_dispatch_valid(vfmis_dispatch_valid),
            .vfmis_dispatch_vd_len(vfmis_dispatch_vd_len),
            .vfmis_vs1_rdata(vfmis_vs1_rdata),
            .vfmis_vs1_rlast(vfmis_vs1_rlast),
            .vfmis_vs1_rready(vfmis_vs1_rready),
            .vfmis_vs1_rvalid(vfmis_vs1_rvalid),
            .vfmis_vs2_rdata(vfmis_vs2_rdata),
            .vfmis_vs2_rlast(vfmis_vs2_rlast),
            .vfmis_vs2_rready(vfmis_vs2_rready),
            .vfmis_vs2_rvalid(vfmis_vs2_rvalid),
            .vfmis_vs2_wide_rdata(vfmis_vs2_wide_rdata),
            .vfmis_vs3_rdata(vfmis_vs3_rdata),
            .vfmis_vs3_rlast(vfmis_vs3_rlast),
            .vfmis_vs3_rready(vfmis_vs3_rready),
            .vfmis_vs3_rvalid(vfmis_vs3_rvalid),
            .vfmis_flag_set(vfmis_flag_set),
            .vfmis_vd_wdata(vfmis_vd_wdata),
            .vfmis_vd_wmask(vfmis_vd_wmask),
            .vfmis_vd_wready(vfmis_vd_wready),
            .vfmis_vd_wvalid(vfmis_vd_wvalid)
        );
    end
endgenerate
kv_valu_lane_top #(
    .DLEN(DLEN),
    .ELEN(ELEN),
    .VLEN(VLEN),
    .VRF_LW(VRF_LW),
    .XLEN(XLEN)
) u_valu_lane_top (
    .lane_id(lane_id),
    .valu_lane_cross_result_data(valu_lane_cross_result_data),
    .valu_lane_mask_result(valu_lane_mask_result),
    .valu_lane_share_result_data(valu_lane_share_result_data),
    .valu_lane_vs1_data(valu_lane_vs1_data),
    .valu_lane_vs1_wide_bdata(valu_lane_vs1_wide_bdata),
    .valu_lane_vs2_data(valu_lane_vs2_data),
    .valu_lane_vs2_wide_bdata(valu_lane_vs2_wide_bdata),
    .valu_mask_result(valu_mask_result),
    .valu_standby_ready(valu_standby_ready),
    .vpu_valu_clk(vpu_valu_clk),
    .vpu_reset_n(vpu_reset_n),
    .valu_cmt_kill(valu_cmt_kill),
    .valu_cmt_valid(valu_cmt_valid),
    .valu_cmt_op1(valu_cmt_op1),
    .valu_dispatch_ctrl(valu_dispatch_ctrl),
    .valu_dispatch_op1(valu_dispatch_op1),
    .valu_dispatch_op1_hazard(valu_dispatch_op1_hazard),
    .valu_dispatch_ready(valu_dispatch_ready),
    .valu_dispatch_v0t_e_mask0(valu_dispatch_v0t_e_mask0),
    .valu_dispatch_v0t_e_mask1(valu_dispatch_v0t_e_mask1),
    .valu_dispatch_v0t_sew16(valu_dispatch_v0t_sew16),
    .valu_dispatch_v0t_sew32(valu_dispatch_v0t_sew32),
    .valu_dispatch_v0t_sew64(valu_dispatch_v0t_sew64),
    .valu_dispatch_v0t_sew8(valu_dispatch_v0t_sew8),
    .valu_dispatch_valid(valu_dispatch_valid),
    .valu_dispatch_vd_len(valu_dispatch_vd_len),
    .valu_dispatch_vxrm(valu_dispatch_vxrm),
    .valu_vs1_rdata(valu_vs1_rdata),
    .valu_vs1_rlast(valu_vs1_rlast),
    .valu_vs1_rready(valu_vs1_rready),
    .valu_vs1_rvalid(valu_vs1_rvalid),
    .valu_vs1_wide_rdata(valu_vs1_wide_rdata),
    .valu_vs2_rdata(valu_vs2_rdata),
    .valu_vs2_rlast(valu_vs2_rlast),
    .valu_vs2_rready(valu_vs2_rready),
    .valu_vs2_rvalid(valu_vs2_rvalid),
    .valu_vs2_wide_rdata(valu_vs2_wide_rdata),
    .valu_vs3_rdata(valu_vs3_rdata),
    .valu_vs3_rlast(valu_vs3_rlast),
    .valu_vs3_rready(valu_vs3_rready),
    .valu_vs3_rvalid(valu_vs3_rvalid),
    .valu_vd_wdata(valu_vd_wdata),
    .valu_vd_wmask(valu_vd_wmask),
    .valu_vd_wready(valu_vd_wready),
    .valu_vd_wvalid(valu_vd_wvalid),
    .valu_vxsat_set(valu_vxsat_set)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

