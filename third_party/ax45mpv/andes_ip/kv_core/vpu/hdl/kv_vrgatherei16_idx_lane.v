// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vrgatherei16_idx_lane (
    lmul_onehot,
    vs1_rdata,
    vs2_group,
    vrgatherei16_idx,
    vrgatherei16_body_mask,
    vrgatherei16_buf0_mask
);
parameter VLEN = 512;
parameter SEW = 8;
localparam DW = 64 * 16 / SEW;
localparam SW = (VLEN == 128) ? 4 : (VLEN == 256) ? 5 : (VLEN == 512) ? 6 : 7;
input [7:0] lmul_onehot;
input [DW - 1:0] vs1_rdata;
input [23:0] vs2_group;
output [SW * 8 - 1:0] vrgatherei16_idx;
output [7:0] vrgatherei16_body_mask;
output [7:0] vrgatherei16_buf0_mask;





// ca65f7de rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [SW - 1:0] s0;
wire [SW - 1:0] s1;
wire [SW - 1:0] s2;
wire [SW - 1:0] s3;
wire [SW - 1:0] s4;
wire [SW - 1:0] s5;
wire [SW - 1:0] s6;
wire [SW - 1:0] s7;
wire [2:0] s8;
wire [2:0] s9;
wire [2:0] s10;
wire [2:0] s11;
wire [2:0] s12;
wire [2:0] s13;
wire [2:0] s14;
wire [2:0] s15;
wire [2:0] s16;
wire [2:0] s17;
wire [2:0] s18;
wire [2:0] s19;
wire [2:0] s20;
wire [2:0] s21;
wire [2:0] s22;
wire [2:0] s23;
assign vrgatherei16_idx = {s7[SW - 1:0],s6[SW - 1:0],s5[SW - 1:0],s4[SW - 1:0],s3[SW - 1:0],s2[SW - 1:0],s1[SW - 1:0],s0[SW - 1:0]};
assign {s23,s22,s21,s20,s19,s18,s17,s16} = vs2_group;
assign vrgatherei16_buf0_mask[0] = ~vrgatherei16_body_mask[0] | (s8 == s16);
assign vrgatherei16_buf0_mask[1] = ~vrgatherei16_body_mask[1] | (s9 == s17);
assign vrgatherei16_buf0_mask[2] = ~vrgatherei16_body_mask[2] | (s10 == s18);
assign vrgatherei16_buf0_mask[3] = ~vrgatherei16_body_mask[3] | (s11 == s19);
assign vrgatherei16_buf0_mask[4] = ~vrgatherei16_body_mask[4] | (s12 == s20);
assign vrgatherei16_buf0_mask[5] = ~vrgatherei16_body_mask[5] | (s13 == s21);
assign vrgatherei16_buf0_mask[6] = ~vrgatherei16_body_mask[6] | (s14 == s22);
assign vrgatherei16_buf0_mask[7] = ~vrgatherei16_body_mask[7] | (s15 == s23);
generate
    if (VLEN == 128 & SEW == 8) begin:gen_vlen128_sew8
        assign {s8,s0} = {vs1_rdata[4 +:3],vs1_rdata[0 +:4]};
        assign {s9,s1} = {vs1_rdata[20 +:3],vs1_rdata[16 +:4]};
        assign {s10,s2} = {vs1_rdata[36 +:3],vs1_rdata[32 +:4]};
        assign {s11,s3} = {vs1_rdata[52 +:3],vs1_rdata[48 +:4]};
        assign {s12,s4} = {vs1_rdata[68 +:3],vs1_rdata[64 +:4]};
        assign {s13,s5} = {vs1_rdata[84 +:3],vs1_rdata[80 +:4]};
        assign {s14,s6} = {vs1_rdata[100 +:3],vs1_rdata[96 +:4]};
        assign {s15,s7} = {vs1_rdata[116 +:3],vs1_rdata[112 +:4]};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:4]) | (lmul_onehot[1] & ~|vs1_rdata[15:5]) | (lmul_onehot[2] & ~|vs1_rdata[15:6]) | (lmul_onehot[3] & ~|vs1_rdata[15:7]) | (lmul_onehot[5] & ~|vs1_rdata[15:1]) | (lmul_onehot[6] & ~|vs1_rdata[15:2]) | (lmul_onehot[7] & ~|vs1_rdata[15:3]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[31:20]) | (lmul_onehot[1] & ~|vs1_rdata[31:21]) | (lmul_onehot[2] & ~|vs1_rdata[31:22]) | (lmul_onehot[3] & ~|vs1_rdata[31:23]) | (lmul_onehot[5] & ~|vs1_rdata[31:17]) | (lmul_onehot[6] & ~|vs1_rdata[31:18]) | (lmul_onehot[7] & ~|vs1_rdata[31:19]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[47:36]) | (lmul_onehot[1] & ~|vs1_rdata[47:37]) | (lmul_onehot[2] & ~|vs1_rdata[47:38]) | (lmul_onehot[3] & ~|vs1_rdata[47:39]) | (lmul_onehot[5] & ~|vs1_rdata[47:33]) | (lmul_onehot[6] & ~|vs1_rdata[47:34]) | (lmul_onehot[7] & ~|vs1_rdata[47:35]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[63:52]) | (lmul_onehot[1] & ~|vs1_rdata[63:53]) | (lmul_onehot[2] & ~|vs1_rdata[63:54]) | (lmul_onehot[3] & ~|vs1_rdata[63:55]) | (lmul_onehot[5] & ~|vs1_rdata[63:49]) | (lmul_onehot[6] & ~|vs1_rdata[63:50]) | (lmul_onehot[7] & ~|vs1_rdata[63:51]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[79:68]) | (lmul_onehot[1] & ~|vs1_rdata[79:69]) | (lmul_onehot[2] & ~|vs1_rdata[79:70]) | (lmul_onehot[3] & ~|vs1_rdata[79:71]) | (lmul_onehot[5] & ~|vs1_rdata[79:65]) | (lmul_onehot[6] & ~|vs1_rdata[79:66]) | (lmul_onehot[7] & ~|vs1_rdata[79:67]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[95:84]) | (lmul_onehot[1] & ~|vs1_rdata[95:85]) | (lmul_onehot[2] & ~|vs1_rdata[95:86]) | (lmul_onehot[3] & ~|vs1_rdata[95:87]) | (lmul_onehot[5] & ~|vs1_rdata[95:81]) | (lmul_onehot[6] & ~|vs1_rdata[95:82]) | (lmul_onehot[7] & ~|vs1_rdata[95:83]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[111:100]) | (lmul_onehot[1] & ~|vs1_rdata[111:101]) | (lmul_onehot[2] & ~|vs1_rdata[111:102]) | (lmul_onehot[3] & ~|vs1_rdata[111:103]) | (lmul_onehot[5] & ~|vs1_rdata[111:97]) | (lmul_onehot[6] & ~|vs1_rdata[111:98]) | (lmul_onehot[7] & ~|vs1_rdata[111:99]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[127:116]) | (lmul_onehot[1] & ~|vs1_rdata[127:117]) | (lmul_onehot[2] & ~|vs1_rdata[127:118]) | (lmul_onehot[3] & ~|vs1_rdata[127:119]) | (lmul_onehot[5] & ~|vs1_rdata[127:113]) | (lmul_onehot[6] & ~|vs1_rdata[127:114]) | (lmul_onehot[7] & ~|vs1_rdata[127:115]);
    end
