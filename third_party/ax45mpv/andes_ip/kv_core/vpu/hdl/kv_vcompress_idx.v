// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vcompress_idx (
    vpu_vpermut_clk,
    e0c_en,
    e0c_valid,
    e0_mask,
    sew_onehot,
    e0c_dual_mask,
    e0c_sel,
    e0_full,
    e0_part_mask
);
parameter VP_LEN = 128;
localparam VP_MLEN = VP_LEN / 8;
localparam VP_IDX = $unsigned($clog2(VP_MLEN));
input vpu_vpermut_clk;
input e0c_en;
input e0c_valid;
input [VP_MLEN - 1:0] e0_mask;
input [3:0] sew_onehot;
output [2 * VP_MLEN - 1:0] e0c_dual_mask;
output [VP_MLEN * VP_IDX - 1:0] e0c_sel;
output e0_full;
output e0_part_mask;





// a71c6ffd rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [2 * VP_MLEN * VP_IDX:0] e0c_dual_sel;
wire nds_unused_e0c_sel = e0c_dual_sel[2 * VP_MLEN * VP_IDX];
assign e0c_sel = e0c_dual_sel[2 * VP_MLEN * VP_IDX - 1 -:VP_MLEN * VP_IDX] | e0c_dual_sel[VP_MLEN * VP_IDX - 1:0];
generate
    if (VP_LEN == 128) begin:gen_vpermut_dlen128
        wire [4:0] e0_offset_in0;
        wire [4:0] e0c_offset_in0;
        kv_dff_gen #(
            .W(4 + 1)
        ) u_e0c_offset_in (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_in0),
            .q(e0c_offset_in0)
        );
        wire [4:0] e0_csb0;
        wire [4 + 1:0] e0_offset_out0 = e0_csb0 + e0_offset_in0;
        wire nds_unused_e0_offset_out0 = e0_offset_out0[4 + 1];
        wire [4:0] e0_offset_in1 = e0_offset_out0[4:0];
        wire [4:0] e0c_offset_out0;
        wire [32 - 1:0] e0c_shift_mask0;
        wire [32 * 4 - 1:0] e0c_shift_sel0;
        kv_csb #(
            .N(2),
            .W(4 + 1)
        ) u_offset0 (
            .in(e0_mask[1:0]),
            .out(e0_csb0)
        );
        kv_dff_gen #(
            .W(4 + 1)
        ) u_e0c_offset0 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out0[4:0]),
            .q(e0c_offset_out0)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(2),
            .SLICE_NUM(8)
        ) u_slice0 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[1:0]),
            .shift(e0c_offset_in0),
            .idx(3'h0),
            .shift_mask(e0c_shift_mask0),
            .shift_sel(e0c_shift_sel0)
        );
        wire [4:0] e0c_offset_in1 = e0c_offset_out0;
        wire [4:0] e0_csb1;
        wire [4 + 1:0] e0_offset_out1 = e0_csb1 + e0_offset_in1;
        wire nds_unused_e0_offset_out1 = e0_offset_out1[4 + 1];
        wire [4:0] e0_offset_in2 = e0_offset_out1[4:0];
        wire [4:0] e0c_offset_out1;
        wire [32 - 1:0] e0c_shift_mask1;
        wire [32 * 4 - 1:0] e0c_shift_sel1;
        kv_csb #(
            .N(2),
            .W(4 + 1)
        ) u_offset1 (
            .in(e0_mask[3:2]),
            .out(e0_csb1)
        );
        kv_dff_gen #(
            .W(4 + 1)
        ) u_e0c_offset1 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out1[4:0]),
            .q(e0c_offset_out1)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(2),
            .SLICE_NUM(8)
        ) u_slice1 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[3:2]),
            .shift(e0c_offset_in1),
            .idx(3'h1),
            .shift_mask(e0c_shift_mask1),
            .shift_sel(e0c_shift_sel1)
        );
        wire [4:0] e0c_offset_in2 = e0c_offset_out1;
        wire [4:0] e0_csb2;
        wire [4 + 1:0] e0_offset_out2 = e0_csb2 + e0_offset_in2;
        wire nds_unused_e0_offset_out2 = e0_offset_out2[4 + 1];
        wire [4:0] e0_offset_in3 = e0_offset_out2[4:0];
        wire [4:0] e0c_offset_out2;
        wire [32 - 1:0] e0c_shift_mask2;
        wire [32 * 4 - 1:0] e0c_shift_sel2;
        kv_csb #(
            .N(2),
            .W(4 + 1)
        ) u_offset2 (
            .in(e0_mask[5:4]),
            .out(e0_csb2)
        );
        kv_dff_gen #(
            .W(4 + 1)
        ) u_e0c_offset2 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out2[4:0]),
            .q(e0c_offset_out2)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(2),
            .SLICE_NUM(8)
        ) u_slice2 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[5:4]),
            .shift(e0c_offset_in2),
            .idx(3'h2),
            .shift_mask(e0c_shift_mask2),
            .shift_sel(e0c_shift_sel2)
        );
        wire [4:0] e0c_offset_in3 = e0c_offset_out2;
        wire [4:0] e0_csb3;
        wire [4 + 1:0] e0_offset_out3 = e0_csb3 + e0_offset_in3;
        wire nds_unused_e0_offset_out3 = e0_offset_out3[4 + 1];
        wire [4:0] e0_offset_in4 = e0_offset_out3[4:0];
        wire [4:0] e0c_offset_out3;
        wire [32 - 1:0] e0c_shift_mask3;
        wire [32 * 4 - 1:0] e0c_shift_sel3;
        kv_csb #(
            .N(2),
            .W(4 + 1)
        ) u_offset3 (
            .in(e0_mask[7:6]),
            .out(e0_csb3)
        );
        kv_dff_gen #(
            .W(4 + 1)
        ) u_e0c_offset3 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out3[4:0]),
            .q(e0c_offset_out3)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(2),
            .SLICE_NUM(8)
        ) u_slice3 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[7:6]),
            .shift(e0c_offset_in3),
            .idx(3'h3),
            .shift_mask(e0c_shift_mask3),
            .shift_sel(e0c_shift_sel3)
        );
        wire [4:0] e0c_offset_in4 = e0c_offset_out3;
        wire [4:0] e0_csb4;
        wire [4 + 1:0] e0_offset_out4 = e0_csb4 + e0_offset_in4;
        wire nds_unused_e0_offset_out4 = e0_offset_out4[4 + 1];
        wire [4:0] e0_offset_in5 = e0_offset_out4[4:0];
        wire [4:0] e0c_offset_out4;
        wire [32 - 1:0] e0c_shift_mask4;
        wire [32 * 4 - 1:0] e0c_shift_sel4;
        kv_csb #(
            .N(2),
            .W(4 + 1)
        ) u_offset4 (
            .in(e0_mask[9:8]),
            .out(e0_csb4)
        );
        kv_dff_gen #(
            .W(4 + 1)
        ) u_e0c_offset4 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out4[4:0]),
            .q(e0c_offset_out4)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(2),
            .SLICE_NUM(8)
        ) u_slice4 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[9:8]),
            .shift(e0c_offset_in4),
            .idx(3'h4),
            .shift_mask(e0c_shift_mask4),
            .shift_sel(e0c_shift_sel4)
        );
        wire [4:0] e0c_offset_in5 = e0c_offset_out4;
        wire [4:0] e0_csb5;
        wire [4 + 1:0] e0_offset_out5 = e0_csb5 + e0_offset_in5;
        wire nds_unused_e0_offset_out5 = e0_offset_out5[4 + 1];
        wire [4:0] e0_offset_in6 = e0_offset_out5[4:0];
        wire [4:0] e0c_offset_out5;
        wire [32 - 1:0] e0c_shift_mask5;
        wire [32 * 4 - 1:0] e0c_shift_sel5;
        kv_csb #(
            .N(2),
            .W(4 + 1)
        ) u_offset5 (
            .in(e0_mask[11:10]),
            .out(e0_csb5)
        );
        kv_dff_gen #(
            .W(4 + 1)
        ) u_e0c_offset5 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out5[4:0]),
            .q(e0c_offset_out5)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(2),
            .SLICE_NUM(8)
        ) u_slice5 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[11:10]),
            .shift(e0c_offset_in5),
            .idx(3'h5),
            .shift_mask(e0c_shift_mask5),
            .shift_sel(e0c_shift_sel5)
        );
        wire [4:0] e0c_offset_in6 = e0c_offset_out5;
        wire [4:0] e0_csb6;
        wire [4 + 1:0] e0_offset_out6 = e0_csb6 + e0_offset_in6;
        wire nds_unused_e0_offset_out6 = e0_offset_out6[4 + 1];
        wire [4:0] e0_offset_in7 = e0_offset_out6[4:0];
        wire [4:0] e0c_offset_out6;
        wire [32 - 1:0] e0c_shift_mask6;
        wire [32 * 4 - 1:0] e0c_shift_sel6;
        kv_csb #(
            .N(2),
            .W(4 + 1)
        ) u_offset6 (
            .in(e0_mask[13:12]),
            .out(e0_csb6)
        );
        kv_dff_gen #(
            .W(4 + 1)
        ) u_e0c_offset6 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out6[4:0]),
            .q(e0c_offset_out6)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(2),
            .SLICE_NUM(8)
        ) u_slice6 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[13:12]),
            .shift(e0c_offset_in6),
            .idx(3'h6),
            .shift_mask(e0c_shift_mask6),
            .shift_sel(e0c_shift_sel6)
        );
        wire [4:0] e0c_offset_in7 = e0c_offset_out6;
        wire [4:0] e0_csb7;
        wire [4 + 1:0] e0_offset_out7 = e0_csb7 + e0_offset_in7;
        wire nds_unused_e0_offset_out7 = e0_offset_out7[4 + 1];
        wire [4:0] e0_offset_in8 = e0_offset_out7[4:0];
        wire [4:0] e0c_offset_out7;
        wire [32 - 1:0] e0c_shift_mask7;
        wire [32 * 4 - 1:0] e0c_shift_sel7;
        kv_csb #(
            .N(2),
            .W(4 + 1)
        ) u_offset7 (
            .in(e0_mask[15:14]),
            .out(e0_csb7)
        );
        kv_dff_gen #(
            .W(4 + 1)
        ) u_e0c_offset7 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out7[4:0]),
            .q(e0c_offset_out7)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(2),
            .SLICE_NUM(8)
        ) u_slice7 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[15:14]),
            .shift(e0c_offset_in7),
            .idx(3'h7),
            .shift_mask(e0c_shift_mask7),
            .shift_sel(e0c_shift_sel7)
        );
        wire [4:0] e0c_offset_in8 = e0c_offset_out7;
        assign e0_offset_in0 = {4 + 1{e0c_valid}} & (({4'b0,{4 - 3{sew_onehot[3]}}} & e0c_offset_in1[4:0]) | ({3'b0,{4 - 2{sew_onehot[2]}}} & e0c_offset_in2[4:0]) | ({2'b0,{4 - 1{sew_onehot[1]}}} & e0c_offset_in4[4:0]) | ({1'b0,{4 - 0{sew_onehot[0]}}} & e0c_offset_in8[4:0]));
        assign e0_full = (sew_onehot[3] & e0_offset_out0[4 - 3]) | (sew_onehot[2] & e0_offset_out1[4 - 2]) | (sew_onehot[1] & e0_offset_out3[4 - 1]) | (sew_onehot[0] & e0_offset_out7[4]);
        assign e0_part_mask = (sew_onehot[3] & |e0_offset_out0[4 - 4:0]) | (sew_onehot[2] & |e0_offset_out1[4 - 3:0]) | (sew_onehot[1] & |e0_offset_out3[4 - 2:0]) | (sew_onehot[0] & |e0_offset_out7[4 - 1:0]);
        wire [4:0] nds_unused_e0_offset_in8 = e0_offset_in8;
        wire [32 - 1:0] e0c_merge_mask_sew8 = e0c_shift_mask0 | e0c_shift_mask1 | e0c_shift_mask2 | e0c_shift_mask3 | e0c_shift_mask4 | e0c_shift_mask5 | e0c_shift_mask6 | e0c_shift_mask7;
        wire [16 - 1:0] e0c_merge_mask_sew16 = e0c_shift_mask0[16 - 1:0] | e0c_shift_mask1[16 - 1:0] | e0c_shift_mask2[16 - 1:0] | e0c_shift_mask3[16 - 1:0];
        wire [8 - 1:0] e0c_merge_mask_sew32 = e0c_shift_mask0[8 - 1:0] | e0c_shift_mask1[8 - 1:0];
        wire [4 - 1:0] e0c_merge_mask_sew64 = e0c_shift_mask0[4 - 1:0];
        wire [32 - 1:0] e0c_merge_mask_exp16;
        wire [32 - 1:0] e0c_merge_mask_exp32;
        wire [32 - 1:0] e0c_merge_mask_exp64;
        kv_bit_expand #(
            .N(16),
            .M(2)
        ) u_exp16_mask (
            .in(e0c_merge_mask_sew16),
            .out(e0c_merge_mask_exp16)
        );
        kv_bit_expand #(
            .N(8),
            .M(4)
        ) u_exp32_mask (
            .in(e0c_merge_mask_sew32),
            .out(e0c_merge_mask_exp32)
        );
        kv_bit_expand #(
            .N(4),
            .M(8)
        ) u_exp64_mask (
            .in(e0c_merge_mask_sew64),
            .out(e0c_merge_mask_exp64)
        );
        assign e0c_dual_mask = ({32{sew_onehot[0]}} & e0c_merge_mask_sew8) | ({32{sew_onehot[1]}} & e0c_merge_mask_exp16) | ({32{sew_onehot[2]}} & e0c_merge_mask_exp32) | ({32{sew_onehot[3]}} & e0c_merge_mask_exp64);
        wire [32 * 4:0] e0c_merge_sel_sew8 = {1'b0,e0c_shift_sel0 | e0c_shift_sel1 | e0c_shift_sel2 | e0c_shift_sel3 | e0c_shift_sel4 | e0c_shift_sel5 | e0c_shift_sel6 | e0c_shift_sel7};
        wire [16 * 4 - 1:0] e0c_merge_sel_sew16 = e0c_shift_sel0[16 * 4 - 1:0] | e0c_shift_sel1[16 * 4 - 1:0] | e0c_shift_sel2[16 * 4 - 1:0] | e0c_shift_sel3[16 * 4 - 1:0];
        wire [8 * 4 - 1:0] e0c_merge_sel_sew32 = e0c_shift_sel0[8 * 4 - 1:0] | e0c_shift_sel1[8 * 4 - 1:0];
        wire [4 * 4 - 1:0] e0c_merge_sel_sew64 = e0c_shift_sel0[4 * 4 - 1:0];
        wire [32 * 4:0] e0c_exp_sel_sew64 = {1'b0,e0c_merge_sel_sew64[12 +:1],3'h7,e0c_merge_sel_sew64[12 +:1],3'h6,e0c_merge_sel_sew64[12 +:1],3'h5,e0c_merge_sel_sew64[12 +:1],3'h4,e0c_merge_sel_sew64[12 +:1],3'h3,e0c_merge_sel_sew64[12 +:1],3'h2,e0c_merge_sel_sew64[12 +:1],3'h1,e0c_merge_sel_sew64[12 +:1],3'h0,e0c_merge_sel_sew64[8 +:1],3'h7,e0c_merge_sel_sew64[8 +:1],3'h6,e0c_merge_sel_sew64[8 +:1],3'h5,e0c_merge_sel_sew64[8 +:1],3'h4,e0c_merge_sel_sew64[8 +:1],3'h3,e0c_merge_sel_sew64[8 +:1],3'h2,e0c_merge_sel_sew64[8 +:1],3'h1,e0c_merge_sel_sew64[8 +:1],3'h0,e0c_merge_sel_sew64[4 +:1],3'h7,e0c_merge_sel_sew64[4 +:1],3'h6,e0c_merge_sel_sew64[4 +:1],3'h5,e0c_merge_sel_sew64[4 +:1],3'h4,e0c_merge_sel_sew64[4 +:1],3'h3,e0c_merge_sel_sew64[4 +:1],3'h2,e0c_merge_sel_sew64[4 +:1],3'h1,e0c_merge_sel_sew64[4 +:1],3'h0,e0c_merge_sel_sew64[0 +:1],3'h7,e0c_merge_sel_sew64[0 +:1],3'h6,e0c_merge_sel_sew64[0 +:1],3'h5,e0c_merge_sel_sew64[0 +:1],3'h4,e0c_merge_sel_sew64[0 +:1],3'h3,e0c_merge_sel_sew64[0 +:1],3'h2,e0c_merge_sel_sew64[0 +:1],3'h1,e0c_merge_sel_sew64[0 +:1],3'h0};
        wire [32 * 4:0] e0c_exp_sel_sew32 = {1'b0,e0c_merge_sel_sew32[28 +:2],2'h3,e0c_merge_sel_sew32[28 +:2],2'h2,e0c_merge_sel_sew32[28 +:2],2'h1,e0c_merge_sel_sew32[28 +:2],2'h0,e0c_merge_sel_sew32[24 +:2],2'h3,e0c_merge_sel_sew32[24 +:2],2'h2,e0c_merge_sel_sew32[24 +:2],2'h1,e0c_merge_sel_sew32[24 +:2],2'h0,e0c_merge_sel_sew32[20 +:2],2'h3,e0c_merge_sel_sew32[20 +:2],2'h2,e0c_merge_sel_sew32[20 +:2],2'h1,e0c_merge_sel_sew32[20 +:2],2'h0,e0c_merge_sel_sew32[16 +:2],2'h3,e0c_merge_sel_sew32[16 +:2],2'h2,e0c_merge_sel_sew32[16 +:2],2'h1,e0c_merge_sel_sew32[16 +:2],2'h0,e0c_merge_sel_sew32[12 +:2],2'h3,e0c_merge_sel_sew32[12 +:2],2'h2,e0c_merge_sel_sew32[12 +:2],2'h1,e0c_merge_sel_sew32[12 +:2],2'h0,e0c_merge_sel_sew32[8 +:2],2'h3,e0c_merge_sel_sew32[8 +:2],2'h2,e0c_merge_sel_sew32[8 +:2],2'h1,e0c_merge_sel_sew32[8 +:2],2'h0,e0c_merge_sel_sew32[4 +:2],2'h3,e0c_merge_sel_sew32[4 +:2],2'h2,e0c_merge_sel_sew32[4 +:2],2'h1,e0c_merge_sel_sew32[4 +:2],2'h0,e0c_merge_sel_sew32[0 +:2],2'h3,e0c_merge_sel_sew32[0 +:2],2'h2,e0c_merge_sel_sew32[0 +:2],2'h1,e0c_merge_sel_sew32[0 +:2],2'h0};
        wire [32 * 4:0] e0c_exp_sel_sew16 = {1'b0,e0c_merge_sel_sew16[60 +:3],1'h1,e0c_merge_sel_sew16[60 +:3],1'h0,e0c_merge_sel_sew16[56 +:3],1'h1,e0c_merge_sel_sew16[56 +:3],1'h0,e0c_merge_sel_sew16[52 +:3],1'h1,e0c_merge_sel_sew16[52 +:3],1'h0,e0c_merge_sel_sew16[48 +:3],1'h1,e0c_merge_sel_sew16[48 +:3],1'h0,e0c_merge_sel_sew16[44 +:3],1'h1,e0c_merge_sel_sew16[44 +:3],1'h0,e0c_merge_sel_sew16[40 +:3],1'h1,e0c_merge_sel_sew16[40 +:3],1'h0,e0c_merge_sel_sew16[36 +:3],1'h1,e0c_merge_sel_sew16[36 +:3],1'h0,e0c_merge_sel_sew16[32 +:3],1'h1,e0c_merge_sel_sew16[32 +:3],1'h0,e0c_merge_sel_sew16[28 +:3],1'h1,e0c_merge_sel_sew16[28 +:3],1'h0,e0c_merge_sel_sew16[24 +:3],1'h1,e0c_merge_sel_sew16[24 +:3],1'h0,e0c_merge_sel_sew16[20 +:3],1'h1,e0c_merge_sel_sew16[20 +:3],1'h0,e0c_merge_sel_sew16[16 +:3],1'h1,e0c_merge_sel_sew16[16 +:3],1'h0,e0c_merge_sel_sew16[12 +:3],1'h1,e0c_merge_sel_sew16[12 +:3],1'h0,e0c_merge_sel_sew16[8 +:3],1'h1,e0c_merge_sel_sew16[8 +:3],1'h0,e0c_merge_sel_sew16[4 +:3],1'h1,e0c_merge_sel_sew16[4 +:3],1'h0,e0c_merge_sel_sew16[0 +:3],1'h1,e0c_merge_sel_sew16[0 +:3],1'h0};
        assign e0c_dual_sel = ({32 * 4 + 1{sew_onehot[0]}} & e0c_merge_sel_sew8) | ({32 * 4 + 1{sew_onehot[1]}} & e0c_exp_sel_sew16) | ({32 * 4 + 1{sew_onehot[2]}} & e0c_exp_sel_sew32) | ({32 * 4 + 1{sew_onehot[3]}} & e0c_exp_sel_sew64);
    end
endgenerate
generate
    if (VP_LEN == 256) begin:gen_vpermut_dlen256
        wire [5:0] e0_offset_in0;
        wire [5:0] e0c_offset_in0;
        kv_dff_gen #(
            .W(5 + 1)
        ) u_e0c_offset_in (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_in0),
            .q(e0c_offset_in0)
        );
        wire [5:0] e0_csb0;
        wire [5 + 1:0] e0_offset_out0 = e0_csb0 + e0_offset_in0;
        wire nds_unused_e0_offset_out0 = e0_offset_out0[5 + 1];
        wire [5:0] e0_offset_in1 = e0_offset_out0[5:0];
        wire [5:0] e0c_offset_out0;
        wire [64 - 1:0] e0c_shift_mask0;
        wire [64 * 5 - 1:0] e0c_shift_sel0;
        kv_csb #(
            .N(4),
            .W(5 + 1)
        ) u_offset0 (
            .in(e0_mask[3:0]),
            .out(e0_csb0)
        );
        kv_dff_gen #(
            .W(5 + 1)
        ) u_e0c_offset0 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out0[5:0]),
            .q(e0c_offset_out0)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(4),
            .SLICE_NUM(8)
        ) u_slice0 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[3:0]),
            .shift(e0c_offset_in0),
            .idx(3'h0),
            .shift_mask(e0c_shift_mask0),
            .shift_sel(e0c_shift_sel0)
        );
        wire [5:0] e0c_offset_in1 = e0c_offset_out0;
        wire [5:0] e0_csb1;
        wire [5 + 1:0] e0_offset_out1 = e0_csb1 + e0_offset_in1;
        wire nds_unused_e0_offset_out1 = e0_offset_out1[5 + 1];
        wire [5:0] e0_offset_in2 = e0_offset_out1[5:0];
        wire [5:0] e0c_offset_out1;
        wire [64 - 1:0] e0c_shift_mask1;
        wire [64 * 5 - 1:0] e0c_shift_sel1;
        kv_csb #(
            .N(4),
            .W(5 + 1)
        ) u_offset1 (
            .in(e0_mask[7:4]),
            .out(e0_csb1)
        );
        kv_dff_gen #(
            .W(5 + 1)
        ) u_e0c_offset1 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out1[5:0]),
            .q(e0c_offset_out1)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(4),
            .SLICE_NUM(8)
        ) u_slice1 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[7:4]),
            .shift(e0c_offset_in1),
            .idx(3'h1),
            .shift_mask(e0c_shift_mask1),
            .shift_sel(e0c_shift_sel1)
        );
        wire [5:0] e0c_offset_in2 = e0c_offset_out1;
        wire [5:0] e0_csb2;
        wire [5 + 1:0] e0_offset_out2 = e0_csb2 + e0_offset_in2;
        wire nds_unused_e0_offset_out2 = e0_offset_out2[5 + 1];
        wire [5:0] e0_offset_in3 = e0_offset_out2[5:0];
        wire [5:0] e0c_offset_out2;
        wire [64 - 1:0] e0c_shift_mask2;
        wire [64 * 5 - 1:0] e0c_shift_sel2;
        kv_csb #(
            .N(4),
            .W(5 + 1)
        ) u_offset2 (
            .in(e0_mask[11:8]),
            .out(e0_csb2)
        );
        kv_dff_gen #(
            .W(5 + 1)
        ) u_e0c_offset2 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out2[5:0]),
            .q(e0c_offset_out2)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(4),
            .SLICE_NUM(8)
        ) u_slice2 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[11:8]),
            .shift(e0c_offset_in2),
            .idx(3'h2),
            .shift_mask(e0c_shift_mask2),
            .shift_sel(e0c_shift_sel2)
        );
        wire [5:0] e0c_offset_in3 = e0c_offset_out2;
        wire [5:0] e0_csb3;
        wire [5 + 1:0] e0_offset_out3 = e0_csb3 + e0_offset_in3;
        wire nds_unused_e0_offset_out3 = e0_offset_out3[5 + 1];
        wire [5:0] e0_offset_in4 = e0_offset_out3[5:0];
        wire [5:0] e0c_offset_out3;
        wire [64 - 1:0] e0c_shift_mask3;
        wire [64 * 5 - 1:0] e0c_shift_sel3;
        kv_csb #(
            .N(4),
            .W(5 + 1)
        ) u_offset3 (
            .in(e0_mask[15:12]),
            .out(e0_csb3)
        );
        kv_dff_gen #(
            .W(5 + 1)
        ) u_e0c_offset3 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out3[5:0]),
            .q(e0c_offset_out3)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(4),
            .SLICE_NUM(8)
        ) u_slice3 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[15:12]),
            .shift(e0c_offset_in3),
            .idx(3'h3),
            .shift_mask(e0c_shift_mask3),
            .shift_sel(e0c_shift_sel3)
        );
        wire [5:0] e0c_offset_in4 = e0c_offset_out3;
        wire [5:0] e0_csb4;
        wire [5 + 1:0] e0_offset_out4 = e0_csb4 + e0_offset_in4;
        wire nds_unused_e0_offset_out4 = e0_offset_out4[5 + 1];
        wire [5:0] e0_offset_in5 = e0_offset_out4[5:0];
        wire [5:0] e0c_offset_out4;
        wire [64 - 1:0] e0c_shift_mask4;
        wire [64 * 5 - 1:0] e0c_shift_sel4;
        kv_csb #(
            .N(4),
            .W(5 + 1)
        ) u_offset4 (
            .in(e0_mask[19:16]),
            .out(e0_csb4)
        );
        kv_dff_gen #(
            .W(5 + 1)
        ) u_e0c_offset4 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out4[5:0]),
            .q(e0c_offset_out4)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(4),
            .SLICE_NUM(8)
        ) u_slice4 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[19:16]),
            .shift(e0c_offset_in4),
            .idx(3'h4),
            .shift_mask(e0c_shift_mask4),
            .shift_sel(e0c_shift_sel4)
        );
        wire [5:0] e0c_offset_in5 = e0c_offset_out4;
        wire [5:0] e0_csb5;
        wire [5 + 1:0] e0_offset_out5 = e0_csb5 + e0_offset_in5;
        wire nds_unused_e0_offset_out5 = e0_offset_out5[5 + 1];
        wire [5:0] e0_offset_in6 = e0_offset_out5[5:0];
        wire [5:0] e0c_offset_out5;
        wire [64 - 1:0] e0c_shift_mask5;
        wire [64 * 5 - 1:0] e0c_shift_sel5;
        kv_csb #(
            .N(4),
            .W(5 + 1)
        ) u_offset5 (
            .in(e0_mask[23:20]),
            .out(e0_csb5)
        );
        kv_dff_gen #(
            .W(5 + 1)
        ) u_e0c_offset5 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out5[5:0]),
            .q(e0c_offset_out5)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(4),
            .SLICE_NUM(8)
        ) u_slice5 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[23:20]),
            .shift(e0c_offset_in5),
            .idx(3'h5),
            .shift_mask(e0c_shift_mask5),
            .shift_sel(e0c_shift_sel5)
        );
        wire [5:0] e0c_offset_in6 = e0c_offset_out5;
        wire [5:0] e0_csb6;
        wire [5 + 1:0] e0_offset_out6 = e0_csb6 + e0_offset_in6;
        wire nds_unused_e0_offset_out6 = e0_offset_out6[5 + 1];
        wire [5:0] e0_offset_in7 = e0_offset_out6[5:0];
        wire [5:0] e0c_offset_out6;
        wire [64 - 1:0] e0c_shift_mask6;
        wire [64 * 5 - 1:0] e0c_shift_sel6;
        kv_csb #(
            .N(4),
            .W(5 + 1)
        ) u_offset6 (
            .in(e0_mask[27:24]),
            .out(e0_csb6)
        );
        kv_dff_gen #(
            .W(5 + 1)
        ) u_e0c_offset6 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out6[5:0]),
            .q(e0c_offset_out6)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(4),
            .SLICE_NUM(8)
        ) u_slice6 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[27:24]),
            .shift(e0c_offset_in6),
            .idx(3'h6),
            .shift_mask(e0c_shift_mask6),
            .shift_sel(e0c_shift_sel6)
        );
        wire [5:0] e0c_offset_in7 = e0c_offset_out6;
        wire [5:0] e0_csb7;
        wire [5 + 1:0] e0_offset_out7 = e0_csb7 + e0_offset_in7;
        wire nds_unused_e0_offset_out7 = e0_offset_out7[5 + 1];
        wire [5:0] e0_offset_in8 = e0_offset_out7[5:0];
        wire [5:0] e0c_offset_out7;
        wire [64 - 1:0] e0c_shift_mask7;
        wire [64 * 5 - 1:0] e0c_shift_sel7;
        kv_csb #(
            .N(4),
            .W(5 + 1)
        ) u_offset7 (
            .in(e0_mask[31:28]),
            .out(e0_csb7)
        );
        kv_dff_gen #(
            .W(5 + 1)
        ) u_e0c_offset7 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out7[5:0]),
            .q(e0c_offset_out7)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(4),
            .SLICE_NUM(8)
        ) u_slice7 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[31:28]),
            .shift(e0c_offset_in7),
            .idx(3'h7),
            .shift_mask(e0c_shift_mask7),
            .shift_sel(e0c_shift_sel7)
        );
        wire [5:0] e0c_offset_in8 = e0c_offset_out7;
        assign e0_offset_in0 = {5 + 1{e0c_valid}} & (({4'b0,{5 - 3{sew_onehot[3]}}} & e0c_offset_in1[5:0]) | ({3'b0,{5 - 2{sew_onehot[2]}}} & e0c_offset_in2[5:0]) | ({2'b0,{5 - 1{sew_onehot[1]}}} & e0c_offset_in4[5:0]) | ({1'b0,{5 - 0{sew_onehot[0]}}} & e0c_offset_in8[5:0]));
        assign e0_full = (sew_onehot[3] & e0_offset_out0[5 - 3]) | (sew_onehot[2] & e0_offset_out1[5 - 2]) | (sew_onehot[1] & e0_offset_out3[5 - 1]) | (sew_onehot[0] & e0_offset_out7[5]);
        assign e0_part_mask = (sew_onehot[3] & |e0_offset_out0[5 - 4:0]) | (sew_onehot[2] & |e0_offset_out1[5 - 3:0]) | (sew_onehot[1] & |e0_offset_out3[5 - 2:0]) | (sew_onehot[0] & |e0_offset_out7[5 - 1:0]);
        wire [5:0] nds_unused_e0_offset_in8 = e0_offset_in8;
        wire [64 - 1:0] e0c_merge_mask_sew8 = e0c_shift_mask0 | e0c_shift_mask1 | e0c_shift_mask2 | e0c_shift_mask3 | e0c_shift_mask4 | e0c_shift_mask5 | e0c_shift_mask6 | e0c_shift_mask7;
        wire [32 - 1:0] e0c_merge_mask_sew16 = e0c_shift_mask0[32 - 1:0] | e0c_shift_mask1[32 - 1:0] | e0c_shift_mask2[32 - 1:0] | e0c_shift_mask3[32 - 1:0];
        wire [16 - 1:0] e0c_merge_mask_sew32 = e0c_shift_mask0[16 - 1:0] | e0c_shift_mask1[16 - 1:0];
        wire [8 - 1:0] e0c_merge_mask_sew64 = e0c_shift_mask0[8 - 1:0];
        wire [64 - 1:0] e0c_merge_mask_exp16;
        wire [64 - 1:0] e0c_merge_mask_exp32;
        wire [64 - 1:0] e0c_merge_mask_exp64;
        kv_bit_expand #(
            .N(32),
            .M(2)
        ) u_exp16_mask (
            .in(e0c_merge_mask_sew16),
            .out(e0c_merge_mask_exp16)
        );
        kv_bit_expand #(
            .N(16),
            .M(4)
        ) u_exp32_mask (
            .in(e0c_merge_mask_sew32),
            .out(e0c_merge_mask_exp32)
        );
        kv_bit_expand #(
            .N(8),
            .M(8)
        ) u_exp64_mask (
            .in(e0c_merge_mask_sew64),
            .out(e0c_merge_mask_exp64)
        );
        assign e0c_dual_mask = ({64{sew_onehot[0]}} & e0c_merge_mask_sew8) | ({64{sew_onehot[1]}} & e0c_merge_mask_exp16) | ({64{sew_onehot[2]}} & e0c_merge_mask_exp32) | ({64{sew_onehot[3]}} & e0c_merge_mask_exp64);
        wire [64 * 5:0] e0c_merge_sel_sew8 = {1'b0,e0c_shift_sel0 | e0c_shift_sel1 | e0c_shift_sel2 | e0c_shift_sel3 | e0c_shift_sel4 | e0c_shift_sel5 | e0c_shift_sel6 | e0c_shift_sel7};
        wire [32 * 5 - 1:0] e0c_merge_sel_sew16 = e0c_shift_sel0[32 * 5 - 1:0] | e0c_shift_sel1[32 * 5 - 1:0] | e0c_shift_sel2[32 * 5 - 1:0] | e0c_shift_sel3[32 * 5 - 1:0];
        wire [16 * 5 - 1:0] e0c_merge_sel_sew32 = e0c_shift_sel0[16 * 5 - 1:0] | e0c_shift_sel1[16 * 5 - 1:0];
        wire [8 * 5 - 1:0] e0c_merge_sel_sew64 = e0c_shift_sel0[8 * 5 - 1:0];
        wire [64 * 5:0] e0c_exp_sel_sew64 = {1'b0,e0c_merge_sel_sew64[35 +:2],3'h7,e0c_merge_sel_sew64[35 +:2],3'h6,e0c_merge_sel_sew64[35 +:2],3'h5,e0c_merge_sel_sew64[35 +:2],3'h4,e0c_merge_sel_sew64[35 +:2],3'h3,e0c_merge_sel_sew64[35 +:2],3'h2,e0c_merge_sel_sew64[35 +:2],3'h1,e0c_merge_sel_sew64[35 +:2],3'h0,e0c_merge_sel_sew64[30 +:2],3'h7,e0c_merge_sel_sew64[30 +:2],3'h6,e0c_merge_sel_sew64[30 +:2],3'h5,e0c_merge_sel_sew64[30 +:2],3'h4,e0c_merge_sel_sew64[30 +:2],3'h3,e0c_merge_sel_sew64[30 +:2],3'h2,e0c_merge_sel_sew64[30 +:2],3'h1,e0c_merge_sel_sew64[30 +:2],3'h0,e0c_merge_sel_sew64[25 +:2],3'h7,e0c_merge_sel_sew64[25 +:2],3'h6,e0c_merge_sel_sew64[25 +:2],3'h5,e0c_merge_sel_sew64[25 +:2],3'h4,e0c_merge_sel_sew64[25 +:2],3'h3,e0c_merge_sel_sew64[25 +:2],3'h2,e0c_merge_sel_sew64[25 +:2],3'h1,e0c_merge_sel_sew64[25 +:2],3'h0,e0c_merge_sel_sew64[20 +:2],3'h7,e0c_merge_sel_sew64[20 +:2],3'h6,e0c_merge_sel_sew64[20 +:2],3'h5,e0c_merge_sel_sew64[20 +:2],3'h4,e0c_merge_sel_sew64[20 +:2],3'h3,e0c_merge_sel_sew64[20 +:2],3'h2,e0c_merge_sel_sew64[20 +:2],3'h1,e0c_merge_sel_sew64[20 +:2],3'h0,e0c_merge_sel_sew64[15 +:2],3'h7,e0c_merge_sel_sew64[15 +:2],3'h6,e0c_merge_sel_sew64[15 +:2],3'h5,e0c_merge_sel_sew64[15 +:2],3'h4,e0c_merge_sel_sew64[15 +:2],3'h3,e0c_merge_sel_sew64[15 +:2],3'h2,e0c_merge_sel_sew64[15 +:2],3'h1,e0c_merge_sel_sew64[15 +:2],3'h0,e0c_merge_sel_sew64[10 +:2],3'h7,e0c_merge_sel_sew64[10 +:2],3'h6,e0c_merge_sel_sew64[10 +:2],3'h5,e0c_merge_sel_sew64[10 +:2],3'h4,e0c_merge_sel_sew64[10 +:2],3'h3,e0c_merge_sel_sew64[10 +:2],3'h2,e0c_merge_sel_sew64[10 +:2],3'h1,e0c_merge_sel_sew64[10 +:2],3'h0,e0c_merge_sel_sew64[5 +:2],3'h7,e0c_merge_sel_sew64[5 +:2],3'h6,e0c_merge_sel_sew64[5 +:2],3'h5,e0c_merge_sel_sew64[5 +:2],3'h4,e0c_merge_sel_sew64[5 +:2],3'h3,e0c_merge_sel_sew64[5 +:2],3'h2,e0c_merge_sel_sew64[5 +:2],3'h1,e0c_merge_sel_sew64[5 +:2],3'h0,e0c_merge_sel_sew64[0 +:2],3'h7,e0c_merge_sel_sew64[0 +:2],3'h6,e0c_merge_sel_sew64[0 +:2],3'h5,e0c_merge_sel_sew64[0 +:2],3'h4,e0c_merge_sel_sew64[0 +:2],3'h3,e0c_merge_sel_sew64[0 +:2],3'h2,e0c_merge_sel_sew64[0 +:2],3'h1,e0c_merge_sel_sew64[0 +:2],3'h0};
        wire [64 * 5:0] e0c_exp_sel_sew32 = {1'b0,e0c_merge_sel_sew32[75 +:3],2'h3,e0c_merge_sel_sew32[75 +:3],2'h2,e0c_merge_sel_sew32[75 +:3],2'h1,e0c_merge_sel_sew32[75 +:3],2'h0,e0c_merge_sel_sew32[70 +:3],2'h3,e0c_merge_sel_sew32[70 +:3],2'h2,e0c_merge_sel_sew32[70 +:3],2'h1,e0c_merge_sel_sew32[70 +:3],2'h0,e0c_merge_sel_sew32[65 +:3],2'h3,e0c_merge_sel_sew32[65 +:3],2'h2,e0c_merge_sel_sew32[65 +:3],2'h1,e0c_merge_sel_sew32[65 +:3],2'h0,e0c_merge_sel_sew32[60 +:3],2'h3,e0c_merge_sel_sew32[60 +:3],2'h2,e0c_merge_sel_sew32[60 +:3],2'h1,e0c_merge_sel_sew32[60 +:3],2'h0,e0c_merge_sel_sew32[55 +:3],2'h3,e0c_merge_sel_sew32[55 +:3],2'h2,e0c_merge_sel_sew32[55 +:3],2'h1,e0c_merge_sel_sew32[55 +:3],2'h0,e0c_merge_sel_sew32[50 +:3],2'h3,e0c_merge_sel_sew32[50 +:3],2'h2,e0c_merge_sel_sew32[50 +:3],2'h1,e0c_merge_sel_sew32[50 +:3],2'h0,e0c_merge_sel_sew32[45 +:3],2'h3,e0c_merge_sel_sew32[45 +:3],2'h2,e0c_merge_sel_sew32[45 +:3],2'h1,e0c_merge_sel_sew32[45 +:3],2'h0,e0c_merge_sel_sew32[40 +:3],2'h3,e0c_merge_sel_sew32[40 +:3],2'h2,e0c_merge_sel_sew32[40 +:3],2'h1,e0c_merge_sel_sew32[40 +:3],2'h0,e0c_merge_sel_sew32[35 +:3],2'h3,e0c_merge_sel_sew32[35 +:3],2'h2,e0c_merge_sel_sew32[35 +:3],2'h1,e0c_merge_sel_sew32[35 +:3],2'h0,e0c_merge_sel_sew32[30 +:3],2'h3,e0c_merge_sel_sew32[30 +:3],2'h2,e0c_merge_sel_sew32[30 +:3],2'h1,e0c_merge_sel_sew32[30 +:3],2'h0,e0c_merge_sel_sew32[25 +:3],2'h3,e0c_merge_sel_sew32[25 +:3],2'h2,e0c_merge_sel_sew32[25 +:3],2'h1,e0c_merge_sel_sew32[25 +:3],2'h0,e0c_merge_sel_sew32[20 +:3],2'h3,e0c_merge_sel_sew32[20 +:3],2'h2,e0c_merge_sel_sew32[20 +:3],2'h1,e0c_merge_sel_sew32[20 +:3],2'h0,e0c_merge_sel_sew32[15 +:3],2'h3,e0c_merge_sel_sew32[15 +:3],2'h2,e0c_merge_sel_sew32[15 +:3],2'h1,e0c_merge_sel_sew32[15 +:3],2'h0,e0c_merge_sel_sew32[10 +:3],2'h3,e0c_merge_sel_sew32[10 +:3],2'h2,e0c_merge_sel_sew32[10 +:3],2'h1,e0c_merge_sel_sew32[10 +:3],2'h0,e0c_merge_sel_sew32[5 +:3],2'h3,e0c_merge_sel_sew32[5 +:3],2'h2,e0c_merge_sel_sew32[5 +:3],2'h1,e0c_merge_sel_sew32[5 +:3],2'h0,e0c_merge_sel_sew32[0 +:3],2'h3,e0c_merge_sel_sew32[0 +:3],2'h2,e0c_merge_sel_sew32[0 +:3],2'h1,e0c_merge_sel_sew32[0 +:3],2'h0};
        wire [64 * 5:0] e0c_exp_sel_sew16 = {1'b0,e0c_merge_sel_sew16[155 +:4],1'h1,e0c_merge_sel_sew16[155 +:4],1'h0,e0c_merge_sel_sew16[150 +:4],1'h1,e0c_merge_sel_sew16[150 +:4],1'h0,e0c_merge_sel_sew16[145 +:4],1'h1,e0c_merge_sel_sew16[145 +:4],1'h0,e0c_merge_sel_sew16[140 +:4],1'h1,e0c_merge_sel_sew16[140 +:4],1'h0,e0c_merge_sel_sew16[135 +:4],1'h1,e0c_merge_sel_sew16[135 +:4],1'h0,e0c_merge_sel_sew16[130 +:4],1'h1,e0c_merge_sel_sew16[130 +:4],1'h0,e0c_merge_sel_sew16[125 +:4],1'h1,e0c_merge_sel_sew16[125 +:4],1'h0,e0c_merge_sel_sew16[120 +:4],1'h1,e0c_merge_sel_sew16[120 +:4],1'h0,e0c_merge_sel_sew16[115 +:4],1'h1,e0c_merge_sel_sew16[115 +:4],1'h0,e0c_merge_sel_sew16[110 +:4],1'h1,e0c_merge_sel_sew16[110 +:4],1'h0,e0c_merge_sel_sew16[105 +:4],1'h1,e0c_merge_sel_sew16[105 +:4],1'h0,e0c_merge_sel_sew16[100 +:4],1'h1,e0c_merge_sel_sew16[100 +:4],1'h0,e0c_merge_sel_sew16[95 +:4],1'h1,e0c_merge_sel_sew16[95 +:4],1'h0,e0c_merge_sel_sew16[90 +:4],1'h1,e0c_merge_sel_sew16[90 +:4],1'h0,e0c_merge_sel_sew16[85 +:4],1'h1,e0c_merge_sel_sew16[85 +:4],1'h0,e0c_merge_sel_sew16[80 +:4],1'h1,e0c_merge_sel_sew16[80 +:4],1'h0,e0c_merge_sel_sew16[75 +:4],1'h1,e0c_merge_sel_sew16[75 +:4],1'h0,e0c_merge_sel_sew16[70 +:4],1'h1,e0c_merge_sel_sew16[70 +:4],1'h0,e0c_merge_sel_sew16[65 +:4],1'h1,e0c_merge_sel_sew16[65 +:4],1'h0,e0c_merge_sel_sew16[60 +:4],1'h1,e0c_merge_sel_sew16[60 +:4],1'h0,e0c_merge_sel_sew16[55 +:4],1'h1,e0c_merge_sel_sew16[55 +:4],1'h0,e0c_merge_sel_sew16[50 +:4],1'h1,e0c_merge_sel_sew16[50 +:4],1'h0,e0c_merge_sel_sew16[45 +:4],1'h1,e0c_merge_sel_sew16[45 +:4],1'h0,e0c_merge_sel_sew16[40 +:4],1'h1,e0c_merge_sel_sew16[40 +:4],1'h0,e0c_merge_sel_sew16[35 +:4],1'h1,e0c_merge_sel_sew16[35 +:4],1'h0,e0c_merge_sel_sew16[30 +:4],1'h1,e0c_merge_sel_sew16[30 +:4],1'h0,e0c_merge_sel_sew16[25 +:4],1'h1,e0c_merge_sel_sew16[25 +:4],1'h0,e0c_merge_sel_sew16[20 +:4],1'h1,e0c_merge_sel_sew16[20 +:4],1'h0,e0c_merge_sel_sew16[15 +:4],1'h1,e0c_merge_sel_sew16[15 +:4],1'h0,e0c_merge_sel_sew16[10 +:4],1'h1,e0c_merge_sel_sew16[10 +:4],1'h0,e0c_merge_sel_sew16[5 +:4],1'h1,e0c_merge_sel_sew16[5 +:4],1'h0,e0c_merge_sel_sew16[0 +:4],1'h1,e0c_merge_sel_sew16[0 +:4],1'h0};
        assign e0c_dual_sel = ({64 * 5 + 1{sew_onehot[0]}} & e0c_merge_sel_sew8) | ({64 * 5 + 1{sew_onehot[1]}} & e0c_exp_sel_sew16) | ({64 * 5 + 1{sew_onehot[2]}} & e0c_exp_sel_sew32) | ({64 * 5 + 1{sew_onehot[3]}} & e0c_exp_sel_sew64);
    end
endgenerate
generate
    if (VP_LEN == 512) begin:gen_vpermut_dlen512
        wire [6:0] e0_offset_in0;
        wire [6:0] e0c_offset_in0;
        kv_dff_gen #(
            .W(6 + 1)
        ) u_e0c_offset_in (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_in0),
            .q(e0c_offset_in0)
        );
        wire [6:0] e0_csb0;
        wire [6 + 1:0] e0_offset_out0 = e0_csb0 + e0_offset_in0;
        wire nds_unused_e0_offset_out0 = e0_offset_out0[6 + 1];
        wire [6:0] e0_offset_in1 = e0_offset_out0[6:0];
        wire [6:0] e0c_offset_out0;
        wire [128 - 1:0] e0c_shift_mask0;
        wire [128 * 6 - 1:0] e0c_shift_sel0;
        kv_csb #(
            .N(8),
            .W(6 + 1)
        ) u_offset0 (
            .in(e0_mask[7:0]),
            .out(e0_csb0)
        );
        kv_dff_gen #(
            .W(6 + 1)
        ) u_e0c_offset0 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out0[6:0]),
            .q(e0c_offset_out0)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(8),
            .SLICE_NUM(8)
        ) u_slice0 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[7:0]),
            .shift(e0c_offset_in0),
            .idx(3'h0),
            .shift_mask(e0c_shift_mask0),
            .shift_sel(e0c_shift_sel0)
        );
        wire [6:0] e0c_offset_in1 = e0c_offset_out0;
        wire [6:0] e0_csb1;
        wire [6 + 1:0] e0_offset_out1 = e0_csb1 + e0_offset_in1;
        wire nds_unused_e0_offset_out1 = e0_offset_out1[6 + 1];
        wire [6:0] e0_offset_in2 = e0_offset_out1[6:0];
        wire [6:0] e0c_offset_out1;
        wire [128 - 1:0] e0c_shift_mask1;
        wire [128 * 6 - 1:0] e0c_shift_sel1;
        kv_csb #(
            .N(8),
            .W(6 + 1)
        ) u_offset1 (
            .in(e0_mask[15:8]),
            .out(e0_csb1)
        );
        kv_dff_gen #(
            .W(6 + 1)
        ) u_e0c_offset1 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out1[6:0]),
            .q(e0c_offset_out1)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(8),
            .SLICE_NUM(8)
        ) u_slice1 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[15:8]),
            .shift(e0c_offset_in1),
            .idx(3'h1),
            .shift_mask(e0c_shift_mask1),
            .shift_sel(e0c_shift_sel1)
        );
        wire [6:0] e0c_offset_in2 = e0c_offset_out1;
        wire [6:0] e0_csb2;
        wire [6 + 1:0] e0_offset_out2 = e0_csb2 + e0_offset_in2;
        wire nds_unused_e0_offset_out2 = e0_offset_out2[6 + 1];
        wire [6:0] e0_offset_in3 = e0_offset_out2[6:0];
        wire [6:0] e0c_offset_out2;
        wire [128 - 1:0] e0c_shift_mask2;
        wire [128 * 6 - 1:0] e0c_shift_sel2;
        kv_csb #(
            .N(8),
            .W(6 + 1)
        ) u_offset2 (
            .in(e0_mask[23:16]),
            .out(e0_csb2)
        );
        kv_dff_gen #(
            .W(6 + 1)
        ) u_e0c_offset2 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out2[6:0]),
            .q(e0c_offset_out2)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(8),
            .SLICE_NUM(8)
        ) u_slice2 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[23:16]),
            .shift(e0c_offset_in2),
            .idx(3'h2),
            .shift_mask(e0c_shift_mask2),
            .shift_sel(e0c_shift_sel2)
        );
        wire [6:0] e0c_offset_in3 = e0c_offset_out2;
        wire [6:0] e0_csb3;
        wire [6 + 1:0] e0_offset_out3 = e0_csb3 + e0_offset_in3;
        wire nds_unused_e0_offset_out3 = e0_offset_out3[6 + 1];
        wire [6:0] e0_offset_in4 = e0_offset_out3[6:0];
        wire [6:0] e0c_offset_out3;
        wire [128 - 1:0] e0c_shift_mask3;
        wire [128 * 6 - 1:0] e0c_shift_sel3;
        kv_csb #(
            .N(8),
            .W(6 + 1)
        ) u_offset3 (
            .in(e0_mask[31:24]),
            .out(e0_csb3)
        );
        kv_dff_gen #(
            .W(6 + 1)
        ) u_e0c_offset3 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out3[6:0]),
            .q(e0c_offset_out3)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(8),
            .SLICE_NUM(8)
        ) u_slice3 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[31:24]),
            .shift(e0c_offset_in3),
            .idx(3'h3),
            .shift_mask(e0c_shift_mask3),
            .shift_sel(e0c_shift_sel3)
        );
        wire [6:0] e0c_offset_in4 = e0c_offset_out3;
        wire [6:0] e0_csb4;
        wire [6 + 1:0] e0_offset_out4 = e0_csb4 + e0_offset_in4;
        wire nds_unused_e0_offset_out4 = e0_offset_out4[6 + 1];
        wire [6:0] e0_offset_in5 = e0_offset_out4[6:0];
        wire [6:0] e0c_offset_out4;
        wire [128 - 1:0] e0c_shift_mask4;
        wire [128 * 6 - 1:0] e0c_shift_sel4;
        kv_csb #(
            .N(8),
            .W(6 + 1)
        ) u_offset4 (
            .in(e0_mask[39:32]),
            .out(e0_csb4)
        );
        kv_dff_gen #(
            .W(6 + 1)
        ) u_e0c_offset4 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out4[6:0]),
            .q(e0c_offset_out4)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(8),
            .SLICE_NUM(8)
        ) u_slice4 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[39:32]),
            .shift(e0c_offset_in4),
            .idx(3'h4),
            .shift_mask(e0c_shift_mask4),
            .shift_sel(e0c_shift_sel4)
        );
        wire [6:0] e0c_offset_in5 = e0c_offset_out4;
        wire [6:0] e0_csb5;
        wire [6 + 1:0] e0_offset_out5 = e0_csb5 + e0_offset_in5;
        wire nds_unused_e0_offset_out5 = e0_offset_out5[6 + 1];
        wire [6:0] e0_offset_in6 = e0_offset_out5[6:0];
        wire [6:0] e0c_offset_out5;
        wire [128 - 1:0] e0c_shift_mask5;
        wire [128 * 6 - 1:0] e0c_shift_sel5;
        kv_csb #(
            .N(8),
            .W(6 + 1)
        ) u_offset5 (
            .in(e0_mask[47:40]),
            .out(e0_csb5)
        );
        kv_dff_gen #(
            .W(6 + 1)
        ) u_e0c_offset5 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out5[6:0]),
            .q(e0c_offset_out5)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(8),
            .SLICE_NUM(8)
        ) u_slice5 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[47:40]),
            .shift(e0c_offset_in5),
            .idx(3'h5),
            .shift_mask(e0c_shift_mask5),
            .shift_sel(e0c_shift_sel5)
        );
        wire [6:0] e0c_offset_in6 = e0c_offset_out5;
        wire [6:0] e0_csb6;
        wire [6 + 1:0] e0_offset_out6 = e0_csb6 + e0_offset_in6;
        wire nds_unused_e0_offset_out6 = e0_offset_out6[6 + 1];
        wire [6:0] e0_offset_in7 = e0_offset_out6[6:0];
        wire [6:0] e0c_offset_out6;
        wire [128 - 1:0] e0c_shift_mask6;
        wire [128 * 6 - 1:0] e0c_shift_sel6;
        kv_csb #(
            .N(8),
            .W(6 + 1)
        ) u_offset6 (
            .in(e0_mask[55:48]),
            .out(e0_csb6)
        );
        kv_dff_gen #(
            .W(6 + 1)
        ) u_e0c_offset6 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out6[6:0]),
            .q(e0c_offset_out6)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(8),
            .SLICE_NUM(8)
        ) u_slice6 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[55:48]),
            .shift(e0c_offset_in6),
            .idx(3'h6),
            .shift_mask(e0c_shift_mask6),
            .shift_sel(e0c_shift_sel6)
        );
        wire [6:0] e0c_offset_in7 = e0c_offset_out6;
        wire [6:0] e0_csb7;
        wire [6 + 1:0] e0_offset_out7 = e0_csb7 + e0_offset_in7;
        wire nds_unused_e0_offset_out7 = e0_offset_out7[6 + 1];
        wire [6:0] e0_offset_in8 = e0_offset_out7[6:0];
        wire [6:0] e0c_offset_out7;
        wire [128 - 1:0] e0c_shift_mask7;
        wire [128 * 6 - 1:0] e0c_shift_sel7;
        kv_csb #(
            .N(8),
            .W(6 + 1)
        ) u_offset7 (
            .in(e0_mask[63:56]),
            .out(e0_csb7)
        );
        kv_dff_gen #(
            .W(6 + 1)
        ) u_e0c_offset7 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out7[6:0]),
            .q(e0c_offset_out7)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(8),
            .SLICE_NUM(8)
        ) u_slice7 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[63:56]),
            .shift(e0c_offset_in7),
            .idx(3'h7),
            .shift_mask(e0c_shift_mask7),
            .shift_sel(e0c_shift_sel7)
        );
        wire [6:0] e0c_offset_in8 = e0c_offset_out7;
        assign e0_offset_in0 = {6 + 1{e0c_valid}} & (({4'b0,{6 - 3{sew_onehot[3]}}} & e0c_offset_in1[6:0]) | ({3'b0,{6 - 2{sew_onehot[2]}}} & e0c_offset_in2[6:0]) | ({2'b0,{6 - 1{sew_onehot[1]}}} & e0c_offset_in4[6:0]) | ({1'b0,{6 - 0{sew_onehot[0]}}} & e0c_offset_in8[6:0]));
        assign e0_full = (sew_onehot[3] & e0_offset_out0[6 - 3]) | (sew_onehot[2] & e0_offset_out1[6 - 2]) | (sew_onehot[1] & e0_offset_out3[6 - 1]) | (sew_onehot[0] & e0_offset_out7[6]);
        assign e0_part_mask = (sew_onehot[3] & |e0_offset_out0[6 - 4:0]) | (sew_onehot[2] & |e0_offset_out1[6 - 3:0]) | (sew_onehot[1] & |e0_offset_out3[6 - 2:0]) | (sew_onehot[0] & |e0_offset_out7[6 - 1:0]);
        wire [6:0] nds_unused_e0_offset_in8 = e0_offset_in8;
        wire [128 - 1:0] e0c_merge_mask_sew8 = e0c_shift_mask0 | e0c_shift_mask1 | e0c_shift_mask2 | e0c_shift_mask3 | e0c_shift_mask4 | e0c_shift_mask5 | e0c_shift_mask6 | e0c_shift_mask7;
        wire [64 - 1:0] e0c_merge_mask_sew16 = e0c_shift_mask0[64 - 1:0] | e0c_shift_mask1[64 - 1:0] | e0c_shift_mask2[64 - 1:0] | e0c_shift_mask3[64 - 1:0];
        wire [32 - 1:0] e0c_merge_mask_sew32 = e0c_shift_mask0[32 - 1:0] | e0c_shift_mask1[32 - 1:0];
        wire [16 - 1:0] e0c_merge_mask_sew64 = e0c_shift_mask0[16 - 1:0];
        wire [128 - 1:0] e0c_merge_mask_exp16;
        wire [128 - 1:0] e0c_merge_mask_exp32;
        wire [128 - 1:0] e0c_merge_mask_exp64;
        kv_bit_expand #(
            .N(64),
            .M(2)
        ) u_exp16_mask (
            .in(e0c_merge_mask_sew16),
            .out(e0c_merge_mask_exp16)
        );
        kv_bit_expand #(
            .N(32),
            .M(4)
        ) u_exp32_mask (
            .in(e0c_merge_mask_sew32),
            .out(e0c_merge_mask_exp32)
        );
        kv_bit_expand #(
            .N(16),
            .M(8)
        ) u_exp64_mask (
            .in(e0c_merge_mask_sew64),
            .out(e0c_merge_mask_exp64)
        );
        assign e0c_dual_mask = ({128{sew_onehot[0]}} & e0c_merge_mask_sew8) | ({128{sew_onehot[1]}} & e0c_merge_mask_exp16) | ({128{sew_onehot[2]}} & e0c_merge_mask_exp32) | ({128{sew_onehot[3]}} & e0c_merge_mask_exp64);
        wire [128 * 6:0] e0c_merge_sel_sew8 = {1'b0,e0c_shift_sel0 | e0c_shift_sel1 | e0c_shift_sel2 | e0c_shift_sel3 | e0c_shift_sel4 | e0c_shift_sel5 | e0c_shift_sel6 | e0c_shift_sel7};
        wire [64 * 6 - 1:0] e0c_merge_sel_sew16 = e0c_shift_sel0[64 * 6 - 1:0] | e0c_shift_sel1[64 * 6 - 1:0] | e0c_shift_sel2[64 * 6 - 1:0] | e0c_shift_sel3[64 * 6 - 1:0];
        wire [32 * 6 - 1:0] e0c_merge_sel_sew32 = e0c_shift_sel0[32 * 6 - 1:0] | e0c_shift_sel1[32 * 6 - 1:0];
        wire [16 * 6 - 1:0] e0c_merge_sel_sew64 = e0c_shift_sel0[16 * 6 - 1:0];
        wire [128 * 6:0] e0c_exp_sel_sew64 = {1'b0,e0c_merge_sel_sew64[90 +:3],3'h7,e0c_merge_sel_sew64[90 +:3],3'h6,e0c_merge_sel_sew64[90 +:3],3'h5,e0c_merge_sel_sew64[90 +:3],3'h4,e0c_merge_sel_sew64[90 +:3],3'h3,e0c_merge_sel_sew64[90 +:3],3'h2,e0c_merge_sel_sew64[90 +:3],3'h1,e0c_merge_sel_sew64[90 +:3],3'h0,e0c_merge_sel_sew64[84 +:3],3'h7,e0c_merge_sel_sew64[84 +:3],3'h6,e0c_merge_sel_sew64[84 +:3],3'h5,e0c_merge_sel_sew64[84 +:3],3'h4,e0c_merge_sel_sew64[84 +:3],3'h3,e0c_merge_sel_sew64[84 +:3],3'h2,e0c_merge_sel_sew64[84 +:3],3'h1,e0c_merge_sel_sew64[84 +:3],3'h0,e0c_merge_sel_sew64[78 +:3],3'h7,e0c_merge_sel_sew64[78 +:3],3'h6,e0c_merge_sel_sew64[78 +:3],3'h5,e0c_merge_sel_sew64[78 +:3],3'h4,e0c_merge_sel_sew64[78 +:3],3'h3,e0c_merge_sel_sew64[78 +:3],3'h2,e0c_merge_sel_sew64[78 +:3],3'h1,e0c_merge_sel_sew64[78 +:3],3'h0,e0c_merge_sel_sew64[72 +:3],3'h7,e0c_merge_sel_sew64[72 +:3],3'h6,e0c_merge_sel_sew64[72 +:3],3'h5,e0c_merge_sel_sew64[72 +:3],3'h4,e0c_merge_sel_sew64[72 +:3],3'h3,e0c_merge_sel_sew64[72 +:3],3'h2,e0c_merge_sel_sew64[72 +:3],3'h1,e0c_merge_sel_sew64[72 +:3],3'h0,e0c_merge_sel_sew64[66 +:3],3'h7,e0c_merge_sel_sew64[66 +:3],3'h6,e0c_merge_sel_sew64[66 +:3],3'h5,e0c_merge_sel_sew64[66 +:3],3'h4,e0c_merge_sel_sew64[66 +:3],3'h3,e0c_merge_sel_sew64[66 +:3],3'h2,e0c_merge_sel_sew64[66 +:3],3'h1,e0c_merge_sel_sew64[66 +:3],3'h0,e0c_merge_sel_sew64[60 +:3],3'h7,e0c_merge_sel_sew64[60 +:3],3'h6,e0c_merge_sel_sew64[60 +:3],3'h5,e0c_merge_sel_sew64[60 +:3],3'h4,e0c_merge_sel_sew64[60 +:3],3'h3,e0c_merge_sel_sew64[60 +:3],3'h2,e0c_merge_sel_sew64[60 +:3],3'h1,e0c_merge_sel_sew64[60 +:3],3'h0,e0c_merge_sel_sew64[54 +:3],3'h7,e0c_merge_sel_sew64[54 +:3],3'h6,e0c_merge_sel_sew64[54 +:3],3'h5,e0c_merge_sel_sew64[54 +:3],3'h4,e0c_merge_sel_sew64[54 +:3],3'h3,e0c_merge_sel_sew64[54 +:3],3'h2,e0c_merge_sel_sew64[54 +:3],3'h1,e0c_merge_sel_sew64[54 +:3],3'h0,e0c_merge_sel_sew64[48 +:3],3'h7,e0c_merge_sel_sew64[48 +:3],3'h6,e0c_merge_sel_sew64[48 +:3],3'h5,e0c_merge_sel_sew64[48 +:3],3'h4,e0c_merge_sel_sew64[48 +:3],3'h3,e0c_merge_sel_sew64[48 +:3],3'h2,e0c_merge_sel_sew64[48 +:3],3'h1,e0c_merge_sel_sew64[48 +:3],3'h0,e0c_merge_sel_sew64[42 +:3],3'h7,e0c_merge_sel_sew64[42 +:3],3'h6,e0c_merge_sel_sew64[42 +:3],3'h5,e0c_merge_sel_sew64[42 +:3],3'h4,e0c_merge_sel_sew64[42 +:3],3'h3,e0c_merge_sel_sew64[42 +:3],3'h2,e0c_merge_sel_sew64[42 +:3],3'h1,e0c_merge_sel_sew64[42 +:3],3'h0,e0c_merge_sel_sew64[36 +:3],3'h7,e0c_merge_sel_sew64[36 +:3],3'h6,e0c_merge_sel_sew64[36 +:3],3'h5,e0c_merge_sel_sew64[36 +:3],3'h4,e0c_merge_sel_sew64[36 +:3],3'h3,e0c_merge_sel_sew64[36 +:3],3'h2,e0c_merge_sel_sew64[36 +:3],3'h1,e0c_merge_sel_sew64[36 +:3],3'h0,e0c_merge_sel_sew64[30 +:3],3'h7,e0c_merge_sel_sew64[30 +:3],3'h6,e0c_merge_sel_sew64[30 +:3],3'h5,e0c_merge_sel_sew64[30 +:3],3'h4,e0c_merge_sel_sew64[30 +:3],3'h3,e0c_merge_sel_sew64[30 +:3],3'h2,e0c_merge_sel_sew64[30 +:3],3'h1,e0c_merge_sel_sew64[30 +:3],3'h0,e0c_merge_sel_sew64[24 +:3],3'h7,e0c_merge_sel_sew64[24 +:3],3'h6,e0c_merge_sel_sew64[24 +:3],3'h5,e0c_merge_sel_sew64[24 +:3],3'h4,e0c_merge_sel_sew64[24 +:3],3'h3,e0c_merge_sel_sew64[24 +:3],3'h2,e0c_merge_sel_sew64[24 +:3],3'h1,e0c_merge_sel_sew64[24 +:3],3'h0,e0c_merge_sel_sew64[18 +:3],3'h7,e0c_merge_sel_sew64[18 +:3],3'h6,e0c_merge_sel_sew64[18 +:3],3'h5,e0c_merge_sel_sew64[18 +:3],3'h4,e0c_merge_sel_sew64[18 +:3],3'h3,e0c_merge_sel_sew64[18 +:3],3'h2,e0c_merge_sel_sew64[18 +:3],3'h1,e0c_merge_sel_sew64[18 +:3],3'h0,e0c_merge_sel_sew64[12 +:3],3'h7,e0c_merge_sel_sew64[12 +:3],3'h6,e0c_merge_sel_sew64[12 +:3],3'h5,e0c_merge_sel_sew64[12 +:3],3'h4,e0c_merge_sel_sew64[12 +:3],3'h3,e0c_merge_sel_sew64[12 +:3],3'h2,e0c_merge_sel_sew64[12 +:3],3'h1,e0c_merge_sel_sew64[12 +:3],3'h0,e0c_merge_sel_sew64[6 +:3],3'h7,e0c_merge_sel_sew64[6 +:3],3'h6,e0c_merge_sel_sew64[6 +:3],3'h5,e0c_merge_sel_sew64[6 +:3],3'h4,e0c_merge_sel_sew64[6 +:3],3'h3,e0c_merge_sel_sew64[6 +:3],3'h2,e0c_merge_sel_sew64[6 +:3],3'h1,e0c_merge_sel_sew64[6 +:3],3'h0,e0c_merge_sel_sew64[0 +:3],3'h7,e0c_merge_sel_sew64[0 +:3],3'h6,e0c_merge_sel_sew64[0 +:3],3'h5,e0c_merge_sel_sew64[0 +:3],3'h4,e0c_merge_sel_sew64[0 +:3],3'h3,e0c_merge_sel_sew64[0 +:3],3'h2,e0c_merge_sel_sew64[0 +:3],3'h1,e0c_merge_sel_sew64[0 +:3],3'h0};
        wire [128 * 6:0] e0c_exp_sel_sew32 = {1'b0,e0c_merge_sel_sew32[186 +:4],2'h3,e0c_merge_sel_sew32[186 +:4],2'h2,e0c_merge_sel_sew32[186 +:4],2'h1,e0c_merge_sel_sew32[186 +:4],2'h0,e0c_merge_sel_sew32[180 +:4],2'h3,e0c_merge_sel_sew32[180 +:4],2'h2,e0c_merge_sel_sew32[180 +:4],2'h1,e0c_merge_sel_sew32[180 +:4],2'h0,e0c_merge_sel_sew32[174 +:4],2'h3,e0c_merge_sel_sew32[174 +:4],2'h2,e0c_merge_sel_sew32[174 +:4],2'h1,e0c_merge_sel_sew32[174 +:4],2'h0,e0c_merge_sel_sew32[168 +:4],2'h3,e0c_merge_sel_sew32[168 +:4],2'h2,e0c_merge_sel_sew32[168 +:4],2'h1,e0c_merge_sel_sew32[168 +:4],2'h0,e0c_merge_sel_sew32[162 +:4],2'h3,e0c_merge_sel_sew32[162 +:4],2'h2,e0c_merge_sel_sew32[162 +:4],2'h1,e0c_merge_sel_sew32[162 +:4],2'h0,e0c_merge_sel_sew32[156 +:4],2'h3,e0c_merge_sel_sew32[156 +:4],2'h2,e0c_merge_sel_sew32[156 +:4],2'h1,e0c_merge_sel_sew32[156 +:4],2'h0,e0c_merge_sel_sew32[150 +:4],2'h3,e0c_merge_sel_sew32[150 +:4],2'h2,e0c_merge_sel_sew32[150 +:4],2'h1,e0c_merge_sel_sew32[150 +:4],2'h0,e0c_merge_sel_sew32[144 +:4],2'h3,e0c_merge_sel_sew32[144 +:4],2'h2,e0c_merge_sel_sew32[144 +:4],2'h1,e0c_merge_sel_sew32[144 +:4],2'h0,e0c_merge_sel_sew32[138 +:4],2'h3,e0c_merge_sel_sew32[138 +:4],2'h2,e0c_merge_sel_sew32[138 +:4],2'h1,e0c_merge_sel_sew32[138 +:4],2'h0,e0c_merge_sel_sew32[132 +:4],2'h3,e0c_merge_sel_sew32[132 +:4],2'h2,e0c_merge_sel_sew32[132 +:4],2'h1,e0c_merge_sel_sew32[132 +:4],2'h0,e0c_merge_sel_sew32[126 +:4],2'h3,e0c_merge_sel_sew32[126 +:4],2'h2,e0c_merge_sel_sew32[126 +:4],2'h1,e0c_merge_sel_sew32[126 +:4],2'h0,e0c_merge_sel_sew32[120 +:4],2'h3,e0c_merge_sel_sew32[120 +:4],2'h2,e0c_merge_sel_sew32[120 +:4],2'h1,e0c_merge_sel_sew32[120 +:4],2'h0,e0c_merge_sel_sew32[114 +:4],2'h3,e0c_merge_sel_sew32[114 +:4],2'h2,e0c_merge_sel_sew32[114 +:4],2'h1,e0c_merge_sel_sew32[114 +:4],2'h0,e0c_merge_sel_sew32[108 +:4],2'h3,e0c_merge_sel_sew32[108 +:4],2'h2,e0c_merge_sel_sew32[108 +:4],2'h1,e0c_merge_sel_sew32[108 +:4],2'h0,e0c_merge_sel_sew32[102 +:4],2'h3,e0c_merge_sel_sew32[102 +:4],2'h2,e0c_merge_sel_sew32[102 +:4],2'h1,e0c_merge_sel_sew32[102 +:4],2'h0,e0c_merge_sel_sew32[96 +:4],2'h3,e0c_merge_sel_sew32[96 +:4],2'h2,e0c_merge_sel_sew32[96 +:4],2'h1,e0c_merge_sel_sew32[96 +:4],2'h0,e0c_merge_sel_sew32[90 +:4],2'h3,e0c_merge_sel_sew32[90 +:4],2'h2,e0c_merge_sel_sew32[90 +:4],2'h1,e0c_merge_sel_sew32[90 +:4],2'h0,e0c_merge_sel_sew32[84 +:4],2'h3,e0c_merge_sel_sew32[84 +:4],2'h2,e0c_merge_sel_sew32[84 +:4],2'h1,e0c_merge_sel_sew32[84 +:4],2'h0,e0c_merge_sel_sew32[78 +:4],2'h3,e0c_merge_sel_sew32[78 +:4],2'h2,e0c_merge_sel_sew32[78 +:4],2'h1,e0c_merge_sel_sew32[78 +:4],2'h0,e0c_merge_sel_sew32[72 +:4],2'h3,e0c_merge_sel_sew32[72 +:4],2'h2,e0c_merge_sel_sew32[72 +:4],2'h1,e0c_merge_sel_sew32[72 +:4],2'h0,e0c_merge_sel_sew32[66 +:4],2'h3,e0c_merge_sel_sew32[66 +:4],2'h2,e0c_merge_sel_sew32[66 +:4],2'h1,e0c_merge_sel_sew32[66 +:4],2'h0,e0c_merge_sel_sew32[60 +:4],2'h3,e0c_merge_sel_sew32[60 +:4],2'h2,e0c_merge_sel_sew32[60 +:4],2'h1,e0c_merge_sel_sew32[60 +:4],2'h0,e0c_merge_sel_sew32[54 +:4],2'h3,e0c_merge_sel_sew32[54 +:4],2'h2,e0c_merge_sel_sew32[54 +:4],2'h1,e0c_merge_sel_sew32[54 +:4],2'h0,e0c_merge_sel_sew32[48 +:4],2'h3,e0c_merge_sel_sew32[48 +:4],2'h2,e0c_merge_sel_sew32[48 +:4],2'h1,e0c_merge_sel_sew32[48 +:4],2'h0,e0c_merge_sel_sew32[42 +:4],2'h3,e0c_merge_sel_sew32[42 +:4],2'h2,e0c_merge_sel_sew32[42 +:4],2'h1,e0c_merge_sel_sew32[42 +:4],2'h0,e0c_merge_sel_sew32[36 +:4],2'h3,e0c_merge_sel_sew32[36 +:4],2'h2,e0c_merge_sel_sew32[36 +:4],2'h1,e0c_merge_sel_sew32[36 +:4],2'h0,e0c_merge_sel_sew32[30 +:4],2'h3,e0c_merge_sel_sew32[30 +:4],2'h2,e0c_merge_sel_sew32[30 +:4],2'h1,e0c_merge_sel_sew32[30 +:4],2'h0,e0c_merge_sel_sew32[24 +:4],2'h3,e0c_merge_sel_sew32[24 +:4],2'h2,e0c_merge_sel_sew32[24 +:4],2'h1,e0c_merge_sel_sew32[24 +:4],2'h0,e0c_merge_sel_sew32[18 +:4],2'h3,e0c_merge_sel_sew32[18 +:4],2'h2,e0c_merge_sel_sew32[18 +:4],2'h1,e0c_merge_sel_sew32[18 +:4],2'h0,e0c_merge_sel_sew32[12 +:4],2'h3,e0c_merge_sel_sew32[12 +:4],2'h2,e0c_merge_sel_sew32[12 +:4],2'h1,e0c_merge_sel_sew32[12 +:4],2'h0,e0c_merge_sel_sew32[6 +:4],2'h3,e0c_merge_sel_sew32[6 +:4],2'h2,e0c_merge_sel_sew32[6 +:4],2'h1,e0c_merge_sel_sew32[6 +:4],2'h0,e0c_merge_sel_sew32[0 +:4],2'h3,e0c_merge_sel_sew32[0 +:4],2'h2,e0c_merge_sel_sew32[0 +:4],2'h1,e0c_merge_sel_sew32[0 +:4],2'h0};
        wire [128 * 6:0] e0c_exp_sel_sew16 = {1'b0,e0c_merge_sel_sew16[378 +:5],1'h1,e0c_merge_sel_sew16[378 +:5],1'h0,e0c_merge_sel_sew16[372 +:5],1'h1,e0c_merge_sel_sew16[372 +:5],1'h0,e0c_merge_sel_sew16[366 +:5],1'h1,e0c_merge_sel_sew16[366 +:5],1'h0,e0c_merge_sel_sew16[360 +:5],1'h1,e0c_merge_sel_sew16[360 +:5],1'h0,e0c_merge_sel_sew16[354 +:5],1'h1,e0c_merge_sel_sew16[354 +:5],1'h0,e0c_merge_sel_sew16[348 +:5],1'h1,e0c_merge_sel_sew16[348 +:5],1'h0,e0c_merge_sel_sew16[342 +:5],1'h1,e0c_merge_sel_sew16[342 +:5],1'h0,e0c_merge_sel_sew16[336 +:5],1'h1,e0c_merge_sel_sew16[336 +:5],1'h0,e0c_merge_sel_sew16[330 +:5],1'h1,e0c_merge_sel_sew16[330 +:5],1'h0,e0c_merge_sel_sew16[324 +:5],1'h1,e0c_merge_sel_sew16[324 +:5],1'h0,e0c_merge_sel_sew16[318 +:5],1'h1,e0c_merge_sel_sew16[318 +:5],1'h0,e0c_merge_sel_sew16[312 +:5],1'h1,e0c_merge_sel_sew16[312 +:5],1'h0,e0c_merge_sel_sew16[306 +:5],1'h1,e0c_merge_sel_sew16[306 +:5],1'h0,e0c_merge_sel_sew16[300 +:5],1'h1,e0c_merge_sel_sew16[300 +:5],1'h0,e0c_merge_sel_sew16[294 +:5],1'h1,e0c_merge_sel_sew16[294 +:5],1'h0,e0c_merge_sel_sew16[288 +:5],1'h1,e0c_merge_sel_sew16[288 +:5],1'h0,e0c_merge_sel_sew16[282 +:5],1'h1,e0c_merge_sel_sew16[282 +:5],1'h0,e0c_merge_sel_sew16[276 +:5],1'h1,e0c_merge_sel_sew16[276 +:5],1'h0,e0c_merge_sel_sew16[270 +:5],1'h1,e0c_merge_sel_sew16[270 +:5],1'h0,e0c_merge_sel_sew16[264 +:5],1'h1,e0c_merge_sel_sew16[264 +:5],1'h0,e0c_merge_sel_sew16[258 +:5],1'h1,e0c_merge_sel_sew16[258 +:5],1'h0,e0c_merge_sel_sew16[252 +:5],1'h1,e0c_merge_sel_sew16[252 +:5],1'h0,e0c_merge_sel_sew16[246 +:5],1'h1,e0c_merge_sel_sew16[246 +:5],1'h0,e0c_merge_sel_sew16[240 +:5],1'h1,e0c_merge_sel_sew16[240 +:5],1'h0,e0c_merge_sel_sew16[234 +:5],1'h1,e0c_merge_sel_sew16[234 +:5],1'h0,e0c_merge_sel_sew16[228 +:5],1'h1,e0c_merge_sel_sew16[228 +:5],1'h0,e0c_merge_sel_sew16[222 +:5],1'h1,e0c_merge_sel_sew16[222 +:5],1'h0,e0c_merge_sel_sew16[216 +:5],1'h1,e0c_merge_sel_sew16[216 +:5],1'h0,e0c_merge_sel_sew16[210 +:5],1'h1,e0c_merge_sel_sew16[210 +:5],1'h0,e0c_merge_sel_sew16[204 +:5],1'h1,e0c_merge_sel_sew16[204 +:5],1'h0,e0c_merge_sel_sew16[198 +:5],1'h1,e0c_merge_sel_sew16[198 +:5],1'h0,e0c_merge_sel_sew16[192 +:5],1'h1,e0c_merge_sel_sew16[192 +:5],1'h0,e0c_merge_sel_sew16[186 +:5],1'h1,e0c_merge_sel_sew16[186 +:5],1'h0,e0c_merge_sel_sew16[180 +:5],1'h1,e0c_merge_sel_sew16[180 +:5],1'h0,e0c_merge_sel_sew16[174 +:5],1'h1,e0c_merge_sel_sew16[174 +:5],1'h0,e0c_merge_sel_sew16[168 +:5],1'h1,e0c_merge_sel_sew16[168 +:5],1'h0,e0c_merge_sel_sew16[162 +:5],1'h1,e0c_merge_sel_sew16[162 +:5],1'h0,e0c_merge_sel_sew16[156 +:5],1'h1,e0c_merge_sel_sew16[156 +:5],1'h0,e0c_merge_sel_sew16[150 +:5],1'h1,e0c_merge_sel_sew16[150 +:5],1'h0,e0c_merge_sel_sew16[144 +:5],1'h1,e0c_merge_sel_sew16[144 +:5],1'h0,e0c_merge_sel_sew16[138 +:5],1'h1,e0c_merge_sel_sew16[138 +:5],1'h0,e0c_merge_sel_sew16[132 +:5],1'h1,e0c_merge_sel_sew16[132 +:5],1'h0,e0c_merge_sel_sew16[126 +:5],1'h1,e0c_merge_sel_sew16[126 +:5],1'h0,e0c_merge_sel_sew16[120 +:5],1'h1,e0c_merge_sel_sew16[120 +:5],1'h0,e0c_merge_sel_sew16[114 +:5],1'h1,e0c_merge_sel_sew16[114 +:5],1'h0,e0c_merge_sel_sew16[108 +:5],1'h1,e0c_merge_sel_sew16[108 +:5],1'h0,e0c_merge_sel_sew16[102 +:5],1'h1,e0c_merge_sel_sew16[102 +:5],1'h0,e0c_merge_sel_sew16[96 +:5],1'h1,e0c_merge_sel_sew16[96 +:5],1'h0,e0c_merge_sel_sew16[90 +:5],1'h1,e0c_merge_sel_sew16[90 +:5],1'h0,e0c_merge_sel_sew16[84 +:5],1'h1,e0c_merge_sel_sew16[84 +:5],1'h0,e0c_merge_sel_sew16[78 +:5],1'h1,e0c_merge_sel_sew16[78 +:5],1'h0,e0c_merge_sel_sew16[72 +:5],1'h1,e0c_merge_sel_sew16[72 +:5],1'h0,e0c_merge_sel_sew16[66 +:5],1'h1,e0c_merge_sel_sew16[66 +:5],1'h0,e0c_merge_sel_sew16[60 +:5],1'h1,e0c_merge_sel_sew16[60 +:5],1'h0,e0c_merge_sel_sew16[54 +:5],1'h1,e0c_merge_sel_sew16[54 +:5],1'h0,e0c_merge_sel_sew16[48 +:5],1'h1,e0c_merge_sel_sew16[48 +:5],1'h0,e0c_merge_sel_sew16[42 +:5],1'h1,e0c_merge_sel_sew16[42 +:5],1'h0,e0c_merge_sel_sew16[36 +:5],1'h1,e0c_merge_sel_sew16[36 +:5],1'h0,e0c_merge_sel_sew16[30 +:5],1'h1,e0c_merge_sel_sew16[30 +:5],1'h0,e0c_merge_sel_sew16[24 +:5],1'h1,e0c_merge_sel_sew16[24 +:5],1'h0,e0c_merge_sel_sew16[18 +:5],1'h1,e0c_merge_sel_sew16[18 +:5],1'h0,e0c_merge_sel_sew16[12 +:5],1'h1,e0c_merge_sel_sew16[12 +:5],1'h0,e0c_merge_sel_sew16[6 +:5],1'h1,e0c_merge_sel_sew16[6 +:5],1'h0,e0c_merge_sel_sew16[0 +:5],1'h1,e0c_merge_sel_sew16[0 +:5],1'h0};
        assign e0c_dual_sel = ({128 * 6 + 1{sew_onehot[0]}} & e0c_merge_sel_sew8) | ({128 * 6 + 1{sew_onehot[1]}} & e0c_exp_sel_sew16) | ({128 * 6 + 1{sew_onehot[2]}} & e0c_exp_sel_sew32) | ({128 * 6 + 1{sew_onehot[3]}} & e0c_exp_sel_sew64);
    end
endgenerate
generate
    if (VP_LEN == 1024) begin:gen_vpermut_dlen1024
        wire [7:0] e0_offset_in0;
        wire [7:0] e0c_offset_in0;
        kv_dff_gen #(
            .W(7 + 1)
        ) u_e0c_offset_in (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_in0),
            .q(e0c_offset_in0)
        );
        wire [7:0] e0_csb0;
        wire [7 + 1:0] e0_offset_out0 = e0_csb0 + e0_offset_in0;
        wire nds_unused_e0_offset_out0 = e0_offset_out0[7 + 1];
        wire [7:0] e0_offset_in1 = e0_offset_out0[7:0];
        wire [7:0] e0c_offset_out0;
        wire [256 - 1:0] e0c_shift_mask0;
        wire [256 * 7 - 1:0] e0c_shift_sel0;
        kv_csb #(
            .N(16),
            .W(7 + 1)
        ) u_offset0 (
            .in(e0_mask[15:0]),
            .out(e0_csb0)
        );
        kv_dff_gen #(
            .W(7 + 1)
        ) u_e0c_offset0 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out0[7:0]),
            .q(e0c_offset_out0)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(16),
            .SLICE_NUM(8)
        ) u_slice0 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[15:0]),
            .shift(e0c_offset_in0),
            .idx(3'h0),
            .shift_mask(e0c_shift_mask0),
            .shift_sel(e0c_shift_sel0)
        );
        wire [7:0] e0c_offset_in1 = e0c_offset_out0;
        wire [7:0] e0_csb1;
        wire [7 + 1:0] e0_offset_out1 = e0_csb1 + e0_offset_in1;
        wire nds_unused_e0_offset_out1 = e0_offset_out1[7 + 1];
        wire [7:0] e0_offset_in2 = e0_offset_out1[7:0];
        wire [7:0] e0c_offset_out1;
        wire [256 - 1:0] e0c_shift_mask1;
        wire [256 * 7 - 1:0] e0c_shift_sel1;
        kv_csb #(
            .N(16),
            .W(7 + 1)
        ) u_offset1 (
            .in(e0_mask[31:16]),
            .out(e0_csb1)
        );
        kv_dff_gen #(
            .W(7 + 1)
        ) u_e0c_offset1 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out1[7:0]),
            .q(e0c_offset_out1)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(16),
            .SLICE_NUM(8)
        ) u_slice1 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[31:16]),
            .shift(e0c_offset_in1),
            .idx(3'h1),
            .shift_mask(e0c_shift_mask1),
            .shift_sel(e0c_shift_sel1)
        );
        wire [7:0] e0c_offset_in2 = e0c_offset_out1;
        wire [7:0] e0_csb2;
        wire [7 + 1:0] e0_offset_out2 = e0_csb2 + e0_offset_in2;
        wire nds_unused_e0_offset_out2 = e0_offset_out2[7 + 1];
        wire [7:0] e0_offset_in3 = e0_offset_out2[7:0];
        wire [7:0] e0c_offset_out2;
        wire [256 - 1:0] e0c_shift_mask2;
        wire [256 * 7 - 1:0] e0c_shift_sel2;
        kv_csb #(
            .N(16),
            .W(7 + 1)
        ) u_offset2 (
            .in(e0_mask[47:32]),
            .out(e0_csb2)
        );
        kv_dff_gen #(
            .W(7 + 1)
        ) u_e0c_offset2 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out2[7:0]),
            .q(e0c_offset_out2)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(16),
            .SLICE_NUM(8)
        ) u_slice2 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[47:32]),
            .shift(e0c_offset_in2),
            .idx(3'h2),
            .shift_mask(e0c_shift_mask2),
            .shift_sel(e0c_shift_sel2)
        );
        wire [7:0] e0c_offset_in3 = e0c_offset_out2;
        wire [7:0] e0_csb3;
        wire [7 + 1:0] e0_offset_out3 = e0_csb3 + e0_offset_in3;
        wire nds_unused_e0_offset_out3 = e0_offset_out3[7 + 1];
        wire [7:0] e0_offset_in4 = e0_offset_out3[7:0];
        wire [7:0] e0c_offset_out3;
        wire [256 - 1:0] e0c_shift_mask3;
        wire [256 * 7 - 1:0] e0c_shift_sel3;
        kv_csb #(
            .N(16),
            .W(7 + 1)
        ) u_offset3 (
            .in(e0_mask[63:48]),
            .out(e0_csb3)
        );
        kv_dff_gen #(
            .W(7 + 1)
        ) u_e0c_offset3 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out3[7:0]),
            .q(e0c_offset_out3)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(16),
            .SLICE_NUM(8)
        ) u_slice3 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[63:48]),
            .shift(e0c_offset_in3),
            .idx(3'h3),
            .shift_mask(e0c_shift_mask3),
            .shift_sel(e0c_shift_sel3)
        );
        wire [7:0] e0c_offset_in4 = e0c_offset_out3;
        wire [7:0] e0_csb4;
        wire [7 + 1:0] e0_offset_out4 = e0_csb4 + e0_offset_in4;
        wire nds_unused_e0_offset_out4 = e0_offset_out4[7 + 1];
        wire [7:0] e0_offset_in5 = e0_offset_out4[7:0];
        wire [7:0] e0c_offset_out4;
        wire [256 - 1:0] e0c_shift_mask4;
        wire [256 * 7 - 1:0] e0c_shift_sel4;
        kv_csb #(
            .N(16),
            .W(7 + 1)
        ) u_offset4 (
            .in(e0_mask[79:64]),
            .out(e0_csb4)
        );
        kv_dff_gen #(
            .W(7 + 1)
        ) u_e0c_offset4 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out4[7:0]),
            .q(e0c_offset_out4)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(16),
            .SLICE_NUM(8)
        ) u_slice4 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[79:64]),
            .shift(e0c_offset_in4),
            .idx(3'h4),
            .shift_mask(e0c_shift_mask4),
            .shift_sel(e0c_shift_sel4)
        );
        wire [7:0] e0c_offset_in5 = e0c_offset_out4;
        wire [7:0] e0_csb5;
        wire [7 + 1:0] e0_offset_out5 = e0_csb5 + e0_offset_in5;
        wire nds_unused_e0_offset_out5 = e0_offset_out5[7 + 1];
        wire [7:0] e0_offset_in6 = e0_offset_out5[7:0];
        wire [7:0] e0c_offset_out5;
        wire [256 - 1:0] e0c_shift_mask5;
        wire [256 * 7 - 1:0] e0c_shift_sel5;
        kv_csb #(
            .N(16),
            .W(7 + 1)
        ) u_offset5 (
            .in(e0_mask[95:80]),
            .out(e0_csb5)
        );
        kv_dff_gen #(
            .W(7 + 1)
        ) u_e0c_offset5 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out5[7:0]),
            .q(e0c_offset_out5)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(16),
            .SLICE_NUM(8)
        ) u_slice5 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[95:80]),
            .shift(e0c_offset_in5),
            .idx(3'h5),
            .shift_mask(e0c_shift_mask5),
            .shift_sel(e0c_shift_sel5)
        );
        wire [7:0] e0c_offset_in6 = e0c_offset_out5;
        wire [7:0] e0_csb6;
        wire [7 + 1:0] e0_offset_out6 = e0_csb6 + e0_offset_in6;
        wire nds_unused_e0_offset_out6 = e0_offset_out6[7 + 1];
        wire [7:0] e0_offset_in7 = e0_offset_out6[7:0];
        wire [7:0] e0c_offset_out6;
        wire [256 - 1:0] e0c_shift_mask6;
        wire [256 * 7 - 1:0] e0c_shift_sel6;
        kv_csb #(
            .N(16),
            .W(7 + 1)
        ) u_offset6 (
            .in(e0_mask[111:96]),
            .out(e0_csb6)
        );
        kv_dff_gen #(
            .W(7 + 1)
        ) u_e0c_offset6 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out6[7:0]),
            .q(e0c_offset_out6)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(16),
            .SLICE_NUM(8)
        ) u_slice6 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[111:96]),
            .shift(e0c_offset_in6),
            .idx(3'h6),
            .shift_mask(e0c_shift_mask6),
            .shift_sel(e0c_shift_sel6)
        );
        wire [7:0] e0c_offset_in7 = e0c_offset_out6;
        wire [7:0] e0_csb7;
        wire [7 + 1:0] e0_offset_out7 = e0_csb7 + e0_offset_in7;
        wire nds_unused_e0_offset_out7 = e0_offset_out7[7 + 1];
        wire [7:0] e0_offset_in8 = e0_offset_out7[7:0];
        wire [7:0] e0c_offset_out7;
        wire [256 - 1:0] e0c_shift_mask7;
        wire [256 * 7 - 1:0] e0c_shift_sel7;
        kv_csb #(
            .N(16),
            .W(7 + 1)
        ) u_offset7 (
            .in(e0_mask[127:112]),
            .out(e0_csb7)
        );
        kv_dff_gen #(
            .W(7 + 1)
        ) u_e0c_offset7 (
            .clk(vpu_vpermut_clk),
            .en(e0c_en),
            .d(e0_offset_out7[7:0]),
            .q(e0c_offset_out7)
        );
        kv_vcompress_slice #(
            .SLICE_LEN(16),
            .SLICE_NUM(8)
        ) u_slice7 (
            .vpu_vpermut_clk(vpu_vpermut_clk),
            .e0c_en(e0c_en),
            .mask_in(e0_mask[127:112]),
            .shift(e0c_offset_in7),
            .idx(3'h7),
            .shift_mask(e0c_shift_mask7),
            .shift_sel(e0c_shift_sel7)
        );
        wire [7:0] e0c_offset_in8 = e0c_offset_out7;
        assign e0_offset_in0 = {7 + 1{e0c_valid}} & (({4'b0,{7 - 3{sew_onehot[3]}}} & e0c_offset_in1[7:0]) | ({3'b0,{7 - 2{sew_onehot[2]}}} & e0c_offset_in2[7:0]) | ({2'b0,{7 - 1{sew_onehot[1]}}} & e0c_offset_in4[7:0]) | ({1'b0,{7 - 0{sew_onehot[0]}}} & e0c_offset_in8[7:0]));
        assign e0_full = (sew_onehot[3] & e0_offset_out0[7 - 3]) | (sew_onehot[2] & e0_offset_out1[7 - 2]) | (sew_onehot[1] & e0_offset_out3[7 - 1]) | (sew_onehot[0] & e0_offset_out7[7]);
        assign e0_part_mask = (sew_onehot[3] & |e0_offset_out0[7 - 4:0]) | (sew_onehot[2] & |e0_offset_out1[7 - 3:0]) | (sew_onehot[1] & |e0_offset_out3[7 - 2:0]) | (sew_onehot[0] & |e0_offset_out7[7 - 1:0]);
        wire [7:0] nds_unused_e0_offset_in8 = e0_offset_in8;
        wire [256 - 1:0] e0c_merge_mask_sew8 = e0c_shift_mask0 | e0c_shift_mask1 | e0c_shift_mask2 | e0c_shift_mask3 | e0c_shift_mask4 | e0c_shift_mask5 | e0c_shift_mask6 | e0c_shift_mask7;
        wire [128 - 1:0] e0c_merge_mask_sew16 = e0c_shift_mask0[128 - 1:0] | e0c_shift_mask1[128 - 1:0] | e0c_shift_mask2[128 - 1:0] | e0c_shift_mask3[128 - 1:0];
        wire [64 - 1:0] e0c_merge_mask_sew32 = e0c_shift_mask0[64 - 1:0] | e0c_shift_mask1[64 - 1:0];
        wire [32 - 1:0] e0c_merge_mask_sew64 = e0c_shift_mask0[32 - 1:0];
        wire [256 - 1:0] e0c_merge_mask_exp16;
        wire [256 - 1:0] e0c_merge_mask_exp32;
        wire [256 - 1:0] e0c_merge_mask_exp64;
        kv_bit_expand #(
            .N(128),
            .M(2)
        ) u_exp16_mask (
            .in(e0c_merge_mask_sew16),
            .out(e0c_merge_mask_exp16)
        );
        kv_bit_expand #(
            .N(64),
            .M(4)
        ) u_exp32_mask (
            .in(e0c_merge_mask_sew32),
            .out(e0c_merge_mask_exp32)
        );
        kv_bit_expand #(
            .N(32),
            .M(8)
        ) u_exp64_mask (
            .in(e0c_merge_mask_sew64),
            .out(e0c_merge_mask_exp64)
        );
        assign e0c_dual_mask = ({256{sew_onehot[0]}} & e0c_merge_mask_sew8) | ({256{sew_onehot[1]}} & e0c_merge_mask_exp16) | ({256{sew_onehot[2]}} & e0c_merge_mask_exp32) | ({256{sew_onehot[3]}} & e0c_merge_mask_exp64);
        wire [256 * 7:0] e0c_merge_sel_sew8 = {1'b0,e0c_shift_sel0 | e0c_shift_sel1 | e0c_shift_sel2 | e0c_shift_sel3 | e0c_shift_sel4 | e0c_shift_sel5 | e0c_shift_sel6 | e0c_shift_sel7};
        wire [128 * 7 - 1:0] e0c_merge_sel_sew16 = e0c_shift_sel0[128 * 7 - 1:0] | e0c_shift_sel1[128 * 7 - 1:0] | e0c_shift_sel2[128 * 7 - 1:0] | e0c_shift_sel3[128 * 7 - 1:0];
        wire [64 * 7 - 1:0] e0c_merge_sel_sew32 = e0c_shift_sel0[64 * 7 - 1:0] | e0c_shift_sel1[64 * 7 - 1:0];
        wire [32 * 7 - 1:0] e0c_merge_sel_sew64 = e0c_shift_sel0[32 * 7 - 1:0];
        wire [256 * 7:0] e0c_exp_sel_sew64 = {1'b0,e0c_merge_sel_sew64[217 +:4],3'h7,e0c_merge_sel_sew64[217 +:4],3'h6,e0c_merge_sel_sew64[217 +:4],3'h5,e0c_merge_sel_sew64[217 +:4],3'h4,e0c_merge_sel_sew64[217 +:4],3'h3,e0c_merge_sel_sew64[217 +:4],3'h2,e0c_merge_sel_sew64[217 +:4],3'h1,e0c_merge_sel_sew64[217 +:4],3'h0,e0c_merge_sel_sew64[210 +:4],3'h7,e0c_merge_sel_sew64[210 +:4],3'h6,e0c_merge_sel_sew64[210 +:4],3'h5,e0c_merge_sel_sew64[210 +:4],3'h4,e0c_merge_sel_sew64[210 +:4],3'h3,e0c_merge_sel_sew64[210 +:4],3'h2,e0c_merge_sel_sew64[210 +:4],3'h1,e0c_merge_sel_sew64[210 +:4],3'h0,e0c_merge_sel_sew64[203 +:4],3'h7,e0c_merge_sel_sew64[203 +:4],3'h6,e0c_merge_sel_sew64[203 +:4],3'h5,e0c_merge_sel_sew64[203 +:4],3'h4,e0c_merge_sel_sew64[203 +:4],3'h3,e0c_merge_sel_sew64[203 +:4],3'h2,e0c_merge_sel_sew64[203 +:4],3'h1,e0c_merge_sel_sew64[203 +:4],3'h0,e0c_merge_sel_sew64[196 +:4],3'h7,e0c_merge_sel_sew64[196 +:4],3'h6,e0c_merge_sel_sew64[196 +:4],3'h5,e0c_merge_sel_sew64[196 +:4],3'h4,e0c_merge_sel_sew64[196 +:4],3'h3,e0c_merge_sel_sew64[196 +:4],3'h2,e0c_merge_sel_sew64[196 +:4],3'h1,e0c_merge_sel_sew64[196 +:4],3'h0,e0c_merge_sel_sew64[189 +:4],3'h7,e0c_merge_sel_sew64[189 +:4],3'h6,e0c_merge_sel_sew64[189 +:4],3'h5,e0c_merge_sel_sew64[189 +:4],3'h4,e0c_merge_sel_sew64[189 +:4],3'h3,e0c_merge_sel_sew64[189 +:4],3'h2,e0c_merge_sel_sew64[189 +:4],3'h1,e0c_merge_sel_sew64[189 +:4],3'h0,e0c_merge_sel_sew64[182 +:4],3'h7,e0c_merge_sel_sew64[182 +:4],3'h6,e0c_merge_sel_sew64[182 +:4],3'h5,e0c_merge_sel_sew64[182 +:4],3'h4,e0c_merge_sel_sew64[182 +:4],3'h3,e0c_merge_sel_sew64[182 +:4],3'h2,e0c_merge_sel_sew64[182 +:4],3'h1,e0c_merge_sel_sew64[182 +:4],3'h0,e0c_merge_sel_sew64[175 +:4],3'h7,e0c_merge_sel_sew64[175 +:4],3'h6,e0c_merge_sel_sew64[175 +:4],3'h5,e0c_merge_sel_sew64[175 +:4],3'h4,e0c_merge_sel_sew64[175 +:4],3'h3,e0c_merge_sel_sew64[175 +:4],3'h2,e0c_merge_sel_sew64[175 +:4],3'h1,e0c_merge_sel_sew64[175 +:4],3'h0,e0c_merge_sel_sew64[168 +:4],3'h7,e0c_merge_sel_sew64[168 +:4],3'h6,e0c_merge_sel_sew64[168 +:4],3'h5,e0c_merge_sel_sew64[168 +:4],3'h4,e0c_merge_sel_sew64[168 +:4],3'h3,e0c_merge_sel_sew64[168 +:4],3'h2,e0c_merge_sel_sew64[168 +:4],3'h1,e0c_merge_sel_sew64[168 +:4],3'h0,e0c_merge_sel_sew64[161 +:4],3'h7,e0c_merge_sel_sew64[161 +:4],3'h6,e0c_merge_sel_sew64[161 +:4],3'h5,e0c_merge_sel_sew64[161 +:4],3'h4,e0c_merge_sel_sew64[161 +:4],3'h3,e0c_merge_sel_sew64[161 +:4],3'h2,e0c_merge_sel_sew64[161 +:4],3'h1,e0c_merge_sel_sew64[161 +:4],3'h0,e0c_merge_sel_sew64[154 +:4],3'h7,e0c_merge_sel_sew64[154 +:4],3'h6,e0c_merge_sel_sew64[154 +:4],3'h5,e0c_merge_sel_sew64[154 +:4],3'h4,e0c_merge_sel_sew64[154 +:4],3'h3,e0c_merge_sel_sew64[154 +:4],3'h2,e0c_merge_sel_sew64[154 +:4],3'h1,e0c_merge_sel_sew64[154 +:4],3'h0,e0c_merge_sel_sew64[147 +:4],3'h7,e0c_merge_sel_sew64[147 +:4],3'h6,e0c_merge_sel_sew64[147 +:4],3'h5,e0c_merge_sel_sew64[147 +:4],3'h4,e0c_merge_sel_sew64[147 +:4],3'h3,e0c_merge_sel_sew64[147 +:4],3'h2,e0c_merge_sel_sew64[147 +:4],3'h1,e0c_merge_sel_sew64[147 +:4],3'h0,e0c_merge_sel_sew64[140 +:4],3'h7,e0c_merge_sel_sew64[140 +:4],3'h6,e0c_merge_sel_sew64[140 +:4],3'h5,e0c_merge_sel_sew64[140 +:4],3'h4,e0c_merge_sel_sew64[140 +:4],3'h3,e0c_merge_sel_sew64[140 +:4],3'h2,e0c_merge_sel_sew64[140 +:4],3'h1,e0c_merge_sel_sew64[140 +:4],3'h0,e0c_merge_sel_sew64[133 +:4],3'h7,e0c_merge_sel_sew64[133 +:4],3'h6,e0c_merge_sel_sew64[133 +:4],3'h5,e0c_merge_sel_sew64[133 +:4],3'h4,e0c_merge_sel_sew64[133 +:4],3'h3,e0c_merge_sel_sew64[133 +:4],3'h2,e0c_merge_sel_sew64[133 +:4],3'h1,e0c_merge_sel_sew64[133 +:4],3'h0,e0c_merge_sel_sew64[126 +:4],3'h7,e0c_merge_sel_sew64[126 +:4],3'h6,e0c_merge_sel_sew64[126 +:4],3'h5,e0c_merge_sel_sew64[126 +:4],3'h4,e0c_merge_sel_sew64[126 +:4],3'h3,e0c_merge_sel_sew64[126 +:4],3'h2,e0c_merge_sel_sew64[126 +:4],3'h1,e0c_merge_sel_sew64[126 +:4],3'h0,e0c_merge_sel_sew64[119 +:4],3'h7,e0c_merge_sel_sew64[119 +:4],3'h6,e0c_merge_sel_sew64[119 +:4],3'h5,e0c_merge_sel_sew64[119 +:4],3'h4,e0c_merge_sel_sew64[119 +:4],3'h3,e0c_merge_sel_sew64[119 +:4],3'h2,e0c_merge_sel_sew64[119 +:4],3'h1,e0c_merge_sel_sew64[119 +:4],3'h0,e0c_merge_sel_sew64[112 +:4],3'h7,e0c_merge_sel_sew64[112 +:4],3'h6,e0c_merge_sel_sew64[112 +:4],3'h5,e0c_merge_sel_sew64[112 +:4],3'h4,e0c_merge_sel_sew64[112 +:4],3'h3,e0c_merge_sel_sew64[112 +:4],3'h2,e0c_merge_sel_sew64[112 +:4],3'h1,e0c_merge_sel_sew64[112 +:4],3'h0,e0c_merge_sel_sew64[105 +:4],3'h7,e0c_merge_sel_sew64[105 +:4],3'h6,e0c_merge_sel_sew64[105 +:4],3'h5,e0c_merge_sel_sew64[105 +:4],3'h4,e0c_merge_sel_sew64[105 +:4],3'h3,e0c_merge_sel_sew64[105 +:4],3'h2,e0c_merge_sel_sew64[105 +:4],3'h1,e0c_merge_sel_sew64[105 +:4],3'h0,e0c_merge_sel_sew64[98 +:4],3'h7,e0c_merge_sel_sew64[98 +:4],3'h6,e0c_merge_sel_sew64[98 +:4],3'h5,e0c_merge_sel_sew64[98 +:4],3'h4,e0c_merge_sel_sew64[98 +:4],3'h3,e0c_merge_sel_sew64[98 +:4],3'h2,e0c_merge_sel_sew64[98 +:4],3'h1,e0c_merge_sel_sew64[98 +:4],3'h0,e0c_merge_sel_sew64[91 +:4],3'h7,e0c_merge_sel_sew64[91 +:4],3'h6,e0c_merge_sel_sew64[91 +:4],3'h5,e0c_merge_sel_sew64[91 +:4],3'h4,e0c_merge_sel_sew64[91 +:4],3'h3,e0c_merge_sel_sew64[91 +:4],3'h2,e0c_merge_sel_sew64[91 +:4],3'h1,e0c_merge_sel_sew64[91 +:4],3'h0,e0c_merge_sel_sew64[84 +:4],3'h7,e0c_merge_sel_sew64[84 +:4],3'h6,e0c_merge_sel_sew64[84 +:4],3'h5,e0c_merge_sel_sew64[84 +:4],3'h4,e0c_merge_sel_sew64[84 +:4],3'h3,e0c_merge_sel_sew64[84 +:4],3'h2,e0c_merge_sel_sew64[84 +:4],3'h1,e0c_merge_sel_sew64[84 +:4],3'h0,e0c_merge_sel_sew64[77 +:4],3'h7,e0c_merge_sel_sew64[77 +:4],3'h6,e0c_merge_sel_sew64[77 +:4],3'h5,e0c_merge_sel_sew64[77 +:4],3'h4,e0c_merge_sel_sew64[77 +:4],3'h3,e0c_merge_sel_sew64[77 +:4],3'h2,e0c_merge_sel_sew64[77 +:4],3'h1,e0c_merge_sel_sew64[77 +:4],3'h0,e0c_merge_sel_sew64[70 +:4],3'h7,e0c_merge_sel_sew64[70 +:4],3'h6,e0c_merge_sel_sew64[70 +:4],3'h5,e0c_merge_sel_sew64[70 +:4],3'h4,e0c_merge_sel_sew64[70 +:4],3'h3,e0c_merge_sel_sew64[70 +:4],3'h2,e0c_merge_sel_sew64[70 +:4],3'h1,e0c_merge_sel_sew64[70 +:4],3'h0,e0c_merge_sel_sew64[63 +:4],3'h7,e0c_merge_sel_sew64[63 +:4],3'h6,e0c_merge_sel_sew64[63 +:4],3'h5,e0c_merge_sel_sew64[63 +:4],3'h4,e0c_merge_sel_sew64[63 +:4],3'h3,e0c_merge_sel_sew64[63 +:4],3'h2,e0c_merge_sel_sew64[63 +:4],3'h1,e0c_merge_sel_sew64[63 +:4],3'h0,e0c_merge_sel_sew64[56 +:4],3'h7,e0c_merge_sel_sew64[56 +:4],3'h6,e0c_merge_sel_sew64[56 +:4],3'h5,e0c_merge_sel_sew64[56 +:4],3'h4,e0c_merge_sel_sew64[56 +:4],3'h3,e0c_merge_sel_sew64[56 +:4],3'h2,e0c_merge_sel_sew64[56 +:4],3'h1,e0c_merge_sel_sew64[56 +:4],3'h0,e0c_merge_sel_sew64[49 +:4],3'h7,e0c_merge_sel_sew64[49 +:4],3'h6,e0c_merge_sel_sew64[49 +:4],3'h5,e0c_merge_sel_sew64[49 +:4],3'h4,e0c_merge_sel_sew64[49 +:4],3'h3,e0c_merge_sel_sew64[49 +:4],3'h2,e0c_merge_sel_sew64[49 +:4],3'h1,e0c_merge_sel_sew64[49 +:4],3'h0,e0c_merge_sel_sew64[42 +:4],3'h7,e0c_merge_sel_sew64[42 +:4],3'h6,e0c_merge_sel_sew64[42 +:4],3'h5,e0c_merge_sel_sew64[42 +:4],3'h4,e0c_merge_sel_sew64[42 +:4],3'h3,e0c_merge_sel_sew64[42 +:4],3'h2,e0c_merge_sel_sew64[42 +:4],3'h1,e0c_merge_sel_sew64[42 +:4],3'h0,e0c_merge_sel_sew64[35 +:4],3'h7,e0c_merge_sel_sew64[35 +:4],3'h6,e0c_merge_sel_sew64[35 +:4],3'h5,e0c_merge_sel_sew64[35 +:4],3'h4,e0c_merge_sel_sew64[35 +:4],3'h3,e0c_merge_sel_sew64[35 +:4],3'h2,e0c_merge_sel_sew64[35 +:4],3'h1,e0c_merge_sel_sew64[35 +:4],3'h0,e0c_merge_sel_sew64[28 +:4],3'h7,e0c_merge_sel_sew64[28 +:4],3'h6,e0c_merge_sel_sew64[28 +:4],3'h5,e0c_merge_sel_sew64[28 +:4],3'h4,e0c_merge_sel_sew64[28 +:4],3'h3,e0c_merge_sel_sew64[28 +:4],3'h2,e0c_merge_sel_sew64[28 +:4],3'h1,e0c_merge_sel_sew64[28 +:4],3'h0,e0c_merge_sel_sew64[21 +:4],3'h7,e0c_merge_sel_sew64[21 +:4],3'h6,e0c_merge_sel_sew64[21 +:4],3'h5,e0c_merge_sel_sew64[21 +:4],3'h4,e0c_merge_sel_sew64[21 +:4],3'h3,e0c_merge_sel_sew64[21 +:4],3'h2,e0c_merge_sel_sew64[21 +:4],3'h1,e0c_merge_sel_sew64[21 +:4],3'h0,e0c_merge_sel_sew64[14 +:4],3'h7,e0c_merge_sel_sew64[14 +:4],3'h6,e0c_merge_sel_sew64[14 +:4],3'h5,e0c_merge_sel_sew64[14 +:4],3'h4,e0c_merge_sel_sew64[14 +:4],3'h3,e0c_merge_sel_sew64[14 +:4],3'h2,e0c_merge_sel_sew64[14 +:4],3'h1,e0c_merge_sel_sew64[14 +:4],3'h0,e0c_merge_sel_sew64[7 +:4],3'h7,e0c_merge_sel_sew64[7 +:4],3'h6,e0c_merge_sel_sew64[7 +:4],3'h5,e0c_merge_sel_sew64[7 +:4],3'h4,e0c_merge_sel_sew64[7 +:4],3'h3,e0c_merge_sel_sew64[7 +:4],3'h2,e0c_merge_sel_sew64[7 +:4],3'h1,e0c_merge_sel_sew64[7 +:4],3'h0,e0c_merge_sel_sew64[0 +:4],3'h7,e0c_merge_sel_sew64[0 +:4],3'h6,e0c_merge_sel_sew64[0 +:4],3'h5,e0c_merge_sel_sew64[0 +:4],3'h4,e0c_merge_sel_sew64[0 +:4],3'h3,e0c_merge_sel_sew64[0 +:4],3'h2,e0c_merge_sel_sew64[0 +:4],3'h1,e0c_merge_sel_sew64[0 +:4],3'h0};
        wire [256 * 7:0] e0c_exp_sel_sew32 = {1'b0,e0c_merge_sel_sew32[441 +:5],2'h3,e0c_merge_sel_sew32[441 +:5],2'h2,e0c_merge_sel_sew32[441 +:5],2'h1,e0c_merge_sel_sew32[441 +:5],2'h0,e0c_merge_sel_sew32[434 +:5],2'h3,e0c_merge_sel_sew32[434 +:5],2'h2,e0c_merge_sel_sew32[434 +:5],2'h1,e0c_merge_sel_sew32[434 +:5],2'h0,e0c_merge_sel_sew32[427 +:5],2'h3,e0c_merge_sel_sew32[427 +:5],2'h2,e0c_merge_sel_sew32[427 +:5],2'h1,e0c_merge_sel_sew32[427 +:5],2'h0,e0c_merge_sel_sew32[420 +:5],2'h3,e0c_merge_sel_sew32[420 +:5],2'h2,e0c_merge_sel_sew32[420 +:5],2'h1,e0c_merge_sel_sew32[420 +:5],2'h0,e0c_merge_sel_sew32[413 +:5],2'h3,e0c_merge_sel_sew32[413 +:5],2'h2,e0c_merge_sel_sew32[413 +:5],2'h1,e0c_merge_sel_sew32[413 +:5],2'h0,e0c_merge_sel_sew32[406 +:5],2'h3,e0c_merge_sel_sew32[406 +:5],2'h2,e0c_merge_sel_sew32[406 +:5],2'h1,e0c_merge_sel_sew32[406 +:5],2'h0,e0c_merge_sel_sew32[399 +:5],2'h3,e0c_merge_sel_sew32[399 +:5],2'h2,e0c_merge_sel_sew32[399 +:5],2'h1,e0c_merge_sel_sew32[399 +:5],2'h0,e0c_merge_sel_sew32[392 +:5],2'h3,e0c_merge_sel_sew32[392 +:5],2'h2,e0c_merge_sel_sew32[392 +:5],2'h1,e0c_merge_sel_sew32[392 +:5],2'h0,e0c_merge_sel_sew32[385 +:5],2'h3,e0c_merge_sel_sew32[385 +:5],2'h2,e0c_merge_sel_sew32[385 +:5],2'h1,e0c_merge_sel_sew32[385 +:5],2'h0,e0c_merge_sel_sew32[378 +:5],2'h3,e0c_merge_sel_sew32[378 +:5],2'h2,e0c_merge_sel_sew32[378 +:5],2'h1,e0c_merge_sel_sew32[378 +:5],2'h0,e0c_merge_sel_sew32[371 +:5],2'h3,e0c_merge_sel_sew32[371 +:5],2'h2,e0c_merge_sel_sew32[371 +:5],2'h1,e0c_merge_sel_sew32[371 +:5],2'h0,e0c_merge_sel_sew32[364 +:5],2'h3,e0c_merge_sel_sew32[364 +:5],2'h2,e0c_merge_sel_sew32[364 +:5],2'h1,e0c_merge_sel_sew32[364 +:5],2'h0,e0c_merge_sel_sew32[357 +:5],2'h3,e0c_merge_sel_sew32[357 +:5],2'h2,e0c_merge_sel_sew32[357 +:5],2'h1,e0c_merge_sel_sew32[357 +:5],2'h0,e0c_merge_sel_sew32[350 +:5],2'h3,e0c_merge_sel_sew32[350 +:5],2'h2,e0c_merge_sel_sew32[350 +:5],2'h1,e0c_merge_sel_sew32[350 +:5],2'h0,e0c_merge_sel_sew32[343 +:5],2'h3,e0c_merge_sel_sew32[343 +:5],2'h2,e0c_merge_sel_sew32[343 +:5],2'h1,e0c_merge_sel_sew32[343 +:5],2'h0,e0c_merge_sel_sew32[336 +:5],2'h3,e0c_merge_sel_sew32[336 +:5],2'h2,e0c_merge_sel_sew32[336 +:5],2'h1,e0c_merge_sel_sew32[336 +:5],2'h0,e0c_merge_sel_sew32[329 +:5],2'h3,e0c_merge_sel_sew32[329 +:5],2'h2,e0c_merge_sel_sew32[329 +:5],2'h1,e0c_merge_sel_sew32[329 +:5],2'h0,e0c_merge_sel_sew32[322 +:5],2'h3,e0c_merge_sel_sew32[322 +:5],2'h2,e0c_merge_sel_sew32[322 +:5],2'h1,e0c_merge_sel_sew32[322 +:5],2'h0,e0c_merge_sel_sew32[315 +:5],2'h3,e0c_merge_sel_sew32[315 +:5],2'h2,e0c_merge_sel_sew32[315 +:5],2'h1,e0c_merge_sel_sew32[315 +:5],2'h0,e0c_merge_sel_sew32[308 +:5],2'h3,e0c_merge_sel_sew32[308 +:5],2'h2,e0c_merge_sel_sew32[308 +:5],2'h1,e0c_merge_sel_sew32[308 +:5],2'h0,e0c_merge_sel_sew32[301 +:5],2'h3,e0c_merge_sel_sew32[301 +:5],2'h2,e0c_merge_sel_sew32[301 +:5],2'h1,e0c_merge_sel_sew32[301 +:5],2'h0,e0c_merge_sel_sew32[294 +:5],2'h3,e0c_merge_sel_sew32[294 +:5],2'h2,e0c_merge_sel_sew32[294 +:5],2'h1,e0c_merge_sel_sew32[294 +:5],2'h0,e0c_merge_sel_sew32[287 +:5],2'h3,e0c_merge_sel_sew32[287 +:5],2'h2,e0c_merge_sel_sew32[287 +:5],2'h1,e0c_merge_sel_sew32[287 +:5],2'h0,e0c_merge_sel_sew32[280 +:5],2'h3,e0c_merge_sel_sew32[280 +:5],2'h2,e0c_merge_sel_sew32[280 +:5],2'h1,e0c_merge_sel_sew32[280 +:5],2'h0,e0c_merge_sel_sew32[273 +:5],2'h3,e0c_merge_sel_sew32[273 +:5],2'h2,e0c_merge_sel_sew32[273 +:5],2'h1,e0c_merge_sel_sew32[273 +:5],2'h0,e0c_merge_sel_sew32[266 +:5],2'h3,e0c_merge_sel_sew32[266 +:5],2'h2,e0c_merge_sel_sew32[266 +:5],2'h1,e0c_merge_sel_sew32[266 +:5],2'h0,e0c_merge_sel_sew32[259 +:5],2'h3,e0c_merge_sel_sew32[259 +:5],2'h2,e0c_merge_sel_sew32[259 +:5],2'h1,e0c_merge_sel_sew32[259 +:5],2'h0,e0c_merge_sel_sew32[252 +:5],2'h3,e0c_merge_sel_sew32[252 +:5],2'h2,e0c_merge_sel_sew32[252 +:5],2'h1,e0c_merge_sel_sew32[252 +:5],2'h0,e0c_merge_sel_sew32[245 +:5],2'h3,e0c_merge_sel_sew32[245 +:5],2'h2,e0c_merge_sel_sew32[245 +:5],2'h1,e0c_merge_sel_sew32[245 +:5],2'h0,e0c_merge_sel_sew32[238 +:5],2'h3,e0c_merge_sel_sew32[238 +:5],2'h2,e0c_merge_sel_sew32[238 +:5],2'h1,e0c_merge_sel_sew32[238 +:5],2'h0,e0c_merge_sel_sew32[231 +:5],2'h3,e0c_merge_sel_sew32[231 +:5],2'h2,e0c_merge_sel_sew32[231 +:5],2'h1,e0c_merge_sel_sew32[231 +:5],2'h0,e0c_merge_sel_sew32[224 +:5],2'h3,e0c_merge_sel_sew32[224 +:5],2'h2,e0c_merge_sel_sew32[224 +:5],2'h1,e0c_merge_sel_sew32[224 +:5],2'h0,e0c_merge_sel_sew32[217 +:5],2'h3,e0c_merge_sel_sew32[217 +:5],2'h2,e0c_merge_sel_sew32[217 +:5],2'h1,e0c_merge_sel_sew32[217 +:5],2'h0,e0c_merge_sel_sew32[210 +:5],2'h3,e0c_merge_sel_sew32[210 +:5],2'h2,e0c_merge_sel_sew32[210 +:5],2'h1,e0c_merge_sel_sew32[210 +:5],2'h0,e0c_merge_sel_sew32[203 +:5],2'h3,e0c_merge_sel_sew32[203 +:5],2'h2,e0c_merge_sel_sew32[203 +:5],2'h1,e0c_merge_sel_sew32[203 +:5],2'h0,e0c_merge_sel_sew32[196 +:5],2'h3,e0c_merge_sel_sew32[196 +:5],2'h2,e0c_merge_sel_sew32[196 +:5],2'h1,e0c_merge_sel_sew32[196 +:5],2'h0,e0c_merge_sel_sew32[189 +:5],2'h3,e0c_merge_sel_sew32[189 +:5],2'h2,e0c_merge_sel_sew32[189 +:5],2'h1,e0c_merge_sel_sew32[189 +:5],2'h0,e0c_merge_sel_sew32[182 +:5],2'h3,e0c_merge_sel_sew32[182 +:5],2'h2,e0c_merge_sel_sew32[182 +:5],2'h1,e0c_merge_sel_sew32[182 +:5],2'h0,e0c_merge_sel_sew32[175 +:5],2'h3,e0c_merge_sel_sew32[175 +:5],2'h2,e0c_merge_sel_sew32[175 +:5],2'h1,e0c_merge_sel_sew32[175 +:5],2'h0,e0c_merge_sel_sew32[168 +:5],2'h3,e0c_merge_sel_sew32[168 +:5],2'h2,e0c_merge_sel_sew32[168 +:5],2'h1,e0c_merge_sel_sew32[168 +:5],2'h0,e0c_merge_sel_sew32[161 +:5],2'h3,e0c_merge_sel_sew32[161 +:5],2'h2,e0c_merge_sel_sew32[161 +:5],2'h1,e0c_merge_sel_sew32[161 +:5],2'h0,e0c_merge_sel_sew32[154 +:5],2'h3,e0c_merge_sel_sew32[154 +:5],2'h2,e0c_merge_sel_sew32[154 +:5],2'h1,e0c_merge_sel_sew32[154 +:5],2'h0,e0c_merge_sel_sew32[147 +:5],2'h3,e0c_merge_sel_sew32[147 +:5],2'h2,e0c_merge_sel_sew32[147 +:5],2'h1,e0c_merge_sel_sew32[147 +:5],2'h0,e0c_merge_sel_sew32[140 +:5],2'h3,e0c_merge_sel_sew32[140 +:5],2'h2,e0c_merge_sel_sew32[140 +:5],2'h1,e0c_merge_sel_sew32[140 +:5],2'h0,e0c_merge_sel_sew32[133 +:5],2'h3,e0c_merge_sel_sew32[133 +:5],2'h2,e0c_merge_sel_sew32[133 +:5],2'h1,e0c_merge_sel_sew32[133 +:5],2'h0,e0c_merge_sel_sew32[126 +:5],2'h3,e0c_merge_sel_sew32[126 +:5],2'h2,e0c_merge_sel_sew32[126 +:5],2'h1,e0c_merge_sel_sew32[126 +:5],2'h0,e0c_merge_sel_sew32[119 +:5],2'h3,e0c_merge_sel_sew32[119 +:5],2'h2,e0c_merge_sel_sew32[119 +:5],2'h1,e0c_merge_sel_sew32[119 +:5],2'h0,e0c_merge_sel_sew32[112 +:5],2'h3,e0c_merge_sel_sew32[112 +:5],2'h2,e0c_merge_sel_sew32[112 +:5],2'h1,e0c_merge_sel_sew32[112 +:5],2'h0,e0c_merge_sel_sew32[105 +:5],2'h3,e0c_merge_sel_sew32[105 +:5],2'h2,e0c_merge_sel_sew32[105 +:5],2'h1,e0c_merge_sel_sew32[105 +:5],2'h0,e0c_merge_sel_sew32[98 +:5],2'h3,e0c_merge_sel_sew32[98 +:5],2'h2,e0c_merge_sel_sew32[98 +:5],2'h1,e0c_merge_sel_sew32[98 +:5],2'h0,e0c_merge_sel_sew32[91 +:5],2'h3,e0c_merge_sel_sew32[91 +:5],2'h2,e0c_merge_sel_sew32[91 +:5],2'h1,e0c_merge_sel_sew32[91 +:5],2'h0,e0c_merge_sel_sew32[84 +:5],2'h3,e0c_merge_sel_sew32[84 +:5],2'h2,e0c_merge_sel_sew32[84 +:5],2'h1,e0c_merge_sel_sew32[84 +:5],2'h0,e0c_merge_sel_sew32[77 +:5],2'h3,e0c_merge_sel_sew32[77 +:5],2'h2,e0c_merge_sel_sew32[77 +:5],2'h1,e0c_merge_sel_sew32[77 +:5],2'h0,e0c_merge_sel_sew32[70 +:5],2'h3,e0c_merge_sel_sew32[70 +:5],2'h2,e0c_merge_sel_sew32[70 +:5],2'h1,e0c_merge_sel_sew32[70 +:5],2'h0,e0c_merge_sel_sew32[63 +:5],2'h3,e0c_merge_sel_sew32[63 +:5],2'h2,e0c_merge_sel_sew32[63 +:5],2'h1,e0c_merge_sel_sew32[63 +:5],2'h0,e0c_merge_sel_sew32[56 +:5],2'h3,e0c_merge_sel_sew32[56 +:5],2'h2,e0c_merge_sel_sew32[56 +:5],2'h1,e0c_merge_sel_sew32[56 +:5],2'h0,e0c_merge_sel_sew32[49 +:5],2'h3,e0c_merge_sel_sew32[49 +:5],2'h2,e0c_merge_sel_sew32[49 +:5],2'h1,e0c_merge_sel_sew32[49 +:5],2'h0,e0c_merge_sel_sew32[42 +:5],2'h3,e0c_merge_sel_sew32[42 +:5],2'h2,e0c_merge_sel_sew32[42 +:5],2'h1,e0c_merge_sel_sew32[42 +:5],2'h0,e0c_merge_sel_sew32[35 +:5],2'h3,e0c_merge_sel_sew32[35 +:5],2'h2,e0c_merge_sel_sew32[35 +:5],2'h1,e0c_merge_sel_sew32[35 +:5],2'h0,e0c_merge_sel_sew32[28 +:5],2'h3,e0c_merge_sel_sew32[28 +:5],2'h2,e0c_merge_sel_sew32[28 +:5],2'h1,e0c_merge_sel_sew32[28 +:5],2'h0,e0c_merge_sel_sew32[21 +:5],2'h3,e0c_merge_sel_sew32[21 +:5],2'h2,e0c_merge_sel_sew32[21 +:5],2'h1,e0c_merge_sel_sew32[21 +:5],2'h0,e0c_merge_sel_sew32[14 +:5],2'h3,e0c_merge_sel_sew32[14 +:5],2'h2,e0c_merge_sel_sew32[14 +:5],2'h1,e0c_merge_sel_sew32[14 +:5],2'h0,e0c_merge_sel_sew32[7 +:5],2'h3,e0c_merge_sel_sew32[7 +:5],2'h2,e0c_merge_sel_sew32[7 +:5],2'h1,e0c_merge_sel_sew32[7 +:5],2'h0,e0c_merge_sel_sew32[0 +:5],2'h3,e0c_merge_sel_sew32[0 +:5],2'h2,e0c_merge_sel_sew32[0 +:5],2'h1,e0c_merge_sel_sew32[0 +:5],2'h0};
        wire [256 * 7:0] e0c_exp_sel_sew16 = {1'b0,e0c_merge_sel_sew16[889 +:6],1'h1,e0c_merge_sel_sew16[889 +:6],1'h0,e0c_merge_sel_sew16[882 +:6],1'h1,e0c_merge_sel_sew16[882 +:6],1'h0,e0c_merge_sel_sew16[875 +:6],1'h1,e0c_merge_sel_sew16[875 +:6],1'h0,e0c_merge_sel_sew16[868 +:6],1'h1,e0c_merge_sel_sew16[868 +:6],1'h0,e0c_merge_sel_sew16[861 +:6],1'h1,e0c_merge_sel_sew16[861 +:6],1'h0,e0c_merge_sel_sew16[854 +:6],1'h1,e0c_merge_sel_sew16[854 +:6],1'h0,e0c_merge_sel_sew16[847 +:6],1'h1,e0c_merge_sel_sew16[847 +:6],1'h0,e0c_merge_sel_sew16[840 +:6],1'h1,e0c_merge_sel_sew16[840 +:6],1'h0,e0c_merge_sel_sew16[833 +:6],1'h1,e0c_merge_sel_sew16[833 +:6],1'h0,e0c_merge_sel_sew16[826 +:6],1'h1,e0c_merge_sel_sew16[826 +:6],1'h0,e0c_merge_sel_sew16[819 +:6],1'h1,e0c_merge_sel_sew16[819 +:6],1'h0,e0c_merge_sel_sew16[812 +:6],1'h1,e0c_merge_sel_sew16[812 +:6],1'h0,e0c_merge_sel_sew16[805 +:6],1'h1,e0c_merge_sel_sew16[805 +:6],1'h0,e0c_merge_sel_sew16[798 +:6],1'h1,e0c_merge_sel_sew16[798 +:6],1'h0,e0c_merge_sel_sew16[791 +:6],1'h1,e0c_merge_sel_sew16[791 +:6],1'h0,e0c_merge_sel_sew16[784 +:6],1'h1,e0c_merge_sel_sew16[784 +:6],1'h0,e0c_merge_sel_sew16[777 +:6],1'h1,e0c_merge_sel_sew16[777 +:6],1'h0,e0c_merge_sel_sew16[770 +:6],1'h1,e0c_merge_sel_sew16[770 +:6],1'h0,e0c_merge_sel_sew16[763 +:6],1'h1,e0c_merge_sel_sew16[763 +:6],1'h0,e0c_merge_sel_sew16[756 +:6],1'h1,e0c_merge_sel_sew16[756 +:6],1'h0,e0c_merge_sel_sew16[749 +:6],1'h1,e0c_merge_sel_sew16[749 +:6],1'h0,e0c_merge_sel_sew16[742 +:6],1'h1,e0c_merge_sel_sew16[742 +:6],1'h0,e0c_merge_sel_sew16[735 +:6],1'h1,e0c_merge_sel_sew16[735 +:6],1'h0,e0c_merge_sel_sew16[728 +:6],1'h1,e0c_merge_sel_sew16[728 +:6],1'h0,e0c_merge_sel_sew16[721 +:6],1'h1,e0c_merge_sel_sew16[721 +:6],1'h0,e0c_merge_sel_sew16[714 +:6],1'h1,e0c_merge_sel_sew16[714 +:6],1'h0,e0c_merge_sel_sew16[707 +:6],1'h1,e0c_merge_sel_sew16[707 +:6],1'h0,e0c_merge_sel_sew16[700 +:6],1'h1,e0c_merge_sel_sew16[700 +:6],1'h0,e0c_merge_sel_sew16[693 +:6],1'h1,e0c_merge_sel_sew16[693 +:6],1'h0,e0c_merge_sel_sew16[686 +:6],1'h1,e0c_merge_sel_sew16[686 +:6],1'h0,e0c_merge_sel_sew16[679 +:6],1'h1,e0c_merge_sel_sew16[679 +:6],1'h0,e0c_merge_sel_sew16[672 +:6],1'h1,e0c_merge_sel_sew16[672 +:6],1'h0,e0c_merge_sel_sew16[665 +:6],1'h1,e0c_merge_sel_sew16[665 +:6],1'h0,e0c_merge_sel_sew16[658 +:6],1'h1,e0c_merge_sel_sew16[658 +:6],1'h0,e0c_merge_sel_sew16[651 +:6],1'h1,e0c_merge_sel_sew16[651 +:6],1'h0,e0c_merge_sel_sew16[644 +:6],1'h1,e0c_merge_sel_sew16[644 +:6],1'h0,e0c_merge_sel_sew16[637 +:6],1'h1,e0c_merge_sel_sew16[637 +:6],1'h0,e0c_merge_sel_sew16[630 +:6],1'h1,e0c_merge_sel_sew16[630 +:6],1'h0,e0c_merge_sel_sew16[623 +:6],1'h1,e0c_merge_sel_sew16[623 +:6],1'h0,e0c_merge_sel_sew16[616 +:6],1'h1,e0c_merge_sel_sew16[616 +:6],1'h0,e0c_merge_sel_sew16[609 +:6],1'h1,e0c_merge_sel_sew16[609 +:6],1'h0,e0c_merge_sel_sew16[602 +:6],1'h1,e0c_merge_sel_sew16[602 +:6],1'h0,e0c_merge_sel_sew16[595 +:6],1'h1,e0c_merge_sel_sew16[595 +:6],1'h0,e0c_merge_sel_sew16[588 +:6],1'h1,e0c_merge_sel_sew16[588 +:6],1'h0,e0c_merge_sel_sew16[581 +:6],1'h1,e0c_merge_sel_sew16[581 +:6],1'h0,e0c_merge_sel_sew16[574 +:6],1'h1,e0c_merge_sel_sew16[574 +:6],1'h0,e0c_merge_sel_sew16[567 +:6],1'h1,e0c_merge_sel_sew16[567 +:6],1'h0,e0c_merge_sel_sew16[560 +:6],1'h1,e0c_merge_sel_sew16[560 +:6],1'h0,e0c_merge_sel_sew16[553 +:6],1'h1,e0c_merge_sel_sew16[553 +:6],1'h0,e0c_merge_sel_sew16[546 +:6],1'h1,e0c_merge_sel_sew16[546 +:6],1'h0,e0c_merge_sel_sew16[539 +:6],1'h1,e0c_merge_sel_sew16[539 +:6],1'h0,e0c_merge_sel_sew16[532 +:6],1'h1,e0c_merge_sel_sew16[532 +:6],1'h0,e0c_merge_sel_sew16[525 +:6],1'h1,e0c_merge_sel_sew16[525 +:6],1'h0,e0c_merge_sel_sew16[518 +:6],1'h1,e0c_merge_sel_sew16[518 +:6],1'h0,e0c_merge_sel_sew16[511 +:6],1'h1,e0c_merge_sel_sew16[511 +:6],1'h0,e0c_merge_sel_sew16[504 +:6],1'h1,e0c_merge_sel_sew16[504 +:6],1'h0,e0c_merge_sel_sew16[497 +:6],1'h1,e0c_merge_sel_sew16[497 +:6],1'h0,e0c_merge_sel_sew16[490 +:6],1'h1,e0c_merge_sel_sew16[490 +:6],1'h0,e0c_merge_sel_sew16[483 +:6],1'h1,e0c_merge_sel_sew16[483 +:6],1'h0,e0c_merge_sel_sew16[476 +:6],1'h1,e0c_merge_sel_sew16[476 +:6],1'h0,e0c_merge_sel_sew16[469 +:6],1'h1,e0c_merge_sel_sew16[469 +:6],1'h0,e0c_merge_sel_sew16[462 +:6],1'h1,e0c_merge_sel_sew16[462 +:6],1'h0,e0c_merge_sel_sew16[455 +:6],1'h1,e0c_merge_sel_sew16[455 +:6],1'h0,e0c_merge_sel_sew16[448 +:6],1'h1,e0c_merge_sel_sew16[448 +:6],1'h0,e0c_merge_sel_sew16[441 +:6],1'h1,e0c_merge_sel_sew16[441 +:6],1'h0,e0c_merge_sel_sew16[434 +:6],1'h1,e0c_merge_sel_sew16[434 +:6],1'h0,e0c_merge_sel_sew16[427 +:6],1'h1,e0c_merge_sel_sew16[427 +:6],1'h0,e0c_merge_sel_sew16[420 +:6],1'h1,e0c_merge_sel_sew16[420 +:6],1'h0,e0c_merge_sel_sew16[413 +:6],1'h1,e0c_merge_sel_sew16[413 +:6],1'h0,e0c_merge_sel_sew16[406 +:6],1'h1,e0c_merge_sel_sew16[406 +:6],1'h0,e0c_merge_sel_sew16[399 +:6],1'h1,e0c_merge_sel_sew16[399 +:6],1'h0,e0c_merge_sel_sew16[392 +:6],1'h1,e0c_merge_sel_sew16[392 +:6],1'h0,e0c_merge_sel_sew16[385 +:6],1'h1,e0c_merge_sel_sew16[385 +:6],1'h0,e0c_merge_sel_sew16[378 +:6],1'h1,e0c_merge_sel_sew16[378 +:6],1'h0,e0c_merge_sel_sew16[371 +:6],1'h1,e0c_merge_sel_sew16[371 +:6],1'h0,e0c_merge_sel_sew16[364 +:6],1'h1,e0c_merge_sel_sew16[364 +:6],1'h0,e0c_merge_sel_sew16[357 +:6],1'h1,e0c_merge_sel_sew16[357 +:6],1'h0,e0c_merge_sel_sew16[350 +:6],1'h1,e0c_merge_sel_sew16[350 +:6],1'h0,e0c_merge_sel_sew16[343 +:6],1'h1,e0c_merge_sel_sew16[343 +:6],1'h0,e0c_merge_sel_sew16[336 +:6],1'h1,e0c_merge_sel_sew16[336 +:6],1'h0,e0c_merge_sel_sew16[329 +:6],1'h1,e0c_merge_sel_sew16[329 +:6],1'h0,e0c_merge_sel_sew16[322 +:6],1'h1,e0c_merge_sel_sew16[322 +:6],1'h0,e0c_merge_sel_sew16[315 +:6],1'h1,e0c_merge_sel_sew16[315 +:6],1'h0,e0c_merge_sel_sew16[308 +:6],1'h1,e0c_merge_sel_sew16[308 +:6],1'h0,e0c_merge_sel_sew16[301 +:6],1'h1,e0c_merge_sel_sew16[301 +:6],1'h0,e0c_merge_sel_sew16[294 +:6],1'h1,e0c_merge_sel_sew16[294 +:6],1'h0,e0c_merge_sel_sew16[287 +:6],1'h1,e0c_merge_sel_sew16[287 +:6],1'h0,e0c_merge_sel_sew16[280 +:6],1'h1,e0c_merge_sel_sew16[280 +:6],1'h0,e0c_merge_sel_sew16[273 +:6],1'h1,e0c_merge_sel_sew16[273 +:6],1'h0,e0c_merge_sel_sew16[266 +:6],1'h1,e0c_merge_sel_sew16[266 +:6],1'h0,e0c_merge_sel_sew16[259 +:6],1'h1,e0c_merge_sel_sew16[259 +:6],1'h0,e0c_merge_sel_sew16[252 +:6],1'h1,e0c_merge_sel_sew16[252 +:6],1'h0,e0c_merge_sel_sew16[245 +:6],1'h1,e0c_merge_sel_sew16[245 +:6],1'h0,e0c_merge_sel_sew16[238 +:6],1'h1,e0c_merge_sel_sew16[238 +:6],1'h0,e0c_merge_sel_sew16[231 +:6],1'h1,e0c_merge_sel_sew16[231 +:6],1'h0,e0c_merge_sel_sew16[224 +:6],1'h1,e0c_merge_sel_sew16[224 +:6],1'h0,e0c_merge_sel_sew16[217 +:6],1'h1,e0c_merge_sel_sew16[217 +:6],1'h0,e0c_merge_sel_sew16[210 +:6],1'h1,e0c_merge_sel_sew16[210 +:6],1'h0,e0c_merge_sel_sew16[203 +:6],1'h1,e0c_merge_sel_sew16[203 +:6],1'h0,e0c_merge_sel_sew16[196 +:6],1'h1,e0c_merge_sel_sew16[196 +:6],1'h0,e0c_merge_sel_sew16[189 +:6],1'h1,e0c_merge_sel_sew16[189 +:6],1'h0,e0c_merge_sel_sew16[182 +:6],1'h1,e0c_merge_sel_sew16[182 +:6],1'h0,e0c_merge_sel_sew16[175 +:6],1'h1,e0c_merge_sel_sew16[175 +:6],1'h0,e0c_merge_sel_sew16[168 +:6],1'h1,e0c_merge_sel_sew16[168 +:6],1'h0,e0c_merge_sel_sew16[161 +:6],1'h1,e0c_merge_sel_sew16[161 +:6],1'h0,e0c_merge_sel_sew16[154 +:6],1'h1,e0c_merge_sel_sew16[154 +:6],1'h0,e0c_merge_sel_sew16[147 +:6],1'h1,e0c_merge_sel_sew16[147 +:6],1'h0,e0c_merge_sel_sew16[140 +:6],1'h1,e0c_merge_sel_sew16[140 +:6],1'h0,e0c_merge_sel_sew16[133 +:6],1'h1,e0c_merge_sel_sew16[133 +:6],1'h0,e0c_merge_sel_sew16[126 +:6],1'h1,e0c_merge_sel_sew16[126 +:6],1'h0,e0c_merge_sel_sew16[119 +:6],1'h1,e0c_merge_sel_sew16[119 +:6],1'h0,e0c_merge_sel_sew16[112 +:6],1'h1,e0c_merge_sel_sew16[112 +:6],1'h0,e0c_merge_sel_sew16[105 +:6],1'h1,e0c_merge_sel_sew16[105 +:6],1'h0,e0c_merge_sel_sew16[98 +:6],1'h1,e0c_merge_sel_sew16[98 +:6],1'h0,e0c_merge_sel_sew16[91 +:6],1'h1,e0c_merge_sel_sew16[91 +:6],1'h0,e0c_merge_sel_sew16[84 +:6],1'h1,e0c_merge_sel_sew16[84 +:6],1'h0,e0c_merge_sel_sew16[77 +:6],1'h1,e0c_merge_sel_sew16[77 +:6],1'h0,e0c_merge_sel_sew16[70 +:6],1'h1,e0c_merge_sel_sew16[70 +:6],1'h0,e0c_merge_sel_sew16[63 +:6],1'h1,e0c_merge_sel_sew16[63 +:6],1'h0,e0c_merge_sel_sew16[56 +:6],1'h1,e0c_merge_sel_sew16[56 +:6],1'h0,e0c_merge_sel_sew16[49 +:6],1'h1,e0c_merge_sel_sew16[49 +:6],1'h0,e0c_merge_sel_sew16[42 +:6],1'h1,e0c_merge_sel_sew16[42 +:6],1'h0,e0c_merge_sel_sew16[35 +:6],1'h1,e0c_merge_sel_sew16[35 +:6],1'h0,e0c_merge_sel_sew16[28 +:6],1'h1,e0c_merge_sel_sew16[28 +:6],1'h0,e0c_merge_sel_sew16[21 +:6],1'h1,e0c_merge_sel_sew16[21 +:6],1'h0,e0c_merge_sel_sew16[14 +:6],1'h1,e0c_merge_sel_sew16[14 +:6],1'h0,e0c_merge_sel_sew16[7 +:6],1'h1,e0c_merge_sel_sew16[7 +:6],1'h0,e0c_merge_sel_sew16[0 +:6],1'h1,e0c_merge_sel_sew16[0 +:6],1'h0};
        assign e0c_dual_sel = ({256 * 7 + 1{sew_onehot[0]}} & e0c_merge_sel_sew8) | ({256 * 7 + 1{sew_onehot[1]}} & e0c_exp_sel_sew16) | ({256 * 7 + 1{sew_onehot[2]}} & e0c_exp_sel_sew32) | ({256 * 7 + 1{sew_onehot[3]}} & e0c_exp_sel_sew64);
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

