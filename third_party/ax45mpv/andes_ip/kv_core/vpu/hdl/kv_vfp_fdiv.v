// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfp_fdiv (
    fdiv_standby_ready,
    f4_wdata,
    f4_wdata_en,
    f4_flag_set,
    f4_result_type,
    f4_tag,
    wb_stall,
    f1_op1_data,
    f1_op2_data,
    f1_valid,
    f1_round_mode,
    f1_sew,
    f1_ediv,
    f1_tag,
    f1_vfdiv,
    f1_vfsqrt,
    f1_vfrece7,
    f1_vfrsqrte7,
    f1_fp_mode,
    kill,
    f3_main_pipe_stall,
    req_ready,
    vpu_vfdiv_clk,
    vpu_reset_n
);
parameter FLEN = 32;
localparam DSU_FRA_MSB = (FLEN == 64) ? 161 : (FLEN == 32) ? 132 : 119;
localparam DSU_FRA_LSB = 108;
localparam DSU_FRA_RND = 107;
localparam DSU_SRT_MSB = DSU_FRA_MSB;
localparam DSU_SRT_LSB = 104;
localparam FRACTION_WIDTH = (FLEN == 64) ? 53 : (FLEN == 32) ? 24 : 11;
localparam FRACTION_MSB = (FRACTION_WIDTH - 1);
localparam DS_DIN_WIDTH = (FRACTION_WIDTH + 1);
localparam DS_DIN_MSB = (DS_DIN_WIDTH - 1);
localparam DS_DOUT_WIDTH = (FRACTION_WIDTH + 5);
localparam DS_DOUT_MSB = (DS_DOUT_WIDTH - 1);
localparam ROUND_ZERO = 2'b00;
localparam ROUND_NEG = 2'b01;
localparam ROUND_POS = 2'b10;
localparam ROUND_NEAREST = 2'b11;
localparam ROUND_RNE = 3'b000;
localparam ROUND_RTZ = 3'b001;
localparam ROUND_RDN = 3'b010;
localparam ROUND_RUP = 3'b011;
localparam ROUND_RMM = 3'b100;
localparam HP = 3'b001;
localparam SP = 3'b010;
localparam DP = 3'b011;
output fdiv_standby_ready;
output [63:0] f4_wdata;
output f4_wdata_en;
output [4:0] f4_flag_set;
output [4:0] f4_tag;
output [1:0] f4_result_type;
input wb_stall;
input [63:0] f1_op1_data;
input [63:0] f1_op2_data;
input f1_valid;
input [4:0] f1_tag;
input [2:0] f1_round_mode;
input [2:0] f1_sew;
input [1:0] f1_ediv;
input f1_vfdiv;
input f1_vfsqrt;
input f1_vfrece7;
input f1_vfrsqrte7;
input f1_fp_mode;
input vpu_vfdiv_clk;
input vpu_reset_n;
input kill;
input f3_main_pipe_stall;
output req_ready;





// 279c6ac8 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0;
wire s1;
wire s2;
wire [11:0] s3;
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
wire s24;
wire s25;
wire s26;
wire s27;
wire nds_unused_f1_op1_d_is_subnor;
wire s28;
wire s29;
wire s30;
wire nds_unused_f1_op2_d_is_subnor;
wire s31;
wire s32;
wire [11:0] s33;
wire [11:0] s34;
wire [FRACTION_MSB:0] s35;
wire [FRACTION_MSB:0] s36;
wire s37;
wire s38;
wire s39;
wire s40;
reg s41;
reg s42;
wire s43;
wire [63:0] s44;
wire [4:0] s45;
wire [1:0] s46;
wire s47;
wire s48;
wire s49;
wire s50;
wire [FRACTION_MSB:0] s51;
wire [FRACTION_MSB:0] nds_unused_f2_op2_normal_fraction;
wire [11:0] s52;
wire [11:0] s53;
wire [11:0] s54;
wire [11:0] s55;
wire [12:0] s56;
wire [12:0] s57;
wire [12:0] s58;
wire [12:0] s59;
wire [12:0] s60;
wire [12:0] s61;
wire [52:0] s62;
wire [52:0] s63;
wire [1:0] s64;
wire [53:1] s65;
wire [53:0] s66;
reg [2:0] s67;
reg s68;
reg s69;
reg s70;
reg s71;
reg s72;
reg s73;
reg s74;
reg s75;
reg s76;
reg s77;
reg s78;
reg s79;
reg s80;
reg [4:0] s81;
wire s82;
wire s83;
wire s84 = s77;
wire s85 = s78;
wire s86 = s72;
wire s87 = s73;
wire s88 = s74;
wire s89 = s47;
wire s90 = s48;
wire s91 = s49;
wire s92 = s50;
wire s93 = s79;
wire s94 = s75;
wire [2:0] s95 = s67;
wire [DSU_SRT_MSB:DSU_SRT_LSB] s96;
wire [DS_DOUT_MSB:0] s97;
wire [DS_DOUT_MSB:0] s98;
wire [DS_DOUT_MSB:0] s99;
wire [DS_DOUT_MSB:0] s100;
wire [DS_DOUT_MSB:0] s101;
wire s102;
wire [12:0] s103;
wire [12:0] s104;
wire [12:0] s105;
wire s106;
wire s107;
wire s108;
wire s109;
wire s110;
wire [5:0] s111;
wire [DS_DOUT_MSB:0] s112;
wire [DS_DOUT_MSB:0] s113;
wire [DS_DOUT_MSB:0] s114;
wire [DS_DOUT_MSB:0] s115;
wire [DS_DOUT_MSB:0] s116;
wire [DS_DOUT_MSB:0] s117;
wire [DS_DOUT_MSB:0] s118;
wire s119;
wire s120;
wire s121;
wire s122;
wire s123;
wire s124;
wire s125;
wire s126;
wire s127;
wire s128;
wire s129;
wire s130;
wire s131;
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
wire f3_stall;
reg s150;
reg s151;
reg s152;
reg [4:0] s153;
reg [1:0] s154;
wire s155;
wire s156;
wire [12:0] s157;
wire s158;
wire s159;
wire s160;
wire s161;
wire s162;
wire s163;
wire s164;
wire s165;
wire s166 = s76;
wire [2:0] s167 = s95;
wire s168 = s84;
wire s169 = s85;
wire s170 = s93;
wire s171 = s86;
wire s172 = s87;
wire s173 = s88;
wire s174 = s89;
wire s175 = s90;
wire s176 = s91;
wire s177 = s92;
wire s178;
wire s179;
wire s180;
wire s181;
wire s182;
wire s183;
wire s184;
wire s185;
wire s186;
wire s187;
wire s188;
wire s189;
wire s190;
wire s191;
wire s192;
wire s193;
wire s194;
wire s195;
wire s196;
wire s197;
wire s198;
wire s199;
wire s200;
wire s201;
wire s202;
wire [DSU_SRT_MSB:DSU_SRT_LSB] s203;
wire [DSU_FRA_MSB:DSU_FRA_RND] s204;
wire [DSU_FRA_MSB:DSU_FRA_RND] s205;
wire [DSU_FRA_MSB:108] s206;
wire s207;
wire f4_wdata_en;
wire [63:0] f4_wdata;
wire [63:0] s208;
wire [63:0] s209;
wire s210;
wire s211;
wire s212;
wire s213;
wire [1:0] s214;
wire [1:0] s215;
wire [11:0] s216;
wire [11:0] s217;
wire [11:0] s218;
wire [11:0] s219;
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
wire [11:0] s240;
wire s241;
wire s242;
wire s243;
wire s244;
wire s245;
wire s246;
wire s247;
wire s248;
wire s249;
reg s250;
reg [4:0] f4_tag;
reg s251;
wire [DS_DIN_MSB:0] ds_din0;
wire [DS_DIN_MSB:1] ds_din1;
wire [DS_DOUT_MSB:0] ds_result0;
wire [DS_DOUT_MSB:0] ds_result1;
wire ds_busy;
wire ds_gen_sticky;
wire ds_calc_done;
wire s252;
wire s253;
wire s254;
wire s255;
wire s256;
assign fdiv_standby_ready = ~f1_valid & ~s80 & ~s150 & ~s250;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s81 <= 5'b0;
    end
    else if (s254) begin
        s81 <= f1_tag;
    end
end

always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s153 <= 5'b0;
    end
    else if (s255) begin
        s153 <= s81;
    end
end

always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        f4_tag <= 5'b0;
    end
    else if (s256) begin
        f4_tag <= s153;
    end
end

wire s257 = (FLEN == 64);
wire s258 = (FLEN == 32) | s257;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s251 <= 1'b0;
    end
    else if (f1_valid | s80 | s150 | s250) begin
        s251 <= ds_busy;
    end
end

assign req_ready = (~s80 & ~s150 & ~s250) | (s250 & ~s80 & ~s150 & ~wb_stall);
wire s259 = (s250 & wb_stall) | (s150 & f3_stall) | (s80 & s43 & wb_stall);
wire s260 = (f1_valid & req_ready) | (s80 & ~kill & f3_main_pipe_stall) | (s80 & ~kill & s259);
wire s261 = (f3_stall & ~kill) | (s80 & ~s43 & ~kill & ~f3_main_pipe_stall & ~s259);
wire s262 = (~f3_stall & s150 & ~kill) | (wb_stall & s250 & ~kill);
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s80 <= 1'b0;
        s150 <= 1'b0;
        s250 <= 1'b0;
    end
    else begin
        s80 <= s260;
        s150 <= s261;
        s250 <= s262;
    end
end

