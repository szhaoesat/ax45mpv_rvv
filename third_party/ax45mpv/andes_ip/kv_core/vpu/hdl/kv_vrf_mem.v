// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vrf_mem (
    vpu_clk,
    vrf_r0_addr,
    vrf_r0_data,
    vrf_r1_addr,
    vrf_r1_data,
    vrf_r2_addr,
    vrf_r2_data,
    vrf_r3_addr,
    vrf_r3_data,
    vrf_r4_addr,
    vrf_r4_data,
    vrf_r5_addr,
    vrf_r5_data,
    vrf_r6_addr,
    vrf_r6_data,
    vrf_r7_addr,
    vrf_r7_data,
    vrf_r8_addr,
    vrf_r8_data,
    vrf_r9_addr,
    vrf_r9_data,
    vrf_r10_addr,
    vrf_r10_data,
    vrf_w0_wen,
    vrf_w0_data,
    vrf_w0_mask,
    vrf_w1_wen,
    vrf_w1_data,
    vrf_w1_mask,
    vrf_w2_wen,
    vrf_w2_data,
    vrf_w2_mask,
    vrf_w3_wen,
    vrf_w3_data,
    vrf_w3_mask,
    vrf_w4_wen,
    vrf_w4_data,
    vrf_w4_mask,
    vrf_w5_wen,
    vrf_w5_data,
    vrf_w5_mask,
    v0,
    v1,
    v2,
    v3,
    v4,
    v5,
    v6,
    v7,
    v8,
    v9,
    v10,
    v11,
    v12,
    v13,
    v14,
    v15,
    v16,
    v17,
    v18,
    v19,
    v20,
    v21,
    v22,
    v23,
    v24,
    v25,
    v26,
    v27,
    v28,
    v29,
    v30,
    v31
);
parameter ELEN = 64;
parameter VMAC2_TYPE = 0;
parameter VRF_MUX = 2;
input vpu_clk;
input [4:0] vrf_r0_addr;
output [ELEN - 1:0] vrf_r0_data;
input [4:0] vrf_r1_addr;
output [ELEN - 1:0] vrf_r1_data;
input [4:0] vrf_r2_addr;
output [ELEN - 1:0] vrf_r2_data;
input [4:0] vrf_r3_addr;
output [ELEN - 1:0] vrf_r3_data;
input [4:0] vrf_r4_addr;
output [ELEN - 1:0] vrf_r4_data;
input [4:0] vrf_r5_addr;
output [ELEN - 1:0] vrf_r5_data;
input [4:0] vrf_r6_addr;
output [ELEN - 1:0] vrf_r6_data;
input [4:0] vrf_r7_addr;
output [ELEN - 1:0] vrf_r7_data;
input [4:0] vrf_r8_addr;
output [ELEN - 1:0] vrf_r8_data;
input [4:0] vrf_r9_addr;
output [ELEN - 1:0] vrf_r9_data;
input [4:0] vrf_r10_addr;
output [ELEN - 1:0] vrf_r10_data;
input [31:0] vrf_w0_wen;
input [ELEN - 1:0] vrf_w0_data;
input [(ELEN / 8) - 1:0] vrf_w0_mask;
input [31:0] vrf_w1_wen;
input [ELEN - 1:0] vrf_w1_data;
input [(ELEN / 8) - 1:0] vrf_w1_mask;
input [31:0] vrf_w2_wen;
input [ELEN - 1:0] vrf_w2_data;
input [(ELEN / 8) - 1:0] vrf_w2_mask;
input [31:0] vrf_w3_wen;
input [ELEN - 1:0] vrf_w3_data;
input [(ELEN / 8) - 1:0] vrf_w3_mask;
input [31:0] vrf_w4_wen;
input [ELEN - 1:0] vrf_w4_data;
input [(ELEN / 8) - 1:0] vrf_w4_mask;
input [31:0] vrf_w5_wen;
input [ELEN - 1:0] vrf_w5_data;
input [(ELEN / 8) - 1:0] vrf_w5_mask;
output [ELEN - 1:0] v0;
output [ELEN - 1:0] v1;
output [ELEN - 1:0] v2;
output [ELEN - 1:0] v3;
output [ELEN - 1:0] v4;
output [ELEN - 1:0] v5;
output [ELEN - 1:0] v6;
output [ELEN - 1:0] v7;
output [ELEN - 1:0] v8;
output [ELEN - 1:0] v9;
output [ELEN - 1:0] v10;
output [ELEN - 1:0] v11;
output [ELEN - 1:0] v12;
output [ELEN - 1:0] v13;
output [ELEN - 1:0] v14;
output [ELEN - 1:0] v15;
output [ELEN - 1:0] v16;
output [ELEN - 1:0] v17;
output [ELEN - 1:0] v18;
output [ELEN - 1:0] v19;
output [ELEN - 1:0] v20;
output [ELEN - 1:0] v21;
output [ELEN - 1:0] v22;
output [ELEN - 1:0] v23;
output [ELEN - 1:0] v24;
output [ELEN - 1:0] v25;
output [ELEN - 1:0] v26;
output [ELEN - 1:0] v27;
output [ELEN - 1:0] v28;
output [ELEN - 1:0] v29;
output [ELEN - 1:0] v30;
output [ELEN - 1:0] v31;





