// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vdis (
    vpu_clk,
    vpu_reset_n,
    viq_i0_valid,
    viq_i0_ready,
    viq_i0_ctrl,
    viq_i0_instr,
    viq_i0_op1,
    viq_i0_op2,
    viq_i1_valid,
    viq_i1_ready,
    viq_i1_ctrl,
    viq_i1_instr,
    viq_i1_op1,
    viq_i1_op2,
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
    valu_dispatch_valid,
    valu_dispatch_ready,
    valu_dispatch_ctrl,
    valu_dispatch_vxrm,
    valu_dispatch_op1_hazard,
    valu_dispatch_op1,
    valu_dispatch_vs1_len,
    valu_dispatch_vs2_len,
    valu_dispatch_vs3_len,
    valu_dispatch_vd_len,
    vlsu_dispatch_valid,
    vlsu_dispatch_ready,
    vlsu_dispatch_ctrl,
    vlsu_dispatch_op1,
    vlsu_dispatch_op2,
    vlsu_dispatch_vs2_len,
    vlsu_dispatch_vs3_len,
    vlsu_dispatch_vd_len,
    vsp_dispatch_valid,
    vsp_dispatch_ready,
    vsp_dispatch_op1_hazard,
    vsp_dispatch_ctrl,
    vsp_dispatch_op1,
    vsp_dispatch_op2,
    vsp_dispatch_vs3_len,
    vsp_dispatch_vd_len,
    vmac_dispatch_ctrl,
    vmac_dispatch_frm,
    vmac_dispatch_vxrm,
    vmac_dispatch_op1,
    vmac_dispatch_op1_hazard,
    vmac_dispatch_ready,
    vmac_dispatch_valid,
    vmac_dispatch_vs1_len,
    vmac_dispatch_vs2_len,
    vmac_dispatch_vs3_len,
    vmac_dispatch_vd_len,
    vmac2_dispatch_ctrl,
    vmac2_dispatch_frm,
    vmac2_dispatch_vxrm,
    vmac2_dispatch_op1,
    vmac2_dispatch_op1_hazard,
    vmac2_dispatch_ready,
    vmac2_dispatch_valid,
    vmac2_dispatch_vs1_len,
    vmac2_dispatch_vs2_len,
    vmac2_dispatch_vs3_len,
    vmac2_dispatch_vd_len,
    vdiv_dispatch_ctrl,
    vdiv_dispatch_op1,
    vdiv_dispatch_op1_hazard,
    vdiv_dispatch_ready,
    vdiv_dispatch_valid,
    vdiv_dispatch_vs1_len,
    vdiv_dispatch_vs2_len,
    vdiv_dispatch_vd_len,
    vpermut_dispatch_ctrl,
    vpermut_dispatch_op1,
    vpermut_dispatch_op1_hazard,
    vpermut_dispatch_ready,
    vpermut_dispatch_valid,
    vpermut_dispatch_vs1_len,
    vpermut_dispatch_vs2_len,
    vpermut_dispatch_vd_len,
    vfmis_dispatch_ctrl,
    vfmis_dispatch_frm,
    vfmis_dispatch_op1,
    vfmis_dispatch_op1_hazard,
    vfmis_dispatch_ready,
    vfmis_dispatch_valid,
    vfmis_dispatch_vs1_len,
    vfmis_dispatch_vs2_len,
    vfmis_dispatch_vs3_len,
    vfmis_dispatch_vd_len,
    vfdiv_dispatch_ctrl,
    vfdiv_dispatch_op1,
    vfdiv_dispatch_op1_hazard,
    vfdiv_dispatch_ready,
    vfdiv_dispatch_valid,
    vfdiv_dispatch_vs1_len,
    vfdiv_dispatch_vs2_len,
    vfdiv_dispatch_vd_len,
    vfdiv_dispatch_frm,
    vmask_dispatch_ctrl,
    vmask_dispatch_op1,
    vmask_dispatch_op1_hazard,
    vmask_dispatch_ready,
    vmask_dispatch_valid,
    vmask_dispatch_vs1_len,
    vmask_dispatch_vs2_len,
    vmask_dispatch_vs3_len,
    vmask_dispatch_vd_len,
    vace_dispatch_ctrl,
    vace_dispatch_frm,
    vace_dispatch_vxrm,
    vace_dispatch_umisc_ctl,
    vace_dispatch_op1,
    vace_dispatch_op1_hazard,
    vace_dispatch_ready,
    vace_dispatch_valid,
    vace_dispatch_vs1_len,
    vace_dispatch_vs2_len,
    vace_dispatch_vs3_len,
    vace_dispatch_vd_len
);
parameter FLEN = 64;
parameter VLEN = 512;
parameter DLEN = 512;
parameter ELEN = 64;
parameter VALEN = 39;
parameter PALEN = 38;
parameter TL_SINK_WIDTH = 2;
parameter VLSU_DATA_WIDTH = 256;
parameter AGEN = 8;
parameter VRF_AW = 5;
parameter VRF_LW = 3;
parameter QMAC_SUPPORT_INT = 0;
parameter BF16_SUPPORT_INT = 0;
parameter ZVFBFMIN_SUPPORT_INT = 0;
parameter ZVFBFWMA_SUPPORT_INT = 0;
parameter VECTOR_SINT_SUPPORT_INT = 0;
parameter VECTOR_DOT_SUPPORT_INT = 0;
parameter VECTOR_PACKED_FP16_SUPPORT_INT = 0;
parameter INT4_VECTOR_LOAD_SUPPORT_INT = 0;
parameter VMAC2_TYPE = 0;
parameter ACE_STREAM_PORT = 0;
localparam XLEN = 64;
input vpu_clk;
input vpu_reset_n;
input viq_i0_valid;
output viq_i0_ready;
input [(81 - 1):0] viq_i0_ctrl;
input [31:0] viq_i0_instr;
input [(XLEN - 1):0] viq_i0_op1;
input [(XLEN - 1):0] viq_i0_op2;
input viq_i1_valid;
output viq_i1_ready;
input [(81 - 1):0] viq_i1_ctrl;
input [31:0] viq_i1_instr;
input [(XLEN - 1):0] viq_i1_op1;
input [(XLEN - 1):0] viq_i1_op2;
input [AGEN - 1:0] vscb_busy;
input vscb_v0t_write_pending;
output dis_i0_grant;
output [11 - 1:0] dis_i0_fu;
output dis_i0_vs1_en;
output [VRF_AW - 1:0] dis_i0_vs1_addr;
output [VRF_LW - 1:0] dis_i0_vs1_len;
output dis_i0_vs2_en;
output [VRF_AW - 1:0] dis_i0_vs2_addr;
output [VRF_LW - 1:0] dis_i0_vs2_len;
output dis_i0_vs3_en;
output [VRF_AW - 1:0] dis_i0_vs3_addr;
output [VRF_LW - 1:0] dis_i0_vs3_len;
output dis_i0_vd_en;
output [VRF_AW - 1:0] dis_i0_vd_addr;
output [VRF_LW - 1:0] dis_i0_vd_len;
output dis_i1_grant;
output [11 - 1:0] dis_i1_fu;
output dis_i1_vs1_en;
output [VRF_AW - 1:0] dis_i1_vs1_addr;
output [VRF_LW - 1:0] dis_i1_vs1_len;
output dis_i1_vs2_en;
output [VRF_AW - 1:0] dis_i1_vs2_addr;
output [VRF_LW - 1:0] dis_i1_vs2_len;
output dis_i1_vs3_en;
output [VRF_AW - 1:0] dis_i1_vs3_addr;
output [VRF_LW - 1:0] dis_i1_vs3_len;
output dis_i1_vd_en;
output [VRF_AW - 1:0] dis_i1_vd_addr;
output [VRF_LW - 1:0] dis_i1_vd_len;
output valu_dispatch_valid;
input valu_dispatch_ready;
output [58 - 1:0] valu_dispatch_ctrl;
output [1:0] valu_dispatch_vxrm;
output valu_dispatch_op1_hazard;
output [XLEN - 1:0] valu_dispatch_op1;
output [VRF_LW - 1:0] valu_dispatch_vs1_len;
output [VRF_LW - 1:0] valu_dispatch_vs2_len;
output [VRF_LW - 1:0] valu_dispatch_vs3_len;
output [VRF_LW - 1:0] valu_dispatch_vd_len;
output vlsu_dispatch_valid;
input vlsu_dispatch_ready;
output [55 - 1:0] vlsu_dispatch_ctrl;
output [XLEN - 1:0] vlsu_dispatch_op1;
output [XLEN - 1:0] vlsu_dispatch_op2;
output [VRF_LW - 1:0] vlsu_dispatch_vs2_len;
output [VRF_LW - 1:0] vlsu_dispatch_vs3_len;
output [VRF_LW - 1:0] vlsu_dispatch_vd_len;
output vsp_dispatch_valid;
input vsp_dispatch_ready;
output vsp_dispatch_op1_hazard;
output [30 - 1:0] vsp_dispatch_ctrl;
output [XLEN - 1:0] vsp_dispatch_op1;
output [XLEN - 1:0] vsp_dispatch_op2;
output [VRF_LW - 1:0] vsp_dispatch_vs3_len;
output [VRF_LW - 1:0] vsp_dispatch_vd_len;
output [(58 - 1):0] vmac_dispatch_ctrl;
output [2:0] vmac_dispatch_frm;
output [1:0] vmac_dispatch_vxrm;
output [(XLEN - 1):0] vmac_dispatch_op1;
output vmac_dispatch_op1_hazard;
input vmac_dispatch_ready;
output vmac_dispatch_valid;
output [VRF_LW - 1:0] vmac_dispatch_vs1_len;
output [VRF_LW - 1:0] vmac_dispatch_vs2_len;
output [VRF_LW - 1:0] vmac_dispatch_vs3_len;
output [VRF_LW - 1:0] vmac_dispatch_vd_len;
output [(58 - 1):0] vmac2_dispatch_ctrl;
output [2:0] vmac2_dispatch_frm;
output [1:0] vmac2_dispatch_vxrm;
output [(XLEN - 1):0] vmac2_dispatch_op1;
output vmac2_dispatch_op1_hazard;
input vmac2_dispatch_ready;
output vmac2_dispatch_valid;
output [VRF_LW - 1:0] vmac2_dispatch_vs1_len;
output [VRF_LW - 1:0] vmac2_dispatch_vs2_len;
output [VRF_LW - 1:0] vmac2_dispatch_vs3_len;
output [VRF_LW - 1:0] vmac2_dispatch_vd_len;
output [(30 - 1):0] vdiv_dispatch_ctrl;
output [(XLEN - 1):0] vdiv_dispatch_op1;
output vdiv_dispatch_op1_hazard;
input vdiv_dispatch_ready;
output vdiv_dispatch_valid;
output [VRF_LW - 1:0] vdiv_dispatch_vs1_len;
output [VRF_LW - 1:0] vdiv_dispatch_vs2_len;
output [VRF_LW - 1:0] vdiv_dispatch_vd_len;
output [(41 - 1):0] vpermut_dispatch_ctrl;
output [(XLEN - 1):0] vpermut_dispatch_op1;
output vpermut_dispatch_op1_hazard;
input vpermut_dispatch_ready;
output vpermut_dispatch_valid;
output [VRF_LW - 1:0] vpermut_dispatch_vs1_len;
output [VRF_LW - 1:0] vpermut_dispatch_vs2_len;
output [VRF_LW - 1:0] vpermut_dispatch_vd_len;
output [(71 - 1):0] vfmis_dispatch_ctrl;
output [2:0] vfmis_dispatch_frm;
output [(XLEN - 1):0] vfmis_dispatch_op1;
output vfmis_dispatch_op1_hazard;
input vfmis_dispatch_ready;
output vfmis_dispatch_valid;
output [VRF_LW - 1:0] vfmis_dispatch_vs1_len;
output [VRF_LW - 1:0] vfmis_dispatch_vs2_len;
output [VRF_LW - 1:0] vfmis_dispatch_vs3_len;
output [VRF_LW - 1:0] vfmis_dispatch_vd_len;
output [(39 - 1):0] vfdiv_dispatch_ctrl;
output [(XLEN - 1):0] vfdiv_dispatch_op1;
output vfdiv_dispatch_op1_hazard;
input vfdiv_dispatch_ready;
output vfdiv_dispatch_valid;
output [VRF_LW - 1:0] vfdiv_dispatch_vs1_len;
output [VRF_LW - 1:0] vfdiv_dispatch_vs2_len;
output [VRF_LW - 1:0] vfdiv_dispatch_vd_len;
output [2:0] vfdiv_dispatch_frm;
output [(44 - 1):0] vmask_dispatch_ctrl;
output [(XLEN - 1):0] vmask_dispatch_op1;
output vmask_dispatch_op1_hazard;
input vmask_dispatch_ready;
output vmask_dispatch_valid;
output [VRF_LW - 1:0] vmask_dispatch_vs1_len;
output [VRF_LW - 1:0] vmask_dispatch_vs2_len;
output [VRF_LW - 1:0] vmask_dispatch_vs3_len;
output [VRF_LW - 1:0] vmask_dispatch_vd_len;
output [(86 - 1):0] vace_dispatch_ctrl;
output [2:0] vace_dispatch_frm;
output [1:0] vace_dispatch_vxrm;
output [3:0] vace_dispatch_umisc_ctl;
output [(XLEN - 1):0] vace_dispatch_op1;
output vace_dispatch_op1_hazard;
input vace_dispatch_ready;
output vace_dispatch_valid;
output [VRF_LW - 1:0] vace_dispatch_vs1_len;
output [VRF_LW - 1:0] vace_dispatch_vs2_len;
output [VRF_LW - 1:0] vace_dispatch_vs3_len;
output [VRF_LW - 1:0] vace_dispatch_vd_len;





