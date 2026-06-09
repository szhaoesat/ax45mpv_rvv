// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vpu_lane_top (
    vmac_fflags_set,
    vmac2_fflags_set,
    vfmis_fflags_set,
    valu_vxsat_set,
    vmac_vxsat_set,
    vmac2_vxsat_set,
    valu_cmt_kill,
    valu_cmt_op1,
    valu_cmt_valid,
    valu_dispatch_ctrl,
    valu_dispatch_vd_len,
    valu_dispatch_vxrm,
    valu_dispatch_op1,
    valu_dispatch_op1_hazard,
    valu_dispatch_ready,
    valu_dispatch_v0t,
    valu_dispatch_valid,
    valu_vd_wdata,
    valu_vd_wmask,
    valu_vd_wready,
    valu_vd_wvalid,
    valu_vs1_rdata,
    valu_vs1_rlast,
    valu_vs1_rready,
    valu_vs1_rvalid,
    valu_vs2_rdata,
    valu_vs2_rlast,
    valu_vs2_rready,
    valu_vs2_rvalid,
    valu_vs3_rdata,
    valu_vs3_rlast,
    valu_vs3_rready,
    valu_vs3_rvalid,
    vfmis_cmt_kill,
    vfmis_cmt_op1,
    vfmis_cmt_valid,
    vfmis_dispatch_ctrl,
    vfmis_dispatch_vd_len,
    vfmis_dispatch_frm,
    vfmis_dispatch_op1,
    vfmis_dispatch_op1_hazard,
    vfmis_dispatch_ready,
    vfmis_dispatch_v0t,
    vfmis_dispatch_valid,
    vfmis_vd_wdata,
    vfmis_vd_wmask,
    vfmis_vd_wready,
    vfmis_vd_wvalid,
    vfmis_vs1_rdata,
    vfmis_vs1_rready,
    vfmis_vs1_rvalid,
    vfmis_vs1_rlast,
    vfmis_vs2_rdata,
    vfmis_vs2_rready,
    vfmis_vs2_rvalid,
    vfmis_vs2_rlast,
    vfmis_vs3_rdata,
    vfmis_vs3_rready,
    vfmis_vs3_rvalid,
    vfmis_vs3_rlast,
    vmac_cmt_kill,
    vmac_cmt_op1,
    vmac_cmt_valid,
    vmac_dispatch_ctrl,
    vmac_dispatch_vd_len,
    vmac_dispatch_frm,
    vmac_dispatch_vxrm,
    vmac_dispatch_op1,
    vmac_dispatch_op1_hazard,
    vmac_dispatch_ready,
    vmac_dispatch_v0t,
    vmac_dispatch_valid,
    vmac_vd_wdata,
    vmac_vd_wmask,
    vmac_vd_wready,
    vmac_vd_wvalid,
    vmac_vs1_rdata,
    vmac_vs1_rlast,
    vmac_vs1_rready,
    vmac_vs1_rvalid,
    vmac_vs2_rdata,
    vmac_vs2_rlast,
    vmac_vs2_rready,
    vmac_vs2_rvalid,
    vmac_vs3_rdata,
    vmac_vs3_rlast,
    vmac_vs3_rready,
    vmac_vs3_rvalid,
    vmac2_cmt_kill,
    vmac2_cmt_op1,
    vmac2_cmt_valid,
    vmac2_dispatch_ctrl,
    vmac2_dispatch_vd_len,
    vmac2_dispatch_frm,
    vmac2_dispatch_vxrm,
    vmac2_dispatch_op1,
    vmac2_dispatch_op1_hazard,
    vmac2_dispatch_ready,
    vmac2_dispatch_v0t,
    vmac2_dispatch_valid,
    vmac2_vd_wdata,
    vmac2_vd_wmask,
    vmac2_vd_wready,
    vmac2_vd_wvalid,
    vmac2_vs1_rdata,
    vmac2_vs1_rready,
    vmac2_vs1_rvalid,
    vmac2_vs1_rlast,
    vmac2_vs2_rdata,
    vmac2_vs2_rready,
    vmac2_vs2_rvalid,
    vmac2_vs2_rlast,
    vmac2_vs3_rdata,
    vmac2_vs3_rready,
    vmac2_vs3_rvalid,
    vmac2_vs3_rlast,
    valu_standby_ready,
    vmac_standby_ready,
    vfmis_standby_ready,
    vpu_valu_clk,
    vpu_vfmis_clk,
    vpu_vmac_clk,
    vpu_reset_n
);
parameter ELEN = 64;
parameter FELEN = 32;
parameter XLEN = 64;
parameter FLEN = 64;
parameter VLEN = 1024;
parameter DLEN = 512;
parameter VMAC2_TYPE = 0;
parameter VRF_LW = 4;
localparam LANE_NUM = DLEN / 64;
output [4:0] vmac_fflags_set;
output [4:0] vmac2_fflags_set;
output [4:0] vfmis_fflags_set;
output valu_vxsat_set;
output vmac_vxsat_set;
output vmac2_vxsat_set;
output valu_standby_ready;
output vmac_standby_ready;
output vfmis_standby_ready;
input valu_cmt_kill;
input [(XLEN - 1):0] valu_cmt_op1;
input valu_cmt_valid;
input [(58 - 1):0] valu_dispatch_ctrl;
input [VRF_LW - 1:0] valu_dispatch_vd_len;
input [1:0] valu_dispatch_vxrm;
input [(XLEN - 1):0] valu_dispatch_op1;
input valu_dispatch_op1_hazard;
output valu_dispatch_ready;
input [(VLEN - 1):0] valu_dispatch_v0t;
input valu_dispatch_valid;
output [DLEN - 1:0] valu_vd_wdata;
output [DLEN / 8 - 1:0] valu_vd_wmask;
input valu_vd_wready;
output valu_vd_wvalid;
input [DLEN - 1:0] valu_vs1_rdata;
input valu_vs1_rlast;
output valu_vs1_rready;
input valu_vs1_rvalid;
input [DLEN - 1:0] valu_vs2_rdata;
input valu_vs2_rlast;
output valu_vs2_rready;
input valu_vs2_rvalid;
input [DLEN - 1:0] valu_vs3_rdata;
input valu_vs3_rlast;
output valu_vs3_rready;
input valu_vs3_rvalid;
input vfmis_cmt_kill;
input [(XLEN - 1):0] vfmis_cmt_op1;
input vfmis_cmt_valid;
input [(71 - 1):0] vfmis_dispatch_ctrl;
input [VRF_LW - 1:0] vfmis_dispatch_vd_len;
input [2:0] vfmis_dispatch_frm;
input [(XLEN - 1):0] vfmis_dispatch_op1;
input vfmis_dispatch_op1_hazard;
output vfmis_dispatch_ready;
input [(VLEN - 1):0] vfmis_dispatch_v0t;
input vfmis_dispatch_valid;
output [DLEN - 1:0] vfmis_vd_wdata;
output [DLEN / 8 - 1:0] vfmis_vd_wmask;
input vfmis_vd_wready;
output vfmis_vd_wvalid;
input [DLEN - 1:0] vfmis_vs1_rdata;
output vfmis_vs1_rready;
input vfmis_vs1_rvalid;
input vfmis_vs1_rlast;
input [DLEN - 1:0] vfmis_vs2_rdata;
output vfmis_vs2_rready;
input vfmis_vs2_rvalid;
input vfmis_vs2_rlast;
input [DLEN - 1:0] vfmis_vs3_rdata;
output vfmis_vs3_rready;
input vfmis_vs3_rvalid;
input vfmis_vs3_rlast;
input vmac_cmt_kill;
input [(XLEN - 1):0] vmac_cmt_op1;
input vmac_cmt_valid;
input [(58 - 1):0] vmac_dispatch_ctrl;
input [VRF_LW - 1:0] vmac_dispatch_vd_len;
input [2:0] vmac_dispatch_frm;
input [1:0] vmac_dispatch_vxrm;
input [(XLEN - 1):0] vmac_dispatch_op1;
input vmac_dispatch_op1_hazard;
output vmac_dispatch_ready;
input [(VLEN - 1):0] vmac_dispatch_v0t;
input vmac_dispatch_valid;
output [DLEN - 1:0] vmac_vd_wdata;
output [DLEN / 8 - 1:0] vmac_vd_wmask;
input vmac_vd_wready;
output vmac_vd_wvalid;
input [DLEN - 1:0] vmac_vs1_rdata;
input vmac_vs1_rlast;
output vmac_vs1_rready;
input vmac_vs1_rvalid;
input [DLEN - 1:0] vmac_vs2_rdata;
input vmac_vs2_rlast;
output vmac_vs2_rready;
input vmac_vs2_rvalid;
input [DLEN - 1:0] vmac_vs3_rdata;
input vmac_vs3_rlast;
output vmac_vs3_rready;
input vmac_vs3_rvalid;
input vmac2_cmt_kill;
input [(XLEN - 1):0] vmac2_cmt_op1;
input vmac2_cmt_valid;
input [(58 - 1):0] vmac2_dispatch_ctrl;
input [(VRF_LW - 1):0] vmac2_dispatch_vd_len;
input [2:0] vmac2_dispatch_frm;
input [1:0] vmac2_dispatch_vxrm;
input [(XLEN - 1):0] vmac2_dispatch_op1;
input vmac2_dispatch_op1_hazard;
output vmac2_dispatch_ready;
input [(VLEN - 1):0] vmac2_dispatch_v0t;
input vmac2_dispatch_valid;
output [DLEN - 1:0] vmac2_vd_wdata;
output [DLEN / 8 - 1:0] vmac2_vd_wmask;
input vmac2_vd_wready;
output vmac2_vd_wvalid;
input [DLEN - 1:0] vmac2_vs1_rdata;
output vmac2_vs1_rready;
input vmac2_vs1_rvalid;
input vmac2_vs1_rlast;
input [DLEN - 1:0] vmac2_vs2_rdata;
output vmac2_vs2_rready;
input vmac2_vs2_rvalid;
input vmac2_vs2_rlast;
input [DLEN - 1:0] vmac2_vs3_rdata;
output vmac2_vs3_rready;
input vmac2_vs3_rvalid;
input vmac2_vs3_rlast;
input vpu_valu_clk;
input vpu_vfmis_clk;
input vpu_vmac_clk;
input vpu_reset_n;





