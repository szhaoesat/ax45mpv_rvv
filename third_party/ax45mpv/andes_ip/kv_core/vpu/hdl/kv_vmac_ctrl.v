// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vmac_ctrl (
    vpu_vmac_clk,
    vpu_reset_n,
    lane_id,
    vmac_cmt_valid,
    vmac_cmt_kill,
    vmac_standby_ready,
    wb_standby,
    wb_us_valid,
    wb_us_ready,
    wb_us_wdata,
    wb_us_bit_wen,
    wb_us_mask_wdata,
    wb_us_cmtted,
    wb_us_last,
    wb_us_skip,
    wb_us_flag_update,
    wb_us_flag,
    wb_us_flag_clr,
    vrf_vs1_valid,
    vrf_vs1_rd,
    vrf_vs1_last,
    vrf_vs1_kill,
    vrf_vs1_wr,
    vrf_vs1_wdata,
    vrf_vs1_rdata,
    vrf_vs2_valid,
    vrf_vs2_rd,
    vrf_vs2_last,
    vrf_vs2_kill,
    vrf_vs2_wr,
    vrf_vs2_wdata,
    vrf_vs2_rdata,
    vrf_vd_valid,
    vrf_vd_rd,
    vrf_vd_last,
    vrf_vd_kill,
    vrf_vd_wr,
    vrf_vd_wdata,
    vrf_vd_rdata,
    veq_ex_valid,
    veq_ex_flush,
    veq_ex_ready,
    veq_ex_ctrl,
    veq_ex_vd_len,
    veq_ex_frm,
    veq_ex_vxrm,
    veq_ex_op1,
    veq_ex_v0t,
    veq_ex_cmt,
    veq_ex_id,
    veq_ex_op1_valid,
    veq_ex_v0t_srl_dlen,
    veq_ex_v0t_srl_element,
    veq_ex_nxt_valid,
    veq_ex_nxt_ctrl,
    fpipe_stall,
    ipipe_stall,
    vmac_vs2_lane_share_shift_data,
    vmac_vs2_lane_share_cross_data,
    vmac_vs1_lane_share_data,
    vmac_lane_shift_type,
    vmac_vs2_lane_shift_data,
    vmac_vs1_lane_shift_data,
    vmac_lane_cross_type,
    vmac_vs2_lane_cross_data,
    vmac_vs1_lane_cross_data,
    vimac_f0_valid,
    vimac_f0_sew,
    vimac_f0_xrm,
    vimac_f0_op1_data,
    vimac_f0_op2_data,
    vimac_f0_op3_data,
    vimac_f0_mask_byte8,
    vimac_f0_negmul,
    vimac_f0_op_wide,
    vimac_f0_op_sign,
    vimac_f0_src_sign,
    vimac_f0_instr_qmac,
    vimac_f0_instr_vsmul,
    vimac_f0_instr_vd4dot,
    vimac_f0_ret_hi,
    vimac_wdata,
    vimac_vxsat_set,
    vfmac_f0_fp_mode,
    vfmac_f0_byte_mask,
    vfmac_f0_op1_data,
    vfmac_f0_op2_data,
    vfmac_f0_op3_data,
    vfmac_f0_valid,
    vfmac_f0_round_mode,
    vfmac_f0_vd_eew,
    vfmac_f0_op1_sew64,
    vfmac_f0_op3_sew64,
    vfmac_f0_op1_sew32,
    vfmac_f0_op3_sew32,
    vfmac_f0_op1_sew16,
    vfmac_f0_op3_sew16,
    vfmac_f0_mul_instr,
    vfmac_f0_madd_instr,
    vfmac_f0_msub_instr,
    vfmac_f0_nmadd_instr,
    vfmac_f0_nmsub_instr,
    vfmac_f0_align_amount_adjustment,
    exs_nxt_cmt,
    vfmac_wdata,
    vfmac_flag_set
);
parameter FELEN = 64;
parameter IELEN = 64;
parameter XLEN = 64;
parameter VLEN = 512;
parameter DLEN = 512;
parameter VFMAC_SUPPORT = 1;
parameter VIMAC_SUPPORT = 1;
parameter VRF_LW = 4;
localparam DBLEN = DLEN / 8;
localparam MASK_CAL_LSB = (DLEN == 1024) ? 4 : (DLEN == 512) ? 3 : (DLEN == 256) ? 2 : (DLEN == 128) ? 1 : 0;
localparam MAX_DNUM = (VLEN == DLEN) ? 3 : 4;
localparam VL_MSB = MASK_CAL_LSB + MAX_DNUM;
localparam IDLE = 0;
localparam DLEN_CAL = 1;
localparam DLEN_RD = 2;
localparam LANE_BYPASS = 3;
localparam LANE_CAL = 4;
localparam ELEMENT_CAL = 5;
localparam ELEMENT_SHIFT = 6;
localparam LANE_ID_BITS = DLEN / 64;
input vpu_vmac_clk;
input vpu_reset_n;
input [31:0] lane_id;
input vmac_cmt_valid;
input vmac_cmt_kill;
output vmac_standby_ready;
input wb_standby;
output wb_us_valid;
input wb_us_ready;
output [63:0] wb_us_wdata;
output [63:0] wb_us_bit_wen;
output [7:0] wb_us_mask_wdata;
output wb_us_cmtted;
output wb_us_last;
output wb_us_skip;
output wb_us_flag_update;
output [5:0] wb_us_flag;
output wb_us_flag_clr;
input vrf_vs1_valid;
output vrf_vs1_rd;
input vrf_vs1_last;
output vrf_vs1_kill;
output vrf_vs1_wr;
output [63:0] vrf_vs1_wdata;
input [63:0] vrf_vs1_rdata;
input vrf_vs2_valid;
output vrf_vs2_rd;
input vrf_vs2_last;
output vrf_vs2_kill;
output vrf_vs2_wr;
output [63:0] vrf_vs2_wdata;
input [63:0] vrf_vs2_rdata;
input vrf_vd_valid;
output vrf_vd_rd;
input vrf_vd_last;
output vrf_vd_kill;
output vrf_vd_wr;
output [63:0] vrf_vd_wdata;
input [63:0] vrf_vd_rdata;
input veq_ex_valid;
input veq_ex_flush;
output veq_ex_ready;
input [58 - 1:0] veq_ex_ctrl;
input [VRF_LW - 1:0] veq_ex_vd_len;
input [2:0] veq_ex_frm;
input [1:0] veq_ex_vxrm;
input [XLEN - 1:0] veq_ex_op1;
input [DLEN / 8 - 1:0] veq_ex_v0t;
input veq_ex_cmt;
input [4:0] veq_ex_id;
input veq_ex_op1_valid;
output veq_ex_v0t_srl_dlen;
output veq_ex_v0t_srl_element;
input veq_ex_nxt_valid;
input [58 - 1:0] veq_ex_nxt_ctrl;
output fpipe_stall;
output ipipe_stall;
output [63:0] vmac_vs2_lane_share_cross_data;
output [63:0] vmac_vs2_lane_share_shift_data;
output [63:0] vmac_vs1_lane_share_data;
output [3:0] vmac_lane_shift_type;
input [63:0] vmac_vs2_lane_shift_data;
input [63:0] vmac_vs1_lane_shift_data;
output [3:0] vmac_lane_cross_type;
input [31:0] vmac_vs2_lane_cross_data;
input [31:0] vmac_vs1_lane_cross_data;
output vimac_f0_valid;
output [1:0] vimac_f0_sew;
output [1:0] vimac_f0_xrm;
output [63:0] vimac_f0_op1_data;
output [63:0] vimac_f0_op2_data;
output [63:0] vimac_f0_op3_data;
output [7:0] vimac_f0_mask_byte8;
output vimac_f0_negmul;
output vimac_f0_op_wide;
output vimac_f0_op_sign;
output vimac_f0_src_sign;
output vimac_f0_instr_qmac;
output vimac_f0_instr_vsmul;
output vimac_f0_instr_vd4dot;
output vimac_f0_ret_hi;
input [63:0] vimac_wdata;
input vimac_vxsat_set;
output [7:0] vfmac_f0_byte_mask;
output [63:0] vfmac_f0_op1_data;
output [63:0] vfmac_f0_op2_data;
output [63:0] vfmac_f0_op3_data;
output vfmac_f0_valid;
output [2:0] vfmac_f0_round_mode;
output [1:0] vfmac_f0_vd_eew;
output vfmac_f0_fp_mode;
output vfmac_f0_op1_sew64;
output vfmac_f0_op3_sew64;
output vfmac_f0_op1_sew32;
output vfmac_f0_op3_sew32;
output vfmac_f0_op1_sew16;
output vfmac_f0_op3_sew16;
output vfmac_f0_mul_instr;
output vfmac_f0_madd_instr;
output vfmac_f0_msub_instr;
output vfmac_f0_nmadd_instr;
output vfmac_f0_nmsub_instr;
output [10:0] vfmac_f0_align_amount_adjustment;
input exs_nxt_cmt;
input [63:0] vfmac_wdata;
input [4:0] vfmac_flag_set;





