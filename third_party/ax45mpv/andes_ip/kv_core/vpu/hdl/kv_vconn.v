// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vconn (
    vrf_r0_valid,
    vrf_r0_ready,
    vrf_r0_fu,
    vrf_r0_bypass_sel,
    vrf_r0_bypass_en,
    vrf_r0_last,
    vrf_r1_valid,
    vrf_r1_ready,
    vrf_r1_fu,
    vrf_r1_bypass_sel,
    vrf_r1_bypass_en,
    vrf_r1_last,
    vrf_r2_valid,
    vrf_r2_ready,
    vrf_r2_fu,
    vrf_r2_bypass_sel,
    vrf_r2_bypass_en,
    vrf_r2_last,
    vrf_r3_valid,
    vrf_r3_ready,
    vrf_r3_fu,
    vrf_r3_bypass_sel,
    vrf_r3_bypass_en,
    vrf_r3_last,
    vrf_r4_valid,
    vrf_r4_ready,
    vrf_r4_fu,
    vrf_r4_bypass_sel,
    vrf_r4_bypass_en,
    vrf_r4_last,
    vrf_r5_valid,
    vrf_r5_ready,
    vrf_r5_fu,
    vrf_r5_bypass_sel,
    vrf_r5_bypass_en,
    vrf_r5_last,
    vrf_r6_valid,
    vrf_r6_ready,
    vrf_r6_fu,
    vrf_r6_bypass_sel,
    vrf_r6_bypass_en,
    vrf_r6_last,
    vrf_r7_valid,
    vrf_r7_ready,
    vrf_r7_fu,
    vrf_r7_bypass_sel,
    vrf_r7_bypass_en,
    vrf_r7_last,
    vrf_w0_valid,
    vrf_w0_fu,
    vrf_w0_last,
    vrf_w0_ready,
    vrf_w1_valid,
    vrf_w1_fu,
    vrf_w1_last,
    vrf_w1_ready,
    vrf_w2_valid,
    vrf_w2_fu,
    vrf_w2_ready,
    vrf_w2_last,
    vrf_w3_valid,
    vrf_w3_fu,
    vrf_w3_last,
    vrf_w3_ready,
    vrf_w4_valid,
    vrf_w4_fu,
    vrf_w4_last,
    vrf_w4_ready,
    vrf_r0_data,
    vrf_r1_data,
    vrf_r2_data,
    vrf_r3_data,
    vrf_r4_data,
    vrf_r5_data,
    vrf_r6_data,
    vrf_r7_data,
    vrf_w0_data,
    vrf_w1_data,
    vrf_w2_data,
    vrf_w3_data,
    vrf_w4_data,
    vrf_w0_mask,
    vrf_w1_mask,
    vrf_w2_mask,
    vrf_w3_mask,
    vrf_w4_mask,
    vrf_r8_valid,
    vrf_r8_ready,
    vrf_r8_fu,
    vrf_r8_bypass_sel,
    vrf_r8_bypass_en,
    vrf_r8_last,
    vrf_r8_data,
    vrf_r9_valid,
    vrf_r9_ready,
    vrf_r9_fu,
    vrf_r9_bypass_sel,
    vrf_r9_bypass_en,
    vrf_r9_last,
    vrf_r9_data,
    vrf_r10_valid,
    vrf_r10_ready,
    vrf_r10_fu,
    vrf_r10_bypass_sel,
    vrf_r10_bypass_en,
    vrf_r10_last,
    vrf_r10_data,
    vrf_w5_valid,
    vrf_w5_fu,
    vrf_w5_last,
    vrf_w5_ready,
    vrf_w5_data,
    vrf_w5_mask,
    valu_vs1_rvalid,
    valu_vs1_rready,
    valu_vs1_rdata,
    valu_vs1_rlast,
    valu_vs2_rvalid,
    valu_vs2_rready,
    valu_vs2_rdata,
    valu_vs2_rlast,
    valu_vs3_rvalid,
    valu_vs3_rready,
    valu_vs3_rdata,
    valu_vs3_rlast,
    valu_vd_wvalid,
    valu_vd_wready,
    valu_vd_wdata,
    valu_vd_wmask,
    valu_vd_wlast,
    vmac_vs1_rvalid,
    vmac_vs1_rready,
    vmac_vs1_rdata,
    vmac_vs1_rlast,
    vmac_vs2_rvalid,
    vmac_vs2_rready,
    vmac_vs2_rdata,
    vmac_vs2_rlast,
    vmac_vs3_rvalid,
    vmac_vs3_rready,
    vmac_vs3_rdata,
    vmac_vs3_rlast,
    vmac_vd_wvalid,
    vmac_vd_wready,
    vmac_vd_wdata,
    vmac_vd_wmask,
    vmac_vd_wlast,
    vmac2_vs1_rvalid,
    vmac2_vs1_rready,
    vmac2_vs1_rdata,
    vmac2_vs1_rlast,
    vmac2_vs2_rvalid,
    vmac2_vs2_rready,
    vmac2_vs2_rdata,
    vmac2_vs2_rlast,
    vmac2_vs3_rvalid,
    vmac2_vs3_rready,
    vmac2_vs3_rdata,
    vmac2_vs3_rlast,
    vmac2_vd_wvalid,
    vmac2_vd_wready,
    vmac2_vd_wdata,
    vmac2_vd_wmask,
    vmac2_vd_wlast,
    vfmis_vs1_rvalid,
    vfmis_vs1_rready,
    vfmis_vs1_rdata,
    vfmis_vs1_rlast,
    vfmis_vs2_rvalid,
    vfmis_vs2_rready,
    vfmis_vs2_rdata,
    vfmis_vs2_rlast,
    vfmis_vs3_rvalid,
    vfmis_vs3_rready,
    vfmis_vs3_rdata,
    vfmis_vs3_rlast,
    vfmis_vd_wvalid,
    vfmis_vd_wdata,
    vfmis_vd_wmask,
    vfmis_vd_wready,
    vfmis_vd_wlast,
    vlsu_vs2_rvalid,
    vlsu_vs2_rready,
    vlsu_vs2_rdata,
    vlsu_vs2_rlast,
    vlsu_vs3_rvalid,
    vlsu_vs3_rready,
    vlsu_vs3_rdata,
    vlsu_vs3_rlast,
    vlsu_vd_wvalid,
    vlsu_vd_wready,
    vlsu_vd_wdata,
    vlsu_vd_wmask,
    vlsu_vd_wlast,
    vsp_vs3_rvalid,
    vsp_vs3_rready,
    vsp_vs3_rdata,
    vsp_vs3_rlast,
    vsp_vd_wvalid,
    vsp_vd_wready,
    vsp_vd_wdata,
    vsp_vd_wmask,
    vsp_vd_wlast,
    vdiv_vs1_rvalid,
    vdiv_vs1_rready,
    vdiv_vs1_rdata,
    vdiv_vs1_rlast,
    vdiv_vs2_rvalid,
    vdiv_vs2_rready,
    vdiv_vs2_rdata,
    vdiv_vs2_rlast,
    vdiv_vd_wdata,
    vdiv_vd_wmask,
    vdiv_vd_wvalid,
    vdiv_vd_wready,
    vdiv_vd_wlast,
    vpermut_vs1_rvalid,
    vpermut_vs1_rready,
    vpermut_vs1_rdata,
    vpermut_vs1_rlast,
    vpermut_vs2_rvalid,
    vpermut_vs2_rready,
    vpermut_vs2_rdata,
    vpermut_vs2_rlast,
    vpermut_vd_wdata,
    vpermut_vd_wmask,
    vpermut_vd_wvalid,
    vpermut_vd_wready,
    vpermut_vd_wlast,
    vfdiv_vs1_rvalid,
    vfdiv_vs1_rready,
    vfdiv_vs1_rdata,
    vfdiv_vs1_rlast,
    vfdiv_vs2_rvalid,
    vfdiv_vs2_rready,
    vfdiv_vs2_rdata,
    vfdiv_vs2_rlast,
    vfdiv_vd_wdata,
    vfdiv_vd_wmask,
    vfdiv_vd_wvalid,
    vfdiv_vd_wready,
    vfdiv_vd_wlast,
    vmask_vs1_rvalid,
    vmask_vs1_rready,
    vmask_vs1_rdata,
    vmask_vs1_rlast,
    vmask_vs2_rvalid,
    vmask_vs2_rready,
    vmask_vs2_rdata,
    vmask_vs2_rlast,
    vmask_vs3_rvalid,
    vmask_vs3_rready,
    vmask_vs3_rdata,
    vmask_vs3_rlast,
    vmask_vd_wdata,
    vmask_vd_wmask,
    vmask_vd_wvalid,
    vmask_vd_wready,
    vmask_vd_wlast,
    vace_vs1_rvalid,
    vace_vs1_rready,
    vace_vs1_rdata,
    vace_vs1_rlast,
    vace_vs2_rvalid,
    vace_vs2_rready,
    vace_vs2_rdata,
    vace_vs2_rlast,
    vace_vs3_rvalid,
    vace_vs3_rready,
    vace_vs3_rdata,
    vace_vs3_rlast,
    vace_vd_wdata,
    vace_vd_wmask,
    vace_vd_wvalid,
    vace_vd_wready,
    vace_vd_wlast
);
parameter VLEN = 512;
parameter DLEN = 512;
parameter ELEN = 64;
parameter BYPASSW = 4;
parameter VMAC2_TYPE = 0;
parameter ACE_SP_WRITE_PORT = 3;
input vrf_r0_valid;
output vrf_r0_ready;
input [11 - 1:0] vrf_r0_fu;
input [BYPASSW - 1:0] vrf_r0_bypass_sel;
input vrf_r0_bypass_en;
input vrf_r0_last;
input vrf_r1_valid;
output vrf_r1_ready;
input [11 - 1:0] vrf_r1_fu;
input [BYPASSW - 1:0] vrf_r1_bypass_sel;
input vrf_r1_bypass_en;
input vrf_r1_last;
input vrf_r2_valid;
output vrf_r2_ready;
input [11 - 1:0] vrf_r2_fu;
input [BYPASSW - 1:0] vrf_r2_bypass_sel;
input vrf_r2_bypass_en;
input vrf_r2_last;
input vrf_r3_valid;
output vrf_r3_ready;
input [11 - 1:0] vrf_r3_fu;
input [BYPASSW - 1:0] vrf_r3_bypass_sel;
input vrf_r3_bypass_en;
input vrf_r3_last;
input vrf_r4_valid;
output vrf_r4_ready;
input [11 - 1:0] vrf_r4_fu;
input [BYPASSW - 1:0] vrf_r4_bypass_sel;
input vrf_r4_bypass_en;
input vrf_r4_last;
input vrf_r5_valid;
output vrf_r5_ready;
input [11 - 1:0] vrf_r5_fu;
input [BYPASSW - 1:0] vrf_r5_bypass_sel;
input vrf_r5_bypass_en;
input vrf_r5_last;
input vrf_r6_valid;
output vrf_r6_ready;
input [11 - 1:0] vrf_r6_fu;
input [BYPASSW - 1:0] vrf_r6_bypass_sel;
input vrf_r6_bypass_en;
input vrf_r6_last;
input vrf_r7_valid;
output vrf_r7_ready;
input [11 - 1:0] vrf_r7_fu;
input [BYPASSW - 1:0] vrf_r7_bypass_sel;
input vrf_r7_bypass_en;
input vrf_r7_last;
output vrf_w0_valid;
input [11 - 1:0] vrf_w0_fu;
input vrf_w0_last;
input vrf_w0_ready;
output vrf_w1_valid;
input [11 - 1:0] vrf_w1_fu;
input vrf_w1_last;
input vrf_w1_ready;
output vrf_w2_valid;
input [11 - 1:0] vrf_w2_fu;
input vrf_w2_ready;
input vrf_w2_last;
output vrf_w3_valid;
input [11 - 1:0] vrf_w3_fu;
input vrf_w3_last;
input vrf_w3_ready;
output vrf_w4_valid;
input [11 - 1:0] vrf_w4_fu;
input vrf_w4_last;
input vrf_w4_ready;
input [DLEN - 1:0] vrf_r0_data;
input [DLEN - 1:0] vrf_r1_data;
input [DLEN - 1:0] vrf_r2_data;
input [DLEN - 1:0] vrf_r3_data;
input [DLEN - 1:0] vrf_r4_data;
input [DLEN - 1:0] vrf_r5_data;
input [DLEN - 1:0] vrf_r6_data;
input [DLEN - 1:0] vrf_r7_data;
output [DLEN - 1:0] vrf_w0_data;
output [DLEN - 1:0] vrf_w1_data;
output [DLEN - 1:0] vrf_w2_data;
output [DLEN - 1:0] vrf_w3_data;
output [DLEN - 1:0] vrf_w4_data;
output [(DLEN / 8) - 1:0] vrf_w0_mask;
output [(DLEN / 8) - 1:0] vrf_w1_mask;
output [(DLEN / 8) - 1:0] vrf_w2_mask;
output [(DLEN / 8) - 1:0] vrf_w3_mask;
output [(DLEN / 8) - 1:0] vrf_w4_mask;
input vrf_r8_valid;
output vrf_r8_ready;
input [11 - 1:0] vrf_r8_fu;
input [BYPASSW - 1:0] vrf_r8_bypass_sel;
input vrf_r8_bypass_en;
input vrf_r8_last;
input [DLEN - 1:0] vrf_r8_data;
input vrf_r9_valid;
output vrf_r9_ready;
input [11 - 1:0] vrf_r9_fu;
input [BYPASSW - 1:0] vrf_r9_bypass_sel;
input vrf_r9_bypass_en;
input vrf_r9_last;
input [DLEN - 1:0] vrf_r9_data;
input vrf_r10_valid;
output vrf_r10_ready;
input [11 - 1:0] vrf_r10_fu;
input [BYPASSW - 1:0] vrf_r10_bypass_sel;
input vrf_r10_bypass_en;
input vrf_r10_last;
input [DLEN - 1:0] vrf_r10_data;
output vrf_w5_valid;
input [11 - 1:0] vrf_w5_fu;
input vrf_w5_last;
input vrf_w5_ready;
output [DLEN - 1:0] vrf_w5_data;
output [(DLEN / 8) - 1:0] vrf_w5_mask;
output valu_vs1_rvalid;
input valu_vs1_rready;
output [DLEN - 1:0] valu_vs1_rdata;
output valu_vs1_rlast;
output valu_vs2_rvalid;
input valu_vs2_rready;
output [DLEN - 1:0] valu_vs2_rdata;
output valu_vs2_rlast;
output valu_vs3_rvalid;
input valu_vs3_rready;
output [DLEN - 1:0] valu_vs3_rdata;
output valu_vs3_rlast;
input valu_vd_wvalid;
output valu_vd_wready;
input [DLEN - 1:0] valu_vd_wdata;
input [(DLEN / 8) - 1:0] valu_vd_wmask;
output valu_vd_wlast;
output vmac_vs1_rvalid;
input vmac_vs1_rready;
output [DLEN - 1:0] vmac_vs1_rdata;
output vmac_vs1_rlast;
output vmac_vs2_rvalid;
input vmac_vs2_rready;
output [DLEN - 1:0] vmac_vs2_rdata;
output vmac_vs2_rlast;
output vmac_vs3_rvalid;
input vmac_vs3_rready;
output [DLEN - 1:0] vmac_vs3_rdata;
output vmac_vs3_rlast;
input vmac_vd_wvalid;
output vmac_vd_wready;
input [DLEN - 1:0] vmac_vd_wdata;
input [(DLEN / 8) - 1:0] vmac_vd_wmask;
output vmac_vd_wlast;
output vmac2_vs1_rvalid;
input vmac2_vs1_rready;
output [DLEN - 1:0] vmac2_vs1_rdata;
output vmac2_vs1_rlast;
output vmac2_vs2_rvalid;
input vmac2_vs2_rready;
output [DLEN - 1:0] vmac2_vs2_rdata;
output vmac2_vs2_rlast;
output vmac2_vs3_rvalid;
input vmac2_vs3_rready;
output [DLEN - 1:0] vmac2_vs3_rdata;
output vmac2_vs3_rlast;
input vmac2_vd_wvalid;
output vmac2_vd_wready;
input [DLEN - 1:0] vmac2_vd_wdata;
input [(DLEN / 8) - 1:0] vmac2_vd_wmask;
output vmac2_vd_wlast;
output vfmis_vs1_rvalid;
input vfmis_vs1_rready;
output [DLEN - 1:0] vfmis_vs1_rdata;
output vfmis_vs1_rlast;
output vfmis_vs2_rvalid;
input vfmis_vs2_rready;
output [DLEN - 1:0] vfmis_vs2_rdata;
output vfmis_vs2_rlast;
output vfmis_vs3_rvalid;
input vfmis_vs3_rready;
output [DLEN - 1:0] vfmis_vs3_rdata;
output vfmis_vs3_rlast;
input vfmis_vd_wvalid;
input [DLEN - 1:0] vfmis_vd_wdata;
input [(DLEN / 8) - 1:0] vfmis_vd_wmask;
output vfmis_vd_wready;
output vfmis_vd_wlast;
output vlsu_vs2_rvalid;
input vlsu_vs2_rready;
output [DLEN - 1:0] vlsu_vs2_rdata;
output vlsu_vs2_rlast;
output vlsu_vs3_rvalid;
input vlsu_vs3_rready;
output [DLEN - 1:0] vlsu_vs3_rdata;
output vlsu_vs3_rlast;
input vlsu_vd_wvalid;
output vlsu_vd_wready;
input [DLEN - 1:0] vlsu_vd_wdata;
input [(DLEN / 8) - 1:0] vlsu_vd_wmask;
output vlsu_vd_wlast;
output vsp_vs3_rvalid;
input vsp_vs3_rready;
output [DLEN - 1:0] vsp_vs3_rdata;
output vsp_vs3_rlast;
input vsp_vd_wvalid;
output vsp_vd_wready;
input [DLEN - 1:0] vsp_vd_wdata;
input [(DLEN / 8) - 1:0] vsp_vd_wmask;
output vsp_vd_wlast;
output vdiv_vs1_rvalid;
input vdiv_vs1_rready;
output [DLEN - 1:0] vdiv_vs1_rdata;
output vdiv_vs1_rlast;
output vdiv_vs2_rvalid;
input vdiv_vs2_rready;
output [DLEN - 1:0] vdiv_vs2_rdata;
output vdiv_vs2_rlast;
input [DLEN - 1:0] vdiv_vd_wdata;
input [(DLEN / 8) - 1:0] vdiv_vd_wmask;
input vdiv_vd_wvalid;
output vdiv_vd_wready;
output vdiv_vd_wlast;
output vpermut_vs1_rvalid;
input vpermut_vs1_rready;
output [DLEN - 1:0] vpermut_vs1_rdata;
output vpermut_vs1_rlast;
output vpermut_vs2_rvalid;
input vpermut_vs2_rready;
output [DLEN - 1:0] vpermut_vs2_rdata;
output vpermut_vs2_rlast;
input [DLEN - 1:0] vpermut_vd_wdata;
input [(DLEN / 8) - 1:0] vpermut_vd_wmask;
input vpermut_vd_wvalid;
output vpermut_vd_wready;
output vpermut_vd_wlast;
output vfdiv_vs1_rvalid;
input vfdiv_vs1_rready;
output [DLEN - 1:0] vfdiv_vs1_rdata;
output vfdiv_vs1_rlast;
output vfdiv_vs2_rvalid;
input vfdiv_vs2_rready;
output [DLEN - 1:0] vfdiv_vs2_rdata;
output vfdiv_vs2_rlast;
input [DLEN - 1:0] vfdiv_vd_wdata;
input [(DLEN / 8) - 1:0] vfdiv_vd_wmask;
input vfdiv_vd_wvalid;
output vfdiv_vd_wready;
output vfdiv_vd_wlast;
output vmask_vs1_rvalid;
input vmask_vs1_rready;
output [DLEN - 1:0] vmask_vs1_rdata;
output vmask_vs1_rlast;
output vmask_vs2_rvalid;
input vmask_vs2_rready;
output [DLEN - 1:0] vmask_vs2_rdata;
output vmask_vs2_rlast;
output vmask_vs3_rvalid;
input vmask_vs3_rready;
output [DLEN - 1:0] vmask_vs3_rdata;
output vmask_vs3_rlast;
input [DLEN - 1:0] vmask_vd_wdata;
input [(DLEN / 8) - 1:0] vmask_vd_wmask;
input vmask_vd_wvalid;
output vmask_vd_wready;
output vmask_vd_wlast;
output vace_vs1_rvalid;
input vace_vs1_rready;
output [DLEN - 1:0] vace_vs1_rdata;
output vace_vs1_rlast;
output vace_vs2_rvalid;
input vace_vs2_rready;
output [DLEN - 1:0] vace_vs2_rdata;
output vace_vs2_rlast;
output vace_vs3_rvalid;
input vace_vs3_rready;
output [DLEN - 1:0] vace_vs3_rdata;
output vace_vs3_rlast;
input [DLEN - 1:0] vace_vd_wdata;
input [(DLEN / 8) - 1:0] vace_vd_wmask;
input vace_vd_wvalid;
output vace_vd_wready;
output vace_vd_wlast;





