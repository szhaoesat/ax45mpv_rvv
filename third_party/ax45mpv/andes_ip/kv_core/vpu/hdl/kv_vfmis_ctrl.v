// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfmis_ctrl (
    vpu_vfmis_clk,
    vpu_reset_n,
    lane_id,
    vfmis_cmt_valid,
    vfmis_cmt_kill,
    vfmis_standby_ready,
    veq_ex_valid,
    veq_ex_ready,
    veq_ex_flush,
    veq_ex_ctrl,
    veq_ex_vd_len,
    veq_ex_byte_mask,
    veq_ex_nrr_byte_mask,
    veq_ex_e_mask,
    veq_ex_cmt,
    veq_ex_op1_valid,
    veq_ex_op1,
    veq_ex_byte_mask_srl,
    veq_ex_nrr_byte_mask_srl,
    veq_ex_nxt_valid,
    veq_ex_nxt_ctrl,
    exs_nxt_cmt,
    f1_nxt_cmt,
    wb_standby,
    wb_us_valid,
    wb_us_ready,
    wb_us_skip,
    wb_us_flag,
    wb_us_flag_update,
    wb_us_flag_clr,
    wb_us_wdata_src0,
    wb_us_wdata_src1,
    wb_us_wdata_src2,
    wb_us_src,
    wb_us_bit_wen,
    wb_us_mask_wdata,
    wb_us_cmtted,
    wb_us_last,
    vrf_vs1_valid,
    vrf_vs1_last,
    vrf_vs1_rd,
    vrf_vs1_kill,
    vrf_vs1_rdata,
    vrf_vs1_wr,
    vrf_vs1_wdata,
    vrf_vs2_valid,
    vrf_vs2_last,
    vrf_vs2_rd,
    vrf_vs2_kill,
    vrf_vs2_rdata,
    vrf_vs2_wr,
    vrf_vs2_wdata,
    vrf_vs2_wide_wr,
    vrf_vs2_wide_wdata,
    vrf_vd_valid,
    vrf_vd_last,
    vrf_vd_rd,
    vrf_vd_kill,
    vrf_vd_rdata,
    vfmis_f1_byte_mask,
    vfmis_f1_nrr_byte_mask,
    vfmis_f2_stall,
    vfmis_f1_valid,
    vfmis_f1_wdata,
    vfmis_f1_lane_cmp_bit,
    vfmis_f1_flag_set,
    vfmis_f2_wdata,
    vfmis_f2_narrow_wdata,
    vfmis_f2_flag_set,
    vfmis_lane_vs2_x2_bdata,
    vfmis_lane_vs2_x4_bdata,
    vfmis_lane_vs2_x8_bdata,
    vfmis_lane_vs2_data,
    vfmis_lane_vs2_sel,
    vfmis_lane_share_data,
    vfmis_lane_cross_data
);
parameter VLEN = 1024;
parameter DLEN = 512;
parameter ELEN = 64;
parameter XLEN = 64;
parameter VRF_LW = 3;
localparam LANE_NUM = DLEN / 64;
localparam DBLEN = DLEN / 8;
localparam DSHFAMT_BIT = (DLEN == 1024) ? 10 : (DLEN == 512) ? 9 : (DLEN == 256) ? 8 : (DLEN == 128) ? 7 : 6;
localparam VSHFAMT_BIT = (VLEN == 1024) ? 10 : (VLEN == 512) ? 9 : (VLEN == 256) ? 8 : 7;
localparam MASK_CAL_LSB = (DLEN == 1024) ? 4 : (DLEN == 512) ? 3 : (DLEN == 256) ? 2 : (DLEN == 128) ? 1 : 0;
localparam MAX_DNUM = (VLEN == DLEN) ? 3 : 4;
localparam VL_MSB = MASK_CAL_LSB + MAX_DNUM;
localparam LANE_ID_BITS = DLEN / 64;
input vpu_vfmis_clk;
input vpu_reset_n;
input [31:0] lane_id;
input vfmis_cmt_valid;
input vfmis_cmt_kill;
output vfmis_standby_ready;
input veq_ex_valid;
output veq_ex_ready;
input [71 - 1:0] veq_ex_ctrl;
input [VRF_LW - 1:0] veq_ex_vd_len;
input [127:0] veq_ex_byte_mask;
input [127:0] veq_ex_nrr_byte_mask;
input [63:0] veq_ex_e_mask;
input veq_ex_cmt;
input veq_ex_op1_valid;
input [XLEN - 1:0] veq_ex_op1;
output veq_ex_byte_mask_srl;
output veq_ex_nrr_byte_mask_srl;
input veq_ex_flush;
input veq_ex_nxt_valid;
input [71 - 1:0] veq_ex_nxt_ctrl;
input exs_nxt_cmt;
output f1_nxt_cmt;
output wb_us_valid;
output wb_us_skip;
input wb_us_ready;
output [4:0] wb_us_flag;
output wb_us_flag_update;
output wb_us_flag_clr;
output [63:0] wb_us_wdata_src0;
output [63:0] wb_us_wdata_src1;
output [63:0] wb_us_wdata_src2;
output [2:0] wb_us_src;
output [63:0] wb_us_bit_wen;
output [7:0] wb_us_mask_wdata;
output wb_us_cmtted;
output wb_us_last;
input wb_standby;
input vrf_vs1_valid;
input vrf_vs1_last;
output vrf_vs1_rd;
output vrf_vs1_kill;
input [63:0] vrf_vs1_rdata;
output vrf_vs1_wr;
output [63:0] vrf_vs1_wdata;
input vrf_vs2_valid;
input vrf_vs2_last;
output vrf_vs2_rd;
output vrf_vs2_kill;
input [63:0] vrf_vs2_rdata;
output vrf_vs2_wr;
output [63:0] vrf_vs2_wdata;
output vrf_vs2_wide_wr;
output [31:0] vrf_vs2_wide_wdata;
input vrf_vd_valid;
input vrf_vd_last;
output vrf_vd_rd;
output vrf_vd_kill;
input [63:0] vrf_vd_rdata;
output [7:0] vfmis_f1_byte_mask;
output [7:0] vfmis_f1_nrr_byte_mask;
output vfmis_f2_stall;
output vfmis_f1_valid;
input [63:0] vfmis_f1_wdata;
input [DLEN / 16 - 1:0] vfmis_f1_lane_cmp_bit;
input [4:0] vfmis_f1_flag_set;
input [63:0] vfmis_f2_wdata;
input [31:0] vfmis_f2_narrow_wdata;
input [4:0] vfmis_f2_flag_set;
input [31:0] vfmis_lane_vs2_x2_bdata;
input [15:0] vfmis_lane_vs2_x4_bdata;
input [7:0] vfmis_lane_vs2_x8_bdata;
output [63:0] vfmis_lane_vs2_data;
output [2:0] vfmis_lane_vs2_sel;
output [63:0] vfmis_lane_share_data;
input [127:0] vfmis_lane_cross_data;





