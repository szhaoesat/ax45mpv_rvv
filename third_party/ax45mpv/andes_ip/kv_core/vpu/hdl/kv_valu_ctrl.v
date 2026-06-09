// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_valu_ctrl (
    vpu_valu_clk,
    vpu_reset_n,
    lane_id,
    valu_standby_ready,
    valu_cmt_valid,
    valu_cmt_kill,
    veq_ex_valid,
    veq_ex_flush,
    veq_ex_ready,
    veq_ex_ctrl,
    veq_ex_vd_len,
    veq_ex_byte_mask,
    veq_ex_nrr_byte_mask,
    veq_ex_e_mask0,
    veq_ex_e_mask1,
    veq_ex_cmt,
    veq_ex_scalar_valid,
    veq_ex_byte_mask_srl,
    veq_ex_nrr_byte_mask_srl,
    veq_ex_nxt_valid,
    veq_ex_nxt_ctrl,
    exs_nxt_cmt,
    ex_nxt_cmt,
    wb_standby,
    wb_us_valid,
    wb_us_ready,
    wb_us_flag_update,
    wb_us_flag_clr,
    wb_us_flag,
    wb_us_wdata_src0,
    wb_us_wdata_src1,
    wb_us_wdata_src2,
    wb_us_wdata_src3,
    wb_us_src,
    wb_us_bit_wen,
    wb_us_mask_wdata,
    wb_us_cmtted,
    wb_us_last,
    wb_us_skip,
    vrf_vs1_valid,
    vrf_vs1_rd,
    vrf_vs1_kill,
    vrf_vs1_wr,
    vrf_vs1_wdata,
    vrf_vs1_rdata,
    vrf_vs1_last,
    vrf_vs1_wide_wr,
    vrf_vs1_wide_wdata,
    vrf_vs2_valid,
    vrf_vs2_rd,
    vrf_vs2_kill,
    vrf_vs2_wr,
    vrf_vs2_wdata,
    vrf_vs2_rdata,
    vrf_vs2_last,
    vrf_vs2_wide_wr,
    vrf_vs2_wide_wdata,
    vrf_vs2_wide_rdata,
    vrf_vd_valid,
    vrf_vd_rd,
    vrf_vd_kill,
    vrf_vd_wr,
    vrf_vd_wdata,
    vrf_vd_rdata,
    vrf_vd_last,
    vrf_vd_srl,
    valu_mask_byte8,
    valu_nrr_mask_byte8,
    valu_ci_byte8,
    valu_vs2_red_non_ext,
    valu_data64,
    valu_data32,
    valu_data64_red,
    valu_mresult,
    vxsat_set,
    valu_mask_result,
    valu_lane_vs2_wide_bdata,
    valu_lane_vs1_wide_bdata,
    valu_lane_vs2_data,
    valu_lane_vs1_data,
    valu_lane_mask_result,
    valu_lane_share_result_data,
    valu_lane_cross_result_data
);
parameter VLEN = 1024;
parameter DLEN = 512;
parameter ELEN = 64;
parameter XLEN = 64;
parameter VRF_LW = 4;
localparam LANE_NUM = DLEN / 64;
localparam DBLEN = DLEN / 8;
localparam DSHFAMT_BIT = (DLEN == 1024) ? 10 : (DLEN == 512) ? 9 : (DLEN == 256) ? 8 : (DLEN == 128) ? 7 : 6;
localparam VSHFAMT_BIT = (VLEN == 1024) ? 10 : (VLEN == 512) ? 9 : (VLEN == 256) ? 8 : 7;
localparam MASK_CAL_LSB = (DLEN == 1024) ? 4 : (DLEN == 512) ? 3 : (DLEN == 256) ? 2 : (DLEN == 128) ? 1 : 0;
localparam MAX_DNUM = (VLEN == DLEN) ? 3 : 4;
localparam VL_MSB = MASK_CAL_LSB + MAX_DNUM;
localparam LANE_ID_BITS = DLEN / 64;
input vpu_valu_clk;
input vpu_reset_n;
input [31:0] lane_id;
output valu_standby_ready;
input valu_cmt_valid;
input valu_cmt_kill;
input veq_ex_valid;
input veq_ex_flush;
output veq_ex_ready;
input [58 - 1:0] veq_ex_ctrl;
input [VRF_LW - 1:0] veq_ex_vd_len;
input [127:0] veq_ex_byte_mask;
input [127:0] veq_ex_nrr_byte_mask;
input [63:0] veq_ex_e_mask0;
input [63:0] veq_ex_e_mask1;
input veq_ex_cmt;
input veq_ex_scalar_valid;
output veq_ex_byte_mask_srl;
output veq_ex_nrr_byte_mask_srl;
input veq_ex_nxt_valid;
input [58 - 1:0] veq_ex_nxt_ctrl;
input exs_nxt_cmt;
output ex_nxt_cmt;
output wb_us_valid;
input wb_us_ready;
input wb_standby;
output wb_us_flag_update;
output wb_us_flag_clr;
output wb_us_flag;
output [63:0] wb_us_wdata_src0;
output [63:0] wb_us_wdata_src1;
output [63:0] wb_us_wdata_src2;
output [63:0] wb_us_wdata_src3;
output [3:0] wb_us_src;
output [63:0] wb_us_bit_wen;
output [7:0] wb_us_mask_wdata;
output wb_us_cmtted;
output wb_us_last;
output wb_us_skip;
input vrf_vs1_valid;
output vrf_vs1_rd;
output vrf_vs1_kill;
output vrf_vs1_wr;
output [63:0] vrf_vs1_wdata;
input [63:0] vrf_vs1_rdata;
input vrf_vs1_last;
output vrf_vs1_wide_wr;
output [31:0] vrf_vs1_wide_wdata;
input vrf_vs2_valid;
output vrf_vs2_rd;
output vrf_vs2_kill;
output vrf_vs2_wr;
output [63:0] vrf_vs2_wdata;
input [63:0] vrf_vs2_rdata;
input vrf_vs2_last;
output vrf_vs2_wide_wr;
output [31:0] vrf_vs2_wide_wdata;
input [31:0] vrf_vs2_wide_rdata;
input vrf_vd_valid;
output vrf_vd_rd;
output vrf_vd_kill;
output vrf_vd_wr;
output [63:0] vrf_vd_wdata;
input [63:0] vrf_vd_rdata;
input vrf_vd_last;
output vrf_vd_srl;
output [7:0] valu_mask_byte8;
output [7:0] valu_nrr_mask_byte8;
output [7:0] valu_ci_byte8;
output valu_vs2_red_non_ext;
input [63:0] valu_data64;
input [31:0] valu_data32;
input [63:0] valu_data64_red;
input [7:0] valu_mresult;
input vxsat_set;
output [7:0] valu_mask_result;
input [31:0] valu_lane_vs2_wide_bdata;
input [31:0] valu_lane_vs1_wide_bdata;
output [63:0] valu_lane_vs2_data;
output [63:0] valu_lane_vs1_data;
input [DLEN / 8 - 1:0] valu_lane_mask_result;
output [63:0] valu_lane_share_result_data;
input [127:0] valu_lane_cross_result_data;