endgenerate
generate
    if (VLEN == 128 & SEW == 16) begin:gen_vlen128_sew16
        assign {s8,s0} = {vs1_rdata[3 +:3],vs1_rdata[0 +:3],1'd0};
        assign {s9,s1} = {vs1_rdata[3 +:3],vs1_rdata[0 +:3],1'd1};
        assign {s10,s2} = {vs1_rdata[19 +:3],vs1_rdata[16 +:3],1'd0};
        assign {s11,s3} = {vs1_rdata[19 +:3],vs1_rdata[16 +:3],1'd1};
        assign {s12,s4} = {vs1_rdata[35 +:3],vs1_rdata[32 +:3],1'd0};
        assign {s13,s5} = {vs1_rdata[35 +:3],vs1_rdata[32 +:3],1'd1};
        assign {s14,s6} = {vs1_rdata[51 +:3],vs1_rdata[48 +:3],1'd0};
        assign {s15,s7} = {vs1_rdata[51 +:3],vs1_rdata[48 +:3],1'd1};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:3]) | (lmul_onehot[1] & ~|vs1_rdata[15:4]) | (lmul_onehot[2] & ~|vs1_rdata[15:5]) | (lmul_onehot[3] & ~|vs1_rdata[15:6]) | (lmul_onehot[5] & ~|vs1_rdata[15:0]) | (lmul_onehot[6] & ~|vs1_rdata[15:1]) | (lmul_onehot[7] & ~|vs1_rdata[15:2]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[15:3]) | (lmul_onehot[1] & ~|vs1_rdata[15:4]) | (lmul_onehot[2] & ~|vs1_rdata[15:5]) | (lmul_onehot[3] & ~|vs1_rdata[15:6]) | (lmul_onehot[5] & ~|vs1_rdata[15:0]) | (lmul_onehot[6] & ~|vs1_rdata[15:1]) | (lmul_onehot[7] & ~|vs1_rdata[15:2]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[31:19]) | (lmul_onehot[1] & ~|vs1_rdata[31:20]) | (lmul_onehot[2] & ~|vs1_rdata[31:21]) | (lmul_onehot[3] & ~|vs1_rdata[31:22]) | (lmul_onehot[5] & ~|vs1_rdata[31:16]) | (lmul_onehot[6] & ~|vs1_rdata[31:17]) | (lmul_onehot[7] & ~|vs1_rdata[31:18]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[31:19]) | (lmul_onehot[1] & ~|vs1_rdata[31:20]) | (lmul_onehot[2] & ~|vs1_rdata[31:21]) | (lmul_onehot[3] & ~|vs1_rdata[31:22]) | (lmul_onehot[5] & ~|vs1_rdata[31:16]) | (lmul_onehot[6] & ~|vs1_rdata[31:17]) | (lmul_onehot[7] & ~|vs1_rdata[31:18]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[47:35]) | (lmul_onehot[1] & ~|vs1_rdata[47:36]) | (lmul_onehot[2] & ~|vs1_rdata[47:37]) | (lmul_onehot[3] & ~|vs1_rdata[47:38]) | (lmul_onehot[5] & ~|vs1_rdata[47:32]) | (lmul_onehot[6] & ~|vs1_rdata[47:33]) | (lmul_onehot[7] & ~|vs1_rdata[47:34]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[47:35]) | (lmul_onehot[1] & ~|vs1_rdata[47:36]) | (lmul_onehot[2] & ~|vs1_rdata[47:37]) | (lmul_onehot[3] & ~|vs1_rdata[47:38]) | (lmul_onehot[5] & ~|vs1_rdata[47:32]) | (lmul_onehot[6] & ~|vs1_rdata[47:33]) | (lmul_onehot[7] & ~|vs1_rdata[47:34]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[63:51]) | (lmul_onehot[1] & ~|vs1_rdata[63:52]) | (lmul_onehot[2] & ~|vs1_rdata[63:53]) | (lmul_onehot[3] & ~|vs1_rdata[63:54]) | (lmul_onehot[5] & ~|vs1_rdata[63:48]) | (lmul_onehot[6] & ~|vs1_rdata[63:49]) | (lmul_onehot[7] & ~|vs1_rdata[63:50]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[63:51]) | (lmul_onehot[1] & ~|vs1_rdata[63:52]) | (lmul_onehot[2] & ~|vs1_rdata[63:53]) | (lmul_onehot[3] & ~|vs1_rdata[63:54]) | (lmul_onehot[5] & ~|vs1_rdata[63:48]) | (lmul_onehot[6] & ~|vs1_rdata[63:49]) | (lmul_onehot[7] & ~|vs1_rdata[63:50]);
    end
endgenerate
generate
    if (VLEN == 128 & SEW == 32) begin:gen_vlen128_sew32
        assign {s8,s0} = {vs1_rdata[2 +:3],vs1_rdata[0 +:2],2'd0};
        assign {s9,s1} = {vs1_rdata[2 +:3],vs1_rdata[0 +:2],2'd1};
        assign {s10,s2} = {vs1_rdata[2 +:3],vs1_rdata[0 +:2],2'd2};
        assign {s11,s3} = {vs1_rdata[2 +:3],vs1_rdata[0 +:2],2'd3};
        assign {s12,s4} = {vs1_rdata[18 +:3],vs1_rdata[16 +:2],2'd0};
        assign {s13,s5} = {vs1_rdata[18 +:3],vs1_rdata[16 +:2],2'd1};
        assign {s14,s6} = {vs1_rdata[18 +:3],vs1_rdata[16 +:2],2'd2};
        assign {s15,s7} = {vs1_rdata[18 +:3],vs1_rdata[16 +:2],2'd3};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:2]) | (lmul_onehot[1] & ~|vs1_rdata[15:3]) | (lmul_onehot[2] & ~|vs1_rdata[15:4]) | (lmul_onehot[3] & ~|vs1_rdata[15:5]) | (lmul_onehot[6] & ~|vs1_rdata[15:0]) | (lmul_onehot[7] & ~|vs1_rdata[15:1]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[15:2]) | (lmul_onehot[1] & ~|vs1_rdata[15:3]) | (lmul_onehot[2] & ~|vs1_rdata[15:4]) | (lmul_onehot[3] & ~|vs1_rdata[15:5]) | (lmul_onehot[6] & ~|vs1_rdata[15:0]) | (lmul_onehot[7] & ~|vs1_rdata[15:1]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[15:2]) | (lmul_onehot[1] & ~|vs1_rdata[15:3]) | (lmul_onehot[2] & ~|vs1_rdata[15:4]) | (lmul_onehot[3] & ~|vs1_rdata[15:5]) | (lmul_onehot[6] & ~|vs1_rdata[15:0]) | (lmul_onehot[7] & ~|vs1_rdata[15:1]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[15:2]) | (lmul_onehot[1] & ~|vs1_rdata[15:3]) | (lmul_onehot[2] & ~|vs1_rdata[15:4]) | (lmul_onehot[3] & ~|vs1_rdata[15:5]) | (lmul_onehot[6] & ~|vs1_rdata[15:0]) | (lmul_onehot[7] & ~|vs1_rdata[15:1]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[31:18]) | (lmul_onehot[1] & ~|vs1_rdata[31:19]) | (lmul_onehot[2] & ~|vs1_rdata[31:20]) | (lmul_onehot[3] & ~|vs1_rdata[31:21]) | (lmul_onehot[5] & ~|vs1_rdata[31:15]) | (lmul_onehot[6] & ~|vs1_rdata[31:16]) | (lmul_onehot[7] & ~|vs1_rdata[31:17]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[31:18]) | (lmul_onehot[1] & ~|vs1_rdata[31:19]) | (lmul_onehot[2] & ~|vs1_rdata[31:20]) | (lmul_onehot[3] & ~|vs1_rdata[31:21]) | (lmul_onehot[5] & ~|vs1_rdata[31:15]) | (lmul_onehot[6] & ~|vs1_rdata[31:16]) | (lmul_onehot[7] & ~|vs1_rdata[31:17]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[31:18]) | (lmul_onehot[1] & ~|vs1_rdata[31:19]) | (lmul_onehot[2] & ~|vs1_rdata[31:20]) | (lmul_onehot[3] & ~|vs1_rdata[31:21]) | (lmul_onehot[5] & ~|vs1_rdata[31:15]) | (lmul_onehot[6] & ~|vs1_rdata[31:16]) | (lmul_onehot[7] & ~|vs1_rdata[31:17]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[31:18]) | (lmul_onehot[1] & ~|vs1_rdata[31:19]) | (lmul_onehot[2] & ~|vs1_rdata[31:20]) | (lmul_onehot[3] & ~|vs1_rdata[31:21]) | (lmul_onehot[5] & ~|vs1_rdata[31:15]) | (lmul_onehot[6] & ~|vs1_rdata[31:16]) | (lmul_onehot[7] & ~|vs1_rdata[31:17]);
    end
endgenerate
generate
    if (VLEN == 128 & SEW == 64) begin:gen_vlen128_sew64
        assign {s8,s0} = {vs1_rdata[1 +:3],vs1_rdata[0 +:1],3'd0};
        assign {s9,s1} = {vs1_rdata[1 +:3],vs1_rdata[0 +:1],3'd1};
        assign {s10,s2} = {vs1_rdata[1 +:3],vs1_rdata[0 +:1],3'd2};
        assign {s11,s3} = {vs1_rdata[1 +:3],vs1_rdata[0 +:1],3'd3};
        assign {s12,s4} = {vs1_rdata[1 +:3],vs1_rdata[0 +:1],3'd4};
        assign {s13,s5} = {vs1_rdata[1 +:3],vs1_rdata[0 +:1],3'd5};
        assign {s14,s6} = {vs1_rdata[1 +:3],vs1_rdata[0 +:1],3'd6};
        assign {s15,s7} = {vs1_rdata[1 +:3],vs1_rdata[0 +:1],3'd7};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:1]) | (lmul_onehot[1] & ~|vs1_rdata[15:2]) | (lmul_onehot[2] & ~|vs1_rdata[15:3]) | (lmul_onehot[3] & ~|vs1_rdata[15:4]) | (lmul_onehot[7] & ~|vs1_rdata[15:0]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[15:1]) | (lmul_onehot[1] & ~|vs1_rdata[15:2]) | (lmul_onehot[2] & ~|vs1_rdata[15:3]) | (lmul_onehot[3] & ~|vs1_rdata[15:4]) | (lmul_onehot[7] & ~|vs1_rdata[15:0]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[15:1]) | (lmul_onehot[1] & ~|vs1_rdata[15:2]) | (lmul_onehot[2] & ~|vs1_rdata[15:3]) | (lmul_onehot[3] & ~|vs1_rdata[15:4]) | (lmul_onehot[7] & ~|vs1_rdata[15:0]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[15:1]) | (lmul_onehot[1] & ~|vs1_rdata[15:2]) | (lmul_onehot[2] & ~|vs1_rdata[15:3]) | (lmul_onehot[3] & ~|vs1_rdata[15:4]) | (lmul_onehot[7] & ~|vs1_rdata[15:0]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[15:1]) | (lmul_onehot[1] & ~|vs1_rdata[15:2]) | (lmul_onehot[2] & ~|vs1_rdata[15:3]) | (lmul_onehot[3] & ~|vs1_rdata[15:4]) | (lmul_onehot[7] & ~|vs1_rdata[15:0]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[15:1]) | (lmul_onehot[1] & ~|vs1_rdata[15:2]) | (lmul_onehot[2] & ~|vs1_rdata[15:3]) | (lmul_onehot[3] & ~|vs1_rdata[15:4]) | (lmul_onehot[7] & ~|vs1_rdata[15:0]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[15:1]) | (lmul_onehot[1] & ~|vs1_rdata[15:2]) | (lmul_onehot[2] & ~|vs1_rdata[15:3]) | (lmul_onehot[3] & ~|vs1_rdata[15:4]) | (lmul_onehot[7] & ~|vs1_rdata[15:0]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[15:1]) | (lmul_onehot[1] & ~|vs1_rdata[15:2]) | (lmul_onehot[2] & ~|vs1_rdata[15:3]) | (lmul_onehot[3] & ~|vs1_rdata[15:4]) | (lmul_onehot[7] & ~|vs1_rdata[15:0]);
    end
endgenerate
generate
    if (VLEN == 256 & SEW == 8) begin:gen_vlen256_sew8
        assign {s8,s0} = {vs1_rdata[5 +:3],vs1_rdata[0 +:5]};
        assign {s9,s1} = {vs1_rdata[21 +:3],vs1_rdata[16 +:5]};
        assign {s10,s2} = {vs1_rdata[37 +:3],vs1_rdata[32 +:5]};
        assign {s11,s3} = {vs1_rdata[53 +:3],vs1_rdata[48 +:5]};
        assign {s12,s4} = {vs1_rdata[69 +:3],vs1_rdata[64 +:5]};
        assign {s13,s5} = {vs1_rdata[85 +:3],vs1_rdata[80 +:5]};
        assign {s14,s6} = {vs1_rdata[101 +:3],vs1_rdata[96 +:5]};
        assign {s15,s7} = {vs1_rdata[117 +:3],vs1_rdata[112 +:5]};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:5]) | (lmul_onehot[1] & ~|vs1_rdata[15:6]) | (lmul_onehot[2] & ~|vs1_rdata[15:7]) | (lmul_onehot[3] & ~|vs1_rdata[15:8]) | (lmul_onehot[5] & ~|vs1_rdata[15:2]) | (lmul_onehot[6] & ~|vs1_rdata[15:3]) | (lmul_onehot[7] & ~|vs1_rdata[15:4]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[31:21]) | (lmul_onehot[1] & ~|vs1_rdata[31:22]) | (lmul_onehot[2] & ~|vs1_rdata[31:23]) | (lmul_onehot[3] & ~|vs1_rdata[31:24]) | (lmul_onehot[5] & ~|vs1_rdata[31:18]) | (lmul_onehot[6] & ~|vs1_rdata[31:19]) | (lmul_onehot[7] & ~|vs1_rdata[31:20]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[47:37]) | (lmul_onehot[1] & ~|vs1_rdata[47:38]) | (lmul_onehot[2] & ~|vs1_rdata[47:39]) | (lmul_onehot[3] & ~|vs1_rdata[47:40]) | (lmul_onehot[5] & ~|vs1_rdata[47:34]) | (lmul_onehot[6] & ~|vs1_rdata[47:35]) | (lmul_onehot[7] & ~|vs1_rdata[47:36]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[63:53]) | (lmul_onehot[1] & ~|vs1_rdata[63:54]) | (lmul_onehot[2] & ~|vs1_rdata[63:55]) | (lmul_onehot[3] & ~|vs1_rdata[63:56]) | (lmul_onehot[5] & ~|vs1_rdata[63:50]) | (lmul_onehot[6] & ~|vs1_rdata[63:51]) | (lmul_onehot[7] & ~|vs1_rdata[63:52]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[79:69]) | (lmul_onehot[1] & ~|vs1_rdata[79:70]) | (lmul_onehot[2] & ~|vs1_rdata[79:71]) | (lmul_onehot[3] & ~|vs1_rdata[79:72]) | (lmul_onehot[5] & ~|vs1_rdata[79:66]) | (lmul_onehot[6] & ~|vs1_rdata[79:67]) | (lmul_onehot[7] & ~|vs1_rdata[79:68]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[95:85]) | (lmul_onehot[1] & ~|vs1_rdata[95:86]) | (lmul_onehot[2] & ~|vs1_rdata[95:87]) | (lmul_onehot[3] & ~|vs1_rdata[95:88]) | (lmul_onehot[5] & ~|vs1_rdata[95:82]) | (lmul_onehot[6] & ~|vs1_rdata[95:83]) | (lmul_onehot[7] & ~|vs1_rdata[95:84]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[111:101]) | (lmul_onehot[1] & ~|vs1_rdata[111:102]) | (lmul_onehot[2] & ~|vs1_rdata[111:103]) | (lmul_onehot[3] & ~|vs1_rdata[111:104]) | (lmul_onehot[5] & ~|vs1_rdata[111:98]) | (lmul_onehot[6] & ~|vs1_rdata[111:99]) | (lmul_onehot[7] & ~|vs1_rdata[111:100]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[127:117]) | (lmul_onehot[1] & ~|vs1_rdata[127:118]) | (lmul_onehot[2] & ~|vs1_rdata[127:119]) | (lmul_onehot[3] & ~|vs1_rdata[127:120]) | (lmul_onehot[5] & ~|vs1_rdata[127:114]) | (lmul_onehot[6] & ~|vs1_rdata[127:115]) | (lmul_onehot[7] & ~|vs1_rdata[127:116]);
    end
endgenerate
generate
    if (VLEN == 256 & SEW == 16) begin:gen_vlen256_sew16
        assign {s8,s0} = {vs1_rdata[4 +:3],vs1_rdata[0 +:4],1'd0};
        assign {s9,s1} = {vs1_rdata[4 +:3],vs1_rdata[0 +:4],1'd1};
        assign {s10,s2} = {vs1_rdata[20 +:3],vs1_rdata[16 +:4],1'd0};
        assign {s11,s3} = {vs1_rdata[20 +:3],vs1_rdata[16 +:4],1'd1};
        assign {s12,s4} = {vs1_rdata[36 +:3],vs1_rdata[32 +:4],1'd0};
        assign {s13,s5} = {vs1_rdata[36 +:3],vs1_rdata[32 +:4],1'd1};
        assign {s14,s6} = {vs1_rdata[52 +:3],vs1_rdata[48 +:4],1'd0};
        assign {s15,s7} = {vs1_rdata[52 +:3],vs1_rdata[48 +:4],1'd1};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:4]) | (lmul_onehot[1] & ~|vs1_rdata[15:5]) | (lmul_onehot[2] & ~|vs1_rdata[15:6]) | (lmul_onehot[3] & ~|vs1_rdata[15:7]) | (lmul_onehot[5] & ~|vs1_rdata[15:1]) | (lmul_onehot[6] & ~|vs1_rdata[15:2]) | (lmul_onehot[7] & ~|vs1_rdata[15:3]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[15:4]) | (lmul_onehot[1] & ~|vs1_rdata[15:5]) | (lmul_onehot[2] & ~|vs1_rdata[15:6]) | (lmul_onehot[3] & ~|vs1_rdata[15:7]) | (lmul_onehot[5] & ~|vs1_rdata[15:1]) | (lmul_onehot[6] & ~|vs1_rdata[15:2]) | (lmul_onehot[7] & ~|vs1_rdata[15:3]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[31:20]) | (lmul_onehot[1] & ~|vs1_rdata[31:21]) | (lmul_onehot[2] & ~|vs1_rdata[31:22]) | (lmul_onehot[3] & ~|vs1_rdata[31:23]) | (lmul_onehot[5] & ~|vs1_rdata[31:17]) | (lmul_onehot[6] & ~|vs1_rdata[31:18]) | (lmul_onehot[7] & ~|vs1_rdata[31:19]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[31:20]) | (lmul_onehot[1] & ~|vs1_rdata[31:21]) | (lmul_onehot[2] & ~|vs1_rdata[31:22]) | (lmul_onehot[3] & ~|vs1_rdata[31:23]) | (lmul_onehot[5] & ~|vs1_rdata[31:17]) | (lmul_onehot[6] & ~|vs1_rdata[31:18]) | (lmul_onehot[7] & ~|vs1_rdata[31:19]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[47:36]) | (lmul_onehot[1] & ~|vs1_rdata[47:37]) | (lmul_onehot[2] & ~|vs1_rdata[47:38]) | (lmul_onehot[3] & ~|vs1_rdata[47:39]) | (lmul_onehot[5] & ~|vs1_rdata[47:33]) | (lmul_onehot[6] & ~|vs1_rdata[47:34]) | (lmul_onehot[7] & ~|vs1_rdata[47:35]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[47:36]) | (lmul_onehot[1] & ~|vs1_rdata[47:37]) | (lmul_onehot[2] & ~|vs1_rdata[47:38]) | (lmul_onehot[3] & ~|vs1_rdata[47:39]) | (lmul_onehot[5] & ~|vs1_rdata[47:33]) | (lmul_onehot[6] & ~|vs1_rdata[47:34]) | (lmul_onehot[7] & ~|vs1_rdata[47:35]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[63:52]) | (lmul_onehot[1] & ~|vs1_rdata[63:53]) | (lmul_onehot[2] & ~|vs1_rdata[63:54]) | (lmul_onehot[3] & ~|vs1_rdata[63:55]) | (lmul_onehot[5] & ~|vs1_rdata[63:49]) | (lmul_onehot[6] & ~|vs1_rdata[63:50]) | (lmul_onehot[7] & ~|vs1_rdata[63:51]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[63:52]) | (lmul_onehot[1] & ~|vs1_rdata[63:53]) | (lmul_onehot[2] & ~|vs1_rdata[63:54]) | (lmul_onehot[3] & ~|vs1_rdata[63:55]) | (lmul_onehot[5] & ~|vs1_rdata[63:49]) | (lmul_onehot[6] & ~|vs1_rdata[63:50]) | (lmul_onehot[7] & ~|vs1_rdata[63:51]);
    end
endgenerate
generate
    if (VLEN == 256 & SEW == 32) begin:gen_vlen256_sew32
        assign {s8,s0} = {vs1_rdata[3 +:3],vs1_rdata[0 +:3],2'd0};
        assign {s9,s1} = {vs1_rdata[3 +:3],vs1_rdata[0 +:3],2'd1};
        assign {s10,s2} = {vs1_rdata[3 +:3],vs1_rdata[0 +:3],2'd2};
        assign {s11,s3} = {vs1_rdata[3 +:3],vs1_rdata[0 +:3],2'd3};
        assign {s12,s4} = {vs1_rdata[19 +:3],vs1_rdata[16 +:3],2'd0};
        assign {s13,s5} = {vs1_rdata[19 +:3],vs1_rdata[16 +:3],2'd1};
        assign {s14,s6} = {vs1_rdata[19 +:3],vs1_rdata[16 +:3],2'd2};
        assign {s15,s7} = {vs1_rdata[19 +:3],vs1_rdata[16 +:3],2'd3};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:3]) | (lmul_onehot[1] & ~|vs1_rdata[15:4]) | (lmul_onehot[2] & ~|vs1_rdata[15:5]) | (lmul_onehot[3] & ~|vs1_rdata[15:6]) | (lmul_onehot[5] & ~|vs1_rdata[15:0]) | (lmul_onehot[6] & ~|vs1_rdata[15:1]) | (lmul_onehot[7] & ~|vs1_rdata[15:2]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[15:3]) | (lmul_onehot[1] & ~|vs1_rdata[15:4]) | (lmul_onehot[2] & ~|vs1_rdata[15:5]) | (lmul_onehot[3] & ~|vs1_rdata[15:6]) | (lmul_onehot[5] & ~|vs1_rdata[15:0]) | (lmul_onehot[6] & ~|vs1_rdata[15:1]) | (lmul_onehot[7] & ~|vs1_rdata[15:2]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[15:3]) | (lmul_onehot[1] & ~|vs1_rdata[15:4]) | (lmul_onehot[2] & ~|vs1_rdata[15:5]) | (lmul_onehot[3] & ~|vs1_rdata[15:6]) | (lmul_onehot[5] & ~|vs1_rdata[15:0]) | (lmul_onehot[6] & ~|vs1_rdata[15:1]) | (lmul_onehot[7] & ~|vs1_rdata[15:2]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[15:3]) | (lmul_onehot[1] & ~|vs1_rdata[15:4]) | (lmul_onehot[2] & ~|vs1_rdata[15:5]) | (lmul_onehot[3] & ~|vs1_rdata[15:6]) | (lmul_onehot[5] & ~|vs1_rdata[15:0]) | (lmul_onehot[6] & ~|vs1_rdata[15:1]) | (lmul_onehot[7] & ~|vs1_rdata[15:2]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[31:19]) | (lmul_onehot[1] & ~|vs1_rdata[31:20]) | (lmul_onehot[2] & ~|vs1_rdata[31:21]) | (lmul_onehot[3] & ~|vs1_rdata[31:22]) | (lmul_onehot[5] & ~|vs1_rdata[31:16]) | (lmul_onehot[6] & ~|vs1_rdata[31:17]) | (lmul_onehot[7] & ~|vs1_rdata[31:18]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[31:19]) | (lmul_onehot[1] & ~|vs1_rdata[31:20]) | (lmul_onehot[2] & ~|vs1_rdata[31:21]) | (lmul_onehot[3] & ~|vs1_rdata[31:22]) | (lmul_onehot[5] & ~|vs1_rdata[31:16]) | (lmul_onehot[6] & ~|vs1_rdata[31:17]) | (lmul_onehot[7] & ~|vs1_rdata[31:18]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[31:19]) | (lmul_onehot[1] & ~|vs1_rdata[31:20]) | (lmul_onehot[2] & ~|vs1_rdata[31:21]) | (lmul_onehot[3] & ~|vs1_rdata[31:22]) | (lmul_onehot[5] & ~|vs1_rdata[31:16]) | (lmul_onehot[6] & ~|vs1_rdata[31:17]) | (lmul_onehot[7] & ~|vs1_rdata[31:18]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[31:19]) | (lmul_onehot[1] & ~|vs1_rdata[31:20]) | (lmul_onehot[2] & ~|vs1_rdata[31:21]) | (lmul_onehot[3] & ~|vs1_rdata[31:22]) | (lmul_onehot[5] & ~|vs1_rdata[31:16]) | (lmul_onehot[6] & ~|vs1_rdata[31:17]) | (lmul_onehot[7] & ~|vs1_rdata[31:18]);
    end
endgenerate
generate
    if (VLEN == 256 & SEW == 64) begin:gen_vlen256_sew64
        assign {s8,s0} = {vs1_rdata[2 +:3],vs1_rdata[0 +:2],3'd0};
        assign {s9,s1} = {vs1_rdata[2 +:3],vs1_rdata[0 +:2],3'd1};
        assign {s10,s2} = {vs1_rdata[2 +:3],vs1_rdata[0 +:2],3'd2};
        assign {s11,s3} = {vs1_rdata[2 +:3],vs1_rdata[0 +:2],3'd3};
        assign {s12,s4} = {vs1_rdata[2 +:3],vs1_rdata[0 +:2],3'd4};
        assign {s13,s5} = {vs1_rdata[2 +:3],vs1_rdata[0 +:2],3'd5};
        assign {s14,s6} = {vs1_rdata[2 +:3],vs1_rdata[0 +:2],3'd6};
        assign {s15,s7} = {vs1_rdata[2 +:3],vs1_rdata[0 +:2],3'd7};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:2]) | (lmul_onehot[1] & ~|vs1_rdata[15:3]) | (lmul_onehot[2] & ~|vs1_rdata[15:4]) | (lmul_onehot[3] & ~|vs1_rdata[15:5]) | (lmul_onehot[6] & ~|vs1_rdata[15:0]) | (lmul_onehot[7] & ~|vs1_rdata[15:1]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[15:2]) | (lmul_onehot[1] & ~|vs1_rdata[15:3]) | (lmul_onehot[2] & ~|vs1_rdata[15:4]) | (lmul_onehot[3] & ~|vs1_rdata[15:5]) | (lmul_onehot[6] & ~|vs1_rdata[15:0]) | (lmul_onehot[7] & ~|vs1_rdata[15:1]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[15:2]) | (lmul_onehot[1] & ~|vs1_rdata[15:3]) | (lmul_onehot[2] & ~|vs1_rdata[15:4]) | (lmul_onehot[3] & ~|vs1_rdata[15:5]) | (lmul_onehot[6] & ~|vs1_rdata[15:0]) | (lmul_onehot[7] & ~|vs1_rdata[15:1]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[15:2]) | (lmul_onehot[1] & ~|vs1_rdata[15:3]) | (lmul_onehot[2] & ~|vs1_rdata[15:4]) | (lmul_onehot[3] & ~|vs1_rdata[15:5]) | (lmul_onehot[6] & ~|vs1_rdata[15:0]) | (lmul_onehot[7] & ~|vs1_rdata[15:1]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[15:2]) | (lmul_onehot[1] & ~|vs1_rdata[15:3]) | (lmul_onehot[2] & ~|vs1_rdata[15:4]) | (lmul_onehot[3] & ~|vs1_rdata[15:5]) | (lmul_onehot[6] & ~|vs1_rdata[15:0]) | (lmul_onehot[7] & ~|vs1_rdata[15:1]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[15:2]) | (lmul_onehot[1] & ~|vs1_rdata[15:3]) | (lmul_onehot[2] & ~|vs1_rdata[15:4]) | (lmul_onehot[3] & ~|vs1_rdata[15:5]) | (lmul_onehot[6] & ~|vs1_rdata[15:0]) | (lmul_onehot[7] & ~|vs1_rdata[15:1]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[15:2]) | (lmul_onehot[1] & ~|vs1_rdata[15:3]) | (lmul_onehot[2] & ~|vs1_rdata[15:4]) | (lmul_onehot[3] & ~|vs1_rdata[15:5]) | (lmul_onehot[6] & ~|vs1_rdata[15:0]) | (lmul_onehot[7] & ~|vs1_rdata[15:1]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[15:2]) | (lmul_onehot[1] & ~|vs1_rdata[15:3]) | (lmul_onehot[2] & ~|vs1_rdata[15:4]) | (lmul_onehot[3] & ~|vs1_rdata[15:5]) | (lmul_onehot[6] & ~|vs1_rdata[15:0]) | (lmul_onehot[7] & ~|vs1_rdata[15:1]);
    end
endgenerate
generate
    if (VLEN == 512 & SEW == 8) begin:gen_vlen512_sew8
        assign {s8,s0} = {vs1_rdata[6 +:3],vs1_rdata[0 +:6]};
        assign {s9,s1} = {vs1_rdata[22 +:3],vs1_rdata[16 +:6]};
        assign {s10,s2} = {vs1_rdata[38 +:3],vs1_rdata[32 +:6]};
        assign {s11,s3} = {vs1_rdata[54 +:3],vs1_rdata[48 +:6]};
        assign {s12,s4} = {vs1_rdata[70 +:3],vs1_rdata[64 +:6]};
        assign {s13,s5} = {vs1_rdata[86 +:3],vs1_rdata[80 +:6]};
        assign {s14,s6} = {vs1_rdata[102 +:3],vs1_rdata[96 +:6]};
        assign {s15,s7} = {vs1_rdata[118 +:3],vs1_rdata[112 +:6]};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:6]) | (lmul_onehot[1] & ~|vs1_rdata[15:7]) | (lmul_onehot[2] & ~|vs1_rdata[15:8]) | (lmul_onehot[3] & ~|vs1_rdata[15:9]) | (lmul_onehot[5] & ~|vs1_rdata[15:3]) | (lmul_onehot[6] & ~|vs1_rdata[15:4]) | (lmul_onehot[7] & ~|vs1_rdata[15:5]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[31:22]) | (lmul_onehot[1] & ~|vs1_rdata[31:23]) | (lmul_onehot[2] & ~|vs1_rdata[31:24]) | (lmul_onehot[3] & ~|vs1_rdata[31:25]) | (lmul_onehot[5] & ~|vs1_rdata[31:19]) | (lmul_onehot[6] & ~|vs1_rdata[31:20]) | (lmul_onehot[7] & ~|vs1_rdata[31:21]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[47:38]) | (lmul_onehot[1] & ~|vs1_rdata[47:39]) | (lmul_onehot[2] & ~|vs1_rdata[47:40]) | (lmul_onehot[3] & ~|vs1_rdata[47:41]) | (lmul_onehot[5] & ~|vs1_rdata[47:35]) | (lmul_onehot[6] & ~|vs1_rdata[47:36]) | (lmul_onehot[7] & ~|vs1_rdata[47:37]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[63:54]) | (lmul_onehot[1] & ~|vs1_rdata[63:55]) | (lmul_onehot[2] & ~|vs1_rdata[63:56]) | (lmul_onehot[3] & ~|vs1_rdata[63:57]) | (lmul_onehot[5] & ~|vs1_rdata[63:51]) | (lmul_onehot[6] & ~|vs1_rdata[63:52]) | (lmul_onehot[7] & ~|vs1_rdata[63:53]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[79:70]) | (lmul_onehot[1] & ~|vs1_rdata[79:71]) | (lmul_onehot[2] & ~|vs1_rdata[79:72]) | (lmul_onehot[3] & ~|vs1_rdata[79:73]) | (lmul_onehot[5] & ~|vs1_rdata[79:67]) | (lmul_onehot[6] & ~|vs1_rdata[79:68]) | (lmul_onehot[7] & ~|vs1_rdata[79:69]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[95:86]) | (lmul_onehot[1] & ~|vs1_rdata[95:87]) | (lmul_onehot[2] & ~|vs1_rdata[95:88]) | (lmul_onehot[3] & ~|vs1_rdata[95:89]) | (lmul_onehot[5] & ~|vs1_rdata[95:83]) | (lmul_onehot[6] & ~|vs1_rdata[95:84]) | (lmul_onehot[7] & ~|vs1_rdata[95:85]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[111:102]) | (lmul_onehot[1] & ~|vs1_rdata[111:103]) | (lmul_onehot[2] & ~|vs1_rdata[111:104]) | (lmul_onehot[3] & ~|vs1_rdata[111:105]) | (lmul_onehot[5] & ~|vs1_rdata[111:99]) | (lmul_onehot[6] & ~|vs1_rdata[111:100]) | (lmul_onehot[7] & ~|vs1_rdata[111:101]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[127:118]) | (lmul_onehot[1] & ~|vs1_rdata[127:119]) | (lmul_onehot[2] & ~|vs1_rdata[127:120]) | (lmul_onehot[3] & ~|vs1_rdata[127:121]) | (lmul_onehot[5] & ~|vs1_rdata[127:115]) | (lmul_onehot[6] & ~|vs1_rdata[127:116]) | (lmul_onehot[7] & ~|vs1_rdata[127:117]);
    end
endgenerate
generate
    if (VLEN == 512 & SEW == 16) begin:gen_vlen512_sew16
        assign {s8,s0} = {vs1_rdata[5 +:3],vs1_rdata[0 +:5],1'd0};
        assign {s9,s1} = {vs1_rdata[5 +:3],vs1_rdata[0 +:5],1'd1};
        assign {s10,s2} = {vs1_rdata[21 +:3],vs1_rdata[16 +:5],1'd0};
        assign {s11,s3} = {vs1_rdata[21 +:3],vs1_rdata[16 +:5],1'd1};
        assign {s12,s4} = {vs1_rdata[37 +:3],vs1_rdata[32 +:5],1'd0};
        assign {s13,s5} = {vs1_rdata[37 +:3],vs1_rdata[32 +:5],1'd1};
        assign {s14,s6} = {vs1_rdata[53 +:3],vs1_rdata[48 +:5],1'd0};
        assign {s15,s7} = {vs1_rdata[53 +:3],vs1_rdata[48 +:5],1'd1};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:5]) | (lmul_onehot[1] & ~|vs1_rdata[15:6]) | (lmul_onehot[2] & ~|vs1_rdata[15:7]) | (lmul_onehot[3] & ~|vs1_rdata[15:8]) | (lmul_onehot[5] & ~|vs1_rdata[15:2]) | (lmul_onehot[6] & ~|vs1_rdata[15:3]) | (lmul_onehot[7] & ~|vs1_rdata[15:4]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[15:5]) | (lmul_onehot[1] & ~|vs1_rdata[15:6]) | (lmul_onehot[2] & ~|vs1_rdata[15:7]) | (lmul_onehot[3] & ~|vs1_rdata[15:8]) | (lmul_onehot[5] & ~|vs1_rdata[15:2]) | (lmul_onehot[6] & ~|vs1_rdata[15:3]) | (lmul_onehot[7] & ~|vs1_rdata[15:4]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[31:21]) | (lmul_onehot[1] & ~|vs1_rdata[31:22]) | (lmul_onehot[2] & ~|vs1_rdata[31:23]) | (lmul_onehot[3] & ~|vs1_rdata[31:24]) | (lmul_onehot[5] & ~|vs1_rdata[31:18]) | (lmul_onehot[6] & ~|vs1_rdata[31:19]) | (lmul_onehot[7] & ~|vs1_rdata[31:20]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[31:21]) | (lmul_onehot[1] & ~|vs1_rdata[31:22]) | (lmul_onehot[2] & ~|vs1_rdata[31:23]) | (lmul_onehot[3] & ~|vs1_rdata[31:24]) | (lmul_onehot[5] & ~|vs1_rdata[31:18]) | (lmul_onehot[6] & ~|vs1_rdata[31:19]) | (lmul_onehot[7] & ~|vs1_rdata[31:20]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[47:37]) | (lmul_onehot[1] & ~|vs1_rdata[47:38]) | (lmul_onehot[2] & ~|vs1_rdata[47:39]) | (lmul_onehot[3] & ~|vs1_rdata[47:40]) | (lmul_onehot[5] & ~|vs1_rdata[47:34]) | (lmul_onehot[6] & ~|vs1_rdata[47:35]) | (lmul_onehot[7] & ~|vs1_rdata[47:36]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[47:37]) | (lmul_onehot[1] & ~|vs1_rdata[47:38]) | (lmul_onehot[2] & ~|vs1_rdata[47:39]) | (lmul_onehot[3] & ~|vs1_rdata[47:40]) | (lmul_onehot[5] & ~|vs1_rdata[47:34]) | (lmul_onehot[6] & ~|vs1_rdata[47:35]) | (lmul_onehot[7] & ~|vs1_rdata[47:36]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[63:53]) | (lmul_onehot[1] & ~|vs1_rdata[63:54]) | (lmul_onehot[2] & ~|vs1_rdata[63:55]) | (lmul_onehot[3] & ~|vs1_rdata[63:56]) | (lmul_onehot[5] & ~|vs1_rdata[63:50]) | (lmul_onehot[6] & ~|vs1_rdata[63:51]) | (lmul_onehot[7] & ~|vs1_rdata[63:52]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[63:53]) | (lmul_onehot[1] & ~|vs1_rdata[63:54]) | (lmul_onehot[2] & ~|vs1_rdata[63:55]) | (lmul_onehot[3] & ~|vs1_rdata[63:56]) | (lmul_onehot[5] & ~|vs1_rdata[63:50]) | (lmul_onehot[6] & ~|vs1_rdata[63:51]) | (lmul_onehot[7] & ~|vs1_rdata[63:52]);
    end
endgenerate
generate
    if (VLEN == 512 & SEW == 32) begin:gen_vlen512_sew32
        assign {s8,s0} = {vs1_rdata[4 +:3],vs1_rdata[0 +:4],2'd0};
        assign {s9,s1} = {vs1_rdata[4 +:3],vs1_rdata[0 +:4],2'd1};
        assign {s10,s2} = {vs1_rdata[4 +:3],vs1_rdata[0 +:4],2'd2};
        assign {s11,s3} = {vs1_rdata[4 +:3],vs1_rdata[0 +:4],2'd3};
        assign {s12,s4} = {vs1_rdata[20 +:3],vs1_rdata[16 +:4],2'd0};
        assign {s13,s5} = {vs1_rdata[20 +:3],vs1_rdata[16 +:4],2'd1};
        assign {s14,s6} = {vs1_rdata[20 +:3],vs1_rdata[16 +:4],2'd2};
        assign {s15,s7} = {vs1_rdata[20 +:3],vs1_rdata[16 +:4],2'd3};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:4]) | (lmul_onehot[1] & ~|vs1_rdata[15:5]) | (lmul_onehot[2] & ~|vs1_rdata[15:6]) | (lmul_onehot[3] & ~|vs1_rdata[15:7]) | (lmul_onehot[5] & ~|vs1_rdata[15:1]) | (lmul_onehot[6] & ~|vs1_rdata[15:2]) | (lmul_onehot[7] & ~|vs1_rdata[15:3]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[15:4]) | (lmul_onehot[1] & ~|vs1_rdata[15:5]) | (lmul_onehot[2] & ~|vs1_rdata[15:6]) | (lmul_onehot[3] & ~|vs1_rdata[15:7]) | (lmul_onehot[5] & ~|vs1_rdata[15:1]) | (lmul_onehot[6] & ~|vs1_rdata[15:2]) | (lmul_onehot[7] & ~|vs1_rdata[15:3]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[15:4]) | (lmul_onehot[1] & ~|vs1_rdata[15:5]) | (lmul_onehot[2] & ~|vs1_rdata[15:6]) | (lmul_onehot[3] & ~|vs1_rdata[15:7]) | (lmul_onehot[5] & ~|vs1_rdata[15:1]) | (lmul_onehot[6] & ~|vs1_rdata[15:2]) | (lmul_onehot[7] & ~|vs1_rdata[15:3]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[15:4]) | (lmul_onehot[1] & ~|vs1_rdata[15:5]) | (lmul_onehot[2] & ~|vs1_rdata[15:6]) | (lmul_onehot[3] & ~|vs1_rdata[15:7]) | (lmul_onehot[5] & ~|vs1_rdata[15:1]) | (lmul_onehot[6] & ~|vs1_rdata[15:2]) | (lmul_onehot[7] & ~|vs1_rdata[15:3]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[31:20]) | (lmul_onehot[1] & ~|vs1_rdata[31:21]) | (lmul_onehot[2] & ~|vs1_rdata[31:22]) | (lmul_onehot[3] & ~|vs1_rdata[31:23]) | (lmul_onehot[5] & ~|vs1_rdata[31:17]) | (lmul_onehot[6] & ~|vs1_rdata[31:18]) | (lmul_onehot[7] & ~|vs1_rdata[31:19]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[31:20]) | (lmul_onehot[1] & ~|vs1_rdata[31:21]) | (lmul_onehot[2] & ~|vs1_rdata[31:22]) | (lmul_onehot[3] & ~|vs1_rdata[31:23]) | (lmul_onehot[5] & ~|vs1_rdata[31:17]) | (lmul_onehot[6] & ~|vs1_rdata[31:18]) | (lmul_onehot[7] & ~|vs1_rdata[31:19]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[31:20]) | (lmul_onehot[1] & ~|vs1_rdata[31:21]) | (lmul_onehot[2] & ~|vs1_rdata[31:22]) | (lmul_onehot[3] & ~|vs1_rdata[31:23]) | (lmul_onehot[5] & ~|vs1_rdata[31:17]) | (lmul_onehot[6] & ~|vs1_rdata[31:18]) | (lmul_onehot[7] & ~|vs1_rdata[31:19]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[31:20]) | (lmul_onehot[1] & ~|vs1_rdata[31:21]) | (lmul_onehot[2] & ~|vs1_rdata[31:22]) | (lmul_onehot[3] & ~|vs1_rdata[31:23]) | (lmul_onehot[5] & ~|vs1_rdata[31:17]) | (lmul_onehot[6] & ~|vs1_rdata[31:18]) | (lmul_onehot[7] & ~|vs1_rdata[31:19]);
    end
endgenerate
generate
    if (VLEN == 512 & SEW == 64) begin:gen_vlen512_sew64
        assign {s8,s0} = {vs1_rdata[3 +:3],vs1_rdata[0 +:3],3'd0};
        assign {s9,s1} = {vs1_rdata[3 +:3],vs1_rdata[0 +:3],3'd1};
        assign {s10,s2} = {vs1_rdata[3 +:3],vs1_rdata[0 +:3],3'd2};
        assign {s11,s3} = {vs1_rdata[3 +:3],vs1_rdata[0 +:3],3'd3};
        assign {s12,s4} = {vs1_rdata[3 +:3],vs1_rdata[0 +:3],3'd4};
        assign {s13,s5} = {vs1_rdata[3 +:3],vs1_rdata[0 +:3],3'd5};
        assign {s14,s6} = {vs1_rdata[3 +:3],vs1_rdata[0 +:3],3'd6};
        assign {s15,s7} = {vs1_rdata[3 +:3],vs1_rdata[0 +:3],3'd7};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:3]) | (lmul_onehot[1] & ~|vs1_rdata[15:4]) | (lmul_onehot[2] & ~|vs1_rdata[15:5]) | (lmul_onehot[3] & ~|vs1_rdata[15:6]) | (lmul_onehot[5] & ~|vs1_rdata[15:0]) | (lmul_onehot[6] & ~|vs1_rdata[15:1]) | (lmul_onehot[7] & ~|vs1_rdata[15:2]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[15:3]) | (lmul_onehot[1] & ~|vs1_rdata[15:4]) | (lmul_onehot[2] & ~|vs1_rdata[15:5]) | (lmul_onehot[3] & ~|vs1_rdata[15:6]) | (lmul_onehot[5] & ~|vs1_rdata[15:0]) | (lmul_onehot[6] & ~|vs1_rdata[15:1]) | (lmul_onehot[7] & ~|vs1_rdata[15:2]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[15:3]) | (lmul_onehot[1] & ~|vs1_rdata[15:4]) | (lmul_onehot[2] & ~|vs1_rdata[15:5]) | (lmul_onehot[3] & ~|vs1_rdata[15:6]) | (lmul_onehot[5] & ~|vs1_rdata[15:0]) | (lmul_onehot[6] & ~|vs1_rdata[15:1]) | (lmul_onehot[7] & ~|vs1_rdata[15:2]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[15:3]) | (lmul_onehot[1] & ~|vs1_rdata[15:4]) | (lmul_onehot[2] & ~|vs1_rdata[15:5]) | (lmul_onehot[3] & ~|vs1_rdata[15:6]) | (lmul_onehot[5] & ~|vs1_rdata[15:0]) | (lmul_onehot[6] & ~|vs1_rdata[15:1]) | (lmul_onehot[7] & ~|vs1_rdata[15:2]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[15:3]) | (lmul_onehot[1] & ~|vs1_rdata[15:4]) | (lmul_onehot[2] & ~|vs1_rdata[15:5]) | (lmul_onehot[3] & ~|vs1_rdata[15:6]) | (lmul_onehot[5] & ~|vs1_rdata[15:0]) | (lmul_onehot[6] & ~|vs1_rdata[15:1]) | (lmul_onehot[7] & ~|vs1_rdata[15:2]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[15:3]) | (lmul_onehot[1] & ~|vs1_rdata[15:4]) | (lmul_onehot[2] & ~|vs1_rdata[15:5]) | (lmul_onehot[3] & ~|vs1_rdata[15:6]) | (lmul_onehot[5] & ~|vs1_rdata[15:0]) | (lmul_onehot[6] & ~|vs1_rdata[15:1]) | (lmul_onehot[7] & ~|vs1_rdata[15:2]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[15:3]) | (lmul_onehot[1] & ~|vs1_rdata[15:4]) | (lmul_onehot[2] & ~|vs1_rdata[15:5]) | (lmul_onehot[3] & ~|vs1_rdata[15:6]) | (lmul_onehot[5] & ~|vs1_rdata[15:0]) | (lmul_onehot[6] & ~|vs1_rdata[15:1]) | (lmul_onehot[7] & ~|vs1_rdata[15:2]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[15:3]) | (lmul_onehot[1] & ~|vs1_rdata[15:4]) | (lmul_onehot[2] & ~|vs1_rdata[15:5]) | (lmul_onehot[3] & ~|vs1_rdata[15:6]) | (lmul_onehot[5] & ~|vs1_rdata[15:0]) | (lmul_onehot[6] & ~|vs1_rdata[15:1]) | (lmul_onehot[7] & ~|vs1_rdata[15:2]);
    end
endgenerate
generate
    if (VLEN == 1024 & SEW == 8) begin:gen_vlen1024_sew8
        assign {s8,s0} = {vs1_rdata[7 +:3],vs1_rdata[0 +:7]};
        assign {s9,s1} = {vs1_rdata[23 +:3],vs1_rdata[16 +:7]};
        assign {s10,s2} = {vs1_rdata[39 +:3],vs1_rdata[32 +:7]};
        assign {s11,s3} = {vs1_rdata[55 +:3],vs1_rdata[48 +:7]};
        assign {s12,s4} = {vs1_rdata[71 +:3],vs1_rdata[64 +:7]};
        assign {s13,s5} = {vs1_rdata[87 +:3],vs1_rdata[80 +:7]};
        assign {s14,s6} = {vs1_rdata[103 +:3],vs1_rdata[96 +:7]};
        assign {s15,s7} = {vs1_rdata[119 +:3],vs1_rdata[112 +:7]};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:7]) | (lmul_onehot[1] & ~|vs1_rdata[15:8]) | (lmul_onehot[2] & ~|vs1_rdata[15:9]) | (lmul_onehot[3] & ~|vs1_rdata[15:10]) | (lmul_onehot[5] & ~|vs1_rdata[15:4]) | (lmul_onehot[6] & ~|vs1_rdata[15:5]) | (lmul_onehot[7] & ~|vs1_rdata[15:6]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[31:23]) | (lmul_onehot[1] & ~|vs1_rdata[31:24]) | (lmul_onehot[2] & ~|vs1_rdata[31:25]) | (lmul_onehot[3] & ~|vs1_rdata[31:26]) | (lmul_onehot[5] & ~|vs1_rdata[31:20]) | (lmul_onehot[6] & ~|vs1_rdata[31:21]) | (lmul_onehot[7] & ~|vs1_rdata[31:22]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[47:39]) | (lmul_onehot[1] & ~|vs1_rdata[47:40]) | (lmul_onehot[2] & ~|vs1_rdata[47:41]) | (lmul_onehot[3] & ~|vs1_rdata[47:42]) | (lmul_onehot[5] & ~|vs1_rdata[47:36]) | (lmul_onehot[6] & ~|vs1_rdata[47:37]) | (lmul_onehot[7] & ~|vs1_rdata[47:38]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[63:55]) | (lmul_onehot[1] & ~|vs1_rdata[63:56]) | (lmul_onehot[2] & ~|vs1_rdata[63:57]) | (lmul_onehot[3] & ~|vs1_rdata[63:58]) | (lmul_onehot[5] & ~|vs1_rdata[63:52]) | (lmul_onehot[6] & ~|vs1_rdata[63:53]) | (lmul_onehot[7] & ~|vs1_rdata[63:54]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[79:71]) | (lmul_onehot[1] & ~|vs1_rdata[79:72]) | (lmul_onehot[2] & ~|vs1_rdata[79:73]) | (lmul_onehot[3] & ~|vs1_rdata[79:74]) | (lmul_onehot[5] & ~|vs1_rdata[79:68]) | (lmul_onehot[6] & ~|vs1_rdata[79:69]) | (lmul_onehot[7] & ~|vs1_rdata[79:70]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[95:87]) | (lmul_onehot[1] & ~|vs1_rdata[95:88]) | (lmul_onehot[2] & ~|vs1_rdata[95:89]) | (lmul_onehot[3] & ~|vs1_rdata[95:90]) | (lmul_onehot[5] & ~|vs1_rdata[95:84]) | (lmul_onehot[6] & ~|vs1_rdata[95:85]) | (lmul_onehot[7] & ~|vs1_rdata[95:86]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[111:103]) | (lmul_onehot[1] & ~|vs1_rdata[111:104]) | (lmul_onehot[2] & ~|vs1_rdata[111:105]) | (lmul_onehot[3] & ~|vs1_rdata[111:106]) | (lmul_onehot[5] & ~|vs1_rdata[111:100]) | (lmul_onehot[6] & ~|vs1_rdata[111:101]) | (lmul_onehot[7] & ~|vs1_rdata[111:102]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[127:119]) | (lmul_onehot[1] & ~|vs1_rdata[127:120]) | (lmul_onehot[2] & ~|vs1_rdata[127:121]) | (lmul_onehot[3] & ~|vs1_rdata[127:122]) | (lmul_onehot[5] & ~|vs1_rdata[127:116]) | (lmul_onehot[6] & ~|vs1_rdata[127:117]) | (lmul_onehot[7] & ~|vs1_rdata[127:118]);
    end
endgenerate
generate
    if (VLEN == 1024 & SEW == 16) begin:gen_vlen1024_sew16
        assign {s8,s0} = {vs1_rdata[6 +:3],vs1_rdata[0 +:6],1'd0};
        assign {s9,s1} = {vs1_rdata[6 +:3],vs1_rdata[0 +:6],1'd1};
        assign {s10,s2} = {vs1_rdata[22 +:3],vs1_rdata[16 +:6],1'd0};
        assign {s11,s3} = {vs1_rdata[22 +:3],vs1_rdata[16 +:6],1'd1};
        assign {s12,s4} = {vs1_rdata[38 +:3],vs1_rdata[32 +:6],1'd0};
        assign {s13,s5} = {vs1_rdata[38 +:3],vs1_rdata[32 +:6],1'd1};
        assign {s14,s6} = {vs1_rdata[54 +:3],vs1_rdata[48 +:6],1'd0};
        assign {s15,s7} = {vs1_rdata[54 +:3],vs1_rdata[48 +:6],1'd1};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:6]) | (lmul_onehot[1] & ~|vs1_rdata[15:7]) | (lmul_onehot[2] & ~|vs1_rdata[15:8]) | (lmul_onehot[3] & ~|vs1_rdata[15:9]) | (lmul_onehot[5] & ~|vs1_rdata[15:3]) | (lmul_onehot[6] & ~|vs1_rdata[15:4]) | (lmul_onehot[7] & ~|vs1_rdata[15:5]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[15:6]) | (lmul_onehot[1] & ~|vs1_rdata[15:7]) | (lmul_onehot[2] & ~|vs1_rdata[15:8]) | (lmul_onehot[3] & ~|vs1_rdata[15:9]) | (lmul_onehot[5] & ~|vs1_rdata[15:3]) | (lmul_onehot[6] & ~|vs1_rdata[15:4]) | (lmul_onehot[7] & ~|vs1_rdata[15:5]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[31:22]) | (lmul_onehot[1] & ~|vs1_rdata[31:23]) | (lmul_onehot[2] & ~|vs1_rdata[31:24]) | (lmul_onehot[3] & ~|vs1_rdata[31:25]) | (lmul_onehot[5] & ~|vs1_rdata[31:19]) | (lmul_onehot[6] & ~|vs1_rdata[31:20]) | (lmul_onehot[7] & ~|vs1_rdata[31:21]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[31:22]) | (lmul_onehot[1] & ~|vs1_rdata[31:23]) | (lmul_onehot[2] & ~|vs1_rdata[31:24]) | (lmul_onehot[3] & ~|vs1_rdata[31:25]) | (lmul_onehot[5] & ~|vs1_rdata[31:19]) | (lmul_onehot[6] & ~|vs1_rdata[31:20]) | (lmul_onehot[7] & ~|vs1_rdata[31:21]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[47:38]) | (lmul_onehot[1] & ~|vs1_rdata[47:39]) | (lmul_onehot[2] & ~|vs1_rdata[47:40]) | (lmul_onehot[3] & ~|vs1_rdata[47:41]) | (lmul_onehot[5] & ~|vs1_rdata[47:35]) | (lmul_onehot[6] & ~|vs1_rdata[47:36]) | (lmul_onehot[7] & ~|vs1_rdata[47:37]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[47:38]) | (lmul_onehot[1] & ~|vs1_rdata[47:39]) | (lmul_onehot[2] & ~|vs1_rdata[47:40]) | (lmul_onehot[3] & ~|vs1_rdata[47:41]) | (lmul_onehot[5] & ~|vs1_rdata[47:35]) | (lmul_onehot[6] & ~|vs1_rdata[47:36]) | (lmul_onehot[7] & ~|vs1_rdata[47:37]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[63:54]) | (lmul_onehot[1] & ~|vs1_rdata[63:55]) | (lmul_onehot[2] & ~|vs1_rdata[63:56]) | (lmul_onehot[3] & ~|vs1_rdata[63:57]) | (lmul_onehot[5] & ~|vs1_rdata[63:51]) | (lmul_onehot[6] & ~|vs1_rdata[63:52]) | (lmul_onehot[7] & ~|vs1_rdata[63:53]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[63:54]) | (lmul_onehot[1] & ~|vs1_rdata[63:55]) | (lmul_onehot[2] & ~|vs1_rdata[63:56]) | (lmul_onehot[3] & ~|vs1_rdata[63:57]) | (lmul_onehot[5] & ~|vs1_rdata[63:51]) | (lmul_onehot[6] & ~|vs1_rdata[63:52]) | (lmul_onehot[7] & ~|vs1_rdata[63:53]);
    end
endgenerate
generate
    if (VLEN == 1024 & SEW == 32) begin:gen_vlen1024_sew32
        assign {s8,s0} = {vs1_rdata[5 +:3],vs1_rdata[0 +:5],2'd0};
        assign {s9,s1} = {vs1_rdata[5 +:3],vs1_rdata[0 +:5],2'd1};
        assign {s10,s2} = {vs1_rdata[5 +:3],vs1_rdata[0 +:5],2'd2};
        assign {s11,s3} = {vs1_rdata[5 +:3],vs1_rdata[0 +:5],2'd3};
        assign {s12,s4} = {vs1_rdata[21 +:3],vs1_rdata[16 +:5],2'd0};
        assign {s13,s5} = {vs1_rdata[21 +:3],vs1_rdata[16 +:5],2'd1};
        assign {s14,s6} = {vs1_rdata[21 +:3],vs1_rdata[16 +:5],2'd2};
        assign {s15,s7} = {vs1_rdata[21 +:3],vs1_rdata[16 +:5],2'd3};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:5]) | (lmul_onehot[1] & ~|vs1_rdata[15:6]) | (lmul_onehot[2] & ~|vs1_rdata[15:7]) | (lmul_onehot[3] & ~|vs1_rdata[15:8]) | (lmul_onehot[5] & ~|vs1_rdata[15:2]) | (lmul_onehot[6] & ~|vs1_rdata[15:3]) | (lmul_onehot[7] & ~|vs1_rdata[15:4]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[15:5]) | (lmul_onehot[1] & ~|vs1_rdata[15:6]) | (lmul_onehot[2] & ~|vs1_rdata[15:7]) | (lmul_onehot[3] & ~|vs1_rdata[15:8]) | (lmul_onehot[5] & ~|vs1_rdata[15:2]) | (lmul_onehot[6] & ~|vs1_rdata[15:3]) | (lmul_onehot[7] & ~|vs1_rdata[15:4]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[15:5]) | (lmul_onehot[1] & ~|vs1_rdata[15:6]) | (lmul_onehot[2] & ~|vs1_rdata[15:7]) | (lmul_onehot[3] & ~|vs1_rdata[15:8]) | (lmul_onehot[5] & ~|vs1_rdata[15:2]) | (lmul_onehot[6] & ~|vs1_rdata[15:3]) | (lmul_onehot[7] & ~|vs1_rdata[15:4]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[15:5]) | (lmul_onehot[1] & ~|vs1_rdata[15:6]) | (lmul_onehot[2] & ~|vs1_rdata[15:7]) | (lmul_onehot[3] & ~|vs1_rdata[15:8]) | (lmul_onehot[5] & ~|vs1_rdata[15:2]) | (lmul_onehot[6] & ~|vs1_rdata[15:3]) | (lmul_onehot[7] & ~|vs1_rdata[15:4]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[31:21]) | (lmul_onehot[1] & ~|vs1_rdata[31:22]) | (lmul_onehot[2] & ~|vs1_rdata[31:23]) | (lmul_onehot[3] & ~|vs1_rdata[31:24]) | (lmul_onehot[5] & ~|vs1_rdata[31:18]) | (lmul_onehot[6] & ~|vs1_rdata[31:19]) | (lmul_onehot[7] & ~|vs1_rdata[31:20]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[31:21]) | (lmul_onehot[1] & ~|vs1_rdata[31:22]) | (lmul_onehot[2] & ~|vs1_rdata[31:23]) | (lmul_onehot[3] & ~|vs1_rdata[31:24]) | (lmul_onehot[5] & ~|vs1_rdata[31:18]) | (lmul_onehot[6] & ~|vs1_rdata[31:19]) | (lmul_onehot[7] & ~|vs1_rdata[31:20]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[31:21]) | (lmul_onehot[1] & ~|vs1_rdata[31:22]) | (lmul_onehot[2] & ~|vs1_rdata[31:23]) | (lmul_onehot[3] & ~|vs1_rdata[31:24]) | (lmul_onehot[5] & ~|vs1_rdata[31:18]) | (lmul_onehot[6] & ~|vs1_rdata[31:19]) | (lmul_onehot[7] & ~|vs1_rdata[31:20]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[31:21]) | (lmul_onehot[1] & ~|vs1_rdata[31:22]) | (lmul_onehot[2] & ~|vs1_rdata[31:23]) | (lmul_onehot[3] & ~|vs1_rdata[31:24]) | (lmul_onehot[5] & ~|vs1_rdata[31:18]) | (lmul_onehot[6] & ~|vs1_rdata[31:19]) | (lmul_onehot[7] & ~|vs1_rdata[31:20]);
    end
endgenerate
generate
    if (VLEN == 1024 & SEW == 64) begin:gen_vlen1024_sew64
        assign {s8,s0} = {vs1_rdata[4 +:3],vs1_rdata[0 +:4],3'd0};
        assign {s9,s1} = {vs1_rdata[4 +:3],vs1_rdata[0 +:4],3'd1};
        assign {s10,s2} = {vs1_rdata[4 +:3],vs1_rdata[0 +:4],3'd2};
        assign {s11,s3} = {vs1_rdata[4 +:3],vs1_rdata[0 +:4],3'd3};
        assign {s12,s4} = {vs1_rdata[4 +:3],vs1_rdata[0 +:4],3'd4};
        assign {s13,s5} = {vs1_rdata[4 +:3],vs1_rdata[0 +:4],3'd5};
        assign {s14,s6} = {vs1_rdata[4 +:3],vs1_rdata[0 +:4],3'd6};
        assign {s15,s7} = {vs1_rdata[4 +:3],vs1_rdata[0 +:4],3'd7};
        assign vrgatherei16_body_mask[0] = (lmul_onehot[0] & ~|vs1_rdata[15:4]) | (lmul_onehot[1] & ~|vs1_rdata[15:5]) | (lmul_onehot[2] & ~|vs1_rdata[15:6]) | (lmul_onehot[3] & ~|vs1_rdata[15:7]) | (lmul_onehot[5] & ~|vs1_rdata[15:1]) | (lmul_onehot[6] & ~|vs1_rdata[15:2]) | (lmul_onehot[7] & ~|vs1_rdata[15:3]);
        assign vrgatherei16_body_mask[1] = (lmul_onehot[0] & ~|vs1_rdata[15:4]) | (lmul_onehot[1] & ~|vs1_rdata[15:5]) | (lmul_onehot[2] & ~|vs1_rdata[15:6]) | (lmul_onehot[3] & ~|vs1_rdata[15:7]) | (lmul_onehot[5] & ~|vs1_rdata[15:1]) | (lmul_onehot[6] & ~|vs1_rdata[15:2]) | (lmul_onehot[7] & ~|vs1_rdata[15:3]);
        assign vrgatherei16_body_mask[2] = (lmul_onehot[0] & ~|vs1_rdata[15:4]) | (lmul_onehot[1] & ~|vs1_rdata[15:5]) | (lmul_onehot[2] & ~|vs1_rdata[15:6]) | (lmul_onehot[3] & ~|vs1_rdata[15:7]) | (lmul_onehot[5] & ~|vs1_rdata[15:1]) | (lmul_onehot[6] & ~|vs1_rdata[15:2]) | (lmul_onehot[7] & ~|vs1_rdata[15:3]);
        assign vrgatherei16_body_mask[3] = (lmul_onehot[0] & ~|vs1_rdata[15:4]) | (lmul_onehot[1] & ~|vs1_rdata[15:5]) | (lmul_onehot[2] & ~|vs1_rdata[15:6]) | (lmul_onehot[3] & ~|vs1_rdata[15:7]) | (lmul_onehot[5] & ~|vs1_rdata[15:1]) | (lmul_onehot[6] & ~|vs1_rdata[15:2]) | (lmul_onehot[7] & ~|vs1_rdata[15:3]);
        assign vrgatherei16_body_mask[4] = (lmul_onehot[0] & ~|vs1_rdata[15:4]) | (lmul_onehot[1] & ~|vs1_rdata[15:5]) | (lmul_onehot[2] & ~|vs1_rdata[15:6]) | (lmul_onehot[3] & ~|vs1_rdata[15:7]) | (lmul_onehot[5] & ~|vs1_rdata[15:1]) | (lmul_onehot[6] & ~|vs1_rdata[15:2]) | (lmul_onehot[7] & ~|vs1_rdata[15:3]);
        assign vrgatherei16_body_mask[5] = (lmul_onehot[0] & ~|vs1_rdata[15:4]) | (lmul_onehot[1] & ~|vs1_rdata[15:5]) | (lmul_onehot[2] & ~|vs1_rdata[15:6]) | (lmul_onehot[3] & ~|vs1_rdata[15:7]) | (lmul_onehot[5] & ~|vs1_rdata[15:1]) | (lmul_onehot[6] & ~|vs1_rdata[15:2]) | (lmul_onehot[7] & ~|vs1_rdata[15:3]);
        assign vrgatherei16_body_mask[6] = (lmul_onehot[0] & ~|vs1_rdata[15:4]) | (lmul_onehot[1] & ~|vs1_rdata[15:5]) | (lmul_onehot[2] & ~|vs1_rdata[15:6]) | (lmul_onehot[3] & ~|vs1_rdata[15:7]) | (lmul_onehot[5] & ~|vs1_rdata[15:1]) | (lmul_onehot[6] & ~|vs1_rdata[15:2]) | (lmul_onehot[7] & ~|vs1_rdata[15:3]);
        assign vrgatherei16_body_mask[7] = (lmul_onehot[0] & ~|vs1_rdata[15:4]) | (lmul_onehot[1] & ~|vs1_rdata[15:5]) | (lmul_onehot[2] & ~|vs1_rdata[15:6]) | (lmul_onehot[3] & ~|vs1_rdata[15:7]) | (lmul_onehot[5] & ~|vs1_rdata[15:1]) | (lmul_onehot[6] & ~|vs1_rdata[15:2]) | (lmul_onehot[7] & ~|vs1_rdata[15:3]);
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

