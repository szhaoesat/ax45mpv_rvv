// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vrf (
    vpu_init_rf,
    v0t,
    vrf_r0_addr,
    vrf_r1_addr,
    vrf_r2_addr,
    vrf_r3_addr,
    vrf_r4_addr,
    vrf_r5_addr,
    vrf_r6_addr,
    vrf_r7_addr,
    vrf_r8_addr,
    vrf_r9_addr,
    vrf_r10_addr,
    vrf_r0_beat,
    vrf_r1_beat,
    vrf_r2_beat,
    vrf_r3_beat,
    vrf_r4_beat,
    vrf_r5_beat,
    vrf_r6_beat,
    vrf_r7_beat,
    vrf_r8_beat,
    vrf_r9_beat,
    vrf_r10_beat,
    vrf_r0_data,
    vrf_r1_data,
    vrf_r2_data,
    vrf_r3_data,
    vrf_r4_data,
    vrf_r5_data,
    vrf_r6_data,
    vrf_r7_data,
    vrf_r8_data,
    vrf_r9_data,
    vrf_r10_data,
    vrf_w0_en,
    vrf_w1_en,
    vrf_w2_en,
    vrf_w3_en,
    vrf_w4_en,
    vrf_w0_addr,
    vrf_w1_addr,
    vrf_w2_addr,
    vrf_w3_addr,
    vrf_w4_addr,
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
    vrf_w5_en,
    vrf_w5_addr,
    vrf_w5_data,
    vrf_w5_mask,
    vpu_clk,
    vpu_reset_n
);
parameter VRF_AW = 5;
parameter VLEN = 1024;
parameter DLEN = 512;
parameter BYPASSW = 5;
parameter VRF_MUX = 32;
parameter VMAC2_TYPE = 0;
input vpu_init_rf;
output [VLEN - 1:0] v0t;
input [(VLEN / 64 * 5) - 1:0] vrf_r0_addr;
input [(VLEN / 64 * 5) - 1:0] vrf_r1_addr;
input [(VLEN / 64 * 5) - 1:0] vrf_r2_addr;
input [(VLEN / 64 * 5) - 1:0] vrf_r3_addr;
input [(VLEN / 64 * 5) - 1:0] vrf_r4_addr;
input [(VLEN / 64 * 5) - 1:0] vrf_r5_addr;
input [(VLEN / 64 * 5) - 1:0] vrf_r6_addr;
input [(VLEN / 64 * 5) - 1:0] vrf_r7_addr;
input [(VLEN / 64 * 5) - 1:0] vrf_r8_addr;
input [(VLEN / 64 * 5) - 1:0] vrf_r9_addr;
input [(VLEN / 64 * 5) - 1:0] vrf_r10_addr;
input vrf_r0_beat;
input vrf_r1_beat;
input vrf_r2_beat;
input vrf_r3_beat;
input vrf_r4_beat;
input vrf_r5_beat;
input vrf_r6_beat;
input vrf_r7_beat;
input vrf_r8_beat;
input vrf_r9_beat;
input vrf_r10_beat;
output [DLEN - 1:0] vrf_r0_data;
output [DLEN - 1:0] vrf_r1_data;
output [DLEN - 1:0] vrf_r2_data;
output [DLEN - 1:0] vrf_r3_data;
output [DLEN - 1:0] vrf_r4_data;
output [DLEN - 1:0] vrf_r5_data;
output [DLEN - 1:0] vrf_r6_data;
output [DLEN - 1:0] vrf_r7_data;
output [DLEN - 1:0] vrf_r8_data;
output [DLEN - 1:0] vrf_r9_data;
output [DLEN - 1:0] vrf_r10_data;
input vrf_w0_en;
input vrf_w1_en;
input vrf_w2_en;
input vrf_w3_en;
input vrf_w4_en;
input [VRF_AW - 1:0] vrf_w0_addr;
input [VRF_AW - 1:0] vrf_w1_addr;
input [VRF_AW - 1:0] vrf_w2_addr;
input [VRF_AW - 1:0] vrf_w3_addr;
input [VRF_AW - 1:0] vrf_w4_addr;
input [DLEN - 1:0] vrf_w0_data;
input [DLEN - 1:0] vrf_w1_data;
input [DLEN - 1:0] vrf_w2_data;
input [DLEN - 1:0] vrf_w3_data;
input [DLEN - 1:0] vrf_w4_data;
input [(DLEN / 8) - 1:0] vrf_w0_mask;
input [(DLEN / 8) - 1:0] vrf_w1_mask;
input [(DLEN / 8) - 1:0] vrf_w2_mask;
input [(DLEN / 8) - 1:0] vrf_w3_mask;
input [(DLEN / 8) - 1:0] vrf_w4_mask;
input vrf_w5_en;
input [VRF_AW - 1:0] vrf_w5_addr;
input [DLEN - 1:0] vrf_w5_data;
input [(DLEN / 8) - 1:0] vrf_w5_mask;
input vpu_clk;
input vpu_reset_n;