// 9cdedabb rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [(58 - 1):0] s0;
wire [(58 - 1):0] s1;
wire [VRF_LW - 1:0] s2;
wire [VRF_LW - 1:0] s3;
wire s4;
wire s5;
wire s6;
wire s7;
wire s8;
wire s9;
wire s10;
wire [XLEN - 1:0] s11;
wire [XLEN - 1:0] s12;
wire s13;
wire s14;
wire s15;
wire s16;
wire s17;
wire s18;
wire s19;
wire s20;
wire s21;
wire s22;
wire s23;
wire s24;
wire s25;
wire s26;
wire s27;
wire s28;
wire s29;
wire s30;
wire s31;
wire s32;
wire s33;
wire s34;
wire s35;
wire [(71 - 1):0] s36;
wire [(71 - 1):0] s37;
wire [VRF_LW - 1:0] s38;
wire [VRF_LW - 1:0] s39;
wire s40;
wire s41;
wire s42;
wire s43;
wire s44;
wire s45;
wire s46;
wire [XLEN - 1:0] s47;
wire [XLEN - 1:0] s48;
wire s49;
wire s50;
wire s51;
wire s52;
wire s53;
wire s54;
wire s55;
wire s56;
wire s57;
wire s58;
wire s59;
wire s60;
wire s61;
wire s62;
wire s63;
wire s64;
wire s65;
wire s66;
wire s67;
wire s68;
wire s69;
wire s70;
wire s71;
wire [(58 - 1):0] s72;
wire [(58 - 1):0] s73;
wire [VRF_LW - 1:0] s74;
wire [VRF_LW - 1:0] s75;
wire s76;
wire s77;
wire s78;
wire s79;
wire s80;
wire s81;
wire s82;
wire [XLEN - 1:0] s83;
wire [XLEN - 1:0] s84;
wire s85;
wire s86;
wire s87;
wire s88;
wire s89;
wire s90;
wire s91;
wire s92;
wire s93;
wire s94;
wire s95;
wire s96;
wire s97;
wire s98;
wire s99;
wire s100;
wire s101;
wire s102;
wire s103;
wire s104;
wire s105;
wire s106;
wire s107;
wire [DLEN / 8 - 1:0] valu_lane_o_mask_result;
wire [DLEN / 8 - 1:0] valu_lane_i_mask_result;
wire [DLEN - 1:0] valu_lane_share_result_data;
wire [DLEN * 2 - 1:0] valu_lane_cross_result_data;
reg [DLEN / 2 - 1:0] valu_vs1_wide_rdata;
reg [DLEN / 2 - 1:0] valu_vs2_wide_rdata;
wire [DLEN - 1:0] valu_lane_vs1_data;
wire [DLEN - 1:0] valu_lane_vs2_data;
wire [DLEN / 2 - 1:0] valu_lane_vs1_wide_bdata;
wire [DLEN / 2 - 1:0] valu_lane_vs2_wide_bdata;
wire [DLEN / 16 - 1:0] vfmis_f1_lane_o_cmp_bit;
wire [DLEN / 16 - 1:0] vfmis_f1_lane_i_cmp_bit;
wire [DLEN - 1:0] vfmis_lane_share_data;
wire [DLEN * 2 - 1:0] vfmis_lane_cross_data;
reg [DLEN / 2 - 1:0] vfmis_vs2_wide_rdata;
wire [DLEN - 1:0] vfmis_lane_vs2_data;
wire [DLEN / 2 - 1:0] vfmis_lane_vs2_x2_bdata;
wire [DLEN / 4 - 1:0] vfmis_lane_vs2_x4_bdata;
wire [DLEN / 8 - 1:0] vfmis_lane_vs2_x8_bdata;
wire [DLEN - 1:0] vmac_vs1_lane_share_data;
wire [DLEN - 1:0] vmac_vs2_lane_share_cross_data;
wire [DLEN - 1:0] vmac_vs2_lane_share_shift_data;
wire [DLEN / 2 - 1:0] vmac_vs2_lane_cross_data;
wire [DLEN / 2 - 1:0] vmac_vs1_lane_cross_data;
wire [3:0] vmac_lane_cross_type[0:LANE_NUM - 1];
wire [DLEN - 1:0] vmac_vs2_lane_shift_data;
wire [DLEN - 1:0] vmac_vs1_lane_shift_data;
wire [3:0] vmac_lane_shift_type[0:LANE_NUM - 1];
wire [DLEN - 1:0] vmac2_vs1_lane_share_data;
wire [DLEN - 1:0] vmac2_vs2_lane_share_cross_data;
wire [DLEN - 1:0] vmac2_vs2_lane_share_shift_data;
wire [DLEN / 2 - 1:0] vmac2_vs2_lane_cross_data;
wire [DLEN / 2 - 1:0] vmac2_vs1_lane_cross_data;
wire [3:0] vmac2_lane_cross_type[0:LANE_NUM - 1];
wire [DLEN - 1:0] vmac2_vs2_lane_shift_data;
wire [DLEN - 1:0] vmac2_vs1_lane_shift_data;
wire [3:0] vmac2_lane_shift_type[0:LANE_NUM - 1];
wire [2:0] vfmis_lane_vs2_sel[0:LANE_NUM - 1];
wire [LANE_NUM - 1:0] s108;
wire [LANE_NUM - 1:0] s109;
wire [LANE_NUM - 1:0] s110;
wire [LANE_NUM - 1:0] s111;
wire [LANE_NUM - 1:0] s112;
wire [LANE_NUM - 1:0] s113;
wire [LANE_NUM - 1:0] s114;
wire [LANE_NUM - 1:0] s115;
wire [LANE_NUM - 1:0] s116;
wire [LANE_NUM - 1:0] s117;
wire [LANE_NUM - 1:0] s118;
wire [LANE_NUM - 1:0] s119;
wire [LANE_NUM - 1:0] s120;
wire [LANE_NUM - 1:0] s121;
wire [LANE_NUM - 1:0] s122;
wire [LANE_NUM - 1:0] s123;
wire [LANE_NUM - 1:0] s124;
wire [LANE_NUM - 1:0] s125;
wire [LANE_NUM - 1:0] s126;
wire [LANE_NUM - 1:0] s127;
wire [LANE_NUM - 1:0] s128;
wire [LANE_NUM - 1:0] s129;
wire [LANE_NUM - 1:0] s130;
wire [LANE_NUM - 1:0] s131;
wire s132;
wire s133;
wire s134;
assign valu_standby_ready = s130[0];
assign vmac_standby_ready = s129[0] & s128[0];
assign vfmis_standby_ready = s131[0];
assign s132 = 1'b0;
assign s133 = 1'b0;
assign s134 = 1'b0;
assign valu_dispatch_ready = s108[0] & ~s132;
assign vfmis_dispatch_ready = s109[0] & ~s134;
assign vmac_dispatch_ready = s110[0] & ~s133;
assign valu_vs1_rready = s111[0] & ~s16;
assign valu_vs2_rready = s112[0] & ~s22;
assign valu_vs3_rready = s113[0] & ~s28;
assign vfmis_vs1_rready = s114[0] & ~s52;
assign vfmis_vs2_rready = s115[0] & ~s58;
assign vfmis_vs3_rready = s116[0] & ~s64;
assign vmac_vs1_rready = s117[0] & ~s88;
assign vmac_vs2_rready = s118[0] & ~s94;
assign vmac_vs3_rready = s119[0] & ~s100;
assign valu_vd_wvalid = s120[0] & ~s13;
assign vfmis_vd_wvalid = s122[0] & ~s49;
assign vmac_vd_wvalid = s121[0] & ~s85;
assign vmac2_dispatch_ready = s123[0];
assign vmac2_vs1_rready = s124[0];
assign vmac2_vs2_rready = s125[0];
assign vmac2_vs3_rready = s126[0];
assign vmac2_vd_wvalid = s127[0];
wire [31:0] lane_id[0:LANE_NUM - 1];
assign lane_id[0] = 32'b1;
wire [127:0] valu_dispatch_v0t_sew8[0:LANE_NUM - 1];
wire [127:0] valu_dispatch_v0t_sew16[0:LANE_NUM - 1];
wire [63:0] valu_dispatch_v0t_sew32[0:LANE_NUM - 1];
wire [31:0] valu_dispatch_v0t_sew64[0:LANE_NUM - 1];
wire [LANE_NUM - 1:0] s135;
wire [5:0] vmac_flag_set;
wire [LANE_NUM - 1:0] s136;
wire [LANE_NUM - 1:0] s137;
wire [LANE_NUM - 1:0] s138;
wire [LANE_NUM - 1:0] s139;
wire [LANE_NUM - 1:0] s140;
wire [LANE_NUM - 1:0] s141;
wire [5:0] vmac2_flag_set;
wire [LANE_NUM - 1:0] s142;
wire [LANE_NUM - 1:0] s143;
wire [LANE_NUM - 1:0] s144;
wire [LANE_NUM - 1:0] s145;
wire [LANE_NUM - 1:0] s146;
wire [LANE_NUM - 1:0] s147;
wire [4:0] vfmis_flag_set;
wire [LANE_NUM - 1:0] s148;
wire [LANE_NUM - 1:0] s149;
wire [LANE_NUM - 1:0] s150;
wire [LANE_NUM - 1:0] s151;
wire [LANE_NUM - 1:0] s152;
wire [DLEN - 1:0] valu_dispatch_v0t_e_mask0;
wire [DLEN - 1:0] valu_dispatch_v0t_e_mask1;
wire [127:0] vfmis_dispatch_v0t_sew8[0:LANE_NUM - 1];
wire [63:0] vfmis_dispatch_v0t_sew16[0:LANE_NUM - 1];
wire [31:0] vfmis_dispatch_v0t_sew32[0:LANE_NUM - 1];
wire [15:0] vfmis_dispatch_v0t_sew64[0:LANE_NUM - 1];
wire [DLEN - 1:0] vfmis_dispatch_v0t_e_mask;
assign valu_vxsat_set = |s135;
assign vmac_flag_set[0] = |s136;
assign vmac_flag_set[1] = |s137;
assign vmac_flag_set[2] = |s138;
assign vmac_flag_set[3] = |s139;
assign vmac_flag_set[4] = |s140;
assign vmac_flag_set[5] = |s141;
generate
    if (VMAC2_TYPE != 0) begin:gen_vmac2_flag_set
        assign vmac2_flag_set[0] = |s142;
        assign vmac2_flag_set[1] = |s143;
        assign vmac2_flag_set[2] = |s144;
        assign vmac2_flag_set[3] = |s145;
        assign vmac2_flag_set[4] = |s146;
        assign vmac2_flag_set[5] = |s147;
    end
    else begin:gen_vmac2_flag_set_stub
        assign vmac2_flag_set = 6'd0;
        wire nds_unused_vmac2_lane_flag_set = (|s142) | (|s143) | (|s144) | (|s145) | (|s146) | (|s147);
    end