// 4d8b17dd rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [LANE_ID_BITS - 1:0] s0 = lane_id[LANE_ID_BITS - 1:0];
reg [4:0] s1;
wire [DBLEN - 1:0] s2;
wire s3;
wire s4;
wire s5;
wire s6;
wire s7;
wire s8;
wire s9;
wire [3:0] s10;
wire [DBLEN - 1:0] s11;
wire [7:0] s12;
wire [7:0] s13;
wire [DBLEN - 1:0] s14;
wire [DBLEN - 1:0] s15;
wire s16;
wire [63:0] s17;
wire [63:0] s18;
wire [63:0] s19;
wire [63:0] s20;
wire [15:0] s21;
wire [31:0] s22;
wire [63:0] s23;
wire [63:0] s24;
wire [63:0] s25;
wire [63:0] s26;
wire [63:0] s27;
wire [63:0] s28;
wire [63:0] s29;
wire [63:0] s30;
wire [63:0] s31;
wire [63:0] s32;
wire [63:0] s33;
wire [63:0] s34;
wire [63:0] s35;
wire [63:0] s36;
wire [63:0] s37;
wire [63:0] s38;
wire [63:0] s39;
wire s40;
wire s41;
wire s42;
wire s43;
wire s44;
wire s45;
wire s46;
wire s47;
wire s48;
wire s49;
wire [2:0] s50;
wire [1:0] s51;
wire s52;
wire s53;
wire [1:0] s54;
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
wire [10:0] s66;
wire s67;
wire s68;
wire s69;
wire s70;
wire s71;
wire s72;
wire s73;
wire s74;
wire s75;
wire s76;
wire s77;
wire [63:0] s78;
wire s79 = (VIMAC_SUPPORT == 1);
wire s80 = (VFMAC_SUPPORT == 1);
wire s81 = veq_ex_ctrl[16] & s79;
wire s82 = ~veq_ex_ctrl[16] & s80;
wire s83 = veq_ex_ctrl[6];
wire [3:0] s84 = veq_ex_ctrl[2 +:4];
wire s85 = s84[3] & ~s81;
wire s86 = s84[2];
wire s87 = s84[1];
wire s88 = s84[0] & ~s81;
wire s89 = veq_ex_ctrl[15] | s81;
wire [3:0] s90 = veq_ex_ctrl[11 +:4];
wire s91 = s90[3];
wire s92 = s90[2] & s82;
wire s93 = s90[1];
wire s94 = s90[0];
wire s95 = veq_ex_ctrl[21];
wire [1:0] s96 = veq_ex_ctrl[19 +:2];
wire s97 = s96[1];
wire s98 = s96[0];
wire s99 = veq_ex_ctrl[24];
wire s100 = veq_ex_ctrl[25];
wire s101 = veq_ex_ctrl[8];
wire s102 = veq_ex_nxt_ctrl[16] & s79;
wire s103 = veq_ex_nxt_ctrl[6];
wire [3:0] s104 = veq_ex_nxt_ctrl[2 +:4];
wire nds_unused_f0_nxt_addend_src_scalar = s104[3] & ~s102;
wire s105 = s104[2];
wire s106 = s104[1];
wire s107 = s104[0] & ~s102;
wire s108 = veq_ex_nxt_ctrl[15] | s102;
wire [3:0] s109 = veq_ex_nxt_ctrl[11 +:4];
wire s110 = s109[3];
wire nds_unused_f0_nxt_icand_src_scalar = s109[2];
wire s111 = s109[1];
wire s112 = s109[0];
wire s113 = veq_ex_nxt_ctrl[21];
wire [1:0] s114 = veq_ex_nxt_ctrl[19 +:2];
wire nds_unused_f0_nxt_iplier_src_scalar = s114[1];
wire s115 = s114[0];
wire s116 = (veq_ex_nxt_valid & s106 & s103) | (veq_ex_nxt_valid & s112 & s108);
wire s117 = (veq_ex_nxt_valid & s107 & s103) | (veq_ex_nxt_valid & s115 & s113) | (veq_ex_nxt_valid & s110 & s108);
wire s118 = (veq_ex_nxt_valid & s105 & s103) | (veq_ex_nxt_valid & s111 & s108);
wire [1:0] s119 = veq_ex_ctrl[9 +:2];
wire [1:0] s120 = veq_ex_ctrl[26 +:2];
wire [1:0] s121 = veq_ex_ctrl[0 +:2];
wire [1:0] s122 = veq_ex_ctrl[44 +:2];
wire [1:0] s123 = veq_ex_ctrl[46 +:2];
wire [1:0] s124 = veq_ex_ctrl[30 +:2];
wire [1:0] s125 = veq_ex_ctrl[26 +:2];
wire [1:0] s126 = s125;
wire s127 = veq_ex_ctrl[43];
wire [9:0] s128 = veq_ex_ctrl[48 +:10];
wire [10:0] s129 = veq_ex_ctrl[32 +:11];
wire s130 = s129 == 11'b0;
wire fpipe_stall;
wire ipipe_stall;
wire s131;
wire s132;
wire [63:0] s133;
wire [63:0] s134;
wire [63:0] s135;
wire [63:0] s136;
wire s137 = (FELEN == 64);
wire s138 = (FELEN == 32);
wire s139 = (IELEN == 64);
wire nds_unused_i_elen32 = (IELEN == 32);
wire s140;
wire s141;
wire s142;
wire s143;
wire s144;
wire s145;
wire s146;
wire s147;
wire s148;
reg s149;
wire s150;
wire s151;
wire s152;
reg s153;
wire s154;
wire s155;
reg s156;
reg s157;
reg s158;
reg [7:0] s159;
reg [3:0] s160;
wire s161;
reg s162;
reg s163;
reg s164;
reg [1:0] s165;
reg s166;
reg s167;
wire s168;
wire s169;
wire s170;
reg s171;
wire s172;
wire s173;
reg s174;
reg s175;
reg s176;
reg [1:0] s177;
reg [7:0] s178;
reg [3:0] s179;
wire s180;
reg s181;
reg s182;
reg s183;
reg s184;
reg s185;
wire s186;
wire s187;
wire s188;
reg s189;
wire s190;
wire s191;
reg s192;
reg s193;
reg s194;
reg [1:0] s195;
reg [7:0] s196;
reg [63:0] s197;
reg [3:0] s198;
wire s199;
reg s200;
reg s201;
reg s202;
wire s203;
wire s204;
wire s205;
wire s206;
wire [7:0] s207;
reg [63:0] s208;
wire [3:0] s209;
wire [1:0] s210;
wire s211;
wire nds_unused_f4;
wire s212;
wire s213;
wire s214;
wire s215;
wire s216;
wire [7:0] s217;
wire s218;
wire [7:0] s219;
wire [1:0] s220;
wire s221;
wire [5:0] s222;
reg [4:0] s223;
wire s224;
wire s225;
wire [4:0] s226;
wire s227;
wire s228;
reg [5:0] s229;
wire [5:0] s230;
wire s231;
wire s232;
wire s233;
wire s234;
wire s235;
wire s236;
wire s237;
wire s238;
wire s239;
wire s240;
wire s241;
wire s242;
wire s243;
wire s244;
reg [6:0] s245;
reg [6:0] s246;
reg s247;
wire s248;
wire s249;
wire s250;
wire s251;
wire s252;
wire s253;
wire s254;
wire s255;
wire s256;
wire s257;
wire s258;
wire s259;
wire s260;
wire s261;
wire s262;
wire s263;
wire s264;
wire s265;
wire s266;
wire s267;
wire s268;
wire s269;
wire s270;
wire s271;
wire s272;
wire s273;
wire s274;
wire s275;
wire s276;
wire s277;
reg s278;
wire s279;
wire s280;
wire s281;
wire s282;
reg [4:0] s283;
wire [4:0] s284;
wire s285;
wire s286;
wire s287;
wire s288;
wire [63:0] s289;
wire [63:0] s290;
wire [63:0] s291;
wire [63:0] s292;
wire [63:0] s293;
wire [63:0] s294;
wire [63:0] s295;
wire [63:0] s296;
wire [31:0] s297;
wire [31:0] s298;
wire [63:0] s299;
wire [63:0] s300;
wire [63:0] s301;
wire [31:0] s302;
wire [31:0] s303;
wire [63:0] s304;
wire [63:0] s305;
wire [63:0] s306;
wire s307;
reg s308;
wire s309;
wire s310;
wire s311;
wire s312;
reg [DBLEN - 1:0] s313;
wire [DBLEN - 1:0] s314;
wire s315;
wire s316;
wire s317;
wire [DBLEN - 1:0] s318;
wire [DBLEN - 1:0] s319;
wire [63:0] s320;
wire s321;
reg [63:0] s322;
wire [63:0] s323;
wire s324;
wire s325;
wire s326;
wire s327;
wire s328;
wire s329;
wire s330;
wire s331;
wire s332;
wire s333;
wire s334;
wire s335;
wire s336;
wire s337;
wire s338;
wire s339;
reg s340;
wire s341;
wire s342;
wire s343;
wire s344;
wire s345;
wire s346;
wire s347;
wire s348;
wire s349;
wire s350;
wire s351;
assign s324 = (s8 & s265 & s255 & s228 & s0[0]) | (s9 & s259 & s228 & s0[0]);
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s322 <= 64'b0;
    end
    else if (s324) begin
        s322 <= s323;
    end
end