// 47184566 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [VLEN - 1:0] s0;
wire [VLEN - 1:0] s1;
wire [VLEN - 1:0] s2;
wire [VLEN - 1:0] s3;
wire [VLEN - 1:0] s4;
wire [(VLEN / 8) - 1:0] s5;
wire [(VLEN / 8) - 1:0] s6;
wire [(VLEN / 8) - 1:0] s7;
wire [(VLEN / 8) - 1:0] s8;
wire [(VLEN / 8) - 1:0] s9;
wire [4:0] s10 = vrf_w0_addr[VRF_AW - 1:VRF_AW - 5];
wire [4:0] s11 = vrf_w1_addr[VRF_AW - 1:VRF_AW - 5];
wire [4:0] s12 = vrf_w2_addr[VRF_AW - 1:VRF_AW - 5];
wire [4:0] s13 = vrf_w3_addr[VRF_AW - 1:VRF_AW - 5];
wire [4:0] s14 = vrf_w4_addr[VRF_AW - 1:VRF_AW - 5];
wire [31:0] s15;
wire [31:0] s16;
wire [31:0] s17;
wire [31:0] s18;
wire [31:0] s19;
wire [31:0] s20;
wire [31:0] s21;
wire [31:0] s22;
wire [31:0] s23;
wire [31:0] s24;
wire [31:0] s25;
wire [31:0] s26;
wire [31:0] s27;
wire [31:0] s28;
wire [31:0] s29;
wire [VLEN - 1:0] s30;
wire [(VLEN / 8) - 1:0] s31;
wire [4:0] s32 = vrf_w5_addr[VRF_AW - 1:VRF_AW - 5];
wire [31:0] s33;
wire [31:0] s34;
wire [31:0] s35;
wire [VLEN - 1:0] s36;
wire [VLEN - 1:0] s37;
wire [VLEN - 1:0] s38;
wire [VLEN - 1:0] s39;
wire [VLEN - 1:0] s40;
wire [VLEN - 1:0] s41;
wire [VLEN - 1:0] s42;
wire [VLEN - 1:0] s43;
wire [VLEN - 1:0] s44;
wire [VLEN - 1:0] s45;
wire [VLEN - 1:0] s46;
wire [VLEN - 1:0] v0;
wire [VLEN - 1:0] v1;
wire [VLEN - 1:0] v2;
wire [VLEN - 1:0] v3;
wire [VLEN - 1:0] v4;
wire [VLEN - 1:0] v5;
wire [VLEN - 1:0] v6;
wire [VLEN - 1:0] v7;
wire [VLEN - 1:0] v8;
wire [VLEN - 1:0] v9;
wire [VLEN - 1:0] v10;
wire [VLEN - 1:0] v11;
wire [VLEN - 1:0] v12;
wire [VLEN - 1:0] v13;
wire [VLEN - 1:0] v14;
wire [VLEN - 1:0] v15;
wire [VLEN - 1:0] v16;
wire [VLEN - 1:0] v17;
wire [VLEN - 1:0] v18;
wire [VLEN - 1:0] v19;
wire [VLEN - 1:0] v20;
wire [VLEN - 1:0] v21;
wire [VLEN - 1:0] v22;
wire [VLEN - 1:0] v23;
wire [VLEN - 1:0] v24;
wire [VLEN - 1:0] v25;
wire [VLEN - 1:0] v26;
wire [VLEN - 1:0] v27;
wire [VLEN - 1:0] v28;
wire [VLEN - 1:0] v29;
wire [VLEN - 1:0] v30;
wire [VLEN - 1:0] v31;
wire nds_unused_debug_signals = (|v0) | (|v1) | (|v2) | (|v3) | (|v4) | (|v5) | (|v6) | (|v7) | (|v8) | (|v9) | (|v10) | (|v11) | (|v12) | (|v13) | (|v14) | (|v15) | (|v16) | (|v17) | (|v18) | (|v19) | (|v20) | (|v21) | (|v22) | (|v23) | (|v24) | (|v25) | (|v26) | (|v27) | (|v28) | (|v29) | (|v30) | (|v31);
generate
    genvar ii;
    for (ii = 0; ii < VLEN / 64; ii = ii + 1) begin:gen_vpu_mem
        wire [31:0] s47 = (ii >= (VLEN / 64 / 2)) ? s25 : s20;
        wire [31:0] s48 = (ii >= (VLEN / 64 / 2)) ? s26 : s21;
        wire [31:0] s49 = (ii >= (VLEN / 64 / 2)) ? s27 : s22;
        wire [31:0] s50 = (ii >= (VLEN / 64 / 2)) ? s28 : s23;
        wire [31:0] s51 = (ii >= (VLEN / 64 / 2)) ? s29 : s24;
        wire [31:0] s52 = (ii >= (VLEN / 64 / 2)) ? s35 : s34;
        kv_vrf_mem #(
            .ELEN(64),
            .VRF_MUX(VRF_MUX),
            .VMAC2_TYPE(VMAC2_TYPE)
        ) u_mem (
            .vpu_clk(vpu_clk),
            .vrf_r0_addr(vrf_r0_addr[ii * 5 +:5]),
            .vrf_r0_data(s36[ii * 64 +:64]),
            .vrf_r1_addr(vrf_r1_addr[ii * 5 +:5]),
            .vrf_r1_data(s37[ii * 64 +:64]),
            .vrf_r2_addr(vrf_r2_addr[ii * 5 +:5]),
            .vrf_r2_data(s38[ii * 64 +:64]),
            .vrf_r3_addr(vrf_r3_addr[ii * 5 +:5]),
            .vrf_r3_data(s39[ii * 64 +:64]),
            .vrf_r4_addr(vrf_r4_addr[ii * 5 +:5]),
            .vrf_r4_data(s40[ii * 64 +:64]),
            .vrf_r5_addr(vrf_r5_addr[ii * 5 +:5]),
            .vrf_r5_data(s41[ii * 64 +:64]),
            .vrf_r6_addr(vrf_r6_addr[ii * 5 +:5]),
            .vrf_r6_data(s42[ii * 64 +:64]),
            .vrf_r7_addr(vrf_r7_addr[ii * 5 +:5]),
            .vrf_r7_data(s43[ii * 64 +:64]),
            .vrf_r8_addr(vrf_r8_addr[ii * 5 +:5]),
            .vrf_r8_data(s44[ii * 64 +:64]),
            .vrf_r9_addr(vrf_r9_addr[ii * 5 +:5]),
            .vrf_r9_data(s45[ii * 64 +:64]),
            .vrf_r10_addr(vrf_r10_addr[ii * 5 +:5]),
            .vrf_r10_data(s46[ii * 64 +:64]),
            .vrf_w0_wen(s47[31:0]),
            .vrf_w0_data(s0[ii * 64 +:64]),
            .vrf_w0_mask(s5[ii * 8 +:8]),
            .vrf_w1_wen(s48[31:0]),
            .vrf_w1_data(s1[ii * 64 +:64]),
            .vrf_w1_mask(s6[ii * 8 +:8]),
            .vrf_w2_wen(s49[31:0]),
            .vrf_w2_data(s2[ii * 64 +:64]),
            .vrf_w2_mask(s7[ii * 8 +:8]),
            .vrf_w3_wen(s50[31:0]),
            .vrf_w3_data(s3[ii * 64 +:64]),
            .vrf_w3_mask(s8[ii * 8 +:8]),
            .vrf_w4_wen(s51[31:0]),
            .vrf_w4_data(s4[ii * 64 +:64]),
            .vrf_w4_mask(s9[ii * 8 +:8]),
            .vrf_w5_wen(s52[31:0]),
            .vrf_w5_data(s30[ii * 64 +:64]),
            .vrf_w5_mask(s31[ii * 8 +:8]),
            .v0(v0[ii * 64 +:64]),
            .v1(v1[ii * 64 +:64]),
            .v2(v2[ii * 64 +:64]),
            .v3(v3[ii * 64 +:64]),
            .v4(v4[ii * 64 +:64]),
            .v5(v5[ii * 64 +:64]),
            .v6(v6[ii * 64 +:64]),
            .v7(v7[ii * 64 +:64]),
            .v8(v8[ii * 64 +:64]),
            .v9(v9[ii * 64 +:64]),
            .v10(v10[ii * 64 +:64]),
            .v11(v11[ii * 64 +:64]),
            .v12(v12[ii * 64 +:64]),
            .v13(v13[ii * 64 +:64]),
            .v14(v14[ii * 64 +:64]),
            .v15(v15[ii * 64 +:64]),
            .v16(v16[ii * 64 +:64]),
            .v17(v17[ii * 64 +:64]),
            .v18(v18[ii * 64 +:64]),
            .v19(v19[ii * 64 +:64]),
            .v20(v20[ii * 64 +:64]),
            .v21(v21[ii * 64 +:64]),
            .v22(v22[ii * 64 +:64]),
            .v23(v23[ii * 64 +:64]),
            .v24(v24[ii * 64 +:64]),
            .v25(v25[ii * 64 +:64]),
            .v26(v26[ii * 64 +:64]),
            .v27(v27[ii * 64 +:64]),
            .v28(v28[ii * 64 +:64]),
            .v29(v29[ii * 64 +:64]),
            .v30(v30[ii * 64 +:64]),
            .v31(v31[ii * 64 +:64])
        );
    end