// dee2b08e rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0 = 1'b0;
wire s1 = 1'b0;
wire [(XLEN - 1):0] s2 = {XLEN{1'b0}};
wire [(XLEN - 1):0] s3 = {XLEN{1'b0}};
wire s4 = viq_i0_valid;
wire [31:0] s5 = viq_i0_instr;
wire [7:0] s6 = viq_i0_ctrl[71 +:8];
wire [1:0] s7 = viq_i0_ctrl[3 +:2];
wire [9:0] s8 = viq_i0_ctrl[61 +:10];
wire [10:0] s9 = viq_i0_ctrl[38 +:11];
wire [2:0] s10 = viq_i0_ctrl[5 +:3];
wire [1:0] s11 = viq_i0_ctrl[79 +:2];
wire [3:0] s12 = {viq_i0_ctrl[1 +:2],viq_i0_ctrl[3 +:2]};
wire [1:0] s13 = viq_i0_ctrl[19 +:2];
wire s14 = viq_i0_ctrl[0];
wire s15 = viq_i0_ctrl[22];
wire s16 = viq_i0_ctrl[21];
wire s17 = viq_i0_ctrl[23];
wire s18 = viq_i0_ctrl[24];
wire s19 = viq_i0_ctrl[30];
wire [3:0] s20 = viq_i0_ctrl[26 +:4];
wire s21 = viq_i0_ctrl[9];
wire s22 = viq_i0_ctrl[13];
wire s23 = viq_i0_ctrl[18];
wire s24 = viq_i0_ctrl[14];
wire s25;
wire s26 = viq_i0_ctrl[10];
wire s27 = viq_i0_ctrl[12];
wire s28 = viq_i0_ctrl[17];
wire s29 = viq_i0_ctrl[11];
wire s30 = viq_i0_ctrl[16];
wire s31 = viq_i0_ctrl[8];
wire s32 = viq_i0_ctrl[37];
wire s33 = viq_i0_ctrl[52];
wire s34 = viq_i0_ctrl[56];
wire s35 = viq_i0_ctrl[60];
wire [2:0] s36 = viq_i0_ctrl[34 +:3];
wire [2:0] s37 = viq_i0_ctrl[49 +:3];
wire [2:0] s38 = viq_i0_ctrl[53 +:3];
wire [2:0] s39 = viq_i0_ctrl[57 +:3];
wire s40 = viq_i0_ctrl[25] | s0;
wire s41 = viq_i0_ctrl[33];
wire [XLEN - 1:0] s42 = {XLEN{~s0}} & viq_i0_op1 | {XLEN{s0}} & s2;
wire [XLEN - 1:0] s43 = viq_i0_op2;
wire s44 = viq_i1_valid;
wire [31:0] s45 = viq_i1_instr;
wire [7:0] s46 = viq_i1_ctrl[71 +:8];
wire [1:0] s47 = viq_i1_ctrl[3 +:2];
wire [9:0] s48 = viq_i1_ctrl[61 +:10];
wire [10:0] s49 = viq_i1_ctrl[38 +:11];
wire [2:0] s50 = viq_i1_ctrl[5 +:3];
wire [1:0] s51 = viq_i1_ctrl[79 +:2];
wire [3:0] s52 = {viq_i1_ctrl[1 +:2],viq_i1_ctrl[3 +:2]};
wire [1:0] s53 = viq_i1_ctrl[19 +:2];
wire s54 = viq_i1_ctrl[0];
wire s55 = viq_i1_ctrl[22];
wire s56 = viq_i1_ctrl[21];
wire s57 = viq_i1_ctrl[23];
wire s58 = viq_i1_ctrl[24];
wire s59 = viq_i1_ctrl[30];
wire [3:0] s60 = viq_i1_ctrl[26 +:4];
wire s61 = viq_i1_ctrl[13];
wire s62 = viq_i1_ctrl[18];
wire s63 = viq_i1_ctrl[9];
wire s64 = viq_i1_ctrl[14];
wire s65;
wire s66 = viq_i1_ctrl[10];
wire s67 = viq_i1_ctrl[12];
wire s68 = viq_i1_ctrl[17];
wire s69 = viq_i1_ctrl[11];
wire s70 = viq_i1_ctrl[16];
wire s71 = viq_i1_ctrl[8];
wire s72 = viq_i1_ctrl[37];
wire s73 = viq_i1_ctrl[52];
wire s74 = viq_i1_ctrl[56];
wire s75 = viq_i1_ctrl[60];
wire [2:0] s76 = viq_i1_ctrl[34 +:3];
wire [2:0] s77 = viq_i1_ctrl[49 +:3];
wire [2:0] s78 = viq_i1_ctrl[53 +:3];
wire [2:0] s79 = viq_i1_ctrl[57 +:3];
wire s80 = viq_i1_ctrl[25] | s1;
wire s81 = viq_i1_ctrl[33];
wire [XLEN - 1:0] s82 = {XLEN{~s1}} & viq_i1_op1 | {XLEN{s1}} & s3;
wire [XLEN - 1:0] s83 = viq_i1_op2;
wire [4:0] s84;
wire [4:0] s85;
wire [4:0] s86;
wire [4:0] s87;
wire s88;
wire s89;
wire s90;
wire s91;
wire [4:0] s92;
wire [4:0] s93;
wire [4:0] s94;
wire [4:0] s95;
wire s96;
wire s97;
wire s98;
wire s99;
wire s100;
wire s101;
wire s102;
wire s103;
wire [103 - 1:0] nds_unused_i0_decode;
wire [103 - 1:0] nds_unused_i1_decode;
wire [58 - 1:0] s104;
wire [58 - 1:0] s105;
wire [55 - 1:0] s106;
wire [55 - 1:0] s107;
wire [30 - 1:0] s108;
wire [30 - 1:0] s109;
wire [58 - 1:0] s110;
wire [58 - 1:0] s111;
wire [30 - 1:0] s112;
wire [30 - 1:0] s113;
wire [71 - 1:0] s114;
wire [71 - 1:0] s115;
wire [41 - 1:0] s116;
wire [41 - 1:0] s117;
wire [39 - 1:0] s118;
wire [39 - 1:0] s119;
wire [44 - 1:0] s120;
wire [44 - 1:0] s121;
wire [86 - 1:0] s122;
wire [86 - 1:0] s123;
wire [1:0] s124;
wire [1:0] s125;
wire [1:0] s126;
wire [1:0] s127;
wire [1:0] s128;
wire [1:0] s129;
wire [1:0] s130;
wire [1:0] s131;
wire [1:0] s132;
wire [1:0] s133;
wire [1:0] s134;
wire s135;
wire s136;
wire s137;
wire s138;
wire s139;
wire s140;
wire s141;
wire s142;
wire s143 = 1'b0;
wire s144 = 1'b0;
wire s145;
reg [AGEN - 1:0] s146;
wire [AGEN - 1:0] s147 = {s146[AGEN - 2:0],s146[AGEN - 1]};
wire [AGEN - 1:0] s148 = {s146[AGEN - 3:0],s146[AGEN - 1:AGEN - 2]};
wire [AGEN - 1:0] s149;
wire [AGEN - 1:0] s150 = s146;
wire [AGEN - 1:0] s151 = s147;
wire s152 = s4 & ~s141;
wire s153 = s44 & ~s142;
generate
    if (VMAC2_TYPE != 0) begin:gen_fu_vmac2
        assign s25 = viq_i0_ctrl[15];
        assign s65 = viq_i1_ctrl[15];
    end
    else begin:gen_fu_vmac2_stub
        assign s25 = 1'b0;
        assign s65 = 1'b0;
    end
endgenerate
wire [11 - 1:0] s154 = {s25,s31,s30,s29,s28,s27,s26,s24,s23,s22,s21};
wire [11 - 1:0] s155 = {s65,s71,s70,s69,s68,s67,s66,s64,s62,s61,s63};
wire s156 = |(s154 & s155);
assign s124 = (s4 & s21) ? 2'b01 : 2'b10;
assign s125 = (s4 & s22) ? 2'b01 : 2'b10;
assign s126 = (s4 & s23) ? 2'b01 : 2'b10;
assign s127 = (s4 & s24) ? 2'b01 : 2'b10;
assign s128 = (s4 & s25) ? 2'b01 : 2'b10;
assign s129 = (s4 & s26) ? 2'b01 : 2'b10;
assign s130 = (s4 & s27) ? 2'b01 : 2'b10;
assign s131 = (s4 & s28) ? 2'b01 : 2'b10;
assign s132 = (s4 & s29) ? 2'b01 : 2'b10;
assign s133 = (s4 & s30) ? 2'b01 : 2'b10;
assign s134 = (s4 & s31) ? 2'b01 : 2'b10;
assign s135 = (s21 & valu_dispatch_ready) | (s22 & vlsu_dispatch_ready) | (s23 & vsp_dispatch_ready) | (s24 & vmac_dispatch_ready) | (s27 & vfmis_dispatch_ready) | (s28 & vpermut_dispatch_ready) | (s26 & vdiv_dispatch_ready) | (s29 & vfdiv_dispatch_ready) | (s30 & vmask_dispatch_ready) | (s31 & vace_dispatch_ready) | (s25 & vmac2_dispatch_ready);
assign s136 = (s63 & valu_dispatch_ready) | (s61 & vlsu_dispatch_ready) | (s62 & vsp_dispatch_ready) | (s64 & vmac_dispatch_ready) | (s67 & vfmis_dispatch_ready) | (s68 & vpermut_dispatch_ready) | (s66 & vdiv_dispatch_ready) | (s69 & vfdiv_dispatch_ready) | (s70 & vmask_dispatch_ready) | (s71 & vace_dispatch_ready) | (s65 & vmac2_dispatch_ready);
assign s139 = s152 & s135;
assign s140 = s153 & s136 & ~s142;
assign s137 = s135 & ~s141;
assign s138 = s136 & ~s142;
assign s102 = s41 & vscb_v0t_write_pending;
assign s103 = (s81 & vscb_v0t_write_pending) | (s91 & (s87 == 5'd0));
assign s141 = s100 | s102 | s143;
assign s142 = s141 | s101 | ~s135 | s156 | s103 | s144;
assign viq_i0_ready = s137;
assign viq_i1_ready = s138;
always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s146 <= {{(AGEN - 1){1'b0}},1'b1};
    end
    else if (s145) begin
        s146 <= s149;
    end
end

assign s145 = dis_i0_grant;
assign s149 = dis_i1_grant ? s148 : s147;
kv_mux_onehot #(
    .N(AGEN),
    .W(1)
) u_i0_vrf_busy (
    .out(s100),
    .sel(s150),
    .in(vscb_busy)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(1)
) u_i1_vrf_busy (
    .out(s101),
    .sel(s151),
    .in(vscb_busy)
);
assign s84 = s5[19:15];
assign s85 = s5[24:20];
assign s86 = s5[11:7];
assign s87 = s5[11:7];
assign s88 = s33;
assign s89 = s34;
assign s90 = s35;
assign s91 = s32;
assign s92 = s45[19:15];
assign s93 = s45[24:20];
assign s94 = s45[11:7];
assign s95 = s45[11:7];
assign s96 = s73;
assign s97 = s74;
assign s98 = s75;
assign s99 = s72;
assign dis_i0_grant = s139;
assign dis_i0_fu = s154;
assign dis_i0_vs1_en = s88;
assign dis_i0_vs2_en = s89;
assign dis_i0_vs3_en = s90;
assign dis_i0_vd_en = s91;
assign dis_i1_grant = s140;
assign dis_i1_fu = s155;
assign dis_i1_vs1_en = s96;
assign dis_i1_vs2_en = s97;
assign dis_i1_vs3_en = s98;
assign dis_i1_vd_en = s99;
generate
    if (VLEN == DLEN) begin:gen_dis_addr
        assign dis_i0_vs1_addr = s84;
        assign dis_i0_vs2_addr = s85;
        assign dis_i0_vs3_addr = s86;
        assign dis_i0_vd_addr = s87;
        assign dis_i0_vs1_len = s37;
        assign dis_i0_vs2_len = s38;
        assign dis_i0_vs3_len = s39;
        assign dis_i0_vd_len = s36;
        assign dis_i1_vs1_addr = s92;
        assign dis_i1_vs2_addr = s93;
        assign dis_i1_vs3_addr = s94;
        assign dis_i1_vd_addr = s95;
        assign dis_i1_vs1_len = s77;
        assign dis_i1_vs2_len = s78;
        assign dis_i1_vs3_len = s79;
        assign dis_i1_vd_len = s76;
    end
    else begin:gen_dis_addr_ext
        assign dis_i0_vs1_addr = {s84,1'b0};
        assign dis_i0_vs2_addr = {s85,1'b0};
        assign dis_i0_vs3_addr = {s86,1'b0};
        assign dis_i0_vd_addr = {s87,1'b0};
        assign dis_i0_vs1_len = {s37,1'b1};
        assign dis_i0_vs2_len = {s38,1'b1};
        assign dis_i0_vs3_len = {s39,1'b1};
        assign dis_i0_vd_len = {s36,1'b1};
        assign dis_i1_vs1_addr = {s92,1'b0};
        assign dis_i1_vs2_addr = {s93,1'b0};
        assign dis_i1_vs3_addr = {s94,1'b0};
        assign dis_i1_vd_addr = {s95,1'b0};
        assign dis_i1_vs1_len = {s77,1'b1};
        assign dis_i1_vs2_len = {s78,1'b1};
        assign dis_i1_vs3_len = {s79,1'b1};
        assign dis_i1_vd_len = {s76,1'b1};
    end
endgenerate
wire s157;
wire [5:0] s158;
wire s159;
wire s160;
wire s161;
wire [4:0] s162;
wire [1:0] s163;
wire [4:0] s164;
wire s165;
wire [5:0] s166;
wire s167;
wire s168;
wire s169;
wire [4:0] s170;
wire [1:0] s171;
wire [4:0] s172;
generate
    if (ACE_STREAM_PORT == 1) begin:gen_ace_stream_port
        wire nds_unused_i0_ace_dec_xrf_rs1_ren;
        wire nds_unused_i0_ace_dec_xrf_rs2_ren;
        wire nds_unused_i0_ace_dec_xrf_rs3_ren;
        wire nds_unused_i0_ace_dec_xrf_rs4_ren;
        wire nds_unused_i0_ace_dec_xrf_rd1_wen;
        wire nds_unused_i0_ace_dec_xrf_rd2_wen;
        wire nds_unused_i0_ace_dec_frf_rs1_ren;
        wire nds_unused_i0_ace_dec_frf_rs2_ren;
        wire nds_unused_i0_ace_dec_frf_rd1_wen;
        wire nds_unused_i0_ace_dec_vrf_rs1_ren;
        wire nds_unused_i0_ace_dec_vrf_rs2_ren;
        wire nds_unused_i0_ace_dec_vrf_rd1_wen;
        wire [4:0] nds_unused_i0_ace_dec_rs1_index;
        wire [4:0] nds_unused_i0_ace_dec_rs2_index;
        wire [4:0] nds_unused_i0_ace_dec_rs3_index;
        wire [4:0] nds_unused_i0_ace_dec_rs4_index;
        wire [4:0] nds_unused_i0_ace_dec_rd1_index;
        wire [4:0] nds_unused_i0_ace_dec_rd2_index;
        wire nds_unused_i0_ace_dec_illegal_insn;
        wire nds_unused_i0_ace_dec_xcpt;
        wire [5:0] nds_unused_i0_ace_dec_xcpt_cause;
        wire nds_unused_i0_ace_dec_sync_en;
        wire nds_unused_i0_ace_dec_acr_wen;
        wire nds_unused_i1_ace_dec_xrf_rs1_ren;
        wire nds_unused_i1_ace_dec_xrf_rs2_ren;
        wire nds_unused_i1_ace_dec_xrf_rs3_ren;
        wire nds_unused_i1_ace_dec_xrf_rs4_ren;
        wire nds_unused_i1_ace_dec_xrf_rd1_wen;
        wire nds_unused_i1_ace_dec_xrf_rd2_wen;
        wire nds_unused_i1_ace_dec_frf_rs1_ren;
        wire nds_unused_i1_ace_dec_frf_rs2_ren;
        wire nds_unused_i1_ace_dec_frf_rd1_wen;
        wire nds_unused_i1_ace_dec_vrf_rs1_ren;
        wire nds_unused_i1_ace_dec_vrf_rs2_ren;
        wire nds_unused_i1_ace_dec_vrf_rd1_wen;
        wire [4:0] nds_unused_i1_ace_dec_rs1_index;
        wire [4:0] nds_unused_i1_ace_dec_rs2_index;
        wire [4:0] nds_unused_i1_ace_dec_rs3_index;
        wire [4:0] nds_unused_i1_ace_dec_rs4_index;
        wire [4:0] nds_unused_i1_ace_dec_rd1_index;
        wire [4:0] nds_unused_i1_ace_dec_rd2_index;
        wire nds_unused_i1_ace_dec_illegal_insn;
        wire nds_unused_i1_ace_dec_xcpt;
        wire [5:0] nds_unused_i1_ace_dec_xcpt_cause;
        wire nds_unused_i1_ace_dec_sync_en;
        wire nds_unused_i1_ace_dec_acr_wen;
        kv_ace_predec u_i0_ace_predec(
            .ace_dec_inst(s5),
            .cur_privilege_m(1'b0),
            .cur_privilege_s(1'b0),
            .cur_privilege_u(1'b0),
            .ace_dec_xrf_rs1_ren(nds_unused_i0_ace_dec_xrf_rs1_ren),
            .ace_dec_xrf_rs2_ren(nds_unused_i0_ace_dec_xrf_rs2_ren),
            .ace_dec_xrf_rs3_ren(nds_unused_i0_ace_dec_xrf_rs3_ren),
            .ace_dec_xrf_rs4_ren(nds_unused_i0_ace_dec_xrf_rs4_ren),
            .ace_dec_xrf_rd1_wen(nds_unused_i0_ace_dec_xrf_rd1_wen),
            .ace_dec_xrf_rd2_wen(nds_unused_i0_ace_dec_xrf_rd2_wen),
            .ace_dec_frf_rs1_ren(nds_unused_i0_ace_dec_frf_rs1_ren),
            .ace_dec_frf_rs2_ren(nds_unused_i0_ace_dec_frf_rs2_ren),
            .ace_dec_frf_rd1_wen(nds_unused_i0_ace_dec_frf_rd1_wen),
            .ace_dec_vrf_rs1_ren(nds_unused_i0_ace_dec_vrf_rs1_ren),
            .ace_dec_vrf_rs2_ren(nds_unused_i0_ace_dec_vrf_rs2_ren),
            .ace_dec_vrf_rd1_wen(nds_unused_i0_ace_dec_vrf_rd1_wen),
            .ace_dec_rs1_index(nds_unused_i0_ace_dec_rs1_index),
            .ace_dec_rs2_index(nds_unused_i0_ace_dec_rs2_index),
            .ace_dec_rs3_index(nds_unused_i0_ace_dec_rs3_index),
            .ace_dec_rs4_index(nds_unused_i0_ace_dec_rs4_index),
            .ace_dec_rd1_index(nds_unused_i0_ace_dec_rd1_index),
            .ace_dec_rd2_index(nds_unused_i0_ace_dec_rd2_index),
            .ace_dec_illegal_insn(nds_unused_i0_ace_dec_illegal_insn),
            .ace_dec_xcpt(nds_unused_i0_ace_dec_xcpt),
            .ace_dec_xcpt_cause(nds_unused_i0_ace_dec_xcpt_cause),
            .ace_dec_sync_en(nds_unused_i0_ace_dec_sync_en),
            .ace_dec_acr_wen(nds_unused_i0_ace_dec_acr_wen),
            .ace_dec_streaming_func_valid(s157),
            .ace_dec_streaming_func(s158),
            .ace_dec_streaming_type2(s159),
            .ace_dec_streaming_type3(s160),
            .ace_dec_streaming_offset_en(s161),
            .ace_dec_streaming_offset_index(s162),
            .ace_dec_streaming_rf_type(s163),
            .ace_dec_streaming_rf_index(s164)
        );
        kv_ace_predec u_i1_ace_predec(
            .ace_dec_inst(s45),
            .cur_privilege_m(1'b0),
            .cur_privilege_s(1'b0),
            .cur_privilege_u(1'b0),
            .ace_dec_xrf_rs1_ren(nds_unused_i1_ace_dec_xrf_rs1_ren),
            .ace_dec_xrf_rs2_ren(nds_unused_i1_ace_dec_xrf_rs2_ren),
            .ace_dec_xrf_rs3_ren(nds_unused_i1_ace_dec_xrf_rs3_ren),
            .ace_dec_xrf_rs4_ren(nds_unused_i1_ace_dec_xrf_rs4_ren),
            .ace_dec_xrf_rd1_wen(nds_unused_i1_ace_dec_xrf_rd1_wen),
            .ace_dec_xrf_rd2_wen(nds_unused_i1_ace_dec_xrf_rd2_wen),
            .ace_dec_frf_rs1_ren(nds_unused_i1_ace_dec_frf_rs1_ren),
            .ace_dec_frf_rs2_ren(nds_unused_i1_ace_dec_frf_rs2_ren),
            .ace_dec_frf_rd1_wen(nds_unused_i1_ace_dec_frf_rd1_wen),
            .ace_dec_vrf_rs1_ren(nds_unused_i1_ace_dec_vrf_rs1_ren),
            .ace_dec_vrf_rs2_ren(nds_unused_i1_ace_dec_vrf_rs2_ren),
            .ace_dec_vrf_rd1_wen(nds_unused_i1_ace_dec_vrf_rd1_wen),
            .ace_dec_rs1_index(nds_unused_i1_ace_dec_rs1_index),
            .ace_dec_rs2_index(nds_unused_i1_ace_dec_rs2_index),
            .ace_dec_rs3_index(nds_unused_i1_ace_dec_rs3_index),
            .ace_dec_rs4_index(nds_unused_i1_ace_dec_rs4_index),
            .ace_dec_rd1_index(nds_unused_i1_ace_dec_rd1_index),
            .ace_dec_rd2_index(nds_unused_i1_ace_dec_rd2_index),
            .ace_dec_illegal_insn(nds_unused_i1_ace_dec_illegal_insn),
            .ace_dec_xcpt(nds_unused_i1_ace_dec_xcpt),
            .ace_dec_xcpt_cause(nds_unused_i1_ace_dec_xcpt_cause),
            .ace_dec_sync_en(nds_unused_i1_ace_dec_sync_en),
            .ace_dec_acr_wen(nds_unused_i1_ace_dec_acr_wen),
            .ace_dec_streaming_func_valid(s165),
            .ace_dec_streaming_func(s166),
            .ace_dec_streaming_type2(s167),
            .ace_dec_streaming_type3(s168),
            .ace_dec_streaming_offset_en(s169),
            .ace_dec_streaming_offset_index(s170),
            .ace_dec_streaming_rf_type(s171),
            .ace_dec_streaming_rf_index(s172)
        );
    end
    else begin:gen_ace_stream_port_stub
        assign s157 = 1'b0;
        assign s158 = 6'b0;
        assign s159 = 1'b0;
        assign s160 = 1'b0;
        assign s161 = 1'b0;
        assign s162 = 5'b0;
        assign s163 = 2'b0;
        assign s164 = 5'b0;
        assign s165 = 1'b0;
        assign s166 = 6'b0;
        assign s167 = 1'b0;
        assign s168 = 1'b0;
        assign s169 = 1'b0;
        assign s170 = 5'b0;
        assign s171 = 2'b0;
        assign s172 = 5'b0;
    end
endgenerate
kv_vdec #(
    .VLEN(VLEN),
    .ELEN(ELEN),
    .FLEN(FLEN),
    .BF16_SUPPORT_INT(BF16_SUPPORT_INT),
    .ZVFBFMIN_SUPPORT_INT(ZVFBFMIN_SUPPORT_INT),
    .ZVFBFWMA_SUPPORT_INT(ZVFBFWMA_SUPPORT_INT),
    .VECTOR_SINT_SUPPORT_INT(VECTOR_SINT_SUPPORT_INT),
    .VECTOR_DOT_SUPPORT_INT(VECTOR_DOT_SUPPORT_INT),
    .VECTOR_PACKED_FP16_SUPPORT_INT(VECTOR_PACKED_FP16_SUPPORT_INT),
    .INT4_VECTOR_LOAD_SUPPORT_INT(INT4_VECTOR_LOAD_SUPPORT_INT),
    .QMAC_SUPPORT_INT(QMAC_SUPPORT_INT)
) u_i0_dec (
    .instr(s5),
    .rvcompm(1'b0),
    .vtype(s6),
    .fp_mode(s7),
    .vl(s9),
    .vstart(s8),
    .ls_privilege(s13),
    .c2nc(s14),
    .milmb_ien(s15),
    .mdlmb_den(s16),
    .mstatus_mxr(s17),
    .mstatus_sum(s18),
    .va2pa_en(s19),
    .satp_mode(s20),
    .decode(nds_unused_i0_decode),
    .valu_ctrl(s104),
    .vlsu_ctrl(s106),
    .vsp_ctrl(s108),
    .vmac_ctrl(s110),
    .vdiv_ctrl(s112),
    .vfmis_ctrl(s114),
    .vpermut_ctrl(s116),
    .vfdiv_ctrl(s118),
    .vmask_ctrl(s120),
    .vace_ctrl(s122),
    .ace_dec_streaming_func_valid(s157),
    .ace_dec_streaming_func(s158),
    .ace_dec_streaming_type2(s159),
    .ace_dec_streaming_type3(s160),
    .ace_dec_streaming_offset_en(s161),
    .ace_dec_streaming_offset_index(s162),
    .ace_dec_streaming_rf_type(s163),
    .ace_dec_streaming_rf_index(s164)
);
kv_vdec #(
    .VLEN(VLEN),
    .ELEN(ELEN),
    .FLEN(FLEN),
    .BF16_SUPPORT_INT(BF16_SUPPORT_INT),
    .ZVFBFMIN_SUPPORT_INT(ZVFBFMIN_SUPPORT_INT),
    .ZVFBFWMA_SUPPORT_INT(ZVFBFWMA_SUPPORT_INT),
    .VECTOR_SINT_SUPPORT_INT(VECTOR_SINT_SUPPORT_INT),
    .VECTOR_DOT_SUPPORT_INT(VECTOR_DOT_SUPPORT_INT),
    .VECTOR_PACKED_FP16_SUPPORT_INT(VECTOR_PACKED_FP16_SUPPORT_INT),
    .INT4_VECTOR_LOAD_SUPPORT_INT(INT4_VECTOR_LOAD_SUPPORT_INT),
    .QMAC_SUPPORT_INT(QMAC_SUPPORT_INT)
) u_i1_dec (
    .instr(s45),
    .rvcompm(1'b0),
    .vtype(s46),
    .fp_mode(s47),
    .vl(s49),
    .vstart(s48),
    .ls_privilege(s53),
    .c2nc(s54),
    .milmb_ien(s55),
    .mdlmb_den(s56),
    .mstatus_mxr(s57),
    .mstatus_sum(s58),
    .va2pa_en(s59),
    .satp_mode(s60),
    .decode(nds_unused_i1_decode),
    .valu_ctrl(s105),
    .vlsu_ctrl(s107),
    .vsp_ctrl(s109),
    .vmac_ctrl(s111),
    .vdiv_ctrl(s113),
    .vfmis_ctrl(s115),
    .vpermut_ctrl(s117),
    .vfdiv_ctrl(s119),
    .vmask_ctrl(s121),
    .vace_ctrl(s123),
    .ace_dec_streaming_func_valid(s165),
    .ace_dec_streaming_func(s166),
    .ace_dec_streaming_type2(s167),
    .ace_dec_streaming_type3(s168),
    .ace_dec_streaming_offset_en(s169),
    .ace_dec_streaming_offset_index(s170),
    .ace_dec_streaming_rf_type(s171),
    .ace_dec_streaming_rf_index(s172)
);
kv_mux_onehot #(
    .N(2),
    .W(2 + VRF_LW * 4 + 58 + XLEN + 1)
) u_valu_dispatch (
    .out({valu_dispatch_vxrm,valu_dispatch_vd_len,valu_dispatch_vs3_len,valu_dispatch_vs2_len,valu_dispatch_vs1_len,valu_dispatch_ctrl,valu_dispatch_op1,valu_dispatch_op1_hazard}),
    .sel(s124),
    .in({s51,dis_i1_vd_len,dis_i1_vs3_len,dis_i1_vs2_len,dis_i1_vs1_len,s105,s82,s80,s11,dis_i0_vd_len,dis_i0_vs3_len,dis_i0_vs2_len,dis_i0_vs1_len,s104,s42,s40})
);
assign valu_dispatch_valid = (s152 & s21) | (s153 & s63);
kv_mux_onehot #(
    .N(2),
    .W(VRF_LW * 3 + 55 + XLEN + XLEN)
) u_vlsu_dispatch (
    .out({vlsu_dispatch_vd_len,vlsu_dispatch_vs3_len,vlsu_dispatch_vs2_len,vlsu_dispatch_ctrl,vlsu_dispatch_op2,vlsu_dispatch_op1}),
    .sel(s125),
    .in({dis_i1_vd_len,dis_i1_vs3_len,dis_i1_vs2_len,s107,s83,s82,dis_i0_vd_len,dis_i0_vs3_len,dis_i0_vs2_len,s106,s43,s42})
);
assign vlsu_dispatch_valid = (s152 & s22) | (s153 & s61);
kv_mux_onehot #(
    .N(2),
    .W(VRF_LW * 2 + 30 + XLEN + XLEN + 1)
) u_vsp_dispatch (
    .out({vsp_dispatch_vd_len,vsp_dispatch_vs3_len,vsp_dispatch_ctrl,vsp_dispatch_op2,vsp_dispatch_op1,vsp_dispatch_op1_hazard}),
    .sel(s126),
    .in({dis_i1_vd_len,dis_i1_vs3_len,s109,s83,s82,s80,dis_i0_vd_len,dis_i0_vs3_len,s108,s43,s42,s40})
);
assign vsp_dispatch_valid = (s152 & s23) | (s153 & s62);
assign vmac_dispatch_valid = (s152 & s24) | (s153 & s64);
kv_mux_onehot #(
    .N(2),
    .W(3 + 2 + VRF_LW * 4 + 58 + XLEN + 1)
) u_vmac_dispatch (
    .out({vmac_dispatch_frm,vmac_dispatch_vxrm,vmac_dispatch_vd_len,vmac_dispatch_vs3_len,vmac_dispatch_vs2_len,vmac_dispatch_vs1_len,vmac_dispatch_ctrl,vmac_dispatch_op1,vmac_dispatch_op1_hazard}),
    .sel(s127),
    .in({s50,s51,dis_i1_vd_len,dis_i1_vs3_len,dis_i1_vs2_len,dis_i1_vs1_len,s111,s82,s80,s10,s11,dis_i0_vd_len,dis_i0_vs3_len,dis_i0_vs2_len,dis_i0_vs1_len,s110,s42,s40})
);
generate
    if (VMAC2_TYPE != 0) begin:gen_vmac2_dispatch
        assign vmac2_dispatch_valid = (s152 & s25) | (s153 & s65);
        kv_mux_onehot #(
            .N(2),
            .W(3 + 2 + VRF_LW * 4 + 58 + XLEN + 1)
        ) u_vmac_dispatch (
            .out({vmac2_dispatch_frm,vmac2_dispatch_vxrm,vmac2_dispatch_vd_len,vmac2_dispatch_vs3_len,vmac2_dispatch_vs2_len,vmac2_dispatch_vs1_len,vmac2_dispatch_ctrl,vmac2_dispatch_op1,vmac2_dispatch_op1_hazard}),
            .sel(s128),
            .in({s50,s51,dis_i1_vd_len,dis_i1_vs3_len,dis_i1_vs2_len,dis_i1_vs1_len,s111,s82,s80,s10,s11,dis_i0_vd_len,dis_i0_vs3_len,dis_i0_vs2_len,dis_i0_vs1_len,s110,s42,s40})
        );
    end
    else begin:gen_vmac2_dispatch_stub
        wire [1:0] nds_unused_vmac2_sel = s128;
        assign vmac2_dispatch_valid = 1'b0;
        assign vmac2_dispatch_ctrl = {58{1'b0}};
        assign vmac2_dispatch_frm = 3'd0;
        assign vmac2_dispatch_vxrm = 2'd0;
        assign vmac2_dispatch_op1 = {XLEN{1'b0}};
        assign vmac2_dispatch_op1_hazard = 1'b0;
        assign vmac2_dispatch_vd_len = {VRF_LW{1'b0}};
        assign vmac2_dispatch_vs3_len = {VRF_LW{1'b0}};
        assign vmac2_dispatch_vs2_len = {VRF_LW{1'b0}};
        assign vmac2_dispatch_vs1_len = {VRF_LW{1'b0}};
    end
endgenerate
assign vdiv_dispatch_valid = (s152 & s26) | (s153 & s66);
kv_mux_onehot #(
    .N(2),
    .W(VRF_LW * 3 + 30 + XLEN + 1)
) u_vdiv_dispatch (
    .out({vdiv_dispatch_vd_len,vdiv_dispatch_vs2_len,vdiv_dispatch_vs1_len,vdiv_dispatch_ctrl,vdiv_dispatch_op1,vdiv_dispatch_op1_hazard}),
    .sel(s129),
    .in({dis_i1_vd_len,dis_i1_vs2_len,dis_i1_vs1_len,s113,s82,s80,dis_i0_vd_len,dis_i0_vs2_len,dis_i0_vs1_len,s112,s42,s40})
);
assign vfmis_dispatch_valid = (s152 & s27) | (s153 & s67);
kv_mux_onehot #(
    .N(2),
    .W(3 + VRF_LW * 4 + 71 + XLEN + 1)
) u_vfmis_dispatch (
    .out({vfmis_dispatch_frm,vfmis_dispatch_vd_len,vfmis_dispatch_vs3_len,vfmis_dispatch_vs2_len,vfmis_dispatch_vs1_len,vfmis_dispatch_ctrl,vfmis_dispatch_op1,vfmis_dispatch_op1_hazard}),
    .sel(s130),
    .in({s50,dis_i1_vd_len,dis_i1_vs3_len,dis_i1_vs2_len,dis_i1_vs1_len,s115,s82,s80,s10,dis_i0_vd_len,dis_i0_vs3_len,dis_i0_vs2_len,dis_i0_vs1_len,s114,s42,s40})
);
assign vpermut_dispatch_valid = (s152 & s28) | (s153 & s68);
kv_mux_onehot #(
    .N(2),
    .W(VRF_LW * 3 + 41 + XLEN + 1)
) u_vpermut_dispatch (
    .out({vpermut_dispatch_vd_len,vpermut_dispatch_vs2_len,vpermut_dispatch_vs1_len,vpermut_dispatch_ctrl,vpermut_dispatch_op1,vpermut_dispatch_op1_hazard}),
    .sel(s131),
    .in({dis_i1_vd_len,dis_i1_vs2_len,dis_i1_vs1_len,s117,s82,s80,dis_i0_vd_len,dis_i0_vs2_len,dis_i0_vs1_len,s116,s42,s40})
);
assign vfdiv_dispatch_valid = (s152 & s29) | (s153 & s69);
kv_mux_onehot #(
    .N(2),
    .W(3 + VRF_LW * 3 + 39 + XLEN + 1)
) u_vfdiv_dispatch (
    .out({vfdiv_dispatch_frm,vfdiv_dispatch_vd_len,vfdiv_dispatch_vs2_len,vfdiv_dispatch_vs1_len,vfdiv_dispatch_ctrl,vfdiv_dispatch_op1,vfdiv_dispatch_op1_hazard}),
    .sel(s132),
    .in({s50,dis_i1_vd_len,dis_i1_vs2_len,dis_i1_vs1_len,s119,s82,s80,s10,dis_i0_vd_len,dis_i0_vs2_len,dis_i0_vs1_len,s118,s42,s40})
);
assign vmask_dispatch_valid = (s152 & s30) | (s153 & s70);
kv_mux_onehot #(
    .N(2),
    .W(VRF_LW * 4 + 44 + XLEN + 1)
) u_vmask_dispatch (
    .out({vmask_dispatch_vd_len,vmask_dispatch_vs3_len,vmask_dispatch_vs2_len,vmask_dispatch_vs1_len,vmask_dispatch_ctrl,vmask_dispatch_op1,vmask_dispatch_op1_hazard}),
    .sel(s133),
    .in({dis_i1_vd_len,dis_i1_vs3_len,dis_i1_vs2_len,dis_i1_vs1_len,s121,s82,s80,dis_i0_vd_len,dis_i0_vs3_len,dis_i0_vs2_len,dis_i0_vs1_len,s120,s42,s40})
);
assign vace_dispatch_valid = (s152 & s31) | (s153 & s71);
kv_mux_onehot #(
    .N(2),
    .W(4 + 3 + 2 + VRF_LW * 4 + 86 + XLEN + 1)
) u_vace_dispatch (
    .out({vace_dispatch_umisc_ctl,vace_dispatch_frm,vace_dispatch_vxrm,vace_dispatch_vd_len,vace_dispatch_vs3_len,vace_dispatch_vs2_len,vace_dispatch_vs1_len,vace_dispatch_ctrl,vace_dispatch_op1,vace_dispatch_op1_hazard}),
    .sel(s134),
    .in({s52,s50,s51,dis_i1_vd_len,dis_i1_vs3_len,dis_i1_vs2_len,dis_i1_vs1_len,s123,s82,s80,s12,s10,s11,dis_i0_vd_len,dis_i0_vs3_len,dis_i0_vs2_len,dis_i0_vs1_len,s122,s42,s40})
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