// 1ec15768 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0;
wire s1;
wire s2;
wire s3;
wire s4;
wire s5;
wire s6;
wire s7;
reg [5:0] s8;
wire [5:0] s9;
wire s10;
wire s11;
wire s12;
wire s13;
wire s14;
reg [DLEN - 1:0] s15;
reg [DLEN - 1:0] s16;
reg [DLEN - 1:0] s17;
reg [DLEN - 1:0] s18;
wire [DLEN - 1:0] s19;
reg [63:0] s20;
reg s21;
wire s22;
wire s23;
wire s24;
wire s25;
wire s26;
reg [3:0] s27;
reg s28;
wire s29;
reg [5:0] s30;
reg s31;
reg [DBLEN - 1:0] s32;
reg [DBLEN - 1:0] s33;
reg [63:0] s34;
reg [63:0] s35;
wire [DLEN - 1:0] s36;
wire [DLEN - 1:0] s37;
wire [DLEN - 1:0] s38;
wire [DLEN - 1:0] s39;
wire [63:0] s40;
wire [63:0] s41;
reg [7:0] s42;
reg s43;
wire s44;
wire s45;
wire s46;
wire s47;
wire s48;
reg s49;
wire ex_nxt_cmt;
reg s50;
wire s51;
wire s52;
wire s53;
wire s54;
wire s55;
wire s56;
wire s57;
wire [DLEN - 1:0] s58;
wire [63:0] s59;
wire [DLEN - 1:0] s60;
wire [DSHFAMT_BIT - 1:0] s61 = {s30[2:0],{DSHFAMT_BIT - 3{1'b0}}};
wire [DSHFAMT_BIT - 1:0] s62 = {s30[3:0],{DSHFAMT_BIT - 4{1'b0}}};
wire [DSHFAMT_BIT - 1:0] s63 = {1'b0,s30[3:0],{DSHFAMT_BIT - 5{1'b0}}};
wire [DSHFAMT_BIT - 1:0] s64;
wire [63:0] s65;
wire [63:0] s66;
wire s67;
wire s68;
wire s69;
wire s70;
wire s71;
wire s72;
wire [7:0] s73;
wire [DLEN / 8 - 1:0] s74;
wire [DLEN / 8 - 1:0] s75;
wire [DLEN / 8 - 1:0] s76;
wire [DLEN / 8 - 1:0] s77;
wire [DLEN / 8 - 1:0] s78;
reg [63:0] s79;
reg [63:0] s80;
reg [63:0] s81;
wire [7:0] s82;
wire s83 = (VLEN == DLEN);
wire s84;
wire s85;
wire s86;
wire s87;
wire s88;
reg s89;
wire s90;
wire s91;
wire s92;
wire s93;
reg s94;
wire s95;
wire s96;
wire s97;
wire s98;
reg s99;
wire s100;
wire s101;
wire s102;
wire s103;
wire s104;
wire s105;
wire s106;
wire s107;
wire [DBLEN - 1:0] s108;
wire [DBLEN - 1:0] s109;
wire [DBLEN - 1:0] s110;
wire [DBLEN - 1:0] s111;
wire [DBLEN - 1:0] s112;
wire [DBLEN - 1:0] s113;
wire s114;
wire s115;
wire s116;
integer s117;
wire s118;
wire s119;
wire s120;
wire s121;
wire s122;
wire s123;
wire s124;
wire s125;
wire [DBLEN / 4 - 1:0] s126;
wire [DBLEN / 2 - 1:0] s127;
wire [DBLEN - 1:0] s128;
wire [DBLEN / 4 - 1:0] s129;
wire [DBLEN / 2 - 1:0] s130;
wire [DBLEN - 1:0] s131;
wire s132;
wire s133;
wire s134;
wire s135;
wire s136;
wire s137;
wire s138;
wire s139;
wire s140;
wire s141;
wire s142;
wire s143;
wire s144;
wire s145;
wire s146;
wire s147;
wire s148;
wire s149;
wire s150;
wire s151;
wire [DBLEN / 4 - 1:0] s152;
wire [DBLEN / 2 - 1:0] s153;
wire [DBLEN - 1:0] s154;
wire [DBLEN / 4 - 1:0] s155;
wire [DBLEN / 2 - 1:0] s156;
wire [DBLEN - 1:0] s157;
wire [63:0] s158;
wire s159;
wire s160;
wire s161;
wire [63:0] s162;
wire s163;
wire s164;
wire s165;
wire s166;
wire [63:0] s167;
wire [63:0] s168;
wire [63:0] s169;
wire [63:0] s170;
wire [63:0] s171;
wire [63:0] s172;
wire [63:0] s173;
wire [63:0] s174;
wire [63:0] s175;
wire [63:0] s176;
wire [63:0] s177;
wire [63:0] s178;
wire [63:0] s179;
wire [63:0] s180;
wire [63:0] s181;
reg [7:0] s182;
wire [7:0] s183;
wire s184;
wire [7:0] s185 = valu_mresult;
wire [DLEN / 8 - 1:0] s186 = valu_lane_mask_result;
assign valu_mask_result = s42;
wire [LANE_ID_BITS - 1:0] s187 = lane_id[LANE_ID_BITS - 1:0];
wire s188 = veq_ex_ctrl[21];
wire [2:0] s189 = veq_ex_ctrl[5 +:3];
wire [3:0] s190 = veq_ex_ctrl[15 +:4] & {(ELEN == 64),3'b111};
wire s191 = veq_ex_ctrl[57];
wire s192 = veq_ex_ctrl[10];
wire [10:0] s193 = veq_ex_ctrl[28 +:11];
wire [9:0] s194 = veq_ex_ctrl[47 +:10];
wire s195 = veq_ex_ctrl[11];
wire s196 = veq_ex_ctrl[40];
wire s197;
wire [3:0] s198 = veq_ex_ctrl[41 +:4] & {(ELEN == 64),3'b111};
wire s199 = veq_ex_ctrl[45];
wire s200 = veq_ex_ctrl[46];
wire s201 = s191 & ~s199;
wire [3:0] s202 = veq_ex_ctrl[24 +:4] & {(ELEN == 64),3'b111};
wire s203 = veq_ex_ctrl[39];
wire s204 = veq_ex_valid;
wire s205 = veq_ex_cmt;
wire s206;
wire s207;
wire s208;
wire s209;
wire s210;
wire s211;
wire s212;
wire s213;
wire s214;
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
wire s235 = veq_ex_nxt_valid & veq_ex_nxt_ctrl[40];
wire s236 = veq_ex_nxt_valid & veq_ex_nxt_ctrl[46];
wire s237 = veq_ex_nxt_valid & veq_ex_nxt_ctrl[9];
wire s238 = veq_ex_ctrl[8];
wire s239 = veq_ex_ctrl[14];
wire s240 = veq_ex_ctrl[23];
wire s241 = s239 & (s189 == 3'b011);
wire s242 = s239 & (s189 == 3'b010);
wire nds_unused_ex_vredsum = s240 & (s189 == 3'b011);
wire s243 = s238 & (s189 == 3'b100);
wire s244 = s238 & (s189 == 3'b101);
wire s245 = s238 & (s189 == 3'b110);
wire s246 = s239 & (s189 == 3'b101);
wire s247 = s239 & (s189 == 3'b100);
wire s248 = veq_ex_ctrl[9];
wire s249 = veq_ex_ctrl[12];
wire s250 = ~s248 & ~s249;
wire s251 = s248 & s240;
assign s197 = (veq_ex_ctrl[57] & ~s249) | veq_ex_ctrl[10];
wire s252 = (DLEN == 64) & s202[3];
wire s253 = s203 | (s240 & (s189 == 3'b100));
reg s254;
wire s255;
wire s256;
wire s257;
wire s258;
wire s259;
assign s259 = (s114 & s197 & ~s199 & ~s8[1] & ~s254 & ~s83) | (s114 & s197 & ~s199 & (s8[1:0] == 2'b10) & s254);
assign s255 = s259 & wb_us_ready & s1 & ~s13 & ~s21;
assign s256 = (wb_us_ready & s254 & s1) | s13;
assign s257 = (s254 & ~s256) | s255;
assign s258 = s255 | s256;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s254 <= 1'b0;
    end
    else if (s258) begin
        s254 <= s257;
    end
end

reg s260;
wire s261;
wire s262;
wire s263;
wire s264;
wire s265;
reg s266;
wire s267;
wire s268;
wire s269;
wire s270;
assign s265 = (s260 & ~s266) | (s260 & s266 & vrf_vs1_valid & ~s210);
assign s267 = ~s83 & s14 & ~s260 & ~s25 & wb_us_ready & ~s13 & ~s210;
assign s268 = s13 | (vrf_vs1_valid & vrf_vs1_last & wb_us_ready);
assign s270 = (s266 & ~s268) | s267;
assign s269 = s267 | s268;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s266 <= 1'b0;
    end
    else if (s269) begin
        s266 <= s270;
    end
end

assign s261 = ~s83 & s14 & ~s260 & ~s25 & wb_us_ready & ~s13 & ~s210;
assign s262 = s13 | (s260 & wb_us_ready & vrf_vs1_valid & ~s210) | (s260 & wb_us_ready & ~s266);
assign s264 = (s260 & ~s262) | s261;
assign s263 = s261 | s262;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s260 <= 1'b0;
    end
    else if (s263) begin
        s260 <= s264;
    end
end

assign s229 = vrf_vs2_valid & s200;
assign s230 = vrf_vs1_valid & s196;
assign s231 = (s230 & s115);
assign s232 = s204 & s250;
assign s233 = s204 & s248;
assign s234 = s204 & s249;
assign s215 = s229 & (s192 & s8 != 6'b0) & ~s8[0] & s114 & ~s259;
assign s216 = (s229 & s201 & ~s114 & s231 & s8[0] & ~s259) | (s229 & s259 & s8[0] & s231) | (s229 & s199 & ~s114 & s231);
assign s217 = (s229 & ~s191 & ~s114 & s231) | (~s200 & (veq_ex_vd_len != s8[VRF_LW - 1:0]) & s231);
assign s218 = (s229 & s214 & s230 & ~s115) | (~s200 & (veq_ex_vd_len == s8[VRF_LW - 1:0]) & ~s115 & vrf_vs1_valid);
assign s207 = s218 | s217 | s216 | s215;
assign s219 = (s229 & s114 & s230 & ~s115 & ~s50);
assign s220 = (s229 & ~s114 & s231 & ~s50);
assign s208 = s219 | s220;
assign s222 = (s229 & s198[0] & ~s8[3] & vrf_vd_valid & s116 & ~s83 & ~s50);
assign s223 = (s229 & ~s198[0] & vrf_vd_valid & s116 & ~s83 & ~s50);
assign s221 = (s229 & vrf_vd_valid & ~s116 & s83) | (s229 & vrf_vd_valid & ~s116 & s8[3] & s198[0]);
assign s224 = (vrf_vd_valid & ~s116 & s50);
assign s209 = s222 | s223 | s221 | s224;
assign s225 = (s88 & vrf_vs1_valid & ~s115 & s83);
assign s226 = (s266 & vrf_vs1_valid & ~s115);
assign s227 = s225 | s226;
assign s228 = (s88 & vrf_vs1_valid & s115 & ~s83);
assign s210 = s227 | s228;
assign s211 = (s234 & s14 & ~wb_us_ready) | (s234 & ~s83 & s260 & ~wb_us_ready) | (s234 & ~s83 & s260 & s266 & ~vrf_vs1_valid) | (s234 & ~s83 & ~s260) | (s234 & s83 & ~s14) | (s234 & s21);
assign s212 = (s233 & ~s1) | (s233 & s25);
assign s213 = (s232 & ~s1) | (s232 & s21) | (s232 & ~wb_us_ready);
assign s206 = s211 | s212 | s213;
generate
    if (DLEN == 1024) begin:gen_all_tail_dlen1024
        assign s132 = ({2'b0,s8[4:0],4'b0} > s193[10:0]);
        assign s133 = ({1'b0,s8[4:0],5'b0} > s193[10:0]);
        assign s134 = ({s8[4:0],6'b0} > s193[10:0]);
        assign s135 = ({s8[3:0],7'b0} > s193[10:0]);
    end
    else if (DLEN == 512) begin:gen_all_tail_dlen512
        assign s132 = ({3'b0,s8[4:0],3'b0} > s193[10:0]);
        assign s133 = ({2'b0,s8[4:0],4'b0} > s193[10:0]);
        assign s134 = ({1'b0,s8[4:0],5'b0} > s193[10:0]);
        assign s135 = ({s8[4:0],6'b0} > s193[10:0]);
    end
    else if (DLEN == 256) begin:gen_all_tail_dlen256
        assign s132 = ({4'b0,s8[4:0],2'b0} > s193[10:0]);
        assign s133 = ({3'b0,s8[4:0],3'b0} > s193[10:0]);
        assign s134 = ({2'b0,s8[4:0],4'b0} > s193[10:0]);
        assign s135 = ({1'b0,s8[4:0],5'b0} > s193[10:0]);
    end
    else if (DLEN == 128) begin:gen_all_tail_dlen128
        assign s132 = ({5'b0,s8[4:0],1'b0} > s193[10:0]);
        assign s133 = ({4'b0,s8[4:0],2'b0} > s193[10:0]);
        assign s134 = ({3'b0,s8[4:0],3'b0} > s193[10:0]);
        assign s135 = ({2'b0,s8[4:0],4'b0} > s193[10:0]);
    end
endgenerate
generate
    if (DLEN == 1024) begin:gen_part_tail_dlen1024
        assign s136 = ({2'b0,s8[4:0]} == s193[10:4]);
        assign s137 = ({1'b0,s8[4:0]} == s193[10:5]);
        assign s138 = (s8[4:0] == s193[10:6]);
        assign s139 = (s8[3:0] == s193[10:7]);
    end
    else if (DLEN == 512) begin:gen_part_tail_dlen512
        assign s136 = ({3'b0,s8[4:0]} == s193[10:3]);
        assign s137 = ({2'b0,s8[4:0]} == s193[10:4]);
        assign s138 = ({1'b0,s8[4:0]} == s193[10:5]);
        assign s139 = (s8[4:0] == s193[10:6]);
    end
    else if (DLEN == 256) begin:gen_part_tail_dlen256
        assign s136 = ({4'b0,s8[4:0]} == s193[10:2]);
        assign s137 = ({3'b0,s8[4:0]} == s193[10:3]);
        assign s138 = ({2'b0,s8[4:0]} == s193[10:4]);
        assign s139 = ({1'b0,s8[4:0]} == s193[10:5]);
    end
    else if (DLEN == 128) begin:gen_part_tail_dlen128
        assign s136 = ({5'b0,s8[4:0]} == s193[10:1]);
        assign s137 = ({4'b0,s8[4:0]} == s193[10:2]);
        assign s138 = ({3'b0,s8[4:0]} == s193[10:3]);
        assign s139 = ({2'b0,s8[4:0]} == s193[10:4]);
    end
endgenerate
wire s271 = ~(|s193[10:VL_MSB + 1]);
wire s272 = ~(|s193[10:VL_MSB + 2]);
assign s140 = (s8[1 +:MAX_DNUM] > s193[(MASK_CAL_LSB + 1) +:MAX_DNUM]) & s271;
assign s141 = (s8[1 +:MAX_DNUM] > s193[(MASK_CAL_LSB + 2) +:MAX_DNUM]) & s272;
assign s143 = (s8[1 +:MAX_DNUM] == s193[(MASK_CAL_LSB + 1) +:MAX_DNUM]) & s271;
assign s144 = (s8[1 +:MAX_DNUM] == s193[(MASK_CAL_LSB + 2) +:MAX_DNUM]) & s272;
generate
    if (VLEN == 1024) begin:gen_tail_ctrl_vlen1024
        assign s142 = (s8[1 +:MAX_DNUM] > s193[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & ~s193[VL_MSB + 3];
        assign s145 = (s8[1 +:MAX_DNUM] == s193[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & ~s193[VL_MSB + 3];
    end
    else begin:gen_tail_ctrl_vlen_le_512
        assign s142 = (s8[1 +:MAX_DNUM] > s193[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & (~(|s193[10:VL_MSB + 3]));
        assign s145 = (s8[1 +:MAX_DNUM] == s193[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & (~(|s193[10:VL_MSB + 3]));
    end
endgenerate
assign s152 = s137 ? (~({DLEN / 32{1'b1}} << s193[MASK_CAL_LSB:0])) : {DLEN / 32{~s133}};
assign s153 = s138 ? (~({DLEN / 16{1'b1}} << s193[MASK_CAL_LSB + 1:0])) : {DLEN / 16{~s134}};
assign s154 = s139 ? (~({DLEN / 8{1'b1}} << s193[MASK_CAL_LSB + 2:0])) : {DLEN / 8{~s135}};
assign s155 = s143 ? (~({DLEN / 32{1'b1}} << s193[MASK_CAL_LSB:0])) : {DLEN / 32{~s140}};
assign s156 = s144 ? (~({DLEN / 16{1'b1}} << s193[MASK_CAL_LSB + 1:0])) : {DLEN / 16{~s141}};
assign s157 = s145 ? (~({DLEN / 8{1'b1}} << s193[MASK_CAL_LSB + 2:0])) : {DLEN / 8{~s142}};
generate
    if (DLEN == 1024) begin:gen_all_ps_dlen1024
        assign s118 = ({2'b0,s8[4:0],4'b0} < {1'b0,s194[9:0]});
        assign s119 = ({1'b0,s8[4:0],5'b0} < {1'b0,s194[9:0]});
        assign s120 = ({s8[4:0],6'b0} < {1'b0,s194[9:0]});
        assign s121 = ({s8[3:0],7'b0} < {1'b0,s194[9:0]});
    end
    else if (DLEN == 512) begin:gen_all_ps_dlen512
        assign s118 = ({3'b0,s8[4:0],3'b0} < {1'b0,s194[9:0]});
        assign s119 = ({2'b0,s8[4:0],4'b0} < {1'b0,s194[9:0]});
        assign s120 = ({1'b0,s8[4:0],5'b0} < {1'b0,s194[9:0]});
        assign s121 = ({s8[4:0],6'b0} < {1'b0,s194[9:0]});
    end
    else if (DLEN == 256) begin:gen_all_ps_dlen256
        assign s118 = ({4'b0,s8[4:0],2'b0} < {1'b0,s194[9:0]});
        assign s119 = ({3'b0,s8[4:0],3'b0} < {1'b0,s194[9:0]});
        assign s120 = ({2'b0,s8[4:0],4'b0} < {1'b0,s194[9:0]});
        assign s121 = ({1'b0,s8[4:0],5'b0} < {1'b0,s194[9:0]});
    end
    else if (DLEN == 128) begin:gen_all_ps_dlen128
        assign s118 = ({5'b0,s8[4:0],1'b0} < {1'b0,s194[9:0]});
        assign s119 = ({4'b0,s8[4:0],2'b0} < {1'b0,s194[9:0]});
        assign s120 = ({3'b0,s8[4:0],3'b0} < {1'b0,s194[9:0]});
        assign s121 = ({2'b0,s8[4:0],4'b0} < {1'b0,s194[9:0]});
    end
endgenerate
generate
    if (DLEN == 1024) begin:gen_part_ps_dlen1024
        assign s122 = ({2'b0,s8[4:0]} == {1'b0,s194[9:4]});
        assign s123 = ({1'b0,s8[4:0]} == {1'b0,s194[9:5]});
        assign s124 = (s8[4:0] == {1'b0,s194[9:6]});
        assign s125 = (s8[3:0] == {1'b0,s194[9:7]});
    end
    else if (DLEN == 512) begin:gen_part_ps_dlen512
        assign s122 = ({3'b0,s8[4:0]} == {1'b0,s194[9:3]});
        assign s123 = ({2'b0,s8[4:0]} == {1'b0,s194[9:4]});
        assign s124 = ({1'b0,s8[4:0]} == {1'b0,s194[9:5]});
        assign s125 = (s8[4:0] == {1'b0,s194[9:6]});
    end
    else if (DLEN == 256) begin:gen_part_ps_dlen256
        assign s122 = ({4'b0,s8[4:0]} == {1'b0,s194[9:2]});
        assign s123 = ({3'b0,s8[4:0]} == {1'b0,s194[9:3]});
        assign s124 = ({2'b0,s8[4:0]} == {1'b0,s194[9:4]});
        assign s125 = ({1'b0,s8[4:0]} == {1'b0,s194[9:5]});
    end
    else if (DLEN == 128) begin:gen_part_ps_dlen128
        assign s122 = ({5'b0,s8[4:0]} == {1'b0,s194[9:1]});
        assign s123 = ({4'b0,s8[4:0]} == {1'b0,s194[9:2]});
        assign s124 = ({3'b0,s8[4:0]} == {1'b0,s194[9:3]});
        assign s125 = ({2'b0,s8[4:0]} == {1'b0,s194[9:4]});
    end
endgenerate
generate
    if (VLEN == 1024) begin:gen_ps_ctrl_vlen1024
        assign s148 = (s8[1 +:MAX_DNUM] < s194[(MASK_CAL_LSB + 3) +:MAX_DNUM]);
        assign s151 = (s8[1 +:MAX_DNUM] == s194[(MASK_CAL_LSB + 3) +:MAX_DNUM]);
        assign s147 = (s8[1 +:MAX_DNUM] < s194[(MASK_CAL_LSB + 2) +:MAX_DNUM]) | s194[VL_MSB + 2];
        assign s150 = (s8[1 +:MAX_DNUM] == s194[(MASK_CAL_LSB + 2) +:MAX_DNUM]) & ~s194[VL_MSB + 2];
    end
    else if (VLEN == 512) begin:gen_ps_ctrl_vlen512
        assign s148 = (s8[1 +:MAX_DNUM] < s194[(MASK_CAL_LSB + 3) +:MAX_DNUM]) | s194[VL_MSB + 3];
        assign s151 = (s8[1 +:MAX_DNUM] == s194[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & ~s194[VL_MSB + 3];
        assign s147 = (s8[1 +:MAX_DNUM] < s194[(MASK_CAL_LSB + 2) +:MAX_DNUM]) | (|s194[9:VL_MSB + 2]);
        assign s150 = (s8[1 +:MAX_DNUM] == s194[(MASK_CAL_LSB + 2) +:MAX_DNUM]) & (~|s194[9:VL_MSB + 2]);
    end
    else begin:gen_ps_ctrl_vlen_le_256
        assign s148 = (s8[1 +:MAX_DNUM] < s194[(MASK_CAL_LSB + 3) +:MAX_DNUM]) | (|s194[9:VL_MSB + 3]);
        assign s151 = (s8[1 +:MAX_DNUM] == s194[(MASK_CAL_LSB + 3) +:MAX_DNUM]) & (~|s194[9:VL_MSB + 3]);
        assign s147 = (s8[1 +:MAX_DNUM] < s194[(MASK_CAL_LSB + 2) +:MAX_DNUM]) | (|s194[9:VL_MSB + 2]);
        assign s150 = (s8[1 +:MAX_DNUM] == s194[(MASK_CAL_LSB + 2) +:MAX_DNUM]) & (~|s194[9:VL_MSB + 2]);
    end
endgenerate
assign s146 = (s8[1 +:MAX_DNUM] < s194[(MASK_CAL_LSB + 1) +:MAX_DNUM]) | (|s194[9:VL_MSB + 1]);
assign s149 = (s8[1 +:MAX_DNUM] == s194[(MASK_CAL_LSB + 1) +:MAX_DNUM]) & (~|s194[9:VL_MSB + 1]);
assign s126 = ({DLEN / 32{s123}} << s194[MASK_CAL_LSB:0]) | {DLEN / 32{~s119 & ~s123}};
assign s127 = ({DLEN / 16{s124}} << s194[MASK_CAL_LSB + 1:0]) | {DLEN / 16{~s120 & ~s124}};
assign s128 = ({DLEN / 8{s125}} << s194[MASK_CAL_LSB + 2:0]) | {DLEN / 8{~s121 & ~s125}};
assign s129 = ({DLEN / 32{s149}} << s194[MASK_CAL_LSB:0]) | {DLEN / 32{~s146 & ~s149}};
assign s130 = ({DLEN / 16{s150}} << s194[MASK_CAL_LSB + 1:0]) | {DLEN / 16{~s147 & ~s150}};
assign s131 = ({DLEN / 8{s151}} << s194[MASK_CAL_LSB + 2:0]) | {DLEN / 8{~s148 & ~s151}};
generate
    if (DLEN > 128) begin:gen_ex_ps_tail_mask_dlen_gt128
        wire [DBLEN / 8 - 1:0] s273;
        reg [DBLEN - 1:0] s274;
        reg [DBLEN - 1:0] s275;
        reg [DBLEN - 1:0] s276;
        reg [DBLEN - 1:0] s277;
        wire [DBLEN / 8 - 1:0] s278;
        reg [DBLEN - 1:0] s279;
        reg [DBLEN - 1:0] s280;
        reg [DBLEN - 1:0] s281;
        reg [DBLEN - 1:0] s282;
        assign s273 = ({DLEN / 64{s122}} << s194[MASK_CAL_LSB - 1:0]) | {DLEN / 64{~s118 & ~s122}};
        assign s278 = s136 ? (~({DLEN / 64{1'b1}} << s193[MASK_CAL_LSB - 1:0])) : {DLEN / 64{~s132}};
        integer s117;
        always @* begin
            for (s117 = 0; s117 < DLEN / 64; s117 = s117 + 1) begin
                s274[s117 * 8 +:8] = {8{s273[s117]}};
                s279[s117 * 8 +:8] = {8{s278[s117]}};
            end
            for (s117 = 0; s117 < DLEN / 32; s117 = s117 + 1) begin
                s275[s117 * 4 +:4] = {4{s126[s117]}};
                s280[s117 * 4 +:4] = {4{s152[s117]}};
            end
            for (s117 = 0; s117 < DLEN / 16; s117 = s117 + 1) begin
                s276[s117 * 2 +:2] = {2{s127[s117]}};
                s281[s117 * 2 +:2] = {2{s153[s117]}};
            end
            for (s117 = 0; s117 < DLEN / 8; s117 = s117 + 1) begin
                s277[s117] = s128[s117];
                s282[s117] = s154[s117];
            end
        end

        assign s109 = (s274 & {DBLEN{s202[3]}}) | (s275 & {DBLEN{s202[2]}}) | (s276 & {DBLEN{s202[1]}}) | (s277 & {DBLEN{s202[0]}});
        assign s108 = (s279 & {DBLEN{s202[3]}}) | (s280 & {DBLEN{s202[2]}}) | (s281 & {DBLEN{s202[1]}}) | (s282 & {DBLEN{s202[0]}});
        assign s111 = (s274 & {DBLEN{s190[2]}}) | (s275 & {DBLEN{s190[1]}}) | (s276 & {DBLEN{s190[0]}});
        assign s110 = (s279 & {DBLEN{s190[2]}}) | (s280 & {DBLEN{s190[1]}}) | (s281 & {DBLEN{s190[0]}});
    end
    else if (DLEN == 128) begin:gen_ex_ps_byte_mask_dlen128
        wire [DBLEN / 8 - 1:0] s273;
        reg [DBLEN - 1:0] s274;
        reg [DBLEN - 1:0] s275;
        reg [DBLEN - 1:0] s276;
        reg [DBLEN - 1:0] s277;
        wire [DBLEN / 8 - 1:0] s278;
        reg [DBLEN - 1:0] s279;
        reg [DBLEN - 1:0] s280;
        reg [DBLEN - 1:0] s281;
        reg [DBLEN - 1:0] s282;
        integer s117;
        assign s273 = ({DLEN / 64{s122}} << s194[0]) | {DLEN / 64{~s118 & ~s122}};
        assign s278 = s136 ? (~({DLEN / 64{1'b1}} << s193[0])) : {DLEN / 64{~s132}};
        always @* begin
            for (s117 = 0; s117 < DLEN / 64; s117 = s117 + 1) begin
                s274[s117 * 8 +:8] = {8{s273[s117]}};
                s279[s117 * 8 +:8] = {8{s278[s117]}};
            end
            for (s117 = 0; s117 < DLEN / 32; s117 = s117 + 1) begin
                s275[s117 * 4 +:4] = {4{s126[s117]}};
                s280[s117 * 4 +:4] = {4{s152[s117]}};
            end
            for (s117 = 0; s117 < DLEN / 16; s117 = s117 + 1) begin
                s276[s117 * 2 +:2] = {2{s127[s117]}};
                s281[s117 * 2 +:2] = {2{s153[s117]}};
            end
            for (s117 = 0; s117 < DLEN / 8; s117 = s117 + 1) begin
                s277[s117] = s128[s117];
                s282[s117] = s154[s117];
            end
        end

        assign s109 = (s274 & {DBLEN{s202[3]}}) | (s275 & {DBLEN{s202[2]}}) | (s276 & {DBLEN{s202[1]}}) | (s277 & {DBLEN{s202[0]}});
        assign s108 = (s279 & {DBLEN{s202[3]}}) | (s280 & {DBLEN{s202[2]}}) | (s281 & {DBLEN{s202[1]}}) | (s282 & {DBLEN{s202[0]}});
        assign s111 = (s274 & {DBLEN{s190[2]}}) | (s275 & {DBLEN{s190[1]}}) | (s276 & {DBLEN{s190[0]}});
        assign s110 = (s279 & {DBLEN{s190[2]}}) | (s280 & {DBLEN{s190[1]}}) | (s281 & {DBLEN{s190[0]}});
    end
    else begin:gen_ex_ps_byte_mask_dlen64
        wire s273;
        reg [DBLEN - 1:0] s274;
        reg [DBLEN - 1:0] s275;
        reg [DBLEN - 1:0] s276;
        reg [DBLEN - 1:0] s277;
        wire s278;
        reg [DBLEN - 1:0] s279;
        reg [DBLEN - 1:0] s280;
        reg [DBLEN - 1:0] s281;
        reg [DBLEN - 1:0] s282;
        integer s117;
        assign s273 = ~s118;
        assign s278 = ~s132;
        always @* begin
            s274[7:0] = {8{s273}};
            s279[7:0] = {8{s278}};
            for (s117 = 0; s117 < DLEN / 32; s117 = s117 + 1) begin
                s275[s117 * 4 +:4] = {4{s126[s117 / 4]}};
                s280[s117 * 4 +:4] = {4{s152[s117 / 4]}};
            end
            for (s117 = 0; s117 < DLEN / 16; s117 = s117 + 1) begin
                s276[s117 * 2 +:2] = {2{s127[s117 / 2]}};
                s281[s117 * 2 +:2] = {2{s153[s117 / 2]}};
            end
            for (s117 = 0; s117 < DLEN / 8; s117 = s117 + 1) begin
                s277[s117] = s128[s117];
                s282[s117] = s154[s117];
            end
        end

        assign s109 = (s274 & {DBLEN{s202[3]}}) | (s275 & {DBLEN{s202[2]}}) | (s276 & {DBLEN{s202[1]}}) | (s277 & {DBLEN{s202[0]}});
        assign s108 = (s279 & {DBLEN{s202[3]}}) | (s280 & {DBLEN{s202[2]}}) | (s281 & {DBLEN{s202[1]}}) | (s282 & {DBLEN{s202[0]}});
        assign s111 = (s274 & {DBLEN{s190[2]}}) | (s275 & {DBLEN{s190[1]}}) | (s276 & {DBLEN{s190[0]}});
        assign s110 = (s279 & {DBLEN{s190[2]}}) | (s280 & {DBLEN{s190[1]}}) | (s281 & {DBLEN{s190[0]}});
    end
endgenerate
reg [DBLEN - 1:0] s283;
reg [DBLEN - 1:0] s284;
reg [DBLEN - 1:0] s285;
reg [DBLEN - 1:0] s286;
reg [DBLEN - 1:0] s287;
reg [DBLEN - 1:0] s288;
always @* begin
    for (s117 = 0; s117 < DLEN / 32; s117 = s117 + 1) begin
        s283[s117 * 4 +:4] = {4{s129[s117]}};
        s286[s117 * 4 +:4] = {4{s155[s117]}};
    end
    for (s117 = 0; s117 < DLEN / 16; s117 = s117 + 1) begin
        s284[s117 * 2 +:2] = {2{s130[s117]}};
        s287[s117 * 2 +:2] = {2{s156[s117]}};
    end
    for (s117 = 0; s117 < DLEN / 8; s117 = s117 + 1) begin
        s285[s117] = s131[s117];
        s288[s117] = s157[s117];
    end
end

assign s113 = (s283 & {DBLEN{s190[2]}}) | (s284 & {DBLEN{s190[1]}}) | (s285 & {DBLEN{s190[0]}});
assign s112 = (s286 & {DBLEN{s190[2]}}) | (s287 & {DBLEN{s190[1]}}) | (s288 & {DBLEN{s190[0]}});
wire [DBLEN - 1:0] s289 = s108;
wire [DBLEN - 1:0] s290 = s109;
wire [7:0] s291;
wire [7:0] s292;
wire [7:0] s293;
wire [7:0] s294;
wire [7:0] s295;
wire [DBLEN - 1:0] s296;
wire [DBLEN - 1:0] s297;
wire [63:0] s298;
wire [63:0] s299;
wire [7:0] s300;
wire [7:0] s301;
wire [7:0] s302;
wire [DBLEN - 1:0] s303 = s110;
wire [DBLEN - 1:0] s304 = s111;
assign s298 = veq_ex_e_mask0 | {64{s203 | s251}};
assign s299 = veq_ex_e_mask1 | {64{s203 | s251}};
wire [DBLEN - 1:0] s305;
reg [DBLEN - 1:0] s306;
reg [DBLEN - 1:0] s307;
reg [DBLEN - 1:0] s308;
wire [DBLEN - 1:0] s309;
reg [DBLEN - 1:0] s310;
reg [DBLEN - 1:0] s311;
reg [DBLEN - 1:0] s312;
assign s305 = s290;
assign s309 = s289;
always @* begin
    for (s117 = 0; s117 < DBLEN / 2; s117 = s117 + 1) begin
        s306[s117] = s290[s117 * 2 + 1];
        s310[s117] = s289[s117 * 2 + 1];
    end
    s306[DBLEN - 1:DBLEN / 2] = {DBLEN / 2{1'b0}};
    s310[DBLEN - 1:DBLEN / 2] = {DBLEN / 2{1'b0}};
end

always @* begin
    for (s117 = 0; s117 < DBLEN / 4; s117 = s117 + 1) begin
        s307[s117] = s290[s117 * 4 + 3];
        s311[s117] = s289[s117 * 4 + 3];
    end
    s307[DBLEN - 1:DBLEN * 1 / 4] = {DBLEN * 3 / 4{1'b0}};
    s311[DBLEN - 1:DBLEN * 1 / 4] = {DBLEN * 3 / 4{1'b0}};
end

always @* begin
    for (s117 = 0; s117 < DBLEN / 8; s117 = s117 + 1) begin
        s308[s117] = s290[s117 * 8 + 7];
        s312[s117] = s289[s117 * 8 + 7];
    end
    s308[DBLEN - 1:DBLEN * 1 / 8] = {DBLEN * 7 / 8{1'b0}};
    s312[DBLEN - 1:DBLEN * 1 / 8] = {DBLEN * 7 / 8{1'b0}};
end

assign s296 = ({DBLEN{s202[0]}} & s305) | ({DBLEN{s202[1]}} & s306) | ({DBLEN{s202[2]}} & s307) | ({DBLEN{s202[3]}} & s308);
assign s297 = ({DBLEN{s202[0]}} & s309) | ({DBLEN{s202[1]}} & s310) | ({DBLEN{s202[2]}} & s311) | ({DBLEN{s202[3]}} & s312);
assign s293 = veq_ex_byte_mask[7:0] | {8{s253 | s242}};
generate
    if (DLEN == 1024) begin:gen_d1024_lane_mux_sel8
        assign s292 = ({8{s187[0]}} & s289[8 * 0 +:8]) | ({8{s187[1]}} & s289[8 * 1 +:8]) | ({8{s187[2]}} & s289[8 * 2 +:8]) | ({8{s187[3]}} & s289[8 * 3 +:8]) | ({8{s187[4]}} & s289[8 * 4 +:8]) | ({8{s187[5]}} & s289[8 * 5 +:8]) | ({8{s187[6]}} & s289[8 * 6 +:8]) | ({8{s187[7]}} & s289[8 * 7 +:8]) | ({8{s187[8]}} & s289[8 * 8 +:8]) | ({8{s187[9]}} & s289[8 * 9 +:8]) | ({8{s187[10]}} & s289[8 * 10 +:8]) | ({8{s187[11]}} & s289[8 * 11 +:8]) | ({8{s187[12]}} & s289[8 * 12 +:8]) | ({8{s187[13]}} & s289[8 * 13 +:8]) | ({8{s187[14]}} & s289[8 * 14 +:8]) | ({8{s187[15]}} & s289[8 * 15 +:8]);
        assign s291 = ({8{s187[0]}} & s290[8 * 0 +:8]) | ({8{s187[1]}} & s290[8 * 1 +:8]) | ({8{s187[2]}} & s290[8 * 2 +:8]) | ({8{s187[3]}} & s290[8 * 3 +:8]) | ({8{s187[4]}} & s290[8 * 4 +:8]) | ({8{s187[5]}} & s290[8 * 5 +:8]) | ({8{s187[6]}} & s290[8 * 6 +:8]) | ({8{s187[7]}} & s290[8 * 7 +:8]) | ({8{s187[8]}} & s290[8 * 8 +:8]) | ({8{s187[9]}} & s290[8 * 9 +:8]) | ({8{s187[10]}} & s290[8 * 10 +:8]) | ({8{s187[11]}} & s290[8 * 11 +:8]) | ({8{s187[12]}} & s290[8 * 12 +:8]) | ({8{s187[13]}} & s290[8 * 13 +:8]) | ({8{s187[14]}} & s290[8 * 14 +:8]) | ({8{s187[15]}} & s290[8 * 15 +:8]);
        assign s294 = ({8{s187[0]}} & s112[8 * 0 +:8]) | ({8{s187[1]}} & s112[8 * 1 +:8]) | ({8{s187[2]}} & s112[8 * 2 +:8]) | ({8{s187[3]}} & s112[8 * 3 +:8]) | ({8{s187[4]}} & s112[8 * 4 +:8]) | ({8{s187[5]}} & s112[8 * 5 +:8]) | ({8{s187[6]}} & s112[8 * 6 +:8]) | ({8{s187[7]}} & s112[8 * 7 +:8]) | ({8{s187[8]}} & s112[8 * 8 +:8]) | ({8{s187[9]}} & s112[8 * 9 +:8]) | ({8{s187[10]}} & s112[8 * 10 +:8]) | ({8{s187[11]}} & s112[8 * 11 +:8]) | ({8{s187[12]}} & s112[8 * 12 +:8]) | ({8{s187[13]}} & s112[8 * 13 +:8]) | ({8{s187[14]}} & s112[8 * 14 +:8]) | ({8{s187[15]}} & s112[8 * 15 +:8]);
        assign s295 = ({8{s187[0]}} & s113[8 * 0 +:8]) | ({8{s187[1]}} & s113[8 * 1 +:8]) | ({8{s187[2]}} & s113[8 * 2 +:8]) | ({8{s187[3]}} & s113[8 * 3 +:8]) | ({8{s187[4]}} & s113[8 * 4 +:8]) | ({8{s187[5]}} & s113[8 * 5 +:8]) | ({8{s187[6]}} & s113[8 * 6 +:8]) | ({8{s187[7]}} & s113[8 * 7 +:8]) | ({8{s187[8]}} & s113[8 * 8 +:8]) | ({8{s187[9]}} & s113[8 * 9 +:8]) | ({8{s187[10]}} & s113[8 * 10 +:8]) | ({8{s187[11]}} & s113[8 * 11 +:8]) | ({8{s187[12]}} & s113[8 * 12 +:8]) | ({8{s187[13]}} & s113[8 * 13 +:8]) | ({8{s187[14]}} & s113[8 * 14 +:8]) | ({8{s187[15]}} & s113[8 * 15 +:8]);
        assign s302 = ({8{s187[0]}} & s303[8 * 0 +:8]) | ({8{s187[1]}} & s303[8 * 1 +:8]) | ({8{s187[2]}} & s303[8 * 2 +:8]) | ({8{s187[3]}} & s303[8 * 3 +:8]) | ({8{s187[4]}} & s303[8 * 4 +:8]) | ({8{s187[5]}} & s303[8 * 5 +:8]) | ({8{s187[6]}} & s303[8 * 6 +:8]) | ({8{s187[7]}} & s303[8 * 7 +:8]) | ({8{s187[8]}} & s303[8 * 8 +:8]) | ({8{s187[9]}} & s303[8 * 9 +:8]) | ({8{s187[10]}} & s303[8 * 10 +:8]) | ({8{s187[11]}} & s303[8 * 11 +:8]) | ({8{s187[12]}} & s303[8 * 12 +:8]) | ({8{s187[13]}} & s303[8 * 13 +:8]) | ({8{s187[14]}} & s303[8 * 14 +:8]) | ({8{s187[15]}} & s303[8 * 15 +:8]);
        assign s301 = ({8{s187[0]}} & s304[8 * 0 +:8]) | ({8{s187[1]}} & s304[8 * 1 +:8]) | ({8{s187[2]}} & s304[8 * 2 +:8]) | ({8{s187[3]}} & s304[8 * 3 +:8]) | ({8{s187[4]}} & s304[8 * 4 +:8]) | ({8{s187[5]}} & s304[8 * 5 +:8]) | ({8{s187[6]}} & s304[8 * 6 +:8]) | ({8{s187[7]}} & s304[8 * 7 +:8]) | ({8{s187[8]}} & s304[8 * 8 +:8]) | ({8{s187[9]}} & s304[8 * 9 +:8]) | ({8{s187[10]}} & s304[8 * 10 +:8]) | ({8{s187[11]}} & s304[8 * 11 +:8]) | ({8{s187[12]}} & s304[8 * 12 +:8]) | ({8{s187[13]}} & s304[8 * 13 +:8]) | ({8{s187[14]}} & s304[8 * 14 +:8]) | ({8{s187[15]}} & s304[8 * 15 +:8]);
        assign s73 = ({8{s187[0]}} & s78[8 * 0 +:8]) | ({8{s187[1]}} & s78[8 * 1 +:8]) | ({8{s187[2]}} & s78[8 * 2 +:8]) | ({8{s187[3]}} & s78[8 * 3 +:8]) | ({8{s187[4]}} & s78[8 * 4 +:8]) | ({8{s187[5]}} & s78[8 * 5 +:8]) | ({8{s187[6]}} & s78[8 * 6 +:8]) | ({8{s187[7]}} & s78[8 * 7 +:8]) | ({8{s187[8]}} & s78[8 * 8 +:8]) | ({8{s187[9]}} & s78[8 * 9 +:8]) | ({8{s187[10]}} & s78[8 * 10 +:8]) | ({8{s187[11]}} & s78[8 * 11 +:8]) | ({8{s187[12]}} & s78[8 * 12 +:8]) | ({8{s187[13]}} & s78[8 * 13 +:8]) | ({8{s187[14]}} & s78[8 * 14 +:8]) | ({8{s187[15]}} & s78[8 * 15 +:8]);
    end
    else if (DLEN == 512) begin:gen_d512_lane_mux_sel8
        assign s292 = ({8{s187[0]}} & s289[8 * 0 +:8]) | ({8{s187[1]}} & s289[8 * 1 +:8]) | ({8{s187[2]}} & s289[8 * 2 +:8]) | ({8{s187[3]}} & s289[8 * 3 +:8]) | ({8{s187[4]}} & s289[8 * 4 +:8]) | ({8{s187[5]}} & s289[8 * 5 +:8]) | ({8{s187[6]}} & s289[8 * 6 +:8]) | ({8{s187[7]}} & s289[8 * 7 +:8]);
        assign s291 = ({8{s187[0]}} & s290[8 * 0 +:8]) | ({8{s187[1]}} & s290[8 * 1 +:8]) | ({8{s187[2]}} & s290[8 * 2 +:8]) | ({8{s187[3]}} & s290[8 * 3 +:8]) | ({8{s187[4]}} & s290[8 * 4 +:8]) | ({8{s187[5]}} & s290[8 * 5 +:8]) | ({8{s187[6]}} & s290[8 * 6 +:8]) | ({8{s187[7]}} & s290[8 * 7 +:8]);
        assign s294 = ({8{s187[0]}} & s112[8 * 0 +:8]) | ({8{s187[1]}} & s112[8 * 1 +:8]) | ({8{s187[2]}} & s112[8 * 2 +:8]) | ({8{s187[3]}} & s112[8 * 3 +:8]) | ({8{s187[4]}} & s112[8 * 4 +:8]) | ({8{s187[5]}} & s112[8 * 5 +:8]) | ({8{s187[6]}} & s112[8 * 6 +:8]) | ({8{s187[7]}} & s112[8 * 7 +:8]);
        assign s295 = ({8{s187[0]}} & s113[8 * 0 +:8]) | ({8{s187[1]}} & s113[8 * 1 +:8]) | ({8{s187[2]}} & s113[8 * 2 +:8]) | ({8{s187[3]}} & s113[8 * 3 +:8]) | ({8{s187[4]}} & s113[8 * 4 +:8]) | ({8{s187[5]}} & s113[8 * 5 +:8]) | ({8{s187[6]}} & s113[8 * 6 +:8]) | ({8{s187[7]}} & s113[8 * 7 +:8]);
        assign s302 = ({8{s187[0]}} & s303[8 * 0 +:8]) | ({8{s187[1]}} & s303[8 * 1 +:8]) | ({8{s187[2]}} & s303[8 * 2 +:8]) | ({8{s187[3]}} & s303[8 * 3 +:8]) | ({8{s187[4]}} & s303[8 * 4 +:8]) | ({8{s187[5]}} & s303[8 * 5 +:8]) | ({8{s187[6]}} & s303[8 * 6 +:8]) | ({8{s187[7]}} & s303[8 * 7 +:8]);
        assign s301 = ({8{s187[0]}} & s304[8 * 0 +:8]) | ({8{s187[1]}} & s304[8 * 1 +:8]) | ({8{s187[2]}} & s304[8 * 2 +:8]) | ({8{s187[3]}} & s304[8 * 3 +:8]) | ({8{s187[4]}} & s304[8 * 4 +:8]) | ({8{s187[5]}} & s304[8 * 5 +:8]) | ({8{s187[6]}} & s304[8 * 6 +:8]) | ({8{s187[7]}} & s304[8 * 7 +:8]);
        assign s73 = ({8{s187[0]}} & s78[8 * 0 +:8]) | ({8{s187[1]}} & s78[8 * 1 +:8]) | ({8{s187[2]}} & s78[8 * 2 +:8]) | ({8{s187[3]}} & s78[8 * 3 +:8]) | ({8{s187[4]}} & s78[8 * 4 +:8]) | ({8{s187[5]}} & s78[8 * 5 +:8]) | ({8{s187[6]}} & s78[8 * 6 +:8]) | ({8{s187[7]}} & s78[8 * 7 +:8]);
    end
    else if (DLEN == 256) begin:gen_d256_lane_mux_sel8
        assign s292 = ({8{s187[0]}} & s289[8 * 0 +:8]) | ({8{s187[1]}} & s289[8 * 1 +:8]) | ({8{s187[2]}} & s289[8 * 2 +:8]) | ({8{s187[3]}} & s289[8 * 3 +:8]);
        assign s291 = ({8{s187[0]}} & s290[8 * 0 +:8]) | ({8{s187[1]}} & s290[8 * 1 +:8]) | ({8{s187[2]}} & s290[8 * 2 +:8]) | ({8{s187[3]}} & s290[8 * 3 +:8]);
        assign s294 = ({8{s187[0]}} & s112[8 * 0 +:8]) | ({8{s187[1]}} & s112[8 * 1 +:8]) | ({8{s187[2]}} & s112[8 * 2 +:8]) | ({8{s187[3]}} & s112[8 * 3 +:8]);
        assign s295 = ({8{s187[0]}} & s113[8 * 0 +:8]) | ({8{s187[1]}} & s113[8 * 1 +:8]) | ({8{s187[2]}} & s113[8 * 2 +:8]) | ({8{s187[3]}} & s113[8 * 3 +:8]);
        assign s302 = ({8{s187[0]}} & s303[8 * 0 +:8]) | ({8{s187[1]}} & s303[8 * 1 +:8]) | ({8{s187[2]}} & s303[8 * 2 +:8]) | ({8{s187[3]}} & s303[8 * 3 +:8]);
        assign s301 = ({8{s187[0]}} & s304[8 * 0 +:8]) | ({8{s187[1]}} & s304[8 * 1 +:8]) | ({8{s187[2]}} & s304[8 * 2 +:8]) | ({8{s187[3]}} & s304[8 * 3 +:8]);
        assign s73 = ({8{s187[0]}} & s78[8 * 0 +:8]) | ({8{s187[1]}} & s78[8 * 1 +:8]) | ({8{s187[2]}} & s78[8 * 2 +:8]) | ({8{s187[3]}} & s78[8 * 3 +:8]);
    end
    else begin:gen_d128_lane_mux_sel8
        assign s292 = ({8{s187[0]}} & s289[8 * 0 +:8]) | ({8{s187[1]}} & s289[8 * 1 +:8]);
        assign s291 = ({8{s187[0]}} & s290[8 * 0 +:8]) | ({8{s187[1]}} & s290[8 * 1 +:8]);
        assign s294 = ({8{s187[0]}} & s112[8 * 0 +:8]) | ({8{s187[1]}} & s112[8 * 1 +:8]);
        assign s295 = ({8{s187[0]}} & s113[8 * 0 +:8]) | ({8{s187[1]}} & s113[8 * 1 +:8]);
        assign s302 = ({8{s187[0]}} & s303[8 * 0 +:8]) | ({8{s187[1]}} & s303[8 * 1 +:8]);
        assign s301 = ({8{s187[0]}} & s304[8 * 0 +:8]) | ({8{s187[1]}} & s304[8 * 1 +:8]);
        assign s73 = ({8{s187[0]}} & s78[8 * 0 +:8]) | ({8{s187[1]}} & s78[8 * 1 +:8]);
    end
endgenerate
assign s82 = s293 & s292 & s291 | {8{s89 | s99}};
assign valu_mask_byte8 = (veq_ex_byte_mask[7:0] | {8{s253}}) & s292 & s291;
assign valu_ci_byte8 = veq_ex_byte_mask[7:0];
always @* begin
    for (s117 = 0; s117 < 8; s117 = s117 + 1) begin
        s79[s117 * 8 +:8] = {8{s82[s117] | s242}};
        s81[s117 * 8 +:8] = {8{s182[s117]}};
        s80[s117 * 8 +:8] = {8{s183[s117]}};
    end
end

assign veq_ex_nrr_byte_mask_srl = s0 & s192;
assign s300 = veq_ex_nrr_byte_mask[7:0] | {8{s203}};
assign valu_nrr_mask_byte8 = s300 & s302 & s301;
assign valu_vs2_red_non_ext = s99 | s89;
assign s87 = s88 | s99 | (s89 & ~s94);
assign s88 = s234 & ~s99 & ~s89 & ~s260 & vrf_vs1_valid & vrf_vs2_valid;
assign s105 = (s89 & (s8 == 6'd0) & (DLEN == 128)) | (s89 & (s8 == 6'd1) & (DLEN == 256)) | (s89 & (s8 == 6'd2) & (DLEN == 512)) | (s89 & (s8 == 6'd3) & (DLEN == 1024));
assign s90 = s88 & s106 & (DLEN > 64) & s249 & ~s210 & ~s25;
assign s91 = (s105 & s89 & ~s94 & ~s202[3]) | (s105 & s89 & ~s94 & s202[3] & wb_us_ready) | (ex_nxt_cmt & valu_cmt_kill & valu_cmt_valid);
assign s92 = (s89 | s90) & ~s91;
assign s93 = s90 | s91;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s89 <= 1'b0;
    end
    else if (s93) begin
        s89 <= s92;
    end
end

assign s95 = (s88 & s106 & (DLEN > 64) & s249 & ~s25) | (s89 & ~s94 & ~s105);
assign s96 = s94;
assign s97 = (s94 & ~s96) | s95;
assign s98 = s95 | s96;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s94 <= 1'b0;
    end
    else if (s98) begin
        s94 <= s97;
    end
end

assign s104 = (s99 & s202[0] & (s8 == 6'd2)) | (s99 & s202[1] & (s8 == 6'd1)) | (s99 & s202[2] & (s8 == 6'd0));
assign s100 = (s88 & s106 & (DLEN == 64) & ~s202[3]) | (s89 & ~s94 & s105 & ~s202[3]);
assign s101 = (ex_nxt_cmt & valu_cmt_kill & valu_cmt_valid) | (s104 & s99 & wb_us_ready);
assign s102 = (s100 | s99) & ~s101;
assign s103 = s100 | s101;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s99 <= 1'b0;
    end
    else if (s103) begin
        s99 <= s102;
    end
end

wire s313;
wire s314;
wire s315;
assign s313 = (s1 & s14) | (s234 & s265);
assign s314 = (s21 & s49) | (s21 & (s30[3:0] == 4'b0111) & s27[0]) | (s21 & s28);
assign s315 = (s250 & s1 & ~s192) | (s192 & s1 & s8[0]) | (s192 & s1 & s114 & s83);
assign wb_us_valid = (s313 & ~s13) | (s314 & ~s26) | (s315 & ~s13 & ~s21);
assign wb_us_flag_update = (s232 & s1 & wb_us_ready & ~s21 & ~s13) | (s232 & s1 & wb_us_ready & s26 & ~s13);
assign wb_us_flag = vxsat_set;
assign wb_us_flag_clr = s204 & s13 & wb_us_ready;
assign s70 = s249 & ~(s21 & ~s26);
assign s71 = s21 & ~s26;
assign s72 = ~s248 & ~s249 & ~(s21 & ~s26);
assign s67 = s1 & s70 & s14 & wb_us_ready;
assign s68 = s71 & wb_us_ready;
assign s69 = s1 & s72 & wb_us_ready;
assign s58 = ({DLEN{s202[0]}} & {{DLEN - 8{1'b0}},8'hff}) | ({DLEN{s202[1]}} & {{DLEN - 16{1'b0}},16'hffff}) | ({DLEN{s202[2]}} & {{DLEN - 32{1'b0}},32'hffffffff}) | ({DLEN{s202[3]}} & {{DLEN - 64{1'b0}},64'hffffffffffffffff});
assign s59 = ({64{s192 & ~s8[0] & (|lane_id[LANE_NUM / 2 - 1:0])}} & {s80[63:0]}) | ({64{s192 & s8[0] & (|lane_id[LANE_NUM - 1:LANE_NUM / 2])}} & {s81[63:0]}) | ({64{~s192}} & s79);
assign s60 = (({DLEN{s27[0]}} & {DLEN{1'b1}}) << s61) | (({DLEN{s27[1]}} & {DLEN{1'b1}}) << s62) | (({DLEN{s27[2]}} & {DLEN{1'b1}}) << s63) | (({DLEN{s27[3]}} & {DLEN{1'b1}}) << s64) | {DLEN{s31}};
wire [63:0] s316;
wire [63:0] s317;
wire [63:0] s318;
generate
    if (DLEN == 1024) begin:gen_d1024_lane_mux_sel_64
        assign s316 = ({64{s187[0]}} & s58[64 * 0 +:64]) | ({64{s187[1]}} & s58[64 * 1 +:64]) | ({64{s187[2]}} & s58[64 * 2 +:64]) | ({64{s187[3]}} & s58[64 * 3 +:64]) | ({64{s187[4]}} & s58[64 * 4 +:64]) | ({64{s187[5]}} & s58[64 * 5 +:64]) | ({64{s187[6]}} & s58[64 * 6 +:64]) | ({64{s187[7]}} & s58[64 * 7 +:64]) | ({64{s187[8]}} & s58[64 * 8 +:64]) | ({64{s187[9]}} & s58[64 * 9 +:64]) | ({64{s187[10]}} & s58[64 * 10 +:64]) | ({64{s187[11]}} & s58[64 * 11 +:64]) | ({64{s187[12]}} & s58[64 * 12 +:64]) | ({64{s187[13]}} & s58[64 * 13 +:64]) | ({64{s187[14]}} & s58[64 * 14 +:64]) | ({64{s187[15]}} & s58[64 * 15 +:64]);
        assign s317 = ({64{s187[0]}} & s60[64 * 0 +:64]) | ({64{s187[1]}} & s60[64 * 1 +:64]) | ({64{s187[2]}} & s60[64 * 2 +:64]) | ({64{s187[3]}} & s60[64 * 3 +:64]) | ({64{s187[4]}} & s60[64 * 4 +:64]) | ({64{s187[5]}} & s60[64 * 5 +:64]) | ({64{s187[6]}} & s60[64 * 6 +:64]) | ({64{s187[7]}} & s60[64 * 7 +:64]) | ({64{s187[8]}} & s60[64 * 8 +:64]) | ({64{s187[9]}} & s60[64 * 9 +:64]) | ({64{s187[10]}} & s60[64 * 10 +:64]) | ({64{s187[11]}} & s60[64 * 11 +:64]) | ({64{s187[12]}} & s60[64 * 12 +:64]) | ({64{s187[13]}} & s60[64 * 13 +:64]) | ({64{s187[14]}} & s60[64 * 14 +:64]) | ({64{s187[15]}} & s60[64 * 15 +:64]);
        assign s318 = ({64{s187[0]}} & s19[64 * 0 +:64]) | ({64{s187[1]}} & s19[64 * 1 +:64]) | ({64{s187[2]}} & s19[64 * 2 +:64]) | ({64{s187[3]}} & s19[64 * 3 +:64]) | ({64{s187[4]}} & s19[64 * 4 +:64]) | ({64{s187[5]}} & s19[64 * 5 +:64]) | ({64{s187[6]}} & s19[64 * 6 +:64]) | ({64{s187[7]}} & s19[64 * 7 +:64]) | ({64{s187[8]}} & s19[64 * 8 +:64]) | ({64{s187[9]}} & s19[64 * 9 +:64]) | ({64{s187[10]}} & s19[64 * 10 +:64]) | ({64{s187[11]}} & s19[64 * 11 +:64]) | ({64{s187[12]}} & s19[64 * 12 +:64]) | ({64{s187[13]}} & s19[64 * 13 +:64]) | ({64{s187[14]}} & s19[64 * 14 +:64]) | ({64{s187[15]}} & s19[64 * 15 +:64]);
        assign s40 = ({64{s187[0]}} & s38[64 * 0 +:64]) | ({64{s187[1]}} & s38[64 * 1 +:64]) | ({64{s187[2]}} & s38[64 * 2 +:64]) | ({64{s187[3]}} & s38[64 * 3 +:64]) | ({64{s187[4]}} & s38[64 * 4 +:64]) | ({64{s187[5]}} & s38[64 * 5 +:64]) | ({64{s187[6]}} & s38[64 * 6 +:64]) | ({64{s187[7]}} & s38[64 * 7 +:64]) | ({64{s187[8]}} & s38[64 * 8 +:64]) | ({64{s187[9]}} & s38[64 * 9 +:64]) | ({64{s187[10]}} & s38[64 * 10 +:64]) | ({64{s187[11]}} & s38[64 * 11 +:64]) | ({64{s187[12]}} & s38[64 * 12 +:64]) | ({64{s187[13]}} & s38[64 * 13 +:64]) | ({64{s187[14]}} & s38[64 * 14 +:64]) | ({64{s187[15]}} & s38[64 * 15 +:64]);
        assign s41 = ({64{s187[0]}} & s39[64 * 0 +:64]) | ({64{s187[1]}} & s39[64 * 1 +:64]) | ({64{s187[2]}} & s39[64 * 2 +:64]) | ({64{s187[3]}} & s39[64 * 3 +:64]) | ({64{s187[4]}} & s39[64 * 4 +:64]) | ({64{s187[5]}} & s39[64 * 5 +:64]) | ({64{s187[6]}} & s39[64 * 6 +:64]) | ({64{s187[7]}} & s39[64 * 7 +:64]) | ({64{s187[8]}} & s39[64 * 8 +:64]) | ({64{s187[9]}} & s39[64 * 9 +:64]) | ({64{s187[10]}} & s39[64 * 10 +:64]) | ({64{s187[11]}} & s39[64 * 11 +:64]) | ({64{s187[12]}} & s39[64 * 12 +:64]) | ({64{s187[13]}} & s39[64 * 13 +:64]) | ({64{s187[14]}} & s39[64 * 14 +:64]) | ({64{s187[15]}} & s39[64 * 15 +:64]);
    end
    else if (DLEN == 512) begin:gen_d512_lane_mux_sel_64
        assign s316 = ({64{s187[0]}} & s58[64 * 0 +:64]) | ({64{s187[1]}} & s58[64 * 1 +:64]) | ({64{s187[2]}} & s58[64 * 2 +:64]) | ({64{s187[3]}} & s58[64 * 3 +:64]) | ({64{s187[4]}} & s58[64 * 4 +:64]) | ({64{s187[5]}} & s58[64 * 5 +:64]) | ({64{s187[6]}} & s58[64 * 6 +:64]) | ({64{s187[7]}} & s58[64 * 7 +:64]);
        assign s317 = ({64{s187[0]}} & s60[64 * 0 +:64]) | ({64{s187[1]}} & s60[64 * 1 +:64]) | ({64{s187[2]}} & s60[64 * 2 +:64]) | ({64{s187[3]}} & s60[64 * 3 +:64]) | ({64{s187[4]}} & s60[64 * 4 +:64]) | ({64{s187[5]}} & s60[64 * 5 +:64]) | ({64{s187[6]}} & s60[64 * 6 +:64]) | ({64{s187[7]}} & s60[64 * 7 +:64]);
        assign s318 = ({64{s187[0]}} & s19[64 * 0 +:64]) | ({64{s187[1]}} & s19[64 * 1 +:64]) | ({64{s187[2]}} & s19[64 * 2 +:64]) | ({64{s187[3]}} & s19[64 * 3 +:64]) | ({64{s187[4]}} & s19[64 * 4 +:64]) | ({64{s187[5]}} & s19[64 * 5 +:64]) | ({64{s187[6]}} & s19[64 * 6 +:64]) | ({64{s187[7]}} & s19[64 * 7 +:64]);
        assign s40 = ({64{s187[0]}} & s38[64 * 0 +:64]) | ({64{s187[1]}} & s38[64 * 1 +:64]) | ({64{s187[2]}} & s38[64 * 2 +:64]) | ({64{s187[3]}} & s38[64 * 3 +:64]) | ({64{s187[4]}} & s38[64 * 4 +:64]) | ({64{s187[5]}} & s38[64 * 5 +:64]) | ({64{s187[6]}} & s38[64 * 6 +:64]) | ({64{s187[7]}} & s38[64 * 7 +:64]);
        assign s41 = ({64{s187[0]}} & s39[64 * 0 +:64]) | ({64{s187[1]}} & s39[64 * 1 +:64]) | ({64{s187[2]}} & s39[64 * 2 +:64]) | ({64{s187[3]}} & s39[64 * 3 +:64]) | ({64{s187[4]}} & s39[64 * 4 +:64]) | ({64{s187[5]}} & s39[64 * 5 +:64]) | ({64{s187[6]}} & s39[64 * 6 +:64]) | ({64{s187[7]}} & s39[64 * 7 +:64]);
    end
    else if (DLEN == 256) begin:gen_d256_lane_mux_sel_64
        assign s316 = ({64{s187[0]}} & s58[64 * 0 +:64]) | ({64{s187[1]}} & s58[64 * 1 +:64]) | ({64{s187[2]}} & s58[64 * 2 +:64]) | ({64{s187[3]}} & s58[64 * 3 +:64]);
        assign s317 = ({64{s187[0]}} & s60[64 * 0 +:64]) | ({64{s187[1]}} & s60[64 * 1 +:64]) | ({64{s187[2]}} & s60[64 * 2 +:64]) | ({64{s187[3]}} & s60[64 * 3 +:64]);
        assign s318 = ({64{s187[0]}} & s19[64 * 0 +:64]) | ({64{s187[1]}} & s19[64 * 1 +:64]) | ({64{s187[2]}} & s19[64 * 2 +:64]) | ({64{s187[3]}} & s19[64 * 3 +:64]);
        assign s40 = ({64{s187[0]}} & s38[64 * 0 +:64]) | ({64{s187[1]}} & s38[64 * 1 +:64]) | ({64{s187[2]}} & s38[64 * 2 +:64]) | ({64{s187[3]}} & s38[64 * 3 +:64]);
        assign s41 = ({64{s187[0]}} & s39[64 * 0 +:64]) | ({64{s187[1]}} & s39[64 * 1 +:64]) | ({64{s187[2]}} & s39[64 * 2 +:64]) | ({64{s187[3]}} & s39[64 * 3 +:64]);
    end
    else begin:gen_d128_lane_mux_sel_64
        assign s316 = ({64{s187[0]}} & s58[64 * 0 +:64]) | ({64{s187[1]}} & s58[64 * 1 +:64]);
        assign s317 = ({64{s187[0]}} & s60[64 * 0 +:64]) | ({64{s187[1]}} & s60[64 * 1 +:64]);
        assign s318 = ({64{s187[0]}} & s19[64 * 0 +:64]) | ({64{s187[1]}} & s19[64 * 1 +:64]);
        assign s40 = ({64{s187[0]}} & s38[64 * 0 +:64]) | ({64{s187[1]}} & s38[64 * 1 +:64]);
        assign s41 = ({64{s187[0]}} & s39[64 * 0 +:64]) | ({64{s187[1]}} & s39[64 * 1 +:64]);
    end
endgenerate
assign wb_us_bit_wen = ({64{s67}} & s316) | ({64{s69}} & s59) | ({64{s68}} & s317);
always @* begin
    s15[DLEN - 1:DLEN / 8] = {DLEN - DLEN / 8{1'b0}};
    s16[DLEN - 1:DLEN / 16] = {DLEN - DLEN / 16{1'b0}};
    s17[DLEN - 1:DLEN / 32] = {DLEN - DLEN / 32{1'b0}};
    s18[DLEN - 1:DLEN / 64] = {DLEN - DLEN / 64{1'b0}};
    for (s117 = 0; s117 < DLEN / 64; s117 = s117 + 1) begin
        s15[s117 * 8 +:8] = {s186[s117 * 8 +:8]};
        s16[s117 * 4 +:4] = {s186[s117 * 8 + 7],s186[s117 * 8 + 5],s186[s117 * 8 + 3],s186[s117 * 8 + 1]};
        s17[s117 * 2 +:2] = {s186[s117 * 8 + 7],s186[s117 * 8 + 3]};
        s18[s117] = {s186[s117 * 8 + 7]};
    end
end

assign s19 = (({DLEN{s27[0]}} & s15) << s61) | (({DLEN{s27[1]}} & s16) << s62) | (({DLEN{s27[2]}} & s17) << s63) | (({DLEN{s27[3]}} & s18) << s64);
assign s36 = {{DLEN - DBLEN{1'b0}},s32};
assign s37 = {{DLEN - DBLEN{1'b0}},s33};
assign s38 = (({DLEN{s27[0]}} & s36) << s61) | (({DLEN{s27[1]}} & s36) << s62) | (({DLEN{s27[2]}} & s36) << s63) | (({DLEN{s27[3]}} & s36) << s64);
assign s39 = (({DLEN{s27[0]}} & s37) << s61) | (({DLEN{s27[1]}} & s37) << s62) | (({DLEN{s27[2]}} & s37) << s63) | (({DLEN{s27[3]}} & s37) << s64);
wire s319;
wire [63:0] s320;
assign s319 = s30[3] & s27[0] & ~s83;
assign s320 = s319 ? (s40 & s41 & s35) : (s40 & s41 & s34);
assign s65 = (s318 & s320 & ~{64{s31}}) | (s20 & (~s320 | {64{s31}}));
assign s66 = {valu_lane_cross_result_data[95:64],valu_lane_cross_result_data[31:0]};
assign s84 = s70 | (s72 & ~s192);
assign s85 = s72 & s192;
assign wb_us_wdata_src0 = s65;
assign wb_us_src[0] = s71;
assign wb_us_wdata_src1 = s249 ? valu_data64_red : valu_data64;
assign wb_us_src[1] = s84;
assign wb_us_wdata_src2 = s66;
assign wb_us_src[2] = s85;
assign wb_us_wdata_src3 = 64'b0;
assign wb_us_src[3] = 1'b0;
assign wb_us_skip = (s83 & ~s249 & s199 & (veq_ex_vd_len == {VRF_LW{1'b0}}) & s8[0]) | (~s83 & ~s249 & s199 & (veq_ex_vd_len == {{VRF_LW - 1{1'b0}},1'b1}) & s8[1]) | (~s83 & ~s249 & s201 & ~s192 & (veq_ex_vd_len == {{VRF_LW - 1{1'b0}},1'h1}) & s8[1]);
assign wb_us_last = (s71 & s28) | (s70 & s83) | (s70 & s260) | (s72 & s106);
assign wb_us_cmtted = (s71 & (s43 | (s48 & valu_cmt_valid))) | (s70 & (s205 | (ex_nxt_cmt & valu_cmt_valid))) | (s72 & (s205 | (ex_nxt_cmt & valu_cmt_valid)));
assign s74 = {{DLEN / 8 - 1{1'b0}},1'h1};
assign s75 = {{DLEN / 8 - 2{1'b0}},2'h3};
assign s76 = {{DLEN / 8 - 4{1'b0}},4'hf};
assign s77 = {{DLEN / 8 - 8{1'b0}},8'hff};
assign s78 = ({DLEN / 8{s202[0] & ~s260 & (s193 != 11'b0)}} & s74) | ({DLEN / 8{s202[1] & ~s260 & (s193 != 11'b0)}} & s75) | ({DLEN / 8{s202[2] & ~s260 & (s193 != 11'b0)}} & s76) | ({DLEN / 8{s202[3] & ~s260 & (s193 != 11'b0)}} & s77);
assign wb_us_mask_wdata = ({8{s71}} & {8{1'b1}}) | ({8{s70}} & s73) | ({8{s72 & ~s254 & ~s192}} & s82) | ({8{s72 & ~s254 & s192 & ~s8[0]}} & s183) | ({8{s72 & ~s254 & s192 & s8[0]}} & s182);
generate
    if (DLEN == 64) begin:sew64_sll_amt_dlen64
        assign s64 = {2'b0,s30[3:0]};
    end
    else begin:gen_sll_amt_dlen_not_64
        assign s64 = {2'b0,s30[3:0],{DSHFAMT_BIT - 6{1'b0}}};
    end
endgenerate
wire s321;
wire s322;
wire s323;
wire s324;
wire s325;
wire s326;
assign s325 = s196 & ~s195 & s55;
assign s326 = s200 & s56;
assign s321 = veq_ex_flush & s196;
assign s322 = veq_ex_flush & s200;
assign s323 = veq_ex_flush & s248;
assign s324 = valu_cmt_valid & valu_cmt_kill & ex_nxt_cmt;
wire s327;
assign s327 = (s204 & s326 & s114 & ~s259 & ~s249 & ~s248) | (s204 & s326 & s114 & s248 & s83) | (s204 & s326 & s114 & s248 & s57) | (s204 & s50 & vrf_vd_valid & ~s209 & ~s25 & ~s83) | (s204 & s14 & wb_us_ready & ~s210 & s83) | (s204 & s260 & vrf_vs1_valid & wb_us_ready & ~s210);
assign vrf_vs2_rd = (s204 & s326 & ~s114 & ~s249 & ~s50) | (s204 & s326 & s249 & s88 & ~s106) | (s327 & s236) | (s322 & vrf_vs2_valid & s236) | (s204 & s200 & ~vrf_vs2_valid & ~s50 & ~s260) | (s204 & ~s200 & s236 & ~vrf_vs2_valid);
assign vrf_vs2_kill = (s204 & s324 & s200) | (s327 & ~s236) | (s322 & ~s236);
wire s328;
assign s328 = (s204 & s325 & s115 & ~s249 & ~s248) | (s204 & s325 & s115 & s248 & s83) | (s204 & s325 & s115 & s248 & s57) | (s204 & s50 & s196 & vrf_vd_valid & ~s209 & ~s25 & ~s83) | (s204 & s14 & s83 & wb_us_ready & ~s210) | (s204 & s260 & vrf_vs1_valid & wb_us_ready & ~s210);
assign vrf_vs1_rd = (s204 & s325 & ~s115 & ~s249 & ~s50) | (s204 & s14 & wb_us_ready & ~s83) | (s266 & ~vrf_vs1_valid) | (s204 & s196 & ~s195 & ~vrf_vs1_valid & ~s50 & ~s260) | (s321 & vrf_vs1_valid & s235) | (s328 & s235) | (s204 & ~s196 & s235 & ~vrf_vs1_valid);
assign vrf_vs1_kill = (s204 & ex_nxt_cmt & valu_cmt_valid & valu_cmt_kill & s196) | (s328 & ~s235) | (s321 & ~s235);
assign s165 = (s99 & ~s104);
assign s166 = (s0 & s199 & ~s8[0] & ~s249) | (s0 & s199 & ~s8[0] & s88);
assign s163 = s100;
assign s164 = (s94 & (|lane_id[LANE_NUM / 2 - 1:0]));
assign vrf_vs2_wr = s163 | s165 | s164;
assign s167 = ~s8[0] ? {48'b0,valu_data64_red[31:16]} : {56'b0,valu_data64_red[15:8]};
assign s168 = {32'b0,valu_data64_red[63:32]};
assign vrf_vs2_wdata = ({64{s99}} & s167) | ({64{s163}} & s168) | ({64{s164 & (|lane_id[LANE_NUM / 2 - 1:0])}} & valu_lane_cross_result_data[63:0]);
assign vrf_vs2_wide_wr = s166;
assign vrf_vs2_wide_wdata = valu_lane_vs2_wide_bdata;
assign valu_lane_vs2_data = vrf_vs2_rdata;
assign valu_lane_vs1_data = vrf_vs1_rdata;
assign s159 = s0 & s197 & ~s8[0] & ~s195;
assign s160 = (s8 == 6'b0) & s249 & s204 & s88 & ~s260 & ~s210 & ~s25;
assign s161 = (s1 & s88 & (s8 != 6'b0) & ~s210 & ~s21) | (s1 & s99 & ~s14) | (s1 & s89 & ~s94 & ~s14) | s100;
assign vrf_vs1_wr = s160 | s161 | s164;
assign vrf_vs1_wdata = ({64{s160}} & s162) | ({64{s161}} & s158[63:0]) | ({64{s164 & (|lane_id[LANE_NUM / 2 - 1:0])}} & valu_lane_cross_result_data[127:64]);
assign vrf_vs1_wide_wr = s159;
assign vrf_vs1_wide_wdata = valu_lane_vs1_wide_bdata;
assign s158 = (~s79 & vrf_vs1_rdata) | (s79 & valu_data64_red);
assign s170 = 64'b0;
assign s171 = 64'hffff_ffff_ffff_ffff;
assign s172 = 64'b0;
assign s173 = 64'b0;
assign s174 = ({64{s202[0]}} & s175) | ({64{s202[1]}} & s176) | ({64{s202[2]}} & s177) | ({64{s202[3]}} & s178);
assign s175 = {8{8'h80}};
assign s176 = {4{16'h8000}};
assign s177 = {2{32'h80000000}};
assign s178 = 64'h8000000000000000;
assign s179 = ~s174;
assign s180 = 64'b0;
assign s181 = 64'hffffffffffffffff;
assign s169 = ({64{s240}} & s170) | ({64{s243}} & s171) | ({64{s244}} & s172) | ({64{s245}} & s173) | ({64{s246 & s188}} & s174) | ({64{s246 & ~s188}} & s180) | ({64{s247 & s188}} & s179) | ({64{s247 & ~s188}} & s181);
wire [63:0] s329;
wire [63:0] s330;
wire [63:0] s331;
wire [63:0] s332;
wire [63:0] s333;
wire [63:0] s334;
reg [63:0] s335;
reg [63:0] s336;
reg [63:0] s337;
assign s334 = {32'b0,vrf_vs2_wide_rdata};
always @* begin
    for (s117 = 0; s117 < 64 / 16; s117 = s117 + 1) begin
        s335[s117 * 16 +:8] = s334[s117 * 8 +:8];
        s335[s117 * 16 + 8 +:8] = s188 ? {8{s334[s117 * 8 + 7]}} : 8'b0;
    end
end

always @* begin
    for (s117 = 0; s117 < 64 / 32; s117 = s117 + 1) begin
        s336[s117 * 32 +:16] = s334[s117 * 16 +:16];
        s336[s117 * 32 + 16 +:16] = s188 ? {16{s334[s117 * 16 + 15]}} : 16'b0;
    end
end

always @* begin
    for (s117 = 0; s117 < 64 / 64; s117 = s117 + 1) begin
        s337[s117 * 64 +:32] = s334[s117 * 32 +:32];
        s337[s117 * 64 + 32 +:32] = s188 ? {32{s334[s117 * 32 + 31]}} : 32'b0;
    end
end

assign s333 = ({64{s190[0]}} & s335) | ({64{s190[1]}} & s336) | ({64{s190[2]}} & s337);
assign s329 = ({64{s202[0]}} & {s169[63:8],vrf_vs1_rdata[7:0]}) | ({64{s202[1]}} & {s169[63:16],vrf_vs1_rdata[15:0]}) | ({64{s202[2]}} & {s169[63:32],vrf_vs1_rdata[31:0]}) | ({64{s202[3]}} & {vrf_vs1_rdata[63:0]});
assign s330 = ({64{s202[0] & ~s191}} & {vrf_vs2_rdata[63:8],valu_data64_red[7:0]}) | ({64{s202[1] & ~s191}} & {vrf_vs2_rdata[63:16],valu_data64_red[15:0]}) | ({64{s202[2] & ~s191}} & {vrf_vs2_rdata[63:32],valu_data64_red[31:0]}) | ({64{s202[3]}} & {valu_data64_red[63:0]}) | ({64{s202[1] & s191}} & {s335[63:16],valu_data64_red[15:0]}) | ({64{s202[2] & s191}} & {s336[63:32],valu_data64_red[31:0]});
assign s331 = (~s79 & s329) | (s79 & s330);
assign s332 = (~s79 & s169) | (s79 & vrf_vs2_rdata & {64{~s191}}) | (s79 & s333 & {64{s191}});
assign s162 = ({64{s187[0]}} & s331) | ({64{~s187[0]}} & s332);
assign s57 = s198[0] & s8[3];
assign vrf_vd_rd = (s233 & ~vrf_vd_valid) | (s233 & s198[0] & (s8 == 6'h7) & ~s83 & s0) | (s204 & s4 & s83 & s237) | (s204 & s4 & s8[3] & s237) | (s204 & s4 & ~s8[3] & ~s83 & ~s50) | (s50 & ~vrf_vd_valid) | (s50 & vrf_vd_valid & wb_us_ready & s237 & s116) | (s50 & vrf_vd_valid & ~s21 & s237) | (s323 & vrf_vd_valid & s237) | (s204 & ~s248 & s237 & ~vrf_vd_valid);
assign vrf_vd_kill = (s204 & ex_nxt_cmt & valu_cmt_valid & valu_cmt_kill & s248) | (s204 & s4 & s83 & ~s237) | (s204 & s4 & s8[3] & ~s237) | (s50 & vrf_vd_valid & wb_us_ready & ~s237) | (s50 & vrf_vd_valid & ~s21 & ~s237) | (s323 & ~s237);
assign vrf_vd_srl = 1'b0;
assign vrf_vd_wr = 1'b0;
assign vrf_vd_wdata = 64'b0;
assign s51 = s4 & ~s57 & ~s83 & ~s13 & ~s50;
assign s52 = (s50 & vrf_vd_valid & s21 & wb_us_ready) | (s50 & vrf_vd_valid & ~s21) | s13;
assign s53 = (s50 & ~s52) | s51;
assign s54 = s51 | s52;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s50 <= 1'b0;
    end
    else if (s54) begin
        s50 <= s53;
    end
end

assign s48 = exs_nxt_cmt & ~s43 & s21;
assign s46 = (s21 & ~s43 & valu_cmt_valid & ~valu_cmt_kill & exs_nxt_cmt & s25) | (s22 & s23 & ~s205 & ex_nxt_cmt & valu_cmt_valid & ~valu_cmt_kill) | (s22 & s23 & s205);
assign s47 = ~s25;
assign s45 = (s43 & ~s47) | s46;
assign s44 = s46 | s47;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s43 <= 1'b0;
    end
    else if (s44) begin
        s43 <= s45;
    end
end

assign s22 = (s204 & s2 & s248 & ~s13 & ~s206) | (s50 & vrf_vd_valid & ~s13 & ~s206) | (s21 & ~s26 & s25);
assign s23 = (s204 & ~s25 & ~s206) | (s21 & ~s25) | (s26 & s21);
assign s24 = (s204 & s2 & s248 & ~s13 & ~s25 & ~s206) | (s50 & vrf_vd_valid & ~s25);
assign s25 = s21 & ~wb_us_ready;
assign s26 = exs_nxt_cmt & ~s43 & valu_cmt_valid & valu_cmt_kill;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s21 <= 1'b0;
    end
    else if (s23) begin
        s21 <= s22;
    end
end

assign s29 = (s4 & ~s57 & s83) | (s4 & s57) | s50;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s27 <= 4'b0;
        s28 <= 1'b0;
        s42 <= 8'b0;
        s20 <= 64'b0;
        s30 <= 6'b0;
        s31 <= 1'b0;
        s32 <= {DBLEN{1'b0}};
        s33 <= {DBLEN{1'b0}};
        s34 <= 64'b0;
        s35 <= 64'b0;
        s49 <= 1'b0;
    end
    else if (s24) begin
        s27 <= s190;
        s28 <= s29;
        s42 <= s185;
        s20 <= vrf_vd_rdata;
        s30 <= s8;
        s31 <= s50;
        s32 <= s297;
        s33 <= s296;
        s34 <= s298;
        s35 <= s299;
        s49 <= s106;
    end
end

assign s5 = (vrf_vs2_valid & ~s215) | ~s200 | s50;
assign s6 = (vrf_vs1_valid & s196 & ~s195 & s250 & ~s207) | (vrf_vs1_valid & s196 & ~s195 & s248 & ~s208) | (vrf_vs1_valid & s196 & s249 & ~s210) | (s195 & veq_ex_scalar_valid) | (~s195 & ~s196) | s50;
assign s7 = (s248 & vrf_vd_valid & ~s209) | ~s248;
assign s1 = s5 & s6 & s7 & s204;
assign s0 = (s1 & s249 & s87 & ~s25) | (s1 & s250 & ~s21 & wb_us_ready) | (s1 & s248 & ~s25);
assign s86 = (s0 & s8[0]);
assign s56 = (s0 & ~s199) | (s86 & s199);
assign s55 = (s0 & ~s197) | (s197 & s0 & ~s199 & s114 & ~s259) | (s197 & s0 & s8[0]);
assign s2 = (s56 & ~s241) | (s55 & s241);
assign ex_nxt_cmt = (~s21 & s204 & exs_nxt_cmt & ~s205) | (s21 & s43 & ~s205) | (s21 & exs_nxt_cmt & ~s43 & ~s28);
assign s13 = ~s205 & s204 & valu_cmt_valid & valu_cmt_kill & ex_nxt_cmt;
assign s10 = s11 | s12;
assign s11 = s13 | s3 | (s106 & s249 & s88) | (s105 & ~s94 & ~s202[3]) | (s105 & ~s94 & s202[3] & wb_us_ready);
assign s12 = s0 & ~s50 & ~s14 & ~s260;
assign s9 = s11 ? 6'b0 : s8 + 6'b1;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s8 <= 6'b0;
    end
    else if (s10) begin
        s8 <= s9;
    end
end

assign veq_ex_ready = s3 | s13;
assign veq_ex_byte_mask_srl = s192 ? s8[0] & s0 : s0;
assign s14 = (s252 & s106 & s88) | (s89 & ~s94 & s105 & s202[3]) | s104;
assign s114 = vrf_vs2_last;
assign s115 = vrf_vs1_last;
assign s116 = vrf_vd_last;
assign s214 = (s107 & s199 & s200) | (s114 & s200 & ~s199 & ~s259);
assign s107 = (s8[0] & s114);
assign s106 = s214 | (~s200 & (veq_ex_vd_len == s8[VRF_LW - 1:0]));
assign s4 = (s248 & s0 & s114);
assign s3 = (s106 & s250 & ~s206) | (s106 & s248 & ~s51 & ~s206) | (s248 & s50 & ~s206) | (s83 & s14 & s249 & ~s206) | (~s83 & s249 & s260 & ~s266 & wb_us_ready & ~s210) | (~s83 & s249 & s260 & s266 & vrf_vs1_valid & wb_us_ready & ~s210);
assign valu_lane_share_result_data = s192 ? {32'b0,valu_data32} : vrf_vs1_rdata;
assign s184 = s192 & s204 & ~s8[0];
assign s183 = s294 & s295 & s293;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s182 <= 8'b0;
    end
    else if (s184) begin
        s182 <= s183;
    end
end

assign valu_standby_ready = ~veq_ex_valid & ~veq_ex_flush & ~s204 & ~s21 & wb_standby;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

