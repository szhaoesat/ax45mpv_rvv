// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_valu_lane (
    clk,
    rstn,
    valu_mask_byte8,
    valu_nrr_mask_byte8,
    valu_ci_byte8,
    valu_ve1_veq_scalar_op,
    valu_ve1_veq_nrr_scalar_op,
    valu_ve1_veq_ctrl,
    valu_ve1_veq_vxrm,
    valu_ve1_vs2_red_non_ext,
    valu_vs1_src,
    valu_vs2_src,
    valu_vs2_wsrc,
    valu_vs1_wsrc,
    valu_data64,
    valu_data32,
    valu_data64_red,
    valu_mresult,
    vxsat_set
);
parameter XLEN = 64;
parameter ELEN = 64;
parameter ID = 0;
input clk;
input rstn;
input [7:0] valu_mask_byte8;
input [7:0] valu_nrr_mask_byte8;
input [7:0] valu_ci_byte8;
input [XLEN - 1:0] valu_ve1_veq_scalar_op;
input [XLEN - 1:0] valu_ve1_veq_nrr_scalar_op;
input [58 - 1:0] valu_ve1_veq_ctrl;
input [1:0] valu_ve1_veq_vxrm;
input valu_ve1_vs2_red_non_ext;
input [63:0] valu_vs1_src;
input [63:0] valu_vs2_src;
input [31:0] valu_vs2_wsrc;
input [31:0] valu_vs1_wsrc;
output [63:0] valu_data64;
output [31:0] valu_data32;
output [63:0] valu_data64_red;
output [7:0] valu_mresult;
output vxsat_set;





