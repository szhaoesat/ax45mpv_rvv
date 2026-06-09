// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vscb (
    vpu_standby_ready,
    vpu_vlsu_standby_ready,
    vpu_valu_standby_ready,
    vpu_vfmis_standby_ready,
    vpu_vmac_standby_ready,
    vpu_vfdiv_standby_ready,
    vpu_vdiv_standby_ready,
    vpu_vmask_standby_ready,
    vpu_vpermut_standby_ready,
    vpu_vace_standby_ready,
    vpu_vsp_standby_ready,
    valu_standby_ready,
    vfmis_standby_ready,
    vmac_standby_ready,
    vfdiv_standby_ready,
    vmask_standby_ready,
    vsp_standby_ready,
    vpermut_standby_ready,
    vace_standby_ready,
    viq_standby_ready,
    srf_standby_ready,
    vpu_vlsu_pending,
    vscb_busy,
    vscb_v0t_write_pending,
    dis_i0_grant,
    dis_i0_fu,
    dis_i0_vs1_en,
    dis_i0_vs1_addr,
    dis_i0_vs1_len,
    dis_i0_vs2_en,
    dis_i0_vs2_addr,
    dis_i0_vs2_len,
    dis_i0_vs3_en,
    dis_i0_vs3_addr,
    dis_i0_vs3_len,
    dis_i0_vd_en,
    dis_i0_vd_addr,
    dis_i0_vd_len,
    dis_i1_grant,
    dis_i1_fu,
    dis_i1_vs1_en,
    dis_i1_vs1_addr,
    dis_i1_vs1_len,
    dis_i1_vs2_en,
    dis_i1_vs2_addr,
    dis_i1_vs2_len,
    dis_i1_vs3_en,
    dis_i1_vs3_addr,
    dis_i1_vs3_len,
    dis_i1_vd_en,
    dis_i1_vd_addr,
    dis_i1_vd_len,
    cmt_i0_grant,
    cmt_i0_kill,
    cmt_i1_grant,
    cmt_i1_kill,
    vrf_r0_valid,
    vrf_r0_addr,
    vrf_r0_beat,
    vrf_r0_fu,
    vrf_r0_bypass_sel,
    vrf_r0_bypass_en,
    vrf_r0_last,
    vrf_r0_ready,
    vrf_r1_valid,
    vrf_r1_addr,
    vrf_r1_beat,
    vrf_r1_fu,
    vrf_r1_bypass_sel,
    vrf_r1_bypass_en,
    vrf_r1_last,
    vrf_r1_ready,
    vrf_r2_valid,
    vrf_r2_addr,
    vrf_r2_beat,
    vrf_r2_fu,
    vrf_r2_bypass_sel,
    vrf_r2_bypass_en,
    vrf_r2_last,
    vrf_r2_ready,
    vrf_r3_valid,
    vrf_r3_addr,
    vrf_r3_beat,
    vrf_r3_fu,
    vrf_r3_bypass_sel,
    vrf_r3_bypass_en,
    vrf_r3_last,
    vrf_r3_ready,
    vrf_r4_valid,
    vrf_r4_addr,
    vrf_r4_beat,
    vrf_r4_fu,
    vrf_r4_bypass_sel,
    vrf_r4_bypass_en,
    vrf_r4_last,
    vrf_r4_ready,
    vrf_r5_valid,
    vrf_r5_addr,
    vrf_r5_beat,
    vrf_r5_fu,
    vrf_r5_bypass_sel,
    vrf_r5_bypass_en,
    vrf_r5_last,
    vrf_r5_ready,
    vrf_r6_valid,
    vrf_r6_addr,
    vrf_r6_beat,
    vrf_r6_fu,
    vrf_r6_bypass_sel,
    vrf_r6_bypass_en,
    vrf_r6_last,
    vrf_r6_ready,
    vrf_r7_valid,
    vrf_r7_addr,
    vrf_r7_beat,
    vrf_r7_fu,
    vrf_r7_bypass_sel,
    vrf_r7_bypass_en,
    vrf_r7_last,
    vrf_r7_ready,
    vrf_r8_valid,
    vrf_r8_addr,
    vrf_r8_beat,
    vrf_r8_fu,
    vrf_r8_bypass_sel,
    vrf_r8_bypass_en,
    vrf_r8_last,
    vrf_r8_ready,
    vrf_r9_valid,
    vrf_r9_addr,
    vrf_r9_beat,
    vrf_r9_fu,
    vrf_r9_bypass_sel,
    vrf_r9_bypass_en,
    vrf_r9_last,
    vrf_r9_ready,
    vrf_r10_valid,
    vrf_r10_addr,
    vrf_r10_beat,
    vrf_r10_fu,
    vrf_r10_bypass_sel,
    vrf_r10_bypass_en,
    vrf_r10_last,
    vrf_r10_ready,
    vrf_w0_valid,
    vrf_w0_en,
    vrf_w0_addr,
    vrf_w0_fu,
    vrf_w0_last,
    vrf_w0_ready,
    vrf_w1_valid,
    vrf_w1_en,
    vrf_w1_addr,
    vrf_w1_fu,
    vrf_w1_last,
    vrf_w1_ready,
    vrf_w2_valid,
    vrf_w2_en,
    vrf_w2_addr,
    vrf_w2_fu,
    vrf_w2_last,
    vrf_w2_ready,
    vrf_w3_valid,
    vrf_w3_en,
    vrf_w3_addr,
    vrf_w3_fu,
    vrf_w3_last,
    vrf_w3_ready,
    vrf_w4_valid,
    vrf_w4_en,
    vrf_w4_addr,
    vrf_w4_fu,
    vrf_w4_last,
    vrf_w4_ready,
    vrf_w5_valid,
    vrf_w5_en,
    vrf_w5_addr,
    vrf_w5_fu,
    vrf_w5_last,
    vrf_w5_ready,
    vpu_clk,
    vpu_reset_n
);
parameter VLEN = 512;
parameter AGEN = 8;
parameter BYPASSW = 4;
parameter VRF_AW = 5;
parameter VRF_LW = 3;
parameter VMAC2_TYPE = 0;
parameter ACE_SP_WRITE_PORT = 3;
localparam FIFO_DEPTH = 8;
output vpu_standby_ready;
output vpu_vlsu_standby_ready;
output vpu_valu_standby_ready;
output vpu_vfmis_standby_ready;
output vpu_vmac_standby_ready;
output vpu_vfdiv_standby_ready;
output vpu_vdiv_standby_ready;
output vpu_vmask_standby_ready;
output vpu_vpermut_standby_ready;
output vpu_vace_standby_ready;
output vpu_vsp_standby_ready;
input valu_standby_ready;
input vfmis_standby_ready;
input vmac_standby_ready;
input vfdiv_standby_ready;
input vmask_standby_ready;
input vsp_standby_ready;
input vpermut_standby_ready;
input vace_standby_ready;
input [(11 - 1):0] viq_standby_ready;
input srf_standby_ready;
input vpu_vlsu_pending;
output [AGEN - 1:0] vscb_busy;
output vscb_v0t_write_pending;
input dis_i0_grant;
input [11 - 1:0] dis_i0_fu;
input dis_i0_vs1_en;
input [VRF_AW - 1:0] dis_i0_vs1_addr;
input [VRF_LW - 1:0] dis_i0_vs1_len;
input dis_i0_vs2_en;
input [VRF_AW - 1:0] dis_i0_vs2_addr;
input [VRF_LW - 1:0] dis_i0_vs2_len;
input dis_i0_vs3_en;
input [VRF_AW - 1:0] dis_i0_vs3_addr;
input [VRF_LW - 1:0] dis_i0_vs3_len;
input dis_i0_vd_en;
input [VRF_AW - 1:0] dis_i0_vd_addr;
input [VRF_LW - 1:0] dis_i0_vd_len;
input dis_i1_grant;
input [11 - 1:0] dis_i1_fu;
input dis_i1_vs1_en;
input [VRF_AW - 1:0] dis_i1_vs1_addr;
input [VRF_LW - 1:0] dis_i1_vs1_len;
input dis_i1_vs2_en;
input [VRF_AW - 1:0] dis_i1_vs2_addr;
input [VRF_LW - 1:0] dis_i1_vs2_len;
input dis_i1_vs3_en;
input [VRF_AW - 1:0] dis_i1_vs3_addr;
input [VRF_LW - 1:0] dis_i1_vs3_len;
input dis_i1_vd_en;
input [VRF_AW - 1:0] dis_i1_vd_addr;
input [VRF_LW - 1:0] dis_i1_vd_len;
input cmt_i0_grant;
input cmt_i0_kill;
input cmt_i1_grant;
input cmt_i1_kill;
output vrf_r0_valid;
output [(VLEN / 64 * 5) - 1:0] vrf_r0_addr;
output vrf_r0_beat;
output [11 - 1:0] vrf_r0_fu;
output [BYPASSW - 1:0] vrf_r0_bypass_sel;
output vrf_r0_bypass_en;
output vrf_r0_last;
input vrf_r0_ready;
output vrf_r1_valid;
output [(VLEN / 64 * 5) - 1:0] vrf_r1_addr;
output vrf_r1_beat;
output [11 - 1:0] vrf_r1_fu;
output [BYPASSW - 1:0] vrf_r1_bypass_sel;
output vrf_r1_bypass_en;
output vrf_r1_last;
input vrf_r1_ready;
output vrf_r2_valid;
output [(VLEN / 64 * 5) - 1:0] vrf_r2_addr;
output vrf_r2_beat;
output [11 - 1:0] vrf_r2_fu;
output [BYPASSW - 1:0] vrf_r2_bypass_sel;
output vrf_r2_bypass_en;
output vrf_r2_last;
input vrf_r2_ready;
output vrf_r3_valid;
output [(VLEN / 64 * 5) - 1:0] vrf_r3_addr;
output vrf_r3_beat;
output [11 - 1:0] vrf_r3_fu;
output [BYPASSW - 1:0] vrf_r3_bypass_sel;
output vrf_r3_bypass_en;
output vrf_r3_last;
input vrf_r3_ready;
output vrf_r4_valid;
output [(VLEN / 64 * 5) - 1:0] vrf_r4_addr;
output vrf_r4_beat;
output [11 - 1:0] vrf_r4_fu;
output [BYPASSW - 1:0] vrf_r4_bypass_sel;
output vrf_r4_bypass_en;
output vrf_r4_last;
input vrf_r4_ready;
output vrf_r5_valid;
output [(VLEN / 64 * 5) - 1:0] vrf_r5_addr;
output vrf_r5_beat;
output [11 - 1:0] vrf_r5_fu;
output [BYPASSW - 1:0] vrf_r5_bypass_sel;
output vrf_r5_bypass_en;
output vrf_r5_last;
input vrf_r5_ready;
output vrf_r6_valid;
output [(VLEN / 64 * 5) - 1:0] vrf_r6_addr;
output vrf_r6_beat;
output [11 - 1:0] vrf_r6_fu;
output [BYPASSW - 1:0] vrf_r6_bypass_sel;
output vrf_r6_bypass_en;
output vrf_r6_last;
input vrf_r6_ready;
output vrf_r7_valid;
output [(VLEN / 64 * 5) - 1:0] vrf_r7_addr;
output vrf_r7_beat;
output [11 - 1:0] vrf_r7_fu;
output [BYPASSW - 1:0] vrf_r7_bypass_sel;
output vrf_r7_bypass_en;
output vrf_r7_last;
input vrf_r7_ready;
output vrf_r8_valid;
output [(VLEN / 64 * 5) - 1:0] vrf_r8_addr;
output vrf_r8_beat;
output [11 - 1:0] vrf_r8_fu;
output [BYPASSW - 1:0] vrf_r8_bypass_sel;
output vrf_r8_bypass_en;
output vrf_r8_last;
input vrf_r8_ready;
output vrf_r9_valid;
output [(VLEN / 64 * 5) - 1:0] vrf_r9_addr;
output vrf_r9_beat;
output [11 - 1:0] vrf_r9_fu;
output [BYPASSW - 1:0] vrf_r9_bypass_sel;
output vrf_r9_bypass_en;
output vrf_r9_last;
input vrf_r9_ready;
output vrf_r10_valid;
output [(VLEN / 64 * 5) - 1:0] vrf_r10_addr;
output vrf_r10_beat;
output [11 - 1:0] vrf_r10_fu;
output [BYPASSW - 1:0] vrf_r10_bypass_sel;
output vrf_r10_bypass_en;
output vrf_r10_last;
input vrf_r10_ready;
input vrf_w0_valid;
output vrf_w0_en;
output [VRF_AW - 1:0] vrf_w0_addr;
output [11 - 1:0] vrf_w0_fu;
output vrf_w0_last;
output vrf_w0_ready;
input vrf_w1_valid;
output vrf_w1_en;
output [VRF_AW - 1:0] vrf_w1_addr;
output [11 - 1:0] vrf_w1_fu;
output vrf_w1_last;
output vrf_w1_ready;
input vrf_w2_valid;
output vrf_w2_en;
output [VRF_AW - 1:0] vrf_w2_addr;
output [11 - 1:0] vrf_w2_fu;
output vrf_w2_last;
output vrf_w2_ready;
input vrf_w3_valid;
output vrf_w3_en;
output [VRF_AW - 1:0] vrf_w3_addr;
output [11 - 1:0] vrf_w3_fu;
output vrf_w3_last;
output vrf_w3_ready;
input vrf_w4_valid;
output vrf_w4_en;
output [VRF_AW - 1:0] vrf_w4_addr;
output [11 - 1:0] vrf_w4_fu;
output vrf_w4_last;
output vrf_w4_ready;
input vrf_w5_valid;
output vrf_w5_en;
output [VRF_AW - 1:0] vrf_w5_addr;
output [11 - 1:0] vrf_w5_fu;
output vrf_w5_last;
output vrf_w5_ready;
input vpu_clk;
input vpu_reset_n;





