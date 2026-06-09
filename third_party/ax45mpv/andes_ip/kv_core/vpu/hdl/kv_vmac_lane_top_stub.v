// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vmac_lane_top_stub (
    vpu_vmac_clk,
    vpu_reset_n,
    lane_id,
    vmac_standby_ready,
    vmac_lane_cross_type,
    vmac_lane_shift_type,
    vmac_vs1_lane_cross_data,
    vmac_vs1_lane_share_data,
    vmac_vs1_lane_shift_data,
    vmac_vs2_lane_cross_data,
    vmac_vs2_lane_share_cross_data,
    vmac_vs2_lane_share_shift_data,
    vmac_vs2_lane_shift_data,
    vmac_cmt_kill,
    vmac_cmt_valid,
    vmac_cmt_op1,
    vmac_dispatch_ctrl,
    vmac_dispatch_vd_len,
    vmac_dispatch_frm,
    vmac_dispatch_op1,
    vmac_dispatch_op1_hazard,
    vmac_dispatch_ready,
    vmac_dispatch_v0t,
    vmac_dispatch_valid,
    vmac_dispatch_vxrm,
    vmac_vs1_rdata,
    vmac_vs1_rready,
    vmac_vs1_rvalid,
    vmac_vs1_rlast,
    vmac_vs2_rdata,
    vmac_vs2_rready,
    vmac_vs2_rvalid,
    vmac_vs2_rlast,
    vmac_vs3_rdata,
    vmac_vs3_rready,
    vmac_vs3_rvalid,
    vmac_vs3_rlast,
    vmac_flag_set,
    vmac_vd_wdata,
    vmac_vd_wmask,
    vmac_vd_wready,
    vmac_vd_wvalid
);
parameter FELEN = 64;
parameter IELEN = 64;
parameter XLEN = 64;
parameter FLEN = 64;
parameter VLEN = 1024;
parameter DLEN = 512;
parameter VFMAC_SUPPORT = 1;
parameter VIMAC_SUPPORT = 1;
parameter VRF_LW = 3;
input vpu_vmac_clk;
input vpu_reset_n;
input [31:0] lane_id;
output vmac_standby_ready;
output [3:0] vmac_lane_cross_type;
output [3:0] vmac_lane_shift_type;
input [31:0] vmac_vs1_lane_cross_data;
output [63:0] vmac_vs1_lane_share_data;
input [63:0] vmac_vs1_lane_shift_data;
input [31:0] vmac_vs2_lane_cross_data;
output [63:0] vmac_vs2_lane_share_cross_data;
output [63:0] vmac_vs2_lane_share_shift_data;
input [63:0] vmac_vs2_lane_shift_data;
input vmac_cmt_kill;
input vmac_cmt_valid;
input [(XLEN - 1):0] vmac_cmt_op1;
input [(58 - 1):0] vmac_dispatch_ctrl;
input [(VRF_LW - 1):0] vmac_dispatch_vd_len;
input [2:0] vmac_dispatch_frm;
input [(XLEN - 1):0] vmac_dispatch_op1;
input vmac_dispatch_op1_hazard;
output vmac_dispatch_ready;
input [(VLEN - 1):0] vmac_dispatch_v0t;
input vmac_dispatch_valid;
input [1:0] vmac_dispatch_vxrm;
input [63:0] vmac_vs1_rdata;
output vmac_vs1_rready;
input vmac_vs1_rvalid;
input vmac_vs1_rlast;
input [63:0] vmac_vs2_rdata;
output vmac_vs2_rready;
input vmac_vs2_rvalid;
input vmac_vs2_rlast;
input [63:0] vmac_vs3_rdata;
output vmac_vs3_rready;
input vmac_vs3_rvalid;
input vmac_vs3_rlast;
output [5:0] vmac_flag_set;
output [63:0] vmac_vd_wdata;
output [7:0] vmac_vd_wmask;
input vmac_vd_wready;
output vmac_vd_wvalid;





// d279389c rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire nds_unused_vpu_vmac_clk = vpu_vmac_clk;
wire nds_unused_vpu_reset_n = vpu_reset_n;
wire [31:0] nds_unused_lane_id = lane_id;
assign vmac_standby_ready = 1'b1;
assign vmac_lane_cross_type = 4'b0;
assign vmac_lane_shift_type = 4'b0;
wire [31:0] nds_unused_vmac_vs1_lane_cross_data = vmac_vs1_lane_cross_data;
assign vmac_vs1_lane_share_data = 64'b0;
wire [63:0] nds_unused_vmac_vs1_lane_shift_data = vmac_vs1_lane_shift_data;
wire [31:0] nds_unused_vmac_vs2_lane_cross_data = vmac_vs2_lane_cross_data;
assign vmac_vs2_lane_share_cross_data = 64'b0;
assign vmac_vs2_lane_share_shift_data = 64'b0;
wire [63:0] nds_unused_vmac_vs2_lane_shift_data = vmac_vs2_lane_shift_data;
wire nds_unused_vmac_cmt_kill = vmac_cmt_kill;
wire nds_unused_vmac_cmt_valid = vmac_cmt_valid;
wire [(XLEN - 1):0] nds_unused_vmac_cmt_op1 = vmac_cmt_op1;
wire [(58 - 1):0] nds_unused_vmac_dispatch_ctrl = vmac_dispatch_ctrl;
wire [(VRF_LW - 1):0] nds_unused_vmac_dispatch_vd_len = vmac_dispatch_vd_len;
wire [2:0] nds_unused_vmac_dispatch_frm = vmac_dispatch_frm;
wire [(XLEN - 1):0] nds_unused_vmac_dispatch_op1 = vmac_dispatch_op1;
wire nds_unused_vmac_dispatch_op1_hazard = vmac_dispatch_op1_hazard;
assign vmac_dispatch_ready = 1'b0;
wire [(VLEN - 1):0] nds_unused_vmac_dispatch_v0t = vmac_dispatch_v0t;
wire nds_unused_vmac_dispatch_valid = vmac_dispatch_valid;
wire [1:0] nds_unused_vmac_dispatch_vxrm = vmac_dispatch_vxrm;
wire [63:0] nds_unused_vmac_vs1_rdata = vmac_vs1_rdata;
assign vmac_vs1_rready = 1'b0;
wire nds_unused_vmac_vs1_rvalid = vmac_vs1_rvalid;
wire nds_unused_vmac_vs1_rlast = vmac_vs1_rlast;
wire [63:0] nds_unused_vmac_vs2_rdata = vmac_vs2_rdata;
assign vmac_vs2_rready = 1'b0;
wire nds_unused_vmac_vs2_rvalid = vmac_vs2_rvalid;
wire nds_unused_vmac_vs2_rlast = vmac_vs2_rlast;
wire [63:0] nds_unused_vmac_vs3_rdata = vmac_vs3_rdata;
assign vmac_vs3_rready = 1'b0;
wire nds_unused_vmac_vs3_rvalid = vmac_vs3_rvalid;
wire nds_unused_vmac_vs3_rlast = vmac_vs3_rlast;
assign vmac_flag_set = 6'b0;
assign vmac_vd_wdata = 64'b0;
assign vmac_vd_wmask = 8'b0;
wire nds_unused_vmac_vd_wready = vmac_vd_wready;
assign vmac_vd_wvalid = 1'b0;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

