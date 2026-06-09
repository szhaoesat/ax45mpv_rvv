// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfmis_lane_top_stub (
    lane_id,
    vfmis_standby_ready,
    vfmis_f1_lane_cmp_bit,
    vfmis_lane_vs2_data,
    vfmis_lane_vs2_x2_bdata,
    vfmis_lane_vs2_x4_bdata,
    vfmis_lane_vs2_x8_bdata,
    vfmis_lane_vs2_sel,
    vfmis_lane_cross_data,
    vpu_vfmis_clk,
    vpu_reset_n,
    vfmis_cmt_kill,
    vfmis_cmt_valid,
    vfmis_f1_cmp_bit,
    vfmis_lane_share_data,
    vfmis_cmt_op1,
    vfmis_dispatch_ctrl,
    vfmis_dispatch_vd_len,
    vfmis_dispatch_op1,
    vfmis_dispatch_op1_hazard,
    vfmis_dispatch_ready,
    vfmis_dispatch_v0t_e_mask,
    vfmis_dispatch_v0t_sew16,
    vfmis_dispatch_v0t_sew32,
    vfmis_dispatch_v0t_sew64,
    vfmis_dispatch_v0t_sew8,
    vfmis_dispatch_valid,
    vfmis_vs1_rdata,
    vfmis_vs1_rready,
    vfmis_vs1_rvalid,
    vfmis_vs1_rlast,
    vfmis_vs2_rdata,
    vfmis_vs2_rready,
    vfmis_vs2_rvalid,
    vfmis_vs2_rlast,
    vfmis_vs2_wide_rdata,
    vfmis_vs3_rdata,
    vfmis_vs3_rready,
    vfmis_vs3_rvalid,
    vfmis_vs3_rlast,
    vfmis_flag_set,
    vfmis_vd_wdata,
    vfmis_vd_wmask,
    vfmis_vd_wready,
    vfmis_vd_wvalid
);
parameter IELEN = 64;
parameter FELEN = 64;
parameter XLEN = 64;
parameter FLEN = 64;
parameter VLEN = 1024;
parameter DLEN = 512;
parameter VRF_LW = 4;
input [31:0] lane_id;
output vfmis_standby_ready;
input [DLEN / 16 - 1:0] vfmis_f1_lane_cmp_bit;
output [63:0] vfmis_lane_vs2_data;
input [31:0] vfmis_lane_vs2_x2_bdata;
input [15:0] vfmis_lane_vs2_x4_bdata;
input [7:0] vfmis_lane_vs2_x8_bdata;
output [2:0] vfmis_lane_vs2_sel;
input [127:0] vfmis_lane_cross_data;
input vpu_vfmis_clk;
input vpu_reset_n;
input vfmis_cmt_kill;
input vfmis_cmt_valid;
output [3:0] vfmis_f1_cmp_bit;
output [63:0] vfmis_lane_share_data;
input [(XLEN - 1):0] vfmis_cmt_op1;
input [(71 - 1):0] vfmis_dispatch_ctrl;
input [(VRF_LW - 1):0] vfmis_dispatch_vd_len;
input [(XLEN - 1):0] vfmis_dispatch_op1;
input vfmis_dispatch_op1_hazard;
output vfmis_dispatch_ready;
input [63:0] vfmis_dispatch_v0t_e_mask;
input [63:0] vfmis_dispatch_v0t_sew16;
input [31:0] vfmis_dispatch_v0t_sew32;
input [15:0] vfmis_dispatch_v0t_sew64;
input [127:0] vfmis_dispatch_v0t_sew8;
input vfmis_dispatch_valid;
input [63:0] vfmis_vs1_rdata;
output vfmis_vs1_rready;
input vfmis_vs1_rvalid;
input vfmis_vs1_rlast;
input [63:0] vfmis_vs2_rdata;
output vfmis_vs2_rready;
input vfmis_vs2_rvalid;
input vfmis_vs2_rlast;
input [31:0] vfmis_vs2_wide_rdata;
input [63:0] vfmis_vs3_rdata;
output vfmis_vs3_rready;
input vfmis_vs3_rvalid;
input vfmis_vs3_rlast;
output [4:0] vfmis_flag_set;
output [63:0] vfmis_vd_wdata;
output [7:0] vfmis_vd_wmask;
input vfmis_vd_wready;
output vfmis_vd_wvalid;





// fce7cab5 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


assign vfmis_standby_ready = 1'b1;
assign vfmis_f1_cmp_bit = 4'b0;
assign vfmis_lane_share_data = 64'b0;
assign vfmis_lane_vs2_data = 64'b0;
assign vfmis_dispatch_ready = 1'b0;
assign vfmis_vs1_rready = 1'b0;
assign vfmis_vs2_rready = 1'b0;
assign vfmis_vs3_rready = 1'b0;
assign vfmis_flag_set = 5'b0;
assign vfmis_vd_wdata = 64'b0;
assign vfmis_vd_wmask = 8'b0;
assign vfmis_vd_wvalid = 1'b0;
assign vfmis_lane_vs2_sel = 3'b0;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