endgenerate
assign v0t = v0;
kv_bin2onehot #(
    .N(32)
) u_w0_addr_onehot (
    .out(s15),
    .in(s10)
);
kv_bin2onehot #(
    .N(32)
) u_w1_addr_onehot (
    .out(s16),
    .in(s11)
);
kv_bin2onehot #(
    .N(32)
) u_w2_addr_onehot (
    .out(s17),
    .in(s12)
);
kv_bin2onehot #(
    .N(32)
) u_w3_addr_onehot (
    .out(s18),
    .in(s13)
);
kv_bin2onehot #(
    .N(32)
) u_w4_addr_onehot (
    .out(s19),
    .in(s14)
);
kv_bin2onehot #(
    .N(32)
) u_w5_addr_onehot (
    .out(s33),
    .in(s32)
);
generate
    if (VLEN == DLEN) begin:gen_vlen_deln_ratio1
        assign vrf_r0_data = s36;
        assign vrf_r1_data = s37;
        assign vrf_r2_data = s38;
        assign vrf_r3_data = s39;
        assign vrf_r4_data = s40;
        assign vrf_r5_data = s41;
        assign vrf_r6_data = s42;
        assign vrf_r7_data = s43;
        assign s0 = vrf_w0_data;
        assign s1 = vrf_w1_data;
        assign s2 = vrf_w2_data;
        assign s3 = vrf_w3_data;
        assign s4 = vrf_w4_data;
        assign s5 = vrf_w0_mask;
        assign s6 = vrf_w1_mask;
        assign s7 = vrf_w2_mask;
        assign s8 = vrf_w3_mask;
        assign s9 = vrf_w4_mask;
        assign s20 = {32{vrf_w0_en}} & s15;
        assign s21 = {32{vrf_w1_en}} & s16;
        assign s22 = {32{vrf_w2_en}} & s17;
        assign s23 = {32{vrf_w3_en}} & s18;
        assign s24 = {32{vrf_w4_en}} & s19;
        assign s25 = {32{vrf_w0_en}} & s15;
        assign s26 = {32{vrf_w1_en}} & s16;
        assign s27 = {32{vrf_w2_en}} & s17;
        assign s28 = {32{vrf_w3_en}} & s18;
        assign s29 = {32{vrf_w4_en}} & s19;
        assign vrf_r8_data = s44;
        assign vrf_r9_data = s45;
        assign vrf_r10_data = s46;
        assign s30 = vrf_w5_data;
        assign s31 = vrf_w5_mask;
        assign s34 = {32{vrf_w5_en}} & s33;
        assign s35 = {32{vrf_w5_en}} & s33;
    end
    else begin:gen_vlen_deln_ratio2
        assign vrf_r0_data = vrf_r0_beat ? s36[VLEN - 1:DLEN] : s36[DLEN - 1:0];
        assign vrf_r1_data = vrf_r1_beat ? s37[VLEN - 1:DLEN] : s37[DLEN - 1:0];
        assign vrf_r2_data = vrf_r2_beat ? s38[VLEN - 1:DLEN] : s38[DLEN - 1:0];
        assign vrf_r3_data = vrf_r3_beat ? s39[VLEN - 1:DLEN] : s39[DLEN - 1:0];
        assign vrf_r4_data = vrf_r4_beat ? s40[VLEN - 1:DLEN] : s40[DLEN - 1:0];
        assign vrf_r5_data = vrf_r5_beat ? s41[VLEN - 1:DLEN] : s41[DLEN - 1:0];
        assign vrf_r6_data = vrf_r6_beat ? s42[VLEN - 1:DLEN] : s42[DLEN - 1:0];
        assign vrf_r7_data = vrf_r7_beat ? s43[VLEN - 1:DLEN] : s43[DLEN - 1:0];
        assign vrf_r8_data = vrf_r8_beat ? s44[VLEN - 1:DLEN] : s44[DLEN - 1:0];
        assign vrf_r9_data = vrf_r9_beat ? s45[VLEN - 1:DLEN] : s45[DLEN - 1:0];
        assign vrf_r10_data = vrf_r10_beat ? s46[VLEN - 1:DLEN] : s46[DLEN - 1:0];
        assign s0 = {2{vrf_w0_data}};
        assign s1 = {2{vrf_w1_data}};
        assign s2 = {2{vrf_w2_data}};
        assign s3 = {2{vrf_w3_data}};
        assign s4 = {2{vrf_w4_data}};
        assign s5 = {2{vrf_w0_mask}};
        assign s6 = {2{vrf_w1_mask}};
        assign s7 = {2{vrf_w2_mask}};
        assign s8 = {2{vrf_w3_mask}};
        assign s9 = {2{vrf_w4_mask}};
        assign s20 = {32{vrf_w0_en & ~vrf_w0_addr[0]}} & s15;
        assign s21 = {32{vrf_w1_en & ~vrf_w1_addr[0]}} & s16;
        assign s22 = {32{vrf_w2_en & ~vrf_w2_addr[0]}} & s17;
        assign s23 = {32{vrf_w3_en & ~vrf_w3_addr[0]}} & s18;
        assign s24 = {32{vrf_w4_en & ~vrf_w4_addr[0]}} & s19;
        assign s25 = {32{vrf_w0_en & vrf_w0_addr[0]}} & s15;
        assign s26 = {32{vrf_w1_en & vrf_w1_addr[0]}} & s16;
        assign s27 = {32{vrf_w2_en & vrf_w2_addr[0]}} & s17;
        assign s28 = {32{vrf_w3_en & vrf_w3_addr[0]}} & s18;
        assign s29 = {32{vrf_w4_en & vrf_w4_addr[0]}} & s19;
        assign s30 = {2{vrf_w5_data}};
        assign s31 = {2{vrf_w5_mask}};
        assign s34 = {32{vrf_w5_en & ~vrf_w5_addr[0]}} & s33;
        assign s35 = {32{vrf_w5_en & vrf_w5_addr[0]}} & s33;
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