// 7393a3e9 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [LANE_ID_BITS - 1:0] s0 = lane_id[LANE_ID_BITS - 1:0];
wire s1;
wire s2;
wire s3;
wire s4;
wire s5;
wire s6;
wire s7;
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
wire s19;
wire s20;
wire s21;
wire s22;
wire s23;
wire [2:0] nds_unused_f1_lmul;
wire s24;
wire s25;
wire [10:0] s26;
wire [9:0] s27;
wire s28;
wire [3:0] s29;
wire [3:0] s30;
wire [3:0] nds_unused_f1_op2_sew;
wire [3:0] s31;
wire s32;
wire s33;
wire s34;
wire [1:0] s35;
wire s36;
wire s37;
wire s38;
wire [DBLEN - 1:0] s39;
wire [DBLEN - 1:0] s40;
wire [DBLEN - 1:0] s41;
wire [DBLEN - 1:0] s42;
reg [2:0] s43;
wire [2:0] s44;
wire s45;
wire s46;
wire s47;
reg [4:0] s48;
wire s49;
wire [4:0] s50;
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
reg s64;
wire s65;
wire s66;
wire s67;
wire s68;
wire s69;
reg s70;
wire s71;
wire s72;
wire s73;
wire s74;
reg s75;
wire s76;
wire s77;
wire s78;
wire s79;
reg s80;
wire s81;
wire s82;
wire s83;
wire s84;
reg s85;
wire s86;
wire s87;
wire s88;
wire s89;
reg s90;
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
wire s101 = vfmis_cmt_valid & vfmis_cmt_kill;
wire s102;
wire s103;
wire [7:0] s104;
wire [7:0] s105;
wire [DBLEN - 1:0] s106;
wire [DBLEN - 1:0] s107;
wire [DBLEN - 1:0] s108;
wire [DBLEN - 1:0] s109;
wire [DBLEN - 1:0] s110;
wire [DBLEN - 1:0] s111;
wire [7:0] s112;
wire [7:0] s113;
wire [7:0] s114;
wire [7:0] s115;
wire [7:0] s116;
wire [7:0] s117;
reg [63:0] s118;
reg [63:0] s119;
reg s120;
wire s121;
reg s122;
wire s123;
wire s124;
wire s125;
reg [4:0] s126;
reg s127;
reg [DLEN / 16 - 1:0] s128;
reg s129;
reg s130;
reg s131;
wire s132;
wire s133;
wire s134;
wire s135;
reg [3:0] s136;
reg s137;
reg s138;
reg s139;
reg s140;
wire s141;
reg [7:0] s142;
reg [63:0] s143;
wire [63:0] s144;
wire [63:0] s145;
wire [63:0] s146;
reg s147;
reg s148;
reg s149;
reg [DBLEN - 1:0] s150;
reg [DBLEN - 1:0] s151;
reg [63:0] s152;
reg [4:0] s153;
wire [63:0] s154;
wire [DLEN - 1:0] s155;
wire [DLEN - 1:0] s156;
wire [DLEN - 1:0] s157;
wire [DLEN - 1:0] s158;
wire [63:0] s159;
wire [63:0] s160;
wire s161;
reg s162;
wire s163;
wire s164;
wire s165;
wire s166;
wire s167;
wire [DSHFAMT_BIT - 1:0] s168 = {s126[3:0],{DSHFAMT_BIT - 4{1'b0}}};
wire [DSHFAMT_BIT - 1:0] s169 = {1'b0,s126[3:0],{DSHFAMT_BIT - 5{1'b0}}};
wire [DSHFAMT_BIT - 1:0] s170;
reg [DLEN - 1:0] s171;
reg [DLEN - 1:0] s172;
reg [DLEN - 1:0] s173;
wire [DLEN - 1:0] s174;
wire [DLEN - 1:0] s175;
wire [63:0] s176;
wire [63:0] s177;
wire [63:0] s178;
reg [63:0] s179;
wire [63:0] s180;
wire [63:0] s181;
wire [63:0] s182;
wire [63:0] s183;
wire [63:0] s184;
wire [63:0] s185;
wire [63:0] s186;
wire [63:0] s187;
wire [63:0] s188;
wire [7:0] s189;
wire [63:0] s190;
wire [63:0] s191;
wire s192;
wire s193;
wire s194;
reg [4:0] s195;
wire s196;
wire s197;
wire [4:0] s198;
wire s199;
wire [63:0] s200;
wire [63:0] s201;
wire [63:0] s202;
wire [63:0] s203;
wire [63:0] s204;
wire [63:0] s205;
wire [63:0] s206;
wire [63:0] s207;
wire [63:0] s208;
wire s209;
wire s210;
wire s211;
wire s212;
wire s213;
wire [1:0] s214;
wire s215;
wire s216;
wire s217;
wire s218;
wire s219;
wire s220;
wire s221;
wire s222;
wire s223;
wire s224;
wire s225;
wire s226;
wire s227;
wire s228;
wire s229;
wire s230;
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
wire s245;
wire s246;
wire s247;
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
wire [7:0] s260;
wire [7:0] s261;
wire [7:0] s262;
wire s263;
wire s264;
wire s265;
wire s266;
wire s267;
wire s268;
assign s268 = ~s24 & ~s15 & s267 & ~s48[0] & (DLEN != VLEN) & ~s161 & ~s64 & ~s13;
assign s267 = vrf_vs2_valid & vrf_vs2_last;
assign s264 = s268 | (s24 & ~s15 & s267 & ~s48[1] & (DLEN != VLEN)) | (s16 & s267 & ~s48[1] & (DLEN != VLEN)) | (s17 & s267 & ~s48[2] & (DLEN != VLEN)) | (s18 & s267 & ~s48[3] & (DLEN != VLEN));
assign s263 = (~s13 & ~veq_ex_ctrl[14] & s267 & vrf_vs1_valid & ~vrf_vs1_last & s35[0]) | (~s13 & ~veq_ex_ctrl[14] & vrf_vs2_valid & ~vrf_vs2_last & vrf_vs1_valid & vrf_vs1_last & s35[0]);
assign s265 = (s22 & (DLEN == VLEN) & vrf_vd_valid & ~vrf_vd_last) | (s22 & (DLEN != VLEN) & s64 & vrf_vd_valid & ~vrf_vd_last) | (s22 & (DLEN != VLEN) & ~s64 & vrf_vd_valid & vrf_vd_last);
assign s266 = (s13 & (DLEN == VLEN) & vrf_vs1_valid & ~vrf_vs1_last & s69) | (s13 & (DLEN != VLEN) & vrf_vs1_valid & vrf_vs1_last & s69) | (s13 & (DLEN != VLEN) & vrf_vs1_valid & ~vrf_vs1_last & s90) | (s13 & s267 & ~s48[0] & (DLEN != VLEN) & s69);
assign s100 = ~s122 & wb_us_ready;
assign s194 = (s13 & ~s99) | (s13 & s98 & ~s100) | (s13 & s99 & s85 & s90 & ~vrf_vs1_valid) | (s13 & s99 & s85 & ~s100) | (s13 & s266);
assign s8 = s121 | (s11 & s193 & ~s100) | (s11 & s23 & ~s100) | (~s13 & ~s61) | s194;
assign s9 = veq_ex_valid;
assign s10 = veq_ex_ctrl[16];
assign s11 = veq_ex_ctrl[42];
assign s12 = veq_ex_ctrl[43];
assign s13 = veq_ex_ctrl[28];
assign s14 = veq_ex_ctrl[35];
assign s15 = veq_ex_ctrl[38];
assign s16 = veq_ex_ctrl[39];
assign s17 = veq_ex_ctrl[40];
assign s18 = veq_ex_ctrl[41];
assign s20 = veq_ex_ctrl[36];
assign s21 = veq_ex_ctrl[37];
assign s22 = veq_ex_ctrl[6] | veq_ex_ctrl[15] | veq_ex_ctrl[10] | veq_ex_ctrl[9] | veq_ex_ctrl[8] | veq_ex_ctrl[7];
assign s23 = veq_ex_ctrl[12] | veq_ex_ctrl[14];
assign nds_unused_f1_lmul = veq_ex_ctrl[20 +:3];
assign s24 = veq_ex_ctrl[70];
assign s25 = veq_ex_ctrl[24];
assign s26 = veq_ex_ctrl[48 +:11];
assign s27 = veq_ex_ctrl[60 +:10];
assign s28 = veq_ex_ctrl[59];
assign s29 = veq_ex_ctrl[31 +:4] & {(ELEN == 64),3'b111};
assign s30 = veq_ex_ctrl[44 +:4] & {(ELEN == 64),3'b111};
assign nds_unused_f1_op2_sew = (s25 ? {s30[2:0],1'b0} : s30) & {(ELEN == 64),3'b111};
assign s31 = veq_ex_ctrl[44 +:4];
assign s34 = veq_ex_ctrl[25];
assign s35 = veq_ex_ctrl[26 +:2];
assign s32 = s28 | s23;
assign s36 = veq_ex_cmt;
assign s37 = veq_ex_op1_valid;
assign s38 = s63;
assign s33 = s9 & f1_nxt_cmt & s101;
assign vfmis_lane_share_data = ({64{s70}} & vrf_vs1_rdata) | ({64{s122 & s148}} & {32'b0,vfmis_f2_narrow_wdata});
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s64 <= 1'b0;
    end
    else if (s68) begin
        s64 <= s67;
    end
end

assign s65 = s9 & s22 & s61 & s102 & ~s121 & (DLEN != VLEN) & ~s33 & ~s64;
assign s66 = (s64 & ~s121 & s61) | (s33 & s64);
assign s67 = (s64 | s65) & ~s66;
assign s68 = s65 | s66;
assign s19 = (vrf_vs2_last & s16 & s43[0]) | (vrf_vs2_last & s17 & (&s43[1:0])) | (vrf_vs2_last & s18 & (&s43[2:0]));
assign s63 = (s13 & s99) | (s15 & s19) | (~s13 & ~s22 & ~s15 & s102) | (s22 & s64) | (s22 & s102 & (DLEN == VLEN));
assign s45 = s46 | s47;
assign s47 = (s9 & s33 & s15) | (s9 & s15 & s16 & s43[0] & s46) | (s9 & s15 & s17 & (&s43[1:0]) & s46);
assign s46 = s9 & ~s8 & s15;
assign s44 = s47 ? 3'b0 : s43 + 3'b1;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s43 <= 3'b0;
    end
    else if (s45) begin
        s43 <= s44;
    end
end

assign s49 = s51 | s52;
assign s51 = s33 | (s63 & veq_ex_valid & ~s8) | (s97 & s13 & vrf_vs2_valid & ~s98 & ~s266) | (s96 & s70 & ~s98);
assign s60 = vrf_vs2_valid & vrf_vs1_valid & ~s266;
assign s59 = vrf_vs2_valid & ~s264;
assign s57 = (s34 & s59) | ~s34 | s64;
assign s58 = (s35[0] & vrf_vs1_valid & ~s263) | (s35[1] & s37) | (~(|s35)) | s64;
assign s62 = (s22 & vrf_vd_valid & ~s265) | (s64 & vrf_vd_valid & ~s265) | ~s22;
assign s61 = s57 & s58 & s62;
assign s53 = (vrf_vs1_valid & vrf_vs2_valid & s69 & ~s97 & ~s121 & ~s266) | (s75 & ~s96) | (s80 & ~s95);
assign s54 = ~s121 & s59;
assign s55 = (s61 & s100 & ~s22) | (s61 & ~s121 & s22);
assign s56 = (s57 & s58 & ~s121);
assign s52 = (veq_ex_valid & s13 & s53) | (veq_ex_valid & s15 & s54) | (veq_ex_valid & ~s13 & ~s15 & s11 & s55 & ~s64) | (veq_ex_valid & ~s13 & ~s15 & s12 & s56);
assign s50 = s51 ? 5'b0 : s48 + 5'b1;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s48 <= 5'b0;
    end
    else if (s49) begin
        s48 <= s50;
    end
end

assign s102 = s24 ? s103 : s25 ? s103 : s15 ? s19 : veq_ex_ctrl[14] ? (veq_ex_vd_len == s48[VRF_LW - 1:0]) : vrf_vs2_last;
generate
    if (DLEN == VLEN) begin:gen_x2_dlen_cal_last_1_1
        assign s103 = s24 ? vrf_vs2_last & s48[0] : vrf_vs2_last;
    end
    else begin:gen_x2_dlen_cal_last_2_1
        assign s103 = (s24 & vrf_vs2_last & s48[0]) | (s25 & (&s48[1:0]) & vrf_vs2_last);
    end
endgenerate
assign s163 = (s161 & s59 & ~s121 & ~s33);
assign s164 = (s162 & (s48[1:0] == 2'b11) & ~s121) | s33;
assign s166 = s163 | s164;
assign s165 = (s162 & ~s164) | s163;
assign s167 = (veq_ex_vd_len < s48[VRF_LW - 1:0]) & ~s13 & ~s25 & ~s22;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s162 <= 1'b0;
    end
    else if (s166) begin
        s162 <= s165;
    end
end

assign s161 = ((VLEN != DLEN) & s25 & vrf_vs2_last & (s48[1:0] == 2'b01)) | (s162 & (s48[1:0] == 2'b10));
assign vfmis_f1_valid = (s9 & s13 & s69 & s60 & ~s121) | (s9 & s75) | (s9 & s80) | (s9 & ~s13 & ~s23 & ~s15 & s61 & ~s64);
assign vfmis_f2_stall = s121;
assign s261 = (s116 & 8'h3 & {8{s29[1]}}) | (s116 & 8'hf & {8{s29[2]}}) | (s116 & 8'hf & {8{s29[3]}});
assign s262 = 8'b0;
assign s260 = ({8{s0[0]}} & s261) | ({8{~s0[0]}} & s262);
wire [7:0] s269;
assign s200 = ({64{s29[3]}} & {64'h7ffe000000000000}) | ({64{s29[2]}} & {2{32'h7fe00000}}) | ({64{s29[1] & ~s10}} & {4{16'h7f00}}) | ({64{s29[1] & s10}} & {4{16'h7fe0}});
assign s269 = {8{(vrf_vs2_rdata[63:0] != 64'h7ffe000000000000) & s29[3]}} | {{4{(vrf_vs2_rdata[63:32] != 32'h7fe00000) & s29[2]}},{4{(vrf_vs2_rdata[31:0] != 32'h7fe00000) & s29[2]}}} | {{2{(vrf_vs2_rdata[63:48] != 16'h7f00) & s29[1] & ~s10}},{2{(vrf_vs2_rdata[47:32] != 16'h7f00) & s29[1] & ~s10}},{2{(vrf_vs2_rdata[31:16] != 16'h7f00) & s29[1] & ~s10}},{2{(vrf_vs2_rdata[15:0] != 16'h7f00) & s29[1] & ~s10}}} | {{2{(vrf_vs2_rdata[63:48] != 16'h7fe0) & s29[1] & s10}},{2{(vrf_vs2_rdata[47:32] != 16'h7fe0) & s29[1] & s10}},{2{(vrf_vs2_rdata[31:16] != 16'h7fe0) & s29[1] & s10}},{2{(vrf_vs2_rdata[15:0] != 16'h7fe0) & s29[1] & s10}}};
assign vfmis_f1_byte_mask = (s116 & {8{~s259 & ~s75 & ~s80}}) | (s260 & {8{s259}}) | ({8{s75}} & s269) | ({8{s80}} & s269);
assign vfmis_f1_nrr_byte_mask = s117;
assign f1_nxt_cmt = (exs_nxt_cmt & ~s122 & s9 & ~s36) | (exs_nxt_cmt & s122 & ~s131 & ~s129) | (s122 & s129 & s131 & ~s36);
assign veq_ex_ready = (s13 & s98 & s100 & (DLEN == VLEN)) | (s13 & s100 & s85 & s60) | (s13 & s100 & s85 & ~s90) | (s11 & s193 & s102 & s61 & s38 & s100) | (s11 & s23 & s102 & s61 & s38 & s100) | (s11 & s22 & s61 & s38 & ~s121) | (~s13 & s12 & s102 & s57 & s58 & ~s121) | (~s13 & s15 & s19 & s57 & ~s121) | (s9 & s33);
assign veq_ex_byte_mask_srl = (veq_ex_valid & s13 & s60 & s69 & ~s121) | (veq_ex_valid & s15 & s59 & ~s121 & ~s264) | (veq_ex_valid & ~s13 & ~s15 & s11 & s55 & ~s64) | (veq_ex_valid & ~s13 & ~s15 & s12 & s56 & ~s25) | (veq_ex_valid & ~s13 & ~s15 & s12 & s56 & s25 & s48[0]);
assign veq_ex_nrr_byte_mask_srl = veq_ex_valid & s12 & s25 & s56;
assign s132 = (s9 & ~s8 & s36) | (s9 & ~s8 & f1_nxt_cmt & vfmis_cmt_valid) | (s122 & s121 & ~s131 & exs_nxt_cmt & vfmis_cmt_valid);
assign s133 = ~s121;
assign s134 = (s131 & ~s133) | s132;
assign s135 = s132 | s133;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s131 <= 1'b0;
    end
    else if (s135) begin
        s131 <= s134;
    end
end

assign s141 = exs_nxt_cmt & s101 & ~s131 & s122;
assign s121 = (s122 & ~wb_us_ready);
assign s123 = (s9 & s22 & ~s8 & ~s33) | (s9 & s12 & ~s8 & ~s33) | (s9 & s15 & ~s8 & ~s33) | (s122 & s121 & ~s141);
assign s124 = s9 & ~s8 | s141 | (~s121 & s122);
assign s125 = s9 & ~s8 & ~s33;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s122 <= 1'b0;
    end
    else if (s124) begin
        s122 <= s123;
    end
end

assign s154 = veq_ex_e_mask | {64{s28}};
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s120 <= 1'b0;
        s126 <= 5'b0;
        s127 <= 1'b0;
        s128 <= {DLEN / 16{1'b0}};
        s129 <= 1'b0;
        s130 <= 1'b0;
        s142 <= 8'b0;
        s143 <= 64'b0;
        s136 <= {4{1'b0}};
        s137 <= 1'b0;
        s138 <= 1'b0;
        s139 <= 1'b0;
        s140 <= 1'b0;
        s147 <= 1'b0;
        s148 <= 1'b0;
        s149 <= 1'b0;
        s150 <= {DBLEN{1'b0}};
        s151 <= {DBLEN{1'b0}};
        s152 <= 64'b0;
        s153 <= 5'b0;
    end
    else if (s125) begin
        s120 <= s10;
        s126 <= s48;
        s127 <= s22;
        s128 <= vfmis_f1_lane_cmp_bit;
        s129 <= s38;
        s130 <= s167;
        s142 <= s116;
        s143 <= s144;
        s136 <= s29;
        s137 <= s14;
        s138 <= s15;
        s139 <= s20;
        s140 <= s21;
        s147 <= s64;
        s148 <= s25;
        s149 <= s24;
        s150 <= s111;
        s151 <= s110;
        s152 <= s154;
        s153 <= vfmis_f1_flag_set;
    end
end

assign s144 = s16 ? {32'b0,vfmis_lane_vs2_x2_bdata} : s17 ? {48'b0,vfmis_lane_vs2_x4_bdata} : s18 ? {56'b0,vfmis_lane_vs2_x8_bdata} : vrf_vd_rdata;
assign s145 = s143;
assign s146 = s143;
integer s270;
wire s271;
wire s272;
wire s273;
wire s274;
wire s275;
wire s276;
wire s277;
wire s278;
wire s279;
wire s280;
wire s281;
wire s282;
wire s283;
wire s284;
wire s285;
wire s286;
wire s287;
wire s288;
wire s289;
wire s290;
wire s291;
wire s292;
wire s293;
wire s294;
wire s295;
wire s296;
wire s297;
wire s298;
wire s299;
wire s300;
wire s301;
wire s302;
wire [DBLEN / 4 - 1:0] s303;
wire [DBLEN / 2 - 1:0] s304;
wire [DBLEN - 1:0] s305;
wire [DBLEN / 4 - 1:0] s306;
wire [DBLEN / 2 - 1:0] s307;
wire [DBLEN - 1:0] s308;
wire s309;
wire s310;
wire s311;
wire s312;
wire s313;
wire s314;
wire s315;
wire s316;
wire s317;
wire s318;
wire s319;
wire s320;
wire s321;
wire s322;
wire s323;
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
wire s340;
wire [DBLEN / 4 - 1:0] s341;
wire [DBLEN / 2 - 1:0] s342;
wire [DBLEN - 1:0] s343;
wire [DBLEN / 4 - 1:0] s344;
wire [DBLEN / 2 - 1:0] s345;
wire [DBLEN - 1:0] s346;
wire s347 = ~(|s26[10:VL_MSB]);
wire s348 = ~(|s26[10:VL_MSB + 1]);
wire s349 = ~(|s26[10:VL_MSB + 2]);
assign s329 = (s48[0 +:MAX_DNUM] > s26[MASK_CAL_LSB +:MAX_DNUM]) & s347;
assign s330 = (s48[0 +:MAX_DNUM] > s26[(MASK_CAL_LSB + 1) +:MAX_DNUM]) & s348;
assign s331 = (s48[0 +:MAX_DNUM] > s26[(MASK_CAL_LSB + 2) +:MAX_DNUM]) & s349;
assign s325 = (s48[1 +:MAX_DNUM] > s26[MASK_CAL_LSB +:MAX_DNUM]) & s347;
assign s326 = (s48[1 +:MAX_DNUM] > s26[(MASK_CAL_LSB + 1) +:MAX_DNUM]) & s348;
assign s327 = (s48[1 +:MAX_DNUM] > s26[(MASK_CAL_LSB + 2) +:MAX_DNUM]) & s349;
assign s337 = (s48[0 +:MAX_DNUM] == s26[MASK_CAL_LSB +:MAX_DNUM]) & s347;
assign s338 = (s48[0 +:MAX_DNUM] == s26[(MASK_CAL_LSB + 1) +:MAX_DNUM]) & s348;
assign s339 = (s48[0 +:MAX_DNUM] == s26[(MASK_CAL_LSB + 2) +:MAX_DNUM]) & s349;
assign s333 = (s48[1 +:MAX_DNUM] == s26[MASK_CAL_LSB +:MAX_DNUM]) & s347;
assign s334 = (s48[1 +:MAX_DNUM] == s26[(MASK_CAL_LSB + 1) +:MAX_DNUM]) & s348;
assign s335 = (s48[1 +:MAX_DNUM] == s26[(MASK_CAL_LSB + 2) +:MAX_DNUM]) & s349;
generate
    if (VLEN == 1024) begin:gen_tail_ctrl_vlen1024
        assign s332 = (s48[0 +:MAX_DNUM] > s26[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & ~s26[VL_MSB + 3];
        assign s328 = (s48[1 +:MAX_DNUM] > s26[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & ~s26[VL_MSB + 3];
        assign s340 = (s48[0 +:MAX_DNUM] == s26[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & ~s26[VL_MSB + 3];
        assign s336 = (s48[1 +:MAX_DNUM] == s26[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & ~s26[VL_MSB + 3];
    end
    else begin:gen_tail_ctrl_vlen_n1024
        assign s332 = (s48[0 +:MAX_DNUM] > s26[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & (~|s26[10:VL_MSB + 3]);
        assign s328 = (s48[1 +:MAX_DNUM] > s26[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & (~|s26[10:VL_MSB + 3]);
        assign s340 = (s48[0 +:MAX_DNUM] == s26[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & (~|s26[10:VL_MSB + 3]);
        assign s336 = (s48[1 +:MAX_DNUM] == s26[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & (~|s26[10:VL_MSB + 3]);
    end
endgenerate
assign s309 = s25 ? s325 : s329;
assign s310 = s25 ? s326 : s330;
assign s311 = s25 ? s327 : s331;
assign s312 = s25 ? s328 : s332;
assign s313 = s25 ? s333 : s337;
assign s314 = s25 ? s334 : s338;
assign s315 = s25 ? s335 : s339;
assign s316 = s25 ? s336 : s340;
assign s317 = s329;
assign s318 = s330;
assign s319 = s331;
assign s320 = s332;
assign s321 = s337;
assign s322 = s338;
assign s323 = s339;
assign s324 = s340;
assign s341 = s314 ? (~({DLEN / 32{1'b1}} << s26[MASK_CAL_LSB:0])) : {DLEN / 32{~s310}};
assign s342 = s315 ? (~({DLEN / 16{1'b1}} << s26[MASK_CAL_LSB + 1:0])) : {DLEN / 16{~s311}};
assign s343 = s316 ? (~({DLEN / 8{1'b1}} << s26[MASK_CAL_LSB + 2:0])) : {DLEN / 8{~s312}};
assign s344 = s322 ? (~({DLEN / 32{1'b1}} << s26[MASK_CAL_LSB:0])) : {DLEN / 32{~s318}};
assign s345 = s323 ? (~({DLEN / 16{1'b1}} << s26[MASK_CAL_LSB + 1:0])) : {DLEN / 16{~s319}};
assign s346 = s324 ? (~({DLEN / 8{1'b1}} << s26[MASK_CAL_LSB + 2:0])) : {DLEN / 8{~s320}};
assign s291 = (s48[0 +:MAX_DNUM] < s27[MASK_CAL_LSB +:MAX_DNUM]) | (|s27[9:VL_MSB]);
assign s292 = (s48[0 +:MAX_DNUM] < s27[(MASK_CAL_LSB + 1) +:MAX_DNUM]) | (|s27[9:VL_MSB + 1]);
assign s287 = (s48[1 +:MAX_DNUM] < s27[MASK_CAL_LSB +:MAX_DNUM]) | (|s27[9:VL_MSB]);
assign s288 = (s48[1 +:MAX_DNUM] < s27[(MASK_CAL_LSB + 1) +:MAX_DNUM]) | (|s27[9:VL_MSB + 1]);
assign s299 = (s48[0 +:MAX_DNUM] == s27[MASK_CAL_LSB +:MAX_DNUM]) & (~|s27[9:VL_MSB]);
assign s300 = (s48[0 +:MAX_DNUM] == s27[(MASK_CAL_LSB + 1) +:MAX_DNUM]) & (~|s27[9:VL_MSB + 1]);
assign s295 = (s48[1 +:MAX_DNUM] == s27[MASK_CAL_LSB +:MAX_DNUM]) & (~|s27[9:VL_MSB]);
assign s296 = (s48[1 +:MAX_DNUM] == s27[(MASK_CAL_LSB + 1) +:MAX_DNUM]) & (~|s27[9:VL_MSB + 1]);
generate
    if (VLEN == 1024) begin:gen_ps_ctrl_vlen1024
        assign s294 = (s48[0 +:MAX_DNUM] < s27[(MASK_CAL_LSB + 3) +:MAX_DNUM]);
        assign s302 = (s48[0 +:MAX_DNUM] == s27[(MASK_CAL_LSB + 3) +:MAX_DNUM]);
        assign s290 = (s48[1 +:MAX_DNUM] < s27[(MASK_CAL_LSB + 3) +:MAX_DNUM]);
        assign s298 = (s48[1 +:MAX_DNUM] == s27[(MASK_CAL_LSB + 3) +:MAX_DNUM]);
        assign s293 = (s48[0 +:MAX_DNUM] < s27[(MASK_CAL_LSB + 2) +:MAX_DNUM]) | s27[VL_MSB + 2];
        assign s301 = (s48[0 +:MAX_DNUM] == s27[(MASK_CAL_LSB + 2) +:MAX_DNUM]) & ~s27[VL_MSB + 2];
        assign s289 = (s48[1 +:MAX_DNUM] < s27[(MASK_CAL_LSB + 2) +:MAX_DNUM]) | s27[VL_MSB + 2];
        assign s297 = (s48[1 +:MAX_DNUM] == s27[(MASK_CAL_LSB + 2) +:MAX_DNUM]) & ~s27[VL_MSB + 2];
    end
    else if (VLEN == 512) begin:gen_ps_ctrl_vlen512
        assign s294 = (s48[0 +:MAX_DNUM] < s27[(MASK_CAL_LSB + 3) +:MAX_DNUM]) | s27[VL_MSB + 3];
        assign s302 = (s48[0 +:MAX_DNUM] == s27[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & ~s27[VL_MSB + 3];
        assign s290 = (s48[1 +:MAX_DNUM] < s27[(MASK_CAL_LSB + 3) +:MAX_DNUM]) | s27[VL_MSB + 3];
        assign s298 = (s48[1 +:MAX_DNUM] == s27[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & ~s27[VL_MSB + 3];
        assign s293 = (s48[0 +:MAX_DNUM] < s27[(MASK_CAL_LSB + 2) +:MAX_DNUM]) | (|s27[9:VL_MSB + 2]);
        assign s301 = (s48[0 +:MAX_DNUM] == s27[(MASK_CAL_LSB + 2) +:MAX_DNUM]) & (~|s27[9:VL_MSB + 2]);
        assign s289 = (s48[1 +:MAX_DNUM] < s27[(MASK_CAL_LSB + 2) +:MAX_DNUM]) | (|s27[9:VL_MSB + 2]);
        assign s297 = (s48[1 +:MAX_DNUM] == s27[(MASK_CAL_LSB + 2) +:MAX_DNUM]) & (~|s27[9:VL_MSB + 2]);
    end
    else begin:gen_ps_ctrl_vlen_lt_512
        assign s294 = (s48[0 +:MAX_DNUM] < s27[(MASK_CAL_LSB + 3) +:MAX_DNUM]) | (|s27[9:VL_MSB + 3]);
        assign s302 = (s48[0 +:MAX_DNUM] == s27[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & (~|s27[9:VL_MSB + 3]);
        assign s290 = (s48[1 +:MAX_DNUM] < s27[(MASK_CAL_LSB + 3) +:MAX_DNUM]) | (|s27[9:VL_MSB + 3]);
        assign s298 = (s48[1 +:MAX_DNUM] == s27[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & (~|s27[9:VL_MSB + 3]);
        assign s293 = (s48[0 +:MAX_DNUM] < s27[(MASK_CAL_LSB + 2) +:MAX_DNUM]) | (|s27[9:VL_MSB + 2]);
        assign s301 = (s48[0 +:MAX_DNUM] == s27[(MASK_CAL_LSB + 2) +:MAX_DNUM]) & (~|s27[9:VL_MSB + 2]);
        assign s289 = (s48[1 +:MAX_DNUM] < s27[(MASK_CAL_LSB + 2) +:MAX_DNUM]) | (|s27[9:VL_MSB + 2]);
        assign s297 = (s48[1 +:MAX_DNUM] == s27[(MASK_CAL_LSB + 2) +:MAX_DNUM]) & (~|s27[9:VL_MSB + 2]);
    end
endgenerate
assign s271 = s25 ? s287 : s291;
assign s272 = s25 ? s288 : s292;
assign s273 = s25 ? s289 : s293;
assign s274 = s25 ? s290 : s294;
assign s275 = s25 ? s295 : s299;
assign s276 = s25 ? s296 : s300;
assign s277 = s25 ? s297 : s301;
assign s278 = s25 ? s298 : s302;
assign s279 = s291;
assign s280 = s292;
assign s281 = s293;
assign s282 = s294;
assign s283 = s299;
assign s284 = s300;
assign s285 = s301;
assign s286 = s302;
assign s303 = ({DLEN / 32{s276}} << s27[MASK_CAL_LSB:0]) | {DLEN / 32{~s272 & ~s276}};
assign s304 = ({DLEN / 16{s277}} << s27[MASK_CAL_LSB + 1:0]) | {DLEN / 16{~s273 & ~s277}};
assign s305 = ({DLEN / 8{s278}} << s27[MASK_CAL_LSB + 2:0]) | {DLEN / 8{~s274 & ~s278}};
assign s306 = ({DLEN / 32{s284}} << s27[MASK_CAL_LSB:0]) | {DLEN / 32{~s280 & ~s284}};
assign s307 = ({DLEN / 16{s285}} << s27[MASK_CAL_LSB + 1:0]) | {DLEN / 16{~s281 & ~s285}};
assign s308 = ({DLEN / 8{s286}} << s27[MASK_CAL_LSB + 2:0]) | {DLEN / 8{~s282 & ~s286}};
wire nds_unused_wire = (|s308) | (|s346);
generate
    if (DLEN > 128) begin:gen_ex_ps_tail_mask_dlen_gt128
        wire [DBLEN / 8 - 1:0] s350;
        wire [DBLEN / 8 - 1:0] s351;
        reg [DBLEN - 1:0] s352;
        reg [DBLEN - 1:0] s353;
        reg [DBLEN - 1:0] s354;
        reg [DBLEN - 1:0] s355;
        reg [DBLEN - 1:0] s356;
        reg [DBLEN - 1:0] s357;
        reg [DBLEN - 1:0] s358;
        wire [DBLEN / 8 - 1:0] s359;
        wire [DBLEN / 8 - 1:0] s360;
        reg [DBLEN - 1:0] s361;
        reg [DBLEN - 1:0] s362;
        reg [DBLEN - 1:0] s363;
        reg [DBLEN - 1:0] s364;
        reg [DBLEN - 1:0] s365;
        reg [DBLEN - 1:0] s366;
        reg [DBLEN - 1:0] s367;
        assign s350 = ({DLEN / 64{s275}} << s27[MASK_CAL_LSB - 1:0]) | {DLEN / 64{~s271 & ~s275}};
        assign s351 = ({DLEN / 64{s283}} << s27[MASK_CAL_LSB - 1:0]) | {DLEN / 64{~s279 & ~s283}};
        assign s359 = s313 ? (~({DLEN / 64{1'b1}} << s26[MASK_CAL_LSB - 1:0])) : {DLEN / 64{~s309}};
        assign s360 = s321 ? (~({DLEN / 64{1'b1}} << s26[MASK_CAL_LSB - 1:0])) : {DLEN / 64{~s317}};
        integer s270;
        always @* begin
            for (s270 = 0; s270 < DLEN / 64; s270 = s270 + 1) begin
                s352[s270 * 8 +:8] = {8{s350[s270]}};
                s361[s270 * 8 +:8] = {8{s359[s270]}};
                s356[s270 * 8 +:8] = {8{s351[s270]}};
                s365[s270 * 8 +:8] = {8{s360[s270]}};
            end
            for (s270 = 0; s270 < DLEN / 32; s270 = s270 + 1) begin
                s353[s270 * 4 +:4] = {4{s303[s270]}};
                s362[s270 * 4 +:4] = {4{s341[s270]}};
                s357[s270 * 4 +:4] = {4{s306[s270]}};
                s366[s270 * 4 +:4] = {4{s344[s270]}};
            end
            for (s270 = 0; s270 < DLEN / 16; s270 = s270 + 1) begin
                s354[s270 * 2 +:2] = {2{s304[s270]}};
                s363[s270 * 2 +:2] = {2{s342[s270]}};
                s358[s270 * 2 +:2] = {2{s307[s270]}};
                s367[s270 * 2 +:2] = {2{s345[s270]}};
            end
            for (s270 = 0; s270 < DLEN / 8; s270 = s270 + 1) begin
                s355[s270] = s305[s270];
                s364[s270] = s343[s270];
            end
        end

        assign s39 = (s352 & {DBLEN{s31[3]}}) | (s353 & {DBLEN{s31[2]}}) | (s354 & {DBLEN{s31[1]}}) | (s355 & {DBLEN{s31[0]}});
        assign s40 = (s361 & {DBLEN{s31[3]}}) | (s362 & {DBLEN{s31[2]}}) | (s363 & {DBLEN{s31[1]}}) | (s364 & {DBLEN{s31[0]}});
        assign s41 = (s356 & {DBLEN{s29[3]}}) | (s357 & {DBLEN{s29[2]}}) | (s358 & {DBLEN{s29[1]}});
        assign s42 = (s365 & {DBLEN{s29[3]}}) | (s366 & {DBLEN{s29[2]}}) | (s367 & {DBLEN{s29[1]}});
    end
    else if (DLEN == 128) begin:gen_ex_ps_mask_dlen128
        wire [DBLEN / 8 - 1:0] s350;
        wire [DBLEN / 8 - 1:0] s351;
        reg [DBLEN - 1:0] s352;
        reg [DBLEN - 1:0] s353;
        reg [DBLEN - 1:0] s354;
        reg [DBLEN - 1:0] s355;
        reg [DBLEN - 1:0] s356;
        reg [DBLEN - 1:0] s357;
        reg [DBLEN - 1:0] s358;
        wire [DBLEN / 8 - 1:0] s359;
        wire [DBLEN / 8 - 1:0] s360;
        reg [DBLEN - 1:0] s361;
        reg [DBLEN - 1:0] s362;
        reg [DBLEN - 1:0] s363;
        reg [DBLEN - 1:0] s364;
        reg [DBLEN - 1:0] s365;
        reg [DBLEN - 1:0] s366;
        reg [DBLEN - 1:0] s367;
        integer s270;
        assign s350 = ({DLEN / 64{s275}} << s27[0]) | {DLEN / 64{~s271 & ~s275}};
        assign s351 = ({DLEN / 64{s283}} << s27[0]) | {DLEN / 64{~s279 & ~s283}};
        assign s359 = s313 ? (~({DLEN / 64{1'b1}} << s26[0])) : {DLEN / 64{~s309}};
        assign s360 = s321 ? (~({DLEN / 64{1'b1}} << s26[0])) : {DLEN / 64{~s317}};
        always @* begin
            for (s270 = 0; s270 < DLEN / 64; s270 = s270 + 1) begin
                s352[s270 * 8 +:8] = {8{s350[s270]}};
                s361[s270 * 8 +:8] = {8{s359[s270]}};
                s356[s270 * 8 +:8] = {8{s351[s270]}};
                s365[s270 * 8 +:8] = {8{s360[s270]}};
            end
            for (s270 = 0; s270 < DLEN / 32; s270 = s270 + 1) begin
                s353[s270 * 4 +:4] = {4{s303[s270]}};
                s362[s270 * 4 +:4] = {4{s341[s270]}};
                s357[s270 * 4 +:4] = {4{s306[s270]}};
                s366[s270 * 4 +:4] = {4{s344[s270]}};
            end
            for (s270 = 0; s270 < DLEN / 16; s270 = s270 + 1) begin
                s354[s270 * 2 +:2] = {2{s304[s270]}};
                s363[s270 * 2 +:2] = {2{s342[s270]}};
                s358[s270 * 2 +:2] = {2{s307[s270]}};
                s367[s270 * 2 +:2] = {2{s345[s270]}};
            end
            for (s270 = 0; s270 < DLEN / 8; s270 = s270 + 1) begin
                s355[s270] = s305[s270];
                s364[s270] = s343[s270];
            end
        end

        assign s39 = (s352 & {DBLEN{s31[3]}}) | (s353 & {DBLEN{s31[2]}}) | (s354 & {DBLEN{s31[1]}}) | (s355 & {DBLEN{s31[0]}});
        assign s40 = (s361 & {DBLEN{s31[3]}}) | (s362 & {DBLEN{s31[2]}}) | (s363 & {DBLEN{s31[1]}}) | (s364 & {DBLEN{s31[0]}});
        assign s41 = (s356 & {DBLEN{s29[3]}}) | (s357 & {DBLEN{s29[2]}}) | (s358 & {DBLEN{s29[1]}});
        assign s42 = (s365 & {DBLEN{s29[3]}}) | (s366 & {DBLEN{s29[2]}}) | (s367 & {DBLEN{s29[1]}});
    end
    else begin:gen_ex_ps_mask_dlen64
        wire s350;
        reg [DBLEN - 1:0] s352;
        reg [DBLEN - 1:0] s353;
        reg [DBLEN - 1:0] s354;
        reg [DBLEN - 1:0] s355;
        wire s359;
        reg [DBLEN - 1:0] s361;
        reg [DBLEN - 1:0] s362;
        reg [DBLEN - 1:0] s363;
        reg [DBLEN - 1:0] s364;
        integer s270;
        assign s350 = ~s271;
        assign s359 = ~s309;
        always @* begin
            s352[7:0] = {8{s350}};
            s361[7:0] = {8{s359}};
            for (s270 = 0; s270 < DLEN / 32; s270 = s270 + 1) begin
                s353[s270 * 4 +:4] = {4{s303[s270 / 4]}};
                s362[s270 * 4 +:4] = {4{s341[s270 / 4]}};
            end
            for (s270 = 0; s270 < DLEN / 16; s270 = s270 + 1) begin
                s354[s270 * 2 +:2] = {2{s304[s270 / 2]}};
                s363[s270 * 2 +:2] = {2{s342[s270 / 2]}};
            end
            for (s270 = 0; s270 < DLEN / 8; s270 = s270 + 1) begin
                s355[s270] = s305[s270];
                s364[s270] = s343[s270];
            end
        end

        assign s39 = (s352 & {DBLEN{s31[3]}}) | (s353 & {DBLEN{s31[2]}}) | (s354 & {DBLEN{s31[1]}}) | (s355 & {DBLEN{s31[0]}});
        assign s40 = (s361 & {DBLEN{s31[3]}}) | (s362 & {DBLEN{s31[2]}}) | (s363 & {DBLEN{s31[1]}}) | (s364 & {DBLEN{s31[0]}});
        assign s41 = (s352 & {DBLEN{s29[3]}}) | (s353 & {DBLEN{s29[2]}}) | (s354 & {DBLEN{s29[1]}});
        assign s42 = (s361 & {DBLEN{s29[3]}}) | (s362 & {DBLEN{s29[2]}}) | (s363 & {DBLEN{s29[1]}});
    end
endgenerate
assign s104 = (veq_ex_byte_mask[7:0] | {8{s32}});
assign s105 = (veq_ex_nrr_byte_mask[7:0] | {8{s32}});
assign s109 = s42;
assign s107 = s40;
assign s108 = s41;
assign s106 = s39;
generate
    if (DLEN == 1024) begin:gen_d1024_mask_sel
        assign s113 = ({8{s0[0]}} & s107[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s107[8 * 2 - 1:8 * 1]) | ({8{s0[2]}} & s107[8 * 3 - 1:8 * 2]) | ({8{s0[3]}} & s107[8 * 4 - 1:8 * 3]) | ({8{s0[4]}} & s107[8 * 5 - 1:8 * 4]) | ({8{s0[5]}} & s107[8 * 6 - 1:8 * 5]) | ({8{s0[6]}} & s107[8 * 7 - 1:8 * 6]) | ({8{s0[7]}} & s107[8 * 8 - 1:8 * 7]) | ({8{s0[8]}} & s107[8 * 9 - 1:8 * 8]) | ({8{s0[9]}} & s107[8 * 10 - 1:8 * 9]) | ({8{s0[10]}} & s107[8 * 11 - 1:8 * 10]) | ({8{s0[11]}} & s107[8 * 12 - 1:8 * 11]) | ({8{s0[12]}} & s107[8 * 13 - 1:8 * 12]) | ({8{s0[13]}} & s107[8 * 14 - 1:8 * 13]) | ({8{s0[14]}} & s107[8 * 15 - 1:8 * 14]) | ({8{s0[15]}} & s107[8 * 16 - 1:8 * 15]);
        assign s112 = ({8{s0[0]}} & s106[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s106[8 * 2 - 1:8 * 1]) | ({8{s0[2]}} & s106[8 * 3 - 1:8 * 2]) | ({8{s0[3]}} & s106[8 * 4 - 1:8 * 3]) | ({8{s0[4]}} & s106[8 * 5 - 1:8 * 4]) | ({8{s0[5]}} & s106[8 * 6 - 1:8 * 5]) | ({8{s0[6]}} & s106[8 * 7 - 1:8 * 6]) | ({8{s0[7]}} & s106[8 * 8 - 1:8 * 7]) | ({8{s0[8]}} & s106[8 * 9 - 1:8 * 8]) | ({8{s0[9]}} & s106[8 * 10 - 1:8 * 9]) | ({8{s0[10]}} & s106[8 * 11 - 1:8 * 10]) | ({8{s0[11]}} & s106[8 * 12 - 1:8 * 11]) | ({8{s0[12]}} & s106[8 * 13 - 1:8 * 12]) | ({8{s0[13]}} & s106[8 * 14 - 1:8 * 13]) | ({8{s0[14]}} & s106[8 * 15 - 1:8 * 14]) | ({8{s0[15]}} & s106[8 * 16 - 1:8 * 15]);
        assign s115 = ({8{s0[0]}} & s109[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s109[8 * 2 - 1:8 * 1]) | ({8{s0[2]}} & s109[8 * 3 - 1:8 * 2]) | ({8{s0[3]}} & s109[8 * 4 - 1:8 * 3]) | ({8{s0[4]}} & s109[8 * 5 - 1:8 * 4]) | ({8{s0[5]}} & s109[8 * 6 - 1:8 * 5]) | ({8{s0[6]}} & s109[8 * 7 - 1:8 * 6]) | ({8{s0[7]}} & s109[8 * 8 - 1:8 * 7]) | ({8{s0[8]}} & s109[8 * 9 - 1:8 * 8]) | ({8{s0[9]}} & s109[8 * 10 - 1:8 * 9]) | ({8{s0[10]}} & s109[8 * 11 - 1:8 * 10]) | ({8{s0[11]}} & s109[8 * 12 - 1:8 * 11]) | ({8{s0[12]}} & s109[8 * 13 - 1:8 * 12]) | ({8{s0[13]}} & s109[8 * 14 - 1:8 * 13]) | ({8{s0[14]}} & s109[8 * 15 - 1:8 * 14]) | ({8{s0[15]}} & s109[8 * 16 - 1:8 * 15]);
        assign s114 = ({8{s0[0]}} & s108[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s108[8 * 2 - 1:8 * 1]) | ({8{s0[2]}} & s108[8 * 3 - 1:8 * 2]) | ({8{s0[3]}} & s108[8 * 4 - 1:8 * 3]) | ({8{s0[4]}} & s108[8 * 5 - 1:8 * 4]) | ({8{s0[5]}} & s108[8 * 6 - 1:8 * 5]) | ({8{s0[6]}} & s108[8 * 7 - 1:8 * 6]) | ({8{s0[7]}} & s108[8 * 8 - 1:8 * 7]) | ({8{s0[8]}} & s108[8 * 9 - 1:8 * 8]) | ({8{s0[9]}} & s108[8 * 10 - 1:8 * 9]) | ({8{s0[10]}} & s108[8 * 11 - 1:8 * 10]) | ({8{s0[11]}} & s108[8 * 12 - 1:8 * 11]) | ({8{s0[12]}} & s108[8 * 13 - 1:8 * 12]) | ({8{s0[13]}} & s108[8 * 14 - 1:8 * 13]) | ({8{s0[14]}} & s108[8 * 15 - 1:8 * 14]) | ({8{s0[15]}} & s108[8 * 16 - 1:8 * 15]);
    end
    else if (DLEN == 512) begin:gen_d512_mask_sel
        assign s113 = ({8{s0[0]}} & s107[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s107[8 * 2 - 1:8 * 1]) | ({8{s0[2]}} & s107[8 * 3 - 1:8 * 2]) | ({8{s0[3]}} & s107[8 * 4 - 1:8 * 3]) | ({8{s0[4]}} & s107[8 * 5 - 1:8 * 4]) | ({8{s0[5]}} & s107[8 * 6 - 1:8 * 5]) | ({8{s0[6]}} & s107[8 * 7 - 1:8 * 6]) | ({8{s0[7]}} & s107[8 * 8 - 1:8 * 7]);
        assign s112 = ({8{s0[0]}} & s106[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s106[8 * 2 - 1:8 * 1]) | ({8{s0[2]}} & s106[8 * 3 - 1:8 * 2]) | ({8{s0[3]}} & s106[8 * 4 - 1:8 * 3]) | ({8{s0[4]}} & s106[8 * 5 - 1:8 * 4]) | ({8{s0[5]}} & s106[8 * 6 - 1:8 * 5]) | ({8{s0[6]}} & s106[8 * 7 - 1:8 * 6]) | ({8{s0[7]}} & s106[8 * 8 - 1:8 * 7]);
        assign s115 = ({8{s0[0]}} & s109[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s109[8 * 2 - 1:8 * 1]) | ({8{s0[2]}} & s109[8 * 3 - 1:8 * 2]) | ({8{s0[3]}} & s109[8 * 4 - 1:8 * 3]) | ({8{s0[4]}} & s109[8 * 5 - 1:8 * 4]) | ({8{s0[5]}} & s109[8 * 6 - 1:8 * 5]) | ({8{s0[6]}} & s109[8 * 7 - 1:8 * 6]) | ({8{s0[7]}} & s109[8 * 8 - 1:8 * 7]);
        assign s114 = ({8{s0[0]}} & s108[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s108[8 * 2 - 1:8 * 1]) | ({8{s0[2]}} & s108[8 * 3 - 1:8 * 2]) | ({8{s0[3]}} & s108[8 * 4 - 1:8 * 3]) | ({8{s0[4]}} & s108[8 * 5 - 1:8 * 4]) | ({8{s0[5]}} & s108[8 * 6 - 1:8 * 5]) | ({8{s0[6]}} & s108[8 * 7 - 1:8 * 6]) | ({8{s0[7]}} & s108[8 * 8 - 1:8 * 7]);
    end
    else if (DLEN == 256) begin:gen_d256_mask_sel
        assign s113 = ({8{s0[0]}} & s107[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s107[8 * 2 - 1:8 * 1]) | ({8{s0[2]}} & s107[8 * 3 - 1:8 * 2]) | ({8{s0[3]}} & s107[8 * 4 - 1:8 * 3]);
        assign s112 = ({8{s0[0]}} & s106[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s106[8 * 2 - 1:8 * 1]) | ({8{s0[2]}} & s106[8 * 3 - 1:8 * 2]) | ({8{s0[3]}} & s106[8 * 4 - 1:8 * 3]);
        assign s115 = ({8{s0[0]}} & s109[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s109[8 * 2 - 1:8 * 1]) | ({8{s0[2]}} & s109[8 * 3 - 1:8 * 2]) | ({8{s0[3]}} & s109[8 * 4 - 1:8 * 3]);
        assign s114 = ({8{s0[0]}} & s108[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s108[8 * 2 - 1:8 * 1]) | ({8{s0[2]}} & s108[8 * 3 - 1:8 * 2]) | ({8{s0[3]}} & s108[8 * 4 - 1:8 * 3]);
    end
    else begin:gen_d128_mask_sel
        assign s113 = ({8{s0[0]}} & s107[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s107[8 * 2 - 1:8 * 1]);
        assign s112 = ({8{s0[0]}} & s106[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s106[8 * 2 - 1:8 * 1]);
        assign s115 = ({8{s0[0]}} & s109[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s109[8 * 2 - 1:8 * 1]);
        assign s114 = ({8{s0[0]}} & s108[8 * 1 - 1:8 * 0]) | ({8{s0[1]}} & s108[8 * 2 - 1:8 * 1]);
    end
endgenerate
assign s116 = s104 & s113 & s112;
assign s117 = s105 & s115 & s114;
reg [DBLEN - 1:0] s368;
reg [DBLEN - 1:0] s369;
reg [DBLEN - 1:0] s370;
reg [DBLEN - 1:0] s371;
reg [DBLEN - 1:0] s372;
reg [DBLEN - 1:0] s373;
integer s374;
integer s375;
always @* begin
    for (s270 = 0; s270 < DBLEN / 2; s270 = s270 + 1) begin
        s368[s270] = s107[s270 * 2 + 1];
        s371[s270] = s106[s270 * 2 + 1];
    end
    s368[DBLEN - 1:DBLEN / 2] = {DBLEN / 2{1'b0}};
    s371[DBLEN - 1:DBLEN / 2] = {DBLEN / 2{1'b0}};
end

always @* begin
    for (s374 = 0; s374 < DBLEN / 4; s374 = s374 + 1) begin
        s369[s374] = s107[s374 * 4 + 3];
        s372[s374] = s106[s374 * 4 + 3];
    end
    s369[DBLEN - 1:DBLEN * 1 / 4] = {DBLEN * 3 / 4{1'b0}};
    s372[DBLEN - 1:DBLEN * 1 / 4] = {DBLEN * 3 / 4{1'b0}};
end

always @* begin
    for (s375 = 0; s375 < DBLEN / 8; s375 = s375 + 1) begin
        s370[s375] = s107[s375 * 8 + 7];
        s373[s375] = s106[s375 * 8 + 7];
    end
    s370[DBLEN - 1:DBLEN * 1 / 8] = {DBLEN * 7 / 8{1'b0}};
    s373[DBLEN - 1:DBLEN * 1 / 8] = {DBLEN * 7 / 8{1'b0}};
end

assign s111 = ({DBLEN{s29[1]}} & s368) | ({DBLEN{s29[2]}} & s369) | ({DBLEN{s29[3]}} & s370);
assign s110 = ({DBLEN{s29[1]}} & s371) | ({DBLEN{s29[2]}} & s372) | ({DBLEN{s29[3]}} & s373);
always @* begin
    for (s270 = 0; s270 < 8; s270 = s270 + 1) begin
        s118[s270 * 8 +:8] = {8{s116[s270]}};
        s119[s270 * 8 +:8] = {8{veq_ex_byte_mask[s270] | veq_ex_ctrl[14]}};
    end
end

assign s98 = (s96 & s29[3] & s70 & ~s85) | (s95 & s80 & ~s85);
assign s99 = (s98 & ~s86) | s85;
assign s97 = s69 & vrf_vs2_last;
assign s69 = s9 & s13 & ~s80 & ~s70 & ~s85;
assign s96 = (s75 & (s48 == 5'd0) & (DLEN == 128)) | (s75 & (s48 == 5'd1) & (DLEN == 256)) | (s75 & (s48 == 5'd2) & (DLEN == 512)) | (s75 & (s48 == 5'd3) & (DLEN == 1024));
assign s71 = s97 & s69 & s13 & s60 & ~s33 & ~s121;
assign s72 = (s96 & ~s29[3]) | (s96 & s29[3] & wb_us_ready) | s33;
assign s73 = (s70 | s71) & ~s72;
assign s74 = s71 | s72;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s70 <= 1'b0;
    end
    else if (s74) begin
        s70 <= s73;
    end
end

assign s76 = s70 & ~s75 & ~s33;
assign s77 = s33 | (s75 & ~s96) | (s75 & ~s29[3]) | (s75 & s96 & s29[3] & wb_us_ready);
assign s78 = (s75 & ~s77) | s76;
assign s79 = s76 | s77;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s75 <= 1'b0;
    end
    else if (s79) begin
        s75 <= s78;
    end
end

assign s95 = (s80 & s29[2]) | (s80 & s29[1] & s48[0]);
assign s81 = (s97 & s69 & s60 & (DLEN == 64) & ~s29[3]) | (s96 & s70 & ~s29[3]);
assign s82 = (f1_nxt_cmt & vfmis_cmt_kill & vfmis_cmt_valid) | (s95 & wb_us_ready);
assign s83 = (s81 | s80) & ~s82;
assign s84 = s81 | s82;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s80 <= 1'b0;
    end
    else if (s84) begin
        s80 <= s83;
    end
end

assign s91 = s9 & s13 & s98 & (DLEN != VLEN) & wb_us_ready & ~s33 & ~vrf_vs1_last;
assign s92 = (s60 & wb_us_ready) | s33;
assign s93 = (s90 & ~s92) | s91;
assign s94 = (s91 | s92);
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s90 <= 1'b0;
    end
    else if (s94) begin
        s90 <= s93;
    end
end

assign s86 = s9 & s13 & s98 & (DLEN != VLEN) & wb_us_ready & ~s33;
assign s87 = (s85 & s60 & wb_us_ready) | (s85 & ~s90 & wb_us_ready) | s33;
assign s88 = (s85 & ~s87) | s86;
assign s89 = s86 | s87;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s85 <= 1'b0;
    end
    else if (s89) begin
        s85 <= s88;
    end
end

assign s193 = ~s13 & ~s22 & ~s23 & ~s15;
assign s224 = veq_ex_flush & s35[0];
assign s225 = veq_ex_flush & veq_ex_ctrl[25];
assign s226 = veq_ex_flush & s22;
assign s214 = veq_ex_nxt_ctrl[26 +:2];
assign s215 = veq_ex_nxt_ctrl[6] | veq_ex_nxt_ctrl[15] | veq_ex_nxt_ctrl[10] | veq_ex_nxt_ctrl[9] | veq_ex_nxt_ctrl[8] | veq_ex_nxt_ctrl[7];
assign s209 = s9 & s13;
assign s210 = s9 & s15;
assign s211 = s9 & s193;
assign s212 = s9 & s23;
assign s213 = s9 & s22;
assign s219 = s57 & s58;
assign s217 = veq_ex_nxt_valid & veq_ex_nxt_ctrl[25];
assign s216 = veq_ex_nxt_valid & s214[0];
assign s218 = veq_ex_nxt_valid & s215;
assign s220 = s211 & s219 & s35[0] & s100;
assign s221 = s212 & s219 & s35[0] & s100;
assign s222 = s213 & s61 & ~s64 & ~s121 & s35[0];
assign s223 = s209 & s98 & ~s85 & s100;
assign s228 = (s223 & ~s86) | (s60 & s90 & wb_us_ready);
assign s229 = s220 & s102;
assign s230 = s221 & s102;
assign s231 = (s222 & s102 & (DLEN == VLEN)) | (s213 & s64 & ~s121 & vrf_vd_valid & ~s265 & s35[0]);
assign s227 = s228 | s229 | s230 | s231;
assign s232 = (s223 & s86) | (s228 & s216) | (s90 & ~vrf_vs1_valid);
assign s233 = (s220 & ~s102) | (s229 & s216);
assign s234 = (s221 & ~s102) | (s230 & s216);
assign s235 = (s222 & ~s102) | (s231 & s216);
assign vrf_vs1_rd = (s9 & ~vrf_vs1_valid & s35[0] & ~s64 & ~s85) | s232 | s233 | s234 | s235 | (s224 & vrf_vs1_valid & s216) | (s9 & ~s35[0] & ~vrf_vs1_valid & s216);
assign vrf_vs1_kill = (s9 & s11 & ~s13 & s35[0] & s33) | (s9 & s13 & s33) | (s227 & ~s216) | (s224 & ~s216);
assign s236 = s9 & s11 & ~s24;
assign s237 = s9 & s11 & s24;
assign s238 = s9 & s12 & ~s24;
assign s239 = s9 & s12 & s24;
assign s240 = s209 & s60 & s69 & ~s121;
assign s241 = (s210 & s59 & ~s121 & s16 & s43[0]) | (s210 & s59 & ~s121 & s17 & (&s43[1:0])) | (s210 & s59 & ~s121 & s18 & (&s43[2:0]));
assign s242 = (s236 & s193 & s61 & s34 & s100) | (s236 & ~s64 & s22 & s61 & s34 & ~s121) | (s236 & s23 & s61 & s34 & s100);
assign s243 = s237 & s61 & s34 & s100 & s48[0];
assign s244 = s238 & s59 & ~s121;
assign s245 = s239 & s59 & s48[0] & ~s121;
assign s253 = (s209 & s98 & ~s86 & wb_us_ready) | (s209 & s85 & ~s90 & wb_us_ready) | (s209 & s85 & s90 & vrf_vs1_valid & wb_us_ready & ~s266);
assign s254 = s210 & s19 & s59 & ~s121;
assign s255 = (s236 & s102 & s193 & s61 & s34 & s100) | (s102 & ~s64 & s22 & s61 & s34 & ~s121 & (DLEN == VLEN)) | (s22 & s64 & vrf_vd_valid & ~s121 & ~s265) | (s102 & s23 & s61 & s34 & s100);
assign s256 = s59 & s237 & s102 & s100;
assign s257 = s59 & s238 & s102 & ~s121;
assign s258 = s59 & s239 & s102 & ~s121;
assign s252 = s253 | s254 | s255 | s256 | s257 | s258;
assign s246 = (s240 & ~s102) | (s253 & s217 & wb_us_ready);
assign s247 = (s241 & ~vrf_vs2_last) | (s254 & s217);
assign s248 = (s242 & ~s102 & ~s161) | (s255 & s217);
assign s249 = (s243 & ~s102) | (s256 & s217);
assign s250 = (s244 & ~s102 & ~s161) | (s257 & s217);
assign s251 = (s245 & ~s102) | (s258 & s217);
assign vrf_vs2_rd = (s9 & ~vrf_vs2_valid & veq_ex_ctrl[25] & ~s85 & ~s64) | s246 | s247 | s248 | s249 | s250 | s251 | (s225 & vrf_vs2_valid & s217) | (s9 & ~vrf_vs2_valid & ~veq_ex_ctrl[25] & s217);
assign vrf_vs2_kill = (s9 & s11 & s34 & s33) | (s9 & s12 & s33) | (s9 & s13 & s33) | (s9 & s15 & s33) | (s252 & ~s217) | (s225 & ~s217);
wire s376;
assign s376 = s9 & s22 & s61 & s102 & ~s121;
assign vrf_vd_rd = (s9 & s22 & ~vrf_vd_valid) | (s376 & ~s65 & s218) | (s376 & s65) | (vrf_vd_valid & s64 & s218 & ~s265) | (s64 & ~vrf_vd_valid) | (s226 & vrf_vd_valid & s218) | (s9 & ~vrf_vd_valid & ~s22 & s218);
assign vrf_vd_kill = (s9 & s22 & s33) | (s226 & ~s218) | (s376 & ~s65 & ~s218) | (vrf_vd_valid & s64 & ~s218);
assign s7 = s70 & ~s75 & ~s96 & (|s0[LANE_ID_BITS / 2 - 1:0]);
assign s207 = {32'b0,vfmis_f1_wdata[63:32]};
assign s208 = {16'b0,vfmis_f1_wdata[63:16]};
assign s3 = s81 & s0[0];
assign s4 = s97 & s69 & (DLEN != 64) & s60 & ~s121;
assign s5 = s80 & ~s95;
assign vrf_vs2_wr = s7 | s3 | s5 | s4;
assign vrf_vs2_wdata = ({64{s7 & (|s0[LANE_ID_BITS / 2 - 1:0])}} & vfmis_lane_cross_data[127:64]) | ({64{s3}} & s207) | ({64{s80}} & s208) | ({64{s69 & (s48 == 5'b0)}} & s201) | ({64{s69 & (s48 != 5'b0)}} & vfmis_f1_wdata);
assign s6 = s9 & s24 & vrf_vs2_valid & ~s38 & ~s8;
assign vrf_vs2_wide_wr = s6;
assign vrf_vs2_wide_wdata = vfmis_lane_vs2_x2_bdata;
assign vfmis_lane_vs2_data = vrf_vs2_rdata;
assign vfmis_lane_vs2_sel = s15 ? s43[2:0] : 3'b1;
assign s259 = s69 & (s48[4:0] == 5'b0);
assign s1 = s60 & s259 & ~s85 & ~s121;
assign s2 = (s69 & s60 & (s48[4:0] != 5'b0)) | (s75 & ~s96) | (s75 & s96 & ~s29[3]) | (s80 & ~s95);
assign vrf_vs1_wr = s7 | s1 | s2;
assign s202 = (s118 & vrf_vs2_rdata) | (~s118 & s200);
assign s204 = ({64{s29[3]}} & vrf_vs1_rdata) | ({64{s29[2]}} & {s200[63:32],vrf_vs1_rdata[31:0]}) | ({64{s29[1]}} & {s200[63:16],vrf_vs1_rdata[15:0]});
assign s205 = ({64{s29[3]}} & vfmis_f1_wdata) | ({64{s29[2]}} & {vrf_vs2_rdata[63:32],vfmis_f1_wdata[31:0]}) | ({64{s29[1]}} & {vrf_vs2_rdata[63:16],vfmis_f1_wdata[15:0]});
assign s203 = (s118 & s205) | (~s118 & s204);
assign s201 = ({64{(~s0[0])}} & s202) | ({64{s0[0]}} & s203);
assign s206 = vfmis_f1_wdata;
assign vrf_vs1_wdata = ({64{s1}} & s201) | ({64{s2}} & s206) | ({64{s7 & (|s0[LANE_ID_BITS / 2 - 1:0])}} & vfmis_lane_cross_data[63:0]);
wire s377;
wire s378;
assign s377 = &veq_ex_op1[63:16];
assign s378 = &veq_ex_op1[63:32];
assign s183 = vfmis_f1_wdata;
assign s185 = (s119 & {64{s29[1] & s377}} & {4{veq_ex_op1[15:0]}}) | (s119 & {64{s29[1] & ~s377 & ~s10}} & {4{16'h7e00}}) | (s119 & {64{s29[1] & ~s377 & s10}} & {4{16'h7fc0}}) | (s119 & {64{s29[2] & s378}} & {2{veq_ex_op1[31:0]}}) | (s119 & {64{s29[2] & ~s378}} & {2{32'h7fc00000}}) | (s119 & {64{s29[3]}} & {1{veq_ex_op1[63:0]}}) | (~s119 & vrf_vs2_rdata);
assign s184 = s118;
assign s189 = ({8{(s26 != 11'b0) & s29[1] & s0[0]}} & 8'b11) | ({8{(s26 != 11'b0) & s29[2] & s0[0]}} & 8'b1111) | ({8{(s26 != 11'b0) & s29[3] & s0[0]}} & 8'b11111111);
assign s187 = vfmis_f1_wdata & {64{s0[0]}};
assign s188 = ({64{s29[1] & s0[0]}} & 64'hffff) | ({64{s29[2] & s0[0]}} & 64'hffffffff) | ({64{s29[3] & s0[0]}} & 64'hffffffffffffffff);
kv_sint_to_fp_lane u_sint_to_fp_lane(
    .fp_mode(s120),
    .sign(s137),
    .sew(s136),
    .rdata(s146[31:0]),
    .wdata(s186),
    .sint_byte(s139),
    .sint_nibble(s140)
);
generate
    if (DLEN == 64) begin:sew64_sll_amt_dlen64
        assign s170 = {2'b0,s126[3:0]};
    end
    else begin:gen_sll_amt_dlen_not_64
        assign s170 = {2'b0,s126[3:0],{DSHFAMT_BIT - 6{1'b0}}};
    end
endgenerate
always @* begin
    s171[DLEN - 1:DLEN / 16] = {DLEN - DLEN / 16{1'b0}};
    s172[DLEN - 1:DLEN / 32] = {DLEN - DLEN / 32{1'b0}};
    s173[DLEN - 1:DLEN / 64] = {DLEN - DLEN / 64{1'b0}};
    for (s270 = 0; s270 < DLEN / 64; s270 = s270 + 1) begin
        s171[s270 * 4 +:4] = {s128[s270 * 4 +:4]};
        s172[s270 * 2 +:2] = {s128[s270 * 4 + 2],s128[s270 * 4]};
        s173[s270] = {s128[s270 * 4]};
    end
end

assign s174 = ({DLEN{s136[1]}} & (s171 << s168)) | ({DLEN{s136[2]}} & (s172 << s169)) | ({DLEN{s136[3]}} & (s173 << s170));
assign s175 = ({DLEN{s136[1]}} & ({DLEN{1'b1}} << s168)) | ({DLEN{s136[2]}} & ({DLEN{1'b1}} << s169)) | ({DLEN{s136[3]}} & ({DLEN{1'b1}} << s170)) | {DLEN{s147}};
assign s157 = {{DLEN - DBLEN{1'b0}},s150};
assign s158 = {{DLEN - DBLEN{1'b0}},s151};
assign s155 = (({DLEN{s136[1]}} & s157) << s168) | (({DLEN{s136[2]}} & s157) << s169) | (({DLEN{s136[3]}} & s157) << s170);
assign s156 = (({DLEN{s136[1]}} & s158) << s168) | (({DLEN{s136[2]}} & s158) << s169) | (({DLEN{s136[3]}} & s158) << s170);
wire [63:0] s379;
wire [63:0] s380;
generate
    if (DLEN == 1024) begin:gen_d1024_e_mask_sel
        assign s160 = ({64{s0[0]}} & s156[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s156[64 * 2 - 1:64 * 1]) | ({64{s0[2]}} & s156[64 * 3 - 1:64 * 2]) | ({64{s0[3]}} & s156[64 * 4 - 1:64 * 3]) | ({64{s0[4]}} & s156[64 * 5 - 1:64 * 4]) | ({64{s0[5]}} & s156[64 * 6 - 1:64 * 5]) | ({64{s0[6]}} & s156[64 * 7 - 1:64 * 6]) | ({64{s0[7]}} & s156[64 * 8 - 1:64 * 7]) | ({64{s0[8]}} & s156[64 * 9 - 1:64 * 8]) | ({64{s0[9]}} & s156[64 * 10 - 1:64 * 9]) | ({64{s0[10]}} & s156[64 * 11 - 1:64 * 10]) | ({64{s0[11]}} & s156[64 * 12 - 1:64 * 11]) | ({64{s0[12]}} & s156[64 * 13 - 1:64 * 12]) | ({64{s0[13]}} & s156[64 * 14 - 1:64 * 13]) | ({64{s0[14]}} & s156[64 * 15 - 1:64 * 14]) | ({64{s0[15]}} & s156[64 * 16 - 1:64 * 15]);
        assign s159 = ({64{s0[0]}} & s155[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s155[64 * 2 - 1:64 * 1]) | ({64{s0[2]}} & s155[64 * 3 - 1:64 * 2]) | ({64{s0[3]}} & s155[64 * 4 - 1:64 * 3]) | ({64{s0[4]}} & s155[64 * 5 - 1:64 * 4]) | ({64{s0[5]}} & s155[64 * 6 - 1:64 * 5]) | ({64{s0[6]}} & s155[64 * 7 - 1:64 * 6]) | ({64{s0[7]}} & s155[64 * 8 - 1:64 * 7]) | ({64{s0[8]}} & s155[64 * 9 - 1:64 * 8]) | ({64{s0[9]}} & s155[64 * 10 - 1:64 * 9]) | ({64{s0[10]}} & s155[64 * 11 - 1:64 * 10]) | ({64{s0[11]}} & s155[64 * 12 - 1:64 * 11]) | ({64{s0[12]}} & s155[64 * 13 - 1:64 * 12]) | ({64{s0[13]}} & s155[64 * 14 - 1:64 * 13]) | ({64{s0[14]}} & s155[64 * 15 - 1:64 * 14]) | ({64{s0[15]}} & s155[64 * 16 - 1:64 * 15]);
        assign s379 = ({64{s0[0]}} & s174[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s174[64 * 2 - 1:64 * 1]) | ({64{s0[2]}} & s174[64 * 3 - 1:64 * 2]) | ({64{s0[3]}} & s174[64 * 4 - 1:64 * 3]) | ({64{s0[4]}} & s174[64 * 5 - 1:64 * 4]) | ({64{s0[5]}} & s174[64 * 6 - 1:64 * 5]) | ({64{s0[6]}} & s174[64 * 7 - 1:64 * 6]) | ({64{s0[7]}} & s174[64 * 8 - 1:64 * 7]) | ({64{s0[8]}} & s174[64 * 9 - 1:64 * 8]) | ({64{s0[9]}} & s174[64 * 10 - 1:64 * 9]) | ({64{s0[10]}} & s174[64 * 11 - 1:64 * 10]) | ({64{s0[11]}} & s174[64 * 12 - 1:64 * 11]) | ({64{s0[12]}} & s174[64 * 13 - 1:64 * 12]) | ({64{s0[13]}} & s174[64 * 14 - 1:64 * 13]) | ({64{s0[14]}} & s174[64 * 15 - 1:64 * 14]) | ({64{s0[15]}} & s174[64 * 16 - 1:64 * 15]);
        assign s380 = ({64{s0[0]}} & s175[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s175[64 * 2 - 1:64 * 1]) | ({64{s0[2]}} & s175[64 * 3 - 1:64 * 2]) | ({64{s0[3]}} & s175[64 * 4 - 1:64 * 3]) | ({64{s0[4]}} & s175[64 * 5 - 1:64 * 4]) | ({64{s0[5]}} & s175[64 * 6 - 1:64 * 5]) | ({64{s0[6]}} & s175[64 * 7 - 1:64 * 6]) | ({64{s0[7]}} & s175[64 * 8 - 1:64 * 7]) | ({64{s0[8]}} & s175[64 * 9 - 1:64 * 8]) | ({64{s0[9]}} & s175[64 * 10 - 1:64 * 9]) | ({64{s0[10]}} & s175[64 * 11 - 1:64 * 10]) | ({64{s0[11]}} & s175[64 * 12 - 1:64 * 11]) | ({64{s0[12]}} & s175[64 * 13 - 1:64 * 12]) | ({64{s0[13]}} & s175[64 * 14 - 1:64 * 13]) | ({64{s0[14]}} & s175[64 * 15 - 1:64 * 14]) | ({64{s0[15]}} & s175[64 * 16 - 1:64 * 15]);
    end
    else if (DLEN == 512) begin:gen_d512_e_mask_sel
        assign s160 = ({64{s0[0]}} & s156[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s156[64 * 2 - 1:64 * 1]) | ({64{s0[2]}} & s156[64 * 3 - 1:64 * 2]) | ({64{s0[3]}} & s156[64 * 4 - 1:64 * 3]) | ({64{s0[4]}} & s156[64 * 5 - 1:64 * 4]) | ({64{s0[5]}} & s156[64 * 6 - 1:64 * 5]) | ({64{s0[6]}} & s156[64 * 7 - 1:64 * 6]) | ({64{s0[7]}} & s156[64 * 8 - 1:64 * 7]);
        assign s159 = ({64{s0[0]}} & s155[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s155[64 * 2 - 1:64 * 1]) | ({64{s0[2]}} & s155[64 * 3 - 1:64 * 2]) | ({64{s0[3]}} & s155[64 * 4 - 1:64 * 3]) | ({64{s0[4]}} & s155[64 * 5 - 1:64 * 4]) | ({64{s0[5]}} & s155[64 * 6 - 1:64 * 5]) | ({64{s0[6]}} & s155[64 * 7 - 1:64 * 6]) | ({64{s0[7]}} & s155[64 * 8 - 1:64 * 7]);
        assign s379 = ({64{s0[0]}} & s174[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s174[64 * 2 - 1:64 * 1]) | ({64{s0[2]}} & s174[64 * 3 - 1:64 * 2]) | ({64{s0[3]}} & s174[64 * 4 - 1:64 * 3]) | ({64{s0[4]}} & s174[64 * 5 - 1:64 * 4]) | ({64{s0[5]}} & s174[64 * 6 - 1:64 * 5]) | ({64{s0[6]}} & s174[64 * 7 - 1:64 * 6]) | ({64{s0[7]}} & s174[64 * 8 - 1:64 * 7]);
        assign s380 = ({64{s0[0]}} & s175[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s175[64 * 2 - 1:64 * 1]) | ({64{s0[2]}} & s175[64 * 3 - 1:64 * 2]) | ({64{s0[3]}} & s175[64 * 4 - 1:64 * 3]) | ({64{s0[4]}} & s175[64 * 5 - 1:64 * 4]) | ({64{s0[5]}} & s175[64 * 6 - 1:64 * 5]) | ({64{s0[6]}} & s175[64 * 7 - 1:64 * 6]) | ({64{s0[7]}} & s175[64 * 8 - 1:64 * 7]);
    end
    else if (DLEN == 256) begin:gen_d256_e_mask_sel
        assign s160 = ({64{s0[0]}} & s156[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s156[64 * 2 - 1:64 * 1]) | ({64{s0[2]}} & s156[64 * 3 - 1:64 * 2]) | ({64{s0[3]}} & s156[64 * 4 - 1:64 * 3]);
        assign s159 = ({64{s0[0]}} & s155[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s155[64 * 2 - 1:64 * 1]) | ({64{s0[2]}} & s155[64 * 3 - 1:64 * 2]) | ({64{s0[3]}} & s155[64 * 4 - 1:64 * 3]);
        assign s379 = ({64{s0[0]}} & s174[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s174[64 * 2 - 1:64 * 1]) | ({64{s0[2]}} & s174[64 * 3 - 1:64 * 2]) | ({64{s0[3]}} & s174[64 * 4 - 1:64 * 3]);
        assign s380 = ({64{s0[0]}} & s175[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s175[64 * 2 - 1:64 * 1]) | ({64{s0[2]}} & s175[64 * 3 - 1:64 * 2]) | ({64{s0[3]}} & s175[64 * 4 - 1:64 * 3]);
    end
    else begin:gen_d128_e_mask_sel
        assign s160 = ({64{s0[0]}} & s156[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s156[64 * 2 - 1:64 * 1]);
        assign s159 = ({64{s0[0]}} & s155[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s155[64 * 2 - 1:64 * 1]);
        assign s379 = ({64{s0[0]}} & s174[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s174[64 * 2 - 1:64 * 1]);
        assign s380 = ({64{s0[0]}} & s175[64 * 1 - 1:64 * 0]) | ({64{s0[1]}} & s175[64 * 2 - 1:64 * 1]);
    end
endgenerate
assign s176 = s160 & s159 & s152;
assign s177 = (s176 & s379 & {64{~s147}}) | (~s176 & s145 & {64{~s147}}) | ({64{s147}} & s145);
assign s178 = s380 | {64{s147}};
assign s180 = vfmis_f2_wdata;
always @* begin
    for (s270 = 0; s270 < 8; s270 = s270 + 1) begin
        s179[s270 * 8 +:8] = {8{s142[s270]}};
    end
end

assign s181 = s179;
assign s182 = s179;
assign s191 = ({64{s126[0] & (|s0[LANE_ID_BITS - 1:LANE_ID_BITS / 2])}} & s179) | ({64{~s126[0] & (|s0[LANE_ID_BITS / 2 - 1:0])}} & s179);
assign s190 = {vfmis_lane_cross_data[95:64],vfmis_lane_cross_data[31:0]};
assign s192 = ~s148 & ~s127 & ~s138;
assign wb_us_flag_update = (s9 & ~s33 & s13 & s98 & ~s85 & wb_us_ready) | (s9 & ~s33 & s11 & s193 & s61 & wb_us_ready) | (s122 & ~s141 & s127 & ~s147 & wb_us_ready) | (s122 & ~s141 & ~s127 & ~s138 & wb_us_ready);
assign wb_us_flag_clr = (s122 & s141 & wb_us_ready) | (s9 & s33 & ~s122 & wb_us_ready);
assign wb_us_flag = (s122 & ~s141) ? s127 ? s153 : vfmis_f2_flag_set : s13 ? vfmis_f1_flag_set | s195 : vfmis_f1_flag_set;
assign s196 = s69 | s80 | s70;
assign s197 = ((s69 | s80 | s70) & s33) | (s9 & s13 & s98 & wb_us_ready);
assign s198 = s197 ? 5'b0 : vfmis_f1_flag_set | s195;
assign s199 = s196 | s197;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s195 <= 5'b0;
    end
    else if (s199) begin
        s195 <= s198;
    end
end

wire s381;
wire s382;
wire s383;
wire s384;
wire s385;
wire s386;
wire s387;
wire s388;
assign s381 = (s9 & s13 & s85 & ~s90) | (s9 & s13 & s85 & s90 & s60);
assign s382 = (s9 & s13 & s98 & ~s266);
assign s383 = s381 | s382;
assign s384 = (s9 & s11 & s193 & s61);
assign s385 = (s9 & s11 & s23 & s61);
assign s386 = (s122 & s127 & s129) | (s122 & s127 & s64);
assign s387 = (s122 & ~s127 & ~s148) | (s122 & s148 & s126[0]) | (s122 & s148 & s129);
assign s388 = s122 & s138;
assign wb_us_valid = (s383 & ~s122 & ~s33) | (s384 & ~s122 & ~s33) | (s385 & ~s122 & ~s33) | (s386 & ~s141) | (s387 & ~s141) | (s388 & ~s141);
assign wb_us_skip = s122 ? s130 : s167;
assign wb_us_wdata_src0 = ({64{s13}} & s187) | ({64{s193}} & s183);
assign wb_us_wdata_src1 = ({64{s127}} & s177) | ({64{s148}} & s190) | ({64{s192}} & s180) | ({64{s138}} & s186);
assign wb_us_wdata_src2 = s185;
assign wb_us_bit_wen = ({64{s9 & ~s33 & s13 & s98 & wb_us_ready}} & s188) | ({64{s9 & ~s33 & s11 & s193 & wb_us_ready & ~s122}} & s184) | ({64{s9 & ~s33 & s11 & s23 & wb_us_ready & ~s122}} & s184) | ({64{s122 & ~s141 & s148 & wb_us_ready}} & s191) | ({64{s122 & ~s141 & s149 & wb_us_ready}} & s182) | ({64{s122 & ~s141 & ~s149 & ~s148 & ~s127 & wb_us_ready}} & s181) | ({64{s122 & ~s141 & s127 & wb_us_ready}} & s178);
assign wb_us_last = (wb_us_src[0] & s38) | (wb_us_src[1] & s129) | (wb_us_src[2] & s38);
assign wb_us_src[2] = s9 & ~(s122 & ~s141) & s23;
assign wb_us_src[1] = s122 & ~s141;
assign wb_us_src[0] = s9 & ~(s122 & ~s141) & ~s23;
assign wb_us_mask_wdata = ({8{wb_us_src[0] & s13 & ~s85}} & s189) | ({8{(wb_us_src[0] | wb_us_src[2]) & ~s13}} & s116) | ({8{wb_us_src[1]}} & (s142 | {8{s127}}));
assign wb_us_cmtted = (wb_us_src[0] & f1_nxt_cmt & vfmis_cmt_valid) | (wb_us_src[0] & s36) | (wb_us_src[1] & exs_nxt_cmt & vfmis_cmt_valid) | (wb_us_src[1] & s131) | (wb_us_src[2] & exs_nxt_cmt & vfmis_cmt_valid) | (wb_us_src[2] & s36);
assign vfmis_standby_ready = ~veq_ex_valid & ~veq_ex_flush & ~s9 & ~s122 & wb_standby;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