// 7b8f542e rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [AGEN - 1:0] dis_age;
wire [AGEN - 1:0] s0;
wire s1;
wire [AGEN - 1:0] s2 = {dis_age[AGEN - 2:0],dis_age[AGEN - 1]};
wire [AGEN - 1:0] s3 = {dis_age[AGEN - 3:0],dis_age[AGEN - 1:AGEN - 2]};
wire [AGEN - 1:0] s4 = dis_age;
wire [AGEN - 1:0] s5 = s2;
reg [AGEN - 1:0] s6;
wire [AGEN - 1:0] s7;
wire ret_age_en;
wire [AGEN - 1:0] s8 = {s6[AGEN - 2:0],s6[AGEN - 1]};
wire [AGEN - 1:0] s9 = {s6[AGEN - 3:0],s6[AGEN - 1:AGEN - 2]};
wire s10;
reg [AGEN - 1:0] s11;
wire [AGEN - 1:0] s12 = {s11[AGEN - 2:0],s11[AGEN - 1]};
wire [AGEN - 1:0] s13 = {s11[AGEN - 3:0],s11[AGEN - 1:AGEN - 2]};
wire [AGEN - 1:0] s14;
wire [AGEN - 1:0] cmt_i0_age = s11;
wire [AGEN - 1:0] cmt_i1_age = s12;
reg s15;
wire s16;
reg vpu_vlsu_standby_ready;
wire s17;
reg vpu_valu_standby_ready;
wire s18;
reg vpu_vfmis_standby_ready;
wire s19;
reg vpu_vmac_standby_ready;
wire s20;
reg vpu_vmask_standby_ready;
wire s21;
reg vpu_vpermut_standby_ready;
wire s22;
reg vpu_vfdiv_standby_ready;
wire s23;
reg vpu_vdiv_standby_ready;
wire s24;
reg vpu_vace_standby_ready;
wire s25;
reg vpu_vsp_standby_ready;
wire s26;
wire [6 - 1:0] s27;
wire [11 - 1:0] s28;
wire [11 - 1:0] s29;
wire [11 - 1:0] s30;
wire [6 - 1:0] s31;
wire [11 - 1:0] s32;
wire [11 - 1:0] s33;
wire [11 - 1:0] s34;
kv_vscb_portmap #(
    .ACE_SP_WRITE_PORT(ACE_SP_WRITE_PORT)
) u_dis_i0_vs_port (
    .fu(dis_i0_fu),
    .vs1_port(s28),
    .vs2_port(s29),
    .vs3_port(s30),
    .vd_port(s27)
);
kv_vscb_portmap #(
    .ACE_SP_WRITE_PORT(ACE_SP_WRITE_PORT)
) u_dis_i1_vs_port (
    .fu(dis_i1_fu),
    .vs1_port(s32),
    .vs2_port(s33),
    .vs3_port(s34),
    .vd_port(s31)
);
wire [AGEN - 1:0] ent_valid;
wire [AGEN - 1:0] s35;
wire [(11 * AGEN) - 1:0] ent_fu;
wire [AGEN - 1:0] ent_valid_clr;
wire [AGEN * AGEN - 1:0] ent_age_mask;
wire [AGEN - 1:0] s36;
wire [AGEN - 1:0] s37;
wire [AGEN - 1:0] s38;
wire [AGEN - 1:0] s39;
wire [AGEN - 1:0] s40;
wire [AGEN - 1:0] s41;
wire [AGEN - 1:0] s42;
wire [AGEN - 1:0] s43;
wire [AGEN - 1:0] s44;
wire [AGEN - 1:0] s45;
wire [AGEN - 1:0] s46;
wire [AGEN - 1:0] s47;
wire [(VRF_AW * AGEN) - 1:0] s48;
wire [(VRF_LW * AGEN) - 1:0] s49;
wire s50;
reg [AGEN - 1:0] ent_committed;
wire [AGEN - 1:0] s51;
wire [AGEN - 1:0] s52;
wire [AGEN - 1:0] s53;
wire [AGEN - 1:0] s54;
wire [(VRF_AW * AGEN) - 1:0] s55;
wire [(VRF_LW * AGEN) - 1:0] s56;
wire [AGEN - 1:0] s57;
wire [(VRF_AW * AGEN) - 1:0] s58;
wire [(VRF_LW * AGEN) - 1:0] s59;
wire [AGEN - 1:0] s60;
wire [(VRF_AW * AGEN) - 1:0] s61;
wire [(VRF_LW * AGEN) - 1:0] s62;
wire [AGEN - 1:0] s63;
wire [(VRF_AW * AGEN) - 1:0] s64;
wire [(VRF_LW * AGEN) - 1:0] s65;
wire [AGEN - 1:0] s66;
wire [(VRF_AW * AGEN) - 1:0] s67;
wire [(VRF_LW * AGEN) - 1:0] s68;
wire [AGEN - 1:0] s69;
wire [(VRF_AW * AGEN) - 1:0] s70;
wire [(VRF_LW * AGEN) - 1:0] s71;
wire [AGEN - 1:0] s72;
wire [(VRF_AW * AGEN) - 1:0] s73;
wire [(VRF_LW * AGEN) - 1:0] s74;
wire [AGEN - 1:0] s75;
wire [(VRF_AW * AGEN) - 1:0] s76;
wire [(VRF_LW * AGEN) - 1:0] s77;
wire [AGEN - 1:0] s78;
wire [(VRF_AW * AGEN) - 1:0] s79;
wire [(VRF_LW * AGEN) - 1:0] s80;
wire [AGEN - 1:0] s81;
wire [(VRF_AW * AGEN) - 1:0] s82;
wire [(VRF_LW * AGEN) - 1:0] s83;
wire [AGEN - 1:0] s84;
wire [(VRF_AW * AGEN) - 1:0] s85;
wire [(VRF_LW * AGEN) - 1:0] s86;
wire s87;
wire [AGEN - 1:0] s88;
wire [VRF_AW - 1:0] s89;
wire s90;
wire s91 = 1'b0;
wire [AGEN - 1:0] s92;
wire [AGEN - 1:0] s93;
wire s94;
wire s95;
wire s96;
wire [AGEN - 1:0] s97;
wire s98;
wire [AGEN - 1:0] s99;
wire [VRF_AW - 1:0] s100;
wire s101;
wire s102 = 1'b0;
wire [AGEN - 1:0] s103;
wire [AGEN - 1:0] s104;
wire s105;
wire s106;
wire s107;
wire [AGEN - 1:0] s108;
wire s109;
wire [AGEN - 1:0] s110;
wire [VRF_AW - 1:0] s111;
wire s112;
wire s113 = 1'b0;
wire [AGEN - 1:0] s114;
wire [AGEN - 1:0] s115;
wire s116;
wire s117;
wire s118;
wire [AGEN - 1:0] s119;
wire s120;
wire [AGEN - 1:0] s121;
wire [VRF_AW - 1:0] s122;
wire s123;
wire s124 = 1'b0;
wire [AGEN - 1:0] s125;
wire [AGEN - 1:0] s126;
wire s127;
wire s128;
wire s129;
wire [AGEN - 1:0] s130;
wire s131;
wire [AGEN - 1:0] s132;
wire [VRF_AW - 1:0] s133;
wire s134;
wire s135 = 1'b0;
wire [AGEN - 1:0] s136;
wire [AGEN - 1:0] s137;
wire s138;
wire s139;
wire s140;
wire [AGEN - 1:0] s141;
wire s142;
wire [AGEN - 1:0] s143;
wire [VRF_AW - 1:0] s144;
wire s145;
wire s146 = 1'b0;
wire [AGEN - 1:0] s147;
wire [AGEN - 1:0] s148;
wire s149;
wire s150;
wire s151;
wire [AGEN - 1:0] s152;
wire s153;
wire [AGEN - 1:0] s154;
wire [VRF_AW - 1:0] s155;
wire s156;
wire s157 = 1'b0;
wire [AGEN - 1:0] s158;
wire [AGEN - 1:0] s159;
wire s160;
wire s161;
wire s162;
wire [AGEN - 1:0] s163;
wire s164;
wire [AGEN - 1:0] s165;
wire [VRF_AW - 1:0] s166;
wire s167;
wire s168 = 1'b0;
wire [AGEN - 1:0] s169;
wire [AGEN - 1:0] s170;
wire s171;
wire s172;
wire s173;
wire [AGEN - 1:0] s174;
wire s175;
wire [AGEN - 1:0] s176;
wire [VRF_AW - 1:0] s177;
wire s178;
wire s179 = 1'b0;
wire [AGEN - 1:0] s180;
wire [AGEN - 1:0] s181;
wire s182;
wire [AGEN - 1:0] s183;
wire [VRF_AW - 1:0] s184;
wire s185;
wire s186 = 1'b0;
wire [AGEN - 1:0] s187;
wire [AGEN - 1:0] s188;
wire s189;
wire [AGEN - 1:0] s190;
wire [VRF_AW - 1:0] s191;
wire s192;
wire s193 = 1'b0;
wire [AGEN - 1:0] s194;
wire [AGEN - 1:0] s195;
wire [AGEN - 1:0] s196;
wire [(VRF_AW * AGEN) - 1:0] s197 = s48;
wire [(VRF_LW * AGEN) - 1:0] s198 = s49;
wire [VRF_AW - 1:0] vrf_w0_addr;
wire w0_pending;
wire s199 = 1'b0;
wire [AGEN - 1:0] w0_age;
wire s200 = vrf_w0_valid & vrf_w0_ready;
wire s201;
wire [AGEN - 1:0] s202;
wire [AGEN - 1:0] s203;
wire [AGEN - 1:0] s204;
wire [AGEN - 1:0] s205;
wire [AGEN - 1:0] w0_age_mask;
wire [AGEN - 1:0] s206;
wire [AGEN - 1:0] s207;
wire s208;
wire s209;
wire s210;
wire [AGEN - 1:0] s211;
wire [AGEN - 1:0] s212;
wire [(VRF_AW * AGEN) - 1:0] s213 = s48;
wire [(VRF_LW * AGEN) - 1:0] s214 = s49;
wire [VRF_AW - 1:0] vrf_w1_addr;
wire w1_pending;
wire s215 = 1'b0;
wire [AGEN - 1:0] w1_age;
wire s216 = vrf_w1_valid & vrf_w1_ready;
wire s217;
wire [AGEN - 1:0] s218;
wire [AGEN - 1:0] s219;
wire [AGEN - 1:0] s220;
wire [AGEN - 1:0] s221;
wire [AGEN - 1:0] w1_age_mask;
wire [AGEN - 1:0] s222;
wire [AGEN - 1:0] s223;
wire s224;
wire s225;
wire s226;
wire [AGEN - 1:0] s227;
wire [AGEN - 1:0] s228;
wire [(VRF_AW * AGEN) - 1:0] s229 = s48;
wire [(VRF_LW * AGEN) - 1:0] s230 = s49;
wire [VRF_AW - 1:0] vrf_w2_addr;
wire w2_pending;
wire s231 = 1'b0;
wire [AGEN - 1:0] w2_age;
wire s232 = vrf_w2_valid & vrf_w2_ready;
wire s233;
wire [AGEN - 1:0] s234;
wire [AGEN - 1:0] s235;
wire [AGEN - 1:0] s236;
wire [AGEN - 1:0] s237;
wire [AGEN - 1:0] w2_age_mask;
wire [AGEN - 1:0] s238;
wire [AGEN - 1:0] s239;
wire s240;
wire s241;
wire s242;
wire [AGEN - 1:0] s243;
wire [AGEN - 1:0] s244;
wire [(VRF_AW * AGEN) - 1:0] s245 = s48;
wire [(VRF_LW * AGEN) - 1:0] s246 = s49;
wire [VRF_AW - 1:0] vrf_w3_addr;
wire w3_pending;
wire s247 = 1'b0;
wire [AGEN - 1:0] w3_age;
wire s248 = vrf_w3_valid & vrf_w3_ready;
wire s249;
wire [AGEN - 1:0] s250;
wire [AGEN - 1:0] s251;
wire [AGEN - 1:0] s252;
wire [AGEN - 1:0] s253;
wire [AGEN - 1:0] w3_age_mask;
wire [AGEN - 1:0] s254;
wire [AGEN - 1:0] s255;
wire s256;
wire s257;
wire s258;
wire [AGEN - 1:0] s259;
wire [AGEN - 1:0] s260;
wire [(VRF_AW * AGEN) - 1:0] s261 = s48;
wire [(VRF_LW * AGEN) - 1:0] s262 = s49;
wire [VRF_AW - 1:0] vrf_w4_addr;
wire w4_pending;
wire s263 = 1'b0;
wire [AGEN - 1:0] w4_age;
wire s264 = vrf_w4_valid & vrf_w4_ready;
wire s265;
wire [AGEN - 1:0] s266;
wire [AGEN - 1:0] s267;
wire [AGEN - 1:0] s268;
wire [AGEN - 1:0] s269;
wire [AGEN - 1:0] w4_age_mask;
wire [AGEN - 1:0] s270;
wire [AGEN - 1:0] s271;
wire s272;
wire s273;
wire s274;
wire [AGEN - 1:0] s275;
wire [AGEN - 1:0] s276;
wire [(VRF_AW * AGEN) - 1:0] s277 = s48;
wire [(VRF_LW * AGEN) - 1:0] s278 = s49;
wire [VRF_AW - 1:0] vrf_w5_addr;
wire s279;
wire s280 = 1'b0;
wire [AGEN - 1:0] s281;
wire s282 = vrf_w5_valid & vrf_w5_ready;
wire s283;
wire [AGEN - 1:0] s284;
wire [AGEN - 1:0] s285;
wire [AGEN - 1:0] s286;
wire [AGEN - 1:0] s287;
wire [AGEN - 1:0] s288;
wire s289;
wire s290;
wire [AGEN - 1:0] s291;
always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        dis_age <= {{(AGEN - 1){1'b0}},1'b1};
    end
    else if (s1) begin
        dis_age <= s0;
    end
end

always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s11 <= {{(AGEN - 1){1'b0}},1'b1};
    end
    else if (s10) begin
        s11 <= s14;
    end
end

assign s10 = cmt_i0_grant;
assign s14 = cmt_i1_grant ? s13 : s12;
always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s6 <= {{(AGEN - 1){1'b0}},1'b1};
    end
    else if (ret_age_en) begin
        s6 <= s7;
    end
end

assign s1 = dis_i0_grant;
assign s0 = dis_i1_grant ? s3 : s2;
kv_mux_onehot #(
    .N(AGEN),
    .W(1)
) u_retire_i0_valid (
    .out(s289),
    .sel(s6),
    .in(s35)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(1)
) u_retire_i1_valid (
    .out(s290),
    .sel(s8),
    .in(s35)
);
assign ret_age_en = s289;
assign s7 = s290 ? s9 : s8;
assign s291 = s6 | ({AGEN{s289}} & s8);
wire s292;
wire [VRF_AW - 1:0] s293;
wire [VRF_LW - 1:0] s294;
wire s295;
wire [VRF_AW - 1:0] s296;
wire [VRF_LW - 1:0] s297;
assign s292 = (dis_i0_vs1_en & s28[0]) | (dis_i0_vs2_en & s29[0]) | (dis_i0_vs3_en & s30[0]);
assign s293 = ({VRF_AW{s28[0]}} & dis_i0_vs1_addr) | ({VRF_AW{s29[0]}} & dis_i0_vs2_addr) | ({VRF_AW{s30[0]}} & dis_i0_vs3_addr);
assign s294 = ({VRF_LW{s28[0]}} & dis_i0_vs1_len) | ({VRF_LW{s29[0]}} & dis_i0_vs2_len) | ({VRF_LW{s30[0]}} & dis_i0_vs3_len);
assign s295 = (dis_i1_vs1_en & s32[0]) | (dis_i1_vs2_en & s33[0]) | (dis_i1_vs3_en & s34[0]);
assign s296 = ({VRF_AW{s32[0]}} & dis_i1_vs1_addr) | ({VRF_AW{s33[0]}} & dis_i1_vs2_addr) | ({VRF_AW{s34[0]}} & dis_i1_vs3_addr);
assign s297 = ({VRF_LW{s32[0]}} & dis_i1_vs1_len) | ({VRF_LW{s33[0]}} & dis_i1_vs2_len) | ({VRF_LW{s34[0]}} & dis_i1_vs3_len);
kv_vrf_rport #(
    .AGEN(AGEN),
    .BYPASSW(BYPASSW),
    .VRF_AW(VRF_AW),
    .VRF_LW(VRF_LW),
    .VLEN(VLEN)
) u_r0_port (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .dis_age(dis_age),
    .dis_i0_grant(dis_i0_grant),
    .dis_i0_en(s292),
    .dis_i0_addr(s293),
    .dis_i0_len(s294),
    .dis_i0_fu(dis_i0_fu),
    .dis_i1_grant(dis_i1_grant),
    .dis_i1_en(s295),
    .dis_i1_addr(s296),
    .dis_i1_len(s297),
    .dis_i1_fu(dis_i1_fu),
    .cmt_i0_grant(cmt_i0_grant),
    .cmt_i0_kill(cmt_i0_kill),
    .cmt_i0_age(cmt_i0_age),
    .cmt_i1_grant(cmt_i1_grant),
    .cmt_i1_kill(cmt_i1_kill),
    .cmt_i1_age(cmt_i1_age),
    .ret_age_en(ret_age_en),
    .ent_valid_clr(ent_valid_clr),
    .ent_valid(ent_valid),
    .ent_pending(s54),
    .ent_addr(s55),
    .ent_len(s56),
    .ent_fu(ent_fu),
    .ent_committed(ent_committed),
    .ent_age_mask(ent_age_mask),
    .r_grant(s90),
    .r_age(s88),
    .r_age_mask(s93),
    .r_addr(s89),
    .vrf_r_addr(vrf_r0_addr),
    .vrf_r_beat(vrf_r0_beat),
    .r_last(vrf_r0_last),
    .r_fu(vrf_r0_fu),
    .r_pending(s87),
    .r_bypass_sel(vrf_r0_bypass_sel),
    .w0_pending(w0_pending),
    .w1_pending(w1_pending),
    .w2_pending(w2_pending),
    .w3_pending(w3_pending),
    .w4_pending(w4_pending),
    .w0_addr(vrf_w0_addr),
    .w1_addr(vrf_w1_addr),
    .w2_addr(vrf_w2_addr),
    .w3_addr(vrf_w3_addr),
    .w4_addr(vrf_w4_addr),
    .w0_age(w0_age),
    .w1_age(w1_age),
    .w2_age(w2_age),
    .w3_age(w3_age),
    .w4_age(w4_age),
    .w0_age_mask(w0_age_mask),
    .w1_age_mask(w1_age_mask),
    .w2_age_mask(w2_age_mask),
    .w3_age_mask(w3_age_mask),
    .w4_age_mask(w4_age_mask)
);
wire s298;
wire [VRF_AW - 1:0] s299;
wire [VRF_LW - 1:0] s300;
wire s301;
wire [VRF_AW - 1:0] s302;
wire [VRF_LW - 1:0] s303;
assign s298 = (dis_i0_vs1_en & s28[1]) | (dis_i0_vs2_en & s29[1]) | (dis_i0_vs3_en & s30[1]);
assign s299 = ({VRF_AW{s28[1]}} & dis_i0_vs1_addr) | ({VRF_AW{s29[1]}} & dis_i0_vs2_addr) | ({VRF_AW{s30[1]}} & dis_i0_vs3_addr);
assign s300 = ({VRF_LW{s28[1]}} & dis_i0_vs1_len) | ({VRF_LW{s29[1]}} & dis_i0_vs2_len) | ({VRF_LW{s30[1]}} & dis_i0_vs3_len);
assign s301 = (dis_i1_vs1_en & s32[1]) | (dis_i1_vs2_en & s33[1]) | (dis_i1_vs3_en & s34[1]);
assign s302 = ({VRF_AW{s32[1]}} & dis_i1_vs1_addr) | ({VRF_AW{s33[1]}} & dis_i1_vs2_addr) | ({VRF_AW{s34[1]}} & dis_i1_vs3_addr);
assign s303 = ({VRF_LW{s32[1]}} & dis_i1_vs1_len) | ({VRF_LW{s33[1]}} & dis_i1_vs2_len) | ({VRF_LW{s34[1]}} & dis_i1_vs3_len);
kv_vrf_rport #(
    .AGEN(AGEN),
    .BYPASSW(BYPASSW),
    .VRF_AW(VRF_AW),
    .VRF_LW(VRF_LW),
    .VLEN(VLEN)
) u_r1_port (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .dis_age(dis_age),
    .dis_i0_grant(dis_i0_grant),
    .dis_i0_en(s298),
    .dis_i0_addr(s299),
    .dis_i0_len(s300),
    .dis_i0_fu(dis_i0_fu),
    .dis_i1_grant(dis_i1_grant),
    .dis_i1_en(s301),
    .dis_i1_addr(s302),
    .dis_i1_len(s303),
    .dis_i1_fu(dis_i1_fu),
    .cmt_i0_grant(cmt_i0_grant),
    .cmt_i0_kill(cmt_i0_kill),
    .cmt_i0_age(cmt_i0_age),
    .cmt_i1_grant(cmt_i1_grant),
    .cmt_i1_kill(cmt_i1_kill),
    .cmt_i1_age(cmt_i1_age),
    .ret_age_en(ret_age_en),
    .ent_valid_clr(ent_valid_clr),
    .ent_valid(ent_valid),
    .ent_pending(s57),
    .ent_addr(s58),
    .ent_len(s59),
    .ent_fu(ent_fu),
    .ent_committed(ent_committed),
    .ent_age_mask(ent_age_mask),
    .r_grant(s101),
    .r_age(s99),
    .r_age_mask(s104),
    .r_addr(s100),
    .vrf_r_addr(vrf_r1_addr),
    .vrf_r_beat(vrf_r1_beat),
    .r_last(vrf_r1_last),
    .r_fu(vrf_r1_fu),
    .r_pending(s98),
    .r_bypass_sel(vrf_r1_bypass_sel),
    .w0_pending(w0_pending),
    .w1_pending(w1_pending),
    .w2_pending(w2_pending),
    .w3_pending(w3_pending),
    .w4_pending(w4_pending),
    .w0_addr(vrf_w0_addr),
    .w1_addr(vrf_w1_addr),
    .w2_addr(vrf_w2_addr),
    .w3_addr(vrf_w3_addr),
    .w4_addr(vrf_w4_addr),
    .w0_age(w0_age),
    .w1_age(w1_age),
    .w2_age(w2_age),
    .w3_age(w3_age),
    .w4_age(w4_age),
    .w0_age_mask(w0_age_mask),
    .w1_age_mask(w1_age_mask),
    .w2_age_mask(w2_age_mask),
    .w3_age_mask(w3_age_mask),
    .w4_age_mask(w4_age_mask)
);
wire s304;
wire [VRF_AW - 1:0] s305;
wire [VRF_LW - 1:0] s306;
wire s307;
wire [VRF_AW - 1:0] s308;
wire [VRF_LW - 1:0] s309;
assign s304 = (dis_i0_vs1_en & s28[2]) | (dis_i0_vs2_en & s29[2]) | (dis_i0_vs3_en & s30[2]);
assign s305 = ({VRF_AW{s28[2]}} & dis_i0_vs1_addr) | ({VRF_AW{s29[2]}} & dis_i0_vs2_addr) | ({VRF_AW{s30[2]}} & dis_i0_vs3_addr);
assign s306 = ({VRF_LW{s28[2]}} & dis_i0_vs1_len) | ({VRF_LW{s29[2]}} & dis_i0_vs2_len) | ({VRF_LW{s30[2]}} & dis_i0_vs3_len);
assign s307 = (dis_i1_vs1_en & s32[2]) | (dis_i1_vs2_en & s33[2]) | (dis_i1_vs3_en & s34[2]);
assign s308 = ({VRF_AW{s32[2]}} & dis_i1_vs1_addr) | ({VRF_AW{s33[2]}} & dis_i1_vs2_addr) | ({VRF_AW{s34[2]}} & dis_i1_vs3_addr);
assign s309 = ({VRF_LW{s32[2]}} & dis_i1_vs1_len) | ({VRF_LW{s33[2]}} & dis_i1_vs2_len) | ({VRF_LW{s34[2]}} & dis_i1_vs3_len);
kv_vrf_rport #(
    .AGEN(AGEN),
    .BYPASSW(BYPASSW),
    .VRF_AW(VRF_AW),
    .VRF_LW(VRF_LW),
    .VLEN(VLEN)
) u_r2_port (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .dis_age(dis_age),
    .dis_i0_grant(dis_i0_grant),
    .dis_i0_en(s304),
    .dis_i0_addr(s305),
    .dis_i0_len(s306),
    .dis_i0_fu(dis_i0_fu),
    .dis_i1_grant(dis_i1_grant),
    .dis_i1_en(s307),
    .dis_i1_addr(s308),
    .dis_i1_len(s309),
    .dis_i1_fu(dis_i1_fu),
    .cmt_i0_grant(cmt_i0_grant),
    .cmt_i0_kill(cmt_i0_kill),
    .cmt_i0_age(cmt_i0_age),
    .cmt_i1_grant(cmt_i1_grant),
    .cmt_i1_kill(cmt_i1_kill),
    .cmt_i1_age(cmt_i1_age),
    .ret_age_en(ret_age_en),
    .ent_valid_clr(ent_valid_clr),
    .ent_valid(ent_valid),
    .ent_pending(s60),
    .ent_addr(s61),
    .ent_len(s62),
    .ent_fu(ent_fu),
    .ent_committed(ent_committed),
    .ent_age_mask(ent_age_mask),
    .r_grant(s112),
    .r_age(s110),
    .r_age_mask(s115),
    .r_addr(s111),
    .vrf_r_addr(vrf_r2_addr),
    .vrf_r_beat(vrf_r2_beat),
    .r_last(vrf_r2_last),
    .r_fu(vrf_r2_fu),
    .r_pending(s109),
    .r_bypass_sel(vrf_r2_bypass_sel),
    .w0_pending(w0_pending),
    .w1_pending(w1_pending),
    .w2_pending(w2_pending),
    .w3_pending(w3_pending),
    .w4_pending(w4_pending),
    .w0_addr(vrf_w0_addr),
    .w1_addr(vrf_w1_addr),
    .w2_addr(vrf_w2_addr),
    .w3_addr(vrf_w3_addr),
    .w4_addr(vrf_w4_addr),
    .w0_age(w0_age),
    .w1_age(w1_age),
    .w2_age(w2_age),
    .w3_age(w3_age),
    .w4_age(w4_age),
    .w0_age_mask(w0_age_mask),
    .w1_age_mask(w1_age_mask),
    .w2_age_mask(w2_age_mask),
    .w3_age_mask(w3_age_mask),
    .w4_age_mask(w4_age_mask)
);
wire s310;
wire [VRF_AW - 1:0] s311;
wire [VRF_LW - 1:0] s312;
wire s313;
wire [VRF_AW - 1:0] s314;
wire [VRF_LW - 1:0] s315;
assign s310 = (dis_i0_vs1_en & s28[3]) | (dis_i0_vs2_en & s29[3]) | (dis_i0_vs3_en & s30[3]);
assign s311 = ({VRF_AW{s28[3]}} & dis_i0_vs1_addr) | ({VRF_AW{s29[3]}} & dis_i0_vs2_addr) | ({VRF_AW{s30[3]}} & dis_i0_vs3_addr);
assign s312 = ({VRF_LW{s28[3]}} & dis_i0_vs1_len) | ({VRF_LW{s29[3]}} & dis_i0_vs2_len) | ({VRF_LW{s30[3]}} & dis_i0_vs3_len);
assign s313 = (dis_i1_vs1_en & s32[3]) | (dis_i1_vs2_en & s33[3]) | (dis_i1_vs3_en & s34[3]);
assign s314 = ({VRF_AW{s32[3]}} & dis_i1_vs1_addr) | ({VRF_AW{s33[3]}} & dis_i1_vs2_addr) | ({VRF_AW{s34[3]}} & dis_i1_vs3_addr);
assign s315 = ({VRF_LW{s32[3]}} & dis_i1_vs1_len) | ({VRF_LW{s33[3]}} & dis_i1_vs2_len) | ({VRF_LW{s34[3]}} & dis_i1_vs3_len);
kv_vrf_rport #(
    .AGEN(AGEN),
    .BYPASSW(BYPASSW),
    .VRF_AW(VRF_AW),
    .VRF_LW(VRF_LW),
    .VLEN(VLEN)
) u_r3_port (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .dis_age(dis_age),
    .dis_i0_grant(dis_i0_grant),
    .dis_i0_en(s310),
    .dis_i0_addr(s311),
    .dis_i0_len(s312),
    .dis_i0_fu(dis_i0_fu),
    .dis_i1_grant(dis_i1_grant),
    .dis_i1_en(s313),
    .dis_i1_addr(s314),
    .dis_i1_len(s315),
    .dis_i1_fu(dis_i1_fu),
    .cmt_i0_grant(cmt_i0_grant),
    .cmt_i0_kill(cmt_i0_kill),
    .cmt_i0_age(cmt_i0_age),
    .cmt_i1_grant(cmt_i1_grant),
    .cmt_i1_kill(cmt_i1_kill),
    .cmt_i1_age(cmt_i1_age),
    .ret_age_en(ret_age_en),
    .ent_valid_clr(ent_valid_clr),
    .ent_valid(ent_valid),
    .ent_pending(s63),
    .ent_addr(s64),
    .ent_len(s65),
    .ent_fu(ent_fu),
    .ent_committed(ent_committed),
    .ent_age_mask(ent_age_mask),
    .r_grant(s123),
    .r_age(s121),
    .r_age_mask(s126),
    .r_addr(s122),
    .vrf_r_addr(vrf_r3_addr),
    .vrf_r_beat(vrf_r3_beat),
    .r_last(vrf_r3_last),
    .r_fu(vrf_r3_fu),
    .r_pending(s120),
    .r_bypass_sel(vrf_r3_bypass_sel),
    .w0_pending(w0_pending),
    .w1_pending(w1_pending),
    .w2_pending(w2_pending),
    .w3_pending(w3_pending),
    .w4_pending(w4_pending),
    .w0_addr(vrf_w0_addr),
    .w1_addr(vrf_w1_addr),
    .w2_addr(vrf_w2_addr),
    .w3_addr(vrf_w3_addr),
    .w4_addr(vrf_w4_addr),
    .w0_age(w0_age),
    .w1_age(w1_age),
    .w2_age(w2_age),
    .w3_age(w3_age),
    .w4_age(w4_age),
    .w0_age_mask(w0_age_mask),
    .w1_age_mask(w1_age_mask),
    .w2_age_mask(w2_age_mask),
    .w3_age_mask(w3_age_mask),
    .w4_age_mask(w4_age_mask)
);
wire s316;
wire [VRF_AW - 1:0] s317;
wire [VRF_LW - 1:0] s318;
wire s319;
wire [VRF_AW - 1:0] s320;
wire [VRF_LW - 1:0] s321;
assign s316 = (dis_i0_vs1_en & s28[4]) | (dis_i0_vs2_en & s29[4]) | (dis_i0_vs3_en & s30[4]);
assign s317 = ({VRF_AW{s28[4]}} & dis_i0_vs1_addr) | ({VRF_AW{s29[4]}} & dis_i0_vs2_addr) | ({VRF_AW{s30[4]}} & dis_i0_vs3_addr);
assign s318 = ({VRF_LW{s28[4]}} & dis_i0_vs1_len) | ({VRF_LW{s29[4]}} & dis_i0_vs2_len) | ({VRF_LW{s30[4]}} & dis_i0_vs3_len);
assign s319 = (dis_i1_vs1_en & s32[4]) | (dis_i1_vs2_en & s33[4]) | (dis_i1_vs3_en & s34[4]);
assign s320 = ({VRF_AW{s32[4]}} & dis_i1_vs1_addr) | ({VRF_AW{s33[4]}} & dis_i1_vs2_addr) | ({VRF_AW{s34[4]}} & dis_i1_vs3_addr);
assign s321 = ({VRF_LW{s32[4]}} & dis_i1_vs1_len) | ({VRF_LW{s33[4]}} & dis_i1_vs2_len) | ({VRF_LW{s34[4]}} & dis_i1_vs3_len);
kv_vrf_rport #(
    .AGEN(AGEN),
    .BYPASSW(BYPASSW),
    .VRF_AW(VRF_AW),
    .VRF_LW(VRF_LW),
    .VLEN(VLEN)
) u_r4_port (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .dis_age(dis_age),
    .dis_i0_grant(dis_i0_grant),
    .dis_i0_en(s316),
    .dis_i0_addr(s317),
    .dis_i0_len(s318),
    .dis_i0_fu(dis_i0_fu),
    .dis_i1_grant(dis_i1_grant),
    .dis_i1_en(s319),
    .dis_i1_addr(s320),
    .dis_i1_len(s321),
    .dis_i1_fu(dis_i1_fu),
    .cmt_i0_grant(cmt_i0_grant),
    .cmt_i0_kill(cmt_i0_kill),
    .cmt_i0_age(cmt_i0_age),
    .cmt_i1_grant(cmt_i1_grant),
    .cmt_i1_kill(cmt_i1_kill),
    .cmt_i1_age(cmt_i1_age),
    .ret_age_en(ret_age_en),
    .ent_valid_clr(ent_valid_clr),
    .ent_valid(ent_valid),
    .ent_pending(s66),
    .ent_addr(s67),
    .ent_len(s68),
    .ent_fu(ent_fu),
    .ent_committed(ent_committed),
    .ent_age_mask(ent_age_mask),
    .r_grant(s134),
    .r_age(s132),
    .r_age_mask(s137),
    .r_addr(s133),
    .vrf_r_addr(vrf_r4_addr),
    .vrf_r_beat(vrf_r4_beat),
    .r_last(vrf_r4_last),
    .r_fu(vrf_r4_fu),
    .r_pending(s131),
    .r_bypass_sel(vrf_r4_bypass_sel),
    .w0_pending(w0_pending),
    .w1_pending(w1_pending),
    .w2_pending(w2_pending),
    .w3_pending(w3_pending),
    .w4_pending(w4_pending),
    .w0_addr(vrf_w0_addr),
    .w1_addr(vrf_w1_addr),
    .w2_addr(vrf_w2_addr),
    .w3_addr(vrf_w3_addr),
    .w4_addr(vrf_w4_addr),
    .w0_age(w0_age),
    .w1_age(w1_age),
    .w2_age(w2_age),
    .w3_age(w3_age),
    .w4_age(w4_age),
    .w0_age_mask(w0_age_mask),
    .w1_age_mask(w1_age_mask),
    .w2_age_mask(w2_age_mask),
    .w3_age_mask(w3_age_mask),
    .w4_age_mask(w4_age_mask)
);
wire s322;
wire [VRF_AW - 1:0] s323;
wire [VRF_LW - 1:0] s324;
wire s325;
wire [VRF_AW - 1:0] s326;
wire [VRF_LW - 1:0] s327;
assign s322 = (dis_i0_vs1_en & s28[5]) | (dis_i0_vs2_en & s29[5]) | (dis_i0_vs3_en & s30[5]);
assign s323 = ({VRF_AW{s28[5]}} & dis_i0_vs1_addr) | ({VRF_AW{s29[5]}} & dis_i0_vs2_addr) | ({VRF_AW{s30[5]}} & dis_i0_vs3_addr);
assign s324 = ({VRF_LW{s28[5]}} & dis_i0_vs1_len) | ({VRF_LW{s29[5]}} & dis_i0_vs2_len) | ({VRF_LW{s30[5]}} & dis_i0_vs3_len);
assign s325 = (dis_i1_vs1_en & s32[5]) | (dis_i1_vs2_en & s33[5]) | (dis_i1_vs3_en & s34[5]);
assign s326 = ({VRF_AW{s32[5]}} & dis_i1_vs1_addr) | ({VRF_AW{s33[5]}} & dis_i1_vs2_addr) | ({VRF_AW{s34[5]}} & dis_i1_vs3_addr);
assign s327 = ({VRF_LW{s32[5]}} & dis_i1_vs1_len) | ({VRF_LW{s33[5]}} & dis_i1_vs2_len) | ({VRF_LW{s34[5]}} & dis_i1_vs3_len);
kv_vrf_rport #(
    .AGEN(AGEN),
    .BYPASSW(BYPASSW),
    .VRF_AW(VRF_AW),
    .VRF_LW(VRF_LW),
    .VLEN(VLEN)
) u_r5_port (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .dis_age(dis_age),
    .dis_i0_grant(dis_i0_grant),
    .dis_i0_en(s322),
    .dis_i0_addr(s323),
    .dis_i0_len(s324),
    .dis_i0_fu(dis_i0_fu),
    .dis_i1_grant(dis_i1_grant),
    .dis_i1_en(s325),
    .dis_i1_addr(s326),
    .dis_i1_len(s327),
    .dis_i1_fu(dis_i1_fu),
    .cmt_i0_grant(cmt_i0_grant),
    .cmt_i0_kill(cmt_i0_kill),
    .cmt_i0_age(cmt_i0_age),
    .cmt_i1_grant(cmt_i1_grant),
    .cmt_i1_kill(cmt_i1_kill),
    .cmt_i1_age(cmt_i1_age),
    .ret_age_en(ret_age_en),
    .ent_valid_clr(ent_valid_clr),
    .ent_valid(ent_valid),
    .ent_pending(s69),
    .ent_addr(s70),
    .ent_len(s71),
    .ent_fu(ent_fu),
    .ent_committed(ent_committed),
    .ent_age_mask(ent_age_mask),
    .r_grant(s145),
    .r_age(s143),
    .r_age_mask(s148),
    .r_addr(s144),
    .vrf_r_addr(vrf_r5_addr),
    .vrf_r_beat(vrf_r5_beat),
    .r_last(vrf_r5_last),
    .r_fu(vrf_r5_fu),
    .r_pending(s142),
    .r_bypass_sel(vrf_r5_bypass_sel),
    .w0_pending(w0_pending),
    .w1_pending(w1_pending),
    .w2_pending(w2_pending),
    .w3_pending(w3_pending),
    .w4_pending(w4_pending),
    .w0_addr(vrf_w0_addr),
    .w1_addr(vrf_w1_addr),
    .w2_addr(vrf_w2_addr),
    .w3_addr(vrf_w3_addr),
    .w4_addr(vrf_w4_addr),
    .w0_age(w0_age),
    .w1_age(w1_age),
    .w2_age(w2_age),
    .w3_age(w3_age),
    .w4_age(w4_age),
    .w0_age_mask(w0_age_mask),
    .w1_age_mask(w1_age_mask),
    .w2_age_mask(w2_age_mask),
    .w3_age_mask(w3_age_mask),
    .w4_age_mask(w4_age_mask)
);
wire s328;
wire [VRF_AW - 1:0] s329;
wire [VRF_LW - 1:0] s330;
wire s331;
wire [VRF_AW - 1:0] s332;
wire [VRF_LW - 1:0] s333;
assign s328 = (dis_i0_vs1_en & s28[6]) | (dis_i0_vs2_en & s29[6]) | (dis_i0_vs3_en & s30[6]);
assign s329 = ({VRF_AW{s28[6]}} & dis_i0_vs1_addr) | ({VRF_AW{s29[6]}} & dis_i0_vs2_addr) | ({VRF_AW{s30[6]}} & dis_i0_vs3_addr);
assign s330 = ({VRF_LW{s28[6]}} & dis_i0_vs1_len) | ({VRF_LW{s29[6]}} & dis_i0_vs2_len) | ({VRF_LW{s30[6]}} & dis_i0_vs3_len);
assign s331 = (dis_i1_vs1_en & s32[6]) | (dis_i1_vs2_en & s33[6]) | (dis_i1_vs3_en & s34[6]);
assign s332 = ({VRF_AW{s32[6]}} & dis_i1_vs1_addr) | ({VRF_AW{s33[6]}} & dis_i1_vs2_addr) | ({VRF_AW{s34[6]}} & dis_i1_vs3_addr);
assign s333 = ({VRF_LW{s32[6]}} & dis_i1_vs1_len) | ({VRF_LW{s33[6]}} & dis_i1_vs2_len) | ({VRF_LW{s34[6]}} & dis_i1_vs3_len);
kv_vrf_rport #(
    .AGEN(AGEN),
    .BYPASSW(BYPASSW),
    .VRF_AW(VRF_AW),
    .VRF_LW(VRF_LW),
    .VLEN(VLEN)
) u_r6_port (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .dis_age(dis_age),
    .dis_i0_grant(dis_i0_grant),
    .dis_i0_en(s328),
    .dis_i0_addr(s329),
    .dis_i0_len(s330),
    .dis_i0_fu(dis_i0_fu),
    .dis_i1_grant(dis_i1_grant),
    .dis_i1_en(s331),
    .dis_i1_addr(s332),
    .dis_i1_len(s333),
    .dis_i1_fu(dis_i1_fu),
    .cmt_i0_grant(cmt_i0_grant),
    .cmt_i0_kill(cmt_i0_kill),
    .cmt_i0_age(cmt_i0_age),
    .cmt_i1_grant(cmt_i1_grant),
    .cmt_i1_kill(cmt_i1_kill),
    .cmt_i1_age(cmt_i1_age),
    .ret_age_en(ret_age_en),
    .ent_valid_clr(ent_valid_clr),
    .ent_valid(ent_valid),
    .ent_pending(s72),
    .ent_addr(s73),
    .ent_len(s74),
    .ent_fu(ent_fu),
    .ent_committed(ent_committed),
    .ent_age_mask(ent_age_mask),
    .r_grant(s156),
    .r_age(s154),
    .r_age_mask(s159),
    .r_addr(s155),
    .vrf_r_addr(vrf_r6_addr),
    .vrf_r_beat(vrf_r6_beat),
    .r_last(vrf_r6_last),
    .r_fu(vrf_r6_fu),
    .r_pending(s153),
    .r_bypass_sel(vrf_r6_bypass_sel),
    .w0_pending(w0_pending),
    .w1_pending(w1_pending),
    .w2_pending(w2_pending),
    .w3_pending(w3_pending),
    .w4_pending(w4_pending),
    .w0_addr(vrf_w0_addr),
    .w1_addr(vrf_w1_addr),
    .w2_addr(vrf_w2_addr),
    .w3_addr(vrf_w3_addr),
    .w4_addr(vrf_w4_addr),
    .w0_age(w0_age),
    .w1_age(w1_age),
    .w2_age(w2_age),
    .w3_age(w3_age),
    .w4_age(w4_age),
    .w0_age_mask(w0_age_mask),
    .w1_age_mask(w1_age_mask),
    .w2_age_mask(w2_age_mask),
    .w3_age_mask(w3_age_mask),
    .w4_age_mask(w4_age_mask)
);
wire s334;
wire [VRF_AW - 1:0] s335;
wire [VRF_LW - 1:0] s336;
wire s337;
wire [VRF_AW - 1:0] s338;
wire [VRF_LW - 1:0] s339;
assign s334 = (dis_i0_vs1_en & s28[7]) | (dis_i0_vs2_en & s29[7]) | (dis_i0_vs3_en & s30[7]);
assign s335 = ({VRF_AW{s28[7]}} & dis_i0_vs1_addr) | ({VRF_AW{s29[7]}} & dis_i0_vs2_addr) | ({VRF_AW{s30[7]}} & dis_i0_vs3_addr);
assign s336 = ({VRF_LW{s28[7]}} & dis_i0_vs1_len) | ({VRF_LW{s29[7]}} & dis_i0_vs2_len) | ({VRF_LW{s30[7]}} & dis_i0_vs3_len);
assign s337 = (dis_i1_vs1_en & s32[7]) | (dis_i1_vs2_en & s33[7]) | (dis_i1_vs3_en & s34[7]);
assign s338 = ({VRF_AW{s32[7]}} & dis_i1_vs1_addr) | ({VRF_AW{s33[7]}} & dis_i1_vs2_addr) | ({VRF_AW{s34[7]}} & dis_i1_vs3_addr);
assign s339 = ({VRF_LW{s32[7]}} & dis_i1_vs1_len) | ({VRF_LW{s33[7]}} & dis_i1_vs2_len) | ({VRF_LW{s34[7]}} & dis_i1_vs3_len);
kv_vrf_rport #(
    .AGEN(AGEN),
    .BYPASSW(BYPASSW),
    .VRF_AW(VRF_AW),
    .VRF_LW(VRF_LW),
    .VLEN(VLEN)
) u_r7_port (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .dis_age(dis_age),
    .dis_i0_grant(dis_i0_grant),
    .dis_i0_en(s334),
    .dis_i0_addr(s335),
    .dis_i0_len(s336),
    .dis_i0_fu(dis_i0_fu),
    .dis_i1_grant(dis_i1_grant),
    .dis_i1_en(s337),
    .dis_i1_addr(s338),
    .dis_i1_len(s339),
    .dis_i1_fu(dis_i1_fu),
    .cmt_i0_grant(cmt_i0_grant),
    .cmt_i0_kill(cmt_i0_kill),
    .cmt_i0_age(cmt_i0_age),
    .cmt_i1_grant(cmt_i1_grant),
    .cmt_i1_kill(cmt_i1_kill),
    .cmt_i1_age(cmt_i1_age),
    .ret_age_en(ret_age_en),
    .ent_valid_clr(ent_valid_clr),
    .ent_valid(ent_valid),
    .ent_pending(s75),
    .ent_addr(s76),
    .ent_len(s77),
    .ent_fu(ent_fu),
    .ent_committed(ent_committed),
    .ent_age_mask(ent_age_mask),
    .r_grant(s167),
    .r_age(s165),
    .r_age_mask(s170),
    .r_addr(s166),
    .vrf_r_addr(vrf_r7_addr),
    .vrf_r_beat(vrf_r7_beat),
    .r_last(vrf_r7_last),
    .r_fu(vrf_r7_fu),
    .r_pending(s164),
    .r_bypass_sel(vrf_r7_bypass_sel),
    .w0_pending(w0_pending),
    .w1_pending(w1_pending),
    .w2_pending(w2_pending),
    .w3_pending(w3_pending),
    .w4_pending(w4_pending),
    .w0_addr(vrf_w0_addr),
    .w1_addr(vrf_w1_addr),
    .w2_addr(vrf_w2_addr),
    .w3_addr(vrf_w3_addr),
    .w4_addr(vrf_w4_addr),
    .w0_age(w0_age),
    .w1_age(w1_age),
    .w2_age(w2_age),
    .w3_age(w3_age),
    .w4_age(w4_age),
    .w0_age_mask(w0_age_mask),
    .w1_age_mask(w1_age_mask),
    .w2_age_mask(w2_age_mask),
    .w3_age_mask(w3_age_mask),
    .w4_age_mask(w4_age_mask)
);
generate
    if (VMAC2_TYPE != 0) begin:gen_vmac2_port
        wire s340;
        wire [VRF_AW - 1:0] s341;
        wire [VRF_LW - 1:0] s342;
        wire s343;
        wire [VRF_AW - 1:0] s344;
        wire [VRF_LW - 1:0] s345;
        assign s340 = (dis_i0_vs1_en & s28[8]) | (dis_i0_vs2_en & s29[8]) | (dis_i0_vs3_en & s30[8]);
        assign s341 = ({VRF_AW{s28[8]}} & dis_i0_vs1_addr) | ({VRF_AW{s29[8]}} & dis_i0_vs2_addr) | ({VRF_AW{s30[8]}} & dis_i0_vs3_addr);
        assign s342 = ({VRF_LW{s28[8]}} & dis_i0_vs1_len) | ({VRF_LW{s29[8]}} & dis_i0_vs2_len) | ({VRF_LW{s30[8]}} & dis_i0_vs3_len);
        assign s343 = (dis_i1_vs1_en & s32[8]) | (dis_i1_vs2_en & s33[8]) | (dis_i1_vs3_en & s34[8]);
        assign s344 = ({VRF_AW{s32[8]}} & dis_i1_vs1_addr) | ({VRF_AW{s33[8]}} & dis_i1_vs2_addr) | ({VRF_AW{s34[8]}} & dis_i1_vs3_addr);
        assign s345 = ({VRF_LW{s32[8]}} & dis_i1_vs1_len) | ({VRF_LW{s33[8]}} & dis_i1_vs2_len) | ({VRF_LW{s34[8]}} & dis_i1_vs3_len);
        kv_vrf_rport #(
            .AGEN(AGEN),
            .BYPASSW(BYPASSW),
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW),
            .VLEN(VLEN)
        ) u_r8_port (
            .vpu_clk(vpu_clk),
            .vpu_reset_n(vpu_reset_n),
            .dis_age(dis_age),
            .dis_i0_grant(dis_i0_grant),
            .dis_i0_en(s340),
            .dis_i0_addr(s341),
            .dis_i0_len(s342),
            .dis_i0_fu(dis_i0_fu),
            .dis_i1_grant(dis_i1_grant),
            .dis_i1_en(s343),
            .dis_i1_addr(s344),
            .dis_i1_len(s345),
            .dis_i1_fu(dis_i1_fu),
            .cmt_i0_grant(cmt_i0_grant),
            .cmt_i0_kill(cmt_i0_kill),
            .cmt_i0_age(cmt_i0_age),
            .cmt_i1_grant(cmt_i1_grant),
            .cmt_i1_kill(cmt_i1_kill),
            .cmt_i1_age(cmt_i1_age),
            .ret_age_en(ret_age_en),
            .ent_valid_clr(ent_valid_clr),
            .ent_valid(ent_valid),
            .ent_pending(s78),
            .ent_addr(s79),
            .ent_len(s80),
            .ent_fu(ent_fu),
            .ent_committed(ent_committed),
            .ent_age_mask(ent_age_mask),
            .r_grant(s178),
            .r_age(s176),
            .r_age_mask(s181),
            .r_addr(s177),
            .vrf_r_addr(vrf_r8_addr),
            .vrf_r_beat(vrf_r8_beat),
            .r_last(vrf_r8_last),
            .r_fu(vrf_r8_fu),
            .r_pending(s175),
            .r_bypass_sel(vrf_r8_bypass_sel),
            .w0_pending(w0_pending),
            .w1_pending(w1_pending),
            .w2_pending(w2_pending),
            .w3_pending(w3_pending),
            .w4_pending(w4_pending),
            .w0_addr(vrf_w0_addr),
            .w1_addr(vrf_w1_addr),
            .w2_addr(vrf_w2_addr),
            .w3_addr(vrf_w3_addr),
            .w4_addr(vrf_w4_addr),
            .w0_age(w0_age),
            .w1_age(w1_age),
            .w2_age(w2_age),
            .w3_age(w3_age),
            .w4_age(w4_age),
            .w0_age_mask(w0_age_mask),
            .w1_age_mask(w1_age_mask),
            .w2_age_mask(w2_age_mask),
            .w3_age_mask(w3_age_mask),
            .w4_age_mask(w4_age_mask)
        );
        wire s346;
        wire [VRF_AW - 1:0] s347;
        wire [VRF_LW - 1:0] s348;
        wire s349;
        wire [VRF_AW - 1:0] s350;
        wire [VRF_LW - 1:0] s351;
        assign s346 = (dis_i0_vs1_en & s28[9]) | (dis_i0_vs2_en & s29[9]) | (dis_i0_vs3_en & s30[9]);
        assign s347 = ({VRF_AW{s28[9]}} & dis_i0_vs1_addr) | ({VRF_AW{s29[9]}} & dis_i0_vs2_addr) | ({VRF_AW{s30[9]}} & dis_i0_vs3_addr);
        assign s348 = ({VRF_LW{s28[9]}} & dis_i0_vs1_len) | ({VRF_LW{s29[9]}} & dis_i0_vs2_len) | ({VRF_LW{s30[9]}} & dis_i0_vs3_len);
        assign s349 = (dis_i1_vs1_en & s32[9]) | (dis_i1_vs2_en & s33[9]) | (dis_i1_vs3_en & s34[9]);
        assign s350 = ({VRF_AW{s32[9]}} & dis_i1_vs1_addr) | ({VRF_AW{s33[9]}} & dis_i1_vs2_addr) | ({VRF_AW{s34[9]}} & dis_i1_vs3_addr);
        assign s351 = ({VRF_LW{s32[9]}} & dis_i1_vs1_len) | ({VRF_LW{s33[9]}} & dis_i1_vs2_len) | ({VRF_LW{s34[9]}} & dis_i1_vs3_len);
        kv_vrf_rport #(
            .AGEN(AGEN),
            .BYPASSW(BYPASSW),
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW),
            .VLEN(VLEN)
        ) u_r9_port (
            .vpu_clk(vpu_clk),
            .vpu_reset_n(vpu_reset_n),
            .dis_age(dis_age),
            .dis_i0_grant(dis_i0_grant),
            .dis_i0_en(s346),
            .dis_i0_addr(s347),
            .dis_i0_len(s348),
            .dis_i0_fu(dis_i0_fu),
            .dis_i1_grant(dis_i1_grant),
            .dis_i1_en(s349),
            .dis_i1_addr(s350),
            .dis_i1_len(s351),
            .dis_i1_fu(dis_i1_fu),
            .cmt_i0_grant(cmt_i0_grant),
            .cmt_i0_kill(cmt_i0_kill),
            .cmt_i0_age(cmt_i0_age),
            .cmt_i1_grant(cmt_i1_grant),
            .cmt_i1_kill(cmt_i1_kill),
            .cmt_i1_age(cmt_i1_age),
            .ret_age_en(ret_age_en),
            .ent_valid_clr(ent_valid_clr),
            .ent_valid(ent_valid),
            .ent_pending(s81),
            .ent_addr(s82),
            .ent_len(s83),
            .ent_fu(ent_fu),
            .ent_committed(ent_committed),
            .ent_age_mask(ent_age_mask),
            .r_grant(s185),
            .r_age(s183),
            .r_age_mask(s188),
            .r_addr(s184),
            .vrf_r_addr(vrf_r9_addr),
            .vrf_r_beat(vrf_r9_beat),
            .r_last(vrf_r9_last),
            .r_fu(vrf_r9_fu),
            .r_pending(s182),
            .r_bypass_sel(vrf_r9_bypass_sel),
            .w0_pending(w0_pending),
            .w1_pending(w1_pending),
            .w2_pending(w2_pending),
            .w3_pending(w3_pending),
            .w4_pending(w4_pending),
            .w0_addr(vrf_w0_addr),
            .w1_addr(vrf_w1_addr),
            .w2_addr(vrf_w2_addr),
            .w3_addr(vrf_w3_addr),
            .w4_addr(vrf_w4_addr),
            .w0_age(w0_age),
            .w1_age(w1_age),
            .w2_age(w2_age),
            .w3_age(w3_age),
            .w4_age(w4_age),
            .w0_age_mask(w0_age_mask),
            .w1_age_mask(w1_age_mask),
            .w2_age_mask(w2_age_mask),
            .w3_age_mask(w3_age_mask),
            .w4_age_mask(w4_age_mask)
        );
        wire s352;
        wire [VRF_AW - 1:0] s353;
        wire [VRF_LW - 1:0] s354;
        wire s355;
        wire [VRF_AW - 1:0] s356;
        wire [VRF_LW - 1:0] s357;
        assign s352 = (dis_i0_vs1_en & s28[10]) | (dis_i0_vs2_en & s29[10]) | (dis_i0_vs3_en & s30[10]);
        assign s353 = ({VRF_AW{s28[10]}} & dis_i0_vs1_addr) | ({VRF_AW{s29[10]}} & dis_i0_vs2_addr) | ({VRF_AW{s30[10]}} & dis_i0_vs3_addr);
        assign s354 = ({VRF_LW{s28[10]}} & dis_i0_vs1_len) | ({VRF_LW{s29[10]}} & dis_i0_vs2_len) | ({VRF_LW{s30[10]}} & dis_i0_vs3_len);
        assign s355 = (dis_i1_vs1_en & s32[10]) | (dis_i1_vs2_en & s33[10]) | (dis_i1_vs3_en & s34[10]);
        assign s356 = ({VRF_AW{s32[10]}} & dis_i1_vs1_addr) | ({VRF_AW{s33[10]}} & dis_i1_vs2_addr) | ({VRF_AW{s34[10]}} & dis_i1_vs3_addr);
        assign s357 = ({VRF_LW{s32[10]}} & dis_i1_vs1_len) | ({VRF_LW{s33[10]}} & dis_i1_vs2_len) | ({VRF_LW{s34[10]}} & dis_i1_vs3_len);
        kv_vrf_rport #(
            .AGEN(AGEN),
            .BYPASSW(BYPASSW),
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW),
            .VLEN(VLEN)
        ) u_r10_port (
            .vpu_clk(vpu_clk),
            .vpu_reset_n(vpu_reset_n),
            .dis_age(dis_age),
            .dis_i0_grant(dis_i0_grant),
            .dis_i0_en(s352),
            .dis_i0_addr(s353),
            .dis_i0_len(s354),
            .dis_i0_fu(dis_i0_fu),
            .dis_i1_grant(dis_i1_grant),
            .dis_i1_en(s355),
            .dis_i1_addr(s356),
            .dis_i1_len(s357),
            .dis_i1_fu(dis_i1_fu),
            .cmt_i0_grant(cmt_i0_grant),
            .cmt_i0_kill(cmt_i0_kill),
            .cmt_i0_age(cmt_i0_age),
            .cmt_i1_grant(cmt_i1_grant),
            .cmt_i1_kill(cmt_i1_kill),
            .cmt_i1_age(cmt_i1_age),
            .ret_age_en(ret_age_en),
            .ent_valid_clr(ent_valid_clr),
            .ent_valid(ent_valid),
            .ent_pending(s84),
            .ent_addr(s85),
            .ent_len(s86),
            .ent_fu(ent_fu),
            .ent_committed(ent_committed),
            .ent_age_mask(ent_age_mask),
            .r_grant(s192),
            .r_age(s190),
            .r_age_mask(s195),
            .r_addr(s191),
            .vrf_r_addr(vrf_r10_addr),
            .vrf_r_beat(vrf_r10_beat),
            .r_last(vrf_r10_last),
            .r_fu(vrf_r10_fu),
            .r_pending(s189),
            .r_bypass_sel(vrf_r10_bypass_sel),
            .w0_pending(w0_pending),
            .w1_pending(w1_pending),
            .w2_pending(w2_pending),
            .w3_pending(w3_pending),
            .w4_pending(w4_pending),
            .w0_addr(vrf_w0_addr),
            .w1_addr(vrf_w1_addr),
            .w2_addr(vrf_w2_addr),
            .w3_addr(vrf_w3_addr),
            .w4_addr(vrf_w4_addr),
            .w0_age(w0_age),
            .w1_age(w1_age),
            .w2_age(w2_age),
            .w3_age(w3_age),
            .w4_age(w4_age),
            .w0_age_mask(w0_age_mask),
            .w1_age_mask(w1_age_mask),
            .w2_age_mask(w2_age_mask),
            .w3_age_mask(w3_age_mask),
            .w4_age_mask(w4_age_mask)
        );
    end
    else begin:gen_vmac2_rport_stub
        assign s176 = {AGEN{1'b0}};
        assign s181 = {AGEN{1'b0}};
        assign s175 = 1'b0;
        assign s177 = {VRF_AW{1'b0}};
        assign vrf_r8_addr = {VLEN / 64 * 5{1'b0}};
        assign vrf_r8_beat = 1'b0;
        assign vrf_r8_last = 1'b0;
        assign vrf_r8_fu = {11{1'b0}};
        assign vrf_r8_bypass_sel = {BYPASSW{1'b0}};
        assign s183 = {AGEN{1'b0}};
        assign s188 = {AGEN{1'b0}};
        assign s182 = 1'b0;
        assign s184 = {VRF_AW{1'b0}};
        assign vrf_r9_addr = {VLEN / 64 * 5{1'b0}};
        assign vrf_r9_beat = 1'b0;
        assign vrf_r9_last = 1'b0;
        assign vrf_r9_fu = {11{1'b0}};
        assign vrf_r9_bypass_sel = {BYPASSW{1'b0}};
        assign s190 = {AGEN{1'b0}};
        assign s195 = {AGEN{1'b0}};
        assign s189 = 1'b0;
        assign s191 = {VRF_AW{1'b0}};
        assign vrf_r10_addr = {VLEN / 64 * 5{1'b0}};
        assign vrf_r10_beat = 1'b0;
        assign vrf_r10_last = 1'b0;
        assign vrf_r10_fu = {11{1'b0}};
        assign vrf_r10_bypass_sel = {BYPASSW{1'b0}};
    end
endgenerate
wire s358;
wire [VRF_AW - 1:0] s359;
wire [VRF_LW - 1:0] s360;
wire s361;
wire [VRF_AW - 1:0] s362;
wire [VRF_LW - 1:0] s363;
assign s358 = dis_i0_vd_en & s27[0];
assign s359 = dis_i0_vd_addr;
assign s360 = dis_i0_vd_len;
assign s361 = dis_i1_vd_en & s31[0];
assign s362 = dis_i1_vd_addr;
assign s363 = dis_i1_vd_len;
kv_vrf_wport #(
    .AGEN(AGEN),
    .VRF_AW(VRF_AW),
    .VRF_LW(VRF_LW)
) u_w0_port (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .dis_age(dis_age),
    .dis_i0_grant(dis_i0_grant),
    .dis_i0_en(s358),
    .dis_i0_addr(s359),
    .dis_i0_len(s360),
    .dis_i0_fu(dis_i0_fu),
    .dis_i1_grant(dis_i1_grant),
    .dis_i1_en(s361),
    .dis_i1_addr(s362),
    .dis_i1_len(s363),
    .dis_i1_fu(dis_i1_fu),
    .cmt_i0_grant(cmt_i0_grant),
    .cmt_i0_kill(cmt_i0_kill),
    .cmt_i0_age(cmt_i0_age),
    .cmt_i1_grant(cmt_i1_grant),
    .cmt_i1_kill(cmt_i1_kill),
    .cmt_i1_age(cmt_i1_age),
    .ret_age_en(ret_age_en),
    .ent_valid_clr(ent_valid_clr),
    .ent_valid(ent_valid),
    .ent_pending(s196),
    .ent_addr(s197),
    .ent_len(s198),
    .ent_fu(ent_fu),
    .ent_committed(ent_committed),
    .ent_age_mask(ent_age_mask),
    .w_grant(s200),
    .w_age(w0_age),
    .w_age_mask(w0_age_mask),
    .w_addr(vrf_w0_addr),
    .w_last(vrf_w0_last),
    .w_fu(vrf_w0_fu),
    .w_committed(s201),
    .w_pending(w0_pending)
);
wire s364;
wire [VRF_AW - 1:0] s365;
wire [VRF_LW - 1:0] s366;
wire s367;
wire [VRF_AW - 1:0] s368;
wire [VRF_LW - 1:0] s369;
assign s364 = dis_i0_vd_en & s27[1];
assign s365 = dis_i0_vd_addr;
assign s366 = dis_i0_vd_len;
assign s367 = dis_i1_vd_en & s31[1];
assign s368 = dis_i1_vd_addr;
assign s369 = dis_i1_vd_len;
kv_vrf_wport #(
    .AGEN(AGEN),
    .VRF_AW(VRF_AW),
    .VRF_LW(VRF_LW)
) u_w1_port (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .dis_age(dis_age),
    .dis_i0_grant(dis_i0_grant),
    .dis_i0_en(s364),
    .dis_i0_addr(s365),
    .dis_i0_len(s366),
    .dis_i0_fu(dis_i0_fu),
    .dis_i1_grant(dis_i1_grant),
    .dis_i1_en(s367),
    .dis_i1_addr(s368),
    .dis_i1_len(s369),
    .dis_i1_fu(dis_i1_fu),
    .cmt_i0_grant(cmt_i0_grant),
    .cmt_i0_kill(cmt_i0_kill),
    .cmt_i0_age(cmt_i0_age),
    .cmt_i1_grant(cmt_i1_grant),
    .cmt_i1_kill(cmt_i1_kill),
    .cmt_i1_age(cmt_i1_age),
    .ret_age_en(ret_age_en),
    .ent_valid_clr(ent_valid_clr),
    .ent_valid(ent_valid),
    .ent_pending(s212),
    .ent_addr(s213),
    .ent_len(s214),
    .ent_fu(ent_fu),
    .ent_committed(ent_committed),
    .ent_age_mask(ent_age_mask),
    .w_grant(s216),
    .w_age(w1_age),
    .w_age_mask(w1_age_mask),
    .w_addr(vrf_w1_addr),
    .w_last(vrf_w1_last),
    .w_fu(vrf_w1_fu),
    .w_committed(s217),
    .w_pending(w1_pending)
);
wire s370;
wire [VRF_AW - 1:0] s371;
wire [VRF_LW - 1:0] s372;
wire s373;
wire [VRF_AW - 1:0] s374;
wire [VRF_LW - 1:0] s375;
assign s370 = dis_i0_vd_en & s27[2];
assign s371 = dis_i0_vd_addr;
assign s372 = dis_i0_vd_len;
assign s373 = dis_i1_vd_en & s31[2];
assign s374 = dis_i1_vd_addr;
assign s375 = dis_i1_vd_len;
kv_vrf_wport #(
    .AGEN(AGEN),
    .VRF_AW(VRF_AW),
    .VRF_LW(VRF_LW)
) u_w2_port (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .dis_age(dis_age),
    .dis_i0_grant(dis_i0_grant),
    .dis_i0_en(s370),
    .dis_i0_addr(s371),
    .dis_i0_len(s372),
    .dis_i0_fu(dis_i0_fu),
    .dis_i1_grant(dis_i1_grant),
    .dis_i1_en(s373),
    .dis_i1_addr(s374),
    .dis_i1_len(s375),
    .dis_i1_fu(dis_i1_fu),
    .cmt_i0_grant(cmt_i0_grant),
    .cmt_i0_kill(cmt_i0_kill),
    .cmt_i0_age(cmt_i0_age),
    .cmt_i1_grant(cmt_i1_grant),
    .cmt_i1_kill(cmt_i1_kill),
    .cmt_i1_age(cmt_i1_age),
    .ret_age_en(ret_age_en),
    .ent_valid_clr(ent_valid_clr),
    .ent_valid(ent_valid),
    .ent_pending(s228),
    .ent_addr(s229),
    .ent_len(s230),
    .ent_fu(ent_fu),
    .ent_committed(ent_committed),
    .ent_age_mask(ent_age_mask),
    .w_grant(s232),
    .w_age(w2_age),
    .w_age_mask(w2_age_mask),
    .w_addr(vrf_w2_addr),
    .w_last(vrf_w2_last),
    .w_fu(vrf_w2_fu),
    .w_committed(s233),
    .w_pending(w2_pending)
);
wire s376;
wire [VRF_AW - 1:0] s377;
wire [VRF_LW - 1:0] s378;
wire s379;
wire [VRF_AW - 1:0] s380;
wire [VRF_LW - 1:0] s381;
assign s376 = dis_i0_vd_en & s27[3];
assign s377 = dis_i0_vd_addr;
assign s378 = dis_i0_vd_len;
assign s379 = dis_i1_vd_en & s31[3];
assign s380 = dis_i1_vd_addr;
assign s381 = dis_i1_vd_len;
kv_vrf_wport #(
    .AGEN(AGEN),
    .VRF_AW(VRF_AW),
    .VRF_LW(VRF_LW)
) u_w3_port (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .dis_age(dis_age),
    .dis_i0_grant(dis_i0_grant),
    .dis_i0_en(s376),
    .dis_i0_addr(s377),
    .dis_i0_len(s378),
    .dis_i0_fu(dis_i0_fu),
    .dis_i1_grant(dis_i1_grant),
    .dis_i1_en(s379),
    .dis_i1_addr(s380),
    .dis_i1_len(s381),
    .dis_i1_fu(dis_i1_fu),
    .cmt_i0_grant(cmt_i0_grant),
    .cmt_i0_kill(cmt_i0_kill),
    .cmt_i0_age(cmt_i0_age),
    .cmt_i1_grant(cmt_i1_grant),
    .cmt_i1_kill(cmt_i1_kill),
    .cmt_i1_age(cmt_i1_age),
    .ret_age_en(ret_age_en),
    .ent_valid_clr(ent_valid_clr),
    .ent_valid(ent_valid),
    .ent_pending(s244),
    .ent_addr(s245),
    .ent_len(s246),
    .ent_fu(ent_fu),
    .ent_committed(ent_committed),
    .ent_age_mask(ent_age_mask),
    .w_grant(s248),
    .w_age(w3_age),
    .w_age_mask(w3_age_mask),
    .w_addr(vrf_w3_addr),
    .w_last(vrf_w3_last),
    .w_fu(vrf_w3_fu),
    .w_committed(s249),
    .w_pending(w3_pending)
);
wire s382;
wire [VRF_AW - 1:0] s383;
wire [VRF_LW - 1:0] s384;
wire s385;
wire [VRF_AW - 1:0] s386;
wire [VRF_LW - 1:0] s387;
assign s382 = dis_i0_vd_en & s27[4];
assign s383 = dis_i0_vd_addr;
assign s384 = dis_i0_vd_len;
assign s385 = dis_i1_vd_en & s31[4];
assign s386 = dis_i1_vd_addr;
assign s387 = dis_i1_vd_len;
kv_vrf_wport #(
    .AGEN(AGEN),
    .VRF_AW(VRF_AW),
    .VRF_LW(VRF_LW)
) u_w4_port (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .dis_age(dis_age),
    .dis_i0_grant(dis_i0_grant),
    .dis_i0_en(s382),
    .dis_i0_addr(s383),
    .dis_i0_len(s384),
    .dis_i0_fu(dis_i0_fu),
    .dis_i1_grant(dis_i1_grant),
    .dis_i1_en(s385),
    .dis_i1_addr(s386),
    .dis_i1_len(s387),
    .dis_i1_fu(dis_i1_fu),
    .cmt_i0_grant(cmt_i0_grant),
    .cmt_i0_kill(cmt_i0_kill),
    .cmt_i0_age(cmt_i0_age),
    .cmt_i1_grant(cmt_i1_grant),
    .cmt_i1_kill(cmt_i1_kill),
    .cmt_i1_age(cmt_i1_age),
    .ret_age_en(ret_age_en),
    .ent_valid_clr(ent_valid_clr),
    .ent_valid(ent_valid),
    .ent_pending(s260),
    .ent_addr(s261),
    .ent_len(s262),
    .ent_fu(ent_fu),
    .ent_committed(ent_committed),
    .ent_age_mask(ent_age_mask),
    .w_grant(s264),
    .w_age(w4_age),
    .w_age_mask(w4_age_mask),
    .w_addr(vrf_w4_addr),
    .w_last(vrf_w4_last),
    .w_fu(vrf_w4_fu),
    .w_committed(s265),
    .w_pending(w4_pending)
);
generate
    if (VMAC2_TYPE != 0) begin:gen_vmac2_wport
        wire s388;
        wire [VRF_AW - 1:0] s389;
        wire [VRF_LW - 1:0] s390;
        wire s391;
        wire [VRF_AW - 1:0] s392;
        wire [VRF_LW - 1:0] s393;
        assign s388 = dis_i0_vd_en & s27[5];
        assign s389 = dis_i0_vd_addr;
        assign s390 = dis_i0_vd_len;
        assign s391 = dis_i1_vd_en & s31[5];
        assign s392 = dis_i1_vd_addr;
        assign s393 = dis_i1_vd_len;
        kv_vrf_wport #(
            .AGEN(AGEN),
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w5_port (
            .vpu_clk(vpu_clk),
            .vpu_reset_n(vpu_reset_n),
            .dis_age(dis_age),
            .dis_i0_grant(dis_i0_grant),
            .dis_i0_en(s388),
            .dis_i0_addr(s389),
            .dis_i0_len(s390),
            .dis_i0_fu(dis_i0_fu),
            .dis_i1_grant(dis_i1_grant),
            .dis_i1_en(s391),
            .dis_i1_addr(s392),
            .dis_i1_len(s393),
            .dis_i1_fu(dis_i1_fu),
            .cmt_i0_grant(cmt_i0_grant),
            .cmt_i0_kill(cmt_i0_kill),
            .cmt_i0_age(cmt_i0_age),
            .cmt_i1_grant(cmt_i1_grant),
            .cmt_i1_kill(cmt_i1_kill),
            .cmt_i1_age(cmt_i1_age),
            .ret_age_en(ret_age_en),
            .ent_valid_clr(ent_valid_clr),
            .ent_valid(ent_valid),
            .ent_pending(s276),
            .ent_addr(s277),
            .ent_len(s278),
            .ent_fu(ent_fu),
            .ent_committed(ent_committed),
            .ent_age_mask(ent_age_mask),
            .w_grant(s282),
            .w_age(s281),
            .w_age_mask(s288),
            .w_addr(vrf_w5_addr),
            .w_last(vrf_w5_last),
            .w_fu(vrf_w5_fu),
            .w_committed(s283),
            .w_pending(s279)
        );
    end
    else begin:gen_vmac2_wport_stub
        assign s281 = {AGEN{1'b0}};
        assign s288 = {AGEN{1'b0}};
        assign vrf_w5_addr = {VRF_AW{1'b0}};
        assign vrf_w5_last = 1'b0;
        assign vrf_w5_fu = {11{1'b0}};
        assign s279 = 1'b0;
        assign s283 = 1'b0;
    end
endgenerate
always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ent_committed <= {AGEN{1'b0}};
    end
    else if (s50) begin
        ent_committed <= s53;
    end
end

assign s50 = dis_i0_grant | dis_i1_grant | cmt_i0_grant | cmt_i1_grant;
assign s52 = ({AGEN{dis_i0_grant}} & s4) | ({AGEN{dis_i1_grant}} & s5);
assign s51 = ({AGEN{cmt_i0_grant}} & cmt_i0_age) | ({AGEN{cmt_i1_grant}} & cmt_i1_age);
assign s53 = s51 | (ent_committed & ~s52);
generate
    genvar i;
    for (i = 0; i < AGEN; i = i + 1) begin:gen_ent
        wire s394;
        wire s395;
        wire s396;
        wire s397;
        wire s398;
        wire s399;
        wire s400;
        wire s401;
        wire s402;
        wire s403;
        wire s404;
        wire s405;
        wire s406;
        wire s407;
        wire s408;
        wire s409;
        wire s410;
        wire s411;
        wire s412;
        wire s413;
        wire s414;
        reg s415;
        wire s416;
        wire s417;
        wire s418;
        wire s419;
        reg [AGEN - 1:0] s420;
        wire [AGEN - 1:0] s421;
        wire [AGEN - 1:0] s422;
        wire [AGEN - 1:0] s423;
        wire s424;
        reg [11 - 1:0] fu;
        wire [11 - 1:0] s425;
        wire [VRF_AW - 1:0] s426;
        wire [VRF_AW - 1:0] s427;
        wire [VRF_AW - 1:0] s428;
        wire [VRF_AW - 1:0] s429;
        wire [VRF_LW - 1:0] s430;
        wire [VRF_LW - 1:0] s431;
        wire [VRF_LW - 1:0] s432;
        wire [VRF_LW - 1:0] s433;
        wire [11 - 1:0] vs1_port;
        wire [11 - 1:0] vs2_port;
        wire [11 - 1:0] vs3_port;
        wire [6 - 1:0] vd_port;
        wire s434;
        wire s435;
        wire s436;
        wire s437;
        wire s438;
        wire s439;
        wire s440;
        wire s441;
        kv_vscb_portmap #(
            .ACE_SP_WRITE_PORT(ACE_SP_WRITE_PORT)
        ) u_port (
            .fu(fu),
            .vs1_port(vs1_port),
            .vs2_port(vs2_port),
            .vs3_port(vs3_port),
            .vd_port(vd_port)
        );
        always @(posedge vpu_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s415 <= 1'b0;
            end
            else if (s417) begin
                s415 <= s416;
            end
        end

        always @(posedge vpu_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                fu <= {11{1'b0}};
            end
            else if (s418) begin
                fu <= s425;
            end
        end

        always @(posedge vpu_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s420 <= {AGEN{1'b0}};
            end
            else if (s424) begin
                s420 <= s421;
            end
        end

        kv_vscb_vx #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_vs1 (
            .vpu_clk(vpu_clk),
            .vpu_reset_n(vpu_reset_n),
            .dis_i0_grant(s394),
            .dis_i0_vx_en(dis_i0_vs1_en),
            .dis_i0_vx_addr(dis_i0_vs1_addr),
            .dis_i0_vx_len(dis_i0_vs1_len),
            .dis_i1_grant(s395),
            .dis_i1_vx_en(dis_i1_vs1_en),
            .dis_i1_vx_addr(dis_i1_vs1_addr),
            .dis_i1_vx_len(dis_i1_vs1_len),
            .cmt_i0_grant(s396),
            .cmt_i0_kill(cmt_i0_kill),
            .cmt_i1_grant(s397),
            .cmt_i1_kill(cmt_i1_kill),
            .vrf_grant(s438),
            .pending(s434),
            .addr(s426),
            .len(s430)
        );
        kv_vscb_vx #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_vs2 (
            .vpu_clk(vpu_clk),
            .vpu_reset_n(vpu_reset_n),
            .dis_i0_grant(s394),
            .dis_i0_vx_en(dis_i0_vs2_en),
            .dis_i0_vx_addr(dis_i0_vs2_addr),
            .dis_i0_vx_len(dis_i0_vs2_len),
            .dis_i1_grant(s395),
            .dis_i1_vx_en(dis_i1_vs2_en),
            .dis_i1_vx_addr(dis_i1_vs2_addr),
            .dis_i1_vx_len(dis_i1_vs2_len),
            .cmt_i0_grant(s396),
            .cmt_i0_kill(cmt_i0_kill),
            .cmt_i1_grant(s397),
            .cmt_i1_kill(cmt_i1_kill),
            .vrf_grant(s439),
            .pending(s435),
            .addr(s427),
            .len(s431)
        );
        kv_vscb_vx #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_vs3 (
            .vpu_clk(vpu_clk),
            .vpu_reset_n(vpu_reset_n),
            .dis_i0_grant(s394),
            .dis_i0_vx_en(dis_i0_vs3_en),
            .dis_i0_vx_addr(dis_i0_vs3_addr),
            .dis_i0_vx_len(dis_i0_vs3_len),
            .dis_i1_grant(s395),
            .dis_i1_vx_en(dis_i1_vs3_en),
            .dis_i1_vx_addr(dis_i1_vs3_addr),
            .dis_i1_vx_len(dis_i1_vs3_len),
            .cmt_i0_grant(s396),
            .cmt_i0_kill(cmt_i0_kill),
            .cmt_i1_grant(s397),
            .cmt_i1_kill(cmt_i1_kill),
            .vrf_grant(s440),
            .pending(s436),
            .addr(s428),
            .len(s432)
        );
        kv_vscb_vx #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_vd (
            .vpu_clk(vpu_clk),
            .vpu_reset_n(vpu_reset_n),
            .dis_i0_grant(s394),
            .dis_i0_vx_en(dis_i0_vd_en),
            .dis_i0_vx_addr(dis_i0_vd_addr),
            .dis_i0_vx_len(dis_i0_vd_len),
            .dis_i1_grant(s395),
            .dis_i1_vx_en(dis_i1_vd_en),
            .dis_i1_vx_addr(dis_i1_vd_addr),
            .dis_i1_vx_len(dis_i1_vd_len),
            .cmt_i0_grant(s396),
            .cmt_i0_kill(cmt_i0_kill),
            .cmt_i1_grant(s397),
            .cmt_i1_kill(cmt_i1_kill),
            .vrf_grant(s441),
            .pending(s437),
            .addr(s429),
            .len(s433)
        );
        assign s394 = dis_i0_grant & s4[i];
        assign s395 = dis_i1_grant & s5[i];
        assign s396 = cmt_i0_grant & cmt_i0_age[i];
        assign s397 = cmt_i1_grant & cmt_i1_age[i];
        assign s398 = s90 & s88[i];
        assign s399 = s101 & s99[i];
        assign s400 = s112 & s110[i];
        assign s401 = s123 & s121[i];
        assign s402 = s134 & s132[i];
        assign s403 = s145 & s143[i];
        assign s404 = s156 & s154[i];
        assign s405 = s167 & s165[i];
        assign s406 = s178 & s176[i];
        assign s407 = s185 & s183[i];
        assign s408 = s192 & s190[i];
        assign s409 = s200 & w0_age[i];
        assign s410 = s216 & w1_age[i];
        assign s411 = s232 & w2_age[i];
        assign s412 = s248 & w3_age[i];
        assign s413 = s264 & w4_age[i];
        assign s414 = s282 & s281[i];
        assign s417 = s418 | s419;
        assign s418 = s394 | s395;
        assign s419 = s35[i] & s291[i];
        assign s416 = s418 | (s415 & ~s419);
        assign s424 = s418 | ret_age_en;
        assign s422 = ({AGEN{s418}} & ent_valid) | ({AGEN{s395}} & s4);
        assign s423 = ent_valid_clr;
        assign s421 = ~s423 & (s420 | s422);
        assign s425 = s4[i] ? dis_i0_fu : dis_i1_fu;
        assign s438 = (s398 & vs1_port[0]) | (s399 & vs1_port[1]) | (s400 & vs1_port[2]) | (s401 & vs1_port[3]) | (s402 & vs1_port[4]) | (s403 & vs1_port[5]) | (s404 & vs1_port[6]) | (s405 & vs1_port[7]) | (s406 & vs1_port[8]) | (s407 & vs1_port[9]) | (s408 & vs1_port[10]);
        assign s439 = (s398 & vs2_port[0]) | (s399 & vs2_port[1]) | (s400 & vs2_port[2]) | (s401 & vs2_port[3]) | (s402 & vs2_port[4]) | (s403 & vs2_port[5]) | (s404 & vs2_port[6]) | (s405 & vs2_port[7]) | (s406 & vs2_port[8]) | (s407 & vs2_port[9]) | (s408 & vs2_port[10]);
        assign s440 = (s398 & vs3_port[0]) | (s399 & vs3_port[1]) | (s400 & vs3_port[2]) | (s401 & vs3_port[3]) | (s402 & vs3_port[4]) | (s403 & vs3_port[5]) | (s404 & vs3_port[6]) | (s405 & vs3_port[7]) | (s406 & vs3_port[8]) | (s407 & vs3_port[9]) | (s408 & vs3_port[10]);
        assign s441 = s409 | s410 | s411 | s412 | s413 | s414;
        assign ent_age_mask[i * AGEN +:AGEN] = s420;
        assign ent_valid[i] = s415;
        assign ent_valid_clr[i] = s419;
        assign s36[i] = s415 & s437 & (s429[VRF_AW - 1:VRF_AW - 5] == 5'd0);
        assign s48[VRF_AW * i +:VRF_AW] = s429;
        assign s49[VRF_LW * i +:VRF_LW] = s433;
        assign ent_fu[11 * i +:11] = fu;
        assign s37[i] = fu[1];
        assign s38[i] = fu[0];
        assign s39[i] = fu[5];
        assign s40[i] = fu[3];
        assign s41[i] = fu[10];
        assign s42[i] = fu[8];
        assign s43[i] = fu[6];
        assign s44[i] = fu[7];
        assign s45[i] = fu[4];
        assign s46[i] = fu[9];
        assign s47[i] = fu[2];
        assign s35[i] = s415 & ~|{s434,s435,s436,s437} & ent_committed[i];
        assign s54[i] = (s434 & vs1_port[0]) | (s435 & vs2_port[0]) | (s436 & vs3_port[0]);
        assign s57[i] = (s434 & vs1_port[1]) | (s435 & vs2_port[1]) | (s436 & vs3_port[1]);
        assign s60[i] = (s434 & vs1_port[2]) | (s435 & vs2_port[2]) | (s436 & vs3_port[2]);
        assign s63[i] = (s434 & vs1_port[3]) | (s435 & vs2_port[3]) | (s436 & vs3_port[3]);
        assign s66[i] = (s434 & vs1_port[4]) | (s435 & vs2_port[4]) | (s436 & vs3_port[4]);
        assign s69[i] = (s434 & vs1_port[5]) | (s435 & vs2_port[5]) | (s436 & vs3_port[5]);
        assign s72[i] = (s434 & vs1_port[6]) | (s435 & vs2_port[6]) | (s436 & vs3_port[6]);
        assign s75[i] = (s434 & vs1_port[7]) | (s435 & vs2_port[7]) | (s436 & vs3_port[7]);
        assign s78[i] = (s434 & vs1_port[8]) | (s435 & vs2_port[8]) | (s436 & vs3_port[8]);
        assign s81[i] = (s434 & vs1_port[9]) | (s435 & vs2_port[9]) | (s436 & vs3_port[9]);
        assign s84[i] = (s434 & vs1_port[10]) | (s435 & vs2_port[10]) | (s436 & vs3_port[10]);
        assign s55[i * VRF_AW +:VRF_AW] = (s426 & {VRF_AW{vs1_port[0]}}) | (s427 & {VRF_AW{vs2_port[0]}}) | (s428 & {VRF_AW{vs3_port[0]}});
        assign s58[i * VRF_AW +:VRF_AW] = (s426 & {VRF_AW{vs1_port[1]}}) | (s427 & {VRF_AW{vs2_port[1]}}) | (s428 & {VRF_AW{vs3_port[1]}});
        assign s61[i * VRF_AW +:VRF_AW] = (s426 & {VRF_AW{vs1_port[2]}}) | (s427 & {VRF_AW{vs2_port[2]}}) | (s428 & {VRF_AW{vs3_port[2]}});
        assign s64[i * VRF_AW +:VRF_AW] = (s426 & {VRF_AW{vs1_port[3]}}) | (s427 & {VRF_AW{vs2_port[3]}}) | (s428 & {VRF_AW{vs3_port[3]}});
        assign s67[i * VRF_AW +:VRF_AW] = (s426 & {VRF_AW{vs1_port[4]}}) | (s427 & {VRF_AW{vs2_port[4]}}) | (s428 & {VRF_AW{vs3_port[4]}});
        assign s70[i * VRF_AW +:VRF_AW] = (s426 & {VRF_AW{vs1_port[5]}}) | (s427 & {VRF_AW{vs2_port[5]}}) | (s428 & {VRF_AW{vs3_port[5]}});
        assign s73[i * VRF_AW +:VRF_AW] = (s426 & {VRF_AW{vs1_port[6]}}) | (s427 & {VRF_AW{vs2_port[6]}}) | (s428 & {VRF_AW{vs3_port[6]}});
        assign s76[i * VRF_AW +:VRF_AW] = (s426 & {VRF_AW{vs1_port[7]}}) | (s427 & {VRF_AW{vs2_port[7]}}) | (s428 & {VRF_AW{vs3_port[7]}});
        assign s79[i * VRF_AW +:VRF_AW] = (s426 & {VRF_AW{vs1_port[8]}}) | (s427 & {VRF_AW{vs2_port[8]}}) | (s428 & {VRF_AW{vs3_port[8]}});
        assign s82[i * VRF_AW +:VRF_AW] = (s426 & {VRF_AW{vs1_port[9]}}) | (s427 & {VRF_AW{vs2_port[9]}}) | (s428 & {VRF_AW{vs3_port[9]}});
        assign s85[i * VRF_AW +:VRF_AW] = (s426 & {VRF_AW{vs1_port[10]}}) | (s427 & {VRF_AW{vs2_port[10]}}) | (s428 & {VRF_AW{vs3_port[10]}});
        assign s56[i * VRF_LW +:VRF_LW] = (s430 & {VRF_LW{vs1_port[0]}}) | (s431 & {VRF_LW{vs2_port[0]}}) | (s432 & {VRF_LW{vs3_port[0]}});
        assign s59[i * VRF_LW +:VRF_LW] = (s430 & {VRF_LW{vs1_port[1]}}) | (s431 & {VRF_LW{vs2_port[1]}}) | (s432 & {VRF_LW{vs3_port[1]}});
        assign s62[i * VRF_LW +:VRF_LW] = (s430 & {VRF_LW{vs1_port[2]}}) | (s431 & {VRF_LW{vs2_port[2]}}) | (s432 & {VRF_LW{vs3_port[2]}});
        assign s65[i * VRF_LW +:VRF_LW] = (s430 & {VRF_LW{vs1_port[3]}}) | (s431 & {VRF_LW{vs2_port[3]}}) | (s432 & {VRF_LW{vs3_port[3]}});
        assign s68[i * VRF_LW +:VRF_LW] = (s430 & {VRF_LW{vs1_port[4]}}) | (s431 & {VRF_LW{vs2_port[4]}}) | (s432 & {VRF_LW{vs3_port[4]}});
        assign s71[i * VRF_LW +:VRF_LW] = (s430 & {VRF_LW{vs1_port[5]}}) | (s431 & {VRF_LW{vs2_port[5]}}) | (s432 & {VRF_LW{vs3_port[5]}});
        assign s74[i * VRF_LW +:VRF_LW] = (s430 & {VRF_LW{vs1_port[6]}}) | (s431 & {VRF_LW{vs2_port[6]}}) | (s432 & {VRF_LW{vs3_port[6]}});
        assign s77[i * VRF_LW +:VRF_LW] = (s430 & {VRF_LW{vs1_port[7]}}) | (s431 & {VRF_LW{vs2_port[7]}}) | (s432 & {VRF_LW{vs3_port[7]}});
        assign s80[i * VRF_LW +:VRF_LW] = (s430 & {VRF_LW{vs1_port[8]}}) | (s431 & {VRF_LW{vs2_port[8]}}) | (s432 & {VRF_LW{vs3_port[8]}});
        assign s83[i * VRF_LW +:VRF_LW] = (s430 & {VRF_LW{vs1_port[9]}}) | (s431 & {VRF_LW{vs2_port[9]}}) | (s432 & {VRF_LW{vs3_port[9]}});
        assign s86[i * VRF_LW +:VRF_LW] = (s430 & {VRF_LW{vs1_port[10]}}) | (s431 & {VRF_LW{vs2_port[10]}}) | (s432 & {VRF_LW{vs3_port[10]}});
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_r0_vd_pending (
            .addr(s89),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s92[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_r1_vd_pending (
            .addr(s100),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s103[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_r2_vd_pending (
            .addr(s111),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s114[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_r3_vd_pending (
            .addr(s122),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s125[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_r4_vd_pending (
            .addr(s133),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s136[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_r5_vd_pending (
            .addr(s144),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s147[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_r6_vd_pending (
            .addr(s155),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s158[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_r7_vd_pending (
            .addr(s166),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s169[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_r8_vd_pending (
            .addr(s177),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s180[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_r9_vd_pending (
            .addr(s184),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s187[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_r10_vd_pending (
            .addr(s191),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s194[i])
        );
        assign s196[i] = s437 & vd_port[0];
        assign s212[i] = s437 & vd_port[1];
        assign s228[i] = s437 & vd_port[2];
        assign s244[i] = s437 & vd_port[3];
        assign s260[i] = s437 & vd_port[4];
        assign s276[i] = s437 & vd_port[5];
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w0_vd_pending (
            .addr(vrf_w0_addr),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s202[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w1_vd_pending (
            .addr(vrf_w1_addr),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s218[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w2_vd_pending (
            .addr(vrf_w2_addr),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s234[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w3_vd_pending (
            .addr(vrf_w3_addr),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s250[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w4_vd_pending (
            .addr(vrf_w4_addr),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s266[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w5_vd_pending (
            .addr(vrf_w5_addr),
            .vx_pending(s437),
            .vx_addr(s429),
            .vx_len(s433),
            .hit(s284[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w0_vs1_pending (
            .addr(vrf_w0_addr),
            .vx_pending(s434),
            .vx_addr(s426),
            .vx_len(s430),
            .hit(s203[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w0_vs2_pending (
            .addr(vrf_w0_addr),
            .vx_pending(s435),
            .vx_addr(s427),
            .vx_len(s431),
            .hit(s204[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w0_vs3_pending (
            .addr(vrf_w0_addr),
            .vx_pending(s436),
            .vx_addr(s428),
            .vx_len(s432),
            .hit(s205[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w1_vs1_pending (
            .addr(vrf_w1_addr),
            .vx_pending(s434),
            .vx_addr(s426),
            .vx_len(s430),
            .hit(s219[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w1_vs2_pending (
            .addr(vrf_w1_addr),
            .vx_pending(s435),
            .vx_addr(s427),
            .vx_len(s431),
            .hit(s220[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w1_vs3_pending (
            .addr(vrf_w1_addr),
            .vx_pending(s436),
            .vx_addr(s428),
            .vx_len(s432),
            .hit(s221[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w2_vs1_pending (
            .addr(vrf_w2_addr),
            .vx_pending(s434),
            .vx_addr(s426),
            .vx_len(s430),
            .hit(s235[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w2_vs2_pending (
            .addr(vrf_w2_addr),
            .vx_pending(s435),
            .vx_addr(s427),
            .vx_len(s431),
            .hit(s236[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w2_vs3_pending (
            .addr(vrf_w2_addr),
            .vx_pending(s436),
            .vx_addr(s428),
            .vx_len(s432),
            .hit(s237[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w3_vs1_pending (
            .addr(vrf_w3_addr),
            .vx_pending(s434),
            .vx_addr(s426),
            .vx_len(s430),
            .hit(s251[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w3_vs2_pending (
            .addr(vrf_w3_addr),
            .vx_pending(s435),
            .vx_addr(s427),
            .vx_len(s431),
            .hit(s252[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w3_vs3_pending (
            .addr(vrf_w3_addr),
            .vx_pending(s436),
            .vx_addr(s428),
            .vx_len(s432),
            .hit(s253[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w4_vs1_pending (
            .addr(vrf_w4_addr),
            .vx_pending(s434),
            .vx_addr(s426),
            .vx_len(s430),
            .hit(s267[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w4_vs2_pending (
            .addr(vrf_w4_addr),
            .vx_pending(s435),
            .vx_addr(s427),
            .vx_len(s431),
            .hit(s268[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w4_vs3_pending (
            .addr(vrf_w4_addr),
            .vx_pending(s436),
            .vx_addr(s428),
            .vx_len(s432),
            .hit(s269[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w5_vs1_pending (
            .addr(vrf_w5_addr),
            .vx_pending(s434),
            .vx_addr(s426),
            .vx_len(s430),
            .hit(s285[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w5_vs2_pending (
            .addr(vrf_w5_addr),
            .vx_pending(s435),
            .vx_addr(s427),
            .vx_len(s431),
            .hit(s286[i])
        );
        kv_vscb_vx_cmp #(
            .VRF_AW(VRF_AW),
            .VRF_LW(VRF_LW)
        ) u_w5_vs3_pending (
            .addr(vrf_w5_addr),
            .vx_pending(s436),
            .vx_addr(s428),
            .vx_len(s432),
            .hit(s287[i])
        );
    end
endgenerate
assign vscb_busy = ent_valid;
assign vscb_v0t_write_pending = |s36;
assign vrf_w0_en = s200;
assign vrf_w1_en = s216;
assign vrf_w2_en = s232;
assign vrf_w3_en = s248;
assign vrf_w4_en = s264;
assign vrf_w0_ready = ~s208 & ~s199;
assign vrf_w1_ready = ~s224 & ~s215;
assign vrf_w2_ready = ~s240 & ~s231;
assign vrf_w3_ready = ~s256 & ~s247;
assign vrf_w4_ready = ~s272 & ~s263;
assign s210 = |s206;
assign s226 = |s222;
assign s242 = |s238;
assign s258 = |s254;
assign s274 = |s270;
assign s208 = (s209 | s210 | ~s201);
assign s224 = (s225 | s226 | ~s217);
assign s240 = (s241 | s242 | ~s233);
assign s256 = (s257 | s258 | ~s249);
assign s272 = (s273 | s274 | ~s265);
assign s211 = w0_age_mask | w0_age;
assign s227 = w1_age_mask | w1_age;
assign s243 = w2_age_mask | w2_age;
assign s259 = w3_age_mask | w3_age;
assign s275 = w4_age_mask | w4_age;
assign s209 = |s207;
assign s225 = |s223;
assign s241 = |s239;
assign s257 = |s255;
assign s273 = |s271;
assign s206 = (w0_age_mask & s202);
assign s222 = (w1_age_mask & s218);
assign s238 = (w2_age_mask & s234);
assign s254 = (w3_age_mask & s250);
assign s270 = (w4_age_mask & s266);
assign s207 = (s211 & s203) | (s211 & s204) | (s211 & s205);
assign s223 = (s227 & s219) | (s227 & s220) | (s227 & s221);
assign s239 = (s243 & s235) | (s243 & s236) | (s243 & s237);
assign s255 = (s259 & s251) | (s259 & s252) | (s259 & s253);
assign s271 = (s275 & s267) | (s275 & s268) | (s275 & s269);
generate
    if (VMAC2_TYPE != 0) begin:gen_w5_hazard
        wire [AGEN - 1:0] s442;
        wire [AGEN - 1:0] s443;
        wire [AGEN - 1:0] s444;
        wire s445 = |s444;
        wire s446 = |s443;
        wire s447 = (s446 | s445 | ~s283);
        assign vrf_w5_en = s282;
        assign vrf_w5_ready = ~s447 & ~s280;
        assign s442 = (s288 | s281);
        assign s444 = (s288 & s284);
        assign s443 = (s442 & s285) | (s442 & s286) | (s442 & s287);
    end
    else begin:gen_w5_hazard_stub
        assign vrf_w5_en = 1'b0;
        assign vrf_w5_ready = 1'b0;
    end
endgenerate
assign s90 = s94 & vrf_r0_ready;
assign s101 = s105 & vrf_r1_ready;
assign s112 = s116 & vrf_r2_ready;
assign s123 = s127 & vrf_r3_ready;
assign s134 = s138 & vrf_r4_ready;
assign s145 = s149 & vrf_r5_ready;
assign s156 = s160 & vrf_r6_ready;
assign s167 = s171 & vrf_r7_ready;
assign vrf_r0_valid = s87 & ~s95 & ~s91;
assign vrf_r1_valid = s98 & ~s106 & ~s102;
assign vrf_r2_valid = s109 & ~s117 & ~s113;
assign vrf_r3_valid = s120 & ~s128 & ~s124;
assign vrf_r4_valid = s131 & ~s139 & ~s135;
assign vrf_r5_valid = s142 & ~s150 & ~s146;
assign vrf_r6_valid = s153 & ~s161 & ~s157;
assign vrf_r7_valid = s164 & ~s172 & ~s168;
assign s94 = vrf_r0_valid | (vrf_r0_bypass_sel[0] & s200 & vrf_r0_bypass_en) | (vrf_r0_bypass_sel[1] & s216 & vrf_r0_bypass_en) | (vrf_r0_bypass_sel[2] & s232 & vrf_r0_bypass_en) | (vrf_r0_bypass_sel[3] & s248 & vrf_r0_bypass_en);
assign s105 = vrf_r1_valid | (vrf_r1_bypass_sel[0] & s200 & vrf_r1_bypass_en) | (vrf_r1_bypass_sel[1] & s216 & vrf_r1_bypass_en) | (vrf_r1_bypass_sel[2] & s232 & vrf_r1_bypass_en) | (vrf_r1_bypass_sel[3] & s248 & vrf_r1_bypass_en);
assign s116 = vrf_r2_valid | (vrf_r2_bypass_sel[0] & s200 & vrf_r2_bypass_en) | (vrf_r2_bypass_sel[1] & s216 & vrf_r2_bypass_en) | (vrf_r2_bypass_sel[2] & s232 & vrf_r2_bypass_en) | (vrf_r2_bypass_sel[3] & s248 & vrf_r2_bypass_en);
assign s127 = vrf_r3_valid | (vrf_r3_bypass_sel[0] & s200 & vrf_r3_bypass_en) | (vrf_r3_bypass_sel[1] & s216 & vrf_r3_bypass_en) | (vrf_r3_bypass_sel[2] & s232 & vrf_r3_bypass_en) | (vrf_r3_bypass_sel[3] & s248 & vrf_r3_bypass_en);
assign s138 = vrf_r4_valid | (vrf_r4_bypass_sel[0] & s200 & vrf_r4_bypass_en) | (vrf_r4_bypass_sel[1] & s216 & vrf_r4_bypass_en) | (vrf_r4_bypass_sel[2] & s232 & vrf_r4_bypass_en) | (vrf_r4_bypass_sel[3] & s248 & vrf_r4_bypass_en);
assign s149 = vrf_r5_valid | (vrf_r5_bypass_sel[0] & s200 & vrf_r5_bypass_en) | (vrf_r5_bypass_sel[1] & s216 & vrf_r5_bypass_en) | (vrf_r5_bypass_sel[2] & s232 & vrf_r5_bypass_en) | (vrf_r5_bypass_sel[3] & s248 & vrf_r5_bypass_en);
assign s160 = vrf_r6_valid | (vrf_r6_bypass_sel[0] & s200 & vrf_r6_bypass_en) | (vrf_r6_bypass_sel[1] & s216 & vrf_r6_bypass_en) | (vrf_r6_bypass_sel[2] & s232 & vrf_r6_bypass_en) | (vrf_r6_bypass_sel[3] & s248 & vrf_r6_bypass_en);
assign s171 = vrf_r7_valid | (vrf_r7_bypass_sel[0] & s200 & vrf_r7_bypass_en) | (vrf_r7_bypass_sel[1] & s216 & vrf_r7_bypass_en) | (vrf_r7_bypass_sel[2] & s232 & vrf_r7_bypass_en) | (vrf_r7_bypass_sel[3] & s248 & vrf_r7_bypass_en);
assign s97 = s93 & s92;
assign s108 = s104 & s103;
assign s119 = s115 & s114;
assign s130 = s126 & s125;
assign s141 = s137 & s136;
assign s152 = s148 & s147;
assign s163 = s159 & s158;
assign s174 = s170 & s169;
kv_onehot #(
    .W(AGEN)
) u_r0_raw_hazard_onehot (
    .out(s96),
    .in(s97)
);
kv_onehot #(
    .W(AGEN)
) u_r1_raw_hazard_onehot (
    .out(s107),
    .in(s108)
);
kv_onehot #(
    .W(AGEN)
) u_r2_raw_hazard_onehot (
    .out(s118),
    .in(s119)
);
kv_onehot #(
    .W(AGEN)
) u_r3_raw_hazard_onehot (
    .out(s129),
    .in(s130)
);
kv_onehot #(
    .W(AGEN)
) u_r4_raw_hazard_onehot (
    .out(s140),
    .in(s141)
);
kv_onehot #(
    .W(AGEN)
) u_r5_raw_hazard_onehot (
    .out(s151),
    .in(s152)
);
kv_onehot #(
    .W(AGEN)
) u_r6_raw_hazard_onehot (
    .out(s162),
    .in(s163)
);
kv_onehot #(
    .W(AGEN)
) u_r7_raw_hazard_onehot (
    .out(s173),
    .in(s174)
);
assign vrf_r0_bypass_en = s87 & s96;
assign vrf_r1_bypass_en = s98 & s107;
assign vrf_r2_bypass_en = s109 & s118;
assign vrf_r3_bypass_en = s120 & s129;
assign vrf_r4_bypass_en = s131 & s140;
assign vrf_r5_bypass_en = s142 & s151;
assign vrf_r6_bypass_en = s153 & s162;
assign vrf_r7_bypass_en = s164 & s173;
assign s95 = |s97;
assign s106 = |s108;
assign s117 = |s119;
assign s128 = |s130;
assign s139 = |s141;
assign s150 = |s152;
assign s161 = |s163;
assign s172 = |s174;
generate
    if (VMAC2_TYPE != 0) begin:gen_r8910
        wire s448;
        wire s449;
        wire s450;
        wire s451;
        wire s452;
        wire s453;
        wire s454;
        wire s455;
        wire s456;
        wire [AGEN - 1:0] s457 = (s181 & s180);
        wire [AGEN - 1:0] s458 = (s188 & s187);
        wire [AGEN - 1:0] s459 = (s195 & s194);
        assign vrf_r8_valid = s175 & ~s451 & ~s179;
        assign vrf_r9_valid = s182 & ~s452 & ~s186;
        assign vrf_r10_valid = s189 & ~s453 & ~s193;
        assign s178 = s448 & vrf_r8_ready;
        assign s185 = s449 & vrf_r9_ready;
        assign s192 = s450 & vrf_r10_ready;
        kv_onehot #(
            .W(AGEN)
        ) u_r8_raw_hazard_onehot (
            .out(s454),
            .in(s457)
        );
        kv_onehot #(
            .W(AGEN)
        ) u_r9_raw_hazard_onehot (
            .out(s455),
            .in(s458)
        );
        kv_onehot #(
            .W(AGEN)
        ) u_r10_raw_hazard_onehot (
            .out(s456),
            .in(s459)
        );
        assign s451 = |s457;
        assign s452 = |s458;
        assign s453 = |s459;
        assign s448 = vrf_r8_valid | (vrf_r8_bypass_sel[0] & s200 & vrf_r8_bypass_en) | (vrf_r8_bypass_sel[1] & s216 & vrf_r8_bypass_en) | (vrf_r8_bypass_sel[2] & s232 & vrf_r8_bypass_en) | (vrf_r8_bypass_sel[3] & s248 & vrf_r8_bypass_en);
        assign s449 = vrf_r9_valid | (vrf_r9_bypass_sel[0] & s200 & vrf_r9_bypass_en) | (vrf_r9_bypass_sel[1] & s216 & vrf_r9_bypass_en) | (vrf_r9_bypass_sel[2] & s232 & vrf_r9_bypass_en) | (vrf_r9_bypass_sel[3] & s248 & vrf_r9_bypass_en);
        assign s450 = vrf_r10_valid | (vrf_r10_bypass_sel[0] & s200 & vrf_r10_bypass_en) | (vrf_r10_bypass_sel[1] & s216 & vrf_r10_bypass_en) | (vrf_r10_bypass_sel[2] & s232 & vrf_r10_bypass_en) | (vrf_r10_bypass_sel[3] & s248 & vrf_r10_bypass_en);
        assign vrf_r8_bypass_en = s175 & s454;
        assign vrf_r9_bypass_en = s182 & s455;
        assign vrf_r10_bypass_en = s189 & s456;
    end
    else begin:gen_r8910_stub
        assign vrf_r8_valid = 1'b0;
        assign vrf_r9_valid = 1'b0;
        assign vrf_r10_valid = 1'b0;
        assign s178 = 1'b0;
        assign s185 = 1'b0;
        assign s192 = 1'b0;
        assign vrf_r8_bypass_en = 1'b0;
        assign vrf_r9_bypass_en = 1'b0;
        assign vrf_r10_bypass_en = 1'b0;
    end
endgenerate
always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s15 <= 1'b0;
        vpu_vlsu_standby_ready <= 1'b0;
        vpu_valu_standby_ready <= 1'b0;
        vpu_vfmis_standby_ready <= 1'b0;
        vpu_vmac_standby_ready <= 1'b0;
        vpu_vmask_standby_ready <= 1'b0;
        vpu_vpermut_standby_ready <= 1'b0;
        vpu_vfdiv_standby_ready <= 1'b0;
        vpu_vdiv_standby_ready <= 1'b0;
        vpu_vace_standby_ready <= 1'b0;
        vpu_vsp_standby_ready <= 1'b0;
    end
    else begin
        s15 <= s16;
        vpu_vlsu_standby_ready <= s17;
        vpu_valu_standby_ready <= s18;
        vpu_vfmis_standby_ready <= s19;
        vpu_vmac_standby_ready <= s20;
        vpu_vmask_standby_ready <= s21;
        vpu_vpermut_standby_ready <= s22;
        vpu_vfdiv_standby_ready <= s23;
        vpu_vdiv_standby_ready <= s24;
        vpu_vace_standby_ready <= s25;
        vpu_vsp_standby_ready <= s26;
    end
end

assign vpu_standby_ready = s15;
assign s17 = ~(|(ent_valid & s37)) & ~vpu_vlsu_pending & viq_standby_ready[6];
assign s18 = valu_standby_ready & ~(|(ent_valid & s38)) & viq_standby_ready[2];
assign s19 = vfmis_standby_ready & ~(|(ent_valid & s39)) & viq_standby_ready[5];
assign s20 = vmac_standby_ready & ~(|(ent_valid & s40)) & ~(|(ent_valid & s41)) & viq_standby_ready[7];
assign s21 = vmask_standby_ready & ~(|(ent_valid & s42)) & viq_standby_ready[8];
assign s22 = vpermut_standby_ready & ~(|(ent_valid & s43)) & viq_standby_ready[9];
assign s23 = vfdiv_standby_ready & ~(|(ent_valid & s44)) & viq_standby_ready[4];
assign s24 = ~(|(ent_valid & s45)) & viq_standby_ready[3];
assign s25 = vace_standby_ready & ~(|(ent_valid & s46)) & viq_standby_ready[1];
assign s26 = vsp_standby_ready & ~(|(ent_valid & s47)) & viq_standby_ready[10];
assign s16 = ~|vscb_busy & valu_standby_ready & vfmis_standby_ready & vmac_standby_ready & vfdiv_standby_ready & vmask_standby_ready & vsp_standby_ready & vpermut_standby_ready & vace_standby_ready & viq_standby_ready[0] & srf_standby_ready & ~vpu_vlsu_pending;
wire nds_unused_signal = |{s179,s186,s193,s180,s187,s194,s80,s83,s86,s79,s82,s85,s78,s81,s84,s175,s182,s189,s181,s188,s195,s280,s288,s283,s279,s284,s285,s286,s287,s278,s278,s276,s277};
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