assign s253 = ds_gen_sticky | ds_calc_done;
assign s254 = f1_valid & req_ready;
assign s255 = s80 & ~s43 & ~f3_main_pipe_stall;
assign s256 = s150 & ~f3_stall;
reg [DS_DOUT_MSB:0] s263;
reg [DS_DOUT_MSB:0] s264;
wire [DS_DOUT_MSB:0] s265;
wire [DS_DOUT_MSB:0] s266;
wire [DS_DOUT_MSB:0] s267;
assign s267 = {{(DS_DOUT_WIDTH - 9){1'b0}},s158,s156,s155,s160,s161,s162,s163,s164,s165};
assign {s241,s212,s211,s224,s225,s226,s227,s228,s229} = s264[8:0];
assign s265 = {DS_DOUT_WIDTH{s254}} & {5'b0,s35} | {DS_DOUT_WIDTH{s253}} & ds_result0 | {DS_DOUT_WIDTH{s256}} & s96;
assign s266 = {DS_DOUT_WIDTH{s254}} & {5'b0,s36} | {DS_DOUT_WIDTH{s253}} & ds_result1 | {DS_DOUT_WIDTH{s256}} & s267;
assign s51 = s263[FRACTION_MSB:0];
assign nds_unused_f2_op2_normal_fraction = s264[FRACTION_MSB:0];
assign s99 = s263;
assign s100 = s264;
assign s203 = s263;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s263 <= {(DS_DOUT_MSB + 1){1'b0}};
        s264 <= {(DS_DOUT_MSB + 1){1'b0}};
    end
    else if (s254 | s253 | s256) begin
        s263 <= s265;
        s264 <= s266;
    end
end

always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s152 <= 1'b0;
        s151 <= 1'b0;
    end
    else if (ds_gen_sticky) begin
        s152 <= s82;
        s151 <= s83;
    end
end

always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s76 <= 1'b0;
        s72 <= 1'b0;
        s73 <= 1'b0;
        s74 <= 1'b0;
        s68 <= 1'b0;
        s69 <= 1'b0;
        s70 <= 1'b0;
        s71 <= 1'b0;
        s67 <= 3'b0;
        s75 <= 1'b0;
        s78 <= 1'b0;
        s77 <= 1'b0;
        s79 <= 1'b0;
        s41 <= 1'b0;
        s42 <= 1'b0;
    end
    else if (s254) begin
        s76 <= s9;
        s72 <= s14;
        s73 <= s15;
        s74 <= s16;
        s68 <= s10;
        s69 <= s11;
        s70 <= s12;
        s71 <= s13;
        s67 <= f1_round_mode;
        s75 <= s40;
        s78 <= s38;
        s77 <= s37;
        s79 <= s39;
        s41 <= s0;
        s42 <= s1;
    end
end

reg [12:0] s268;
reg [12:0] s269;
wire [12:0] s270;
wire [12:0] s271;
assign s270 = {13{s254}} & {1'b0,s33} | {13{s255}} & s60 | {13{s256}} & s157;
assign s271 = {13{s254 & s2}} & {s4,s3} | {13{s254 & ~s2}} & {1'b0,s34} | {13{s255}} & s61;
assign s52 = s268[11:0];
assign s53 = s269[11:0];
assign s103 = s268;
assign s104 = s269;
assign s216 = s268[11:0];
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s268 <= 13'b0;
        s269 <= 13'b0;
    end
    else if (s254 | s255 | s256) begin
        s268 <= s270;
        s269 <= s271;
    end
end

assign s10 = f1_sew[0] & f1_fp_mode;
assign s11 = f1_sew[0] & ~f1_fp_mode;
assign s12 = f1_sew[1] & s258;
assign s13 = f1_sew[2] & s257;
wire s272 = s9;
wire s273 = s272 ? ((s10 & (FLEN == 64)) ? &f1_op1_data[63:16] : (s10 & (FLEN == 32)) ? &f1_op1_data[31:16] : 1'b0) : 1'b1;
wire s274 = s272 ? ((s10 & (FLEN == 64)) ? &f1_op2_data[63:16] : (s10 & (FLEN == 32)) ? &f1_op2_data[31:16] : 1'b0) : 1'b1;
wire s275 = s272 ? ((s11 & (FLEN == 64)) ? &f1_op1_data[63:16] : (s11 & (FLEN == 32)) ? &f1_op1_data[31:16] : 1'b0) : 1'b1;
wire s276 = s272 ? ((s11 & (FLEN == 64)) ? &f1_op2_data[63:16] : (s11 & (FLEN == 32)) ? &f1_op2_data[31:16] : 1'b0) : 1'b1;
wire s277 = s272 ? ((s12 & (FLEN == 64)) ? &f1_op1_data[63:32] : (s12 & (FLEN == 32)) ? 1'b1 : 1'b0) : 1'b1;
wire s278 = s272 ? ((s12 & (FLEN == 64)) ? &f1_op2_data[63:32] : (s12 & (FLEN == 32)) ? 1'b1 : 1'b0) : 1'b1;
wire s279 = s10 ? s273 : s11 ? s275 : s12 ? s277 : 1'b1;
wire s280 = s10 ? s274 : s11 ? s276 : s12 ? s278 : 1'b1;
wire s281 = (f1_op1_data[14:07] == 8'hff) & (f1_op1_data[6:0] == 7'b0) & s273;
wire nds_unused_f1_op1_b_is_subnor = (f1_op1_data[14:07] == 8'b0) & (f1_op1_data[6:0] != 7'b0) & s273;
wire s282 = (f1_op1_data[14:07] == 8'hff) & f1_op1_data[6] | ~s273;
wire s283 = (f1_op1_data[14:07] == 8'hff) & (f1_op1_data[5:0] != 6'b0) & s273 & ~f1_op1_data[6];
wire s284 = (f1_op2_data[14:07] == 8'hff) & (f1_op2_data[6:0] == 7'b0) & s274;
wire nds_unused_f1_op2_b_is_subnor = (f1_op2_data[14:07] == 8'b0) & (f1_op2_data[6:0] != 7'b0) & s274;
wire s285 = (f1_op2_data[14:07] == 8'hff) & f1_op2_data[6] | ~s274;
wire s286 = (f1_op2_data[14:07] == 8'hff) & (f1_op2_data[5:0] != 6'b0) & s274 & ~f1_op2_data[6];
wire s287 = (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[9:0] == 10'b0) & s275;
wire nds_unused_f1_op1_h_is_subnor = (f1_op1_data[14:10] == 5'b0) & (f1_op1_data[9:0] != 10'b0) & s275;
wire s288 = (f1_op1_data[14:10] == 5'h1f) & f1_op1_data[9] | ~s275;
wire s289 = (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[8:0] != 9'b0) & s275 & ~f1_op1_data[9];
wire s290 = (f1_op2_data[14:10] == 5'h1f) & (f1_op2_data[9:0] == 10'b0) & s276;
wire nds_unused_f1_op2_h_is_subnor = (f1_op2_data[14:10] == 5'b0) & (f1_op2_data[9:0] != 10'b0) & s276;
wire s291 = (f1_op2_data[14:10] == 5'h1f) & f1_op2_data[9] | ~s276;
wire s292 = (f1_op2_data[14:10] == 5'h1f) & (f1_op2_data[8:0] != 9'b0) & s276 & ~f1_op2_data[9];
wire s293 = (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[22:0] == 23'b0) & s277;
wire nds_unused_f1_op1_s_is_subnor = (f1_op1_data[30:23] == 8'b0) & (f1_op1_data[22:0] != 23'b0) & s277;
wire s294 = (f1_op1_data[30:23] == 8'hff) & f1_op1_data[22] | ~s277;
wire s295 = (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[21:0] != 22'b0) & s277 & ~f1_op1_data[22];
wire s296 = (f1_op2_data[30:23] == 8'hff) & (f1_op2_data[22:0] == 23'b0) & s278;
wire nds_unused_f1_op2_s_is_subnor = (f1_op2_data[30:23] == 8'b0) & (f1_op2_data[22:0] != 23'b0) & s278;
wire s297 = (f1_op2_data[30:23] == 8'hff) & f1_op2_data[22] | ~s278;
wire s298 = (f1_op2_data[30:23] == 8'hff) & (f1_op2_data[21:0] != 22'b0) & s278 & ~f1_op2_data[22];
wire s299 = s10 & s281 | s11 & s287 | s12 & s293 | s13 & s27;
wire s300 = s10 & s283 | s11 & s289 | s12 & s295 | s13 & s29;
wire s301 = s10 & s282 | s11 & s288 | s12 & s294 | s13 & s28;
wire s302 = s10 & s284 | s11 & s290 | s12 & s296 | s13 & s30;
wire s303 = s10 & s286 | s11 & s292 | s12 & s298 | s13 & s32;
wire s304 = s10 & s285 | s11 & s291 | s12 & s297 | s13 & s31;
wire s305 = s301 | s300;
wire s306 = s304 | s303;
wire s307 = s25 ^ s26;
assign s15 = (s7 | s5) & ~s20 & ~s306 & s19 & s279 & s280 | (s7 | s5) & ~s305 & s302 & s279 & s280 | (s8 | s6) & s19 & s279 | s0 & s299 & s279 | s1 & s299 & ~s25 & s279 & s280;
assign s14 = (s7 | s5) & ~(s19 | s305) & s20 & s279 & s280 | (s7 | s5) & ~(s302 | s306) & s299 & s279 & s280 | (s8 | s6) & s299 & s279 | (s0 | s1) & s19 & s279;
assign s16 = (s7 | s5) & (s305 | s306) | (s7 | s5) & (s299 & s302) | (s7 | s5) & (s19 & s20) | (s8 | s6 | s1) & (s305 | (s25 & ~s19)) | s0 & s305;
assign s37 = (s7 | s5) & s20 & ~(s19 | s305 | s299) & s280 | (s0 | s1) & s19 & s279;
assign s38 = (s7 | s5) & (s299 & s302) & s279 & s280 | (s7 | s5) & (s19 & s20) & s279 & s280 | (s7 | s5) & ((s300 & s279) | (s303 & s280)) | (s8 | s6 | s1) & (s25 & ~s19 & ~s305) & s279 | (s8 | s6 | s1) & s300 & s279 | s0 & s300 & s279;
assign s17 = (s7 | s5) & s307 | (s8 | s6) & s25;
assign s18 = (s7 | s5) & (s299 | s302) & s307 | (s7 | s5) & s20 & s307;
assign s5 = f1_vfdiv;
assign s6 = f1_vfsqrt;
assign s7 = s5;
assign s8 = s6;
assign s0 = f1_vfrece7;
assign s1 = f1_vfrsqrte7;
assign s9 = 1'b0;
assign s2 = s0 | s1;
assign s43 = s41 | s42;
assign s40 = s7 | s5;
assign s19 = s10 & (~(|f1_op1_data[14:0])) | s11 & (~(|f1_op1_data[14:0])) | s12 & (~(|f1_op1_data[30:0])) | s13 & (~(|f1_op1_data[62:0]));
assign s20 = s10 & (~(|f1_op2_data[14:0])) | s11 & (~(|f1_op2_data[14:0])) | s12 & (~(|f1_op2_data[30:0])) | s13 & (~(|f1_op2_data[62:0]));
assign s21 = s10 & (~(|f1_op1_data[14:07])) | s11 & (~(|f1_op1_data[14:10])) | s12 & (~(|f1_op1_data[30:23])) | s13 & (~(|f1_op1_data[62:52]));
assign s22 = s10 & (~(|f1_op2_data[14:07])) | s11 & (~(|f1_op2_data[14:10])) | s12 & (~(|f1_op2_data[30:23])) | s13 & (~(|f1_op2_data[62:52]));
assign s23 = ~s21;
assign s24 = ~s22;
assign s25 = s10 & f1_op1_data[15] | s11 & f1_op1_data[15] | s12 & f1_op1_data[31] | s13 & f1_op1_data[63];
assign s26 = s10 & f1_op2_data[15] | s11 & f1_op2_data[15] | s12 & f1_op2_data[31] | s13 & f1_op2_data[63];
assign s39 = s2 ? s25 : s15 ? s17 : s14 ? s18 : (s6 | s8) ? 1'b0 : s25 ^ s26;
assign s66 = {54{s10 & (~s7) & s33[0]}} & {2'd1,s62[51:45],45'd0} | {54{s11 & (~s7) & s33[0]}} & {2'd1,s62[51:42],42'd0} | {54{s12 & (~s7) & s33[0]}} & {2'd1,s62[51:29],29'd0} | {54{s13 & (~s7) & s33[0]}} & {2'd1,s62[51:0]} | {54{s10 & (s7 | ~s33[0])}} & {1'd1,s62[51:45],46'd0} | {54{s11 & (s7 | ~s33[0])}} & {1'd1,s62[51:42],43'd0} | {54{s12 & (s7 | ~s33[0])}} & {1'd1,s62[51:29],30'd0} | {54{s13 & (s7 | ~s33[0])}} & {1'd1,s62[51:0],1'd0};
assign s65 = {53{s10}} & {1'd1,s63[51:45],45'd0} | {53{s11}} & {1'd1,s63[51:42],42'd0} | {53{s12}} & {1'b1,s63[51:29],29'd0} | {53{s13}} & {1'b1,s63[51:0]};
wire s308 = s7 & f1_valid & ~f3_main_pipe_stall;
wire s309 = s8 & f1_valid & ~f3_main_pipe_stall;
assign s252 = 1'b0;
assign s64 = s11 ? 2'b10 : s12 ? 2'b01 : s13 ? 2'b00 : 2'b11;
wire s310 = kill;
kv_vfp_fdiv_dsu #(
    .FLEN(FLEN)
) u_kv_vfp_fdiv_dsu (
    .ds_busy(ds_busy),
    .ds_gen_sticky(ds_gen_sticky),
    .ds_calc_done(ds_calc_done),
    .ds_result0(ds_result0),
    .ds_result1(ds_result1),
    .ds_din0(ds_din0),
    .ds_din1(ds_din1[DS_DIN_MSB:1]),
    .div_enable(s308),
    .sqrt_enable(s309),
    .ds_invalidate(s310),
    .ds_type(s64),
    .f3_stall(s252),
    .vpu_vfdiv_clk(vpu_vfdiv_clk),
    .vpu_reset_n(vpu_reset_n)
);
wire [12:0] s311;
wire [12:0] s312;
wire [12:0] s313;
wire [12:0] s314;
wire [12:0] s315;
assign s311 = 13'd127;
assign s312 = 13'd15;
assign s313 = 13'd127;
assign s314 = 13'd1023;
assign s315 = ({13{s68}} & s311) | ({13{s69}} & s312) | ({13{s70}} & s313) | ({13{s71}} & s314);
assign s57 = {s54[11],s54};
assign s58 = {s55[11],s55};
wire nds_unused_f2_op1_exp_no_bias_co;
assign {nds_unused_f2_op1_exp_no_bias_co,s56} = s57 - s315;
wire nds_unused_f2_div_exp_co;
assign {nds_unused_f2_div_exp_co,s59} = s57 - s58;
assign s60 = s75 ? s59 : {s56[12],s56[12:1]};
wire nds_unused_f2_ds_exp_minus_1_co;
assign {nds_unused_f2_ds_exp_minus_1_co,s61} = s60 + 13'h1fff;
assign s47 = s68;
assign s48 = s69;
assign s49 = s70;
assign s50 = s71;
wire nds_unused_ds_result_added_co;
assign {nds_unused_ds_result_added_co,s101} = s263 + s264;
assign s82 = s101[(DS_DOUT_MSB - 1)];
assign s83 = |s101[(DS_DOUT_MSB - 1):0];
assign s98 = s152 ? s100 : s99;
assign s97 = s102 ? {s98[(DS_DOUT_MSB - 1):0],1'b0} : s98;
assign s96 = s118[DS_DOUT_MSB:0];
assign f3_stall = s150 & (ds_busy | s251 | f3_main_pipe_stall | (wb_stall & s250));
assign s157 = (s94 & s102) ? s104 : s103;
assign s159 = s93;
assign s158 = s151 | s125;
assign s132 = ~s157[12] & (s157[11:0] > 12'd15);
assign s133 = ~s157[12] | (~s157[11:0] < 12'd14);
assign s134 = ~s157[12] | (~s157[11:0] < 12'd25);
assign s144 = ~s157[12] & (s157[11:0] > 12'd14);
assign s145 = ~s157[12] | (~s157[11:0] < 12'd15);
assign s146 = ~s157[12] | (~s157[11:0] < 12'd26);
assign s135 = ~s157[12] & (s157[11:0] > 12'd127);
assign s136 = ~s157[12] | (~s157[11:0] < 12'd126);
assign s137 = ~s157[12] | (~s157[11:0] < 12'd134);
assign s147 = ~s157[12] & (s157[11:0] > 12'd126);
assign s148 = ~s157[12] | (~s157[11:0] < 12'd127);
assign s149 = ~s157[12] | (~s157[11:0] < 12'd135);
assign s160 = (s89 & s135) | (s90 & s132) | (s91 & s129) | (s92 & s126);
assign s161 = (s89 & s136) | (s90 & s133) | (s91 & s130) | (s92 & s127);
assign s162 = (s89 & s137) | (s90 & s134) | (s91 & s131) | (s92 & s128);
assign s163 = (s89 & s147) | (s90 & s144) | (s91 & s141) | (s92 & s138);
assign s164 = (s89 & s148) | (s90 & s145) | (s91 & s142) | (s92 & s139);
assign s165 = (s89 & s149) | (s90 & s146) | (s91 & s143) | (s92 & s140);
assign s110 = ~s127 & s140;
assign s109 = ~s130 & s143;
assign s108 = ~s133 & s146;
assign s107 = ~s136 & s149;
assign s106 = (s90 & s108 | s89 & s107 | s91 & s109 | s92 & s110) & s150 & ~s251 & ~(s86 | s87 | s88);
wire [12:0] s316;
wire [12:0] s317;
assign s316 = ~s157;
assign s317 = (s89 ? 13'd125 : s90 ? 13'd13 : s91 ? 13'd125 : 13'd1021);
wire nds_unused_f3_subnorm_pred_num_co;
assign {nds_unused_f3_subnorm_pred_num_co,s105} = s316 - s317;
assign s111 = {6{s106}} & s105[5:0];
assign s112 = {s97[(DS_DOUT_MSB - 1):0],1'b0};
generate
    if (FLEN > 32) begin:gen_f3_sbs_l0_for_dp
        assign s113 = s111[5] ? {{32'b0},s112[DS_DOUT_MSB:32]} : s112;
        assign s119 = (s111[5] & (|s112[31:0]));
    end
    else begin:gen_f3_sbs_l0_for_hp_sp
        assign s113 = s112;
        assign s119 = 1'b0;
    end
endgenerate
generate
    if (FLEN > 16) begin:gen_f3_sbs_l1_for_dp_sp
        assign s114 = s111[4] ? {{16'b0},s113[DS_DOUT_MSB:16]} : s113;
        assign s120 = (s111[4] & (|s113[15:0]));
    end
    else begin:gen_f3_sbs_l1_for_hp
        assign s114 = s113;
        assign s120 = 1'b0;
    end
endgenerate
assign s115 = s111[3] ? {{8'b0},s114[DS_DOUT_MSB:8]} : s114;
assign s116 = s111[2] ? {{4'b0},s115[DS_DOUT_MSB:4]} : s115;
assign s117 = s111[1] ? {{2'b0},s116[DS_DOUT_MSB:2]} : s116;
assign s118 = s111[0] ? {{1'b0},s117[DS_DOUT_MSB:1]} : s117;
assign s121 = (s111[3] & (|s114[7:0]));
assign s122 = (s111[2] & (|s115[3:0]));
assign s123 = (s111[1] & (|s116[1:0]));
assign s124 = (s111[0] & (|s117[0]));
assign s125 = s124 | s123 | s122 | s121 | s120 | s119;
always @* begin
    case (s95)
        ROUND_RMM: s154 = ROUND_NEAREST;
        ROUND_RUP: s154 = ROUND_POS;
        ROUND_RDN: s154 = ROUND_NEG;
        ROUND_RTZ: s154 = ROUND_ZERO;
        default: s154 = ROUND_NEAREST;
    endcase
end

assign s155 = s154[0] & s154[1];
assign s156 = (~s159 & ~s154[0] & s154[1]) | (s159 & s154[0] & ~s154[1]);
assign s243 = |s203[(DSU_FRA_RND - 1):DSU_SRT_LSB];
assign s242 = s243 | s241;
assign s205 = s203[DSU_FRA_MSB:DSU_FRA_RND];
wire [DSU_FRA_MSB:DSU_FRA_RND] s318;
wire [DSU_FRA_MSB:DSU_FRA_RND] s319;
assign s318 = s205;
assign s319 = {{(DSU_FRA_MSB - DSU_FRA_RND - 1){1'b0}},&s214[1:0],^s214[1:0]};
wire nds_unused_f4_round_adder_result_co;
assign {nds_unused_f4_round_adder_result_co,s204} = s318 + s319;
assign s213 = s203[DSU_FRA_RND];
assign s249 = s213 & ~s242;
assign s248 = s249 & (s167 == ROUND_RNE);
assign s247 = s248 ? 1'b0 : s204[DSU_FRA_LSB];
assign s206 = {s204[DSU_FRA_MSB:(DSU_FRA_LSB + 1)],s247};
assign s214 = {(s242 & s212),(s211 | s212)};
assign s215 = {(s214[1] & s214[0]),(s214[1] ^ s214[0])};
assign s245 = ~(|s203[DSU_SRT_MSB:DSU_SRT_LSB]);
assign s246 = ~(|s206[DSU_FRA_MSB:DSU_FRA_LSB]);
assign s178 = ~s173 & ~s171 & (s172 | s246 | (s232 & ~s233 & ((s167 == ROUND_RNE) | (s167 == ROUND_RMM) | (s167 == ROUND_RTZ) | ((s167 == ROUND_RUP) & s170) | ((s167 == ROUND_RDN) & ~s170))));
assign s181 = s232 & ~s233 & (((s167 == ROUND_RUP) & ~s170) | ((s167 == ROUND_RDN) & s170));
assign s179 = ~s173 & (s171 | (s231 & ((s167 == ROUND_RNE) | (s167 == ROUND_RMM) | ((s167 == ROUND_RDN) & s170) | ((s167 == ROUND_RUP) & ~s170))));
assign s180 = s231 & ((s167 == ROUND_RTZ) | ((s167 == ROUND_RUP) & s170) | ((s167 == ROUND_RDN) & ~s170));
assign s221 = s220 ? s227 : s224;
assign s222 = s220 ? s228 : s225;
assign s223 = s220 ? s229 : s226;
assign s182 = s171 | s173 | s172;
assign s231 = s221 & ~(s168 | s182);
assign s233 = ~s222 & s223;
assign s244 = s203[106];
assign s236 = s238 & ~(s215[1] | (s215[0] & s244));
assign s237 = s239 & (s242 | s213) & (s212 & !s211);
wire [11:0] s320;
wire [11:0] s321;
assign s320 = ~s216;
assign s321 = (s174 ? 12'd125 : s175 ? 12'd13 : s176 ? 12'd125 : s177 ? 12'd1021 : 12'd0);
wire nds_unused_f4_subnorm_amount_co;
assign {nds_unused_f4_subnorm_amount_co,s240} = s320 - s321;
assign s235 = (s240 == 12'b1) & (s236 | s237);
assign s232 = s233 & (s213 | s242) & (~s234 | s235) | (~s223 & ~(s168 | s169 | s182 | (s245 & ~s213 & ~s242)));
assign s230 = ~(s173 | s172) & ((s213 | s242) & ~(s169 | s171) | s231 | s232);
assign s207 = (s246 & ~s213 & ~s242 & ~s172) ? (s167 == ROUND_RDN) : s170;
assign s183 = s174 & s173;
assign s184 = s175 & s173;
assign s185 = s176 & s173;
assign s186 = s177 & s173;
assign s187 = s174 & s179;
assign s188 = s175 & s179;
assign s189 = s176 & s179;
assign s190 = s177 & s179;
assign s191 = s174 & s178;
assign s192 = s175 & s178;
assign s193 = s176 & s178;
assign s194 = s177 & s178;
assign s195 = s174 & s180;
assign s196 = s175 & s180;
assign s197 = s176 & s180;
assign s198 = s177 & s180;
assign s199 = s174 & s181;
assign s200 = s175 & s181;
assign s201 = s176 & s181;
assign s202 = s177 & s181;
assign s209 = ({64{s183}} & {48'hffffffffffff,1'b0,8'hff,7'h40}) | ({64{s184}} & {48'hffffffffffff,1'b0,5'h1f,10'h200}) | ({64{s185}} & {32'hffffffff,1'b0,8'hff,23'h400000}) | ({64{s186}} & {1'b0,11'h7ff,52'h8000000000000}) | ({64{s187}} & {48'hffffffffffff,s170,8'hff,7'h0}) | ({64{s188}} & {48'hffffffffffff,s170,5'h1f,10'h0}) | ({64{s189}} & {32'hffffffff,s170,8'hff,23'h0}) | ({64{s190}} & {s170,11'h7ff,52'h0}) | ({64{s191}} & {48'hffffffffffff,s207,8'h00,7'h0}) | ({64{s192}} & {48'hffffffffffff,s207,5'h00,10'h0}) | ({64{s193}} & {32'hffffffff,s207,8'h00,23'h0}) | ({64{s194}} & {s207,11'h000,52'h0}) | ({64{s195}} & {48'hffffffffffff,s170,8'hfe,7'h7f}) | ({64{s196}} & {48'hffffffffffff,s170,5'h1e,10'h3ff}) | ({64{s197}} & {32'hffffffff,s170,8'hfe,23'h7fffff}) | ({64{s198}} & {s170,11'h7fe,52'hfffffffffffff}) | ({64{s199}} & {48'hffffffffffff,s170,8'h00,7'h1}) | ({64{s200}} & {48'hffffffffffff,s170,5'h00,10'h1}) | ({64{s201}} & {32'hffffffff,s170,8'h00,23'h1}) | ({64{s202}} & {s170,11'h000,52'h1});
assign s210 = s179 | s178 | s173 | s180 | s181;
assign f4_wdata = s43 ? s44 : s210 ? s209 : s208;
assign f4_wdata_en = s250 | (s43 & s80);
assign f4_flag_set = s43 ? s45 : {5{s250}} & {s169,s168,s231,s232,s230};
assign f4_result_type = s43 ? s46 : s166 ? 2'b11 : s177 ? 2'b10 : s176 ? 2'b01 : 2'b00;
generate
    if (FLEN == 64) begin:gen_fpu_dp
        assign s27 = (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[51:0] == 52'b0);
        assign nds_unused_f1_op1_d_is_subnor = (f1_op1_data[62:52] == 11'b0) & (f1_op1_data[51:0] != 52'b0);
        assign s28 = (f1_op1_data[62:52] == 11'h7ff) & f1_op1_data[51];
        assign s29 = (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[50:0] != 51'b0) & ~f1_op1_data[51];
        assign s30 = (f1_op2_data[62:52] == 11'h7ff) & (f1_op2_data[51:0] == 52'b0);
        assign nds_unused_f1_op2_d_is_subnor = (f1_op2_data[62:52] == 11'b0) & (f1_op2_data[51:0] != 52'b0);
        assign s31 = (f1_op2_data[62:52] == 11'h7ff) & f1_op2_data[51];
        assign s32 = (f1_op2_data[62:52] == 11'h7ff) & (f1_op2_data[50:0] != 51'b0) & ~f1_op2_data[51];
        assign ds_din0 = s66;
        assign ds_din1 = s65;
        assign s102 = s89 ? (s152 ? ~s100[10] : ~s99[10]) : s90 ? (s152 ? ~s100[13] : ~s99[13]) : s91 ? (s152 ? ~s100[26] : ~s99[26]) : (s152 ? ~s100[55] : ~s99[55]);
        assign s138 = ~s157[12] & (s157[11:0] > 12'd1022);
        assign s139 = ~s157[12] | (~s157[11:0] < 12'd1023);
        assign s140 = ~s157[12] | (~s157[11:0] < 12'd1076);
        assign s126 = ~s157[12] & (s157[11:0] > 12'd1023);
        assign s127 = ~s157[12] | (~s157[11:0] < 12'd1022);
        assign s128 = ~s157[12] | (~s157[11:0] < 12'd1075);
        assign s129 = ~s157[12] & (s157[11:0] > 12'd127);
        assign s130 = ~s157[12] | (~s157[11:0] < 12'd126);
        assign s131 = ~s157[12] | (~s157[11:0] < 12'd150);
        assign s141 = ~s157[12] & (s157[11:0] > 12'd126);
        assign s142 = ~s157[12] | (~s157[11:0] < 12'd127);
        assign s143 = ~s157[12] | (~s157[11:0] < 12'd151);
        assign s238 = s174 & (s203[114:107] == 08'hff) | s175 & (s203[117:107] == 11'h7ff) | s176 & (s203[130:107] == 24'hffffff) | s177 & (s203[159:107] == 53'h1fffffffffffff);
        assign s239 = s174 & (s203[114:107] == 08'hfe) | s175 & (s203[117:107] == 11'h7fe) | s176 & (s203[130:107] == 24'hfffffe) | s177 & (s203[159:107] == 53'h1ffffffffffffe);
        assign s234 = s174 ? s206[115] : s175 ? s206[118] : s176 ? s206[131] : s206[160];
        assign s220 = s177 & s204[161] | s176 & s204[132] | s175 & s204[119] | s174 & s204[116];
        assign s218 = {11'b0,s174 ? s206[115] : s175 ? s206[118] : s176 ? s206[131] : s206[160]};
        wire [11:0] s322;
        wire [11:0] s323;
        assign s322 = s216;
        assign s323 = (s174 ? 12'd127 : s175 ? 12'd15 : s176 ? 12'd127 : 12'd1023) + {11'b0,s220};
        wire nds_unused_f4_exp_bias_norm_co;
        assign {nds_unused_f4_exp_bias_norm_co,s219} = s322 + s323;
        assign s217 = s233 ? s218 : s219;
        assign s208 = s174 ? {48'hffffffffffff,s170,s217[7:0],s206[114:108]} : s175 ? {48'hffffffffffff,s170,s217[4:0],s206[117:108]} : s176 ? {32'hffffffff,s170,s217[7:0],s206[130:108]} : {s170,s217[10:0],s206[159:108]};
    end
    else if (FLEN == 32) begin:gen_fpu_sp
        assign s27 = 1'b0;
        assign nds_unused_f1_op1_d_is_subnor = 1'b0;
        assign s28 = 1'b0;
        assign s29 = 1'b0;
        assign s30 = 1'b0;
        assign nds_unused_f1_op2_d_is_subnor = 1'b0;
        assign s31 = 1'b0;
        assign s32 = 1'b0;
        assign ds_din0 = s66[53:29];
        assign ds_din1 = s65[53:30];
        assign s102 = s89 ? s152 ? ~s100[10] : ~s99[10] : s90 ? s152 ? ~s100[13] : ~s99[13] : s152 ? ~s100[26] : ~s99[26];
        assign s138 = 1'b0;
        assign s139 = 1'b0;
        assign s140 = 1'b0;
        assign s126 = 1'b0;
        assign s127 = 1'b0;
        assign s128 = 1'b0;
        assign s129 = ~s157[12] & (s157[11:0] > 12'd127);
        assign s130 = ~s157[12] | (~s157[11:0] < 12'd126);
        assign s131 = ~s157[12] | (~s157[11:0] < 12'd150);
        assign s141 = ~s157[12] & (s157[11:0] > 12'd126);
        assign s142 = ~s157[12] | (~s157[11:0] < 12'd127);
        assign s143 = ~s157[12] | (~s157[11:0] < 12'd151);
        assign s238 = s174 & (s203[114:107] == 08'hff) | s175 & (s203[117:107] == 11'h7ff) | s176 & (s203[130:107] == 24'hffffff);
        assign s239 = s174 & (s203[114:107] == 08'hfe) | s175 & (s203[117:107] == 11'h7fe) | s176 & (s203[130:107] == 24'hfffffe);
        assign s234 = s174 ? s206[115] : s175 ? s206[118] : s206[131];
        assign s220 = s176 & s204[132] | s175 & s204[119] | s174 & s204[116];
        assign s218 = {11'b0,s174 ? s206[115] : s175 ? s206[118] : s206[131]};
        wire [11:0] s322;
        wire [11:0] s323;
        assign s322 = s216;
        assign s323 = (s175 ? 12'd15 : 12'd127) + {11'b0,s220};
        wire nds_unused_f4_exp_bias_norm_co;
        assign {nds_unused_f4_exp_bias_norm_co,s219} = s322 + s323;
        assign s217 = s233 ? s218 : s219;
        assign s208 = s175 ? {48'hffffffffffff,s170,s217[4:0],s206[117:108]} : s174 ? {48'hffffffffffff,s170,s217[7:0],s206[114:108]} : {32'hffffffff,s170,s217[7:0],s206[130:108]};
    end
    else begin:gen_fpu_hp
        assign s27 = 1'b0;
        assign nds_unused_f1_op1_d_is_subnor = 1'b0;
        assign s28 = 1'b0;
        assign s29 = 1'b0;
        assign s30 = 1'b0;
        assign nds_unused_f1_op2_d_is_subnor = 1'b0;
        assign s31 = 1'b0;
        assign s32 = 1'b0;
        assign ds_din0 = s66[53:42];
        assign ds_din1 = s65[53:43];
        assign s102 = s89 ? (s152 ? ~s100[10] : ~s99[10]) : (s152 ? ~s100[13] : ~s99[13]);
        assign s138 = 1'b0;
        assign s139 = 1'b0;
        assign s140 = 1'b0;
        assign s126 = 1'b0;
        assign s127 = 1'b0;
        assign s128 = 1'b0;
        assign s141 = 1'b0;
        assign s142 = 1'b0;
        assign s143 = 1'b0;
        assign s129 = 1'b0;
        assign s130 = 1'b0;
        assign s131 = 1'b0;
        assign s238 = s174 & (s203[114:107] == 08'hff) | s175 & (s203[117:107] == 11'h7ff);
        assign s239 = s174 & (s203[114:107] == 08'hfe) | s175 & (s203[117:107] == 11'h7fe);
        assign s234 = s174 ? s206[115] : s206[118];
        assign s220 = s175 & s204[119] | s174 & s204[116];
        assign s218 = {11'b0,s174 ? s206[115] : s206[118]};
        wire [11:0] s322;
        wire [11:0] s323;
        assign s322 = s216;
        assign s323 = (s174 ? 12'd127 : 12'd15) + {11'b0,s220};
        wire nds_unused_f4_exp_bias_norm_co;
        assign {nds_unused_f4_exp_bias_norm_co,s219} = s322 + s323;
        assign s217 = s233 ? s218 : s219;
        assign s208 = s174 ? {48'hffffffffffff,s170,s217[7:0],s206[114:108]} : {48'hffffffffffff,s170,s217[4:0],s206[117:108]};
    end
endgenerate
generate
    if (FLEN == 16) begin:gen_fpu_hp_subnormal_input
        reg [5:0] s324;
        reg [5:0] s325;
        wire [3:0] s326 = {4{s21}} & s324[3:0];
        wire [3:0] s327 = {4{s22}} & s325[3:0];
        wire [9:0] s328 = ({10{s11}} & f1_op1_data[9:0]) | ({10{s10}} & {f1_op1_data[6:0],3'b0});
        wire [9:0] s329 = s326[0] ? {s328[9 - 1:0],1'd0} : s328;
        wire [9:0] s330 = s326[1] ? {s329[9 - 2:0],2'd0} : s329;
        wire [9:0] s331 = s326[2] ? {s330[9 - 4:0],4'd0} : s330;
        wire [9:0] s332 = s326[3] ? {s331[9 - 8:0],8'd0} : s331;
        wire [5:0] s333;
        wire [5:0] s334;
        wire [5:0] s335;
        assign s333 = 6'd1;
        assign s334 = s324;
        wire nds_unused_exp_bh_op1_with_bias_co;
        assign {nds_unused_exp_bh_op1_with_bias_co,s335} = s333 - s334;
        wire [9:0] s336 = ({10{s11}} & f1_op2_data[9:0]) | ({10{s10}} & {f1_op2_data[6:0],3'b0});
        wire [9:0] s337 = s327[0] ? {s336[9 - 1:0],1'd0} : s336;
        wire [9:0] s338 = s327[1] ? {s337[9 - 2:0],2'd0} : s337;
        wire [9:0] s339 = s327[2] ? {s338[9 - 4:0],4'd0} : s338;
        wire [9:0] s340 = s327[3] ? {s339[9 - 8:0],8'd0} : s339;
        wire [5:0] s341;
        wire [5:0] s342;
        wire [5:0] s343;
        assign s341 = 6'd1;
        assign s342 = s325;
        wire nds_unused_exp_bh_op2_with_bias_co;
        assign {nds_unused_exp_bh_op2_with_bias_co,s343} = s341 - s342;
        assign s35 = {s23,s332};
        assign s36 = {s24,s340};
        assign s62 = {s35[10:0],42'b0};
        assign s63 = {s36[10:0],42'b0};
        wire [8:0] s344 = s11 ? {4'b0,f1_op1_data[14:10]} : {1'b0,f1_op1_data[14:7]};
        wire [8:0] s345 = s11 ? {4'b0,f1_op2_data[14:10]} : {1'b0,f1_op2_data[14:7]};
        assign s33 = s19 ? 12'b0 : s21 ? {{6{s335[5]}},s335[5:0]} : {3'b0,s344};
        assign s34 = s20 ? 12'b0 : s22 ? {{6{s343[5]}},s343[5:0]} : {3'b0,s345};
        assign s54 = {{4{s52[8]}},s52[7:0]};
        assign s55 = {{4{s53[8]}},s53[7:0]};
        always @* begin
            casez (s328[9:0])
                {1'd1,{9{1'b?}}}: s324 = 6'd1;
                {2'd1,{8{1'b?}}}: s324 = 6'd2;
                {3'd1,{7{1'b?}}}: s324 = 6'd3;
                {4'd1,{6{1'b?}}}: s324 = 6'd4;
                {5'd1,{5{1'b?}}}: s324 = 6'd5;
                {6'd1,{4{1'b?}}}: s324 = 6'd6;
                {7'd1,{3{1'b?}}}: s324 = 6'd7;
                {8'd1,{2{1'b?}}}: s324 = 6'd8;
                {9'd1,{1{1'b?}}}: s324 = 6'd9;
                default: s324 = 6'd10;
            endcase
        end

        always @* begin
            casez (s336[9:0])
                {1'd1,{9{1'b?}}}: s325 = 6'd1;
                {2'd1,{8{1'b?}}}: s325 = 6'd2;
                {3'd1,{7{1'b?}}}: s325 = 6'd3;
                {4'd1,{6{1'b?}}}: s325 = 6'd4;
                {5'd1,{5{1'b?}}}: s325 = 6'd5;
                {6'd1,{4{1'b?}}}: s325 = 6'd6;
                {7'd1,{3{1'b?}}}: s325 = 6'd7;
                {8'd1,{2{1'b?}}}: s325 = 6'd8;
                {9'd1,{1{1'b?}}}: s325 = 6'd9;
                default: s325 = 6'd10;
            endcase
        end

    end
    else if (FLEN == 32) begin:gen_fpu_sp_subnormal_input
        wire [8:0] s346;
        wire [8:0] s347;
        wire [4:0] s326 = {5{s21}} & s346[4:0];
        wire [4:0] s327 = {5{s22}} & s347[4:0];
        wire [22:0] s348 = {23{s12}} & f1_op1_data[22:0] | {23{s11}} & {f1_op1_data[9:0],13'b0} | {23{s10}} & {f1_op1_data[6:0],16'b0};
        wire [22:0] s349 = s326[0] ? {s348[22 - 1:0],1'd0} : s348;
        wire [22:0] s350 = s326[1] ? {s349[22 - 2:0],2'd0} : s349;
        wire [22:0] s351 = s326[2] ? {s350[22 - 4:0],4'd0} : s350;
        wire [22:0] s352 = s326[3] ? {s351[22 - 8:0],8'd0} : s351;
        wire [22:0] s353 = s326[4] ? {s352[22 - 16:0],16'd0} : s352;
        wire [8:0] s354;
        wire [8:0] s355;
        wire [8:0] s356;
        assign s354 = 9'd1;
        assign s355 = s346;
        wire nds_unused_exp_s_op1_with_bias_co;
        assign {nds_unused_exp_s_op1_with_bias_co,s356} = s354 - s355;
        wire [22:0] s357 = {23{s12}} & f1_op2_data[22:0] | {23{s11}} & {f1_op2_data[9:0],13'b0} | {23{s10}} & {f1_op2_data[6:0],16'b0};
        wire [22:0] s358 = s327[0] ? {s357[22 - 1:0],1'd0} : s357;
        wire [22:0] s359 = s327[1] ? {s358[22 - 2:0],2'd0} : s358;
        wire [22:0] s360 = s327[2] ? {s359[22 - 4:0],4'd0} : s359;
        wire [22:0] s361 = s327[3] ? {s360[22 - 8:0],8'd0} : s360;
        wire [22:0] s362 = s327[4] ? {s361[22 - 16:0],16'd0} : s361;
        wire [8:0] s363;
        wire [8:0] s364;
        wire [8:0] s365;
        assign s363 = 9'd1;
        assign s364 = s347;
        wire nds_unused_exp_s_op2_with_bias_co;
        assign {nds_unused_exp_s_op2_with_bias_co,s365} = s363 - s364;
        assign s35 = {s23,s353};
        assign s36 = {s24,s362};
        assign s62 = {s35[23:0],29'b0};
        assign s63 = {s36[23:0],29'b0};
        wire [8:0] s344 = s12 ? {1'b0,f1_op1_data[30:23]} : s11 ? {4'b0,f1_op1_data[14:10]} : {1'b0,f1_op1_data[14:7]};
        wire [8:0] s345 = s12 ? {1'b0,f1_op2_data[30:23]} : s11 ? {4'b0,f1_op2_data[14:10]} : {1'b0,f1_op2_data[14:7]};
        assign s33 = s19 ? 12'b0 : s21 ? {{3{s356[8]}},s356[8:0]} : {3'b0,s344};
        assign s34 = s20 ? 12'b0 : s22 ? {{3{s365[8]}},s365[8:0]} : {3'b0,s345};
        assign s54 = {{4{s52[8]}},s52[7:0]};
        assign s55 = {{4{s53[8]}},s53[7:0]};
        wire [31:0] s366;
        wire [15:0] s367;
        wire [7:0] s368;
        wire [3:0] s369;
        wire [1:0] s370;
        wire [4:0] s371;
        assign s371[4] = ~|s366[31:16];
        assign s371[3] = ~|s367[15:8];
        assign s371[2] = ~|s368[7:4];
        assign s371[1] = ~|s369[3:2];
        assign s371[0] = ~s370[1];
        assign s366 = {1'b0,s348[22:0],8'b0};
        assign s367 = s371[4] ? s366[15:0] : s366[31:16];
        assign s368 = s371[3] ? s367[7:0] : s367[15:8];
        assign s369 = s371[2] ? s368[3:0] : s368[7:4];
        assign s370 = s371[1] ? s369[1:0] : s369[3:2];
        assign s346 = {4'b0,s371[4:0]};
        wire [31:0] s372;
        wire [15:0] s373;
        wire [7:0] s374;
        wire [3:0] s375;
        wire [1:0] s376;
        wire [4:0] s377;
        assign s377[4] = ~|s372[31:16];
        assign s377[3] = ~|s373[15:8];
        assign s377[2] = ~|s374[7:4];
        assign s377[1] = ~|s375[3:2];
        assign s377[0] = ~s376[1];
        assign s372 = {1'b0,s357[22:0],8'b0};
        assign s373 = s377[4] ? s372[15:0] : s372[31:16];
        assign s374 = s377[3] ? s373[7:0] : s373[15:8];
        assign s375 = s377[2] ? s374[3:0] : s374[7:4];
        assign s376 = s377[1] ? s375[1:0] : s375[3:2];
        assign s347 = {4'b0,s377[4:0]};
    end
    else begin:gen_fpu_dp_subnormal_input
        wire [11:0] s378;
        wire [11:0] s379;
        wire [5:0] s326 = {6{s21}} & s378[5:0];
        wire [5:0] s327 = {6{s22}} & s379[5:0];
        wire [51:0] s380 = {52{s13}} & f1_op1_data[51:0] | {52{s12}} & {f1_op1_data[22:0],29'b0} | {52{s11}} & {f1_op1_data[9:0],42'b0} | {52{s10}} & {f1_op1_data[6:0],45'b0};
        wire [51:0] s381 = s326[0] ? {s380[51 - 1:0],1'd0} : s380;
        wire [51:0] s382 = s326[1] ? {s381[51 - 2:0],2'd0} : s381;
        wire [51:0] s383 = s326[2] ? {s382[51 - 4:0],4'd0} : s382;
        wire [51:0] s384 = s326[3] ? {s383[51 - 8:0],8'd0} : s383;
        wire [51:0] s385 = s326[4] ? {s384[51 - 16:0],16'd0} : s384;
        wire [51:0] s386 = s326[5] ? {s385[51 - 32:0],32'd0} : s385;
        wire [11:0] s387;
        wire [11:0] s388;
        wire [11:0] s389;
        assign s387 = 12'd1;
        assign s388 = s378;
        wire nds_unused_exp_d_op1_with_bias_co;
        assign {nds_unused_exp_d_op1_with_bias_co,s389} = s387 - s388;
        wire [51:0] s390 = {52{s13}} & f1_op2_data[51:0] | {52{s12}} & {f1_op2_data[22:0],29'b0} | {52{s11}} & {f1_op2_data[9:0],42'b0} | {52{s10}} & {f1_op2_data[6:0],45'b0};
        wire [51:0] s391 = s327[0] ? {s390[51 - 1:0],1'd0} : s390;
        wire [51:0] s392 = s327[1] ? {s391[51 - 2:0],2'd0} : s391;
        wire [51:0] s393 = s327[2] ? {s392[51 - 4:0],4'd0} : s392;
        wire [51:0] s394 = s327[3] ? {s393[51 - 8:0],8'd0} : s393;
        wire [51:0] s395 = s327[4] ? {s394[51 - 16:0],16'd0} : s394;
        wire [51:0] s396 = s327[5] ? {s395[51 - 32:0],32'd0} : s395;
        wire [11:0] s397;
        wire [11:0] s398;
        wire [11:0] s399;
        assign s397 = 12'd1;
        assign s398 = s379;
        wire nds_unused_exp_d_op2_with_bias_co;
        assign {nds_unused_exp_d_op2_with_bias_co,s399} = s397 - s398;
        assign s35 = {s23,s386};
        assign s36 = {s24,s396};
        assign s62 = s35[52:0];
        assign s63 = s36[52:0];
        wire [11:0] s344 = {12{s13}} & {1'b0,f1_op1_data[62:52]} | {12{s12}} & {4'b0,f1_op1_data[30:23]} | {12{s11}} & {7'b0,f1_op1_data[14:10]} | {12{s10}} & {4'b0,f1_op1_data[14:07]};
        wire [11:0] s345 = {12{s13}} & {1'b0,f1_op2_data[62:52]} | {12{s12}} & {4'b0,f1_op2_data[30:23]} | {12{s11}} & {7'b0,f1_op2_data[14:10]} | {12{s10}} & {4'b0,f1_op2_data[14:07]};
        assign s33 = s19 ? 12'b0 : s21 ? s389[11:0] : s344;
        assign s34 = s20 ? 12'b0 : s22 ? s399[11:0] : s345;
        assign s54 = s52[11:0];
        assign s55 = s53[11:0];
        wire [63:0] s400;
        wire [31:0] s366;
        wire [15:0] s367;
        wire [7:0] s368;
        wire [3:0] s369;
        wire [1:0] s370;
        wire s401;
        wire [1:0] s402;
        wire [1:0] s403;
        wire [1:0] s404;
        wire [1:0] s405;
        wire [5:0] s371;
        assign s400 = {1'b0,s380[51:0],11'b0};
        assign s401 = ~|s400[63:32];
        assign s402[1] = ~|s400[31:16];
        assign s402[0] = ~|s400[63:48];
        assign s403[1] = s371[5] ? ~|s400[15:8] : ~|s400[47:40];
        assign s403[0] = s371[5] ? ~|s400[31:24] : ~|s400[63:56];
        assign s404[1] = ((s371[5:4] == 2'b11) & (~|s400[7:4])) | ((s371[5:4] == 2'b10) & (~|s400[23:20])) | ((s371[5:4] == 2'b01) & (~|s400[39:36])) | ((s371[5:4] == 2'b00) & (~|s400[55:52]));
        assign s404[0] = ((s371[5:4] == 2'b11) & (~|s400[15:12])) | ((s371[5:4] == 2'b10) & (~|s400[31:28])) | ((s371[5:4] == 2'b01) & (~|s400[47:44])) | ((s371[5:4] == 2'b00) & (~|s400[63:60]));
        assign s405[1] = ((s371[5:3] == 3'b111) & (~|s400[3:2])) | ((s371[5:3] == 3'b110) & (~|s400[11:10])) | ((s371[5:3] == 3'b101) & (~|s400[19:18])) | ((s371[5:3] == 3'b100) & (~|s400[27:26])) | ((s371[5:3] == 3'b011) & (~|s400[35:34])) | ((s371[5:3] == 3'b010) & (~|s400[43:42])) | ((s371[5:3] == 3'b001) & (~|s400[51:50])) | ((s371[5:3] == 3'b000) & (~|s400[59:58]));
        assign s405[0] = ((s371[5:3] == 3'b111) & (~|s400[7:6])) | ((s371[5:3] == 3'b110) & (~|s400[15:14])) | ((s371[5:3] == 3'b101) & (~|s400[23:22])) | ((s371[5:3] == 3'b100) & (~|s400[31:30])) | ((s371[5:3] == 3'b011) & (~|s400[39:38])) | ((s371[5:3] == 3'b010) & (~|s400[47:46])) | ((s371[5:3] == 3'b001) & (~|s400[55:54])) | ((s371[5:3] == 3'b000) & (~|s400[63:62]));
        assign s371[5] = s401;
        assign s371[4] = s371[5] ? s402[1] : s402[0];
        assign s371[3] = s371[4] ? s403[1] : s403[0];
        assign s371[2] = s371[3] ? s404[1] : s404[0];
        assign s371[1] = s371[2] ? s405[1] : s405[0];
        assign s371[0] = ~s370[1];
        assign s366 = s371[5] ? s400[31:0] : s400[63:32];
        assign s367 = s371[4] ? s366[15:0] : s366[31:16];
        assign s368 = s371[3] ? s367[7:0] : s367[15:8];
        assign s369 = s371[2] ? s368[3:0] : s368[7:4];
        assign s370 = s371[1] ? s369[1:0] : s369[3:2];
        assign s378 = {6'b0,s371[5:0]};
        wire [63:0] s406;
        wire [31:0] s372;
        wire [15:0] s373;
        wire [7:0] s374;
        wire [3:0] s375;
        wire [1:0] s376;
        wire s407;
        wire [1:0] s408;
        wire [1:0] s409;
        wire [1:0] s410;
        wire [1:0] s411;
        wire [5:0] s377;
        assign s406 = {1'b0,s390[51:0],11'b0};
        assign s407 = ~|s406[63:32];
        assign s408[1] = ~|s406[31:16];
        assign s408[0] = ~|s406[63:48];
        assign s409[1] = s377[5] ? ~|s406[15:8] : ~|s406[47:40];
        assign s409[0] = s377[5] ? ~|s406[31:24] : ~|s406[63:56];
        assign s410[1] = ((s377[5:4] == 2'b11) & (~|s406[7:4])) | ((s377[5:4] == 2'b10) & (~|s406[23:20])) | ((s377[5:4] == 2'b01) & (~|s406[39:36])) | ((s377[5:4] == 2'b00) & (~|s406[55:52]));
        assign s410[0] = ((s377[5:4] == 2'b11) & (~|s406[15:12])) | ((s377[5:4] == 2'b10) & (~|s406[31:28])) | ((s377[5:4] == 2'b01) & (~|s406[47:44])) | ((s377[5:4] == 2'b00) & (~|s406[63:60]));
        assign s411[1] = ((s377[5:3] == 3'b111) & (~|s406[3:2])) | ((s377[5:3] == 3'b110) & (~|s406[11:10])) | ((s377[5:3] == 3'b101) & (~|s406[19:18])) | ((s377[5:3] == 3'b100) & (~|s406[27:26])) | ((s377[5:3] == 3'b011) & (~|s406[35:34])) | ((s377[5:3] == 3'b010) & (~|s406[43:42])) | ((s377[5:3] == 3'b001) & (~|s406[51:50])) | ((s377[5:3] == 3'b000) & (~|s406[59:58]));
        assign s411[0] = ((s377[5:3] == 3'b111) & (~|s406[7:6])) | ((s377[5:3] == 3'b110) & (~|s406[15:14])) | ((s377[5:3] == 3'b101) & (~|s406[23:22])) | ((s377[5:3] == 3'b100) & (~|s406[31:30])) | ((s377[5:3] == 3'b011) & (~|s406[39:38])) | ((s377[5:3] == 3'b010) & (~|s406[47:46])) | ((s377[5:3] == 3'b001) & (~|s406[55:54])) | ((s377[5:3] == 3'b000) & (~|s406[63:62]));
        assign s377[5] = s407;
        assign s377[4] = s377[5] ? s408[1] : s408[0];
        assign s377[3] = s377[4] ? s409[1] : s409[0];
        assign s377[2] = s377[3] ? s410[1] : s410[0];
        assign s377[1] = s377[2] ? s411[1] : s411[0];
        assign s377[0] = ~s376[1];
        assign s372 = s377[5] ? s406[31:0] : s406[63:32];
        assign s373 = s377[4] ? s372[15:0] : s372[31:16];
        assign s374 = s377[3] ? s373[7:0] : s373[15:8];
        assign s375 = s377[2] ? s374[3:0] : s374[7:4];
        assign s376 = s377[1] ? s375[1:0] : s375[3:2];
        assign s379 = {6'b0,s377[5:0]};
    end
endgenerate
wire s412;
wire s413;
wire s414;
wire s415;
wire [11:0] s416;
wire [11:0] s417;
wire [11:0] s418;
wire [11:0] s419;
wire s420;
wire [8:0] s421;
wire [8:0] s422;
reg [6:0] s423;
reg [6:0] s424;
wire [6:0] s425;
wire [6:0] s426;
wire [8:0] s427;
wire [6:0] s428;
wire [6:0] s429;
wire [63:0] s430;
wire [63:0] s431;
wire s432;
wire s433;
wire s434;
wire s435;
wire s436;
wire s437;
wire s438;
wire s439;
assign s412 = (s10 & (~(|f1_op1_data[14:5])));
assign s413 = (s11 & (~(|f1_op1_data[14:8])));
assign s414 = (s12 & (~(|f1_op1_data[30:21])));
assign s415 = (s13 & (~(|f1_op1_data[62:50])));
assign s4 = ((s413 | s412 | s414 | s415) & ~s19);
assign s416 = s33;
assign s417 = ({12{s13}} & 12'd1022) | ({12{s12}} & 12'd126) | ({12{s10}} & 12'd126) | ({12{s11}} & 12'd14);
wire [11:0] s440;
wire [11:0] s441;
wire [11:0] s442;
assign s440 = ({12{s10}} & s311[11:0]) | ({12{s11}} & s312[11:0]) | ({12{s12}} & s313[11:0]) | ({12{s13}} & s314[11:0]);
assign s441 = s416;
assign s442 = s440;
wire nds_unused_f1_op1_exp_no_bias_co;
assign {nds_unused_f1_op1_exp_no_bias_co,s418} = s441 - s442;
wire [11:0] s443;
wire [11:0] s444;
assign s443 = s417;
assign s444 = (s0 ? s418 : {s418[11],s418[11:1]});
wire nds_unused_f1_estimate7_exp_co;
assign {nds_unused_f1_estimate7_exp_co,s3} = s443 - s444;
assign s433 = s269[12];
assign s419 = s269[11:0];
assign s430 = {64{s71}} & {s79,{11{~s439}} & s419[10:0],s427,43'b0} | {64{s70}} & {{32{1'b1}},s79,{8{~s439}} & s419[7:0],s427,14'b0} | {64{s68}} & {{48{1'b1}},s79,{8{~s439}} & s419[7:0],s427[8:2]} | {64{s69}} & {{48{1'b1}},s79,{5{~s439}} & s419[4:0],s427,1'b0};
assign s44 = s432 ? s431 : s430;
assign s434 = s41 & s433;
assign s436 = s41 & s433;
assign s435 = 1'b0;
assign s45 = {5{s80}} & {s78,s77,s434,s435,s436};
assign s46 = ({2{s70}} & 2'b01) | ({2{s71}} & 2'b10);
assign s426 = s41 ? s423 : s424;
assign s427 = s439 ? s422 : {s426,2'b0};
assign s432 = s73 | s74 | s438 | s437;
assign s438 = s434 & ((s67 == ROUND_RTZ) | ((s67 == ROUND_RUP) & s79) | ((s67 == ROUND_RDN) & ~s79));
assign s437 = ~s74 & (s72 | (s434 & ((s67 == ROUND_RNE) | (s67 == ROUND_RMM) | ((s67 == ROUND_RDN) & s79) | ((s67 == ROUND_RUP) & ~s79))));
assign s431 = ({64{s437 & s68}} & {{48{1'b1}},s79,8'hff,07'h0}) | ({64{s437 & s69}} & {{48{1'b1}},s79,5'h1f,10'h0}) | ({64{s437 & s70}} & {{32{1'b1}},s79,8'hff,23'h0}) | ({64{s437 & s71}} & {s79,11'h7ff,52'h0}) | ({64{s438 & s68}} & {{48{1'b1}},s79,8'hfe,07'h7f}) | ({64{s438 & s69}} & {{48{1'b1}},s79,5'h1e,10'h3ff}) | ({64{s438 & s70}} & {{32{1'b1}},s79,8'hfe,23'h7fffff}) | ({64{s438 & s71}} & {s79,11'h7fe,52'hfffffffffffff}) | ({64{s74 & s68}} & {{48{1'b1}},1'b0,8'hff,07'h40}) | ({64{s74 & s69}} & {{48{1'b1}},1'b0,5'h1f,10'h200}) | ({64{s74 & s70}} & {{32{1'b1}},1'b0,8'hff,23'h400000}) | ({64{s74 & s71}} & {1'b0,11'h7ff,52'h8000000000000}) | ({64{s73 & s68}} & {{48{1'b1}},s79,8'h00,07'h0}) | ({64{s73 & s69}} & {{48{1'b1}},s79,5'h00,10'h0}) | ({64{s73 & s70}} & {{32{1'b1}},s79,8'h00,23'h0}) | ({64{s73 & s71}} & {s79,11'h000,52'h0});
assign s439 = s419[11] | ~(|s419[10:0]);
assign s420 = s419[0];
assign s421 = {1'b1,s426[6:0],1'b0};
assign s422 = s420 ? {{1'b0},s421[8:1]} : s421;
assign s425 = s51[FRACTION_MSB - 1:FRACTION_MSB - 7];
assign s428 = {7{s41}} & {s425[6:0]};
assign s429 = {7{s42}} & {s54[0],s425[6:1]};
always @* begin
    case (s428[6:0])
        7'd0: s423 = 7'd127;
        7'd1: s423 = 7'd125;
        7'd2: s423 = 7'd123;
        7'd3: s423 = 7'd121;
        7'd4: s423 = 7'd119;
        7'd5: s423 = 7'd117;
        7'd6: s423 = 7'd116;
        7'd7: s423 = 7'd114;
        7'd8: s423 = 7'd112;
        7'd9: s423 = 7'd110;
        7'd10: s423 = 7'd109;
        7'd11: s423 = 7'd107;
        7'd12: s423 = 7'd105;
        7'd13: s423 = 7'd104;
        7'd14: s423 = 7'd102;
        7'd15: s423 = 7'd100;
        7'd16: s423 = 7'd99;
        7'd17: s423 = 7'd97;
        7'd18: s423 = 7'd96;
        7'd19: s423 = 7'd94;
        7'd20: s423 = 7'd93;
        7'd21: s423 = 7'd91;
        7'd22: s423 = 7'd90;
        7'd23: s423 = 7'd88;
        7'd24: s423 = 7'd87;
        7'd25: s423 = 7'd85;
        7'd26: s423 = 7'd84;
        7'd27: s423 = 7'd83;
        7'd28: s423 = 7'd81;
        7'd29: s423 = 7'd80;
        7'd30: s423 = 7'd79;
        7'd31: s423 = 7'd77;
        7'd32: s423 = 7'd76;
        7'd33: s423 = 7'd75;
        7'd34: s423 = 7'd74;
        7'd35: s423 = 7'd72;
        7'd36: s423 = 7'd71;
        7'd37: s423 = 7'd70;
        7'd38: s423 = 7'd69;
        7'd39: s423 = 7'd68;
        7'd40: s423 = 7'd66;
        7'd41: s423 = 7'd65;
        7'd42: s423 = 7'd64;
        7'd43: s423 = 7'd63;
        7'd44: s423 = 7'd62;
        7'd45: s423 = 7'd61;
        7'd46: s423 = 7'd60;
        7'd47: s423 = 7'd59;
        7'd48: s423 = 7'd58;
        7'd49: s423 = 7'd57;
        7'd50: s423 = 7'd56;
        7'd51: s423 = 7'd55;
        7'd52: s423 = 7'd54;
        7'd53: s423 = 7'd53;
        7'd54: s423 = 7'd52;
        7'd55: s423 = 7'd51;
        7'd56: s423 = 7'd50;
        7'd57: s423 = 7'd49;
        7'd58: s423 = 7'd48;
        7'd59: s423 = 7'd47;
        7'd60: s423 = 7'd46;
        7'd61: s423 = 7'd45;
        7'd62: s423 = 7'd44;
        7'd63: s423 = 7'd43;
        7'd64: s423 = 7'd42;
        7'd65: s423 = 7'd41;
        7'd66: s423 = 7'd40;
        7'd67: s423 = 7'd40;
        7'd68: s423 = 7'd39;
        7'd69: s423 = 7'd38;
        7'd70: s423 = 7'd37;
        7'd71: s423 = 7'd36;
        7'd72: s423 = 7'd35;
        7'd73: s423 = 7'd35;
        7'd74: s423 = 7'd34;
        7'd75: s423 = 7'd33;
        7'd76: s423 = 7'd32;
        7'd77: s423 = 7'd31;
        7'd78: s423 = 7'd31;
        7'd79: s423 = 7'd30;
        7'd80: s423 = 7'd29;
        7'd81: s423 = 7'd28;
        7'd82: s423 = 7'd28;
        7'd83: s423 = 7'd27;
        7'd84: s423 = 7'd26;
        7'd85: s423 = 7'd25;
        7'd86: s423 = 7'd25;
        7'd87: s423 = 7'd24;
        7'd88: s423 = 7'd23;
        7'd89: s423 = 7'd23;
        7'd90: s423 = 7'd22;
        7'd91: s423 = 7'd21;
        7'd92: s423 = 7'd21;
        7'd93: s423 = 7'd20;
        7'd94: s423 = 7'd19;
        7'd95: s423 = 7'd19;
        7'd96: s423 = 7'd18;
        7'd97: s423 = 7'd17;
        7'd98: s423 = 7'd17;
        7'd99: s423 = 7'd16;
        7'd100: s423 = 7'd15;
        7'd101: s423 = 7'd15;
        7'd102: s423 = 7'd14;
        7'd103: s423 = 7'd14;
        7'd104: s423 = 7'd13;
        7'd105: s423 = 7'd12;
        7'd106: s423 = 7'd12;
        7'd107: s423 = 7'd11;
        7'd108: s423 = 7'd11;
        7'd109: s423 = 7'd10;
        7'd110: s423 = 7'd9;
        7'd111: s423 = 7'd9;
        7'd112: s423 = 7'd8;
        7'd113: s423 = 7'd8;
        7'd114: s423 = 7'd7;
        7'd115: s423 = 7'd7;
        7'd116: s423 = 7'd6;
        7'd117: s423 = 7'd5;
        7'd118: s423 = 7'd5;
        7'd119: s423 = 7'd4;
        7'd120: s423 = 7'd4;
        7'd121: s423 = 7'd3;
        7'd122: s423 = 7'd3;
        7'd123: s423 = 7'd2;
        7'd124: s423 = 7'd2;
        7'd125: s423 = 7'd1;
        7'd126: s423 = 7'd1;
        default: s423 = 7'd0;
    endcase
end

always @* begin
    case (s429[6:0])
        7'd0: s424 = 7'd52;
        7'd1: s424 = 7'd51;
        7'd2: s424 = 7'd50;
        7'd3: s424 = 7'd48;
        7'd4: s424 = 7'd47;
        7'd5: s424 = 7'd46;
        7'd6: s424 = 7'd44;
        7'd7: s424 = 7'd43;
        7'd8: s424 = 7'd42;
        7'd9: s424 = 7'd41;
        7'd10: s424 = 7'd40;
        7'd11: s424 = 7'd39;
        7'd12: s424 = 7'd38;
        7'd13: s424 = 7'd36;
        7'd14: s424 = 7'd35;
        7'd15: s424 = 7'd34;
        7'd16: s424 = 7'd33;
        7'd17: s424 = 7'd32;
        7'd18: s424 = 7'd31;
        7'd19: s424 = 7'd30;
        7'd20: s424 = 7'd30;
        7'd21: s424 = 7'd29;
        7'd22: s424 = 7'd28;
        7'd23: s424 = 7'd27;
        7'd24: s424 = 7'd26;
        7'd25: s424 = 7'd25;
        7'd26: s424 = 7'd24;
        7'd27: s424 = 7'd23;
        7'd28: s424 = 7'd23;
        7'd29: s424 = 7'd22;
        7'd30: s424 = 7'd21;
        7'd31: s424 = 7'd20;
        7'd32: s424 = 7'd19;
        7'd33: s424 = 7'd19;
        7'd34: s424 = 7'd18;
        7'd35: s424 = 7'd17;
        7'd36: s424 = 7'd16;
        7'd37: s424 = 7'd16;
        7'd38: s424 = 7'd15;
        7'd39: s424 = 7'd14;
        7'd40: s424 = 7'd14;
        7'd41: s424 = 7'd13;
        7'd42: s424 = 7'd12;
        7'd43: s424 = 7'd12;
        7'd44: s424 = 7'd11;
        7'd45: s424 = 7'd10;
        7'd46: s424 = 7'd10;
        7'd47: s424 = 7'd9;
        7'd48: s424 = 7'd9;
        7'd49: s424 = 7'd8;
        7'd50: s424 = 7'd7;
        7'd51: s424 = 7'd7;
        7'd52: s424 = 7'd6;
        7'd53: s424 = 7'd6;
        7'd54: s424 = 7'd5;
        7'd55: s424 = 7'd4;
        7'd56: s424 = 7'd4;
        7'd57: s424 = 7'd3;
        7'd58: s424 = 7'd3;
        7'd59: s424 = 7'd2;
        7'd60: s424 = 7'd2;
        7'd61: s424 = 7'd1;
        7'd62: s424 = 7'd1;
        7'd63: s424 = 7'd0;
        7'd64: s424 = 7'd127;
        7'd65: s424 = 7'd125;
        7'd66: s424 = 7'd123;
        7'd67: s424 = 7'd121;
        7'd68: s424 = 7'd119;
        7'd69: s424 = 7'd118;
        7'd70: s424 = 7'd116;
        7'd71: s424 = 7'd114;
        7'd72: s424 = 7'd113;
        7'd73: s424 = 7'd111;
        7'd74: s424 = 7'd109;
        7'd75: s424 = 7'd108;
        7'd76: s424 = 7'd106;
        7'd77: s424 = 7'd105;
        7'd78: s424 = 7'd103;
        7'd79: s424 = 7'd102;
        7'd80: s424 = 7'd100;
        7'd81: s424 = 7'd99;
        7'd82: s424 = 7'd97;
        7'd83: s424 = 7'd96;
        7'd84: s424 = 7'd95;
        7'd85: s424 = 7'd93;
        7'd86: s424 = 7'd92;
        7'd87: s424 = 7'd91;
        7'd88: s424 = 7'd90;
        7'd89: s424 = 7'd88;
        7'd90: s424 = 7'd87;
        7'd91: s424 = 7'd86;
        7'd92: s424 = 7'd85;
        7'd93: s424 = 7'd84;
        7'd94: s424 = 7'd83;
        7'd95: s424 = 7'd82;
        7'd96: s424 = 7'd80;
        7'd97: s424 = 7'd79;
        7'd98: s424 = 7'd78;
        7'd99: s424 = 7'd77;
        7'd100: s424 = 7'd76;
        7'd101: s424 = 7'd75;
        7'd102: s424 = 7'd74;
        7'd103: s424 = 7'd73;
        7'd104: s424 = 7'd72;
        7'd105: s424 = 7'd71;
        7'd106: s424 = 7'd70;
        7'd107: s424 = 7'd70;
        7'd108: s424 = 7'd69;
        7'd109: s424 = 7'd68;
        7'd110: s424 = 7'd67;
        7'd111: s424 = 7'd66;
        7'd112: s424 = 7'd65;
        7'd113: s424 = 7'd64;
        7'd114: s424 = 7'd63;
        7'd115: s424 = 7'd63;
        7'd116: s424 = 7'd62;
        7'd117: s424 = 7'd61;
        7'd118: s424 = 7'd60;
        7'd119: s424 = 7'd59;
        7'd120: s424 = 7'd59;
        7'd121: s424 = 7'd58;
        7'd122: s424 = 7'd57;
        7'd123: s424 = 7'd56;
        7'd124: s424 = 7'd56;
        7'd125: s424 = 7'd55;
        7'd126: s424 = 7'd54;
        default: s424 = 7'd53;
    endcase
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