endgenerate
assign vfmis_flag_set[0] = |s148;
assign vfmis_flag_set[1] = |s149;
assign vfmis_flag_set[2] = |s150;
assign vfmis_flag_set[3] = |s151;
assign vfmis_flag_set[4] = |s152;
assign vmac_fflags_set = vmac_flag_set[4:0];
assign vmac_vxsat_set = vmac_flag_set[5];
assign vmac2_fflags_set = vmac2_flag_set[4:0];
assign vmac2_vxsat_set = vmac2_flag_set[5];
assign vfmis_fflags_set = vfmis_flag_set[4:0];
assign valu_dispatch_v0t_e_mask0 = valu_dispatch_v0t[DLEN - 1:0];
assign vfmis_dispatch_v0t_e_mask = vfmis_dispatch_v0t[DLEN - 1:0];
generate
    if (VLEN == DLEN) begin:gen_1_1_e_mask
        assign valu_dispatch_v0t_e_mask1 = {DLEN{1'b0}};
    end
    else begin:gen_2_1_e_mask
        assign valu_dispatch_v0t_e_mask1 = valu_dispatch_v0t[VLEN - 1:DLEN];
    end
endgenerate
kv_vpu_lane_xl #(
    .DLEN(DLEN)
) u_kv_vpu_lane_xl (
    .valu_lane_o_mask_result(valu_lane_o_mask_result),
    .valu_lane_i_mask_result(valu_lane_i_mask_result),
    .valu_lane_share_result_data(valu_lane_share_result_data),
    .valu_lane_cross_result_data(valu_lane_cross_result_data),
    .valu_lane_vs1_wide_bdata(valu_lane_vs1_wide_bdata),
    .valu_lane_vs2_wide_bdata(valu_lane_vs2_wide_bdata),
    .valu_lane_vs1_data(valu_lane_vs1_data),
    .valu_lane_vs2_data(valu_lane_vs2_data),
    .vfmis_f1_lane_o_cmp_bit(vfmis_f1_lane_o_cmp_bit),
    .vfmis_f1_lane_i_cmp_bit(vfmis_f1_lane_i_cmp_bit),
    .vfmis_lane_vs2_sel(vfmis_lane_vs2_sel[0]),
    .vfmis_lane_vs2_x2_bdata(vfmis_lane_vs2_x2_bdata),
    .vfmis_lane_vs2_x4_bdata(vfmis_lane_vs2_x4_bdata),
    .vfmis_lane_vs2_x8_bdata(vfmis_lane_vs2_x8_bdata),
    .vfmis_lane_vs2_data(vfmis_lane_vs2_data),
    .vfmis_lane_share_data(vfmis_lane_share_data),
    .vfmis_lane_cross_data(vfmis_lane_cross_data),
    .vmac2_vs1_lane_share_data(vmac2_vs1_lane_share_data),
    .vmac2_vs2_lane_share_cross_data(vmac2_vs2_lane_share_cross_data),
    .vmac2_vs2_lane_share_shift_data(vmac2_vs2_lane_share_shift_data),
    .vmac2_vs1_lane_shift_data(vmac2_vs1_lane_shift_data),
    .vmac2_vs2_lane_shift_data(vmac2_vs2_lane_shift_data),
    .vmac2_lane_shift_type(vmac2_lane_shift_type[0]),
    .vmac2_vs1_lane_cross_data(vmac2_vs1_lane_cross_data),
    .vmac2_vs2_lane_cross_data(vmac2_vs2_lane_cross_data),
    .vmac2_lane_cross_type(vmac2_lane_cross_type[0]),
    .vmac_vs1_lane_share_data(vmac_vs1_lane_share_data),
    .vmac_vs2_lane_share_cross_data(vmac_vs2_lane_share_cross_data),
    .vmac_vs2_lane_share_shift_data(vmac_vs2_lane_share_shift_data),
    .vmac_vs1_lane_shift_data(vmac_vs1_lane_shift_data),
    .vmac_vs2_lane_shift_data(vmac_vs2_lane_shift_data),
    .vmac_lane_shift_type(vmac_lane_shift_type[0]),
    .vmac_vs1_lane_cross_data(vmac_vs1_lane_cross_data),
    .vmac_vs2_lane_cross_data(vmac_vs2_lane_cross_data),
    .vmac_lane_cross_type(vmac_lane_cross_type[0])
);
generate
    genvar k;
    for (k = 1; k < DLEN / 64; k = k + 1) begin:gen_lane_id
        assign lane_id[k] = {lane_id[k - 1][30:0],1'b0};
    end
endgenerate
generate
    genvar j;
    for (j = 0; j < LANE_NUM; j = j + 1) begin:gen_vpu_lanes_v0t
        assign valu_dispatch_v0t_sew8[j][0 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 0) +:8]};
        assign valu_dispatch_v0t_sew8[j][8 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 1) +:8]};
        assign valu_dispatch_v0t_sew8[j][16 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 2) +:8]};
        assign valu_dispatch_v0t_sew8[j][24 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 3) +:8]};
        assign valu_dispatch_v0t_sew8[j][32 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 4) +:8]};
        assign valu_dispatch_v0t_sew8[j][40 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 5) +:8]};
        assign valu_dispatch_v0t_sew8[j][48 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 6) +:8]};
        assign valu_dispatch_v0t_sew8[j][56 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 7) +:8]};
        if (VLEN > DLEN) begin:gen_sew8_v0t_vlen_bt_dlen_alu
            assign valu_dispatch_v0t_sew8[j][64 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 8) +:8]};
            assign valu_dispatch_v0t_sew8[j][72 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 9) +:8]};
            assign valu_dispatch_v0t_sew8[j][80 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 10) +:8]};
            assign valu_dispatch_v0t_sew8[j][88 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 11) +:8]};
            assign valu_dispatch_v0t_sew8[j][96 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 12) +:8]};
            assign valu_dispatch_v0t_sew8[j][104 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 13) +:8]};
            assign valu_dispatch_v0t_sew8[j][112 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 14) +:8]};
            assign valu_dispatch_v0t_sew8[j][120 +:8] = {valu_dispatch_v0t[(j * 8 + (DLEN / 8) * 15) +:8]};
        end
        else begin:gen_sew8_v0t_vlen_eq_dlen_alu
            assign valu_dispatch_v0t_sew8[j][64 +:8] = 8'b0;
            assign valu_dispatch_v0t_sew8[j][72 +:8] = 8'b0;
            assign valu_dispatch_v0t_sew8[j][80 +:8] = 8'b0;
            assign valu_dispatch_v0t_sew8[j][88 +:8] = 8'b0;
            assign valu_dispatch_v0t_sew8[j][96 +:8] = 8'b0;
            assign valu_dispatch_v0t_sew8[j][104 +:8] = 8'b0;
            assign valu_dispatch_v0t_sew8[j][112 +:8] = 8'b0;
            assign valu_dispatch_v0t_sew8[j][120 +:8] = 8'b0;
        end
        assign valu_dispatch_v0t_sew16[j][0 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 0) +:4]};
        assign valu_dispatch_v0t_sew16[j][4 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 1) +:4]};
        assign valu_dispatch_v0t_sew16[j][8 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 2) +:4]};
        assign valu_dispatch_v0t_sew16[j][12 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 3) +:4]};
        assign valu_dispatch_v0t_sew16[j][16 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 4) +:4]};
        assign valu_dispatch_v0t_sew16[j][20 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 5) +:4]};
        assign valu_dispatch_v0t_sew16[j][24 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 6) +:4]};
        assign valu_dispatch_v0t_sew16[j][28 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 7) +:4]};
        assign valu_dispatch_v0t_sew16[j][32 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 8) +:4]};
        assign valu_dispatch_v0t_sew16[j][36 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 9) +:4]};
        assign valu_dispatch_v0t_sew16[j][40 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 10) +:4]};
        assign valu_dispatch_v0t_sew16[j][44 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 11) +:4]};
        assign valu_dispatch_v0t_sew16[j][48 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 12) +:4]};
        assign valu_dispatch_v0t_sew16[j][52 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 13) +:4]};
        assign valu_dispatch_v0t_sew16[j][56 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 14) +:4]};
        assign valu_dispatch_v0t_sew16[j][60 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 15) +:4]};
        if (VLEN > DLEN) begin:gen_sew16_v0t_vlen_bt_dlen_alu
            assign valu_dispatch_v0t_sew16[j][64 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 16) +:4]};
            assign valu_dispatch_v0t_sew16[j][68 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 17) +:4]};
            assign valu_dispatch_v0t_sew16[j][72 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 18) +:4]};
            assign valu_dispatch_v0t_sew16[j][76 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 19) +:4]};
            assign valu_dispatch_v0t_sew16[j][80 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 20) +:4]};
            assign valu_dispatch_v0t_sew16[j][84 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 21) +:4]};
            assign valu_dispatch_v0t_sew16[j][88 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 22) +:4]};
            assign valu_dispatch_v0t_sew16[j][92 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 23) +:4]};
            assign valu_dispatch_v0t_sew16[j][96 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 24) +:4]};
            assign valu_dispatch_v0t_sew16[j][100 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 25) +:4]};
            assign valu_dispatch_v0t_sew16[j][104 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 26) +:4]};
            assign valu_dispatch_v0t_sew16[j][108 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 27) +:4]};
            assign valu_dispatch_v0t_sew16[j][112 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 28) +:4]};
            assign valu_dispatch_v0t_sew16[j][116 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 29) +:4]};
            assign valu_dispatch_v0t_sew16[j][120 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 30) +:4]};
            assign valu_dispatch_v0t_sew16[j][124 +:4] = {valu_dispatch_v0t[(j * 4 + (DLEN / 16) * 31) +:4]};
        end
        else begin:gen_sew16_v0t_vlen_eq_dlen_alu
            assign valu_dispatch_v0t_sew16[j][64 +:4] = 4'b0;
            assign valu_dispatch_v0t_sew16[j][68 +:4] = 4'b0;
            assign valu_dispatch_v0t_sew16[j][72 +:4] = 4'b0;
            assign valu_dispatch_v0t_sew16[j][76 +:4] = 4'b0;
            assign valu_dispatch_v0t_sew16[j][80 +:4] = 4'b0;
            assign valu_dispatch_v0t_sew16[j][84 +:4] = 4'b0;
            assign valu_dispatch_v0t_sew16[j][88 +:4] = 4'b0;
            assign valu_dispatch_v0t_sew16[j][92 +:4] = 4'b0;
            assign valu_dispatch_v0t_sew16[j][96 +:4] = 4'b0;
            assign valu_dispatch_v0t_sew16[j][100 +:4] = 4'b0;
            assign valu_dispatch_v0t_sew16[j][104 +:4] = 4'b0;
            assign valu_dispatch_v0t_sew16[j][108 +:4] = 4'b0;
            assign valu_dispatch_v0t_sew16[j][112 +:4] = 4'b0;
            assign valu_dispatch_v0t_sew16[j][116 +:4] = 4'b0;
            assign valu_dispatch_v0t_sew16[j][120 +:4] = 4'b0;
            assign valu_dispatch_v0t_sew16[j][124 +:4] = 4'b0;
        end
        assign valu_dispatch_v0t_sew32[j][0 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 0) +:2]};
        assign valu_dispatch_v0t_sew32[j][2 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 1) +:2]};
        assign valu_dispatch_v0t_sew32[j][4 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 2) +:2]};
        assign valu_dispatch_v0t_sew32[j][6 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 3) +:2]};
        assign valu_dispatch_v0t_sew32[j][8 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 4) +:2]};
        assign valu_dispatch_v0t_sew32[j][10 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 5) +:2]};
        assign valu_dispatch_v0t_sew32[j][12 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 6) +:2]};
        assign valu_dispatch_v0t_sew32[j][14 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 7) +:2]};
        assign valu_dispatch_v0t_sew32[j][16 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 8) +:2]};
        assign valu_dispatch_v0t_sew32[j][18 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 9) +:2]};
        assign valu_dispatch_v0t_sew32[j][20 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 10) +:2]};
        assign valu_dispatch_v0t_sew32[j][22 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 11) +:2]};
        assign valu_dispatch_v0t_sew32[j][24 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 12) +:2]};
        assign valu_dispatch_v0t_sew32[j][26 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 13) +:2]};
        assign valu_dispatch_v0t_sew32[j][28 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 14) +:2]};
        assign valu_dispatch_v0t_sew32[j][30 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 15) +:2]};
        if (VLEN > DLEN) begin:gen_sew32_v0t_vlen_bt_dlen_alu
            assign valu_dispatch_v0t_sew32[j][32 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 16) +:2]};
            assign valu_dispatch_v0t_sew32[j][34 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 17) +:2]};
            assign valu_dispatch_v0t_sew32[j][36 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 18) +:2]};
            assign valu_dispatch_v0t_sew32[j][38 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 19) +:2]};
            assign valu_dispatch_v0t_sew32[j][40 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 20) +:2]};
            assign valu_dispatch_v0t_sew32[j][42 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 21) +:2]};
            assign valu_dispatch_v0t_sew32[j][44 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 22) +:2]};
            assign valu_dispatch_v0t_sew32[j][46 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 23) +:2]};
            assign valu_dispatch_v0t_sew32[j][48 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 24) +:2]};
            assign valu_dispatch_v0t_sew32[j][50 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 25) +:2]};
            assign valu_dispatch_v0t_sew32[j][52 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 26) +:2]};
            assign valu_dispatch_v0t_sew32[j][54 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 27) +:2]};
            assign valu_dispatch_v0t_sew32[j][56 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 28) +:2]};
            assign valu_dispatch_v0t_sew32[j][58 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 29) +:2]};
            assign valu_dispatch_v0t_sew32[j][60 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 30) +:2]};
            assign valu_dispatch_v0t_sew32[j][62 +:2] = {valu_dispatch_v0t[(j * 2 + (DLEN / 32) * 31) +:2]};
        end
        else begin:gen_sew32_v0t_vlen_eq_dlen_alu
            assign valu_dispatch_v0t_sew32[j][32 +:2] = 2'b0;
            assign valu_dispatch_v0t_sew32[j][34 +:2] = 2'b0;
            assign valu_dispatch_v0t_sew32[j][36 +:2] = 2'b0;
            assign valu_dispatch_v0t_sew32[j][38 +:2] = 2'b0;
            assign valu_dispatch_v0t_sew32[j][40 +:2] = 2'b0;
            assign valu_dispatch_v0t_sew32[j][42 +:2] = 2'b0;
            assign valu_dispatch_v0t_sew32[j][44 +:2] = 2'b0;
            assign valu_dispatch_v0t_sew32[j][46 +:2] = 2'b0;
            assign valu_dispatch_v0t_sew32[j][48 +:2] = 2'b0;
            assign valu_dispatch_v0t_sew32[j][50 +:2] = 2'b0;
            assign valu_dispatch_v0t_sew32[j][52 +:2] = 2'b0;
            assign valu_dispatch_v0t_sew32[j][54 +:2] = 2'b0;
            assign valu_dispatch_v0t_sew32[j][56 +:2] = 2'b0;
            assign valu_dispatch_v0t_sew32[j][58 +:2] = 2'b0;
            assign valu_dispatch_v0t_sew32[j][60 +:2] = 2'b0;
            assign valu_dispatch_v0t_sew32[j][62 +:2] = 2'b0;
        end
        assign valu_dispatch_v0t_sew64[j][0 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 0) +:1]};
        assign valu_dispatch_v0t_sew64[j][1 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 1) +:1]};
        assign valu_dispatch_v0t_sew64[j][2 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 2) +:1]};
        assign valu_dispatch_v0t_sew64[j][3 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 3) +:1]};
        assign valu_dispatch_v0t_sew64[j][4 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 4) +:1]};
        assign valu_dispatch_v0t_sew64[j][5 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 5) +:1]};
        assign valu_dispatch_v0t_sew64[j][6 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 6) +:1]};
        assign valu_dispatch_v0t_sew64[j][7 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 7) +:1]};
        assign valu_dispatch_v0t_sew64[j][8 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 8) +:1]};
        assign valu_dispatch_v0t_sew64[j][9 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 9) +:1]};
        assign valu_dispatch_v0t_sew64[j][10 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 10) +:1]};
        assign valu_dispatch_v0t_sew64[j][11 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 11) +:1]};
        assign valu_dispatch_v0t_sew64[j][12 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 12) +:1]};
        assign valu_dispatch_v0t_sew64[j][13 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 13) +:1]};
        assign valu_dispatch_v0t_sew64[j][14 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 14) +:1]};
        assign valu_dispatch_v0t_sew64[j][15 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 15) +:1]};
        if (VLEN > DLEN) begin:gen_sew64_v0t_vlen_bt_dlen_alu
            assign valu_dispatch_v0t_sew64[j][16 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 16) +:1]};
            assign valu_dispatch_v0t_sew64[j][17 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 17) +:1]};
            assign valu_dispatch_v0t_sew64[j][18 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 18) +:1]};
            assign valu_dispatch_v0t_sew64[j][19 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 19) +:1]};
            assign valu_dispatch_v0t_sew64[j][20 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 20) +:1]};
            assign valu_dispatch_v0t_sew64[j][21 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 21) +:1]};
            assign valu_dispatch_v0t_sew64[j][22 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 22) +:1]};
            assign valu_dispatch_v0t_sew64[j][23 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 23) +:1]};
            assign valu_dispatch_v0t_sew64[j][24 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 24) +:1]};
            assign valu_dispatch_v0t_sew64[j][25 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 25) +:1]};
            assign valu_dispatch_v0t_sew64[j][26 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 26) +:1]};
            assign valu_dispatch_v0t_sew64[j][27 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 27) +:1]};
            assign valu_dispatch_v0t_sew64[j][28 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 28) +:1]};
            assign valu_dispatch_v0t_sew64[j][29 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 29) +:1]};
            assign valu_dispatch_v0t_sew64[j][30 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 30) +:1]};
            assign valu_dispatch_v0t_sew64[j][31 +:1] = {valu_dispatch_v0t[(j * 1 + (DLEN / 64) * 31) +:1]};
        end
        else begin:gen_sew64_v0t_vlen_eq_dlen_alu
            assign valu_dispatch_v0t_sew64[j][16 +:1] = 1'b0;
            assign valu_dispatch_v0t_sew64[j][17 +:1] = 1'b0;
            assign valu_dispatch_v0t_sew64[j][18 +:1] = 1'b0;
            assign valu_dispatch_v0t_sew64[j][19 +:1] = 1'b0;
            assign valu_dispatch_v0t_sew64[j][20 +:1] = 1'b0;
            assign valu_dispatch_v0t_sew64[j][21 +:1] = 1'b0;
            assign valu_dispatch_v0t_sew64[j][22 +:1] = 1'b0;
            assign valu_dispatch_v0t_sew64[j][23 +:1] = 1'b0;
            assign valu_dispatch_v0t_sew64[j][24 +:1] = 1'b0;
            assign valu_dispatch_v0t_sew64[j][25 +:1] = 1'b0;
            assign valu_dispatch_v0t_sew64[j][26 +:1] = 1'b0;
            assign valu_dispatch_v0t_sew64[j][27 +:1] = 1'b0;
            assign valu_dispatch_v0t_sew64[j][28 +:1] = 1'b0;
            assign valu_dispatch_v0t_sew64[j][29 +:1] = 1'b0;
            assign valu_dispatch_v0t_sew64[j][30 +:1] = 1'b0;
            assign valu_dispatch_v0t_sew64[j][31 +:1] = 1'b0;
        end
        assign vfmis_dispatch_v0t_sew8[j][0 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 0) +:8]};
        assign vfmis_dispatch_v0t_sew8[j][8 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 1) +:8]};
        assign vfmis_dispatch_v0t_sew8[j][16 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 2) +:8]};
        assign vfmis_dispatch_v0t_sew8[j][24 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 3) +:8]};
        assign vfmis_dispatch_v0t_sew8[j][32 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 4) +:8]};
        assign vfmis_dispatch_v0t_sew8[j][40 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 5) +:8]};
        assign vfmis_dispatch_v0t_sew8[j][48 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 6) +:8]};
        assign vfmis_dispatch_v0t_sew8[j][56 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 7) +:8]};
        if (VLEN > DLEN) begin:gen_sew8_v0t_vlen_bt_dlen_fmis
            assign vfmis_dispatch_v0t_sew8[j][64 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 8) +:8]};
            assign vfmis_dispatch_v0t_sew8[j][72 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 9) +:8]};
            assign vfmis_dispatch_v0t_sew8[j][80 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 10) +:8]};
            assign vfmis_dispatch_v0t_sew8[j][88 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 11) +:8]};
            assign vfmis_dispatch_v0t_sew8[j][96 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 12) +:8]};
            assign vfmis_dispatch_v0t_sew8[j][104 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 13) +:8]};
            assign vfmis_dispatch_v0t_sew8[j][112 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 14) +:8]};
            assign vfmis_dispatch_v0t_sew8[j][120 +:8] = {vfmis_dispatch_v0t[(j * 8 + (DLEN / 8) * 15) +:8]};
        end
        else begin:gen_sew8_v0t_vlen_eq_dlen_fmis
            assign vfmis_dispatch_v0t_sew8[j][64 +:8] = 8'b0;
            assign vfmis_dispatch_v0t_sew8[j][72 +:8] = 8'b0;
            assign vfmis_dispatch_v0t_sew8[j][80 +:8] = 8'b0;
            assign vfmis_dispatch_v0t_sew8[j][88 +:8] = 8'b0;
            assign vfmis_dispatch_v0t_sew8[j][96 +:8] = 8'b0;
            assign vfmis_dispatch_v0t_sew8[j][104 +:8] = 8'b0;
            assign vfmis_dispatch_v0t_sew8[j][112 +:8] = 8'b0;
            assign vfmis_dispatch_v0t_sew8[j][120 +:8] = 8'b0;
        end
        assign vfmis_dispatch_v0t_sew16[j][0 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 0) +:4]};
        assign vfmis_dispatch_v0t_sew16[j][4 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 1) +:4]};
        assign vfmis_dispatch_v0t_sew16[j][8 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 2) +:4]};
        assign vfmis_dispatch_v0t_sew16[j][12 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 3) +:4]};
        assign vfmis_dispatch_v0t_sew16[j][16 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 4) +:4]};
        assign vfmis_dispatch_v0t_sew16[j][20 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 5) +:4]};
        assign vfmis_dispatch_v0t_sew16[j][24 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 6) +:4]};
        assign vfmis_dispatch_v0t_sew16[j][28 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 7) +:4]};
        assign vfmis_dispatch_v0t_sew16[j][32 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 8) +:4]};
        assign vfmis_dispatch_v0t_sew16[j][36 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 9) +:4]};
        assign vfmis_dispatch_v0t_sew16[j][40 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 10) +:4]};
        assign vfmis_dispatch_v0t_sew16[j][44 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 11) +:4]};
        assign vfmis_dispatch_v0t_sew16[j][48 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 12) +:4]};
        assign vfmis_dispatch_v0t_sew16[j][52 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 13) +:4]};
        assign vfmis_dispatch_v0t_sew16[j][56 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 14) +:4]};
        assign vfmis_dispatch_v0t_sew16[j][60 +:4] = {vfmis_dispatch_v0t[(j * 4 + (DLEN / 16) * 15) +:4]};
        assign vfmis_dispatch_v0t_sew32[j][0 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 0) +:2]};
        assign vfmis_dispatch_v0t_sew32[j][2 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 1) +:2]};
        assign vfmis_dispatch_v0t_sew32[j][4 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 2) +:2]};
        assign vfmis_dispatch_v0t_sew32[j][6 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 3) +:2]};
        assign vfmis_dispatch_v0t_sew32[j][8 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 4) +:2]};
        assign vfmis_dispatch_v0t_sew32[j][10 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 5) +:2]};
        assign vfmis_dispatch_v0t_sew32[j][12 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 6) +:2]};
        assign vfmis_dispatch_v0t_sew32[j][14 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 7) +:2]};
        assign vfmis_dispatch_v0t_sew32[j][16 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 8) +:2]};
        assign vfmis_dispatch_v0t_sew32[j][18 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 9) +:2]};
        assign vfmis_dispatch_v0t_sew32[j][20 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 10) +:2]};
        assign vfmis_dispatch_v0t_sew32[j][22 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 11) +:2]};
        assign vfmis_dispatch_v0t_sew32[j][24 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 12) +:2]};
        assign vfmis_dispatch_v0t_sew32[j][26 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 13) +:2]};
        assign vfmis_dispatch_v0t_sew32[j][28 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 14) +:2]};
        assign vfmis_dispatch_v0t_sew32[j][30 +:2] = {vfmis_dispatch_v0t[(j * 2 + (DLEN / 32) * 15) +:2]};
        assign vfmis_dispatch_v0t_sew64[j][0 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 0) +:1]};
        assign vfmis_dispatch_v0t_sew64[j][1 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 1) +:1]};
        assign vfmis_dispatch_v0t_sew64[j][2 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 2) +:1]};
        assign vfmis_dispatch_v0t_sew64[j][3 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 3) +:1]};
        assign vfmis_dispatch_v0t_sew64[j][4 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 4) +:1]};
        assign vfmis_dispatch_v0t_sew64[j][5 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 5) +:1]};
        assign vfmis_dispatch_v0t_sew64[j][6 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 6) +:1]};
        assign vfmis_dispatch_v0t_sew64[j][7 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 7) +:1]};
        assign vfmis_dispatch_v0t_sew64[j][8 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 8) +:1]};
        assign vfmis_dispatch_v0t_sew64[j][9 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 9) +:1]};
        assign vfmis_dispatch_v0t_sew64[j][10 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 10) +:1]};
        assign vfmis_dispatch_v0t_sew64[j][11 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 11) +:1]};
        assign vfmis_dispatch_v0t_sew64[j][12 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 12) +:1]};
        assign vfmis_dispatch_v0t_sew64[j][13 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 13) +:1]};
        assign vfmis_dispatch_v0t_sew64[j][14 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 14) +:1]};
        assign vfmis_dispatch_v0t_sew64[j][15 +:1] = {vfmis_dispatch_v0t[(j * 1 + (DLEN / 64) * 15) +:1]};
    end
