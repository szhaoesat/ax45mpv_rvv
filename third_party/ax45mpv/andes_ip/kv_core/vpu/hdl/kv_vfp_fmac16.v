// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfp_fmac16 (
    f3_wdata,
    f3_wdata_en,
    f3_flag_set,
    vpu_vmac_clk,
    vpu_reset_n,
    fpipe_stall,
    f1_fp_mode,
    f1_op1_data,
    f1_op2_data,
    f1_op3_data,
    f1_valid,
    f1_round_mode,
    f1_mul_instr,
    f1_madd_instr,
    f1_msub_instr,
    f1_nmadd_instr,
    f1_nmsub_instr
);
localparam HP_FRAC_BW = 10;
localparam HP_BIAS = 7'd15;
localparam BP_BIAS = 7'd127;
localparam EXP_MSB = 9;
localparam MAC_MSB = 25;
localparam MAC_LSB = 0;
localparam MAC_WIDTH = MAC_MSB - MAC_LSB + 1;
localparam ALIGN_MSB = 31;
localparam ROUND_RNE = 3'b000;
localparam ROUND_RTZ = 3'b001;
localparam ROUND_RDN = 3'b010;
localparam ROUND_RUP = 3'b011;
localparam ROUND_RMM = 3'b100;
input vpu_vmac_clk;
input vpu_reset_n;
input [15:0] f1_op1_data;
input [15:0] f1_op2_data;
input [15:0] f1_op3_data;
input f1_valid;
input [2:0] f1_round_mode;
input fpipe_stall;
input f1_mul_instr;
input f1_madd_instr;
input f1_msub_instr;
input f1_nmadd_instr;
input f1_nmsub_instr;
input f1_fp_mode;
output [15:0] f3_wdata;
output f3_wdata_en;
output [4:0] f3_flag_set;