// fc797061 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [ELEN - 1:0] s0;
wire [ELEN - 1:0] s1;
wire [ELEN - 1:0] s2;
wire [ELEN - 1:0] s3;
wire [ELEN - 1:0] s4;
wire [ELEN - 1:0] s5;
wire [ELEN - 1:0] s6;
wire [ELEN - 1:0] s7;
wire [ELEN - 1:0] s8;
wire [ELEN - 1:0] s9;
wire [ELEN - 1:0] s10;
wire [ELEN - 1:0] s11;
wire [ELEN - 1:0] s12;
wire [ELEN - 1:0] s13;
wire [ELEN - 1:0] s14;
wire [ELEN - 1:0] s15;
wire [ELEN - 1:0] s16;
wire [ELEN - 1:0] s17;
wire [ELEN - 1:0] s18;
wire [ELEN - 1:0] s19;
wire [ELEN - 1:0] s20;
wire [ELEN - 1:0] s21;
wire [ELEN - 1:0] s22;
wire [ELEN - 1:0] s23;
wire [ELEN - 1:0] s24;
wire [ELEN - 1:0] s25;
wire [ELEN - 1:0] s26;
wire [ELEN - 1:0] s27;
wire [ELEN - 1:0] s28;
wire [ELEN - 1:0] s29;
wire [ELEN - 1:0] s30;
wire [ELEN - 1:0] s31;
wire [ELEN * 32 - 1:0] s32 = {s31,s30,s29,s28,s27,s26,s25,s24,s23,s22,s21,s20,s19,s18,s17,s16,s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0};
wire [ELEN / 8 - 1:0] s33;
wire [ELEN - 1:0] s34;
wire [ELEN / 8 - 1:0] s35;
wire [ELEN - 1:0] s36;
wire [ELEN / 8 - 1:0] s37;
wire [ELEN - 1:0] s38;
wire [ELEN / 8 - 1:0] s39;
wire [ELEN - 1:0] s40;
wire [ELEN / 8 - 1:0] s41;
wire [ELEN - 1:0] s42;
wire [ELEN / 8 - 1:0] s43;
wire [ELEN - 1:0] s44;
wire [ELEN / 8 - 1:0] s45;
wire [ELEN - 1:0] s46;
wire [ELEN / 8 - 1:0] s47;
wire [ELEN - 1:0] s48;
wire [ELEN / 8 - 1:0] s49;
wire [ELEN - 1:0] s50;
wire [ELEN / 8 - 1:0] s51;
wire [ELEN - 1:0] s52;
wire [ELEN / 8 - 1:0] s53;
wire [ELEN - 1:0] s54;
wire [ELEN / 8 - 1:0] s55;
wire [ELEN - 1:0] s56;
wire [ELEN / 8 - 1:0] s57;
wire [ELEN - 1:0] s58;
wire [ELEN / 8 - 1:0] s59;
wire [ELEN - 1:0] s60;
wire [ELEN / 8 - 1:0] s61;
wire [ELEN - 1:0] s62;
wire [ELEN / 8 - 1:0] s63;
wire [ELEN - 1:0] s64;
wire [ELEN / 8 - 1:0] s65;
wire [ELEN - 1:0] s66;
wire [ELEN / 8 - 1:0] s67;
wire [ELEN - 1:0] s68;
wire [ELEN / 8 - 1:0] s69;
wire [ELEN - 1:0] s70;
wire [ELEN / 8 - 1:0] s71;
wire [ELEN - 1:0] s72;
wire [ELEN / 8 - 1:0] s73;
wire [ELEN - 1:0] s74;
wire [ELEN / 8 - 1:0] s75;
wire [ELEN - 1:0] s76;
wire [ELEN / 8 - 1:0] s77;
wire [ELEN - 1:0] s78;
wire [ELEN / 8 - 1:0] s79;
wire [ELEN - 1:0] s80;
wire [ELEN / 8 - 1:0] s81;
wire [ELEN - 1:0] s82;
wire [ELEN / 8 - 1:0] s83;
wire [ELEN - 1:0] s84;
wire [ELEN / 8 - 1:0] s85;
wire [ELEN - 1:0] s86;
wire [ELEN / 8 - 1:0] s87;
wire [ELEN - 1:0] s88;
wire [ELEN / 8 - 1:0] s89;
wire [ELEN - 1:0] s90;
wire [ELEN / 8 - 1:0] s91;
wire [ELEN - 1:0] s92;
wire [ELEN / 8 - 1:0] s93;
wire [ELEN - 1:0] s94;
wire [ELEN / 8 - 1:0] s95;
wire [ELEN - 1:0] s96;
generate
    if (VMAC2_TYPE != 0) begin:gen_v0_w6
        assign s33 = ({(ELEN / 8){vrf_w0_wen[0]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[0]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[0]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[0]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[0]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[0]}} & vrf_w5_mask);
        assign s34 = ({ELEN{vrf_w0_wen[0]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[0]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[0]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[0]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[0]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[0]}} & vrf_w5_data);
    end
    else begin:gen_v0_w5
        assign s33 = ({(ELEN / 8){vrf_w0_wen[0]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[0]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[0]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[0]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[0]}} & vrf_w4_mask);
        assign s34 = ({ELEN{vrf_w0_wen[0]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[0]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[0]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[0]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[0]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v1_w6
        assign s35 = ({(ELEN / 8){vrf_w0_wen[1]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[1]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[1]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[1]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[1]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[1]}} & vrf_w5_mask);
        assign s36 = ({ELEN{vrf_w0_wen[1]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[1]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[1]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[1]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[1]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[1]}} & vrf_w5_data);
    end
    else begin:gen_v1_w5
        assign s35 = ({(ELEN / 8){vrf_w0_wen[1]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[1]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[1]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[1]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[1]}} & vrf_w4_mask);
        assign s36 = ({ELEN{vrf_w0_wen[1]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[1]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[1]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[1]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[1]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v2_w6
        assign s37 = ({(ELEN / 8){vrf_w0_wen[2]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[2]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[2]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[2]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[2]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[2]}} & vrf_w5_mask);
        assign s38 = ({ELEN{vrf_w0_wen[2]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[2]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[2]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[2]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[2]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[2]}} & vrf_w5_data);
    end
    else begin:gen_v2_w5
        assign s37 = ({(ELEN / 8){vrf_w0_wen[2]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[2]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[2]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[2]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[2]}} & vrf_w4_mask);
        assign s38 = ({ELEN{vrf_w0_wen[2]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[2]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[2]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[2]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[2]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v3_w6
        assign s39 = ({(ELEN / 8){vrf_w0_wen[3]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[3]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[3]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[3]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[3]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[3]}} & vrf_w5_mask);
        assign s40 = ({ELEN{vrf_w0_wen[3]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[3]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[3]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[3]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[3]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[3]}} & vrf_w5_data);
    end
    else begin:gen_v3_w5
        assign s39 = ({(ELEN / 8){vrf_w0_wen[3]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[3]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[3]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[3]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[3]}} & vrf_w4_mask);
        assign s40 = ({ELEN{vrf_w0_wen[3]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[3]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[3]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[3]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[3]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v4_w6
        assign s41 = ({(ELEN / 8){vrf_w0_wen[4]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[4]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[4]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[4]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[4]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[4]}} & vrf_w5_mask);
        assign s42 = ({ELEN{vrf_w0_wen[4]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[4]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[4]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[4]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[4]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[4]}} & vrf_w5_data);
    end
    else begin:gen_v4_w5
        assign s41 = ({(ELEN / 8){vrf_w0_wen[4]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[4]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[4]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[4]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[4]}} & vrf_w4_mask);
        assign s42 = ({ELEN{vrf_w0_wen[4]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[4]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[4]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[4]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[4]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v5_w6
        assign s43 = ({(ELEN / 8){vrf_w0_wen[5]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[5]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[5]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[5]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[5]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[5]}} & vrf_w5_mask);
        assign s44 = ({ELEN{vrf_w0_wen[5]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[5]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[5]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[5]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[5]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[5]}} & vrf_w5_data);
    end
    else begin:gen_v5_w5
        assign s43 = ({(ELEN / 8){vrf_w0_wen[5]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[5]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[5]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[5]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[5]}} & vrf_w4_mask);
        assign s44 = ({ELEN{vrf_w0_wen[5]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[5]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[5]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[5]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[5]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v6_w6
        assign s45 = ({(ELEN / 8){vrf_w0_wen[6]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[6]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[6]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[6]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[6]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[6]}} & vrf_w5_mask);
        assign s46 = ({ELEN{vrf_w0_wen[6]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[6]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[6]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[6]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[6]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[6]}} & vrf_w5_data);
    end
    else begin:gen_v6_w5
        assign s45 = ({(ELEN / 8){vrf_w0_wen[6]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[6]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[6]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[6]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[6]}} & vrf_w4_mask);
        assign s46 = ({ELEN{vrf_w0_wen[6]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[6]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[6]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[6]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[6]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v7_w6
        assign s47 = ({(ELEN / 8){vrf_w0_wen[7]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[7]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[7]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[7]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[7]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[7]}} & vrf_w5_mask);
        assign s48 = ({ELEN{vrf_w0_wen[7]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[7]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[7]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[7]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[7]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[7]}} & vrf_w5_data);
    end
    else begin:gen_v7_w5
        assign s47 = ({(ELEN / 8){vrf_w0_wen[7]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[7]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[7]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[7]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[7]}} & vrf_w4_mask);
        assign s48 = ({ELEN{vrf_w0_wen[7]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[7]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[7]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[7]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[7]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v8_w6
        assign s49 = ({(ELEN / 8){vrf_w0_wen[8]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[8]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[8]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[8]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[8]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[8]}} & vrf_w5_mask);
        assign s50 = ({ELEN{vrf_w0_wen[8]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[8]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[8]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[8]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[8]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[8]}} & vrf_w5_data);
    end
    else begin:gen_v8_w5
        assign s49 = ({(ELEN / 8){vrf_w0_wen[8]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[8]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[8]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[8]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[8]}} & vrf_w4_mask);
        assign s50 = ({ELEN{vrf_w0_wen[8]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[8]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[8]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[8]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[8]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v9_w6
        assign s51 = ({(ELEN / 8){vrf_w0_wen[9]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[9]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[9]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[9]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[9]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[9]}} & vrf_w5_mask);
        assign s52 = ({ELEN{vrf_w0_wen[9]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[9]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[9]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[9]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[9]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[9]}} & vrf_w5_data);
    end
    else begin:gen_v9_w5
        assign s51 = ({(ELEN / 8){vrf_w0_wen[9]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[9]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[9]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[9]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[9]}} & vrf_w4_mask);
        assign s52 = ({ELEN{vrf_w0_wen[9]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[9]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[9]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[9]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[9]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v10_w6
        assign s53 = ({(ELEN / 8){vrf_w0_wen[10]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[10]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[10]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[10]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[10]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[10]}} & vrf_w5_mask);
        assign s54 = ({ELEN{vrf_w0_wen[10]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[10]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[10]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[10]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[10]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[10]}} & vrf_w5_data);
    end
    else begin:gen_v10_w5
        assign s53 = ({(ELEN / 8){vrf_w0_wen[10]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[10]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[10]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[10]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[10]}} & vrf_w4_mask);
        assign s54 = ({ELEN{vrf_w0_wen[10]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[10]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[10]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[10]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[10]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v11_w6
        assign s55 = ({(ELEN / 8){vrf_w0_wen[11]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[11]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[11]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[11]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[11]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[11]}} & vrf_w5_mask);
        assign s56 = ({ELEN{vrf_w0_wen[11]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[11]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[11]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[11]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[11]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[11]}} & vrf_w5_data);
    end
    else begin:gen_v11_w5
        assign s55 = ({(ELEN / 8){vrf_w0_wen[11]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[11]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[11]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[11]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[11]}} & vrf_w4_mask);
        assign s56 = ({ELEN{vrf_w0_wen[11]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[11]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[11]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[11]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[11]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v12_w6
        assign s57 = ({(ELEN / 8){vrf_w0_wen[12]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[12]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[12]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[12]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[12]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[12]}} & vrf_w5_mask);
        assign s58 = ({ELEN{vrf_w0_wen[12]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[12]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[12]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[12]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[12]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[12]}} & vrf_w5_data);
    end
    else begin:gen_v12_w5
        assign s57 = ({(ELEN / 8){vrf_w0_wen[12]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[12]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[12]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[12]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[12]}} & vrf_w4_mask);
        assign s58 = ({ELEN{vrf_w0_wen[12]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[12]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[12]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[12]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[12]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v13_w6
        assign s59 = ({(ELEN / 8){vrf_w0_wen[13]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[13]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[13]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[13]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[13]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[13]}} & vrf_w5_mask);
        assign s60 = ({ELEN{vrf_w0_wen[13]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[13]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[13]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[13]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[13]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[13]}} & vrf_w5_data);
    end
    else begin:gen_v13_w5
        assign s59 = ({(ELEN / 8){vrf_w0_wen[13]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[13]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[13]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[13]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[13]}} & vrf_w4_mask);
        assign s60 = ({ELEN{vrf_w0_wen[13]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[13]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[13]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[13]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[13]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v14_w6
        assign s61 = ({(ELEN / 8){vrf_w0_wen[14]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[14]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[14]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[14]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[14]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[14]}} & vrf_w5_mask);
        assign s62 = ({ELEN{vrf_w0_wen[14]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[14]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[14]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[14]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[14]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[14]}} & vrf_w5_data);
    end
    else begin:gen_v14_w5
        assign s61 = ({(ELEN / 8){vrf_w0_wen[14]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[14]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[14]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[14]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[14]}} & vrf_w4_mask);
        assign s62 = ({ELEN{vrf_w0_wen[14]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[14]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[14]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[14]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[14]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v15_w6
        assign s63 = ({(ELEN / 8){vrf_w0_wen[15]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[15]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[15]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[15]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[15]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[15]}} & vrf_w5_mask);
        assign s64 = ({ELEN{vrf_w0_wen[15]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[15]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[15]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[15]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[15]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[15]}} & vrf_w5_data);
    end
    else begin:gen_v15_w5
        assign s63 = ({(ELEN / 8){vrf_w0_wen[15]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[15]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[15]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[15]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[15]}} & vrf_w4_mask);
        assign s64 = ({ELEN{vrf_w0_wen[15]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[15]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[15]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[15]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[15]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v16_w6
        assign s65 = ({(ELEN / 8){vrf_w0_wen[16]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[16]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[16]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[16]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[16]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[16]}} & vrf_w5_mask);
        assign s66 = ({ELEN{vrf_w0_wen[16]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[16]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[16]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[16]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[16]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[16]}} & vrf_w5_data);
    end
    else begin:gen_v16_w5
        assign s65 = ({(ELEN / 8){vrf_w0_wen[16]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[16]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[16]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[16]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[16]}} & vrf_w4_mask);
        assign s66 = ({ELEN{vrf_w0_wen[16]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[16]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[16]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[16]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[16]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v17_w6
        assign s67 = ({(ELEN / 8){vrf_w0_wen[17]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[17]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[17]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[17]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[17]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[17]}} & vrf_w5_mask);
        assign s68 = ({ELEN{vrf_w0_wen[17]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[17]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[17]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[17]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[17]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[17]}} & vrf_w5_data);
    end
    else begin:gen_v17_w5
        assign s67 = ({(ELEN / 8){vrf_w0_wen[17]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[17]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[17]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[17]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[17]}} & vrf_w4_mask);
        assign s68 = ({ELEN{vrf_w0_wen[17]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[17]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[17]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[17]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[17]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v18_w6
        assign s69 = ({(ELEN / 8){vrf_w0_wen[18]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[18]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[18]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[18]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[18]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[18]}} & vrf_w5_mask);
        assign s70 = ({ELEN{vrf_w0_wen[18]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[18]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[18]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[18]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[18]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[18]}} & vrf_w5_data);
    end
    else begin:gen_v18_w5
        assign s69 = ({(ELEN / 8){vrf_w0_wen[18]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[18]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[18]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[18]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[18]}} & vrf_w4_mask);
        assign s70 = ({ELEN{vrf_w0_wen[18]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[18]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[18]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[18]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[18]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v19_w6
        assign s71 = ({(ELEN / 8){vrf_w0_wen[19]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[19]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[19]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[19]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[19]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[19]}} & vrf_w5_mask);
        assign s72 = ({ELEN{vrf_w0_wen[19]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[19]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[19]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[19]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[19]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[19]}} & vrf_w5_data);
    end
    else begin:gen_v19_w5
        assign s71 = ({(ELEN / 8){vrf_w0_wen[19]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[19]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[19]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[19]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[19]}} & vrf_w4_mask);
        assign s72 = ({ELEN{vrf_w0_wen[19]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[19]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[19]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[19]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[19]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v20_w6
        assign s73 = ({(ELEN / 8){vrf_w0_wen[20]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[20]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[20]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[20]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[20]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[20]}} & vrf_w5_mask);
        assign s74 = ({ELEN{vrf_w0_wen[20]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[20]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[20]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[20]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[20]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[20]}} & vrf_w5_data);
    end
    else begin:gen_v20_w5
        assign s73 = ({(ELEN / 8){vrf_w0_wen[20]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[20]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[20]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[20]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[20]}} & vrf_w4_mask);
        assign s74 = ({ELEN{vrf_w0_wen[20]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[20]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[20]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[20]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[20]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v21_w6
        assign s75 = ({(ELEN / 8){vrf_w0_wen[21]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[21]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[21]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[21]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[21]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[21]}} & vrf_w5_mask);
        assign s76 = ({ELEN{vrf_w0_wen[21]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[21]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[21]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[21]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[21]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[21]}} & vrf_w5_data);
    end
    else begin:gen_v21_w5
        assign s75 = ({(ELEN / 8){vrf_w0_wen[21]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[21]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[21]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[21]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[21]}} & vrf_w4_mask);
        assign s76 = ({ELEN{vrf_w0_wen[21]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[21]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[21]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[21]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[21]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v22_w6
        assign s77 = ({(ELEN / 8){vrf_w0_wen[22]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[22]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[22]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[22]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[22]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[22]}} & vrf_w5_mask);
        assign s78 = ({ELEN{vrf_w0_wen[22]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[22]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[22]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[22]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[22]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[22]}} & vrf_w5_data);
    end
    else begin:gen_v22_w5
        assign s77 = ({(ELEN / 8){vrf_w0_wen[22]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[22]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[22]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[22]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[22]}} & vrf_w4_mask);
        assign s78 = ({ELEN{vrf_w0_wen[22]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[22]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[22]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[22]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[22]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v23_w6
        assign s79 = ({(ELEN / 8){vrf_w0_wen[23]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[23]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[23]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[23]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[23]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[23]}} & vrf_w5_mask);
        assign s80 = ({ELEN{vrf_w0_wen[23]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[23]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[23]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[23]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[23]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[23]}} & vrf_w5_data);
    end
    else begin:gen_v23_w5
        assign s79 = ({(ELEN / 8){vrf_w0_wen[23]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[23]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[23]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[23]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[23]}} & vrf_w4_mask);
        assign s80 = ({ELEN{vrf_w0_wen[23]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[23]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[23]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[23]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[23]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v24_w6
        assign s81 = ({(ELEN / 8){vrf_w0_wen[24]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[24]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[24]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[24]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[24]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[24]}} & vrf_w5_mask);
        assign s82 = ({ELEN{vrf_w0_wen[24]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[24]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[24]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[24]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[24]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[24]}} & vrf_w5_data);
    end
    else begin:gen_v24_w5
        assign s81 = ({(ELEN / 8){vrf_w0_wen[24]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[24]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[24]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[24]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[24]}} & vrf_w4_mask);
        assign s82 = ({ELEN{vrf_w0_wen[24]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[24]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[24]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[24]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[24]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v25_w6
        assign s83 = ({(ELEN / 8){vrf_w0_wen[25]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[25]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[25]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[25]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[25]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[25]}} & vrf_w5_mask);
        assign s84 = ({ELEN{vrf_w0_wen[25]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[25]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[25]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[25]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[25]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[25]}} & vrf_w5_data);
    end
    else begin:gen_v25_w5
        assign s83 = ({(ELEN / 8){vrf_w0_wen[25]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[25]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[25]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[25]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[25]}} & vrf_w4_mask);
        assign s84 = ({ELEN{vrf_w0_wen[25]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[25]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[25]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[25]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[25]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v26_w6
        assign s85 = ({(ELEN / 8){vrf_w0_wen[26]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[26]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[26]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[26]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[26]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[26]}} & vrf_w5_mask);
        assign s86 = ({ELEN{vrf_w0_wen[26]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[26]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[26]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[26]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[26]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[26]}} & vrf_w5_data);
    end
    else begin:gen_v26_w5
        assign s85 = ({(ELEN / 8){vrf_w0_wen[26]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[26]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[26]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[26]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[26]}} & vrf_w4_mask);
        assign s86 = ({ELEN{vrf_w0_wen[26]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[26]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[26]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[26]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[26]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v27_w6
        assign s87 = ({(ELEN / 8){vrf_w0_wen[27]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[27]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[27]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[27]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[27]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[27]}} & vrf_w5_mask);
        assign s88 = ({ELEN{vrf_w0_wen[27]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[27]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[27]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[27]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[27]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[27]}} & vrf_w5_data);
    end
    else begin:gen_v27_w5
        assign s87 = ({(ELEN / 8){vrf_w0_wen[27]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[27]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[27]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[27]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[27]}} & vrf_w4_mask);
        assign s88 = ({ELEN{vrf_w0_wen[27]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[27]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[27]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[27]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[27]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v28_w6
        assign s89 = ({(ELEN / 8){vrf_w0_wen[28]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[28]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[28]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[28]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[28]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[28]}} & vrf_w5_mask);
        assign s90 = ({ELEN{vrf_w0_wen[28]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[28]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[28]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[28]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[28]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[28]}} & vrf_w5_data);
    end
    else begin:gen_v28_w5
        assign s89 = ({(ELEN / 8){vrf_w0_wen[28]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[28]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[28]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[28]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[28]}} & vrf_w4_mask);
        assign s90 = ({ELEN{vrf_w0_wen[28]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[28]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[28]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[28]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[28]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v29_w6
        assign s91 = ({(ELEN / 8){vrf_w0_wen[29]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[29]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[29]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[29]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[29]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[29]}} & vrf_w5_mask);
        assign s92 = ({ELEN{vrf_w0_wen[29]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[29]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[29]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[29]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[29]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[29]}} & vrf_w5_data);
    end
    else begin:gen_v29_w5
        assign s91 = ({(ELEN / 8){vrf_w0_wen[29]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[29]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[29]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[29]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[29]}} & vrf_w4_mask);
        assign s92 = ({ELEN{vrf_w0_wen[29]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[29]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[29]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[29]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[29]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v30_w6
        assign s93 = ({(ELEN / 8){vrf_w0_wen[30]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[30]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[30]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[30]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[30]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[30]}} & vrf_w5_mask);
        assign s94 = ({ELEN{vrf_w0_wen[30]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[30]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[30]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[30]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[30]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[30]}} & vrf_w5_data);
    end
    else begin:gen_v30_w5
        assign s93 = ({(ELEN / 8){vrf_w0_wen[30]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[30]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[30]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[30]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[30]}} & vrf_w4_mask);
        assign s94 = ({ELEN{vrf_w0_wen[30]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[30]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[30]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[30]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[30]}} & vrf_w4_data);
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_v31_w6
        assign s95 = ({(ELEN / 8){vrf_w0_wen[31]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[31]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[31]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[31]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[31]}} & vrf_w4_mask) | ({(ELEN / 8){vrf_w5_wen[31]}} & vrf_w5_mask);
        assign s96 = ({ELEN{vrf_w0_wen[31]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[31]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[31]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[31]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[31]}} & vrf_w4_data) | ({ELEN{vrf_w5_wen[31]}} & vrf_w5_data);
    end
    else begin:gen_v31_w5
        assign s95 = ({(ELEN / 8){vrf_w0_wen[31]}} & vrf_w0_mask) | ({(ELEN / 8){vrf_w1_wen[31]}} & vrf_w1_mask) | ({(ELEN / 8){vrf_w2_wen[31]}} & vrf_w2_mask) | ({(ELEN / 8){vrf_w3_wen[31]}} & vrf_w3_mask) | ({(ELEN / 8){vrf_w4_wen[31]}} & vrf_w4_mask);
        assign s96 = ({ELEN{vrf_w0_wen[31]}} & vrf_w0_data) | ({ELEN{vrf_w1_wen[31]}} & vrf_w1_data) | ({ELEN{vrf_w2_wen[31]}} & vrf_w2_data) | ({ELEN{vrf_w3_wen[31]}} & vrf_w3_data) | ({ELEN{vrf_w4_wen[31]}} & vrf_w4_data);
    end
endgenerate
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v0 (
    .clk(vpu_clk),
    .bwe(s33),
    .d(s34),
    .q(s0)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v1 (
    .clk(vpu_clk),
    .bwe(s35),
    .d(s36),
    .q(s1)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v2 (
    .clk(vpu_clk),
    .bwe(s37),
    .d(s38),
    .q(s2)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v3 (
    .clk(vpu_clk),
    .bwe(s39),
    .d(s40),
    .q(s3)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v4 (
    .clk(vpu_clk),
    .bwe(s41),
    .d(s42),
    .q(s4)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v5 (
    .clk(vpu_clk),
    .bwe(s43),
    .d(s44),
    .q(s5)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v6 (
    .clk(vpu_clk),
    .bwe(s45),
    .d(s46),
    .q(s6)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v7 (
    .clk(vpu_clk),
    .bwe(s47),
    .d(s48),
    .q(s7)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v8 (
    .clk(vpu_clk),
    .bwe(s49),
    .d(s50),
    .q(s8)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v9 (
    .clk(vpu_clk),
    .bwe(s51),
    .d(s52),
    .q(s9)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v10 (
    .clk(vpu_clk),
    .bwe(s53),
    .d(s54),
    .q(s10)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v11 (
    .clk(vpu_clk),
    .bwe(s55),
    .d(s56),
    .q(s11)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v12 (
    .clk(vpu_clk),
    .bwe(s57),
    .d(s58),
    .q(s12)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v13 (
    .clk(vpu_clk),
    .bwe(s59),
    .d(s60),
    .q(s13)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v14 (
    .clk(vpu_clk),
    .bwe(s61),
    .d(s62),
    .q(s14)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v15 (
    .clk(vpu_clk),
    .bwe(s63),
    .d(s64),
    .q(s15)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v16 (
    .clk(vpu_clk),
    .bwe(s65),
    .d(s66),
    .q(s16)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v17 (
    .clk(vpu_clk),
    .bwe(s67),
    .d(s68),
    .q(s17)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v18 (
    .clk(vpu_clk),
    .bwe(s69),
    .d(s70),
    .q(s18)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v19 (
    .clk(vpu_clk),
    .bwe(s71),
    .d(s72),
    .q(s19)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v20 (
    .clk(vpu_clk),
    .bwe(s73),
    .d(s74),
    .q(s20)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v21 (
    .clk(vpu_clk),
    .bwe(s75),
    .d(s76),
    .q(s21)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v22 (
    .clk(vpu_clk),
    .bwe(s77),
    .d(s78),
    .q(s22)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v23 (
    .clk(vpu_clk),
    .bwe(s79),
    .d(s80),
    .q(s23)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v24 (
    .clk(vpu_clk),
    .bwe(s81),
    .d(s82),
    .q(s24)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v25 (
    .clk(vpu_clk),
    .bwe(s83),
    .d(s84),
    .q(s25)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v26 (
    .clk(vpu_clk),
    .bwe(s85),
    .d(s86),
    .q(s26)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v27 (
    .clk(vpu_clk),
    .bwe(s87),
    .d(s88),
    .q(s27)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v28 (
    .clk(vpu_clk),
    .bwe(s89),
    .d(s90),
    .q(s28)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v29 (
    .clk(vpu_clk),
    .bwe(s91),
    .d(s92),
    .q(s29)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v30 (
    .clk(vpu_clk),
    .bwe(s93),
    .d(s94),
    .q(s30)
);
kv_dff_bwe #(
    .BYTES(ELEN / 8)
) u_v31 (
    .clk(vpu_clk),
    .bwe(s95),
    .d(s96),
    .q(s31)
);
generate
    if (VRF_MUX == 2) begin:gen_mux2
        wire [ELEN - 1:0] s97 = vrf_r0_addr[0] ? s1 : s0;
        wire [ELEN - 1:0] s98 = vrf_r0_addr[0] ? s3 : s2;
        wire [ELEN - 1:0] s99 = vrf_r0_addr[0] ? s5 : s4;
        wire [ELEN - 1:0] s100 = vrf_r0_addr[0] ? s7 : s6;
        wire [ELEN - 1:0] s101 = vrf_r0_addr[0] ? s9 : s8;
        wire [ELEN - 1:0] s102 = vrf_r0_addr[0] ? s11 : s10;
        wire [ELEN - 1:0] s103 = vrf_r0_addr[0] ? s13 : s12;
        wire [ELEN - 1:0] s104 = vrf_r0_addr[0] ? s15 : s14;
        wire [ELEN - 1:0] s105 = vrf_r0_addr[0] ? s17 : s16;
        wire [ELEN - 1:0] s106 = vrf_r0_addr[0] ? s19 : s18;
        wire [ELEN - 1:0] s107 = vrf_r0_addr[0] ? s21 : s20;
        wire [ELEN - 1:0] s108 = vrf_r0_addr[0] ? s23 : s22;
        wire [ELEN - 1:0] s109 = vrf_r0_addr[0] ? s25 : s24;
        wire [ELEN - 1:0] s110 = vrf_r0_addr[0] ? s27 : s26;
        wire [ELEN - 1:0] s111 = vrf_r0_addr[0] ? s29 : s28;
        wire [ELEN - 1:0] s112 = vrf_r0_addr[0] ? s31 : s30;
        wire [ELEN - 1:0] s113 = vrf_r0_addr[1] ? s98 : s97;
        wire [ELEN - 1:0] s114 = vrf_r0_addr[1] ? s100 : s99;
        wire [ELEN - 1:0] s115 = vrf_r0_addr[1] ? s102 : s101;
        wire [ELEN - 1:0] s116 = vrf_r0_addr[1] ? s104 : s103;
        wire [ELEN - 1:0] s117 = vrf_r0_addr[1] ? s106 : s105;
        wire [ELEN - 1:0] s118 = vrf_r0_addr[1] ? s108 : s107;
        wire [ELEN - 1:0] s119 = vrf_r0_addr[1] ? s110 : s109;
        wire [ELEN - 1:0] s120 = vrf_r0_addr[1] ? s112 : s111;
        wire [ELEN - 1:0] s121 = vrf_r0_addr[2] ? s114 : s113;
        wire [ELEN - 1:0] s122 = vrf_r0_addr[2] ? s116 : s115;
        wire [ELEN - 1:0] s123 = vrf_r0_addr[2] ? s118 : s117;
        wire [ELEN - 1:0] s124 = vrf_r0_addr[2] ? s120 : s119;
        wire [ELEN - 1:0] s125 = vrf_r0_addr[3] ? s122 : s121;
        wire [ELEN - 1:0] s126 = vrf_r0_addr[3] ? s124 : s123;
        assign vrf_r0_data = vrf_r0_addr[4] ? s126 : s125;
        wire [ELEN - 1:0] s127 = vrf_r1_addr[0] ? s1 : s0;
        wire [ELEN - 1:0] s128 = vrf_r1_addr[0] ? s3 : s2;
        wire [ELEN - 1:0] s129 = vrf_r1_addr[0] ? s5 : s4;
        wire [ELEN - 1:0] s130 = vrf_r1_addr[0] ? s7 : s6;
        wire [ELEN - 1:0] s131 = vrf_r1_addr[0] ? s9 : s8;
        wire [ELEN - 1:0] s132 = vrf_r1_addr[0] ? s11 : s10;
        wire [ELEN - 1:0] s133 = vrf_r1_addr[0] ? s13 : s12;
        wire [ELEN - 1:0] s134 = vrf_r1_addr[0] ? s15 : s14;
        wire [ELEN - 1:0] s135 = vrf_r1_addr[0] ? s17 : s16;
        wire [ELEN - 1:0] s136 = vrf_r1_addr[0] ? s19 : s18;
        wire [ELEN - 1:0] s137 = vrf_r1_addr[0] ? s21 : s20;
        wire [ELEN - 1:0] s138 = vrf_r1_addr[0] ? s23 : s22;
        wire [ELEN - 1:0] s139 = vrf_r1_addr[0] ? s25 : s24;
        wire [ELEN - 1:0] s140 = vrf_r1_addr[0] ? s27 : s26;
        wire [ELEN - 1:0] s141 = vrf_r1_addr[0] ? s29 : s28;
        wire [ELEN - 1:0] s142 = vrf_r1_addr[0] ? s31 : s30;
        wire [ELEN - 1:0] s143 = vrf_r1_addr[1] ? s128 : s127;
        wire [ELEN - 1:0] s144 = vrf_r1_addr[1] ? s130 : s129;
        wire [ELEN - 1:0] s145 = vrf_r1_addr[1] ? s132 : s131;
        wire [ELEN - 1:0] s146 = vrf_r1_addr[1] ? s134 : s133;
        wire [ELEN - 1:0] s147 = vrf_r1_addr[1] ? s136 : s135;
        wire [ELEN - 1:0] s148 = vrf_r1_addr[1] ? s138 : s137;
        wire [ELEN - 1:0] s149 = vrf_r1_addr[1] ? s140 : s139;
        wire [ELEN - 1:0] s150 = vrf_r1_addr[1] ? s142 : s141;
        wire [ELEN - 1:0] s151 = vrf_r1_addr[2] ? s144 : s143;
        wire [ELEN - 1:0] s152 = vrf_r1_addr[2] ? s146 : s145;
        wire [ELEN - 1:0] s153 = vrf_r1_addr[2] ? s148 : s147;
        wire [ELEN - 1:0] s154 = vrf_r1_addr[2] ? s150 : s149;
        wire [ELEN - 1:0] s155 = vrf_r1_addr[3] ? s152 : s151;
        wire [ELEN - 1:0] s156 = vrf_r1_addr[3] ? s154 : s153;
        assign vrf_r1_data = vrf_r1_addr[4] ? s156 : s155;
        wire [ELEN - 1:0] s157 = vrf_r2_addr[0] ? s1 : s0;
        wire [ELEN - 1:0] s158 = vrf_r2_addr[0] ? s3 : s2;
        wire [ELEN - 1:0] s159 = vrf_r2_addr[0] ? s5 : s4;
        wire [ELEN - 1:0] s160 = vrf_r2_addr[0] ? s7 : s6;
        wire [ELEN - 1:0] s161 = vrf_r2_addr[0] ? s9 : s8;
        wire [ELEN - 1:0] s162 = vrf_r2_addr[0] ? s11 : s10;
        wire [ELEN - 1:0] s163 = vrf_r2_addr[0] ? s13 : s12;
        wire [ELEN - 1:0] s164 = vrf_r2_addr[0] ? s15 : s14;
        wire [ELEN - 1:0] s165 = vrf_r2_addr[0] ? s17 : s16;
        wire [ELEN - 1:0] s166 = vrf_r2_addr[0] ? s19 : s18;
        wire [ELEN - 1:0] s167 = vrf_r2_addr[0] ? s21 : s20;
        wire [ELEN - 1:0] s168 = vrf_r2_addr[0] ? s23 : s22;
        wire [ELEN - 1:0] s169 = vrf_r2_addr[0] ? s25 : s24;
        wire [ELEN - 1:0] s170 = vrf_r2_addr[0] ? s27 : s26;
        wire [ELEN - 1:0] s171 = vrf_r2_addr[0] ? s29 : s28;
        wire [ELEN - 1:0] s172 = vrf_r2_addr[0] ? s31 : s30;
        wire [ELEN - 1:0] s173 = vrf_r2_addr[1] ? s158 : s157;
        wire [ELEN - 1:0] s174 = vrf_r2_addr[1] ? s160 : s159;
        wire [ELEN - 1:0] s175 = vrf_r2_addr[1] ? s162 : s161;
        wire [ELEN - 1:0] s176 = vrf_r2_addr[1] ? s164 : s163;
        wire [ELEN - 1:0] s177 = vrf_r2_addr[1] ? s166 : s165;
        wire [ELEN - 1:0] s178 = vrf_r2_addr[1] ? s168 : s167;
        wire [ELEN - 1:0] s179 = vrf_r2_addr[1] ? s170 : s169;
        wire [ELEN - 1:0] s180 = vrf_r2_addr[1] ? s172 : s171;
        wire [ELEN - 1:0] s181 = vrf_r2_addr[2] ? s174 : s173;
        wire [ELEN - 1:0] s182 = vrf_r2_addr[2] ? s176 : s175;
        wire [ELEN - 1:0] s183 = vrf_r2_addr[2] ? s178 : s177;
        wire [ELEN - 1:0] s184 = vrf_r2_addr[2] ? s180 : s179;
        wire [ELEN - 1:0] s185 = vrf_r2_addr[3] ? s182 : s181;
        wire [ELEN - 1:0] s186 = vrf_r2_addr[3] ? s184 : s183;
        assign vrf_r2_data = vrf_r2_addr[4] ? s186 : s185;
        wire [ELEN - 1:0] s187 = vrf_r3_addr[0] ? s1 : s0;
        wire [ELEN - 1:0] s188 = vrf_r3_addr[0] ? s3 : s2;
        wire [ELEN - 1:0] s189 = vrf_r3_addr[0] ? s5 : s4;
        wire [ELEN - 1:0] s190 = vrf_r3_addr[0] ? s7 : s6;
        wire [ELEN - 1:0] s191 = vrf_r3_addr[0] ? s9 : s8;
        wire [ELEN - 1:0] s192 = vrf_r3_addr[0] ? s11 : s10;
        wire [ELEN - 1:0] s193 = vrf_r3_addr[0] ? s13 : s12;
        wire [ELEN - 1:0] s194 = vrf_r3_addr[0] ? s15 : s14;
        wire [ELEN - 1:0] s195 = vrf_r3_addr[0] ? s17 : s16;
        wire [ELEN - 1:0] s196 = vrf_r3_addr[0] ? s19 : s18;
        wire [ELEN - 1:0] s197 = vrf_r3_addr[0] ? s21 : s20;
        wire [ELEN - 1:0] s198 = vrf_r3_addr[0] ? s23 : s22;
        wire [ELEN - 1:0] s199 = vrf_r3_addr[0] ? s25 : s24;
        wire [ELEN - 1:0] s200 = vrf_r3_addr[0] ? s27 : s26;
        wire [ELEN - 1:0] s201 = vrf_r3_addr[0] ? s29 : s28;
        wire [ELEN - 1:0] s202 = vrf_r3_addr[0] ? s31 : s30;
        wire [ELEN - 1:0] s203 = vrf_r3_addr[1] ? s188 : s187;
        wire [ELEN - 1:0] s204 = vrf_r3_addr[1] ? s190 : s189;
        wire [ELEN - 1:0] s205 = vrf_r3_addr[1] ? s192 : s191;
        wire [ELEN - 1:0] s206 = vrf_r3_addr[1] ? s194 : s193;
        wire [ELEN - 1:0] s207 = vrf_r3_addr[1] ? s196 : s195;
        wire [ELEN - 1:0] s208 = vrf_r3_addr[1] ? s198 : s197;
        wire [ELEN - 1:0] s209 = vrf_r3_addr[1] ? s200 : s199;
        wire [ELEN - 1:0] s210 = vrf_r3_addr[1] ? s202 : s201;
        wire [ELEN - 1:0] s211 = vrf_r3_addr[2] ? s204 : s203;
        wire [ELEN - 1:0] s212 = vrf_r3_addr[2] ? s206 : s205;
        wire [ELEN - 1:0] s213 = vrf_r3_addr[2] ? s208 : s207;
        wire [ELEN - 1:0] s214 = vrf_r3_addr[2] ? s210 : s209;
        wire [ELEN - 1:0] s215 = vrf_r3_addr[3] ? s212 : s211;
        wire [ELEN - 1:0] s216 = vrf_r3_addr[3] ? s214 : s213;
        assign vrf_r3_data = vrf_r3_addr[4] ? s216 : s215;
        wire [ELEN - 1:0] s217 = vrf_r4_addr[0] ? s1 : s0;
        wire [ELEN - 1:0] s218 = vrf_r4_addr[0] ? s3 : s2;
        wire [ELEN - 1:0] s219 = vrf_r4_addr[0] ? s5 : s4;
        wire [ELEN - 1:0] s220 = vrf_r4_addr[0] ? s7 : s6;
        wire [ELEN - 1:0] s221 = vrf_r4_addr[0] ? s9 : s8;
        wire [ELEN - 1:0] s222 = vrf_r4_addr[0] ? s11 : s10;
        wire [ELEN - 1:0] s223 = vrf_r4_addr[0] ? s13 : s12;
        wire [ELEN - 1:0] s224 = vrf_r4_addr[0] ? s15 : s14;
        wire [ELEN - 1:0] s225 = vrf_r4_addr[0] ? s17 : s16;
        wire [ELEN - 1:0] s226 = vrf_r4_addr[0] ? s19 : s18;
        wire [ELEN - 1:0] s227 = vrf_r4_addr[0] ? s21 : s20;
        wire [ELEN - 1:0] s228 = vrf_r4_addr[0] ? s23 : s22;
        wire [ELEN - 1:0] s229 = vrf_r4_addr[0] ? s25 : s24;
        wire [ELEN - 1:0] s230 = vrf_r4_addr[0] ? s27 : s26;
        wire [ELEN - 1:0] s231 = vrf_r4_addr[0] ? s29 : s28;
        wire [ELEN - 1:0] s232 = vrf_r4_addr[0] ? s31 : s30;
        wire [ELEN - 1:0] s233 = vrf_r4_addr[1] ? s218 : s217;
        wire [ELEN - 1:0] s234 = vrf_r4_addr[1] ? s220 : s219;
        wire [ELEN - 1:0] s235 = vrf_r4_addr[1] ? s222 : s221;
        wire [ELEN - 1:0] s236 = vrf_r4_addr[1] ? s224 : s223;
        wire [ELEN - 1:0] s237 = vrf_r4_addr[1] ? s226 : s225;
        wire [ELEN - 1:0] s238 = vrf_r4_addr[1] ? s228 : s227;
        wire [ELEN - 1:0] s239 = vrf_r4_addr[1] ? s230 : s229;
        wire [ELEN - 1:0] s240 = vrf_r4_addr[1] ? s232 : s231;
        wire [ELEN - 1:0] s241 = vrf_r4_addr[2] ? s234 : s233;
        wire [ELEN - 1:0] s242 = vrf_r4_addr[2] ? s236 : s235;
        wire [ELEN - 1:0] s243 = vrf_r4_addr[2] ? s238 : s237;
        wire [ELEN - 1:0] s244 = vrf_r4_addr[2] ? s240 : s239;
        wire [ELEN - 1:0] s245 = vrf_r4_addr[3] ? s242 : s241;
        wire [ELEN - 1:0] s246 = vrf_r4_addr[3] ? s244 : s243;
        assign vrf_r4_data = vrf_r4_addr[4] ? s246 : s245;
        wire [ELEN - 1:0] s247 = vrf_r5_addr[0] ? s1 : s0;
        wire [ELEN - 1:0] s248 = vrf_r5_addr[0] ? s3 : s2;
        wire [ELEN - 1:0] s249 = vrf_r5_addr[0] ? s5 : s4;
        wire [ELEN - 1:0] s250 = vrf_r5_addr[0] ? s7 : s6;
        wire [ELEN - 1:0] s251 = vrf_r5_addr[0] ? s9 : s8;
        wire [ELEN - 1:0] s252 = vrf_r5_addr[0] ? s11 : s10;
        wire [ELEN - 1:0] s253 = vrf_r5_addr[0] ? s13 : s12;
        wire [ELEN - 1:0] s254 = vrf_r5_addr[0] ? s15 : s14;
        wire [ELEN - 1:0] s255 = vrf_r5_addr[0] ? s17 : s16;
        wire [ELEN - 1:0] s256 = vrf_r5_addr[0] ? s19 : s18;
        wire [ELEN - 1:0] s257 = vrf_r5_addr[0] ? s21 : s20;
        wire [ELEN - 1:0] s258 = vrf_r5_addr[0] ? s23 : s22;
        wire [ELEN - 1:0] s259 = vrf_r5_addr[0] ? s25 : s24;
        wire [ELEN - 1:0] s260 = vrf_r5_addr[0] ? s27 : s26;
        wire [ELEN - 1:0] s261 = vrf_r5_addr[0] ? s29 : s28;
        wire [ELEN - 1:0] s262 = vrf_r5_addr[0] ? s31 : s30;
        wire [ELEN - 1:0] s263 = vrf_r5_addr[1] ? s248 : s247;
        wire [ELEN - 1:0] s264 = vrf_r5_addr[1] ? s250 : s249;
        wire [ELEN - 1:0] s265 = vrf_r5_addr[1] ? s252 : s251;
        wire [ELEN - 1:0] s266 = vrf_r5_addr[1] ? s254 : s253;
        wire [ELEN - 1:0] s267 = vrf_r5_addr[1] ? s256 : s255;
        wire [ELEN - 1:0] s268 = vrf_r5_addr[1] ? s258 : s257;
        wire [ELEN - 1:0] s269 = vrf_r5_addr[1] ? s260 : s259;
        wire [ELEN - 1:0] s270 = vrf_r5_addr[1] ? s262 : s261;
        wire [ELEN - 1:0] s271 = vrf_r5_addr[2] ? s264 : s263;
        wire [ELEN - 1:0] s272 = vrf_r5_addr[2] ? s266 : s265;
        wire [ELEN - 1:0] s273 = vrf_r5_addr[2] ? s268 : s267;
        wire [ELEN - 1:0] s274 = vrf_r5_addr[2] ? s270 : s269;
        wire [ELEN - 1:0] s275 = vrf_r5_addr[3] ? s272 : s271;
        wire [ELEN - 1:0] s276 = vrf_r5_addr[3] ? s274 : s273;
        assign vrf_r5_data = vrf_r5_addr[4] ? s276 : s275;
        wire [ELEN - 1:0] s277 = vrf_r6_addr[0] ? s1 : s0;
        wire [ELEN - 1:0] s278 = vrf_r6_addr[0] ? s3 : s2;
        wire [ELEN - 1:0] s279 = vrf_r6_addr[0] ? s5 : s4;
        wire [ELEN - 1:0] s280 = vrf_r6_addr[0] ? s7 : s6;
        wire [ELEN - 1:0] s281 = vrf_r6_addr[0] ? s9 : s8;
        wire [ELEN - 1:0] s282 = vrf_r6_addr[0] ? s11 : s10;
        wire [ELEN - 1:0] s283 = vrf_r6_addr[0] ? s13 : s12;
        wire [ELEN - 1:0] s284 = vrf_r6_addr[0] ? s15 : s14;
        wire [ELEN - 1:0] s285 = vrf_r6_addr[0] ? s17 : s16;
        wire [ELEN - 1:0] s286 = vrf_r6_addr[0] ? s19 : s18;
        wire [ELEN - 1:0] s287 = vrf_r6_addr[0] ? s21 : s20;
        wire [ELEN - 1:0] s288 = vrf_r6_addr[0] ? s23 : s22;
        wire [ELEN - 1:0] s289 = vrf_r6_addr[0] ? s25 : s24;
        wire [ELEN - 1:0] s290 = vrf_r6_addr[0] ? s27 : s26;
        wire [ELEN - 1:0] s291 = vrf_r6_addr[0] ? s29 : s28;
        wire [ELEN - 1:0] s292 = vrf_r6_addr[0] ? s31 : s30;
        wire [ELEN - 1:0] s293 = vrf_r6_addr[1] ? s278 : s277;
        wire [ELEN - 1:0] s294 = vrf_r6_addr[1] ? s280 : s279;
        wire [ELEN - 1:0] s295 = vrf_r6_addr[1] ? s282 : s281;
        wire [ELEN - 1:0] s296 = vrf_r6_addr[1] ? s284 : s283;
        wire [ELEN - 1:0] s297 = vrf_r6_addr[1] ? s286 : s285;
        wire [ELEN - 1:0] s298 = vrf_r6_addr[1] ? s288 : s287;
        wire [ELEN - 1:0] s299 = vrf_r6_addr[1] ? s290 : s289;
        wire [ELEN - 1:0] s300 = vrf_r6_addr[1] ? s292 : s291;
        wire [ELEN - 1:0] s301 = vrf_r6_addr[2] ? s294 : s293;
        wire [ELEN - 1:0] s302 = vrf_r6_addr[2] ? s296 : s295;
        wire [ELEN - 1:0] s303 = vrf_r6_addr[2] ? s298 : s297;
        wire [ELEN - 1:0] s304 = vrf_r6_addr[2] ? s300 : s299;
        wire [ELEN - 1:0] s305 = vrf_r6_addr[3] ? s302 : s301;
        wire [ELEN - 1:0] s306 = vrf_r6_addr[3] ? s304 : s303;
        assign vrf_r6_data = vrf_r6_addr[4] ? s306 : s305;
        wire [ELEN - 1:0] s307 = vrf_r7_addr[0] ? s1 : s0;
        wire [ELEN - 1:0] s308 = vrf_r7_addr[0] ? s3 : s2;
        wire [ELEN - 1:0] s309 = vrf_r7_addr[0] ? s5 : s4;
        wire [ELEN - 1:0] s310 = vrf_r7_addr[0] ? s7 : s6;
        wire [ELEN - 1:0] s311 = vrf_r7_addr[0] ? s9 : s8;
        wire [ELEN - 1:0] s312 = vrf_r7_addr[0] ? s11 : s10;
        wire [ELEN - 1:0] s313 = vrf_r7_addr[0] ? s13 : s12;
        wire [ELEN - 1:0] s314 = vrf_r7_addr[0] ? s15 : s14;
        wire [ELEN - 1:0] s315 = vrf_r7_addr[0] ? s17 : s16;
        wire [ELEN - 1:0] s316 = vrf_r7_addr[0] ? s19 : s18;
        wire [ELEN - 1:0] s317 = vrf_r7_addr[0] ? s21 : s20;
        wire [ELEN - 1:0] s318 = vrf_r7_addr[0] ? s23 : s22;
        wire [ELEN - 1:0] s319 = vrf_r7_addr[0] ? s25 : s24;
        wire [ELEN - 1:0] s320 = vrf_r7_addr[0] ? s27 : s26;
        wire [ELEN - 1:0] s321 = vrf_r7_addr[0] ? s29 : s28;
        wire [ELEN - 1:0] s322 = vrf_r7_addr[0] ? s31 : s30;
        wire [ELEN - 1:0] s323 = vrf_r7_addr[1] ? s308 : s307;
        wire [ELEN - 1:0] s324 = vrf_r7_addr[1] ? s310 : s309;
        wire [ELEN - 1:0] s325 = vrf_r7_addr[1] ? s312 : s311;
        wire [ELEN - 1:0] s326 = vrf_r7_addr[1] ? s314 : s313;
        wire [ELEN - 1:0] s327 = vrf_r7_addr[1] ? s316 : s315;
        wire [ELEN - 1:0] s328 = vrf_r7_addr[1] ? s318 : s317;
        wire [ELEN - 1:0] s329 = vrf_r7_addr[1] ? s320 : s319;
        wire [ELEN - 1:0] s330 = vrf_r7_addr[1] ? s322 : s321;
        wire [ELEN - 1:0] s331 = vrf_r7_addr[2] ? s324 : s323;
        wire [ELEN - 1:0] s332 = vrf_r7_addr[2] ? s326 : s325;
        wire [ELEN - 1:0] s333 = vrf_r7_addr[2] ? s328 : s327;
        wire [ELEN - 1:0] s334 = vrf_r7_addr[2] ? s330 : s329;
        wire [ELEN - 1:0] s335 = vrf_r7_addr[3] ? s332 : s331;
        wire [ELEN - 1:0] s336 = vrf_r7_addr[3] ? s334 : s333;
        assign vrf_r7_data = vrf_r7_addr[4] ? s336 : s335;
        wire nds_unused_mux2_vrf_mem = |s32;
    end
    else begin:gen_mux32
        kv_mux32 #(
            .W(ELEN)
        ) u_r0_data (
            .out(vrf_r0_data),
            .sel(vrf_r0_addr),
            .in(s32)
        );
        kv_mux32 #(
            .W(ELEN)
        ) u_r1_data (
            .out(vrf_r1_data),
            .sel(vrf_r1_addr),
            .in(s32)
        );
        kv_mux32 #(
            .W(ELEN)
        ) u_r2_data (
            .out(vrf_r2_data),
            .sel(vrf_r2_addr),
            .in(s32)
        );
        kv_mux32 #(
            .W(ELEN)
        ) u_r3_data (
            .out(vrf_r3_data),
            .sel(vrf_r3_addr),
            .in(s32)
        );
        kv_mux32 #(
            .W(ELEN)
        ) u_r4_data (
            .out(vrf_r4_data),
            .sel(vrf_r4_addr),
            .in(s32)
        );
        kv_mux32 #(
            .W(ELEN)
        ) u_r5_data (
            .out(vrf_r5_data),
            .sel(vrf_r5_addr),
            .in(s32)
        );
        kv_mux32 #(
            .W(ELEN)
        ) u_r6_data (
            .out(vrf_r6_data),
            .sel(vrf_r6_addr),
            .in(s32)
        );
        kv_mux32 #(
            .W(ELEN)
        ) u_r7_data (
            .out(vrf_r7_data),
            .sel(vrf_r7_addr),
            .in(s32)
        );
    end
endgenerate
generate
    if (VMAC2_TYPE != 0) begin:gen_vmac2_rports
        kv_mux32 #(
            .W(ELEN)
        ) u_r8_data (
            .out(vrf_r8_data),
            .sel(vrf_r8_addr),
            .in(s32)
        );
        kv_mux32 #(
            .W(ELEN)
        ) u_r9_data (
            .out(vrf_r9_data),
            .sel(vrf_r9_addr),
            .in(s32)
        );
        kv_mux32 #(
            .W(ELEN)
        ) u_r10_data (
            .out(vrf_r10_data),
            .sel(vrf_r10_addr),
            .in(s32)
        );
    end
    else begin:gen_vmac2_rports_stub
        assign vrf_r8_data = {ELEN{1'b0}};
        assign vrf_r9_data = {ELEN{1'b0}};
        assign vrf_r10_data = {ELEN{1'b0}};
    end
endgenerate
assign v0 = s0;
assign v1 = s1;
assign v2 = s2;
assign v3 = s3;
assign v4 = s4;
assign v5 = s5;
assign v6 = s6;
assign v7 = s7;
assign v8 = s8;
assign v9 = s9;
assign v10 = s10;
assign v11 = s11;
assign v12 = s12;
assign v13 = s13;
assign v14 = s14;
assign v15 = s15;
assign v16 = s16;
assign v17 = s17;
assign v18 = s18;
assign v19 = s19;
assign v20 = s20;
assign v21 = s21;
assign v22 = s22;
assign v23 = s23;
assign v24 = s24;
assign v25 = s25;
assign v26 = s26;
assign v27 = s27;
assign v28 = s28;
assign v29 = s29;
assign v30 = s30;
assign v31 = s31;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