// d05bc5d2 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [DLEN - 1:0] s0;
wire [(DLEN / 8) - 1:0] s1;
wire [DLEN - 1:0] s2;
wire [(DLEN / 8) - 1:0] s3;
wire s4 = vrf_w0_valid & vrf_w0_ready;
wire s5 = vrf_w1_valid & vrf_w1_ready;
wire s6 = vrf_w2_valid & vrf_w2_ready;
wire s7 = vrf_w3_valid & vrf_w3_ready;
wire s8;
wire s9;
wire s10;
wire s11;
wire s12;
wire s13;
wire s14;
wire s15;
wire s16;
wire s17;
wire s18;
wire [DLEN - 1:0] s19;
wire [DLEN - 1:0] s20;
wire [DLEN - 1:0] s21;
wire [DLEN - 1:0] s22;
wire [DLEN - 1:0] s23;
wire [DLEN - 1:0] s24;
wire [DLEN - 1:0] s25;
wire [DLEN - 1:0] s26;
wire [DLEN - 1:0] s27;
wire [DLEN - 1:0] s28;
wire [DLEN - 1:0] s29;
wire s30 = vrf_r0_last;
wire s31 = vrf_r1_last;
wire s32 = vrf_r2_last;
wire s33 = vrf_r3_last;
wire s34 = vrf_r4_last;
wire s35 = vrf_r5_last;
wire s36 = vrf_r6_last;
wire s37 = vrf_r7_last;
wire s38 = vrf_r8_last;
wire s39 = vrf_r9_last;
wire s40 = vrf_r10_last;
wire s41 = vrf_w3_fu[2] & (ACE_SP_WRITE_PORT == 3);
wire s42 = vrf_w4_fu[2] & (ACE_SP_WRITE_PORT == 4);
kv_mux_onehot #(
    .N(3),
    .W(1 + DLEN + DLEN / 8)
) u_w0 (
    .out({vrf_w0_valid,vrf_w0_mask,vrf_w0_data}),
    .sel({vrf_w0_fu[9],vrf_w0_fu[8],vrf_w0_fu[0]}),
    .in({vace_vd_wvalid,vace_vd_wmask,vace_vd_wdata,vmask_vd_wvalid,vmask_vd_wmask,vmask_vd_wdata,valu_vd_wvalid,valu_vd_wmask,valu_vd_wdata})
);
assign vrf_w1_valid = vmac_vd_wvalid;
assign vrf_w2_valid = vfmis_vd_wvalid;
assign vrf_w3_valid = (vrf_w3_fu[1] & vlsu_vd_wvalid) | (s41 & vsp_vd_wvalid);
assign {vrf_w1_mask,vrf_w1_data} = {vmac_vd_wmask,vmac_vd_wdata};
assign {vrf_w2_mask,vrf_w2_data} = {vfmis_vd_wmask,vfmis_vd_wdata};
kv_mux_onehot #(
    .N(2),
    .W(DLEN + DLEN / 8)
) u_w3 (
    .out({vrf_w3_mask,vrf_w3_data}),
    .sel({s41,vrf_w3_fu[1]}),
    .in({vsp_vd_wmask,vsp_vd_wdata,vlsu_vd_wmask,vlsu_vd_wdata})
);
kv_mux_onehot #(
    .N(2),
    .W(DLEN + DLEN / 8)
) u_w3_dup0 (
    .out({s1,s0}),
    .sel({s41,vrf_w3_fu[1]}),
    .in({vsp_vd_wmask,vsp_vd_wdata,vlsu_vd_wmask,vlsu_vd_wdata})
);
kv_mux_onehot #(
    .N(2),
    .W(DLEN + DLEN / 8)
) u_w3_dup1 (
    .out({s3,s2}),
    .sel({s41,vrf_w3_fu[1]}),
    .in({vsp_vd_wmask,vsp_vd_wdata,vlsu_vd_wmask,vlsu_vd_wdata})
);
kv_mux_onehot #(
    .N(4),
    .W(1 + DLEN + DLEN / 8)
) u_w4 (
    .out({vrf_w4_valid,vrf_w4_mask,vrf_w4_data}),
    .sel({s42,vrf_w4_fu[7],vrf_w4_fu[6],vrf_w4_fu[4]}),
    .in({vsp_vd_wvalid,vsp_vd_wmask,vsp_vd_wdata,vfdiv_vd_wvalid,vfdiv_vd_wmask,vfdiv_vd_wdata,vpermut_vd_wvalid,vpermut_vd_wmask,vpermut_vd_wdata,vdiv_vd_wvalid,vdiv_vd_wmask,vdiv_vd_wdata})
);
assign valu_vd_wready = vrf_w0_ready & vrf_w0_fu[0];
assign valu_vd_wlast = vrf_w0_last;
assign vmask_vd_wready = vrf_w0_ready & vrf_w0_fu[8];
assign vmask_vd_wlast = vrf_w0_last;
assign vace_vd_wready = vrf_w0_ready & vrf_w0_fu[9];
assign vace_vd_wlast = vrf_w0_last;
assign vmac_vd_wready = vrf_w1_ready;
assign vmac_vd_wlast = vrf_w1_last;
generate
    if (VMAC2_TYPE != 0) begin:gen_vmac2_vd
        assign {vrf_w5_valid,vrf_w5_mask,vrf_w5_data} = {vmac2_vd_wvalid,vmac2_vd_wmask,vmac2_vd_wdata};
        assign vmac2_vd_wready = vrf_w5_ready;
        assign vmac2_vd_wlast = vrf_w5_last;
    end
    else begin:gen_vmac2_vd_stub
        assign vrf_w5_valid = 1'b0;
        assign vrf_w5_mask = {(DLEN / 8){1'b0}};
        assign vrf_w5_data = {DLEN{1'b0}};
        assign vmac2_vd_wready = 1'b0;
        assign vmac2_vd_wlast = 1'b0;
    end
endgenerate
assign vfmis_vd_wlast = vrf_w2_last;
assign vfmis_vd_wready = vrf_w2_ready;
assign vlsu_vd_wready = vrf_w3_ready & vrf_w3_fu[1];
assign vlsu_vd_wlast = vrf_w3_last & vrf_w3_fu[1];
assign vsp_vd_wready = (vrf_w3_ready & s41) | (vrf_w4_ready & s42);
assign vsp_vd_wlast = (vrf_w3_last & s41) | (vrf_w4_last & s42);
assign vdiv_vd_wlast = vrf_w4_last;
assign vdiv_vd_wready = vrf_w4_ready & vrf_w4_fu[4];
assign vpermut_vd_wlast = vrf_w4_last;
assign vpermut_vd_wready = vrf_w4_ready & vrf_w4_fu[6];
assign vfdiv_vd_wlast = vrf_w4_last;
assign vfdiv_vd_wready = vrf_w4_ready & vrf_w4_fu[7];
kv_vconn_vs #(
    .ELEN(DLEN),
    .BYPASSW(BYPASSW)
) u_fu_r0 (
    .vrf_r_data(vrf_r0_data),
    .vrf_r_bypass_sel(vrf_r0_bypass_sel),
    .vrf_w0_data(vrf_w0_data),
    .vrf_w0_mask(vrf_w0_mask),
    .vrf_w1_data(vrf_w1_data),
    .vrf_w1_mask(vrf_w1_mask),
    .vrf_w2_data(vrf_w2_data),
    .vrf_w2_mask(vrf_w2_mask),
    .vrf_w3_data(s0),
    .vrf_w3_mask(s1),
    .vs_rdata(s19)
);
kv_vconn_vs #(
    .ELEN(DLEN),
    .BYPASSW(BYPASSW)
) u_fu_r1 (
    .vrf_r_data(vrf_r1_data),
    .vrf_r_bypass_sel(vrf_r1_bypass_sel),
    .vrf_w0_data(vrf_w0_data),
    .vrf_w0_mask(vrf_w0_mask),
    .vrf_w1_data(vrf_w1_data),
    .vrf_w1_mask(vrf_w1_mask),
    .vrf_w2_data(vrf_w2_data),
    .vrf_w2_mask(vrf_w2_mask),
    .vrf_w3_data(s0),
    .vrf_w3_mask(s1),
    .vs_rdata(s20)
);
kv_vconn_vs #(
    .ELEN(DLEN),
    .BYPASSW(BYPASSW)
) u_fu_r2 (
    .vrf_r_data(vrf_r2_data),
    .vrf_r_bypass_sel(vrf_r2_bypass_sel),
    .vrf_w0_data(vrf_w0_data),
    .vrf_w0_mask(vrf_w0_mask),
    .vrf_w1_data(vrf_w1_data),
    .vrf_w1_mask(vrf_w1_mask),
    .vrf_w2_data(vrf_w2_data),
    .vrf_w2_mask(vrf_w2_mask),
    .vrf_w3_data(s0),
    .vrf_w3_mask(s1),
    .vs_rdata(s21)
);
kv_vconn_vs #(
    .ELEN(DLEN),
    .BYPASSW(BYPASSW)
) u_fu_r3 (
    .vrf_r_data(vrf_r3_data),
    .vrf_r_bypass_sel(vrf_r3_bypass_sel),
    .vrf_w0_data(vrf_w0_data),
    .vrf_w0_mask(vrf_w0_mask),
    .vrf_w1_data(vrf_w1_data),
    .vrf_w1_mask(vrf_w1_mask),
    .vrf_w2_data(vrf_w2_data),
    .vrf_w2_mask(vrf_w2_mask),
    .vrf_w3_data(s0),
    .vrf_w3_mask(s1),
    .vs_rdata(s22)
);
kv_vconn_vs #(
    .ELEN(DLEN),
    .BYPASSW(BYPASSW)
) u_fu_r4 (
    .vrf_r_data(vrf_r4_data),
    .vrf_r_bypass_sel(vrf_r4_bypass_sel),
    .vrf_w0_data(vrf_w0_data),
    .vrf_w0_mask(vrf_w0_mask),
    .vrf_w1_data(vrf_w1_data),
    .vrf_w1_mask(vrf_w1_mask),
    .vrf_w2_data(vrf_w2_data),
    .vrf_w2_mask(vrf_w2_mask),
    .vrf_w3_data(s0),
    .vrf_w3_mask(s1),
    .vs_rdata(s23)
);
kv_vconn_vs #(
    .ELEN(DLEN),
    .BYPASSW(BYPASSW)
) u_fu_r5 (
    .vrf_r_data(vrf_r5_data),
    .vrf_r_bypass_sel(vrf_r5_bypass_sel),
    .vrf_w0_data(vrf_w0_data),
    .vrf_w0_mask(vrf_w0_mask),
    .vrf_w1_data(vrf_w1_data),
    .vrf_w1_mask(vrf_w1_mask),
    .vrf_w2_data(vrf_w2_data),
    .vrf_w2_mask(vrf_w2_mask),
    .vrf_w3_data(s0),
    .vrf_w3_mask(s1),
    .vs_rdata(s24)
);
kv_vconn_vs #(
    .ELEN(DLEN),
    .BYPASSW(BYPASSW)
) u_fu_r6 (
    .vrf_r_data(vrf_r6_data),
    .vrf_r_bypass_sel(vrf_r6_bypass_sel),
    .vrf_w0_data(vrf_w0_data),
    .vrf_w0_mask(vrf_w0_mask),
    .vrf_w1_data(vrf_w1_data),
    .vrf_w1_mask(vrf_w1_mask),
    .vrf_w2_data(vrf_w2_data),
    .vrf_w2_mask(vrf_w2_mask),
    .vrf_w3_data(s2),
    .vrf_w3_mask(s3),
    .vs_rdata(s25)
);
kv_vconn_vs #(
    .ELEN(DLEN),
    .BYPASSW(BYPASSW)
) u_fu_r7 (
    .vrf_r_data(vrf_r7_data),
    .vrf_r_bypass_sel(vrf_r7_bypass_sel),
    .vrf_w0_data(vrf_w0_data),
    .vrf_w0_mask(vrf_w0_mask),
    .vrf_w1_data(vrf_w1_data),
    .vrf_w1_mask(vrf_w1_mask),
    .vrf_w2_data(vrf_w2_data),
    .vrf_w2_mask(vrf_w2_mask),
    .vrf_w3_data(s2),
    .vrf_w3_mask(s3),
    .vs_rdata(s26)
);
generate
    if (VMAC2_TYPE != 0) begin:gen_vconn_vs8
        kv_vconn_vs #(
            .ELEN(DLEN),
            .BYPASSW(BYPASSW)
        ) u_fu_r8 (
            .vrf_r_data(vrf_r8_data),
            .vrf_r_bypass_sel(vrf_r8_bypass_sel),
            .vrf_w0_data(vrf_w0_data),
            .vrf_w0_mask(vrf_w0_mask),
            .vrf_w1_data(vrf_w1_data),
            .vrf_w1_mask(vrf_w1_mask),
            .vrf_w2_data(vrf_w2_data),
            .vrf_w2_mask(vrf_w2_mask),
            .vrf_w3_data(vrf_w3_data),
            .vrf_w3_mask(vrf_w3_mask),
            .vs_rdata(s27)
        );
    end
    else begin:gen_vconn_vs8_stub
        assign s27 = {DLEN{1'b0}};
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_vconn_vs9
        kv_vconn_vs #(
            .ELEN(DLEN),
            .BYPASSW(BYPASSW)
        ) u_fu_r9 (
            .vrf_r_data(vrf_r9_data),
            .vrf_r_bypass_sel(vrf_r9_bypass_sel),
            .vrf_w0_data(vrf_w0_data),
            .vrf_w0_mask(vrf_w0_mask),
            .vrf_w1_data(vrf_w1_data),
            .vrf_w1_mask(vrf_w1_mask),
            .vrf_w2_data(vrf_w2_data),
            .vrf_w2_mask(vrf_w2_mask),
            .vrf_w3_data(vrf_w3_data),
            .vrf_w3_mask(vrf_w3_mask),
            .vs_rdata(s28)
        );
    end
    else begin:gen_vconn_vs9_stub
        assign s28 = {DLEN{1'b0}};
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_vconn_vs10
        kv_vconn_vs #(
            .ELEN(DLEN),
            .BYPASSW(BYPASSW)
        ) u_fu_r10 (
            .vrf_r_data(vrf_r10_data),
            .vrf_r_bypass_sel(vrf_r10_bypass_sel),
            .vrf_w0_data(vrf_w0_data),
            .vrf_w0_mask(vrf_w0_mask),
            .vrf_w1_data(vrf_w1_data),
            .vrf_w1_mask(vrf_w1_mask),
            .vrf_w2_data(vrf_w2_data),
            .vrf_w2_mask(vrf_w2_mask),
            .vrf_w3_data(vrf_w3_data),
            .vrf_w3_mask(vrf_w3_mask),
            .vs_rdata(s29)
        );
    end
    else begin:gen_vconn_vs10_stub
        assign s29 = {DLEN{1'b0}};
    end
endgenerate
assign s8 = vrf_r0_valid | (vrf_r0_bypass_sel[0] & s4 & vrf_r0_bypass_en) | (vrf_r0_bypass_sel[1] & s5 & vrf_r0_bypass_en) | (vrf_r0_bypass_sel[2] & s6 & vrf_r0_bypass_en) | (vrf_r0_bypass_sel[3] & s7 & vrf_r0_bypass_en);
assign s9 = vrf_r1_valid | (vrf_r1_bypass_sel[0] & s4 & vrf_r1_bypass_en) | (vrf_r1_bypass_sel[1] & s5 & vrf_r1_bypass_en) | (vrf_r1_bypass_sel[2] & s6 & vrf_r1_bypass_en) | (vrf_r1_bypass_sel[3] & s7 & vrf_r1_bypass_en);
assign s10 = vrf_r2_valid | (vrf_r2_bypass_sel[0] & s4 & vrf_r2_bypass_en) | (vrf_r2_bypass_sel[1] & s5 & vrf_r2_bypass_en) | (vrf_r2_bypass_sel[2] & s6 & vrf_r2_bypass_en) | (vrf_r2_bypass_sel[3] & s7 & vrf_r2_bypass_en);
assign s11 = vrf_r3_valid | (vrf_r3_bypass_sel[0] & s4 & vrf_r3_bypass_en) | (vrf_r3_bypass_sel[1] & s5 & vrf_r3_bypass_en) | (vrf_r3_bypass_sel[2] & s6 & vrf_r3_bypass_en) | (vrf_r3_bypass_sel[3] & s7 & vrf_r3_bypass_en);
assign s12 = vrf_r4_valid | (vrf_r4_bypass_sel[0] & s4 & vrf_r4_bypass_en) | (vrf_r4_bypass_sel[1] & s5 & vrf_r4_bypass_en) | (vrf_r4_bypass_sel[2] & s6 & vrf_r4_bypass_en) | (vrf_r4_bypass_sel[3] & s7 & vrf_r4_bypass_en);
assign s13 = vrf_r5_valid | (vrf_r5_bypass_sel[0] & s4 & vrf_r5_bypass_en) | (vrf_r5_bypass_sel[1] & s5 & vrf_r5_bypass_en) | (vrf_r5_bypass_sel[2] & s6 & vrf_r5_bypass_en) | (vrf_r5_bypass_sel[3] & s7 & vrf_r5_bypass_en);
assign s14 = vrf_r6_valid | (vrf_r6_bypass_sel[0] & s4 & vrf_r6_bypass_en) | (vrf_r6_bypass_sel[1] & s5 & vrf_r6_bypass_en) | (vrf_r6_bypass_sel[2] & s6 & vrf_r6_bypass_en) | (vrf_r6_bypass_sel[3] & s7 & vrf_r6_bypass_en);
assign s15 = vrf_r7_valid | (vrf_r7_bypass_sel[0] & s4 & vrf_r7_bypass_en) | (vrf_r7_bypass_sel[1] & s5 & vrf_r7_bypass_en) | (vrf_r7_bypass_sel[2] & s6 & vrf_r7_bypass_en) | (vrf_r7_bypass_sel[3] & s7 & vrf_r7_bypass_en);
generate
    if (VMAC2_TYPE != 0) begin:gen_vmac2_vs
        assign s16 = vrf_r8_valid | (vrf_r8_bypass_sel[0] & s4 & vrf_r8_bypass_en) | (vrf_r8_bypass_sel[1] & s5 & vrf_r8_bypass_en) | (vrf_r8_bypass_sel[2] & s6 & vrf_r8_bypass_en) | (vrf_r8_bypass_sel[3] & s7 & vrf_r8_bypass_en);
        assign s17 = vrf_r9_valid | (vrf_r9_bypass_sel[0] & s4 & vrf_r9_bypass_en) | (vrf_r9_bypass_sel[1] & s5 & vrf_r9_bypass_en) | (vrf_r9_bypass_sel[2] & s6 & vrf_r9_bypass_en) | (vrf_r9_bypass_sel[3] & s7 & vrf_r9_bypass_en);
        assign s18 = vrf_r10_valid | (vrf_r10_bypass_sel[0] & s4 & vrf_r10_bypass_en) | (vrf_r10_bypass_sel[1] & s5 & vrf_r10_bypass_en) | (vrf_r10_bypass_sel[2] & s6 & vrf_r10_bypass_en) | (vrf_r10_bypass_sel[3] & s7 & vrf_r10_bypass_en);
    end
    else begin:gen_vmac2_vs_stub
        assign s16 = 1'b0;
        assign s17 = 1'b0;
        assign s18 = 1'b0;
    end
endgenerate
assign vrf_r0_ready = (vrf_r0_fu[0] & valu_vs1_rready) | (vrf_r0_fu[5] & vfmis_vs3_rready) | (vrf_r0_fu[8] & vmask_vs1_rready) | (vrf_r0_fu[9] & vace_vs1_rready);
assign vrf_r1_ready = (vrf_r1_fu[0] & valu_vs2_rready) | (vrf_r1_fu[5] & vfmis_vs1_rready) | (vrf_r1_fu[8] & vmask_vs2_rready) | (vrf_r1_fu[9] & vace_vs2_rready);
assign vrf_r2_ready = (vrf_r2_fu[0] & valu_vs3_rready) | (vrf_r2_fu[5] & vfmis_vs2_rready) | (vrf_r2_fu[8] & vmask_vs3_rready) | (vrf_r2_fu[9] & vace_vs3_rready);
assign vrf_r3_ready = (vrf_r3_fu[3] & vmac_vs1_rready);
assign vrf_r4_ready = (vrf_r4_fu[3] & vmac_vs2_rready);
assign vrf_r5_ready = (vrf_r5_fu[3] & vmac_vs3_rready);
assign vrf_r6_ready = (vrf_r6_fu[1] & vlsu_vs2_rready) | (vrf_r6_fu[4] & vdiv_vs1_rready) | (vrf_r6_fu[7] & vfdiv_vs1_rready) | (vrf_r6_fu[6] & vpermut_vs1_rready);
assign vrf_r7_ready = (vrf_r7_fu[1] & vlsu_vs3_rready) | (vrf_r7_fu[2] & vsp_vs3_rready) | (vrf_r7_fu[4] & vdiv_vs2_rready) | (vrf_r7_fu[7] & vfdiv_vs2_rready) | (vrf_r7_fu[6] & vpermut_vs2_rready);
generate
    if (VMAC2_TYPE != 0) begin:gen_vamc2_r_ready
        assign vrf_r8_ready = (vrf_r8_fu[10] & vmac2_vs1_rready);
        assign vrf_r9_ready = (vrf_r9_fu[10] & vmac2_vs2_rready);
        assign vrf_r10_ready = (vrf_r10_fu[10] & vmac2_vs3_rready);
    end
    else begin:gen_vamc2_r_ready_stub
        assign vrf_r8_ready = 1'b0;
        assign vrf_r9_ready = 1'b0;
        assign vrf_r10_ready = 1'b0;
    end
endgenerate
assign valu_vs1_rvalid = s8 & vrf_r0_fu[0];
assign valu_vs2_rvalid = s9 & vrf_r1_fu[0];
assign valu_vs3_rvalid = s10 & vrf_r2_fu[0];
assign valu_vs1_rdata = s19;
assign valu_vs2_rdata = s20;
assign valu_vs3_rdata = s21;
assign valu_vs1_rlast = s30;
assign valu_vs2_rlast = s31;
assign valu_vs3_rlast = s32;
assign vfmis_vs1_rvalid = s9 & vrf_r1_fu[5];
assign vfmis_vs2_rvalid = s10 & vrf_r2_fu[5];
assign vfmis_vs3_rvalid = s8 & vrf_r0_fu[5];
assign vfmis_vs1_rdata = s20;
assign vfmis_vs2_rdata = s21;
assign vfmis_vs3_rdata = s19;
assign vfmis_vs1_rlast = s31;
assign vfmis_vs2_rlast = s32;
assign vfmis_vs3_rlast = s30;
assign vmask_vs1_rvalid = s8 & vrf_r0_fu[8];
assign vmask_vs2_rvalid = s9 & vrf_r1_fu[8];
assign vmask_vs3_rvalid = s10 & vrf_r2_fu[8];
assign vmask_vs1_rdata = s19;
assign vmask_vs2_rdata = s20;
assign vmask_vs3_rdata = s21;
assign vmask_vs1_rlast = s30;
assign vmask_vs2_rlast = s31;
assign vmask_vs3_rlast = s32;
assign vmac_vs1_rvalid = s11 & vrf_r3_fu[3];
assign vmac_vs2_rvalid = s12 & vrf_r4_fu[3];
assign vmac_vs3_rvalid = s13 & vrf_r5_fu[3];
assign vmac_vs1_rdata = s22;
assign vmac_vs2_rdata = s23;
assign vmac_vs3_rdata = s24;
assign vmac_vs1_rlast = s33;
assign vmac_vs2_rlast = s34;
assign vmac_vs3_rlast = s35;
generate
    if (VMAC2_TYPE != 0) begin:gen_vmac2_vs_rvalid
        assign vmac2_vs1_rvalid = s16 & vrf_r8_fu[10];
        assign vmac2_vs2_rvalid = s17 & vrf_r9_fu[10];
        assign vmac2_vs3_rvalid = s18 & vrf_r10_fu[10];
        assign vmac2_vs1_rdata = s27;
        assign vmac2_vs2_rdata = s28;
        assign vmac2_vs3_rdata = s29;
        assign vmac2_vs1_rlast = s38;
        assign vmac2_vs2_rlast = s39;
        assign vmac2_vs3_rlast = s40;
    end
    else begin:gen_vmac2_vs_rvalid_stub
        wire nds_unused_vs8_valid = s16;
        wire nds_unused_vs9_valid = s17;
        wire nds_unused_vs10_valid = s18;
        wire [DLEN - 1:0] nds_unused_vs8_rdata = s27;
        wire [DLEN - 1:0] nds_unused_vs9_rdata = s28;
        wire [DLEN - 1:0] nds_unused_vs10_rdata = s29;
        wire nds_unused_vs8_last = s38;
        wire nds_unused_vs9_last = s39;
        wire nds_unused_vs10_last = s40;
        assign vmac2_vs1_rvalid = 1'b0;
        assign vmac2_vs2_rvalid = 1'b0;
        assign vmac2_vs3_rvalid = 1'b0;
        assign vmac2_vs1_rdata = {DLEN{1'b0}};
        assign vmac2_vs2_rdata = {DLEN{1'b0}};
        assign vmac2_vs3_rdata = {DLEN{1'b0}};
        assign vmac2_vs1_rlast = 1'b0;
        assign vmac2_vs2_rlast = 1'b0;
        assign vmac2_vs3_rlast = 1'b0;
    end
endgenerate
assign vlsu_vs2_rvalid = s14 & vrf_r6_fu[1];
assign vlsu_vs3_rvalid = s15 & vrf_r7_fu[1];
assign vlsu_vs2_rdata = s25;
assign vlsu_vs3_rdata = s26;
assign vlsu_vs2_rlast = s36;
assign vlsu_vs3_rlast = s37;
assign vsp_vs3_rvalid = s15 & vrf_r7_fu[2];
assign vsp_vs3_rdata = s26;
assign vsp_vs3_rlast = s37;
assign vdiv_vs1_rvalid = s14 & vrf_r6_fu[4];
assign vdiv_vs2_rvalid = s15 & vrf_r7_fu[4];
assign vdiv_vs1_rdata = s25;
assign vdiv_vs2_rdata = s26;
assign vdiv_vs1_rlast = s36;
assign vdiv_vs2_rlast = s37;
assign vpermut_vs1_rvalid = s14 & vrf_r6_fu[6];
assign vpermut_vs2_rvalid = s15 & vrf_r7_fu[6];
assign vpermut_vs1_rdata = s25;
assign vpermut_vs2_rdata = s26;
assign vpermut_vs1_rlast = s36;
assign vpermut_vs2_rlast = s37;
assign vfdiv_vs1_rvalid = s14 & vrf_r6_fu[7];
assign vfdiv_vs2_rvalid = s15 & vrf_r7_fu[7];
assign vfdiv_vs1_rdata = s25;
assign vfdiv_vs2_rdata = s26;
assign vfdiv_vs1_rlast = s36;
assign vfdiv_vs2_rlast = s37;
assign vace_vs1_rvalid = s8 & vrf_r0_fu[9];
assign vace_vs2_rvalid = s9 & vrf_r1_fu[9];
assign vace_vs3_rvalid = s10 & vrf_r2_fu[9];
assign vace_vs1_rdata = s19;
assign vace_vs2_rdata = s20;
assign vace_vs3_rdata = s21;
assign vace_vs1_rlast = s30;
assign vace_vs2_rlast = s31;
assign vace_vs3_rlast = s32;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