// c3e5b250 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [9:0] s0;
wire s1;
wire s2;
wire s3;
wire s4;
wire s5;
wire [7:0] s6;
wire [7:0] s7;
wire [7:0] s8;
wire [HP_FRAC_BW:0] s9;
wire [HP_FRAC_BW:0] s10;
wire [HP_FRAC_BW:0] s11;
wire s12;
wire s13;
wire s14;
wire s15;
wire s16;
wire [21:0] s17;
wire [ALIGN_MSB:0] s18;
wire [ALIGN_MSB:0] s19;
wire [ALIGN_MSB:0] s20;
wire [ALIGN_MSB:0] s21;
wire [ALIGN_MSB:0] s22;
wire [ALIGN_MSB:0] s23;
wire [ALIGN_MSB + 2:MAC_LSB] s24;
wire [EXP_MSB:0] s25;
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
wire s36;
wire s37;
wire s38;
wire s39;
wire s40;
wire s41;
wire [1:0] s42;
wire [EXP_MSB:0] s43;
wire [EXP_MSB:0] s44;
wire [MAC_MSB - 1:MAC_LSB] s45;
wire [21:0] s46;
wire [EXP_MSB:0] s47;
wire s48;
wire s49;
wire [MAC_MSB:MAC_LSB] s50;
reg s51;
reg s52;
reg [MAC_MSB:MAC_LSB] s53;
reg s54;
reg s55;
reg s56;
reg s57;
reg s58;
reg s59;
reg [2:0] s60;
reg [EXP_MSB:0] s61;
reg s62;
wire s63;
wire [MAC_MSB:MAC_LSB] s64;
wire [MAC_MSB:MAC_LSB] s65;
wire [MAC_MSB:MAC_LSB] s66;
wire [MAC_MSB:MAC_LSB] s67;
wire [MAC_MSB:MAC_LSB] s68;
wire [MAC_MSB:MAC_LSB] s69;
wire [MAC_MSB:2] s70;
wire [4:0] s71;
wire [EXP_MSB:0] s72;
wire s73;
wire [4:0] s74;
wire s75;
wire s76;
wire s77;
wire s78;
wire s79;
wire s80;
wire s81;
wire s82;
wire s83;
wire s84;
wire s85;
wire s86;
wire s87;
wire s88;
wire s89;
wire s90;
wire s91;
wire [9:0] s92;
wire s93;
wire s94;
wire s95;
wire s96;
reg s97;
reg s98;
reg s99;
reg s100;
reg s101;
reg s102;
reg s103;
reg s104;
reg [EXP_MSB - 1:0] s105;
reg s106;
reg [HP_FRAC_BW - 1:0] s107;
reg s108;
reg s109;
reg s110;
reg s111;
wire [EXP_MSB:0] s112;
wire s113;
wire [HP_FRAC_BW - 1:0] s114;
wire [15:0] s115;
wire [15:0] s116;
wire s117;
wire s118;
wire s119;
wire s120;
wire s121;
wire s122;
wire s123;
wire s124;
wire s125;
wire s126;
wire s127;
wire [7:0] s128;
wire s129;
wire s130 = f1_op1_data[15];
wire [4:0] s131 = f1_op1_data[14:10];
wire [9:0] s132 = f1_op1_data[9:0];
wire s133 = f1_op2_data[15];
wire [4:0] s134 = f1_op2_data[14:10];
wire [9:0] s135 = f1_op2_data[9:0];
wire s136 = f1_op3_data[15];
wire [4:0] s137 = f1_op3_data[14:10];
wire [9:0] s138 = f1_op3_data[9:0];
wire s139 = f1_op1_data[15];
wire [7:0] s140 = f1_op1_data[14:7];
wire [6:0] s141 = f1_op1_data[6:0];
wire s142 = f1_op2_data[15];
wire [7:0] s143 = f1_op2_data[14:7];
wire [6:0] s144 = f1_op2_data[6:0];
wire s145 = f1_op3_data[15];
wire [7:0] s146 = f1_op3_data[14:7];
wire [6:0] s147 = f1_op3_data[6:0];
wire s148 = f1_fp_mode ? (&s140) : (&s131);
wire s149 = f1_fp_mode ? (&s143) : (&s134);
wire s150 = f1_fp_mode ? (&s146) : (&s137);
wire s151 = f1_fp_mode ? ~(|s140) : ~(|s131);
wire s152 = f1_fp_mode ? ~(|s143) : ~(|s134);
wire s153 = f1_fp_mode ? ~(|s146) : ~(|s137);
wire s154 = f1_fp_mode ? ~(|s141) : ~(|s132);
wire s155 = f1_fp_mode ? ~(|s144) : ~(|s135);
wire s156 = f1_fp_mode ? ~(|s147) : ~(|s138);
wire s157 = f1_fp_mode ? f1_op1_data[6] : f1_op1_data[9];
wire s158 = f1_fp_mode ? f1_op2_data[6] : f1_op2_data[9];
wire s159 = f1_fp_mode ? f1_op3_data[6] : f1_op3_data[9];
wire s160 = s148 & s154;
wire s161 = s149 & s155;
wire s162 = s150 & s156;
wire s163 = (s148 & ~s154);
wire s164 = (s149 & ~s155);
wire s165 = (s150 & ~s156);
wire s166 = s163 & ~s157;
wire s167 = s164 & ~s158;
wire s168 = s165 & ~s159;
wire s169 = s151 & s154;
wire s170 = s152 & s155;
wire s171 = s153 & s156;
assign s1 = f1_fp_mode ? s139 : s130;
assign s2 = f1_fp_mode ? s142 : s133;
assign s3 = f1_fp_mode ? s145 : s136;
assign s4 = s1 ^ s2 ^ (f1_nmadd_instr | f1_nmsub_instr);
assign s5 = s3 ^ (f1_msub_instr | f1_nmadd_instr);
assign s12 = s4 ^ s5;
assign s13 = s160 & ~(s170 | s164) | s161 & ~(s169 | s163);
assign s14 = s169 & ~(s161 | s164) | s170 & ~(s160 | s163);
assign s15 = (s163 | s164) | (s160 & s170) | (s161 & s169);
assign s16 = (s166 | s167) | (s160 & s170) | (s161 & s169);
assign s35 = s14 & s171;
assign s36 = (s13 & ~s165 & ~(s162 & s12)) | (s162 & ~s15 & ~(s13 & s12));
assign s37 = (s15 | s165) | (s13 & s162 & s12);
assign s40 = (s16 | s168) | (s13 & s162 & s12);
assign s38 = (f1_mul_instr & s4) | (s4 & s5) | (s12 & (f1_round_mode == ROUND_RDN));
assign s39 = s162 ? s5 : s4;
assign s48 = s37 ? 1'b0 : s35 ? s38 : s36 ? s39 : s4;
assign s6 = (f1_fp_mode ? s140 : {3'b0,s131}) | {7'b0,s151};
assign s7 = (f1_fp_mode ? s143 : {3'b0,s134}) | {7'b0,s152};
assign s8 = (f1_fp_mode ? s146 : {3'b0,s137}) | {7'b0,s153};
assign s9 = f1_fp_mode ? {~s151,s141,3'b0} : {~s151,s132};
assign s10 = f1_fp_mode ? {~s152,s144,3'b0} : {~s152,s135};
assign s11 = f1_fp_mode ? {~s153,s147,3'b0} : {~s153,s138};
function  [21:0] w21_op2_mul_func;
input [21:0] op1;
input [21:0] op2;
reg [43:22] nds_unused_mul_out;
begin
    {nds_unused_mul_out,w21_op2_mul_func} = op1 * op2;
end
endfunction
assign s17 = w21_op2_mul_func({11'b0,s9}, {11'b0,s10});
assign s41 = s169 | s170;
wire [9:0] s172;
wire [9:0] s173;
assign s172 = {9'b0,~s153};
assign s173 = ({10{~f1_fp_mode}} & 10'b1111111100) | ({10{f1_fp_mode}} & 10'b1110001100);
wire nds_unused_f1_align_amount_adjustment_co;
assign {nds_unused_f1_align_amount_adjustment_co,s0} = s172 + s173;
wire [EXP_MSB + 1:0] s174;
wire [EXP_MSB:0] s175;
wire [EXP_MSB:0] s176;
wire [EXP_MSB:0] s177;
wire [EXP_MSB:0] s178;
wire [EXP_MSB:0] s179;
wire [EXP_MSB:0] s180;
wire [EXP_MSB:0] s181;
wire [EXP_MSB:0] s182;
assign s179 = f1_fp_mode ? {2'b0,s140} : {5'b0,s131};
assign s180 = f1_fp_mode ? {2'b0,s143} : {5'b0,s134};
assign s181 = f1_fp_mode ? ~{2'b0,s146} : ~{5'b0,s137};
assign s182 = s0;
assign s177 = s179 ^ s180 ^ s181;
assign s176 = (s179 & s180) | (s179 & s181) | (s180 & s181);
assign s175 = s177 ^ s182 ^ {s176[EXP_MSB - 1:0],1'b0};
assign s174 = {s175[EXP_MSB],s175};
assign s178 = (s177 & s182) | (s177 & {s176[EXP_MSB - 1:0],1'b0}) | (s182 & {s176[EXP_MSB - 1:0],1'b0});
wire nds_unused_wire = f1_madd_instr;
wire [EXP_MSB:0] s183;
wire [EXP_MSB:0] s184;
wire [EXP_MSB:0] s185;
assign s183 = s174[EXP_MSB:0];
assign s184 = {s178[EXP_MSB - 1:0],s151};
assign s185 = {9'b0,s152};
wire [EXP_MSB:0] s186;
wire nds_unused_f1_abs_amount_tmp_co;
assign {nds_unused_f1_abs_amount_tmp_co,s186} = s183 + s184;
wire nds_unused_f1_abs_amount_co;
assign {nds_unused_f1_abs_amount_co,s25} = s186 + s185;
assign s26 = ~s25[EXP_MSB] & ~s41;
assign s28 = ~s25[EXP_MSB] & (|s25[EXP_MSB - 1:5]) & ~s41;
assign s27 = ~s25[EXP_MSB] & (s25[EXP_MSB - 1:0] > 9'h08) & ~s41;
assign s29 = (s25 == 10'h3ff);
assign s30 = (s25 == 10'h3fe);
wire s187 = s25[EXP_MSB] & (s25[EXP_MSB - 1:0] < 9'h1fe);
wire [9:0] s188;
wire [9:0] s189;
wire [9:0] s190;
assign s188 = {2'b0,s6};
assign s189 = {2'b0,s7};
assign s190 = f1_fp_mode ? 10'b1110000100 : 10'b1111110100;
wire [9:0] s191;
wire nds_unused_f1_mul_exp_tmp_co;
assign {nds_unused_f1_mul_exp_tmp_co,s191} = s188 + s190;
wire nds_unused_f1_mul_exp_co;
assign {nds_unused_f1_mul_exp_co,s43} = s191 + s189;
wire [9:0] s192;
wire [9:0] s193;
wire [9:0] s194;
wire [9:0] s195;
wire nds_unused_f1_acc_exp_tmp_co;
assign s192 = {2'b0,s8};
assign s193 = ({10{s26}} & s25);
assign s194 = 10'd1;
assign {nds_unused_f1_acc_exp_tmp_co,s195} = s192 + s194;
wire nds_unused_f1_acc_exp_co;
assign {nds_unused_f1_acc_exp_co,s44} = s195 + s193;
assign s47 = s27 ? s43 : s44;
assign s18 = ({32{s12}} ^ {s11,{ALIGN_MSB - HP_FRAC_BW{1'b0}}});
assign s19 = s25[0] ? {{1{s12}},s18[ALIGN_MSB:1]} : s18;
assign s20 = s25[1] ? {{2{s12}},s19[ALIGN_MSB:2]} : s19;
assign s21 = s25[2] ? {{4{s12}},s20[ALIGN_MSB:4]} : s20;
assign s22 = s25[3] ? {{8{s12}},s21[ALIGN_MSB:8]} : s21;
assign s23 = s25[4] ? {{16{s12}},s22[ALIGN_MSB:16]} : s22;
assign s42 = s25[4] ? s22[15:14] : {2{s12}};
assign s24 = ({34{~s26}} & {s18,{2{s12}}}) | ({34{s28}} & {34{s12}}) | ({34{s26 & ~s28}} & {s23,s42});
assign s45 = s27 ? s24[(MAC_MSB - 1):MAC_LSB] : {s24[33:13],{4{s12}}};
assign s46 = ({22{s27}} & {s17}) | ({22{s26 & ~s27}} & {9'b0,s17[21],s17[20],s17[19],s17[18:11],2'b0}) | ({22{s29}} & {9'b0,1'b0,s17[21],s17[20],s17[18:11],2'b0}) | ({22{s30}} & {9'b0,1'b0,1'b0,s17[21],s17[18:11],2'b0}) | ({22{s187}} & {9'b0,1'b0,1'b0,1'b0,s17[18:11],2'b0});
assign s32 = (s26 & s25[4] & (|({8{s12}} ^ s22[13:6]))) | (s28 & ~s171);
assign s31 = (s26 & |{s17[10:0]}) | (s29 & |{s17[10:0],s17[19]}) | (s30 & |{s17[10:0],s17[20:19]}) | (s187 & |{s17[10:0],s17[21:19]});
assign s33 = s27 ? s32 : s31;
assign s34 = s12 & ~s32;
wire [MAC_WIDTH:0] s196;
wire [MAC_WIDTH:0] s197;
wire nds_unused_f1_comp_and_mac_sum_tmp_co;
wire [MAC_WIDTH:0] s198;
wire [MAC_WIDTH:0] s199;
wire [MAC_WIDTH:0] s200;
assign s198 = {{(MAC_WIDTH - 23){1'b0}},s46,2'b0};
assign s199 = {{2{s12}},s45};
assign s200 = {{MAC_WIDTH{1'b0}},s34};
assign {nds_unused_f1_comp_and_mac_sum_tmp_co,s197} = s198 + s199;
wire nds_unused_f1_comp_and_mac_sum_co;
assign {nds_unused_f1_comp_and_mac_sum_co,s196} = s197 + s200;
assign {s49,s50} = s196;
assign s63 = s59 ^ s52;
assign s70 = s64[MAC_MSB:2];
kv_lzc_encode #(
    .WIDTH(32)
) lzc_encode_pos (
    .lza_str({s70,{(32 - MAC_WIDTH + 2){1'b1}}}),
    .lzc(s71)
);
wire nds_unused_f2_lzc_to_subnorm_co;
assign {nds_unused_f2_lzc_to_subnorm_co,s72} = s61 + 10'h3ff;
assign s73 = {5'b0,s71} > s72;
assign s74 = s73 ? s72[4:0] : s71;
wire [9:0] s201 = {5'b0,s71};
wire [9:0] s202;
wire nds_unused_f3_mac_exp_nx_sel_op2_co;
assign {nds_unused_f3_mac_exp_nx_sel_op2_co,s202} = s61 - s201;
assign s112 = (s73 | s95) ? 10'b0 : s202;
assign s64 = s52 ? ~s53 : s53;
assign s65 = s74[4] ? {s64[(MAC_MSB - 16):MAC_LSB],{16{s52}}} : s64;
assign s66 = s74[3] ? {s65[(MAC_MSB - 8):MAC_LSB],{8{s52}}} : s65;
assign s67 = s74[2] ? {s66[(MAC_MSB - 4):MAC_LSB],{4{s52}}} : s66;
assign s68 = s74[1] ? {s67[(MAC_MSB - 2):MAC_LSB],{2{s52}}} : s67;
assign s69 = s74[0] ? {s68[(MAC_MSB - 1):MAC_LSB],{1{s52}}} : s68;
assign s75 = (s60 == ROUND_RNE);
assign s79 = (s60 == ROUND_RTZ);
assign s77 = (s60 == ROUND_RDN);
assign s78 = (s60 == ROUND_RUP);
assign s76 = (s60 == ROUND_RMM);
assign s81 = s75 | s76;
assign s80 = (~s63 & s78) | (s63 & s77);
assign s82 = s79 | (~s63 & s77) | (s63 & s78);
assign s87 = s51 ? &{s69[MAC_MSB - 10:MAC_LSB],~s62} & s52 : &{s69[MAC_MSB - 13:MAC_LSB],~s62} & s52;
wire [2:0] s203;
wire [2:0] s204;
wire [2:0] s205;
assign s204 = s51 ? s69[(MAC_MSB - 7):(MAC_MSB - 9)] : s69[(MAC_MSB - 10):(MAC_MSB - 12)];
assign s205 = {2'b0,s87};
wire nds_unused_f2_lsb_round_bit_sticky_msb_co;
assign {nds_unused_f2_lsb_round_bit_sticky_msb_co,s203} = s204 + s205;
assign {s83,s84,s86} = s203;
wire s206 = s52 ? ~&{s69[(MAC_MSB - 12):MAC_LSB],~s62} : |{s69[(MAC_MSB - 12):MAC_LSB],s62};
wire s207 = s52 ? ~&{s69[(MAC_MSB - 9):MAC_LSB],~s62} : |{s69[(MAC_MSB - 9):MAC_LSB],s62};
assign s85 = s51 ? s207 : s206;
assign s89 = (s80 & s88) | (s75 & s84 & (s83 | s85)) | (s76 & s84) | (s51 & s69[MAC_MSB - 8] & s69[MAC_MSB - 9] & s87) | (~s51 & s69[MAC_MSB - 11] & s69[MAC_MSB - 12] & s87);
assign s93 = ~s69[MAC_MSB];
assign s92 = s69[(MAC_MSB - 1) -:10];
assign s88 = s84 | s85;
assign s95 = s52 ? &{s64,~s62} : ~|{s64,s62};
assign s94 = s56 | s58 | s57;
assign s96 = s94 ? s59 : s95 ? s77 : s63;
assign s90 = s51 ? &{s92[9:3],s89} : &{s92[9:0],s89};
assign s91 = s84 & ((s80 & s85) | (s81 & s86));
wire [9:0] s208 = s111 ? {6'b0,s108,3'b0} : {9'b0,s108};
wire nds_unused_f3_frac_final_co;
assign {nds_unused_f3_frac_final_co,s114} = s107 + s208;
wire [7:0] s209 = {7'b0,s110};
wire nds_unused_f3_exp_final_co;
assign {nds_unused_f3_exp_final_co,s128} = s105[7:0] + s209;
assign s115 = s111 ? {s103,s128[7:0],s114[9:3]} : {s103,s128[4:0],s114[9:0]};
assign s119 = s111 ? (s105[(EXP_MSB - 1):0] > 9'd254) : (s105[(EXP_MSB - 1):0] > 9'd30);
assign s120 = s111 ? (s105[(EXP_MSB - 1):0] > 9'd253) : (s105[(EXP_MSB - 1):0] > 9'd29);
assign s118 = s119 | (s110 & s120);
assign s127 = s98 | s100 | s99;
assign s121 = ~s127 & s118;
assign s123 = s106 & s110;
assign s129 = s123 & s104 & ~s109;
assign s122 = (s106 & ~s123 & s104) | s129;
assign s113 = ~s127 & (s104 | s121);
assign s124 = s99;
assign s125 = s98 | (s121 & ~s101);
assign s126 = s121 & s101;
assign s116 = ({16{~s111 & s100}} & {s103,5'h1f,10'h200}) | ({16{~s111 & s125}} & {s103,5'h1f,10'h0}) | ({16{~s111 & s124}} & {s103,5'h00,10'h0}) | ({16{~s111 & s126}} & {s103,5'h1e,10'h3ff}) | ({16{s111 & s100}} & {s103,8'hff,7'h40}) | ({16{s111 & s125}} & {s103,8'hff,7'h0}) | ({16{s111 & s124}} & {s103,8'h00,7'h0}) | ({16{s111 & s126}} & {s103,8'hfe,7'h7f});
assign s117 = s125 | s124 | s100 | s126;
assign f3_flag_set = {5{s97}} & {s102,1'b0,s121,s122,s113};
assign f3_wdata = s117 ? s116 : s115;
assign f3_wdata_en = s97;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s54 <= 1'b0;
        s97 <= 1'b0;
    end
    else if (~fpipe_stall) begin
        s54 <= f1_valid;
        s97 <= s54;
    end
end

always @(posedge vpu_vmac_clk) begin
    if (f1_valid & ~fpipe_stall) begin
        s56 <= s36;
        s57 <= s35;
        s58 <= s37;
        s55 <= s40;
        s60 <= f1_round_mode;
        s62 <= s33;
        s59 <= s48;
        s61 <= s47;
        s53 <= s50;
        s52 <= s49;
        s51 <= f1_fp_mode;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s98 <= 1'b0;
        s99 <= 1'b0;
        s100 <= 1'b0;
        s102 <= 1'b0;
        s101 <= 1'b0;
        s108 <= 1'b0;
        s104 <= 1'b0;
        s103 <= 1'b0;
        s105 <= 9'b0;
        s106 <= 1'b0;
        s107 <= 10'b0;
        s109 <= 1'b0;
        s110 <= 1'b0;
        s111 <= 1'b0;
    end
    else if (s54 & ~fpipe_stall) begin
        s98 <= s56;
        s99 <= s57;
        s100 <= s58;
        s102 <= s55;
        s101 <= s82;
        s108 <= s89;
        s104 <= s88;
        s103 <= s96;
        s105 <= s112[EXP_MSB - 1:0];
        s106 <= s93;
        s107 <= s92;
        s109 <= s91;
        s110 <= s90;
        s111 <= s51;
    end
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