assign s323 = (s138 & s7 & ~s196[0]) ? vrf_vs1_rdata : (s137 & s7 & ~s207[0]) ? vrf_vs1_rdata : vfmac_wdata;
assign s321 = vrf_vs1_valid & ~s308;
assign vmac_lane_shift_type[0] = (s253 & s8) | (s9 & (s229[1:0] == 2'b0) & s254);
assign vmac_lane_shift_type[1] = (s9 & (s229[1:0] == 2'b1) & s254) & (DLEN != 128);
assign vmac_lane_shift_type[2] = (s6 & ~s253 & ~s254 & ~vimac_f0_instr_qmac) | ((s9 & (s229[1:0] == 2'd2) & s254) & (DLEN == 512)) | ((s9 & (s229[1:0] == 2'd3) & s254) & (DLEN == 1024));
assign vmac_lane_shift_type[3] = vimac_f0_instr_qmac | ((s9 & (s229[1:0] == 2'd2) & s254) & (DLEN == 1024));
assign vmac_lane_cross_type[0] = s6 & ~vimac_f0_instr_qmac;
assign vmac_lane_cross_type[1] = vimac_f0_instr_qmac;
assign vmac_lane_cross_type[2] = 1'b0;
assign vmac_lane_cross_type[3] = 1'b0;
assign s320 = (vfmac_wdata & s208) | (vfmac_wdata & s197) | (vrf_vs1_rdata & ~s208 & ~s197);
wire [4:0] s352;
wire s353;
assign s352 = s1 + 5'b0001;
assign s353 = vmac_cmt_valid;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s1 <= 5'b0;
    end
    else if (s353) begin
        s1 <= s352;
    end
end

wire s354;
wire s355;
wire s356;
wire s357;
wire s358;
wire s359;
wire s360;
wire s361;
wire [DBLEN / 4 - 1:0] s362;
wire [DBLEN / 2 - 1:0] s363;
wire [DBLEN / 1 - 1:0] s364;
wire s365;
wire s366;
wire s367;
wire s368;
wire s369;
wire s370;
wire s371;
wire s372;
wire [DBLEN / 4 - 1:0] s373;
wire [DBLEN / 2 - 1:0] s374;
wire [DBLEN - 1:0] s375;
wire [4:0] s376;
wire [DBLEN - 1:0] s377;
reg [DBLEN - 1:0] s378;
reg [DBLEN - 1:0] s379;
reg [DBLEN - 1:0] s380;
assign s376 = s8 ? s283 : s229[4:0];
assign s377 = veq_ex_v0t;
integer s381;
always @* begin
    for (s381 = 0; s381 < DBLEN / 2; s381 = s381 + 1) begin
        s378[s381 * 2 +:2] = {2{veq_ex_v0t[s381]}};
    end
    for (s381 = 0; s381 < DBLEN / 4; s381 = s381 + 1) begin
        s379[s381 * 4 +:4] = {4{veq_ex_v0t[s381]}};
    end
    for (s381 = 0; s381 < DBLEN / 8; s381 = s381 + 1) begin
        s380[s381 * 8 +:8] = {8{veq_ex_v0t[s381]}};
    end
end

assign s2 = ({DBLEN{s54 == 2'b00}} & s377) | ({DBLEN{s54 == 2'b01}} & s378) | ({DBLEN{s54 == 2'b10}} & s379) | ({DBLEN{s54 == 2'b11}} & s380);
generate
    if (DLEN == 1024) begin:gen_all_tail_dlen1024
        assign s365 = ({2'b0,s376[4:0],4'b0} > s129[10:0]);
        assign s366 = ({1'b0,s376[4:0],5'b0} > s129[10:0]);
        assign s367 = ({s376[4:0],6'b0} > s129[10:0]);
        assign s368 = ({s376[3:0],7'b0} > s129[10:0]);
    end
    else if (DLEN == 512) begin:gen_all_tail_dlen512
        assign s365 = ({3'b0,s376[4:0],3'b0} > s129[10:0]);
        assign s366 = ({2'b0,s376[4:0],4'b0} > s129[10:0]);
        assign s367 = ({1'b0,s376[4:0],5'b0} > s129[10:0]);
        assign s368 = ({s376[4:0],6'b0} > s129[10:0]);
    end
    else if (DLEN == 256) begin:gen_all_tail_dlen256
        assign s365 = ({4'b0,s376[4:0],2'b0} > s129[10:0]);
        assign s366 = ({3'b0,s376[4:0],3'b0} > s129[10:0]);
        assign s367 = ({2'b0,s376[4:0],4'b0} > s129[10:0]);
        assign s368 = ({1'b0,s376[4:0],5'b0} > s129[10:0]);
    end
    else if (DLEN == 128) begin:gen_all_tail_dlen128
        assign s365 = ({5'b0,s376[4:0],1'b0} > s129[10:0]);
        assign s366 = ({4'b0,s376[4:0],2'b0} > s129[10:0]);
        assign s367 = ({3'b0,s376[4:0],3'b0} > s129[10:0]);
        assign s368 = ({2'b0,s376[4:0],4'b0} > s129[10:0]);
    end
endgenerate
generate
    if (DLEN == 1024) begin:gen_part_tail_dlen1024
        assign s369 = ({2'b0,s376[4:0]} == s129[10:4]);
        assign s370 = ({1'b0,s376[4:0]} == s129[10:5]);
        assign s371 = (s376[4:0] == s129[10:6]);
        assign s372 = (s376[3:0] == s129[10:7]);
    end
    else if (DLEN == 512) begin:gen_part_tail_dlen512
        assign s369 = ({3'b0,s376[4:0]} == s129[10:3]);
        assign s370 = ({2'b0,s376[4:0]} == s129[10:4]);
        assign s371 = ({1'b0,s376[4:0]} == s129[10:5]);
        assign s372 = (s376[4:0] == s129[10:6]);
    end
    else if (DLEN == 256) begin:gen_part_tail_dlen256
        assign s369 = ({4'b0,s376[4:0]} == s129[10:2]);
        assign s370 = ({3'b0,s376[4:0]} == s129[10:3]);
        assign s371 = ({2'b0,s376[4:0]} == s129[10:4]);
        assign s372 = ({1'b0,s376[4:0]} == s129[10:5]);
    end
    else if (DLEN == 128) begin:gen_part_tail_dlen128
        assign s369 = ({5'b0,s376[4:0]} == s129[10:1]);
        assign s370 = ({4'b0,s376[4:0]} == s129[10:2]);
        assign s371 = ({3'b0,s376[4:0]} == s129[10:3]);
        assign s372 = ({2'b0,s376[4:0]} == s129[10:4]);
    end
endgenerate
assign s373 = s370 ? (~({DLEN / 32{1'b1}} << s129[MASK_CAL_LSB:0])) : {DLEN / 32{~s366}};
assign s374 = s371 ? (~({DLEN / 16{1'b1}} << s129[MASK_CAL_LSB + 1:0])) : {DLEN / 16{~s367}};
assign s375 = s372 ? (~({DLEN / 8{1'b1}} << s129[MASK_CAL_LSB + 2:0])) : {DLEN / 8{~s368}};
generate
    if (DLEN == 1024) begin:gen_all_ps_dlen1024
        assign s354 = ({2'b0,s376[4:0],4'b0} < {1'b0,s128[9:0]});
        assign s355 = ({1'b0,s376[4:0],5'b0} < {1'b0,s128[9:0]});
        assign s356 = ({s376[4:0],6'b0} < {1'b0,s128[9:0]});
        assign s357 = ({s376[3:0],7'b0} < {1'b0,s128[9:0]});
    end
    else if (DLEN == 512) begin:gen_all_ps_dlen512
        assign s354 = ({3'b0,s376[4:0],3'b0} < {1'b0,s128[9:0]});
        assign s355 = ({2'b0,s376[4:0],4'b0} < {1'b0,s128[9:0]});
        assign s356 = ({1'b0,s376[4:0],5'b0} < {1'b0,s128[9:0]});
        assign s357 = ({s376[4:0],6'b0} < {1'b0,s128[9:0]});
    end
    else if (DLEN == 256) begin:gen_all_ps_dlen256
        assign s354 = ({4'b0,s376[4:0],2'b0} < {1'b0,s128[9:0]});
        assign s355 = ({3'b0,s376[4:0],3'b0} < {1'b0,s128[9:0]});
        assign s356 = ({2'b0,s376[4:0],4'b0} < {1'b0,s128[9:0]});
        assign s357 = ({1'b0,s376[4:0],5'b0} < {1'b0,s128[9:0]});
    end
    else if (DLEN == 128) begin:gen_all_ps_dlen128
        assign s354 = ({5'b0,s376[4:0],1'b0} < {1'b0,s128[9:0]});
        assign s355 = ({4'b0,s376[4:0],2'b0} < {1'b0,s128[9:0]});
        assign s356 = ({3'b0,s376[4:0],3'b0} < {1'b0,s128[9:0]});
        assign s357 = ({2'b0,s376[4:0],4'b0} < {1'b0,s128[9:0]});
    end
endgenerate
generate
    if (DLEN == 1024) begin:gen_part_ps_dlen1024
        assign s358 = ({2'b0,s376[4:0]} == {1'b0,s128[9:4]});
        assign s359 = ({1'b0,s376[4:0]} == {1'b0,s128[9:5]});
        assign s360 = (s376[4:0] == {1'b0,s128[9:6]});
        assign s361 = (s376[3:0] == {1'b0,s128[9:7]});
    end
    else if (DLEN == 512) begin:gen_part_ps_dlen512
        assign s358 = ({3'b0,s376[4:0]} == {1'b0,s128[9:3]});
        assign s359 = ({2'b0,s376[4:0]} == {1'b0,s128[9:4]});
        assign s360 = ({1'b0,s376[4:0]} == {1'b0,s128[9:5]});
        assign s361 = (s376[4:0] == {1'b0,s128[9:6]});
    end
    else if (DLEN == 256) begin:gen_part_ps_dlen256
        assign s358 = ({4'b0,s376[4:0]} == {1'b0,s128[9:2]});
        assign s359 = ({3'b0,s376[4:0]} == {1'b0,s128[9:3]});
        assign s360 = ({2'b0,s376[4:0]} == {1'b0,s128[9:4]});
        assign s361 = ({1'b0,s376[4:0]} == {1'b0,s128[9:5]});
    end
    else if (DLEN == 128) begin:gen_part_ps_dlen128
        assign s358 = ({5'b0,s376[4:0]} == {1'b0,s128[9:1]});
        assign s359 = ({4'b0,s376[4:0]} == {1'b0,s128[9:2]});
        assign s360 = ({3'b0,s376[4:0]} == {1'b0,s128[9:3]});
        assign s361 = ({2'b0,s376[4:0]} == {1'b0,s128[9:4]});
    end
endgenerate
assign s362 = ({DLEN / 32{s359}} << s128[MASK_CAL_LSB:0]) | {DLEN / 32{~s355 & ~s359}};
assign s363 = ({DLEN / 16{s360}} << s128[MASK_CAL_LSB + 1:0]) | {DLEN / 16{~s356 & ~s360}};
assign s364 = ({DLEN / 8{s361}} << s128[MASK_CAL_LSB + 2:0]) | {DLEN / 8{~s357 & ~s361}};
generate
    if (DLEN > 128) begin:gen_ex_ps_tail_mask_dlen_gt128
        wire [DBLEN / 8 - 1:0] s382;
        reg [DBLEN - 1:0] s383;
        reg [DBLEN - 1:0] s384;
        reg [DBLEN - 1:0] s385;
        reg [DBLEN - 1:0] s386;
        wire [DBLEN / 8 - 1:0] s387;
        reg [DBLEN - 1:0] s388;
        reg [DBLEN - 1:0] s389;
        reg [DBLEN - 1:0] s390;
        reg [DBLEN - 1:0] s391;
        assign s382 = ({DLEN / 64{s358}} << s128[MASK_CAL_LSB - 1:0]) | {DLEN / 64{~s354 & ~s358}};
        assign s387 = s369 ? (~({DLEN / 64{1'b1}} << s129[MASK_CAL_LSB - 1:0])) : {DLEN / 64{~s365}};
        integer s392;
        always @* begin
            for (s392 = 0; s392 < DLEN / 64; s392 = s392 + 1) begin
                s383[s392 * 8 +:8] = {8{s382[s392]}};
                s388[s392 * 8 +:8] = {8{s387[s392]}};
            end
            for (s392 = 0; s392 < DLEN / 32; s392 = s392 + 1) begin
                s384[s392 * 4 +:4] = {4{s362[s392]}};
                s389[s392 * 4 +:4] = {4{s373[s392]}};
            end
            for (s392 = 0; s392 < DLEN / 16; s392 = s392 + 1) begin
                s385[s392 * 2 +:2] = {2{s363[s392]}};
                s390[s392 * 2 +:2] = {2{s374[s392]}};
            end
            for (s392 = 0; s392 < DLEN / 8; s392 = s392 + 1) begin
                s386[s392] = s364[s392];
                s391[s392] = s375[s392];
            end
        end

        assign s15 = (s383 & {DBLEN{s124 == 2'b11}}) | (s384 & {DBLEN{s124 == 2'b10}}) | (s385 & {DBLEN{s124 == 2'b01}}) | (s386 & {DBLEN{s124 == 2'b00}});
        assign s14 = (s388 & {DBLEN{s124 == 2'b11}}) | (s389 & {DBLEN{s124 == 2'b10}}) | (s390 & {DBLEN{s124 == 2'b01}}) | (s391 & {DBLEN{s124 == 2'b00}});
    end
    else if (DLEN == 128) begin:gen_f0_ps_byte_mask_all_dlen128
        wire [DBLEN / 8 - 1:0] s382;
        reg [DBLEN - 1:0] s383;
        reg [DBLEN - 1:0] s384;
        reg [DBLEN - 1:0] s385;
        reg [DBLEN - 1:0] s386;
        wire [DBLEN / 8 - 1:0] s387;
        reg [DBLEN - 1:0] s388;
        reg [DBLEN - 1:0] s389;
        reg [DBLEN - 1:0] s390;
        reg [DBLEN - 1:0] s391;
        integer s392;
        assign s382 = ({DLEN / 64{s358}} << s128[0]) | {DLEN / 64{~s354 & ~s358}};
        assign s387 = s369 ? (~({DLEN / 64{1'b1}} << s129[0])) : {DLEN / 64{~s365}};
        always @* begin
            for (s392 = 0; s392 < DLEN / 64; s392 = s392 + 1) begin
                s383[s392 * 8 +:8] = {8{s382[s392]}};
                s388[s392 * 8 +:8] = {8{s387[s392]}};
            end
            for (s392 = 0; s392 < DLEN / 32; s392 = s392 + 1) begin
                s384[s392 * 4 +:4] = {4{s362[s392]}};
                s389[s392 * 4 +:4] = {4{s373[s392]}};
            end
            for (s392 = 0; s392 < DLEN / 16; s392 = s392 + 1) begin
                s385[s392 * 2 +:2] = {2{s363[s392]}};
                s390[s392 * 2 +:2] = {2{s374[s392]}};
            end
            for (s392 = 0; s392 < DLEN / 8; s392 = s392 + 1) begin
                s386[s392] = s364[s392];
                s391[s392] = s375[s392];
            end
        end

        assign s15 = (s383 & {DBLEN{s124 == 2'b11}}) | (s384 & {DBLEN{s124 == 2'b10}}) | (s385 & {DBLEN{s124 == 2'b01}}) | (s386 & {DBLEN{s124 == 2'b00}});
        assign s14 = (s388 & {DBLEN{s124 == 2'b11}}) | (s389 & {DBLEN{s124 == 2'b10}}) | (s390 & {DBLEN{s124 == 2'b01}}) | (s391 & {DBLEN{s124 == 2'b00}});
    end
    else begin:gen_f0_ps_byte_mask_all_dlen64
        wire s382;
        reg [DBLEN - 1:0] s383;
        reg [DBLEN - 1:0] s384;
        reg [DBLEN - 1:0] s385;
        reg [DBLEN - 1:0] s386;
        wire s387;
        reg [DBLEN - 1:0] s388;
        reg [DBLEN - 1:0] s389;
        reg [DBLEN - 1:0] s390;
        reg [DBLEN - 1:0] s391;
        integer s392;
        assign s382 = ~s354;
        assign s387 = ~s365;
        always @* begin
            s383[7:0] = {8{s382}};
            s388[7:0] = {8{s387}};
            for (s392 = 0; s392 < DLEN / 32; s392 = s392 + 1) begin
                s384[s392 * 4 +:4] = {4{s362[s392 / 4]}};
                s389[s392 * 4 +:4] = {4{s373[s392 / 4]}};
            end
            for (s392 = 0; s392 < DLEN / 16; s392 = s392 + 1) begin
                s385[s392 * 2 +:2] = {2{s363[s392 / 2]}};
                s390[s392 * 2 +:2] = {2{s374[s392 / 2]}};
            end
            for (s392 = 0; s392 < DLEN / 8; s392 = s392 + 1) begin
                s386[s392] = s364[s392];
                s391[s392] = s375[s392];
            end
        end

        assign s15 = (s383 & {DBLEN{s124 == 2'b11}}) | (s384 & {DBLEN{s124 == 2'b10}}) | (s385 & {DBLEN{s124 == 2'b01}}) | (s386 & {DBLEN{s124 == 2'b00}});
        assign s14 = (s388 & {DBLEN{s124 == 2'b11}}) | (s389 & {DBLEN{s124 == 2'b10}}) | (s390 & {DBLEN{s124 == 2'b01}}) | (s391 & {DBLEN{s124 == 2'b00}});
    end
endgenerate
generate
    if (DLEN == 1024) begin:gen_byte_mask_d1024
        assign s12 = ({8{s0[0]}} & s11[8 * 0 +:8]) | ({8{s0[1]}} & s11[8 * 1 +:8]) | ({8{s0[2]}} & s11[8 * 2 +:8]) | ({8{s0[3]}} & s11[8 * 3 +:8]) | ({8{s0[4]}} & s11[8 * 4 +:8]) | ({8{s0[5]}} & s11[8 * 5 +:8]) | ({8{s0[6]}} & s11[8 * 6 +:8]) | ({8{s0[7]}} & s11[8 * 7 +:8]) | ({8{s0[8]}} & s11[8 * 8 +:8]) | ({8{s0[9]}} & s11[8 * 9 +:8]) | ({8{s0[10]}} & s11[8 * 10 +:8]) | ({8{s0[11]}} & s11[8 * 11 +:8]) | ({8{s0[12]}} & s11[8 * 12 +:8]) | ({8{s0[13]}} & s11[8 * 13 +:8]) | ({8{s0[14]}} & s11[8 * 14 +:8]) | ({8{s0[15]}} & s11[8 * 15 +:8]);
    end
    else if (DLEN == 512) begin:gen_byte_mask_d512
        assign s12 = ({8{s0[0]}} & s11[8 * 0 +:8]) | ({8{s0[1]}} & s11[8 * 1 +:8]) | ({8{s0[2]}} & s11[8 * 2 +:8]) | ({8{s0[3]}} & s11[8 * 3 +:8]) | ({8{s0[4]}} & s11[8 * 4 +:8]) | ({8{s0[5]}} & s11[8 * 5 +:8]) | ({8{s0[6]}} & s11[8 * 6 +:8]) | ({8{s0[7]}} & s11[8 * 7 +:8]);
    end
    else if (DLEN == 256) begin:gen_byte_mask_d256
        assign s12 = ({8{s0[0]}} & s11[8 * 0 +:8]) | ({8{s0[1]}} & s11[8 * 1 +:8]) | ({8{s0[2]}} & s11[8 * 2 +:8]) | ({8{s0[3]}} & s11[8 * 3 +:8]);
    end
    else begin:gen_byte_mask_d128
        assign s12 = ({8{s0[0]}} & s11[8 * 0 +:8]) | ({8{s0[1]}} & s11[8 * 1 +:8]);
    end
endgenerate
wire [7:0] s393;
wire [7:0] s394;
wire [7:0] s395;
wire [7:0] s396;
wire [7:0] s397;
wire [7:0] s398;
wire [7:0] s399;
wire [7:0] s400;
wire [7:0] s401;
assign s401 = s248 ? s12 : s313[7:0];
assign s398 = (s401 & 8'h03);
assign s399 = (s401 & 8'h0f);
assign s400 = (s401 & 8'hff);
assign s397 = ({8{(s54 == 2'b01) & s8 & s0[0]}} & s398) | ({8{(s54 == 2'b10) & s8 & s0[0]}} & s399) | ({8{(s54 == 2'b11) & s8 & s0[0]}} & s400);
generate
    if (DLEN == 128) begin:gen_ured_byte_mask_128
        assign s393 = {8{s254 & s0[0]}};
    end
    else if (DLEN == 256) begin:gen_ured_byte_mask_256
        assign s393 = {8{s254 & s0[0]}} | {8{s254 & s0[2] & ~s229[0]}};
    end
    else if (DLEN == 512) begin:gen_ured_byte_mask_512
        assign s393 = {8{s254 & s0[0]}} | {8{s254 & s0[2] & (s229[1:0] == 2'b00)}} | {8{s254 & s0[4] & ~s229[1]}} | {8{s254 & s0[6] & (s229[1:0] == 2'b00)}};
    end
    else if (DLEN == 1024) begin:gen_ured_byte_mask_10
        assign s393 = {8{s254 & s0[0]}} | {8{s254 & s0[2] & (s229[1:0] == 2'b00)}} | {8{s254 & s0[6] & (s229[1:0] == 2'b00)}} | {8{s254 & s0[10] & (s229[1:0] == 2'b00)}} | {8{s254 & s0[14] & (s229[1:0] == 2'b00)}} | {8{s254 & s0[4] & ~s229[1]}} | {8{s254 & s0[12] & ~s229[1]}} | {8{s254 & s0[8] & ~(&s229[1:0])}};
    end
endgenerate
assign s396 = 8'hf & {8{s0[0]}};
assign s395 = ({8{s229[0] & s0[0]}} & 8'h3) | ({8{~s229[0] & s0[0]}} & 8'h33);
assign s394 = ({8{(s54 == 2'b10) & s9 & s255}} & s396) | ({8{(s54 == 2'b01) & s9 & s255}} & s395);
assign s13 = (s12 & {8{~s254 & ~s255 & ~s8}}) | s397 | s394 | s393;
integer s402;
always @* begin
    for (s402 = 0; s402 < 8; s402 = s402 + 1) begin
        s197[s402 * 8 +:8] = {8{s196[s402] & s138}};
        s208[s402 * 8 +:8] = {8{s207[s402] & s137}};
    end
end

assign fpipe_stall = (s203 & ~wb_us_ready & s137 & ~s213) | (s185 & ~wb_us_ready & s138 & ~s200) | (s203 & ~wb_us_ready & s137 & s213 & s351) | (s185 & ~wb_us_ready & s138 & s200 & s350) | (s203 & s137 & s213 & ~vrf_vs2_valid & ~s351) | (s185 & s138 & s200 & ~vrf_vs2_valid & ~s350);
assign ipipe_stall = ((s203 | s185) & s167 & s181) | (~s203 & ~s185 & s167 & s181 & ~wb_us_ready) | fpipe_stall;
assign s132 = s251 | s254 | s255 | s248;
assign s131 = (s149 & s166) | (s167 & s181) | s308 | (veq_ex_valid & s7 & ~s132) | (s149 & s349);
wire s403;
wire s404;
wire s405;
assign s403 = vrf_vs2_valid & vrf_vs2_last;
assign s404 = vrf_vs1_valid & vrf_vs1_last;
assign s405 = vrf_vd_valid & vrf_vd_last;
assign s45 = (s346 & ~s7 & vrf_vs2_valid & ~vrf_vs2_last & s4) | (s346 & ~s7 & s403 & ~s326 & s6 & ~s244 & ~s4) | (s346 & ~s7 & s403 & ~s6 & ~s4) | (s346 & ~s7 & s403 & vimac_f0_instr_qmac & (&s229[1:0]) & ~s4) | (s346 & ~s7 & s403 & s244 & ~vimac_f0_instr_qmac & s229[0] & ~s4);
assign s46 = (s345 & ~s7 & vrf_vs1_valid & ~vrf_vs1_last & s4) | (s345 & ~s7 & s404 & ~s243 & ~s4) | (s345 & ~s7 & s404 & vimac_f0_instr_qmac & (&s229[1:0]) & ~s4) | (s345 & ~s7 & s404 & s243 & ~vimac_f0_instr_qmac & s229[0] & ~s4);
assign s47 = (s347 & vrf_vd_valid & ~vrf_vd_last & s4) | (s347 & s405 & ~s4 & ~s328);
assign s48 = ((DLEN == VLEN) & vrf_vs1_valid & ~vrf_vs1_last) | ((DLEN != VLEN) & ~s308 & vrf_vs1_valid & vrf_vs1_last);
assign s49 = vrf_vs1_valid & ~vrf_vs1_last;
wire s406;
wire s407;
wire s408;
wire s409;
wire [63:0] s410;
wire [63:0] s411;
wire [63:0] s412;
wire [63:0] s413;
wire [63:0] s414;
wire [63:0] s415;
wire s416;
wire [63:0] s417;
wire s418;
wire [63:0] s419;
wire s420;
wire [63:0] s421;
wire s422;
wire [63:0] s423;
wire [63:0] s424;
wire [31:0] s425;
wire [15:0] s426;
assign s424 = {{s50 != 3'b010},63'b0};
assign s425 = {{s50 != 3'b010},31'b0};
assign s426 = {{s50 != 3'b010},15'b0};
assign s406 = s249;
assign s410 = ({64{(s126 == 2'b01) & ~s6}} & {{3{s426}},{vrf_vs1_rdata[15:0]}}) | ({64{(s126 == 2'b10) & ~s6}} & {s425,{vrf_vs1_rdata[31:0]}}) | ({64{(s126 == 2'b11) & ~s6}} & vrf_vs1_rdata[63:0]) | ({64{(s126 == 2'b01) & s6}} & {s425,vrf_vs1_rdata[31:0]}) | ({64{(s126 == 2'b10) & s6}} & {vrf_vs1_rdata[63:0]});
assign s411 = ({64{(s126 == 2'b01) & ~s6}} & {4{s426}}) | ({64{(s126 == 2'b10) & ~s6}} & {2{s425}}) | ({64{(s126 == 2'b11) & ~s6}} & {1{s424}}) | ({64{(s126 == 2'b01) & s6}} & {2{s425}}) | ({64{(s126 == 2'b10) & s6}} & {1{s424}});
assign s412 = ({64{s0[0]}} & s410) | ({64{~s0[0]}} & s411);
assign s409 = (s251 & s138 & ~s350 & s200 & s185) | (s251 & s137 & ~s351 & s213 & s203) | (s8 & s255 & ~s250 & s0[0] & s138 & s185 & ~s350 & s196[0] & s200 & ~s265) | (s8 & s255 & ~s250 & s0[0] & s137 & s203 & ~s351 & s207[0] & s213 & ~s265);
assign s413 = s320;
assign s408 = (s243 & s88 & s228 & ~s229[0] & s83 & ~veq_ex_ready) | (s243 & s98 & s228 & ~s229[0] & s95 & ~veq_ex_ready) | (s243 & s91 & s228 & ~s229[0] & s89 & ~veq_ex_ready);
assign s407 = (vimac_f0_instr_qmac & s88 & s83 & ~veq_ex_ready & s228 & ~(&s229[1:0])) | (vimac_f0_instr_qmac & s98 & s95 & ~veq_ex_ready & s228 & ~(&s229[1:0]));
assign s414 = vmac_vs1_lane_shift_data;
assign s415 = vmac_vs1_lane_shift_data;
assign s416 = s253;
assign s417 = vmac_vs2_lane_shift_data;
assign s418 = s256 & s0[0];
assign s419 = ({64{s9}} & {16'b0,vrf_vs2_rdata[63:16]}) | ({64{(s126 == 2'b01) & s8}} & {16'b0,vrf_vs2_rdata[63:16]}) | ({64{s126[1] & s8}} & {32'b0,vrf_vs2_rdata[63:32]});
assign s420 = (s244 & s87 & s83 & ~veq_ex_ready & s228 & ~s229[0] & ~s8) | (s244 & s94 & s89 & ~veq_ex_ready & s228 & ~s229[0] & ~s8);
assign s421 = vmac_vs2_lane_shift_data;
assign s422 = (vimac_f0_instr_qmac & s87 & s83 & ~veq_ex_ready & s228 & ~(&s229[1:0])) | (vimac_f0_instr_qmac & s94 & s89 & ~veq_ex_ready & s228 & ~(&s229[1:0]));
assign s423 = vmac_vs2_lane_shift_data;
assign s243 = s6 & (s122 == s125) & ~s7;
assign s244 = s6 & (s123 == s125) & ~s8;
assign vrf_vs1_wr = s406 | s409 | s407 | s408;
assign vrf_vs2_wr = s416 | s418 | s422 | s420;
assign vrf_vd_wr = 1'b0;
assign s240 = ((s119 == s125) & s89 & ~s6) | ((s119 == s125) & s89 & s6 & s229[0] & ~vimac_f0_instr_qmac) | ((s119 == s125) & s89 & s6 & (&s229[1:0]) & vimac_f0_instr_qmac) | ((s119 != s125) & s89 & s6 & ~vimac_f0_instr_qmac);
assign s241 = ((s120 == s125) & s95 & ~s6) | ((s120 == s125) & s95 & s6 & s229[0] & ~vimac_f0_instr_qmac) | ((s120 == s125) & s95 & s6 & (&s229[1:0]) & vimac_f0_instr_qmac) | ((s120 != s125) & s95 & s6 & ~vimac_f0_instr_qmac);
assign s242 = ((s121 == s125) & s83 & ~s6) | ((s121 == s125) & s83 & s6 & s229[0]) | ((s121 != s125) & s83 & s6);
assign s233 = s94 & s240;
assign s234 = s93 & s240;
assign s235 = s91 & s240;
assign s236 = s98 & s241;
assign s238 = s87 & s242;
assign s239 = s86 & s242;
assign s237 = s88 & s242;
assign s342 = s236 | s237 | s235;
assign s343 = s233 | s238;
assign s344 = s234 | s239;
assign s345 = (s95 & s98) | (s83 & s88) | (s89 & s91);
assign s346 = (s89 & s94) | (s83 & s87);
assign s347 = (s89 & s93) | (s83 & s86);
assign vrf_vs1_kill = (s345 & veq_ex_valid & ~s308 & s67) | (s308 & s67) | (s345 & s228 & ~s7 & s4 & ~s117) | (s7 & s258 & ~s309 & ~s117 & ~s48) | (s308 & vrf_vs1_valid & ~s117 & ~s49 & ~fpipe_stall) | (veq_ex_flush & s321 & ~s117);
assign vrf_vs2_kill = (s346 & veq_ex_valid & s67) | (s346 & s228 & ~s7 & s4 & ~s116) | (s7 & s258 & ~s309 & ~s116 & ~s48) | (s7 & s308 & vrf_vs1_valid & ~s116 & ~s49 & ~fpipe_stall) | (veq_ex_flush & vrf_vs2_valid & ~s116);
assign vrf_vd_kill = (s347 & veq_ex_valid & s67) | (s347 & s228 & s4 & ~s118) | (veq_ex_flush & vrf_vd_valid & ~s118);
assign vrf_vs1_rd = (s342 & s228 & ~s7 & ~s4) | (s228 & s345 & ~s7 & s4 & s117) | (s7 & s258 & (DLEN == VLEN) & s117 & ~s48) | (s7 & s258 & (DLEN != VLEN) & ~s48) | (s308 & vrf_vs1_valid & s117 & ~s49 & ~fpipe_stall) | (~vrf_vs1_valid & veq_ex_valid & s345) | (~vrf_vs1_valid & s308 & (FELEN == 32)) | (~vrf_vs1_valid & s308 & (FELEN == 64)) | (veq_ex_flush & s321 & s117) | (veq_ex_valid & ~s345 & ~vrf_vs1_valid & s117);
assign vrf_vs2_rd = (s343 & s228 & ~s7 & ~s4 & ~s326) | (s228 & ~s7 & s346 & s4 & s116) | (s8 & s252 & ~s48) | (s252 & ~s48) | (s7 & s258 & s116 & ~s48 & (DLEN == VLEN)) | (s7 & s308 & vrf_vs1_valid & ~s49 & s116 & ~fpipe_stall) | (~vrf_vs2_valid & veq_ex_valid & s346) | (veq_ex_flush & vrf_vs2_valid & s116) | (veq_ex_valid & ~s346 & ~vrf_vs2_valid & s116);
assign vrf_vd_rd = (s344 & s228 & ~s4 & ~s328) | (s228 & s347 & s4 & s118) | (~vrf_vd_valid & veq_ex_valid & s347) | (veq_ex_flush & vrf_vd_valid & s118) | (veq_ex_valid & ~s347 & ~vrf_vd_valid & s118);
assign vrf_vs1_wdata = ({64{s406}} & s412) | ({64{s409}} & s413) | ({64{s407}} & s414) | ({64{s408}} & s415);
assign vrf_vs2_wdata = ({64{s416}} & s417) | ({64{s418}} & s419) | ({64{s422}} & s423) | ({64{s420}} & s421);
assign vrf_vd_wdata = 64'b0;
assign vmac_vs2_lane_share_shift_data = s254 ? s320 : vrf_vs2_rdata;
assign vmac_vs2_lane_share_cross_data = vrf_vs2_rdata;
assign vmac_vs1_lane_share_data = vrf_vs1_rdata;
assign s297 = {{24{vmac_vs1_lane_cross_data[15] & vimac_f0_src_sign}},vmac_vs1_lane_cross_data[15:8]};
assign s298 = {{24{vmac_vs1_lane_cross_data[7] & vimac_f0_src_sign}},vmac_vs1_lane_cross_data[7:0]};
assign s302 = {{24{vmac_vs2_lane_cross_data[15] & vimac_f0_op_sign}},vmac_vs2_lane_cross_data[15:8]};
assign s303 = {{24{vmac_vs2_lane_cross_data[7] & vimac_f0_op_sign}},vmac_vs2_lane_cross_data[7:0]};
assign s299 = {s297,s298};
assign s304 = {s302,s303};
assign s300 = {{48{vmac_vs1_lane_cross_data[15] & vimac_f0_src_sign}},vmac_vs1_lane_cross_data[15:0]};
assign s305 = {{48{vmac_vs2_lane_cross_data[15] & vimac_f0_op_sign}},vmac_vs2_lane_cross_data[15:0]};
assign s301 = ({64{s126 == 2'b00}} & s299) | ({64{s126 == 2'b01}} & s300);
assign s306 = ({64{s126 == 2'b00}} & s304) | ({64{s126 == 2'b01}} & s305);
assign s136 = ({64{s6}} & s39) | ({64{~s6}} & s32);
assign s133 = ({64{~s243 & ~s7}} & vrf_vs1_rdata) | ({64{s7 & s248 & (s54 == 2'b11) & s0[0]}} & vrf_vs1_rdata) | ({64{s7 & s248 & (s54 == 2'b10) & s0[0]}} & {s425,vrf_vs1_rdata[31:0]}) | ({64{s7 & s248 & (s54 == 2'b01) & s0[0]}} & {{3{s426}},vrf_vs1_rdata[15:0]}) | ({64{s7 & s248 & (s54 == 2'b11) & ~s0[0]}} & s424) | ({64{s7 & s248 & (s54 == 2'b10) & ~s0[0]}} & {2{s425}}) | ({64{s7 & s248 & (s54 == 2'b01) & ~s0[0]}} & {4{s426}}) | ({64{s243 & vimac_f0_instr_qmac}} & s301) | ({64{s243 & ~vimac_f0_instr_qmac}} & s292);
assign s134 = ({64{~s244 | s8}} & vrf_vs2_rdata) | ({64{s244 & vimac_f0_instr_qmac}} & s306) | ({64{s244 & ~vimac_f0_instr_qmac & ~s8}} & s296);
assign s292 = ({64{s126 == 2'b00}} & s289) | ({64{s126 == 2'b01}} & s290) | ({64{s126 == 2'b10}} & s291);
assign s289 = {{8{vmac_vs1_lane_cross_data[31] & vimac_f0_src_sign}},vmac_vs1_lane_cross_data[31:24],{8{vmac_vs1_lane_cross_data[23] & vimac_f0_src_sign}},vmac_vs1_lane_cross_data[23:16],{8{vmac_vs1_lane_cross_data[15] & vimac_f0_src_sign}},vmac_vs1_lane_cross_data[15:8],{8{vmac_vs1_lane_cross_data[7] & vimac_f0_src_sign}},vmac_vs1_lane_cross_data[7:0]};
wire [63:0] s427;
wire [63:0] s428;
assign s427 = {{16{vmac_vs1_lane_cross_data[31] & vimac_f0_src_sign}},vmac_vs1_lane_cross_data[31:16],{16{vmac_vs1_lane_cross_data[15] & vimac_f0_src_sign}},vmac_vs1_lane_cross_data[15:0]};
assign s428 = {vmac_vs1_lane_cross_data[31:16],16'b0,vmac_vs1_lane_cross_data[15:0],16'b0};
assign s290 = s53 ? s428 : s427;
assign s291 = {{32{vmac_vs1_lane_cross_data[31] & vimac_f0_src_sign}},vmac_vs1_lane_cross_data[31:0]};
assign s296 = ({64{s126 == 2'b00}} & s293) | ({64{s126 == 2'b01}} & s294) | ({64{s126 == 2'b10}} & s295);
assign s293 = {{8{vmac_vs2_lane_cross_data[31] & s81 & vimac_f0_op_sign}},vmac_vs2_lane_cross_data[31:24],{8{vmac_vs2_lane_cross_data[23] & s81 & vimac_f0_op_sign}},vmac_vs2_lane_cross_data[23:16],{8{vmac_vs2_lane_cross_data[15] & s81 & vimac_f0_op_sign}},vmac_vs2_lane_cross_data[15:8],{8{vmac_vs2_lane_cross_data[7] & s81 & vimac_f0_op_sign}},vmac_vs2_lane_cross_data[7:0]};
wire [63:0] s429;
wire [63:0] s430;
assign s429 = {{16{vmac_vs2_lane_cross_data[31] & s81 & vimac_f0_op_sign}},vmac_vs2_lane_cross_data[31:16],{16{vmac_vs2_lane_cross_data[15] & s81 & vimac_f0_op_sign}},vmac_vs2_lane_cross_data[15:0]};
assign s430 = {vmac_vs2_lane_cross_data[31:16],16'b0,vmac_vs2_lane_cross_data[15:0],16'b0};
assign s294 = s53 ? s430 : s429;
assign s295 = {{32{vmac_vs2_lane_cross_data[31] & s81 & vimac_f0_op_sign}},vmac_vs2_lane_cross_data[31:0]};
assign s135 = vrf_vd_rdata[63:0];
wire s431;
wire s432;
assign s431 = (s82 & (s126 == 2'b10) & (&veq_ex_op1[63:32]));
assign s432 = (s82 & (s126 == 2'b01) & (&veq_ex_op1[63:16]));
assign s28 = {8{veq_ex_op1[7:0]}};
assign s29 = s81 ? {4{veq_ex_op1[15:0]}} : s432 ? {4{veq_ex_op1[15:0]}} : s101 ? {4{16'h7fc0}} : {4{16'h7e00}};
assign s30 = s81 ? {2{veq_ex_op1[31:0]}} : s431 ? {2{veq_ex_op1[31:0]}} : {2{32'h7fc00000}};
assign s31 = veq_ex_op1[63:0];
assign s32 = ({64{s126 == 2'b00}} & s28) | ({64{s126 == 2'b01}} & s29) | ({64{s126 == 2'b10}} & s30) | ({64{s126 == 2'b11}} & s31);
assign s37 = {2{{24{veq_ex_op1[7] & vimac_f0_src_sign}},veq_ex_op1[7:0]}};
assign s38 = {{48{veq_ex_op1[15] & vimac_f0_src_sign}},veq_ex_op1[15:0]};
assign s33 = {4{{8{veq_ex_op1[7]}},veq_ex_op1[7:0]}};
assign s35 = s53 ? {2{veq_ex_op1[15:0],16'b0}} : {2{16'b0,veq_ex_op1[15:0]}};
assign s34 = s81 ? {2{{16{veq_ex_op1[15]}},veq_ex_op1[15:0]}} : s432 ? s35 : s53 ? {2{32'h7fc00000}} : s101 ? {2{16'b0,16'h7fc0}} : {2{16'b0,16'h7e00}};
assign s36 = s81 ? {{32{veq_ex_op1[31]}},veq_ex_op1[31:0]} : s431 ? {32'b0,veq_ex_op1[31:0]} : {32'b0,32'h7fc00000};
assign s39 = ({64{(s126 == 2'b00) & ~vimac_f0_instr_qmac}} & s33) | ({64{(s126 == 2'b01) & ~vimac_f0_instr_qmac}} & s34) | ({64{(s126 == 2'b10) & ~vimac_f0_instr_qmac}} & s36) | ({64{(s126 == 2'b00) & vimac_f0_instr_qmac}} & s37) | ({64{(s126 == 2'b01) & vimac_f0_instr_qmac}} & s38);
assign s69 = (s94 & ~s9) | (s94 & s9 & s248) | s251;
assign s70 = s254;
assign s71 = s255 & s0[0] & s9;
assign s72 = (s71 & (s54 == 2'b10)) | (s71 & s229[0]);
assign s73 = s71 & ~s229[0] & (s54 == 2'b01);
assign s18 = ({64{s92}} & s136) | ({64{s93}} & s135) | ({64{s69}} & s134) | ({64{s91}} & s133) | ({64{s70}} & vmac_vs2_lane_shift_data) | ({64{s73}} & {16'b0,vfmac_wdata[63:48],16'b0,vfmac_wdata[31:16]}) | ({64{s72}} & {32'b0,vfmac_wdata[63:32]});
assign s17 = ({64{s93}} & s135) | ({64{s69}} & s134) | ({64{s91}} & s133);
assign s19 = {1{{64{s119 == 2'b11}} & 64'b1}} | {2{{32{s119 == 2'b10}} & 32'b1}} | {4{{16{s119 == 2'b01}} & 16'b1}} | {8{{8{s119 == 2'b00}} & 8'b1}};
assign s23 = 64'h3ff0000000000000;
assign s22 = 32'h3f800000;
assign s21 = s101 ? 16'h3f80 : 16'h3c00;
assign s20 = {1{{64{(s119 == 2'b11) & ~s9}} & s23}} | {2{{32{(s119 == 2'b10) & ~s9}} & s22}} | {4{{16{(s119 == 2'b01) & ~s9}} & s21}} | {1{{64{(s119 == 2'b11) & s251}} & s23}} | {2{{32{(s119 == 2'b10) & s251}} & s22}} | {4{{16{(s119 == 2'b01) & s251}} & s21}} | {1{{64{(s119 == 2'b11) & s248 & s9}} & s23}} | {2{{32{(s119 == 2'b10) & s248 & s9}} & s22}} | {4{{16{(s119 == 2'b01) & s248 & s9}} & s21}} | {1{{64{(s54 == 2'b11) & ~s251 & ~s248 & s9}} & s23}} | {2{{32{(s54 == 2'b10) & ~s251 & ~s248 & s9}} & s22}} | {4{{16{(s54 == 2'b01) & ~s251 & ~s248 & s9}} & s21}};
assign s24 = ({64{s97}} & s136) | ({64{s98}} & s133);
assign s25 = ({64{s97 & ~s99 & ~s100}} & s136) | ({64{s97 & s99}} & {4{veq_ex_op1[15:0]}}) | ({64{s97 & s100}} & {4{veq_ex_op1[31:16]}}) | ({64{s98}} & s133);
assign s76 = (s88 & ~s7) | (s251 & s250) | (s248 & s250);
assign s78[7:0] = (s185 & s138 & s196[0]) ? vfmac_wdata[7:0] : (s203 & s137 & s207[0]) ? vfmac_wdata[7:0] : vrf_vs1_rdata[7:0];
assign s78[15:8] = (s185 & s138 & s196[1]) ? vfmac_wdata[15:8] : (s203 & s137 & s207[1]) ? vfmac_wdata[15:8] : vrf_vs1_rdata[15:8];
assign s78[23:16] = (s185 & s138 & s196[2]) ? vfmac_wdata[23:16] : (s203 & s137 & s207[2]) ? vfmac_wdata[23:16] : vrf_vs1_rdata[23:16];
assign s78[31:24] = (s185 & s138 & s196[3]) ? vfmac_wdata[31:24] : (s203 & s137 & s207[3]) ? vfmac_wdata[31:24] : vrf_vs1_rdata[31:24];
assign s78[39:32] = (s185 & s138 & s196[4]) ? vfmac_wdata[39:32] : (s203 & s137 & s207[4]) ? vfmac_wdata[39:32] : vrf_vs1_rdata[39:32];
assign s78[47:40] = (s185 & s138 & s196[5]) ? vfmac_wdata[47:40] : (s203 & s137 & s207[5]) ? vfmac_wdata[47:40] : vrf_vs1_rdata[47:40];
assign s78[55:48] = (s185 & s138 & s196[6]) ? vfmac_wdata[55:48] : (s203 & s137 & s207[6]) ? vfmac_wdata[55:48] : vrf_vs1_rdata[55:48];
assign s78[63:56] = (s185 & s138 & s196[7]) ? vfmac_wdata[63:56] : (s203 & s137 & s207[7]) ? vfmac_wdata[63:56] : vrf_vs1_rdata[63:56];
assign s77 = (s251 & ~s250) | s254 | (s255 & s9) | (s255 & s8 & ~s250);
assign s26 = ({64{s86}} & s135) | ({64{s87}} & s134) | ({64{s76}} & s133);
assign s27 = ({64{s99}} & {4{veq_ex_op1[31:16]}}) | ({64{s100}} & {4{veq_ex_op1[15:0]}}) | ({64{s86}} & s135) | ({64{s87}} & s134) | ({64{s76}} & s133) | ({64{s77}} & s78);
assign s42 = s251 & s261;
assign s40 = s254 & s263;
assign s41 = s9 & s255 & s264;
assign s43 = (s8 & vrf_vs2_valid);
assign s44 = (s8 & s321 & s250) | (s8 & s138 & s185 & s200 & ~s350 & ~s250) | (s8 & s137 & s203 & s213 & ~s351 & ~s250);
assign s75 = (s88 & s321 & ~s7 & ~s46) | (s87 & vrf_vs2_valid & ~s45) | (s86 & vrf_vd_valid & ~s47) | (s85 & veq_ex_op1_valid) | ~s83 | (s88 & s321 & s7 & s248 & ~s48) | (~s48 & s42) | (~s48 & s40) | (~s48 & s41) | (~s48 & s44);
assign s74 = (s97 & veq_ex_op1_valid) | (s98 & s321 & ~s46) | ~s95;
assign s68 = (s92 & veq_ex_op1_valid) | (s93 & vrf_vd_valid & ~s47) | (s91 & s321 & ~s46) | (s94 & vrf_vs2_valid & ~s7 & ~s45) | (s94 & vrf_vs2_valid & s7 & s248 & ~s48) | ~s89 | (~s48 & s42) | (~s48 & s40) | (~s48 & s41) | (~s48 & s43);
assign s3 = s68 & s74 & s75;
assign s325 = (s8 & s265 & s255 & s228 & (DLEN == VLEN)) | (s9 & s259 & s228 & (DLEN == VLEN)) | (s7 & s308 & (DLEN != VLEN));
assign s5 = (s4 & s228 & ~s7) | s325;
assign s8 = veq_ex_ctrl[23];
assign s9 = veq_ex_ctrl[28];
assign s7 = s8 | s9;
assign s6 = (s125 != s124);
assign s56 = ((s121 == 2'b11) & s137 & ~s7) | ((s54 == 2'b11) & s137 & s7);
assign s58 = ((s121 == 2'b10) & ~s7) | ((s54 == 2'b10) & s7);
assign s60 = ((s121 == 2'b01) & ~s7) | ((s54 == 2'b01) & s7);
assign s55 = ((s119 == 2'b11) & ~s9) | ((s119 == 2'b11) & s251) | ((s119 == 2'b11) & s248 & s9) | ((s54 == 2'b11) & s9 & s255) | ((s54 == 2'b11) & s254);
assign s57 = ((s119 == 2'b10) & ~s9) | ((s119 == 2'b01) & s53) | ((s119 == 2'b10) & s251) | ((s119 == 2'b10) & s248 & s9) | ((s54 == 2'b10) & s9 & s255) | ((s54 == 2'b10) & s254);
assign s59 = ((s119 == 2'b01) & ~s9 & ~s53) | ((s119 == 2'b01) & s251) | ((s119 == 2'b01) & s248 & s9) | ((s54 == 2'b01) & s9 & s255) | ((s54 == 2'b01) & s254);
assign s61 = ~veq_ex_ctrl[6];
assign s62 = veq_ex_ctrl[7] & veq_ex_ctrl[22] & veq_ex_ctrl[6];
assign s63 = ~veq_ex_ctrl[7] & veq_ex_ctrl[22] & veq_ex_ctrl[6];
assign s64 = ~veq_ex_ctrl[7] & ~veq_ex_ctrl[22] & veq_ex_ctrl[6];
assign s65 = veq_ex_ctrl[7] & ~veq_ex_ctrl[22] & veq_ex_ctrl[6];
assign s10 = veq_ex_id[3:0];
assign s11 = (s2 | {DBLEN{s127}}) & s15 & s14;
assign s16 = veq_ex_cmt;
assign s50 = veq_ex_frm;
assign s51 = veq_ex_vxrm;
assign s52 = veq_ex_ctrl[29] & s81;
assign s53 = veq_ex_ctrl[29] & s82;
assign s54 = s124;
assign s67 = veq_ex_valid & vmac_cmt_valid & (s10[3:0] == s1[3:0]) & vmac_cmt_kill & ~veq_ex_cmt;
wire s433 = s6 & ~s254 & ~s255;
generate
    if (FELEN == 64) begin:gen_align_amout_dp_mac
        assign s66 = ({11{~s53 & s55 & s56}} & 11'h43a) | ({11{~s53 & s57 & s56}} & 11'h33a) | ({11{~s53 & s433 & s57 & s58}} & 11'h7ba) | ({11{~s433 & s57 & s58 | s53}} & 11'h79d) | ({11{~s53 & s433 & s59 & s60 & s101}} & 11'h79d) | ({11{~s53 & s433 & s59 & s60 & ~s101}} & 11'h00d) | ({11{~s53 & ~s433 & s59 & s60 & s101}} & 11'h78d) | ({11{~s53 & ~s433 & s59 & s60 & ~s101}} & 11'h000) | ({11{~s53 & s59 & s58 & s101}} & 11'h79d) | ({11{~s53 & s59 & s58 & ~s101}} & 11'h07d);
    end
    else begin:gen_align_amout_sp_mac
        assign s66 = ({11{s57 & s58 | s53}} & 11'h080) | ({11{~s53 & s59 & s60}} & 11'h010) | ({11{~s53 & s59 & s58}} & 11'h1a0);
        wire nds_unused_f0_cal_op_wide = s433;
    end
endgenerate
assign vimac_f0_valid = veq_ex_valid & s3 & s81;
assign vimac_f0_sew = s125;
assign vimac_f0_xrm = s51;
assign vimac_f0_op1_data = s17;
assign vimac_f0_op2_data = s95 ? s24 : s19;
assign vimac_f0_op3_data = s26;
assign vimac_f0_mask_byte8 = s12;
assign vimac_f0_negmul = ~veq_ex_ctrl[22];
assign vimac_f0_op_wide = s6;
assign vimac_f0_op_sign = s84[0];
assign vimac_f0_src_sign = s84[3];
assign vimac_f0_instr_qmac = ((s124 == 2'b11) & (s125 == 2'b01) & s139 & s79) | ((s124 == 2'b10) & (s125 == 2'b00) & s79);
assign vimac_f0_instr_vsmul = veq_ex_ctrl[7];
assign vimac_f0_instr_vd4dot = s52;
assign vimac_f0_ret_hi = s90[2];
assign s140 = (veq_ex_valid & exs_nxt_cmt & s145 & s153 & ~s16) | (veq_ex_valid & exs_nxt_cmt & ~s145 & s146 & s171 & ~s16) | (veq_ex_valid & exs_nxt_cmt & ~s145 & ~s146 & s147 & s189 & ~s16) | (veq_ex_valid & exs_nxt_cmt & ~s145 & ~s146 & ~s147 & s148 & s204 & ~s16) | (veq_ex_valid & exs_nxt_cmt & ~s145 & ~s146 & ~s147 & ~s148 & ~s16);
assign s349 = fpipe_stall | ipipe_stall;
assign s145 = s149 & s156;
assign s141 = (s149 & exs_nxt_cmt & s146 & s171 & ~s153) | (s149 & exs_nxt_cmt & ~s146 & s147 & s189 & ~s153) | (s149 & exs_nxt_cmt & ~s146 & ~s147 & s148 & s204 & ~s153) | (s149 & exs_nxt_cmt & ~s146 & ~s147 & ~s148 & ~s153);
assign s161 = s149 & vmac_cmt_valid & s141 & vmac_cmt_kill;
assign s150 = (~s131 & veq_ex_valid & s3 & ~s67 & s82) | (veq_ex_valid & s3 & ~s67 & s81 & ~s349) | (s308 & vrf_vs1_valid & ~s67 & ~s49 & ~s349);
assign s151 = ~s349 | (s161 & s349);
assign s152 = (~s349 & ~(s131 & s82) & (veq_ex_valid & s3 & ~s67)) | (~s349 & vrf_vs1_valid & s308 & ~s49 & ~s67);
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s149 <= 1'b0;
    end
    else if (s151) begin
        s149 <= s150;
    end
end

assign s154 = (veq_ex_valid & s3 & ~s67 & ~s349) | (vrf_vs1_valid & s308 & ~s49 & ~s67 & ~s349) | (s149 & s349 & vmac_cmt_valid & s141 & ~vmac_cmt_kill);
assign s155 = (s149 & s349) ? 1'b1 : (vmac_cmt_valid & s140) ? 1'b1 : s16;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s153 <= 1'b0;
    end
    else if (s154) begin
        s153 <= s155;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s160 <= 4'b0;
        s159 <= 8'b0;
        s156 <= 1'b0;
        s158 <= 1'b0;
        s157 <= 1'b0;
        s165 <= 2'b0;
        s166 <= 1'b0;
        s162 <= 1'b0;
        s163 <= 1'b0;
        s164 <= 1'b0;
    end
    else if (s152) begin
        s160 <= s10;
        s159 <= s13;
        s156 <= s5;
        s158 <= s341;
        s157 <= s130;
        s165 <= s54;
        s166 <= s81;
        s162 <= s7;
        s163 <= s8;
        s164 <= s250;
    end
end

assign vfmac_f0_fp_mode = s101;
assign vfmac_f0_byte_mask = s13;
assign vfmac_f0_op1_data = s18;
assign vfmac_f0_op2_data = s95 ? s25 : s20;
assign vfmac_f0_op3_data = s27;
assign vfmac_f0_valid = veq_ex_valid & s3 & s82 & ~s131 & s80;
assign vfmac_f0_round_mode = s50;
assign vfmac_f0_vd_eew = s54;
assign vfmac_f0_op1_sew64 = s55;
assign vfmac_f0_op3_sew64 = s56;
assign vfmac_f0_op1_sew32 = s57;
assign vfmac_f0_op3_sew32 = s58;
assign vfmac_f0_op1_sew16 = s59;
assign vfmac_f0_op3_sew16 = s60;
assign vfmac_f0_mul_instr = s61;
assign vfmac_f0_madd_instr = s62;
assign vfmac_f0_msub_instr = s63;
assign vfmac_f0_nmadd_instr = s64;
assign vfmac_f0_nmsub_instr = s65;
assign vfmac_f0_align_amount_adjustment = s66;
wire s434;
assign s434 = fpipe_stall | ipipe_stall;
assign s146 = s167 & s175;
assign s142 = (s167 & exs_nxt_cmt & s147 & s189 & ~s171) | (s167 & exs_nxt_cmt & ~s147 & s148 & s204 & ~s171) | (s167 & exs_nxt_cmt & ~s147 & ~s148 & ~s171);
assign s180 = s167 & vmac_cmt_valid & s142 & vmac_cmt_kill;
assign s168 = (s149 & ~s161 & ~s434);
assign s169 = ~s434 | s180 & s434;
assign s170 = s149 & ~s161 & ~s434;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s167 <= 1'b0;
    end
    else if (s169) begin
        s167 <= s168;
    end
end

assign s172 = (s149 & ~s161 & ~s434) | (s167 & s434 & vmac_cmt_valid & s142 & ~vmac_cmt_kill);
assign s173 = (s167 & s434) ? 1'b1 : (vmac_cmt_valid & s141) ? 1'b1 : s153;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s171 <= 1'b0;
    end
    else if (s172) begin
        s171 <= s173;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s179 <= 4'b0;
        s178 <= 8'b0;
        s175 <= 1'b0;
        s176 <= 1'b0;
        s174 <= 1'b0;
        s177 <= 2'b0;
        s181 <= 1'b0;
        s182 <= 1'b0;
        s183 <= 1'b0;
        s184 <= 1'b0;
    end
    else if (s170) begin
        s179 <= s160;
        s178 <= s159;
        s175 <= s156;
        s176 <= s158;
        s174 <= s157;
        s177 <= s165;
        s181 <= s166;
        s182 <= s162;
        s183 <= s163;
        s184 <= s164;
    end
end

assign s147 = s185 & s192;
assign s143 = (s185 & exs_nxt_cmt & s148 & s204 & ~s189) | (s185 & exs_nxt_cmt & ~s148 & ~s189);
assign s199 = s185 & vmac_cmt_valid & s143 & vmac_cmt_kill;
assign s186 = (s167 & ~s180 & ~s181 & s80 & ~fpipe_stall);
assign s187 = (~fpipe_stall | s199 & fpipe_stall) & s80;
assign s188 = s167 & ~s180 & ~fpipe_stall & s80;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s185 <= 1'b0;
    end
    else if (s187) begin
        s185 <= s186;
    end
end

assign s190 = (s167 & ~s180 & ~fpipe_stall) | (s185 & fpipe_stall & vmac_cmt_valid & s143 & ~vmac_cmt_kill);
assign s191 = (s185 & fpipe_stall) ? 1'b1 : (vmac_cmt_valid & s142) ? 1'b1 : s171;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s189 <= 1'b0;
    end
    else if (s190) begin
        s189 <= s191;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s198 <= 4'b0;
        s196 <= 8'b0;
        s192 <= 1'b0;
        s194 <= 1'b0;
        s193 <= 1'b0;
        s195 <= 2'b0;
        s200 <= 1'b0;
        s201 <= 1'b0;
        s202 <= 1'b0;
    end
    else if (s188) begin
        s198 <= s179;
        s196 <= s178;
        s192 <= s175;
        s194 <= s176;
        s193 <= s174;
        s195 <= s177;
        s200 <= s182;
        s201 <= s183;
        s202 <= s184;
    end
end

generate
    if ((FELEN == 64) & (VFMAC_SUPPORT == 1)) begin:gen_fmac64_ctrl_pipe
        reg s435;
        wire s436;
        wire s437;
        wire s438;
        reg s439;
        wire s440;
        wire s441;
        reg s442;
        reg s443;
        reg s444;
        reg [7:0] s445;
        reg [3:0] s446;
        reg [1:0] s447;
        reg s448;
        reg s449;
        reg s450;
        assign s144 = s203 & exs_nxt_cmt & ~s439;
        assign s212 = s203 & vmac_cmt_valid & s144 & vmac_cmt_kill;
        assign s148 = s203 & s205;
        assign s436 = (s185 & ~s199 & ~fpipe_stall);
        assign s437 = ~fpipe_stall | s212 & fpipe_stall;
        assign s438 = s185 & ~s199 & ~fpipe_stall;
        always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s435 <= 1'b0;
            end
            else if (s437) begin
                s435 <= s436;
            end
        end

        assign s440 = (s185 & ~s199 & ~fpipe_stall) | (s203 & fpipe_stall & vmac_cmt_valid & s144 & ~vmac_cmt_kill);
        assign s441 = (s203 & fpipe_stall) ? 1'b1 : (vmac_cmt_valid & s143) ? 1'b1 : s189;
        always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s439 <= 1'b0;
            end
            else if (s440) begin
                s439 <= s441;
            end
        end

        always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s446 <= 4'b0;
                s445 <= 8'b0;
                s442 <= 1'b0;
                s443 <= 1'b0;
                s444 <= 1'b0;
                s447 <= 2'b0;
                s448 <= 1'b0;
                s449 <= 1'b0;
                s450 <= 1'b0;
            end
            else if (s438) begin
                s446 <= s198;
                s445 <= s196;
                s442 <= s192;
                s443 <= s194;
                s444 <= s193;
                s447 <= s195;
                s448 <= s200;
                s449 <= s201;
                s450 <= s202;
            end
        end

        assign s203 = s435;
        assign s204 = s439;
        assign s205 = s442;
        assign s206 = s443;
        assign s211 = s444;
        assign s207 = s445;
        assign s209 = s446;
        assign s210 = s447;
        assign s213 = s448;
        assign s214 = s449;
        assign s215 = s450;
        assign nds_unused_f4 = 1'b0;
    end
    else begin:gen_fmac_32_ctrl_pipe
        assign s203 = 1'b0;
        assign s204 = 1'b0;
        assign s205 = 1'b0;
        assign s206 = 1'b0;
        assign s211 = 1'b0;
        assign s207 = 8'b0;
        assign s209 = 4'b0;
        assign s210 = 2'b0;
        assign s213 = 1'b0;
        assign s214 = 1'b0;
        assign s215 = 1'b0;
        assign nds_unused_f4 = s203 | s204 | s205 | (|s207) | (|s209) | (|s210) | s213 | s215 | s206 | s211;
        assign s212 = 1'b0;
        assign s144 = 1'b0;
        assign s148 = 1'b0;
    end
endgenerate
assign s221 = (s138 & s185 & ~s199 & wb_us_ready & ~s200) | (s137 & s203 & ~s212 & wb_us_ready & ~s213) | (s138 & s185 & ~s199 & s350 & s200 & ~s307 & wb_us_ready & ~s193) | (s137 & s203 & ~s212 & s351 & s213 & ~s307 & wb_us_ready & ~s211) | (~s185 & ~s203 & s167 & s181 & wb_us_ready & ~s180);
assign s222 = (s138 & s185) ? {1'b0,vfmac_flag_set | {5{s200}} & s223} : (s137 & s203) ? {1'b0,vfmac_flag_set | {5{s213}} & s223} : {vimac_vxsat_set,5'b0};
assign s224 = (s138 & s185 & ~s192 & s201 & s0[0]) | (s137 & s203 & ~s205 & s214 & s0[0]) | (s138 & s185 & ~s192 & s200 & ~s201) | (s137 & s203 & ~s205 & s213 & ~s214);
assign s225 = (s138 & s185 & s192 & s200 & wb_us_ready) | (s137 & s203 & s205 & s213 & wb_us_ready) | (s203 & s213 & s212 & ~s215) | (s185 & s200 & s199 & ~s202) | (s167 & s182 & s180 & ~s184) | (s149 & s162 & s161 & ~s164) | (veq_ex_valid & s7 & s67 & ~s348);
assign s226 = s225 ? 5'b0 : (vfmac_flag_set | s223);
assign s227 = s224 | s225;
assign s348 = (s149 & s156) | (s167 & s175) | (s185 & s192) | (s203 & s205);
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s223 <= 5'b0;
    end
    else if (s227) begin
        s223 <= s226;
    end
end

assign s350 = (s185 & s200 & s192) | (s167 & s182 & s175 & (DLEN != VLEN)) | (s149 & s162 & s156 & (DLEN != VLEN)) | (veq_ex_valid & s7 & s308 & (DLEN != VLEN));
assign s351 = (s203 & s213 & s205) | (s185 & s200 & s192 & (DLEN != VLEN)) | (s167 & s182 & s175 & (DLEN != VLEN)) | (s149 & s162 & s156 & (DLEN != VLEN)) | (veq_ex_valid & s7 & s308 & (DLEN != VLEN));
assign s216 = (s138 & s185 & ~s199 & ~s200) | (s138 & s185 & ~s199 & s200 & s350 & ~(s49 & s308)) | (s137 & s203 & ~s212 & ~s213) | (s137 & s203 & ~s212 & s213 & s351 & ~(s49 & s308)) | (~s185 & ~s203 & s167 & s181 & ~s180);
assign wb_us_valid = s216;
assign wb_us_flag = s222;
assign wb_us_flag_update = s221;
assign wb_us_flag_clr = (s185 & s138 & s199) | (s167 & ~s185 & s138 & s180) | (s149 & ~s185 & ~s167 & s138 & s161) | (veq_ex_valid & ~s185 & ~s167 & ~s149 & s138 & s67) | (s203 & s137 & s212) | (s185 & ~s203 & s137 & s199) | (s167 & ~s185 & ~s203 & s137 & s180) | (s149 & ~s167 & ~s185 & ~s203 & s137 & s161) | (veq_ex_valid & ~s149 & ~s167 & ~s185 & ~s203 & s137 & s67) | (s167 & ~s185 & ~s203 & s181 & s180) | (s149 & ~s167 & ~s185 & ~s203 & s181 & s161) | (veq_ex_valid & ~s149 & ~s167 & ~s185 & ~s203 & s181 & s67);
assign s220 = (s138 & s185) ? s195 : s210;
assign s218 = (s138 & s185) ? s200 : s213;
assign s219 = ({8{s0[0] & ~s193 & ~s307 & s138 & (s220 == 2'b01)}} & 8'b11) | ({8{s0[0] & ~s193 & ~s307 & s138 & (s220 == 2'b10)}} & 8'b1111) | ({8{s0[0] & ~s193 & ~s307 & s138 & (s220 == 2'b11)}} & 8'b11111111) | ({8{s0[0] & ~s211 & ~s307 & s137 & (s220 == 2'b01)}} & 8'b11) | ({8{s0[0] & ~s211 & ~s307 & s137 & (s220 == 2'b10)}} & 8'b1111) | ({8{s0[0] & ~s211 & ~s307 & s137 & (s220 == 2'b11)}} & 8'b11111111);
assign s217 = (s138 & s185 & ~s199) ? s218 ? s219 : s196 : (s137 & s203 & ~s212) ? s218 ? s219 : s207 : s178;
assign wb_us_bit_wen = {64{s216 & wb_us_ready}};
assign wb_us_cmtted = (s138 & s185) ? s189 | (vmac_cmt_valid & s143) : (s137 & s203) ? s204 | (vmac_cmt_valid & s144) : s171 | (vmac_cmt_valid & s142);
assign wb_us_last = (s138 & s185) ? s192 : (s137 & s203) ? s205 : s175;
assign wb_us_skip = (s138 & s185) ? s194 : (s137 & s203) ? s206 : s176;
assign wb_us_wdata = (s138 & s185 & ~s199) ? (s200 & ~s196[0]) ? s322 : vfmac_wdata : (s137 & s203 & ~s212) ? (s213 & ~s207[0]) ? s322 : vfmac_wdata : vimac_wdata;
assign wb_us_mask_wdata = s217;
assign veq_ex_ready = s67 | (s4 & s228 & ~s7) | (s258 & s7 & (VLEN == DLEN)) | (s308 & vrf_vs1_valid & ~s49 & ~fpipe_stall);
assign s228 = (veq_ex_valid & s3 & ~s349 & ~s131 & s82 & ~s308) | (veq_ex_valid & s3 & ~s349 & s81);
assign s231 = veq_ex_ready | (s8 & s273 & s257 & s266) | (s9 & s251 & s261 & s262) | (s9 & s248 & s261 & s262) | (s9 & s260 & (DLEN == 128)) | (s9 & s260 & s203 & s137 & s254) | (s9 & s260 & s185 & s138 & s254);
assign s232 = s228 | s231;
assign s230 = s231 ? 6'b0 : s229 + 6'b1;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s229 <= 6'b0;
    end
    else if (s232) begin
        s229 <= s230;
    end
end

assign s279 = (s8 & s228 & s6 & s276 & s266 & ~s273);
assign s280 = s278;
assign s281 = (s278 & ~s280) | s279;
assign s282 = s279 | s280;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s278 <= 1'b0;
    end
    else if (s282) begin
        s278 <= s281;
    end
end

assign veq_ex_v0t_srl_dlen = (s228 & ~veq_ex_ready & ~s8) | (s8 & s228 & s273 & s266 & ~s265) | (s8 & s228 & s6 & s276 & s266);
assign veq_ex_v0t_srl_element = 1'b0;
assign s331 = (veq_ex_vd_len == s229[VRF_LW - 1:0]);
assign s333 = (veq_ex_vd_len == {{VRF_LW - 1{1'b0}},1'b1}) & s6;
assign s334 = (veq_ex_vd_len == {{VRF_LW - 2{1'b0}},2'b11}) & vimac_f0_instr_qmac;
assign s332 = ((s229[1:0] == 2'b11) & s333 & ~vimac_f0_instr_qmac & s6) | ((s229[2:0] == 3'b111) & s333 & vimac_f0_instr_qmac) | ((s229[2:0] == 3'b111) & s334 & vimac_f0_instr_qmac) | ((veq_ex_vd_len == s229[VRF_LW - 1:0]) & ~s333 & ~s334);
assign s4 = ((DLEN == VLEN) & s331) | ((DLEN != VLEN) & s332);
assign s341 = (veq_ex_vd_len < s229[VRF_LW - 1:0]) & ~s7;
assign s327 = (vrf_vs2_last & ~s229[1] & (DLEN != VLEN) & (s123 != s125)) | (vrf_vs2_last & s340 & (s229[1:0] == 2'b10) & (s123 != s125));
assign s326 = s327;
assign s329 = (vrf_vd_last & ~s229[1] & (DLEN != VLEN) & s6 & ~vimac_f0_instr_qmac) | (vrf_vd_last & s340 & (s229[1:0] == 2'b10) & ~vimac_f0_instr_qmac);
assign s330 = (vrf_vd_last & ~s229[2] & vimac_f0_instr_qmac & (DLEN != VLEN)) | (vrf_vd_last & s340 & (s229[2:0] != 3'b111) & vimac_f0_instr_qmac);
assign s328 = s329 | s330;
assign s335 = (s326 & s346 & ~s7) | (s328 & s347 & ~s7);
assign s336 = s335 & s228;
assign s337 = (s340 & (s229[1:0] == 2'b11) & s228) | s67;
assign s338 = (s340 & ~s337) | s336;
assign s339 = s336 | s337;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s340 <= 1'b0;
    end
    else if (s339) begin
        s340 <= s338;
    end
end

assign s248 = s246[IDLE];
assign s251 = s246[DLEN_CAL];
assign s252 = s246[DLEN_RD];
assign s253 = s246[LANE_BYPASS];
assign s254 = s246[LANE_CAL];
assign s255 = s246[ELEMENT_CAL];
assign s256 = s246[ELEMENT_SHIFT];
assign s249 = s248 & s321 & vrf_vs2_valid & s7 & veq_ex_valid;
assign s286 = (s8 & s265 & s44) | (s8 & s67);
assign s287 = (s8 & vfmac_f0_valid & s266 & s273) | s279;
assign s284 = s286 ? 5'b0 : s283 + 5'b1;
assign s285 = s286 | s287;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s283 <= 5'b0;
    end
    else if (s285) begin
        s283 <= s284;
    end
end

assign s257 = (s321 & vrf_vs2_valid & s250) | (vrf_vs2_valid & s203 & s213 & ~s351 & s137 & ~s250) | (vrf_vs2_valid & s185 & s200 & ~s350 & s138 & ~s250);
assign s261 = (s250 & s9 & s321 & vrf_vs2_valid) | (~s250 & s203 & s213 & ~s351 & s137 & vrf_vs2_valid) | (~s250 & s185 & s200 & ~s350 & s138 & vrf_vs2_valid);
assign s263 = (s203 & s137 & (s10 == s209)) | (s185 & s138 & (s10 == s198));
assign s264 = (s138 & s185 & (s10 == s198)) | (s137 & s203 & (s10 == s209));
assign s260 = ((DLEN == 128) & (s229[3:0] == 4'h0) & s254) | ((DLEN == 256) & (s229[3:0] == 4'h1) & s254) | ((DLEN == 512) & (s229[3:0] == 4'h2) & s254) | ((DLEN == 1024) & (s229[3:0] == 4'h3) & s254);
assign s262 = (vrf_vs2_last & ~s6) | (vrf_vs2_last & s229[0] & s6);
assign s265 = (s270 & s277 & s267 & (s126 == 2'b01) & (&s229[1:0])) | (s271 & s277 & s268 & (s126 == 2'b10) & s229[0]) | (s272 & s277 & s269 & (s126 == 2'b11));
assign s267 = (s229[1:0] == 2'b11);
assign s268 = s229[0];
assign s269 = 1'b1;
assign s266 = (s267 & (s126 == 2'b01)) | (s268 & (s126 == 2'b10)) | (s269 & (s126 == 2'b11));
assign s272 = (DLEN == 64) | ((DLEN == 128) & s229[0]) | ((DLEN == 256) & (&s229[1:0])) | ((DLEN == 512) & (&s229[2:0])) | ((DLEN == 1024) & (&s229[3:0]));
assign s271 = (DLEN == 64) | ((DLEN == 128) & s229[1]) | ((DLEN == 256) & (&s229[2:1])) | ((DLEN == 512) & (&s229[3:1])) | ((DLEN == 1024) & (&s229[4:1]));
assign s270 = (DLEN == 64) | ((DLEN == 128) & (&s229[2])) | ((DLEN == 256) & (&s229[3:2])) | ((DLEN == 512) & (&s229[4:2])) | ((DLEN == 1024) & (&s229[5:2]));
assign s273 = ((s126[1:0] == 2'b01) & s270) | ((s126[1:0] == 2'b10) & s271) | ((s126[1:0] == 2'b11) & s272);
assign s274 = (DLEN == 128) | ((DLEN == 256) & (&s229[2])) | ((DLEN == 512) & (&s229[3:2])) | ((DLEN == 1024) & (&s229[4:2]));
assign s275 = (DLEN == 128) | ((DLEN == 256) & (&s229[1])) | ((DLEN == 512) & (&s229[2:1])) | ((DLEN == 1024) & (&s229[3:1]));
assign s276 = ((s126[1:0] == 2'b01) & s274) | ((s126[1:0] == 2'b10) & s275);
assign s277 = vrf_vs2_last;
assign s288 = (s54[1:0] == 2'b10) | s229[0];
assign s259 = (s262 & (DLEN == 64) & (&s54[1:0])) | (s260 & (&s54[1:0])) | (s288 & s255);
assign s258 = (s8 & s265 & s255 & s228) | (s9 & s259 & s228);
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s246 <= 7'b1;
    end
    else if (s247) begin
        s246 <= s245;
    end
end

always @* begin
    s245 = 7'b0;
    s247 = 1'b0;
    case (1'b1)
        s67: begin
            s245[IDLE] = 1'b1;
            s247 = 1'b1;
        end
        s246[IDLE]: begin
            if (s9) begin
                if (s6) begin
                    s245[DLEN_CAL] = 1'b1;
                    s247 = vfmac_f0_valid & ~fpipe_stall;
                end
                else if (s262) begin
                    s245[LANE_CAL] = 1'b1;
                    s247 = vfmac_f0_valid & ~fpipe_stall;
                end
                else if (s261) begin
                    s245[DLEN_RD] = 1'b1;
                    s247 = vfmac_f0_valid & ~fpipe_stall;
                end
            end
            else begin
                if (s126 == 2'b11) begin
                    s245[LANE_BYPASS] = 1'b1;
                end
                else begin
                    s245[ELEMENT_SHIFT] = 1'b1;
                end
                s247 = s7 & vfmac_f0_valid & ~fpipe_stall;
            end
        end
        s246[DLEN_CAL]: begin
            if (s6) begin
                if (s229[0]) begin
                    if (s262) begin
                        s245[LANE_CAL] = 1'b1;
                        s247 = s261;
                    end
                    else begin
                        s245[DLEN_RD] = 1'b1;
                        s247 = s261;
                    end
                end
                else begin
                    s245[DLEN_CAL] = 1'b1;
                    s247 = s261;
                end
            end
            else if (s262) begin
                if (DLEN == 64) begin
                    s245[IDLE] = 1'b1;
                    s247 = s261;
                end
                else begin
                    s245[LANE_CAL] = 1'b1;
                    s247 = s261;
                end
            end
            else if (s261) begin
                s245[DLEN_RD] = 1'b1;
                s247 = 1'b1;
            end
        end
        s246[DLEN_RD]: begin
            if (s8) begin
                s245[ELEMENT_CAL] = 1'b1;
                s247 = 1'b1;
            end
            else begin
                s245[DLEN_CAL] = 1'b1;
                s247 = 1'b1;
            end
        end
        s246[LANE_BYPASS]: begin
            if (s8) begin
                s245[ELEMENT_CAL] = 1'b1;
                s247 = 1'b1;
            end
            else if (s9) begin
                s245[LANE_CAL] = 1'b1;
                s247 = 1'b1;
            end
        end
        s246[LANE_CAL]: begin
            if (s260) begin
                if (s54 == 2'b11) begin
                    s245[IDLE] = 1'b1;
                    s247 = s263;
                end
                else begin
                    s245[ELEMENT_CAL] = 1'b1;
                    s247 = s263;
                end
            end
            else if (s263) begin
                s245[LANE_CAL] = 1'b1;
                s247 = s263;
            end
        end
        s246[ELEMENT_CAL]: begin
            if (s8) begin
                if (s265) begin
                    s245[IDLE] = 1'b1;
                    s247 = s257;
                end
                else if (s266) begin
                    if (s273) begin
                        s245[DLEN_RD] = 1'b1;
                        s247 = s257;
                    end
                    else begin
                        s245[LANE_BYPASS] = 1'b1;
                        s247 = s257;
                    end
                end
                else begin
                    s245[ELEMENT_SHIFT] = 1'b1;
                    s247 = s257;
                end
            end
            else if (s288) begin
                s245[IDLE] = 1'b1;
                s247 = s264;
            end
            else begin
                s245[ELEMENT_CAL] = 1'b1;
                s247 = s264;
            end
        end
        s246[ELEMENT_SHIFT]: begin
            s245[ELEMENT_CAL] = 1'b1;
            s247 = 1'b1;
        end
        default: begin
            s245 = 7'b0;
            s247 = 1'b0;
        end
    endcase
end

assign s309 = s258 & (DLEN != VLEN) & ~s48 & ~s67;
assign s310 = (vrf_vs1_valid & ~s49 & ~fpipe_stall) | s67;
assign s311 = (s308 & ~s310) | s309;
assign s312 = s309 | s310;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s308 <= 1'b0;
    end
    else if (s312) begin
        s308 <= s311;
    end
end

assign s307 = (s203 & s137 & (DLEN != VLEN) & s205) | (s185 & s138 & (DLEN != VLEN) & s192);
assign s250 = s249;
assign s315 = s317 | s316;
assign s316 = s8 & s228 & ~s5;
assign s317 = s249 | (s8 & s252) | s278;
assign s318 = ({DBLEN{(s54 == 2'b11) & s248}} & {8'b0,s11[DBLEN - 1:8]}) | ({DBLEN{(s54 == 2'b10) & s248}} & {4'b0,s11[DBLEN - 1:4]}) | ({DBLEN{(s54 == 2'b01) & s248}} & {2'b0,s11[DBLEN - 1:2]}) | ({DBLEN{~s248}} & s11[DBLEN - 1:0]);
assign s319 = ({DBLEN{(s54 == 2'b11)}} & {8'b0,s313[DBLEN - 1:8]}) | ({DBLEN{(s54 == 2'b10)}} & {4'b0,s313[DBLEN - 1:4]}) | ({DBLEN{(s54 == 2'b01)}} & {2'b0,s313[DBLEN - 1:2]});
assign s314 = s317 ? s318 : s319;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s313 <= {DBLEN{1'b0}};
    end
    else if (s315) begin
        s313 <= s314;
    end
end

assign vmac_standby_ready = ~veq_ex_valid & ~veq_ex_flush & ~s149 & ~s167 & ~s185 & ~s203 & wb_standby;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

