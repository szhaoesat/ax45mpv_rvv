// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vpermut_pu (
    vmv_fxs,
    vmv_fs,
    vmv_nr,
    sew_onehot,
    vzsext,
    vsext,
    eew4x2,
    eew4x4,
    eew4x8,
    eew8x2,
    eew8x4,
    eew8x8,
    eew16x2,
    eew16x4,
    eew32x2,
    vs2_buf,
    idx,
    body_mask,
    op1_sel,
    op1_mask,
    op1,
    result0,
    result1
);
parameter VLEN = 512;
parameter DLEN = 512;
parameter VP_LEN = 512;
localparam SW = (VLEN == 128) ? 4 : (VLEN == 256) ? 5 : (VLEN == 512) ? 6 : 7;
input vmv_fxs;
input vmv_fs;
input vmv_nr;
input [3:0] sew_onehot;
input vzsext;
input vsext;
input eew4x2;
input eew4x4;
input eew4x8;
input eew8x2;
input eew8x4;
input eew8x8;
input eew16x2;
input eew16x4;
input eew32x2;
input [8 * VLEN - 1:0] vs2_buf;
input [VP_LEN / 8 * SW - 1:0] idx;
input [VP_LEN / 8 - 1:0] body_mask;
input [1:0] op1_sel;
input [VP_LEN / 8 - 1:0] op1_mask;
input [63:0] op1;
output [VP_LEN - 1:0] result0;
output [VP_LEN - 1:0] result1;





// 906a7082 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [VP_LEN - 1:0] s0;
wire s1 = vzsext & eew4x2;
wire s2 = vzsext & eew4x4;
wire s3 = vzsext & eew4x8;
wire s4 = vsext & eew4x2;
wire s5 = vsext & eew4x4;
wire s6 = vsext & eew4x8;
wire s7 = vsext & eew8x2;
wire s8 = vsext & eew8x4;
wire s9 = vsext & eew8x8;
wire s10 = vsext & eew16x2;
wire s11 = vsext & eew16x4;
wire s12 = vsext & eew32x2;
wire [DLEN - 1:0] s13;
wire [DLEN - 1:0] s14;
wire [DLEN - 1:0] s15;
wire [VP_LEN / 8 - 1:0] s16;
wire [VP_LEN / 8 - 1:0] s17;
wire [VP_LEN / 8 - 1:0] s18;
wire [VP_LEN / 8 - 1:0] s19;
wire [VP_LEN / 8 - 1:0] s20;
wire [VP_LEN / 8 - 1:0] s21;
wire [VP_LEN / 8 - 1:0] s22;
wire [VP_LEN / 8 - 1:0] s23;
wire [VP_LEN / 8 - 1:0] s24;
wire [VP_LEN / 8 - 1:0] s25;
wire [VP_LEN / 8 - 1:0] s26;
wire [VP_LEN / 8 - 1:0] s27;
wire [VP_LEN / 8 - 1:0] s28 = ({(VP_LEN / 8){s7}} & s16) | ({(VP_LEN / 8){s8}} & s17) | ({(VP_LEN / 8){s9}} & s18) | ({(VP_LEN / 8){s10}} & s19) | ({(VP_LEN / 8){s11}} & s20) | ({(VP_LEN / 8){s12}} & s21) | ({(VP_LEN / 8){vmv_fxs}} & (({(VP_LEN / 8){sew_onehot[0]}} & s22) | ({(VP_LEN / 8){sew_onehot[1]}} & s23) | ({(VP_LEN / 8){sew_onehot[2]}} & s24))) | ({(VP_LEN / 8){vmv_fs}} & (({(VP_LEN / 8){sew_onehot[0]}} & s25) | ({(VP_LEN / 8){sew_onehot[1]}} & s26) | ({(VP_LEN / 8){sew_onehot[2]}} & s27)));
wire [VP_LEN / 8 - 1:0] s29 = (vmv_fxs & ~sew_onehot[3]) ? (({(VP_LEN / 8){sew_onehot[0]}} & ~s25) | ({(VP_LEN / 8){sew_onehot[1]}} & ~s26) | ({(VP_LEN / 8){sew_onehot[2]}} & ~s27)) : body_mask;
wire [VP_LEN / 8 - 1:0] s30 = {(VP_LEN / 8){op1_sel[0]}} & op1_mask;
wire [VP_LEN / 8 - 1:0] s31 = {(VP_LEN / 8){op1_sel[1]}} & op1_mask;
wire [VP_LEN / 8 - 1:0] s32 = ~s30 & s29;
wire [VP_LEN / 8 - 1:0] s33 = ~s31 & s29 & {VP_LEN / 8{~vmv_nr}};
wire [VP_LEN - 1:0] s34 = {VP_LEN / 64{op1}};
generate
    if ((VLEN == 128) && (DLEN == 128) & (VP_LEN == 128)) begin:gen_vlen128_dlen128_vplen128
        assign s16[0] = 1'b0;
        assign s16[1] = s0[15];
        assign s16[2] = 1'b0;
        assign s16[3] = s0[31];
        assign s16[4] = 1'b0;
        assign s16[5] = s0[47];
        assign s16[6] = 1'b0;
        assign s16[7] = s0[63];
        assign s16[8] = 1'b0;
        assign s16[9] = s0[79];
        assign s16[10] = 1'b0;
        assign s16[11] = s0[95];
        assign s16[12] = 1'b0;
        assign s16[13] = s0[111];
        assign s16[14] = 1'b0;
        assign s16[15] = s0[127];
        assign s17[0] = 1'b0;
        assign s17[1] = s0[15];
        assign s17[2] = s0[23];
        assign s17[3] = s0[31];
        assign s17[4] = 1'b0;
        assign s17[5] = s0[47];
        assign s17[6] = s0[55];
        assign s17[7] = s0[63];
        assign s17[8] = 1'b0;
        assign s17[9] = s0[79];
        assign s17[10] = s0[87];
        assign s17[11] = s0[95];
        assign s17[12] = 1'b0;
        assign s17[13] = s0[111];
        assign s17[14] = s0[119];
        assign s17[15] = s0[127];
        assign s22[0] = 1'b0;
        assign s18[0] = 1'b0;
        assign s22[1] = s0[15];
        assign s18[1] = s0[15];
        assign s22[2] = s0[23];
        assign s18[2] = s0[23];
        assign s22[3] = s0[31];
        assign s18[3] = s0[31];
        assign s22[4] = s0[39];
        assign s18[4] = s0[39];
        assign s22[5] = s0[47];
        assign s18[5] = s0[47];
        assign s22[6] = s0[55];
        assign s18[6] = s0[55];
        assign s22[7] = s0[63];
        assign s18[7] = s0[63];
        assign s22[8] = 1'b0;
        assign s18[8] = 1'b0;
        assign s22[9] = s0[79];
        assign s18[9] = s0[79];
        assign s22[10] = s0[87];
        assign s18[10] = s0[87];
        assign s22[11] = s0[95];
        assign s18[11] = s0[95];
        assign s22[12] = s0[103];
        assign s18[12] = s0[103];
        assign s22[13] = s0[111];
        assign s18[13] = s0[111];
        assign s22[14] = s0[119];
        assign s18[14] = s0[119];
        assign s22[15] = s0[127];
        assign s18[15] = s0[127];
        assign s25[0 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[1 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s19[0] = 1'b0;
        assign s19[1] = 1'b0;
        assign s19[2] = s0[23];
        assign s19[3] = s0[31];
        assign s19[4] = 1'b0;
        assign s19[5] = 1'b0;
        assign s19[6] = s0[55];
        assign s19[7] = s0[63];
        assign s19[8] = 1'b0;
        assign s19[9] = 1'b0;
        assign s19[10] = s0[87];
        assign s19[11] = s0[95];
        assign s19[12] = 1'b0;
        assign s19[13] = 1'b0;
        assign s19[14] = s0[119];
        assign s19[15] = s0[127];
        assign s23[0] = 1'b0;
        assign s20[0] = 1'b0;
        assign s23[1] = 1'b0;
        assign s20[1] = 1'b0;
        assign s23[2] = s0[23];
        assign s20[2] = s0[23];
        assign s23[3] = s0[31];
        assign s20[3] = s0[31];
        assign s23[4] = s0[39];
        assign s20[4] = s0[39];
        assign s23[5] = s0[47];
        assign s20[5] = s0[47];
        assign s23[6] = s0[55];
        assign s20[6] = s0[55];
        assign s23[7] = s0[63];
        assign s20[7] = s0[63];
        assign s23[8] = 1'b0;
        assign s20[8] = 1'b0;
        assign s23[9] = 1'b0;
        assign s20[9] = 1'b0;
        assign s23[10] = s0[87];
        assign s20[10] = s0[87];
        assign s23[11] = s0[95];
        assign s20[11] = s0[95];
        assign s23[12] = s0[103];
        assign s20[12] = s0[103];
        assign s23[13] = s0[111];
        assign s20[13] = s0[111];
        assign s23[14] = s0[119];
        assign s20[14] = s0[119];
        assign s23[15] = s0[127];
        assign s20[15] = s0[127];
        assign s26[0 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[1 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s24[0] = 1'b0;
        assign s21[0] = 1'b0;
        assign s24[1] = 1'b0;
        assign s21[1] = 1'b0;
        assign s24[2] = 1'b0;
        assign s21[2] = 1'b0;
        assign s24[3] = 1'b0;
        assign s21[3] = 1'b0;
        assign s24[4] = s0[39];
        assign s21[4] = s0[39];
        assign s24[5] = s0[47];
        assign s21[5] = s0[47];
        assign s24[6] = s0[55];
        assign s21[6] = s0[55];
        assign s24[7] = s0[63];
        assign s21[7] = s0[63];
        assign s24[8] = 1'b0;
        assign s21[8] = 1'b0;
        assign s24[9] = 1'b0;
        assign s21[9] = 1'b0;
        assign s24[10] = 1'b0;
        assign s21[10] = 1'b0;
        assign s24[11] = 1'b0;
        assign s21[11] = 1'b0;
        assign s24[12] = s0[103];
        assign s21[12] = s0[103];
        assign s24[13] = s0[111];
        assign s21[13] = s0[111];
        assign s24[14] = s0[119];
        assign s21[14] = s0[119];
        assign s24[15] = s0[127];
        assign s21[15] = s0[127];
        assign s27[0 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[1 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        kv_mux16 #(
            .W(8)
        ) u_mux0 (
            .out(s0[0 * 8 +:8]),
            .sel(idx[0 * SW +:SW]),
            .in(vs2_buf[0 * 128 +:128])
        );
        kv_mux16 #(
            .W(8)
        ) u_mux1 (
            .out(s0[1 * 8 +:8]),
            .sel(idx[1 * SW +:SW]),
            .in(vs2_buf[0 * 128 +:128])
        );
        kv_mux16 #(
            .W(8)
        ) u_mux2 (
            .out(s0[2 * 8 +:8]),
            .sel(idx[2 * SW +:SW]),
            .in(vs2_buf[1 * 128 +:128])
        );
        kv_mux16 #(
            .W(8)
        ) u_mux3 (
            .out(s0[3 * 8 +:8]),
            .sel(idx[3 * SW +:SW]),
            .in(vs2_buf[1 * 128 +:128])
        );
        kv_mux16 #(
            .W(8)
        ) u_mux4 (
            .out(s0[4 * 8 +:8]),
            .sel(idx[4 * SW +:SW]),
            .in(vs2_buf[2 * 128 +:128])
        );
        kv_mux16 #(
            .W(8)
        ) u_mux5 (
            .out(s0[5 * 8 +:8]),
            .sel(idx[5 * SW +:SW]),
            .in(vs2_buf[2 * 128 +:128])
        );
        kv_mux16 #(
            .W(8)
        ) u_mux6 (
            .out(s0[6 * 8 +:8]),
            .sel(idx[6 * SW +:SW]),
            .in(vs2_buf[3 * 128 +:128])
        );
        kv_mux16 #(
            .W(8)
        ) u_mux7 (
            .out(s0[7 * 8 +:8]),
            .sel(idx[7 * SW +:SW]),
            .in(vs2_buf[3 * 128 +:128])
        );
        kv_mux16 #(
            .W(8)
        ) u_mux8 (
            .out(s0[8 * 8 +:8]),
            .sel(idx[8 * SW +:SW]),
            .in(vs2_buf[4 * 128 +:128])
        );
        kv_mux16 #(
            .W(8)
        ) u_mux9 (
            .out(s0[9 * 8 +:8]),
            .sel(idx[9 * SW +:SW]),
            .in(vs2_buf[4 * 128 +:128])
        );
        kv_mux16 #(
            .W(8)
        ) u_mux10 (
            .out(s0[10 * 8 +:8]),
            .sel(idx[10 * SW +:SW]),
            .in(vs2_buf[5 * 128 +:128])
        );
        kv_mux16 #(
            .W(8)
        ) u_mux11 (
            .out(s0[11 * 8 +:8]),
            .sel(idx[11 * SW +:SW]),
            .in(vs2_buf[5 * 128 +:128])
        );
        kv_mux16 #(
            .W(8)
        ) u_mux12 (
            .out(s0[12 * 8 +:8]),
            .sel(idx[12 * SW +:SW]),
            .in(vs2_buf[6 * 128 +:128])
        );
        kv_mux16 #(
            .W(8)
        ) u_mux13 (
            .out(s0[13 * 8 +:8]),
            .sel(idx[13 * SW +:SW]),
            .in(vs2_buf[6 * 128 +:128])
        );
        kv_mux16 #(
            .W(8)
        ) u_mux14 (
            .out(s0[14 * 8 +:8]),
            .sel(idx[14 * SW +:SW]),
            .in(vs2_buf[7 * 128 +:128])
        );
        kv_mux16 #(
            .W(8)
        ) u_mux15 (
            .out(s0[15 * 8 +:8]),
            .sel(idx[15 * SW +:SW]),
            .in(vs2_buf[7 * 128 +:128])
        );
        assign s13[0 +:8] = {{4{s0[0 + 3] & s4}},s0[0 +:4] & {4{s1}}};
        assign s13[8 +:8] = {{4{s0[15] & s4}},s0[12 +:4] & {4{s1}}};
        assign s13[16 +:8] = {{4{s0[16 + 3] & s4}},s0[16 +:4] & {4{s1}}};
        assign s13[24 +:8] = {{4{s0[31] & s4}},s0[28 +:4] & {4{s1}}};
        assign s13[32 +:8] = {{4{s0[32 + 3] & s4}},s0[32 +:4] & {4{s1}}};
        assign s13[40 +:8] = {{4{s0[47] & s4}},s0[44 +:4] & {4{s1}}};
        assign s13[48 +:8] = {{4{s0[48 + 3] & s4}},s0[48 +:4] & {4{s1}}};
        assign s13[56 +:8] = {{4{s0[63] & s4}},s0[60 +:4] & {4{s1}}};
        assign s13[64 +:8] = {{4{s0[64 + 3] & s4}},s0[64 +:4] & {4{s1}}};
        assign s13[72 +:8] = {{4{s0[79] & s4}},s0[76 +:4] & {4{s1}}};
        assign s13[80 +:8] = {{4{s0[80 + 3] & s4}},s0[80 +:4] & {4{s1}}};
        assign s13[88 +:8] = {{4{s0[95] & s4}},s0[92 +:4] & {4{s1}}};
        assign s13[96 +:8] = {{4{s0[96 + 3] & s4}},s0[96 +:4] & {4{s1}}};
        assign s13[104 +:8] = {{4{s0[111] & s4}},s0[108 +:4] & {4{s1}}};
        assign s13[112 +:8] = {{4{s0[112 + 3] & s4}},s0[112 +:4] & {4{s1}}};
        assign s13[120 +:8] = {{4{s0[127] & s4}},s0[124 +:4] & {4{s1}}};
        assign s14[0 +:16] = {{8{s0[0 + 11] & s5}},{4{s0[0 + 3] & s5}},s0[0 +:4] & {4{s2}}};
        assign s14[16 +:16] = {{8{s0[23 + 8] & s5}},{4{s0[23] & s5}},s0[20 +:4] & {4{s2}}};
        assign s14[32 +:16] = {{8{s0[32 + 11] & s5}},{4{s0[32 + 3] & s5}},s0[32 +:4] & {4{s2}}};
        assign s14[48 +:16] = {{8{s0[55 + 8] & s5}},{4{s0[55] & s5}},s0[52 +:4] & {4{s2}}};
        assign s14[64 +:16] = {{8{s0[64 + 11] & s5}},{4{s0[64 + 3] & s5}},s0[64 +:4] & {4{s2}}};
        assign s14[80 +:16] = {{8{s0[87 + 8] & s5}},{4{s0[87] & s5}},s0[84 +:4] & {4{s2}}};
        assign s14[96 +:16] = {{8{s0[96 + 11] & s5}},{4{s0[96 + 3] & s5}},s0[96 +:4] & {4{s2}}};
        assign s14[112 +:16] = {{8{s0[119 + 8] & s5}},{4{s0[119] & s5}},s0[116 +:4] & {4{s2}}};
        assign s15[0 +:32] = {{8{s0[0 + 27] & s6}},{8{s0[0 + 19] & s6}},{8{s0[0 + 11] & s6}},{4{s0[0 + 3] & s6}},s0[0 +:4] & {4{s3}}};
        assign s15[32 +:32] = {{8{s0[39 + 24] & s6}},{8{s0[39 + 16] & s6}},{8{s0[39 + 8] & s6}},{4{s0[39] & s6}},s0[36 +:4] & {4{s3}}};
        assign s15[64 +:32] = {{8{s0[64 + 27] & s6}},{8{s0[64 + 19] & s6}},{8{s0[64 + 11] & s6}},{4{s0[64 + 3] & s6}},s0[64 +:4] & {4{s3}}};
        assign s15[96 +:32] = {{8{s0[103 + 24] & s6}},{8{s0[103 + 16] & s6}},{8{s0[103 + 8] & s6}},{4{s0[103] & s6}},s0[100 +:4] & {4{s3}}};
        wire [2 * VP_LEN - 1:0] s35;
        assign s35 = {2{s13 | s14 | s15}};
        wire [2 * VP_LEN - 1:0] s36 = {2 * VP_LEN{vmv_nr}} & {vs2_buf[VP_LEN +:VP_LEN],{VP_LEN{1'b0}}};
        assign result0[0 * 8 +:8] = s36[0 * 8 +:8] | s35[0 * 8 +:8] | ({8{s30[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s32[0]}}) | {8{s28[0]}});
        assign result0[1 * 8 +:8] = s36[1 * 8 +:8] | s35[1 * 8 +:8] | ({8{s30[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s32[1]}}) | {8{s28[1]}});
        assign result0[2 * 8 +:8] = s36[2 * 8 +:8] | s35[2 * 8 +:8] | ({8{s30[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s32[2]}}) | {8{s28[2]}});
        assign result0[3 * 8 +:8] = s36[3 * 8 +:8] | s35[3 * 8 +:8] | ({8{s30[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s32[3]}}) | {8{s28[3]}});
        assign result0[4 * 8 +:8] = s36[4 * 8 +:8] | s35[4 * 8 +:8] | ({8{s30[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s32[4]}}) | {8{s28[4]}});
        assign result0[5 * 8 +:8] = s36[5 * 8 +:8] | s35[5 * 8 +:8] | ({8{s30[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s32[5]}}) | {8{s28[5]}});
        assign result0[6 * 8 +:8] = s36[6 * 8 +:8] | s35[6 * 8 +:8] | ({8{s30[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s32[6]}}) | {8{s28[6]}});
        assign result0[7 * 8 +:8] = s36[7 * 8 +:8] | s35[7 * 8 +:8] | ({8{s30[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s32[7]}}) | {8{s28[7]}});
        assign result0[8 * 8 +:8] = s36[8 * 8 +:8] | s35[8 * 8 +:8] | ({8{s30[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s32[8]}}) | {8{s28[8]}});
        assign result0[9 * 8 +:8] = s36[9 * 8 +:8] | s35[9 * 8 +:8] | ({8{s30[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s32[9]}}) | {8{s28[9]}});
        assign result0[10 * 8 +:8] = s36[10 * 8 +:8] | s35[10 * 8 +:8] | ({8{s30[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s32[10]}}) | {8{s28[10]}});
        assign result0[11 * 8 +:8] = s36[11 * 8 +:8] | s35[11 * 8 +:8] | ({8{s30[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s32[11]}}) | {8{s28[11]}});
        assign result0[12 * 8 +:8] = s36[12 * 8 +:8] | s35[12 * 8 +:8] | ({8{s30[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s32[12]}}) | {8{s28[12]}});
        assign result0[13 * 8 +:8] = s36[13 * 8 +:8] | s35[13 * 8 +:8] | ({8{s30[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s32[13]}}) | {8{s28[13]}});
        assign result0[14 * 8 +:8] = s36[14 * 8 +:8] | s35[14 * 8 +:8] | ({8{s30[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s32[14]}}) | {8{s28[14]}});
        assign result0[15 * 8 +:8] = s36[15 * 8 +:8] | s35[15 * 8 +:8] | ({8{s30[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s32[15]}}) | {8{s28[15]}});
        assign result1[0 * 8 +:8] = s36[16 * 8 +:8] | s35[16 * 8 +:8] | ({8{s31[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s33[0]}}) | {8{s28[0]}});
        assign result1[1 * 8 +:8] = s36[17 * 8 +:8] | s35[17 * 8 +:8] | ({8{s31[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s33[1]}}) | {8{s28[1]}});
        assign result1[2 * 8 +:8] = s36[18 * 8 +:8] | s35[18 * 8 +:8] | ({8{s31[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s33[2]}}) | {8{s28[2]}});
        assign result1[3 * 8 +:8] = s36[19 * 8 +:8] | s35[19 * 8 +:8] | ({8{s31[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s33[3]}}) | {8{s28[3]}});
        assign result1[4 * 8 +:8] = s36[20 * 8 +:8] | s35[20 * 8 +:8] | ({8{s31[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s33[4]}}) | {8{s28[4]}});
        assign result1[5 * 8 +:8] = s36[21 * 8 +:8] | s35[21 * 8 +:8] | ({8{s31[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s33[5]}}) | {8{s28[5]}});
        assign result1[6 * 8 +:8] = s36[22 * 8 +:8] | s35[22 * 8 +:8] | ({8{s31[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s33[6]}}) | {8{s28[6]}});
        assign result1[7 * 8 +:8] = s36[23 * 8 +:8] | s35[23 * 8 +:8] | ({8{s31[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s33[7]}}) | {8{s28[7]}});
        assign result1[8 * 8 +:8] = s36[24 * 8 +:8] | s35[24 * 8 +:8] | ({8{s31[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s33[8]}}) | {8{s28[8]}});
        assign result1[9 * 8 +:8] = s36[25 * 8 +:8] | s35[25 * 8 +:8] | ({8{s31[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s33[9]}}) | {8{s28[9]}});
        assign result1[10 * 8 +:8] = s36[26 * 8 +:8] | s35[26 * 8 +:8] | ({8{s31[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s33[10]}}) | {8{s28[10]}});
        assign result1[11 * 8 +:8] = s36[27 * 8 +:8] | s35[27 * 8 +:8] | ({8{s31[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s33[11]}}) | {8{s28[11]}});
        assign result1[12 * 8 +:8] = s36[28 * 8 +:8] | s35[28 * 8 +:8] | ({8{s31[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s33[12]}}) | {8{s28[12]}});
        assign result1[13 * 8 +:8] = s36[29 * 8 +:8] | s35[29 * 8 +:8] | ({8{s31[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s33[13]}}) | {8{s28[13]}});
        assign result1[14 * 8 +:8] = s36[30 * 8 +:8] | s35[30 * 8 +:8] | ({8{s31[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s33[14]}}) | {8{s28[14]}});
        assign result1[15 * 8 +:8] = s36[31 * 8 +:8] | s35[31 * 8 +:8] | ({8{s31[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s33[15]}}) | {8{s28[15]}});
    end
endgenerate
generate
    if ((VLEN == 256) && (DLEN == 128) & (VP_LEN == 128)) begin:gen_vlen256_dlen128_vplen128
        assign s16[0] = 1'b0;
        assign s16[1] = s0[15];
        assign s16[2] = 1'b0;
        assign s16[3] = s0[31];
        assign s16[4] = 1'b0;
        assign s16[5] = s0[47];
        assign s16[6] = 1'b0;
        assign s16[7] = s0[63];
        assign s16[8] = 1'b0;
        assign s16[9] = s0[79];
        assign s16[10] = 1'b0;
        assign s16[11] = s0[95];
        assign s16[12] = 1'b0;
        assign s16[13] = s0[111];
        assign s16[14] = 1'b0;
        assign s16[15] = s0[127];
        assign s17[0] = 1'b0;
        assign s17[1] = s0[15];
        assign s17[2] = s0[23];
        assign s17[3] = s0[31];
        assign s17[4] = 1'b0;
        assign s17[5] = s0[47];
        assign s17[6] = s0[55];
        assign s17[7] = s0[63];
        assign s17[8] = 1'b0;
        assign s17[9] = s0[79];
        assign s17[10] = s0[87];
        assign s17[11] = s0[95];
        assign s17[12] = 1'b0;
        assign s17[13] = s0[111];
        assign s17[14] = s0[119];
        assign s17[15] = s0[127];
        assign s22[0] = 1'b0;
        assign s18[0] = 1'b0;
        assign s22[1] = s0[15];
        assign s18[1] = s0[15];
        assign s22[2] = s0[23];
        assign s18[2] = s0[23];
        assign s22[3] = s0[31];
        assign s18[3] = s0[31];
        assign s22[4] = s0[39];
        assign s18[4] = s0[39];
        assign s22[5] = s0[47];
        assign s18[5] = s0[47];
        assign s22[6] = s0[55];
        assign s18[6] = s0[55];
        assign s22[7] = s0[63];
        assign s18[7] = s0[63];
        assign s22[8] = 1'b0;
        assign s18[8] = 1'b0;
        assign s22[9] = s0[79];
        assign s18[9] = s0[79];
        assign s22[10] = s0[87];
        assign s18[10] = s0[87];
        assign s22[11] = s0[95];
        assign s18[11] = s0[95];
        assign s22[12] = s0[103];
        assign s18[12] = s0[103];
        assign s22[13] = s0[111];
        assign s18[13] = s0[111];
        assign s22[14] = s0[119];
        assign s18[14] = s0[119];
        assign s22[15] = s0[127];
        assign s18[15] = s0[127];
        assign s25[0 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[1 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s19[0] = 1'b0;
        assign s19[1] = 1'b0;
        assign s19[2] = s0[23];
        assign s19[3] = s0[31];
        assign s19[4] = 1'b0;
        assign s19[5] = 1'b0;
        assign s19[6] = s0[55];
        assign s19[7] = s0[63];
        assign s19[8] = 1'b0;
        assign s19[9] = 1'b0;
        assign s19[10] = s0[87];
        assign s19[11] = s0[95];
        assign s19[12] = 1'b0;
        assign s19[13] = 1'b0;
        assign s19[14] = s0[119];
        assign s19[15] = s0[127];
        assign s23[0] = 1'b0;
        assign s20[0] = 1'b0;
        assign s23[1] = 1'b0;
        assign s20[1] = 1'b0;
        assign s23[2] = s0[23];
        assign s20[2] = s0[23];
        assign s23[3] = s0[31];
        assign s20[3] = s0[31];
        assign s23[4] = s0[39];
        assign s20[4] = s0[39];
        assign s23[5] = s0[47];
        assign s20[5] = s0[47];
        assign s23[6] = s0[55];
        assign s20[6] = s0[55];
        assign s23[7] = s0[63];
        assign s20[7] = s0[63];
        assign s23[8] = 1'b0;
        assign s20[8] = 1'b0;
        assign s23[9] = 1'b0;
        assign s20[9] = 1'b0;
        assign s23[10] = s0[87];
        assign s20[10] = s0[87];
        assign s23[11] = s0[95];
        assign s20[11] = s0[95];
        assign s23[12] = s0[103];
        assign s20[12] = s0[103];
        assign s23[13] = s0[111];
        assign s20[13] = s0[111];
        assign s23[14] = s0[119];
        assign s20[14] = s0[119];
        assign s23[15] = s0[127];
        assign s20[15] = s0[127];
        assign s26[0 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[1 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s24[0] = 1'b0;
        assign s21[0] = 1'b0;
        assign s24[1] = 1'b0;
        assign s21[1] = 1'b0;
        assign s24[2] = 1'b0;
        assign s21[2] = 1'b0;
        assign s24[3] = 1'b0;
        assign s21[3] = 1'b0;
        assign s24[4] = s0[39];
        assign s21[4] = s0[39];
        assign s24[5] = s0[47];
        assign s21[5] = s0[47];
        assign s24[6] = s0[55];
        assign s21[6] = s0[55];
        assign s24[7] = s0[63];
        assign s21[7] = s0[63];
        assign s24[8] = 1'b0;
        assign s21[8] = 1'b0;
        assign s24[9] = 1'b0;
        assign s21[9] = 1'b0;
        assign s24[10] = 1'b0;
        assign s21[10] = 1'b0;
        assign s24[11] = 1'b0;
        assign s21[11] = 1'b0;
        assign s24[12] = s0[103];
        assign s21[12] = s0[103];
        assign s24[13] = s0[111];
        assign s21[13] = s0[111];
        assign s24[14] = s0[119];
        assign s21[14] = s0[119];
        assign s24[15] = s0[127];
        assign s21[15] = s0[127];
        assign s27[0 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[1 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        kv_mux32 #(
            .W(8)
        ) u_mux0 (
            .out(s0[0 * 8 +:8]),
            .sel(idx[0 * SW +:SW]),
            .in(vs2_buf[0 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux1 (
            .out(s0[1 * 8 +:8]),
            .sel(idx[1 * SW +:SW]),
            .in(vs2_buf[0 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux2 (
            .out(s0[2 * 8 +:8]),
            .sel(idx[2 * SW +:SW]),
            .in(vs2_buf[1 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux3 (
            .out(s0[3 * 8 +:8]),
            .sel(idx[3 * SW +:SW]),
            .in(vs2_buf[1 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux4 (
            .out(s0[4 * 8 +:8]),
            .sel(idx[4 * SW +:SW]),
            .in(vs2_buf[2 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux5 (
            .out(s0[5 * 8 +:8]),
            .sel(idx[5 * SW +:SW]),
            .in(vs2_buf[2 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux6 (
            .out(s0[6 * 8 +:8]),
            .sel(idx[6 * SW +:SW]),
            .in(vs2_buf[3 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux7 (
            .out(s0[7 * 8 +:8]),
            .sel(idx[7 * SW +:SW]),
            .in(vs2_buf[3 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux8 (
            .out(s0[8 * 8 +:8]),
            .sel(idx[8 * SW +:SW]),
            .in(vs2_buf[4 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux9 (
            .out(s0[9 * 8 +:8]),
            .sel(idx[9 * SW +:SW]),
            .in(vs2_buf[4 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux10 (
            .out(s0[10 * 8 +:8]),
            .sel(idx[10 * SW +:SW]),
            .in(vs2_buf[5 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux11 (
            .out(s0[11 * 8 +:8]),
            .sel(idx[11 * SW +:SW]),
            .in(vs2_buf[5 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux12 (
            .out(s0[12 * 8 +:8]),
            .sel(idx[12 * SW +:SW]),
            .in(vs2_buf[6 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux13 (
            .out(s0[13 * 8 +:8]),
            .sel(idx[13 * SW +:SW]),
            .in(vs2_buf[6 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux14 (
            .out(s0[14 * 8 +:8]),
            .sel(idx[14 * SW +:SW]),
            .in(vs2_buf[7 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux15 (
            .out(s0[15 * 8 +:8]),
            .sel(idx[15 * SW +:SW]),
            .in(vs2_buf[7 * 256 +:256])
        );
        assign s13[0 +:8] = {{4{s0[0 + 3] & s4}},s0[0 +:4] & {4{s1}}};
        assign s13[8 +:8] = {{4{s0[15] & s4}},s0[12 +:4] & {4{s1}}};
        assign s13[16 +:8] = {{4{s0[16 + 3] & s4}},s0[16 +:4] & {4{s1}}};
        assign s13[24 +:8] = {{4{s0[31] & s4}},s0[28 +:4] & {4{s1}}};
        assign s13[32 +:8] = {{4{s0[32 + 3] & s4}},s0[32 +:4] & {4{s1}}};
        assign s13[40 +:8] = {{4{s0[47] & s4}},s0[44 +:4] & {4{s1}}};
        assign s13[48 +:8] = {{4{s0[48 + 3] & s4}},s0[48 +:4] & {4{s1}}};
        assign s13[56 +:8] = {{4{s0[63] & s4}},s0[60 +:4] & {4{s1}}};
        assign s13[64 +:8] = {{4{s0[64 + 3] & s4}},s0[64 +:4] & {4{s1}}};
        assign s13[72 +:8] = {{4{s0[79] & s4}},s0[76 +:4] & {4{s1}}};
        assign s13[80 +:8] = {{4{s0[80 + 3] & s4}},s0[80 +:4] & {4{s1}}};
        assign s13[88 +:8] = {{4{s0[95] & s4}},s0[92 +:4] & {4{s1}}};
        assign s13[96 +:8] = {{4{s0[96 + 3] & s4}},s0[96 +:4] & {4{s1}}};
        assign s13[104 +:8] = {{4{s0[111] & s4}},s0[108 +:4] & {4{s1}}};
        assign s13[112 +:8] = {{4{s0[112 + 3] & s4}},s0[112 +:4] & {4{s1}}};
        assign s13[120 +:8] = {{4{s0[127] & s4}},s0[124 +:4] & {4{s1}}};
        assign s14[0 +:16] = {{8{s0[0 + 11] & s5}},{4{s0[0 + 3] & s5}},s0[0 +:4] & {4{s2}}};
        assign s14[16 +:16] = {{8{s0[23 + 8] & s5}},{4{s0[23] & s5}},s0[20 +:4] & {4{s2}}};
        assign s14[32 +:16] = {{8{s0[32 + 11] & s5}},{4{s0[32 + 3] & s5}},s0[32 +:4] & {4{s2}}};
        assign s14[48 +:16] = {{8{s0[55 + 8] & s5}},{4{s0[55] & s5}},s0[52 +:4] & {4{s2}}};
        assign s14[64 +:16] = {{8{s0[64 + 11] & s5}},{4{s0[64 + 3] & s5}},s0[64 +:4] & {4{s2}}};
        assign s14[80 +:16] = {{8{s0[87 + 8] & s5}},{4{s0[87] & s5}},s0[84 +:4] & {4{s2}}};
        assign s14[96 +:16] = {{8{s0[96 + 11] & s5}},{4{s0[96 + 3] & s5}},s0[96 +:4] & {4{s2}}};
        assign s14[112 +:16] = {{8{s0[119 + 8] & s5}},{4{s0[119] & s5}},s0[116 +:4] & {4{s2}}};
        assign s15[0 +:32] = {{8{s0[0 + 27] & s6}},{8{s0[0 + 19] & s6}},{8{s0[0 + 11] & s6}},{4{s0[0 + 3] & s6}},s0[0 +:4] & {4{s3}}};
        assign s15[32 +:32] = {{8{s0[39 + 24] & s6}},{8{s0[39 + 16] & s6}},{8{s0[39 + 8] & s6}},{4{s0[39] & s6}},s0[36 +:4] & {4{s3}}};
        assign s15[64 +:32] = {{8{s0[64 + 27] & s6}},{8{s0[64 + 19] & s6}},{8{s0[64 + 11] & s6}},{4{s0[64 + 3] & s6}},s0[64 +:4] & {4{s3}}};
        assign s15[96 +:32] = {{8{s0[103 + 24] & s6}},{8{s0[103 + 16] & s6}},{8{s0[103 + 8] & s6}},{4{s0[103] & s6}},s0[100 +:4] & {4{s3}}};
        wire [2 * VP_LEN - 1:0] s35;
        assign s35 = {2{s13 | s14 | s15}};
        wire [2 * VP_LEN - 1:0] s36 = {2 * VP_LEN{vmv_nr}} & {vs2_buf[VP_LEN +:VP_LEN],{VP_LEN{1'b0}}};
        assign result0[0 * 8 +:8] = s36[0 * 8 +:8] | s35[0 * 8 +:8] | ({8{s30[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s32[0]}}) | {8{s28[0]}});
        assign result0[1 * 8 +:8] = s36[1 * 8 +:8] | s35[1 * 8 +:8] | ({8{s30[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s32[1]}}) | {8{s28[1]}});
        assign result0[2 * 8 +:8] = s36[2 * 8 +:8] | s35[2 * 8 +:8] | ({8{s30[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s32[2]}}) | {8{s28[2]}});
        assign result0[3 * 8 +:8] = s36[3 * 8 +:8] | s35[3 * 8 +:8] | ({8{s30[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s32[3]}}) | {8{s28[3]}});
        assign result0[4 * 8 +:8] = s36[4 * 8 +:8] | s35[4 * 8 +:8] | ({8{s30[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s32[4]}}) | {8{s28[4]}});
        assign result0[5 * 8 +:8] = s36[5 * 8 +:8] | s35[5 * 8 +:8] | ({8{s30[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s32[5]}}) | {8{s28[5]}});
        assign result0[6 * 8 +:8] = s36[6 * 8 +:8] | s35[6 * 8 +:8] | ({8{s30[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s32[6]}}) | {8{s28[6]}});
        assign result0[7 * 8 +:8] = s36[7 * 8 +:8] | s35[7 * 8 +:8] | ({8{s30[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s32[7]}}) | {8{s28[7]}});
        assign result0[8 * 8 +:8] = s36[8 * 8 +:8] | s35[8 * 8 +:8] | ({8{s30[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s32[8]}}) | {8{s28[8]}});
        assign result0[9 * 8 +:8] = s36[9 * 8 +:8] | s35[9 * 8 +:8] | ({8{s30[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s32[9]}}) | {8{s28[9]}});
        assign result0[10 * 8 +:8] = s36[10 * 8 +:8] | s35[10 * 8 +:8] | ({8{s30[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s32[10]}}) | {8{s28[10]}});
        assign result0[11 * 8 +:8] = s36[11 * 8 +:8] | s35[11 * 8 +:8] | ({8{s30[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s32[11]}}) | {8{s28[11]}});
        assign result0[12 * 8 +:8] = s36[12 * 8 +:8] | s35[12 * 8 +:8] | ({8{s30[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s32[12]}}) | {8{s28[12]}});
        assign result0[13 * 8 +:8] = s36[13 * 8 +:8] | s35[13 * 8 +:8] | ({8{s30[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s32[13]}}) | {8{s28[13]}});
        assign result0[14 * 8 +:8] = s36[14 * 8 +:8] | s35[14 * 8 +:8] | ({8{s30[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s32[14]}}) | {8{s28[14]}});
        assign result0[15 * 8 +:8] = s36[15 * 8 +:8] | s35[15 * 8 +:8] | ({8{s30[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s32[15]}}) | {8{s28[15]}});
        assign result1[0 * 8 +:8] = s36[16 * 8 +:8] | s35[16 * 8 +:8] | ({8{s31[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s33[0]}}) | {8{s28[0]}});
        assign result1[1 * 8 +:8] = s36[17 * 8 +:8] | s35[17 * 8 +:8] | ({8{s31[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s33[1]}}) | {8{s28[1]}});
        assign result1[2 * 8 +:8] = s36[18 * 8 +:8] | s35[18 * 8 +:8] | ({8{s31[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s33[2]}}) | {8{s28[2]}});
        assign result1[3 * 8 +:8] = s36[19 * 8 +:8] | s35[19 * 8 +:8] | ({8{s31[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s33[3]}}) | {8{s28[3]}});
        assign result1[4 * 8 +:8] = s36[20 * 8 +:8] | s35[20 * 8 +:8] | ({8{s31[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s33[4]}}) | {8{s28[4]}});
        assign result1[5 * 8 +:8] = s36[21 * 8 +:8] | s35[21 * 8 +:8] | ({8{s31[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s33[5]}}) | {8{s28[5]}});
        assign result1[6 * 8 +:8] = s36[22 * 8 +:8] | s35[22 * 8 +:8] | ({8{s31[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s33[6]}}) | {8{s28[6]}});
        assign result1[7 * 8 +:8] = s36[23 * 8 +:8] | s35[23 * 8 +:8] | ({8{s31[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s33[7]}}) | {8{s28[7]}});
        assign result1[8 * 8 +:8] = s36[24 * 8 +:8] | s35[24 * 8 +:8] | ({8{s31[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s33[8]}}) | {8{s28[8]}});
        assign result1[9 * 8 +:8] = s36[25 * 8 +:8] | s35[25 * 8 +:8] | ({8{s31[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s33[9]}}) | {8{s28[9]}});
        assign result1[10 * 8 +:8] = s36[26 * 8 +:8] | s35[26 * 8 +:8] | ({8{s31[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s33[10]}}) | {8{s28[10]}});
        assign result1[11 * 8 +:8] = s36[27 * 8 +:8] | s35[27 * 8 +:8] | ({8{s31[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s33[11]}}) | {8{s28[11]}});
        assign result1[12 * 8 +:8] = s36[28 * 8 +:8] | s35[28 * 8 +:8] | ({8{s31[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s33[12]}}) | {8{s28[12]}});
        assign result1[13 * 8 +:8] = s36[29 * 8 +:8] | s35[29 * 8 +:8] | ({8{s31[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s33[13]}}) | {8{s28[13]}});
        assign result1[14 * 8 +:8] = s36[30 * 8 +:8] | s35[30 * 8 +:8] | ({8{s31[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s33[14]}}) | {8{s28[14]}});
        assign result1[15 * 8 +:8] = s36[31 * 8 +:8] | s35[31 * 8 +:8] | ({8{s31[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s33[15]}}) | {8{s28[15]}});
    end
endgenerate
generate
    if ((VLEN == 256) && (DLEN == 256) & (VP_LEN == 128)) begin:gen_vlen256_dlen256_vplen128
        assign s16[0] = 1'b0;
        assign s16[1] = 1'b0;
        assign s16[2] = 1'b0;
        assign s16[3] = 1'b0;
        assign s16[4] = 1'b0;
        assign s16[5] = 1'b0;
        assign s16[6] = 1'b0;
        assign s16[7] = 1'b0;
        assign s16[8] = 1'b0;
        assign s16[9] = 1'b0;
        assign s16[10] = 1'b0;
        assign s16[11] = 1'b0;
        assign s16[12] = 1'b0;
        assign s16[13] = 1'b0;
        assign s16[14] = 1'b0;
        assign s16[15] = 1'b0;
        assign s17[0] = 1'b0;
        assign s17[1] = 1'b0;
        assign s17[2] = 1'b0;
        assign s17[3] = 1'b0;
        assign s17[4] = 1'b0;
        assign s17[5] = 1'b0;
        assign s17[6] = 1'b0;
        assign s17[7] = 1'b0;
        assign s17[8] = 1'b0;
        assign s17[9] = 1'b0;
        assign s17[10] = 1'b0;
        assign s17[11] = 1'b0;
        assign s17[12] = 1'b0;
        assign s17[13] = 1'b0;
        assign s17[14] = 1'b0;
        assign s17[15] = 1'b0;
        assign s22[0] = 1'b0;
        assign s18[0] = 1'b0;
        assign s22[1] = s0[15];
        assign s18[1] = 1'b0;
        assign s22[2] = s0[23];
        assign s18[2] = 1'b0;
        assign s22[3] = s0[31];
        assign s18[3] = 1'b0;
        assign s22[4] = s0[39];
        assign s18[4] = 1'b0;
        assign s22[5] = s0[47];
        assign s18[5] = 1'b0;
        assign s22[6] = s0[55];
        assign s18[6] = 1'b0;
        assign s22[7] = s0[63];
        assign s18[7] = 1'b0;
        assign s22[8] = 1'b0;
        assign s18[8] = 1'b0;
        assign s22[9] = s0[79];
        assign s18[9] = 1'b0;
        assign s22[10] = s0[87];
        assign s18[10] = 1'b0;
        assign s22[11] = s0[95];
        assign s18[11] = 1'b0;
        assign s22[12] = s0[103];
        assign s18[12] = 1'b0;
        assign s22[13] = s0[111];
        assign s18[13] = 1'b0;
        assign s22[14] = s0[119];
        assign s18[14] = 1'b0;
        assign s22[15] = s0[127];
        assign s18[15] = 1'b0;
        assign s25[0 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[1 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s19[0] = 1'b0;
        assign s19[1] = 1'b0;
        assign s19[2] = 1'b0;
        assign s19[3] = 1'b0;
        assign s19[4] = 1'b0;
        assign s19[5] = 1'b0;
        assign s19[6] = 1'b0;
        assign s19[7] = 1'b0;
        assign s19[8] = 1'b0;
        assign s19[9] = 1'b0;
        assign s19[10] = 1'b0;
        assign s19[11] = 1'b0;
        assign s19[12] = 1'b0;
        assign s19[13] = 1'b0;
        assign s19[14] = 1'b0;
        assign s19[15] = 1'b0;
        assign s23[0] = 1'b0;
        assign s20[0] = 1'b0;
        assign s23[1] = 1'b0;
        assign s20[1] = 1'b0;
        assign s23[2] = s0[23];
        assign s20[2] = 1'b0;
        assign s23[3] = s0[31];
        assign s20[3] = 1'b0;
        assign s23[4] = s0[39];
        assign s20[4] = 1'b0;
        assign s23[5] = s0[47];
        assign s20[5] = 1'b0;
        assign s23[6] = s0[55];
        assign s20[6] = 1'b0;
        assign s23[7] = s0[63];
        assign s20[7] = 1'b0;
        assign s23[8] = 1'b0;
        assign s20[8] = 1'b0;
        assign s23[9] = 1'b0;
        assign s20[9] = 1'b0;
        assign s23[10] = s0[87];
        assign s20[10] = 1'b0;
        assign s23[11] = s0[95];
        assign s20[11] = 1'b0;
        assign s23[12] = s0[103];
        assign s20[12] = 1'b0;
        assign s23[13] = s0[111];
        assign s20[13] = 1'b0;
        assign s23[14] = s0[119];
        assign s20[14] = 1'b0;
        assign s23[15] = s0[127];
        assign s20[15] = 1'b0;
        assign s26[0 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[1 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s24[0] = 1'b0;
        assign s21[0] = 1'b0;
        assign s24[1] = 1'b0;
        assign s21[1] = 1'b0;
        assign s24[2] = 1'b0;
        assign s21[2] = 1'b0;
        assign s24[3] = 1'b0;
        assign s21[3] = 1'b0;
        assign s24[4] = s0[39];
        assign s21[4] = 1'b0;
        assign s24[5] = s0[47];
        assign s21[5] = 1'b0;
        assign s24[6] = s0[55];
        assign s21[6] = 1'b0;
        assign s24[7] = s0[63];
        assign s21[7] = 1'b0;
        assign s24[8] = 1'b0;
        assign s21[8] = 1'b0;
        assign s24[9] = 1'b0;
        assign s21[9] = 1'b0;
        assign s24[10] = 1'b0;
        assign s21[10] = 1'b0;
        assign s24[11] = 1'b0;
        assign s21[11] = 1'b0;
        assign s24[12] = s0[103];
        assign s21[12] = 1'b0;
        assign s24[13] = s0[111];
        assign s21[13] = 1'b0;
        assign s24[14] = s0[119];
        assign s21[14] = 1'b0;
        assign s24[15] = s0[127];
        assign s21[15] = 1'b0;
        assign s27[0 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[1 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        kv_mux32 #(
            .W(8)
        ) u_mux0 (
            .out(s0[0 * 8 +:8]),
            .sel(idx[0 * SW +:SW]),
            .in(vs2_buf[0 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux1 (
            .out(s0[1 * 8 +:8]),
            .sel(idx[1 * SW +:SW]),
            .in(vs2_buf[0 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux2 (
            .out(s0[2 * 8 +:8]),
            .sel(idx[2 * SW +:SW]),
            .in(vs2_buf[1 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux3 (
            .out(s0[3 * 8 +:8]),
            .sel(idx[3 * SW +:SW]),
            .in(vs2_buf[1 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux4 (
            .out(s0[4 * 8 +:8]),
            .sel(idx[4 * SW +:SW]),
            .in(vs2_buf[2 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux5 (
            .out(s0[5 * 8 +:8]),
            .sel(idx[5 * SW +:SW]),
            .in(vs2_buf[2 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux6 (
            .out(s0[6 * 8 +:8]),
            .sel(idx[6 * SW +:SW]),
            .in(vs2_buf[3 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux7 (
            .out(s0[7 * 8 +:8]),
            .sel(idx[7 * SW +:SW]),
            .in(vs2_buf[3 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux8 (
            .out(s0[8 * 8 +:8]),
            .sel(idx[8 * SW +:SW]),
            .in(vs2_buf[4 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux9 (
            .out(s0[9 * 8 +:8]),
            .sel(idx[9 * SW +:SW]),
            .in(vs2_buf[4 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux10 (
            .out(s0[10 * 8 +:8]),
            .sel(idx[10 * SW +:SW]),
            .in(vs2_buf[5 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux11 (
            .out(s0[11 * 8 +:8]),
            .sel(idx[11 * SW +:SW]),
            .in(vs2_buf[5 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux12 (
            .out(s0[12 * 8 +:8]),
            .sel(idx[12 * SW +:SW]),
            .in(vs2_buf[6 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux13 (
            .out(s0[13 * 8 +:8]),
            .sel(idx[13 * SW +:SW]),
            .in(vs2_buf[6 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux14 (
            .out(s0[14 * 8 +:8]),
            .sel(idx[14 * SW +:SW]),
            .in(vs2_buf[7 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux15 (
            .out(s0[15 * 8 +:8]),
            .sel(idx[15 * SW +:SW]),
            .in(vs2_buf[7 * 256 +:256])
        );
        assign s13[0 +:8] = {{4{s0[3] & s4}},s0[0 +:4] & {4{s1}}};
        assign s13[8 +:8] = {{4{s0[7] & s4}},s0[4 +:4] & {4{s1}}};
        assign s13[16 +:8] = {{4{s0[11] & s4}},s0[8 +:4] & {4{s1}}};
        assign s13[24 +:8] = {{4{s0[15] & s4}},s0[12 +:4] & {4{s1}}};
        assign s13[32 +:8] = {{4{s0[19] & s4}},s0[16 +:4] & {4{s1}}};
        assign s13[40 +:8] = {{4{s0[23] & s4}},s0[20 +:4] & {4{s1}}};
        assign s13[48 +:8] = {{4{s0[27] & s4}},s0[24 +:4] & {4{s1}}};
        assign s13[56 +:8] = {{4{s0[31] & s4}},s0[28 +:4] & {4{s1}}};
        assign s13[64 +:8] = {{4{s0[35] & s4}},s0[32 +:4] & {4{s1}}};
        assign s13[72 +:8] = {{4{s0[39] & s4}},s0[36 +:4] & {4{s1}}};
        assign s13[80 +:8] = {{4{s0[43] & s4}},s0[40 +:4] & {4{s1}}};
        assign s13[88 +:8] = {{4{s0[47] & s4}},s0[44 +:4] & {4{s1}}};
        assign s13[96 +:8] = {{4{s0[51] & s4}},s0[48 +:4] & {4{s1}}};
        assign s13[104 +:8] = {{4{s0[55] & s4}},s0[52 +:4] & {4{s1}}};
        assign s13[112 +:8] = {{4{s0[59] & s4}},s0[56 +:4] & {4{s1}}};
        assign s13[120 +:8] = {{4{s0[63] & s4}},s0[60 +:4] & {4{s1}}};
        assign s13[128 +:8] = {{4{s0[67] & s4}},s0[64 +:4] & {4{s1}}};
        assign s13[136 +:8] = {{4{s0[71] & s4}},s0[68 +:4] & {4{s1}}};
        assign s13[144 +:8] = {{4{s0[75] & s4}},s0[72 +:4] & {4{s1}}};
        assign s13[152 +:8] = {{4{s0[79] & s4}},s0[76 +:4] & {4{s1}}};
        assign s13[160 +:8] = {{4{s0[83] & s4}},s0[80 +:4] & {4{s1}}};
        assign s13[168 +:8] = {{4{s0[87] & s4}},s0[84 +:4] & {4{s1}}};
        assign s13[176 +:8] = {{4{s0[91] & s4}},s0[88 +:4] & {4{s1}}};
        assign s13[184 +:8] = {{4{s0[95] & s4}},s0[92 +:4] & {4{s1}}};
        assign s13[192 +:8] = {{4{s0[99] & s4}},s0[96 +:4] & {4{s1}}};
        assign s13[200 +:8] = {{4{s0[103] & s4}},s0[100 +:4] & {4{s1}}};
        assign s13[208 +:8] = {{4{s0[107] & s4}},s0[104 +:4] & {4{s1}}};
        assign s13[216 +:8] = {{4{s0[111] & s4}},s0[108 +:4] & {4{s1}}};
        assign s13[224 +:8] = {{4{s0[115] & s4}},s0[112 +:4] & {4{s1}}};
        assign s13[232 +:8] = {{4{s0[119] & s4}},s0[116 +:4] & {4{s1}}};
        assign s13[240 +:8] = {{4{s0[123] & s4}},s0[120 +:4] & {4{s1}}};
        assign s13[248 +:8] = {{4{s0[127] & s4}},s0[124 +:4] & {4{s1}}};
        assign s14[0 +:16] = {{12{s0[3] & s5}},s0[0 +:4] & {4{s2}}};
        assign s14[16 +:16] = {{12{s0[7] & s5}},s0[4 +:4] & {4{s2}}};
        assign s14[32 +:16] = {{12{s0[11] & s5}},s0[8 +:4] & {4{s2}}};
        assign s14[48 +:16] = {{12{s0[15] & s5}},s0[12 +:4] & {4{s2}}};
        assign s14[64 +:16] = {{12{s0[19] & s5}},s0[16 +:4] & {4{s2}}};
        assign s14[80 +:16] = {{12{s0[23] & s5}},s0[20 +:4] & {4{s2}}};
        assign s14[96 +:16] = {{12{s0[27] & s5}},s0[24 +:4] & {4{s2}}};
        assign s14[112 +:16] = {{12{s0[31] & s5}},s0[28 +:4] & {4{s2}}};
        assign s14[128 +:16] = {{12{s0[35] & s5}},s0[32 +:4] & {4{s2}}};
        assign s14[144 +:16] = {{12{s0[39] & s5}},s0[36 +:4] & {4{s2}}};
        assign s14[160 +:16] = {{12{s0[43] & s5}},s0[40 +:4] & {4{s2}}};
        assign s14[176 +:16] = {{12{s0[47] & s5}},s0[44 +:4] & {4{s2}}};
        assign s14[192 +:16] = {{12{s0[51] & s5}},s0[48 +:4] & {4{s2}}};
        assign s14[208 +:16] = {{12{s0[55] & s5}},s0[52 +:4] & {4{s2}}};
        assign s14[224 +:16] = {{12{s0[59] & s5}},s0[56 +:4] & {4{s2}}};
        assign s14[240 +:16] = {{12{s0[63] & s5}},s0[60 +:4] & {4{s2}}};
        assign s15[0 +:32] = {{28{s0[3] & s6}},s0[0 +:4] & {4{s3}}};
        assign s15[32 +:32] = {{28{s0[7] & s6}},s0[4 +:4] & {4{s3}}};
        assign s15[64 +:32] = {{28{s0[11] & s6}},s0[8 +:4] & {4{s3}}};
        assign s15[96 +:32] = {{28{s0[15] & s6}},s0[12 +:4] & {4{s3}}};
        assign s15[128 +:32] = {{28{s0[19] & s6}},s0[16 +:4] & {4{s3}}};
        assign s15[160 +:32] = {{28{s0[23] & s6}},s0[20 +:4] & {4{s3}}};
        assign s15[192 +:32] = {{28{s0[27] & s6}},s0[24 +:4] & {4{s3}}};
        assign s15[224 +:32] = {{28{s0[31] & s6}},s0[28 +:4] & {4{s3}}};
        wire [2 * VP_LEN - 1:0] s37;
        wire s38 = vzsext & eew8x2;
        assign s37[0 +:16] = {{8{s0[7] & s7}},s0[0 +:8] & {8{s38}}};
        assign s37[16 +:16] = {{8{s0[15] & s7}},s0[8 +:8] & {8{s38}}};
        assign s37[32 +:16] = {{8{s0[23] & s7}},s0[16 +:8] & {8{s38}}};
        assign s37[48 +:16] = {{8{s0[31] & s7}},s0[24 +:8] & {8{s38}}};
        assign s37[64 +:16] = {{8{s0[39] & s7}},s0[32 +:8] & {8{s38}}};
        assign s37[80 +:16] = {{8{s0[47] & s7}},s0[40 +:8] & {8{s38}}};
        assign s37[96 +:16] = {{8{s0[55] & s7}},s0[48 +:8] & {8{s38}}};
        assign s37[112 +:16] = {{8{s0[63] & s7}},s0[56 +:8] & {8{s38}}};
        assign s37[128 +:16] = {{8{s0[71] & s7}},s0[64 +:8] & {8{s38}}};
        assign s37[144 +:16] = {{8{s0[79] & s7}},s0[72 +:8] & {8{s38}}};
        assign s37[160 +:16] = {{8{s0[87] & s7}},s0[80 +:8] & {8{s38}}};
        assign s37[176 +:16] = {{8{s0[95] & s7}},s0[88 +:8] & {8{s38}}};
        assign s37[192 +:16] = {{8{s0[103] & s7}},s0[96 +:8] & {8{s38}}};
        assign s37[208 +:16] = {{8{s0[111] & s7}},s0[104 +:8] & {8{s38}}};
        assign s37[224 +:16] = {{8{s0[119] & s7}},s0[112 +:8] & {8{s38}}};
        assign s37[240 +:16] = {{8{s0[127] & s7}},s0[120 +:8] & {8{s38}}};
        wire [2 * VP_LEN - 1:0] s39;
        wire s40 = vzsext & eew8x4;
        assign s39[0 +:32] = {{24{s0[7] & s8}},s0[0 +:8] & {8{s40}}};
        assign s39[32 +:32] = {{24{s0[15] & s8}},s0[8 +:8] & {8{s40}}};
        assign s39[64 +:32] = {{24{s0[23] & s8}},s0[16 +:8] & {8{s40}}};
        assign s39[96 +:32] = {{24{s0[31] & s8}},s0[24 +:8] & {8{s40}}};
        assign s39[128 +:32] = {{24{s0[39] & s8}},s0[32 +:8] & {8{s40}}};
        assign s39[160 +:32] = {{24{s0[47] & s8}},s0[40 +:8] & {8{s40}}};
        assign s39[192 +:32] = {{24{s0[55] & s8}},s0[48 +:8] & {8{s40}}};
        assign s39[224 +:32] = {{24{s0[63] & s8}},s0[56 +:8] & {8{s40}}};
        wire [2 * VP_LEN - 1:0] s41;
        wire s42 = vzsext & eew8x8;
        assign s41[0 +:64] = {{56{s0[7] & s9}},s0[0 +:8] & {8{s42}}};
        assign s41[64 +:64] = {{56{s0[15] & s9}},s0[8 +:8] & {8{s42}}};
        assign s41[128 +:64] = {{56{s0[23] & s9}},s0[16 +:8] & {8{s42}}};
        assign s41[192 +:64] = {{56{s0[31] & s9}},s0[24 +:8] & {8{s42}}};
        wire [2 * VP_LEN - 1:0] s43;
        wire s44 = vzsext & eew16x2;
        assign s43[0 +:32] = {{16{s0[15] & s10}},s0[0 +:16] & {16{s44}}};
        assign s43[32 +:32] = {{16{s0[31] & s10}},s0[16 +:16] & {16{s44}}};
        assign s43[64 +:32] = {{16{s0[47] & s10}},s0[32 +:16] & {16{s44}}};
        assign s43[96 +:32] = {{16{s0[63] & s10}},s0[48 +:16] & {16{s44}}};
        assign s43[128 +:32] = {{16{s0[79] & s10}},s0[64 +:16] & {16{s44}}};
        assign s43[160 +:32] = {{16{s0[95] & s10}},s0[80 +:16] & {16{s44}}};
        assign s43[192 +:32] = {{16{s0[111] & s10}},s0[96 +:16] & {16{s44}}};
        assign s43[224 +:32] = {{16{s0[127] & s10}},s0[112 +:16] & {16{s44}}};
        wire [2 * VP_LEN - 1:0] s45;
        wire s46 = vzsext & eew16x4;
        assign s45[0 +:64] = {{48{s0[15] & s11}},s0[0 +:16] & {16{s46}}};
        assign s45[64 +:64] = {{48{s0[31] & s11}},s0[16 +:16] & {16{s46}}};
        assign s45[128 +:64] = {{48{s0[47] & s11}},s0[32 +:16] & {16{s46}}};
        assign s45[192 +:64] = {{48{s0[63] & s11}},s0[48 +:16] & {16{s46}}};
        wire [2 * VP_LEN - 1:0] s47;
        wire s48 = vzsext & eew32x2;
        assign s47[0 +:64] = {{32{s0[31] & s12}},s0[0 +:32] & {32{s48}}};
        assign s47[64 +:64] = {{32{s0[63] & s12}},s0[32 +:32] & {32{s48}}};
        assign s47[128 +:64] = {{32{s0[95] & s12}},s0[64 +:32] & {32{s48}}};
        assign s47[192 +:64] = {{32{s0[127] & s12}},s0[96 +:32] & {32{s48}}};
        wire [2 * VP_LEN - 1:0] s35;
        assign s35 = s13 | s14 | s15 | s37 | s39 | s41 | s43 | s45 | s47;
        wire [2 * VP_LEN - 1:0] s36 = {2 * VP_LEN{vmv_nr}} & {vs2_buf[VP_LEN +:VP_LEN],{VP_LEN{1'b0}}};
        assign result0[0 * 8 +:8] = s36[0 * 8 +:8] | s35[0 * 8 +:8] | ({8{s30[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s32[0]}}) | {8{s28[0]}});
        assign result0[1 * 8 +:8] = s36[1 * 8 +:8] | s35[1 * 8 +:8] | ({8{s30[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s32[1]}}) | {8{s28[1]}});
        assign result0[2 * 8 +:8] = s36[2 * 8 +:8] | s35[2 * 8 +:8] | ({8{s30[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s32[2]}}) | {8{s28[2]}});
        assign result0[3 * 8 +:8] = s36[3 * 8 +:8] | s35[3 * 8 +:8] | ({8{s30[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s32[3]}}) | {8{s28[3]}});
        assign result0[4 * 8 +:8] = s36[4 * 8 +:8] | s35[4 * 8 +:8] | ({8{s30[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s32[4]}}) | {8{s28[4]}});
        assign result0[5 * 8 +:8] = s36[5 * 8 +:8] | s35[5 * 8 +:8] | ({8{s30[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s32[5]}}) | {8{s28[5]}});
        assign result0[6 * 8 +:8] = s36[6 * 8 +:8] | s35[6 * 8 +:8] | ({8{s30[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s32[6]}}) | {8{s28[6]}});
        assign result0[7 * 8 +:8] = s36[7 * 8 +:8] | s35[7 * 8 +:8] | ({8{s30[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s32[7]}}) | {8{s28[7]}});
        assign result0[8 * 8 +:8] = s36[8 * 8 +:8] | s35[8 * 8 +:8] | ({8{s30[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s32[8]}}) | {8{s28[8]}});
        assign result0[9 * 8 +:8] = s36[9 * 8 +:8] | s35[9 * 8 +:8] | ({8{s30[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s32[9]}}) | {8{s28[9]}});
        assign result0[10 * 8 +:8] = s36[10 * 8 +:8] | s35[10 * 8 +:8] | ({8{s30[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s32[10]}}) | {8{s28[10]}});
        assign result0[11 * 8 +:8] = s36[11 * 8 +:8] | s35[11 * 8 +:8] | ({8{s30[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s32[11]}}) | {8{s28[11]}});
        assign result0[12 * 8 +:8] = s36[12 * 8 +:8] | s35[12 * 8 +:8] | ({8{s30[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s32[12]}}) | {8{s28[12]}});
        assign result0[13 * 8 +:8] = s36[13 * 8 +:8] | s35[13 * 8 +:8] | ({8{s30[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s32[13]}}) | {8{s28[13]}});
        assign result0[14 * 8 +:8] = s36[14 * 8 +:8] | s35[14 * 8 +:8] | ({8{s30[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s32[14]}}) | {8{s28[14]}});
        assign result0[15 * 8 +:8] = s36[15 * 8 +:8] | s35[15 * 8 +:8] | ({8{s30[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s32[15]}}) | {8{s28[15]}});
        assign result1[0 * 8 +:8] = s36[16 * 8 +:8] | s35[16 * 8 +:8] | ({8{s31[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s33[0]}}) | {8{s28[0]}});
        assign result1[1 * 8 +:8] = s36[17 * 8 +:8] | s35[17 * 8 +:8] | ({8{s31[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s33[1]}}) | {8{s28[1]}});
        assign result1[2 * 8 +:8] = s36[18 * 8 +:8] | s35[18 * 8 +:8] | ({8{s31[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s33[2]}}) | {8{s28[2]}});
        assign result1[3 * 8 +:8] = s36[19 * 8 +:8] | s35[19 * 8 +:8] | ({8{s31[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s33[3]}}) | {8{s28[3]}});
        assign result1[4 * 8 +:8] = s36[20 * 8 +:8] | s35[20 * 8 +:8] | ({8{s31[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s33[4]}}) | {8{s28[4]}});
        assign result1[5 * 8 +:8] = s36[21 * 8 +:8] | s35[21 * 8 +:8] | ({8{s31[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s33[5]}}) | {8{s28[5]}});
        assign result1[6 * 8 +:8] = s36[22 * 8 +:8] | s35[22 * 8 +:8] | ({8{s31[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s33[6]}}) | {8{s28[6]}});
        assign result1[7 * 8 +:8] = s36[23 * 8 +:8] | s35[23 * 8 +:8] | ({8{s31[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s33[7]}}) | {8{s28[7]}});
        assign result1[8 * 8 +:8] = s36[24 * 8 +:8] | s35[24 * 8 +:8] | ({8{s31[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s33[8]}}) | {8{s28[8]}});
        assign result1[9 * 8 +:8] = s36[25 * 8 +:8] | s35[25 * 8 +:8] | ({8{s31[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s33[9]}}) | {8{s28[9]}});
        assign result1[10 * 8 +:8] = s36[26 * 8 +:8] | s35[26 * 8 +:8] | ({8{s31[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s33[10]}}) | {8{s28[10]}});
        assign result1[11 * 8 +:8] = s36[27 * 8 +:8] | s35[27 * 8 +:8] | ({8{s31[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s33[11]}}) | {8{s28[11]}});
        assign result1[12 * 8 +:8] = s36[28 * 8 +:8] | s35[28 * 8 +:8] | ({8{s31[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s33[12]}}) | {8{s28[12]}});
        assign result1[13 * 8 +:8] = s36[29 * 8 +:8] | s35[29 * 8 +:8] | ({8{s31[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s33[13]}}) | {8{s28[13]}});
        assign result1[14 * 8 +:8] = s36[30 * 8 +:8] | s35[30 * 8 +:8] | ({8{s31[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s33[14]}}) | {8{s28[14]}});
        assign result1[15 * 8 +:8] = s36[31 * 8 +:8] | s35[31 * 8 +:8] | ({8{s31[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s33[15]}}) | {8{s28[15]}});
    end
endgenerate
generate
    if ((VLEN == 512) && (DLEN == 256) & (VP_LEN == 128)) begin:gen_vlen512_dlen256_vplen128
        assign s16[0] = 1'b0;
        assign s16[1] = 1'b0;
        assign s16[2] = 1'b0;
        assign s16[3] = 1'b0;
        assign s16[4] = 1'b0;
        assign s16[5] = 1'b0;
        assign s16[6] = 1'b0;
        assign s16[7] = 1'b0;
        assign s16[8] = 1'b0;
        assign s16[9] = 1'b0;
        assign s16[10] = 1'b0;
        assign s16[11] = 1'b0;
        assign s16[12] = 1'b0;
        assign s16[13] = 1'b0;
        assign s16[14] = 1'b0;
        assign s16[15] = 1'b0;
        assign s17[0] = 1'b0;
        assign s17[1] = 1'b0;
        assign s17[2] = 1'b0;
        assign s17[3] = 1'b0;
        assign s17[4] = 1'b0;
        assign s17[5] = 1'b0;
        assign s17[6] = 1'b0;
        assign s17[7] = 1'b0;
        assign s17[8] = 1'b0;
        assign s17[9] = 1'b0;
        assign s17[10] = 1'b0;
        assign s17[11] = 1'b0;
        assign s17[12] = 1'b0;
        assign s17[13] = 1'b0;
        assign s17[14] = 1'b0;
        assign s17[15] = 1'b0;
        assign s22[0] = 1'b0;
        assign s18[0] = 1'b0;
        assign s22[1] = s0[15];
        assign s18[1] = 1'b0;
        assign s22[2] = s0[23];
        assign s18[2] = 1'b0;
        assign s22[3] = s0[31];
        assign s18[3] = 1'b0;
        assign s22[4] = s0[39];
        assign s18[4] = 1'b0;
        assign s22[5] = s0[47];
        assign s18[5] = 1'b0;
        assign s22[6] = s0[55];
        assign s18[6] = 1'b0;
        assign s22[7] = s0[63];
        assign s18[7] = 1'b0;
        assign s22[8] = 1'b0;
        assign s18[8] = 1'b0;
        assign s22[9] = s0[79];
        assign s18[9] = 1'b0;
        assign s22[10] = s0[87];
        assign s18[10] = 1'b0;
        assign s22[11] = s0[95];
        assign s18[11] = 1'b0;
        assign s22[12] = s0[103];
        assign s18[12] = 1'b0;
        assign s22[13] = s0[111];
        assign s18[13] = 1'b0;
        assign s22[14] = s0[119];
        assign s18[14] = 1'b0;
        assign s22[15] = s0[127];
        assign s18[15] = 1'b0;
        assign s25[0 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[1 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s19[0] = 1'b0;
        assign s19[1] = 1'b0;
        assign s19[2] = 1'b0;
        assign s19[3] = 1'b0;
        assign s19[4] = 1'b0;
        assign s19[5] = 1'b0;
        assign s19[6] = 1'b0;
        assign s19[7] = 1'b0;
        assign s19[8] = 1'b0;
        assign s19[9] = 1'b0;
        assign s19[10] = 1'b0;
        assign s19[11] = 1'b0;
        assign s19[12] = 1'b0;
        assign s19[13] = 1'b0;
        assign s19[14] = 1'b0;
        assign s19[15] = 1'b0;
        assign s23[0] = 1'b0;
        assign s20[0] = 1'b0;
        assign s23[1] = 1'b0;
        assign s20[1] = 1'b0;
        assign s23[2] = s0[23];
        assign s20[2] = 1'b0;
        assign s23[3] = s0[31];
        assign s20[3] = 1'b0;
        assign s23[4] = s0[39];
        assign s20[4] = 1'b0;
        assign s23[5] = s0[47];
        assign s20[5] = 1'b0;
        assign s23[6] = s0[55];
        assign s20[6] = 1'b0;
        assign s23[7] = s0[63];
        assign s20[7] = 1'b0;
        assign s23[8] = 1'b0;
        assign s20[8] = 1'b0;
        assign s23[9] = 1'b0;
        assign s20[9] = 1'b0;
        assign s23[10] = s0[87];
        assign s20[10] = 1'b0;
        assign s23[11] = s0[95];
        assign s20[11] = 1'b0;
        assign s23[12] = s0[103];
        assign s20[12] = 1'b0;
        assign s23[13] = s0[111];
        assign s20[13] = 1'b0;
        assign s23[14] = s0[119];
        assign s20[14] = 1'b0;
        assign s23[15] = s0[127];
        assign s20[15] = 1'b0;
        assign s26[0 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[1 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s24[0] = 1'b0;
        assign s21[0] = 1'b0;
        assign s24[1] = 1'b0;
        assign s21[1] = 1'b0;
        assign s24[2] = 1'b0;
        assign s21[2] = 1'b0;
        assign s24[3] = 1'b0;
        assign s21[3] = 1'b0;
        assign s24[4] = s0[39];
        assign s21[4] = 1'b0;
        assign s24[5] = s0[47];
        assign s21[5] = 1'b0;
        assign s24[6] = s0[55];
        assign s21[6] = 1'b0;
        assign s24[7] = s0[63];
        assign s21[7] = 1'b0;
        assign s24[8] = 1'b0;
        assign s21[8] = 1'b0;
        assign s24[9] = 1'b0;
        assign s21[9] = 1'b0;
        assign s24[10] = 1'b0;
        assign s21[10] = 1'b0;
        assign s24[11] = 1'b0;
        assign s21[11] = 1'b0;
        assign s24[12] = s0[103];
        assign s21[12] = 1'b0;
        assign s24[13] = s0[111];
        assign s21[13] = 1'b0;
        assign s24[14] = s0[119];
        assign s21[14] = 1'b0;
        assign s24[15] = s0[127];
        assign s21[15] = 1'b0;
        assign s27[0 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[1 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        kv_mux64 #(
            .W(8)
        ) u_mux0 (
            .out(s0[0 * 8 +:8]),
            .sel(idx[0 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux1 (
            .out(s0[1 * 8 +:8]),
            .sel(idx[1 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux2 (
            .out(s0[2 * 8 +:8]),
            .sel(idx[2 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux3 (
            .out(s0[3 * 8 +:8]),
            .sel(idx[3 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux4 (
            .out(s0[4 * 8 +:8]),
            .sel(idx[4 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux5 (
            .out(s0[5 * 8 +:8]),
            .sel(idx[5 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux6 (
            .out(s0[6 * 8 +:8]),
            .sel(idx[6 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux7 (
            .out(s0[7 * 8 +:8]),
            .sel(idx[7 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux8 (
            .out(s0[8 * 8 +:8]),
            .sel(idx[8 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux9 (
            .out(s0[9 * 8 +:8]),
            .sel(idx[9 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux10 (
            .out(s0[10 * 8 +:8]),
            .sel(idx[10 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux11 (
            .out(s0[11 * 8 +:8]),
            .sel(idx[11 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux12 (
            .out(s0[12 * 8 +:8]),
            .sel(idx[12 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux13 (
            .out(s0[13 * 8 +:8]),
            .sel(idx[13 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux14 (
            .out(s0[14 * 8 +:8]),
            .sel(idx[14 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux15 (
            .out(s0[15 * 8 +:8]),
            .sel(idx[15 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        assign s13[0 +:8] = {{4{s0[3] & s4}},s0[0 +:4] & {4{s1}}};
        assign s13[8 +:8] = {{4{s0[7] & s4}},s0[4 +:4] & {4{s1}}};
        assign s13[16 +:8] = {{4{s0[11] & s4}},s0[8 +:4] & {4{s1}}};
        assign s13[24 +:8] = {{4{s0[15] & s4}},s0[12 +:4] & {4{s1}}};
        assign s13[32 +:8] = {{4{s0[19] & s4}},s0[16 +:4] & {4{s1}}};
        assign s13[40 +:8] = {{4{s0[23] & s4}},s0[20 +:4] & {4{s1}}};
        assign s13[48 +:8] = {{4{s0[27] & s4}},s0[24 +:4] & {4{s1}}};
        assign s13[56 +:8] = {{4{s0[31] & s4}},s0[28 +:4] & {4{s1}}};
        assign s13[64 +:8] = {{4{s0[35] & s4}},s0[32 +:4] & {4{s1}}};
        assign s13[72 +:8] = {{4{s0[39] & s4}},s0[36 +:4] & {4{s1}}};
        assign s13[80 +:8] = {{4{s0[43] & s4}},s0[40 +:4] & {4{s1}}};
        assign s13[88 +:8] = {{4{s0[47] & s4}},s0[44 +:4] & {4{s1}}};
        assign s13[96 +:8] = {{4{s0[51] & s4}},s0[48 +:4] & {4{s1}}};
        assign s13[104 +:8] = {{4{s0[55] & s4}},s0[52 +:4] & {4{s1}}};
        assign s13[112 +:8] = {{4{s0[59] & s4}},s0[56 +:4] & {4{s1}}};
        assign s13[120 +:8] = {{4{s0[63] & s4}},s0[60 +:4] & {4{s1}}};
        assign s13[128 +:8] = {{4{s0[67] & s4}},s0[64 +:4] & {4{s1}}};
        assign s13[136 +:8] = {{4{s0[71] & s4}},s0[68 +:4] & {4{s1}}};
        assign s13[144 +:8] = {{4{s0[75] & s4}},s0[72 +:4] & {4{s1}}};
        assign s13[152 +:8] = {{4{s0[79] & s4}},s0[76 +:4] & {4{s1}}};
        assign s13[160 +:8] = {{4{s0[83] & s4}},s0[80 +:4] & {4{s1}}};
        assign s13[168 +:8] = {{4{s0[87] & s4}},s0[84 +:4] & {4{s1}}};
        assign s13[176 +:8] = {{4{s0[91] & s4}},s0[88 +:4] & {4{s1}}};
        assign s13[184 +:8] = {{4{s0[95] & s4}},s0[92 +:4] & {4{s1}}};
        assign s13[192 +:8] = {{4{s0[99] & s4}},s0[96 +:4] & {4{s1}}};
        assign s13[200 +:8] = {{4{s0[103] & s4}},s0[100 +:4] & {4{s1}}};
        assign s13[208 +:8] = {{4{s0[107] & s4}},s0[104 +:4] & {4{s1}}};
        assign s13[216 +:8] = {{4{s0[111] & s4}},s0[108 +:4] & {4{s1}}};
        assign s13[224 +:8] = {{4{s0[115] & s4}},s0[112 +:4] & {4{s1}}};
        assign s13[232 +:8] = {{4{s0[119] & s4}},s0[116 +:4] & {4{s1}}};
        assign s13[240 +:8] = {{4{s0[123] & s4}},s0[120 +:4] & {4{s1}}};
        assign s13[248 +:8] = {{4{s0[127] & s4}},s0[124 +:4] & {4{s1}}};
        assign s14[0 +:16] = {{12{s0[3] & s5}},s0[0 +:4] & {4{s2}}};
        assign s14[16 +:16] = {{12{s0[7] & s5}},s0[4 +:4] & {4{s2}}};
        assign s14[32 +:16] = {{12{s0[11] & s5}},s0[8 +:4] & {4{s2}}};
        assign s14[48 +:16] = {{12{s0[15] & s5}},s0[12 +:4] & {4{s2}}};
        assign s14[64 +:16] = {{12{s0[19] & s5}},s0[16 +:4] & {4{s2}}};
        assign s14[80 +:16] = {{12{s0[23] & s5}},s0[20 +:4] & {4{s2}}};
        assign s14[96 +:16] = {{12{s0[27] & s5}},s0[24 +:4] & {4{s2}}};
        assign s14[112 +:16] = {{12{s0[31] & s5}},s0[28 +:4] & {4{s2}}};
        assign s14[128 +:16] = {{12{s0[35] & s5}},s0[32 +:4] & {4{s2}}};
        assign s14[144 +:16] = {{12{s0[39] & s5}},s0[36 +:4] & {4{s2}}};
        assign s14[160 +:16] = {{12{s0[43] & s5}},s0[40 +:4] & {4{s2}}};
        assign s14[176 +:16] = {{12{s0[47] & s5}},s0[44 +:4] & {4{s2}}};
        assign s14[192 +:16] = {{12{s0[51] & s5}},s0[48 +:4] & {4{s2}}};
        assign s14[208 +:16] = {{12{s0[55] & s5}},s0[52 +:4] & {4{s2}}};
        assign s14[224 +:16] = {{12{s0[59] & s5}},s0[56 +:4] & {4{s2}}};
        assign s14[240 +:16] = {{12{s0[63] & s5}},s0[60 +:4] & {4{s2}}};
        assign s15[0 +:32] = {{28{s0[3] & s6}},s0[0 +:4] & {4{s3}}};
        assign s15[32 +:32] = {{28{s0[7] & s6}},s0[4 +:4] & {4{s3}}};
        assign s15[64 +:32] = {{28{s0[11] & s6}},s0[8 +:4] & {4{s3}}};
        assign s15[96 +:32] = {{28{s0[15] & s6}},s0[12 +:4] & {4{s3}}};
        assign s15[128 +:32] = {{28{s0[19] & s6}},s0[16 +:4] & {4{s3}}};
        assign s15[160 +:32] = {{28{s0[23] & s6}},s0[20 +:4] & {4{s3}}};
        assign s15[192 +:32] = {{28{s0[27] & s6}},s0[24 +:4] & {4{s3}}};
        assign s15[224 +:32] = {{28{s0[31] & s6}},s0[28 +:4] & {4{s3}}};
        wire [2 * VP_LEN - 1:0] s37;
        wire s38 = vzsext & eew8x2;
        assign s37[0 +:16] = {{8{s0[7] & s7}},s0[0 +:8] & {8{s38}}};
        assign s37[16 +:16] = {{8{s0[15] & s7}},s0[8 +:8] & {8{s38}}};
        assign s37[32 +:16] = {{8{s0[23] & s7}},s0[16 +:8] & {8{s38}}};
        assign s37[48 +:16] = {{8{s0[31] & s7}},s0[24 +:8] & {8{s38}}};
        assign s37[64 +:16] = {{8{s0[39] & s7}},s0[32 +:8] & {8{s38}}};
        assign s37[80 +:16] = {{8{s0[47] & s7}},s0[40 +:8] & {8{s38}}};
        assign s37[96 +:16] = {{8{s0[55] & s7}},s0[48 +:8] & {8{s38}}};
        assign s37[112 +:16] = {{8{s0[63] & s7}},s0[56 +:8] & {8{s38}}};
        assign s37[128 +:16] = {{8{s0[71] & s7}},s0[64 +:8] & {8{s38}}};
        assign s37[144 +:16] = {{8{s0[79] & s7}},s0[72 +:8] & {8{s38}}};
        assign s37[160 +:16] = {{8{s0[87] & s7}},s0[80 +:8] & {8{s38}}};
        assign s37[176 +:16] = {{8{s0[95] & s7}},s0[88 +:8] & {8{s38}}};
        assign s37[192 +:16] = {{8{s0[103] & s7}},s0[96 +:8] & {8{s38}}};
        assign s37[208 +:16] = {{8{s0[111] & s7}},s0[104 +:8] & {8{s38}}};
        assign s37[224 +:16] = {{8{s0[119] & s7}},s0[112 +:8] & {8{s38}}};
        assign s37[240 +:16] = {{8{s0[127] & s7}},s0[120 +:8] & {8{s38}}};
        wire [2 * VP_LEN - 1:0] s39;
        wire s40 = vzsext & eew8x4;
        assign s39[0 +:32] = {{24{s0[7] & s8}},s0[0 +:8] & {8{s40}}};
        assign s39[32 +:32] = {{24{s0[15] & s8}},s0[8 +:8] & {8{s40}}};
        assign s39[64 +:32] = {{24{s0[23] & s8}},s0[16 +:8] & {8{s40}}};
        assign s39[96 +:32] = {{24{s0[31] & s8}},s0[24 +:8] & {8{s40}}};
        assign s39[128 +:32] = {{24{s0[39] & s8}},s0[32 +:8] & {8{s40}}};
        assign s39[160 +:32] = {{24{s0[47] & s8}},s0[40 +:8] & {8{s40}}};
        assign s39[192 +:32] = {{24{s0[55] & s8}},s0[48 +:8] & {8{s40}}};
        assign s39[224 +:32] = {{24{s0[63] & s8}},s0[56 +:8] & {8{s40}}};
        wire [2 * VP_LEN - 1:0] s41;
        wire s42 = vzsext & eew8x8;
        assign s41[0 +:64] = {{56{s0[7] & s9}},s0[0 +:8] & {8{s42}}};
        assign s41[64 +:64] = {{56{s0[15] & s9}},s0[8 +:8] & {8{s42}}};
        assign s41[128 +:64] = {{56{s0[23] & s9}},s0[16 +:8] & {8{s42}}};
        assign s41[192 +:64] = {{56{s0[31] & s9}},s0[24 +:8] & {8{s42}}};
        wire [2 * VP_LEN - 1:0] s43;
        wire s44 = vzsext & eew16x2;
        assign s43[0 +:32] = {{16{s0[15] & s10}},s0[0 +:16] & {16{s44}}};
        assign s43[32 +:32] = {{16{s0[31] & s10}},s0[16 +:16] & {16{s44}}};
        assign s43[64 +:32] = {{16{s0[47] & s10}},s0[32 +:16] & {16{s44}}};
        assign s43[96 +:32] = {{16{s0[63] & s10}},s0[48 +:16] & {16{s44}}};
        assign s43[128 +:32] = {{16{s0[79] & s10}},s0[64 +:16] & {16{s44}}};
        assign s43[160 +:32] = {{16{s0[95] & s10}},s0[80 +:16] & {16{s44}}};
        assign s43[192 +:32] = {{16{s0[111] & s10}},s0[96 +:16] & {16{s44}}};
        assign s43[224 +:32] = {{16{s0[127] & s10}},s0[112 +:16] & {16{s44}}};
        wire [2 * VP_LEN - 1:0] s45;
        wire s46 = vzsext & eew16x4;
        assign s45[0 +:64] = {{48{s0[15] & s11}},s0[0 +:16] & {16{s46}}};
        assign s45[64 +:64] = {{48{s0[31] & s11}},s0[16 +:16] & {16{s46}}};
        assign s45[128 +:64] = {{48{s0[47] & s11}},s0[32 +:16] & {16{s46}}};
        assign s45[192 +:64] = {{48{s0[63] & s11}},s0[48 +:16] & {16{s46}}};
        wire [2 * VP_LEN - 1:0] s47;
        wire s48 = vzsext & eew32x2;
        assign s47[0 +:64] = {{32{s0[31] & s12}},s0[0 +:32] & {32{s48}}};
        assign s47[64 +:64] = {{32{s0[63] & s12}},s0[32 +:32] & {32{s48}}};
        assign s47[128 +:64] = {{32{s0[95] & s12}},s0[64 +:32] & {32{s48}}};
        assign s47[192 +:64] = {{32{s0[127] & s12}},s0[96 +:32] & {32{s48}}};
        wire [2 * VP_LEN - 1:0] s35;
        assign s35 = s13 | s14 | s15 | s37 | s39 | s41 | s43 | s45 | s47;
        wire [2 * VP_LEN - 1:0] s36 = {2 * VP_LEN{vmv_nr}} & {vs2_buf[VP_LEN +:VP_LEN],{VP_LEN{1'b0}}};
        assign result0[0 * 8 +:8] = s36[0 * 8 +:8] | s35[0 * 8 +:8] | ({8{s30[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s32[0]}}) | {8{s28[0]}});
        assign result0[1 * 8 +:8] = s36[1 * 8 +:8] | s35[1 * 8 +:8] | ({8{s30[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s32[1]}}) | {8{s28[1]}});
        assign result0[2 * 8 +:8] = s36[2 * 8 +:8] | s35[2 * 8 +:8] | ({8{s30[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s32[2]}}) | {8{s28[2]}});
        assign result0[3 * 8 +:8] = s36[3 * 8 +:8] | s35[3 * 8 +:8] | ({8{s30[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s32[3]}}) | {8{s28[3]}});
        assign result0[4 * 8 +:8] = s36[4 * 8 +:8] | s35[4 * 8 +:8] | ({8{s30[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s32[4]}}) | {8{s28[4]}});
        assign result0[5 * 8 +:8] = s36[5 * 8 +:8] | s35[5 * 8 +:8] | ({8{s30[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s32[5]}}) | {8{s28[5]}});
        assign result0[6 * 8 +:8] = s36[6 * 8 +:8] | s35[6 * 8 +:8] | ({8{s30[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s32[6]}}) | {8{s28[6]}});
        assign result0[7 * 8 +:8] = s36[7 * 8 +:8] | s35[7 * 8 +:8] | ({8{s30[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s32[7]}}) | {8{s28[7]}});
        assign result0[8 * 8 +:8] = s36[8 * 8 +:8] | s35[8 * 8 +:8] | ({8{s30[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s32[8]}}) | {8{s28[8]}});
        assign result0[9 * 8 +:8] = s36[9 * 8 +:8] | s35[9 * 8 +:8] | ({8{s30[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s32[9]}}) | {8{s28[9]}});
        assign result0[10 * 8 +:8] = s36[10 * 8 +:8] | s35[10 * 8 +:8] | ({8{s30[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s32[10]}}) | {8{s28[10]}});
        assign result0[11 * 8 +:8] = s36[11 * 8 +:8] | s35[11 * 8 +:8] | ({8{s30[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s32[11]}}) | {8{s28[11]}});
        assign result0[12 * 8 +:8] = s36[12 * 8 +:8] | s35[12 * 8 +:8] | ({8{s30[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s32[12]}}) | {8{s28[12]}});
        assign result0[13 * 8 +:8] = s36[13 * 8 +:8] | s35[13 * 8 +:8] | ({8{s30[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s32[13]}}) | {8{s28[13]}});
        assign result0[14 * 8 +:8] = s36[14 * 8 +:8] | s35[14 * 8 +:8] | ({8{s30[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s32[14]}}) | {8{s28[14]}});
        assign result0[15 * 8 +:8] = s36[15 * 8 +:8] | s35[15 * 8 +:8] | ({8{s30[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s32[15]}}) | {8{s28[15]}});
        assign result1[0 * 8 +:8] = s36[16 * 8 +:8] | s35[16 * 8 +:8] | ({8{s31[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s33[0]}}) | {8{s28[0]}});
        assign result1[1 * 8 +:8] = s36[17 * 8 +:8] | s35[17 * 8 +:8] | ({8{s31[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s33[1]}}) | {8{s28[1]}});
        assign result1[2 * 8 +:8] = s36[18 * 8 +:8] | s35[18 * 8 +:8] | ({8{s31[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s33[2]}}) | {8{s28[2]}});
        assign result1[3 * 8 +:8] = s36[19 * 8 +:8] | s35[19 * 8 +:8] | ({8{s31[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s33[3]}}) | {8{s28[3]}});
        assign result1[4 * 8 +:8] = s36[20 * 8 +:8] | s35[20 * 8 +:8] | ({8{s31[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s33[4]}}) | {8{s28[4]}});
        assign result1[5 * 8 +:8] = s36[21 * 8 +:8] | s35[21 * 8 +:8] | ({8{s31[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s33[5]}}) | {8{s28[5]}});
        assign result1[6 * 8 +:8] = s36[22 * 8 +:8] | s35[22 * 8 +:8] | ({8{s31[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s33[6]}}) | {8{s28[6]}});
        assign result1[7 * 8 +:8] = s36[23 * 8 +:8] | s35[23 * 8 +:8] | ({8{s31[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s33[7]}}) | {8{s28[7]}});
        assign result1[8 * 8 +:8] = s36[24 * 8 +:8] | s35[24 * 8 +:8] | ({8{s31[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s33[8]}}) | {8{s28[8]}});
        assign result1[9 * 8 +:8] = s36[25 * 8 +:8] | s35[25 * 8 +:8] | ({8{s31[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s33[9]}}) | {8{s28[9]}});
        assign result1[10 * 8 +:8] = s36[26 * 8 +:8] | s35[26 * 8 +:8] | ({8{s31[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s33[10]}}) | {8{s28[10]}});
        assign result1[11 * 8 +:8] = s36[27 * 8 +:8] | s35[27 * 8 +:8] | ({8{s31[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s33[11]}}) | {8{s28[11]}});
        assign result1[12 * 8 +:8] = s36[28 * 8 +:8] | s35[28 * 8 +:8] | ({8{s31[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s33[12]}}) | {8{s28[12]}});
        assign result1[13 * 8 +:8] = s36[29 * 8 +:8] | s35[29 * 8 +:8] | ({8{s31[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s33[13]}}) | {8{s28[13]}});
        assign result1[14 * 8 +:8] = s36[30 * 8 +:8] | s35[30 * 8 +:8] | ({8{s31[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s33[14]}}) | {8{s28[14]}});
        assign result1[15 * 8 +:8] = s36[31 * 8 +:8] | s35[31 * 8 +:8] | ({8{s31[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s33[15]}}) | {8{s28[15]}});
    end
endgenerate
generate
    if ((VLEN == 256) && (DLEN == 256) & (VP_LEN == 256)) begin:gen_vlen256_dlen256_vplen256
        assign s16[0] = 1'b0;
        assign s16[1] = s0[15];
        assign s16[2] = 1'b0;
        assign s16[3] = s0[31];
        assign s16[4] = 1'b0;
        assign s16[5] = s0[47];
        assign s16[6] = 1'b0;
        assign s16[7] = s0[63];
        assign s16[8] = 1'b0;
        assign s16[9] = s0[79];
        assign s16[10] = 1'b0;
        assign s16[11] = s0[95];
        assign s16[12] = 1'b0;
        assign s16[13] = s0[111];
        assign s16[14] = 1'b0;
        assign s16[15] = s0[127];
        assign s16[16] = 1'b0;
        assign s16[17] = s0[143];
        assign s16[18] = 1'b0;
        assign s16[19] = s0[159];
        assign s16[20] = 1'b0;
        assign s16[21] = s0[175];
        assign s16[22] = 1'b0;
        assign s16[23] = s0[191];
        assign s16[24] = 1'b0;
        assign s16[25] = s0[207];
        assign s16[26] = 1'b0;
        assign s16[27] = s0[223];
        assign s16[28] = 1'b0;
        assign s16[29] = s0[239];
        assign s16[30] = 1'b0;
        assign s16[31] = s0[255];
        assign s17[0] = 1'b0;
        assign s17[1] = s0[15];
        assign s17[2] = s0[23];
        assign s17[3] = s0[31];
        assign s17[4] = 1'b0;
        assign s17[5] = s0[47];
        assign s17[6] = s0[55];
        assign s17[7] = s0[63];
        assign s17[8] = 1'b0;
        assign s17[9] = s0[79];
        assign s17[10] = s0[87];
        assign s17[11] = s0[95];
        assign s17[12] = 1'b0;
        assign s17[13] = s0[111];
        assign s17[14] = s0[119];
        assign s17[15] = s0[127];
        assign s17[16] = 1'b0;
        assign s17[17] = s0[143];
        assign s17[18] = s0[151];
        assign s17[19] = s0[159];
        assign s17[20] = 1'b0;
        assign s17[21] = s0[175];
        assign s17[22] = s0[183];
        assign s17[23] = s0[191];
        assign s17[24] = 1'b0;
        assign s17[25] = s0[207];
        assign s17[26] = s0[215];
        assign s17[27] = s0[223];
        assign s17[28] = 1'b0;
        assign s17[29] = s0[239];
        assign s17[30] = s0[247];
        assign s17[31] = s0[255];
        assign s22[0] = 1'b0;
        assign s18[0] = 1'b0;
        assign s22[1] = s0[15];
        assign s18[1] = s0[15];
        assign s22[2] = s0[23];
        assign s18[2] = s0[23];
        assign s22[3] = s0[31];
        assign s18[3] = s0[31];
        assign s22[4] = s0[39];
        assign s18[4] = s0[39];
        assign s22[5] = s0[47];
        assign s18[5] = s0[47];
        assign s22[6] = s0[55];
        assign s18[6] = s0[55];
        assign s22[7] = s0[63];
        assign s18[7] = s0[63];
        assign s22[8] = 1'b0;
        assign s18[8] = 1'b0;
        assign s22[9] = s0[79];
        assign s18[9] = s0[79];
        assign s22[10] = s0[87];
        assign s18[10] = s0[87];
        assign s22[11] = s0[95];
        assign s18[11] = s0[95];
        assign s22[12] = s0[103];
        assign s18[12] = s0[103];
        assign s22[13] = s0[111];
        assign s18[13] = s0[111];
        assign s22[14] = s0[119];
        assign s18[14] = s0[119];
        assign s22[15] = s0[127];
        assign s18[15] = s0[127];
        assign s22[16] = 1'b0;
        assign s18[16] = 1'b0;
        assign s22[17] = s0[143];
        assign s18[17] = s0[143];
        assign s22[18] = s0[151];
        assign s18[18] = s0[151];
        assign s22[19] = s0[159];
        assign s18[19] = s0[159];
        assign s22[20] = s0[167];
        assign s18[20] = s0[167];
        assign s22[21] = s0[175];
        assign s18[21] = s0[175];
        assign s22[22] = s0[183];
        assign s18[22] = s0[183];
        assign s22[23] = s0[191];
        assign s18[23] = s0[191];
        assign s22[24] = 1'b0;
        assign s18[24] = 1'b0;
        assign s22[25] = s0[207];
        assign s18[25] = s0[207];
        assign s22[26] = s0[215];
        assign s18[26] = s0[215];
        assign s22[27] = s0[223];
        assign s18[27] = s0[223];
        assign s22[28] = s0[231];
        assign s18[28] = s0[231];
        assign s22[29] = s0[239];
        assign s18[29] = s0[239];
        assign s22[30] = s0[247];
        assign s18[30] = s0[247];
        assign s22[31] = s0[255];
        assign s18[31] = s0[255];
        assign s25[0 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[1 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[2 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[3 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s19[0] = 1'b0;
        assign s19[1] = 1'b0;
        assign s19[2] = s0[23];
        assign s19[3] = s0[31];
        assign s19[4] = 1'b0;
        assign s19[5] = 1'b0;
        assign s19[6] = s0[55];
        assign s19[7] = s0[63];
        assign s19[8] = 1'b0;
        assign s19[9] = 1'b0;
        assign s19[10] = s0[87];
        assign s19[11] = s0[95];
        assign s19[12] = 1'b0;
        assign s19[13] = 1'b0;
        assign s19[14] = s0[119];
        assign s19[15] = s0[127];
        assign s19[16] = 1'b0;
        assign s19[17] = 1'b0;
        assign s19[18] = s0[151];
        assign s19[19] = s0[159];
        assign s19[20] = 1'b0;
        assign s19[21] = 1'b0;
        assign s19[22] = s0[183];
        assign s19[23] = s0[191];
        assign s19[24] = 1'b0;
        assign s19[25] = 1'b0;
        assign s19[26] = s0[215];
        assign s19[27] = s0[223];
        assign s19[28] = 1'b0;
        assign s19[29] = 1'b0;
        assign s19[30] = s0[247];
        assign s19[31] = s0[255];
        assign s23[0] = 1'b0;
        assign s20[0] = 1'b0;
        assign s23[1] = 1'b0;
        assign s20[1] = 1'b0;
        assign s23[2] = s0[23];
        assign s20[2] = s0[23];
        assign s23[3] = s0[31];
        assign s20[3] = s0[31];
        assign s23[4] = s0[39];
        assign s20[4] = s0[39];
        assign s23[5] = s0[47];
        assign s20[5] = s0[47];
        assign s23[6] = s0[55];
        assign s20[6] = s0[55];
        assign s23[7] = s0[63];
        assign s20[7] = s0[63];
        assign s23[8] = 1'b0;
        assign s20[8] = 1'b0;
        assign s23[9] = 1'b0;
        assign s20[9] = 1'b0;
        assign s23[10] = s0[87];
        assign s20[10] = s0[87];
        assign s23[11] = s0[95];
        assign s20[11] = s0[95];
        assign s23[12] = s0[103];
        assign s20[12] = s0[103];
        assign s23[13] = s0[111];
        assign s20[13] = s0[111];
        assign s23[14] = s0[119];
        assign s20[14] = s0[119];
        assign s23[15] = s0[127];
        assign s20[15] = s0[127];
        assign s23[16] = 1'b0;
        assign s20[16] = 1'b0;
        assign s23[17] = 1'b0;
        assign s20[17] = 1'b0;
        assign s23[18] = s0[151];
        assign s20[18] = s0[151];
        assign s23[19] = s0[159];
        assign s20[19] = s0[159];
        assign s23[20] = s0[167];
        assign s20[20] = s0[167];
        assign s23[21] = s0[175];
        assign s20[21] = s0[175];
        assign s23[22] = s0[183];
        assign s20[22] = s0[183];
        assign s23[23] = s0[191];
        assign s20[23] = s0[191];
        assign s23[24] = 1'b0;
        assign s20[24] = 1'b0;
        assign s23[25] = 1'b0;
        assign s20[25] = 1'b0;
        assign s23[26] = s0[215];
        assign s20[26] = s0[215];
        assign s23[27] = s0[223];
        assign s20[27] = s0[223];
        assign s23[28] = s0[231];
        assign s20[28] = s0[231];
        assign s23[29] = s0[239];
        assign s20[29] = s0[239];
        assign s23[30] = s0[247];
        assign s20[30] = s0[247];
        assign s23[31] = s0[255];
        assign s20[31] = s0[255];
        assign s26[0 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[1 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[2 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[3 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s24[0] = 1'b0;
        assign s21[0] = 1'b0;
        assign s24[1] = 1'b0;
        assign s21[1] = 1'b0;
        assign s24[2] = 1'b0;
        assign s21[2] = 1'b0;
        assign s24[3] = 1'b0;
        assign s21[3] = 1'b0;
        assign s24[4] = s0[39];
        assign s21[4] = s0[39];
        assign s24[5] = s0[47];
        assign s21[5] = s0[47];
        assign s24[6] = s0[55];
        assign s21[6] = s0[55];
        assign s24[7] = s0[63];
        assign s21[7] = s0[63];
        assign s24[8] = 1'b0;
        assign s21[8] = 1'b0;
        assign s24[9] = 1'b0;
        assign s21[9] = 1'b0;
        assign s24[10] = 1'b0;
        assign s21[10] = 1'b0;
        assign s24[11] = 1'b0;
        assign s21[11] = 1'b0;
        assign s24[12] = s0[103];
        assign s21[12] = s0[103];
        assign s24[13] = s0[111];
        assign s21[13] = s0[111];
        assign s24[14] = s0[119];
        assign s21[14] = s0[119];
        assign s24[15] = s0[127];
        assign s21[15] = s0[127];
        assign s24[16] = 1'b0;
        assign s21[16] = 1'b0;
        assign s24[17] = 1'b0;
        assign s21[17] = 1'b0;
        assign s24[18] = 1'b0;
        assign s21[18] = 1'b0;
        assign s24[19] = 1'b0;
        assign s21[19] = 1'b0;
        assign s24[20] = s0[167];
        assign s21[20] = s0[167];
        assign s24[21] = s0[175];
        assign s21[21] = s0[175];
        assign s24[22] = s0[183];
        assign s21[22] = s0[183];
        assign s24[23] = s0[191];
        assign s21[23] = s0[191];
        assign s24[24] = 1'b0;
        assign s21[24] = 1'b0;
        assign s24[25] = 1'b0;
        assign s21[25] = 1'b0;
        assign s24[26] = 1'b0;
        assign s21[26] = 1'b0;
        assign s24[27] = 1'b0;
        assign s21[27] = 1'b0;
        assign s24[28] = s0[231];
        assign s21[28] = s0[231];
        assign s24[29] = s0[239];
        assign s21[29] = s0[239];
        assign s24[30] = s0[247];
        assign s21[30] = s0[247];
        assign s24[31] = s0[255];
        assign s21[31] = s0[255];
        assign s27[0 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[1 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[2 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[3 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        kv_mux32 #(
            .W(8)
        ) u_mux0 (
            .out(s0[0 * 8 +:8]),
            .sel(idx[0 * SW +:SW]),
            .in(vs2_buf[0 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux1 (
            .out(s0[1 * 8 +:8]),
            .sel(idx[1 * SW +:SW]),
            .in(vs2_buf[0 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux2 (
            .out(s0[2 * 8 +:8]),
            .sel(idx[2 * SW +:SW]),
            .in(vs2_buf[0 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux3 (
            .out(s0[3 * 8 +:8]),
            .sel(idx[3 * SW +:SW]),
            .in(vs2_buf[0 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux4 (
            .out(s0[4 * 8 +:8]),
            .sel(idx[4 * SW +:SW]),
            .in(vs2_buf[1 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux5 (
            .out(s0[5 * 8 +:8]),
            .sel(idx[5 * SW +:SW]),
            .in(vs2_buf[1 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux6 (
            .out(s0[6 * 8 +:8]),
            .sel(idx[6 * SW +:SW]),
            .in(vs2_buf[1 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux7 (
            .out(s0[7 * 8 +:8]),
            .sel(idx[7 * SW +:SW]),
            .in(vs2_buf[1 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux8 (
            .out(s0[8 * 8 +:8]),
            .sel(idx[8 * SW +:SW]),
            .in(vs2_buf[2 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux9 (
            .out(s0[9 * 8 +:8]),
            .sel(idx[9 * SW +:SW]),
            .in(vs2_buf[2 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux10 (
            .out(s0[10 * 8 +:8]),
            .sel(idx[10 * SW +:SW]),
            .in(vs2_buf[2 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux11 (
            .out(s0[11 * 8 +:8]),
            .sel(idx[11 * SW +:SW]),
            .in(vs2_buf[2 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux12 (
            .out(s0[12 * 8 +:8]),
            .sel(idx[12 * SW +:SW]),
            .in(vs2_buf[3 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux13 (
            .out(s0[13 * 8 +:8]),
            .sel(idx[13 * SW +:SW]),
            .in(vs2_buf[3 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux14 (
            .out(s0[14 * 8 +:8]),
            .sel(idx[14 * SW +:SW]),
            .in(vs2_buf[3 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux15 (
            .out(s0[15 * 8 +:8]),
            .sel(idx[15 * SW +:SW]),
            .in(vs2_buf[3 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux16 (
            .out(s0[16 * 8 +:8]),
            .sel(idx[16 * SW +:SW]),
            .in(vs2_buf[4 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux17 (
            .out(s0[17 * 8 +:8]),
            .sel(idx[17 * SW +:SW]),
            .in(vs2_buf[4 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux18 (
            .out(s0[18 * 8 +:8]),
            .sel(idx[18 * SW +:SW]),
            .in(vs2_buf[4 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux19 (
            .out(s0[19 * 8 +:8]),
            .sel(idx[19 * SW +:SW]),
            .in(vs2_buf[4 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux20 (
            .out(s0[20 * 8 +:8]),
            .sel(idx[20 * SW +:SW]),
            .in(vs2_buf[5 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux21 (
            .out(s0[21 * 8 +:8]),
            .sel(idx[21 * SW +:SW]),
            .in(vs2_buf[5 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux22 (
            .out(s0[22 * 8 +:8]),
            .sel(idx[22 * SW +:SW]),
            .in(vs2_buf[5 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux23 (
            .out(s0[23 * 8 +:8]),
            .sel(idx[23 * SW +:SW]),
            .in(vs2_buf[5 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux24 (
            .out(s0[24 * 8 +:8]),
            .sel(idx[24 * SW +:SW]),
            .in(vs2_buf[6 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux25 (
            .out(s0[25 * 8 +:8]),
            .sel(idx[25 * SW +:SW]),
            .in(vs2_buf[6 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux26 (
            .out(s0[26 * 8 +:8]),
            .sel(idx[26 * SW +:SW]),
            .in(vs2_buf[6 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux27 (
            .out(s0[27 * 8 +:8]),
            .sel(idx[27 * SW +:SW]),
            .in(vs2_buf[6 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux28 (
            .out(s0[28 * 8 +:8]),
            .sel(idx[28 * SW +:SW]),
            .in(vs2_buf[7 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux29 (
            .out(s0[29 * 8 +:8]),
            .sel(idx[29 * SW +:SW]),
            .in(vs2_buf[7 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux30 (
            .out(s0[30 * 8 +:8]),
            .sel(idx[30 * SW +:SW]),
            .in(vs2_buf[7 * 256 +:256])
        );
        kv_mux32 #(
            .W(8)
        ) u_mux31 (
            .out(s0[31 * 8 +:8]),
            .sel(idx[31 * SW +:SW]),
            .in(vs2_buf[7 * 256 +:256])
        );
        assign s13[0 +:8] = {{4{s0[0 + 3] & s4}},s0[0 +:4] & {4{s1}}};
        assign s13[8 +:8] = {{4{s0[15] & s4}},s0[12 +:4] & {4{s1}}};
        assign s13[16 +:8] = {{4{s0[16 + 3] & s4}},s0[16 +:4] & {4{s1}}};
        assign s13[24 +:8] = {{4{s0[31] & s4}},s0[28 +:4] & {4{s1}}};
        assign s13[32 +:8] = {{4{s0[32 + 3] & s4}},s0[32 +:4] & {4{s1}}};
        assign s13[40 +:8] = {{4{s0[47] & s4}},s0[44 +:4] & {4{s1}}};
        assign s13[48 +:8] = {{4{s0[48 + 3] & s4}},s0[48 +:4] & {4{s1}}};
        assign s13[56 +:8] = {{4{s0[63] & s4}},s0[60 +:4] & {4{s1}}};
        assign s13[64 +:8] = {{4{s0[64 + 3] & s4}},s0[64 +:4] & {4{s1}}};
        assign s13[72 +:8] = {{4{s0[79] & s4}},s0[76 +:4] & {4{s1}}};
        assign s13[80 +:8] = {{4{s0[80 + 3] & s4}},s0[80 +:4] & {4{s1}}};
        assign s13[88 +:8] = {{4{s0[95] & s4}},s0[92 +:4] & {4{s1}}};
        assign s13[96 +:8] = {{4{s0[96 + 3] & s4}},s0[96 +:4] & {4{s1}}};
        assign s13[104 +:8] = {{4{s0[111] & s4}},s0[108 +:4] & {4{s1}}};
        assign s13[112 +:8] = {{4{s0[112 + 3] & s4}},s0[112 +:4] & {4{s1}}};
        assign s13[120 +:8] = {{4{s0[127] & s4}},s0[124 +:4] & {4{s1}}};
        assign s13[128 +:8] = {{4{s0[128 + 3] & s4}},s0[128 +:4] & {4{s1}}};
        assign s13[136 +:8] = {{4{s0[143] & s4}},s0[140 +:4] & {4{s1}}};
        assign s13[144 +:8] = {{4{s0[144 + 3] & s4}},s0[144 +:4] & {4{s1}}};
        assign s13[152 +:8] = {{4{s0[159] & s4}},s0[156 +:4] & {4{s1}}};
        assign s13[160 +:8] = {{4{s0[160 + 3] & s4}},s0[160 +:4] & {4{s1}}};
        assign s13[168 +:8] = {{4{s0[175] & s4}},s0[172 +:4] & {4{s1}}};
        assign s13[176 +:8] = {{4{s0[176 + 3] & s4}},s0[176 +:4] & {4{s1}}};
        assign s13[184 +:8] = {{4{s0[191] & s4}},s0[188 +:4] & {4{s1}}};
        assign s13[192 +:8] = {{4{s0[192 + 3] & s4}},s0[192 +:4] & {4{s1}}};
        assign s13[200 +:8] = {{4{s0[207] & s4}},s0[204 +:4] & {4{s1}}};
        assign s13[208 +:8] = {{4{s0[208 + 3] & s4}},s0[208 +:4] & {4{s1}}};
        assign s13[216 +:8] = {{4{s0[223] & s4}},s0[220 +:4] & {4{s1}}};
        assign s13[224 +:8] = {{4{s0[224 + 3] & s4}},s0[224 +:4] & {4{s1}}};
        assign s13[232 +:8] = {{4{s0[239] & s4}},s0[236 +:4] & {4{s1}}};
        assign s13[240 +:8] = {{4{s0[240 + 3] & s4}},s0[240 +:4] & {4{s1}}};
        assign s13[248 +:8] = {{4{s0[255] & s4}},s0[252 +:4] & {4{s1}}};
        assign s14[0 +:16] = {{8{s0[0 + 11] & s5}},{4{s0[0 + 3] & s5}},s0[0 +:4] & {4{s2}}};
        assign s14[16 +:16] = {{8{s0[23 + 8] & s5}},{4{s0[23] & s5}},s0[20 +:4] & {4{s2}}};
        assign s14[32 +:16] = {{8{s0[32 + 11] & s5}},{4{s0[32 + 3] & s5}},s0[32 +:4] & {4{s2}}};
        assign s14[48 +:16] = {{8{s0[55 + 8] & s5}},{4{s0[55] & s5}},s0[52 +:4] & {4{s2}}};
        assign s14[64 +:16] = {{8{s0[64 + 11] & s5}},{4{s0[64 + 3] & s5}},s0[64 +:4] & {4{s2}}};
        assign s14[80 +:16] = {{8{s0[87 + 8] & s5}},{4{s0[87] & s5}},s0[84 +:4] & {4{s2}}};
        assign s14[96 +:16] = {{8{s0[96 + 11] & s5}},{4{s0[96 + 3] & s5}},s0[96 +:4] & {4{s2}}};
        assign s14[112 +:16] = {{8{s0[119 + 8] & s5}},{4{s0[119] & s5}},s0[116 +:4] & {4{s2}}};
        assign s14[128 +:16] = {{8{s0[128 + 11] & s5}},{4{s0[128 + 3] & s5}},s0[128 +:4] & {4{s2}}};
        assign s14[144 +:16] = {{8{s0[151 + 8] & s5}},{4{s0[151] & s5}},s0[148 +:4] & {4{s2}}};
        assign s14[160 +:16] = {{8{s0[160 + 11] & s5}},{4{s0[160 + 3] & s5}},s0[160 +:4] & {4{s2}}};
        assign s14[176 +:16] = {{8{s0[183 + 8] & s5}},{4{s0[183] & s5}},s0[180 +:4] & {4{s2}}};
        assign s14[192 +:16] = {{8{s0[192 + 11] & s5}},{4{s0[192 + 3] & s5}},s0[192 +:4] & {4{s2}}};
        assign s14[208 +:16] = {{8{s0[215 + 8] & s5}},{4{s0[215] & s5}},s0[212 +:4] & {4{s2}}};
        assign s14[224 +:16] = {{8{s0[224 + 11] & s5}},{4{s0[224 + 3] & s5}},s0[224 +:4] & {4{s2}}};
        assign s14[240 +:16] = {{8{s0[247 + 8] & s5}},{4{s0[247] & s5}},s0[244 +:4] & {4{s2}}};
        assign s15[0 +:32] = {{8{s0[0 + 27] & s6}},{8{s0[0 + 19] & s6}},{8{s0[0 + 11] & s6}},{4{s0[0 + 3] & s6}},s0[0 +:4] & {4{s3}}};
        assign s15[32 +:32] = {{8{s0[39 + 24] & s6}},{8{s0[39 + 16] & s6}},{8{s0[39 + 8] & s6}},{4{s0[39] & s6}},s0[36 +:4] & {4{s3}}};
        assign s15[64 +:32] = {{8{s0[64 + 27] & s6}},{8{s0[64 + 19] & s6}},{8{s0[64 + 11] & s6}},{4{s0[64 + 3] & s6}},s0[64 +:4] & {4{s3}}};
        assign s15[96 +:32] = {{8{s0[103 + 24] & s6}},{8{s0[103 + 16] & s6}},{8{s0[103 + 8] & s6}},{4{s0[103] & s6}},s0[100 +:4] & {4{s3}}};
        assign s15[128 +:32] = {{8{s0[128 + 27] & s6}},{8{s0[128 + 19] & s6}},{8{s0[128 + 11] & s6}},{4{s0[128 + 3] & s6}},s0[128 +:4] & {4{s3}}};
        assign s15[160 +:32] = {{8{s0[167 + 24] & s6}},{8{s0[167 + 16] & s6}},{8{s0[167 + 8] & s6}},{4{s0[167] & s6}},s0[164 +:4] & {4{s3}}};
        assign s15[192 +:32] = {{8{s0[192 + 27] & s6}},{8{s0[192 + 19] & s6}},{8{s0[192 + 11] & s6}},{4{s0[192 + 3] & s6}},s0[192 +:4] & {4{s3}}};
        assign s15[224 +:32] = {{8{s0[231 + 24] & s6}},{8{s0[231 + 16] & s6}},{8{s0[231 + 8] & s6}},{4{s0[231] & s6}},s0[228 +:4] & {4{s3}}};
        wire [2 * VP_LEN - 1:0] s35;
        assign s35 = {2{s13 | s14 | s15}};
        wire [2 * VP_LEN - 1:0] s36 = {2 * VP_LEN{vmv_nr}} & {vs2_buf[VP_LEN +:VP_LEN],{VP_LEN{1'b0}}};
        assign result0[0 * 8 +:8] = s36[0 * 8 +:8] | s35[0 * 8 +:8] | ({8{s30[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s32[0]}}) | {8{s28[0]}});
        assign result0[1 * 8 +:8] = s36[1 * 8 +:8] | s35[1 * 8 +:8] | ({8{s30[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s32[1]}}) | {8{s28[1]}});
        assign result0[2 * 8 +:8] = s36[2 * 8 +:8] | s35[2 * 8 +:8] | ({8{s30[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s32[2]}}) | {8{s28[2]}});
        assign result0[3 * 8 +:8] = s36[3 * 8 +:8] | s35[3 * 8 +:8] | ({8{s30[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s32[3]}}) | {8{s28[3]}});
        assign result0[4 * 8 +:8] = s36[4 * 8 +:8] | s35[4 * 8 +:8] | ({8{s30[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s32[4]}}) | {8{s28[4]}});
        assign result0[5 * 8 +:8] = s36[5 * 8 +:8] | s35[5 * 8 +:8] | ({8{s30[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s32[5]}}) | {8{s28[5]}});
        assign result0[6 * 8 +:8] = s36[6 * 8 +:8] | s35[6 * 8 +:8] | ({8{s30[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s32[6]}}) | {8{s28[6]}});
        assign result0[7 * 8 +:8] = s36[7 * 8 +:8] | s35[7 * 8 +:8] | ({8{s30[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s32[7]}}) | {8{s28[7]}});
        assign result0[8 * 8 +:8] = s36[8 * 8 +:8] | s35[8 * 8 +:8] | ({8{s30[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s32[8]}}) | {8{s28[8]}});
        assign result0[9 * 8 +:8] = s36[9 * 8 +:8] | s35[9 * 8 +:8] | ({8{s30[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s32[9]}}) | {8{s28[9]}});
        assign result0[10 * 8 +:8] = s36[10 * 8 +:8] | s35[10 * 8 +:8] | ({8{s30[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s32[10]}}) | {8{s28[10]}});
        assign result0[11 * 8 +:8] = s36[11 * 8 +:8] | s35[11 * 8 +:8] | ({8{s30[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s32[11]}}) | {8{s28[11]}});
        assign result0[12 * 8 +:8] = s36[12 * 8 +:8] | s35[12 * 8 +:8] | ({8{s30[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s32[12]}}) | {8{s28[12]}});
        assign result0[13 * 8 +:8] = s36[13 * 8 +:8] | s35[13 * 8 +:8] | ({8{s30[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s32[13]}}) | {8{s28[13]}});
        assign result0[14 * 8 +:8] = s36[14 * 8 +:8] | s35[14 * 8 +:8] | ({8{s30[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s32[14]}}) | {8{s28[14]}});
        assign result0[15 * 8 +:8] = s36[15 * 8 +:8] | s35[15 * 8 +:8] | ({8{s30[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s32[15]}}) | {8{s28[15]}});
        assign result0[16 * 8 +:8] = s36[16 * 8 +:8] | s35[16 * 8 +:8] | ({8{s30[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s32[16]}}) | {8{s28[16]}});
        assign result0[17 * 8 +:8] = s36[17 * 8 +:8] | s35[17 * 8 +:8] | ({8{s30[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s32[17]}}) | {8{s28[17]}});
        assign result0[18 * 8 +:8] = s36[18 * 8 +:8] | s35[18 * 8 +:8] | ({8{s30[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s32[18]}}) | {8{s28[18]}});
        assign result0[19 * 8 +:8] = s36[19 * 8 +:8] | s35[19 * 8 +:8] | ({8{s30[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s32[19]}}) | {8{s28[19]}});
        assign result0[20 * 8 +:8] = s36[20 * 8 +:8] | s35[20 * 8 +:8] | ({8{s30[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s32[20]}}) | {8{s28[20]}});
        assign result0[21 * 8 +:8] = s36[21 * 8 +:8] | s35[21 * 8 +:8] | ({8{s30[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s32[21]}}) | {8{s28[21]}});
        assign result0[22 * 8 +:8] = s36[22 * 8 +:8] | s35[22 * 8 +:8] | ({8{s30[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s32[22]}}) | {8{s28[22]}});
        assign result0[23 * 8 +:8] = s36[23 * 8 +:8] | s35[23 * 8 +:8] | ({8{s30[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s32[23]}}) | {8{s28[23]}});
        assign result0[24 * 8 +:8] = s36[24 * 8 +:8] | s35[24 * 8 +:8] | ({8{s30[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s32[24]}}) | {8{s28[24]}});
        assign result0[25 * 8 +:8] = s36[25 * 8 +:8] | s35[25 * 8 +:8] | ({8{s30[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s32[25]}}) | {8{s28[25]}});
        assign result0[26 * 8 +:8] = s36[26 * 8 +:8] | s35[26 * 8 +:8] | ({8{s30[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s32[26]}}) | {8{s28[26]}});
        assign result0[27 * 8 +:8] = s36[27 * 8 +:8] | s35[27 * 8 +:8] | ({8{s30[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s32[27]}}) | {8{s28[27]}});
        assign result0[28 * 8 +:8] = s36[28 * 8 +:8] | s35[28 * 8 +:8] | ({8{s30[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s32[28]}}) | {8{s28[28]}});
        assign result0[29 * 8 +:8] = s36[29 * 8 +:8] | s35[29 * 8 +:8] | ({8{s30[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s32[29]}}) | {8{s28[29]}});
        assign result0[30 * 8 +:8] = s36[30 * 8 +:8] | s35[30 * 8 +:8] | ({8{s30[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s32[30]}}) | {8{s28[30]}});
        assign result0[31 * 8 +:8] = s36[31 * 8 +:8] | s35[31 * 8 +:8] | ({8{s30[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s32[31]}}) | {8{s28[31]}});
        assign result1[0 * 8 +:8] = s36[32 * 8 +:8] | s35[32 * 8 +:8] | ({8{s31[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s33[0]}}) | {8{s28[0]}});
        assign result1[1 * 8 +:8] = s36[33 * 8 +:8] | s35[33 * 8 +:8] | ({8{s31[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s33[1]}}) | {8{s28[1]}});
        assign result1[2 * 8 +:8] = s36[34 * 8 +:8] | s35[34 * 8 +:8] | ({8{s31[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s33[2]}}) | {8{s28[2]}});
        assign result1[3 * 8 +:8] = s36[35 * 8 +:8] | s35[35 * 8 +:8] | ({8{s31[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s33[3]}}) | {8{s28[3]}});
        assign result1[4 * 8 +:8] = s36[36 * 8 +:8] | s35[36 * 8 +:8] | ({8{s31[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s33[4]}}) | {8{s28[4]}});
        assign result1[5 * 8 +:8] = s36[37 * 8 +:8] | s35[37 * 8 +:8] | ({8{s31[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s33[5]}}) | {8{s28[5]}});
        assign result1[6 * 8 +:8] = s36[38 * 8 +:8] | s35[38 * 8 +:8] | ({8{s31[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s33[6]}}) | {8{s28[6]}});
        assign result1[7 * 8 +:8] = s36[39 * 8 +:8] | s35[39 * 8 +:8] | ({8{s31[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s33[7]}}) | {8{s28[7]}});
        assign result1[8 * 8 +:8] = s36[40 * 8 +:8] | s35[40 * 8 +:8] | ({8{s31[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s33[8]}}) | {8{s28[8]}});
        assign result1[9 * 8 +:8] = s36[41 * 8 +:8] | s35[41 * 8 +:8] | ({8{s31[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s33[9]}}) | {8{s28[9]}});
        assign result1[10 * 8 +:8] = s36[42 * 8 +:8] | s35[42 * 8 +:8] | ({8{s31[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s33[10]}}) | {8{s28[10]}});
        assign result1[11 * 8 +:8] = s36[43 * 8 +:8] | s35[43 * 8 +:8] | ({8{s31[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s33[11]}}) | {8{s28[11]}});
        assign result1[12 * 8 +:8] = s36[44 * 8 +:8] | s35[44 * 8 +:8] | ({8{s31[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s33[12]}}) | {8{s28[12]}});
        assign result1[13 * 8 +:8] = s36[45 * 8 +:8] | s35[45 * 8 +:8] | ({8{s31[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s33[13]}}) | {8{s28[13]}});
        assign result1[14 * 8 +:8] = s36[46 * 8 +:8] | s35[46 * 8 +:8] | ({8{s31[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s33[14]}}) | {8{s28[14]}});
        assign result1[15 * 8 +:8] = s36[47 * 8 +:8] | s35[47 * 8 +:8] | ({8{s31[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s33[15]}}) | {8{s28[15]}});
        assign result1[16 * 8 +:8] = s36[48 * 8 +:8] | s35[48 * 8 +:8] | ({8{s31[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s33[16]}}) | {8{s28[16]}});
        assign result1[17 * 8 +:8] = s36[49 * 8 +:8] | s35[49 * 8 +:8] | ({8{s31[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s33[17]}}) | {8{s28[17]}});
        assign result1[18 * 8 +:8] = s36[50 * 8 +:8] | s35[50 * 8 +:8] | ({8{s31[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s33[18]}}) | {8{s28[18]}});
        assign result1[19 * 8 +:8] = s36[51 * 8 +:8] | s35[51 * 8 +:8] | ({8{s31[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s33[19]}}) | {8{s28[19]}});
        assign result1[20 * 8 +:8] = s36[52 * 8 +:8] | s35[52 * 8 +:8] | ({8{s31[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s33[20]}}) | {8{s28[20]}});
        assign result1[21 * 8 +:8] = s36[53 * 8 +:8] | s35[53 * 8 +:8] | ({8{s31[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s33[21]}}) | {8{s28[21]}});
        assign result1[22 * 8 +:8] = s36[54 * 8 +:8] | s35[54 * 8 +:8] | ({8{s31[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s33[22]}}) | {8{s28[22]}});
        assign result1[23 * 8 +:8] = s36[55 * 8 +:8] | s35[55 * 8 +:8] | ({8{s31[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s33[23]}}) | {8{s28[23]}});
        assign result1[24 * 8 +:8] = s36[56 * 8 +:8] | s35[56 * 8 +:8] | ({8{s31[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s33[24]}}) | {8{s28[24]}});
        assign result1[25 * 8 +:8] = s36[57 * 8 +:8] | s35[57 * 8 +:8] | ({8{s31[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s33[25]}}) | {8{s28[25]}});
        assign result1[26 * 8 +:8] = s36[58 * 8 +:8] | s35[58 * 8 +:8] | ({8{s31[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s33[26]}}) | {8{s28[26]}});
        assign result1[27 * 8 +:8] = s36[59 * 8 +:8] | s35[59 * 8 +:8] | ({8{s31[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s33[27]}}) | {8{s28[27]}});
        assign result1[28 * 8 +:8] = s36[60 * 8 +:8] | s35[60 * 8 +:8] | ({8{s31[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s33[28]}}) | {8{s28[28]}});
        assign result1[29 * 8 +:8] = s36[61 * 8 +:8] | s35[61 * 8 +:8] | ({8{s31[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s33[29]}}) | {8{s28[29]}});
        assign result1[30 * 8 +:8] = s36[62 * 8 +:8] | s35[62 * 8 +:8] | ({8{s31[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s33[30]}}) | {8{s28[30]}});
        assign result1[31 * 8 +:8] = s36[63 * 8 +:8] | s35[63 * 8 +:8] | ({8{s31[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s33[31]}}) | {8{s28[31]}});
    end
endgenerate
generate
    if ((VLEN == 512) && (DLEN == 256) & (VP_LEN == 256)) begin:gen_vlen512_dlen256_vplen256
        assign s16[0] = 1'b0;
        assign s16[1] = s0[15];
        assign s16[2] = 1'b0;
        assign s16[3] = s0[31];
        assign s16[4] = 1'b0;
        assign s16[5] = s0[47];
        assign s16[6] = 1'b0;
        assign s16[7] = s0[63];
        assign s16[8] = 1'b0;
        assign s16[9] = s0[79];
        assign s16[10] = 1'b0;
        assign s16[11] = s0[95];
        assign s16[12] = 1'b0;
        assign s16[13] = s0[111];
        assign s16[14] = 1'b0;
        assign s16[15] = s0[127];
        assign s16[16] = 1'b0;
        assign s16[17] = s0[143];
        assign s16[18] = 1'b0;
        assign s16[19] = s0[159];
        assign s16[20] = 1'b0;
        assign s16[21] = s0[175];
        assign s16[22] = 1'b0;
        assign s16[23] = s0[191];
        assign s16[24] = 1'b0;
        assign s16[25] = s0[207];
        assign s16[26] = 1'b0;
        assign s16[27] = s0[223];
        assign s16[28] = 1'b0;
        assign s16[29] = s0[239];
        assign s16[30] = 1'b0;
        assign s16[31] = s0[255];
        assign s17[0] = 1'b0;
        assign s17[1] = s0[15];
        assign s17[2] = s0[23];
        assign s17[3] = s0[31];
        assign s17[4] = 1'b0;
        assign s17[5] = s0[47];
        assign s17[6] = s0[55];
        assign s17[7] = s0[63];
        assign s17[8] = 1'b0;
        assign s17[9] = s0[79];
        assign s17[10] = s0[87];
        assign s17[11] = s0[95];
        assign s17[12] = 1'b0;
        assign s17[13] = s0[111];
        assign s17[14] = s0[119];
        assign s17[15] = s0[127];
        assign s17[16] = 1'b0;
        assign s17[17] = s0[143];
        assign s17[18] = s0[151];
        assign s17[19] = s0[159];
        assign s17[20] = 1'b0;
        assign s17[21] = s0[175];
        assign s17[22] = s0[183];
        assign s17[23] = s0[191];
        assign s17[24] = 1'b0;
        assign s17[25] = s0[207];
        assign s17[26] = s0[215];
        assign s17[27] = s0[223];
        assign s17[28] = 1'b0;
        assign s17[29] = s0[239];
        assign s17[30] = s0[247];
        assign s17[31] = s0[255];
        assign s22[0] = 1'b0;
        assign s18[0] = 1'b0;
        assign s22[1] = s0[15];
        assign s18[1] = s0[15];
        assign s22[2] = s0[23];
        assign s18[2] = s0[23];
        assign s22[3] = s0[31];
        assign s18[3] = s0[31];
        assign s22[4] = s0[39];
        assign s18[4] = s0[39];
        assign s22[5] = s0[47];
        assign s18[5] = s0[47];
        assign s22[6] = s0[55];
        assign s18[6] = s0[55];
        assign s22[7] = s0[63];
        assign s18[7] = s0[63];
        assign s22[8] = 1'b0;
        assign s18[8] = 1'b0;
        assign s22[9] = s0[79];
        assign s18[9] = s0[79];
        assign s22[10] = s0[87];
        assign s18[10] = s0[87];
        assign s22[11] = s0[95];
        assign s18[11] = s0[95];
        assign s22[12] = s0[103];
        assign s18[12] = s0[103];
        assign s22[13] = s0[111];
        assign s18[13] = s0[111];
        assign s22[14] = s0[119];
        assign s18[14] = s0[119];
        assign s22[15] = s0[127];
        assign s18[15] = s0[127];
        assign s22[16] = 1'b0;
        assign s18[16] = 1'b0;
        assign s22[17] = s0[143];
        assign s18[17] = s0[143];
        assign s22[18] = s0[151];
        assign s18[18] = s0[151];
        assign s22[19] = s0[159];
        assign s18[19] = s0[159];
        assign s22[20] = s0[167];
        assign s18[20] = s0[167];
        assign s22[21] = s0[175];
        assign s18[21] = s0[175];
        assign s22[22] = s0[183];
        assign s18[22] = s0[183];
        assign s22[23] = s0[191];
        assign s18[23] = s0[191];
        assign s22[24] = 1'b0;
        assign s18[24] = 1'b0;
        assign s22[25] = s0[207];
        assign s18[25] = s0[207];
        assign s22[26] = s0[215];
        assign s18[26] = s0[215];
        assign s22[27] = s0[223];
        assign s18[27] = s0[223];
        assign s22[28] = s0[231];
        assign s18[28] = s0[231];
        assign s22[29] = s0[239];
        assign s18[29] = s0[239];
        assign s22[30] = s0[247];
        assign s18[30] = s0[247];
        assign s22[31] = s0[255];
        assign s18[31] = s0[255];
        assign s25[0 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[1 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[2 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[3 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s19[0] = 1'b0;
        assign s19[1] = 1'b0;
        assign s19[2] = s0[23];
        assign s19[3] = s0[31];
        assign s19[4] = 1'b0;
        assign s19[5] = 1'b0;
        assign s19[6] = s0[55];
        assign s19[7] = s0[63];
        assign s19[8] = 1'b0;
        assign s19[9] = 1'b0;
        assign s19[10] = s0[87];
        assign s19[11] = s0[95];
        assign s19[12] = 1'b0;
        assign s19[13] = 1'b0;
        assign s19[14] = s0[119];
        assign s19[15] = s0[127];
        assign s19[16] = 1'b0;
        assign s19[17] = 1'b0;
        assign s19[18] = s0[151];
        assign s19[19] = s0[159];
        assign s19[20] = 1'b0;
        assign s19[21] = 1'b0;
        assign s19[22] = s0[183];
        assign s19[23] = s0[191];
        assign s19[24] = 1'b0;
        assign s19[25] = 1'b0;
        assign s19[26] = s0[215];
        assign s19[27] = s0[223];
        assign s19[28] = 1'b0;
        assign s19[29] = 1'b0;
        assign s19[30] = s0[247];
        assign s19[31] = s0[255];
        assign s23[0] = 1'b0;
        assign s20[0] = 1'b0;
        assign s23[1] = 1'b0;
        assign s20[1] = 1'b0;
        assign s23[2] = s0[23];
        assign s20[2] = s0[23];
        assign s23[3] = s0[31];
        assign s20[3] = s0[31];
        assign s23[4] = s0[39];
        assign s20[4] = s0[39];
        assign s23[5] = s0[47];
        assign s20[5] = s0[47];
        assign s23[6] = s0[55];
        assign s20[6] = s0[55];
        assign s23[7] = s0[63];
        assign s20[7] = s0[63];
        assign s23[8] = 1'b0;
        assign s20[8] = 1'b0;
        assign s23[9] = 1'b0;
        assign s20[9] = 1'b0;
        assign s23[10] = s0[87];
        assign s20[10] = s0[87];
        assign s23[11] = s0[95];
        assign s20[11] = s0[95];
        assign s23[12] = s0[103];
        assign s20[12] = s0[103];
        assign s23[13] = s0[111];
        assign s20[13] = s0[111];
        assign s23[14] = s0[119];
        assign s20[14] = s0[119];
        assign s23[15] = s0[127];
        assign s20[15] = s0[127];
        assign s23[16] = 1'b0;
        assign s20[16] = 1'b0;
        assign s23[17] = 1'b0;
        assign s20[17] = 1'b0;
        assign s23[18] = s0[151];
        assign s20[18] = s0[151];
        assign s23[19] = s0[159];
        assign s20[19] = s0[159];
        assign s23[20] = s0[167];
        assign s20[20] = s0[167];
        assign s23[21] = s0[175];
        assign s20[21] = s0[175];
        assign s23[22] = s0[183];
        assign s20[22] = s0[183];
        assign s23[23] = s0[191];
        assign s20[23] = s0[191];
        assign s23[24] = 1'b0;
        assign s20[24] = 1'b0;
        assign s23[25] = 1'b0;
        assign s20[25] = 1'b0;
        assign s23[26] = s0[215];
        assign s20[26] = s0[215];
        assign s23[27] = s0[223];
        assign s20[27] = s0[223];
        assign s23[28] = s0[231];
        assign s20[28] = s0[231];
        assign s23[29] = s0[239];
        assign s20[29] = s0[239];
        assign s23[30] = s0[247];
        assign s20[30] = s0[247];
        assign s23[31] = s0[255];
        assign s20[31] = s0[255];
        assign s26[0 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[1 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[2 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[3 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s24[0] = 1'b0;
        assign s21[0] = 1'b0;
        assign s24[1] = 1'b0;
        assign s21[1] = 1'b0;
        assign s24[2] = 1'b0;
        assign s21[2] = 1'b0;
        assign s24[3] = 1'b0;
        assign s21[3] = 1'b0;
        assign s24[4] = s0[39];
        assign s21[4] = s0[39];
        assign s24[5] = s0[47];
        assign s21[5] = s0[47];
        assign s24[6] = s0[55];
        assign s21[6] = s0[55];
        assign s24[7] = s0[63];
        assign s21[7] = s0[63];
        assign s24[8] = 1'b0;
        assign s21[8] = 1'b0;
        assign s24[9] = 1'b0;
        assign s21[9] = 1'b0;
        assign s24[10] = 1'b0;
        assign s21[10] = 1'b0;
        assign s24[11] = 1'b0;
        assign s21[11] = 1'b0;
        assign s24[12] = s0[103];
        assign s21[12] = s0[103];
        assign s24[13] = s0[111];
        assign s21[13] = s0[111];
        assign s24[14] = s0[119];
        assign s21[14] = s0[119];
        assign s24[15] = s0[127];
        assign s21[15] = s0[127];
        assign s24[16] = 1'b0;
        assign s21[16] = 1'b0;
        assign s24[17] = 1'b0;
        assign s21[17] = 1'b0;
        assign s24[18] = 1'b0;
        assign s21[18] = 1'b0;
        assign s24[19] = 1'b0;
        assign s21[19] = 1'b0;
        assign s24[20] = s0[167];
        assign s21[20] = s0[167];
        assign s24[21] = s0[175];
        assign s21[21] = s0[175];
        assign s24[22] = s0[183];
        assign s21[22] = s0[183];
        assign s24[23] = s0[191];
        assign s21[23] = s0[191];
        assign s24[24] = 1'b0;
        assign s21[24] = 1'b0;
        assign s24[25] = 1'b0;
        assign s21[25] = 1'b0;
        assign s24[26] = 1'b0;
        assign s21[26] = 1'b0;
        assign s24[27] = 1'b0;
        assign s21[27] = 1'b0;
        assign s24[28] = s0[231];
        assign s21[28] = s0[231];
        assign s24[29] = s0[239];
        assign s21[29] = s0[239];
        assign s24[30] = s0[247];
        assign s21[30] = s0[247];
        assign s24[31] = s0[255];
        assign s21[31] = s0[255];
        assign s27[0 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[1 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[2 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[3 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        kv_mux64 #(
            .W(8)
        ) u_mux0 (
            .out(s0[0 * 8 +:8]),
            .sel(idx[0 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux1 (
            .out(s0[1 * 8 +:8]),
            .sel(idx[1 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux2 (
            .out(s0[2 * 8 +:8]),
            .sel(idx[2 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux3 (
            .out(s0[3 * 8 +:8]),
            .sel(idx[3 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux4 (
            .out(s0[4 * 8 +:8]),
            .sel(idx[4 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux5 (
            .out(s0[5 * 8 +:8]),
            .sel(idx[5 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux6 (
            .out(s0[6 * 8 +:8]),
            .sel(idx[6 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux7 (
            .out(s0[7 * 8 +:8]),
            .sel(idx[7 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux8 (
            .out(s0[8 * 8 +:8]),
            .sel(idx[8 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux9 (
            .out(s0[9 * 8 +:8]),
            .sel(idx[9 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux10 (
            .out(s0[10 * 8 +:8]),
            .sel(idx[10 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux11 (
            .out(s0[11 * 8 +:8]),
            .sel(idx[11 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux12 (
            .out(s0[12 * 8 +:8]),
            .sel(idx[12 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux13 (
            .out(s0[13 * 8 +:8]),
            .sel(idx[13 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux14 (
            .out(s0[14 * 8 +:8]),
            .sel(idx[14 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux15 (
            .out(s0[15 * 8 +:8]),
            .sel(idx[15 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux16 (
            .out(s0[16 * 8 +:8]),
            .sel(idx[16 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux17 (
            .out(s0[17 * 8 +:8]),
            .sel(idx[17 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux18 (
            .out(s0[18 * 8 +:8]),
            .sel(idx[18 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux19 (
            .out(s0[19 * 8 +:8]),
            .sel(idx[19 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux20 (
            .out(s0[20 * 8 +:8]),
            .sel(idx[20 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux21 (
            .out(s0[21 * 8 +:8]),
            .sel(idx[21 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux22 (
            .out(s0[22 * 8 +:8]),
            .sel(idx[22 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux23 (
            .out(s0[23 * 8 +:8]),
            .sel(idx[23 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux24 (
            .out(s0[24 * 8 +:8]),
            .sel(idx[24 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux25 (
            .out(s0[25 * 8 +:8]),
            .sel(idx[25 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux26 (
            .out(s0[26 * 8 +:8]),
            .sel(idx[26 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux27 (
            .out(s0[27 * 8 +:8]),
            .sel(idx[27 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux28 (
            .out(s0[28 * 8 +:8]),
            .sel(idx[28 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux29 (
            .out(s0[29 * 8 +:8]),
            .sel(idx[29 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux30 (
            .out(s0[30 * 8 +:8]),
            .sel(idx[30 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux31 (
            .out(s0[31 * 8 +:8]),
            .sel(idx[31 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        assign s13[0 +:8] = {{4{s0[0 + 3] & s4}},s0[0 +:4] & {4{s1}}};
        assign s13[8 +:8] = {{4{s0[15] & s4}},s0[12 +:4] & {4{s1}}};
        assign s13[16 +:8] = {{4{s0[16 + 3] & s4}},s0[16 +:4] & {4{s1}}};
        assign s13[24 +:8] = {{4{s0[31] & s4}},s0[28 +:4] & {4{s1}}};
        assign s13[32 +:8] = {{4{s0[32 + 3] & s4}},s0[32 +:4] & {4{s1}}};
        assign s13[40 +:8] = {{4{s0[47] & s4}},s0[44 +:4] & {4{s1}}};
        assign s13[48 +:8] = {{4{s0[48 + 3] & s4}},s0[48 +:4] & {4{s1}}};
        assign s13[56 +:8] = {{4{s0[63] & s4}},s0[60 +:4] & {4{s1}}};
        assign s13[64 +:8] = {{4{s0[64 + 3] & s4}},s0[64 +:4] & {4{s1}}};
        assign s13[72 +:8] = {{4{s0[79] & s4}},s0[76 +:4] & {4{s1}}};
        assign s13[80 +:8] = {{4{s0[80 + 3] & s4}},s0[80 +:4] & {4{s1}}};
        assign s13[88 +:8] = {{4{s0[95] & s4}},s0[92 +:4] & {4{s1}}};
        assign s13[96 +:8] = {{4{s0[96 + 3] & s4}},s0[96 +:4] & {4{s1}}};
        assign s13[104 +:8] = {{4{s0[111] & s4}},s0[108 +:4] & {4{s1}}};
        assign s13[112 +:8] = {{4{s0[112 + 3] & s4}},s0[112 +:4] & {4{s1}}};
        assign s13[120 +:8] = {{4{s0[127] & s4}},s0[124 +:4] & {4{s1}}};
        assign s13[128 +:8] = {{4{s0[128 + 3] & s4}},s0[128 +:4] & {4{s1}}};
        assign s13[136 +:8] = {{4{s0[143] & s4}},s0[140 +:4] & {4{s1}}};
        assign s13[144 +:8] = {{4{s0[144 + 3] & s4}},s0[144 +:4] & {4{s1}}};
        assign s13[152 +:8] = {{4{s0[159] & s4}},s0[156 +:4] & {4{s1}}};
        assign s13[160 +:8] = {{4{s0[160 + 3] & s4}},s0[160 +:4] & {4{s1}}};
        assign s13[168 +:8] = {{4{s0[175] & s4}},s0[172 +:4] & {4{s1}}};
        assign s13[176 +:8] = {{4{s0[176 + 3] & s4}},s0[176 +:4] & {4{s1}}};
        assign s13[184 +:8] = {{4{s0[191] & s4}},s0[188 +:4] & {4{s1}}};
        assign s13[192 +:8] = {{4{s0[192 + 3] & s4}},s0[192 +:4] & {4{s1}}};
        assign s13[200 +:8] = {{4{s0[207] & s4}},s0[204 +:4] & {4{s1}}};
        assign s13[208 +:8] = {{4{s0[208 + 3] & s4}},s0[208 +:4] & {4{s1}}};
        assign s13[216 +:8] = {{4{s0[223] & s4}},s0[220 +:4] & {4{s1}}};
        assign s13[224 +:8] = {{4{s0[224 + 3] & s4}},s0[224 +:4] & {4{s1}}};
        assign s13[232 +:8] = {{4{s0[239] & s4}},s0[236 +:4] & {4{s1}}};
        assign s13[240 +:8] = {{4{s0[240 + 3] & s4}},s0[240 +:4] & {4{s1}}};
        assign s13[248 +:8] = {{4{s0[255] & s4}},s0[252 +:4] & {4{s1}}};
        assign s14[0 +:16] = {{8{s0[0 + 11] & s5}},{4{s0[0 + 3] & s5}},s0[0 +:4] & {4{s2}}};
        assign s14[16 +:16] = {{8{s0[23 + 8] & s5}},{4{s0[23] & s5}},s0[20 +:4] & {4{s2}}};
        assign s14[32 +:16] = {{8{s0[32 + 11] & s5}},{4{s0[32 + 3] & s5}},s0[32 +:4] & {4{s2}}};
        assign s14[48 +:16] = {{8{s0[55 + 8] & s5}},{4{s0[55] & s5}},s0[52 +:4] & {4{s2}}};
        assign s14[64 +:16] = {{8{s0[64 + 11] & s5}},{4{s0[64 + 3] & s5}},s0[64 +:4] & {4{s2}}};
        assign s14[80 +:16] = {{8{s0[87 + 8] & s5}},{4{s0[87] & s5}},s0[84 +:4] & {4{s2}}};
        assign s14[96 +:16] = {{8{s0[96 + 11] & s5}},{4{s0[96 + 3] & s5}},s0[96 +:4] & {4{s2}}};
        assign s14[112 +:16] = {{8{s0[119 + 8] & s5}},{4{s0[119] & s5}},s0[116 +:4] & {4{s2}}};
        assign s14[128 +:16] = {{8{s0[128 + 11] & s5}},{4{s0[128 + 3] & s5}},s0[128 +:4] & {4{s2}}};
        assign s14[144 +:16] = {{8{s0[151 + 8] & s5}},{4{s0[151] & s5}},s0[148 +:4] & {4{s2}}};
        assign s14[160 +:16] = {{8{s0[160 + 11] & s5}},{4{s0[160 + 3] & s5}},s0[160 +:4] & {4{s2}}};
        assign s14[176 +:16] = {{8{s0[183 + 8] & s5}},{4{s0[183] & s5}},s0[180 +:4] & {4{s2}}};
        assign s14[192 +:16] = {{8{s0[192 + 11] & s5}},{4{s0[192 + 3] & s5}},s0[192 +:4] & {4{s2}}};
        assign s14[208 +:16] = {{8{s0[215 + 8] & s5}},{4{s0[215] & s5}},s0[212 +:4] & {4{s2}}};
        assign s14[224 +:16] = {{8{s0[224 + 11] & s5}},{4{s0[224 + 3] & s5}},s0[224 +:4] & {4{s2}}};
        assign s14[240 +:16] = {{8{s0[247 + 8] & s5}},{4{s0[247] & s5}},s0[244 +:4] & {4{s2}}};
        assign s15[0 +:32] = {{8{s0[0 + 27] & s6}},{8{s0[0 + 19] & s6}},{8{s0[0 + 11] & s6}},{4{s0[0 + 3] & s6}},s0[0 +:4] & {4{s3}}};
        assign s15[32 +:32] = {{8{s0[39 + 24] & s6}},{8{s0[39 + 16] & s6}},{8{s0[39 + 8] & s6}},{4{s0[39] & s6}},s0[36 +:4] & {4{s3}}};
        assign s15[64 +:32] = {{8{s0[64 + 27] & s6}},{8{s0[64 + 19] & s6}},{8{s0[64 + 11] & s6}},{4{s0[64 + 3] & s6}},s0[64 +:4] & {4{s3}}};
        assign s15[96 +:32] = {{8{s0[103 + 24] & s6}},{8{s0[103 + 16] & s6}},{8{s0[103 + 8] & s6}},{4{s0[103] & s6}},s0[100 +:4] & {4{s3}}};
        assign s15[128 +:32] = {{8{s0[128 + 27] & s6}},{8{s0[128 + 19] & s6}},{8{s0[128 + 11] & s6}},{4{s0[128 + 3] & s6}},s0[128 +:4] & {4{s3}}};
        assign s15[160 +:32] = {{8{s0[167 + 24] & s6}},{8{s0[167 + 16] & s6}},{8{s0[167 + 8] & s6}},{4{s0[167] & s6}},s0[164 +:4] & {4{s3}}};
        assign s15[192 +:32] = {{8{s0[192 + 27] & s6}},{8{s0[192 + 19] & s6}},{8{s0[192 + 11] & s6}},{4{s0[192 + 3] & s6}},s0[192 +:4] & {4{s3}}};
        assign s15[224 +:32] = {{8{s0[231 + 24] & s6}},{8{s0[231 + 16] & s6}},{8{s0[231 + 8] & s6}},{4{s0[231] & s6}},s0[228 +:4] & {4{s3}}};
        wire [2 * VP_LEN - 1:0] s35;
        assign s35 = {2{s13 | s14 | s15}};
        wire [2 * VP_LEN - 1:0] s36 = {2 * VP_LEN{vmv_nr}} & {vs2_buf[VP_LEN +:VP_LEN],{VP_LEN{1'b0}}};
        assign result0[0 * 8 +:8] = s36[0 * 8 +:8] | s35[0 * 8 +:8] | ({8{s30[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s32[0]}}) | {8{s28[0]}});
        assign result0[1 * 8 +:8] = s36[1 * 8 +:8] | s35[1 * 8 +:8] | ({8{s30[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s32[1]}}) | {8{s28[1]}});
        assign result0[2 * 8 +:8] = s36[2 * 8 +:8] | s35[2 * 8 +:8] | ({8{s30[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s32[2]}}) | {8{s28[2]}});
        assign result0[3 * 8 +:8] = s36[3 * 8 +:8] | s35[3 * 8 +:8] | ({8{s30[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s32[3]}}) | {8{s28[3]}});
        assign result0[4 * 8 +:8] = s36[4 * 8 +:8] | s35[4 * 8 +:8] | ({8{s30[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s32[4]}}) | {8{s28[4]}});
        assign result0[5 * 8 +:8] = s36[5 * 8 +:8] | s35[5 * 8 +:8] | ({8{s30[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s32[5]}}) | {8{s28[5]}});
        assign result0[6 * 8 +:8] = s36[6 * 8 +:8] | s35[6 * 8 +:8] | ({8{s30[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s32[6]}}) | {8{s28[6]}});
        assign result0[7 * 8 +:8] = s36[7 * 8 +:8] | s35[7 * 8 +:8] | ({8{s30[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s32[7]}}) | {8{s28[7]}});
        assign result0[8 * 8 +:8] = s36[8 * 8 +:8] | s35[8 * 8 +:8] | ({8{s30[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s32[8]}}) | {8{s28[8]}});
        assign result0[9 * 8 +:8] = s36[9 * 8 +:8] | s35[9 * 8 +:8] | ({8{s30[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s32[9]}}) | {8{s28[9]}});
        assign result0[10 * 8 +:8] = s36[10 * 8 +:8] | s35[10 * 8 +:8] | ({8{s30[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s32[10]}}) | {8{s28[10]}});
        assign result0[11 * 8 +:8] = s36[11 * 8 +:8] | s35[11 * 8 +:8] | ({8{s30[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s32[11]}}) | {8{s28[11]}});
        assign result0[12 * 8 +:8] = s36[12 * 8 +:8] | s35[12 * 8 +:8] | ({8{s30[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s32[12]}}) | {8{s28[12]}});
        assign result0[13 * 8 +:8] = s36[13 * 8 +:8] | s35[13 * 8 +:8] | ({8{s30[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s32[13]}}) | {8{s28[13]}});
        assign result0[14 * 8 +:8] = s36[14 * 8 +:8] | s35[14 * 8 +:8] | ({8{s30[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s32[14]}}) | {8{s28[14]}});
        assign result0[15 * 8 +:8] = s36[15 * 8 +:8] | s35[15 * 8 +:8] | ({8{s30[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s32[15]}}) | {8{s28[15]}});
        assign result0[16 * 8 +:8] = s36[16 * 8 +:8] | s35[16 * 8 +:8] | ({8{s30[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s32[16]}}) | {8{s28[16]}});
        assign result0[17 * 8 +:8] = s36[17 * 8 +:8] | s35[17 * 8 +:8] | ({8{s30[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s32[17]}}) | {8{s28[17]}});
        assign result0[18 * 8 +:8] = s36[18 * 8 +:8] | s35[18 * 8 +:8] | ({8{s30[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s32[18]}}) | {8{s28[18]}});
        assign result0[19 * 8 +:8] = s36[19 * 8 +:8] | s35[19 * 8 +:8] | ({8{s30[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s32[19]}}) | {8{s28[19]}});
        assign result0[20 * 8 +:8] = s36[20 * 8 +:8] | s35[20 * 8 +:8] | ({8{s30[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s32[20]}}) | {8{s28[20]}});
        assign result0[21 * 8 +:8] = s36[21 * 8 +:8] | s35[21 * 8 +:8] | ({8{s30[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s32[21]}}) | {8{s28[21]}});
        assign result0[22 * 8 +:8] = s36[22 * 8 +:8] | s35[22 * 8 +:8] | ({8{s30[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s32[22]}}) | {8{s28[22]}});
        assign result0[23 * 8 +:8] = s36[23 * 8 +:8] | s35[23 * 8 +:8] | ({8{s30[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s32[23]}}) | {8{s28[23]}});
        assign result0[24 * 8 +:8] = s36[24 * 8 +:8] | s35[24 * 8 +:8] | ({8{s30[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s32[24]}}) | {8{s28[24]}});
        assign result0[25 * 8 +:8] = s36[25 * 8 +:8] | s35[25 * 8 +:8] | ({8{s30[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s32[25]}}) | {8{s28[25]}});
        assign result0[26 * 8 +:8] = s36[26 * 8 +:8] | s35[26 * 8 +:8] | ({8{s30[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s32[26]}}) | {8{s28[26]}});
        assign result0[27 * 8 +:8] = s36[27 * 8 +:8] | s35[27 * 8 +:8] | ({8{s30[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s32[27]}}) | {8{s28[27]}});
        assign result0[28 * 8 +:8] = s36[28 * 8 +:8] | s35[28 * 8 +:8] | ({8{s30[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s32[28]}}) | {8{s28[28]}});
        assign result0[29 * 8 +:8] = s36[29 * 8 +:8] | s35[29 * 8 +:8] | ({8{s30[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s32[29]}}) | {8{s28[29]}});
        assign result0[30 * 8 +:8] = s36[30 * 8 +:8] | s35[30 * 8 +:8] | ({8{s30[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s32[30]}}) | {8{s28[30]}});
        assign result0[31 * 8 +:8] = s36[31 * 8 +:8] | s35[31 * 8 +:8] | ({8{s30[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s32[31]}}) | {8{s28[31]}});
        assign result1[0 * 8 +:8] = s36[32 * 8 +:8] | s35[32 * 8 +:8] | ({8{s31[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s33[0]}}) | {8{s28[0]}});
        assign result1[1 * 8 +:8] = s36[33 * 8 +:8] | s35[33 * 8 +:8] | ({8{s31[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s33[1]}}) | {8{s28[1]}});
        assign result1[2 * 8 +:8] = s36[34 * 8 +:8] | s35[34 * 8 +:8] | ({8{s31[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s33[2]}}) | {8{s28[2]}});
        assign result1[3 * 8 +:8] = s36[35 * 8 +:8] | s35[35 * 8 +:8] | ({8{s31[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s33[3]}}) | {8{s28[3]}});
        assign result1[4 * 8 +:8] = s36[36 * 8 +:8] | s35[36 * 8 +:8] | ({8{s31[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s33[4]}}) | {8{s28[4]}});
        assign result1[5 * 8 +:8] = s36[37 * 8 +:8] | s35[37 * 8 +:8] | ({8{s31[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s33[5]}}) | {8{s28[5]}});
        assign result1[6 * 8 +:8] = s36[38 * 8 +:8] | s35[38 * 8 +:8] | ({8{s31[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s33[6]}}) | {8{s28[6]}});
        assign result1[7 * 8 +:8] = s36[39 * 8 +:8] | s35[39 * 8 +:8] | ({8{s31[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s33[7]}}) | {8{s28[7]}});
        assign result1[8 * 8 +:8] = s36[40 * 8 +:8] | s35[40 * 8 +:8] | ({8{s31[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s33[8]}}) | {8{s28[8]}});
        assign result1[9 * 8 +:8] = s36[41 * 8 +:8] | s35[41 * 8 +:8] | ({8{s31[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s33[9]}}) | {8{s28[9]}});
        assign result1[10 * 8 +:8] = s36[42 * 8 +:8] | s35[42 * 8 +:8] | ({8{s31[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s33[10]}}) | {8{s28[10]}});
        assign result1[11 * 8 +:8] = s36[43 * 8 +:8] | s35[43 * 8 +:8] | ({8{s31[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s33[11]}}) | {8{s28[11]}});
        assign result1[12 * 8 +:8] = s36[44 * 8 +:8] | s35[44 * 8 +:8] | ({8{s31[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s33[12]}}) | {8{s28[12]}});
        assign result1[13 * 8 +:8] = s36[45 * 8 +:8] | s35[45 * 8 +:8] | ({8{s31[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s33[13]}}) | {8{s28[13]}});
        assign result1[14 * 8 +:8] = s36[46 * 8 +:8] | s35[46 * 8 +:8] | ({8{s31[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s33[14]}}) | {8{s28[14]}});
        assign result1[15 * 8 +:8] = s36[47 * 8 +:8] | s35[47 * 8 +:8] | ({8{s31[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s33[15]}}) | {8{s28[15]}});
        assign result1[16 * 8 +:8] = s36[48 * 8 +:8] | s35[48 * 8 +:8] | ({8{s31[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s33[16]}}) | {8{s28[16]}});
        assign result1[17 * 8 +:8] = s36[49 * 8 +:8] | s35[49 * 8 +:8] | ({8{s31[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s33[17]}}) | {8{s28[17]}});
        assign result1[18 * 8 +:8] = s36[50 * 8 +:8] | s35[50 * 8 +:8] | ({8{s31[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s33[18]}}) | {8{s28[18]}});
        assign result1[19 * 8 +:8] = s36[51 * 8 +:8] | s35[51 * 8 +:8] | ({8{s31[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s33[19]}}) | {8{s28[19]}});
        assign result1[20 * 8 +:8] = s36[52 * 8 +:8] | s35[52 * 8 +:8] | ({8{s31[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s33[20]}}) | {8{s28[20]}});
        assign result1[21 * 8 +:8] = s36[53 * 8 +:8] | s35[53 * 8 +:8] | ({8{s31[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s33[21]}}) | {8{s28[21]}});
        assign result1[22 * 8 +:8] = s36[54 * 8 +:8] | s35[54 * 8 +:8] | ({8{s31[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s33[22]}}) | {8{s28[22]}});
        assign result1[23 * 8 +:8] = s36[55 * 8 +:8] | s35[55 * 8 +:8] | ({8{s31[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s33[23]}}) | {8{s28[23]}});
        assign result1[24 * 8 +:8] = s36[56 * 8 +:8] | s35[56 * 8 +:8] | ({8{s31[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s33[24]}}) | {8{s28[24]}});
        assign result1[25 * 8 +:8] = s36[57 * 8 +:8] | s35[57 * 8 +:8] | ({8{s31[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s33[25]}}) | {8{s28[25]}});
        assign result1[26 * 8 +:8] = s36[58 * 8 +:8] | s35[58 * 8 +:8] | ({8{s31[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s33[26]}}) | {8{s28[26]}});
        assign result1[27 * 8 +:8] = s36[59 * 8 +:8] | s35[59 * 8 +:8] | ({8{s31[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s33[27]}}) | {8{s28[27]}});
        assign result1[28 * 8 +:8] = s36[60 * 8 +:8] | s35[60 * 8 +:8] | ({8{s31[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s33[28]}}) | {8{s28[28]}});
        assign result1[29 * 8 +:8] = s36[61 * 8 +:8] | s35[61 * 8 +:8] | ({8{s31[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s33[29]}}) | {8{s28[29]}});
        assign result1[30 * 8 +:8] = s36[62 * 8 +:8] | s35[62 * 8 +:8] | ({8{s31[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s33[30]}}) | {8{s28[30]}});
        assign result1[31 * 8 +:8] = s36[63 * 8 +:8] | s35[63 * 8 +:8] | ({8{s31[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s33[31]}}) | {8{s28[31]}});
    end
endgenerate
generate
    if ((VLEN == 512) && (DLEN == 512) & (VP_LEN == 256)) begin:gen_vlen512_dlen512_vplen256
        assign s16[0] = 1'b0;
        assign s16[1] = 1'b0;
        assign s16[2] = 1'b0;
        assign s16[3] = 1'b0;
        assign s16[4] = 1'b0;
        assign s16[5] = 1'b0;
        assign s16[6] = 1'b0;
        assign s16[7] = 1'b0;
        assign s16[8] = 1'b0;
        assign s16[9] = 1'b0;
        assign s16[10] = 1'b0;
        assign s16[11] = 1'b0;
        assign s16[12] = 1'b0;
        assign s16[13] = 1'b0;
        assign s16[14] = 1'b0;
        assign s16[15] = 1'b0;
        assign s16[16] = 1'b0;
        assign s16[17] = 1'b0;
        assign s16[18] = 1'b0;
        assign s16[19] = 1'b0;
        assign s16[20] = 1'b0;
        assign s16[21] = 1'b0;
        assign s16[22] = 1'b0;
        assign s16[23] = 1'b0;
        assign s16[24] = 1'b0;
        assign s16[25] = 1'b0;
        assign s16[26] = 1'b0;
        assign s16[27] = 1'b0;
        assign s16[28] = 1'b0;
        assign s16[29] = 1'b0;
        assign s16[30] = 1'b0;
        assign s16[31] = 1'b0;
        assign s17[0] = 1'b0;
        assign s17[1] = 1'b0;
        assign s17[2] = 1'b0;
        assign s17[3] = 1'b0;
        assign s17[4] = 1'b0;
        assign s17[5] = 1'b0;
        assign s17[6] = 1'b0;
        assign s17[7] = 1'b0;
        assign s17[8] = 1'b0;
        assign s17[9] = 1'b0;
        assign s17[10] = 1'b0;
        assign s17[11] = 1'b0;
        assign s17[12] = 1'b0;
        assign s17[13] = 1'b0;
        assign s17[14] = 1'b0;
        assign s17[15] = 1'b0;
        assign s17[16] = 1'b0;
        assign s17[17] = 1'b0;
        assign s17[18] = 1'b0;
        assign s17[19] = 1'b0;
        assign s17[20] = 1'b0;
        assign s17[21] = 1'b0;
        assign s17[22] = 1'b0;
        assign s17[23] = 1'b0;
        assign s17[24] = 1'b0;
        assign s17[25] = 1'b0;
        assign s17[26] = 1'b0;
        assign s17[27] = 1'b0;
        assign s17[28] = 1'b0;
        assign s17[29] = 1'b0;
        assign s17[30] = 1'b0;
        assign s17[31] = 1'b0;
        assign s22[0] = 1'b0;
        assign s18[0] = 1'b0;
        assign s22[1] = s0[15];
        assign s18[1] = 1'b0;
        assign s22[2] = s0[23];
        assign s18[2] = 1'b0;
        assign s22[3] = s0[31];
        assign s18[3] = 1'b0;
        assign s22[4] = s0[39];
        assign s18[4] = 1'b0;
        assign s22[5] = s0[47];
        assign s18[5] = 1'b0;
        assign s22[6] = s0[55];
        assign s18[6] = 1'b0;
        assign s22[7] = s0[63];
        assign s18[7] = 1'b0;
        assign s22[8] = 1'b0;
        assign s18[8] = 1'b0;
        assign s22[9] = s0[79];
        assign s18[9] = 1'b0;
        assign s22[10] = s0[87];
        assign s18[10] = 1'b0;
        assign s22[11] = s0[95];
        assign s18[11] = 1'b0;
        assign s22[12] = s0[103];
        assign s18[12] = 1'b0;
        assign s22[13] = s0[111];
        assign s18[13] = 1'b0;
        assign s22[14] = s0[119];
        assign s18[14] = 1'b0;
        assign s22[15] = s0[127];
        assign s18[15] = 1'b0;
        assign s22[16] = 1'b0;
        assign s18[16] = 1'b0;
        assign s22[17] = s0[143];
        assign s18[17] = 1'b0;
        assign s22[18] = s0[151];
        assign s18[18] = 1'b0;
        assign s22[19] = s0[159];
        assign s18[19] = 1'b0;
        assign s22[20] = s0[167];
        assign s18[20] = 1'b0;
        assign s22[21] = s0[175];
        assign s18[21] = 1'b0;
        assign s22[22] = s0[183];
        assign s18[22] = 1'b0;
        assign s22[23] = s0[191];
        assign s18[23] = 1'b0;
        assign s22[24] = 1'b0;
        assign s18[24] = 1'b0;
        assign s22[25] = s0[207];
        assign s18[25] = 1'b0;
        assign s22[26] = s0[215];
        assign s18[26] = 1'b0;
        assign s22[27] = s0[223];
        assign s18[27] = 1'b0;
        assign s22[28] = s0[231];
        assign s18[28] = 1'b0;
        assign s22[29] = s0[239];
        assign s18[29] = 1'b0;
        assign s22[30] = s0[247];
        assign s18[30] = 1'b0;
        assign s22[31] = s0[255];
        assign s18[31] = 1'b0;
        assign s25[0 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[1 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[2 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[3 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s19[0] = 1'b0;
        assign s19[1] = 1'b0;
        assign s19[2] = 1'b0;
        assign s19[3] = 1'b0;
        assign s19[4] = 1'b0;
        assign s19[5] = 1'b0;
        assign s19[6] = 1'b0;
        assign s19[7] = 1'b0;
        assign s19[8] = 1'b0;
        assign s19[9] = 1'b0;
        assign s19[10] = 1'b0;
        assign s19[11] = 1'b0;
        assign s19[12] = 1'b0;
        assign s19[13] = 1'b0;
        assign s19[14] = 1'b0;
        assign s19[15] = 1'b0;
        assign s19[16] = 1'b0;
        assign s19[17] = 1'b0;
        assign s19[18] = 1'b0;
        assign s19[19] = 1'b0;
        assign s19[20] = 1'b0;
        assign s19[21] = 1'b0;
        assign s19[22] = 1'b0;
        assign s19[23] = 1'b0;
        assign s19[24] = 1'b0;
        assign s19[25] = 1'b0;
        assign s19[26] = 1'b0;
        assign s19[27] = 1'b0;
        assign s19[28] = 1'b0;
        assign s19[29] = 1'b0;
        assign s19[30] = 1'b0;
        assign s19[31] = 1'b0;
        assign s23[0] = 1'b0;
        assign s20[0] = 1'b0;
        assign s23[1] = 1'b0;
        assign s20[1] = 1'b0;
        assign s23[2] = s0[23];
        assign s20[2] = 1'b0;
        assign s23[3] = s0[31];
        assign s20[3] = 1'b0;
        assign s23[4] = s0[39];
        assign s20[4] = 1'b0;
        assign s23[5] = s0[47];
        assign s20[5] = 1'b0;
        assign s23[6] = s0[55];
        assign s20[6] = 1'b0;
        assign s23[7] = s0[63];
        assign s20[7] = 1'b0;
        assign s23[8] = 1'b0;
        assign s20[8] = 1'b0;
        assign s23[9] = 1'b0;
        assign s20[9] = 1'b0;
        assign s23[10] = s0[87];
        assign s20[10] = 1'b0;
        assign s23[11] = s0[95];
        assign s20[11] = 1'b0;
        assign s23[12] = s0[103];
        assign s20[12] = 1'b0;
        assign s23[13] = s0[111];
        assign s20[13] = 1'b0;
        assign s23[14] = s0[119];
        assign s20[14] = 1'b0;
        assign s23[15] = s0[127];
        assign s20[15] = 1'b0;
        assign s23[16] = 1'b0;
        assign s20[16] = 1'b0;
        assign s23[17] = 1'b0;
        assign s20[17] = 1'b0;
        assign s23[18] = s0[151];
        assign s20[18] = 1'b0;
        assign s23[19] = s0[159];
        assign s20[19] = 1'b0;
        assign s23[20] = s0[167];
        assign s20[20] = 1'b0;
        assign s23[21] = s0[175];
        assign s20[21] = 1'b0;
        assign s23[22] = s0[183];
        assign s20[22] = 1'b0;
        assign s23[23] = s0[191];
        assign s20[23] = 1'b0;
        assign s23[24] = 1'b0;
        assign s20[24] = 1'b0;
        assign s23[25] = 1'b0;
        assign s20[25] = 1'b0;
        assign s23[26] = s0[215];
        assign s20[26] = 1'b0;
        assign s23[27] = s0[223];
        assign s20[27] = 1'b0;
        assign s23[28] = s0[231];
        assign s20[28] = 1'b0;
        assign s23[29] = s0[239];
        assign s20[29] = 1'b0;
        assign s23[30] = s0[247];
        assign s20[30] = 1'b0;
        assign s23[31] = s0[255];
        assign s20[31] = 1'b0;
        assign s26[0 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[1 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[2 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[3 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s24[0] = 1'b0;
        assign s21[0] = 1'b0;
        assign s24[1] = 1'b0;
        assign s21[1] = 1'b0;
        assign s24[2] = 1'b0;
        assign s21[2] = 1'b0;
        assign s24[3] = 1'b0;
        assign s21[3] = 1'b0;
        assign s24[4] = s0[39];
        assign s21[4] = 1'b0;
        assign s24[5] = s0[47];
        assign s21[5] = 1'b0;
        assign s24[6] = s0[55];
        assign s21[6] = 1'b0;
        assign s24[7] = s0[63];
        assign s21[7] = 1'b0;
        assign s24[8] = 1'b0;
        assign s21[8] = 1'b0;
        assign s24[9] = 1'b0;
        assign s21[9] = 1'b0;
        assign s24[10] = 1'b0;
        assign s21[10] = 1'b0;
        assign s24[11] = 1'b0;
        assign s21[11] = 1'b0;
        assign s24[12] = s0[103];
        assign s21[12] = 1'b0;
        assign s24[13] = s0[111];
        assign s21[13] = 1'b0;
        assign s24[14] = s0[119];
        assign s21[14] = 1'b0;
        assign s24[15] = s0[127];
        assign s21[15] = 1'b0;
        assign s24[16] = 1'b0;
        assign s21[16] = 1'b0;
        assign s24[17] = 1'b0;
        assign s21[17] = 1'b0;
        assign s24[18] = 1'b0;
        assign s21[18] = 1'b0;
        assign s24[19] = 1'b0;
        assign s21[19] = 1'b0;
        assign s24[20] = s0[167];
        assign s21[20] = 1'b0;
        assign s24[21] = s0[175];
        assign s21[21] = 1'b0;
        assign s24[22] = s0[183];
        assign s21[22] = 1'b0;
        assign s24[23] = s0[191];
        assign s21[23] = 1'b0;
        assign s24[24] = 1'b0;
        assign s21[24] = 1'b0;
        assign s24[25] = 1'b0;
        assign s21[25] = 1'b0;
        assign s24[26] = 1'b0;
        assign s21[26] = 1'b0;
        assign s24[27] = 1'b0;
        assign s21[27] = 1'b0;
        assign s24[28] = s0[231];
        assign s21[28] = 1'b0;
        assign s24[29] = s0[239];
        assign s21[29] = 1'b0;
        assign s24[30] = s0[247];
        assign s21[30] = 1'b0;
        assign s24[31] = s0[255];
        assign s21[31] = 1'b0;
        assign s27[0 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[1 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[2 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[3 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        kv_mux64 #(
            .W(8)
        ) u_mux0 (
            .out(s0[0 * 8 +:8]),
            .sel(idx[0 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux1 (
            .out(s0[1 * 8 +:8]),
            .sel(idx[1 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux2 (
            .out(s0[2 * 8 +:8]),
            .sel(idx[2 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux3 (
            .out(s0[3 * 8 +:8]),
            .sel(idx[3 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux4 (
            .out(s0[4 * 8 +:8]),
            .sel(idx[4 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux5 (
            .out(s0[5 * 8 +:8]),
            .sel(idx[5 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux6 (
            .out(s0[6 * 8 +:8]),
            .sel(idx[6 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux7 (
            .out(s0[7 * 8 +:8]),
            .sel(idx[7 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux8 (
            .out(s0[8 * 8 +:8]),
            .sel(idx[8 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux9 (
            .out(s0[9 * 8 +:8]),
            .sel(idx[9 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux10 (
            .out(s0[10 * 8 +:8]),
            .sel(idx[10 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux11 (
            .out(s0[11 * 8 +:8]),
            .sel(idx[11 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux12 (
            .out(s0[12 * 8 +:8]),
            .sel(idx[12 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux13 (
            .out(s0[13 * 8 +:8]),
            .sel(idx[13 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux14 (
            .out(s0[14 * 8 +:8]),
            .sel(idx[14 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux15 (
            .out(s0[15 * 8 +:8]),
            .sel(idx[15 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux16 (
            .out(s0[16 * 8 +:8]),
            .sel(idx[16 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux17 (
            .out(s0[17 * 8 +:8]),
            .sel(idx[17 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux18 (
            .out(s0[18 * 8 +:8]),
            .sel(idx[18 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux19 (
            .out(s0[19 * 8 +:8]),
            .sel(idx[19 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux20 (
            .out(s0[20 * 8 +:8]),
            .sel(idx[20 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux21 (
            .out(s0[21 * 8 +:8]),
            .sel(idx[21 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux22 (
            .out(s0[22 * 8 +:8]),
            .sel(idx[22 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux23 (
            .out(s0[23 * 8 +:8]),
            .sel(idx[23 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux24 (
            .out(s0[24 * 8 +:8]),
            .sel(idx[24 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux25 (
            .out(s0[25 * 8 +:8]),
            .sel(idx[25 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux26 (
            .out(s0[26 * 8 +:8]),
            .sel(idx[26 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux27 (
            .out(s0[27 * 8 +:8]),
            .sel(idx[27 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux28 (
            .out(s0[28 * 8 +:8]),
            .sel(idx[28 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux29 (
            .out(s0[29 * 8 +:8]),
            .sel(idx[29 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux30 (
            .out(s0[30 * 8 +:8]),
            .sel(idx[30 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux31 (
            .out(s0[31 * 8 +:8]),
            .sel(idx[31 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        assign s13[0 +:8] = {{4{s0[3] & s4}},s0[0 +:4] & {4{s1}}};
        assign s13[8 +:8] = {{4{s0[7] & s4}},s0[4 +:4] & {4{s1}}};
        assign s13[16 +:8] = {{4{s0[11] & s4}},s0[8 +:4] & {4{s1}}};
        assign s13[24 +:8] = {{4{s0[15] & s4}},s0[12 +:4] & {4{s1}}};
        assign s13[32 +:8] = {{4{s0[19] & s4}},s0[16 +:4] & {4{s1}}};
        assign s13[40 +:8] = {{4{s0[23] & s4}},s0[20 +:4] & {4{s1}}};
        assign s13[48 +:8] = {{4{s0[27] & s4}},s0[24 +:4] & {4{s1}}};
        assign s13[56 +:8] = {{4{s0[31] & s4}},s0[28 +:4] & {4{s1}}};
        assign s13[64 +:8] = {{4{s0[35] & s4}},s0[32 +:4] & {4{s1}}};
        assign s13[72 +:8] = {{4{s0[39] & s4}},s0[36 +:4] & {4{s1}}};
        assign s13[80 +:8] = {{4{s0[43] & s4}},s0[40 +:4] & {4{s1}}};
        assign s13[88 +:8] = {{4{s0[47] & s4}},s0[44 +:4] & {4{s1}}};
        assign s13[96 +:8] = {{4{s0[51] & s4}},s0[48 +:4] & {4{s1}}};
        assign s13[104 +:8] = {{4{s0[55] & s4}},s0[52 +:4] & {4{s1}}};
        assign s13[112 +:8] = {{4{s0[59] & s4}},s0[56 +:4] & {4{s1}}};
        assign s13[120 +:8] = {{4{s0[63] & s4}},s0[60 +:4] & {4{s1}}};
        assign s13[128 +:8] = {{4{s0[67] & s4}},s0[64 +:4] & {4{s1}}};
        assign s13[136 +:8] = {{4{s0[71] & s4}},s0[68 +:4] & {4{s1}}};
        assign s13[144 +:8] = {{4{s0[75] & s4}},s0[72 +:4] & {4{s1}}};
        assign s13[152 +:8] = {{4{s0[79] & s4}},s0[76 +:4] & {4{s1}}};
        assign s13[160 +:8] = {{4{s0[83] & s4}},s0[80 +:4] & {4{s1}}};
        assign s13[168 +:8] = {{4{s0[87] & s4}},s0[84 +:4] & {4{s1}}};
        assign s13[176 +:8] = {{4{s0[91] & s4}},s0[88 +:4] & {4{s1}}};
        assign s13[184 +:8] = {{4{s0[95] & s4}},s0[92 +:4] & {4{s1}}};
        assign s13[192 +:8] = {{4{s0[99] & s4}},s0[96 +:4] & {4{s1}}};
        assign s13[200 +:8] = {{4{s0[103] & s4}},s0[100 +:4] & {4{s1}}};
        assign s13[208 +:8] = {{4{s0[107] & s4}},s0[104 +:4] & {4{s1}}};
        assign s13[216 +:8] = {{4{s0[111] & s4}},s0[108 +:4] & {4{s1}}};
        assign s13[224 +:8] = {{4{s0[115] & s4}},s0[112 +:4] & {4{s1}}};
        assign s13[232 +:8] = {{4{s0[119] & s4}},s0[116 +:4] & {4{s1}}};
        assign s13[240 +:8] = {{4{s0[123] & s4}},s0[120 +:4] & {4{s1}}};
        assign s13[248 +:8] = {{4{s0[127] & s4}},s0[124 +:4] & {4{s1}}};
        assign s13[256 +:8] = {{4{s0[131] & s4}},s0[128 +:4] & {4{s1}}};
        assign s13[264 +:8] = {{4{s0[135] & s4}},s0[132 +:4] & {4{s1}}};
        assign s13[272 +:8] = {{4{s0[139] & s4}},s0[136 +:4] & {4{s1}}};
        assign s13[280 +:8] = {{4{s0[143] & s4}},s0[140 +:4] & {4{s1}}};
        assign s13[288 +:8] = {{4{s0[147] & s4}},s0[144 +:4] & {4{s1}}};
        assign s13[296 +:8] = {{4{s0[151] & s4}},s0[148 +:4] & {4{s1}}};
        assign s13[304 +:8] = {{4{s0[155] & s4}},s0[152 +:4] & {4{s1}}};
        assign s13[312 +:8] = {{4{s0[159] & s4}},s0[156 +:4] & {4{s1}}};
        assign s13[320 +:8] = {{4{s0[163] & s4}},s0[160 +:4] & {4{s1}}};
        assign s13[328 +:8] = {{4{s0[167] & s4}},s0[164 +:4] & {4{s1}}};
        assign s13[336 +:8] = {{4{s0[171] & s4}},s0[168 +:4] & {4{s1}}};
        assign s13[344 +:8] = {{4{s0[175] & s4}},s0[172 +:4] & {4{s1}}};
        assign s13[352 +:8] = {{4{s0[179] & s4}},s0[176 +:4] & {4{s1}}};
        assign s13[360 +:8] = {{4{s0[183] & s4}},s0[180 +:4] & {4{s1}}};
        assign s13[368 +:8] = {{4{s0[187] & s4}},s0[184 +:4] & {4{s1}}};
        assign s13[376 +:8] = {{4{s0[191] & s4}},s0[188 +:4] & {4{s1}}};
        assign s13[384 +:8] = {{4{s0[195] & s4}},s0[192 +:4] & {4{s1}}};
        assign s13[392 +:8] = {{4{s0[199] & s4}},s0[196 +:4] & {4{s1}}};
        assign s13[400 +:8] = {{4{s0[203] & s4}},s0[200 +:4] & {4{s1}}};
        assign s13[408 +:8] = {{4{s0[207] & s4}},s0[204 +:4] & {4{s1}}};
        assign s13[416 +:8] = {{4{s0[211] & s4}},s0[208 +:4] & {4{s1}}};
        assign s13[424 +:8] = {{4{s0[215] & s4}},s0[212 +:4] & {4{s1}}};
        assign s13[432 +:8] = {{4{s0[219] & s4}},s0[216 +:4] & {4{s1}}};
        assign s13[440 +:8] = {{4{s0[223] & s4}},s0[220 +:4] & {4{s1}}};
        assign s13[448 +:8] = {{4{s0[227] & s4}},s0[224 +:4] & {4{s1}}};
        assign s13[456 +:8] = {{4{s0[231] & s4}},s0[228 +:4] & {4{s1}}};
        assign s13[464 +:8] = {{4{s0[235] & s4}},s0[232 +:4] & {4{s1}}};
        assign s13[472 +:8] = {{4{s0[239] & s4}},s0[236 +:4] & {4{s1}}};
        assign s13[480 +:8] = {{4{s0[243] & s4}},s0[240 +:4] & {4{s1}}};
        assign s13[488 +:8] = {{4{s0[247] & s4}},s0[244 +:4] & {4{s1}}};
        assign s13[496 +:8] = {{4{s0[251] & s4}},s0[248 +:4] & {4{s1}}};
        assign s13[504 +:8] = {{4{s0[255] & s4}},s0[252 +:4] & {4{s1}}};
        assign s14[0 +:16] = {{12{s0[3] & s5}},s0[0 +:4] & {4{s2}}};
        assign s14[16 +:16] = {{12{s0[7] & s5}},s0[4 +:4] & {4{s2}}};
        assign s14[32 +:16] = {{12{s0[11] & s5}},s0[8 +:4] & {4{s2}}};
        assign s14[48 +:16] = {{12{s0[15] & s5}},s0[12 +:4] & {4{s2}}};
        assign s14[64 +:16] = {{12{s0[19] & s5}},s0[16 +:4] & {4{s2}}};
        assign s14[80 +:16] = {{12{s0[23] & s5}},s0[20 +:4] & {4{s2}}};
        assign s14[96 +:16] = {{12{s0[27] & s5}},s0[24 +:4] & {4{s2}}};
        assign s14[112 +:16] = {{12{s0[31] & s5}},s0[28 +:4] & {4{s2}}};
        assign s14[128 +:16] = {{12{s0[35] & s5}},s0[32 +:4] & {4{s2}}};
        assign s14[144 +:16] = {{12{s0[39] & s5}},s0[36 +:4] & {4{s2}}};
        assign s14[160 +:16] = {{12{s0[43] & s5}},s0[40 +:4] & {4{s2}}};
        assign s14[176 +:16] = {{12{s0[47] & s5}},s0[44 +:4] & {4{s2}}};
        assign s14[192 +:16] = {{12{s0[51] & s5}},s0[48 +:4] & {4{s2}}};
        assign s14[208 +:16] = {{12{s0[55] & s5}},s0[52 +:4] & {4{s2}}};
        assign s14[224 +:16] = {{12{s0[59] & s5}},s0[56 +:4] & {4{s2}}};
        assign s14[240 +:16] = {{12{s0[63] & s5}},s0[60 +:4] & {4{s2}}};
        assign s14[256 +:16] = {{12{s0[67] & s5}},s0[64 +:4] & {4{s2}}};
        assign s14[272 +:16] = {{12{s0[71] & s5}},s0[68 +:4] & {4{s2}}};
        assign s14[288 +:16] = {{12{s0[75] & s5}},s0[72 +:4] & {4{s2}}};
        assign s14[304 +:16] = {{12{s0[79] & s5}},s0[76 +:4] & {4{s2}}};
        assign s14[320 +:16] = {{12{s0[83] & s5}},s0[80 +:4] & {4{s2}}};
        assign s14[336 +:16] = {{12{s0[87] & s5}},s0[84 +:4] & {4{s2}}};
        assign s14[352 +:16] = {{12{s0[91] & s5}},s0[88 +:4] & {4{s2}}};
        assign s14[368 +:16] = {{12{s0[95] & s5}},s0[92 +:4] & {4{s2}}};
        assign s14[384 +:16] = {{12{s0[99] & s5}},s0[96 +:4] & {4{s2}}};
        assign s14[400 +:16] = {{12{s0[103] & s5}},s0[100 +:4] & {4{s2}}};
        assign s14[416 +:16] = {{12{s0[107] & s5}},s0[104 +:4] & {4{s2}}};
        assign s14[432 +:16] = {{12{s0[111] & s5}},s0[108 +:4] & {4{s2}}};
        assign s14[448 +:16] = {{12{s0[115] & s5}},s0[112 +:4] & {4{s2}}};
        assign s14[464 +:16] = {{12{s0[119] & s5}},s0[116 +:4] & {4{s2}}};
        assign s14[480 +:16] = {{12{s0[123] & s5}},s0[120 +:4] & {4{s2}}};
        assign s14[496 +:16] = {{12{s0[127] & s5}},s0[124 +:4] & {4{s2}}};
        assign s15[0 +:32] = {{28{s0[3] & s6}},s0[0 +:4] & {4{s3}}};
        assign s15[32 +:32] = {{28{s0[7] & s6}},s0[4 +:4] & {4{s3}}};
        assign s15[64 +:32] = {{28{s0[11] & s6}},s0[8 +:4] & {4{s3}}};
        assign s15[96 +:32] = {{28{s0[15] & s6}},s0[12 +:4] & {4{s3}}};
        assign s15[128 +:32] = {{28{s0[19] & s6}},s0[16 +:4] & {4{s3}}};
        assign s15[160 +:32] = {{28{s0[23] & s6}},s0[20 +:4] & {4{s3}}};
        assign s15[192 +:32] = {{28{s0[27] & s6}},s0[24 +:4] & {4{s3}}};
        assign s15[224 +:32] = {{28{s0[31] & s6}},s0[28 +:4] & {4{s3}}};
        assign s15[256 +:32] = {{28{s0[35] & s6}},s0[32 +:4] & {4{s3}}};
        assign s15[288 +:32] = {{28{s0[39] & s6}},s0[36 +:4] & {4{s3}}};
        assign s15[320 +:32] = {{28{s0[43] & s6}},s0[40 +:4] & {4{s3}}};
        assign s15[352 +:32] = {{28{s0[47] & s6}},s0[44 +:4] & {4{s3}}};
        assign s15[384 +:32] = {{28{s0[51] & s6}},s0[48 +:4] & {4{s3}}};
        assign s15[416 +:32] = {{28{s0[55] & s6}},s0[52 +:4] & {4{s3}}};
        assign s15[448 +:32] = {{28{s0[59] & s6}},s0[56 +:4] & {4{s3}}};
        assign s15[480 +:32] = {{28{s0[63] & s6}},s0[60 +:4] & {4{s3}}};
        wire [2 * VP_LEN - 1:0] s37;
        wire s38 = vzsext & eew8x2;
        assign s37[0 +:16] = {{8{s0[7] & s7}},s0[0 +:8] & {8{s38}}};
        assign s37[16 +:16] = {{8{s0[15] & s7}},s0[8 +:8] & {8{s38}}};
        assign s37[32 +:16] = {{8{s0[23] & s7}},s0[16 +:8] & {8{s38}}};
        assign s37[48 +:16] = {{8{s0[31] & s7}},s0[24 +:8] & {8{s38}}};
        assign s37[64 +:16] = {{8{s0[39] & s7}},s0[32 +:8] & {8{s38}}};
        assign s37[80 +:16] = {{8{s0[47] & s7}},s0[40 +:8] & {8{s38}}};
        assign s37[96 +:16] = {{8{s0[55] & s7}},s0[48 +:8] & {8{s38}}};
        assign s37[112 +:16] = {{8{s0[63] & s7}},s0[56 +:8] & {8{s38}}};
        assign s37[128 +:16] = {{8{s0[71] & s7}},s0[64 +:8] & {8{s38}}};
        assign s37[144 +:16] = {{8{s0[79] & s7}},s0[72 +:8] & {8{s38}}};
        assign s37[160 +:16] = {{8{s0[87] & s7}},s0[80 +:8] & {8{s38}}};
        assign s37[176 +:16] = {{8{s0[95] & s7}},s0[88 +:8] & {8{s38}}};
        assign s37[192 +:16] = {{8{s0[103] & s7}},s0[96 +:8] & {8{s38}}};
        assign s37[208 +:16] = {{8{s0[111] & s7}},s0[104 +:8] & {8{s38}}};
        assign s37[224 +:16] = {{8{s0[119] & s7}},s0[112 +:8] & {8{s38}}};
        assign s37[240 +:16] = {{8{s0[127] & s7}},s0[120 +:8] & {8{s38}}};
        assign s37[256 +:16] = {{8{s0[135] & s7}},s0[128 +:8] & {8{s38}}};
        assign s37[272 +:16] = {{8{s0[143] & s7}},s0[136 +:8] & {8{s38}}};
        assign s37[288 +:16] = {{8{s0[151] & s7}},s0[144 +:8] & {8{s38}}};
        assign s37[304 +:16] = {{8{s0[159] & s7}},s0[152 +:8] & {8{s38}}};
        assign s37[320 +:16] = {{8{s0[167] & s7}},s0[160 +:8] & {8{s38}}};
        assign s37[336 +:16] = {{8{s0[175] & s7}},s0[168 +:8] & {8{s38}}};
        assign s37[352 +:16] = {{8{s0[183] & s7}},s0[176 +:8] & {8{s38}}};
        assign s37[368 +:16] = {{8{s0[191] & s7}},s0[184 +:8] & {8{s38}}};
        assign s37[384 +:16] = {{8{s0[199] & s7}},s0[192 +:8] & {8{s38}}};
        assign s37[400 +:16] = {{8{s0[207] & s7}},s0[200 +:8] & {8{s38}}};
        assign s37[416 +:16] = {{8{s0[215] & s7}},s0[208 +:8] & {8{s38}}};
        assign s37[432 +:16] = {{8{s0[223] & s7}},s0[216 +:8] & {8{s38}}};
        assign s37[448 +:16] = {{8{s0[231] & s7}},s0[224 +:8] & {8{s38}}};
        assign s37[464 +:16] = {{8{s0[239] & s7}},s0[232 +:8] & {8{s38}}};
        assign s37[480 +:16] = {{8{s0[247] & s7}},s0[240 +:8] & {8{s38}}};
        assign s37[496 +:16] = {{8{s0[255] & s7}},s0[248 +:8] & {8{s38}}};
        wire [2 * VP_LEN - 1:0] s39;
        wire s40 = vzsext & eew8x4;
        assign s39[0 +:32] = {{24{s0[7] & s8}},s0[0 +:8] & {8{s40}}};
        assign s39[32 +:32] = {{24{s0[15] & s8}},s0[8 +:8] & {8{s40}}};
        assign s39[64 +:32] = {{24{s0[23] & s8}},s0[16 +:8] & {8{s40}}};
        assign s39[96 +:32] = {{24{s0[31] & s8}},s0[24 +:8] & {8{s40}}};
        assign s39[128 +:32] = {{24{s0[39] & s8}},s0[32 +:8] & {8{s40}}};
        assign s39[160 +:32] = {{24{s0[47] & s8}},s0[40 +:8] & {8{s40}}};
        assign s39[192 +:32] = {{24{s0[55] & s8}},s0[48 +:8] & {8{s40}}};
        assign s39[224 +:32] = {{24{s0[63] & s8}},s0[56 +:8] & {8{s40}}};
        assign s39[256 +:32] = {{24{s0[71] & s8}},s0[64 +:8] & {8{s40}}};
        assign s39[288 +:32] = {{24{s0[79] & s8}},s0[72 +:8] & {8{s40}}};
        assign s39[320 +:32] = {{24{s0[87] & s8}},s0[80 +:8] & {8{s40}}};
        assign s39[352 +:32] = {{24{s0[95] & s8}},s0[88 +:8] & {8{s40}}};
        assign s39[384 +:32] = {{24{s0[103] & s8}},s0[96 +:8] & {8{s40}}};
        assign s39[416 +:32] = {{24{s0[111] & s8}},s0[104 +:8] & {8{s40}}};
        assign s39[448 +:32] = {{24{s0[119] & s8}},s0[112 +:8] & {8{s40}}};
        assign s39[480 +:32] = {{24{s0[127] & s8}},s0[120 +:8] & {8{s40}}};
        wire [2 * VP_LEN - 1:0] s41;
        wire s42 = vzsext & eew8x8;
        assign s41[0 +:64] = {{56{s0[7] & s9}},s0[0 +:8] & {8{s42}}};
        assign s41[64 +:64] = {{56{s0[15] & s9}},s0[8 +:8] & {8{s42}}};
        assign s41[128 +:64] = {{56{s0[23] & s9}},s0[16 +:8] & {8{s42}}};
        assign s41[192 +:64] = {{56{s0[31] & s9}},s0[24 +:8] & {8{s42}}};
        assign s41[256 +:64] = {{56{s0[39] & s9}},s0[32 +:8] & {8{s42}}};
        assign s41[320 +:64] = {{56{s0[47] & s9}},s0[40 +:8] & {8{s42}}};
        assign s41[384 +:64] = {{56{s0[55] & s9}},s0[48 +:8] & {8{s42}}};
        assign s41[448 +:64] = {{56{s0[63] & s9}},s0[56 +:8] & {8{s42}}};
        wire [2 * VP_LEN - 1:0] s43;
        wire s44 = vzsext & eew16x2;
        assign s43[0 +:32] = {{16{s0[15] & s10}},s0[0 +:16] & {16{s44}}};
        assign s43[32 +:32] = {{16{s0[31] & s10}},s0[16 +:16] & {16{s44}}};
        assign s43[64 +:32] = {{16{s0[47] & s10}},s0[32 +:16] & {16{s44}}};
        assign s43[96 +:32] = {{16{s0[63] & s10}},s0[48 +:16] & {16{s44}}};
        assign s43[128 +:32] = {{16{s0[79] & s10}},s0[64 +:16] & {16{s44}}};
        assign s43[160 +:32] = {{16{s0[95] & s10}},s0[80 +:16] & {16{s44}}};
        assign s43[192 +:32] = {{16{s0[111] & s10}},s0[96 +:16] & {16{s44}}};
        assign s43[224 +:32] = {{16{s0[127] & s10}},s0[112 +:16] & {16{s44}}};
        assign s43[256 +:32] = {{16{s0[143] & s10}},s0[128 +:16] & {16{s44}}};
        assign s43[288 +:32] = {{16{s0[159] & s10}},s0[144 +:16] & {16{s44}}};
        assign s43[320 +:32] = {{16{s0[175] & s10}},s0[160 +:16] & {16{s44}}};
        assign s43[352 +:32] = {{16{s0[191] & s10}},s0[176 +:16] & {16{s44}}};
        assign s43[384 +:32] = {{16{s0[207] & s10}},s0[192 +:16] & {16{s44}}};
        assign s43[416 +:32] = {{16{s0[223] & s10}},s0[208 +:16] & {16{s44}}};
        assign s43[448 +:32] = {{16{s0[239] & s10}},s0[224 +:16] & {16{s44}}};
        assign s43[480 +:32] = {{16{s0[255] & s10}},s0[240 +:16] & {16{s44}}};
        wire [2 * VP_LEN - 1:0] s45;
        wire s46 = vzsext & eew16x4;
        assign s45[0 +:64] = {{48{s0[15] & s11}},s0[0 +:16] & {16{s46}}};
        assign s45[64 +:64] = {{48{s0[31] & s11}},s0[16 +:16] & {16{s46}}};
        assign s45[128 +:64] = {{48{s0[47] & s11}},s0[32 +:16] & {16{s46}}};
        assign s45[192 +:64] = {{48{s0[63] & s11}},s0[48 +:16] & {16{s46}}};
        assign s45[256 +:64] = {{48{s0[79] & s11}},s0[64 +:16] & {16{s46}}};
        assign s45[320 +:64] = {{48{s0[95] & s11}},s0[80 +:16] & {16{s46}}};
        assign s45[384 +:64] = {{48{s0[111] & s11}},s0[96 +:16] & {16{s46}}};
        assign s45[448 +:64] = {{48{s0[127] & s11}},s0[112 +:16] & {16{s46}}};
        wire [2 * VP_LEN - 1:0] s47;
        wire s48 = vzsext & eew32x2;
        assign s47[0 +:64] = {{32{s0[31] & s12}},s0[0 +:32] & {32{s48}}};
        assign s47[64 +:64] = {{32{s0[63] & s12}},s0[32 +:32] & {32{s48}}};
        assign s47[128 +:64] = {{32{s0[95] & s12}},s0[64 +:32] & {32{s48}}};
        assign s47[192 +:64] = {{32{s0[127] & s12}},s0[96 +:32] & {32{s48}}};
        assign s47[256 +:64] = {{32{s0[159] & s12}},s0[128 +:32] & {32{s48}}};
        assign s47[320 +:64] = {{32{s0[191] & s12}},s0[160 +:32] & {32{s48}}};
        assign s47[384 +:64] = {{32{s0[223] & s12}},s0[192 +:32] & {32{s48}}};
        assign s47[448 +:64] = {{32{s0[255] & s12}},s0[224 +:32] & {32{s48}}};
        wire [2 * VP_LEN - 1:0] s35;
        assign s35 = s13 | s14 | s15 | s37 | s39 | s41 | s43 | s45 | s47;
        wire [2 * VP_LEN - 1:0] s36 = {2 * VP_LEN{vmv_nr}} & {vs2_buf[VP_LEN +:VP_LEN],{VP_LEN{1'b0}}};
        assign result0[0 * 8 +:8] = s36[0 * 8 +:8] | s35[0 * 8 +:8] | ({8{s30[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s32[0]}}) | {8{s28[0]}});
        assign result0[1 * 8 +:8] = s36[1 * 8 +:8] | s35[1 * 8 +:8] | ({8{s30[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s32[1]}}) | {8{s28[1]}});
        assign result0[2 * 8 +:8] = s36[2 * 8 +:8] | s35[2 * 8 +:8] | ({8{s30[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s32[2]}}) | {8{s28[2]}});
        assign result0[3 * 8 +:8] = s36[3 * 8 +:8] | s35[3 * 8 +:8] | ({8{s30[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s32[3]}}) | {8{s28[3]}});
        assign result0[4 * 8 +:8] = s36[4 * 8 +:8] | s35[4 * 8 +:8] | ({8{s30[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s32[4]}}) | {8{s28[4]}});
        assign result0[5 * 8 +:8] = s36[5 * 8 +:8] | s35[5 * 8 +:8] | ({8{s30[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s32[5]}}) | {8{s28[5]}});
        assign result0[6 * 8 +:8] = s36[6 * 8 +:8] | s35[6 * 8 +:8] | ({8{s30[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s32[6]}}) | {8{s28[6]}});
        assign result0[7 * 8 +:8] = s36[7 * 8 +:8] | s35[7 * 8 +:8] | ({8{s30[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s32[7]}}) | {8{s28[7]}});
        assign result0[8 * 8 +:8] = s36[8 * 8 +:8] | s35[8 * 8 +:8] | ({8{s30[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s32[8]}}) | {8{s28[8]}});
        assign result0[9 * 8 +:8] = s36[9 * 8 +:8] | s35[9 * 8 +:8] | ({8{s30[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s32[9]}}) | {8{s28[9]}});
        assign result0[10 * 8 +:8] = s36[10 * 8 +:8] | s35[10 * 8 +:8] | ({8{s30[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s32[10]}}) | {8{s28[10]}});
        assign result0[11 * 8 +:8] = s36[11 * 8 +:8] | s35[11 * 8 +:8] | ({8{s30[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s32[11]}}) | {8{s28[11]}});
        assign result0[12 * 8 +:8] = s36[12 * 8 +:8] | s35[12 * 8 +:8] | ({8{s30[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s32[12]}}) | {8{s28[12]}});
        assign result0[13 * 8 +:8] = s36[13 * 8 +:8] | s35[13 * 8 +:8] | ({8{s30[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s32[13]}}) | {8{s28[13]}});
        assign result0[14 * 8 +:8] = s36[14 * 8 +:8] | s35[14 * 8 +:8] | ({8{s30[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s32[14]}}) | {8{s28[14]}});
        assign result0[15 * 8 +:8] = s36[15 * 8 +:8] | s35[15 * 8 +:8] | ({8{s30[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s32[15]}}) | {8{s28[15]}});
        assign result0[16 * 8 +:8] = s36[16 * 8 +:8] | s35[16 * 8 +:8] | ({8{s30[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s32[16]}}) | {8{s28[16]}});
        assign result0[17 * 8 +:8] = s36[17 * 8 +:8] | s35[17 * 8 +:8] | ({8{s30[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s32[17]}}) | {8{s28[17]}});
        assign result0[18 * 8 +:8] = s36[18 * 8 +:8] | s35[18 * 8 +:8] | ({8{s30[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s32[18]}}) | {8{s28[18]}});
        assign result0[19 * 8 +:8] = s36[19 * 8 +:8] | s35[19 * 8 +:8] | ({8{s30[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s32[19]}}) | {8{s28[19]}});
        assign result0[20 * 8 +:8] = s36[20 * 8 +:8] | s35[20 * 8 +:8] | ({8{s30[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s32[20]}}) | {8{s28[20]}});
        assign result0[21 * 8 +:8] = s36[21 * 8 +:8] | s35[21 * 8 +:8] | ({8{s30[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s32[21]}}) | {8{s28[21]}});
        assign result0[22 * 8 +:8] = s36[22 * 8 +:8] | s35[22 * 8 +:8] | ({8{s30[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s32[22]}}) | {8{s28[22]}});
        assign result0[23 * 8 +:8] = s36[23 * 8 +:8] | s35[23 * 8 +:8] | ({8{s30[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s32[23]}}) | {8{s28[23]}});
        assign result0[24 * 8 +:8] = s36[24 * 8 +:8] | s35[24 * 8 +:8] | ({8{s30[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s32[24]}}) | {8{s28[24]}});
        assign result0[25 * 8 +:8] = s36[25 * 8 +:8] | s35[25 * 8 +:8] | ({8{s30[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s32[25]}}) | {8{s28[25]}});
        assign result0[26 * 8 +:8] = s36[26 * 8 +:8] | s35[26 * 8 +:8] | ({8{s30[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s32[26]}}) | {8{s28[26]}});
        assign result0[27 * 8 +:8] = s36[27 * 8 +:8] | s35[27 * 8 +:8] | ({8{s30[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s32[27]}}) | {8{s28[27]}});
        assign result0[28 * 8 +:8] = s36[28 * 8 +:8] | s35[28 * 8 +:8] | ({8{s30[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s32[28]}}) | {8{s28[28]}});
        assign result0[29 * 8 +:8] = s36[29 * 8 +:8] | s35[29 * 8 +:8] | ({8{s30[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s32[29]}}) | {8{s28[29]}});
        assign result0[30 * 8 +:8] = s36[30 * 8 +:8] | s35[30 * 8 +:8] | ({8{s30[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s32[30]}}) | {8{s28[30]}});
        assign result0[31 * 8 +:8] = s36[31 * 8 +:8] | s35[31 * 8 +:8] | ({8{s30[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s32[31]}}) | {8{s28[31]}});
        assign result1[0 * 8 +:8] = s36[32 * 8 +:8] | s35[32 * 8 +:8] | ({8{s31[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s33[0]}}) | {8{s28[0]}});
        assign result1[1 * 8 +:8] = s36[33 * 8 +:8] | s35[33 * 8 +:8] | ({8{s31[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s33[1]}}) | {8{s28[1]}});
        assign result1[2 * 8 +:8] = s36[34 * 8 +:8] | s35[34 * 8 +:8] | ({8{s31[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s33[2]}}) | {8{s28[2]}});
        assign result1[3 * 8 +:8] = s36[35 * 8 +:8] | s35[35 * 8 +:8] | ({8{s31[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s33[3]}}) | {8{s28[3]}});
        assign result1[4 * 8 +:8] = s36[36 * 8 +:8] | s35[36 * 8 +:8] | ({8{s31[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s33[4]}}) | {8{s28[4]}});
        assign result1[5 * 8 +:8] = s36[37 * 8 +:8] | s35[37 * 8 +:8] | ({8{s31[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s33[5]}}) | {8{s28[5]}});
        assign result1[6 * 8 +:8] = s36[38 * 8 +:8] | s35[38 * 8 +:8] | ({8{s31[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s33[6]}}) | {8{s28[6]}});
        assign result1[7 * 8 +:8] = s36[39 * 8 +:8] | s35[39 * 8 +:8] | ({8{s31[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s33[7]}}) | {8{s28[7]}});
        assign result1[8 * 8 +:8] = s36[40 * 8 +:8] | s35[40 * 8 +:8] | ({8{s31[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s33[8]}}) | {8{s28[8]}});
        assign result1[9 * 8 +:8] = s36[41 * 8 +:8] | s35[41 * 8 +:8] | ({8{s31[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s33[9]}}) | {8{s28[9]}});
        assign result1[10 * 8 +:8] = s36[42 * 8 +:8] | s35[42 * 8 +:8] | ({8{s31[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s33[10]}}) | {8{s28[10]}});
        assign result1[11 * 8 +:8] = s36[43 * 8 +:8] | s35[43 * 8 +:8] | ({8{s31[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s33[11]}}) | {8{s28[11]}});
        assign result1[12 * 8 +:8] = s36[44 * 8 +:8] | s35[44 * 8 +:8] | ({8{s31[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s33[12]}}) | {8{s28[12]}});
        assign result1[13 * 8 +:8] = s36[45 * 8 +:8] | s35[45 * 8 +:8] | ({8{s31[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s33[13]}}) | {8{s28[13]}});
        assign result1[14 * 8 +:8] = s36[46 * 8 +:8] | s35[46 * 8 +:8] | ({8{s31[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s33[14]}}) | {8{s28[14]}});
        assign result1[15 * 8 +:8] = s36[47 * 8 +:8] | s35[47 * 8 +:8] | ({8{s31[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s33[15]}}) | {8{s28[15]}});
        assign result1[16 * 8 +:8] = s36[48 * 8 +:8] | s35[48 * 8 +:8] | ({8{s31[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s33[16]}}) | {8{s28[16]}});
        assign result1[17 * 8 +:8] = s36[49 * 8 +:8] | s35[49 * 8 +:8] | ({8{s31[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s33[17]}}) | {8{s28[17]}});
        assign result1[18 * 8 +:8] = s36[50 * 8 +:8] | s35[50 * 8 +:8] | ({8{s31[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s33[18]}}) | {8{s28[18]}});
        assign result1[19 * 8 +:8] = s36[51 * 8 +:8] | s35[51 * 8 +:8] | ({8{s31[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s33[19]}}) | {8{s28[19]}});
        assign result1[20 * 8 +:8] = s36[52 * 8 +:8] | s35[52 * 8 +:8] | ({8{s31[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s33[20]}}) | {8{s28[20]}});
        assign result1[21 * 8 +:8] = s36[53 * 8 +:8] | s35[53 * 8 +:8] | ({8{s31[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s33[21]}}) | {8{s28[21]}});
        assign result1[22 * 8 +:8] = s36[54 * 8 +:8] | s35[54 * 8 +:8] | ({8{s31[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s33[22]}}) | {8{s28[22]}});
        assign result1[23 * 8 +:8] = s36[55 * 8 +:8] | s35[55 * 8 +:8] | ({8{s31[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s33[23]}}) | {8{s28[23]}});
        assign result1[24 * 8 +:8] = s36[56 * 8 +:8] | s35[56 * 8 +:8] | ({8{s31[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s33[24]}}) | {8{s28[24]}});
        assign result1[25 * 8 +:8] = s36[57 * 8 +:8] | s35[57 * 8 +:8] | ({8{s31[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s33[25]}}) | {8{s28[25]}});
        assign result1[26 * 8 +:8] = s36[58 * 8 +:8] | s35[58 * 8 +:8] | ({8{s31[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s33[26]}}) | {8{s28[26]}});
        assign result1[27 * 8 +:8] = s36[59 * 8 +:8] | s35[59 * 8 +:8] | ({8{s31[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s33[27]}}) | {8{s28[27]}});
        assign result1[28 * 8 +:8] = s36[60 * 8 +:8] | s35[60 * 8 +:8] | ({8{s31[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s33[28]}}) | {8{s28[28]}});
        assign result1[29 * 8 +:8] = s36[61 * 8 +:8] | s35[61 * 8 +:8] | ({8{s31[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s33[29]}}) | {8{s28[29]}});
        assign result1[30 * 8 +:8] = s36[62 * 8 +:8] | s35[62 * 8 +:8] | ({8{s31[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s33[30]}}) | {8{s28[30]}});
        assign result1[31 * 8 +:8] = s36[63 * 8 +:8] | s35[63 * 8 +:8] | ({8{s31[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s33[31]}}) | {8{s28[31]}});
    end
endgenerate
generate
    if ((VLEN == 1024) && (DLEN == 512) & (VP_LEN == 256)) begin:gen_vlen1024_dlen512_vplen256
        assign s16[0] = 1'b0;
        assign s16[1] = 1'b0;
        assign s16[2] = 1'b0;
        assign s16[3] = 1'b0;
        assign s16[4] = 1'b0;
        assign s16[5] = 1'b0;
        assign s16[6] = 1'b0;
        assign s16[7] = 1'b0;
        assign s16[8] = 1'b0;
        assign s16[9] = 1'b0;
        assign s16[10] = 1'b0;
        assign s16[11] = 1'b0;
        assign s16[12] = 1'b0;
        assign s16[13] = 1'b0;
        assign s16[14] = 1'b0;
        assign s16[15] = 1'b0;
        assign s16[16] = 1'b0;
        assign s16[17] = 1'b0;
        assign s16[18] = 1'b0;
        assign s16[19] = 1'b0;
        assign s16[20] = 1'b0;
        assign s16[21] = 1'b0;
        assign s16[22] = 1'b0;
        assign s16[23] = 1'b0;
        assign s16[24] = 1'b0;
        assign s16[25] = 1'b0;
        assign s16[26] = 1'b0;
        assign s16[27] = 1'b0;
        assign s16[28] = 1'b0;
        assign s16[29] = 1'b0;
        assign s16[30] = 1'b0;
        assign s16[31] = 1'b0;
        assign s17[0] = 1'b0;
        assign s17[1] = 1'b0;
        assign s17[2] = 1'b0;
        assign s17[3] = 1'b0;
        assign s17[4] = 1'b0;
        assign s17[5] = 1'b0;
        assign s17[6] = 1'b0;
        assign s17[7] = 1'b0;
        assign s17[8] = 1'b0;
        assign s17[9] = 1'b0;
        assign s17[10] = 1'b0;
        assign s17[11] = 1'b0;
        assign s17[12] = 1'b0;
        assign s17[13] = 1'b0;
        assign s17[14] = 1'b0;
        assign s17[15] = 1'b0;
        assign s17[16] = 1'b0;
        assign s17[17] = 1'b0;
        assign s17[18] = 1'b0;
        assign s17[19] = 1'b0;
        assign s17[20] = 1'b0;
        assign s17[21] = 1'b0;
        assign s17[22] = 1'b0;
        assign s17[23] = 1'b0;
        assign s17[24] = 1'b0;
        assign s17[25] = 1'b0;
        assign s17[26] = 1'b0;
        assign s17[27] = 1'b0;
        assign s17[28] = 1'b0;
        assign s17[29] = 1'b0;
        assign s17[30] = 1'b0;
        assign s17[31] = 1'b0;
        assign s22[0] = 1'b0;
        assign s18[0] = 1'b0;
        assign s22[1] = s0[15];
        assign s18[1] = 1'b0;
        assign s22[2] = s0[23];
        assign s18[2] = 1'b0;
        assign s22[3] = s0[31];
        assign s18[3] = 1'b0;
        assign s22[4] = s0[39];
        assign s18[4] = 1'b0;
        assign s22[5] = s0[47];
        assign s18[5] = 1'b0;
        assign s22[6] = s0[55];
        assign s18[6] = 1'b0;
        assign s22[7] = s0[63];
        assign s18[7] = 1'b0;
        assign s22[8] = 1'b0;
        assign s18[8] = 1'b0;
        assign s22[9] = s0[79];
        assign s18[9] = 1'b0;
        assign s22[10] = s0[87];
        assign s18[10] = 1'b0;
        assign s22[11] = s0[95];
        assign s18[11] = 1'b0;
        assign s22[12] = s0[103];
        assign s18[12] = 1'b0;
        assign s22[13] = s0[111];
        assign s18[13] = 1'b0;
        assign s22[14] = s0[119];
        assign s18[14] = 1'b0;
        assign s22[15] = s0[127];
        assign s18[15] = 1'b0;
        assign s22[16] = 1'b0;
        assign s18[16] = 1'b0;
        assign s22[17] = s0[143];
        assign s18[17] = 1'b0;
        assign s22[18] = s0[151];
        assign s18[18] = 1'b0;
        assign s22[19] = s0[159];
        assign s18[19] = 1'b0;
        assign s22[20] = s0[167];
        assign s18[20] = 1'b0;
        assign s22[21] = s0[175];
        assign s18[21] = 1'b0;
        assign s22[22] = s0[183];
        assign s18[22] = 1'b0;
        assign s22[23] = s0[191];
        assign s18[23] = 1'b0;
        assign s22[24] = 1'b0;
        assign s18[24] = 1'b0;
        assign s22[25] = s0[207];
        assign s18[25] = 1'b0;
        assign s22[26] = s0[215];
        assign s18[26] = 1'b0;
        assign s22[27] = s0[223];
        assign s18[27] = 1'b0;
        assign s22[28] = s0[231];
        assign s18[28] = 1'b0;
        assign s22[29] = s0[239];
        assign s18[29] = 1'b0;
        assign s22[30] = s0[247];
        assign s18[30] = 1'b0;
        assign s22[31] = s0[255];
        assign s18[31] = 1'b0;
        assign s25[0 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[1 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[2 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[3 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s19[0] = 1'b0;
        assign s19[1] = 1'b0;
        assign s19[2] = 1'b0;
        assign s19[3] = 1'b0;
        assign s19[4] = 1'b0;
        assign s19[5] = 1'b0;
        assign s19[6] = 1'b0;
        assign s19[7] = 1'b0;
        assign s19[8] = 1'b0;
        assign s19[9] = 1'b0;
        assign s19[10] = 1'b0;
        assign s19[11] = 1'b0;
        assign s19[12] = 1'b0;
        assign s19[13] = 1'b0;
        assign s19[14] = 1'b0;
        assign s19[15] = 1'b0;
        assign s19[16] = 1'b0;
        assign s19[17] = 1'b0;
        assign s19[18] = 1'b0;
        assign s19[19] = 1'b0;
        assign s19[20] = 1'b0;
        assign s19[21] = 1'b0;
        assign s19[22] = 1'b0;
        assign s19[23] = 1'b0;
        assign s19[24] = 1'b0;
        assign s19[25] = 1'b0;
        assign s19[26] = 1'b0;
        assign s19[27] = 1'b0;
        assign s19[28] = 1'b0;
        assign s19[29] = 1'b0;
        assign s19[30] = 1'b0;
        assign s19[31] = 1'b0;
        assign s23[0] = 1'b0;
        assign s20[0] = 1'b0;
        assign s23[1] = 1'b0;
        assign s20[1] = 1'b0;
        assign s23[2] = s0[23];
        assign s20[2] = 1'b0;
        assign s23[3] = s0[31];
        assign s20[3] = 1'b0;
        assign s23[4] = s0[39];
        assign s20[4] = 1'b0;
        assign s23[5] = s0[47];
        assign s20[5] = 1'b0;
        assign s23[6] = s0[55];
        assign s20[6] = 1'b0;
        assign s23[7] = s0[63];
        assign s20[7] = 1'b0;
        assign s23[8] = 1'b0;
        assign s20[8] = 1'b0;
        assign s23[9] = 1'b0;
        assign s20[9] = 1'b0;
        assign s23[10] = s0[87];
        assign s20[10] = 1'b0;
        assign s23[11] = s0[95];
        assign s20[11] = 1'b0;
        assign s23[12] = s0[103];
        assign s20[12] = 1'b0;
        assign s23[13] = s0[111];
        assign s20[13] = 1'b0;
        assign s23[14] = s0[119];
        assign s20[14] = 1'b0;
        assign s23[15] = s0[127];
        assign s20[15] = 1'b0;
        assign s23[16] = 1'b0;
        assign s20[16] = 1'b0;
        assign s23[17] = 1'b0;
        assign s20[17] = 1'b0;
        assign s23[18] = s0[151];
        assign s20[18] = 1'b0;
        assign s23[19] = s0[159];
        assign s20[19] = 1'b0;
        assign s23[20] = s0[167];
        assign s20[20] = 1'b0;
        assign s23[21] = s0[175];
        assign s20[21] = 1'b0;
        assign s23[22] = s0[183];
        assign s20[22] = 1'b0;
        assign s23[23] = s0[191];
        assign s20[23] = 1'b0;
        assign s23[24] = 1'b0;
        assign s20[24] = 1'b0;
        assign s23[25] = 1'b0;
        assign s20[25] = 1'b0;
        assign s23[26] = s0[215];
        assign s20[26] = 1'b0;
        assign s23[27] = s0[223];
        assign s20[27] = 1'b0;
        assign s23[28] = s0[231];
        assign s20[28] = 1'b0;
        assign s23[29] = s0[239];
        assign s20[29] = 1'b0;
        assign s23[30] = s0[247];
        assign s20[30] = 1'b0;
        assign s23[31] = s0[255];
        assign s20[31] = 1'b0;
        assign s26[0 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[1 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[2 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[3 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s24[0] = 1'b0;
        assign s21[0] = 1'b0;
        assign s24[1] = 1'b0;
        assign s21[1] = 1'b0;
        assign s24[2] = 1'b0;
        assign s21[2] = 1'b0;
        assign s24[3] = 1'b0;
        assign s21[3] = 1'b0;
        assign s24[4] = s0[39];
        assign s21[4] = 1'b0;
        assign s24[5] = s0[47];
        assign s21[5] = 1'b0;
        assign s24[6] = s0[55];
        assign s21[6] = 1'b0;
        assign s24[7] = s0[63];
        assign s21[7] = 1'b0;
        assign s24[8] = 1'b0;
        assign s21[8] = 1'b0;
        assign s24[9] = 1'b0;
        assign s21[9] = 1'b0;
        assign s24[10] = 1'b0;
        assign s21[10] = 1'b0;
        assign s24[11] = 1'b0;
        assign s21[11] = 1'b0;
        assign s24[12] = s0[103];
        assign s21[12] = 1'b0;
        assign s24[13] = s0[111];
        assign s21[13] = 1'b0;
        assign s24[14] = s0[119];
        assign s21[14] = 1'b0;
        assign s24[15] = s0[127];
        assign s21[15] = 1'b0;
        assign s24[16] = 1'b0;
        assign s21[16] = 1'b0;
        assign s24[17] = 1'b0;
        assign s21[17] = 1'b0;
        assign s24[18] = 1'b0;
        assign s21[18] = 1'b0;
        assign s24[19] = 1'b0;
        assign s21[19] = 1'b0;
        assign s24[20] = s0[167];
        assign s21[20] = 1'b0;
        assign s24[21] = s0[175];
        assign s21[21] = 1'b0;
        assign s24[22] = s0[183];
        assign s21[22] = 1'b0;
        assign s24[23] = s0[191];
        assign s21[23] = 1'b0;
        assign s24[24] = 1'b0;
        assign s21[24] = 1'b0;
        assign s24[25] = 1'b0;
        assign s21[25] = 1'b0;
        assign s24[26] = 1'b0;
        assign s21[26] = 1'b0;
        assign s24[27] = 1'b0;
        assign s21[27] = 1'b0;
        assign s24[28] = s0[231];
        assign s21[28] = 1'b0;
        assign s24[29] = s0[239];
        assign s21[29] = 1'b0;
        assign s24[30] = s0[247];
        assign s21[30] = 1'b0;
        assign s24[31] = s0[255];
        assign s21[31] = 1'b0;
        assign s27[0 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[1 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[2 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[3 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        kv_mux128 #(
            .W(8)
        ) u_mux0 (
            .out(s0[0 * 8 +:8]),
            .sel(idx[0 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux1 (
            .out(s0[1 * 8 +:8]),
            .sel(idx[1 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux2 (
            .out(s0[2 * 8 +:8]),
            .sel(idx[2 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux3 (
            .out(s0[3 * 8 +:8]),
            .sel(idx[3 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux4 (
            .out(s0[4 * 8 +:8]),
            .sel(idx[4 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux5 (
            .out(s0[5 * 8 +:8]),
            .sel(idx[5 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux6 (
            .out(s0[6 * 8 +:8]),
            .sel(idx[6 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux7 (
            .out(s0[7 * 8 +:8]),
            .sel(idx[7 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux8 (
            .out(s0[8 * 8 +:8]),
            .sel(idx[8 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux9 (
            .out(s0[9 * 8 +:8]),
            .sel(idx[9 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux10 (
            .out(s0[10 * 8 +:8]),
            .sel(idx[10 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux11 (
            .out(s0[11 * 8 +:8]),
            .sel(idx[11 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux12 (
            .out(s0[12 * 8 +:8]),
            .sel(idx[12 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux13 (
            .out(s0[13 * 8 +:8]),
            .sel(idx[13 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux14 (
            .out(s0[14 * 8 +:8]),
            .sel(idx[14 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux15 (
            .out(s0[15 * 8 +:8]),
            .sel(idx[15 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux16 (
            .out(s0[16 * 8 +:8]),
            .sel(idx[16 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux17 (
            .out(s0[17 * 8 +:8]),
            .sel(idx[17 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux18 (
            .out(s0[18 * 8 +:8]),
            .sel(idx[18 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux19 (
            .out(s0[19 * 8 +:8]),
            .sel(idx[19 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux20 (
            .out(s0[20 * 8 +:8]),
            .sel(idx[20 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux21 (
            .out(s0[21 * 8 +:8]),
            .sel(idx[21 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux22 (
            .out(s0[22 * 8 +:8]),
            .sel(idx[22 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux23 (
            .out(s0[23 * 8 +:8]),
            .sel(idx[23 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux24 (
            .out(s0[24 * 8 +:8]),
            .sel(idx[24 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux25 (
            .out(s0[25 * 8 +:8]),
            .sel(idx[25 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux26 (
            .out(s0[26 * 8 +:8]),
            .sel(idx[26 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux27 (
            .out(s0[27 * 8 +:8]),
            .sel(idx[27 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux28 (
            .out(s0[28 * 8 +:8]),
            .sel(idx[28 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux29 (
            .out(s0[29 * 8 +:8]),
            .sel(idx[29 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux30 (
            .out(s0[30 * 8 +:8]),
            .sel(idx[30 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux31 (
            .out(s0[31 * 8 +:8]),
            .sel(idx[31 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        assign s13[0 +:8] = {{4{s0[3] & s4}},s0[0 +:4] & {4{s1}}};
        assign s13[8 +:8] = {{4{s0[7] & s4}},s0[4 +:4] & {4{s1}}};
        assign s13[16 +:8] = {{4{s0[11] & s4}},s0[8 +:4] & {4{s1}}};
        assign s13[24 +:8] = {{4{s0[15] & s4}},s0[12 +:4] & {4{s1}}};
        assign s13[32 +:8] = {{4{s0[19] & s4}},s0[16 +:4] & {4{s1}}};
        assign s13[40 +:8] = {{4{s0[23] & s4}},s0[20 +:4] & {4{s1}}};
        assign s13[48 +:8] = {{4{s0[27] & s4}},s0[24 +:4] & {4{s1}}};
        assign s13[56 +:8] = {{4{s0[31] & s4}},s0[28 +:4] & {4{s1}}};
        assign s13[64 +:8] = {{4{s0[35] & s4}},s0[32 +:4] & {4{s1}}};
        assign s13[72 +:8] = {{4{s0[39] & s4}},s0[36 +:4] & {4{s1}}};
        assign s13[80 +:8] = {{4{s0[43] & s4}},s0[40 +:4] & {4{s1}}};
        assign s13[88 +:8] = {{4{s0[47] & s4}},s0[44 +:4] & {4{s1}}};
        assign s13[96 +:8] = {{4{s0[51] & s4}},s0[48 +:4] & {4{s1}}};
        assign s13[104 +:8] = {{4{s0[55] & s4}},s0[52 +:4] & {4{s1}}};
        assign s13[112 +:8] = {{4{s0[59] & s4}},s0[56 +:4] & {4{s1}}};
        assign s13[120 +:8] = {{4{s0[63] & s4}},s0[60 +:4] & {4{s1}}};
        assign s13[128 +:8] = {{4{s0[67] & s4}},s0[64 +:4] & {4{s1}}};
        assign s13[136 +:8] = {{4{s0[71] & s4}},s0[68 +:4] & {4{s1}}};
        assign s13[144 +:8] = {{4{s0[75] & s4}},s0[72 +:4] & {4{s1}}};
        assign s13[152 +:8] = {{4{s0[79] & s4}},s0[76 +:4] & {4{s1}}};
        assign s13[160 +:8] = {{4{s0[83] & s4}},s0[80 +:4] & {4{s1}}};
        assign s13[168 +:8] = {{4{s0[87] & s4}},s0[84 +:4] & {4{s1}}};
        assign s13[176 +:8] = {{4{s0[91] & s4}},s0[88 +:4] & {4{s1}}};
        assign s13[184 +:8] = {{4{s0[95] & s4}},s0[92 +:4] & {4{s1}}};
        assign s13[192 +:8] = {{4{s0[99] & s4}},s0[96 +:4] & {4{s1}}};
        assign s13[200 +:8] = {{4{s0[103] & s4}},s0[100 +:4] & {4{s1}}};
        assign s13[208 +:8] = {{4{s0[107] & s4}},s0[104 +:4] & {4{s1}}};
        assign s13[216 +:8] = {{4{s0[111] & s4}},s0[108 +:4] & {4{s1}}};
        assign s13[224 +:8] = {{4{s0[115] & s4}},s0[112 +:4] & {4{s1}}};
        assign s13[232 +:8] = {{4{s0[119] & s4}},s0[116 +:4] & {4{s1}}};
        assign s13[240 +:8] = {{4{s0[123] & s4}},s0[120 +:4] & {4{s1}}};
        assign s13[248 +:8] = {{4{s0[127] & s4}},s0[124 +:4] & {4{s1}}};
        assign s13[256 +:8] = {{4{s0[131] & s4}},s0[128 +:4] & {4{s1}}};
        assign s13[264 +:8] = {{4{s0[135] & s4}},s0[132 +:4] & {4{s1}}};
        assign s13[272 +:8] = {{4{s0[139] & s4}},s0[136 +:4] & {4{s1}}};
        assign s13[280 +:8] = {{4{s0[143] & s4}},s0[140 +:4] & {4{s1}}};
        assign s13[288 +:8] = {{4{s0[147] & s4}},s0[144 +:4] & {4{s1}}};
        assign s13[296 +:8] = {{4{s0[151] & s4}},s0[148 +:4] & {4{s1}}};
        assign s13[304 +:8] = {{4{s0[155] & s4}},s0[152 +:4] & {4{s1}}};
        assign s13[312 +:8] = {{4{s0[159] & s4}},s0[156 +:4] & {4{s1}}};
        assign s13[320 +:8] = {{4{s0[163] & s4}},s0[160 +:4] & {4{s1}}};
        assign s13[328 +:8] = {{4{s0[167] & s4}},s0[164 +:4] & {4{s1}}};
        assign s13[336 +:8] = {{4{s0[171] & s4}},s0[168 +:4] & {4{s1}}};
        assign s13[344 +:8] = {{4{s0[175] & s4}},s0[172 +:4] & {4{s1}}};
        assign s13[352 +:8] = {{4{s0[179] & s4}},s0[176 +:4] & {4{s1}}};
        assign s13[360 +:8] = {{4{s0[183] & s4}},s0[180 +:4] & {4{s1}}};
        assign s13[368 +:8] = {{4{s0[187] & s4}},s0[184 +:4] & {4{s1}}};
        assign s13[376 +:8] = {{4{s0[191] & s4}},s0[188 +:4] & {4{s1}}};
        assign s13[384 +:8] = {{4{s0[195] & s4}},s0[192 +:4] & {4{s1}}};
        assign s13[392 +:8] = {{4{s0[199] & s4}},s0[196 +:4] & {4{s1}}};
        assign s13[400 +:8] = {{4{s0[203] & s4}},s0[200 +:4] & {4{s1}}};
        assign s13[408 +:8] = {{4{s0[207] & s4}},s0[204 +:4] & {4{s1}}};
        assign s13[416 +:8] = {{4{s0[211] & s4}},s0[208 +:4] & {4{s1}}};
        assign s13[424 +:8] = {{4{s0[215] & s4}},s0[212 +:4] & {4{s1}}};
        assign s13[432 +:8] = {{4{s0[219] & s4}},s0[216 +:4] & {4{s1}}};
        assign s13[440 +:8] = {{4{s0[223] & s4}},s0[220 +:4] & {4{s1}}};
        assign s13[448 +:8] = {{4{s0[227] & s4}},s0[224 +:4] & {4{s1}}};
        assign s13[456 +:8] = {{4{s0[231] & s4}},s0[228 +:4] & {4{s1}}};
        assign s13[464 +:8] = {{4{s0[235] & s4}},s0[232 +:4] & {4{s1}}};
        assign s13[472 +:8] = {{4{s0[239] & s4}},s0[236 +:4] & {4{s1}}};
        assign s13[480 +:8] = {{4{s0[243] & s4}},s0[240 +:4] & {4{s1}}};
        assign s13[488 +:8] = {{4{s0[247] & s4}},s0[244 +:4] & {4{s1}}};
        assign s13[496 +:8] = {{4{s0[251] & s4}},s0[248 +:4] & {4{s1}}};
        assign s13[504 +:8] = {{4{s0[255] & s4}},s0[252 +:4] & {4{s1}}};
        assign s14[0 +:16] = {{12{s0[3] & s5}},s0[0 +:4] & {4{s2}}};
        assign s14[16 +:16] = {{12{s0[7] & s5}},s0[4 +:4] & {4{s2}}};
        assign s14[32 +:16] = {{12{s0[11] & s5}},s0[8 +:4] & {4{s2}}};
        assign s14[48 +:16] = {{12{s0[15] & s5}},s0[12 +:4] & {4{s2}}};
        assign s14[64 +:16] = {{12{s0[19] & s5}},s0[16 +:4] & {4{s2}}};
        assign s14[80 +:16] = {{12{s0[23] & s5}},s0[20 +:4] & {4{s2}}};
        assign s14[96 +:16] = {{12{s0[27] & s5}},s0[24 +:4] & {4{s2}}};
        assign s14[112 +:16] = {{12{s0[31] & s5}},s0[28 +:4] & {4{s2}}};
        assign s14[128 +:16] = {{12{s0[35] & s5}},s0[32 +:4] & {4{s2}}};
        assign s14[144 +:16] = {{12{s0[39] & s5}},s0[36 +:4] & {4{s2}}};
        assign s14[160 +:16] = {{12{s0[43] & s5}},s0[40 +:4] & {4{s2}}};
        assign s14[176 +:16] = {{12{s0[47] & s5}},s0[44 +:4] & {4{s2}}};
        assign s14[192 +:16] = {{12{s0[51] & s5}},s0[48 +:4] & {4{s2}}};
        assign s14[208 +:16] = {{12{s0[55] & s5}},s0[52 +:4] & {4{s2}}};
        assign s14[224 +:16] = {{12{s0[59] & s5}},s0[56 +:4] & {4{s2}}};
        assign s14[240 +:16] = {{12{s0[63] & s5}},s0[60 +:4] & {4{s2}}};
        assign s14[256 +:16] = {{12{s0[67] & s5}},s0[64 +:4] & {4{s2}}};
        assign s14[272 +:16] = {{12{s0[71] & s5}},s0[68 +:4] & {4{s2}}};
        assign s14[288 +:16] = {{12{s0[75] & s5}},s0[72 +:4] & {4{s2}}};
        assign s14[304 +:16] = {{12{s0[79] & s5}},s0[76 +:4] & {4{s2}}};
        assign s14[320 +:16] = {{12{s0[83] & s5}},s0[80 +:4] & {4{s2}}};
        assign s14[336 +:16] = {{12{s0[87] & s5}},s0[84 +:4] & {4{s2}}};
        assign s14[352 +:16] = {{12{s0[91] & s5}},s0[88 +:4] & {4{s2}}};
        assign s14[368 +:16] = {{12{s0[95] & s5}},s0[92 +:4] & {4{s2}}};
        assign s14[384 +:16] = {{12{s0[99] & s5}},s0[96 +:4] & {4{s2}}};
        assign s14[400 +:16] = {{12{s0[103] & s5}},s0[100 +:4] & {4{s2}}};
        assign s14[416 +:16] = {{12{s0[107] & s5}},s0[104 +:4] & {4{s2}}};
        assign s14[432 +:16] = {{12{s0[111] & s5}},s0[108 +:4] & {4{s2}}};
        assign s14[448 +:16] = {{12{s0[115] & s5}},s0[112 +:4] & {4{s2}}};
        assign s14[464 +:16] = {{12{s0[119] & s5}},s0[116 +:4] & {4{s2}}};
        assign s14[480 +:16] = {{12{s0[123] & s5}},s0[120 +:4] & {4{s2}}};
        assign s14[496 +:16] = {{12{s0[127] & s5}},s0[124 +:4] & {4{s2}}};
        assign s15[0 +:32] = {{28{s0[3] & s6}},s0[0 +:4] & {4{s3}}};
        assign s15[32 +:32] = {{28{s0[7] & s6}},s0[4 +:4] & {4{s3}}};
        assign s15[64 +:32] = {{28{s0[11] & s6}},s0[8 +:4] & {4{s3}}};
        assign s15[96 +:32] = {{28{s0[15] & s6}},s0[12 +:4] & {4{s3}}};
        assign s15[128 +:32] = {{28{s0[19] & s6}},s0[16 +:4] & {4{s3}}};
        assign s15[160 +:32] = {{28{s0[23] & s6}},s0[20 +:4] & {4{s3}}};
        assign s15[192 +:32] = {{28{s0[27] & s6}},s0[24 +:4] & {4{s3}}};
        assign s15[224 +:32] = {{28{s0[31] & s6}},s0[28 +:4] & {4{s3}}};
        assign s15[256 +:32] = {{28{s0[35] & s6}},s0[32 +:4] & {4{s3}}};
        assign s15[288 +:32] = {{28{s0[39] & s6}},s0[36 +:4] & {4{s3}}};
        assign s15[320 +:32] = {{28{s0[43] & s6}},s0[40 +:4] & {4{s3}}};
        assign s15[352 +:32] = {{28{s0[47] & s6}},s0[44 +:4] & {4{s3}}};
        assign s15[384 +:32] = {{28{s0[51] & s6}},s0[48 +:4] & {4{s3}}};
        assign s15[416 +:32] = {{28{s0[55] & s6}},s0[52 +:4] & {4{s3}}};
        assign s15[448 +:32] = {{28{s0[59] & s6}},s0[56 +:4] & {4{s3}}};
        assign s15[480 +:32] = {{28{s0[63] & s6}},s0[60 +:4] & {4{s3}}};
        wire [2 * VP_LEN - 1:0] s37;
        wire s38 = vzsext & eew8x2;
        assign s37[0 +:16] = {{8{s0[7] & s7}},s0[0 +:8] & {8{s38}}};
        assign s37[16 +:16] = {{8{s0[15] & s7}},s0[8 +:8] & {8{s38}}};
        assign s37[32 +:16] = {{8{s0[23] & s7}},s0[16 +:8] & {8{s38}}};
        assign s37[48 +:16] = {{8{s0[31] & s7}},s0[24 +:8] & {8{s38}}};
        assign s37[64 +:16] = {{8{s0[39] & s7}},s0[32 +:8] & {8{s38}}};
        assign s37[80 +:16] = {{8{s0[47] & s7}},s0[40 +:8] & {8{s38}}};
        assign s37[96 +:16] = {{8{s0[55] & s7}},s0[48 +:8] & {8{s38}}};
        assign s37[112 +:16] = {{8{s0[63] & s7}},s0[56 +:8] & {8{s38}}};
        assign s37[128 +:16] = {{8{s0[71] & s7}},s0[64 +:8] & {8{s38}}};
        assign s37[144 +:16] = {{8{s0[79] & s7}},s0[72 +:8] & {8{s38}}};
        assign s37[160 +:16] = {{8{s0[87] & s7}},s0[80 +:8] & {8{s38}}};
        assign s37[176 +:16] = {{8{s0[95] & s7}},s0[88 +:8] & {8{s38}}};
        assign s37[192 +:16] = {{8{s0[103] & s7}},s0[96 +:8] & {8{s38}}};
        assign s37[208 +:16] = {{8{s0[111] & s7}},s0[104 +:8] & {8{s38}}};
        assign s37[224 +:16] = {{8{s0[119] & s7}},s0[112 +:8] & {8{s38}}};
        assign s37[240 +:16] = {{8{s0[127] & s7}},s0[120 +:8] & {8{s38}}};
        assign s37[256 +:16] = {{8{s0[135] & s7}},s0[128 +:8] & {8{s38}}};
        assign s37[272 +:16] = {{8{s0[143] & s7}},s0[136 +:8] & {8{s38}}};
        assign s37[288 +:16] = {{8{s0[151] & s7}},s0[144 +:8] & {8{s38}}};
        assign s37[304 +:16] = {{8{s0[159] & s7}},s0[152 +:8] & {8{s38}}};
        assign s37[320 +:16] = {{8{s0[167] & s7}},s0[160 +:8] & {8{s38}}};
        assign s37[336 +:16] = {{8{s0[175] & s7}},s0[168 +:8] & {8{s38}}};
        assign s37[352 +:16] = {{8{s0[183] & s7}},s0[176 +:8] & {8{s38}}};
        assign s37[368 +:16] = {{8{s0[191] & s7}},s0[184 +:8] & {8{s38}}};
        assign s37[384 +:16] = {{8{s0[199] & s7}},s0[192 +:8] & {8{s38}}};
        assign s37[400 +:16] = {{8{s0[207] & s7}},s0[200 +:8] & {8{s38}}};
        assign s37[416 +:16] = {{8{s0[215] & s7}},s0[208 +:8] & {8{s38}}};
        assign s37[432 +:16] = {{8{s0[223] & s7}},s0[216 +:8] & {8{s38}}};
        assign s37[448 +:16] = {{8{s0[231] & s7}},s0[224 +:8] & {8{s38}}};
        assign s37[464 +:16] = {{8{s0[239] & s7}},s0[232 +:8] & {8{s38}}};
        assign s37[480 +:16] = {{8{s0[247] & s7}},s0[240 +:8] & {8{s38}}};
        assign s37[496 +:16] = {{8{s0[255] & s7}},s0[248 +:8] & {8{s38}}};
        wire [2 * VP_LEN - 1:0] s39;
        wire s40 = vzsext & eew8x4;
        assign s39[0 +:32] = {{24{s0[7] & s8}},s0[0 +:8] & {8{s40}}};
        assign s39[32 +:32] = {{24{s0[15] & s8}},s0[8 +:8] & {8{s40}}};
        assign s39[64 +:32] = {{24{s0[23] & s8}},s0[16 +:8] & {8{s40}}};
        assign s39[96 +:32] = {{24{s0[31] & s8}},s0[24 +:8] & {8{s40}}};
        assign s39[128 +:32] = {{24{s0[39] & s8}},s0[32 +:8] & {8{s40}}};
        assign s39[160 +:32] = {{24{s0[47] & s8}},s0[40 +:8] & {8{s40}}};
        assign s39[192 +:32] = {{24{s0[55] & s8}},s0[48 +:8] & {8{s40}}};
        assign s39[224 +:32] = {{24{s0[63] & s8}},s0[56 +:8] & {8{s40}}};
        assign s39[256 +:32] = {{24{s0[71] & s8}},s0[64 +:8] & {8{s40}}};
        assign s39[288 +:32] = {{24{s0[79] & s8}},s0[72 +:8] & {8{s40}}};
        assign s39[320 +:32] = {{24{s0[87] & s8}},s0[80 +:8] & {8{s40}}};
        assign s39[352 +:32] = {{24{s0[95] & s8}},s0[88 +:8] & {8{s40}}};
        assign s39[384 +:32] = {{24{s0[103] & s8}},s0[96 +:8] & {8{s40}}};
        assign s39[416 +:32] = {{24{s0[111] & s8}},s0[104 +:8] & {8{s40}}};
        assign s39[448 +:32] = {{24{s0[119] & s8}},s0[112 +:8] & {8{s40}}};
        assign s39[480 +:32] = {{24{s0[127] & s8}},s0[120 +:8] & {8{s40}}};
        wire [2 * VP_LEN - 1:0] s41;
        wire s42 = vzsext & eew8x8;
        assign s41[0 +:64] = {{56{s0[7] & s9}},s0[0 +:8] & {8{s42}}};
        assign s41[64 +:64] = {{56{s0[15] & s9}},s0[8 +:8] & {8{s42}}};
        assign s41[128 +:64] = {{56{s0[23] & s9}},s0[16 +:8] & {8{s42}}};
        assign s41[192 +:64] = {{56{s0[31] & s9}},s0[24 +:8] & {8{s42}}};
        assign s41[256 +:64] = {{56{s0[39] & s9}},s0[32 +:8] & {8{s42}}};
        assign s41[320 +:64] = {{56{s0[47] & s9}},s0[40 +:8] & {8{s42}}};
        assign s41[384 +:64] = {{56{s0[55] & s9}},s0[48 +:8] & {8{s42}}};
        assign s41[448 +:64] = {{56{s0[63] & s9}},s0[56 +:8] & {8{s42}}};
        wire [2 * VP_LEN - 1:0] s43;
        wire s44 = vzsext & eew16x2;
        assign s43[0 +:32] = {{16{s0[15] & s10}},s0[0 +:16] & {16{s44}}};
        assign s43[32 +:32] = {{16{s0[31] & s10}},s0[16 +:16] & {16{s44}}};
        assign s43[64 +:32] = {{16{s0[47] & s10}},s0[32 +:16] & {16{s44}}};
        assign s43[96 +:32] = {{16{s0[63] & s10}},s0[48 +:16] & {16{s44}}};
        assign s43[128 +:32] = {{16{s0[79] & s10}},s0[64 +:16] & {16{s44}}};
        assign s43[160 +:32] = {{16{s0[95] & s10}},s0[80 +:16] & {16{s44}}};
        assign s43[192 +:32] = {{16{s0[111] & s10}},s0[96 +:16] & {16{s44}}};
        assign s43[224 +:32] = {{16{s0[127] & s10}},s0[112 +:16] & {16{s44}}};
        assign s43[256 +:32] = {{16{s0[143] & s10}},s0[128 +:16] & {16{s44}}};
        assign s43[288 +:32] = {{16{s0[159] & s10}},s0[144 +:16] & {16{s44}}};
        assign s43[320 +:32] = {{16{s0[175] & s10}},s0[160 +:16] & {16{s44}}};
        assign s43[352 +:32] = {{16{s0[191] & s10}},s0[176 +:16] & {16{s44}}};
        assign s43[384 +:32] = {{16{s0[207] & s10}},s0[192 +:16] & {16{s44}}};
        assign s43[416 +:32] = {{16{s0[223] & s10}},s0[208 +:16] & {16{s44}}};
        assign s43[448 +:32] = {{16{s0[239] & s10}},s0[224 +:16] & {16{s44}}};
        assign s43[480 +:32] = {{16{s0[255] & s10}},s0[240 +:16] & {16{s44}}};
        wire [2 * VP_LEN - 1:0] s45;
        wire s46 = vzsext & eew16x4;
        assign s45[0 +:64] = {{48{s0[15] & s11}},s0[0 +:16] & {16{s46}}};
        assign s45[64 +:64] = {{48{s0[31] & s11}},s0[16 +:16] & {16{s46}}};
        assign s45[128 +:64] = {{48{s0[47] & s11}},s0[32 +:16] & {16{s46}}};
        assign s45[192 +:64] = {{48{s0[63] & s11}},s0[48 +:16] & {16{s46}}};
        assign s45[256 +:64] = {{48{s0[79] & s11}},s0[64 +:16] & {16{s46}}};
        assign s45[320 +:64] = {{48{s0[95] & s11}},s0[80 +:16] & {16{s46}}};
        assign s45[384 +:64] = {{48{s0[111] & s11}},s0[96 +:16] & {16{s46}}};
        assign s45[448 +:64] = {{48{s0[127] & s11}},s0[112 +:16] & {16{s46}}};
        wire [2 * VP_LEN - 1:0] s47;
        wire s48 = vzsext & eew32x2;
        assign s47[0 +:64] = {{32{s0[31] & s12}},s0[0 +:32] & {32{s48}}};
        assign s47[64 +:64] = {{32{s0[63] & s12}},s0[32 +:32] & {32{s48}}};
        assign s47[128 +:64] = {{32{s0[95] & s12}},s0[64 +:32] & {32{s48}}};
        assign s47[192 +:64] = {{32{s0[127] & s12}},s0[96 +:32] & {32{s48}}};
        assign s47[256 +:64] = {{32{s0[159] & s12}},s0[128 +:32] & {32{s48}}};
        assign s47[320 +:64] = {{32{s0[191] & s12}},s0[160 +:32] & {32{s48}}};
        assign s47[384 +:64] = {{32{s0[223] & s12}},s0[192 +:32] & {32{s48}}};
        assign s47[448 +:64] = {{32{s0[255] & s12}},s0[224 +:32] & {32{s48}}};
        wire [2 * VP_LEN - 1:0] s35;
        assign s35 = s13 | s14 | s15 | s37 | s39 | s41 | s43 | s45 | s47;
        wire [2 * VP_LEN - 1:0] s36 = {2 * VP_LEN{vmv_nr}} & {vs2_buf[VP_LEN +:VP_LEN],{VP_LEN{1'b0}}};
        assign result0[0 * 8 +:8] = s36[0 * 8 +:8] | s35[0 * 8 +:8] | ({8{s30[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s32[0]}}) | {8{s28[0]}});
        assign result0[1 * 8 +:8] = s36[1 * 8 +:8] | s35[1 * 8 +:8] | ({8{s30[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s32[1]}}) | {8{s28[1]}});
        assign result0[2 * 8 +:8] = s36[2 * 8 +:8] | s35[2 * 8 +:8] | ({8{s30[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s32[2]}}) | {8{s28[2]}});
        assign result0[3 * 8 +:8] = s36[3 * 8 +:8] | s35[3 * 8 +:8] | ({8{s30[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s32[3]}}) | {8{s28[3]}});
        assign result0[4 * 8 +:8] = s36[4 * 8 +:8] | s35[4 * 8 +:8] | ({8{s30[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s32[4]}}) | {8{s28[4]}});
        assign result0[5 * 8 +:8] = s36[5 * 8 +:8] | s35[5 * 8 +:8] | ({8{s30[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s32[5]}}) | {8{s28[5]}});
        assign result0[6 * 8 +:8] = s36[6 * 8 +:8] | s35[6 * 8 +:8] | ({8{s30[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s32[6]}}) | {8{s28[6]}});
        assign result0[7 * 8 +:8] = s36[7 * 8 +:8] | s35[7 * 8 +:8] | ({8{s30[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s32[7]}}) | {8{s28[7]}});
        assign result0[8 * 8 +:8] = s36[8 * 8 +:8] | s35[8 * 8 +:8] | ({8{s30[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s32[8]}}) | {8{s28[8]}});
        assign result0[9 * 8 +:8] = s36[9 * 8 +:8] | s35[9 * 8 +:8] | ({8{s30[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s32[9]}}) | {8{s28[9]}});
        assign result0[10 * 8 +:8] = s36[10 * 8 +:8] | s35[10 * 8 +:8] | ({8{s30[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s32[10]}}) | {8{s28[10]}});
        assign result0[11 * 8 +:8] = s36[11 * 8 +:8] | s35[11 * 8 +:8] | ({8{s30[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s32[11]}}) | {8{s28[11]}});
        assign result0[12 * 8 +:8] = s36[12 * 8 +:8] | s35[12 * 8 +:8] | ({8{s30[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s32[12]}}) | {8{s28[12]}});
        assign result0[13 * 8 +:8] = s36[13 * 8 +:8] | s35[13 * 8 +:8] | ({8{s30[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s32[13]}}) | {8{s28[13]}});
        assign result0[14 * 8 +:8] = s36[14 * 8 +:8] | s35[14 * 8 +:8] | ({8{s30[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s32[14]}}) | {8{s28[14]}});
        assign result0[15 * 8 +:8] = s36[15 * 8 +:8] | s35[15 * 8 +:8] | ({8{s30[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s32[15]}}) | {8{s28[15]}});
        assign result0[16 * 8 +:8] = s36[16 * 8 +:8] | s35[16 * 8 +:8] | ({8{s30[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s32[16]}}) | {8{s28[16]}});
        assign result0[17 * 8 +:8] = s36[17 * 8 +:8] | s35[17 * 8 +:8] | ({8{s30[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s32[17]}}) | {8{s28[17]}});
        assign result0[18 * 8 +:8] = s36[18 * 8 +:8] | s35[18 * 8 +:8] | ({8{s30[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s32[18]}}) | {8{s28[18]}});
        assign result0[19 * 8 +:8] = s36[19 * 8 +:8] | s35[19 * 8 +:8] | ({8{s30[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s32[19]}}) | {8{s28[19]}});
        assign result0[20 * 8 +:8] = s36[20 * 8 +:8] | s35[20 * 8 +:8] | ({8{s30[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s32[20]}}) | {8{s28[20]}});
        assign result0[21 * 8 +:8] = s36[21 * 8 +:8] | s35[21 * 8 +:8] | ({8{s30[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s32[21]}}) | {8{s28[21]}});
        assign result0[22 * 8 +:8] = s36[22 * 8 +:8] | s35[22 * 8 +:8] | ({8{s30[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s32[22]}}) | {8{s28[22]}});
        assign result0[23 * 8 +:8] = s36[23 * 8 +:8] | s35[23 * 8 +:8] | ({8{s30[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s32[23]}}) | {8{s28[23]}});
        assign result0[24 * 8 +:8] = s36[24 * 8 +:8] | s35[24 * 8 +:8] | ({8{s30[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s32[24]}}) | {8{s28[24]}});
        assign result0[25 * 8 +:8] = s36[25 * 8 +:8] | s35[25 * 8 +:8] | ({8{s30[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s32[25]}}) | {8{s28[25]}});
        assign result0[26 * 8 +:8] = s36[26 * 8 +:8] | s35[26 * 8 +:8] | ({8{s30[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s32[26]}}) | {8{s28[26]}});
        assign result0[27 * 8 +:8] = s36[27 * 8 +:8] | s35[27 * 8 +:8] | ({8{s30[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s32[27]}}) | {8{s28[27]}});
        assign result0[28 * 8 +:8] = s36[28 * 8 +:8] | s35[28 * 8 +:8] | ({8{s30[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s32[28]}}) | {8{s28[28]}});
        assign result0[29 * 8 +:8] = s36[29 * 8 +:8] | s35[29 * 8 +:8] | ({8{s30[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s32[29]}}) | {8{s28[29]}});
        assign result0[30 * 8 +:8] = s36[30 * 8 +:8] | s35[30 * 8 +:8] | ({8{s30[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s32[30]}}) | {8{s28[30]}});
        assign result0[31 * 8 +:8] = s36[31 * 8 +:8] | s35[31 * 8 +:8] | ({8{s30[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s32[31]}}) | {8{s28[31]}});
        assign result1[0 * 8 +:8] = s36[32 * 8 +:8] | s35[32 * 8 +:8] | ({8{s31[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s33[0]}}) | {8{s28[0]}});
        assign result1[1 * 8 +:8] = s36[33 * 8 +:8] | s35[33 * 8 +:8] | ({8{s31[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s33[1]}}) | {8{s28[1]}});
        assign result1[2 * 8 +:8] = s36[34 * 8 +:8] | s35[34 * 8 +:8] | ({8{s31[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s33[2]}}) | {8{s28[2]}});
        assign result1[3 * 8 +:8] = s36[35 * 8 +:8] | s35[35 * 8 +:8] | ({8{s31[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s33[3]}}) | {8{s28[3]}});
        assign result1[4 * 8 +:8] = s36[36 * 8 +:8] | s35[36 * 8 +:8] | ({8{s31[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s33[4]}}) | {8{s28[4]}});
        assign result1[5 * 8 +:8] = s36[37 * 8 +:8] | s35[37 * 8 +:8] | ({8{s31[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s33[5]}}) | {8{s28[5]}});
        assign result1[6 * 8 +:8] = s36[38 * 8 +:8] | s35[38 * 8 +:8] | ({8{s31[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s33[6]}}) | {8{s28[6]}});
        assign result1[7 * 8 +:8] = s36[39 * 8 +:8] | s35[39 * 8 +:8] | ({8{s31[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s33[7]}}) | {8{s28[7]}});
        assign result1[8 * 8 +:8] = s36[40 * 8 +:8] | s35[40 * 8 +:8] | ({8{s31[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s33[8]}}) | {8{s28[8]}});
        assign result1[9 * 8 +:8] = s36[41 * 8 +:8] | s35[41 * 8 +:8] | ({8{s31[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s33[9]}}) | {8{s28[9]}});
        assign result1[10 * 8 +:8] = s36[42 * 8 +:8] | s35[42 * 8 +:8] | ({8{s31[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s33[10]}}) | {8{s28[10]}});
        assign result1[11 * 8 +:8] = s36[43 * 8 +:8] | s35[43 * 8 +:8] | ({8{s31[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s33[11]}}) | {8{s28[11]}});
        assign result1[12 * 8 +:8] = s36[44 * 8 +:8] | s35[44 * 8 +:8] | ({8{s31[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s33[12]}}) | {8{s28[12]}});
        assign result1[13 * 8 +:8] = s36[45 * 8 +:8] | s35[45 * 8 +:8] | ({8{s31[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s33[13]}}) | {8{s28[13]}});
        assign result1[14 * 8 +:8] = s36[46 * 8 +:8] | s35[46 * 8 +:8] | ({8{s31[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s33[14]}}) | {8{s28[14]}});
        assign result1[15 * 8 +:8] = s36[47 * 8 +:8] | s35[47 * 8 +:8] | ({8{s31[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s33[15]}}) | {8{s28[15]}});
        assign result1[16 * 8 +:8] = s36[48 * 8 +:8] | s35[48 * 8 +:8] | ({8{s31[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s33[16]}}) | {8{s28[16]}});
        assign result1[17 * 8 +:8] = s36[49 * 8 +:8] | s35[49 * 8 +:8] | ({8{s31[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s33[17]}}) | {8{s28[17]}});
        assign result1[18 * 8 +:8] = s36[50 * 8 +:8] | s35[50 * 8 +:8] | ({8{s31[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s33[18]}}) | {8{s28[18]}});
        assign result1[19 * 8 +:8] = s36[51 * 8 +:8] | s35[51 * 8 +:8] | ({8{s31[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s33[19]}}) | {8{s28[19]}});
        assign result1[20 * 8 +:8] = s36[52 * 8 +:8] | s35[52 * 8 +:8] | ({8{s31[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s33[20]}}) | {8{s28[20]}});
        assign result1[21 * 8 +:8] = s36[53 * 8 +:8] | s35[53 * 8 +:8] | ({8{s31[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s33[21]}}) | {8{s28[21]}});
        assign result1[22 * 8 +:8] = s36[54 * 8 +:8] | s35[54 * 8 +:8] | ({8{s31[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s33[22]}}) | {8{s28[22]}});
        assign result1[23 * 8 +:8] = s36[55 * 8 +:8] | s35[55 * 8 +:8] | ({8{s31[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s33[23]}}) | {8{s28[23]}});
        assign result1[24 * 8 +:8] = s36[56 * 8 +:8] | s35[56 * 8 +:8] | ({8{s31[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s33[24]}}) | {8{s28[24]}});
        assign result1[25 * 8 +:8] = s36[57 * 8 +:8] | s35[57 * 8 +:8] | ({8{s31[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s33[25]}}) | {8{s28[25]}});
        assign result1[26 * 8 +:8] = s36[58 * 8 +:8] | s35[58 * 8 +:8] | ({8{s31[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s33[26]}}) | {8{s28[26]}});
        assign result1[27 * 8 +:8] = s36[59 * 8 +:8] | s35[59 * 8 +:8] | ({8{s31[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s33[27]}}) | {8{s28[27]}});
        assign result1[28 * 8 +:8] = s36[60 * 8 +:8] | s35[60 * 8 +:8] | ({8{s31[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s33[28]}}) | {8{s28[28]}});
        assign result1[29 * 8 +:8] = s36[61 * 8 +:8] | s35[61 * 8 +:8] | ({8{s31[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s33[29]}}) | {8{s28[29]}});
        assign result1[30 * 8 +:8] = s36[62 * 8 +:8] | s35[62 * 8 +:8] | ({8{s31[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s33[30]}}) | {8{s28[30]}});
        assign result1[31 * 8 +:8] = s36[63 * 8 +:8] | s35[63 * 8 +:8] | ({8{s31[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s33[31]}}) | {8{s28[31]}});
    end
endgenerate
generate
    if ((VLEN == 512) && (DLEN == 512) & (VP_LEN == 512)) begin:gen_vlen512_dlen512_vplen512
        assign s16[0] = 1'b0;
        assign s16[1] = s0[15];
        assign s16[2] = 1'b0;
        assign s16[3] = s0[31];
        assign s16[4] = 1'b0;
        assign s16[5] = s0[47];
        assign s16[6] = 1'b0;
        assign s16[7] = s0[63];
        assign s16[8] = 1'b0;
        assign s16[9] = s0[79];
        assign s16[10] = 1'b0;
        assign s16[11] = s0[95];
        assign s16[12] = 1'b0;
        assign s16[13] = s0[111];
        assign s16[14] = 1'b0;
        assign s16[15] = s0[127];
        assign s16[16] = 1'b0;
        assign s16[17] = s0[143];
        assign s16[18] = 1'b0;
        assign s16[19] = s0[159];
        assign s16[20] = 1'b0;
        assign s16[21] = s0[175];
        assign s16[22] = 1'b0;
        assign s16[23] = s0[191];
        assign s16[24] = 1'b0;
        assign s16[25] = s0[207];
        assign s16[26] = 1'b0;
        assign s16[27] = s0[223];
        assign s16[28] = 1'b0;
        assign s16[29] = s0[239];
        assign s16[30] = 1'b0;
        assign s16[31] = s0[255];
        assign s16[32] = 1'b0;
        assign s16[33] = s0[271];
        assign s16[34] = 1'b0;
        assign s16[35] = s0[287];
        assign s16[36] = 1'b0;
        assign s16[37] = s0[303];
        assign s16[38] = 1'b0;
        assign s16[39] = s0[319];
        assign s16[40] = 1'b0;
        assign s16[41] = s0[335];
        assign s16[42] = 1'b0;
        assign s16[43] = s0[351];
        assign s16[44] = 1'b0;
        assign s16[45] = s0[367];
        assign s16[46] = 1'b0;
        assign s16[47] = s0[383];
        assign s16[48] = 1'b0;
        assign s16[49] = s0[399];
        assign s16[50] = 1'b0;
        assign s16[51] = s0[415];
        assign s16[52] = 1'b0;
        assign s16[53] = s0[431];
        assign s16[54] = 1'b0;
        assign s16[55] = s0[447];
        assign s16[56] = 1'b0;
        assign s16[57] = s0[463];
        assign s16[58] = 1'b0;
        assign s16[59] = s0[479];
        assign s16[60] = 1'b0;
        assign s16[61] = s0[495];
        assign s16[62] = 1'b0;
        assign s16[63] = s0[511];
        assign s17[0] = 1'b0;
        assign s17[1] = s0[15];
        assign s17[2] = s0[23];
        assign s17[3] = s0[31];
        assign s17[4] = 1'b0;
        assign s17[5] = s0[47];
        assign s17[6] = s0[55];
        assign s17[7] = s0[63];
        assign s17[8] = 1'b0;
        assign s17[9] = s0[79];
        assign s17[10] = s0[87];
        assign s17[11] = s0[95];
        assign s17[12] = 1'b0;
        assign s17[13] = s0[111];
        assign s17[14] = s0[119];
        assign s17[15] = s0[127];
        assign s17[16] = 1'b0;
        assign s17[17] = s0[143];
        assign s17[18] = s0[151];
        assign s17[19] = s0[159];
        assign s17[20] = 1'b0;
        assign s17[21] = s0[175];
        assign s17[22] = s0[183];
        assign s17[23] = s0[191];
        assign s17[24] = 1'b0;
        assign s17[25] = s0[207];
        assign s17[26] = s0[215];
        assign s17[27] = s0[223];
        assign s17[28] = 1'b0;
        assign s17[29] = s0[239];
        assign s17[30] = s0[247];
        assign s17[31] = s0[255];
        assign s17[32] = 1'b0;
        assign s17[33] = s0[271];
        assign s17[34] = s0[279];
        assign s17[35] = s0[287];
        assign s17[36] = 1'b0;
        assign s17[37] = s0[303];
        assign s17[38] = s0[311];
        assign s17[39] = s0[319];
        assign s17[40] = 1'b0;
        assign s17[41] = s0[335];
        assign s17[42] = s0[343];
        assign s17[43] = s0[351];
        assign s17[44] = 1'b0;
        assign s17[45] = s0[367];
        assign s17[46] = s0[375];
        assign s17[47] = s0[383];
        assign s17[48] = 1'b0;
        assign s17[49] = s0[399];
        assign s17[50] = s0[407];
        assign s17[51] = s0[415];
        assign s17[52] = 1'b0;
        assign s17[53] = s0[431];
        assign s17[54] = s0[439];
        assign s17[55] = s0[447];
        assign s17[56] = 1'b0;
        assign s17[57] = s0[463];
        assign s17[58] = s0[471];
        assign s17[59] = s0[479];
        assign s17[60] = 1'b0;
        assign s17[61] = s0[495];
        assign s17[62] = s0[503];
        assign s17[63] = s0[511];
        assign s22[0] = 1'b0;
        assign s18[0] = 1'b0;
        assign s22[1] = s0[15];
        assign s18[1] = s0[15];
        assign s22[2] = s0[23];
        assign s18[2] = s0[23];
        assign s22[3] = s0[31];
        assign s18[3] = s0[31];
        assign s22[4] = s0[39];
        assign s18[4] = s0[39];
        assign s22[5] = s0[47];
        assign s18[5] = s0[47];
        assign s22[6] = s0[55];
        assign s18[6] = s0[55];
        assign s22[7] = s0[63];
        assign s18[7] = s0[63];
        assign s22[8] = 1'b0;
        assign s18[8] = 1'b0;
        assign s22[9] = s0[79];
        assign s18[9] = s0[79];
        assign s22[10] = s0[87];
        assign s18[10] = s0[87];
        assign s22[11] = s0[95];
        assign s18[11] = s0[95];
        assign s22[12] = s0[103];
        assign s18[12] = s0[103];
        assign s22[13] = s0[111];
        assign s18[13] = s0[111];
        assign s22[14] = s0[119];
        assign s18[14] = s0[119];
        assign s22[15] = s0[127];
        assign s18[15] = s0[127];
        assign s22[16] = 1'b0;
        assign s18[16] = 1'b0;
        assign s22[17] = s0[143];
        assign s18[17] = s0[143];
        assign s22[18] = s0[151];
        assign s18[18] = s0[151];
        assign s22[19] = s0[159];
        assign s18[19] = s0[159];
        assign s22[20] = s0[167];
        assign s18[20] = s0[167];
        assign s22[21] = s0[175];
        assign s18[21] = s0[175];
        assign s22[22] = s0[183];
        assign s18[22] = s0[183];
        assign s22[23] = s0[191];
        assign s18[23] = s0[191];
        assign s22[24] = 1'b0;
        assign s18[24] = 1'b0;
        assign s22[25] = s0[207];
        assign s18[25] = s0[207];
        assign s22[26] = s0[215];
        assign s18[26] = s0[215];
        assign s22[27] = s0[223];
        assign s18[27] = s0[223];
        assign s22[28] = s0[231];
        assign s18[28] = s0[231];
        assign s22[29] = s0[239];
        assign s18[29] = s0[239];
        assign s22[30] = s0[247];
        assign s18[30] = s0[247];
        assign s22[31] = s0[255];
        assign s18[31] = s0[255];
        assign s22[32] = 1'b0;
        assign s18[32] = 1'b0;
        assign s22[33] = s0[271];
        assign s18[33] = s0[271];
        assign s22[34] = s0[279];
        assign s18[34] = s0[279];
        assign s22[35] = s0[287];
        assign s18[35] = s0[287];
        assign s22[36] = s0[295];
        assign s18[36] = s0[295];
        assign s22[37] = s0[303];
        assign s18[37] = s0[303];
        assign s22[38] = s0[311];
        assign s18[38] = s0[311];
        assign s22[39] = s0[319];
        assign s18[39] = s0[319];
        assign s22[40] = 1'b0;
        assign s18[40] = 1'b0;
        assign s22[41] = s0[335];
        assign s18[41] = s0[335];
        assign s22[42] = s0[343];
        assign s18[42] = s0[343];
        assign s22[43] = s0[351];
        assign s18[43] = s0[351];
        assign s22[44] = s0[359];
        assign s18[44] = s0[359];
        assign s22[45] = s0[367];
        assign s18[45] = s0[367];
        assign s22[46] = s0[375];
        assign s18[46] = s0[375];
        assign s22[47] = s0[383];
        assign s18[47] = s0[383];
        assign s22[48] = 1'b0;
        assign s18[48] = 1'b0;
        assign s22[49] = s0[399];
        assign s18[49] = s0[399];
        assign s22[50] = s0[407];
        assign s18[50] = s0[407];
        assign s22[51] = s0[415];
        assign s18[51] = s0[415];
        assign s22[52] = s0[423];
        assign s18[52] = s0[423];
        assign s22[53] = s0[431];
        assign s18[53] = s0[431];
        assign s22[54] = s0[439];
        assign s18[54] = s0[439];
        assign s22[55] = s0[447];
        assign s18[55] = s0[447];
        assign s22[56] = 1'b0;
        assign s18[56] = 1'b0;
        assign s22[57] = s0[463];
        assign s18[57] = s0[463];
        assign s22[58] = s0[471];
        assign s18[58] = s0[471];
        assign s22[59] = s0[479];
        assign s18[59] = s0[479];
        assign s22[60] = s0[487];
        assign s18[60] = s0[487];
        assign s22[61] = s0[495];
        assign s18[61] = s0[495];
        assign s22[62] = s0[503];
        assign s18[62] = s0[503];
        assign s22[63] = s0[511];
        assign s18[63] = s0[511];
        assign s25[0 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[1 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[2 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[3 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[4 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[5 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[6 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[7 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s19[0] = 1'b0;
        assign s19[1] = 1'b0;
        assign s19[2] = s0[23];
        assign s19[3] = s0[31];
        assign s19[4] = 1'b0;
        assign s19[5] = 1'b0;
        assign s19[6] = s0[55];
        assign s19[7] = s0[63];
        assign s19[8] = 1'b0;
        assign s19[9] = 1'b0;
        assign s19[10] = s0[87];
        assign s19[11] = s0[95];
        assign s19[12] = 1'b0;
        assign s19[13] = 1'b0;
        assign s19[14] = s0[119];
        assign s19[15] = s0[127];
        assign s19[16] = 1'b0;
        assign s19[17] = 1'b0;
        assign s19[18] = s0[151];
        assign s19[19] = s0[159];
        assign s19[20] = 1'b0;
        assign s19[21] = 1'b0;
        assign s19[22] = s0[183];
        assign s19[23] = s0[191];
        assign s19[24] = 1'b0;
        assign s19[25] = 1'b0;
        assign s19[26] = s0[215];
        assign s19[27] = s0[223];
        assign s19[28] = 1'b0;
        assign s19[29] = 1'b0;
        assign s19[30] = s0[247];
        assign s19[31] = s0[255];
        assign s19[32] = 1'b0;
        assign s19[33] = 1'b0;
        assign s19[34] = s0[279];
        assign s19[35] = s0[287];
        assign s19[36] = 1'b0;
        assign s19[37] = 1'b0;
        assign s19[38] = s0[311];
        assign s19[39] = s0[319];
        assign s19[40] = 1'b0;
        assign s19[41] = 1'b0;
        assign s19[42] = s0[343];
        assign s19[43] = s0[351];
        assign s19[44] = 1'b0;
        assign s19[45] = 1'b0;
        assign s19[46] = s0[375];
        assign s19[47] = s0[383];
        assign s19[48] = 1'b0;
        assign s19[49] = 1'b0;
        assign s19[50] = s0[407];
        assign s19[51] = s0[415];
        assign s19[52] = 1'b0;
        assign s19[53] = 1'b0;
        assign s19[54] = s0[439];
        assign s19[55] = s0[447];
        assign s19[56] = 1'b0;
        assign s19[57] = 1'b0;
        assign s19[58] = s0[471];
        assign s19[59] = s0[479];
        assign s19[60] = 1'b0;
        assign s19[61] = 1'b0;
        assign s19[62] = s0[503];
        assign s19[63] = s0[511];
        assign s23[0] = 1'b0;
        assign s20[0] = 1'b0;
        assign s23[1] = 1'b0;
        assign s20[1] = 1'b0;
        assign s23[2] = s0[23];
        assign s20[2] = s0[23];
        assign s23[3] = s0[31];
        assign s20[3] = s0[31];
        assign s23[4] = s0[39];
        assign s20[4] = s0[39];
        assign s23[5] = s0[47];
        assign s20[5] = s0[47];
        assign s23[6] = s0[55];
        assign s20[6] = s0[55];
        assign s23[7] = s0[63];
        assign s20[7] = s0[63];
        assign s23[8] = 1'b0;
        assign s20[8] = 1'b0;
        assign s23[9] = 1'b0;
        assign s20[9] = 1'b0;
        assign s23[10] = s0[87];
        assign s20[10] = s0[87];
        assign s23[11] = s0[95];
        assign s20[11] = s0[95];
        assign s23[12] = s0[103];
        assign s20[12] = s0[103];
        assign s23[13] = s0[111];
        assign s20[13] = s0[111];
        assign s23[14] = s0[119];
        assign s20[14] = s0[119];
        assign s23[15] = s0[127];
        assign s20[15] = s0[127];
        assign s23[16] = 1'b0;
        assign s20[16] = 1'b0;
        assign s23[17] = 1'b0;
        assign s20[17] = 1'b0;
        assign s23[18] = s0[151];
        assign s20[18] = s0[151];
        assign s23[19] = s0[159];
        assign s20[19] = s0[159];
        assign s23[20] = s0[167];
        assign s20[20] = s0[167];
        assign s23[21] = s0[175];
        assign s20[21] = s0[175];
        assign s23[22] = s0[183];
        assign s20[22] = s0[183];
        assign s23[23] = s0[191];
        assign s20[23] = s0[191];
        assign s23[24] = 1'b0;
        assign s20[24] = 1'b0;
        assign s23[25] = 1'b0;
        assign s20[25] = 1'b0;
        assign s23[26] = s0[215];
        assign s20[26] = s0[215];
        assign s23[27] = s0[223];
        assign s20[27] = s0[223];
        assign s23[28] = s0[231];
        assign s20[28] = s0[231];
        assign s23[29] = s0[239];
        assign s20[29] = s0[239];
        assign s23[30] = s0[247];
        assign s20[30] = s0[247];
        assign s23[31] = s0[255];
        assign s20[31] = s0[255];
        assign s23[32] = 1'b0;
        assign s20[32] = 1'b0;
        assign s23[33] = 1'b0;
        assign s20[33] = 1'b0;
        assign s23[34] = s0[279];
        assign s20[34] = s0[279];
        assign s23[35] = s0[287];
        assign s20[35] = s0[287];
        assign s23[36] = s0[295];
        assign s20[36] = s0[295];
        assign s23[37] = s0[303];
        assign s20[37] = s0[303];
        assign s23[38] = s0[311];
        assign s20[38] = s0[311];
        assign s23[39] = s0[319];
        assign s20[39] = s0[319];
        assign s23[40] = 1'b0;
        assign s20[40] = 1'b0;
        assign s23[41] = 1'b0;
        assign s20[41] = 1'b0;
        assign s23[42] = s0[343];
        assign s20[42] = s0[343];
        assign s23[43] = s0[351];
        assign s20[43] = s0[351];
        assign s23[44] = s0[359];
        assign s20[44] = s0[359];
        assign s23[45] = s0[367];
        assign s20[45] = s0[367];
        assign s23[46] = s0[375];
        assign s20[46] = s0[375];
        assign s23[47] = s0[383];
        assign s20[47] = s0[383];
        assign s23[48] = 1'b0;
        assign s20[48] = 1'b0;
        assign s23[49] = 1'b0;
        assign s20[49] = 1'b0;
        assign s23[50] = s0[407];
        assign s20[50] = s0[407];
        assign s23[51] = s0[415];
        assign s20[51] = s0[415];
        assign s23[52] = s0[423];
        assign s20[52] = s0[423];
        assign s23[53] = s0[431];
        assign s20[53] = s0[431];
        assign s23[54] = s0[439];
        assign s20[54] = s0[439];
        assign s23[55] = s0[447];
        assign s20[55] = s0[447];
        assign s23[56] = 1'b0;
        assign s20[56] = 1'b0;
        assign s23[57] = 1'b0;
        assign s20[57] = 1'b0;
        assign s23[58] = s0[471];
        assign s20[58] = s0[471];
        assign s23[59] = s0[479];
        assign s20[59] = s0[479];
        assign s23[60] = s0[487];
        assign s20[60] = s0[487];
        assign s23[61] = s0[495];
        assign s20[61] = s0[495];
        assign s23[62] = s0[503];
        assign s20[62] = s0[503];
        assign s23[63] = s0[511];
        assign s20[63] = s0[511];
        assign s26[0 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[1 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[2 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[3 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[4 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[5 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[6 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[7 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s24[0] = 1'b0;
        assign s21[0] = 1'b0;
        assign s24[1] = 1'b0;
        assign s21[1] = 1'b0;
        assign s24[2] = 1'b0;
        assign s21[2] = 1'b0;
        assign s24[3] = 1'b0;
        assign s21[3] = 1'b0;
        assign s24[4] = s0[39];
        assign s21[4] = s0[39];
        assign s24[5] = s0[47];
        assign s21[5] = s0[47];
        assign s24[6] = s0[55];
        assign s21[6] = s0[55];
        assign s24[7] = s0[63];
        assign s21[7] = s0[63];
        assign s24[8] = 1'b0;
        assign s21[8] = 1'b0;
        assign s24[9] = 1'b0;
        assign s21[9] = 1'b0;
        assign s24[10] = 1'b0;
        assign s21[10] = 1'b0;
        assign s24[11] = 1'b0;
        assign s21[11] = 1'b0;
        assign s24[12] = s0[103];
        assign s21[12] = s0[103];
        assign s24[13] = s0[111];
        assign s21[13] = s0[111];
        assign s24[14] = s0[119];
        assign s21[14] = s0[119];
        assign s24[15] = s0[127];
        assign s21[15] = s0[127];
        assign s24[16] = 1'b0;
        assign s21[16] = 1'b0;
        assign s24[17] = 1'b0;
        assign s21[17] = 1'b0;
        assign s24[18] = 1'b0;
        assign s21[18] = 1'b0;
        assign s24[19] = 1'b0;
        assign s21[19] = 1'b0;
        assign s24[20] = s0[167];
        assign s21[20] = s0[167];
        assign s24[21] = s0[175];
        assign s21[21] = s0[175];
        assign s24[22] = s0[183];
        assign s21[22] = s0[183];
        assign s24[23] = s0[191];
        assign s21[23] = s0[191];
        assign s24[24] = 1'b0;
        assign s21[24] = 1'b0;
        assign s24[25] = 1'b0;
        assign s21[25] = 1'b0;
        assign s24[26] = 1'b0;
        assign s21[26] = 1'b0;
        assign s24[27] = 1'b0;
        assign s21[27] = 1'b0;
        assign s24[28] = s0[231];
        assign s21[28] = s0[231];
        assign s24[29] = s0[239];
        assign s21[29] = s0[239];
        assign s24[30] = s0[247];
        assign s21[30] = s0[247];
        assign s24[31] = s0[255];
        assign s21[31] = s0[255];
        assign s24[32] = 1'b0;
        assign s21[32] = 1'b0;
        assign s24[33] = 1'b0;
        assign s21[33] = 1'b0;
        assign s24[34] = 1'b0;
        assign s21[34] = 1'b0;
        assign s24[35] = 1'b0;
        assign s21[35] = 1'b0;
        assign s24[36] = s0[295];
        assign s21[36] = s0[295];
        assign s24[37] = s0[303];
        assign s21[37] = s0[303];
        assign s24[38] = s0[311];
        assign s21[38] = s0[311];
        assign s24[39] = s0[319];
        assign s21[39] = s0[319];
        assign s24[40] = 1'b0;
        assign s21[40] = 1'b0;
        assign s24[41] = 1'b0;
        assign s21[41] = 1'b0;
        assign s24[42] = 1'b0;
        assign s21[42] = 1'b0;
        assign s24[43] = 1'b0;
        assign s21[43] = 1'b0;
        assign s24[44] = s0[359];
        assign s21[44] = s0[359];
        assign s24[45] = s0[367];
        assign s21[45] = s0[367];
        assign s24[46] = s0[375];
        assign s21[46] = s0[375];
        assign s24[47] = s0[383];
        assign s21[47] = s0[383];
        assign s24[48] = 1'b0;
        assign s21[48] = 1'b0;
        assign s24[49] = 1'b0;
        assign s21[49] = 1'b0;
        assign s24[50] = 1'b0;
        assign s21[50] = 1'b0;
        assign s24[51] = 1'b0;
        assign s21[51] = 1'b0;
        assign s24[52] = s0[423];
        assign s21[52] = s0[423];
        assign s24[53] = s0[431];
        assign s21[53] = s0[431];
        assign s24[54] = s0[439];
        assign s21[54] = s0[439];
        assign s24[55] = s0[447];
        assign s21[55] = s0[447];
        assign s24[56] = 1'b0;
        assign s21[56] = 1'b0;
        assign s24[57] = 1'b0;
        assign s21[57] = 1'b0;
        assign s24[58] = 1'b0;
        assign s21[58] = 1'b0;
        assign s24[59] = 1'b0;
        assign s21[59] = 1'b0;
        assign s24[60] = s0[487];
        assign s21[60] = s0[487];
        assign s24[61] = s0[495];
        assign s21[61] = s0[495];
        assign s24[62] = s0[503];
        assign s21[62] = s0[503];
        assign s24[63] = s0[511];
        assign s21[63] = s0[511];
        assign s27[0 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[1 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[2 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[3 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[4 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[5 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[6 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[7 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        kv_mux64 #(
            .W(8)
        ) u_mux0 (
            .out(s0[0 * 8 +:8]),
            .sel(idx[0 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux1 (
            .out(s0[1 * 8 +:8]),
            .sel(idx[1 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux2 (
            .out(s0[2 * 8 +:8]),
            .sel(idx[2 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux3 (
            .out(s0[3 * 8 +:8]),
            .sel(idx[3 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux4 (
            .out(s0[4 * 8 +:8]),
            .sel(idx[4 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux5 (
            .out(s0[5 * 8 +:8]),
            .sel(idx[5 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux6 (
            .out(s0[6 * 8 +:8]),
            .sel(idx[6 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux7 (
            .out(s0[7 * 8 +:8]),
            .sel(idx[7 * SW +:SW]),
            .in(vs2_buf[0 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux8 (
            .out(s0[8 * 8 +:8]),
            .sel(idx[8 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux9 (
            .out(s0[9 * 8 +:8]),
            .sel(idx[9 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux10 (
            .out(s0[10 * 8 +:8]),
            .sel(idx[10 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux11 (
            .out(s0[11 * 8 +:8]),
            .sel(idx[11 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux12 (
            .out(s0[12 * 8 +:8]),
            .sel(idx[12 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux13 (
            .out(s0[13 * 8 +:8]),
            .sel(idx[13 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux14 (
            .out(s0[14 * 8 +:8]),
            .sel(idx[14 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux15 (
            .out(s0[15 * 8 +:8]),
            .sel(idx[15 * SW +:SW]),
            .in(vs2_buf[1 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux16 (
            .out(s0[16 * 8 +:8]),
            .sel(idx[16 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux17 (
            .out(s0[17 * 8 +:8]),
            .sel(idx[17 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux18 (
            .out(s0[18 * 8 +:8]),
            .sel(idx[18 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux19 (
            .out(s0[19 * 8 +:8]),
            .sel(idx[19 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux20 (
            .out(s0[20 * 8 +:8]),
            .sel(idx[20 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux21 (
            .out(s0[21 * 8 +:8]),
            .sel(idx[21 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux22 (
            .out(s0[22 * 8 +:8]),
            .sel(idx[22 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux23 (
            .out(s0[23 * 8 +:8]),
            .sel(idx[23 * SW +:SW]),
            .in(vs2_buf[2 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux24 (
            .out(s0[24 * 8 +:8]),
            .sel(idx[24 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux25 (
            .out(s0[25 * 8 +:8]),
            .sel(idx[25 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux26 (
            .out(s0[26 * 8 +:8]),
            .sel(idx[26 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux27 (
            .out(s0[27 * 8 +:8]),
            .sel(idx[27 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux28 (
            .out(s0[28 * 8 +:8]),
            .sel(idx[28 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux29 (
            .out(s0[29 * 8 +:8]),
            .sel(idx[29 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux30 (
            .out(s0[30 * 8 +:8]),
            .sel(idx[30 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux31 (
            .out(s0[31 * 8 +:8]),
            .sel(idx[31 * SW +:SW]),
            .in(vs2_buf[3 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux32 (
            .out(s0[32 * 8 +:8]),
            .sel(idx[32 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux33 (
            .out(s0[33 * 8 +:8]),
            .sel(idx[33 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux34 (
            .out(s0[34 * 8 +:8]),
            .sel(idx[34 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux35 (
            .out(s0[35 * 8 +:8]),
            .sel(idx[35 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux36 (
            .out(s0[36 * 8 +:8]),
            .sel(idx[36 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux37 (
            .out(s0[37 * 8 +:8]),
            .sel(idx[37 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux38 (
            .out(s0[38 * 8 +:8]),
            .sel(idx[38 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux39 (
            .out(s0[39 * 8 +:8]),
            .sel(idx[39 * SW +:SW]),
            .in(vs2_buf[4 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux40 (
            .out(s0[40 * 8 +:8]),
            .sel(idx[40 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux41 (
            .out(s0[41 * 8 +:8]),
            .sel(idx[41 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux42 (
            .out(s0[42 * 8 +:8]),
            .sel(idx[42 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux43 (
            .out(s0[43 * 8 +:8]),
            .sel(idx[43 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux44 (
            .out(s0[44 * 8 +:8]),
            .sel(idx[44 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux45 (
            .out(s0[45 * 8 +:8]),
            .sel(idx[45 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux46 (
            .out(s0[46 * 8 +:8]),
            .sel(idx[46 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux47 (
            .out(s0[47 * 8 +:8]),
            .sel(idx[47 * SW +:SW]),
            .in(vs2_buf[5 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux48 (
            .out(s0[48 * 8 +:8]),
            .sel(idx[48 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux49 (
            .out(s0[49 * 8 +:8]),
            .sel(idx[49 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux50 (
            .out(s0[50 * 8 +:8]),
            .sel(idx[50 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux51 (
            .out(s0[51 * 8 +:8]),
            .sel(idx[51 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux52 (
            .out(s0[52 * 8 +:8]),
            .sel(idx[52 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux53 (
            .out(s0[53 * 8 +:8]),
            .sel(idx[53 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux54 (
            .out(s0[54 * 8 +:8]),
            .sel(idx[54 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux55 (
            .out(s0[55 * 8 +:8]),
            .sel(idx[55 * SW +:SW]),
            .in(vs2_buf[6 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux56 (
            .out(s0[56 * 8 +:8]),
            .sel(idx[56 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux57 (
            .out(s0[57 * 8 +:8]),
            .sel(idx[57 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux58 (
            .out(s0[58 * 8 +:8]),
            .sel(idx[58 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux59 (
            .out(s0[59 * 8 +:8]),
            .sel(idx[59 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux60 (
            .out(s0[60 * 8 +:8]),
            .sel(idx[60 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux61 (
            .out(s0[61 * 8 +:8]),
            .sel(idx[61 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux62 (
            .out(s0[62 * 8 +:8]),
            .sel(idx[62 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        kv_mux64 #(
            .W(8)
        ) u_mux63 (
            .out(s0[63 * 8 +:8]),
            .sel(idx[63 * SW +:SW]),
            .in(vs2_buf[7 * 512 +:512])
        );
        assign s13[0 +:8] = {{4{s0[0 + 3] & s4}},s0[0 +:4] & {4{s1}}};
        assign s13[8 +:8] = {{4{s0[15] & s4}},s0[12 +:4] & {4{s1}}};
        assign s13[16 +:8] = {{4{s0[16 + 3] & s4}},s0[16 +:4] & {4{s1}}};
        assign s13[24 +:8] = {{4{s0[31] & s4}},s0[28 +:4] & {4{s1}}};
        assign s13[32 +:8] = {{4{s0[32 + 3] & s4}},s0[32 +:4] & {4{s1}}};
        assign s13[40 +:8] = {{4{s0[47] & s4}},s0[44 +:4] & {4{s1}}};
        assign s13[48 +:8] = {{4{s0[48 + 3] & s4}},s0[48 +:4] & {4{s1}}};
        assign s13[56 +:8] = {{4{s0[63] & s4}},s0[60 +:4] & {4{s1}}};
        assign s13[64 +:8] = {{4{s0[64 + 3] & s4}},s0[64 +:4] & {4{s1}}};
        assign s13[72 +:8] = {{4{s0[79] & s4}},s0[76 +:4] & {4{s1}}};
        assign s13[80 +:8] = {{4{s0[80 + 3] & s4}},s0[80 +:4] & {4{s1}}};
        assign s13[88 +:8] = {{4{s0[95] & s4}},s0[92 +:4] & {4{s1}}};
        assign s13[96 +:8] = {{4{s0[96 + 3] & s4}},s0[96 +:4] & {4{s1}}};
        assign s13[104 +:8] = {{4{s0[111] & s4}},s0[108 +:4] & {4{s1}}};
        assign s13[112 +:8] = {{4{s0[112 + 3] & s4}},s0[112 +:4] & {4{s1}}};
        assign s13[120 +:8] = {{4{s0[127] & s4}},s0[124 +:4] & {4{s1}}};
        assign s13[128 +:8] = {{4{s0[128 + 3] & s4}},s0[128 +:4] & {4{s1}}};
        assign s13[136 +:8] = {{4{s0[143] & s4}},s0[140 +:4] & {4{s1}}};
        assign s13[144 +:8] = {{4{s0[144 + 3] & s4}},s0[144 +:4] & {4{s1}}};
        assign s13[152 +:8] = {{4{s0[159] & s4}},s0[156 +:4] & {4{s1}}};
        assign s13[160 +:8] = {{4{s0[160 + 3] & s4}},s0[160 +:4] & {4{s1}}};
        assign s13[168 +:8] = {{4{s0[175] & s4}},s0[172 +:4] & {4{s1}}};
        assign s13[176 +:8] = {{4{s0[176 + 3] & s4}},s0[176 +:4] & {4{s1}}};
        assign s13[184 +:8] = {{4{s0[191] & s4}},s0[188 +:4] & {4{s1}}};
        assign s13[192 +:8] = {{4{s0[192 + 3] & s4}},s0[192 +:4] & {4{s1}}};
        assign s13[200 +:8] = {{4{s0[207] & s4}},s0[204 +:4] & {4{s1}}};
        assign s13[208 +:8] = {{4{s0[208 + 3] & s4}},s0[208 +:4] & {4{s1}}};
        assign s13[216 +:8] = {{4{s0[223] & s4}},s0[220 +:4] & {4{s1}}};
        assign s13[224 +:8] = {{4{s0[224 + 3] & s4}},s0[224 +:4] & {4{s1}}};
        assign s13[232 +:8] = {{4{s0[239] & s4}},s0[236 +:4] & {4{s1}}};
        assign s13[240 +:8] = {{4{s0[240 + 3] & s4}},s0[240 +:4] & {4{s1}}};
        assign s13[248 +:8] = {{4{s0[255] & s4}},s0[252 +:4] & {4{s1}}};
        assign s13[256 +:8] = {{4{s0[256 + 3] & s4}},s0[256 +:4] & {4{s1}}};
        assign s13[264 +:8] = {{4{s0[271] & s4}},s0[268 +:4] & {4{s1}}};
        assign s13[272 +:8] = {{4{s0[272 + 3] & s4}},s0[272 +:4] & {4{s1}}};
        assign s13[280 +:8] = {{4{s0[287] & s4}},s0[284 +:4] & {4{s1}}};
        assign s13[288 +:8] = {{4{s0[288 + 3] & s4}},s0[288 +:4] & {4{s1}}};
        assign s13[296 +:8] = {{4{s0[303] & s4}},s0[300 +:4] & {4{s1}}};
        assign s13[304 +:8] = {{4{s0[304 + 3] & s4}},s0[304 +:4] & {4{s1}}};
        assign s13[312 +:8] = {{4{s0[319] & s4}},s0[316 +:4] & {4{s1}}};
        assign s13[320 +:8] = {{4{s0[320 + 3] & s4}},s0[320 +:4] & {4{s1}}};
        assign s13[328 +:8] = {{4{s0[335] & s4}},s0[332 +:4] & {4{s1}}};
        assign s13[336 +:8] = {{4{s0[336 + 3] & s4}},s0[336 +:4] & {4{s1}}};
        assign s13[344 +:8] = {{4{s0[351] & s4}},s0[348 +:4] & {4{s1}}};
        assign s13[352 +:8] = {{4{s0[352 + 3] & s4}},s0[352 +:4] & {4{s1}}};
        assign s13[360 +:8] = {{4{s0[367] & s4}},s0[364 +:4] & {4{s1}}};
        assign s13[368 +:8] = {{4{s0[368 + 3] & s4}},s0[368 +:4] & {4{s1}}};
        assign s13[376 +:8] = {{4{s0[383] & s4}},s0[380 +:4] & {4{s1}}};
        assign s13[384 +:8] = {{4{s0[384 + 3] & s4}},s0[384 +:4] & {4{s1}}};
        assign s13[392 +:8] = {{4{s0[399] & s4}},s0[396 +:4] & {4{s1}}};
        assign s13[400 +:8] = {{4{s0[400 + 3] & s4}},s0[400 +:4] & {4{s1}}};
        assign s13[408 +:8] = {{4{s0[415] & s4}},s0[412 +:4] & {4{s1}}};
        assign s13[416 +:8] = {{4{s0[416 + 3] & s4}},s0[416 +:4] & {4{s1}}};
        assign s13[424 +:8] = {{4{s0[431] & s4}},s0[428 +:4] & {4{s1}}};
        assign s13[432 +:8] = {{4{s0[432 + 3] & s4}},s0[432 +:4] & {4{s1}}};
        assign s13[440 +:8] = {{4{s0[447] & s4}},s0[444 +:4] & {4{s1}}};
        assign s13[448 +:8] = {{4{s0[448 + 3] & s4}},s0[448 +:4] & {4{s1}}};
        assign s13[456 +:8] = {{4{s0[463] & s4}},s0[460 +:4] & {4{s1}}};
        assign s13[464 +:8] = {{4{s0[464 + 3] & s4}},s0[464 +:4] & {4{s1}}};
        assign s13[472 +:8] = {{4{s0[479] & s4}},s0[476 +:4] & {4{s1}}};
        assign s13[480 +:8] = {{4{s0[480 + 3] & s4}},s0[480 +:4] & {4{s1}}};
        assign s13[488 +:8] = {{4{s0[495] & s4}},s0[492 +:4] & {4{s1}}};
        assign s13[496 +:8] = {{4{s0[496 + 3] & s4}},s0[496 +:4] & {4{s1}}};
        assign s13[504 +:8] = {{4{s0[511] & s4}},s0[508 +:4] & {4{s1}}};
        assign s14[0 +:16] = {{8{s0[0 + 11] & s5}},{4{s0[0 + 3] & s5}},s0[0 +:4] & {4{s2}}};
        assign s14[16 +:16] = {{8{s0[23 + 8] & s5}},{4{s0[23] & s5}},s0[20 +:4] & {4{s2}}};
        assign s14[32 +:16] = {{8{s0[32 + 11] & s5}},{4{s0[32 + 3] & s5}},s0[32 +:4] & {4{s2}}};
        assign s14[48 +:16] = {{8{s0[55 + 8] & s5}},{4{s0[55] & s5}},s0[52 +:4] & {4{s2}}};
        assign s14[64 +:16] = {{8{s0[64 + 11] & s5}},{4{s0[64 + 3] & s5}},s0[64 +:4] & {4{s2}}};
        assign s14[80 +:16] = {{8{s0[87 + 8] & s5}},{4{s0[87] & s5}},s0[84 +:4] & {4{s2}}};
        assign s14[96 +:16] = {{8{s0[96 + 11] & s5}},{4{s0[96 + 3] & s5}},s0[96 +:4] & {4{s2}}};
        assign s14[112 +:16] = {{8{s0[119 + 8] & s5}},{4{s0[119] & s5}},s0[116 +:4] & {4{s2}}};
        assign s14[128 +:16] = {{8{s0[128 + 11] & s5}},{4{s0[128 + 3] & s5}},s0[128 +:4] & {4{s2}}};
        assign s14[144 +:16] = {{8{s0[151 + 8] & s5}},{4{s0[151] & s5}},s0[148 +:4] & {4{s2}}};
        assign s14[160 +:16] = {{8{s0[160 + 11] & s5}},{4{s0[160 + 3] & s5}},s0[160 +:4] & {4{s2}}};
        assign s14[176 +:16] = {{8{s0[183 + 8] & s5}},{4{s0[183] & s5}},s0[180 +:4] & {4{s2}}};
        assign s14[192 +:16] = {{8{s0[192 + 11] & s5}},{4{s0[192 + 3] & s5}},s0[192 +:4] & {4{s2}}};
        assign s14[208 +:16] = {{8{s0[215 + 8] & s5}},{4{s0[215] & s5}},s0[212 +:4] & {4{s2}}};
        assign s14[224 +:16] = {{8{s0[224 + 11] & s5}},{4{s0[224 + 3] & s5}},s0[224 +:4] & {4{s2}}};
        assign s14[240 +:16] = {{8{s0[247 + 8] & s5}},{4{s0[247] & s5}},s0[244 +:4] & {4{s2}}};
        assign s14[256 +:16] = {{8{s0[256 + 11] & s5}},{4{s0[256 + 3] & s5}},s0[256 +:4] & {4{s2}}};
        assign s14[272 +:16] = {{8{s0[279 + 8] & s5}},{4{s0[279] & s5}},s0[276 +:4] & {4{s2}}};
        assign s14[288 +:16] = {{8{s0[288 + 11] & s5}},{4{s0[288 + 3] & s5}},s0[288 +:4] & {4{s2}}};
        assign s14[304 +:16] = {{8{s0[311 + 8] & s5}},{4{s0[311] & s5}},s0[308 +:4] & {4{s2}}};
        assign s14[320 +:16] = {{8{s0[320 + 11] & s5}},{4{s0[320 + 3] & s5}},s0[320 +:4] & {4{s2}}};
        assign s14[336 +:16] = {{8{s0[343 + 8] & s5}},{4{s0[343] & s5}},s0[340 +:4] & {4{s2}}};
        assign s14[352 +:16] = {{8{s0[352 + 11] & s5}},{4{s0[352 + 3] & s5}},s0[352 +:4] & {4{s2}}};
        assign s14[368 +:16] = {{8{s0[375 + 8] & s5}},{4{s0[375] & s5}},s0[372 +:4] & {4{s2}}};
        assign s14[384 +:16] = {{8{s0[384 + 11] & s5}},{4{s0[384 + 3] & s5}},s0[384 +:4] & {4{s2}}};
        assign s14[400 +:16] = {{8{s0[407 + 8] & s5}},{4{s0[407] & s5}},s0[404 +:4] & {4{s2}}};
        assign s14[416 +:16] = {{8{s0[416 + 11] & s5}},{4{s0[416 + 3] & s5}},s0[416 +:4] & {4{s2}}};
        assign s14[432 +:16] = {{8{s0[439 + 8] & s5}},{4{s0[439] & s5}},s0[436 +:4] & {4{s2}}};
        assign s14[448 +:16] = {{8{s0[448 + 11] & s5}},{4{s0[448 + 3] & s5}},s0[448 +:4] & {4{s2}}};
        assign s14[464 +:16] = {{8{s0[471 + 8] & s5}},{4{s0[471] & s5}},s0[468 +:4] & {4{s2}}};
        assign s14[480 +:16] = {{8{s0[480 + 11] & s5}},{4{s0[480 + 3] & s5}},s0[480 +:4] & {4{s2}}};
        assign s14[496 +:16] = {{8{s0[503 + 8] & s5}},{4{s0[503] & s5}},s0[500 +:4] & {4{s2}}};
        assign s15[0 +:32] = {{8{s0[0 + 27] & s6}},{8{s0[0 + 19] & s6}},{8{s0[0 + 11] & s6}},{4{s0[0 + 3] & s6}},s0[0 +:4] & {4{s3}}};
        assign s15[32 +:32] = {{8{s0[39 + 24] & s6}},{8{s0[39 + 16] & s6}},{8{s0[39 + 8] & s6}},{4{s0[39] & s6}},s0[36 +:4] & {4{s3}}};
        assign s15[64 +:32] = {{8{s0[64 + 27] & s6}},{8{s0[64 + 19] & s6}},{8{s0[64 + 11] & s6}},{4{s0[64 + 3] & s6}},s0[64 +:4] & {4{s3}}};
        assign s15[96 +:32] = {{8{s0[103 + 24] & s6}},{8{s0[103 + 16] & s6}},{8{s0[103 + 8] & s6}},{4{s0[103] & s6}},s0[100 +:4] & {4{s3}}};
        assign s15[128 +:32] = {{8{s0[128 + 27] & s6}},{8{s0[128 + 19] & s6}},{8{s0[128 + 11] & s6}},{4{s0[128 + 3] & s6}},s0[128 +:4] & {4{s3}}};
        assign s15[160 +:32] = {{8{s0[167 + 24] & s6}},{8{s0[167 + 16] & s6}},{8{s0[167 + 8] & s6}},{4{s0[167] & s6}},s0[164 +:4] & {4{s3}}};
        assign s15[192 +:32] = {{8{s0[192 + 27] & s6}},{8{s0[192 + 19] & s6}},{8{s0[192 + 11] & s6}},{4{s0[192 + 3] & s6}},s0[192 +:4] & {4{s3}}};
        assign s15[224 +:32] = {{8{s0[231 + 24] & s6}},{8{s0[231 + 16] & s6}},{8{s0[231 + 8] & s6}},{4{s0[231] & s6}},s0[228 +:4] & {4{s3}}};
        assign s15[256 +:32] = {{8{s0[256 + 27] & s6}},{8{s0[256 + 19] & s6}},{8{s0[256 + 11] & s6}},{4{s0[256 + 3] & s6}},s0[256 +:4] & {4{s3}}};
        assign s15[288 +:32] = {{8{s0[295 + 24] & s6}},{8{s0[295 + 16] & s6}},{8{s0[295 + 8] & s6}},{4{s0[295] & s6}},s0[292 +:4] & {4{s3}}};
        assign s15[320 +:32] = {{8{s0[320 + 27] & s6}},{8{s0[320 + 19] & s6}},{8{s0[320 + 11] & s6}},{4{s0[320 + 3] & s6}},s0[320 +:4] & {4{s3}}};
        assign s15[352 +:32] = {{8{s0[359 + 24] & s6}},{8{s0[359 + 16] & s6}},{8{s0[359 + 8] & s6}},{4{s0[359] & s6}},s0[356 +:4] & {4{s3}}};
        assign s15[384 +:32] = {{8{s0[384 + 27] & s6}},{8{s0[384 + 19] & s6}},{8{s0[384 + 11] & s6}},{4{s0[384 + 3] & s6}},s0[384 +:4] & {4{s3}}};
        assign s15[416 +:32] = {{8{s0[423 + 24] & s6}},{8{s0[423 + 16] & s6}},{8{s0[423 + 8] & s6}},{4{s0[423] & s6}},s0[420 +:4] & {4{s3}}};
        assign s15[448 +:32] = {{8{s0[448 + 27] & s6}},{8{s0[448 + 19] & s6}},{8{s0[448 + 11] & s6}},{4{s0[448 + 3] & s6}},s0[448 +:4] & {4{s3}}};
        assign s15[480 +:32] = {{8{s0[487 + 24] & s6}},{8{s0[487 + 16] & s6}},{8{s0[487 + 8] & s6}},{4{s0[487] & s6}},s0[484 +:4] & {4{s3}}};
        wire [2 * VP_LEN - 1:0] s35;
        assign s35 = {2{s13 | s14 | s15}};
        wire [2 * VP_LEN - 1:0] s36 = {2 * VP_LEN{vmv_nr}} & {vs2_buf[VP_LEN +:VP_LEN],{VP_LEN{1'b0}}};
        assign result0[0 * 8 +:8] = s36[0 * 8 +:8] | s35[0 * 8 +:8] | ({8{s30[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s32[0]}}) | {8{s28[0]}});
        assign result0[1 * 8 +:8] = s36[1 * 8 +:8] | s35[1 * 8 +:8] | ({8{s30[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s32[1]}}) | {8{s28[1]}});
        assign result0[2 * 8 +:8] = s36[2 * 8 +:8] | s35[2 * 8 +:8] | ({8{s30[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s32[2]}}) | {8{s28[2]}});
        assign result0[3 * 8 +:8] = s36[3 * 8 +:8] | s35[3 * 8 +:8] | ({8{s30[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s32[3]}}) | {8{s28[3]}});
        assign result0[4 * 8 +:8] = s36[4 * 8 +:8] | s35[4 * 8 +:8] | ({8{s30[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s32[4]}}) | {8{s28[4]}});
        assign result0[5 * 8 +:8] = s36[5 * 8 +:8] | s35[5 * 8 +:8] | ({8{s30[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s32[5]}}) | {8{s28[5]}});
        assign result0[6 * 8 +:8] = s36[6 * 8 +:8] | s35[6 * 8 +:8] | ({8{s30[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s32[6]}}) | {8{s28[6]}});
        assign result0[7 * 8 +:8] = s36[7 * 8 +:8] | s35[7 * 8 +:8] | ({8{s30[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s32[7]}}) | {8{s28[7]}});
        assign result0[8 * 8 +:8] = s36[8 * 8 +:8] | s35[8 * 8 +:8] | ({8{s30[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s32[8]}}) | {8{s28[8]}});
        assign result0[9 * 8 +:8] = s36[9 * 8 +:8] | s35[9 * 8 +:8] | ({8{s30[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s32[9]}}) | {8{s28[9]}});
        assign result0[10 * 8 +:8] = s36[10 * 8 +:8] | s35[10 * 8 +:8] | ({8{s30[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s32[10]}}) | {8{s28[10]}});
        assign result0[11 * 8 +:8] = s36[11 * 8 +:8] | s35[11 * 8 +:8] | ({8{s30[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s32[11]}}) | {8{s28[11]}});
        assign result0[12 * 8 +:8] = s36[12 * 8 +:8] | s35[12 * 8 +:8] | ({8{s30[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s32[12]}}) | {8{s28[12]}});
        assign result0[13 * 8 +:8] = s36[13 * 8 +:8] | s35[13 * 8 +:8] | ({8{s30[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s32[13]}}) | {8{s28[13]}});
        assign result0[14 * 8 +:8] = s36[14 * 8 +:8] | s35[14 * 8 +:8] | ({8{s30[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s32[14]}}) | {8{s28[14]}});
        assign result0[15 * 8 +:8] = s36[15 * 8 +:8] | s35[15 * 8 +:8] | ({8{s30[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s32[15]}}) | {8{s28[15]}});
        assign result0[16 * 8 +:8] = s36[16 * 8 +:8] | s35[16 * 8 +:8] | ({8{s30[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s32[16]}}) | {8{s28[16]}});
        assign result0[17 * 8 +:8] = s36[17 * 8 +:8] | s35[17 * 8 +:8] | ({8{s30[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s32[17]}}) | {8{s28[17]}});
        assign result0[18 * 8 +:8] = s36[18 * 8 +:8] | s35[18 * 8 +:8] | ({8{s30[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s32[18]}}) | {8{s28[18]}});
        assign result0[19 * 8 +:8] = s36[19 * 8 +:8] | s35[19 * 8 +:8] | ({8{s30[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s32[19]}}) | {8{s28[19]}});
        assign result0[20 * 8 +:8] = s36[20 * 8 +:8] | s35[20 * 8 +:8] | ({8{s30[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s32[20]}}) | {8{s28[20]}});
        assign result0[21 * 8 +:8] = s36[21 * 8 +:8] | s35[21 * 8 +:8] | ({8{s30[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s32[21]}}) | {8{s28[21]}});
        assign result0[22 * 8 +:8] = s36[22 * 8 +:8] | s35[22 * 8 +:8] | ({8{s30[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s32[22]}}) | {8{s28[22]}});
        assign result0[23 * 8 +:8] = s36[23 * 8 +:8] | s35[23 * 8 +:8] | ({8{s30[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s32[23]}}) | {8{s28[23]}});
        assign result0[24 * 8 +:8] = s36[24 * 8 +:8] | s35[24 * 8 +:8] | ({8{s30[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s32[24]}}) | {8{s28[24]}});
        assign result0[25 * 8 +:8] = s36[25 * 8 +:8] | s35[25 * 8 +:8] | ({8{s30[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s32[25]}}) | {8{s28[25]}});
        assign result0[26 * 8 +:8] = s36[26 * 8 +:8] | s35[26 * 8 +:8] | ({8{s30[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s32[26]}}) | {8{s28[26]}});
        assign result0[27 * 8 +:8] = s36[27 * 8 +:8] | s35[27 * 8 +:8] | ({8{s30[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s32[27]}}) | {8{s28[27]}});
        assign result0[28 * 8 +:8] = s36[28 * 8 +:8] | s35[28 * 8 +:8] | ({8{s30[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s32[28]}}) | {8{s28[28]}});
        assign result0[29 * 8 +:8] = s36[29 * 8 +:8] | s35[29 * 8 +:8] | ({8{s30[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s32[29]}}) | {8{s28[29]}});
        assign result0[30 * 8 +:8] = s36[30 * 8 +:8] | s35[30 * 8 +:8] | ({8{s30[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s32[30]}}) | {8{s28[30]}});
        assign result0[31 * 8 +:8] = s36[31 * 8 +:8] | s35[31 * 8 +:8] | ({8{s30[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s32[31]}}) | {8{s28[31]}});
        assign result0[32 * 8 +:8] = s36[32 * 8 +:8] | s35[32 * 8 +:8] | ({8{s30[32]}} & s34[32 * 8 +:8]) | ((s0[32 * 8 +:8] & {8{s32[32]}}) | {8{s28[32]}});
        assign result0[33 * 8 +:8] = s36[33 * 8 +:8] | s35[33 * 8 +:8] | ({8{s30[33]}} & s34[33 * 8 +:8]) | ((s0[33 * 8 +:8] & {8{s32[33]}}) | {8{s28[33]}});
        assign result0[34 * 8 +:8] = s36[34 * 8 +:8] | s35[34 * 8 +:8] | ({8{s30[34]}} & s34[34 * 8 +:8]) | ((s0[34 * 8 +:8] & {8{s32[34]}}) | {8{s28[34]}});
        assign result0[35 * 8 +:8] = s36[35 * 8 +:8] | s35[35 * 8 +:8] | ({8{s30[35]}} & s34[35 * 8 +:8]) | ((s0[35 * 8 +:8] & {8{s32[35]}}) | {8{s28[35]}});
        assign result0[36 * 8 +:8] = s36[36 * 8 +:8] | s35[36 * 8 +:8] | ({8{s30[36]}} & s34[36 * 8 +:8]) | ((s0[36 * 8 +:8] & {8{s32[36]}}) | {8{s28[36]}});
        assign result0[37 * 8 +:8] = s36[37 * 8 +:8] | s35[37 * 8 +:8] | ({8{s30[37]}} & s34[37 * 8 +:8]) | ((s0[37 * 8 +:8] & {8{s32[37]}}) | {8{s28[37]}});
        assign result0[38 * 8 +:8] = s36[38 * 8 +:8] | s35[38 * 8 +:8] | ({8{s30[38]}} & s34[38 * 8 +:8]) | ((s0[38 * 8 +:8] & {8{s32[38]}}) | {8{s28[38]}});
        assign result0[39 * 8 +:8] = s36[39 * 8 +:8] | s35[39 * 8 +:8] | ({8{s30[39]}} & s34[39 * 8 +:8]) | ((s0[39 * 8 +:8] & {8{s32[39]}}) | {8{s28[39]}});
        assign result0[40 * 8 +:8] = s36[40 * 8 +:8] | s35[40 * 8 +:8] | ({8{s30[40]}} & s34[40 * 8 +:8]) | ((s0[40 * 8 +:8] & {8{s32[40]}}) | {8{s28[40]}});
        assign result0[41 * 8 +:8] = s36[41 * 8 +:8] | s35[41 * 8 +:8] | ({8{s30[41]}} & s34[41 * 8 +:8]) | ((s0[41 * 8 +:8] & {8{s32[41]}}) | {8{s28[41]}});
        assign result0[42 * 8 +:8] = s36[42 * 8 +:8] | s35[42 * 8 +:8] | ({8{s30[42]}} & s34[42 * 8 +:8]) | ((s0[42 * 8 +:8] & {8{s32[42]}}) | {8{s28[42]}});
        assign result0[43 * 8 +:8] = s36[43 * 8 +:8] | s35[43 * 8 +:8] | ({8{s30[43]}} & s34[43 * 8 +:8]) | ((s0[43 * 8 +:8] & {8{s32[43]}}) | {8{s28[43]}});
        assign result0[44 * 8 +:8] = s36[44 * 8 +:8] | s35[44 * 8 +:8] | ({8{s30[44]}} & s34[44 * 8 +:8]) | ((s0[44 * 8 +:8] & {8{s32[44]}}) | {8{s28[44]}});
        assign result0[45 * 8 +:8] = s36[45 * 8 +:8] | s35[45 * 8 +:8] | ({8{s30[45]}} & s34[45 * 8 +:8]) | ((s0[45 * 8 +:8] & {8{s32[45]}}) | {8{s28[45]}});
        assign result0[46 * 8 +:8] = s36[46 * 8 +:8] | s35[46 * 8 +:8] | ({8{s30[46]}} & s34[46 * 8 +:8]) | ((s0[46 * 8 +:8] & {8{s32[46]}}) | {8{s28[46]}});
        assign result0[47 * 8 +:8] = s36[47 * 8 +:8] | s35[47 * 8 +:8] | ({8{s30[47]}} & s34[47 * 8 +:8]) | ((s0[47 * 8 +:8] & {8{s32[47]}}) | {8{s28[47]}});
        assign result0[48 * 8 +:8] = s36[48 * 8 +:8] | s35[48 * 8 +:8] | ({8{s30[48]}} & s34[48 * 8 +:8]) | ((s0[48 * 8 +:8] & {8{s32[48]}}) | {8{s28[48]}});
        assign result0[49 * 8 +:8] = s36[49 * 8 +:8] | s35[49 * 8 +:8] | ({8{s30[49]}} & s34[49 * 8 +:8]) | ((s0[49 * 8 +:8] & {8{s32[49]}}) | {8{s28[49]}});
        assign result0[50 * 8 +:8] = s36[50 * 8 +:8] | s35[50 * 8 +:8] | ({8{s30[50]}} & s34[50 * 8 +:8]) | ((s0[50 * 8 +:8] & {8{s32[50]}}) | {8{s28[50]}});
        assign result0[51 * 8 +:8] = s36[51 * 8 +:8] | s35[51 * 8 +:8] | ({8{s30[51]}} & s34[51 * 8 +:8]) | ((s0[51 * 8 +:8] & {8{s32[51]}}) | {8{s28[51]}});
        assign result0[52 * 8 +:8] = s36[52 * 8 +:8] | s35[52 * 8 +:8] | ({8{s30[52]}} & s34[52 * 8 +:8]) | ((s0[52 * 8 +:8] & {8{s32[52]}}) | {8{s28[52]}});
        assign result0[53 * 8 +:8] = s36[53 * 8 +:8] | s35[53 * 8 +:8] | ({8{s30[53]}} & s34[53 * 8 +:8]) | ((s0[53 * 8 +:8] & {8{s32[53]}}) | {8{s28[53]}});
        assign result0[54 * 8 +:8] = s36[54 * 8 +:8] | s35[54 * 8 +:8] | ({8{s30[54]}} & s34[54 * 8 +:8]) | ((s0[54 * 8 +:8] & {8{s32[54]}}) | {8{s28[54]}});
        assign result0[55 * 8 +:8] = s36[55 * 8 +:8] | s35[55 * 8 +:8] | ({8{s30[55]}} & s34[55 * 8 +:8]) | ((s0[55 * 8 +:8] & {8{s32[55]}}) | {8{s28[55]}});
        assign result0[56 * 8 +:8] = s36[56 * 8 +:8] | s35[56 * 8 +:8] | ({8{s30[56]}} & s34[56 * 8 +:8]) | ((s0[56 * 8 +:8] & {8{s32[56]}}) | {8{s28[56]}});
        assign result0[57 * 8 +:8] = s36[57 * 8 +:8] | s35[57 * 8 +:8] | ({8{s30[57]}} & s34[57 * 8 +:8]) | ((s0[57 * 8 +:8] & {8{s32[57]}}) | {8{s28[57]}});
        assign result0[58 * 8 +:8] = s36[58 * 8 +:8] | s35[58 * 8 +:8] | ({8{s30[58]}} & s34[58 * 8 +:8]) | ((s0[58 * 8 +:8] & {8{s32[58]}}) | {8{s28[58]}});
        assign result0[59 * 8 +:8] = s36[59 * 8 +:8] | s35[59 * 8 +:8] | ({8{s30[59]}} & s34[59 * 8 +:8]) | ((s0[59 * 8 +:8] & {8{s32[59]}}) | {8{s28[59]}});
        assign result0[60 * 8 +:8] = s36[60 * 8 +:8] | s35[60 * 8 +:8] | ({8{s30[60]}} & s34[60 * 8 +:8]) | ((s0[60 * 8 +:8] & {8{s32[60]}}) | {8{s28[60]}});
        assign result0[61 * 8 +:8] = s36[61 * 8 +:8] | s35[61 * 8 +:8] | ({8{s30[61]}} & s34[61 * 8 +:8]) | ((s0[61 * 8 +:8] & {8{s32[61]}}) | {8{s28[61]}});
        assign result0[62 * 8 +:8] = s36[62 * 8 +:8] | s35[62 * 8 +:8] | ({8{s30[62]}} & s34[62 * 8 +:8]) | ((s0[62 * 8 +:8] & {8{s32[62]}}) | {8{s28[62]}});
        assign result0[63 * 8 +:8] = s36[63 * 8 +:8] | s35[63 * 8 +:8] | ({8{s30[63]}} & s34[63 * 8 +:8]) | ((s0[63 * 8 +:8] & {8{s32[63]}}) | {8{s28[63]}});
        assign result1[0 * 8 +:8] = s36[64 * 8 +:8] | s35[64 * 8 +:8] | ({8{s31[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s33[0]}}) | {8{s28[0]}});
        assign result1[1 * 8 +:8] = s36[65 * 8 +:8] | s35[65 * 8 +:8] | ({8{s31[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s33[1]}}) | {8{s28[1]}});
        assign result1[2 * 8 +:8] = s36[66 * 8 +:8] | s35[66 * 8 +:8] | ({8{s31[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s33[2]}}) | {8{s28[2]}});
        assign result1[3 * 8 +:8] = s36[67 * 8 +:8] | s35[67 * 8 +:8] | ({8{s31[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s33[3]}}) | {8{s28[3]}});
        assign result1[4 * 8 +:8] = s36[68 * 8 +:8] | s35[68 * 8 +:8] | ({8{s31[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s33[4]}}) | {8{s28[4]}});
        assign result1[5 * 8 +:8] = s36[69 * 8 +:8] | s35[69 * 8 +:8] | ({8{s31[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s33[5]}}) | {8{s28[5]}});
        assign result1[6 * 8 +:8] = s36[70 * 8 +:8] | s35[70 * 8 +:8] | ({8{s31[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s33[6]}}) | {8{s28[6]}});
        assign result1[7 * 8 +:8] = s36[71 * 8 +:8] | s35[71 * 8 +:8] | ({8{s31[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s33[7]}}) | {8{s28[7]}});
        assign result1[8 * 8 +:8] = s36[72 * 8 +:8] | s35[72 * 8 +:8] | ({8{s31[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s33[8]}}) | {8{s28[8]}});
        assign result1[9 * 8 +:8] = s36[73 * 8 +:8] | s35[73 * 8 +:8] | ({8{s31[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s33[9]}}) | {8{s28[9]}});
        assign result1[10 * 8 +:8] = s36[74 * 8 +:8] | s35[74 * 8 +:8] | ({8{s31[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s33[10]}}) | {8{s28[10]}});
        assign result1[11 * 8 +:8] = s36[75 * 8 +:8] | s35[75 * 8 +:8] | ({8{s31[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s33[11]}}) | {8{s28[11]}});
        assign result1[12 * 8 +:8] = s36[76 * 8 +:8] | s35[76 * 8 +:8] | ({8{s31[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s33[12]}}) | {8{s28[12]}});
        assign result1[13 * 8 +:8] = s36[77 * 8 +:8] | s35[77 * 8 +:8] | ({8{s31[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s33[13]}}) | {8{s28[13]}});
        assign result1[14 * 8 +:8] = s36[78 * 8 +:8] | s35[78 * 8 +:8] | ({8{s31[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s33[14]}}) | {8{s28[14]}});
        assign result1[15 * 8 +:8] = s36[79 * 8 +:8] | s35[79 * 8 +:8] | ({8{s31[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s33[15]}}) | {8{s28[15]}});
        assign result1[16 * 8 +:8] = s36[80 * 8 +:8] | s35[80 * 8 +:8] | ({8{s31[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s33[16]}}) | {8{s28[16]}});
        assign result1[17 * 8 +:8] = s36[81 * 8 +:8] | s35[81 * 8 +:8] | ({8{s31[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s33[17]}}) | {8{s28[17]}});
        assign result1[18 * 8 +:8] = s36[82 * 8 +:8] | s35[82 * 8 +:8] | ({8{s31[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s33[18]}}) | {8{s28[18]}});
        assign result1[19 * 8 +:8] = s36[83 * 8 +:8] | s35[83 * 8 +:8] | ({8{s31[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s33[19]}}) | {8{s28[19]}});
        assign result1[20 * 8 +:8] = s36[84 * 8 +:8] | s35[84 * 8 +:8] | ({8{s31[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s33[20]}}) | {8{s28[20]}});
        assign result1[21 * 8 +:8] = s36[85 * 8 +:8] | s35[85 * 8 +:8] | ({8{s31[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s33[21]}}) | {8{s28[21]}});
        assign result1[22 * 8 +:8] = s36[86 * 8 +:8] | s35[86 * 8 +:8] | ({8{s31[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s33[22]}}) | {8{s28[22]}});
        assign result1[23 * 8 +:8] = s36[87 * 8 +:8] | s35[87 * 8 +:8] | ({8{s31[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s33[23]}}) | {8{s28[23]}});
        assign result1[24 * 8 +:8] = s36[88 * 8 +:8] | s35[88 * 8 +:8] | ({8{s31[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s33[24]}}) | {8{s28[24]}});
        assign result1[25 * 8 +:8] = s36[89 * 8 +:8] | s35[89 * 8 +:8] | ({8{s31[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s33[25]}}) | {8{s28[25]}});
        assign result1[26 * 8 +:8] = s36[90 * 8 +:8] | s35[90 * 8 +:8] | ({8{s31[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s33[26]}}) | {8{s28[26]}});
        assign result1[27 * 8 +:8] = s36[91 * 8 +:8] | s35[91 * 8 +:8] | ({8{s31[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s33[27]}}) | {8{s28[27]}});
        assign result1[28 * 8 +:8] = s36[92 * 8 +:8] | s35[92 * 8 +:8] | ({8{s31[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s33[28]}}) | {8{s28[28]}});
        assign result1[29 * 8 +:8] = s36[93 * 8 +:8] | s35[93 * 8 +:8] | ({8{s31[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s33[29]}}) | {8{s28[29]}});
        assign result1[30 * 8 +:8] = s36[94 * 8 +:8] | s35[94 * 8 +:8] | ({8{s31[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s33[30]}}) | {8{s28[30]}});
        assign result1[31 * 8 +:8] = s36[95 * 8 +:8] | s35[95 * 8 +:8] | ({8{s31[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s33[31]}}) | {8{s28[31]}});
        assign result1[32 * 8 +:8] = s36[96 * 8 +:8] | s35[96 * 8 +:8] | ({8{s31[32]}} & s34[32 * 8 +:8]) | ((s0[32 * 8 +:8] & {8{s33[32]}}) | {8{s28[32]}});
        assign result1[33 * 8 +:8] = s36[97 * 8 +:8] | s35[97 * 8 +:8] | ({8{s31[33]}} & s34[33 * 8 +:8]) | ((s0[33 * 8 +:8] & {8{s33[33]}}) | {8{s28[33]}});
        assign result1[34 * 8 +:8] = s36[98 * 8 +:8] | s35[98 * 8 +:8] | ({8{s31[34]}} & s34[34 * 8 +:8]) | ((s0[34 * 8 +:8] & {8{s33[34]}}) | {8{s28[34]}});
        assign result1[35 * 8 +:8] = s36[99 * 8 +:8] | s35[99 * 8 +:8] | ({8{s31[35]}} & s34[35 * 8 +:8]) | ((s0[35 * 8 +:8] & {8{s33[35]}}) | {8{s28[35]}});
        assign result1[36 * 8 +:8] = s36[100 * 8 +:8] | s35[100 * 8 +:8] | ({8{s31[36]}} & s34[36 * 8 +:8]) | ((s0[36 * 8 +:8] & {8{s33[36]}}) | {8{s28[36]}});
        assign result1[37 * 8 +:8] = s36[101 * 8 +:8] | s35[101 * 8 +:8] | ({8{s31[37]}} & s34[37 * 8 +:8]) | ((s0[37 * 8 +:8] & {8{s33[37]}}) | {8{s28[37]}});
        assign result1[38 * 8 +:8] = s36[102 * 8 +:8] | s35[102 * 8 +:8] | ({8{s31[38]}} & s34[38 * 8 +:8]) | ((s0[38 * 8 +:8] & {8{s33[38]}}) | {8{s28[38]}});
        assign result1[39 * 8 +:8] = s36[103 * 8 +:8] | s35[103 * 8 +:8] | ({8{s31[39]}} & s34[39 * 8 +:8]) | ((s0[39 * 8 +:8] & {8{s33[39]}}) | {8{s28[39]}});
        assign result1[40 * 8 +:8] = s36[104 * 8 +:8] | s35[104 * 8 +:8] | ({8{s31[40]}} & s34[40 * 8 +:8]) | ((s0[40 * 8 +:8] & {8{s33[40]}}) | {8{s28[40]}});
        assign result1[41 * 8 +:8] = s36[105 * 8 +:8] | s35[105 * 8 +:8] | ({8{s31[41]}} & s34[41 * 8 +:8]) | ((s0[41 * 8 +:8] & {8{s33[41]}}) | {8{s28[41]}});
        assign result1[42 * 8 +:8] = s36[106 * 8 +:8] | s35[106 * 8 +:8] | ({8{s31[42]}} & s34[42 * 8 +:8]) | ((s0[42 * 8 +:8] & {8{s33[42]}}) | {8{s28[42]}});
        assign result1[43 * 8 +:8] = s36[107 * 8 +:8] | s35[107 * 8 +:8] | ({8{s31[43]}} & s34[43 * 8 +:8]) | ((s0[43 * 8 +:8] & {8{s33[43]}}) | {8{s28[43]}});
        assign result1[44 * 8 +:8] = s36[108 * 8 +:8] | s35[108 * 8 +:8] | ({8{s31[44]}} & s34[44 * 8 +:8]) | ((s0[44 * 8 +:8] & {8{s33[44]}}) | {8{s28[44]}});
        assign result1[45 * 8 +:8] = s36[109 * 8 +:8] | s35[109 * 8 +:8] | ({8{s31[45]}} & s34[45 * 8 +:8]) | ((s0[45 * 8 +:8] & {8{s33[45]}}) | {8{s28[45]}});
        assign result1[46 * 8 +:8] = s36[110 * 8 +:8] | s35[110 * 8 +:8] | ({8{s31[46]}} & s34[46 * 8 +:8]) | ((s0[46 * 8 +:8] & {8{s33[46]}}) | {8{s28[46]}});
        assign result1[47 * 8 +:8] = s36[111 * 8 +:8] | s35[111 * 8 +:8] | ({8{s31[47]}} & s34[47 * 8 +:8]) | ((s0[47 * 8 +:8] & {8{s33[47]}}) | {8{s28[47]}});
        assign result1[48 * 8 +:8] = s36[112 * 8 +:8] | s35[112 * 8 +:8] | ({8{s31[48]}} & s34[48 * 8 +:8]) | ((s0[48 * 8 +:8] & {8{s33[48]}}) | {8{s28[48]}});
        assign result1[49 * 8 +:8] = s36[113 * 8 +:8] | s35[113 * 8 +:8] | ({8{s31[49]}} & s34[49 * 8 +:8]) | ((s0[49 * 8 +:8] & {8{s33[49]}}) | {8{s28[49]}});
        assign result1[50 * 8 +:8] = s36[114 * 8 +:8] | s35[114 * 8 +:8] | ({8{s31[50]}} & s34[50 * 8 +:8]) | ((s0[50 * 8 +:8] & {8{s33[50]}}) | {8{s28[50]}});
        assign result1[51 * 8 +:8] = s36[115 * 8 +:8] | s35[115 * 8 +:8] | ({8{s31[51]}} & s34[51 * 8 +:8]) | ((s0[51 * 8 +:8] & {8{s33[51]}}) | {8{s28[51]}});
        assign result1[52 * 8 +:8] = s36[116 * 8 +:8] | s35[116 * 8 +:8] | ({8{s31[52]}} & s34[52 * 8 +:8]) | ((s0[52 * 8 +:8] & {8{s33[52]}}) | {8{s28[52]}});
        assign result1[53 * 8 +:8] = s36[117 * 8 +:8] | s35[117 * 8 +:8] | ({8{s31[53]}} & s34[53 * 8 +:8]) | ((s0[53 * 8 +:8] & {8{s33[53]}}) | {8{s28[53]}});
        assign result1[54 * 8 +:8] = s36[118 * 8 +:8] | s35[118 * 8 +:8] | ({8{s31[54]}} & s34[54 * 8 +:8]) | ((s0[54 * 8 +:8] & {8{s33[54]}}) | {8{s28[54]}});
        assign result1[55 * 8 +:8] = s36[119 * 8 +:8] | s35[119 * 8 +:8] | ({8{s31[55]}} & s34[55 * 8 +:8]) | ((s0[55 * 8 +:8] & {8{s33[55]}}) | {8{s28[55]}});
        assign result1[56 * 8 +:8] = s36[120 * 8 +:8] | s35[120 * 8 +:8] | ({8{s31[56]}} & s34[56 * 8 +:8]) | ((s0[56 * 8 +:8] & {8{s33[56]}}) | {8{s28[56]}});
        assign result1[57 * 8 +:8] = s36[121 * 8 +:8] | s35[121 * 8 +:8] | ({8{s31[57]}} & s34[57 * 8 +:8]) | ((s0[57 * 8 +:8] & {8{s33[57]}}) | {8{s28[57]}});
        assign result1[58 * 8 +:8] = s36[122 * 8 +:8] | s35[122 * 8 +:8] | ({8{s31[58]}} & s34[58 * 8 +:8]) | ((s0[58 * 8 +:8] & {8{s33[58]}}) | {8{s28[58]}});
        assign result1[59 * 8 +:8] = s36[123 * 8 +:8] | s35[123 * 8 +:8] | ({8{s31[59]}} & s34[59 * 8 +:8]) | ((s0[59 * 8 +:8] & {8{s33[59]}}) | {8{s28[59]}});
        assign result1[60 * 8 +:8] = s36[124 * 8 +:8] | s35[124 * 8 +:8] | ({8{s31[60]}} & s34[60 * 8 +:8]) | ((s0[60 * 8 +:8] & {8{s33[60]}}) | {8{s28[60]}});
        assign result1[61 * 8 +:8] = s36[125 * 8 +:8] | s35[125 * 8 +:8] | ({8{s31[61]}} & s34[61 * 8 +:8]) | ((s0[61 * 8 +:8] & {8{s33[61]}}) | {8{s28[61]}});
        assign result1[62 * 8 +:8] = s36[126 * 8 +:8] | s35[126 * 8 +:8] | ({8{s31[62]}} & s34[62 * 8 +:8]) | ((s0[62 * 8 +:8] & {8{s33[62]}}) | {8{s28[62]}});
        assign result1[63 * 8 +:8] = s36[127 * 8 +:8] | s35[127 * 8 +:8] | ({8{s31[63]}} & s34[63 * 8 +:8]) | ((s0[63 * 8 +:8] & {8{s33[63]}}) | {8{s28[63]}});
    end
endgenerate
generate
    if ((VLEN == 1024) && (DLEN == 512) & (VP_LEN == 512)) begin:gen_vlen1024_dlen512_vplen512
        assign s16[0] = 1'b0;
        assign s16[1] = s0[15];
        assign s16[2] = 1'b0;
        assign s16[3] = s0[31];
        assign s16[4] = 1'b0;
        assign s16[5] = s0[47];
        assign s16[6] = 1'b0;
        assign s16[7] = s0[63];
        assign s16[8] = 1'b0;
        assign s16[9] = s0[79];
        assign s16[10] = 1'b0;
        assign s16[11] = s0[95];
        assign s16[12] = 1'b0;
        assign s16[13] = s0[111];
        assign s16[14] = 1'b0;
        assign s16[15] = s0[127];
        assign s16[16] = 1'b0;
        assign s16[17] = s0[143];
        assign s16[18] = 1'b0;
        assign s16[19] = s0[159];
        assign s16[20] = 1'b0;
        assign s16[21] = s0[175];
        assign s16[22] = 1'b0;
        assign s16[23] = s0[191];
        assign s16[24] = 1'b0;
        assign s16[25] = s0[207];
        assign s16[26] = 1'b0;
        assign s16[27] = s0[223];
        assign s16[28] = 1'b0;
        assign s16[29] = s0[239];
        assign s16[30] = 1'b0;
        assign s16[31] = s0[255];
        assign s16[32] = 1'b0;
        assign s16[33] = s0[271];
        assign s16[34] = 1'b0;
        assign s16[35] = s0[287];
        assign s16[36] = 1'b0;
        assign s16[37] = s0[303];
        assign s16[38] = 1'b0;
        assign s16[39] = s0[319];
        assign s16[40] = 1'b0;
        assign s16[41] = s0[335];
        assign s16[42] = 1'b0;
        assign s16[43] = s0[351];
        assign s16[44] = 1'b0;
        assign s16[45] = s0[367];
        assign s16[46] = 1'b0;
        assign s16[47] = s0[383];
        assign s16[48] = 1'b0;
        assign s16[49] = s0[399];
        assign s16[50] = 1'b0;
        assign s16[51] = s0[415];
        assign s16[52] = 1'b0;
        assign s16[53] = s0[431];
        assign s16[54] = 1'b0;
        assign s16[55] = s0[447];
        assign s16[56] = 1'b0;
        assign s16[57] = s0[463];
        assign s16[58] = 1'b0;
        assign s16[59] = s0[479];
        assign s16[60] = 1'b0;
        assign s16[61] = s0[495];
        assign s16[62] = 1'b0;
        assign s16[63] = s0[511];
        assign s17[0] = 1'b0;
        assign s17[1] = s0[15];
        assign s17[2] = s0[23];
        assign s17[3] = s0[31];
        assign s17[4] = 1'b0;
        assign s17[5] = s0[47];
        assign s17[6] = s0[55];
        assign s17[7] = s0[63];
        assign s17[8] = 1'b0;
        assign s17[9] = s0[79];
        assign s17[10] = s0[87];
        assign s17[11] = s0[95];
        assign s17[12] = 1'b0;
        assign s17[13] = s0[111];
        assign s17[14] = s0[119];
        assign s17[15] = s0[127];
        assign s17[16] = 1'b0;
        assign s17[17] = s0[143];
        assign s17[18] = s0[151];
        assign s17[19] = s0[159];
        assign s17[20] = 1'b0;
        assign s17[21] = s0[175];
        assign s17[22] = s0[183];
        assign s17[23] = s0[191];
        assign s17[24] = 1'b0;
        assign s17[25] = s0[207];
        assign s17[26] = s0[215];
        assign s17[27] = s0[223];
        assign s17[28] = 1'b0;
        assign s17[29] = s0[239];
        assign s17[30] = s0[247];
        assign s17[31] = s0[255];
        assign s17[32] = 1'b0;
        assign s17[33] = s0[271];
        assign s17[34] = s0[279];
        assign s17[35] = s0[287];
        assign s17[36] = 1'b0;
        assign s17[37] = s0[303];
        assign s17[38] = s0[311];
        assign s17[39] = s0[319];
        assign s17[40] = 1'b0;
        assign s17[41] = s0[335];
        assign s17[42] = s0[343];
        assign s17[43] = s0[351];
        assign s17[44] = 1'b0;
        assign s17[45] = s0[367];
        assign s17[46] = s0[375];
        assign s17[47] = s0[383];
        assign s17[48] = 1'b0;
        assign s17[49] = s0[399];
        assign s17[50] = s0[407];
        assign s17[51] = s0[415];
        assign s17[52] = 1'b0;
        assign s17[53] = s0[431];
        assign s17[54] = s0[439];
        assign s17[55] = s0[447];
        assign s17[56] = 1'b0;
        assign s17[57] = s0[463];
        assign s17[58] = s0[471];
        assign s17[59] = s0[479];
        assign s17[60] = 1'b0;
        assign s17[61] = s0[495];
        assign s17[62] = s0[503];
        assign s17[63] = s0[511];
        assign s22[0] = 1'b0;
        assign s18[0] = 1'b0;
        assign s22[1] = s0[15];
        assign s18[1] = s0[15];
        assign s22[2] = s0[23];
        assign s18[2] = s0[23];
        assign s22[3] = s0[31];
        assign s18[3] = s0[31];
        assign s22[4] = s0[39];
        assign s18[4] = s0[39];
        assign s22[5] = s0[47];
        assign s18[5] = s0[47];
        assign s22[6] = s0[55];
        assign s18[6] = s0[55];
        assign s22[7] = s0[63];
        assign s18[7] = s0[63];
        assign s22[8] = 1'b0;
        assign s18[8] = 1'b0;
        assign s22[9] = s0[79];
        assign s18[9] = s0[79];
        assign s22[10] = s0[87];
        assign s18[10] = s0[87];
        assign s22[11] = s0[95];
        assign s18[11] = s0[95];
        assign s22[12] = s0[103];
        assign s18[12] = s0[103];
        assign s22[13] = s0[111];
        assign s18[13] = s0[111];
        assign s22[14] = s0[119];
        assign s18[14] = s0[119];
        assign s22[15] = s0[127];
        assign s18[15] = s0[127];
        assign s22[16] = 1'b0;
        assign s18[16] = 1'b0;
        assign s22[17] = s0[143];
        assign s18[17] = s0[143];
        assign s22[18] = s0[151];
        assign s18[18] = s0[151];
        assign s22[19] = s0[159];
        assign s18[19] = s0[159];
        assign s22[20] = s0[167];
        assign s18[20] = s0[167];
        assign s22[21] = s0[175];
        assign s18[21] = s0[175];
        assign s22[22] = s0[183];
        assign s18[22] = s0[183];
        assign s22[23] = s0[191];
        assign s18[23] = s0[191];
        assign s22[24] = 1'b0;
        assign s18[24] = 1'b0;
        assign s22[25] = s0[207];
        assign s18[25] = s0[207];
        assign s22[26] = s0[215];
        assign s18[26] = s0[215];
        assign s22[27] = s0[223];
        assign s18[27] = s0[223];
        assign s22[28] = s0[231];
        assign s18[28] = s0[231];
        assign s22[29] = s0[239];
        assign s18[29] = s0[239];
        assign s22[30] = s0[247];
        assign s18[30] = s0[247];
        assign s22[31] = s0[255];
        assign s18[31] = s0[255];
        assign s22[32] = 1'b0;
        assign s18[32] = 1'b0;
        assign s22[33] = s0[271];
        assign s18[33] = s0[271];
        assign s22[34] = s0[279];
        assign s18[34] = s0[279];
        assign s22[35] = s0[287];
        assign s18[35] = s0[287];
        assign s22[36] = s0[295];
        assign s18[36] = s0[295];
        assign s22[37] = s0[303];
        assign s18[37] = s0[303];
        assign s22[38] = s0[311];
        assign s18[38] = s0[311];
        assign s22[39] = s0[319];
        assign s18[39] = s0[319];
        assign s22[40] = 1'b0;
        assign s18[40] = 1'b0;
        assign s22[41] = s0[335];
        assign s18[41] = s0[335];
        assign s22[42] = s0[343];
        assign s18[42] = s0[343];
        assign s22[43] = s0[351];
        assign s18[43] = s0[351];
        assign s22[44] = s0[359];
        assign s18[44] = s0[359];
        assign s22[45] = s0[367];
        assign s18[45] = s0[367];
        assign s22[46] = s0[375];
        assign s18[46] = s0[375];
        assign s22[47] = s0[383];
        assign s18[47] = s0[383];
        assign s22[48] = 1'b0;
        assign s18[48] = 1'b0;
        assign s22[49] = s0[399];
        assign s18[49] = s0[399];
        assign s22[50] = s0[407];
        assign s18[50] = s0[407];
        assign s22[51] = s0[415];
        assign s18[51] = s0[415];
        assign s22[52] = s0[423];
        assign s18[52] = s0[423];
        assign s22[53] = s0[431];
        assign s18[53] = s0[431];
        assign s22[54] = s0[439];
        assign s18[54] = s0[439];
        assign s22[55] = s0[447];
        assign s18[55] = s0[447];
        assign s22[56] = 1'b0;
        assign s18[56] = 1'b0;
        assign s22[57] = s0[463];
        assign s18[57] = s0[463];
        assign s22[58] = s0[471];
        assign s18[58] = s0[471];
        assign s22[59] = s0[479];
        assign s18[59] = s0[479];
        assign s22[60] = s0[487];
        assign s18[60] = s0[487];
        assign s22[61] = s0[495];
        assign s18[61] = s0[495];
        assign s22[62] = s0[503];
        assign s18[62] = s0[503];
        assign s22[63] = s0[511];
        assign s18[63] = s0[511];
        assign s25[0 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[1 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[2 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[3 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[4 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[5 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[6 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[7 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s19[0] = 1'b0;
        assign s19[1] = 1'b0;
        assign s19[2] = s0[23];
        assign s19[3] = s0[31];
        assign s19[4] = 1'b0;
        assign s19[5] = 1'b0;
        assign s19[6] = s0[55];
        assign s19[7] = s0[63];
        assign s19[8] = 1'b0;
        assign s19[9] = 1'b0;
        assign s19[10] = s0[87];
        assign s19[11] = s0[95];
        assign s19[12] = 1'b0;
        assign s19[13] = 1'b0;
        assign s19[14] = s0[119];
        assign s19[15] = s0[127];
        assign s19[16] = 1'b0;
        assign s19[17] = 1'b0;
        assign s19[18] = s0[151];
        assign s19[19] = s0[159];
        assign s19[20] = 1'b0;
        assign s19[21] = 1'b0;
        assign s19[22] = s0[183];
        assign s19[23] = s0[191];
        assign s19[24] = 1'b0;
        assign s19[25] = 1'b0;
        assign s19[26] = s0[215];
        assign s19[27] = s0[223];
        assign s19[28] = 1'b0;
        assign s19[29] = 1'b0;
        assign s19[30] = s0[247];
        assign s19[31] = s0[255];
        assign s19[32] = 1'b0;
        assign s19[33] = 1'b0;
        assign s19[34] = s0[279];
        assign s19[35] = s0[287];
        assign s19[36] = 1'b0;
        assign s19[37] = 1'b0;
        assign s19[38] = s0[311];
        assign s19[39] = s0[319];
        assign s19[40] = 1'b0;
        assign s19[41] = 1'b0;
        assign s19[42] = s0[343];
        assign s19[43] = s0[351];
        assign s19[44] = 1'b0;
        assign s19[45] = 1'b0;
        assign s19[46] = s0[375];
        assign s19[47] = s0[383];
        assign s19[48] = 1'b0;
        assign s19[49] = 1'b0;
        assign s19[50] = s0[407];
        assign s19[51] = s0[415];
        assign s19[52] = 1'b0;
        assign s19[53] = 1'b0;
        assign s19[54] = s0[439];
        assign s19[55] = s0[447];
        assign s19[56] = 1'b0;
        assign s19[57] = 1'b0;
        assign s19[58] = s0[471];
        assign s19[59] = s0[479];
        assign s19[60] = 1'b0;
        assign s19[61] = 1'b0;
        assign s19[62] = s0[503];
        assign s19[63] = s0[511];
        assign s23[0] = 1'b0;
        assign s20[0] = 1'b0;
        assign s23[1] = 1'b0;
        assign s20[1] = 1'b0;
        assign s23[2] = s0[23];
        assign s20[2] = s0[23];
        assign s23[3] = s0[31];
        assign s20[3] = s0[31];
        assign s23[4] = s0[39];
        assign s20[4] = s0[39];
        assign s23[5] = s0[47];
        assign s20[5] = s0[47];
        assign s23[6] = s0[55];
        assign s20[6] = s0[55];
        assign s23[7] = s0[63];
        assign s20[7] = s0[63];
        assign s23[8] = 1'b0;
        assign s20[8] = 1'b0;
        assign s23[9] = 1'b0;
        assign s20[9] = 1'b0;
        assign s23[10] = s0[87];
        assign s20[10] = s0[87];
        assign s23[11] = s0[95];
        assign s20[11] = s0[95];
        assign s23[12] = s0[103];
        assign s20[12] = s0[103];
        assign s23[13] = s0[111];
        assign s20[13] = s0[111];
        assign s23[14] = s0[119];
        assign s20[14] = s0[119];
        assign s23[15] = s0[127];
        assign s20[15] = s0[127];
        assign s23[16] = 1'b0;
        assign s20[16] = 1'b0;
        assign s23[17] = 1'b0;
        assign s20[17] = 1'b0;
        assign s23[18] = s0[151];
        assign s20[18] = s0[151];
        assign s23[19] = s0[159];
        assign s20[19] = s0[159];
        assign s23[20] = s0[167];
        assign s20[20] = s0[167];
        assign s23[21] = s0[175];
        assign s20[21] = s0[175];
        assign s23[22] = s0[183];
        assign s20[22] = s0[183];
        assign s23[23] = s0[191];
        assign s20[23] = s0[191];
        assign s23[24] = 1'b0;
        assign s20[24] = 1'b0;
        assign s23[25] = 1'b0;
        assign s20[25] = 1'b0;
        assign s23[26] = s0[215];
        assign s20[26] = s0[215];
        assign s23[27] = s0[223];
        assign s20[27] = s0[223];
        assign s23[28] = s0[231];
        assign s20[28] = s0[231];
        assign s23[29] = s0[239];
        assign s20[29] = s0[239];
        assign s23[30] = s0[247];
        assign s20[30] = s0[247];
        assign s23[31] = s0[255];
        assign s20[31] = s0[255];
        assign s23[32] = 1'b0;
        assign s20[32] = 1'b0;
        assign s23[33] = 1'b0;
        assign s20[33] = 1'b0;
        assign s23[34] = s0[279];
        assign s20[34] = s0[279];
        assign s23[35] = s0[287];
        assign s20[35] = s0[287];
        assign s23[36] = s0[295];
        assign s20[36] = s0[295];
        assign s23[37] = s0[303];
        assign s20[37] = s0[303];
        assign s23[38] = s0[311];
        assign s20[38] = s0[311];
        assign s23[39] = s0[319];
        assign s20[39] = s0[319];
        assign s23[40] = 1'b0;
        assign s20[40] = 1'b0;
        assign s23[41] = 1'b0;
        assign s20[41] = 1'b0;
        assign s23[42] = s0[343];
        assign s20[42] = s0[343];
        assign s23[43] = s0[351];
        assign s20[43] = s0[351];
        assign s23[44] = s0[359];
        assign s20[44] = s0[359];
        assign s23[45] = s0[367];
        assign s20[45] = s0[367];
        assign s23[46] = s0[375];
        assign s20[46] = s0[375];
        assign s23[47] = s0[383];
        assign s20[47] = s0[383];
        assign s23[48] = 1'b0;
        assign s20[48] = 1'b0;
        assign s23[49] = 1'b0;
        assign s20[49] = 1'b0;
        assign s23[50] = s0[407];
        assign s20[50] = s0[407];
        assign s23[51] = s0[415];
        assign s20[51] = s0[415];
        assign s23[52] = s0[423];
        assign s20[52] = s0[423];
        assign s23[53] = s0[431];
        assign s20[53] = s0[431];
        assign s23[54] = s0[439];
        assign s20[54] = s0[439];
        assign s23[55] = s0[447];
        assign s20[55] = s0[447];
        assign s23[56] = 1'b0;
        assign s20[56] = 1'b0;
        assign s23[57] = 1'b0;
        assign s20[57] = 1'b0;
        assign s23[58] = s0[471];
        assign s20[58] = s0[471];
        assign s23[59] = s0[479];
        assign s20[59] = s0[479];
        assign s23[60] = s0[487];
        assign s20[60] = s0[487];
        assign s23[61] = s0[495];
        assign s20[61] = s0[495];
        assign s23[62] = s0[503];
        assign s20[62] = s0[503];
        assign s23[63] = s0[511];
        assign s20[63] = s0[511];
        assign s26[0 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[1 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[2 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[3 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[4 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[5 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[6 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[7 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s24[0] = 1'b0;
        assign s21[0] = 1'b0;
        assign s24[1] = 1'b0;
        assign s21[1] = 1'b0;
        assign s24[2] = 1'b0;
        assign s21[2] = 1'b0;
        assign s24[3] = 1'b0;
        assign s21[3] = 1'b0;
        assign s24[4] = s0[39];
        assign s21[4] = s0[39];
        assign s24[5] = s0[47];
        assign s21[5] = s0[47];
        assign s24[6] = s0[55];
        assign s21[6] = s0[55];
        assign s24[7] = s0[63];
        assign s21[7] = s0[63];
        assign s24[8] = 1'b0;
        assign s21[8] = 1'b0;
        assign s24[9] = 1'b0;
        assign s21[9] = 1'b0;
        assign s24[10] = 1'b0;
        assign s21[10] = 1'b0;
        assign s24[11] = 1'b0;
        assign s21[11] = 1'b0;
        assign s24[12] = s0[103];
        assign s21[12] = s0[103];
        assign s24[13] = s0[111];
        assign s21[13] = s0[111];
        assign s24[14] = s0[119];
        assign s21[14] = s0[119];
        assign s24[15] = s0[127];
        assign s21[15] = s0[127];
        assign s24[16] = 1'b0;
        assign s21[16] = 1'b0;
        assign s24[17] = 1'b0;
        assign s21[17] = 1'b0;
        assign s24[18] = 1'b0;
        assign s21[18] = 1'b0;
        assign s24[19] = 1'b0;
        assign s21[19] = 1'b0;
        assign s24[20] = s0[167];
        assign s21[20] = s0[167];
        assign s24[21] = s0[175];
        assign s21[21] = s0[175];
        assign s24[22] = s0[183];
        assign s21[22] = s0[183];
        assign s24[23] = s0[191];
        assign s21[23] = s0[191];
        assign s24[24] = 1'b0;
        assign s21[24] = 1'b0;
        assign s24[25] = 1'b0;
        assign s21[25] = 1'b0;
        assign s24[26] = 1'b0;
        assign s21[26] = 1'b0;
        assign s24[27] = 1'b0;
        assign s21[27] = 1'b0;
        assign s24[28] = s0[231];
        assign s21[28] = s0[231];
        assign s24[29] = s0[239];
        assign s21[29] = s0[239];
        assign s24[30] = s0[247];
        assign s21[30] = s0[247];
        assign s24[31] = s0[255];
        assign s21[31] = s0[255];
        assign s24[32] = 1'b0;
        assign s21[32] = 1'b0;
        assign s24[33] = 1'b0;
        assign s21[33] = 1'b0;
        assign s24[34] = 1'b0;
        assign s21[34] = 1'b0;
        assign s24[35] = 1'b0;
        assign s21[35] = 1'b0;
        assign s24[36] = s0[295];
        assign s21[36] = s0[295];
        assign s24[37] = s0[303];
        assign s21[37] = s0[303];
        assign s24[38] = s0[311];
        assign s21[38] = s0[311];
        assign s24[39] = s0[319];
        assign s21[39] = s0[319];
        assign s24[40] = 1'b0;
        assign s21[40] = 1'b0;
        assign s24[41] = 1'b0;
        assign s21[41] = 1'b0;
        assign s24[42] = 1'b0;
        assign s21[42] = 1'b0;
        assign s24[43] = 1'b0;
        assign s21[43] = 1'b0;
        assign s24[44] = s0[359];
        assign s21[44] = s0[359];
        assign s24[45] = s0[367];
        assign s21[45] = s0[367];
        assign s24[46] = s0[375];
        assign s21[46] = s0[375];
        assign s24[47] = s0[383];
        assign s21[47] = s0[383];
        assign s24[48] = 1'b0;
        assign s21[48] = 1'b0;
        assign s24[49] = 1'b0;
        assign s21[49] = 1'b0;
        assign s24[50] = 1'b0;
        assign s21[50] = 1'b0;
        assign s24[51] = 1'b0;
        assign s21[51] = 1'b0;
        assign s24[52] = s0[423];
        assign s21[52] = s0[423];
        assign s24[53] = s0[431];
        assign s21[53] = s0[431];
        assign s24[54] = s0[439];
        assign s21[54] = s0[439];
        assign s24[55] = s0[447];
        assign s21[55] = s0[447];
        assign s24[56] = 1'b0;
        assign s21[56] = 1'b0;
        assign s24[57] = 1'b0;
        assign s21[57] = 1'b0;
        assign s24[58] = 1'b0;
        assign s21[58] = 1'b0;
        assign s24[59] = 1'b0;
        assign s21[59] = 1'b0;
        assign s24[60] = s0[487];
        assign s21[60] = s0[487];
        assign s24[61] = s0[495];
        assign s21[61] = s0[495];
        assign s24[62] = s0[503];
        assign s21[62] = s0[503];
        assign s24[63] = s0[511];
        assign s21[63] = s0[511];
        assign s27[0 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[1 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[2 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[3 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[4 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[5 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[6 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[7 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        kv_mux128 #(
            .W(8)
        ) u_mux0 (
            .out(s0[0 * 8 +:8]),
            .sel(idx[0 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux1 (
            .out(s0[1 * 8 +:8]),
            .sel(idx[1 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux2 (
            .out(s0[2 * 8 +:8]),
            .sel(idx[2 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux3 (
            .out(s0[3 * 8 +:8]),
            .sel(idx[3 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux4 (
            .out(s0[4 * 8 +:8]),
            .sel(idx[4 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux5 (
            .out(s0[5 * 8 +:8]),
            .sel(idx[5 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux6 (
            .out(s0[6 * 8 +:8]),
            .sel(idx[6 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux7 (
            .out(s0[7 * 8 +:8]),
            .sel(idx[7 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux8 (
            .out(s0[8 * 8 +:8]),
            .sel(idx[8 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux9 (
            .out(s0[9 * 8 +:8]),
            .sel(idx[9 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux10 (
            .out(s0[10 * 8 +:8]),
            .sel(idx[10 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux11 (
            .out(s0[11 * 8 +:8]),
            .sel(idx[11 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux12 (
            .out(s0[12 * 8 +:8]),
            .sel(idx[12 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux13 (
            .out(s0[13 * 8 +:8]),
            .sel(idx[13 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux14 (
            .out(s0[14 * 8 +:8]),
            .sel(idx[14 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux15 (
            .out(s0[15 * 8 +:8]),
            .sel(idx[15 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux16 (
            .out(s0[16 * 8 +:8]),
            .sel(idx[16 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux17 (
            .out(s0[17 * 8 +:8]),
            .sel(idx[17 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux18 (
            .out(s0[18 * 8 +:8]),
            .sel(idx[18 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux19 (
            .out(s0[19 * 8 +:8]),
            .sel(idx[19 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux20 (
            .out(s0[20 * 8 +:8]),
            .sel(idx[20 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux21 (
            .out(s0[21 * 8 +:8]),
            .sel(idx[21 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux22 (
            .out(s0[22 * 8 +:8]),
            .sel(idx[22 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux23 (
            .out(s0[23 * 8 +:8]),
            .sel(idx[23 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux24 (
            .out(s0[24 * 8 +:8]),
            .sel(idx[24 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux25 (
            .out(s0[25 * 8 +:8]),
            .sel(idx[25 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux26 (
            .out(s0[26 * 8 +:8]),
            .sel(idx[26 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux27 (
            .out(s0[27 * 8 +:8]),
            .sel(idx[27 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux28 (
            .out(s0[28 * 8 +:8]),
            .sel(idx[28 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux29 (
            .out(s0[29 * 8 +:8]),
            .sel(idx[29 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux30 (
            .out(s0[30 * 8 +:8]),
            .sel(idx[30 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux31 (
            .out(s0[31 * 8 +:8]),
            .sel(idx[31 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux32 (
            .out(s0[32 * 8 +:8]),
            .sel(idx[32 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux33 (
            .out(s0[33 * 8 +:8]),
            .sel(idx[33 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux34 (
            .out(s0[34 * 8 +:8]),
            .sel(idx[34 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux35 (
            .out(s0[35 * 8 +:8]),
            .sel(idx[35 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux36 (
            .out(s0[36 * 8 +:8]),
            .sel(idx[36 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux37 (
            .out(s0[37 * 8 +:8]),
            .sel(idx[37 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux38 (
            .out(s0[38 * 8 +:8]),
            .sel(idx[38 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux39 (
            .out(s0[39 * 8 +:8]),
            .sel(idx[39 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux40 (
            .out(s0[40 * 8 +:8]),
            .sel(idx[40 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux41 (
            .out(s0[41 * 8 +:8]),
            .sel(idx[41 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux42 (
            .out(s0[42 * 8 +:8]),
            .sel(idx[42 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux43 (
            .out(s0[43 * 8 +:8]),
            .sel(idx[43 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux44 (
            .out(s0[44 * 8 +:8]),
            .sel(idx[44 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux45 (
            .out(s0[45 * 8 +:8]),
            .sel(idx[45 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux46 (
            .out(s0[46 * 8 +:8]),
            .sel(idx[46 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux47 (
            .out(s0[47 * 8 +:8]),
            .sel(idx[47 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux48 (
            .out(s0[48 * 8 +:8]),
            .sel(idx[48 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux49 (
            .out(s0[49 * 8 +:8]),
            .sel(idx[49 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux50 (
            .out(s0[50 * 8 +:8]),
            .sel(idx[50 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux51 (
            .out(s0[51 * 8 +:8]),
            .sel(idx[51 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux52 (
            .out(s0[52 * 8 +:8]),
            .sel(idx[52 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux53 (
            .out(s0[53 * 8 +:8]),
            .sel(idx[53 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux54 (
            .out(s0[54 * 8 +:8]),
            .sel(idx[54 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux55 (
            .out(s0[55 * 8 +:8]),
            .sel(idx[55 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux56 (
            .out(s0[56 * 8 +:8]),
            .sel(idx[56 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux57 (
            .out(s0[57 * 8 +:8]),
            .sel(idx[57 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux58 (
            .out(s0[58 * 8 +:8]),
            .sel(idx[58 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux59 (
            .out(s0[59 * 8 +:8]),
            .sel(idx[59 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux60 (
            .out(s0[60 * 8 +:8]),
            .sel(idx[60 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux61 (
            .out(s0[61 * 8 +:8]),
            .sel(idx[61 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux62 (
            .out(s0[62 * 8 +:8]),
            .sel(idx[62 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux63 (
            .out(s0[63 * 8 +:8]),
            .sel(idx[63 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        assign s13[0 +:8] = {{4{s0[0 + 3] & s4}},s0[0 +:4] & {4{s1}}};
        assign s13[8 +:8] = {{4{s0[15] & s4}},s0[12 +:4] & {4{s1}}};
        assign s13[16 +:8] = {{4{s0[16 + 3] & s4}},s0[16 +:4] & {4{s1}}};
        assign s13[24 +:8] = {{4{s0[31] & s4}},s0[28 +:4] & {4{s1}}};
        assign s13[32 +:8] = {{4{s0[32 + 3] & s4}},s0[32 +:4] & {4{s1}}};
        assign s13[40 +:8] = {{4{s0[47] & s4}},s0[44 +:4] & {4{s1}}};
        assign s13[48 +:8] = {{4{s0[48 + 3] & s4}},s0[48 +:4] & {4{s1}}};
        assign s13[56 +:8] = {{4{s0[63] & s4}},s0[60 +:4] & {4{s1}}};
        assign s13[64 +:8] = {{4{s0[64 + 3] & s4}},s0[64 +:4] & {4{s1}}};
        assign s13[72 +:8] = {{4{s0[79] & s4}},s0[76 +:4] & {4{s1}}};
        assign s13[80 +:8] = {{4{s0[80 + 3] & s4}},s0[80 +:4] & {4{s1}}};
        assign s13[88 +:8] = {{4{s0[95] & s4}},s0[92 +:4] & {4{s1}}};
        assign s13[96 +:8] = {{4{s0[96 + 3] & s4}},s0[96 +:4] & {4{s1}}};
        assign s13[104 +:8] = {{4{s0[111] & s4}},s0[108 +:4] & {4{s1}}};
        assign s13[112 +:8] = {{4{s0[112 + 3] & s4}},s0[112 +:4] & {4{s1}}};
        assign s13[120 +:8] = {{4{s0[127] & s4}},s0[124 +:4] & {4{s1}}};
        assign s13[128 +:8] = {{4{s0[128 + 3] & s4}},s0[128 +:4] & {4{s1}}};
        assign s13[136 +:8] = {{4{s0[143] & s4}},s0[140 +:4] & {4{s1}}};
        assign s13[144 +:8] = {{4{s0[144 + 3] & s4}},s0[144 +:4] & {4{s1}}};
        assign s13[152 +:8] = {{4{s0[159] & s4}},s0[156 +:4] & {4{s1}}};
        assign s13[160 +:8] = {{4{s0[160 + 3] & s4}},s0[160 +:4] & {4{s1}}};
        assign s13[168 +:8] = {{4{s0[175] & s4}},s0[172 +:4] & {4{s1}}};
        assign s13[176 +:8] = {{4{s0[176 + 3] & s4}},s0[176 +:4] & {4{s1}}};
        assign s13[184 +:8] = {{4{s0[191] & s4}},s0[188 +:4] & {4{s1}}};
        assign s13[192 +:8] = {{4{s0[192 + 3] & s4}},s0[192 +:4] & {4{s1}}};
        assign s13[200 +:8] = {{4{s0[207] & s4}},s0[204 +:4] & {4{s1}}};
        assign s13[208 +:8] = {{4{s0[208 + 3] & s4}},s0[208 +:4] & {4{s1}}};
        assign s13[216 +:8] = {{4{s0[223] & s4}},s0[220 +:4] & {4{s1}}};
        assign s13[224 +:8] = {{4{s0[224 + 3] & s4}},s0[224 +:4] & {4{s1}}};
        assign s13[232 +:8] = {{4{s0[239] & s4}},s0[236 +:4] & {4{s1}}};
        assign s13[240 +:8] = {{4{s0[240 + 3] & s4}},s0[240 +:4] & {4{s1}}};
        assign s13[248 +:8] = {{4{s0[255] & s4}},s0[252 +:4] & {4{s1}}};
        assign s13[256 +:8] = {{4{s0[256 + 3] & s4}},s0[256 +:4] & {4{s1}}};
        assign s13[264 +:8] = {{4{s0[271] & s4}},s0[268 +:4] & {4{s1}}};
        assign s13[272 +:8] = {{4{s0[272 + 3] & s4}},s0[272 +:4] & {4{s1}}};
        assign s13[280 +:8] = {{4{s0[287] & s4}},s0[284 +:4] & {4{s1}}};
        assign s13[288 +:8] = {{4{s0[288 + 3] & s4}},s0[288 +:4] & {4{s1}}};
        assign s13[296 +:8] = {{4{s0[303] & s4}},s0[300 +:4] & {4{s1}}};
        assign s13[304 +:8] = {{4{s0[304 + 3] & s4}},s0[304 +:4] & {4{s1}}};
        assign s13[312 +:8] = {{4{s0[319] & s4}},s0[316 +:4] & {4{s1}}};
        assign s13[320 +:8] = {{4{s0[320 + 3] & s4}},s0[320 +:4] & {4{s1}}};
        assign s13[328 +:8] = {{4{s0[335] & s4}},s0[332 +:4] & {4{s1}}};
        assign s13[336 +:8] = {{4{s0[336 + 3] & s4}},s0[336 +:4] & {4{s1}}};
        assign s13[344 +:8] = {{4{s0[351] & s4}},s0[348 +:4] & {4{s1}}};
        assign s13[352 +:8] = {{4{s0[352 + 3] & s4}},s0[352 +:4] & {4{s1}}};
        assign s13[360 +:8] = {{4{s0[367] & s4}},s0[364 +:4] & {4{s1}}};
        assign s13[368 +:8] = {{4{s0[368 + 3] & s4}},s0[368 +:4] & {4{s1}}};
        assign s13[376 +:8] = {{4{s0[383] & s4}},s0[380 +:4] & {4{s1}}};
        assign s13[384 +:8] = {{4{s0[384 + 3] & s4}},s0[384 +:4] & {4{s1}}};
        assign s13[392 +:8] = {{4{s0[399] & s4}},s0[396 +:4] & {4{s1}}};
        assign s13[400 +:8] = {{4{s0[400 + 3] & s4}},s0[400 +:4] & {4{s1}}};
        assign s13[408 +:8] = {{4{s0[415] & s4}},s0[412 +:4] & {4{s1}}};
        assign s13[416 +:8] = {{4{s0[416 + 3] & s4}},s0[416 +:4] & {4{s1}}};
        assign s13[424 +:8] = {{4{s0[431] & s4}},s0[428 +:4] & {4{s1}}};
        assign s13[432 +:8] = {{4{s0[432 + 3] & s4}},s0[432 +:4] & {4{s1}}};
        assign s13[440 +:8] = {{4{s0[447] & s4}},s0[444 +:4] & {4{s1}}};
        assign s13[448 +:8] = {{4{s0[448 + 3] & s4}},s0[448 +:4] & {4{s1}}};
        assign s13[456 +:8] = {{4{s0[463] & s4}},s0[460 +:4] & {4{s1}}};
        assign s13[464 +:8] = {{4{s0[464 + 3] & s4}},s0[464 +:4] & {4{s1}}};
        assign s13[472 +:8] = {{4{s0[479] & s4}},s0[476 +:4] & {4{s1}}};
        assign s13[480 +:8] = {{4{s0[480 + 3] & s4}},s0[480 +:4] & {4{s1}}};
        assign s13[488 +:8] = {{4{s0[495] & s4}},s0[492 +:4] & {4{s1}}};
        assign s13[496 +:8] = {{4{s0[496 + 3] & s4}},s0[496 +:4] & {4{s1}}};
        assign s13[504 +:8] = {{4{s0[511] & s4}},s0[508 +:4] & {4{s1}}};
        assign s14[0 +:16] = {{8{s0[0 + 11] & s5}},{4{s0[0 + 3] & s5}},s0[0 +:4] & {4{s2}}};
        assign s14[16 +:16] = {{8{s0[23 + 8] & s5}},{4{s0[23] & s5}},s0[20 +:4] & {4{s2}}};
        assign s14[32 +:16] = {{8{s0[32 + 11] & s5}},{4{s0[32 + 3] & s5}},s0[32 +:4] & {4{s2}}};
        assign s14[48 +:16] = {{8{s0[55 + 8] & s5}},{4{s0[55] & s5}},s0[52 +:4] & {4{s2}}};
        assign s14[64 +:16] = {{8{s0[64 + 11] & s5}},{4{s0[64 + 3] & s5}},s0[64 +:4] & {4{s2}}};
        assign s14[80 +:16] = {{8{s0[87 + 8] & s5}},{4{s0[87] & s5}},s0[84 +:4] & {4{s2}}};
        assign s14[96 +:16] = {{8{s0[96 + 11] & s5}},{4{s0[96 + 3] & s5}},s0[96 +:4] & {4{s2}}};
        assign s14[112 +:16] = {{8{s0[119 + 8] & s5}},{4{s0[119] & s5}},s0[116 +:4] & {4{s2}}};
        assign s14[128 +:16] = {{8{s0[128 + 11] & s5}},{4{s0[128 + 3] & s5}},s0[128 +:4] & {4{s2}}};
        assign s14[144 +:16] = {{8{s0[151 + 8] & s5}},{4{s0[151] & s5}},s0[148 +:4] & {4{s2}}};
        assign s14[160 +:16] = {{8{s0[160 + 11] & s5}},{4{s0[160 + 3] & s5}},s0[160 +:4] & {4{s2}}};
        assign s14[176 +:16] = {{8{s0[183 + 8] & s5}},{4{s0[183] & s5}},s0[180 +:4] & {4{s2}}};
        assign s14[192 +:16] = {{8{s0[192 + 11] & s5}},{4{s0[192 + 3] & s5}},s0[192 +:4] & {4{s2}}};
        assign s14[208 +:16] = {{8{s0[215 + 8] & s5}},{4{s0[215] & s5}},s0[212 +:4] & {4{s2}}};
        assign s14[224 +:16] = {{8{s0[224 + 11] & s5}},{4{s0[224 + 3] & s5}},s0[224 +:4] & {4{s2}}};
        assign s14[240 +:16] = {{8{s0[247 + 8] & s5}},{4{s0[247] & s5}},s0[244 +:4] & {4{s2}}};
        assign s14[256 +:16] = {{8{s0[256 + 11] & s5}},{4{s0[256 + 3] & s5}},s0[256 +:4] & {4{s2}}};
        assign s14[272 +:16] = {{8{s0[279 + 8] & s5}},{4{s0[279] & s5}},s0[276 +:4] & {4{s2}}};
        assign s14[288 +:16] = {{8{s0[288 + 11] & s5}},{4{s0[288 + 3] & s5}},s0[288 +:4] & {4{s2}}};
        assign s14[304 +:16] = {{8{s0[311 + 8] & s5}},{4{s0[311] & s5}},s0[308 +:4] & {4{s2}}};
        assign s14[320 +:16] = {{8{s0[320 + 11] & s5}},{4{s0[320 + 3] & s5}},s0[320 +:4] & {4{s2}}};
        assign s14[336 +:16] = {{8{s0[343 + 8] & s5}},{4{s0[343] & s5}},s0[340 +:4] & {4{s2}}};
        assign s14[352 +:16] = {{8{s0[352 + 11] & s5}},{4{s0[352 + 3] & s5}},s0[352 +:4] & {4{s2}}};
        assign s14[368 +:16] = {{8{s0[375 + 8] & s5}},{4{s0[375] & s5}},s0[372 +:4] & {4{s2}}};
        assign s14[384 +:16] = {{8{s0[384 + 11] & s5}},{4{s0[384 + 3] & s5}},s0[384 +:4] & {4{s2}}};
        assign s14[400 +:16] = {{8{s0[407 + 8] & s5}},{4{s0[407] & s5}},s0[404 +:4] & {4{s2}}};
        assign s14[416 +:16] = {{8{s0[416 + 11] & s5}},{4{s0[416 + 3] & s5}},s0[416 +:4] & {4{s2}}};
        assign s14[432 +:16] = {{8{s0[439 + 8] & s5}},{4{s0[439] & s5}},s0[436 +:4] & {4{s2}}};
        assign s14[448 +:16] = {{8{s0[448 + 11] & s5}},{4{s0[448 + 3] & s5}},s0[448 +:4] & {4{s2}}};
        assign s14[464 +:16] = {{8{s0[471 + 8] & s5}},{4{s0[471] & s5}},s0[468 +:4] & {4{s2}}};
        assign s14[480 +:16] = {{8{s0[480 + 11] & s5}},{4{s0[480 + 3] & s5}},s0[480 +:4] & {4{s2}}};
        assign s14[496 +:16] = {{8{s0[503 + 8] & s5}},{4{s0[503] & s5}},s0[500 +:4] & {4{s2}}};
        assign s15[0 +:32] = {{8{s0[0 + 27] & s6}},{8{s0[0 + 19] & s6}},{8{s0[0 + 11] & s6}},{4{s0[0 + 3] & s6}},s0[0 +:4] & {4{s3}}};
        assign s15[32 +:32] = {{8{s0[39 + 24] & s6}},{8{s0[39 + 16] & s6}},{8{s0[39 + 8] & s6}},{4{s0[39] & s6}},s0[36 +:4] & {4{s3}}};
        assign s15[64 +:32] = {{8{s0[64 + 27] & s6}},{8{s0[64 + 19] & s6}},{8{s0[64 + 11] & s6}},{4{s0[64 + 3] & s6}},s0[64 +:4] & {4{s3}}};
        assign s15[96 +:32] = {{8{s0[103 + 24] & s6}},{8{s0[103 + 16] & s6}},{8{s0[103 + 8] & s6}},{4{s0[103] & s6}},s0[100 +:4] & {4{s3}}};
        assign s15[128 +:32] = {{8{s0[128 + 27] & s6}},{8{s0[128 + 19] & s6}},{8{s0[128 + 11] & s6}},{4{s0[128 + 3] & s6}},s0[128 +:4] & {4{s3}}};
        assign s15[160 +:32] = {{8{s0[167 + 24] & s6}},{8{s0[167 + 16] & s6}},{8{s0[167 + 8] & s6}},{4{s0[167] & s6}},s0[164 +:4] & {4{s3}}};
        assign s15[192 +:32] = {{8{s0[192 + 27] & s6}},{8{s0[192 + 19] & s6}},{8{s0[192 + 11] & s6}},{4{s0[192 + 3] & s6}},s0[192 +:4] & {4{s3}}};
        assign s15[224 +:32] = {{8{s0[231 + 24] & s6}},{8{s0[231 + 16] & s6}},{8{s0[231 + 8] & s6}},{4{s0[231] & s6}},s0[228 +:4] & {4{s3}}};
        assign s15[256 +:32] = {{8{s0[256 + 27] & s6}},{8{s0[256 + 19] & s6}},{8{s0[256 + 11] & s6}},{4{s0[256 + 3] & s6}},s0[256 +:4] & {4{s3}}};
        assign s15[288 +:32] = {{8{s0[295 + 24] & s6}},{8{s0[295 + 16] & s6}},{8{s0[295 + 8] & s6}},{4{s0[295] & s6}},s0[292 +:4] & {4{s3}}};
        assign s15[320 +:32] = {{8{s0[320 + 27] & s6}},{8{s0[320 + 19] & s6}},{8{s0[320 + 11] & s6}},{4{s0[320 + 3] & s6}},s0[320 +:4] & {4{s3}}};
        assign s15[352 +:32] = {{8{s0[359 + 24] & s6}},{8{s0[359 + 16] & s6}},{8{s0[359 + 8] & s6}},{4{s0[359] & s6}},s0[356 +:4] & {4{s3}}};
        assign s15[384 +:32] = {{8{s0[384 + 27] & s6}},{8{s0[384 + 19] & s6}},{8{s0[384 + 11] & s6}},{4{s0[384 + 3] & s6}},s0[384 +:4] & {4{s3}}};
        assign s15[416 +:32] = {{8{s0[423 + 24] & s6}},{8{s0[423 + 16] & s6}},{8{s0[423 + 8] & s6}},{4{s0[423] & s6}},s0[420 +:4] & {4{s3}}};
        assign s15[448 +:32] = {{8{s0[448 + 27] & s6}},{8{s0[448 + 19] & s6}},{8{s0[448 + 11] & s6}},{4{s0[448 + 3] & s6}},s0[448 +:4] & {4{s3}}};
        assign s15[480 +:32] = {{8{s0[487 + 24] & s6}},{8{s0[487 + 16] & s6}},{8{s0[487 + 8] & s6}},{4{s0[487] & s6}},s0[484 +:4] & {4{s3}}};
        wire [2 * VP_LEN - 1:0] s35;
        assign s35 = {2{s13 | s14 | s15}};
        wire [2 * VP_LEN - 1:0] s36 = {2 * VP_LEN{vmv_nr}} & {vs2_buf[VP_LEN +:VP_LEN],{VP_LEN{1'b0}}};
        assign result0[0 * 8 +:8] = s36[0 * 8 +:8] | s35[0 * 8 +:8] | ({8{s30[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s32[0]}}) | {8{s28[0]}});
        assign result0[1 * 8 +:8] = s36[1 * 8 +:8] | s35[1 * 8 +:8] | ({8{s30[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s32[1]}}) | {8{s28[1]}});
        assign result0[2 * 8 +:8] = s36[2 * 8 +:8] | s35[2 * 8 +:8] | ({8{s30[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s32[2]}}) | {8{s28[2]}});
        assign result0[3 * 8 +:8] = s36[3 * 8 +:8] | s35[3 * 8 +:8] | ({8{s30[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s32[3]}}) | {8{s28[3]}});
        assign result0[4 * 8 +:8] = s36[4 * 8 +:8] | s35[4 * 8 +:8] | ({8{s30[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s32[4]}}) | {8{s28[4]}});
        assign result0[5 * 8 +:8] = s36[5 * 8 +:8] | s35[5 * 8 +:8] | ({8{s30[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s32[5]}}) | {8{s28[5]}});
        assign result0[6 * 8 +:8] = s36[6 * 8 +:8] | s35[6 * 8 +:8] | ({8{s30[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s32[6]}}) | {8{s28[6]}});
        assign result0[7 * 8 +:8] = s36[7 * 8 +:8] | s35[7 * 8 +:8] | ({8{s30[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s32[7]}}) | {8{s28[7]}});
        assign result0[8 * 8 +:8] = s36[8 * 8 +:8] | s35[8 * 8 +:8] | ({8{s30[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s32[8]}}) | {8{s28[8]}});
        assign result0[9 * 8 +:8] = s36[9 * 8 +:8] | s35[9 * 8 +:8] | ({8{s30[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s32[9]}}) | {8{s28[9]}});
        assign result0[10 * 8 +:8] = s36[10 * 8 +:8] | s35[10 * 8 +:8] | ({8{s30[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s32[10]}}) | {8{s28[10]}});
        assign result0[11 * 8 +:8] = s36[11 * 8 +:8] | s35[11 * 8 +:8] | ({8{s30[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s32[11]}}) | {8{s28[11]}});
        assign result0[12 * 8 +:8] = s36[12 * 8 +:8] | s35[12 * 8 +:8] | ({8{s30[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s32[12]}}) | {8{s28[12]}});
        assign result0[13 * 8 +:8] = s36[13 * 8 +:8] | s35[13 * 8 +:8] | ({8{s30[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s32[13]}}) | {8{s28[13]}});
        assign result0[14 * 8 +:8] = s36[14 * 8 +:8] | s35[14 * 8 +:8] | ({8{s30[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s32[14]}}) | {8{s28[14]}});
        assign result0[15 * 8 +:8] = s36[15 * 8 +:8] | s35[15 * 8 +:8] | ({8{s30[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s32[15]}}) | {8{s28[15]}});
        assign result0[16 * 8 +:8] = s36[16 * 8 +:8] | s35[16 * 8 +:8] | ({8{s30[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s32[16]}}) | {8{s28[16]}});
        assign result0[17 * 8 +:8] = s36[17 * 8 +:8] | s35[17 * 8 +:8] | ({8{s30[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s32[17]}}) | {8{s28[17]}});
        assign result0[18 * 8 +:8] = s36[18 * 8 +:8] | s35[18 * 8 +:8] | ({8{s30[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s32[18]}}) | {8{s28[18]}});
        assign result0[19 * 8 +:8] = s36[19 * 8 +:8] | s35[19 * 8 +:8] | ({8{s30[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s32[19]}}) | {8{s28[19]}});
        assign result0[20 * 8 +:8] = s36[20 * 8 +:8] | s35[20 * 8 +:8] | ({8{s30[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s32[20]}}) | {8{s28[20]}});
        assign result0[21 * 8 +:8] = s36[21 * 8 +:8] | s35[21 * 8 +:8] | ({8{s30[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s32[21]}}) | {8{s28[21]}});
        assign result0[22 * 8 +:8] = s36[22 * 8 +:8] | s35[22 * 8 +:8] | ({8{s30[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s32[22]}}) | {8{s28[22]}});
        assign result0[23 * 8 +:8] = s36[23 * 8 +:8] | s35[23 * 8 +:8] | ({8{s30[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s32[23]}}) | {8{s28[23]}});
        assign result0[24 * 8 +:8] = s36[24 * 8 +:8] | s35[24 * 8 +:8] | ({8{s30[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s32[24]}}) | {8{s28[24]}});
        assign result0[25 * 8 +:8] = s36[25 * 8 +:8] | s35[25 * 8 +:8] | ({8{s30[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s32[25]}}) | {8{s28[25]}});
        assign result0[26 * 8 +:8] = s36[26 * 8 +:8] | s35[26 * 8 +:8] | ({8{s30[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s32[26]}}) | {8{s28[26]}});
        assign result0[27 * 8 +:8] = s36[27 * 8 +:8] | s35[27 * 8 +:8] | ({8{s30[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s32[27]}}) | {8{s28[27]}});
        assign result0[28 * 8 +:8] = s36[28 * 8 +:8] | s35[28 * 8 +:8] | ({8{s30[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s32[28]}}) | {8{s28[28]}});
        assign result0[29 * 8 +:8] = s36[29 * 8 +:8] | s35[29 * 8 +:8] | ({8{s30[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s32[29]}}) | {8{s28[29]}});
        assign result0[30 * 8 +:8] = s36[30 * 8 +:8] | s35[30 * 8 +:8] | ({8{s30[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s32[30]}}) | {8{s28[30]}});
        assign result0[31 * 8 +:8] = s36[31 * 8 +:8] | s35[31 * 8 +:8] | ({8{s30[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s32[31]}}) | {8{s28[31]}});
        assign result0[32 * 8 +:8] = s36[32 * 8 +:8] | s35[32 * 8 +:8] | ({8{s30[32]}} & s34[32 * 8 +:8]) | ((s0[32 * 8 +:8] & {8{s32[32]}}) | {8{s28[32]}});
        assign result0[33 * 8 +:8] = s36[33 * 8 +:8] | s35[33 * 8 +:8] | ({8{s30[33]}} & s34[33 * 8 +:8]) | ((s0[33 * 8 +:8] & {8{s32[33]}}) | {8{s28[33]}});
        assign result0[34 * 8 +:8] = s36[34 * 8 +:8] | s35[34 * 8 +:8] | ({8{s30[34]}} & s34[34 * 8 +:8]) | ((s0[34 * 8 +:8] & {8{s32[34]}}) | {8{s28[34]}});
        assign result0[35 * 8 +:8] = s36[35 * 8 +:8] | s35[35 * 8 +:8] | ({8{s30[35]}} & s34[35 * 8 +:8]) | ((s0[35 * 8 +:8] & {8{s32[35]}}) | {8{s28[35]}});
        assign result0[36 * 8 +:8] = s36[36 * 8 +:8] | s35[36 * 8 +:8] | ({8{s30[36]}} & s34[36 * 8 +:8]) | ((s0[36 * 8 +:8] & {8{s32[36]}}) | {8{s28[36]}});
        assign result0[37 * 8 +:8] = s36[37 * 8 +:8] | s35[37 * 8 +:8] | ({8{s30[37]}} & s34[37 * 8 +:8]) | ((s0[37 * 8 +:8] & {8{s32[37]}}) | {8{s28[37]}});
        assign result0[38 * 8 +:8] = s36[38 * 8 +:8] | s35[38 * 8 +:8] | ({8{s30[38]}} & s34[38 * 8 +:8]) | ((s0[38 * 8 +:8] & {8{s32[38]}}) | {8{s28[38]}});
        assign result0[39 * 8 +:8] = s36[39 * 8 +:8] | s35[39 * 8 +:8] | ({8{s30[39]}} & s34[39 * 8 +:8]) | ((s0[39 * 8 +:8] & {8{s32[39]}}) | {8{s28[39]}});
        assign result0[40 * 8 +:8] = s36[40 * 8 +:8] | s35[40 * 8 +:8] | ({8{s30[40]}} & s34[40 * 8 +:8]) | ((s0[40 * 8 +:8] & {8{s32[40]}}) | {8{s28[40]}});
        assign result0[41 * 8 +:8] = s36[41 * 8 +:8] | s35[41 * 8 +:8] | ({8{s30[41]}} & s34[41 * 8 +:8]) | ((s0[41 * 8 +:8] & {8{s32[41]}}) | {8{s28[41]}});
        assign result0[42 * 8 +:8] = s36[42 * 8 +:8] | s35[42 * 8 +:8] | ({8{s30[42]}} & s34[42 * 8 +:8]) | ((s0[42 * 8 +:8] & {8{s32[42]}}) | {8{s28[42]}});
        assign result0[43 * 8 +:8] = s36[43 * 8 +:8] | s35[43 * 8 +:8] | ({8{s30[43]}} & s34[43 * 8 +:8]) | ((s0[43 * 8 +:8] & {8{s32[43]}}) | {8{s28[43]}});
        assign result0[44 * 8 +:8] = s36[44 * 8 +:8] | s35[44 * 8 +:8] | ({8{s30[44]}} & s34[44 * 8 +:8]) | ((s0[44 * 8 +:8] & {8{s32[44]}}) | {8{s28[44]}});
        assign result0[45 * 8 +:8] = s36[45 * 8 +:8] | s35[45 * 8 +:8] | ({8{s30[45]}} & s34[45 * 8 +:8]) | ((s0[45 * 8 +:8] & {8{s32[45]}}) | {8{s28[45]}});
        assign result0[46 * 8 +:8] = s36[46 * 8 +:8] | s35[46 * 8 +:8] | ({8{s30[46]}} & s34[46 * 8 +:8]) | ((s0[46 * 8 +:8] & {8{s32[46]}}) | {8{s28[46]}});
        assign result0[47 * 8 +:8] = s36[47 * 8 +:8] | s35[47 * 8 +:8] | ({8{s30[47]}} & s34[47 * 8 +:8]) | ((s0[47 * 8 +:8] & {8{s32[47]}}) | {8{s28[47]}});
        assign result0[48 * 8 +:8] = s36[48 * 8 +:8] | s35[48 * 8 +:8] | ({8{s30[48]}} & s34[48 * 8 +:8]) | ((s0[48 * 8 +:8] & {8{s32[48]}}) | {8{s28[48]}});
        assign result0[49 * 8 +:8] = s36[49 * 8 +:8] | s35[49 * 8 +:8] | ({8{s30[49]}} & s34[49 * 8 +:8]) | ((s0[49 * 8 +:8] & {8{s32[49]}}) | {8{s28[49]}});
        assign result0[50 * 8 +:8] = s36[50 * 8 +:8] | s35[50 * 8 +:8] | ({8{s30[50]}} & s34[50 * 8 +:8]) | ((s0[50 * 8 +:8] & {8{s32[50]}}) | {8{s28[50]}});
        assign result0[51 * 8 +:8] = s36[51 * 8 +:8] | s35[51 * 8 +:8] | ({8{s30[51]}} & s34[51 * 8 +:8]) | ((s0[51 * 8 +:8] & {8{s32[51]}}) | {8{s28[51]}});
        assign result0[52 * 8 +:8] = s36[52 * 8 +:8] | s35[52 * 8 +:8] | ({8{s30[52]}} & s34[52 * 8 +:8]) | ((s0[52 * 8 +:8] & {8{s32[52]}}) | {8{s28[52]}});
        assign result0[53 * 8 +:8] = s36[53 * 8 +:8] | s35[53 * 8 +:8] | ({8{s30[53]}} & s34[53 * 8 +:8]) | ((s0[53 * 8 +:8] & {8{s32[53]}}) | {8{s28[53]}});
        assign result0[54 * 8 +:8] = s36[54 * 8 +:8] | s35[54 * 8 +:8] | ({8{s30[54]}} & s34[54 * 8 +:8]) | ((s0[54 * 8 +:8] & {8{s32[54]}}) | {8{s28[54]}});
        assign result0[55 * 8 +:8] = s36[55 * 8 +:8] | s35[55 * 8 +:8] | ({8{s30[55]}} & s34[55 * 8 +:8]) | ((s0[55 * 8 +:8] & {8{s32[55]}}) | {8{s28[55]}});
        assign result0[56 * 8 +:8] = s36[56 * 8 +:8] | s35[56 * 8 +:8] | ({8{s30[56]}} & s34[56 * 8 +:8]) | ((s0[56 * 8 +:8] & {8{s32[56]}}) | {8{s28[56]}});
        assign result0[57 * 8 +:8] = s36[57 * 8 +:8] | s35[57 * 8 +:8] | ({8{s30[57]}} & s34[57 * 8 +:8]) | ((s0[57 * 8 +:8] & {8{s32[57]}}) | {8{s28[57]}});
        assign result0[58 * 8 +:8] = s36[58 * 8 +:8] | s35[58 * 8 +:8] | ({8{s30[58]}} & s34[58 * 8 +:8]) | ((s0[58 * 8 +:8] & {8{s32[58]}}) | {8{s28[58]}});
        assign result0[59 * 8 +:8] = s36[59 * 8 +:8] | s35[59 * 8 +:8] | ({8{s30[59]}} & s34[59 * 8 +:8]) | ((s0[59 * 8 +:8] & {8{s32[59]}}) | {8{s28[59]}});
        assign result0[60 * 8 +:8] = s36[60 * 8 +:8] | s35[60 * 8 +:8] | ({8{s30[60]}} & s34[60 * 8 +:8]) | ((s0[60 * 8 +:8] & {8{s32[60]}}) | {8{s28[60]}});
        assign result0[61 * 8 +:8] = s36[61 * 8 +:8] | s35[61 * 8 +:8] | ({8{s30[61]}} & s34[61 * 8 +:8]) | ((s0[61 * 8 +:8] & {8{s32[61]}}) | {8{s28[61]}});
        assign result0[62 * 8 +:8] = s36[62 * 8 +:8] | s35[62 * 8 +:8] | ({8{s30[62]}} & s34[62 * 8 +:8]) | ((s0[62 * 8 +:8] & {8{s32[62]}}) | {8{s28[62]}});
        assign result0[63 * 8 +:8] = s36[63 * 8 +:8] | s35[63 * 8 +:8] | ({8{s30[63]}} & s34[63 * 8 +:8]) | ((s0[63 * 8 +:8] & {8{s32[63]}}) | {8{s28[63]}});
        assign result1[0 * 8 +:8] = s36[64 * 8 +:8] | s35[64 * 8 +:8] | ({8{s31[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s33[0]}}) | {8{s28[0]}});
        assign result1[1 * 8 +:8] = s36[65 * 8 +:8] | s35[65 * 8 +:8] | ({8{s31[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s33[1]}}) | {8{s28[1]}});
        assign result1[2 * 8 +:8] = s36[66 * 8 +:8] | s35[66 * 8 +:8] | ({8{s31[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s33[2]}}) | {8{s28[2]}});
        assign result1[3 * 8 +:8] = s36[67 * 8 +:8] | s35[67 * 8 +:8] | ({8{s31[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s33[3]}}) | {8{s28[3]}});
        assign result1[4 * 8 +:8] = s36[68 * 8 +:8] | s35[68 * 8 +:8] | ({8{s31[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s33[4]}}) | {8{s28[4]}});
        assign result1[5 * 8 +:8] = s36[69 * 8 +:8] | s35[69 * 8 +:8] | ({8{s31[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s33[5]}}) | {8{s28[5]}});
        assign result1[6 * 8 +:8] = s36[70 * 8 +:8] | s35[70 * 8 +:8] | ({8{s31[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s33[6]}}) | {8{s28[6]}});
        assign result1[7 * 8 +:8] = s36[71 * 8 +:8] | s35[71 * 8 +:8] | ({8{s31[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s33[7]}}) | {8{s28[7]}});
        assign result1[8 * 8 +:8] = s36[72 * 8 +:8] | s35[72 * 8 +:8] | ({8{s31[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s33[8]}}) | {8{s28[8]}});
        assign result1[9 * 8 +:8] = s36[73 * 8 +:8] | s35[73 * 8 +:8] | ({8{s31[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s33[9]}}) | {8{s28[9]}});
        assign result1[10 * 8 +:8] = s36[74 * 8 +:8] | s35[74 * 8 +:8] | ({8{s31[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s33[10]}}) | {8{s28[10]}});
        assign result1[11 * 8 +:8] = s36[75 * 8 +:8] | s35[75 * 8 +:8] | ({8{s31[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s33[11]}}) | {8{s28[11]}});
        assign result1[12 * 8 +:8] = s36[76 * 8 +:8] | s35[76 * 8 +:8] | ({8{s31[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s33[12]}}) | {8{s28[12]}});
        assign result1[13 * 8 +:8] = s36[77 * 8 +:8] | s35[77 * 8 +:8] | ({8{s31[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s33[13]}}) | {8{s28[13]}});
        assign result1[14 * 8 +:8] = s36[78 * 8 +:8] | s35[78 * 8 +:8] | ({8{s31[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s33[14]}}) | {8{s28[14]}});
        assign result1[15 * 8 +:8] = s36[79 * 8 +:8] | s35[79 * 8 +:8] | ({8{s31[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s33[15]}}) | {8{s28[15]}});
        assign result1[16 * 8 +:8] = s36[80 * 8 +:8] | s35[80 * 8 +:8] | ({8{s31[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s33[16]}}) | {8{s28[16]}});
        assign result1[17 * 8 +:8] = s36[81 * 8 +:8] | s35[81 * 8 +:8] | ({8{s31[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s33[17]}}) | {8{s28[17]}});
        assign result1[18 * 8 +:8] = s36[82 * 8 +:8] | s35[82 * 8 +:8] | ({8{s31[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s33[18]}}) | {8{s28[18]}});
        assign result1[19 * 8 +:8] = s36[83 * 8 +:8] | s35[83 * 8 +:8] | ({8{s31[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s33[19]}}) | {8{s28[19]}});
        assign result1[20 * 8 +:8] = s36[84 * 8 +:8] | s35[84 * 8 +:8] | ({8{s31[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s33[20]}}) | {8{s28[20]}});
        assign result1[21 * 8 +:8] = s36[85 * 8 +:8] | s35[85 * 8 +:8] | ({8{s31[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s33[21]}}) | {8{s28[21]}});
        assign result1[22 * 8 +:8] = s36[86 * 8 +:8] | s35[86 * 8 +:8] | ({8{s31[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s33[22]}}) | {8{s28[22]}});
        assign result1[23 * 8 +:8] = s36[87 * 8 +:8] | s35[87 * 8 +:8] | ({8{s31[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s33[23]}}) | {8{s28[23]}});
        assign result1[24 * 8 +:8] = s36[88 * 8 +:8] | s35[88 * 8 +:8] | ({8{s31[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s33[24]}}) | {8{s28[24]}});
        assign result1[25 * 8 +:8] = s36[89 * 8 +:8] | s35[89 * 8 +:8] | ({8{s31[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s33[25]}}) | {8{s28[25]}});
        assign result1[26 * 8 +:8] = s36[90 * 8 +:8] | s35[90 * 8 +:8] | ({8{s31[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s33[26]}}) | {8{s28[26]}});
        assign result1[27 * 8 +:8] = s36[91 * 8 +:8] | s35[91 * 8 +:8] | ({8{s31[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s33[27]}}) | {8{s28[27]}});
        assign result1[28 * 8 +:8] = s36[92 * 8 +:8] | s35[92 * 8 +:8] | ({8{s31[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s33[28]}}) | {8{s28[28]}});
        assign result1[29 * 8 +:8] = s36[93 * 8 +:8] | s35[93 * 8 +:8] | ({8{s31[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s33[29]}}) | {8{s28[29]}});
        assign result1[30 * 8 +:8] = s36[94 * 8 +:8] | s35[94 * 8 +:8] | ({8{s31[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s33[30]}}) | {8{s28[30]}});
        assign result1[31 * 8 +:8] = s36[95 * 8 +:8] | s35[95 * 8 +:8] | ({8{s31[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s33[31]}}) | {8{s28[31]}});
        assign result1[32 * 8 +:8] = s36[96 * 8 +:8] | s35[96 * 8 +:8] | ({8{s31[32]}} & s34[32 * 8 +:8]) | ((s0[32 * 8 +:8] & {8{s33[32]}}) | {8{s28[32]}});
        assign result1[33 * 8 +:8] = s36[97 * 8 +:8] | s35[97 * 8 +:8] | ({8{s31[33]}} & s34[33 * 8 +:8]) | ((s0[33 * 8 +:8] & {8{s33[33]}}) | {8{s28[33]}});
        assign result1[34 * 8 +:8] = s36[98 * 8 +:8] | s35[98 * 8 +:8] | ({8{s31[34]}} & s34[34 * 8 +:8]) | ((s0[34 * 8 +:8] & {8{s33[34]}}) | {8{s28[34]}});
        assign result1[35 * 8 +:8] = s36[99 * 8 +:8] | s35[99 * 8 +:8] | ({8{s31[35]}} & s34[35 * 8 +:8]) | ((s0[35 * 8 +:8] & {8{s33[35]}}) | {8{s28[35]}});
        assign result1[36 * 8 +:8] = s36[100 * 8 +:8] | s35[100 * 8 +:8] | ({8{s31[36]}} & s34[36 * 8 +:8]) | ((s0[36 * 8 +:8] & {8{s33[36]}}) | {8{s28[36]}});
        assign result1[37 * 8 +:8] = s36[101 * 8 +:8] | s35[101 * 8 +:8] | ({8{s31[37]}} & s34[37 * 8 +:8]) | ((s0[37 * 8 +:8] & {8{s33[37]}}) | {8{s28[37]}});
        assign result1[38 * 8 +:8] = s36[102 * 8 +:8] | s35[102 * 8 +:8] | ({8{s31[38]}} & s34[38 * 8 +:8]) | ((s0[38 * 8 +:8] & {8{s33[38]}}) | {8{s28[38]}});
        assign result1[39 * 8 +:8] = s36[103 * 8 +:8] | s35[103 * 8 +:8] | ({8{s31[39]}} & s34[39 * 8 +:8]) | ((s0[39 * 8 +:8] & {8{s33[39]}}) | {8{s28[39]}});
        assign result1[40 * 8 +:8] = s36[104 * 8 +:8] | s35[104 * 8 +:8] | ({8{s31[40]}} & s34[40 * 8 +:8]) | ((s0[40 * 8 +:8] & {8{s33[40]}}) | {8{s28[40]}});
        assign result1[41 * 8 +:8] = s36[105 * 8 +:8] | s35[105 * 8 +:8] | ({8{s31[41]}} & s34[41 * 8 +:8]) | ((s0[41 * 8 +:8] & {8{s33[41]}}) | {8{s28[41]}});
        assign result1[42 * 8 +:8] = s36[106 * 8 +:8] | s35[106 * 8 +:8] | ({8{s31[42]}} & s34[42 * 8 +:8]) | ((s0[42 * 8 +:8] & {8{s33[42]}}) | {8{s28[42]}});
        assign result1[43 * 8 +:8] = s36[107 * 8 +:8] | s35[107 * 8 +:8] | ({8{s31[43]}} & s34[43 * 8 +:8]) | ((s0[43 * 8 +:8] & {8{s33[43]}}) | {8{s28[43]}});
        assign result1[44 * 8 +:8] = s36[108 * 8 +:8] | s35[108 * 8 +:8] | ({8{s31[44]}} & s34[44 * 8 +:8]) | ((s0[44 * 8 +:8] & {8{s33[44]}}) | {8{s28[44]}});
        assign result1[45 * 8 +:8] = s36[109 * 8 +:8] | s35[109 * 8 +:8] | ({8{s31[45]}} & s34[45 * 8 +:8]) | ((s0[45 * 8 +:8] & {8{s33[45]}}) | {8{s28[45]}});
        assign result1[46 * 8 +:8] = s36[110 * 8 +:8] | s35[110 * 8 +:8] | ({8{s31[46]}} & s34[46 * 8 +:8]) | ((s0[46 * 8 +:8] & {8{s33[46]}}) | {8{s28[46]}});
        assign result1[47 * 8 +:8] = s36[111 * 8 +:8] | s35[111 * 8 +:8] | ({8{s31[47]}} & s34[47 * 8 +:8]) | ((s0[47 * 8 +:8] & {8{s33[47]}}) | {8{s28[47]}});
        assign result1[48 * 8 +:8] = s36[112 * 8 +:8] | s35[112 * 8 +:8] | ({8{s31[48]}} & s34[48 * 8 +:8]) | ((s0[48 * 8 +:8] & {8{s33[48]}}) | {8{s28[48]}});
        assign result1[49 * 8 +:8] = s36[113 * 8 +:8] | s35[113 * 8 +:8] | ({8{s31[49]}} & s34[49 * 8 +:8]) | ((s0[49 * 8 +:8] & {8{s33[49]}}) | {8{s28[49]}});
        assign result1[50 * 8 +:8] = s36[114 * 8 +:8] | s35[114 * 8 +:8] | ({8{s31[50]}} & s34[50 * 8 +:8]) | ((s0[50 * 8 +:8] & {8{s33[50]}}) | {8{s28[50]}});
        assign result1[51 * 8 +:8] = s36[115 * 8 +:8] | s35[115 * 8 +:8] | ({8{s31[51]}} & s34[51 * 8 +:8]) | ((s0[51 * 8 +:8] & {8{s33[51]}}) | {8{s28[51]}});
        assign result1[52 * 8 +:8] = s36[116 * 8 +:8] | s35[116 * 8 +:8] | ({8{s31[52]}} & s34[52 * 8 +:8]) | ((s0[52 * 8 +:8] & {8{s33[52]}}) | {8{s28[52]}});
        assign result1[53 * 8 +:8] = s36[117 * 8 +:8] | s35[117 * 8 +:8] | ({8{s31[53]}} & s34[53 * 8 +:8]) | ((s0[53 * 8 +:8] & {8{s33[53]}}) | {8{s28[53]}});
        assign result1[54 * 8 +:8] = s36[118 * 8 +:8] | s35[118 * 8 +:8] | ({8{s31[54]}} & s34[54 * 8 +:8]) | ((s0[54 * 8 +:8] & {8{s33[54]}}) | {8{s28[54]}});
        assign result1[55 * 8 +:8] = s36[119 * 8 +:8] | s35[119 * 8 +:8] | ({8{s31[55]}} & s34[55 * 8 +:8]) | ((s0[55 * 8 +:8] & {8{s33[55]}}) | {8{s28[55]}});
        assign result1[56 * 8 +:8] = s36[120 * 8 +:8] | s35[120 * 8 +:8] | ({8{s31[56]}} & s34[56 * 8 +:8]) | ((s0[56 * 8 +:8] & {8{s33[56]}}) | {8{s28[56]}});
        assign result1[57 * 8 +:8] = s36[121 * 8 +:8] | s35[121 * 8 +:8] | ({8{s31[57]}} & s34[57 * 8 +:8]) | ((s0[57 * 8 +:8] & {8{s33[57]}}) | {8{s28[57]}});
        assign result1[58 * 8 +:8] = s36[122 * 8 +:8] | s35[122 * 8 +:8] | ({8{s31[58]}} & s34[58 * 8 +:8]) | ((s0[58 * 8 +:8] & {8{s33[58]}}) | {8{s28[58]}});
        assign result1[59 * 8 +:8] = s36[123 * 8 +:8] | s35[123 * 8 +:8] | ({8{s31[59]}} & s34[59 * 8 +:8]) | ((s0[59 * 8 +:8] & {8{s33[59]}}) | {8{s28[59]}});
        assign result1[60 * 8 +:8] = s36[124 * 8 +:8] | s35[124 * 8 +:8] | ({8{s31[60]}} & s34[60 * 8 +:8]) | ((s0[60 * 8 +:8] & {8{s33[60]}}) | {8{s28[60]}});
        assign result1[61 * 8 +:8] = s36[125 * 8 +:8] | s35[125 * 8 +:8] | ({8{s31[61]}} & s34[61 * 8 +:8]) | ((s0[61 * 8 +:8] & {8{s33[61]}}) | {8{s28[61]}});
        assign result1[62 * 8 +:8] = s36[126 * 8 +:8] | s35[126 * 8 +:8] | ({8{s31[62]}} & s34[62 * 8 +:8]) | ((s0[62 * 8 +:8] & {8{s33[62]}}) | {8{s28[62]}});
        assign result1[63 * 8 +:8] = s36[127 * 8 +:8] | s35[127 * 8 +:8] | ({8{s31[63]}} & s34[63 * 8 +:8]) | ((s0[63 * 8 +:8] & {8{s33[63]}}) | {8{s28[63]}});
    end
endgenerate
generate
    if ((VLEN == 1024) && (DLEN == 1024) & (VP_LEN == 512)) begin:gen_vlen1024_dlen1024_vplen512
        assign s16[0] = 1'b0;
        assign s16[1] = 1'b0;
        assign s16[2] = 1'b0;
        assign s16[3] = 1'b0;
        assign s16[4] = 1'b0;
        assign s16[5] = 1'b0;
        assign s16[6] = 1'b0;
        assign s16[7] = 1'b0;
        assign s16[8] = 1'b0;
        assign s16[9] = 1'b0;
        assign s16[10] = 1'b0;
        assign s16[11] = 1'b0;
        assign s16[12] = 1'b0;
        assign s16[13] = 1'b0;
        assign s16[14] = 1'b0;
        assign s16[15] = 1'b0;
        assign s16[16] = 1'b0;
        assign s16[17] = 1'b0;
        assign s16[18] = 1'b0;
        assign s16[19] = 1'b0;
        assign s16[20] = 1'b0;
        assign s16[21] = 1'b0;
        assign s16[22] = 1'b0;
        assign s16[23] = 1'b0;
        assign s16[24] = 1'b0;
        assign s16[25] = 1'b0;
        assign s16[26] = 1'b0;
        assign s16[27] = 1'b0;
        assign s16[28] = 1'b0;
        assign s16[29] = 1'b0;
        assign s16[30] = 1'b0;
        assign s16[31] = 1'b0;
        assign s16[32] = 1'b0;
        assign s16[33] = 1'b0;
        assign s16[34] = 1'b0;
        assign s16[35] = 1'b0;
        assign s16[36] = 1'b0;
        assign s16[37] = 1'b0;
        assign s16[38] = 1'b0;
        assign s16[39] = 1'b0;
        assign s16[40] = 1'b0;
        assign s16[41] = 1'b0;
        assign s16[42] = 1'b0;
        assign s16[43] = 1'b0;
        assign s16[44] = 1'b0;
        assign s16[45] = 1'b0;
        assign s16[46] = 1'b0;
        assign s16[47] = 1'b0;
        assign s16[48] = 1'b0;
        assign s16[49] = 1'b0;
        assign s16[50] = 1'b0;
        assign s16[51] = 1'b0;
        assign s16[52] = 1'b0;
        assign s16[53] = 1'b0;
        assign s16[54] = 1'b0;
        assign s16[55] = 1'b0;
        assign s16[56] = 1'b0;
        assign s16[57] = 1'b0;
        assign s16[58] = 1'b0;
        assign s16[59] = 1'b0;
        assign s16[60] = 1'b0;
        assign s16[61] = 1'b0;
        assign s16[62] = 1'b0;
        assign s16[63] = 1'b0;
        assign s17[0] = 1'b0;
        assign s17[1] = 1'b0;
        assign s17[2] = 1'b0;
        assign s17[3] = 1'b0;
        assign s17[4] = 1'b0;
        assign s17[5] = 1'b0;
        assign s17[6] = 1'b0;
        assign s17[7] = 1'b0;
        assign s17[8] = 1'b0;
        assign s17[9] = 1'b0;
        assign s17[10] = 1'b0;
        assign s17[11] = 1'b0;
        assign s17[12] = 1'b0;
        assign s17[13] = 1'b0;
        assign s17[14] = 1'b0;
        assign s17[15] = 1'b0;
        assign s17[16] = 1'b0;
        assign s17[17] = 1'b0;
        assign s17[18] = 1'b0;
        assign s17[19] = 1'b0;
        assign s17[20] = 1'b0;
        assign s17[21] = 1'b0;
        assign s17[22] = 1'b0;
        assign s17[23] = 1'b0;
        assign s17[24] = 1'b0;
        assign s17[25] = 1'b0;
        assign s17[26] = 1'b0;
        assign s17[27] = 1'b0;
        assign s17[28] = 1'b0;
        assign s17[29] = 1'b0;
        assign s17[30] = 1'b0;
        assign s17[31] = 1'b0;
        assign s17[32] = 1'b0;
        assign s17[33] = 1'b0;
        assign s17[34] = 1'b0;
        assign s17[35] = 1'b0;
        assign s17[36] = 1'b0;
        assign s17[37] = 1'b0;
        assign s17[38] = 1'b0;
        assign s17[39] = 1'b0;
        assign s17[40] = 1'b0;
        assign s17[41] = 1'b0;
        assign s17[42] = 1'b0;
        assign s17[43] = 1'b0;
        assign s17[44] = 1'b0;
        assign s17[45] = 1'b0;
        assign s17[46] = 1'b0;
        assign s17[47] = 1'b0;
        assign s17[48] = 1'b0;
        assign s17[49] = 1'b0;
        assign s17[50] = 1'b0;
        assign s17[51] = 1'b0;
        assign s17[52] = 1'b0;
        assign s17[53] = 1'b0;
        assign s17[54] = 1'b0;
        assign s17[55] = 1'b0;
        assign s17[56] = 1'b0;
        assign s17[57] = 1'b0;
        assign s17[58] = 1'b0;
        assign s17[59] = 1'b0;
        assign s17[60] = 1'b0;
        assign s17[61] = 1'b0;
        assign s17[62] = 1'b0;
        assign s17[63] = 1'b0;
        assign s22[0] = 1'b0;
        assign s18[0] = 1'b0;
        assign s22[1] = s0[15];
        assign s18[1] = 1'b0;
        assign s22[2] = s0[23];
        assign s18[2] = 1'b0;
        assign s22[3] = s0[31];
        assign s18[3] = 1'b0;
        assign s22[4] = s0[39];
        assign s18[4] = 1'b0;
        assign s22[5] = s0[47];
        assign s18[5] = 1'b0;
        assign s22[6] = s0[55];
        assign s18[6] = 1'b0;
        assign s22[7] = s0[63];
        assign s18[7] = 1'b0;
        assign s22[8] = 1'b0;
        assign s18[8] = 1'b0;
        assign s22[9] = s0[79];
        assign s18[9] = 1'b0;
        assign s22[10] = s0[87];
        assign s18[10] = 1'b0;
        assign s22[11] = s0[95];
        assign s18[11] = 1'b0;
        assign s22[12] = s0[103];
        assign s18[12] = 1'b0;
        assign s22[13] = s0[111];
        assign s18[13] = 1'b0;
        assign s22[14] = s0[119];
        assign s18[14] = 1'b0;
        assign s22[15] = s0[127];
        assign s18[15] = 1'b0;
        assign s22[16] = 1'b0;
        assign s18[16] = 1'b0;
        assign s22[17] = s0[143];
        assign s18[17] = 1'b0;
        assign s22[18] = s0[151];
        assign s18[18] = 1'b0;
        assign s22[19] = s0[159];
        assign s18[19] = 1'b0;
        assign s22[20] = s0[167];
        assign s18[20] = 1'b0;
        assign s22[21] = s0[175];
        assign s18[21] = 1'b0;
        assign s22[22] = s0[183];
        assign s18[22] = 1'b0;
        assign s22[23] = s0[191];
        assign s18[23] = 1'b0;
        assign s22[24] = 1'b0;
        assign s18[24] = 1'b0;
        assign s22[25] = s0[207];
        assign s18[25] = 1'b0;
        assign s22[26] = s0[215];
        assign s18[26] = 1'b0;
        assign s22[27] = s0[223];
        assign s18[27] = 1'b0;
        assign s22[28] = s0[231];
        assign s18[28] = 1'b0;
        assign s22[29] = s0[239];
        assign s18[29] = 1'b0;
        assign s22[30] = s0[247];
        assign s18[30] = 1'b0;
        assign s22[31] = s0[255];
        assign s18[31] = 1'b0;
        assign s22[32] = 1'b0;
        assign s18[32] = 1'b0;
        assign s22[33] = s0[271];
        assign s18[33] = 1'b0;
        assign s22[34] = s0[279];
        assign s18[34] = 1'b0;
        assign s22[35] = s0[287];
        assign s18[35] = 1'b0;
        assign s22[36] = s0[295];
        assign s18[36] = 1'b0;
        assign s22[37] = s0[303];
        assign s18[37] = 1'b0;
        assign s22[38] = s0[311];
        assign s18[38] = 1'b0;
        assign s22[39] = s0[319];
        assign s18[39] = 1'b0;
        assign s22[40] = 1'b0;
        assign s18[40] = 1'b0;
        assign s22[41] = s0[335];
        assign s18[41] = 1'b0;
        assign s22[42] = s0[343];
        assign s18[42] = 1'b0;
        assign s22[43] = s0[351];
        assign s18[43] = 1'b0;
        assign s22[44] = s0[359];
        assign s18[44] = 1'b0;
        assign s22[45] = s0[367];
        assign s18[45] = 1'b0;
        assign s22[46] = s0[375];
        assign s18[46] = 1'b0;
        assign s22[47] = s0[383];
        assign s18[47] = 1'b0;
        assign s22[48] = 1'b0;
        assign s18[48] = 1'b0;
        assign s22[49] = s0[399];
        assign s18[49] = 1'b0;
        assign s22[50] = s0[407];
        assign s18[50] = 1'b0;
        assign s22[51] = s0[415];
        assign s18[51] = 1'b0;
        assign s22[52] = s0[423];
        assign s18[52] = 1'b0;
        assign s22[53] = s0[431];
        assign s18[53] = 1'b0;
        assign s22[54] = s0[439];
        assign s18[54] = 1'b0;
        assign s22[55] = s0[447];
        assign s18[55] = 1'b0;
        assign s22[56] = 1'b0;
        assign s18[56] = 1'b0;
        assign s22[57] = s0[463];
        assign s18[57] = 1'b0;
        assign s22[58] = s0[471];
        assign s18[58] = 1'b0;
        assign s22[59] = s0[479];
        assign s18[59] = 1'b0;
        assign s22[60] = s0[487];
        assign s18[60] = 1'b0;
        assign s22[61] = s0[495];
        assign s18[61] = 1'b0;
        assign s22[62] = s0[503];
        assign s18[62] = 1'b0;
        assign s22[63] = s0[511];
        assign s18[63] = 1'b0;
        assign s25[0 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[1 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[2 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[3 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[4 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[5 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[6 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[7 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s19[0] = 1'b0;
        assign s19[1] = 1'b0;
        assign s19[2] = 1'b0;
        assign s19[3] = 1'b0;
        assign s19[4] = 1'b0;
        assign s19[5] = 1'b0;
        assign s19[6] = 1'b0;
        assign s19[7] = 1'b0;
        assign s19[8] = 1'b0;
        assign s19[9] = 1'b0;
        assign s19[10] = 1'b0;
        assign s19[11] = 1'b0;
        assign s19[12] = 1'b0;
        assign s19[13] = 1'b0;
        assign s19[14] = 1'b0;
        assign s19[15] = 1'b0;
        assign s19[16] = 1'b0;
        assign s19[17] = 1'b0;
        assign s19[18] = 1'b0;
        assign s19[19] = 1'b0;
        assign s19[20] = 1'b0;
        assign s19[21] = 1'b0;
        assign s19[22] = 1'b0;
        assign s19[23] = 1'b0;
        assign s19[24] = 1'b0;
        assign s19[25] = 1'b0;
        assign s19[26] = 1'b0;
        assign s19[27] = 1'b0;
        assign s19[28] = 1'b0;
        assign s19[29] = 1'b0;
        assign s19[30] = 1'b0;
        assign s19[31] = 1'b0;
        assign s19[32] = 1'b0;
        assign s19[33] = 1'b0;
        assign s19[34] = 1'b0;
        assign s19[35] = 1'b0;
        assign s19[36] = 1'b0;
        assign s19[37] = 1'b0;
        assign s19[38] = 1'b0;
        assign s19[39] = 1'b0;
        assign s19[40] = 1'b0;
        assign s19[41] = 1'b0;
        assign s19[42] = 1'b0;
        assign s19[43] = 1'b0;
        assign s19[44] = 1'b0;
        assign s19[45] = 1'b0;
        assign s19[46] = 1'b0;
        assign s19[47] = 1'b0;
        assign s19[48] = 1'b0;
        assign s19[49] = 1'b0;
        assign s19[50] = 1'b0;
        assign s19[51] = 1'b0;
        assign s19[52] = 1'b0;
        assign s19[53] = 1'b0;
        assign s19[54] = 1'b0;
        assign s19[55] = 1'b0;
        assign s19[56] = 1'b0;
        assign s19[57] = 1'b0;
        assign s19[58] = 1'b0;
        assign s19[59] = 1'b0;
        assign s19[60] = 1'b0;
        assign s19[61] = 1'b0;
        assign s19[62] = 1'b0;
        assign s19[63] = 1'b0;
        assign s23[0] = 1'b0;
        assign s20[0] = 1'b0;
        assign s23[1] = 1'b0;
        assign s20[1] = 1'b0;
        assign s23[2] = s0[23];
        assign s20[2] = 1'b0;
        assign s23[3] = s0[31];
        assign s20[3] = 1'b0;
        assign s23[4] = s0[39];
        assign s20[4] = 1'b0;
        assign s23[5] = s0[47];
        assign s20[5] = 1'b0;
        assign s23[6] = s0[55];
        assign s20[6] = 1'b0;
        assign s23[7] = s0[63];
        assign s20[7] = 1'b0;
        assign s23[8] = 1'b0;
        assign s20[8] = 1'b0;
        assign s23[9] = 1'b0;
        assign s20[9] = 1'b0;
        assign s23[10] = s0[87];
        assign s20[10] = 1'b0;
        assign s23[11] = s0[95];
        assign s20[11] = 1'b0;
        assign s23[12] = s0[103];
        assign s20[12] = 1'b0;
        assign s23[13] = s0[111];
        assign s20[13] = 1'b0;
        assign s23[14] = s0[119];
        assign s20[14] = 1'b0;
        assign s23[15] = s0[127];
        assign s20[15] = 1'b0;
        assign s23[16] = 1'b0;
        assign s20[16] = 1'b0;
        assign s23[17] = 1'b0;
        assign s20[17] = 1'b0;
        assign s23[18] = s0[151];
        assign s20[18] = 1'b0;
        assign s23[19] = s0[159];
        assign s20[19] = 1'b0;
        assign s23[20] = s0[167];
        assign s20[20] = 1'b0;
        assign s23[21] = s0[175];
        assign s20[21] = 1'b0;
        assign s23[22] = s0[183];
        assign s20[22] = 1'b0;
        assign s23[23] = s0[191];
        assign s20[23] = 1'b0;
        assign s23[24] = 1'b0;
        assign s20[24] = 1'b0;
        assign s23[25] = 1'b0;
        assign s20[25] = 1'b0;
        assign s23[26] = s0[215];
        assign s20[26] = 1'b0;
        assign s23[27] = s0[223];
        assign s20[27] = 1'b0;
        assign s23[28] = s0[231];
        assign s20[28] = 1'b0;
        assign s23[29] = s0[239];
        assign s20[29] = 1'b0;
        assign s23[30] = s0[247];
        assign s20[30] = 1'b0;
        assign s23[31] = s0[255];
        assign s20[31] = 1'b0;
        assign s23[32] = 1'b0;
        assign s20[32] = 1'b0;
        assign s23[33] = 1'b0;
        assign s20[33] = 1'b0;
        assign s23[34] = s0[279];
        assign s20[34] = 1'b0;
        assign s23[35] = s0[287];
        assign s20[35] = 1'b0;
        assign s23[36] = s0[295];
        assign s20[36] = 1'b0;
        assign s23[37] = s0[303];
        assign s20[37] = 1'b0;
        assign s23[38] = s0[311];
        assign s20[38] = 1'b0;
        assign s23[39] = s0[319];
        assign s20[39] = 1'b0;
        assign s23[40] = 1'b0;
        assign s20[40] = 1'b0;
        assign s23[41] = 1'b0;
        assign s20[41] = 1'b0;
        assign s23[42] = s0[343];
        assign s20[42] = 1'b0;
        assign s23[43] = s0[351];
        assign s20[43] = 1'b0;
        assign s23[44] = s0[359];
        assign s20[44] = 1'b0;
        assign s23[45] = s0[367];
        assign s20[45] = 1'b0;
        assign s23[46] = s0[375];
        assign s20[46] = 1'b0;
        assign s23[47] = s0[383];
        assign s20[47] = 1'b0;
        assign s23[48] = 1'b0;
        assign s20[48] = 1'b0;
        assign s23[49] = 1'b0;
        assign s20[49] = 1'b0;
        assign s23[50] = s0[407];
        assign s20[50] = 1'b0;
        assign s23[51] = s0[415];
        assign s20[51] = 1'b0;
        assign s23[52] = s0[423];
        assign s20[52] = 1'b0;
        assign s23[53] = s0[431];
        assign s20[53] = 1'b0;
        assign s23[54] = s0[439];
        assign s20[54] = 1'b0;
        assign s23[55] = s0[447];
        assign s20[55] = 1'b0;
        assign s23[56] = 1'b0;
        assign s20[56] = 1'b0;
        assign s23[57] = 1'b0;
        assign s20[57] = 1'b0;
        assign s23[58] = s0[471];
        assign s20[58] = 1'b0;
        assign s23[59] = s0[479];
        assign s20[59] = 1'b0;
        assign s23[60] = s0[487];
        assign s20[60] = 1'b0;
        assign s23[61] = s0[495];
        assign s20[61] = 1'b0;
        assign s23[62] = s0[503];
        assign s20[62] = 1'b0;
        assign s23[63] = s0[511];
        assign s20[63] = 1'b0;
        assign s26[0 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[1 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[2 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[3 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[4 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[5 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[6 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[7 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s24[0] = 1'b0;
        assign s21[0] = 1'b0;
        assign s24[1] = 1'b0;
        assign s21[1] = 1'b0;
        assign s24[2] = 1'b0;
        assign s21[2] = 1'b0;
        assign s24[3] = 1'b0;
        assign s21[3] = 1'b0;
        assign s24[4] = s0[39];
        assign s21[4] = 1'b0;
        assign s24[5] = s0[47];
        assign s21[5] = 1'b0;
        assign s24[6] = s0[55];
        assign s21[6] = 1'b0;
        assign s24[7] = s0[63];
        assign s21[7] = 1'b0;
        assign s24[8] = 1'b0;
        assign s21[8] = 1'b0;
        assign s24[9] = 1'b0;
        assign s21[9] = 1'b0;
        assign s24[10] = 1'b0;
        assign s21[10] = 1'b0;
        assign s24[11] = 1'b0;
        assign s21[11] = 1'b0;
        assign s24[12] = s0[103];
        assign s21[12] = 1'b0;
        assign s24[13] = s0[111];
        assign s21[13] = 1'b0;
        assign s24[14] = s0[119];
        assign s21[14] = 1'b0;
        assign s24[15] = s0[127];
        assign s21[15] = 1'b0;
        assign s24[16] = 1'b0;
        assign s21[16] = 1'b0;
        assign s24[17] = 1'b0;
        assign s21[17] = 1'b0;
        assign s24[18] = 1'b0;
        assign s21[18] = 1'b0;
        assign s24[19] = 1'b0;
        assign s21[19] = 1'b0;
        assign s24[20] = s0[167];
        assign s21[20] = 1'b0;
        assign s24[21] = s0[175];
        assign s21[21] = 1'b0;
        assign s24[22] = s0[183];
        assign s21[22] = 1'b0;
        assign s24[23] = s0[191];
        assign s21[23] = 1'b0;
        assign s24[24] = 1'b0;
        assign s21[24] = 1'b0;
        assign s24[25] = 1'b0;
        assign s21[25] = 1'b0;
        assign s24[26] = 1'b0;
        assign s21[26] = 1'b0;
        assign s24[27] = 1'b0;
        assign s21[27] = 1'b0;
        assign s24[28] = s0[231];
        assign s21[28] = 1'b0;
        assign s24[29] = s0[239];
        assign s21[29] = 1'b0;
        assign s24[30] = s0[247];
        assign s21[30] = 1'b0;
        assign s24[31] = s0[255];
        assign s21[31] = 1'b0;
        assign s24[32] = 1'b0;
        assign s21[32] = 1'b0;
        assign s24[33] = 1'b0;
        assign s21[33] = 1'b0;
        assign s24[34] = 1'b0;
        assign s21[34] = 1'b0;
        assign s24[35] = 1'b0;
        assign s21[35] = 1'b0;
        assign s24[36] = s0[295];
        assign s21[36] = 1'b0;
        assign s24[37] = s0[303];
        assign s21[37] = 1'b0;
        assign s24[38] = s0[311];
        assign s21[38] = 1'b0;
        assign s24[39] = s0[319];
        assign s21[39] = 1'b0;
        assign s24[40] = 1'b0;
        assign s21[40] = 1'b0;
        assign s24[41] = 1'b0;
        assign s21[41] = 1'b0;
        assign s24[42] = 1'b0;
        assign s21[42] = 1'b0;
        assign s24[43] = 1'b0;
        assign s21[43] = 1'b0;
        assign s24[44] = s0[359];
        assign s21[44] = 1'b0;
        assign s24[45] = s0[367];
        assign s21[45] = 1'b0;
        assign s24[46] = s0[375];
        assign s21[46] = 1'b0;
        assign s24[47] = s0[383];
        assign s21[47] = 1'b0;
        assign s24[48] = 1'b0;
        assign s21[48] = 1'b0;
        assign s24[49] = 1'b0;
        assign s21[49] = 1'b0;
        assign s24[50] = 1'b0;
        assign s21[50] = 1'b0;
        assign s24[51] = 1'b0;
        assign s21[51] = 1'b0;
        assign s24[52] = s0[423];
        assign s21[52] = 1'b0;
        assign s24[53] = s0[431];
        assign s21[53] = 1'b0;
        assign s24[54] = s0[439];
        assign s21[54] = 1'b0;
        assign s24[55] = s0[447];
        assign s21[55] = 1'b0;
        assign s24[56] = 1'b0;
        assign s21[56] = 1'b0;
        assign s24[57] = 1'b0;
        assign s21[57] = 1'b0;
        assign s24[58] = 1'b0;
        assign s21[58] = 1'b0;
        assign s24[59] = 1'b0;
        assign s21[59] = 1'b0;
        assign s24[60] = s0[487];
        assign s21[60] = 1'b0;
        assign s24[61] = s0[495];
        assign s21[61] = 1'b0;
        assign s24[62] = s0[503];
        assign s21[62] = 1'b0;
        assign s24[63] = s0[511];
        assign s21[63] = 1'b0;
        assign s27[0 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[1 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[2 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[3 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[4 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[5 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[6 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[7 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        kv_mux128 #(
            .W(8)
        ) u_mux0 (
            .out(s0[0 * 8 +:8]),
            .sel(idx[0 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux1 (
            .out(s0[1 * 8 +:8]),
            .sel(idx[1 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux2 (
            .out(s0[2 * 8 +:8]),
            .sel(idx[2 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux3 (
            .out(s0[3 * 8 +:8]),
            .sel(idx[3 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux4 (
            .out(s0[4 * 8 +:8]),
            .sel(idx[4 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux5 (
            .out(s0[5 * 8 +:8]),
            .sel(idx[5 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux6 (
            .out(s0[6 * 8 +:8]),
            .sel(idx[6 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux7 (
            .out(s0[7 * 8 +:8]),
            .sel(idx[7 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux8 (
            .out(s0[8 * 8 +:8]),
            .sel(idx[8 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux9 (
            .out(s0[9 * 8 +:8]),
            .sel(idx[9 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux10 (
            .out(s0[10 * 8 +:8]),
            .sel(idx[10 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux11 (
            .out(s0[11 * 8 +:8]),
            .sel(idx[11 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux12 (
            .out(s0[12 * 8 +:8]),
            .sel(idx[12 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux13 (
            .out(s0[13 * 8 +:8]),
            .sel(idx[13 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux14 (
            .out(s0[14 * 8 +:8]),
            .sel(idx[14 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux15 (
            .out(s0[15 * 8 +:8]),
            .sel(idx[15 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux16 (
            .out(s0[16 * 8 +:8]),
            .sel(idx[16 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux17 (
            .out(s0[17 * 8 +:8]),
            .sel(idx[17 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux18 (
            .out(s0[18 * 8 +:8]),
            .sel(idx[18 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux19 (
            .out(s0[19 * 8 +:8]),
            .sel(idx[19 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux20 (
            .out(s0[20 * 8 +:8]),
            .sel(idx[20 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux21 (
            .out(s0[21 * 8 +:8]),
            .sel(idx[21 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux22 (
            .out(s0[22 * 8 +:8]),
            .sel(idx[22 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux23 (
            .out(s0[23 * 8 +:8]),
            .sel(idx[23 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux24 (
            .out(s0[24 * 8 +:8]),
            .sel(idx[24 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux25 (
            .out(s0[25 * 8 +:8]),
            .sel(idx[25 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux26 (
            .out(s0[26 * 8 +:8]),
            .sel(idx[26 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux27 (
            .out(s0[27 * 8 +:8]),
            .sel(idx[27 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux28 (
            .out(s0[28 * 8 +:8]),
            .sel(idx[28 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux29 (
            .out(s0[29 * 8 +:8]),
            .sel(idx[29 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux30 (
            .out(s0[30 * 8 +:8]),
            .sel(idx[30 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux31 (
            .out(s0[31 * 8 +:8]),
            .sel(idx[31 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux32 (
            .out(s0[32 * 8 +:8]),
            .sel(idx[32 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux33 (
            .out(s0[33 * 8 +:8]),
            .sel(idx[33 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux34 (
            .out(s0[34 * 8 +:8]),
            .sel(idx[34 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux35 (
            .out(s0[35 * 8 +:8]),
            .sel(idx[35 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux36 (
            .out(s0[36 * 8 +:8]),
            .sel(idx[36 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux37 (
            .out(s0[37 * 8 +:8]),
            .sel(idx[37 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux38 (
            .out(s0[38 * 8 +:8]),
            .sel(idx[38 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux39 (
            .out(s0[39 * 8 +:8]),
            .sel(idx[39 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux40 (
            .out(s0[40 * 8 +:8]),
            .sel(idx[40 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux41 (
            .out(s0[41 * 8 +:8]),
            .sel(idx[41 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux42 (
            .out(s0[42 * 8 +:8]),
            .sel(idx[42 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux43 (
            .out(s0[43 * 8 +:8]),
            .sel(idx[43 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux44 (
            .out(s0[44 * 8 +:8]),
            .sel(idx[44 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux45 (
            .out(s0[45 * 8 +:8]),
            .sel(idx[45 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux46 (
            .out(s0[46 * 8 +:8]),
            .sel(idx[46 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux47 (
            .out(s0[47 * 8 +:8]),
            .sel(idx[47 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux48 (
            .out(s0[48 * 8 +:8]),
            .sel(idx[48 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux49 (
            .out(s0[49 * 8 +:8]),
            .sel(idx[49 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux50 (
            .out(s0[50 * 8 +:8]),
            .sel(idx[50 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux51 (
            .out(s0[51 * 8 +:8]),
            .sel(idx[51 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux52 (
            .out(s0[52 * 8 +:8]),
            .sel(idx[52 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux53 (
            .out(s0[53 * 8 +:8]),
            .sel(idx[53 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux54 (
            .out(s0[54 * 8 +:8]),
            .sel(idx[54 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux55 (
            .out(s0[55 * 8 +:8]),
            .sel(idx[55 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux56 (
            .out(s0[56 * 8 +:8]),
            .sel(idx[56 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux57 (
            .out(s0[57 * 8 +:8]),
            .sel(idx[57 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux58 (
            .out(s0[58 * 8 +:8]),
            .sel(idx[58 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux59 (
            .out(s0[59 * 8 +:8]),
            .sel(idx[59 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux60 (
            .out(s0[60 * 8 +:8]),
            .sel(idx[60 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux61 (
            .out(s0[61 * 8 +:8]),
            .sel(idx[61 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux62 (
            .out(s0[62 * 8 +:8]),
            .sel(idx[62 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux63 (
            .out(s0[63 * 8 +:8]),
            .sel(idx[63 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        assign s13[0 +:8] = {{4{s0[3] & s4}},s0[0 +:4] & {4{s1}}};
        assign s13[8 +:8] = {{4{s0[7] & s4}},s0[4 +:4] & {4{s1}}};
        assign s13[16 +:8] = {{4{s0[11] & s4}},s0[8 +:4] & {4{s1}}};
        assign s13[24 +:8] = {{4{s0[15] & s4}},s0[12 +:4] & {4{s1}}};
        assign s13[32 +:8] = {{4{s0[19] & s4}},s0[16 +:4] & {4{s1}}};
        assign s13[40 +:8] = {{4{s0[23] & s4}},s0[20 +:4] & {4{s1}}};
        assign s13[48 +:8] = {{4{s0[27] & s4}},s0[24 +:4] & {4{s1}}};
        assign s13[56 +:8] = {{4{s0[31] & s4}},s0[28 +:4] & {4{s1}}};
        assign s13[64 +:8] = {{4{s0[35] & s4}},s0[32 +:4] & {4{s1}}};
        assign s13[72 +:8] = {{4{s0[39] & s4}},s0[36 +:4] & {4{s1}}};
        assign s13[80 +:8] = {{4{s0[43] & s4}},s0[40 +:4] & {4{s1}}};
        assign s13[88 +:8] = {{4{s0[47] & s4}},s0[44 +:4] & {4{s1}}};
        assign s13[96 +:8] = {{4{s0[51] & s4}},s0[48 +:4] & {4{s1}}};
        assign s13[104 +:8] = {{4{s0[55] & s4}},s0[52 +:4] & {4{s1}}};
        assign s13[112 +:8] = {{4{s0[59] & s4}},s0[56 +:4] & {4{s1}}};
        assign s13[120 +:8] = {{4{s0[63] & s4}},s0[60 +:4] & {4{s1}}};
        assign s13[128 +:8] = {{4{s0[67] & s4}},s0[64 +:4] & {4{s1}}};
        assign s13[136 +:8] = {{4{s0[71] & s4}},s0[68 +:4] & {4{s1}}};
        assign s13[144 +:8] = {{4{s0[75] & s4}},s0[72 +:4] & {4{s1}}};
        assign s13[152 +:8] = {{4{s0[79] & s4}},s0[76 +:4] & {4{s1}}};
        assign s13[160 +:8] = {{4{s0[83] & s4}},s0[80 +:4] & {4{s1}}};
        assign s13[168 +:8] = {{4{s0[87] & s4}},s0[84 +:4] & {4{s1}}};
        assign s13[176 +:8] = {{4{s0[91] & s4}},s0[88 +:4] & {4{s1}}};
        assign s13[184 +:8] = {{4{s0[95] & s4}},s0[92 +:4] & {4{s1}}};
        assign s13[192 +:8] = {{4{s0[99] & s4}},s0[96 +:4] & {4{s1}}};
        assign s13[200 +:8] = {{4{s0[103] & s4}},s0[100 +:4] & {4{s1}}};
        assign s13[208 +:8] = {{4{s0[107] & s4}},s0[104 +:4] & {4{s1}}};
        assign s13[216 +:8] = {{4{s0[111] & s4}},s0[108 +:4] & {4{s1}}};
        assign s13[224 +:8] = {{4{s0[115] & s4}},s0[112 +:4] & {4{s1}}};
        assign s13[232 +:8] = {{4{s0[119] & s4}},s0[116 +:4] & {4{s1}}};
        assign s13[240 +:8] = {{4{s0[123] & s4}},s0[120 +:4] & {4{s1}}};
        assign s13[248 +:8] = {{4{s0[127] & s4}},s0[124 +:4] & {4{s1}}};
        assign s13[256 +:8] = {{4{s0[131] & s4}},s0[128 +:4] & {4{s1}}};
        assign s13[264 +:8] = {{4{s0[135] & s4}},s0[132 +:4] & {4{s1}}};
        assign s13[272 +:8] = {{4{s0[139] & s4}},s0[136 +:4] & {4{s1}}};
        assign s13[280 +:8] = {{4{s0[143] & s4}},s0[140 +:4] & {4{s1}}};
        assign s13[288 +:8] = {{4{s0[147] & s4}},s0[144 +:4] & {4{s1}}};
        assign s13[296 +:8] = {{4{s0[151] & s4}},s0[148 +:4] & {4{s1}}};
        assign s13[304 +:8] = {{4{s0[155] & s4}},s0[152 +:4] & {4{s1}}};
        assign s13[312 +:8] = {{4{s0[159] & s4}},s0[156 +:4] & {4{s1}}};
        assign s13[320 +:8] = {{4{s0[163] & s4}},s0[160 +:4] & {4{s1}}};
        assign s13[328 +:8] = {{4{s0[167] & s4}},s0[164 +:4] & {4{s1}}};
        assign s13[336 +:8] = {{4{s0[171] & s4}},s0[168 +:4] & {4{s1}}};
        assign s13[344 +:8] = {{4{s0[175] & s4}},s0[172 +:4] & {4{s1}}};
        assign s13[352 +:8] = {{4{s0[179] & s4}},s0[176 +:4] & {4{s1}}};
        assign s13[360 +:8] = {{4{s0[183] & s4}},s0[180 +:4] & {4{s1}}};
        assign s13[368 +:8] = {{4{s0[187] & s4}},s0[184 +:4] & {4{s1}}};
        assign s13[376 +:8] = {{4{s0[191] & s4}},s0[188 +:4] & {4{s1}}};
        assign s13[384 +:8] = {{4{s0[195] & s4}},s0[192 +:4] & {4{s1}}};
        assign s13[392 +:8] = {{4{s0[199] & s4}},s0[196 +:4] & {4{s1}}};
        assign s13[400 +:8] = {{4{s0[203] & s4}},s0[200 +:4] & {4{s1}}};
        assign s13[408 +:8] = {{4{s0[207] & s4}},s0[204 +:4] & {4{s1}}};
        assign s13[416 +:8] = {{4{s0[211] & s4}},s0[208 +:4] & {4{s1}}};
        assign s13[424 +:8] = {{4{s0[215] & s4}},s0[212 +:4] & {4{s1}}};
        assign s13[432 +:8] = {{4{s0[219] & s4}},s0[216 +:4] & {4{s1}}};
        assign s13[440 +:8] = {{4{s0[223] & s4}},s0[220 +:4] & {4{s1}}};
        assign s13[448 +:8] = {{4{s0[227] & s4}},s0[224 +:4] & {4{s1}}};
        assign s13[456 +:8] = {{4{s0[231] & s4}},s0[228 +:4] & {4{s1}}};
        assign s13[464 +:8] = {{4{s0[235] & s4}},s0[232 +:4] & {4{s1}}};
        assign s13[472 +:8] = {{4{s0[239] & s4}},s0[236 +:4] & {4{s1}}};
        assign s13[480 +:8] = {{4{s0[243] & s4}},s0[240 +:4] & {4{s1}}};
        assign s13[488 +:8] = {{4{s0[247] & s4}},s0[244 +:4] & {4{s1}}};
        assign s13[496 +:8] = {{4{s0[251] & s4}},s0[248 +:4] & {4{s1}}};
        assign s13[504 +:8] = {{4{s0[255] & s4}},s0[252 +:4] & {4{s1}}};
        assign s13[512 +:8] = {{4{s0[259] & s4}},s0[256 +:4] & {4{s1}}};
        assign s13[520 +:8] = {{4{s0[263] & s4}},s0[260 +:4] & {4{s1}}};
        assign s13[528 +:8] = {{4{s0[267] & s4}},s0[264 +:4] & {4{s1}}};
        assign s13[536 +:8] = {{4{s0[271] & s4}},s0[268 +:4] & {4{s1}}};
        assign s13[544 +:8] = {{4{s0[275] & s4}},s0[272 +:4] & {4{s1}}};
        assign s13[552 +:8] = {{4{s0[279] & s4}},s0[276 +:4] & {4{s1}}};
        assign s13[560 +:8] = {{4{s0[283] & s4}},s0[280 +:4] & {4{s1}}};
        assign s13[568 +:8] = {{4{s0[287] & s4}},s0[284 +:4] & {4{s1}}};
        assign s13[576 +:8] = {{4{s0[291] & s4}},s0[288 +:4] & {4{s1}}};
        assign s13[584 +:8] = {{4{s0[295] & s4}},s0[292 +:4] & {4{s1}}};
        assign s13[592 +:8] = {{4{s0[299] & s4}},s0[296 +:4] & {4{s1}}};
        assign s13[600 +:8] = {{4{s0[303] & s4}},s0[300 +:4] & {4{s1}}};
        assign s13[608 +:8] = {{4{s0[307] & s4}},s0[304 +:4] & {4{s1}}};
        assign s13[616 +:8] = {{4{s0[311] & s4}},s0[308 +:4] & {4{s1}}};
        assign s13[624 +:8] = {{4{s0[315] & s4}},s0[312 +:4] & {4{s1}}};
        assign s13[632 +:8] = {{4{s0[319] & s4}},s0[316 +:4] & {4{s1}}};
        assign s13[640 +:8] = {{4{s0[323] & s4}},s0[320 +:4] & {4{s1}}};
        assign s13[648 +:8] = {{4{s0[327] & s4}},s0[324 +:4] & {4{s1}}};
        assign s13[656 +:8] = {{4{s0[331] & s4}},s0[328 +:4] & {4{s1}}};
        assign s13[664 +:8] = {{4{s0[335] & s4}},s0[332 +:4] & {4{s1}}};
        assign s13[672 +:8] = {{4{s0[339] & s4}},s0[336 +:4] & {4{s1}}};
        assign s13[680 +:8] = {{4{s0[343] & s4}},s0[340 +:4] & {4{s1}}};
        assign s13[688 +:8] = {{4{s0[347] & s4}},s0[344 +:4] & {4{s1}}};
        assign s13[696 +:8] = {{4{s0[351] & s4}},s0[348 +:4] & {4{s1}}};
        assign s13[704 +:8] = {{4{s0[355] & s4}},s0[352 +:4] & {4{s1}}};
        assign s13[712 +:8] = {{4{s0[359] & s4}},s0[356 +:4] & {4{s1}}};
        assign s13[720 +:8] = {{4{s0[363] & s4}},s0[360 +:4] & {4{s1}}};
        assign s13[728 +:8] = {{4{s0[367] & s4}},s0[364 +:4] & {4{s1}}};
        assign s13[736 +:8] = {{4{s0[371] & s4}},s0[368 +:4] & {4{s1}}};
        assign s13[744 +:8] = {{4{s0[375] & s4}},s0[372 +:4] & {4{s1}}};
        assign s13[752 +:8] = {{4{s0[379] & s4}},s0[376 +:4] & {4{s1}}};
        assign s13[760 +:8] = {{4{s0[383] & s4}},s0[380 +:4] & {4{s1}}};
        assign s13[768 +:8] = {{4{s0[387] & s4}},s0[384 +:4] & {4{s1}}};
        assign s13[776 +:8] = {{4{s0[391] & s4}},s0[388 +:4] & {4{s1}}};
        assign s13[784 +:8] = {{4{s0[395] & s4}},s0[392 +:4] & {4{s1}}};
        assign s13[792 +:8] = {{4{s0[399] & s4}},s0[396 +:4] & {4{s1}}};
        assign s13[800 +:8] = {{4{s0[403] & s4}},s0[400 +:4] & {4{s1}}};
        assign s13[808 +:8] = {{4{s0[407] & s4}},s0[404 +:4] & {4{s1}}};
        assign s13[816 +:8] = {{4{s0[411] & s4}},s0[408 +:4] & {4{s1}}};
        assign s13[824 +:8] = {{4{s0[415] & s4}},s0[412 +:4] & {4{s1}}};
        assign s13[832 +:8] = {{4{s0[419] & s4}},s0[416 +:4] & {4{s1}}};
        assign s13[840 +:8] = {{4{s0[423] & s4}},s0[420 +:4] & {4{s1}}};
        assign s13[848 +:8] = {{4{s0[427] & s4}},s0[424 +:4] & {4{s1}}};
        assign s13[856 +:8] = {{4{s0[431] & s4}},s0[428 +:4] & {4{s1}}};
        assign s13[864 +:8] = {{4{s0[435] & s4}},s0[432 +:4] & {4{s1}}};
        assign s13[872 +:8] = {{4{s0[439] & s4}},s0[436 +:4] & {4{s1}}};
        assign s13[880 +:8] = {{4{s0[443] & s4}},s0[440 +:4] & {4{s1}}};
        assign s13[888 +:8] = {{4{s0[447] & s4}},s0[444 +:4] & {4{s1}}};
        assign s13[896 +:8] = {{4{s0[451] & s4}},s0[448 +:4] & {4{s1}}};
        assign s13[904 +:8] = {{4{s0[455] & s4}},s0[452 +:4] & {4{s1}}};
        assign s13[912 +:8] = {{4{s0[459] & s4}},s0[456 +:4] & {4{s1}}};
        assign s13[920 +:8] = {{4{s0[463] & s4}},s0[460 +:4] & {4{s1}}};
        assign s13[928 +:8] = {{4{s0[467] & s4}},s0[464 +:4] & {4{s1}}};
        assign s13[936 +:8] = {{4{s0[471] & s4}},s0[468 +:4] & {4{s1}}};
        assign s13[944 +:8] = {{4{s0[475] & s4}},s0[472 +:4] & {4{s1}}};
        assign s13[952 +:8] = {{4{s0[479] & s4}},s0[476 +:4] & {4{s1}}};
        assign s13[960 +:8] = {{4{s0[483] & s4}},s0[480 +:4] & {4{s1}}};
        assign s13[968 +:8] = {{4{s0[487] & s4}},s0[484 +:4] & {4{s1}}};
        assign s13[976 +:8] = {{4{s0[491] & s4}},s0[488 +:4] & {4{s1}}};
        assign s13[984 +:8] = {{4{s0[495] & s4}},s0[492 +:4] & {4{s1}}};
        assign s13[992 +:8] = {{4{s0[499] & s4}},s0[496 +:4] & {4{s1}}};
        assign s13[1000 +:8] = {{4{s0[503] & s4}},s0[500 +:4] & {4{s1}}};
        assign s13[1008 +:8] = {{4{s0[507] & s4}},s0[504 +:4] & {4{s1}}};
        assign s13[1016 +:8] = {{4{s0[511] & s4}},s0[508 +:4] & {4{s1}}};
        assign s14[0 +:16] = {{12{s0[3] & s5}},s0[0 +:4] & {4{s2}}};
        assign s14[16 +:16] = {{12{s0[7] & s5}},s0[4 +:4] & {4{s2}}};
        assign s14[32 +:16] = {{12{s0[11] & s5}},s0[8 +:4] & {4{s2}}};
        assign s14[48 +:16] = {{12{s0[15] & s5}},s0[12 +:4] & {4{s2}}};
        assign s14[64 +:16] = {{12{s0[19] & s5}},s0[16 +:4] & {4{s2}}};
        assign s14[80 +:16] = {{12{s0[23] & s5}},s0[20 +:4] & {4{s2}}};
        assign s14[96 +:16] = {{12{s0[27] & s5}},s0[24 +:4] & {4{s2}}};
        assign s14[112 +:16] = {{12{s0[31] & s5}},s0[28 +:4] & {4{s2}}};
        assign s14[128 +:16] = {{12{s0[35] & s5}},s0[32 +:4] & {4{s2}}};
        assign s14[144 +:16] = {{12{s0[39] & s5}},s0[36 +:4] & {4{s2}}};
        assign s14[160 +:16] = {{12{s0[43] & s5}},s0[40 +:4] & {4{s2}}};
        assign s14[176 +:16] = {{12{s0[47] & s5}},s0[44 +:4] & {4{s2}}};
        assign s14[192 +:16] = {{12{s0[51] & s5}},s0[48 +:4] & {4{s2}}};
        assign s14[208 +:16] = {{12{s0[55] & s5}},s0[52 +:4] & {4{s2}}};
        assign s14[224 +:16] = {{12{s0[59] & s5}},s0[56 +:4] & {4{s2}}};
        assign s14[240 +:16] = {{12{s0[63] & s5}},s0[60 +:4] & {4{s2}}};
        assign s14[256 +:16] = {{12{s0[67] & s5}},s0[64 +:4] & {4{s2}}};
        assign s14[272 +:16] = {{12{s0[71] & s5}},s0[68 +:4] & {4{s2}}};
        assign s14[288 +:16] = {{12{s0[75] & s5}},s0[72 +:4] & {4{s2}}};
        assign s14[304 +:16] = {{12{s0[79] & s5}},s0[76 +:4] & {4{s2}}};
        assign s14[320 +:16] = {{12{s0[83] & s5}},s0[80 +:4] & {4{s2}}};
        assign s14[336 +:16] = {{12{s0[87] & s5}},s0[84 +:4] & {4{s2}}};
        assign s14[352 +:16] = {{12{s0[91] & s5}},s0[88 +:4] & {4{s2}}};
        assign s14[368 +:16] = {{12{s0[95] & s5}},s0[92 +:4] & {4{s2}}};
        assign s14[384 +:16] = {{12{s0[99] & s5}},s0[96 +:4] & {4{s2}}};
        assign s14[400 +:16] = {{12{s0[103] & s5}},s0[100 +:4] & {4{s2}}};
        assign s14[416 +:16] = {{12{s0[107] & s5}},s0[104 +:4] & {4{s2}}};
        assign s14[432 +:16] = {{12{s0[111] & s5}},s0[108 +:4] & {4{s2}}};
        assign s14[448 +:16] = {{12{s0[115] & s5}},s0[112 +:4] & {4{s2}}};
        assign s14[464 +:16] = {{12{s0[119] & s5}},s0[116 +:4] & {4{s2}}};
        assign s14[480 +:16] = {{12{s0[123] & s5}},s0[120 +:4] & {4{s2}}};
        assign s14[496 +:16] = {{12{s0[127] & s5}},s0[124 +:4] & {4{s2}}};
        assign s14[512 +:16] = {{12{s0[131] & s5}},s0[128 +:4] & {4{s2}}};
        assign s14[528 +:16] = {{12{s0[135] & s5}},s0[132 +:4] & {4{s2}}};
        assign s14[544 +:16] = {{12{s0[139] & s5}},s0[136 +:4] & {4{s2}}};
        assign s14[560 +:16] = {{12{s0[143] & s5}},s0[140 +:4] & {4{s2}}};
        assign s14[576 +:16] = {{12{s0[147] & s5}},s0[144 +:4] & {4{s2}}};
        assign s14[592 +:16] = {{12{s0[151] & s5}},s0[148 +:4] & {4{s2}}};
        assign s14[608 +:16] = {{12{s0[155] & s5}},s0[152 +:4] & {4{s2}}};
        assign s14[624 +:16] = {{12{s0[159] & s5}},s0[156 +:4] & {4{s2}}};
        assign s14[640 +:16] = {{12{s0[163] & s5}},s0[160 +:4] & {4{s2}}};
        assign s14[656 +:16] = {{12{s0[167] & s5}},s0[164 +:4] & {4{s2}}};
        assign s14[672 +:16] = {{12{s0[171] & s5}},s0[168 +:4] & {4{s2}}};
        assign s14[688 +:16] = {{12{s0[175] & s5}},s0[172 +:4] & {4{s2}}};
        assign s14[704 +:16] = {{12{s0[179] & s5}},s0[176 +:4] & {4{s2}}};
        assign s14[720 +:16] = {{12{s0[183] & s5}},s0[180 +:4] & {4{s2}}};
        assign s14[736 +:16] = {{12{s0[187] & s5}},s0[184 +:4] & {4{s2}}};
        assign s14[752 +:16] = {{12{s0[191] & s5}},s0[188 +:4] & {4{s2}}};
        assign s14[768 +:16] = {{12{s0[195] & s5}},s0[192 +:4] & {4{s2}}};
        assign s14[784 +:16] = {{12{s0[199] & s5}},s0[196 +:4] & {4{s2}}};
        assign s14[800 +:16] = {{12{s0[203] & s5}},s0[200 +:4] & {4{s2}}};
        assign s14[816 +:16] = {{12{s0[207] & s5}},s0[204 +:4] & {4{s2}}};
        assign s14[832 +:16] = {{12{s0[211] & s5}},s0[208 +:4] & {4{s2}}};
        assign s14[848 +:16] = {{12{s0[215] & s5}},s0[212 +:4] & {4{s2}}};
        assign s14[864 +:16] = {{12{s0[219] & s5}},s0[216 +:4] & {4{s2}}};
        assign s14[880 +:16] = {{12{s0[223] & s5}},s0[220 +:4] & {4{s2}}};
        assign s14[896 +:16] = {{12{s0[227] & s5}},s0[224 +:4] & {4{s2}}};
        assign s14[912 +:16] = {{12{s0[231] & s5}},s0[228 +:4] & {4{s2}}};
        assign s14[928 +:16] = {{12{s0[235] & s5}},s0[232 +:4] & {4{s2}}};
        assign s14[944 +:16] = {{12{s0[239] & s5}},s0[236 +:4] & {4{s2}}};
        assign s14[960 +:16] = {{12{s0[243] & s5}},s0[240 +:4] & {4{s2}}};
        assign s14[976 +:16] = {{12{s0[247] & s5}},s0[244 +:4] & {4{s2}}};
        assign s14[992 +:16] = {{12{s0[251] & s5}},s0[248 +:4] & {4{s2}}};
        assign s14[1008 +:16] = {{12{s0[255] & s5}},s0[252 +:4] & {4{s2}}};
        assign s15[0 +:32] = {{28{s0[3] & s6}},s0[0 +:4] & {4{s3}}};
        assign s15[32 +:32] = {{28{s0[7] & s6}},s0[4 +:4] & {4{s3}}};
        assign s15[64 +:32] = {{28{s0[11] & s6}},s0[8 +:4] & {4{s3}}};
        assign s15[96 +:32] = {{28{s0[15] & s6}},s0[12 +:4] & {4{s3}}};
        assign s15[128 +:32] = {{28{s0[19] & s6}},s0[16 +:4] & {4{s3}}};
        assign s15[160 +:32] = {{28{s0[23] & s6}},s0[20 +:4] & {4{s3}}};
        assign s15[192 +:32] = {{28{s0[27] & s6}},s0[24 +:4] & {4{s3}}};
        assign s15[224 +:32] = {{28{s0[31] & s6}},s0[28 +:4] & {4{s3}}};
        assign s15[256 +:32] = {{28{s0[35] & s6}},s0[32 +:4] & {4{s3}}};
        assign s15[288 +:32] = {{28{s0[39] & s6}},s0[36 +:4] & {4{s3}}};
        assign s15[320 +:32] = {{28{s0[43] & s6}},s0[40 +:4] & {4{s3}}};
        assign s15[352 +:32] = {{28{s0[47] & s6}},s0[44 +:4] & {4{s3}}};
        assign s15[384 +:32] = {{28{s0[51] & s6}},s0[48 +:4] & {4{s3}}};
        assign s15[416 +:32] = {{28{s0[55] & s6}},s0[52 +:4] & {4{s3}}};
        assign s15[448 +:32] = {{28{s0[59] & s6}},s0[56 +:4] & {4{s3}}};
        assign s15[480 +:32] = {{28{s0[63] & s6}},s0[60 +:4] & {4{s3}}};
        assign s15[512 +:32] = {{28{s0[67] & s6}},s0[64 +:4] & {4{s3}}};
        assign s15[544 +:32] = {{28{s0[71] & s6}},s0[68 +:4] & {4{s3}}};
        assign s15[576 +:32] = {{28{s0[75] & s6}},s0[72 +:4] & {4{s3}}};
        assign s15[608 +:32] = {{28{s0[79] & s6}},s0[76 +:4] & {4{s3}}};
        assign s15[640 +:32] = {{28{s0[83] & s6}},s0[80 +:4] & {4{s3}}};
        assign s15[672 +:32] = {{28{s0[87] & s6}},s0[84 +:4] & {4{s3}}};
        assign s15[704 +:32] = {{28{s0[91] & s6}},s0[88 +:4] & {4{s3}}};
        assign s15[736 +:32] = {{28{s0[95] & s6}},s0[92 +:4] & {4{s3}}};
        assign s15[768 +:32] = {{28{s0[99] & s6}},s0[96 +:4] & {4{s3}}};
        assign s15[800 +:32] = {{28{s0[103] & s6}},s0[100 +:4] & {4{s3}}};
        assign s15[832 +:32] = {{28{s0[107] & s6}},s0[104 +:4] & {4{s3}}};
        assign s15[864 +:32] = {{28{s0[111] & s6}},s0[108 +:4] & {4{s3}}};
        assign s15[896 +:32] = {{28{s0[115] & s6}},s0[112 +:4] & {4{s3}}};
        assign s15[928 +:32] = {{28{s0[119] & s6}},s0[116 +:4] & {4{s3}}};
        assign s15[960 +:32] = {{28{s0[123] & s6}},s0[120 +:4] & {4{s3}}};
        assign s15[992 +:32] = {{28{s0[127] & s6}},s0[124 +:4] & {4{s3}}};
        wire [2 * VP_LEN - 1:0] s37;
        wire s38 = vzsext & eew8x2;
        assign s37[0 +:16] = {{8{s0[7] & s7}},s0[0 +:8] & {8{s38}}};
        assign s37[16 +:16] = {{8{s0[15] & s7}},s0[8 +:8] & {8{s38}}};
        assign s37[32 +:16] = {{8{s0[23] & s7}},s0[16 +:8] & {8{s38}}};
        assign s37[48 +:16] = {{8{s0[31] & s7}},s0[24 +:8] & {8{s38}}};
        assign s37[64 +:16] = {{8{s0[39] & s7}},s0[32 +:8] & {8{s38}}};
        assign s37[80 +:16] = {{8{s0[47] & s7}},s0[40 +:8] & {8{s38}}};
        assign s37[96 +:16] = {{8{s0[55] & s7}},s0[48 +:8] & {8{s38}}};
        assign s37[112 +:16] = {{8{s0[63] & s7}},s0[56 +:8] & {8{s38}}};
        assign s37[128 +:16] = {{8{s0[71] & s7}},s0[64 +:8] & {8{s38}}};
        assign s37[144 +:16] = {{8{s0[79] & s7}},s0[72 +:8] & {8{s38}}};
        assign s37[160 +:16] = {{8{s0[87] & s7}},s0[80 +:8] & {8{s38}}};
        assign s37[176 +:16] = {{8{s0[95] & s7}},s0[88 +:8] & {8{s38}}};
        assign s37[192 +:16] = {{8{s0[103] & s7}},s0[96 +:8] & {8{s38}}};
        assign s37[208 +:16] = {{8{s0[111] & s7}},s0[104 +:8] & {8{s38}}};
        assign s37[224 +:16] = {{8{s0[119] & s7}},s0[112 +:8] & {8{s38}}};
        assign s37[240 +:16] = {{8{s0[127] & s7}},s0[120 +:8] & {8{s38}}};
        assign s37[256 +:16] = {{8{s0[135] & s7}},s0[128 +:8] & {8{s38}}};
        assign s37[272 +:16] = {{8{s0[143] & s7}},s0[136 +:8] & {8{s38}}};
        assign s37[288 +:16] = {{8{s0[151] & s7}},s0[144 +:8] & {8{s38}}};
        assign s37[304 +:16] = {{8{s0[159] & s7}},s0[152 +:8] & {8{s38}}};
        assign s37[320 +:16] = {{8{s0[167] & s7}},s0[160 +:8] & {8{s38}}};
        assign s37[336 +:16] = {{8{s0[175] & s7}},s0[168 +:8] & {8{s38}}};
        assign s37[352 +:16] = {{8{s0[183] & s7}},s0[176 +:8] & {8{s38}}};
        assign s37[368 +:16] = {{8{s0[191] & s7}},s0[184 +:8] & {8{s38}}};
        assign s37[384 +:16] = {{8{s0[199] & s7}},s0[192 +:8] & {8{s38}}};
        assign s37[400 +:16] = {{8{s0[207] & s7}},s0[200 +:8] & {8{s38}}};
        assign s37[416 +:16] = {{8{s0[215] & s7}},s0[208 +:8] & {8{s38}}};
        assign s37[432 +:16] = {{8{s0[223] & s7}},s0[216 +:8] & {8{s38}}};
        assign s37[448 +:16] = {{8{s0[231] & s7}},s0[224 +:8] & {8{s38}}};
        assign s37[464 +:16] = {{8{s0[239] & s7}},s0[232 +:8] & {8{s38}}};
        assign s37[480 +:16] = {{8{s0[247] & s7}},s0[240 +:8] & {8{s38}}};
        assign s37[496 +:16] = {{8{s0[255] & s7}},s0[248 +:8] & {8{s38}}};
        assign s37[512 +:16] = {{8{s0[263] & s7}},s0[256 +:8] & {8{s38}}};
        assign s37[528 +:16] = {{8{s0[271] & s7}},s0[264 +:8] & {8{s38}}};
        assign s37[544 +:16] = {{8{s0[279] & s7}},s0[272 +:8] & {8{s38}}};
        assign s37[560 +:16] = {{8{s0[287] & s7}},s0[280 +:8] & {8{s38}}};
        assign s37[576 +:16] = {{8{s0[295] & s7}},s0[288 +:8] & {8{s38}}};
        assign s37[592 +:16] = {{8{s0[303] & s7}},s0[296 +:8] & {8{s38}}};
        assign s37[608 +:16] = {{8{s0[311] & s7}},s0[304 +:8] & {8{s38}}};
        assign s37[624 +:16] = {{8{s0[319] & s7}},s0[312 +:8] & {8{s38}}};
        assign s37[640 +:16] = {{8{s0[327] & s7}},s0[320 +:8] & {8{s38}}};
        assign s37[656 +:16] = {{8{s0[335] & s7}},s0[328 +:8] & {8{s38}}};
        assign s37[672 +:16] = {{8{s0[343] & s7}},s0[336 +:8] & {8{s38}}};
        assign s37[688 +:16] = {{8{s0[351] & s7}},s0[344 +:8] & {8{s38}}};
        assign s37[704 +:16] = {{8{s0[359] & s7}},s0[352 +:8] & {8{s38}}};
        assign s37[720 +:16] = {{8{s0[367] & s7}},s0[360 +:8] & {8{s38}}};
        assign s37[736 +:16] = {{8{s0[375] & s7}},s0[368 +:8] & {8{s38}}};
        assign s37[752 +:16] = {{8{s0[383] & s7}},s0[376 +:8] & {8{s38}}};
        assign s37[768 +:16] = {{8{s0[391] & s7}},s0[384 +:8] & {8{s38}}};
        assign s37[784 +:16] = {{8{s0[399] & s7}},s0[392 +:8] & {8{s38}}};
        assign s37[800 +:16] = {{8{s0[407] & s7}},s0[400 +:8] & {8{s38}}};
        assign s37[816 +:16] = {{8{s0[415] & s7}},s0[408 +:8] & {8{s38}}};
        assign s37[832 +:16] = {{8{s0[423] & s7}},s0[416 +:8] & {8{s38}}};
        assign s37[848 +:16] = {{8{s0[431] & s7}},s0[424 +:8] & {8{s38}}};
        assign s37[864 +:16] = {{8{s0[439] & s7}},s0[432 +:8] & {8{s38}}};
        assign s37[880 +:16] = {{8{s0[447] & s7}},s0[440 +:8] & {8{s38}}};
        assign s37[896 +:16] = {{8{s0[455] & s7}},s0[448 +:8] & {8{s38}}};
        assign s37[912 +:16] = {{8{s0[463] & s7}},s0[456 +:8] & {8{s38}}};
        assign s37[928 +:16] = {{8{s0[471] & s7}},s0[464 +:8] & {8{s38}}};
        assign s37[944 +:16] = {{8{s0[479] & s7}},s0[472 +:8] & {8{s38}}};
        assign s37[960 +:16] = {{8{s0[487] & s7}},s0[480 +:8] & {8{s38}}};
        assign s37[976 +:16] = {{8{s0[495] & s7}},s0[488 +:8] & {8{s38}}};
        assign s37[992 +:16] = {{8{s0[503] & s7}},s0[496 +:8] & {8{s38}}};
        assign s37[1008 +:16] = {{8{s0[511] & s7}},s0[504 +:8] & {8{s38}}};
        wire [2 * VP_LEN - 1:0] s39;
        wire s40 = vzsext & eew8x4;
        assign s39[0 +:32] = {{24{s0[7] & s8}},s0[0 +:8] & {8{s40}}};
        assign s39[32 +:32] = {{24{s0[15] & s8}},s0[8 +:8] & {8{s40}}};
        assign s39[64 +:32] = {{24{s0[23] & s8}},s0[16 +:8] & {8{s40}}};
        assign s39[96 +:32] = {{24{s0[31] & s8}},s0[24 +:8] & {8{s40}}};
        assign s39[128 +:32] = {{24{s0[39] & s8}},s0[32 +:8] & {8{s40}}};
        assign s39[160 +:32] = {{24{s0[47] & s8}},s0[40 +:8] & {8{s40}}};
        assign s39[192 +:32] = {{24{s0[55] & s8}},s0[48 +:8] & {8{s40}}};
        assign s39[224 +:32] = {{24{s0[63] & s8}},s0[56 +:8] & {8{s40}}};
        assign s39[256 +:32] = {{24{s0[71] & s8}},s0[64 +:8] & {8{s40}}};
        assign s39[288 +:32] = {{24{s0[79] & s8}},s0[72 +:8] & {8{s40}}};
        assign s39[320 +:32] = {{24{s0[87] & s8}},s0[80 +:8] & {8{s40}}};
        assign s39[352 +:32] = {{24{s0[95] & s8}},s0[88 +:8] & {8{s40}}};
        assign s39[384 +:32] = {{24{s0[103] & s8}},s0[96 +:8] & {8{s40}}};
        assign s39[416 +:32] = {{24{s0[111] & s8}},s0[104 +:8] & {8{s40}}};
        assign s39[448 +:32] = {{24{s0[119] & s8}},s0[112 +:8] & {8{s40}}};
        assign s39[480 +:32] = {{24{s0[127] & s8}},s0[120 +:8] & {8{s40}}};
        assign s39[512 +:32] = {{24{s0[135] & s8}},s0[128 +:8] & {8{s40}}};
        assign s39[544 +:32] = {{24{s0[143] & s8}},s0[136 +:8] & {8{s40}}};
        assign s39[576 +:32] = {{24{s0[151] & s8}},s0[144 +:8] & {8{s40}}};
        assign s39[608 +:32] = {{24{s0[159] & s8}},s0[152 +:8] & {8{s40}}};
        assign s39[640 +:32] = {{24{s0[167] & s8}},s0[160 +:8] & {8{s40}}};
        assign s39[672 +:32] = {{24{s0[175] & s8}},s0[168 +:8] & {8{s40}}};
        assign s39[704 +:32] = {{24{s0[183] & s8}},s0[176 +:8] & {8{s40}}};
        assign s39[736 +:32] = {{24{s0[191] & s8}},s0[184 +:8] & {8{s40}}};
        assign s39[768 +:32] = {{24{s0[199] & s8}},s0[192 +:8] & {8{s40}}};
        assign s39[800 +:32] = {{24{s0[207] & s8}},s0[200 +:8] & {8{s40}}};
        assign s39[832 +:32] = {{24{s0[215] & s8}},s0[208 +:8] & {8{s40}}};
        assign s39[864 +:32] = {{24{s0[223] & s8}},s0[216 +:8] & {8{s40}}};
        assign s39[896 +:32] = {{24{s0[231] & s8}},s0[224 +:8] & {8{s40}}};
        assign s39[928 +:32] = {{24{s0[239] & s8}},s0[232 +:8] & {8{s40}}};
        assign s39[960 +:32] = {{24{s0[247] & s8}},s0[240 +:8] & {8{s40}}};
        assign s39[992 +:32] = {{24{s0[255] & s8}},s0[248 +:8] & {8{s40}}};
        wire [2 * VP_LEN - 1:0] s41;
        wire s42 = vzsext & eew8x8;
        assign s41[0 +:64] = {{56{s0[7] & s9}},s0[0 +:8] & {8{s42}}};
        assign s41[64 +:64] = {{56{s0[15] & s9}},s0[8 +:8] & {8{s42}}};
        assign s41[128 +:64] = {{56{s0[23] & s9}},s0[16 +:8] & {8{s42}}};
        assign s41[192 +:64] = {{56{s0[31] & s9}},s0[24 +:8] & {8{s42}}};
        assign s41[256 +:64] = {{56{s0[39] & s9}},s0[32 +:8] & {8{s42}}};
        assign s41[320 +:64] = {{56{s0[47] & s9}},s0[40 +:8] & {8{s42}}};
        assign s41[384 +:64] = {{56{s0[55] & s9}},s0[48 +:8] & {8{s42}}};
        assign s41[448 +:64] = {{56{s0[63] & s9}},s0[56 +:8] & {8{s42}}};
        assign s41[512 +:64] = {{56{s0[71] & s9}},s0[64 +:8] & {8{s42}}};
        assign s41[576 +:64] = {{56{s0[79] & s9}},s0[72 +:8] & {8{s42}}};
        assign s41[640 +:64] = {{56{s0[87] & s9}},s0[80 +:8] & {8{s42}}};
        assign s41[704 +:64] = {{56{s0[95] & s9}},s0[88 +:8] & {8{s42}}};
        assign s41[768 +:64] = {{56{s0[103] & s9}},s0[96 +:8] & {8{s42}}};
        assign s41[832 +:64] = {{56{s0[111] & s9}},s0[104 +:8] & {8{s42}}};
        assign s41[896 +:64] = {{56{s0[119] & s9}},s0[112 +:8] & {8{s42}}};
        assign s41[960 +:64] = {{56{s0[127] & s9}},s0[120 +:8] & {8{s42}}};
        wire [2 * VP_LEN - 1:0] s43;
        wire s44 = vzsext & eew16x2;
        assign s43[0 +:32] = {{16{s0[15] & s10}},s0[0 +:16] & {16{s44}}};
        assign s43[32 +:32] = {{16{s0[31] & s10}},s0[16 +:16] & {16{s44}}};
        assign s43[64 +:32] = {{16{s0[47] & s10}},s0[32 +:16] & {16{s44}}};
        assign s43[96 +:32] = {{16{s0[63] & s10}},s0[48 +:16] & {16{s44}}};
        assign s43[128 +:32] = {{16{s0[79] & s10}},s0[64 +:16] & {16{s44}}};
        assign s43[160 +:32] = {{16{s0[95] & s10}},s0[80 +:16] & {16{s44}}};
        assign s43[192 +:32] = {{16{s0[111] & s10}},s0[96 +:16] & {16{s44}}};
        assign s43[224 +:32] = {{16{s0[127] & s10}},s0[112 +:16] & {16{s44}}};
        assign s43[256 +:32] = {{16{s0[143] & s10}},s0[128 +:16] & {16{s44}}};
        assign s43[288 +:32] = {{16{s0[159] & s10}},s0[144 +:16] & {16{s44}}};
        assign s43[320 +:32] = {{16{s0[175] & s10}},s0[160 +:16] & {16{s44}}};
        assign s43[352 +:32] = {{16{s0[191] & s10}},s0[176 +:16] & {16{s44}}};
        assign s43[384 +:32] = {{16{s0[207] & s10}},s0[192 +:16] & {16{s44}}};
        assign s43[416 +:32] = {{16{s0[223] & s10}},s0[208 +:16] & {16{s44}}};
        assign s43[448 +:32] = {{16{s0[239] & s10}},s0[224 +:16] & {16{s44}}};
        assign s43[480 +:32] = {{16{s0[255] & s10}},s0[240 +:16] & {16{s44}}};
        assign s43[512 +:32] = {{16{s0[271] & s10}},s0[256 +:16] & {16{s44}}};
        assign s43[544 +:32] = {{16{s0[287] & s10}},s0[272 +:16] & {16{s44}}};
        assign s43[576 +:32] = {{16{s0[303] & s10}},s0[288 +:16] & {16{s44}}};
        assign s43[608 +:32] = {{16{s0[319] & s10}},s0[304 +:16] & {16{s44}}};
        assign s43[640 +:32] = {{16{s0[335] & s10}},s0[320 +:16] & {16{s44}}};
        assign s43[672 +:32] = {{16{s0[351] & s10}},s0[336 +:16] & {16{s44}}};
        assign s43[704 +:32] = {{16{s0[367] & s10}},s0[352 +:16] & {16{s44}}};
        assign s43[736 +:32] = {{16{s0[383] & s10}},s0[368 +:16] & {16{s44}}};
        assign s43[768 +:32] = {{16{s0[399] & s10}},s0[384 +:16] & {16{s44}}};
        assign s43[800 +:32] = {{16{s0[415] & s10}},s0[400 +:16] & {16{s44}}};
        assign s43[832 +:32] = {{16{s0[431] & s10}},s0[416 +:16] & {16{s44}}};
        assign s43[864 +:32] = {{16{s0[447] & s10}},s0[432 +:16] & {16{s44}}};
        assign s43[896 +:32] = {{16{s0[463] & s10}},s0[448 +:16] & {16{s44}}};
        assign s43[928 +:32] = {{16{s0[479] & s10}},s0[464 +:16] & {16{s44}}};
        assign s43[960 +:32] = {{16{s0[495] & s10}},s0[480 +:16] & {16{s44}}};
        assign s43[992 +:32] = {{16{s0[511] & s10}},s0[496 +:16] & {16{s44}}};
        wire [2 * VP_LEN - 1:0] s45;
        wire s46 = vzsext & eew16x4;
        assign s45[0 +:64] = {{48{s0[15] & s11}},s0[0 +:16] & {16{s46}}};
        assign s45[64 +:64] = {{48{s0[31] & s11}},s0[16 +:16] & {16{s46}}};
        assign s45[128 +:64] = {{48{s0[47] & s11}},s0[32 +:16] & {16{s46}}};
        assign s45[192 +:64] = {{48{s0[63] & s11}},s0[48 +:16] & {16{s46}}};
        assign s45[256 +:64] = {{48{s0[79] & s11}},s0[64 +:16] & {16{s46}}};
        assign s45[320 +:64] = {{48{s0[95] & s11}},s0[80 +:16] & {16{s46}}};
        assign s45[384 +:64] = {{48{s0[111] & s11}},s0[96 +:16] & {16{s46}}};
        assign s45[448 +:64] = {{48{s0[127] & s11}},s0[112 +:16] & {16{s46}}};
        assign s45[512 +:64] = {{48{s0[143] & s11}},s0[128 +:16] & {16{s46}}};
        assign s45[576 +:64] = {{48{s0[159] & s11}},s0[144 +:16] & {16{s46}}};
        assign s45[640 +:64] = {{48{s0[175] & s11}},s0[160 +:16] & {16{s46}}};
        assign s45[704 +:64] = {{48{s0[191] & s11}},s0[176 +:16] & {16{s46}}};
        assign s45[768 +:64] = {{48{s0[207] & s11}},s0[192 +:16] & {16{s46}}};
        assign s45[832 +:64] = {{48{s0[223] & s11}},s0[208 +:16] & {16{s46}}};
        assign s45[896 +:64] = {{48{s0[239] & s11}},s0[224 +:16] & {16{s46}}};
        assign s45[960 +:64] = {{48{s0[255] & s11}},s0[240 +:16] & {16{s46}}};
        wire [2 * VP_LEN - 1:0] s47;
        wire s48 = vzsext & eew32x2;
        assign s47[0 +:64] = {{32{s0[31] & s12}},s0[0 +:32] & {32{s48}}};
        assign s47[64 +:64] = {{32{s0[63] & s12}},s0[32 +:32] & {32{s48}}};
        assign s47[128 +:64] = {{32{s0[95] & s12}},s0[64 +:32] & {32{s48}}};
        assign s47[192 +:64] = {{32{s0[127] & s12}},s0[96 +:32] & {32{s48}}};
        assign s47[256 +:64] = {{32{s0[159] & s12}},s0[128 +:32] & {32{s48}}};
        assign s47[320 +:64] = {{32{s0[191] & s12}},s0[160 +:32] & {32{s48}}};
        assign s47[384 +:64] = {{32{s0[223] & s12}},s0[192 +:32] & {32{s48}}};
        assign s47[448 +:64] = {{32{s0[255] & s12}},s0[224 +:32] & {32{s48}}};
        assign s47[512 +:64] = {{32{s0[287] & s12}},s0[256 +:32] & {32{s48}}};
        assign s47[576 +:64] = {{32{s0[319] & s12}},s0[288 +:32] & {32{s48}}};
        assign s47[640 +:64] = {{32{s0[351] & s12}},s0[320 +:32] & {32{s48}}};
        assign s47[704 +:64] = {{32{s0[383] & s12}},s0[352 +:32] & {32{s48}}};
        assign s47[768 +:64] = {{32{s0[415] & s12}},s0[384 +:32] & {32{s48}}};
        assign s47[832 +:64] = {{32{s0[447] & s12}},s0[416 +:32] & {32{s48}}};
        assign s47[896 +:64] = {{32{s0[479] & s12}},s0[448 +:32] & {32{s48}}};
        assign s47[960 +:64] = {{32{s0[511] & s12}},s0[480 +:32] & {32{s48}}};
        wire [2 * VP_LEN - 1:0] s35;
        assign s35 = s13 | s14 | s15 | s37 | s39 | s41 | s43 | s45 | s47;
        wire [2 * VP_LEN - 1:0] s36 = {2 * VP_LEN{vmv_nr}} & {vs2_buf[VP_LEN +:VP_LEN],{VP_LEN{1'b0}}};
        assign result0[0 * 8 +:8] = s36[0 * 8 +:8] | s35[0 * 8 +:8] | ({8{s30[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s32[0]}}) | {8{s28[0]}});
        assign result0[1 * 8 +:8] = s36[1 * 8 +:8] | s35[1 * 8 +:8] | ({8{s30[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s32[1]}}) | {8{s28[1]}});
        assign result0[2 * 8 +:8] = s36[2 * 8 +:8] | s35[2 * 8 +:8] | ({8{s30[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s32[2]}}) | {8{s28[2]}});
        assign result0[3 * 8 +:8] = s36[3 * 8 +:8] | s35[3 * 8 +:8] | ({8{s30[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s32[3]}}) | {8{s28[3]}});
        assign result0[4 * 8 +:8] = s36[4 * 8 +:8] | s35[4 * 8 +:8] | ({8{s30[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s32[4]}}) | {8{s28[4]}});
        assign result0[5 * 8 +:8] = s36[5 * 8 +:8] | s35[5 * 8 +:8] | ({8{s30[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s32[5]}}) | {8{s28[5]}});
        assign result0[6 * 8 +:8] = s36[6 * 8 +:8] | s35[6 * 8 +:8] | ({8{s30[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s32[6]}}) | {8{s28[6]}});
        assign result0[7 * 8 +:8] = s36[7 * 8 +:8] | s35[7 * 8 +:8] | ({8{s30[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s32[7]}}) | {8{s28[7]}});
        assign result0[8 * 8 +:8] = s36[8 * 8 +:8] | s35[8 * 8 +:8] | ({8{s30[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s32[8]}}) | {8{s28[8]}});
        assign result0[9 * 8 +:8] = s36[9 * 8 +:8] | s35[9 * 8 +:8] | ({8{s30[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s32[9]}}) | {8{s28[9]}});
        assign result0[10 * 8 +:8] = s36[10 * 8 +:8] | s35[10 * 8 +:8] | ({8{s30[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s32[10]}}) | {8{s28[10]}});
        assign result0[11 * 8 +:8] = s36[11 * 8 +:8] | s35[11 * 8 +:8] | ({8{s30[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s32[11]}}) | {8{s28[11]}});
        assign result0[12 * 8 +:8] = s36[12 * 8 +:8] | s35[12 * 8 +:8] | ({8{s30[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s32[12]}}) | {8{s28[12]}});
        assign result0[13 * 8 +:8] = s36[13 * 8 +:8] | s35[13 * 8 +:8] | ({8{s30[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s32[13]}}) | {8{s28[13]}});
        assign result0[14 * 8 +:8] = s36[14 * 8 +:8] | s35[14 * 8 +:8] | ({8{s30[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s32[14]}}) | {8{s28[14]}});
        assign result0[15 * 8 +:8] = s36[15 * 8 +:8] | s35[15 * 8 +:8] | ({8{s30[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s32[15]}}) | {8{s28[15]}});
        assign result0[16 * 8 +:8] = s36[16 * 8 +:8] | s35[16 * 8 +:8] | ({8{s30[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s32[16]}}) | {8{s28[16]}});
        assign result0[17 * 8 +:8] = s36[17 * 8 +:8] | s35[17 * 8 +:8] | ({8{s30[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s32[17]}}) | {8{s28[17]}});
        assign result0[18 * 8 +:8] = s36[18 * 8 +:8] | s35[18 * 8 +:8] | ({8{s30[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s32[18]}}) | {8{s28[18]}});
        assign result0[19 * 8 +:8] = s36[19 * 8 +:8] | s35[19 * 8 +:8] | ({8{s30[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s32[19]}}) | {8{s28[19]}});
        assign result0[20 * 8 +:8] = s36[20 * 8 +:8] | s35[20 * 8 +:8] | ({8{s30[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s32[20]}}) | {8{s28[20]}});
        assign result0[21 * 8 +:8] = s36[21 * 8 +:8] | s35[21 * 8 +:8] | ({8{s30[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s32[21]}}) | {8{s28[21]}});
        assign result0[22 * 8 +:8] = s36[22 * 8 +:8] | s35[22 * 8 +:8] | ({8{s30[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s32[22]}}) | {8{s28[22]}});
        assign result0[23 * 8 +:8] = s36[23 * 8 +:8] | s35[23 * 8 +:8] | ({8{s30[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s32[23]}}) | {8{s28[23]}});
        assign result0[24 * 8 +:8] = s36[24 * 8 +:8] | s35[24 * 8 +:8] | ({8{s30[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s32[24]}}) | {8{s28[24]}});
        assign result0[25 * 8 +:8] = s36[25 * 8 +:8] | s35[25 * 8 +:8] | ({8{s30[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s32[25]}}) | {8{s28[25]}});
        assign result0[26 * 8 +:8] = s36[26 * 8 +:8] | s35[26 * 8 +:8] | ({8{s30[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s32[26]}}) | {8{s28[26]}});
        assign result0[27 * 8 +:8] = s36[27 * 8 +:8] | s35[27 * 8 +:8] | ({8{s30[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s32[27]}}) | {8{s28[27]}});
        assign result0[28 * 8 +:8] = s36[28 * 8 +:8] | s35[28 * 8 +:8] | ({8{s30[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s32[28]}}) | {8{s28[28]}});
        assign result0[29 * 8 +:8] = s36[29 * 8 +:8] | s35[29 * 8 +:8] | ({8{s30[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s32[29]}}) | {8{s28[29]}});
        assign result0[30 * 8 +:8] = s36[30 * 8 +:8] | s35[30 * 8 +:8] | ({8{s30[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s32[30]}}) | {8{s28[30]}});
        assign result0[31 * 8 +:8] = s36[31 * 8 +:8] | s35[31 * 8 +:8] | ({8{s30[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s32[31]}}) | {8{s28[31]}});
        assign result0[32 * 8 +:8] = s36[32 * 8 +:8] | s35[32 * 8 +:8] | ({8{s30[32]}} & s34[32 * 8 +:8]) | ((s0[32 * 8 +:8] & {8{s32[32]}}) | {8{s28[32]}});
        assign result0[33 * 8 +:8] = s36[33 * 8 +:8] | s35[33 * 8 +:8] | ({8{s30[33]}} & s34[33 * 8 +:8]) | ((s0[33 * 8 +:8] & {8{s32[33]}}) | {8{s28[33]}});
        assign result0[34 * 8 +:8] = s36[34 * 8 +:8] | s35[34 * 8 +:8] | ({8{s30[34]}} & s34[34 * 8 +:8]) | ((s0[34 * 8 +:8] & {8{s32[34]}}) | {8{s28[34]}});
        assign result0[35 * 8 +:8] = s36[35 * 8 +:8] | s35[35 * 8 +:8] | ({8{s30[35]}} & s34[35 * 8 +:8]) | ((s0[35 * 8 +:8] & {8{s32[35]}}) | {8{s28[35]}});
        assign result0[36 * 8 +:8] = s36[36 * 8 +:8] | s35[36 * 8 +:8] | ({8{s30[36]}} & s34[36 * 8 +:8]) | ((s0[36 * 8 +:8] & {8{s32[36]}}) | {8{s28[36]}});
        assign result0[37 * 8 +:8] = s36[37 * 8 +:8] | s35[37 * 8 +:8] | ({8{s30[37]}} & s34[37 * 8 +:8]) | ((s0[37 * 8 +:8] & {8{s32[37]}}) | {8{s28[37]}});
        assign result0[38 * 8 +:8] = s36[38 * 8 +:8] | s35[38 * 8 +:8] | ({8{s30[38]}} & s34[38 * 8 +:8]) | ((s0[38 * 8 +:8] & {8{s32[38]}}) | {8{s28[38]}});
        assign result0[39 * 8 +:8] = s36[39 * 8 +:8] | s35[39 * 8 +:8] | ({8{s30[39]}} & s34[39 * 8 +:8]) | ((s0[39 * 8 +:8] & {8{s32[39]}}) | {8{s28[39]}});
        assign result0[40 * 8 +:8] = s36[40 * 8 +:8] | s35[40 * 8 +:8] | ({8{s30[40]}} & s34[40 * 8 +:8]) | ((s0[40 * 8 +:8] & {8{s32[40]}}) | {8{s28[40]}});
        assign result0[41 * 8 +:8] = s36[41 * 8 +:8] | s35[41 * 8 +:8] | ({8{s30[41]}} & s34[41 * 8 +:8]) | ((s0[41 * 8 +:8] & {8{s32[41]}}) | {8{s28[41]}});
        assign result0[42 * 8 +:8] = s36[42 * 8 +:8] | s35[42 * 8 +:8] | ({8{s30[42]}} & s34[42 * 8 +:8]) | ((s0[42 * 8 +:8] & {8{s32[42]}}) | {8{s28[42]}});
        assign result0[43 * 8 +:8] = s36[43 * 8 +:8] | s35[43 * 8 +:8] | ({8{s30[43]}} & s34[43 * 8 +:8]) | ((s0[43 * 8 +:8] & {8{s32[43]}}) | {8{s28[43]}});
        assign result0[44 * 8 +:8] = s36[44 * 8 +:8] | s35[44 * 8 +:8] | ({8{s30[44]}} & s34[44 * 8 +:8]) | ((s0[44 * 8 +:8] & {8{s32[44]}}) | {8{s28[44]}});
        assign result0[45 * 8 +:8] = s36[45 * 8 +:8] | s35[45 * 8 +:8] | ({8{s30[45]}} & s34[45 * 8 +:8]) | ((s0[45 * 8 +:8] & {8{s32[45]}}) | {8{s28[45]}});
        assign result0[46 * 8 +:8] = s36[46 * 8 +:8] | s35[46 * 8 +:8] | ({8{s30[46]}} & s34[46 * 8 +:8]) | ((s0[46 * 8 +:8] & {8{s32[46]}}) | {8{s28[46]}});
        assign result0[47 * 8 +:8] = s36[47 * 8 +:8] | s35[47 * 8 +:8] | ({8{s30[47]}} & s34[47 * 8 +:8]) | ((s0[47 * 8 +:8] & {8{s32[47]}}) | {8{s28[47]}});
        assign result0[48 * 8 +:8] = s36[48 * 8 +:8] | s35[48 * 8 +:8] | ({8{s30[48]}} & s34[48 * 8 +:8]) | ((s0[48 * 8 +:8] & {8{s32[48]}}) | {8{s28[48]}});
        assign result0[49 * 8 +:8] = s36[49 * 8 +:8] | s35[49 * 8 +:8] | ({8{s30[49]}} & s34[49 * 8 +:8]) | ((s0[49 * 8 +:8] & {8{s32[49]}}) | {8{s28[49]}});
        assign result0[50 * 8 +:8] = s36[50 * 8 +:8] | s35[50 * 8 +:8] | ({8{s30[50]}} & s34[50 * 8 +:8]) | ((s0[50 * 8 +:8] & {8{s32[50]}}) | {8{s28[50]}});
        assign result0[51 * 8 +:8] = s36[51 * 8 +:8] | s35[51 * 8 +:8] | ({8{s30[51]}} & s34[51 * 8 +:8]) | ((s0[51 * 8 +:8] & {8{s32[51]}}) | {8{s28[51]}});
        assign result0[52 * 8 +:8] = s36[52 * 8 +:8] | s35[52 * 8 +:8] | ({8{s30[52]}} & s34[52 * 8 +:8]) | ((s0[52 * 8 +:8] & {8{s32[52]}}) | {8{s28[52]}});
        assign result0[53 * 8 +:8] = s36[53 * 8 +:8] | s35[53 * 8 +:8] | ({8{s30[53]}} & s34[53 * 8 +:8]) | ((s0[53 * 8 +:8] & {8{s32[53]}}) | {8{s28[53]}});
        assign result0[54 * 8 +:8] = s36[54 * 8 +:8] | s35[54 * 8 +:8] | ({8{s30[54]}} & s34[54 * 8 +:8]) | ((s0[54 * 8 +:8] & {8{s32[54]}}) | {8{s28[54]}});
        assign result0[55 * 8 +:8] = s36[55 * 8 +:8] | s35[55 * 8 +:8] | ({8{s30[55]}} & s34[55 * 8 +:8]) | ((s0[55 * 8 +:8] & {8{s32[55]}}) | {8{s28[55]}});
        assign result0[56 * 8 +:8] = s36[56 * 8 +:8] | s35[56 * 8 +:8] | ({8{s30[56]}} & s34[56 * 8 +:8]) | ((s0[56 * 8 +:8] & {8{s32[56]}}) | {8{s28[56]}});
        assign result0[57 * 8 +:8] = s36[57 * 8 +:8] | s35[57 * 8 +:8] | ({8{s30[57]}} & s34[57 * 8 +:8]) | ((s0[57 * 8 +:8] & {8{s32[57]}}) | {8{s28[57]}});
        assign result0[58 * 8 +:8] = s36[58 * 8 +:8] | s35[58 * 8 +:8] | ({8{s30[58]}} & s34[58 * 8 +:8]) | ((s0[58 * 8 +:8] & {8{s32[58]}}) | {8{s28[58]}});
        assign result0[59 * 8 +:8] = s36[59 * 8 +:8] | s35[59 * 8 +:8] | ({8{s30[59]}} & s34[59 * 8 +:8]) | ((s0[59 * 8 +:8] & {8{s32[59]}}) | {8{s28[59]}});
        assign result0[60 * 8 +:8] = s36[60 * 8 +:8] | s35[60 * 8 +:8] | ({8{s30[60]}} & s34[60 * 8 +:8]) | ((s0[60 * 8 +:8] & {8{s32[60]}}) | {8{s28[60]}});
        assign result0[61 * 8 +:8] = s36[61 * 8 +:8] | s35[61 * 8 +:8] | ({8{s30[61]}} & s34[61 * 8 +:8]) | ((s0[61 * 8 +:8] & {8{s32[61]}}) | {8{s28[61]}});
        assign result0[62 * 8 +:8] = s36[62 * 8 +:8] | s35[62 * 8 +:8] | ({8{s30[62]}} & s34[62 * 8 +:8]) | ((s0[62 * 8 +:8] & {8{s32[62]}}) | {8{s28[62]}});
        assign result0[63 * 8 +:8] = s36[63 * 8 +:8] | s35[63 * 8 +:8] | ({8{s30[63]}} & s34[63 * 8 +:8]) | ((s0[63 * 8 +:8] & {8{s32[63]}}) | {8{s28[63]}});
        assign result1[0 * 8 +:8] = s36[64 * 8 +:8] | s35[64 * 8 +:8] | ({8{s31[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s33[0]}}) | {8{s28[0]}});
        assign result1[1 * 8 +:8] = s36[65 * 8 +:8] | s35[65 * 8 +:8] | ({8{s31[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s33[1]}}) | {8{s28[1]}});
        assign result1[2 * 8 +:8] = s36[66 * 8 +:8] | s35[66 * 8 +:8] | ({8{s31[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s33[2]}}) | {8{s28[2]}});
        assign result1[3 * 8 +:8] = s36[67 * 8 +:8] | s35[67 * 8 +:8] | ({8{s31[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s33[3]}}) | {8{s28[3]}});
        assign result1[4 * 8 +:8] = s36[68 * 8 +:8] | s35[68 * 8 +:8] | ({8{s31[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s33[4]}}) | {8{s28[4]}});
        assign result1[5 * 8 +:8] = s36[69 * 8 +:8] | s35[69 * 8 +:8] | ({8{s31[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s33[5]}}) | {8{s28[5]}});
        assign result1[6 * 8 +:8] = s36[70 * 8 +:8] | s35[70 * 8 +:8] | ({8{s31[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s33[6]}}) | {8{s28[6]}});
        assign result1[7 * 8 +:8] = s36[71 * 8 +:8] | s35[71 * 8 +:8] | ({8{s31[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s33[7]}}) | {8{s28[7]}});
        assign result1[8 * 8 +:8] = s36[72 * 8 +:8] | s35[72 * 8 +:8] | ({8{s31[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s33[8]}}) | {8{s28[8]}});
        assign result1[9 * 8 +:8] = s36[73 * 8 +:8] | s35[73 * 8 +:8] | ({8{s31[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s33[9]}}) | {8{s28[9]}});
        assign result1[10 * 8 +:8] = s36[74 * 8 +:8] | s35[74 * 8 +:8] | ({8{s31[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s33[10]}}) | {8{s28[10]}});
        assign result1[11 * 8 +:8] = s36[75 * 8 +:8] | s35[75 * 8 +:8] | ({8{s31[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s33[11]}}) | {8{s28[11]}});
        assign result1[12 * 8 +:8] = s36[76 * 8 +:8] | s35[76 * 8 +:8] | ({8{s31[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s33[12]}}) | {8{s28[12]}});
        assign result1[13 * 8 +:8] = s36[77 * 8 +:8] | s35[77 * 8 +:8] | ({8{s31[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s33[13]}}) | {8{s28[13]}});
        assign result1[14 * 8 +:8] = s36[78 * 8 +:8] | s35[78 * 8 +:8] | ({8{s31[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s33[14]}}) | {8{s28[14]}});
        assign result1[15 * 8 +:8] = s36[79 * 8 +:8] | s35[79 * 8 +:8] | ({8{s31[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s33[15]}}) | {8{s28[15]}});
        assign result1[16 * 8 +:8] = s36[80 * 8 +:8] | s35[80 * 8 +:8] | ({8{s31[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s33[16]}}) | {8{s28[16]}});
        assign result1[17 * 8 +:8] = s36[81 * 8 +:8] | s35[81 * 8 +:8] | ({8{s31[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s33[17]}}) | {8{s28[17]}});
        assign result1[18 * 8 +:8] = s36[82 * 8 +:8] | s35[82 * 8 +:8] | ({8{s31[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s33[18]}}) | {8{s28[18]}});
        assign result1[19 * 8 +:8] = s36[83 * 8 +:8] | s35[83 * 8 +:8] | ({8{s31[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s33[19]}}) | {8{s28[19]}});
        assign result1[20 * 8 +:8] = s36[84 * 8 +:8] | s35[84 * 8 +:8] | ({8{s31[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s33[20]}}) | {8{s28[20]}});
        assign result1[21 * 8 +:8] = s36[85 * 8 +:8] | s35[85 * 8 +:8] | ({8{s31[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s33[21]}}) | {8{s28[21]}});
        assign result1[22 * 8 +:8] = s36[86 * 8 +:8] | s35[86 * 8 +:8] | ({8{s31[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s33[22]}}) | {8{s28[22]}});
        assign result1[23 * 8 +:8] = s36[87 * 8 +:8] | s35[87 * 8 +:8] | ({8{s31[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s33[23]}}) | {8{s28[23]}});
        assign result1[24 * 8 +:8] = s36[88 * 8 +:8] | s35[88 * 8 +:8] | ({8{s31[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s33[24]}}) | {8{s28[24]}});
        assign result1[25 * 8 +:8] = s36[89 * 8 +:8] | s35[89 * 8 +:8] | ({8{s31[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s33[25]}}) | {8{s28[25]}});
        assign result1[26 * 8 +:8] = s36[90 * 8 +:8] | s35[90 * 8 +:8] | ({8{s31[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s33[26]}}) | {8{s28[26]}});
        assign result1[27 * 8 +:8] = s36[91 * 8 +:8] | s35[91 * 8 +:8] | ({8{s31[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s33[27]}}) | {8{s28[27]}});
        assign result1[28 * 8 +:8] = s36[92 * 8 +:8] | s35[92 * 8 +:8] | ({8{s31[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s33[28]}}) | {8{s28[28]}});
        assign result1[29 * 8 +:8] = s36[93 * 8 +:8] | s35[93 * 8 +:8] | ({8{s31[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s33[29]}}) | {8{s28[29]}});
        assign result1[30 * 8 +:8] = s36[94 * 8 +:8] | s35[94 * 8 +:8] | ({8{s31[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s33[30]}}) | {8{s28[30]}});
        assign result1[31 * 8 +:8] = s36[95 * 8 +:8] | s35[95 * 8 +:8] | ({8{s31[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s33[31]}}) | {8{s28[31]}});
        assign result1[32 * 8 +:8] = s36[96 * 8 +:8] | s35[96 * 8 +:8] | ({8{s31[32]}} & s34[32 * 8 +:8]) | ((s0[32 * 8 +:8] & {8{s33[32]}}) | {8{s28[32]}});
        assign result1[33 * 8 +:8] = s36[97 * 8 +:8] | s35[97 * 8 +:8] | ({8{s31[33]}} & s34[33 * 8 +:8]) | ((s0[33 * 8 +:8] & {8{s33[33]}}) | {8{s28[33]}});
        assign result1[34 * 8 +:8] = s36[98 * 8 +:8] | s35[98 * 8 +:8] | ({8{s31[34]}} & s34[34 * 8 +:8]) | ((s0[34 * 8 +:8] & {8{s33[34]}}) | {8{s28[34]}});
        assign result1[35 * 8 +:8] = s36[99 * 8 +:8] | s35[99 * 8 +:8] | ({8{s31[35]}} & s34[35 * 8 +:8]) | ((s0[35 * 8 +:8] & {8{s33[35]}}) | {8{s28[35]}});
        assign result1[36 * 8 +:8] = s36[100 * 8 +:8] | s35[100 * 8 +:8] | ({8{s31[36]}} & s34[36 * 8 +:8]) | ((s0[36 * 8 +:8] & {8{s33[36]}}) | {8{s28[36]}});
        assign result1[37 * 8 +:8] = s36[101 * 8 +:8] | s35[101 * 8 +:8] | ({8{s31[37]}} & s34[37 * 8 +:8]) | ((s0[37 * 8 +:8] & {8{s33[37]}}) | {8{s28[37]}});
        assign result1[38 * 8 +:8] = s36[102 * 8 +:8] | s35[102 * 8 +:8] | ({8{s31[38]}} & s34[38 * 8 +:8]) | ((s0[38 * 8 +:8] & {8{s33[38]}}) | {8{s28[38]}});
        assign result1[39 * 8 +:8] = s36[103 * 8 +:8] | s35[103 * 8 +:8] | ({8{s31[39]}} & s34[39 * 8 +:8]) | ((s0[39 * 8 +:8] & {8{s33[39]}}) | {8{s28[39]}});
        assign result1[40 * 8 +:8] = s36[104 * 8 +:8] | s35[104 * 8 +:8] | ({8{s31[40]}} & s34[40 * 8 +:8]) | ((s0[40 * 8 +:8] & {8{s33[40]}}) | {8{s28[40]}});
        assign result1[41 * 8 +:8] = s36[105 * 8 +:8] | s35[105 * 8 +:8] | ({8{s31[41]}} & s34[41 * 8 +:8]) | ((s0[41 * 8 +:8] & {8{s33[41]}}) | {8{s28[41]}});
        assign result1[42 * 8 +:8] = s36[106 * 8 +:8] | s35[106 * 8 +:8] | ({8{s31[42]}} & s34[42 * 8 +:8]) | ((s0[42 * 8 +:8] & {8{s33[42]}}) | {8{s28[42]}});
        assign result1[43 * 8 +:8] = s36[107 * 8 +:8] | s35[107 * 8 +:8] | ({8{s31[43]}} & s34[43 * 8 +:8]) | ((s0[43 * 8 +:8] & {8{s33[43]}}) | {8{s28[43]}});
        assign result1[44 * 8 +:8] = s36[108 * 8 +:8] | s35[108 * 8 +:8] | ({8{s31[44]}} & s34[44 * 8 +:8]) | ((s0[44 * 8 +:8] & {8{s33[44]}}) | {8{s28[44]}});
        assign result1[45 * 8 +:8] = s36[109 * 8 +:8] | s35[109 * 8 +:8] | ({8{s31[45]}} & s34[45 * 8 +:8]) | ((s0[45 * 8 +:8] & {8{s33[45]}}) | {8{s28[45]}});
        assign result1[46 * 8 +:8] = s36[110 * 8 +:8] | s35[110 * 8 +:8] | ({8{s31[46]}} & s34[46 * 8 +:8]) | ((s0[46 * 8 +:8] & {8{s33[46]}}) | {8{s28[46]}});
        assign result1[47 * 8 +:8] = s36[111 * 8 +:8] | s35[111 * 8 +:8] | ({8{s31[47]}} & s34[47 * 8 +:8]) | ((s0[47 * 8 +:8] & {8{s33[47]}}) | {8{s28[47]}});
        assign result1[48 * 8 +:8] = s36[112 * 8 +:8] | s35[112 * 8 +:8] | ({8{s31[48]}} & s34[48 * 8 +:8]) | ((s0[48 * 8 +:8] & {8{s33[48]}}) | {8{s28[48]}});
        assign result1[49 * 8 +:8] = s36[113 * 8 +:8] | s35[113 * 8 +:8] | ({8{s31[49]}} & s34[49 * 8 +:8]) | ((s0[49 * 8 +:8] & {8{s33[49]}}) | {8{s28[49]}});
        assign result1[50 * 8 +:8] = s36[114 * 8 +:8] | s35[114 * 8 +:8] | ({8{s31[50]}} & s34[50 * 8 +:8]) | ((s0[50 * 8 +:8] & {8{s33[50]}}) | {8{s28[50]}});
        assign result1[51 * 8 +:8] = s36[115 * 8 +:8] | s35[115 * 8 +:8] | ({8{s31[51]}} & s34[51 * 8 +:8]) | ((s0[51 * 8 +:8] & {8{s33[51]}}) | {8{s28[51]}});
        assign result1[52 * 8 +:8] = s36[116 * 8 +:8] | s35[116 * 8 +:8] | ({8{s31[52]}} & s34[52 * 8 +:8]) | ((s0[52 * 8 +:8] & {8{s33[52]}}) | {8{s28[52]}});
        assign result1[53 * 8 +:8] = s36[117 * 8 +:8] | s35[117 * 8 +:8] | ({8{s31[53]}} & s34[53 * 8 +:8]) | ((s0[53 * 8 +:8] & {8{s33[53]}}) | {8{s28[53]}});
        assign result1[54 * 8 +:8] = s36[118 * 8 +:8] | s35[118 * 8 +:8] | ({8{s31[54]}} & s34[54 * 8 +:8]) | ((s0[54 * 8 +:8] & {8{s33[54]}}) | {8{s28[54]}});
        assign result1[55 * 8 +:8] = s36[119 * 8 +:8] | s35[119 * 8 +:8] | ({8{s31[55]}} & s34[55 * 8 +:8]) | ((s0[55 * 8 +:8] & {8{s33[55]}}) | {8{s28[55]}});
        assign result1[56 * 8 +:8] = s36[120 * 8 +:8] | s35[120 * 8 +:8] | ({8{s31[56]}} & s34[56 * 8 +:8]) | ((s0[56 * 8 +:8] & {8{s33[56]}}) | {8{s28[56]}});
        assign result1[57 * 8 +:8] = s36[121 * 8 +:8] | s35[121 * 8 +:8] | ({8{s31[57]}} & s34[57 * 8 +:8]) | ((s0[57 * 8 +:8] & {8{s33[57]}}) | {8{s28[57]}});
        assign result1[58 * 8 +:8] = s36[122 * 8 +:8] | s35[122 * 8 +:8] | ({8{s31[58]}} & s34[58 * 8 +:8]) | ((s0[58 * 8 +:8] & {8{s33[58]}}) | {8{s28[58]}});
        assign result1[59 * 8 +:8] = s36[123 * 8 +:8] | s35[123 * 8 +:8] | ({8{s31[59]}} & s34[59 * 8 +:8]) | ((s0[59 * 8 +:8] & {8{s33[59]}}) | {8{s28[59]}});
        assign result1[60 * 8 +:8] = s36[124 * 8 +:8] | s35[124 * 8 +:8] | ({8{s31[60]}} & s34[60 * 8 +:8]) | ((s0[60 * 8 +:8] & {8{s33[60]}}) | {8{s28[60]}});
        assign result1[61 * 8 +:8] = s36[125 * 8 +:8] | s35[125 * 8 +:8] | ({8{s31[61]}} & s34[61 * 8 +:8]) | ((s0[61 * 8 +:8] & {8{s33[61]}}) | {8{s28[61]}});
        assign result1[62 * 8 +:8] = s36[126 * 8 +:8] | s35[126 * 8 +:8] | ({8{s31[62]}} & s34[62 * 8 +:8]) | ((s0[62 * 8 +:8] & {8{s33[62]}}) | {8{s28[62]}});
        assign result1[63 * 8 +:8] = s36[127 * 8 +:8] | s35[127 * 8 +:8] | ({8{s31[63]}} & s34[63 * 8 +:8]) | ((s0[63 * 8 +:8] & {8{s33[63]}}) | {8{s28[63]}});
    end
endgenerate
generate
    if ((VLEN == 1024) && (DLEN == 1024) & (VP_LEN == 1024)) begin:gen_vlen1024_dlen1024_vplen1024
        assign s16[0] = 1'b0;
        assign s16[1] = s0[15];
        assign s16[2] = 1'b0;
        assign s16[3] = s0[31];
        assign s16[4] = 1'b0;
        assign s16[5] = s0[47];
        assign s16[6] = 1'b0;
        assign s16[7] = s0[63];
        assign s16[8] = 1'b0;
        assign s16[9] = s0[79];
        assign s16[10] = 1'b0;
        assign s16[11] = s0[95];
        assign s16[12] = 1'b0;
        assign s16[13] = s0[111];
        assign s16[14] = 1'b0;
        assign s16[15] = s0[127];
        assign s16[16] = 1'b0;
        assign s16[17] = s0[143];
        assign s16[18] = 1'b0;
        assign s16[19] = s0[159];
        assign s16[20] = 1'b0;
        assign s16[21] = s0[175];
        assign s16[22] = 1'b0;
        assign s16[23] = s0[191];
        assign s16[24] = 1'b0;
        assign s16[25] = s0[207];
        assign s16[26] = 1'b0;
        assign s16[27] = s0[223];
        assign s16[28] = 1'b0;
        assign s16[29] = s0[239];
        assign s16[30] = 1'b0;
        assign s16[31] = s0[255];
        assign s16[32] = 1'b0;
        assign s16[33] = s0[271];
        assign s16[34] = 1'b0;
        assign s16[35] = s0[287];
        assign s16[36] = 1'b0;
        assign s16[37] = s0[303];
        assign s16[38] = 1'b0;
        assign s16[39] = s0[319];
        assign s16[40] = 1'b0;
        assign s16[41] = s0[335];
        assign s16[42] = 1'b0;
        assign s16[43] = s0[351];
        assign s16[44] = 1'b0;
        assign s16[45] = s0[367];
        assign s16[46] = 1'b0;
        assign s16[47] = s0[383];
        assign s16[48] = 1'b0;
        assign s16[49] = s0[399];
        assign s16[50] = 1'b0;
        assign s16[51] = s0[415];
        assign s16[52] = 1'b0;
        assign s16[53] = s0[431];
        assign s16[54] = 1'b0;
        assign s16[55] = s0[447];
        assign s16[56] = 1'b0;
        assign s16[57] = s0[463];
        assign s16[58] = 1'b0;
        assign s16[59] = s0[479];
        assign s16[60] = 1'b0;
        assign s16[61] = s0[495];
        assign s16[62] = 1'b0;
        assign s16[63] = s0[511];
        assign s16[64] = 1'b0;
        assign s16[65] = s0[527];
        assign s16[66] = 1'b0;
        assign s16[67] = s0[543];
        assign s16[68] = 1'b0;
        assign s16[69] = s0[559];
        assign s16[70] = 1'b0;
        assign s16[71] = s0[575];
        assign s16[72] = 1'b0;
        assign s16[73] = s0[591];
        assign s16[74] = 1'b0;
        assign s16[75] = s0[607];
        assign s16[76] = 1'b0;
        assign s16[77] = s0[623];
        assign s16[78] = 1'b0;
        assign s16[79] = s0[639];
        assign s16[80] = 1'b0;
        assign s16[81] = s0[655];
        assign s16[82] = 1'b0;
        assign s16[83] = s0[671];
        assign s16[84] = 1'b0;
        assign s16[85] = s0[687];
        assign s16[86] = 1'b0;
        assign s16[87] = s0[703];
        assign s16[88] = 1'b0;
        assign s16[89] = s0[719];
        assign s16[90] = 1'b0;
        assign s16[91] = s0[735];
        assign s16[92] = 1'b0;
        assign s16[93] = s0[751];
        assign s16[94] = 1'b0;
        assign s16[95] = s0[767];
        assign s16[96] = 1'b0;
        assign s16[97] = s0[783];
        assign s16[98] = 1'b0;
        assign s16[99] = s0[799];
        assign s16[100] = 1'b0;
        assign s16[101] = s0[815];
        assign s16[102] = 1'b0;
        assign s16[103] = s0[831];
        assign s16[104] = 1'b0;
        assign s16[105] = s0[847];
        assign s16[106] = 1'b0;
        assign s16[107] = s0[863];
        assign s16[108] = 1'b0;
        assign s16[109] = s0[879];
        assign s16[110] = 1'b0;
        assign s16[111] = s0[895];
        assign s16[112] = 1'b0;
        assign s16[113] = s0[911];
        assign s16[114] = 1'b0;
        assign s16[115] = s0[927];
        assign s16[116] = 1'b0;
        assign s16[117] = s0[943];
        assign s16[118] = 1'b0;
        assign s16[119] = s0[959];
        assign s16[120] = 1'b0;
        assign s16[121] = s0[975];
        assign s16[122] = 1'b0;
        assign s16[123] = s0[991];
        assign s16[124] = 1'b0;
        assign s16[125] = s0[1007];
        assign s16[126] = 1'b0;
        assign s16[127] = s0[1023];
        assign s17[0] = 1'b0;
        assign s17[1] = s0[15];
        assign s17[2] = s0[23];
        assign s17[3] = s0[31];
        assign s17[4] = 1'b0;
        assign s17[5] = s0[47];
        assign s17[6] = s0[55];
        assign s17[7] = s0[63];
        assign s17[8] = 1'b0;
        assign s17[9] = s0[79];
        assign s17[10] = s0[87];
        assign s17[11] = s0[95];
        assign s17[12] = 1'b0;
        assign s17[13] = s0[111];
        assign s17[14] = s0[119];
        assign s17[15] = s0[127];
        assign s17[16] = 1'b0;
        assign s17[17] = s0[143];
        assign s17[18] = s0[151];
        assign s17[19] = s0[159];
        assign s17[20] = 1'b0;
        assign s17[21] = s0[175];
        assign s17[22] = s0[183];
        assign s17[23] = s0[191];
        assign s17[24] = 1'b0;
        assign s17[25] = s0[207];
        assign s17[26] = s0[215];
        assign s17[27] = s0[223];
        assign s17[28] = 1'b0;
        assign s17[29] = s0[239];
        assign s17[30] = s0[247];
        assign s17[31] = s0[255];
        assign s17[32] = 1'b0;
        assign s17[33] = s0[271];
        assign s17[34] = s0[279];
        assign s17[35] = s0[287];
        assign s17[36] = 1'b0;
        assign s17[37] = s0[303];
        assign s17[38] = s0[311];
        assign s17[39] = s0[319];
        assign s17[40] = 1'b0;
        assign s17[41] = s0[335];
        assign s17[42] = s0[343];
        assign s17[43] = s0[351];
        assign s17[44] = 1'b0;
        assign s17[45] = s0[367];
        assign s17[46] = s0[375];
        assign s17[47] = s0[383];
        assign s17[48] = 1'b0;
        assign s17[49] = s0[399];
        assign s17[50] = s0[407];
        assign s17[51] = s0[415];
        assign s17[52] = 1'b0;
        assign s17[53] = s0[431];
        assign s17[54] = s0[439];
        assign s17[55] = s0[447];
        assign s17[56] = 1'b0;
        assign s17[57] = s0[463];
        assign s17[58] = s0[471];
        assign s17[59] = s0[479];
        assign s17[60] = 1'b0;
        assign s17[61] = s0[495];
        assign s17[62] = s0[503];
        assign s17[63] = s0[511];
        assign s17[64] = 1'b0;
        assign s17[65] = s0[527];
        assign s17[66] = s0[535];
        assign s17[67] = s0[543];
        assign s17[68] = 1'b0;
        assign s17[69] = s0[559];
        assign s17[70] = s0[567];
        assign s17[71] = s0[575];
        assign s17[72] = 1'b0;
        assign s17[73] = s0[591];
        assign s17[74] = s0[599];
        assign s17[75] = s0[607];
        assign s17[76] = 1'b0;
        assign s17[77] = s0[623];
        assign s17[78] = s0[631];
        assign s17[79] = s0[639];
        assign s17[80] = 1'b0;
        assign s17[81] = s0[655];
        assign s17[82] = s0[663];
        assign s17[83] = s0[671];
        assign s17[84] = 1'b0;
        assign s17[85] = s0[687];
        assign s17[86] = s0[695];
        assign s17[87] = s0[703];
        assign s17[88] = 1'b0;
        assign s17[89] = s0[719];
        assign s17[90] = s0[727];
        assign s17[91] = s0[735];
        assign s17[92] = 1'b0;
        assign s17[93] = s0[751];
        assign s17[94] = s0[759];
        assign s17[95] = s0[767];
        assign s17[96] = 1'b0;
        assign s17[97] = s0[783];
        assign s17[98] = s0[791];
        assign s17[99] = s0[799];
        assign s17[100] = 1'b0;
        assign s17[101] = s0[815];
        assign s17[102] = s0[823];
        assign s17[103] = s0[831];
        assign s17[104] = 1'b0;
        assign s17[105] = s0[847];
        assign s17[106] = s0[855];
        assign s17[107] = s0[863];
        assign s17[108] = 1'b0;
        assign s17[109] = s0[879];
        assign s17[110] = s0[887];
        assign s17[111] = s0[895];
        assign s17[112] = 1'b0;
        assign s17[113] = s0[911];
        assign s17[114] = s0[919];
        assign s17[115] = s0[927];
        assign s17[116] = 1'b0;
        assign s17[117] = s0[943];
        assign s17[118] = s0[951];
        assign s17[119] = s0[959];
        assign s17[120] = 1'b0;
        assign s17[121] = s0[975];
        assign s17[122] = s0[983];
        assign s17[123] = s0[991];
        assign s17[124] = 1'b0;
        assign s17[125] = s0[1007];
        assign s17[126] = s0[1015];
        assign s17[127] = s0[1023];
        assign s22[0] = 1'b0;
        assign s18[0] = 1'b0;
        assign s22[1] = s0[15];
        assign s18[1] = s0[15];
        assign s22[2] = s0[23];
        assign s18[2] = s0[23];
        assign s22[3] = s0[31];
        assign s18[3] = s0[31];
        assign s22[4] = s0[39];
        assign s18[4] = s0[39];
        assign s22[5] = s0[47];
        assign s18[5] = s0[47];
        assign s22[6] = s0[55];
        assign s18[6] = s0[55];
        assign s22[7] = s0[63];
        assign s18[7] = s0[63];
        assign s22[8] = 1'b0;
        assign s18[8] = 1'b0;
        assign s22[9] = s0[79];
        assign s18[9] = s0[79];
        assign s22[10] = s0[87];
        assign s18[10] = s0[87];
        assign s22[11] = s0[95];
        assign s18[11] = s0[95];
        assign s22[12] = s0[103];
        assign s18[12] = s0[103];
        assign s22[13] = s0[111];
        assign s18[13] = s0[111];
        assign s22[14] = s0[119];
        assign s18[14] = s0[119];
        assign s22[15] = s0[127];
        assign s18[15] = s0[127];
        assign s22[16] = 1'b0;
        assign s18[16] = 1'b0;
        assign s22[17] = s0[143];
        assign s18[17] = s0[143];
        assign s22[18] = s0[151];
        assign s18[18] = s0[151];
        assign s22[19] = s0[159];
        assign s18[19] = s0[159];
        assign s22[20] = s0[167];
        assign s18[20] = s0[167];
        assign s22[21] = s0[175];
        assign s18[21] = s0[175];
        assign s22[22] = s0[183];
        assign s18[22] = s0[183];
        assign s22[23] = s0[191];
        assign s18[23] = s0[191];
        assign s22[24] = 1'b0;
        assign s18[24] = 1'b0;
        assign s22[25] = s0[207];
        assign s18[25] = s0[207];
        assign s22[26] = s0[215];
        assign s18[26] = s0[215];
        assign s22[27] = s0[223];
        assign s18[27] = s0[223];
        assign s22[28] = s0[231];
        assign s18[28] = s0[231];
        assign s22[29] = s0[239];
        assign s18[29] = s0[239];
        assign s22[30] = s0[247];
        assign s18[30] = s0[247];
        assign s22[31] = s0[255];
        assign s18[31] = s0[255];
        assign s22[32] = 1'b0;
        assign s18[32] = 1'b0;
        assign s22[33] = s0[271];
        assign s18[33] = s0[271];
        assign s22[34] = s0[279];
        assign s18[34] = s0[279];
        assign s22[35] = s0[287];
        assign s18[35] = s0[287];
        assign s22[36] = s0[295];
        assign s18[36] = s0[295];
        assign s22[37] = s0[303];
        assign s18[37] = s0[303];
        assign s22[38] = s0[311];
        assign s18[38] = s0[311];
        assign s22[39] = s0[319];
        assign s18[39] = s0[319];
        assign s22[40] = 1'b0;
        assign s18[40] = 1'b0;
        assign s22[41] = s0[335];
        assign s18[41] = s0[335];
        assign s22[42] = s0[343];
        assign s18[42] = s0[343];
        assign s22[43] = s0[351];
        assign s18[43] = s0[351];
        assign s22[44] = s0[359];
        assign s18[44] = s0[359];
        assign s22[45] = s0[367];
        assign s18[45] = s0[367];
        assign s22[46] = s0[375];
        assign s18[46] = s0[375];
        assign s22[47] = s0[383];
        assign s18[47] = s0[383];
        assign s22[48] = 1'b0;
        assign s18[48] = 1'b0;
        assign s22[49] = s0[399];
        assign s18[49] = s0[399];
        assign s22[50] = s0[407];
        assign s18[50] = s0[407];
        assign s22[51] = s0[415];
        assign s18[51] = s0[415];
        assign s22[52] = s0[423];
        assign s18[52] = s0[423];
        assign s22[53] = s0[431];
        assign s18[53] = s0[431];
        assign s22[54] = s0[439];
        assign s18[54] = s0[439];
        assign s22[55] = s0[447];
        assign s18[55] = s0[447];
        assign s22[56] = 1'b0;
        assign s18[56] = 1'b0;
        assign s22[57] = s0[463];
        assign s18[57] = s0[463];
        assign s22[58] = s0[471];
        assign s18[58] = s0[471];
        assign s22[59] = s0[479];
        assign s18[59] = s0[479];
        assign s22[60] = s0[487];
        assign s18[60] = s0[487];
        assign s22[61] = s0[495];
        assign s18[61] = s0[495];
        assign s22[62] = s0[503];
        assign s18[62] = s0[503];
        assign s22[63] = s0[511];
        assign s18[63] = s0[511];
        assign s22[64] = 1'b0;
        assign s18[64] = 1'b0;
        assign s22[65] = s0[527];
        assign s18[65] = s0[527];
        assign s22[66] = s0[535];
        assign s18[66] = s0[535];
        assign s22[67] = s0[543];
        assign s18[67] = s0[543];
        assign s22[68] = s0[551];
        assign s18[68] = s0[551];
        assign s22[69] = s0[559];
        assign s18[69] = s0[559];
        assign s22[70] = s0[567];
        assign s18[70] = s0[567];
        assign s22[71] = s0[575];
        assign s18[71] = s0[575];
        assign s22[72] = 1'b0;
        assign s18[72] = 1'b0;
        assign s22[73] = s0[591];
        assign s18[73] = s0[591];
        assign s22[74] = s0[599];
        assign s18[74] = s0[599];
        assign s22[75] = s0[607];
        assign s18[75] = s0[607];
        assign s22[76] = s0[615];
        assign s18[76] = s0[615];
        assign s22[77] = s0[623];
        assign s18[77] = s0[623];
        assign s22[78] = s0[631];
        assign s18[78] = s0[631];
        assign s22[79] = s0[639];
        assign s18[79] = s0[639];
        assign s22[80] = 1'b0;
        assign s18[80] = 1'b0;
        assign s22[81] = s0[655];
        assign s18[81] = s0[655];
        assign s22[82] = s0[663];
        assign s18[82] = s0[663];
        assign s22[83] = s0[671];
        assign s18[83] = s0[671];
        assign s22[84] = s0[679];
        assign s18[84] = s0[679];
        assign s22[85] = s0[687];
        assign s18[85] = s0[687];
        assign s22[86] = s0[695];
        assign s18[86] = s0[695];
        assign s22[87] = s0[703];
        assign s18[87] = s0[703];
        assign s22[88] = 1'b0;
        assign s18[88] = 1'b0;
        assign s22[89] = s0[719];
        assign s18[89] = s0[719];
        assign s22[90] = s0[727];
        assign s18[90] = s0[727];
        assign s22[91] = s0[735];
        assign s18[91] = s0[735];
        assign s22[92] = s0[743];
        assign s18[92] = s0[743];
        assign s22[93] = s0[751];
        assign s18[93] = s0[751];
        assign s22[94] = s0[759];
        assign s18[94] = s0[759];
        assign s22[95] = s0[767];
        assign s18[95] = s0[767];
        assign s22[96] = 1'b0;
        assign s18[96] = 1'b0;
        assign s22[97] = s0[783];
        assign s18[97] = s0[783];
        assign s22[98] = s0[791];
        assign s18[98] = s0[791];
        assign s22[99] = s0[799];
        assign s18[99] = s0[799];
        assign s22[100] = s0[807];
        assign s18[100] = s0[807];
        assign s22[101] = s0[815];
        assign s18[101] = s0[815];
        assign s22[102] = s0[823];
        assign s18[102] = s0[823];
        assign s22[103] = s0[831];
        assign s18[103] = s0[831];
        assign s22[104] = 1'b0;
        assign s18[104] = 1'b0;
        assign s22[105] = s0[847];
        assign s18[105] = s0[847];
        assign s22[106] = s0[855];
        assign s18[106] = s0[855];
        assign s22[107] = s0[863];
        assign s18[107] = s0[863];
        assign s22[108] = s0[871];
        assign s18[108] = s0[871];
        assign s22[109] = s0[879];
        assign s18[109] = s0[879];
        assign s22[110] = s0[887];
        assign s18[110] = s0[887];
        assign s22[111] = s0[895];
        assign s18[111] = s0[895];
        assign s22[112] = 1'b0;
        assign s18[112] = 1'b0;
        assign s22[113] = s0[911];
        assign s18[113] = s0[911];
        assign s22[114] = s0[919];
        assign s18[114] = s0[919];
        assign s22[115] = s0[927];
        assign s18[115] = s0[927];
        assign s22[116] = s0[935];
        assign s18[116] = s0[935];
        assign s22[117] = s0[943];
        assign s18[117] = s0[943];
        assign s22[118] = s0[951];
        assign s18[118] = s0[951];
        assign s22[119] = s0[959];
        assign s18[119] = s0[959];
        assign s22[120] = 1'b0;
        assign s18[120] = 1'b0;
        assign s22[121] = s0[975];
        assign s18[121] = s0[975];
        assign s22[122] = s0[983];
        assign s18[122] = s0[983];
        assign s22[123] = s0[991];
        assign s18[123] = s0[991];
        assign s22[124] = s0[999];
        assign s18[124] = s0[999];
        assign s22[125] = s0[1007];
        assign s18[125] = s0[1007];
        assign s22[126] = s0[1015];
        assign s18[126] = s0[1015];
        assign s22[127] = s0[1023];
        assign s18[127] = s0[1023];
        assign s25[0 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[1 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[2 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[3 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[4 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[5 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[6 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[7 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[8 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[9 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[10 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[11 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[12 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[13 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[14 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s25[15 * 8 +:8] = {{7{1'b1}},{1{1'b0}}};
        assign s19[0] = 1'b0;
        assign s19[1] = 1'b0;
        assign s19[2] = s0[23];
        assign s19[3] = s0[31];
        assign s19[4] = 1'b0;
        assign s19[5] = 1'b0;
        assign s19[6] = s0[55];
        assign s19[7] = s0[63];
        assign s19[8] = 1'b0;
        assign s19[9] = 1'b0;
        assign s19[10] = s0[87];
        assign s19[11] = s0[95];
        assign s19[12] = 1'b0;
        assign s19[13] = 1'b0;
        assign s19[14] = s0[119];
        assign s19[15] = s0[127];
        assign s19[16] = 1'b0;
        assign s19[17] = 1'b0;
        assign s19[18] = s0[151];
        assign s19[19] = s0[159];
        assign s19[20] = 1'b0;
        assign s19[21] = 1'b0;
        assign s19[22] = s0[183];
        assign s19[23] = s0[191];
        assign s19[24] = 1'b0;
        assign s19[25] = 1'b0;
        assign s19[26] = s0[215];
        assign s19[27] = s0[223];
        assign s19[28] = 1'b0;
        assign s19[29] = 1'b0;
        assign s19[30] = s0[247];
        assign s19[31] = s0[255];
        assign s19[32] = 1'b0;
        assign s19[33] = 1'b0;
        assign s19[34] = s0[279];
        assign s19[35] = s0[287];
        assign s19[36] = 1'b0;
        assign s19[37] = 1'b0;
        assign s19[38] = s0[311];
        assign s19[39] = s0[319];
        assign s19[40] = 1'b0;
        assign s19[41] = 1'b0;
        assign s19[42] = s0[343];
        assign s19[43] = s0[351];
        assign s19[44] = 1'b0;
        assign s19[45] = 1'b0;
        assign s19[46] = s0[375];
        assign s19[47] = s0[383];
        assign s19[48] = 1'b0;
        assign s19[49] = 1'b0;
        assign s19[50] = s0[407];
        assign s19[51] = s0[415];
        assign s19[52] = 1'b0;
        assign s19[53] = 1'b0;
        assign s19[54] = s0[439];
        assign s19[55] = s0[447];
        assign s19[56] = 1'b0;
        assign s19[57] = 1'b0;
        assign s19[58] = s0[471];
        assign s19[59] = s0[479];
        assign s19[60] = 1'b0;
        assign s19[61] = 1'b0;
        assign s19[62] = s0[503];
        assign s19[63] = s0[511];
        assign s19[64] = 1'b0;
        assign s19[65] = 1'b0;
        assign s19[66] = s0[535];
        assign s19[67] = s0[543];
        assign s19[68] = 1'b0;
        assign s19[69] = 1'b0;
        assign s19[70] = s0[567];
        assign s19[71] = s0[575];
        assign s19[72] = 1'b0;
        assign s19[73] = 1'b0;
        assign s19[74] = s0[599];
        assign s19[75] = s0[607];
        assign s19[76] = 1'b0;
        assign s19[77] = 1'b0;
        assign s19[78] = s0[631];
        assign s19[79] = s0[639];
        assign s19[80] = 1'b0;
        assign s19[81] = 1'b0;
        assign s19[82] = s0[663];
        assign s19[83] = s0[671];
        assign s19[84] = 1'b0;
        assign s19[85] = 1'b0;
        assign s19[86] = s0[695];
        assign s19[87] = s0[703];
        assign s19[88] = 1'b0;
        assign s19[89] = 1'b0;
        assign s19[90] = s0[727];
        assign s19[91] = s0[735];
        assign s19[92] = 1'b0;
        assign s19[93] = 1'b0;
        assign s19[94] = s0[759];
        assign s19[95] = s0[767];
        assign s19[96] = 1'b0;
        assign s19[97] = 1'b0;
        assign s19[98] = s0[791];
        assign s19[99] = s0[799];
        assign s19[100] = 1'b0;
        assign s19[101] = 1'b0;
        assign s19[102] = s0[823];
        assign s19[103] = s0[831];
        assign s19[104] = 1'b0;
        assign s19[105] = 1'b0;
        assign s19[106] = s0[855];
        assign s19[107] = s0[863];
        assign s19[108] = 1'b0;
        assign s19[109] = 1'b0;
        assign s19[110] = s0[887];
        assign s19[111] = s0[895];
        assign s19[112] = 1'b0;
        assign s19[113] = 1'b0;
        assign s19[114] = s0[919];
        assign s19[115] = s0[927];
        assign s19[116] = 1'b0;
        assign s19[117] = 1'b0;
        assign s19[118] = s0[951];
        assign s19[119] = s0[959];
        assign s19[120] = 1'b0;
        assign s19[121] = 1'b0;
        assign s19[122] = s0[983];
        assign s19[123] = s0[991];
        assign s19[124] = 1'b0;
        assign s19[125] = 1'b0;
        assign s19[126] = s0[1015];
        assign s19[127] = s0[1023];
        assign s23[0] = 1'b0;
        assign s20[0] = 1'b0;
        assign s23[1] = 1'b0;
        assign s20[1] = 1'b0;
        assign s23[2] = s0[23];
        assign s20[2] = s0[23];
        assign s23[3] = s0[31];
        assign s20[3] = s0[31];
        assign s23[4] = s0[39];
        assign s20[4] = s0[39];
        assign s23[5] = s0[47];
        assign s20[5] = s0[47];
        assign s23[6] = s0[55];
        assign s20[6] = s0[55];
        assign s23[7] = s0[63];
        assign s20[7] = s0[63];
        assign s23[8] = 1'b0;
        assign s20[8] = 1'b0;
        assign s23[9] = 1'b0;
        assign s20[9] = 1'b0;
        assign s23[10] = s0[87];
        assign s20[10] = s0[87];
        assign s23[11] = s0[95];
        assign s20[11] = s0[95];
        assign s23[12] = s0[103];
        assign s20[12] = s0[103];
        assign s23[13] = s0[111];
        assign s20[13] = s0[111];
        assign s23[14] = s0[119];
        assign s20[14] = s0[119];
        assign s23[15] = s0[127];
        assign s20[15] = s0[127];
        assign s23[16] = 1'b0;
        assign s20[16] = 1'b0;
        assign s23[17] = 1'b0;
        assign s20[17] = 1'b0;
        assign s23[18] = s0[151];
        assign s20[18] = s0[151];
        assign s23[19] = s0[159];
        assign s20[19] = s0[159];
        assign s23[20] = s0[167];
        assign s20[20] = s0[167];
        assign s23[21] = s0[175];
        assign s20[21] = s0[175];
        assign s23[22] = s0[183];
        assign s20[22] = s0[183];
        assign s23[23] = s0[191];
        assign s20[23] = s0[191];
        assign s23[24] = 1'b0;
        assign s20[24] = 1'b0;
        assign s23[25] = 1'b0;
        assign s20[25] = 1'b0;
        assign s23[26] = s0[215];
        assign s20[26] = s0[215];
        assign s23[27] = s0[223];
        assign s20[27] = s0[223];
        assign s23[28] = s0[231];
        assign s20[28] = s0[231];
        assign s23[29] = s0[239];
        assign s20[29] = s0[239];
        assign s23[30] = s0[247];
        assign s20[30] = s0[247];
        assign s23[31] = s0[255];
        assign s20[31] = s0[255];
        assign s23[32] = 1'b0;
        assign s20[32] = 1'b0;
        assign s23[33] = 1'b0;
        assign s20[33] = 1'b0;
        assign s23[34] = s0[279];
        assign s20[34] = s0[279];
        assign s23[35] = s0[287];
        assign s20[35] = s0[287];
        assign s23[36] = s0[295];
        assign s20[36] = s0[295];
        assign s23[37] = s0[303];
        assign s20[37] = s0[303];
        assign s23[38] = s0[311];
        assign s20[38] = s0[311];
        assign s23[39] = s0[319];
        assign s20[39] = s0[319];
        assign s23[40] = 1'b0;
        assign s20[40] = 1'b0;
        assign s23[41] = 1'b0;
        assign s20[41] = 1'b0;
        assign s23[42] = s0[343];
        assign s20[42] = s0[343];
        assign s23[43] = s0[351];
        assign s20[43] = s0[351];
        assign s23[44] = s0[359];
        assign s20[44] = s0[359];
        assign s23[45] = s0[367];
        assign s20[45] = s0[367];
        assign s23[46] = s0[375];
        assign s20[46] = s0[375];
        assign s23[47] = s0[383];
        assign s20[47] = s0[383];
        assign s23[48] = 1'b0;
        assign s20[48] = 1'b0;
        assign s23[49] = 1'b0;
        assign s20[49] = 1'b0;
        assign s23[50] = s0[407];
        assign s20[50] = s0[407];
        assign s23[51] = s0[415];
        assign s20[51] = s0[415];
        assign s23[52] = s0[423];
        assign s20[52] = s0[423];
        assign s23[53] = s0[431];
        assign s20[53] = s0[431];
        assign s23[54] = s0[439];
        assign s20[54] = s0[439];
        assign s23[55] = s0[447];
        assign s20[55] = s0[447];
        assign s23[56] = 1'b0;
        assign s20[56] = 1'b0;
        assign s23[57] = 1'b0;
        assign s20[57] = 1'b0;
        assign s23[58] = s0[471];
        assign s20[58] = s0[471];
        assign s23[59] = s0[479];
        assign s20[59] = s0[479];
        assign s23[60] = s0[487];
        assign s20[60] = s0[487];
        assign s23[61] = s0[495];
        assign s20[61] = s0[495];
        assign s23[62] = s0[503];
        assign s20[62] = s0[503];
        assign s23[63] = s0[511];
        assign s20[63] = s0[511];
        assign s23[64] = 1'b0;
        assign s20[64] = 1'b0;
        assign s23[65] = 1'b0;
        assign s20[65] = 1'b0;
        assign s23[66] = s0[535];
        assign s20[66] = s0[535];
        assign s23[67] = s0[543];
        assign s20[67] = s0[543];
        assign s23[68] = s0[551];
        assign s20[68] = s0[551];
        assign s23[69] = s0[559];
        assign s20[69] = s0[559];
        assign s23[70] = s0[567];
        assign s20[70] = s0[567];
        assign s23[71] = s0[575];
        assign s20[71] = s0[575];
        assign s23[72] = 1'b0;
        assign s20[72] = 1'b0;
        assign s23[73] = 1'b0;
        assign s20[73] = 1'b0;
        assign s23[74] = s0[599];
        assign s20[74] = s0[599];
        assign s23[75] = s0[607];
        assign s20[75] = s0[607];
        assign s23[76] = s0[615];
        assign s20[76] = s0[615];
        assign s23[77] = s0[623];
        assign s20[77] = s0[623];
        assign s23[78] = s0[631];
        assign s20[78] = s0[631];
        assign s23[79] = s0[639];
        assign s20[79] = s0[639];
        assign s23[80] = 1'b0;
        assign s20[80] = 1'b0;
        assign s23[81] = 1'b0;
        assign s20[81] = 1'b0;
        assign s23[82] = s0[663];
        assign s20[82] = s0[663];
        assign s23[83] = s0[671];
        assign s20[83] = s0[671];
        assign s23[84] = s0[679];
        assign s20[84] = s0[679];
        assign s23[85] = s0[687];
        assign s20[85] = s0[687];
        assign s23[86] = s0[695];
        assign s20[86] = s0[695];
        assign s23[87] = s0[703];
        assign s20[87] = s0[703];
        assign s23[88] = 1'b0;
        assign s20[88] = 1'b0;
        assign s23[89] = 1'b0;
        assign s20[89] = 1'b0;
        assign s23[90] = s0[727];
        assign s20[90] = s0[727];
        assign s23[91] = s0[735];
        assign s20[91] = s0[735];
        assign s23[92] = s0[743];
        assign s20[92] = s0[743];
        assign s23[93] = s0[751];
        assign s20[93] = s0[751];
        assign s23[94] = s0[759];
        assign s20[94] = s0[759];
        assign s23[95] = s0[767];
        assign s20[95] = s0[767];
        assign s23[96] = 1'b0;
        assign s20[96] = 1'b0;
        assign s23[97] = 1'b0;
        assign s20[97] = 1'b0;
        assign s23[98] = s0[791];
        assign s20[98] = s0[791];
        assign s23[99] = s0[799];
        assign s20[99] = s0[799];
        assign s23[100] = s0[807];
        assign s20[100] = s0[807];
        assign s23[101] = s0[815];
        assign s20[101] = s0[815];
        assign s23[102] = s0[823];
        assign s20[102] = s0[823];
        assign s23[103] = s0[831];
        assign s20[103] = s0[831];
        assign s23[104] = 1'b0;
        assign s20[104] = 1'b0;
        assign s23[105] = 1'b0;
        assign s20[105] = 1'b0;
        assign s23[106] = s0[855];
        assign s20[106] = s0[855];
        assign s23[107] = s0[863];
        assign s20[107] = s0[863];
        assign s23[108] = s0[871];
        assign s20[108] = s0[871];
        assign s23[109] = s0[879];
        assign s20[109] = s0[879];
        assign s23[110] = s0[887];
        assign s20[110] = s0[887];
        assign s23[111] = s0[895];
        assign s20[111] = s0[895];
        assign s23[112] = 1'b0;
        assign s20[112] = 1'b0;
        assign s23[113] = 1'b0;
        assign s20[113] = 1'b0;
        assign s23[114] = s0[919];
        assign s20[114] = s0[919];
        assign s23[115] = s0[927];
        assign s20[115] = s0[927];
        assign s23[116] = s0[935];
        assign s20[116] = s0[935];
        assign s23[117] = s0[943];
        assign s20[117] = s0[943];
        assign s23[118] = s0[951];
        assign s20[118] = s0[951];
        assign s23[119] = s0[959];
        assign s20[119] = s0[959];
        assign s23[120] = 1'b0;
        assign s20[120] = 1'b0;
        assign s23[121] = 1'b0;
        assign s20[121] = 1'b0;
        assign s23[122] = s0[983];
        assign s20[122] = s0[983];
        assign s23[123] = s0[991];
        assign s20[123] = s0[991];
        assign s23[124] = s0[999];
        assign s20[124] = s0[999];
        assign s23[125] = s0[1007];
        assign s20[125] = s0[1007];
        assign s23[126] = s0[1015];
        assign s20[126] = s0[1015];
        assign s23[127] = s0[1023];
        assign s20[127] = s0[1023];
        assign s26[0 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[1 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[2 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[3 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[4 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[5 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[6 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[7 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[8 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[9 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[10 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[11 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[12 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[13 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[14 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s26[15 * 8 +:8] = {{6{1'b1}},{2{1'b0}}};
        assign s24[0] = 1'b0;
        assign s21[0] = 1'b0;
        assign s24[1] = 1'b0;
        assign s21[1] = 1'b0;
        assign s24[2] = 1'b0;
        assign s21[2] = 1'b0;
        assign s24[3] = 1'b0;
        assign s21[3] = 1'b0;
        assign s24[4] = s0[39];
        assign s21[4] = s0[39];
        assign s24[5] = s0[47];
        assign s21[5] = s0[47];
        assign s24[6] = s0[55];
        assign s21[6] = s0[55];
        assign s24[7] = s0[63];
        assign s21[7] = s0[63];
        assign s24[8] = 1'b0;
        assign s21[8] = 1'b0;
        assign s24[9] = 1'b0;
        assign s21[9] = 1'b0;
        assign s24[10] = 1'b0;
        assign s21[10] = 1'b0;
        assign s24[11] = 1'b0;
        assign s21[11] = 1'b0;
        assign s24[12] = s0[103];
        assign s21[12] = s0[103];
        assign s24[13] = s0[111];
        assign s21[13] = s0[111];
        assign s24[14] = s0[119];
        assign s21[14] = s0[119];
        assign s24[15] = s0[127];
        assign s21[15] = s0[127];
        assign s24[16] = 1'b0;
        assign s21[16] = 1'b0;
        assign s24[17] = 1'b0;
        assign s21[17] = 1'b0;
        assign s24[18] = 1'b0;
        assign s21[18] = 1'b0;
        assign s24[19] = 1'b0;
        assign s21[19] = 1'b0;
        assign s24[20] = s0[167];
        assign s21[20] = s0[167];
        assign s24[21] = s0[175];
        assign s21[21] = s0[175];
        assign s24[22] = s0[183];
        assign s21[22] = s0[183];
        assign s24[23] = s0[191];
        assign s21[23] = s0[191];
        assign s24[24] = 1'b0;
        assign s21[24] = 1'b0;
        assign s24[25] = 1'b0;
        assign s21[25] = 1'b0;
        assign s24[26] = 1'b0;
        assign s21[26] = 1'b0;
        assign s24[27] = 1'b0;
        assign s21[27] = 1'b0;
        assign s24[28] = s0[231];
        assign s21[28] = s0[231];
        assign s24[29] = s0[239];
        assign s21[29] = s0[239];
        assign s24[30] = s0[247];
        assign s21[30] = s0[247];
        assign s24[31] = s0[255];
        assign s21[31] = s0[255];
        assign s24[32] = 1'b0;
        assign s21[32] = 1'b0;
        assign s24[33] = 1'b0;
        assign s21[33] = 1'b0;
        assign s24[34] = 1'b0;
        assign s21[34] = 1'b0;
        assign s24[35] = 1'b0;
        assign s21[35] = 1'b0;
        assign s24[36] = s0[295];
        assign s21[36] = s0[295];
        assign s24[37] = s0[303];
        assign s21[37] = s0[303];
        assign s24[38] = s0[311];
        assign s21[38] = s0[311];
        assign s24[39] = s0[319];
        assign s21[39] = s0[319];
        assign s24[40] = 1'b0;
        assign s21[40] = 1'b0;
        assign s24[41] = 1'b0;
        assign s21[41] = 1'b0;
        assign s24[42] = 1'b0;
        assign s21[42] = 1'b0;
        assign s24[43] = 1'b0;
        assign s21[43] = 1'b0;
        assign s24[44] = s0[359];
        assign s21[44] = s0[359];
        assign s24[45] = s0[367];
        assign s21[45] = s0[367];
        assign s24[46] = s0[375];
        assign s21[46] = s0[375];
        assign s24[47] = s0[383];
        assign s21[47] = s0[383];
        assign s24[48] = 1'b0;
        assign s21[48] = 1'b0;
        assign s24[49] = 1'b0;
        assign s21[49] = 1'b0;
        assign s24[50] = 1'b0;
        assign s21[50] = 1'b0;
        assign s24[51] = 1'b0;
        assign s21[51] = 1'b0;
        assign s24[52] = s0[423];
        assign s21[52] = s0[423];
        assign s24[53] = s0[431];
        assign s21[53] = s0[431];
        assign s24[54] = s0[439];
        assign s21[54] = s0[439];
        assign s24[55] = s0[447];
        assign s21[55] = s0[447];
        assign s24[56] = 1'b0;
        assign s21[56] = 1'b0;
        assign s24[57] = 1'b0;
        assign s21[57] = 1'b0;
        assign s24[58] = 1'b0;
        assign s21[58] = 1'b0;
        assign s24[59] = 1'b0;
        assign s21[59] = 1'b0;
        assign s24[60] = s0[487];
        assign s21[60] = s0[487];
        assign s24[61] = s0[495];
        assign s21[61] = s0[495];
        assign s24[62] = s0[503];
        assign s21[62] = s0[503];
        assign s24[63] = s0[511];
        assign s21[63] = s0[511];
        assign s24[64] = 1'b0;
        assign s21[64] = 1'b0;
        assign s24[65] = 1'b0;
        assign s21[65] = 1'b0;
        assign s24[66] = 1'b0;
        assign s21[66] = 1'b0;
        assign s24[67] = 1'b0;
        assign s21[67] = 1'b0;
        assign s24[68] = s0[551];
        assign s21[68] = s0[551];
        assign s24[69] = s0[559];
        assign s21[69] = s0[559];
        assign s24[70] = s0[567];
        assign s21[70] = s0[567];
        assign s24[71] = s0[575];
        assign s21[71] = s0[575];
        assign s24[72] = 1'b0;
        assign s21[72] = 1'b0;
        assign s24[73] = 1'b0;
        assign s21[73] = 1'b0;
        assign s24[74] = 1'b0;
        assign s21[74] = 1'b0;
        assign s24[75] = 1'b0;
        assign s21[75] = 1'b0;
        assign s24[76] = s0[615];
        assign s21[76] = s0[615];
        assign s24[77] = s0[623];
        assign s21[77] = s0[623];
        assign s24[78] = s0[631];
        assign s21[78] = s0[631];
        assign s24[79] = s0[639];
        assign s21[79] = s0[639];
        assign s24[80] = 1'b0;
        assign s21[80] = 1'b0;
        assign s24[81] = 1'b0;
        assign s21[81] = 1'b0;
        assign s24[82] = 1'b0;
        assign s21[82] = 1'b0;
        assign s24[83] = 1'b0;
        assign s21[83] = 1'b0;
        assign s24[84] = s0[679];
        assign s21[84] = s0[679];
        assign s24[85] = s0[687];
        assign s21[85] = s0[687];
        assign s24[86] = s0[695];
        assign s21[86] = s0[695];
        assign s24[87] = s0[703];
        assign s21[87] = s0[703];
        assign s24[88] = 1'b0;
        assign s21[88] = 1'b0;
        assign s24[89] = 1'b0;
        assign s21[89] = 1'b0;
        assign s24[90] = 1'b0;
        assign s21[90] = 1'b0;
        assign s24[91] = 1'b0;
        assign s21[91] = 1'b0;
        assign s24[92] = s0[743];
        assign s21[92] = s0[743];
        assign s24[93] = s0[751];
        assign s21[93] = s0[751];
        assign s24[94] = s0[759];
        assign s21[94] = s0[759];
        assign s24[95] = s0[767];
        assign s21[95] = s0[767];
        assign s24[96] = 1'b0;
        assign s21[96] = 1'b0;
        assign s24[97] = 1'b0;
        assign s21[97] = 1'b0;
        assign s24[98] = 1'b0;
        assign s21[98] = 1'b0;
        assign s24[99] = 1'b0;
        assign s21[99] = 1'b0;
        assign s24[100] = s0[807];
        assign s21[100] = s0[807];
        assign s24[101] = s0[815];
        assign s21[101] = s0[815];
        assign s24[102] = s0[823];
        assign s21[102] = s0[823];
        assign s24[103] = s0[831];
        assign s21[103] = s0[831];
        assign s24[104] = 1'b0;
        assign s21[104] = 1'b0;
        assign s24[105] = 1'b0;
        assign s21[105] = 1'b0;
        assign s24[106] = 1'b0;
        assign s21[106] = 1'b0;
        assign s24[107] = 1'b0;
        assign s21[107] = 1'b0;
        assign s24[108] = s0[871];
        assign s21[108] = s0[871];
        assign s24[109] = s0[879];
        assign s21[109] = s0[879];
        assign s24[110] = s0[887];
        assign s21[110] = s0[887];
        assign s24[111] = s0[895];
        assign s21[111] = s0[895];
        assign s24[112] = 1'b0;
        assign s21[112] = 1'b0;
        assign s24[113] = 1'b0;
        assign s21[113] = 1'b0;
        assign s24[114] = 1'b0;
        assign s21[114] = 1'b0;
        assign s24[115] = 1'b0;
        assign s21[115] = 1'b0;
        assign s24[116] = s0[935];
        assign s21[116] = s0[935];
        assign s24[117] = s0[943];
        assign s21[117] = s0[943];
        assign s24[118] = s0[951];
        assign s21[118] = s0[951];
        assign s24[119] = s0[959];
        assign s21[119] = s0[959];
        assign s24[120] = 1'b0;
        assign s21[120] = 1'b0;
        assign s24[121] = 1'b0;
        assign s21[121] = 1'b0;
        assign s24[122] = 1'b0;
        assign s21[122] = 1'b0;
        assign s24[123] = 1'b0;
        assign s21[123] = 1'b0;
        assign s24[124] = s0[999];
        assign s21[124] = s0[999];
        assign s24[125] = s0[1007];
        assign s21[125] = s0[1007];
        assign s24[126] = s0[1015];
        assign s21[126] = s0[1015];
        assign s24[127] = s0[1023];
        assign s21[127] = s0[1023];
        assign s27[0 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[1 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[2 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[3 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[4 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[5 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[6 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[7 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[8 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[9 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[10 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[11 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[12 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[13 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[14 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        assign s27[15 * 8 +:8] = {{4{1'b1}},{4{1'b0}}};
        kv_mux128 #(
            .W(8)
        ) u_mux0 (
            .out(s0[0 * 8 +:8]),
            .sel(idx[0 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux1 (
            .out(s0[1 * 8 +:8]),
            .sel(idx[1 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux2 (
            .out(s0[2 * 8 +:8]),
            .sel(idx[2 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux3 (
            .out(s0[3 * 8 +:8]),
            .sel(idx[3 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux4 (
            .out(s0[4 * 8 +:8]),
            .sel(idx[4 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux5 (
            .out(s0[5 * 8 +:8]),
            .sel(idx[5 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux6 (
            .out(s0[6 * 8 +:8]),
            .sel(idx[6 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux7 (
            .out(s0[7 * 8 +:8]),
            .sel(idx[7 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux8 (
            .out(s0[8 * 8 +:8]),
            .sel(idx[8 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux9 (
            .out(s0[9 * 8 +:8]),
            .sel(idx[9 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux10 (
            .out(s0[10 * 8 +:8]),
            .sel(idx[10 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux11 (
            .out(s0[11 * 8 +:8]),
            .sel(idx[11 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux12 (
            .out(s0[12 * 8 +:8]),
            .sel(idx[12 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux13 (
            .out(s0[13 * 8 +:8]),
            .sel(idx[13 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux14 (
            .out(s0[14 * 8 +:8]),
            .sel(idx[14 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux15 (
            .out(s0[15 * 8 +:8]),
            .sel(idx[15 * SW +:SW]),
            .in(vs2_buf[0 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux16 (
            .out(s0[16 * 8 +:8]),
            .sel(idx[16 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux17 (
            .out(s0[17 * 8 +:8]),
            .sel(idx[17 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux18 (
            .out(s0[18 * 8 +:8]),
            .sel(idx[18 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux19 (
            .out(s0[19 * 8 +:8]),
            .sel(idx[19 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux20 (
            .out(s0[20 * 8 +:8]),
            .sel(idx[20 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux21 (
            .out(s0[21 * 8 +:8]),
            .sel(idx[21 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux22 (
            .out(s0[22 * 8 +:8]),
            .sel(idx[22 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux23 (
            .out(s0[23 * 8 +:8]),
            .sel(idx[23 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux24 (
            .out(s0[24 * 8 +:8]),
            .sel(idx[24 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux25 (
            .out(s0[25 * 8 +:8]),
            .sel(idx[25 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux26 (
            .out(s0[26 * 8 +:8]),
            .sel(idx[26 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux27 (
            .out(s0[27 * 8 +:8]),
            .sel(idx[27 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux28 (
            .out(s0[28 * 8 +:8]),
            .sel(idx[28 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux29 (
            .out(s0[29 * 8 +:8]),
            .sel(idx[29 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux30 (
            .out(s0[30 * 8 +:8]),
            .sel(idx[30 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux31 (
            .out(s0[31 * 8 +:8]),
            .sel(idx[31 * SW +:SW]),
            .in(vs2_buf[1 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux32 (
            .out(s0[32 * 8 +:8]),
            .sel(idx[32 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux33 (
            .out(s0[33 * 8 +:8]),
            .sel(idx[33 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux34 (
            .out(s0[34 * 8 +:8]),
            .sel(idx[34 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux35 (
            .out(s0[35 * 8 +:8]),
            .sel(idx[35 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux36 (
            .out(s0[36 * 8 +:8]),
            .sel(idx[36 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux37 (
            .out(s0[37 * 8 +:8]),
            .sel(idx[37 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux38 (
            .out(s0[38 * 8 +:8]),
            .sel(idx[38 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux39 (
            .out(s0[39 * 8 +:8]),
            .sel(idx[39 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux40 (
            .out(s0[40 * 8 +:8]),
            .sel(idx[40 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux41 (
            .out(s0[41 * 8 +:8]),
            .sel(idx[41 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux42 (
            .out(s0[42 * 8 +:8]),
            .sel(idx[42 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux43 (
            .out(s0[43 * 8 +:8]),
            .sel(idx[43 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux44 (
            .out(s0[44 * 8 +:8]),
            .sel(idx[44 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux45 (
            .out(s0[45 * 8 +:8]),
            .sel(idx[45 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux46 (
            .out(s0[46 * 8 +:8]),
            .sel(idx[46 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux47 (
            .out(s0[47 * 8 +:8]),
            .sel(idx[47 * SW +:SW]),
            .in(vs2_buf[2 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux48 (
            .out(s0[48 * 8 +:8]),
            .sel(idx[48 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux49 (
            .out(s0[49 * 8 +:8]),
            .sel(idx[49 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux50 (
            .out(s0[50 * 8 +:8]),
            .sel(idx[50 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux51 (
            .out(s0[51 * 8 +:8]),
            .sel(idx[51 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux52 (
            .out(s0[52 * 8 +:8]),
            .sel(idx[52 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux53 (
            .out(s0[53 * 8 +:8]),
            .sel(idx[53 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux54 (
            .out(s0[54 * 8 +:8]),
            .sel(idx[54 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux55 (
            .out(s0[55 * 8 +:8]),
            .sel(idx[55 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux56 (
            .out(s0[56 * 8 +:8]),
            .sel(idx[56 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux57 (
            .out(s0[57 * 8 +:8]),
            .sel(idx[57 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux58 (
            .out(s0[58 * 8 +:8]),
            .sel(idx[58 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux59 (
            .out(s0[59 * 8 +:8]),
            .sel(idx[59 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux60 (
            .out(s0[60 * 8 +:8]),
            .sel(idx[60 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux61 (
            .out(s0[61 * 8 +:8]),
            .sel(idx[61 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux62 (
            .out(s0[62 * 8 +:8]),
            .sel(idx[62 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux63 (
            .out(s0[63 * 8 +:8]),
            .sel(idx[63 * SW +:SW]),
            .in(vs2_buf[3 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux64 (
            .out(s0[64 * 8 +:8]),
            .sel(idx[64 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux65 (
            .out(s0[65 * 8 +:8]),
            .sel(idx[65 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux66 (
            .out(s0[66 * 8 +:8]),
            .sel(idx[66 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux67 (
            .out(s0[67 * 8 +:8]),
            .sel(idx[67 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux68 (
            .out(s0[68 * 8 +:8]),
            .sel(idx[68 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux69 (
            .out(s0[69 * 8 +:8]),
            .sel(idx[69 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux70 (
            .out(s0[70 * 8 +:8]),
            .sel(idx[70 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux71 (
            .out(s0[71 * 8 +:8]),
            .sel(idx[71 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux72 (
            .out(s0[72 * 8 +:8]),
            .sel(idx[72 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux73 (
            .out(s0[73 * 8 +:8]),
            .sel(idx[73 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux74 (
            .out(s0[74 * 8 +:8]),
            .sel(idx[74 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux75 (
            .out(s0[75 * 8 +:8]),
            .sel(idx[75 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux76 (
            .out(s0[76 * 8 +:8]),
            .sel(idx[76 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux77 (
            .out(s0[77 * 8 +:8]),
            .sel(idx[77 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux78 (
            .out(s0[78 * 8 +:8]),
            .sel(idx[78 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux79 (
            .out(s0[79 * 8 +:8]),
            .sel(idx[79 * SW +:SW]),
            .in(vs2_buf[4 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux80 (
            .out(s0[80 * 8 +:8]),
            .sel(idx[80 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux81 (
            .out(s0[81 * 8 +:8]),
            .sel(idx[81 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux82 (
            .out(s0[82 * 8 +:8]),
            .sel(idx[82 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux83 (
            .out(s0[83 * 8 +:8]),
            .sel(idx[83 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux84 (
            .out(s0[84 * 8 +:8]),
            .sel(idx[84 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux85 (
            .out(s0[85 * 8 +:8]),
            .sel(idx[85 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux86 (
            .out(s0[86 * 8 +:8]),
            .sel(idx[86 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux87 (
            .out(s0[87 * 8 +:8]),
            .sel(idx[87 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux88 (
            .out(s0[88 * 8 +:8]),
            .sel(idx[88 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux89 (
            .out(s0[89 * 8 +:8]),
            .sel(idx[89 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux90 (
            .out(s0[90 * 8 +:8]),
            .sel(idx[90 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux91 (
            .out(s0[91 * 8 +:8]),
            .sel(idx[91 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux92 (
            .out(s0[92 * 8 +:8]),
            .sel(idx[92 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux93 (
            .out(s0[93 * 8 +:8]),
            .sel(idx[93 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux94 (
            .out(s0[94 * 8 +:8]),
            .sel(idx[94 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux95 (
            .out(s0[95 * 8 +:8]),
            .sel(idx[95 * SW +:SW]),
            .in(vs2_buf[5 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux96 (
            .out(s0[96 * 8 +:8]),
            .sel(idx[96 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux97 (
            .out(s0[97 * 8 +:8]),
            .sel(idx[97 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux98 (
            .out(s0[98 * 8 +:8]),
            .sel(idx[98 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux99 (
            .out(s0[99 * 8 +:8]),
            .sel(idx[99 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux100 (
            .out(s0[100 * 8 +:8]),
            .sel(idx[100 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux101 (
            .out(s0[101 * 8 +:8]),
            .sel(idx[101 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux102 (
            .out(s0[102 * 8 +:8]),
            .sel(idx[102 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux103 (
            .out(s0[103 * 8 +:8]),
            .sel(idx[103 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux104 (
            .out(s0[104 * 8 +:8]),
            .sel(idx[104 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux105 (
            .out(s0[105 * 8 +:8]),
            .sel(idx[105 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux106 (
            .out(s0[106 * 8 +:8]),
            .sel(idx[106 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux107 (
            .out(s0[107 * 8 +:8]),
            .sel(idx[107 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux108 (
            .out(s0[108 * 8 +:8]),
            .sel(idx[108 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux109 (
            .out(s0[109 * 8 +:8]),
            .sel(idx[109 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux110 (
            .out(s0[110 * 8 +:8]),
            .sel(idx[110 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux111 (
            .out(s0[111 * 8 +:8]),
            .sel(idx[111 * SW +:SW]),
            .in(vs2_buf[6 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux112 (
            .out(s0[112 * 8 +:8]),
            .sel(idx[112 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux113 (
            .out(s0[113 * 8 +:8]),
            .sel(idx[113 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux114 (
            .out(s0[114 * 8 +:8]),
            .sel(idx[114 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux115 (
            .out(s0[115 * 8 +:8]),
            .sel(idx[115 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux116 (
            .out(s0[116 * 8 +:8]),
            .sel(idx[116 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux117 (
            .out(s0[117 * 8 +:8]),
            .sel(idx[117 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux118 (
            .out(s0[118 * 8 +:8]),
            .sel(idx[118 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux119 (
            .out(s0[119 * 8 +:8]),
            .sel(idx[119 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux120 (
            .out(s0[120 * 8 +:8]),
            .sel(idx[120 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux121 (
            .out(s0[121 * 8 +:8]),
            .sel(idx[121 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux122 (
            .out(s0[122 * 8 +:8]),
            .sel(idx[122 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux123 (
            .out(s0[123 * 8 +:8]),
            .sel(idx[123 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux124 (
            .out(s0[124 * 8 +:8]),
            .sel(idx[124 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux125 (
            .out(s0[125 * 8 +:8]),
            .sel(idx[125 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux126 (
            .out(s0[126 * 8 +:8]),
            .sel(idx[126 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        kv_mux128 #(
            .W(8)
        ) u_mux127 (
            .out(s0[127 * 8 +:8]),
            .sel(idx[127 * SW +:SW]),
            .in(vs2_buf[7 * 1024 +:1024])
        );
        assign s13[0 +:8] = {{4{s0[0 + 3] & s4}},s0[0 +:4] & {4{s1}}};
        assign s13[8 +:8] = {{4{s0[15] & s4}},s0[12 +:4] & {4{s1}}};
        assign s13[16 +:8] = {{4{s0[16 + 3] & s4}},s0[16 +:4] & {4{s1}}};
        assign s13[24 +:8] = {{4{s0[31] & s4}},s0[28 +:4] & {4{s1}}};
        assign s13[32 +:8] = {{4{s0[32 + 3] & s4}},s0[32 +:4] & {4{s1}}};
        assign s13[40 +:8] = {{4{s0[47] & s4}},s0[44 +:4] & {4{s1}}};
        assign s13[48 +:8] = {{4{s0[48 + 3] & s4}},s0[48 +:4] & {4{s1}}};
        assign s13[56 +:8] = {{4{s0[63] & s4}},s0[60 +:4] & {4{s1}}};
        assign s13[64 +:8] = {{4{s0[64 + 3] & s4}},s0[64 +:4] & {4{s1}}};
        assign s13[72 +:8] = {{4{s0[79] & s4}},s0[76 +:4] & {4{s1}}};
        assign s13[80 +:8] = {{4{s0[80 + 3] & s4}},s0[80 +:4] & {4{s1}}};
        assign s13[88 +:8] = {{4{s0[95] & s4}},s0[92 +:4] & {4{s1}}};
        assign s13[96 +:8] = {{4{s0[96 + 3] & s4}},s0[96 +:4] & {4{s1}}};
        assign s13[104 +:8] = {{4{s0[111] & s4}},s0[108 +:4] & {4{s1}}};
        assign s13[112 +:8] = {{4{s0[112 + 3] & s4}},s0[112 +:4] & {4{s1}}};
        assign s13[120 +:8] = {{4{s0[127] & s4}},s0[124 +:4] & {4{s1}}};
        assign s13[128 +:8] = {{4{s0[128 + 3] & s4}},s0[128 +:4] & {4{s1}}};
        assign s13[136 +:8] = {{4{s0[143] & s4}},s0[140 +:4] & {4{s1}}};
        assign s13[144 +:8] = {{4{s0[144 + 3] & s4}},s0[144 +:4] & {4{s1}}};
        assign s13[152 +:8] = {{4{s0[159] & s4}},s0[156 +:4] & {4{s1}}};
        assign s13[160 +:8] = {{4{s0[160 + 3] & s4}},s0[160 +:4] & {4{s1}}};
        assign s13[168 +:8] = {{4{s0[175] & s4}},s0[172 +:4] & {4{s1}}};
        assign s13[176 +:8] = {{4{s0[176 + 3] & s4}},s0[176 +:4] & {4{s1}}};
        assign s13[184 +:8] = {{4{s0[191] & s4}},s0[188 +:4] & {4{s1}}};
        assign s13[192 +:8] = {{4{s0[192 + 3] & s4}},s0[192 +:4] & {4{s1}}};
        assign s13[200 +:8] = {{4{s0[207] & s4}},s0[204 +:4] & {4{s1}}};
        assign s13[208 +:8] = {{4{s0[208 + 3] & s4}},s0[208 +:4] & {4{s1}}};
        assign s13[216 +:8] = {{4{s0[223] & s4}},s0[220 +:4] & {4{s1}}};
        assign s13[224 +:8] = {{4{s0[224 + 3] & s4}},s0[224 +:4] & {4{s1}}};
        assign s13[232 +:8] = {{4{s0[239] & s4}},s0[236 +:4] & {4{s1}}};
        assign s13[240 +:8] = {{4{s0[240 + 3] & s4}},s0[240 +:4] & {4{s1}}};
        assign s13[248 +:8] = {{4{s0[255] & s4}},s0[252 +:4] & {4{s1}}};
        assign s13[256 +:8] = {{4{s0[256 + 3] & s4}},s0[256 +:4] & {4{s1}}};
        assign s13[264 +:8] = {{4{s0[271] & s4}},s0[268 +:4] & {4{s1}}};
        assign s13[272 +:8] = {{4{s0[272 + 3] & s4}},s0[272 +:4] & {4{s1}}};
        assign s13[280 +:8] = {{4{s0[287] & s4}},s0[284 +:4] & {4{s1}}};
        assign s13[288 +:8] = {{4{s0[288 + 3] & s4}},s0[288 +:4] & {4{s1}}};
        assign s13[296 +:8] = {{4{s0[303] & s4}},s0[300 +:4] & {4{s1}}};
        assign s13[304 +:8] = {{4{s0[304 + 3] & s4}},s0[304 +:4] & {4{s1}}};
        assign s13[312 +:8] = {{4{s0[319] & s4}},s0[316 +:4] & {4{s1}}};
        assign s13[320 +:8] = {{4{s0[320 + 3] & s4}},s0[320 +:4] & {4{s1}}};
        assign s13[328 +:8] = {{4{s0[335] & s4}},s0[332 +:4] & {4{s1}}};
        assign s13[336 +:8] = {{4{s0[336 + 3] & s4}},s0[336 +:4] & {4{s1}}};
        assign s13[344 +:8] = {{4{s0[351] & s4}},s0[348 +:4] & {4{s1}}};
        assign s13[352 +:8] = {{4{s0[352 + 3] & s4}},s0[352 +:4] & {4{s1}}};
        assign s13[360 +:8] = {{4{s0[367] & s4}},s0[364 +:4] & {4{s1}}};
        assign s13[368 +:8] = {{4{s0[368 + 3] & s4}},s0[368 +:4] & {4{s1}}};
        assign s13[376 +:8] = {{4{s0[383] & s4}},s0[380 +:4] & {4{s1}}};
        assign s13[384 +:8] = {{4{s0[384 + 3] & s4}},s0[384 +:4] & {4{s1}}};
        assign s13[392 +:8] = {{4{s0[399] & s4}},s0[396 +:4] & {4{s1}}};
        assign s13[400 +:8] = {{4{s0[400 + 3] & s4}},s0[400 +:4] & {4{s1}}};
        assign s13[408 +:8] = {{4{s0[415] & s4}},s0[412 +:4] & {4{s1}}};
        assign s13[416 +:8] = {{4{s0[416 + 3] & s4}},s0[416 +:4] & {4{s1}}};
        assign s13[424 +:8] = {{4{s0[431] & s4}},s0[428 +:4] & {4{s1}}};
        assign s13[432 +:8] = {{4{s0[432 + 3] & s4}},s0[432 +:4] & {4{s1}}};
        assign s13[440 +:8] = {{4{s0[447] & s4}},s0[444 +:4] & {4{s1}}};
        assign s13[448 +:8] = {{4{s0[448 + 3] & s4}},s0[448 +:4] & {4{s1}}};
        assign s13[456 +:8] = {{4{s0[463] & s4}},s0[460 +:4] & {4{s1}}};
        assign s13[464 +:8] = {{4{s0[464 + 3] & s4}},s0[464 +:4] & {4{s1}}};
        assign s13[472 +:8] = {{4{s0[479] & s4}},s0[476 +:4] & {4{s1}}};
        assign s13[480 +:8] = {{4{s0[480 + 3] & s4}},s0[480 +:4] & {4{s1}}};
        assign s13[488 +:8] = {{4{s0[495] & s4}},s0[492 +:4] & {4{s1}}};
        assign s13[496 +:8] = {{4{s0[496 + 3] & s4}},s0[496 +:4] & {4{s1}}};
        assign s13[504 +:8] = {{4{s0[511] & s4}},s0[508 +:4] & {4{s1}}};
        assign s13[512 +:8] = {{4{s0[512 + 3] & s4}},s0[512 +:4] & {4{s1}}};
        assign s13[520 +:8] = {{4{s0[527] & s4}},s0[524 +:4] & {4{s1}}};
        assign s13[528 +:8] = {{4{s0[528 + 3] & s4}},s0[528 +:4] & {4{s1}}};
        assign s13[536 +:8] = {{4{s0[543] & s4}},s0[540 +:4] & {4{s1}}};
        assign s13[544 +:8] = {{4{s0[544 + 3] & s4}},s0[544 +:4] & {4{s1}}};
        assign s13[552 +:8] = {{4{s0[559] & s4}},s0[556 +:4] & {4{s1}}};
        assign s13[560 +:8] = {{4{s0[560 + 3] & s4}},s0[560 +:4] & {4{s1}}};
        assign s13[568 +:8] = {{4{s0[575] & s4}},s0[572 +:4] & {4{s1}}};
        assign s13[576 +:8] = {{4{s0[576 + 3] & s4}},s0[576 +:4] & {4{s1}}};
        assign s13[584 +:8] = {{4{s0[591] & s4}},s0[588 +:4] & {4{s1}}};
        assign s13[592 +:8] = {{4{s0[592 + 3] & s4}},s0[592 +:4] & {4{s1}}};
        assign s13[600 +:8] = {{4{s0[607] & s4}},s0[604 +:4] & {4{s1}}};
        assign s13[608 +:8] = {{4{s0[608 + 3] & s4}},s0[608 +:4] & {4{s1}}};
        assign s13[616 +:8] = {{4{s0[623] & s4}},s0[620 +:4] & {4{s1}}};
        assign s13[624 +:8] = {{4{s0[624 + 3] & s4}},s0[624 +:4] & {4{s1}}};
        assign s13[632 +:8] = {{4{s0[639] & s4}},s0[636 +:4] & {4{s1}}};
        assign s13[640 +:8] = {{4{s0[640 + 3] & s4}},s0[640 +:4] & {4{s1}}};
        assign s13[648 +:8] = {{4{s0[655] & s4}},s0[652 +:4] & {4{s1}}};
        assign s13[656 +:8] = {{4{s0[656 + 3] & s4}},s0[656 +:4] & {4{s1}}};
        assign s13[664 +:8] = {{4{s0[671] & s4}},s0[668 +:4] & {4{s1}}};
        assign s13[672 +:8] = {{4{s0[672 + 3] & s4}},s0[672 +:4] & {4{s1}}};
        assign s13[680 +:8] = {{4{s0[687] & s4}},s0[684 +:4] & {4{s1}}};
        assign s13[688 +:8] = {{4{s0[688 + 3] & s4}},s0[688 +:4] & {4{s1}}};
        assign s13[696 +:8] = {{4{s0[703] & s4}},s0[700 +:4] & {4{s1}}};
        assign s13[704 +:8] = {{4{s0[704 + 3] & s4}},s0[704 +:4] & {4{s1}}};
        assign s13[712 +:8] = {{4{s0[719] & s4}},s0[716 +:4] & {4{s1}}};
        assign s13[720 +:8] = {{4{s0[720 + 3] & s4}},s0[720 +:4] & {4{s1}}};
        assign s13[728 +:8] = {{4{s0[735] & s4}},s0[732 +:4] & {4{s1}}};
        assign s13[736 +:8] = {{4{s0[736 + 3] & s4}},s0[736 +:4] & {4{s1}}};
        assign s13[744 +:8] = {{4{s0[751] & s4}},s0[748 +:4] & {4{s1}}};
        assign s13[752 +:8] = {{4{s0[752 + 3] & s4}},s0[752 +:4] & {4{s1}}};
        assign s13[760 +:8] = {{4{s0[767] & s4}},s0[764 +:4] & {4{s1}}};
        assign s13[768 +:8] = {{4{s0[768 + 3] & s4}},s0[768 +:4] & {4{s1}}};
        assign s13[776 +:8] = {{4{s0[783] & s4}},s0[780 +:4] & {4{s1}}};
        assign s13[784 +:8] = {{4{s0[784 + 3] & s4}},s0[784 +:4] & {4{s1}}};
        assign s13[792 +:8] = {{4{s0[799] & s4}},s0[796 +:4] & {4{s1}}};
        assign s13[800 +:8] = {{4{s0[800 + 3] & s4}},s0[800 +:4] & {4{s1}}};
        assign s13[808 +:8] = {{4{s0[815] & s4}},s0[812 +:4] & {4{s1}}};
        assign s13[816 +:8] = {{4{s0[816 + 3] & s4}},s0[816 +:4] & {4{s1}}};
        assign s13[824 +:8] = {{4{s0[831] & s4}},s0[828 +:4] & {4{s1}}};
        assign s13[832 +:8] = {{4{s0[832 + 3] & s4}},s0[832 +:4] & {4{s1}}};
        assign s13[840 +:8] = {{4{s0[847] & s4}},s0[844 +:4] & {4{s1}}};
        assign s13[848 +:8] = {{4{s0[848 + 3] & s4}},s0[848 +:4] & {4{s1}}};
        assign s13[856 +:8] = {{4{s0[863] & s4}},s0[860 +:4] & {4{s1}}};
        assign s13[864 +:8] = {{4{s0[864 + 3] & s4}},s0[864 +:4] & {4{s1}}};
        assign s13[872 +:8] = {{4{s0[879] & s4}},s0[876 +:4] & {4{s1}}};
        assign s13[880 +:8] = {{4{s0[880 + 3] & s4}},s0[880 +:4] & {4{s1}}};
        assign s13[888 +:8] = {{4{s0[895] & s4}},s0[892 +:4] & {4{s1}}};
        assign s13[896 +:8] = {{4{s0[896 + 3] & s4}},s0[896 +:4] & {4{s1}}};
        assign s13[904 +:8] = {{4{s0[911] & s4}},s0[908 +:4] & {4{s1}}};
        assign s13[912 +:8] = {{4{s0[912 + 3] & s4}},s0[912 +:4] & {4{s1}}};
        assign s13[920 +:8] = {{4{s0[927] & s4}},s0[924 +:4] & {4{s1}}};
        assign s13[928 +:8] = {{4{s0[928 + 3] & s4}},s0[928 +:4] & {4{s1}}};
        assign s13[936 +:8] = {{4{s0[943] & s4}},s0[940 +:4] & {4{s1}}};
        assign s13[944 +:8] = {{4{s0[944 + 3] & s4}},s0[944 +:4] & {4{s1}}};
        assign s13[952 +:8] = {{4{s0[959] & s4}},s0[956 +:4] & {4{s1}}};
        assign s13[960 +:8] = {{4{s0[960 + 3] & s4}},s0[960 +:4] & {4{s1}}};
        assign s13[968 +:8] = {{4{s0[975] & s4}},s0[972 +:4] & {4{s1}}};
        assign s13[976 +:8] = {{4{s0[976 + 3] & s4}},s0[976 +:4] & {4{s1}}};
        assign s13[984 +:8] = {{4{s0[991] & s4}},s0[988 +:4] & {4{s1}}};
        assign s13[992 +:8] = {{4{s0[992 + 3] & s4}},s0[992 +:4] & {4{s1}}};
        assign s13[1000 +:8] = {{4{s0[1007] & s4}},s0[1004 +:4] & {4{s1}}};
        assign s13[1008 +:8] = {{4{s0[1008 + 3] & s4}},s0[1008 +:4] & {4{s1}}};
        assign s13[1016 +:8] = {{4{s0[1023] & s4}},s0[1020 +:4] & {4{s1}}};
        assign s14[0 +:16] = {{8{s0[0 + 11] & s5}},{4{s0[0 + 3] & s5}},s0[0 +:4] & {4{s2}}};
        assign s14[16 +:16] = {{8{s0[23 + 8] & s5}},{4{s0[23] & s5}},s0[20 +:4] & {4{s2}}};
        assign s14[32 +:16] = {{8{s0[32 + 11] & s5}},{4{s0[32 + 3] & s5}},s0[32 +:4] & {4{s2}}};
        assign s14[48 +:16] = {{8{s0[55 + 8] & s5}},{4{s0[55] & s5}},s0[52 +:4] & {4{s2}}};
        assign s14[64 +:16] = {{8{s0[64 + 11] & s5}},{4{s0[64 + 3] & s5}},s0[64 +:4] & {4{s2}}};
        assign s14[80 +:16] = {{8{s0[87 + 8] & s5}},{4{s0[87] & s5}},s0[84 +:4] & {4{s2}}};
        assign s14[96 +:16] = {{8{s0[96 + 11] & s5}},{4{s0[96 + 3] & s5}},s0[96 +:4] & {4{s2}}};
        assign s14[112 +:16] = {{8{s0[119 + 8] & s5}},{4{s0[119] & s5}},s0[116 +:4] & {4{s2}}};
        assign s14[128 +:16] = {{8{s0[128 + 11] & s5}},{4{s0[128 + 3] & s5}},s0[128 +:4] & {4{s2}}};
        assign s14[144 +:16] = {{8{s0[151 + 8] & s5}},{4{s0[151] & s5}},s0[148 +:4] & {4{s2}}};
        assign s14[160 +:16] = {{8{s0[160 + 11] & s5}},{4{s0[160 + 3] & s5}},s0[160 +:4] & {4{s2}}};
        assign s14[176 +:16] = {{8{s0[183 + 8] & s5}},{4{s0[183] & s5}},s0[180 +:4] & {4{s2}}};
        assign s14[192 +:16] = {{8{s0[192 + 11] & s5}},{4{s0[192 + 3] & s5}},s0[192 +:4] & {4{s2}}};
        assign s14[208 +:16] = {{8{s0[215 + 8] & s5}},{4{s0[215] & s5}},s0[212 +:4] & {4{s2}}};
        assign s14[224 +:16] = {{8{s0[224 + 11] & s5}},{4{s0[224 + 3] & s5}},s0[224 +:4] & {4{s2}}};
        assign s14[240 +:16] = {{8{s0[247 + 8] & s5}},{4{s0[247] & s5}},s0[244 +:4] & {4{s2}}};
        assign s14[256 +:16] = {{8{s0[256 + 11] & s5}},{4{s0[256 + 3] & s5}},s0[256 +:4] & {4{s2}}};
        assign s14[272 +:16] = {{8{s0[279 + 8] & s5}},{4{s0[279] & s5}},s0[276 +:4] & {4{s2}}};
        assign s14[288 +:16] = {{8{s0[288 + 11] & s5}},{4{s0[288 + 3] & s5}},s0[288 +:4] & {4{s2}}};
        assign s14[304 +:16] = {{8{s0[311 + 8] & s5}},{4{s0[311] & s5}},s0[308 +:4] & {4{s2}}};
        assign s14[320 +:16] = {{8{s0[320 + 11] & s5}},{4{s0[320 + 3] & s5}},s0[320 +:4] & {4{s2}}};
        assign s14[336 +:16] = {{8{s0[343 + 8] & s5}},{4{s0[343] & s5}},s0[340 +:4] & {4{s2}}};
        assign s14[352 +:16] = {{8{s0[352 + 11] & s5}},{4{s0[352 + 3] & s5}},s0[352 +:4] & {4{s2}}};
        assign s14[368 +:16] = {{8{s0[375 + 8] & s5}},{4{s0[375] & s5}},s0[372 +:4] & {4{s2}}};
        assign s14[384 +:16] = {{8{s0[384 + 11] & s5}},{4{s0[384 + 3] & s5}},s0[384 +:4] & {4{s2}}};
        assign s14[400 +:16] = {{8{s0[407 + 8] & s5}},{4{s0[407] & s5}},s0[404 +:4] & {4{s2}}};
        assign s14[416 +:16] = {{8{s0[416 + 11] & s5}},{4{s0[416 + 3] & s5}},s0[416 +:4] & {4{s2}}};
        assign s14[432 +:16] = {{8{s0[439 + 8] & s5}},{4{s0[439] & s5}},s0[436 +:4] & {4{s2}}};
        assign s14[448 +:16] = {{8{s0[448 + 11] & s5}},{4{s0[448 + 3] & s5}},s0[448 +:4] & {4{s2}}};
        assign s14[464 +:16] = {{8{s0[471 + 8] & s5}},{4{s0[471] & s5}},s0[468 +:4] & {4{s2}}};
        assign s14[480 +:16] = {{8{s0[480 + 11] & s5}},{4{s0[480 + 3] & s5}},s0[480 +:4] & {4{s2}}};
        assign s14[496 +:16] = {{8{s0[503 + 8] & s5}},{4{s0[503] & s5}},s0[500 +:4] & {4{s2}}};
        assign s14[512 +:16] = {{8{s0[512 + 11] & s5}},{4{s0[512 + 3] & s5}},s0[512 +:4] & {4{s2}}};
        assign s14[528 +:16] = {{8{s0[535 + 8] & s5}},{4{s0[535] & s5}},s0[532 +:4] & {4{s2}}};
        assign s14[544 +:16] = {{8{s0[544 + 11] & s5}},{4{s0[544 + 3] & s5}},s0[544 +:4] & {4{s2}}};
        assign s14[560 +:16] = {{8{s0[567 + 8] & s5}},{4{s0[567] & s5}},s0[564 +:4] & {4{s2}}};
        assign s14[576 +:16] = {{8{s0[576 + 11] & s5}},{4{s0[576 + 3] & s5}},s0[576 +:4] & {4{s2}}};
        assign s14[592 +:16] = {{8{s0[599 + 8] & s5}},{4{s0[599] & s5}},s0[596 +:4] & {4{s2}}};
        assign s14[608 +:16] = {{8{s0[608 + 11] & s5}},{4{s0[608 + 3] & s5}},s0[608 +:4] & {4{s2}}};
        assign s14[624 +:16] = {{8{s0[631 + 8] & s5}},{4{s0[631] & s5}},s0[628 +:4] & {4{s2}}};
        assign s14[640 +:16] = {{8{s0[640 + 11] & s5}},{4{s0[640 + 3] & s5}},s0[640 +:4] & {4{s2}}};
        assign s14[656 +:16] = {{8{s0[663 + 8] & s5}},{4{s0[663] & s5}},s0[660 +:4] & {4{s2}}};
        assign s14[672 +:16] = {{8{s0[672 + 11] & s5}},{4{s0[672 + 3] & s5}},s0[672 +:4] & {4{s2}}};
        assign s14[688 +:16] = {{8{s0[695 + 8] & s5}},{4{s0[695] & s5}},s0[692 +:4] & {4{s2}}};
        assign s14[704 +:16] = {{8{s0[704 + 11] & s5}},{4{s0[704 + 3] & s5}},s0[704 +:4] & {4{s2}}};
        assign s14[720 +:16] = {{8{s0[727 + 8] & s5}},{4{s0[727] & s5}},s0[724 +:4] & {4{s2}}};
        assign s14[736 +:16] = {{8{s0[736 + 11] & s5}},{4{s0[736 + 3] & s5}},s0[736 +:4] & {4{s2}}};
        assign s14[752 +:16] = {{8{s0[759 + 8] & s5}},{4{s0[759] & s5}},s0[756 +:4] & {4{s2}}};
        assign s14[768 +:16] = {{8{s0[768 + 11] & s5}},{4{s0[768 + 3] & s5}},s0[768 +:4] & {4{s2}}};
        assign s14[784 +:16] = {{8{s0[791 + 8] & s5}},{4{s0[791] & s5}},s0[788 +:4] & {4{s2}}};
        assign s14[800 +:16] = {{8{s0[800 + 11] & s5}},{4{s0[800 + 3] & s5}},s0[800 +:4] & {4{s2}}};
        assign s14[816 +:16] = {{8{s0[823 + 8] & s5}},{4{s0[823] & s5}},s0[820 +:4] & {4{s2}}};
        assign s14[832 +:16] = {{8{s0[832 + 11] & s5}},{4{s0[832 + 3] & s5}},s0[832 +:4] & {4{s2}}};
        assign s14[848 +:16] = {{8{s0[855 + 8] & s5}},{4{s0[855] & s5}},s0[852 +:4] & {4{s2}}};
        assign s14[864 +:16] = {{8{s0[864 + 11] & s5}},{4{s0[864 + 3] & s5}},s0[864 +:4] & {4{s2}}};
        assign s14[880 +:16] = {{8{s0[887 + 8] & s5}},{4{s0[887] & s5}},s0[884 +:4] & {4{s2}}};
        assign s14[896 +:16] = {{8{s0[896 + 11] & s5}},{4{s0[896 + 3] & s5}},s0[896 +:4] & {4{s2}}};
        assign s14[912 +:16] = {{8{s0[919 + 8] & s5}},{4{s0[919] & s5}},s0[916 +:4] & {4{s2}}};
        assign s14[928 +:16] = {{8{s0[928 + 11] & s5}},{4{s0[928 + 3] & s5}},s0[928 +:4] & {4{s2}}};
        assign s14[944 +:16] = {{8{s0[951 + 8] & s5}},{4{s0[951] & s5}},s0[948 +:4] & {4{s2}}};
        assign s14[960 +:16] = {{8{s0[960 + 11] & s5}},{4{s0[960 + 3] & s5}},s0[960 +:4] & {4{s2}}};
        assign s14[976 +:16] = {{8{s0[983 + 8] & s5}},{4{s0[983] & s5}},s0[980 +:4] & {4{s2}}};
        assign s14[992 +:16] = {{8{s0[992 + 11] & s5}},{4{s0[992 + 3] & s5}},s0[992 +:4] & {4{s2}}};
        assign s14[1008 +:16] = {{8{s0[1015 + 8] & s5}},{4{s0[1015] & s5}},s0[1012 +:4] & {4{s2}}};
        assign s15[0 +:32] = {{8{s0[0 + 27] & s6}},{8{s0[0 + 19] & s6}},{8{s0[0 + 11] & s6}},{4{s0[0 + 3] & s6}},s0[0 +:4] & {4{s3}}};
        assign s15[32 +:32] = {{8{s0[39 + 24] & s6}},{8{s0[39 + 16] & s6}},{8{s0[39 + 8] & s6}},{4{s0[39] & s6}},s0[36 +:4] & {4{s3}}};
        assign s15[64 +:32] = {{8{s0[64 + 27] & s6}},{8{s0[64 + 19] & s6}},{8{s0[64 + 11] & s6}},{4{s0[64 + 3] & s6}},s0[64 +:4] & {4{s3}}};
        assign s15[96 +:32] = {{8{s0[103 + 24] & s6}},{8{s0[103 + 16] & s6}},{8{s0[103 + 8] & s6}},{4{s0[103] & s6}},s0[100 +:4] & {4{s3}}};
        assign s15[128 +:32] = {{8{s0[128 + 27] & s6}},{8{s0[128 + 19] & s6}},{8{s0[128 + 11] & s6}},{4{s0[128 + 3] & s6}},s0[128 +:4] & {4{s3}}};
        assign s15[160 +:32] = {{8{s0[167 + 24] & s6}},{8{s0[167 + 16] & s6}},{8{s0[167 + 8] & s6}},{4{s0[167] & s6}},s0[164 +:4] & {4{s3}}};
        assign s15[192 +:32] = {{8{s0[192 + 27] & s6}},{8{s0[192 + 19] & s6}},{8{s0[192 + 11] & s6}},{4{s0[192 + 3] & s6}},s0[192 +:4] & {4{s3}}};
        assign s15[224 +:32] = {{8{s0[231 + 24] & s6}},{8{s0[231 + 16] & s6}},{8{s0[231 + 8] & s6}},{4{s0[231] & s6}},s0[228 +:4] & {4{s3}}};
        assign s15[256 +:32] = {{8{s0[256 + 27] & s6}},{8{s0[256 + 19] & s6}},{8{s0[256 + 11] & s6}},{4{s0[256 + 3] & s6}},s0[256 +:4] & {4{s3}}};
        assign s15[288 +:32] = {{8{s0[295 + 24] & s6}},{8{s0[295 + 16] & s6}},{8{s0[295 + 8] & s6}},{4{s0[295] & s6}},s0[292 +:4] & {4{s3}}};
        assign s15[320 +:32] = {{8{s0[320 + 27] & s6}},{8{s0[320 + 19] & s6}},{8{s0[320 + 11] & s6}},{4{s0[320 + 3] & s6}},s0[320 +:4] & {4{s3}}};
        assign s15[352 +:32] = {{8{s0[359 + 24] & s6}},{8{s0[359 + 16] & s6}},{8{s0[359 + 8] & s6}},{4{s0[359] & s6}},s0[356 +:4] & {4{s3}}};
        assign s15[384 +:32] = {{8{s0[384 + 27] & s6}},{8{s0[384 + 19] & s6}},{8{s0[384 + 11] & s6}},{4{s0[384 + 3] & s6}},s0[384 +:4] & {4{s3}}};
        assign s15[416 +:32] = {{8{s0[423 + 24] & s6}},{8{s0[423 + 16] & s6}},{8{s0[423 + 8] & s6}},{4{s0[423] & s6}},s0[420 +:4] & {4{s3}}};
        assign s15[448 +:32] = {{8{s0[448 + 27] & s6}},{8{s0[448 + 19] & s6}},{8{s0[448 + 11] & s6}},{4{s0[448 + 3] & s6}},s0[448 +:4] & {4{s3}}};
        assign s15[480 +:32] = {{8{s0[487 + 24] & s6}},{8{s0[487 + 16] & s6}},{8{s0[487 + 8] & s6}},{4{s0[487] & s6}},s0[484 +:4] & {4{s3}}};
        assign s15[512 +:32] = {{8{s0[512 + 27] & s6}},{8{s0[512 + 19] & s6}},{8{s0[512 + 11] & s6}},{4{s0[512 + 3] & s6}},s0[512 +:4] & {4{s3}}};
        assign s15[544 +:32] = {{8{s0[551 + 24] & s6}},{8{s0[551 + 16] & s6}},{8{s0[551 + 8] & s6}},{4{s0[551] & s6}},s0[548 +:4] & {4{s3}}};
        assign s15[576 +:32] = {{8{s0[576 + 27] & s6}},{8{s0[576 + 19] & s6}},{8{s0[576 + 11] & s6}},{4{s0[576 + 3] & s6}},s0[576 +:4] & {4{s3}}};
        assign s15[608 +:32] = {{8{s0[615 + 24] & s6}},{8{s0[615 + 16] & s6}},{8{s0[615 + 8] & s6}},{4{s0[615] & s6}},s0[612 +:4] & {4{s3}}};
        assign s15[640 +:32] = {{8{s0[640 + 27] & s6}},{8{s0[640 + 19] & s6}},{8{s0[640 + 11] & s6}},{4{s0[640 + 3] & s6}},s0[640 +:4] & {4{s3}}};
        assign s15[672 +:32] = {{8{s0[679 + 24] & s6}},{8{s0[679 + 16] & s6}},{8{s0[679 + 8] & s6}},{4{s0[679] & s6}},s0[676 +:4] & {4{s3}}};
        assign s15[704 +:32] = {{8{s0[704 + 27] & s6}},{8{s0[704 + 19] & s6}},{8{s0[704 + 11] & s6}},{4{s0[704 + 3] & s6}},s0[704 +:4] & {4{s3}}};
        assign s15[736 +:32] = {{8{s0[743 + 24] & s6}},{8{s0[743 + 16] & s6}},{8{s0[743 + 8] & s6}},{4{s0[743] & s6}},s0[740 +:4] & {4{s3}}};
        assign s15[768 +:32] = {{8{s0[768 + 27] & s6}},{8{s0[768 + 19] & s6}},{8{s0[768 + 11] & s6}},{4{s0[768 + 3] & s6}},s0[768 +:4] & {4{s3}}};
        assign s15[800 +:32] = {{8{s0[807 + 24] & s6}},{8{s0[807 + 16] & s6}},{8{s0[807 + 8] & s6}},{4{s0[807] & s6}},s0[804 +:4] & {4{s3}}};
        assign s15[832 +:32] = {{8{s0[832 + 27] & s6}},{8{s0[832 + 19] & s6}},{8{s0[832 + 11] & s6}},{4{s0[832 + 3] & s6}},s0[832 +:4] & {4{s3}}};
        assign s15[864 +:32] = {{8{s0[871 + 24] & s6}},{8{s0[871 + 16] & s6}},{8{s0[871 + 8] & s6}},{4{s0[871] & s6}},s0[868 +:4] & {4{s3}}};
        assign s15[896 +:32] = {{8{s0[896 + 27] & s6}},{8{s0[896 + 19] & s6}},{8{s0[896 + 11] & s6}},{4{s0[896 + 3] & s6}},s0[896 +:4] & {4{s3}}};
        assign s15[928 +:32] = {{8{s0[935 + 24] & s6}},{8{s0[935 + 16] & s6}},{8{s0[935 + 8] & s6}},{4{s0[935] & s6}},s0[932 +:4] & {4{s3}}};
        assign s15[960 +:32] = {{8{s0[960 + 27] & s6}},{8{s0[960 + 19] & s6}},{8{s0[960 + 11] & s6}},{4{s0[960 + 3] & s6}},s0[960 +:4] & {4{s3}}};
        assign s15[992 +:32] = {{8{s0[999 + 24] & s6}},{8{s0[999 + 16] & s6}},{8{s0[999 + 8] & s6}},{4{s0[999] & s6}},s0[996 +:4] & {4{s3}}};
        wire [2 * VP_LEN - 1:0] s35;
        assign s35 = {2{s13 | s14 | s15}};
        wire [2 * VP_LEN - 1:0] s36 = {2 * VP_LEN{vmv_nr}} & {vs2_buf[VP_LEN +:VP_LEN],{VP_LEN{1'b0}}};
        assign result0[0 * 8 +:8] = s36[0 * 8 +:8] | s35[0 * 8 +:8] | ({8{s30[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s32[0]}}) | {8{s28[0]}});
        assign result0[1 * 8 +:8] = s36[1 * 8 +:8] | s35[1 * 8 +:8] | ({8{s30[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s32[1]}}) | {8{s28[1]}});
        assign result0[2 * 8 +:8] = s36[2 * 8 +:8] | s35[2 * 8 +:8] | ({8{s30[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s32[2]}}) | {8{s28[2]}});
        assign result0[3 * 8 +:8] = s36[3 * 8 +:8] | s35[3 * 8 +:8] | ({8{s30[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s32[3]}}) | {8{s28[3]}});
        assign result0[4 * 8 +:8] = s36[4 * 8 +:8] | s35[4 * 8 +:8] | ({8{s30[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s32[4]}}) | {8{s28[4]}});
        assign result0[5 * 8 +:8] = s36[5 * 8 +:8] | s35[5 * 8 +:8] | ({8{s30[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s32[5]}}) | {8{s28[5]}});
        assign result0[6 * 8 +:8] = s36[6 * 8 +:8] | s35[6 * 8 +:8] | ({8{s30[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s32[6]}}) | {8{s28[6]}});
        assign result0[7 * 8 +:8] = s36[7 * 8 +:8] | s35[7 * 8 +:8] | ({8{s30[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s32[7]}}) | {8{s28[7]}});
        assign result0[8 * 8 +:8] = s36[8 * 8 +:8] | s35[8 * 8 +:8] | ({8{s30[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s32[8]}}) | {8{s28[8]}});
        assign result0[9 * 8 +:8] = s36[9 * 8 +:8] | s35[9 * 8 +:8] | ({8{s30[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s32[9]}}) | {8{s28[9]}});
        assign result0[10 * 8 +:8] = s36[10 * 8 +:8] | s35[10 * 8 +:8] | ({8{s30[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s32[10]}}) | {8{s28[10]}});
        assign result0[11 * 8 +:8] = s36[11 * 8 +:8] | s35[11 * 8 +:8] | ({8{s30[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s32[11]}}) | {8{s28[11]}});
        assign result0[12 * 8 +:8] = s36[12 * 8 +:8] | s35[12 * 8 +:8] | ({8{s30[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s32[12]}}) | {8{s28[12]}});
        assign result0[13 * 8 +:8] = s36[13 * 8 +:8] | s35[13 * 8 +:8] | ({8{s30[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s32[13]}}) | {8{s28[13]}});
        assign result0[14 * 8 +:8] = s36[14 * 8 +:8] | s35[14 * 8 +:8] | ({8{s30[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s32[14]}}) | {8{s28[14]}});
        assign result0[15 * 8 +:8] = s36[15 * 8 +:8] | s35[15 * 8 +:8] | ({8{s30[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s32[15]}}) | {8{s28[15]}});
        assign result0[16 * 8 +:8] = s36[16 * 8 +:8] | s35[16 * 8 +:8] | ({8{s30[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s32[16]}}) | {8{s28[16]}});
        assign result0[17 * 8 +:8] = s36[17 * 8 +:8] | s35[17 * 8 +:8] | ({8{s30[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s32[17]}}) | {8{s28[17]}});
        assign result0[18 * 8 +:8] = s36[18 * 8 +:8] | s35[18 * 8 +:8] | ({8{s30[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s32[18]}}) | {8{s28[18]}});
        assign result0[19 * 8 +:8] = s36[19 * 8 +:8] | s35[19 * 8 +:8] | ({8{s30[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s32[19]}}) | {8{s28[19]}});
        assign result0[20 * 8 +:8] = s36[20 * 8 +:8] | s35[20 * 8 +:8] | ({8{s30[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s32[20]}}) | {8{s28[20]}});
        assign result0[21 * 8 +:8] = s36[21 * 8 +:8] | s35[21 * 8 +:8] | ({8{s30[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s32[21]}}) | {8{s28[21]}});
        assign result0[22 * 8 +:8] = s36[22 * 8 +:8] | s35[22 * 8 +:8] | ({8{s30[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s32[22]}}) | {8{s28[22]}});
        assign result0[23 * 8 +:8] = s36[23 * 8 +:8] | s35[23 * 8 +:8] | ({8{s30[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s32[23]}}) | {8{s28[23]}});
        assign result0[24 * 8 +:8] = s36[24 * 8 +:8] | s35[24 * 8 +:8] | ({8{s30[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s32[24]}}) | {8{s28[24]}});
        assign result0[25 * 8 +:8] = s36[25 * 8 +:8] | s35[25 * 8 +:8] | ({8{s30[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s32[25]}}) | {8{s28[25]}});
        assign result0[26 * 8 +:8] = s36[26 * 8 +:8] | s35[26 * 8 +:8] | ({8{s30[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s32[26]}}) | {8{s28[26]}});
        assign result0[27 * 8 +:8] = s36[27 * 8 +:8] | s35[27 * 8 +:8] | ({8{s30[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s32[27]}}) | {8{s28[27]}});
        assign result0[28 * 8 +:8] = s36[28 * 8 +:8] | s35[28 * 8 +:8] | ({8{s30[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s32[28]}}) | {8{s28[28]}});
        assign result0[29 * 8 +:8] = s36[29 * 8 +:8] | s35[29 * 8 +:8] | ({8{s30[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s32[29]}}) | {8{s28[29]}});
        assign result0[30 * 8 +:8] = s36[30 * 8 +:8] | s35[30 * 8 +:8] | ({8{s30[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s32[30]}}) | {8{s28[30]}});
        assign result0[31 * 8 +:8] = s36[31 * 8 +:8] | s35[31 * 8 +:8] | ({8{s30[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s32[31]}}) | {8{s28[31]}});
        assign result0[32 * 8 +:8] = s36[32 * 8 +:8] | s35[32 * 8 +:8] | ({8{s30[32]}} & s34[32 * 8 +:8]) | ((s0[32 * 8 +:8] & {8{s32[32]}}) | {8{s28[32]}});
        assign result0[33 * 8 +:8] = s36[33 * 8 +:8] | s35[33 * 8 +:8] | ({8{s30[33]}} & s34[33 * 8 +:8]) | ((s0[33 * 8 +:8] & {8{s32[33]}}) | {8{s28[33]}});
        assign result0[34 * 8 +:8] = s36[34 * 8 +:8] | s35[34 * 8 +:8] | ({8{s30[34]}} & s34[34 * 8 +:8]) | ((s0[34 * 8 +:8] & {8{s32[34]}}) | {8{s28[34]}});
        assign result0[35 * 8 +:8] = s36[35 * 8 +:8] | s35[35 * 8 +:8] | ({8{s30[35]}} & s34[35 * 8 +:8]) | ((s0[35 * 8 +:8] & {8{s32[35]}}) | {8{s28[35]}});
        assign result0[36 * 8 +:8] = s36[36 * 8 +:8] | s35[36 * 8 +:8] | ({8{s30[36]}} & s34[36 * 8 +:8]) | ((s0[36 * 8 +:8] & {8{s32[36]}}) | {8{s28[36]}});
        assign result0[37 * 8 +:8] = s36[37 * 8 +:8] | s35[37 * 8 +:8] | ({8{s30[37]}} & s34[37 * 8 +:8]) | ((s0[37 * 8 +:8] & {8{s32[37]}}) | {8{s28[37]}});
        assign result0[38 * 8 +:8] = s36[38 * 8 +:8] | s35[38 * 8 +:8] | ({8{s30[38]}} & s34[38 * 8 +:8]) | ((s0[38 * 8 +:8] & {8{s32[38]}}) | {8{s28[38]}});
        assign result0[39 * 8 +:8] = s36[39 * 8 +:8] | s35[39 * 8 +:8] | ({8{s30[39]}} & s34[39 * 8 +:8]) | ((s0[39 * 8 +:8] & {8{s32[39]}}) | {8{s28[39]}});
        assign result0[40 * 8 +:8] = s36[40 * 8 +:8] | s35[40 * 8 +:8] | ({8{s30[40]}} & s34[40 * 8 +:8]) | ((s0[40 * 8 +:8] & {8{s32[40]}}) | {8{s28[40]}});
        assign result0[41 * 8 +:8] = s36[41 * 8 +:8] | s35[41 * 8 +:8] | ({8{s30[41]}} & s34[41 * 8 +:8]) | ((s0[41 * 8 +:8] & {8{s32[41]}}) | {8{s28[41]}});
        assign result0[42 * 8 +:8] = s36[42 * 8 +:8] | s35[42 * 8 +:8] | ({8{s30[42]}} & s34[42 * 8 +:8]) | ((s0[42 * 8 +:8] & {8{s32[42]}}) | {8{s28[42]}});
        assign result0[43 * 8 +:8] = s36[43 * 8 +:8] | s35[43 * 8 +:8] | ({8{s30[43]}} & s34[43 * 8 +:8]) | ((s0[43 * 8 +:8] & {8{s32[43]}}) | {8{s28[43]}});
        assign result0[44 * 8 +:8] = s36[44 * 8 +:8] | s35[44 * 8 +:8] | ({8{s30[44]}} & s34[44 * 8 +:8]) | ((s0[44 * 8 +:8] & {8{s32[44]}}) | {8{s28[44]}});
        assign result0[45 * 8 +:8] = s36[45 * 8 +:8] | s35[45 * 8 +:8] | ({8{s30[45]}} & s34[45 * 8 +:8]) | ((s0[45 * 8 +:8] & {8{s32[45]}}) | {8{s28[45]}});
        assign result0[46 * 8 +:8] = s36[46 * 8 +:8] | s35[46 * 8 +:8] | ({8{s30[46]}} & s34[46 * 8 +:8]) | ((s0[46 * 8 +:8] & {8{s32[46]}}) | {8{s28[46]}});
        assign result0[47 * 8 +:8] = s36[47 * 8 +:8] | s35[47 * 8 +:8] | ({8{s30[47]}} & s34[47 * 8 +:8]) | ((s0[47 * 8 +:8] & {8{s32[47]}}) | {8{s28[47]}});
        assign result0[48 * 8 +:8] = s36[48 * 8 +:8] | s35[48 * 8 +:8] | ({8{s30[48]}} & s34[48 * 8 +:8]) | ((s0[48 * 8 +:8] & {8{s32[48]}}) | {8{s28[48]}});
        assign result0[49 * 8 +:8] = s36[49 * 8 +:8] | s35[49 * 8 +:8] | ({8{s30[49]}} & s34[49 * 8 +:8]) | ((s0[49 * 8 +:8] & {8{s32[49]}}) | {8{s28[49]}});
        assign result0[50 * 8 +:8] = s36[50 * 8 +:8] | s35[50 * 8 +:8] | ({8{s30[50]}} & s34[50 * 8 +:8]) | ((s0[50 * 8 +:8] & {8{s32[50]}}) | {8{s28[50]}});
        assign result0[51 * 8 +:8] = s36[51 * 8 +:8] | s35[51 * 8 +:8] | ({8{s30[51]}} & s34[51 * 8 +:8]) | ((s0[51 * 8 +:8] & {8{s32[51]}}) | {8{s28[51]}});
        assign result0[52 * 8 +:8] = s36[52 * 8 +:8] | s35[52 * 8 +:8] | ({8{s30[52]}} & s34[52 * 8 +:8]) | ((s0[52 * 8 +:8] & {8{s32[52]}}) | {8{s28[52]}});
        assign result0[53 * 8 +:8] = s36[53 * 8 +:8] | s35[53 * 8 +:8] | ({8{s30[53]}} & s34[53 * 8 +:8]) | ((s0[53 * 8 +:8] & {8{s32[53]}}) | {8{s28[53]}});
        assign result0[54 * 8 +:8] = s36[54 * 8 +:8] | s35[54 * 8 +:8] | ({8{s30[54]}} & s34[54 * 8 +:8]) | ((s0[54 * 8 +:8] & {8{s32[54]}}) | {8{s28[54]}});
        assign result0[55 * 8 +:8] = s36[55 * 8 +:8] | s35[55 * 8 +:8] | ({8{s30[55]}} & s34[55 * 8 +:8]) | ((s0[55 * 8 +:8] & {8{s32[55]}}) | {8{s28[55]}});
        assign result0[56 * 8 +:8] = s36[56 * 8 +:8] | s35[56 * 8 +:8] | ({8{s30[56]}} & s34[56 * 8 +:8]) | ((s0[56 * 8 +:8] & {8{s32[56]}}) | {8{s28[56]}});
        assign result0[57 * 8 +:8] = s36[57 * 8 +:8] | s35[57 * 8 +:8] | ({8{s30[57]}} & s34[57 * 8 +:8]) | ((s0[57 * 8 +:8] & {8{s32[57]}}) | {8{s28[57]}});
        assign result0[58 * 8 +:8] = s36[58 * 8 +:8] | s35[58 * 8 +:8] | ({8{s30[58]}} & s34[58 * 8 +:8]) | ((s0[58 * 8 +:8] & {8{s32[58]}}) | {8{s28[58]}});
        assign result0[59 * 8 +:8] = s36[59 * 8 +:8] | s35[59 * 8 +:8] | ({8{s30[59]}} & s34[59 * 8 +:8]) | ((s0[59 * 8 +:8] & {8{s32[59]}}) | {8{s28[59]}});
        assign result0[60 * 8 +:8] = s36[60 * 8 +:8] | s35[60 * 8 +:8] | ({8{s30[60]}} & s34[60 * 8 +:8]) | ((s0[60 * 8 +:8] & {8{s32[60]}}) | {8{s28[60]}});
        assign result0[61 * 8 +:8] = s36[61 * 8 +:8] | s35[61 * 8 +:8] | ({8{s30[61]}} & s34[61 * 8 +:8]) | ((s0[61 * 8 +:8] & {8{s32[61]}}) | {8{s28[61]}});
        assign result0[62 * 8 +:8] = s36[62 * 8 +:8] | s35[62 * 8 +:8] | ({8{s30[62]}} & s34[62 * 8 +:8]) | ((s0[62 * 8 +:8] & {8{s32[62]}}) | {8{s28[62]}});
        assign result0[63 * 8 +:8] = s36[63 * 8 +:8] | s35[63 * 8 +:8] | ({8{s30[63]}} & s34[63 * 8 +:8]) | ((s0[63 * 8 +:8] & {8{s32[63]}}) | {8{s28[63]}});
        assign result0[64 * 8 +:8] = s36[64 * 8 +:8] | s35[64 * 8 +:8] | ({8{s30[64]}} & s34[64 * 8 +:8]) | ((s0[64 * 8 +:8] & {8{s32[64]}}) | {8{s28[64]}});
        assign result0[65 * 8 +:8] = s36[65 * 8 +:8] | s35[65 * 8 +:8] | ({8{s30[65]}} & s34[65 * 8 +:8]) | ((s0[65 * 8 +:8] & {8{s32[65]}}) | {8{s28[65]}});
        assign result0[66 * 8 +:8] = s36[66 * 8 +:8] | s35[66 * 8 +:8] | ({8{s30[66]}} & s34[66 * 8 +:8]) | ((s0[66 * 8 +:8] & {8{s32[66]}}) | {8{s28[66]}});
        assign result0[67 * 8 +:8] = s36[67 * 8 +:8] | s35[67 * 8 +:8] | ({8{s30[67]}} & s34[67 * 8 +:8]) | ((s0[67 * 8 +:8] & {8{s32[67]}}) | {8{s28[67]}});
        assign result0[68 * 8 +:8] = s36[68 * 8 +:8] | s35[68 * 8 +:8] | ({8{s30[68]}} & s34[68 * 8 +:8]) | ((s0[68 * 8 +:8] & {8{s32[68]}}) | {8{s28[68]}});
        assign result0[69 * 8 +:8] = s36[69 * 8 +:8] | s35[69 * 8 +:8] | ({8{s30[69]}} & s34[69 * 8 +:8]) | ((s0[69 * 8 +:8] & {8{s32[69]}}) | {8{s28[69]}});
        assign result0[70 * 8 +:8] = s36[70 * 8 +:8] | s35[70 * 8 +:8] | ({8{s30[70]}} & s34[70 * 8 +:8]) | ((s0[70 * 8 +:8] & {8{s32[70]}}) | {8{s28[70]}});
        assign result0[71 * 8 +:8] = s36[71 * 8 +:8] | s35[71 * 8 +:8] | ({8{s30[71]}} & s34[71 * 8 +:8]) | ((s0[71 * 8 +:8] & {8{s32[71]}}) | {8{s28[71]}});
        assign result0[72 * 8 +:8] = s36[72 * 8 +:8] | s35[72 * 8 +:8] | ({8{s30[72]}} & s34[72 * 8 +:8]) | ((s0[72 * 8 +:8] & {8{s32[72]}}) | {8{s28[72]}});
        assign result0[73 * 8 +:8] = s36[73 * 8 +:8] | s35[73 * 8 +:8] | ({8{s30[73]}} & s34[73 * 8 +:8]) | ((s0[73 * 8 +:8] & {8{s32[73]}}) | {8{s28[73]}});
        assign result0[74 * 8 +:8] = s36[74 * 8 +:8] | s35[74 * 8 +:8] | ({8{s30[74]}} & s34[74 * 8 +:8]) | ((s0[74 * 8 +:8] & {8{s32[74]}}) | {8{s28[74]}});
        assign result0[75 * 8 +:8] = s36[75 * 8 +:8] | s35[75 * 8 +:8] | ({8{s30[75]}} & s34[75 * 8 +:8]) | ((s0[75 * 8 +:8] & {8{s32[75]}}) | {8{s28[75]}});
        assign result0[76 * 8 +:8] = s36[76 * 8 +:8] | s35[76 * 8 +:8] | ({8{s30[76]}} & s34[76 * 8 +:8]) | ((s0[76 * 8 +:8] & {8{s32[76]}}) | {8{s28[76]}});
        assign result0[77 * 8 +:8] = s36[77 * 8 +:8] | s35[77 * 8 +:8] | ({8{s30[77]}} & s34[77 * 8 +:8]) | ((s0[77 * 8 +:8] & {8{s32[77]}}) | {8{s28[77]}});
        assign result0[78 * 8 +:8] = s36[78 * 8 +:8] | s35[78 * 8 +:8] | ({8{s30[78]}} & s34[78 * 8 +:8]) | ((s0[78 * 8 +:8] & {8{s32[78]}}) | {8{s28[78]}});
        assign result0[79 * 8 +:8] = s36[79 * 8 +:8] | s35[79 * 8 +:8] | ({8{s30[79]}} & s34[79 * 8 +:8]) | ((s0[79 * 8 +:8] & {8{s32[79]}}) | {8{s28[79]}});
        assign result0[80 * 8 +:8] = s36[80 * 8 +:8] | s35[80 * 8 +:8] | ({8{s30[80]}} & s34[80 * 8 +:8]) | ((s0[80 * 8 +:8] & {8{s32[80]}}) | {8{s28[80]}});
        assign result0[81 * 8 +:8] = s36[81 * 8 +:8] | s35[81 * 8 +:8] | ({8{s30[81]}} & s34[81 * 8 +:8]) | ((s0[81 * 8 +:8] & {8{s32[81]}}) | {8{s28[81]}});
        assign result0[82 * 8 +:8] = s36[82 * 8 +:8] | s35[82 * 8 +:8] | ({8{s30[82]}} & s34[82 * 8 +:8]) | ((s0[82 * 8 +:8] & {8{s32[82]}}) | {8{s28[82]}});
        assign result0[83 * 8 +:8] = s36[83 * 8 +:8] | s35[83 * 8 +:8] | ({8{s30[83]}} & s34[83 * 8 +:8]) | ((s0[83 * 8 +:8] & {8{s32[83]}}) | {8{s28[83]}});
        assign result0[84 * 8 +:8] = s36[84 * 8 +:8] | s35[84 * 8 +:8] | ({8{s30[84]}} & s34[84 * 8 +:8]) | ((s0[84 * 8 +:8] & {8{s32[84]}}) | {8{s28[84]}});
        assign result0[85 * 8 +:8] = s36[85 * 8 +:8] | s35[85 * 8 +:8] | ({8{s30[85]}} & s34[85 * 8 +:8]) | ((s0[85 * 8 +:8] & {8{s32[85]}}) | {8{s28[85]}});
        assign result0[86 * 8 +:8] = s36[86 * 8 +:8] | s35[86 * 8 +:8] | ({8{s30[86]}} & s34[86 * 8 +:8]) | ((s0[86 * 8 +:8] & {8{s32[86]}}) | {8{s28[86]}});
        assign result0[87 * 8 +:8] = s36[87 * 8 +:8] | s35[87 * 8 +:8] | ({8{s30[87]}} & s34[87 * 8 +:8]) | ((s0[87 * 8 +:8] & {8{s32[87]}}) | {8{s28[87]}});
        assign result0[88 * 8 +:8] = s36[88 * 8 +:8] | s35[88 * 8 +:8] | ({8{s30[88]}} & s34[88 * 8 +:8]) | ((s0[88 * 8 +:8] & {8{s32[88]}}) | {8{s28[88]}});
        assign result0[89 * 8 +:8] = s36[89 * 8 +:8] | s35[89 * 8 +:8] | ({8{s30[89]}} & s34[89 * 8 +:8]) | ((s0[89 * 8 +:8] & {8{s32[89]}}) | {8{s28[89]}});
        assign result0[90 * 8 +:8] = s36[90 * 8 +:8] | s35[90 * 8 +:8] | ({8{s30[90]}} & s34[90 * 8 +:8]) | ((s0[90 * 8 +:8] & {8{s32[90]}}) | {8{s28[90]}});
        assign result0[91 * 8 +:8] = s36[91 * 8 +:8] | s35[91 * 8 +:8] | ({8{s30[91]}} & s34[91 * 8 +:8]) | ((s0[91 * 8 +:8] & {8{s32[91]}}) | {8{s28[91]}});
        assign result0[92 * 8 +:8] = s36[92 * 8 +:8] | s35[92 * 8 +:8] | ({8{s30[92]}} & s34[92 * 8 +:8]) | ((s0[92 * 8 +:8] & {8{s32[92]}}) | {8{s28[92]}});
        assign result0[93 * 8 +:8] = s36[93 * 8 +:8] | s35[93 * 8 +:8] | ({8{s30[93]}} & s34[93 * 8 +:8]) | ((s0[93 * 8 +:8] & {8{s32[93]}}) | {8{s28[93]}});
        assign result0[94 * 8 +:8] = s36[94 * 8 +:8] | s35[94 * 8 +:8] | ({8{s30[94]}} & s34[94 * 8 +:8]) | ((s0[94 * 8 +:8] & {8{s32[94]}}) | {8{s28[94]}});
        assign result0[95 * 8 +:8] = s36[95 * 8 +:8] | s35[95 * 8 +:8] | ({8{s30[95]}} & s34[95 * 8 +:8]) | ((s0[95 * 8 +:8] & {8{s32[95]}}) | {8{s28[95]}});
        assign result0[96 * 8 +:8] = s36[96 * 8 +:8] | s35[96 * 8 +:8] | ({8{s30[96]}} & s34[96 * 8 +:8]) | ((s0[96 * 8 +:8] & {8{s32[96]}}) | {8{s28[96]}});
        assign result0[97 * 8 +:8] = s36[97 * 8 +:8] | s35[97 * 8 +:8] | ({8{s30[97]}} & s34[97 * 8 +:8]) | ((s0[97 * 8 +:8] & {8{s32[97]}}) | {8{s28[97]}});
        assign result0[98 * 8 +:8] = s36[98 * 8 +:8] | s35[98 * 8 +:8] | ({8{s30[98]}} & s34[98 * 8 +:8]) | ((s0[98 * 8 +:8] & {8{s32[98]}}) | {8{s28[98]}});
        assign result0[99 * 8 +:8] = s36[99 * 8 +:8] | s35[99 * 8 +:8] | ({8{s30[99]}} & s34[99 * 8 +:8]) | ((s0[99 * 8 +:8] & {8{s32[99]}}) | {8{s28[99]}});
        assign result0[100 * 8 +:8] = s36[100 * 8 +:8] | s35[100 * 8 +:8] | ({8{s30[100]}} & s34[100 * 8 +:8]) | ((s0[100 * 8 +:8] & {8{s32[100]}}) | {8{s28[100]}});
        assign result0[101 * 8 +:8] = s36[101 * 8 +:8] | s35[101 * 8 +:8] | ({8{s30[101]}} & s34[101 * 8 +:8]) | ((s0[101 * 8 +:8] & {8{s32[101]}}) | {8{s28[101]}});
        assign result0[102 * 8 +:8] = s36[102 * 8 +:8] | s35[102 * 8 +:8] | ({8{s30[102]}} & s34[102 * 8 +:8]) | ((s0[102 * 8 +:8] & {8{s32[102]}}) | {8{s28[102]}});
        assign result0[103 * 8 +:8] = s36[103 * 8 +:8] | s35[103 * 8 +:8] | ({8{s30[103]}} & s34[103 * 8 +:8]) | ((s0[103 * 8 +:8] & {8{s32[103]}}) | {8{s28[103]}});
        assign result0[104 * 8 +:8] = s36[104 * 8 +:8] | s35[104 * 8 +:8] | ({8{s30[104]}} & s34[104 * 8 +:8]) | ((s0[104 * 8 +:8] & {8{s32[104]}}) | {8{s28[104]}});
        assign result0[105 * 8 +:8] = s36[105 * 8 +:8] | s35[105 * 8 +:8] | ({8{s30[105]}} & s34[105 * 8 +:8]) | ((s0[105 * 8 +:8] & {8{s32[105]}}) | {8{s28[105]}});
        assign result0[106 * 8 +:8] = s36[106 * 8 +:8] | s35[106 * 8 +:8] | ({8{s30[106]}} & s34[106 * 8 +:8]) | ((s0[106 * 8 +:8] & {8{s32[106]}}) | {8{s28[106]}});
        assign result0[107 * 8 +:8] = s36[107 * 8 +:8] | s35[107 * 8 +:8] | ({8{s30[107]}} & s34[107 * 8 +:8]) | ((s0[107 * 8 +:8] & {8{s32[107]}}) | {8{s28[107]}});
        assign result0[108 * 8 +:8] = s36[108 * 8 +:8] | s35[108 * 8 +:8] | ({8{s30[108]}} & s34[108 * 8 +:8]) | ((s0[108 * 8 +:8] & {8{s32[108]}}) | {8{s28[108]}});
        assign result0[109 * 8 +:8] = s36[109 * 8 +:8] | s35[109 * 8 +:8] | ({8{s30[109]}} & s34[109 * 8 +:8]) | ((s0[109 * 8 +:8] & {8{s32[109]}}) | {8{s28[109]}});
        assign result0[110 * 8 +:8] = s36[110 * 8 +:8] | s35[110 * 8 +:8] | ({8{s30[110]}} & s34[110 * 8 +:8]) | ((s0[110 * 8 +:8] & {8{s32[110]}}) | {8{s28[110]}});
        assign result0[111 * 8 +:8] = s36[111 * 8 +:8] | s35[111 * 8 +:8] | ({8{s30[111]}} & s34[111 * 8 +:8]) | ((s0[111 * 8 +:8] & {8{s32[111]}}) | {8{s28[111]}});
        assign result0[112 * 8 +:8] = s36[112 * 8 +:8] | s35[112 * 8 +:8] | ({8{s30[112]}} & s34[112 * 8 +:8]) | ((s0[112 * 8 +:8] & {8{s32[112]}}) | {8{s28[112]}});
        assign result0[113 * 8 +:8] = s36[113 * 8 +:8] | s35[113 * 8 +:8] | ({8{s30[113]}} & s34[113 * 8 +:8]) | ((s0[113 * 8 +:8] & {8{s32[113]}}) | {8{s28[113]}});
        assign result0[114 * 8 +:8] = s36[114 * 8 +:8] | s35[114 * 8 +:8] | ({8{s30[114]}} & s34[114 * 8 +:8]) | ((s0[114 * 8 +:8] & {8{s32[114]}}) | {8{s28[114]}});
        assign result0[115 * 8 +:8] = s36[115 * 8 +:8] | s35[115 * 8 +:8] | ({8{s30[115]}} & s34[115 * 8 +:8]) | ((s0[115 * 8 +:8] & {8{s32[115]}}) | {8{s28[115]}});
        assign result0[116 * 8 +:8] = s36[116 * 8 +:8] | s35[116 * 8 +:8] | ({8{s30[116]}} & s34[116 * 8 +:8]) | ((s0[116 * 8 +:8] & {8{s32[116]}}) | {8{s28[116]}});
        assign result0[117 * 8 +:8] = s36[117 * 8 +:8] | s35[117 * 8 +:8] | ({8{s30[117]}} & s34[117 * 8 +:8]) | ((s0[117 * 8 +:8] & {8{s32[117]}}) | {8{s28[117]}});
        assign result0[118 * 8 +:8] = s36[118 * 8 +:8] | s35[118 * 8 +:8] | ({8{s30[118]}} & s34[118 * 8 +:8]) | ((s0[118 * 8 +:8] & {8{s32[118]}}) | {8{s28[118]}});
        assign result0[119 * 8 +:8] = s36[119 * 8 +:8] | s35[119 * 8 +:8] | ({8{s30[119]}} & s34[119 * 8 +:8]) | ((s0[119 * 8 +:8] & {8{s32[119]}}) | {8{s28[119]}});
        assign result0[120 * 8 +:8] = s36[120 * 8 +:8] | s35[120 * 8 +:8] | ({8{s30[120]}} & s34[120 * 8 +:8]) | ((s0[120 * 8 +:8] & {8{s32[120]}}) | {8{s28[120]}});
        assign result0[121 * 8 +:8] = s36[121 * 8 +:8] | s35[121 * 8 +:8] | ({8{s30[121]}} & s34[121 * 8 +:8]) | ((s0[121 * 8 +:8] & {8{s32[121]}}) | {8{s28[121]}});
        assign result0[122 * 8 +:8] = s36[122 * 8 +:8] | s35[122 * 8 +:8] | ({8{s30[122]}} & s34[122 * 8 +:8]) | ((s0[122 * 8 +:8] & {8{s32[122]}}) | {8{s28[122]}});
        assign result0[123 * 8 +:8] = s36[123 * 8 +:8] | s35[123 * 8 +:8] | ({8{s30[123]}} & s34[123 * 8 +:8]) | ((s0[123 * 8 +:8] & {8{s32[123]}}) | {8{s28[123]}});
        assign result0[124 * 8 +:8] = s36[124 * 8 +:8] | s35[124 * 8 +:8] | ({8{s30[124]}} & s34[124 * 8 +:8]) | ((s0[124 * 8 +:8] & {8{s32[124]}}) | {8{s28[124]}});
        assign result0[125 * 8 +:8] = s36[125 * 8 +:8] | s35[125 * 8 +:8] | ({8{s30[125]}} & s34[125 * 8 +:8]) | ((s0[125 * 8 +:8] & {8{s32[125]}}) | {8{s28[125]}});
        assign result0[126 * 8 +:8] = s36[126 * 8 +:8] | s35[126 * 8 +:8] | ({8{s30[126]}} & s34[126 * 8 +:8]) | ((s0[126 * 8 +:8] & {8{s32[126]}}) | {8{s28[126]}});
        assign result0[127 * 8 +:8] = s36[127 * 8 +:8] | s35[127 * 8 +:8] | ({8{s30[127]}} & s34[127 * 8 +:8]) | ((s0[127 * 8 +:8] & {8{s32[127]}}) | {8{s28[127]}});
        assign result1[0 * 8 +:8] = s36[128 * 8 +:8] | s35[128 * 8 +:8] | ({8{s31[0]}} & s34[0 * 8 +:8]) | ((s0[0 * 8 +:8] & {8{s33[0]}}) | {8{s28[0]}});
        assign result1[1 * 8 +:8] = s36[129 * 8 +:8] | s35[129 * 8 +:8] | ({8{s31[1]}} & s34[1 * 8 +:8]) | ((s0[1 * 8 +:8] & {8{s33[1]}}) | {8{s28[1]}});
        assign result1[2 * 8 +:8] = s36[130 * 8 +:8] | s35[130 * 8 +:8] | ({8{s31[2]}} & s34[2 * 8 +:8]) | ((s0[2 * 8 +:8] & {8{s33[2]}}) | {8{s28[2]}});
        assign result1[3 * 8 +:8] = s36[131 * 8 +:8] | s35[131 * 8 +:8] | ({8{s31[3]}} & s34[3 * 8 +:8]) | ((s0[3 * 8 +:8] & {8{s33[3]}}) | {8{s28[3]}});
        assign result1[4 * 8 +:8] = s36[132 * 8 +:8] | s35[132 * 8 +:8] | ({8{s31[4]}} & s34[4 * 8 +:8]) | ((s0[4 * 8 +:8] & {8{s33[4]}}) | {8{s28[4]}});
        assign result1[5 * 8 +:8] = s36[133 * 8 +:8] | s35[133 * 8 +:8] | ({8{s31[5]}} & s34[5 * 8 +:8]) | ((s0[5 * 8 +:8] & {8{s33[5]}}) | {8{s28[5]}});
        assign result1[6 * 8 +:8] = s36[134 * 8 +:8] | s35[134 * 8 +:8] | ({8{s31[6]}} & s34[6 * 8 +:8]) | ((s0[6 * 8 +:8] & {8{s33[6]}}) | {8{s28[6]}});
        assign result1[7 * 8 +:8] = s36[135 * 8 +:8] | s35[135 * 8 +:8] | ({8{s31[7]}} & s34[7 * 8 +:8]) | ((s0[7 * 8 +:8] & {8{s33[7]}}) | {8{s28[7]}});
        assign result1[8 * 8 +:8] = s36[136 * 8 +:8] | s35[136 * 8 +:8] | ({8{s31[8]}} & s34[8 * 8 +:8]) | ((s0[8 * 8 +:8] & {8{s33[8]}}) | {8{s28[8]}});
        assign result1[9 * 8 +:8] = s36[137 * 8 +:8] | s35[137 * 8 +:8] | ({8{s31[9]}} & s34[9 * 8 +:8]) | ((s0[9 * 8 +:8] & {8{s33[9]}}) | {8{s28[9]}});
        assign result1[10 * 8 +:8] = s36[138 * 8 +:8] | s35[138 * 8 +:8] | ({8{s31[10]}} & s34[10 * 8 +:8]) | ((s0[10 * 8 +:8] & {8{s33[10]}}) | {8{s28[10]}});
        assign result1[11 * 8 +:8] = s36[139 * 8 +:8] | s35[139 * 8 +:8] | ({8{s31[11]}} & s34[11 * 8 +:8]) | ((s0[11 * 8 +:8] & {8{s33[11]}}) | {8{s28[11]}});
        assign result1[12 * 8 +:8] = s36[140 * 8 +:8] | s35[140 * 8 +:8] | ({8{s31[12]}} & s34[12 * 8 +:8]) | ((s0[12 * 8 +:8] & {8{s33[12]}}) | {8{s28[12]}});
        assign result1[13 * 8 +:8] = s36[141 * 8 +:8] | s35[141 * 8 +:8] | ({8{s31[13]}} & s34[13 * 8 +:8]) | ((s0[13 * 8 +:8] & {8{s33[13]}}) | {8{s28[13]}});
        assign result1[14 * 8 +:8] = s36[142 * 8 +:8] | s35[142 * 8 +:8] | ({8{s31[14]}} & s34[14 * 8 +:8]) | ((s0[14 * 8 +:8] & {8{s33[14]}}) | {8{s28[14]}});
        assign result1[15 * 8 +:8] = s36[143 * 8 +:8] | s35[143 * 8 +:8] | ({8{s31[15]}} & s34[15 * 8 +:8]) | ((s0[15 * 8 +:8] & {8{s33[15]}}) | {8{s28[15]}});
        assign result1[16 * 8 +:8] = s36[144 * 8 +:8] | s35[144 * 8 +:8] | ({8{s31[16]}} & s34[16 * 8 +:8]) | ((s0[16 * 8 +:8] & {8{s33[16]}}) | {8{s28[16]}});
        assign result1[17 * 8 +:8] = s36[145 * 8 +:8] | s35[145 * 8 +:8] | ({8{s31[17]}} & s34[17 * 8 +:8]) | ((s0[17 * 8 +:8] & {8{s33[17]}}) | {8{s28[17]}});
        assign result1[18 * 8 +:8] = s36[146 * 8 +:8] | s35[146 * 8 +:8] | ({8{s31[18]}} & s34[18 * 8 +:8]) | ((s0[18 * 8 +:8] & {8{s33[18]}}) | {8{s28[18]}});
        assign result1[19 * 8 +:8] = s36[147 * 8 +:8] | s35[147 * 8 +:8] | ({8{s31[19]}} & s34[19 * 8 +:8]) | ((s0[19 * 8 +:8] & {8{s33[19]}}) | {8{s28[19]}});
        assign result1[20 * 8 +:8] = s36[148 * 8 +:8] | s35[148 * 8 +:8] | ({8{s31[20]}} & s34[20 * 8 +:8]) | ((s0[20 * 8 +:8] & {8{s33[20]}}) | {8{s28[20]}});
        assign result1[21 * 8 +:8] = s36[149 * 8 +:8] | s35[149 * 8 +:8] | ({8{s31[21]}} & s34[21 * 8 +:8]) | ((s0[21 * 8 +:8] & {8{s33[21]}}) | {8{s28[21]}});
        assign result1[22 * 8 +:8] = s36[150 * 8 +:8] | s35[150 * 8 +:8] | ({8{s31[22]}} & s34[22 * 8 +:8]) | ((s0[22 * 8 +:8] & {8{s33[22]}}) | {8{s28[22]}});
        assign result1[23 * 8 +:8] = s36[151 * 8 +:8] | s35[151 * 8 +:8] | ({8{s31[23]}} & s34[23 * 8 +:8]) | ((s0[23 * 8 +:8] & {8{s33[23]}}) | {8{s28[23]}});
        assign result1[24 * 8 +:8] = s36[152 * 8 +:8] | s35[152 * 8 +:8] | ({8{s31[24]}} & s34[24 * 8 +:8]) | ((s0[24 * 8 +:8] & {8{s33[24]}}) | {8{s28[24]}});
        assign result1[25 * 8 +:8] = s36[153 * 8 +:8] | s35[153 * 8 +:8] | ({8{s31[25]}} & s34[25 * 8 +:8]) | ((s0[25 * 8 +:8] & {8{s33[25]}}) | {8{s28[25]}});
        assign result1[26 * 8 +:8] = s36[154 * 8 +:8] | s35[154 * 8 +:8] | ({8{s31[26]}} & s34[26 * 8 +:8]) | ((s0[26 * 8 +:8] & {8{s33[26]}}) | {8{s28[26]}});
        assign result1[27 * 8 +:8] = s36[155 * 8 +:8] | s35[155 * 8 +:8] | ({8{s31[27]}} & s34[27 * 8 +:8]) | ((s0[27 * 8 +:8] & {8{s33[27]}}) | {8{s28[27]}});
        assign result1[28 * 8 +:8] = s36[156 * 8 +:8] | s35[156 * 8 +:8] | ({8{s31[28]}} & s34[28 * 8 +:8]) | ((s0[28 * 8 +:8] & {8{s33[28]}}) | {8{s28[28]}});
        assign result1[29 * 8 +:8] = s36[157 * 8 +:8] | s35[157 * 8 +:8] | ({8{s31[29]}} & s34[29 * 8 +:8]) | ((s0[29 * 8 +:8] & {8{s33[29]}}) | {8{s28[29]}});
        assign result1[30 * 8 +:8] = s36[158 * 8 +:8] | s35[158 * 8 +:8] | ({8{s31[30]}} & s34[30 * 8 +:8]) | ((s0[30 * 8 +:8] & {8{s33[30]}}) | {8{s28[30]}});
        assign result1[31 * 8 +:8] = s36[159 * 8 +:8] | s35[159 * 8 +:8] | ({8{s31[31]}} & s34[31 * 8 +:8]) | ((s0[31 * 8 +:8] & {8{s33[31]}}) | {8{s28[31]}});
        assign result1[32 * 8 +:8] = s36[160 * 8 +:8] | s35[160 * 8 +:8] | ({8{s31[32]}} & s34[32 * 8 +:8]) | ((s0[32 * 8 +:8] & {8{s33[32]}}) | {8{s28[32]}});
        assign result1[33 * 8 +:8] = s36[161 * 8 +:8] | s35[161 * 8 +:8] | ({8{s31[33]}} & s34[33 * 8 +:8]) | ((s0[33 * 8 +:8] & {8{s33[33]}}) | {8{s28[33]}});
        assign result1[34 * 8 +:8] = s36[162 * 8 +:8] | s35[162 * 8 +:8] | ({8{s31[34]}} & s34[34 * 8 +:8]) | ((s0[34 * 8 +:8] & {8{s33[34]}}) | {8{s28[34]}});
        assign result1[35 * 8 +:8] = s36[163 * 8 +:8] | s35[163 * 8 +:8] | ({8{s31[35]}} & s34[35 * 8 +:8]) | ((s0[35 * 8 +:8] & {8{s33[35]}}) | {8{s28[35]}});
        assign result1[36 * 8 +:8] = s36[164 * 8 +:8] | s35[164 * 8 +:8] | ({8{s31[36]}} & s34[36 * 8 +:8]) | ((s0[36 * 8 +:8] & {8{s33[36]}}) | {8{s28[36]}});
        assign result1[37 * 8 +:8] = s36[165 * 8 +:8] | s35[165 * 8 +:8] | ({8{s31[37]}} & s34[37 * 8 +:8]) | ((s0[37 * 8 +:8] & {8{s33[37]}}) | {8{s28[37]}});
        assign result1[38 * 8 +:8] = s36[166 * 8 +:8] | s35[166 * 8 +:8] | ({8{s31[38]}} & s34[38 * 8 +:8]) | ((s0[38 * 8 +:8] & {8{s33[38]}}) | {8{s28[38]}});
        assign result1[39 * 8 +:8] = s36[167 * 8 +:8] | s35[167 * 8 +:8] | ({8{s31[39]}} & s34[39 * 8 +:8]) | ((s0[39 * 8 +:8] & {8{s33[39]}}) | {8{s28[39]}});
        assign result1[40 * 8 +:8] = s36[168 * 8 +:8] | s35[168 * 8 +:8] | ({8{s31[40]}} & s34[40 * 8 +:8]) | ((s0[40 * 8 +:8] & {8{s33[40]}}) | {8{s28[40]}});
        assign result1[41 * 8 +:8] = s36[169 * 8 +:8] | s35[169 * 8 +:8] | ({8{s31[41]}} & s34[41 * 8 +:8]) | ((s0[41 * 8 +:8] & {8{s33[41]}}) | {8{s28[41]}});
        assign result1[42 * 8 +:8] = s36[170 * 8 +:8] | s35[170 * 8 +:8] | ({8{s31[42]}} & s34[42 * 8 +:8]) | ((s0[42 * 8 +:8] & {8{s33[42]}}) | {8{s28[42]}});
        assign result1[43 * 8 +:8] = s36[171 * 8 +:8] | s35[171 * 8 +:8] | ({8{s31[43]}} & s34[43 * 8 +:8]) | ((s0[43 * 8 +:8] & {8{s33[43]}}) | {8{s28[43]}});
        assign result1[44 * 8 +:8] = s36[172 * 8 +:8] | s35[172 * 8 +:8] | ({8{s31[44]}} & s34[44 * 8 +:8]) | ((s0[44 * 8 +:8] & {8{s33[44]}}) | {8{s28[44]}});
        assign result1[45 * 8 +:8] = s36[173 * 8 +:8] | s35[173 * 8 +:8] | ({8{s31[45]}} & s34[45 * 8 +:8]) | ((s0[45 * 8 +:8] & {8{s33[45]}}) | {8{s28[45]}});
        assign result1[46 * 8 +:8] = s36[174 * 8 +:8] | s35[174 * 8 +:8] | ({8{s31[46]}} & s34[46 * 8 +:8]) | ((s0[46 * 8 +:8] & {8{s33[46]}}) | {8{s28[46]}});
        assign result1[47 * 8 +:8] = s36[175 * 8 +:8] | s35[175 * 8 +:8] | ({8{s31[47]}} & s34[47 * 8 +:8]) | ((s0[47 * 8 +:8] & {8{s33[47]}}) | {8{s28[47]}});
        assign result1[48 * 8 +:8] = s36[176 * 8 +:8] | s35[176 * 8 +:8] | ({8{s31[48]}} & s34[48 * 8 +:8]) | ((s0[48 * 8 +:8] & {8{s33[48]}}) | {8{s28[48]}});
        assign result1[49 * 8 +:8] = s36[177 * 8 +:8] | s35[177 * 8 +:8] | ({8{s31[49]}} & s34[49 * 8 +:8]) | ((s0[49 * 8 +:8] & {8{s33[49]}}) | {8{s28[49]}});
        assign result1[50 * 8 +:8] = s36[178 * 8 +:8] | s35[178 * 8 +:8] | ({8{s31[50]}} & s34[50 * 8 +:8]) | ((s0[50 * 8 +:8] & {8{s33[50]}}) | {8{s28[50]}});
        assign result1[51 * 8 +:8] = s36[179 * 8 +:8] | s35[179 * 8 +:8] | ({8{s31[51]}} & s34[51 * 8 +:8]) | ((s0[51 * 8 +:8] & {8{s33[51]}}) | {8{s28[51]}});
        assign result1[52 * 8 +:8] = s36[180 * 8 +:8] | s35[180 * 8 +:8] | ({8{s31[52]}} & s34[52 * 8 +:8]) | ((s0[52 * 8 +:8] & {8{s33[52]}}) | {8{s28[52]}});
        assign result1[53 * 8 +:8] = s36[181 * 8 +:8] | s35[181 * 8 +:8] | ({8{s31[53]}} & s34[53 * 8 +:8]) | ((s0[53 * 8 +:8] & {8{s33[53]}}) | {8{s28[53]}});
        assign result1[54 * 8 +:8] = s36[182 * 8 +:8] | s35[182 * 8 +:8] | ({8{s31[54]}} & s34[54 * 8 +:8]) | ((s0[54 * 8 +:8] & {8{s33[54]}}) | {8{s28[54]}});
        assign result1[55 * 8 +:8] = s36[183 * 8 +:8] | s35[183 * 8 +:8] | ({8{s31[55]}} & s34[55 * 8 +:8]) | ((s0[55 * 8 +:8] & {8{s33[55]}}) | {8{s28[55]}});
        assign result1[56 * 8 +:8] = s36[184 * 8 +:8] | s35[184 * 8 +:8] | ({8{s31[56]}} & s34[56 * 8 +:8]) | ((s0[56 * 8 +:8] & {8{s33[56]}}) | {8{s28[56]}});
        assign result1[57 * 8 +:8] = s36[185 * 8 +:8] | s35[185 * 8 +:8] | ({8{s31[57]}} & s34[57 * 8 +:8]) | ((s0[57 * 8 +:8] & {8{s33[57]}}) | {8{s28[57]}});
        assign result1[58 * 8 +:8] = s36[186 * 8 +:8] | s35[186 * 8 +:8] | ({8{s31[58]}} & s34[58 * 8 +:8]) | ((s0[58 * 8 +:8] & {8{s33[58]}}) | {8{s28[58]}});
        assign result1[59 * 8 +:8] = s36[187 * 8 +:8] | s35[187 * 8 +:8] | ({8{s31[59]}} & s34[59 * 8 +:8]) | ((s0[59 * 8 +:8] & {8{s33[59]}}) | {8{s28[59]}});
        assign result1[60 * 8 +:8] = s36[188 * 8 +:8] | s35[188 * 8 +:8] | ({8{s31[60]}} & s34[60 * 8 +:8]) | ((s0[60 * 8 +:8] & {8{s33[60]}}) | {8{s28[60]}});
        assign result1[61 * 8 +:8] = s36[189 * 8 +:8] | s35[189 * 8 +:8] | ({8{s31[61]}} & s34[61 * 8 +:8]) | ((s0[61 * 8 +:8] & {8{s33[61]}}) | {8{s28[61]}});
        assign result1[62 * 8 +:8] = s36[190 * 8 +:8] | s35[190 * 8 +:8] | ({8{s31[62]}} & s34[62 * 8 +:8]) | ((s0[62 * 8 +:8] & {8{s33[62]}}) | {8{s28[62]}});
        assign result1[63 * 8 +:8] = s36[191 * 8 +:8] | s35[191 * 8 +:8] | ({8{s31[63]}} & s34[63 * 8 +:8]) | ((s0[63 * 8 +:8] & {8{s33[63]}}) | {8{s28[63]}});
        assign result1[64 * 8 +:8] = s36[192 * 8 +:8] | s35[192 * 8 +:8] | ({8{s31[64]}} & s34[64 * 8 +:8]) | ((s0[64 * 8 +:8] & {8{s33[64]}}) | {8{s28[64]}});
        assign result1[65 * 8 +:8] = s36[193 * 8 +:8] | s35[193 * 8 +:8] | ({8{s31[65]}} & s34[65 * 8 +:8]) | ((s0[65 * 8 +:8] & {8{s33[65]}}) | {8{s28[65]}});
        assign result1[66 * 8 +:8] = s36[194 * 8 +:8] | s35[194 * 8 +:8] | ({8{s31[66]}} & s34[66 * 8 +:8]) | ((s0[66 * 8 +:8] & {8{s33[66]}}) | {8{s28[66]}});
        assign result1[67 * 8 +:8] = s36[195 * 8 +:8] | s35[195 * 8 +:8] | ({8{s31[67]}} & s34[67 * 8 +:8]) | ((s0[67 * 8 +:8] & {8{s33[67]}}) | {8{s28[67]}});
        assign result1[68 * 8 +:8] = s36[196 * 8 +:8] | s35[196 * 8 +:8] | ({8{s31[68]}} & s34[68 * 8 +:8]) | ((s0[68 * 8 +:8] & {8{s33[68]}}) | {8{s28[68]}});
        assign result1[69 * 8 +:8] = s36[197 * 8 +:8] | s35[197 * 8 +:8] | ({8{s31[69]}} & s34[69 * 8 +:8]) | ((s0[69 * 8 +:8] & {8{s33[69]}}) | {8{s28[69]}});
        assign result1[70 * 8 +:8] = s36[198 * 8 +:8] | s35[198 * 8 +:8] | ({8{s31[70]}} & s34[70 * 8 +:8]) | ((s0[70 * 8 +:8] & {8{s33[70]}}) | {8{s28[70]}});
        assign result1[71 * 8 +:8] = s36[199 * 8 +:8] | s35[199 * 8 +:8] | ({8{s31[71]}} & s34[71 * 8 +:8]) | ((s0[71 * 8 +:8] & {8{s33[71]}}) | {8{s28[71]}});
        assign result1[72 * 8 +:8] = s36[200 * 8 +:8] | s35[200 * 8 +:8] | ({8{s31[72]}} & s34[72 * 8 +:8]) | ((s0[72 * 8 +:8] & {8{s33[72]}}) | {8{s28[72]}});
        assign result1[73 * 8 +:8] = s36[201 * 8 +:8] | s35[201 * 8 +:8] | ({8{s31[73]}} & s34[73 * 8 +:8]) | ((s0[73 * 8 +:8] & {8{s33[73]}}) | {8{s28[73]}});
        assign result1[74 * 8 +:8] = s36[202 * 8 +:8] | s35[202 * 8 +:8] | ({8{s31[74]}} & s34[74 * 8 +:8]) | ((s0[74 * 8 +:8] & {8{s33[74]}}) | {8{s28[74]}});
        assign result1[75 * 8 +:8] = s36[203 * 8 +:8] | s35[203 * 8 +:8] | ({8{s31[75]}} & s34[75 * 8 +:8]) | ((s0[75 * 8 +:8] & {8{s33[75]}}) | {8{s28[75]}});
        assign result1[76 * 8 +:8] = s36[204 * 8 +:8] | s35[204 * 8 +:8] | ({8{s31[76]}} & s34[76 * 8 +:8]) | ((s0[76 * 8 +:8] & {8{s33[76]}}) | {8{s28[76]}});
        assign result1[77 * 8 +:8] = s36[205 * 8 +:8] | s35[205 * 8 +:8] | ({8{s31[77]}} & s34[77 * 8 +:8]) | ((s0[77 * 8 +:8] & {8{s33[77]}}) | {8{s28[77]}});
        assign result1[78 * 8 +:8] = s36[206 * 8 +:8] | s35[206 * 8 +:8] | ({8{s31[78]}} & s34[78 * 8 +:8]) | ((s0[78 * 8 +:8] & {8{s33[78]}}) | {8{s28[78]}});
        assign result1[79 * 8 +:8] = s36[207 * 8 +:8] | s35[207 * 8 +:8] | ({8{s31[79]}} & s34[79 * 8 +:8]) | ((s0[79 * 8 +:8] & {8{s33[79]}}) | {8{s28[79]}});
        assign result1[80 * 8 +:8] = s36[208 * 8 +:8] | s35[208 * 8 +:8] | ({8{s31[80]}} & s34[80 * 8 +:8]) | ((s0[80 * 8 +:8] & {8{s33[80]}}) | {8{s28[80]}});
        assign result1[81 * 8 +:8] = s36[209 * 8 +:8] | s35[209 * 8 +:8] | ({8{s31[81]}} & s34[81 * 8 +:8]) | ((s0[81 * 8 +:8] & {8{s33[81]}}) | {8{s28[81]}});
        assign result1[82 * 8 +:8] = s36[210 * 8 +:8] | s35[210 * 8 +:8] | ({8{s31[82]}} & s34[82 * 8 +:8]) | ((s0[82 * 8 +:8] & {8{s33[82]}}) | {8{s28[82]}});
        assign result1[83 * 8 +:8] = s36[211 * 8 +:8] | s35[211 * 8 +:8] | ({8{s31[83]}} & s34[83 * 8 +:8]) | ((s0[83 * 8 +:8] & {8{s33[83]}}) | {8{s28[83]}});
        assign result1[84 * 8 +:8] = s36[212 * 8 +:8] | s35[212 * 8 +:8] | ({8{s31[84]}} & s34[84 * 8 +:8]) | ((s0[84 * 8 +:8] & {8{s33[84]}}) | {8{s28[84]}});
        assign result1[85 * 8 +:8] = s36[213 * 8 +:8] | s35[213 * 8 +:8] | ({8{s31[85]}} & s34[85 * 8 +:8]) | ((s0[85 * 8 +:8] & {8{s33[85]}}) | {8{s28[85]}});
        assign result1[86 * 8 +:8] = s36[214 * 8 +:8] | s35[214 * 8 +:8] | ({8{s31[86]}} & s34[86 * 8 +:8]) | ((s0[86 * 8 +:8] & {8{s33[86]}}) | {8{s28[86]}});
        assign result1[87 * 8 +:8] = s36[215 * 8 +:8] | s35[215 * 8 +:8] | ({8{s31[87]}} & s34[87 * 8 +:8]) | ((s0[87 * 8 +:8] & {8{s33[87]}}) | {8{s28[87]}});
        assign result1[88 * 8 +:8] = s36[216 * 8 +:8] | s35[216 * 8 +:8] | ({8{s31[88]}} & s34[88 * 8 +:8]) | ((s0[88 * 8 +:8] & {8{s33[88]}}) | {8{s28[88]}});
        assign result1[89 * 8 +:8] = s36[217 * 8 +:8] | s35[217 * 8 +:8] | ({8{s31[89]}} & s34[89 * 8 +:8]) | ((s0[89 * 8 +:8] & {8{s33[89]}}) | {8{s28[89]}});
        assign result1[90 * 8 +:8] = s36[218 * 8 +:8] | s35[218 * 8 +:8] | ({8{s31[90]}} & s34[90 * 8 +:8]) | ((s0[90 * 8 +:8] & {8{s33[90]}}) | {8{s28[90]}});
        assign result1[91 * 8 +:8] = s36[219 * 8 +:8] | s35[219 * 8 +:8] | ({8{s31[91]}} & s34[91 * 8 +:8]) | ((s0[91 * 8 +:8] & {8{s33[91]}}) | {8{s28[91]}});
        assign result1[92 * 8 +:8] = s36[220 * 8 +:8] | s35[220 * 8 +:8] | ({8{s31[92]}} & s34[92 * 8 +:8]) | ((s0[92 * 8 +:8] & {8{s33[92]}}) | {8{s28[92]}});
        assign result1[93 * 8 +:8] = s36[221 * 8 +:8] | s35[221 * 8 +:8] | ({8{s31[93]}} & s34[93 * 8 +:8]) | ((s0[93 * 8 +:8] & {8{s33[93]}}) | {8{s28[93]}});
        assign result1[94 * 8 +:8] = s36[222 * 8 +:8] | s35[222 * 8 +:8] | ({8{s31[94]}} & s34[94 * 8 +:8]) | ((s0[94 * 8 +:8] & {8{s33[94]}}) | {8{s28[94]}});
        assign result1[95 * 8 +:8] = s36[223 * 8 +:8] | s35[223 * 8 +:8] | ({8{s31[95]}} & s34[95 * 8 +:8]) | ((s0[95 * 8 +:8] & {8{s33[95]}}) | {8{s28[95]}});
        assign result1[96 * 8 +:8] = s36[224 * 8 +:8] | s35[224 * 8 +:8] | ({8{s31[96]}} & s34[96 * 8 +:8]) | ((s0[96 * 8 +:8] & {8{s33[96]}}) | {8{s28[96]}});
        assign result1[97 * 8 +:8] = s36[225 * 8 +:8] | s35[225 * 8 +:8] | ({8{s31[97]}} & s34[97 * 8 +:8]) | ((s0[97 * 8 +:8] & {8{s33[97]}}) | {8{s28[97]}});
        assign result1[98 * 8 +:8] = s36[226 * 8 +:8] | s35[226 * 8 +:8] | ({8{s31[98]}} & s34[98 * 8 +:8]) | ((s0[98 * 8 +:8] & {8{s33[98]}}) | {8{s28[98]}});
        assign result1[99 * 8 +:8] = s36[227 * 8 +:8] | s35[227 * 8 +:8] | ({8{s31[99]}} & s34[99 * 8 +:8]) | ((s0[99 * 8 +:8] & {8{s33[99]}}) | {8{s28[99]}});
        assign result1[100 * 8 +:8] = s36[228 * 8 +:8] | s35[228 * 8 +:8] | ({8{s31[100]}} & s34[100 * 8 +:8]) | ((s0[100 * 8 +:8] & {8{s33[100]}}) | {8{s28[100]}});
        assign result1[101 * 8 +:8] = s36[229 * 8 +:8] | s35[229 * 8 +:8] | ({8{s31[101]}} & s34[101 * 8 +:8]) | ((s0[101 * 8 +:8] & {8{s33[101]}}) | {8{s28[101]}});
        assign result1[102 * 8 +:8] = s36[230 * 8 +:8] | s35[230 * 8 +:8] | ({8{s31[102]}} & s34[102 * 8 +:8]) | ((s0[102 * 8 +:8] & {8{s33[102]}}) | {8{s28[102]}});
        assign result1[103 * 8 +:8] = s36[231 * 8 +:8] | s35[231 * 8 +:8] | ({8{s31[103]}} & s34[103 * 8 +:8]) | ((s0[103 * 8 +:8] & {8{s33[103]}}) | {8{s28[103]}});
        assign result1[104 * 8 +:8] = s36[232 * 8 +:8] | s35[232 * 8 +:8] | ({8{s31[104]}} & s34[104 * 8 +:8]) | ((s0[104 * 8 +:8] & {8{s33[104]}}) | {8{s28[104]}});
        assign result1[105 * 8 +:8] = s36[233 * 8 +:8] | s35[233 * 8 +:8] | ({8{s31[105]}} & s34[105 * 8 +:8]) | ((s0[105 * 8 +:8] & {8{s33[105]}}) | {8{s28[105]}});
        assign result1[106 * 8 +:8] = s36[234 * 8 +:8] | s35[234 * 8 +:8] | ({8{s31[106]}} & s34[106 * 8 +:8]) | ((s0[106 * 8 +:8] & {8{s33[106]}}) | {8{s28[106]}});
        assign result1[107 * 8 +:8] = s36[235 * 8 +:8] | s35[235 * 8 +:8] | ({8{s31[107]}} & s34[107 * 8 +:8]) | ((s0[107 * 8 +:8] & {8{s33[107]}}) | {8{s28[107]}});
        assign result1[108 * 8 +:8] = s36[236 * 8 +:8] | s35[236 * 8 +:8] | ({8{s31[108]}} & s34[108 * 8 +:8]) | ((s0[108 * 8 +:8] & {8{s33[108]}}) | {8{s28[108]}});
        assign result1[109 * 8 +:8] = s36[237 * 8 +:8] | s35[237 * 8 +:8] | ({8{s31[109]}} & s34[109 * 8 +:8]) | ((s0[109 * 8 +:8] & {8{s33[109]}}) | {8{s28[109]}});
        assign result1[110 * 8 +:8] = s36[238 * 8 +:8] | s35[238 * 8 +:8] | ({8{s31[110]}} & s34[110 * 8 +:8]) | ((s0[110 * 8 +:8] & {8{s33[110]}}) | {8{s28[110]}});
        assign result1[111 * 8 +:8] = s36[239 * 8 +:8] | s35[239 * 8 +:8] | ({8{s31[111]}} & s34[111 * 8 +:8]) | ((s0[111 * 8 +:8] & {8{s33[111]}}) | {8{s28[111]}});
        assign result1[112 * 8 +:8] = s36[240 * 8 +:8] | s35[240 * 8 +:8] | ({8{s31[112]}} & s34[112 * 8 +:8]) | ((s0[112 * 8 +:8] & {8{s33[112]}}) | {8{s28[112]}});
        assign result1[113 * 8 +:8] = s36[241 * 8 +:8] | s35[241 * 8 +:8] | ({8{s31[113]}} & s34[113 * 8 +:8]) | ((s0[113 * 8 +:8] & {8{s33[113]}}) | {8{s28[113]}});
        assign result1[114 * 8 +:8] = s36[242 * 8 +:8] | s35[242 * 8 +:8] | ({8{s31[114]}} & s34[114 * 8 +:8]) | ((s0[114 * 8 +:8] & {8{s33[114]}}) | {8{s28[114]}});
        assign result1[115 * 8 +:8] = s36[243 * 8 +:8] | s35[243 * 8 +:8] | ({8{s31[115]}} & s34[115 * 8 +:8]) | ((s0[115 * 8 +:8] & {8{s33[115]}}) | {8{s28[115]}});
        assign result1[116 * 8 +:8] = s36[244 * 8 +:8] | s35[244 * 8 +:8] | ({8{s31[116]}} & s34[116 * 8 +:8]) | ((s0[116 * 8 +:8] & {8{s33[116]}}) | {8{s28[116]}});
        assign result1[117 * 8 +:8] = s36[245 * 8 +:8] | s35[245 * 8 +:8] | ({8{s31[117]}} & s34[117 * 8 +:8]) | ((s0[117 * 8 +:8] & {8{s33[117]}}) | {8{s28[117]}});
        assign result1[118 * 8 +:8] = s36[246 * 8 +:8] | s35[246 * 8 +:8] | ({8{s31[118]}} & s34[118 * 8 +:8]) | ((s0[118 * 8 +:8] & {8{s33[118]}}) | {8{s28[118]}});
        assign result1[119 * 8 +:8] = s36[247 * 8 +:8] | s35[247 * 8 +:8] | ({8{s31[119]}} & s34[119 * 8 +:8]) | ((s0[119 * 8 +:8] & {8{s33[119]}}) | {8{s28[119]}});
        assign result1[120 * 8 +:8] = s36[248 * 8 +:8] | s35[248 * 8 +:8] | ({8{s31[120]}} & s34[120 * 8 +:8]) | ((s0[120 * 8 +:8] & {8{s33[120]}}) | {8{s28[120]}});
        assign result1[121 * 8 +:8] = s36[249 * 8 +:8] | s35[249 * 8 +:8] | ({8{s31[121]}} & s34[121 * 8 +:8]) | ((s0[121 * 8 +:8] & {8{s33[121]}}) | {8{s28[121]}});
        assign result1[122 * 8 +:8] = s36[250 * 8 +:8] | s35[250 * 8 +:8] | ({8{s31[122]}} & s34[122 * 8 +:8]) | ((s0[122 * 8 +:8] & {8{s33[122]}}) | {8{s28[122]}});
        assign result1[123 * 8 +:8] = s36[251 * 8 +:8] | s35[251 * 8 +:8] | ({8{s31[123]}} & s34[123 * 8 +:8]) | ((s0[123 * 8 +:8] & {8{s33[123]}}) | {8{s28[123]}});
        assign result1[124 * 8 +:8] = s36[252 * 8 +:8] | s35[252 * 8 +:8] | ({8{s31[124]}} & s34[124 * 8 +:8]) | ((s0[124 * 8 +:8] & {8{s33[124]}}) | {8{s28[124]}});
        assign result1[125 * 8 +:8] = s36[253 * 8 +:8] | s35[253 * 8 +:8] | ({8{s31[125]}} & s34[125 * 8 +:8]) | ((s0[125 * 8 +:8] & {8{s33[125]}}) | {8{s28[125]}});
        assign result1[126 * 8 +:8] = s36[254 * 8 +:8] | s35[254 * 8 +:8] | ({8{s31[126]}} & s34[126 * 8 +:8]) | ((s0[126 * 8 +:8] & {8{s33[126]}}) | {8{s28[126]}});
        assign result1[127 * 8 +:8] = s36[255 * 8 +:8] | s35[255 * 8 +:8] | ({8{s31[127]}} & s34[127 * 8 +:8]) | ((s0[127 * 8 +:8] & {8{s33[127]}}) | {8{s28[127]}});
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