endgenerate
assign s4 = 1'b0;
assign s0 = {58{1'b0}};
assign s2 = {VRF_LW{1'b0}};
assign s6 = 1'b0;
assign s9 = 1'b0;
assign s8 = 1'b0;
assign s35 = 1'b0;
assign s11 = {XLEN{1'b0}};
assign s13 = 1'b0;
assign s14 = 1'b0;
assign s16 = 1'b0;
assign s22 = 1'b0;
assign s28 = 1'b0;
assign s19 = 1'b0;
assign s25 = 1'b0;
assign s31 = 1'b0;
assign s17 = 1'b0;
assign s23 = 1'b0;
assign s29 = 1'b0;
assign s20 = 1'b0;
assign s26 = 1'b0;
assign s32 = 1'b0;
assign s40 = 1'b0;
assign s36 = {71{1'b0}};
assign s38 = {VRF_LW{1'b0}};
assign s42 = 1'b0;
assign s45 = 1'b0;
assign s44 = 1'b0;
assign s71 = 1'b0;
assign s47 = {XLEN{1'b0}};
assign s49 = 1'b0;
assign s50 = 1'b0;
assign s52 = 1'b0;
assign s58 = 1'b0;
assign s64 = 1'b0;
assign s55 = 1'b0;
assign s61 = 1'b0;
assign s67 = 1'b0;
assign s53 = 1'b0;
assign s59 = 1'b0;
assign s65 = 1'b0;
assign s56 = 1'b0;
assign s62 = 1'b0;
assign s68 = 1'b0;
assign s76 = 1'b0;
assign s72 = {58{1'b0}};
assign s74 = {VRF_LW{1'b0}};
assign s78 = 1'b0;
assign s81 = 1'b0;
assign s80 = 1'b0;
assign s107 = 1'b0;
assign s83 = {XLEN{1'b0}};
assign s85 = 1'b0;
assign s86 = 1'b0;
assign s88 = 1'b0;
assign s94 = 1'b0;
assign s100 = 1'b0;
assign s91 = 1'b0;
assign s97 = 1'b0;
assign s103 = 1'b0;
assign s89 = 1'b0;
assign s95 = 1'b0;
assign s101 = 1'b0;
assign s92 = 1'b0;
assign s98 = 1'b0;
assign s104 = 1'b0;
assign s5 = (valu_dispatch_valid | s4) & ~s132;
assign s1 = s4 ? s0 : valu_dispatch_ctrl;
assign s3 = s4 ? s2 : valu_dispatch_vd_len;
assign s7 = s4 ? s6 : valu_dispatch_op1_hazard;
assign s10 = (valu_cmt_valid & ~s9) | s8;
assign s34 = s9 ? s35 : valu_cmt_kill;
assign s12 = s9 ? s11 : valu_cmt_op1;
assign s15 = valu_vd_wready & ~s14;
assign s18 = (valu_vs1_rvalid & ~s19) | s17;
assign s24 = (valu_vs2_rvalid & ~s25) | s23;
assign s30 = (valu_vs3_rvalid & ~s31) | s29;
assign s21 = (valu_vs1_rlast & ~s19) | s20;
assign s27 = (valu_vs2_rlast & ~s25) | s26;
assign s33 = (valu_vs3_rlast & ~s31) | s32;
assign s41 = (vfmis_dispatch_valid | s40) & ~s134;
assign s37 = s40 ? s36 : vfmis_dispatch_ctrl;
assign s39 = s40 ? s38 : vfmis_dispatch_vd_len;
assign s43 = s40 ? s42 : vfmis_dispatch_op1_hazard;
assign s46 = (vfmis_cmt_valid & ~s45) | s44;
assign s70 = s45 ? s71 : vfmis_cmt_kill;
assign s48 = s45 ? s47 : vfmis_cmt_op1;
assign s51 = vfmis_vd_wready & ~s50;
assign s54 = (vfmis_vs1_rvalid & ~s55) | s53;
assign s60 = (vfmis_vs2_rvalid & ~s61) | s59;
assign s66 = (vfmis_vs3_rvalid & ~s67) | s65;
assign s57 = (vfmis_vs1_rlast & ~s55) | s56;
assign s63 = (vfmis_vs2_rlast & ~s61) | s62;
assign s69 = (vfmis_vs3_rlast & ~s67) | s68;
assign s77 = (vmac_dispatch_valid | s76) & ~s133;
assign s73 = s76 ? s72 : vmac_dispatch_ctrl;
assign s75 = s76 ? s74 : vmac_dispatch_vd_len;
assign s79 = s76 ? s78 : vmac_dispatch_op1_hazard;
assign s82 = (vmac_cmt_valid & ~s81) | s80;
assign s106 = s81 ? s107 : vmac_cmt_kill;
assign s84 = s81 ? s83 : vmac_cmt_op1;
assign s87 = vmac_vd_wready & ~s86;
assign s90 = (vmac_vs1_rvalid & ~s91) | s89;
assign s96 = (vmac_vs2_rvalid & ~s97) | s95;
assign s102 = (vmac_vs3_rvalid & ~s103) | s101;
assign s93 = (vmac_vs1_rlast & ~s91) | s92;
assign s99 = (vmac_vs2_rlast & ~s97) | s98;
assign s105 = (vmac_vs3_rlast & ~s103) | s104;
generate
    genvar i;
    for (i = 0; i < LANE_NUM; i = i + 1) begin:gen_vpu_lanes
        wire [5:0] s153;
        wire [5:0] s154;
        wire [4:0] s155;
        assign s136[i] = s153[0];
        assign s137[i] = s153[1];
        assign s138[i] = s153[2];
        assign s139[i] = s153[3];
        assign s140[i] = s153[4];
        assign s141[i] = s153[5];
        assign s142[i] = s154[0];
        assign s143[i] = s154[1];
        assign s144[i] = s154[2];
        assign s145[i] = s154[3];
        assign s146[i] = s154[4];
        assign s147[i] = s154[5];
        assign s148[i] = s155[0];
        assign s149[i] = s155[1];
        assign s150[i] = s155[2];
        assign s151[i] = s155[3];
        assign s152[i] = s155[4];
        always @* begin
            valu_vs1_wide_rdata[32 * i +:32] = valu_vs1_rdata[32 * i +:32];
        end

        always @* begin
            valu_vs2_wide_rdata[32 * i +:32] = valu_vs2_rdata[32 * i +:32];
        end

        always @* begin
            vfmis_vs2_wide_rdata[32 * i +:32] = vfmis_vs2_rdata[32 * i +:32];
        end

        kv_vpu_lane #(
            .XLEN(XLEN),
            .FLEN(FLEN),
            .VLEN(VLEN),
            .DLEN(DLEN),
            .ELEN(ELEN),
            .FELEN(FELEN),
            .VMAC2_TYPE(VMAC2_TYPE),
            .VRF_LW(VRF_LW)
        ) u_kv_vpu_lane (
            .vpu_valu_clk(vpu_valu_clk),
            .vpu_vfmis_clk(vpu_vfmis_clk),
            .vpu_vmac_clk(vpu_vmac_clk),
            .vpu_reset_n(vpu_reset_n),
            .lane_id(lane_id[i]),
            .valu_standby_ready(s130[i]),
            .vmac_standby_ready(s129[i]),
            .vfmis_standby_ready(s131[i]),
            .vmac2_standby_ready(s128[i]),
            .valu_cmt_kill(s34),
            .valu_cmt_op1(s12),
            .valu_cmt_valid(s10),
            .valu_dispatch_ctrl(s1),
            .valu_dispatch_vd_len(s3),
            .valu_dispatch_vxrm(valu_dispatch_vxrm),
            .valu_dispatch_op1(valu_dispatch_op1),
            .valu_dispatch_op1_hazard(s7),
            .valu_dispatch_ready(s108[i]),
            .valu_dispatch_v0t_e_mask0(valu_dispatch_v0t_e_mask0[i * 64 +:64]),
            .valu_dispatch_v0t_e_mask1(valu_dispatch_v0t_e_mask1[i * 64 +:64]),
            .valu_dispatch_v0t_sew8(valu_dispatch_v0t_sew8[i]),
            .valu_dispatch_v0t_sew16(valu_dispatch_v0t_sew16[i]),
            .valu_dispatch_v0t_sew32(valu_dispatch_v0t_sew32[i]),
            .valu_dispatch_v0t_sew64(valu_dispatch_v0t_sew64[i]),
            .valu_dispatch_valid(s5),
            .valu_lane_mask_result(valu_lane_i_mask_result),
            .valu_lane_cross_result_data(valu_lane_cross_result_data[i * 128 +:128]),
            .valu_lane_vs2_data(valu_lane_vs2_data[i * 64 +:64]),
            .valu_lane_vs2_wide_bdata(valu_lane_vs2_wide_bdata[(i * 32) +:32]),
            .valu_lane_vs1_data(valu_lane_vs1_data[i * 64 +:64]),
            .valu_lane_vs1_wide_bdata(valu_lane_vs1_wide_bdata[(i * 32) +:32]),
            .valu_mask_result(valu_lane_o_mask_result[i * 8 +:8]),
            .valu_lane_share_result_data(valu_lane_share_result_data[i * 64 +:64]),
            .valu_vd_wdata(valu_vd_wdata[i * 64 +:64]),
            .valu_vd_wmask(valu_vd_wmask[i * 8 +:8]),
            .valu_vd_wready(s15),
            .valu_vd_wvalid(s120[i]),
            .valu_vs1_rdata(valu_vs1_rdata[i * 64 +:64]),
            .valu_vs1_rlast(s21),
            .valu_vs1_rready(s111[i]),
            .valu_vs1_rvalid(s18),
            .valu_vs1_wide_rdata(valu_vs1_wide_rdata[i * 32 +:32]),
            .valu_vs2_rdata(valu_vs2_rdata[i * 64 +:64]),
            .valu_vs2_rlast(s27),
            .valu_vs2_rready(s112[i]),
            .valu_vs2_rvalid(s24),
            .valu_vs2_wide_rdata(valu_vs2_wide_rdata[i * 32 +:32]),
            .valu_vs3_rdata(valu_vs3_rdata[i * 64 +:64]),
            .valu_vs3_rlast(s33),
            .valu_vs3_rready(s113[i]),
            .valu_vs3_rvalid(s30),
            .vfmis_cmt_kill(s70),
            .vfmis_cmt_op1(s48),
            .vfmis_cmt_valid(s46),
            .vfmis_dispatch_ctrl(s37),
            .vfmis_dispatch_vd_len(s39),
            .vfmis_dispatch_frm(vfmis_dispatch_frm),
            .vfmis_dispatch_op1(vfmis_dispatch_op1),
            .vfmis_dispatch_op1_hazard(s43),
            .vfmis_dispatch_ready(s109[i]),
            .vfmis_dispatch_v0t_e_mask(vfmis_dispatch_v0t_e_mask[i * 64 +:64]),
            .vfmis_dispatch_v0t_sew8(vfmis_dispatch_v0t_sew8[i]),
            .vfmis_dispatch_v0t_sew16(vfmis_dispatch_v0t_sew16[i]),
            .vfmis_dispatch_v0t_sew32(vfmis_dispatch_v0t_sew32[i]),
            .vfmis_dispatch_v0t_sew64(vfmis_dispatch_v0t_sew64[i]),
            .vfmis_dispatch_valid(s41),
            .vfmis_f1_lane_cmp_bit(vfmis_f1_lane_i_cmp_bit),
            .vfmis_lane_cross_data(vfmis_lane_cross_data[i * 128 +:128]),
            .vfmis_lane_vs2_data(vfmis_lane_vs2_data[i * 64 +:64]),
            .vfmis_lane_vs2_sel(vfmis_lane_vs2_sel[i]),
            .vfmis_lane_vs2_x2_bdata(vfmis_lane_vs2_x2_bdata[(i * 32) +:32]),
            .vfmis_lane_vs2_x4_bdata(vfmis_lane_vs2_x4_bdata[(i * 16) +:16]),
            .vfmis_lane_vs2_x8_bdata(vfmis_lane_vs2_x8_bdata[(i * 8) +:8]),
            .vfmis_f1_cmp_bit(vfmis_f1_lane_o_cmp_bit[i * 4 +:4]),
            .vfmis_lane_share_data(vfmis_lane_share_data[i * 64 +:64]),
            .vfmis_vd_wdata(vfmis_vd_wdata[i * 64 +:64]),
            .vfmis_vd_wmask(vfmis_vd_wmask[i * 8 +:8]),
            .vfmis_vd_wready(s51),
            .vfmis_vd_wvalid(s122[i]),
            .vfmis_vs1_rdata(vfmis_vs1_rdata[i * 64 +:64]),
            .vfmis_vs1_rready(s114[i]),
            .vfmis_vs1_rvalid(s54),
            .vfmis_vs1_rlast(s57),
            .vfmis_vs2_rdata(vfmis_vs2_rdata[i * 64 +:64]),
            .vfmis_vs2_rready(s115[i]),
            .vfmis_vs2_rvalid(s60),
            .vfmis_vs2_rlast(s63),
            .vfmis_vs2_wide_rdata(vfmis_vs2_wide_rdata[i * 32 +:32]),
            .vfmis_vs3_rdata(vfmis_vs3_rdata[i * 64 +:64]),
            .vfmis_vs3_rready(s116[i]),
            .vfmis_vs3_rvalid(s66),
            .vfmis_vs3_rlast(s69),
            .valu_vxsat_set(s135[i]),
            .vmac_flag_set(s153),
            .vfmis_flag_set(s155),
            .vmac2_flag_set(s154),
            .vmac2_vs2_lane_share_cross_data(vmac2_vs2_lane_share_cross_data[i * 64 +:64]),
            .vmac2_vs2_lane_share_shift_data(vmac2_vs2_lane_share_shift_data[i * 64 +:64]),
            .vmac2_vs1_lane_share_data(vmac2_vs1_lane_share_data[i * 64 +:64]),
            .vmac2_cmt_kill(vmac2_cmt_kill),
            .vmac2_cmt_op1(vmac2_cmt_op1),
            .vmac2_cmt_valid(vmac2_cmt_valid),
            .vmac2_dispatch_ctrl(vmac2_dispatch_ctrl),
            .vmac2_dispatch_vd_len(vmac2_dispatch_vd_len),
            .vmac2_dispatch_frm(vmac2_dispatch_frm),
            .vmac2_dispatch_vxrm(vmac2_dispatch_vxrm),
            .vmac2_dispatch_op1(vmac2_dispatch_op1),
            .vmac2_dispatch_op1_hazard(vmac2_dispatch_op1_hazard),
            .vmac2_dispatch_ready(s123[i]),
            .vmac2_dispatch_v0t(vmac2_dispatch_v0t),
            .vmac2_dispatch_valid(vmac2_dispatch_valid),
            .vmac2_vs3_rdata(vmac2_vs3_rdata[i * 64 +:64]),
            .vmac2_vs3_rready(s126[i]),
            .vmac2_vs3_rvalid(vmac2_vs3_rvalid),
            .vmac2_vs3_rlast(vmac2_vs3_rlast),
            .vmac2_vd_wdata(vmac2_vd_wdata[i * 64 +:64]),
            .vmac2_vd_wmask(vmac2_vd_wmask[i * 8 +:8]),
            .vmac2_vd_wready(vmac2_vd_wready),
            .vmac2_vd_wvalid(s127[i]),
            .vmac2_vs1_rdata(vmac2_vs1_rdata[i * 64 +:64]),
            .vmac2_vs1_rready(s124[i]),
            .vmac2_vs1_rvalid(vmac2_vs1_rvalid),
            .vmac2_vs1_rlast(vmac2_vs1_rlast),
            .vmac2_vs2_rdata(vmac2_vs2_rdata[i * 64 +:64]),
            .vmac2_vs2_rready(s125[i]),
            .vmac2_vs2_rvalid(vmac2_vs2_rvalid),
            .vmac2_vs2_rlast(vmac2_vs2_rlast),
            .vmac2_vs2_lane_shift_data(vmac2_vs2_lane_shift_data[i * 64 +:64]),
            .vmac2_vs1_lane_shift_data(vmac2_vs1_lane_shift_data[i * 64 +:64]),
            .vmac2_lane_shift_type(vmac2_lane_shift_type[i]),
            .vmac2_vs2_lane_cross_data(vmac2_vs2_lane_cross_data[i * 32 +:32]),
            .vmac2_vs1_lane_cross_data(vmac2_vs1_lane_cross_data[i * 32 +:32]),
            .vmac2_lane_cross_type(vmac2_lane_cross_type[i]),
            .vmac_vs2_lane_share_cross_data(vmac_vs2_lane_share_cross_data[i * 64 +:64]),
            .vmac_vs2_lane_share_shift_data(vmac_vs2_lane_share_shift_data[i * 64 +:64]),
            .vmac_vs1_lane_share_data(vmac_vs1_lane_share_data[i * 64 +:64]),
            .vmac_cmt_kill(s106),
            .vmac_cmt_op1(s84),
            .vmac_cmt_valid(s82),
            .vmac_dispatch_ctrl(s73),
            .vmac_dispatch_vd_len(s75),
            .vmac_dispatch_frm(vmac_dispatch_frm),
            .vmac_dispatch_vxrm(vmac_dispatch_vxrm),
            .vmac_dispatch_op1(vmac_dispatch_op1),
            .vmac_dispatch_op1_hazard(s79),
            .vmac_dispatch_ready(s110[i]),
            .vmac_dispatch_v0t(vmac_dispatch_v0t),
            .vmac_dispatch_valid(s77),
            .vmac_vs3_rdata(vmac_vs3_rdata[i * 64 +:64]),
            .vmac_vs3_rlast(s105),
            .vmac_vs3_rready(s119[i]),
            .vmac_vs3_rvalid(s102),
            .vmac_vd_wdata(vmac_vd_wdata[i * 64 +:64]),
            .vmac_vd_wmask(vmac_vd_wmask[i * 8 +:8]),
            .vmac_vd_wready(s87),
            .vmac_vd_wvalid(s121[i]),
            .vmac_vs1_rdata(vmac_vs1_rdata[i * 64 +:64]),
            .vmac_vs1_rlast(s93),
            .vmac_vs1_rready(s117[i]),
            .vmac_vs1_rvalid(s90),
            .vmac_vs2_rdata(vmac_vs2_rdata[i * 64 +:64]),
            .vmac_vs2_rlast(s99),
            .vmac_vs2_rready(s118[i]),
            .vmac_vs2_rvalid(s96),
            .vmac_vs2_lane_shift_data(vmac_vs2_lane_shift_data[i * 64 +:64]),
            .vmac_vs1_lane_shift_data(vmac_vs1_lane_shift_data[i * 64 +:64]),
            .vmac_lane_shift_type(vmac_lane_shift_type[i]),
            .vmac_vs2_lane_cross_data(vmac_vs2_lane_cross_data[i * 32 +:32]),
            .vmac_vs1_lane_cross_data(vmac_vs1_lane_cross_data[i * 32 +:32]),
            .vmac_lane_cross_type(vmac_lane_cross_type[i])
        );
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