// 8f298cf6 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [3:0] s0;
wire [1:0] s1;
wire [2:0] s2;
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
wire nds_unused_valu_ve1_narrow;
wire s19;
wire s20;
wire s21;
assign s0 = valu_ve1_veq_ctrl[15 +:4];
assign s1 = valu_ve1_veq_vxrm;
assign s2 = valu_ve1_veq_ctrl[5 +:3];
assign s3 = valu_ve1_veq_ctrl[57];
assign s4 = valu_ve1_veq_ctrl[21];
assign s5 = valu_ve1_veq_ctrl[20];
assign s6 = valu_ve1_veq_ctrl[3];
assign s7 = valu_ve1_veq_ctrl[8];
assign s8 = valu_ve1_veq_ctrl[14];
assign s9 = valu_ve1_veq_ctrl[23];
assign s10 = valu_ve1_veq_ctrl[1];
assign s11 = valu_ve1_veq_ctrl[0];
assign s12 = valu_ve1_veq_ctrl[22];
assign s13 = valu_ve1_veq_ctrl[13];
assign s14 = valu_ve1_veq_ctrl[2];
assign nds_unused_valu_ve1_narrow = valu_ve1_veq_ctrl[10];
assign s15 = s3;
assign s16 = valu_ve1_veq_ctrl[45];
assign s17 = valu_ve1_veq_ctrl[11];
assign s18 = valu_ve1_veq_ctrl[46];
assign s21 = valu_ve1_veq_ctrl[39];
assign s19 = valu_ve1_veq_ctrl[19];
assign s20 = valu_ve1_veq_ctrl[12];
wire s22 = (s2[1:0] == 2'b00);
wire s23 = (s2[1:0] == 2'b01);
wire s24 = (s2[1:0] == 2'b10);
wire s25 = (s2[1:0] == 2'b00);
wire s26 = (s2[1:0] == 2'b01);
wire s27 = s2[1];
wire [3:0] nds_unused_valu_vd_sew = valu_ve1_veq_ctrl[24 +:4] & {(ELEN == 64),3'b111};
wire [63:0] s28;
wire [63:0] s29;
wire [7:0] s30;
wire [63:0] s31;
wire [7:0] s32;
wire [63:0] s33;
wire [31:0] s34;
wire [63:0] s35;
wire [7:0] s36;
wire s37 = s19;
wire s38 = s5;
wire s39 = s6;
wire s40 = s7;
wire s41 = s8;
wire s42 = s4;
wire s43 = s15 & ~s20;
wire s44 = s16 & ~valu_ve1_vs2_red_non_ext;
wire s45 = s3;
wire s46 = s17;
wire s47 = s3;
wire [1:0] s48 = s1;
wire [2:0] s49 = s2;
wire [3:0] s50 = s0;
wire [3:0] s51 = {s0[2:0],1'b0};
wire [3:0] s52 = s47 ? s51 : s50;
wire s53 = s18;
wire [63:0] s54;
wire [63:0] nds_unused_ve1_nrr_scalar_op;
generate
    if (XLEN == 32) begin:gen_scalar_op_xlen32
        assign s54 = {32'b0,valu_ve1_veq_scalar_op};
        assign nds_unused_ve1_nrr_scalar_op = {32'b0,valu_ve1_veq_nrr_scalar_op};
    end
    else begin:gen_scalar_op_xlen64
        assign s54 = valu_ve1_veq_scalar_op;
        assign nds_unused_ve1_nrr_scalar_op = valu_ve1_veq_nrr_scalar_op;
    end
endgenerate
wire s55 = s9;
wire s56 = s38 & s47;
wire s57;
wire [63:0] s58;
wire [63:0] s59;
wire [63:0] s60;
wire [63:0] s61;
wire [63:0] s62;
wire [63:0] s63;
wire [63:0] s64;
wire [63:0] s65;
wire [63:0] s66;
wire [63:0] s67;
wire [63:0] s68;
wire [63:0] s69;
wire [63:0] s70;
assign s67 = {32'b0,valu_vs1_wsrc};
assign s68 = {32'b0,valu_vs2_wsrc};
assign s69 = ({64{s52[0]}} & {8{s54[7:0]}}) | ({64{s52[1]}} & {4{s54[15:0]}}) | ({64{s52[2]}} & {2{s54[31:0]}}) | ({64{s52[3]}} & {64 / XLEN{s54[XLEN - 1:0]}});
wire [63:0] s71;
wire [63:0] s72;
wire [63:0] s73;
wire [63:0] s74;
wire [63:0] s75;
wire [63:0] s76;
assign s71[15:0] = {{8{s67[7]}},s67[7:0]};
assign s71[31:16] = {{8{s67[15]}},s67[15:8]};
assign s71[47:32] = {{8{s67[23]}},s67[23:16]};
assign s71[63:48] = {{8{s67[31]}},s67[31:24]};
assign s72[15:0] = {8'b0,s67[7:0]};
assign s72[31:16] = {8'b0,s67[15:8]};
assign s72[47:32] = {8'b0,s67[23:16]};
assign s72[63:48] = {8'b0,s67[31:24]};
assign s73[31:0] = {{16{s67[15]}},s67[15:0]};
assign s73[63:32] = {{16{s67[31]}},s67[31:16]};
assign s74[31:0] = {16'b0,s67[15:0]};
assign s74[63:32] = {16'b0,s67[31:16]};
assign s75 = {{32{s67[31]}},s67[31:0]};
assign s76 = {32'b0,s67[31:0]};
assign s59 = ({64{s0[0] & s42}} & s71) | ({64{s0[0] & ~s42}} & s72) | ({64{s0[1] & s42}} & s73) | ({64{s0[1] & ~s42}} & s74) | ({64{s0[2] & s42}} & s75) | ({64{s0[2] & ~s42}} & s76);
assign s60 = ({64{s0[0] & s45 & s42}} & {4{{8{s54[7]}},s54[7:0]}}) | ({64{s0[1] & s45 & s42}} & {2{{16{s54[15]}},s54[15:0]}}) | ({64{s0[2] & s45 & s42}} & {1{{32{s54[31]}},s54[31:0]}}) | ({64{s0[0] & s45 & ~s42}} & {4{8'b0,s54[7:0]}}) | ({64{s0[1] & s45 & ~s42}} & {2{16'b0,s54[15:0]}}) | ({64{s0[2] & s45 & ~s42}} & {1{32'b0,s54[31:0]}}) | ({64{~s45}} & s69);
wire [63:0] s77;
wire [63:0] s78;
wire [63:0] s79;
wire [63:0] s80;
wire [63:0] s81;
wire [63:0] s82;
assign s77[15:0] = {{8{s68[7]}},s68[7:0]};
assign s77[31:16] = {{8{s68[15]}},s68[15:8]};
assign s77[47:32] = {{8{s68[23]}},s68[23:16]};
assign s77[63:48] = {{8{s68[31]}},s68[31:24]};
assign s78[15:0] = {8'b0,s68[7:0]};
assign s78[31:16] = {8'b0,s68[15:8]};
assign s78[47:32] = {8'b0,s68[23:16]};
assign s78[63:48] = {8'b0,s68[31:24]};
assign s79[31:0] = {{16{s68[15]}},s68[15:0]};
assign s79[63:32] = {{16{s68[31]}},s68[31:16]};
assign s80[31:0] = {16'b0,s68[15:0]};
assign s80[63:32] = {16'b0,s68[31:16]};
assign s81 = {{32{s68[31]}},s68[31:0]};
assign s82 = {32'b0,s68[31:0]};
assign s61 = ({64{s0[0] & s42}} & s77) | ({64{s0[0] & ~s42}} & s78) | ({64{s0[1] & s42}} & s79) | ({64{s0[1] & ~s42}} & s80) | ({64{s0[2] & s42}} & s81) | ({64{s0[2] & ~s42}} & s82);
assign s58 = s43 ? s59 : valu_vs1_src;
assign s66 = s46 ? s69 : valu_vs1_src;
assign s65 = valu_vs2_src;
assign s63 = s46 ? s60 : s58;
assign s62 = s44 ? s61 : {64{s53}} & valu_vs2_src;
assign s70 = ({64{s52[0]}} & {8{s54[7:0]}}) | ({64{s52[1]}} & {4{s54[15:0]}}) | ({64{s52[2]}} & {2{s54[31:0]}}) | ({64{s52[3]}} & {64 / XLEN{s54[XLEN - 1:0]}});
assign s64 = ({64{s46}} & s70) | ({64{~s46}} & s58);
wire [63:0] s83 = s65;
wire [63:0] s84 = s66;
wire s85 = s22;
wire s86 = s23;
wire s87 = s24;
assign s28 = ({64{s85}} & (s83 & s84)) | ({64{s86}} & (s83 | s84)) | ({64{s87}} & (s83 ^ s84));
wire [7:0] s88;
wire [7:0] nds_unused_shifter_sat_set;
wire [31:0] nds_unused_shift_narrow_result;
wire [63:0] nds_unused_shift_result;
kv_valu_shifter valu_shifter(
    .vxrm(s48),
    .narrow(1'b0),
    .shift_l(s37),
    .ctrl(s49),
    .sign(s42),
    .ssew(s50),
    .src1(s65),
    .src2(s64),
    .sat_set(nds_unused_shifter_sat_set),
    .result_narrow(nds_unused_shift_narrow_result),
    .result(s29)
);
kv_valu_shifter valu_shifter_nrr(
    .vxrm(s48),
    .narrow(1'b1),
    .shift_l(1'b0),
    .ctrl(s49),
    .sign(s42),
    .ssew(s51),
    .src1(s65),
    .src2(s64),
    .sat_set(s88),
    .result_narrow(s34),
    .result(nds_unused_shift_result)
);
wire [7:0] s89 = valu_ci_byte8;
wire s90 = s10;
wire s91 = s11;
wire s92 = s12;
wire s93 = s14;
wire s94 = s25;
wire s95 = s26;
wire s96 = s27;
wire s97 = (s49[2:0] == 3'b000);
wire s98 = (s49[2:0] == 3'b001);
wire s99 = (s49[2:0] == 3'b010);
wire s100 = (s49[2:0] == 3'b011);
wire s101 = (s49[2:0] == 3'b100);
wire s102 = s21;
wire [7:0] s103;
wire [7:0] s104;
wire [7:0] s105;
wire [7:0] s106;
wire [7:0] s107;
wire [7:0] s108;
wire [7:0] s109;
wire [7:0] s110;
wire [7:0] s111;
assign s104 = {8{s92}};
assign s105 = {s62[56],s62[48],s62[40],s62[32],s62[24],s62[16],s62[8],s62[0]};
assign s106 = {s63[56],s63[48],s63[40],s63[32],s63[24],s63[16],s63[8],s63[0]} ^ s104;
assign s107 = (s104 & s105) | (s104 & s106) | (s105 & s106);
assign s108 = {s62[57],s62[49],s62[41],s62[33],s62[25],s62[17],s62[9],s62[1]};
assign s109 = {s63[57],s63[49],s63[41],s63[33],s63[25],s63[17],s63[9],s63[1]} ^ s104;
assign s110 = s105 ^ s106 ^ s104;
assign s111 = s108 ^ s109 ^ s107;
assign s103 = ({8{s48 == 2'b00}} & s110) | ({8{s48 == 2'b01}} & s110 & s111) | ({8{s48 == 2'b11}} & s110 & ~s111);
wire [7:0] s112 = {8{s92}};
wire s113 = s13;
wire [3:0] s114 = s52;
wire [63:0] s115 = s62;
wire [63:0] s116 = s63;
wire [63:0] s117 = s65;
wire [63:0] s118 = s66;
wire [7:0] s119 = s89 & {8{s90 & ~s102}};
wire [7:0] s120 = s103 & {8{s91}};
wire [7:0] s121;
wire [7:0] s122;
wire [7:0] s123;
wire [63:0] s124;
wire [7:0] s125;
wire [7:0] s126;
kv_valu_adder71 u_kv_valu_adder71(
    .sub(s112),
    .rev(s113),
    .sign(s42),
    .ssew(s114),
    .src1(s115),
    .src2(s116),
    .src1_ori(s117),
    .src2_ori(s118),
    .ci(s119),
    .rup(s120),
    .ovf(s121),
    .neg(s122),
    .zero(s123),
    .sum(s124),
    .uco(s125),
    .co(s126)
);
assign s30 = s125;
wire [7:0] s127;
assign s127[0] = (s52[1] & s93 & s121[1]) | (s52[0] & s93 & s121[0]);
assign s127[1] = (s52[2] & s93 & s121[3]) | (s52[0] & s93 & s121[1]);
assign s127[2] = (s52[1] & s93 & s121[3]) | (s52[0] & s93 & s121[2]);
assign s127[3] = (s52[3] & s93 & s121[7]) | (s52[0] & s93 & s121[3]);
assign s127[4] = (s52[1] & s93 & s121[5]) | (s52[0] & s93 & s121[4]);
assign s127[5] = (s52[2] & s93 & s121[7]) | (s52[0] & s93 & s121[5]);
assign s127[6] = (s52[1] & s93 & s121[7]) | (s52[0] & s93 & s121[6]);
assign s127[7] = s52[0] & s93 & s121[7];
wire [63:0] s128;
wire [63:0] s129;
wire [63:0] s130;
wire [63:0] s131;
wire [7:0] s132;
wire [7:0] s133;
assign s133 = {8{~s91}} & ({8{~s93}} | ~s121);
assign s132 = {s115[63],s115[55],s115[47],s115[39],s115[31],s115[23],s115[15],s115[7]};
assign s128[0 * 8 +:8] = ({8{s42 & s93 & s121[0]}} & {{s132[0]},{7{~s132[0]}}}) | ({8{~s42 & s93 & s121[0]}} & {8{~s92}}) | ({8{s91}} & {s126[0],s124[(0 * 8 + 1) +:7]}) | ({8{s133[0]}} & s124[0 * 8 +:8]);
assign s128[1 * 8 +:8] = ({8{s42 & s93 & s121[1]}} & {{s132[1]},{7{~s132[1]}}}) | ({8{~s42 & s93 & s121[1]}} & {8{~s92}}) | ({8{s91}} & {s126[1],s124[(1 * 8 + 1) +:7]}) | ({8{s133[1]}} & s124[1 * 8 +:8]);
assign s128[2 * 8 +:8] = ({8{s42 & s93 & s121[2]}} & {{s132[2]},{7{~s132[2]}}}) | ({8{~s42 & s93 & s121[2]}} & {8{~s92}}) | ({8{s91}} & {s126[2],s124[(2 * 8 + 1) +:7]}) | ({8{s133[2]}} & s124[2 * 8 +:8]);
assign s128[3 * 8 +:8] = ({8{s42 & s93 & s121[3]}} & {{s132[3]},{7{~s132[3]}}}) | ({8{~s42 & s93 & s121[3]}} & {8{~s92}}) | ({8{s91}} & {s126[3],s124[(3 * 8 + 1) +:7]}) | ({8{s133[3]}} & s124[3 * 8 +:8]);
assign s128[4 * 8 +:8] = ({8{s42 & s93 & s121[4]}} & {{s132[4]},{7{~s132[4]}}}) | ({8{~s42 & s93 & s121[4]}} & {8{~s92}}) | ({8{s91}} & {s126[4],s124[(4 * 8 + 1) +:7]}) | ({8{s133[4]}} & s124[4 * 8 +:8]);
assign s128[5 * 8 +:8] = ({8{s42 & s93 & s121[5]}} & {{s132[5]},{7{~s132[5]}}}) | ({8{~s42 & s93 & s121[5]}} & {8{~s92}}) | ({8{s91}} & {s126[5],s124[(5 * 8 + 1) +:7]}) | ({8{s133[5]}} & s124[5 * 8 +:8]);
assign s128[6 * 8 +:8] = ({8{s42 & s93 & s121[6]}} & {{s132[6]},{7{~s132[6]}}}) | ({8{~s42 & s93 & s121[6]}} & {8{~s92}}) | ({8{s91}} & {s126[6],s124[(6 * 8 + 1) +:7]}) | ({8{s133[6]}} & s124[6 * 8 +:8]);
assign s128[7 * 8 +:8] = ({8{s42 & s93 & s121[7]}} & {{s132[7]},{7{~s132[7]}}}) | ({8{~s42 & s93 & s121[7]}} & {8{~s92}}) | ({8{s91}} & {s126[7],s124[(7 * 8 + 1) +:7]}) | ({8{s133[7]}} & s124[7 * 8 +:8]);
assign s129[0 * 16 +:16] = ({16{s42 & s93 & s121[0 * 2 + 1]}} & {{s132[0 * 2 + 1]},{15{~s132[0 * 2 + 1]}}}) | ({16{~s42 & s93 & s121[0 * 2 + 1]}} & {16{~s92}}) | ({16{s91}} & {s126[0 * 2 + 1],s124[(16 * 0 + 1) +:16 - 1]}) | ({16{s133[0 * 2 + 1]}} & s124[(16 * 0) +:16]);
assign s129[1 * 16 +:16] = ({16{s42 & s93 & s121[1 * 2 + 1]}} & {{s132[1 * 2 + 1]},{15{~s132[1 * 2 + 1]}}}) | ({16{~s42 & s93 & s121[1 * 2 + 1]}} & {16{~s92}}) | ({16{s91}} & {s126[1 * 2 + 1],s124[(16 * 1 + 1) +:16 - 1]}) | ({16{s133[1 * 2 + 1]}} & s124[(16 * 1) +:16]);
assign s129[2 * 16 +:16] = ({16{s42 & s93 & s121[2 * 2 + 1]}} & {{s132[2 * 2 + 1]},{15{~s132[2 * 2 + 1]}}}) | ({16{~s42 & s93 & s121[2 * 2 + 1]}} & {16{~s92}}) | ({16{s91}} & {s126[2 * 2 + 1],s124[(16 * 2 + 1) +:16 - 1]}) | ({16{s133[2 * 2 + 1]}} & s124[(16 * 2) +:16]);
assign s129[3 * 16 +:16] = ({16{s42 & s93 & s121[3 * 2 + 1]}} & {{s132[3 * 2 + 1]},{15{~s132[3 * 2 + 1]}}}) | ({16{~s42 & s93 & s121[3 * 2 + 1]}} & {16{~s92}}) | ({16{s91}} & {s126[3 * 2 + 1],s124[(16 * 3 + 1) +:16 - 1]}) | ({16{s133[3 * 2 + 1]}} & s124[(16 * 3) +:16]);
assign s130[0 * 32 +:32] = ({32{s42 & s93 & s121[0 * 4 + 3]}} & {{s132[0 * 4 + 3]},{31{~s132[0 * 4 + 3]}}}) | ({32{~s42 & s93 & s121[0 * 4 + 3]}} & {32{~s92}}) | ({32{s91}} & {s126[0 * 4 + 3],s124[(32 * 0 + 1) +:32 - 1]}) | ({32{s133[0 * 4 + 3]}} & s124[(32 * 0) +:32]);
assign s130[1 * 32 +:32] = ({32{s42 & s93 & s121[1 * 4 + 3]}} & {{s132[1 * 4 + 3]},{31{~s132[1 * 4 + 3]}}}) | ({32{~s42 & s93 & s121[1 * 4 + 3]}} & {32{~s92}}) | ({32{s91}} & {s126[1 * 4 + 3],s124[(32 * 1 + 1) +:32 - 1]}) | ({32{s133[1 * 4 + 3]}} & s124[(32 * 1) +:32]);
assign s131 = ({64{s42 & s93 & s121[7]}} & {{s132[7]},{63{~s132[7]}}}) | ({64{~s42 & s93 & s121[7]}} & {64{~s92}}) | ({64{s91}} & {s126[7],s124[63:1]}) | ({64{s133[7]}} & s124[63:0]);
assign s31 = ({64{s52[0]}} & s128) | ({64{s52[1]}} & s129) | ({64{s52[2]}} & s130) | ({64{s52[3]}} & s131);
assign s32 = ({8{s97}} & s123) | ({8{s98}} & ~s123) | ({8{s99}} & s122) | ({8{s100}} & s123) | ({8{s100}} & s122) | ({8{s101}} & ~s123 & ~s122);
wire [7:0] s134 = valu_mask_byte8 | {8{(&s49[1:0])}};
wire [7:0] s135;
wire [7:0] s136;
wire [7:0] s137;
wire [7:0] s138;
wire [7:0] s139;
assign s137 = ({8{s52[3]}} & {8{~s134[7]}}) | ({8{s52[2]}} & {{4{~s134[7]}},{4{~s134[3]}}}) | ({8{s52[1]}} & {{2{~s134[7]}},{2{~s134[5]}},{2{~s134[3]}},{2{~s134[1]}}}) | ({8{s52[0]}} & (~s134[7:0]));
assign s138 = ({8{s52[3]}} & {8{s122[7]}}) | ({8{s52[2]}} & {{4{s122[7]}},{4{s122[3]}}}) | ({8{s52[1]}} & {{2{s122[7]}},{2{s122[5]}},{2{s122[3]}},{2{s122[1]}}}) | ({8{s52[0]}} & s122[7:0]);
assign s139 = ({8{s52[3]}} & {8{~s122[7]}}) | ({8{s52[2]}} & {{4{~s122[7]}},{4{~s122[3]}}}) | ({8{s52[1]}} & {{2{~s122[7]}},{2{~s122[5]}},{2{~s122[3]}},{2{~s122[1]}}}) | ({8{s52[0]}} & (~s122[7:0]));
assign s135 = ({8{s96}} & s137) | ({8{s94}} & s138) | ({8{s95}} & s139);
assign s136 = ~s135;
assign s33[7:0] = ({8{s135[0]}} & s65[7:0]) | ({8{s136[0]}} & s66[7:0]);
assign s33[15:8] = ({8{s135[1]}} & s65[15:8]) | ({8{s136[1]}} & s66[15:8]);
assign s33[23:16] = ({8{s135[2]}} & s65[23:16]) | ({8{s136[2]}} & s66[23:16]);
assign s33[31:24] = ({8{s135[3]}} & s65[31:24]) | ({8{s136[3]}} & s66[31:24]);
assign s33[39:32] = ({8{s135[4]}} & s65[39:32]) | ({8{s136[4]}} & s66[39:32]);
assign s33[47:40] = ({8{s135[5]}} & s65[47:40]) | ({8{s136[5]}} & s66[47:40]);
assign s33[55:48] = ({8{s135[6]}} & s65[55:48]) | ({8{s136[6]}} & s66[55:48]);
assign s33[63:56] = ({8{s135[7]}} & s65[63:56]) | ({8{s136[7]}} & s66[63:56]);
assign s35 = ({64{s38}} & s29) | ({64{s55}} & s31) | ({64{s40}} & s28) | ({64{s41}} & s33);
assign s36 = ({8{s39}} & {s32}) | ({8{s90}} & {s30});
wire [63:0] nds_unused_bit_mask;
assign nds_unused_bit_mask = {{8{valu_mask_byte8[7]}},{8{valu_mask_byte8[6]}},{8{valu_mask_byte8[5]}},{8{valu_mask_byte8[4]}},{8{valu_mask_byte8[3]}},{8{valu_mask_byte8[2]}},{8{valu_mask_byte8[1]}},{8{valu_mask_byte8[0]}}};
assign s57 = ((&valu_mask_byte8) & s127[3] & s93 & (ELEN == 64)) | ((&valu_mask_byte8[3:0]) & s127[1] & s93) | ((&valu_mask_byte8[7:4]) & s127[5] & s93) | ((&valu_mask_byte8[1:0]) & s127[0] & s93) | ((&valu_mask_byte8[3:2]) & s127[2] & s93) | ((&valu_mask_byte8[5:4]) & s127[4] & s93) | ((&valu_mask_byte8[7:6]) & s127[6] & s93) | ((|(valu_mask_byte8 & s127)) & s93) | ((&valu_nrr_mask_byte8) & s88[3] & s38 & s56 & (ELEN == 64)) | ((&valu_nrr_mask_byte8[3:0]) & s88[1] & s38 & s56) | ((&valu_nrr_mask_byte8[7:4]) & s88[5] & s38 & s56) | ((&valu_nrr_mask_byte8[1:0]) & s88[0] & s38 & s56) | ((&valu_nrr_mask_byte8[3:2]) & s88[2] & s38 & s56) | ((&valu_nrr_mask_byte8[5:4]) & s88[4] & s38 & s56) | ((&valu_nrr_mask_byte8[7:6]) & s88[6] & s38 & s56);
assign vxsat_set = s57;
wire [63:0] s140;
assign s140 = ({64{s55}} & s124) | ({64{s40}} & s28) | ({64{s41}} & s33);
assign valu_data64_red = s140;
assign valu_data64 = s35;
assign valu_data32 = s34;
assign valu_mresult = s36;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

