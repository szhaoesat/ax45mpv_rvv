// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_valu_adder71 (
    sub,
    rev,
    sign,
    ssew,
    src1,
    src1_ori,
    src2,
    src2_ori,
    ci,
    rup,
    ovf,
    neg,
    zero,
    sum,
    uco,
    co
);
input [7:0] sub;
input rev;
input sign;
input [3:0] ssew;
input [63:0] src1;
input [63:0] src1_ori;
input [63:0] src2;
input [63:0] src2_ori;
input [7:0] ci;
input [7:0] rup;
output [7:0] ovf;
output [7:0] neg;
output [7:0] zero;
output [63:0] sum;
output [7:0] uco;
output [7:0] co;





// de08b573 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [6:0] s0;
wire [63:0] s1;
wire [63:0] s2;
wire [63:0] s3;
wire [63:0] s4;
wire [7:0] s5;
wire s6;
wire [1:0] s7;
wire [3:0] s8;
wire [7:0] s9;
wire [7:0] s10;
wire [7:0] s11;
wire [7:0] s12;
wire [3:0] nds_unused_ssew_1hot = ssew;
assign s0[0] = ~ssew[0];
assign s0[1] = |ssew[3:2];
assign s0[2] = ~ssew[0];
assign s0[3] = ssew[3];
assign s0[4] = ~ssew[0];
assign s0[5] = |ssew[3:2];
assign s0[6] = ~ssew[0];
assign s1 = {{64{rev}} ^ src1};
assign s2 = {{64{rev}} ^ src1_ori};
assign s3[7:0] = {8{sub[0]}} ^ src2[7:0];
assign s3[15:8] = {8{sub[1]}} ^ src2[15:8];
assign s3[23:16] = {8{sub[2]}} ^ src2[23:16];
assign s3[31:24] = {8{sub[3]}} ^ src2[31:24];
assign s3[39:32] = {8{sub[4]}} ^ src2[39:32];
assign s3[47:40] = {8{sub[5]}} ^ src2[47:40];
assign s3[55:48] = {8{sub[6]}} ^ src2[55:48];
assign s3[63:56] = {8{sub[7]}} ^ src2[63:56];
assign s4[7:0] = {8{sub[0]}} ^ src2_ori[7:0];
assign s4[15:8] = {8{sub[1]}} ^ src2_ori[15:8];
assign s4[23:16] = {8{sub[2]}} ^ src2_ori[23:16];
assign s4[31:24] = {8{sub[3]}} ^ src2_ori[31:24];
assign s4[39:32] = {8{sub[4]}} ^ src2_ori[39:32];
assign s4[47:40] = {8{sub[5]}} ^ src2_ori[47:40];
assign s4[55:48] = {8{sub[6]}} ^ src2_ori[55:48];
assign s4[63:56] = {8{sub[7]}} ^ src2_ori[63:56];
wire [7:0] s13;
wire [63:0] s14;
wire [63:0] s15;
wire [63:0] s16;
wire [64 - 1:0] s17[0:1];
wire [64 - 1:0] s18[0:1];
wire [7:0] s19;
wire [7:0] s20;
wire [7:0] s21;
wire [7:0] s22;
assign s15[(8 - 1):0] = {6'b0,1'b1,ci[0] ^ (sub[0] | rev)};
assign s15[(8 * 2 - 1):8] = {6'b0,1'b1,ci[1] ^ (sub[1] | rev)} & {8{ssew[0]}};
assign s15[(8 * 3 - 1):8 * 2] = {6'b0,1'b1,ci[2] ^ (sub[2] | rev)} & {8{|ssew[1:0]}};
assign s15[(8 * 4 - 1):8 * 3] = {6'b0,1'b1,ci[3] ^ (sub[3] | rev)} & {8{ssew[0]}};
assign s15[(8 * 5 - 1):8 * 4] = {6'b0,1'b1,ci[4] ^ (sub[4] | rev)} & {8{~ssew[3]}};
assign s15[(8 * 6 - 1):8 * 5] = {6'b0,1'b1,ci[5] ^ (sub[5] | rev)} & {8{ssew[0]}};
assign s15[(8 * 7 - 1):8 * 6] = {6'b0,1'b1,ci[6] ^ (sub[6] | rev)} & {8{|ssew[1:0]}};
assign s15[(8 * 8 - 1):8 * 7] = {6'b0,1'b1,ci[7] ^ (sub[7] | rev)} & {8{ssew[0]}};
assign s16[(8 - 1):0] = {6'b0,1'b0,ci[0] ^ (sub[0] | rev)};
assign s16[(8 * 2 - 1):8] = {6'b0,1'b0,ci[1] ^ (sub[1] | rev)} & {8{ssew[0]}};
assign s16[(8 * 3 - 1):8 * 2] = {6'b0,1'b0,ci[2] ^ (sub[2] | rev)} & {8{|ssew[1:0]}};
assign s16[(8 * 4 - 1):8 * 3] = {6'b0,1'b0,ci[3] ^ (sub[3] | rev)} & {8{ssew[0]}};
assign s16[(8 * 5 - 1):8 * 4] = {6'b0,1'b0,ci[4] ^ (sub[4] | rev)} & {8{~ssew[3]}};
assign s16[(8 * 6 - 1):8 * 5] = {6'b0,1'b0,ci[5] ^ (sub[5] | rev)} & {8{ssew[0]}};
assign s16[(8 * 7 - 1):8 * 6] = {6'b0,1'b0,ci[6] ^ (sub[6] | rev)} & {8{|ssew[1:0]}};
assign s16[(8 * 8 - 1):8 * 7] = {6'b0,1'b0,ci[7] ^ (sub[7] | rev)} & {8{ssew[0]}};
assign {s20,s18[0],s18[1]} = parallel_cmp32_64b_func(s0, s2, s4, s15);
assign {s19,s17[0],s17[1]} = parallel_cmp32_64b_func(s0, s1, s3, s16);
wire [63:0] s23;
wire [63:0] s24;
wire [7:0] s25;
assign s25[0] = rup[0];
assign s25[1] = (rup[0] & ~ssew[0]) | (rup[1] & ssew[0]);
assign s25[2] = (rup[0] & (|ssew[3:2])) | (rup[2] & (|ssew[1:0]));
assign s25[3] = (rup[0] & (|ssew[3:2])) | (rup[2] & ssew[1]) | (rup[3] & ssew[0]);
assign s25[4] = (rup[0] & ssew[3]) | (rup[4] & (|ssew[2:0]));
assign s25[5] = (rup[0] & ssew[3]) | (rup[4] & (|ssew[2:1])) | (rup[5] & ssew[0]);
assign s25[6] = (rup[0] & ssew[3]) | (rup[4] & ssew[2]) | (rup[6] & (|ssew[1:0]));
assign s25[7] = (rup[0] & ssew[3]) | (rup[4] & ssew[2]) | (rup[6] & ssew[1]) | (rup[7] & ssew[0]);
assign s24 = {{8{s25[7]}},{8{s25[6]}},{8{s25[5]}},{8{s25[4]}},{8{s25[3]}},{8{s25[2]}},{8{s25[1]}},{8{s25[0]}}};
assign {s21,s14} = parallel_add_64b_func(s0, s17[0], s17[1]);
assign {s22,s23} = parallel_add_64b_func(s0, s18[0], s18[1]);
assign s11 = (rup & s20) | (~rup & s19);
assign s12 = (s25 & s22) | (~s25 & s21);
assign sum = (s24 & s23) | (~s24 & s14);
assign s13 = s21 ^ s19;
wire [7:0] s26;
wire [7:0] s27;
assign s26 = s11 ^ s12;
assign uco = s11 ^ s12 ^ sub;
assign co = sign ? s27 : uco;
assign s10[0] = ~|s14[(8 * 0) +:8];
assign s10[1] = ~|s14[(8 * 1) +:8];
assign s10[2] = ~|s14[(8 * 2) +:8];
assign s10[3] = ~|s14[(8 * 3) +:8];
assign s10[4] = ~|s14[(8 * 4) +:8];
assign s10[5] = ~|s14[(8 * 5) +:8];
assign s10[6] = ~|s14[(8 * 6) +:8];
assign s10[7] = ~|s14[(8 * 7) +:8];
assign s5[0] = sign ? (s13[0] ^ s14[7]) & ~(src1_ori[7] ^ s4[7]) : (s13[0] ^ sub[0]);
assign s5[1] = sign ? (s13[1] ^ s14[15]) & ~(src1_ori[15] ^ s4[15]) : (s13[1] ^ sub[1]);
assign s5[2] = sign ? (s13[2] ^ s14[23]) & ~(src1_ori[23] ^ s4[23]) : (s13[2] ^ sub[2]);
assign s5[3] = sign ? (s13[3] ^ s14[31]) & ~(src1_ori[31] ^ s4[31]) : (s13[3] ^ sub[3]);
assign s5[4] = sign ? (s13[4] ^ s14[39]) & ~(src1_ori[39] ^ s4[39]) : (s13[4] ^ sub[4]);
assign s5[5] = sign ? (s13[5] ^ s14[47]) & ~(src1_ori[47] ^ s4[47]) : (s13[5] ^ sub[5]);
assign s5[6] = sign ? (s13[6] ^ s14[55]) & ~(src1_ori[55] ^ s4[55]) : (s13[6] ^ sub[6]);
assign s5[7] = sign ? (s13[7] ^ s14[63]) & ~(src1_ori[63] ^ s4[63]) : (s13[7] ^ sub[7]);
assign ovf = s5;
assign s27[0] = (s26[0] ^ s1[7] ^ s3[7]);
assign s27[1] = (s26[1] ^ s1[15] ^ s3[15]);
assign s27[2] = (s26[2] ^ s1[23] ^ s3[23]);
assign s27[3] = (s26[3] ^ s1[31] ^ s3[31]);
assign s27[4] = (s26[4] ^ s1[39] ^ s3[39]);
assign s27[5] = (s26[5] ^ s1[47] ^ s3[47]);
assign s27[6] = (s26[6] ^ s1[55] ^ s3[55]);
assign s27[7] = (s26[7] ^ s1[63] ^ s3[63]);
assign s9[0] = ((src1_ori[7] == src2_ori[7]) & (src1_ori[0 +:7] < src2_ori[0 +:7]));
assign s9[1] = ((src1_ori[15] == src2_ori[15]) & (src1_ori[8 +:7] < src2_ori[8 +:7]));
assign s9[2] = ((src1_ori[23] == src2_ori[23]) & (src1_ori[16 +:7] < src2_ori[16 +:7]));
assign s9[3] = ((src1_ori[31] == src2_ori[31]) & (src1_ori[24 +:7] < src2_ori[24 +:7]));
assign s9[4] = ((src1_ori[39] == src2_ori[39]) & (src1_ori[32 +:7] < src2_ori[32 +:7]));
assign s9[5] = ((src1_ori[47] == src2_ori[47]) & (src1_ori[40 +:7] < src2_ori[40 +:7]));
assign s9[6] = ((src1_ori[55] == src2_ori[55]) & (src1_ori[48 +:7] < src2_ori[48 +:7]));
assign s9[7] = ((src1_ori[63] == src2_ori[63]) & (src1_ori[56 +:7] < src2_ori[56 +:7]));
assign s8[0] = ((src1_ori[15] == src2_ori[15]) & (src1_ori[0 +:15] < src2_ori[0 +:15]));
assign s8[1] = ((src1_ori[31] == src2_ori[31]) & (src1_ori[16 +:15] < src2_ori[16 +:15]));
assign s8[2] = ((src1_ori[47] == src2_ori[47]) & (src1_ori[32 +:15] < src2_ori[32 +:15]));
assign s8[3] = ((src1_ori[63] == src2_ori[63]) & (src1_ori[48 +:15] < src2_ori[48 +:15]));
assign s7[0] = ((src1_ori[31] == src2_ori[31]) & (src1_ori[0 +:31] < src2_ori[0 +:31]));
assign s7[1] = ((src1_ori[63] == src2_ori[63]) & (src1_ori[32 +:31] < src2_ori[32 +:31]));
assign s6 = ((src1_ori[63] == src2_ori[63]) & (src1_ori[62:0] < src2_ori[62:0]));
wire [7:0] s28;
assign s28[0] = (src1_ori[7] & ~src2_ori[7] & sign) | (~src1_ori[7] & src2_ori[7] & ~sign);
assign s28[1] = (src1_ori[15] & ~src2_ori[15] & sign) | (~src1_ori[15] & src2_ori[15] & ~sign);
assign s28[2] = (src1_ori[23] & ~src2_ori[23] & sign) | (~src1_ori[23] & src2_ori[23] & ~sign);
assign s28[3] = (src1_ori[31] & ~src2_ori[31] & sign) | (~src1_ori[31] & src2_ori[31] & ~sign);
assign s28[4] = (src1_ori[39] & ~src2_ori[39] & sign) | (~src1_ori[39] & src2_ori[39] & ~sign);
assign s28[5] = (src1_ori[47] & ~src2_ori[47] & sign) | (~src1_ori[47] & src2_ori[47] & ~sign);
assign s28[6] = (src1_ori[55] & ~src2_ori[55] & sign) | (~src1_ori[55] & src2_ori[55] & ~sign);
assign s28[7] = (src1_ori[63] & ~src2_ori[63] & sign) | (~src1_ori[63] & src2_ori[63] & ~sign);
assign neg[0] = (s28[0] & ssew[0]) | (s9[0] & ssew[0]);
assign neg[1] = (s28[1] & (|ssew[1:0])) | (s8[0] & ssew[1]) | (s9[1] & ssew[0]);
assign neg[2] = (s28[2] & ssew[0]) | (s9[2] & ssew[0]);
assign neg[3] = (s28[3] & (|ssew[2:0])) | (s7[0] & ssew[2]) | (s8[1] & ssew[1]) | (s9[3] & ssew[0]);
assign neg[4] = (s28[4] & ssew[0]) | (s9[4] & ssew[0]);
assign neg[5] = (s28[5] & (|ssew[1:0])) | (s8[2] & ssew[1]) | (s9[5] & ssew[0]);
assign neg[6] = (s28[6] & ssew[0]) | (s9[6] & ssew[0]);
assign neg[7] = s28[7] | (s6 & ssew[3]) | (s7[1] & ssew[2]) | (s8[3] & ssew[1]) | (s9[7] & ssew[0]);
assign zero[0] = s10[0];
assign zero[1] = ((&s10[1:0]) & ssew[1]) | (s10[1] & ssew[0]);
assign zero[2] = s10[2];
assign zero[3] = (s10[3] & ssew[0]) | ((&s10[3:0]) & ssew[2]) | ((&s10[3:2]) & ssew[1]);
assign zero[4] = s10[4];
assign zero[5] = ((&s10[5:4]) & ssew[1]) | (s10[5] & ssew[0]);
assign zero[6] = s10[6];
assign zero[7] = ((&s10) & ssew[3]) | ((&s10[7:4]) & ssew[2]) | ((&s10[7:6]) & ssew[1]) | (s10[7] & ssew[0]);
function  [64 * 2 - 1 + 8:0] parallel_cmp32_64b_func;
input [6:0] chain_byte;
input [64 - 1:0] op0;
input [64 - 1:0] op1;
input [64 - 1:0] op2;
reg [64 - 1:0] s29;
reg [64 - 1:0] s30;
reg [64:0] s31;
reg [64 - 1:0] s32;
reg [7:0] co;
begin
    s30 = op0 ^ op1 ^ op2;
    s29 = (op0 & op1) | (op0 & op2) | (op1 & op2);
    s31 = {s29[64 - 1:0],1'b0};
    s32 = {s31[(8 * 7 + 1) +:7],s31[8 * 7] & chain_byte[6],s31[(8 * 6 + 1) +:7],s31[8 * 6] & chain_byte[5],s31[(8 * 5 + 1) +:7],s31[8 * 5] & chain_byte[4],s31[(8 * 4 + 1) +:7],s31[8 * 4] & chain_byte[3],s31[(8 * 3 + 1) +:7],s31[8 * 3] & chain_byte[2],s31[(8 * 2 + 1) +:7],s31[8 * 2] & chain_byte[1],s31[(8 * 1 + 1) +:7],s31[8 * 1] & chain_byte[0],s31[(8 * 0) +:8]};
    co = {s31[8 * 8],s31[8 * 7],s31[8 * 6],s31[8 * 5],s31[8 * 4],s31[8 * 3],s31[8 * 2],s31[8 * 1]};
    parallel_cmp32_64b_func = {co,s32,s30};
end
endfunction
function  [64 - 1 + 8:0] parallel_add_64b_func;
input [6:0] chain_byte;
input [64 - 1:0] src1;
input [64 - 1:0] src2;
reg [64 + 7:0] op1;
reg [64 + 7:0] op2;
begin
    op1 = {1'b0,src1[(8 * 8 - 1):8 * 7],chain_byte[6],src1[(8 * 7 - 1):8 * 6],chain_byte[5],src1[(8 * 6 - 1):8 * 5],chain_byte[4],src1[(8 * 5 - 1):8 * 4],chain_byte[3],src1[(8 * 4 - 1):8 * 3],chain_byte[2],src1[(8 * 3 - 1):8 * 2],chain_byte[1],src1[(8 * 2 - 1):8],chain_byte[0],src1[(8 - 1):0]};
    op2 = {1'b0,src2[(8 * 8 - 1):8 * 7],1'b0,src2[(8 * 7 - 1):8 * 6],1'b0,src2[(8 * 6 - 1):8 * 5],1'b0,src2[(8 * 5 - 1):8 * 4],1'b0,src2[(8 * 4 - 1):8 * 3],1'b0,src2[(8 * 3 - 1):8 * 2],1'b0,src2[(8 * 2 - 1):8],1'b0,src2[(8 - 1):0]};
    {parallel_add_64b_func[64 + 7],parallel_add_64b_func[(8 * 8 - 1):8 * 7],parallel_add_64b_func[64 + 6],parallel_add_64b_func[(8 * 7 - 1):8 * 6],parallel_add_64b_func[64 + 5],parallel_add_64b_func[(8 * 6 - 1):8 * 5],parallel_add_64b_func[64 + 4],parallel_add_64b_func[(8 * 5 - 1):8 * 4],parallel_add_64b_func[64 + 3],parallel_add_64b_func[(8 * 4 - 1):8 * 3],parallel_add_64b_func[64 + 2],parallel_add_64b_func[(8 * 3 - 1):8 * 2],parallel_add_64b_func[64 + 1],parallel_add_64b_func[(8 * 2 - 1):8],parallel_add_64b_func[64 + 0],parallel_add_64b_func[(8 - 1):0]} = op2_72b_adder(op1, op2);
end
endfunction
function  [71:0] op2_72b_adder;
input [71:0] op1;
input [71:0] op2;
reg nds_unused_sum;
{nds_unused_sum,op2_72b_adder} = op1 + op2;
endfunction
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

