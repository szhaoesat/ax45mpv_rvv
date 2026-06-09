// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vcompress_slice (
    vpu_vpermut_clk,
    mask_in,
    shift,
    idx,
    e0c_en,
    shift_mask,
    shift_sel
);
parameter SLICE_LEN = 8;
parameter SLICE_NUM = 8;
localparam SLICE_LEN_LOG2 = $unsigned($clog2(SLICE_LEN));
localparam LANE = SLICE_LEN * SLICE_NUM;
localparam LANE_LOG2 = $unsigned($clog2(LANE));
localparam SLICE_OFF = LANE_LOG2 + 1;
localparam SLICE_IDX = $unsigned($clog2(SLICE_NUM));
input vpu_vpermut_clk;
input [SLICE_LEN - 1:0] mask_in;
input [SLICE_OFF - 1:0] shift;
input [SLICE_IDX - 1:0] idx;
input e0c_en;
output [2 * LANE - 1:0] shift_mask;
output [2 * LANE * LANE_LOG2 - 1:0] shift_sel;





// 704c1128 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [SLICE_LEN - 1:0] e0c_mask;
reg [SLICE_LEN * SLICE_LEN_LOG2 - 1:0] e0c_sel;
wire [2 * LANE * SLICE_LEN_LOG2 - 1:0] e0c_shift_sel;
wire [2 * LANE - 1:0] shift_onehot;
kv_bin2onehot #(
    .N(2 * LANE)
) u_shift_onehot (
    .in(shift),
    .out(shift_onehot)
);
wire [SLICE_LEN - 1:0] mask;
wire [SLICE_LEN * SLICE_LEN_LOG2 - 1:0] sel;
wire [SLICE_LEN_LOG2 - 1:0] ffs0_sel;
wire [SLICE_LEN - 1:0] ffs0_mask;
kv_ffs #(
    .WIDTH(SLICE_LEN)
) u_find_set0 (
    .in(mask_in),
    .out(ffs0_mask)
);
kv_onehot2bin #(
    .N(SLICE_LEN)
) u_set0 (
    .in(ffs0_mask),
    .out(ffs0_sel)
);
assign sel[0 +:SLICE_LEN_LOG2] = ffs0_sel;
assign mask[0] = |ffs0_mask;
generate
    if (SLICE_LEN == 2) begin:gen_direct_compress2
        wire [2 - 1:0] ffs1_mask_body;
        assign ffs1_mask_body[1 - 1:0] = {1{1'b0}};
        assign ffs1_mask_body[1] = &mask_in[1:0];
        wire [2 - 1:0] ffs1_mask = ffs0_mask | ffs1_mask_body;
        assign mask[1] = |ffs1_mask_body;
        kv_onehot2bin #(
            .N(2)
        ) u_set1 (
            .in(ffs1_mask_body),
            .out(sel[1 * 1 +:1])
        );
        wire [2 - 1:0] nds_unused_mask = ffs1_mask;
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum0 = {{30 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[0]}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum1 = sel_sum0 | {{29 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[1]}},{1 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum2 = sel_sum1 | {{28 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[2]}},{2 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum3 = sel_sum2 | {{27 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[3]}},{3 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum4 = sel_sum3 | {{26 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[4]}},{4 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum5 = sel_sum4 | {{25 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[5]}},{5 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum6 = sel_sum5 | {{24 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[6]}},{6 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum7 = sel_sum6 | {{23 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[7]}},{7 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum8 = sel_sum7 | {{22 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[8]}},{8 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum9 = sel_sum8 | {{21 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[9]}},{9 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum10 = sel_sum9 | {{20 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[10]}},{10 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum11 = sel_sum10 | {{19 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[11]}},{11 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum12 = sel_sum11 | {{18 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[12]}},{12 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum13 = sel_sum12 | {{17 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[13]}},{13 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum14 = sel_sum13 | {{16 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[14]}},{14 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum15 = sel_sum14 | {{15 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[15]}},{15 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum16 = sel_sum15 | {{14 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[16]}},{16 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum17 = sel_sum16 | {{13 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[17]}},{17 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum18 = sel_sum17 | {{12 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[18]}},{18 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum19 = sel_sum18 | {{11 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[19]}},{19 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum20 = sel_sum19 | {{10 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[20]}},{20 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum21 = sel_sum20 | {{9 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[21]}},{21 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum22 = sel_sum21 | {{8 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[22]}},{22 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum23 = sel_sum22 | {{7 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[23]}},{23 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum24 = sel_sum23 | {{6 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[24]}},{24 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum25 = sel_sum24 | {{5 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[25]}},{25 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum26 = sel_sum25 | {{4 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[26]}},{26 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum27 = sel_sum26 | {{3 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[27]}},{27 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum28 = sel_sum27 | {{2 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[28]}},{28 * SLICE_LEN_LOG2{1'b0}}};
        wire [32 * SLICE_LEN_LOG2 - 1:0] sel_sum29 = sel_sum28 | {{1 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[29]}},{29 * SLICE_LEN_LOG2{1'b0}}};
        assign e0c_shift_sel = sel_sum29 | {e0c_sel & {2 * SLICE_LEN_LOG2{shift_onehot[30]}},{30 * SLICE_LEN_LOG2{1'b0}}};
        assign shift_sel[0 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[0]}} & {idx,e0c_shift_sel[0 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[1 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[1]}} & {idx,e0c_shift_sel[1 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[2 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[2]}} & {idx,e0c_shift_sel[2 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[3 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[3]}} & {idx,e0c_shift_sel[3 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[4 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[4]}} & {idx,e0c_shift_sel[4 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[5 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[5]}} & {idx,e0c_shift_sel[5 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[6 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[6]}} & {idx,e0c_shift_sel[6 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[7 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[7]}} & {idx,e0c_shift_sel[7 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[8 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[8]}} & {idx,e0c_shift_sel[8 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[9 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[9]}} & {idx,e0c_shift_sel[9 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[10 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[10]}} & {idx,e0c_shift_sel[10 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[11 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[11]}} & {idx,e0c_shift_sel[11 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[12 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[12]}} & {idx,e0c_shift_sel[12 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[13 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[13]}} & {idx,e0c_shift_sel[13 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[14 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[14]}} & {idx,e0c_shift_sel[14 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[15 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[15]}} & {idx,e0c_shift_sel[15 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[16 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[16]}} & {idx,e0c_shift_sel[16 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[17 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[17]}} & {idx,e0c_shift_sel[17 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[18 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[18]}} & {idx,e0c_shift_sel[18 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[19 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[19]}} & {idx,e0c_shift_sel[19 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[20 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[20]}} & {idx,e0c_shift_sel[20 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[21 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[21]}} & {idx,e0c_shift_sel[21 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[22 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[22]}} & {idx,e0c_shift_sel[22 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[23 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[23]}} & {idx,e0c_shift_sel[23 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[24 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[24]}} & {idx,e0c_shift_sel[24 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[25 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[25]}} & {idx,e0c_shift_sel[25 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[26 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[26]}} & {idx,e0c_shift_sel[26 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[27 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[27]}} & {idx,e0c_shift_sel[27 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[28 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[28]}} & {idx,e0c_shift_sel[28 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[29 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[29]}} & {idx,e0c_shift_sel[29 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[30 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[30]}} & {idx,e0c_shift_sel[30 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[31 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[31]}} & {idx,e0c_shift_sel[31 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
    end
endgenerate
generate
    if (SLICE_LEN == 4) begin:gen_direct_compress4
        wire [4 - 1:0] ffs1_mask_body;
        assign ffs1_mask_body[1 - 1:0] = {1{1'b0}};
        assign ffs1_mask_body[1] = &mask_in[1:0];
        assign ffs1_mask_body[2] = mask_in[2] & ~ffs0_mask[2] & ~|(~ffs0_mask[1 +:1] & mask_in[1 +:1]);
        assign ffs1_mask_body[3] = mask_in[3] & ~ffs0_mask[3] & ~|(~ffs0_mask[1 +:2] & mask_in[1 +:2]);
        wire [4 - 1:0] ffs1_mask = ffs0_mask | ffs1_mask_body;
        assign mask[1] = |ffs1_mask_body;
        kv_onehot2bin #(
            .N(4)
        ) u_set1 (
            .in(ffs1_mask_body),
            .out(sel[1 * 2 +:2])
        );
        wire [4 - 1:0] ffs2_mask_body;
        assign ffs2_mask_body[2 - 1:0] = {2{1'b0}};
        assign ffs2_mask_body[2] = &mask_in[2:0];
        assign ffs2_mask_body[3] = mask_in[3] & ~ffs1_mask[3] & ~|(~ffs1_mask[2 +:1] & mask_in[2 +:1]);
        wire [4 - 1:0] ffs2_mask = ffs1_mask | ffs2_mask_body;
        assign mask[2] = |ffs2_mask_body;
        kv_onehot2bin #(
            .N(4)
        ) u_set2 (
            .in(ffs2_mask_body),
            .out(sel[2 * 2 +:2])
        );
        wire [4 - 1:0] ffs3_mask_body;
        assign ffs3_mask_body[3 - 1:0] = {3{1'b0}};
        assign ffs3_mask_body[3] = &mask_in[3:0];
        wire [4 - 1:0] ffs3_mask = ffs2_mask | ffs3_mask_body;
        assign mask[3] = |ffs3_mask_body;
        kv_onehot2bin #(
            .N(4)
        ) u_set3 (
            .in(ffs3_mask_body),
            .out(sel[3 * 2 +:2])
        );
        wire [4 - 1:0] nds_unused_mask = ffs3_mask;
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum0 = {{60 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[0]}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum1 = sel_sum0 | {{59 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[1]}},{1 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum2 = sel_sum1 | {{58 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[2]}},{2 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum3 = sel_sum2 | {{57 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[3]}},{3 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum4 = sel_sum3 | {{56 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[4]}},{4 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum5 = sel_sum4 | {{55 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[5]}},{5 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum6 = sel_sum5 | {{54 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[6]}},{6 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum7 = sel_sum6 | {{53 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[7]}},{7 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum8 = sel_sum7 | {{52 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[8]}},{8 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum9 = sel_sum8 | {{51 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[9]}},{9 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum10 = sel_sum9 | {{50 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[10]}},{10 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum11 = sel_sum10 | {{49 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[11]}},{11 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum12 = sel_sum11 | {{48 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[12]}},{12 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum13 = sel_sum12 | {{47 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[13]}},{13 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum14 = sel_sum13 | {{46 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[14]}},{14 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum15 = sel_sum14 | {{45 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[15]}},{15 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum16 = sel_sum15 | {{44 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[16]}},{16 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum17 = sel_sum16 | {{43 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[17]}},{17 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum18 = sel_sum17 | {{42 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[18]}},{18 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum19 = sel_sum18 | {{41 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[19]}},{19 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum20 = sel_sum19 | {{40 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[20]}},{20 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum21 = sel_sum20 | {{39 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[21]}},{21 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum22 = sel_sum21 | {{38 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[22]}},{22 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum23 = sel_sum22 | {{37 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[23]}},{23 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum24 = sel_sum23 | {{36 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[24]}},{24 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum25 = sel_sum24 | {{35 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[25]}},{25 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum26 = sel_sum25 | {{34 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[26]}},{26 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum27 = sel_sum26 | {{33 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[27]}},{27 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum28 = sel_sum27 | {{32 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[28]}},{28 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum29 = sel_sum28 | {{31 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[29]}},{29 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum30 = sel_sum29 | {{30 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[30]}},{30 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum31 = sel_sum30 | {{29 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[31]}},{31 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum32 = sel_sum31 | {{28 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[32]}},{32 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum33 = sel_sum32 | {{27 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[33]}},{33 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum34 = sel_sum33 | {{26 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[34]}},{34 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum35 = sel_sum34 | {{25 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[35]}},{35 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum36 = sel_sum35 | {{24 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[36]}},{36 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum37 = sel_sum36 | {{23 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[37]}},{37 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum38 = sel_sum37 | {{22 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[38]}},{38 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum39 = sel_sum38 | {{21 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[39]}},{39 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum40 = sel_sum39 | {{20 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[40]}},{40 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum41 = sel_sum40 | {{19 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[41]}},{41 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum42 = sel_sum41 | {{18 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[42]}},{42 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum43 = sel_sum42 | {{17 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[43]}},{43 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum44 = sel_sum43 | {{16 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[44]}},{44 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum45 = sel_sum44 | {{15 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[45]}},{45 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum46 = sel_sum45 | {{14 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[46]}},{46 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum47 = sel_sum46 | {{13 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[47]}},{47 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum48 = sel_sum47 | {{12 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[48]}},{48 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum49 = sel_sum48 | {{11 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[49]}},{49 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum50 = sel_sum49 | {{10 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[50]}},{50 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum51 = sel_sum50 | {{9 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[51]}},{51 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum52 = sel_sum51 | {{8 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[52]}},{52 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum53 = sel_sum52 | {{7 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[53]}},{53 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum54 = sel_sum53 | {{6 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[54]}},{54 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum55 = sel_sum54 | {{5 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[55]}},{55 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum56 = sel_sum55 | {{4 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[56]}},{56 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum57 = sel_sum56 | {{3 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[57]}},{57 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum58 = sel_sum57 | {{2 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[58]}},{58 * SLICE_LEN_LOG2{1'b0}}};
        wire [64 * SLICE_LEN_LOG2 - 1:0] sel_sum59 = sel_sum58 | {{1 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[59]}},{59 * SLICE_LEN_LOG2{1'b0}}};
        assign e0c_shift_sel = sel_sum59 | {e0c_sel & {4 * SLICE_LEN_LOG2{shift_onehot[60]}},{60 * SLICE_LEN_LOG2{1'b0}}};
        assign shift_sel[0 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[0]}} & {idx,e0c_shift_sel[0 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[1 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[1]}} & {idx,e0c_shift_sel[1 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[2 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[2]}} & {idx,e0c_shift_sel[2 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[3 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[3]}} & {idx,e0c_shift_sel[3 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[4 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[4]}} & {idx,e0c_shift_sel[4 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[5 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[5]}} & {idx,e0c_shift_sel[5 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[6 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[6]}} & {idx,e0c_shift_sel[6 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[7 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[7]}} & {idx,e0c_shift_sel[7 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[8 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[8]}} & {idx,e0c_shift_sel[8 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[9 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[9]}} & {idx,e0c_shift_sel[9 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[10 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[10]}} & {idx,e0c_shift_sel[10 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[11 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[11]}} & {idx,e0c_shift_sel[11 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[12 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[12]}} & {idx,e0c_shift_sel[12 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[13 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[13]}} & {idx,e0c_shift_sel[13 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[14 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[14]}} & {idx,e0c_shift_sel[14 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[15 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[15]}} & {idx,e0c_shift_sel[15 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[16 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[16]}} & {idx,e0c_shift_sel[16 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[17 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[17]}} & {idx,e0c_shift_sel[17 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[18 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[18]}} & {idx,e0c_shift_sel[18 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[19 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[19]}} & {idx,e0c_shift_sel[19 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[20 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[20]}} & {idx,e0c_shift_sel[20 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[21 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[21]}} & {idx,e0c_shift_sel[21 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[22 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[22]}} & {idx,e0c_shift_sel[22 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[23 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[23]}} & {idx,e0c_shift_sel[23 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[24 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[24]}} & {idx,e0c_shift_sel[24 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[25 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[25]}} & {idx,e0c_shift_sel[25 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[26 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[26]}} & {idx,e0c_shift_sel[26 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[27 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[27]}} & {idx,e0c_shift_sel[27 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[28 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[28]}} & {idx,e0c_shift_sel[28 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[29 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[29]}} & {idx,e0c_shift_sel[29 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[30 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[30]}} & {idx,e0c_shift_sel[30 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[31 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[31]}} & {idx,e0c_shift_sel[31 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[32 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[32]}} & {idx,e0c_shift_sel[32 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[33 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[33]}} & {idx,e0c_shift_sel[33 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[34 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[34]}} & {idx,e0c_shift_sel[34 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[35 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[35]}} & {idx,e0c_shift_sel[35 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[36 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[36]}} & {idx,e0c_shift_sel[36 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[37 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[37]}} & {idx,e0c_shift_sel[37 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[38 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[38]}} & {idx,e0c_shift_sel[38 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[39 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[39]}} & {idx,e0c_shift_sel[39 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[40 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[40]}} & {idx,e0c_shift_sel[40 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[41 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[41]}} & {idx,e0c_shift_sel[41 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[42 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[42]}} & {idx,e0c_shift_sel[42 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[43 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[43]}} & {idx,e0c_shift_sel[43 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[44 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[44]}} & {idx,e0c_shift_sel[44 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[45 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[45]}} & {idx,e0c_shift_sel[45 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[46 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[46]}} & {idx,e0c_shift_sel[46 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[47 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[47]}} & {idx,e0c_shift_sel[47 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[48 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[48]}} & {idx,e0c_shift_sel[48 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[49 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[49]}} & {idx,e0c_shift_sel[49 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[50 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[50]}} & {idx,e0c_shift_sel[50 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[51 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[51]}} & {idx,e0c_shift_sel[51 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[52 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[52]}} & {idx,e0c_shift_sel[52 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[53 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[53]}} & {idx,e0c_shift_sel[53 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[54 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[54]}} & {idx,e0c_shift_sel[54 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[55 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[55]}} & {idx,e0c_shift_sel[55 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[56 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[56]}} & {idx,e0c_shift_sel[56 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[57 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[57]}} & {idx,e0c_shift_sel[57 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[58 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[58]}} & {idx,e0c_shift_sel[58 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[59 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[59]}} & {idx,e0c_shift_sel[59 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[60 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[60]}} & {idx,e0c_shift_sel[60 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[61 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[61]}} & {idx,e0c_shift_sel[61 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[62 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[62]}} & {idx,e0c_shift_sel[62 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[63 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[63]}} & {idx,e0c_shift_sel[63 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
    end
endgenerate
generate
    if (SLICE_LEN == 8) begin:gen_direct_compress8
        wire [8 - 1:0] ffs1_mask_body;
        assign ffs1_mask_body[1 - 1:0] = {1{1'b0}};
        assign ffs1_mask_body[1] = &mask_in[1:0];
        assign ffs1_mask_body[2] = mask_in[2] & ~ffs0_mask[2] & ~|(~ffs0_mask[1 +:1] & mask_in[1 +:1]);
        assign ffs1_mask_body[3] = mask_in[3] & ~ffs0_mask[3] & ~|(~ffs0_mask[1 +:2] & mask_in[1 +:2]);
        assign ffs1_mask_body[4] = mask_in[4] & ~ffs0_mask[4] & ~|(~ffs0_mask[1 +:3] & mask_in[1 +:3]);
        assign ffs1_mask_body[5] = mask_in[5] & ~ffs0_mask[5] & ~|(~ffs0_mask[1 +:4] & mask_in[1 +:4]);
        assign ffs1_mask_body[6] = mask_in[6] & ~ffs0_mask[6] & ~|(~ffs0_mask[1 +:5] & mask_in[1 +:5]);
        assign ffs1_mask_body[7] = mask_in[7] & ~ffs0_mask[7] & ~|(~ffs0_mask[1 +:6] & mask_in[1 +:6]);
        wire [8 - 1:0] ffs1_mask = ffs0_mask | ffs1_mask_body;
        assign mask[1] = |ffs1_mask_body;
        kv_onehot2bin #(
            .N(8)
        ) u_set1 (
            .in(ffs1_mask_body),
            .out(sel[1 * 3 +:3])
        );
        wire [8 - 1:0] ffs2_mask_body;
        assign ffs2_mask_body[2 - 1:0] = {2{1'b0}};
        assign ffs2_mask_body[2] = &mask_in[2:0];
        assign ffs2_mask_body[3] = mask_in[3] & ~ffs1_mask[3] & ~|(~ffs1_mask[2 +:1] & mask_in[2 +:1]);
        assign ffs2_mask_body[4] = mask_in[4] & ~ffs1_mask[4] & ~|(~ffs1_mask[2 +:2] & mask_in[2 +:2]);
        assign ffs2_mask_body[5] = mask_in[5] & ~ffs1_mask[5] & ~|(~ffs1_mask[2 +:3] & mask_in[2 +:3]);
        assign ffs2_mask_body[6] = mask_in[6] & ~ffs1_mask[6] & ~|(~ffs1_mask[2 +:4] & mask_in[2 +:4]);
        assign ffs2_mask_body[7] = mask_in[7] & ~ffs1_mask[7] & ~|(~ffs1_mask[2 +:5] & mask_in[2 +:5]);
        wire [8 - 1:0] ffs2_mask = ffs1_mask | ffs2_mask_body;
        assign mask[2] = |ffs2_mask_body;
        kv_onehot2bin #(
            .N(8)
        ) u_set2 (
            .in(ffs2_mask_body),
            .out(sel[2 * 3 +:3])
        );
        wire [8 - 1:0] ffs3_mask_body;
        assign ffs3_mask_body[3 - 1:0] = {3{1'b0}};
        assign ffs3_mask_body[3] = &mask_in[3:0];
        assign ffs3_mask_body[4] = mask_in[4] & ~ffs2_mask[4] & ~|(~ffs2_mask[3 +:1] & mask_in[3 +:1]);
        assign ffs3_mask_body[5] = mask_in[5] & ~ffs2_mask[5] & ~|(~ffs2_mask[3 +:2] & mask_in[3 +:2]);
        assign ffs3_mask_body[6] = mask_in[6] & ~ffs2_mask[6] & ~|(~ffs2_mask[3 +:3] & mask_in[3 +:3]);
        assign ffs3_mask_body[7] = mask_in[7] & ~ffs2_mask[7] & ~|(~ffs2_mask[3 +:4] & mask_in[3 +:4]);
        wire [8 - 1:0] ffs3_mask = ffs2_mask | ffs3_mask_body;
        assign mask[3] = |ffs3_mask_body;
        kv_onehot2bin #(
            .N(8)
        ) u_set3 (
            .in(ffs3_mask_body),
            .out(sel[3 * 3 +:3])
        );
        wire [8 - 1:0] ffs4_mask_body;
        assign ffs4_mask_body[4 - 1:0] = {4{1'b0}};
        assign ffs4_mask_body[4] = &mask_in[4:0];
        assign ffs4_mask_body[5] = mask_in[5] & ~ffs3_mask[5] & ~|(~ffs3_mask[4 +:1] & mask_in[4 +:1]);
        assign ffs4_mask_body[6] = mask_in[6] & ~ffs3_mask[6] & ~|(~ffs3_mask[4 +:2] & mask_in[4 +:2]);
        assign ffs4_mask_body[7] = mask_in[7] & ~ffs3_mask[7] & ~|(~ffs3_mask[4 +:3] & mask_in[4 +:3]);
        wire [8 - 1:0] ffs4_mask = ffs3_mask | ffs4_mask_body;
        assign mask[4] = |ffs4_mask_body;
        kv_onehot2bin #(
            .N(8)
        ) u_set4 (
            .in(ffs4_mask_body),
            .out(sel[4 * 3 +:3])
        );
        wire [8 - 1:0] ffs5_mask_body;
        assign ffs5_mask_body[5 - 1:0] = {5{1'b0}};
        assign ffs5_mask_body[5] = &mask_in[5:0];
        assign ffs5_mask_body[6] = mask_in[6] & ~ffs4_mask[6] & ~|(~ffs4_mask[5 +:1] & mask_in[5 +:1]);
        assign ffs5_mask_body[7] = mask_in[7] & ~ffs4_mask[7] & ~|(~ffs4_mask[5 +:2] & mask_in[5 +:2]);
        wire [8 - 1:0] ffs5_mask = ffs4_mask | ffs5_mask_body;
        assign mask[5] = |ffs5_mask_body;
        kv_onehot2bin #(
            .N(8)
        ) u_set5 (
            .in(ffs5_mask_body),
            .out(sel[5 * 3 +:3])
        );
        wire [8 - 1:0] ffs6_mask_body;
        assign ffs6_mask_body[6 - 1:0] = {6{1'b0}};
        assign ffs6_mask_body[6] = &mask_in[6:0];
        assign ffs6_mask_body[7] = mask_in[7] & ~ffs5_mask[7] & ~|(~ffs5_mask[6 +:1] & mask_in[6 +:1]);
        wire [8 - 1:0] ffs6_mask = ffs5_mask | ffs6_mask_body;
        assign mask[6] = |ffs6_mask_body;
        kv_onehot2bin #(
            .N(8)
        ) u_set6 (
            .in(ffs6_mask_body),
            .out(sel[6 * 3 +:3])
        );
        wire [8 - 1:0] ffs7_mask_body;
        assign ffs7_mask_body[7 - 1:0] = {7{1'b0}};
        assign ffs7_mask_body[7] = &mask_in[7:0];
        wire [8 - 1:0] ffs7_mask = ffs6_mask | ffs7_mask_body;
        assign mask[7] = |ffs7_mask_body;
        kv_onehot2bin #(
            .N(8)
        ) u_set7 (
            .in(ffs7_mask_body),
            .out(sel[7 * 3 +:3])
        );
        wire [8 - 1:0] nds_unused_mask = ffs7_mask;
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum0 = {{120 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[0]}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum1 = sel_sum0 | {{119 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[1]}},{1 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum2 = sel_sum1 | {{118 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[2]}},{2 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum3 = sel_sum2 | {{117 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[3]}},{3 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum4 = sel_sum3 | {{116 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[4]}},{4 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum5 = sel_sum4 | {{115 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[5]}},{5 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum6 = sel_sum5 | {{114 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[6]}},{6 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum7 = sel_sum6 | {{113 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[7]}},{7 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum8 = sel_sum7 | {{112 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[8]}},{8 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum9 = sel_sum8 | {{111 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[9]}},{9 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum10 = sel_sum9 | {{110 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[10]}},{10 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum11 = sel_sum10 | {{109 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[11]}},{11 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum12 = sel_sum11 | {{108 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[12]}},{12 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum13 = sel_sum12 | {{107 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[13]}},{13 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum14 = sel_sum13 | {{106 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[14]}},{14 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum15 = sel_sum14 | {{105 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[15]}},{15 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum16 = sel_sum15 | {{104 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[16]}},{16 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum17 = sel_sum16 | {{103 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[17]}},{17 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum18 = sel_sum17 | {{102 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[18]}},{18 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum19 = sel_sum18 | {{101 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[19]}},{19 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum20 = sel_sum19 | {{100 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[20]}},{20 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum21 = sel_sum20 | {{99 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[21]}},{21 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum22 = sel_sum21 | {{98 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[22]}},{22 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum23 = sel_sum22 | {{97 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[23]}},{23 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum24 = sel_sum23 | {{96 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[24]}},{24 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum25 = sel_sum24 | {{95 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[25]}},{25 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum26 = sel_sum25 | {{94 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[26]}},{26 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum27 = sel_sum26 | {{93 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[27]}},{27 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum28 = sel_sum27 | {{92 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[28]}},{28 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum29 = sel_sum28 | {{91 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[29]}},{29 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum30 = sel_sum29 | {{90 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[30]}},{30 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum31 = sel_sum30 | {{89 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[31]}},{31 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum32 = sel_sum31 | {{88 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[32]}},{32 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum33 = sel_sum32 | {{87 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[33]}},{33 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum34 = sel_sum33 | {{86 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[34]}},{34 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum35 = sel_sum34 | {{85 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[35]}},{35 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum36 = sel_sum35 | {{84 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[36]}},{36 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum37 = sel_sum36 | {{83 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[37]}},{37 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum38 = sel_sum37 | {{82 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[38]}},{38 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum39 = sel_sum38 | {{81 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[39]}},{39 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum40 = sel_sum39 | {{80 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[40]}},{40 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum41 = sel_sum40 | {{79 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[41]}},{41 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum42 = sel_sum41 | {{78 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[42]}},{42 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum43 = sel_sum42 | {{77 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[43]}},{43 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum44 = sel_sum43 | {{76 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[44]}},{44 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum45 = sel_sum44 | {{75 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[45]}},{45 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum46 = sel_sum45 | {{74 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[46]}},{46 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum47 = sel_sum46 | {{73 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[47]}},{47 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum48 = sel_sum47 | {{72 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[48]}},{48 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum49 = sel_sum48 | {{71 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[49]}},{49 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum50 = sel_sum49 | {{70 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[50]}},{50 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum51 = sel_sum50 | {{69 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[51]}},{51 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum52 = sel_sum51 | {{68 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[52]}},{52 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum53 = sel_sum52 | {{67 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[53]}},{53 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum54 = sel_sum53 | {{66 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[54]}},{54 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum55 = sel_sum54 | {{65 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[55]}},{55 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum56 = sel_sum55 | {{64 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[56]}},{56 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum57 = sel_sum56 | {{63 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[57]}},{57 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum58 = sel_sum57 | {{62 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[58]}},{58 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum59 = sel_sum58 | {{61 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[59]}},{59 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum60 = sel_sum59 | {{60 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[60]}},{60 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum61 = sel_sum60 | {{59 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[61]}},{61 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum62 = sel_sum61 | {{58 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[62]}},{62 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum63 = sel_sum62 | {{57 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[63]}},{63 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum64 = sel_sum63 | {{56 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[64]}},{64 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum65 = sel_sum64 | {{55 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[65]}},{65 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum66 = sel_sum65 | {{54 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[66]}},{66 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum67 = sel_sum66 | {{53 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[67]}},{67 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum68 = sel_sum67 | {{52 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[68]}},{68 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum69 = sel_sum68 | {{51 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[69]}},{69 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum70 = sel_sum69 | {{50 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[70]}},{70 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum71 = sel_sum70 | {{49 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[71]}},{71 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum72 = sel_sum71 | {{48 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[72]}},{72 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum73 = sel_sum72 | {{47 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[73]}},{73 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum74 = sel_sum73 | {{46 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[74]}},{74 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum75 = sel_sum74 | {{45 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[75]}},{75 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum76 = sel_sum75 | {{44 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[76]}},{76 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum77 = sel_sum76 | {{43 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[77]}},{77 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum78 = sel_sum77 | {{42 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[78]}},{78 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum79 = sel_sum78 | {{41 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[79]}},{79 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum80 = sel_sum79 | {{40 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[80]}},{80 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum81 = sel_sum80 | {{39 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[81]}},{81 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum82 = sel_sum81 | {{38 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[82]}},{82 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum83 = sel_sum82 | {{37 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[83]}},{83 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum84 = sel_sum83 | {{36 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[84]}},{84 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum85 = sel_sum84 | {{35 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[85]}},{85 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum86 = sel_sum85 | {{34 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[86]}},{86 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum87 = sel_sum86 | {{33 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[87]}},{87 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum88 = sel_sum87 | {{32 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[88]}},{88 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum89 = sel_sum88 | {{31 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[89]}},{89 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum90 = sel_sum89 | {{30 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[90]}},{90 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum91 = sel_sum90 | {{29 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[91]}},{91 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum92 = sel_sum91 | {{28 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[92]}},{92 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum93 = sel_sum92 | {{27 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[93]}},{93 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum94 = sel_sum93 | {{26 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[94]}},{94 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum95 = sel_sum94 | {{25 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[95]}},{95 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum96 = sel_sum95 | {{24 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[96]}},{96 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum97 = sel_sum96 | {{23 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[97]}},{97 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum98 = sel_sum97 | {{22 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[98]}},{98 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum99 = sel_sum98 | {{21 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[99]}},{99 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum100 = sel_sum99 | {{20 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[100]}},{100 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum101 = sel_sum100 | {{19 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[101]}},{101 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum102 = sel_sum101 | {{18 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[102]}},{102 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum103 = sel_sum102 | {{17 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[103]}},{103 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum104 = sel_sum103 | {{16 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[104]}},{104 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum105 = sel_sum104 | {{15 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[105]}},{105 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum106 = sel_sum105 | {{14 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[106]}},{106 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum107 = sel_sum106 | {{13 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[107]}},{107 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum108 = sel_sum107 | {{12 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[108]}},{108 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum109 = sel_sum108 | {{11 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[109]}},{109 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum110 = sel_sum109 | {{10 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[110]}},{110 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum111 = sel_sum110 | {{9 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[111]}},{111 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum112 = sel_sum111 | {{8 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[112]}},{112 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum113 = sel_sum112 | {{7 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[113]}},{113 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum114 = sel_sum113 | {{6 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[114]}},{114 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum115 = sel_sum114 | {{5 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[115]}},{115 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum116 = sel_sum115 | {{4 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[116]}},{116 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum117 = sel_sum116 | {{3 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[117]}},{117 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum118 = sel_sum117 | {{2 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[118]}},{118 * SLICE_LEN_LOG2{1'b0}}};
        wire [128 * SLICE_LEN_LOG2 - 1:0] sel_sum119 = sel_sum118 | {{1 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[119]}},{119 * SLICE_LEN_LOG2{1'b0}}};
        assign e0c_shift_sel = sel_sum119 | {e0c_sel & {8 * SLICE_LEN_LOG2{shift_onehot[120]}},{120 * SLICE_LEN_LOG2{1'b0}}};
        assign shift_sel[0 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[0]}} & {idx,e0c_shift_sel[0 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[1 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[1]}} & {idx,e0c_shift_sel[1 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[2 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[2]}} & {idx,e0c_shift_sel[2 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[3 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[3]}} & {idx,e0c_shift_sel[3 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[4 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[4]}} & {idx,e0c_shift_sel[4 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[5 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[5]}} & {idx,e0c_shift_sel[5 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[6 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[6]}} & {idx,e0c_shift_sel[6 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[7 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[7]}} & {idx,e0c_shift_sel[7 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[8 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[8]}} & {idx,e0c_shift_sel[8 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[9 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[9]}} & {idx,e0c_shift_sel[9 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[10 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[10]}} & {idx,e0c_shift_sel[10 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[11 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[11]}} & {idx,e0c_shift_sel[11 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[12 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[12]}} & {idx,e0c_shift_sel[12 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[13 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[13]}} & {idx,e0c_shift_sel[13 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[14 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[14]}} & {idx,e0c_shift_sel[14 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[15 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[15]}} & {idx,e0c_shift_sel[15 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[16 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[16]}} & {idx,e0c_shift_sel[16 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[17 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[17]}} & {idx,e0c_shift_sel[17 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[18 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[18]}} & {idx,e0c_shift_sel[18 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[19 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[19]}} & {idx,e0c_shift_sel[19 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[20 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[20]}} & {idx,e0c_shift_sel[20 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[21 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[21]}} & {idx,e0c_shift_sel[21 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[22 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[22]}} & {idx,e0c_shift_sel[22 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[23 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[23]}} & {idx,e0c_shift_sel[23 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[24 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[24]}} & {idx,e0c_shift_sel[24 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[25 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[25]}} & {idx,e0c_shift_sel[25 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[26 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[26]}} & {idx,e0c_shift_sel[26 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[27 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[27]}} & {idx,e0c_shift_sel[27 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[28 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[28]}} & {idx,e0c_shift_sel[28 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[29 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[29]}} & {idx,e0c_shift_sel[29 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[30 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[30]}} & {idx,e0c_shift_sel[30 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[31 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[31]}} & {idx,e0c_shift_sel[31 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[32 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[32]}} & {idx,e0c_shift_sel[32 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[33 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[33]}} & {idx,e0c_shift_sel[33 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[34 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[34]}} & {idx,e0c_shift_sel[34 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[35 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[35]}} & {idx,e0c_shift_sel[35 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[36 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[36]}} & {idx,e0c_shift_sel[36 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[37 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[37]}} & {idx,e0c_shift_sel[37 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[38 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[38]}} & {idx,e0c_shift_sel[38 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[39 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[39]}} & {idx,e0c_shift_sel[39 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[40 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[40]}} & {idx,e0c_shift_sel[40 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[41 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[41]}} & {idx,e0c_shift_sel[41 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[42 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[42]}} & {idx,e0c_shift_sel[42 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[43 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[43]}} & {idx,e0c_shift_sel[43 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[44 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[44]}} & {idx,e0c_shift_sel[44 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[45 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[45]}} & {idx,e0c_shift_sel[45 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[46 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[46]}} & {idx,e0c_shift_sel[46 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[47 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[47]}} & {idx,e0c_shift_sel[47 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[48 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[48]}} & {idx,e0c_shift_sel[48 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[49 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[49]}} & {idx,e0c_shift_sel[49 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[50 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[50]}} & {idx,e0c_shift_sel[50 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[51 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[51]}} & {idx,e0c_shift_sel[51 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[52 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[52]}} & {idx,e0c_shift_sel[52 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[53 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[53]}} & {idx,e0c_shift_sel[53 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[54 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[54]}} & {idx,e0c_shift_sel[54 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[55 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[55]}} & {idx,e0c_shift_sel[55 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[56 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[56]}} & {idx,e0c_shift_sel[56 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[57 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[57]}} & {idx,e0c_shift_sel[57 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[58 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[58]}} & {idx,e0c_shift_sel[58 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[59 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[59]}} & {idx,e0c_shift_sel[59 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[60 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[60]}} & {idx,e0c_shift_sel[60 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[61 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[61]}} & {idx,e0c_shift_sel[61 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[62 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[62]}} & {idx,e0c_shift_sel[62 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[63 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[63]}} & {idx,e0c_shift_sel[63 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[64 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[64]}} & {idx,e0c_shift_sel[64 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[65 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[65]}} & {idx,e0c_shift_sel[65 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[66 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[66]}} & {idx,e0c_shift_sel[66 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[67 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[67]}} & {idx,e0c_shift_sel[67 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[68 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[68]}} & {idx,e0c_shift_sel[68 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[69 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[69]}} & {idx,e0c_shift_sel[69 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[70 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[70]}} & {idx,e0c_shift_sel[70 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[71 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[71]}} & {idx,e0c_shift_sel[71 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[72 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[72]}} & {idx,e0c_shift_sel[72 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[73 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[73]}} & {idx,e0c_shift_sel[73 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[74 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[74]}} & {idx,e0c_shift_sel[74 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[75 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[75]}} & {idx,e0c_shift_sel[75 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[76 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[76]}} & {idx,e0c_shift_sel[76 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[77 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[77]}} & {idx,e0c_shift_sel[77 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[78 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[78]}} & {idx,e0c_shift_sel[78 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[79 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[79]}} & {idx,e0c_shift_sel[79 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[80 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[80]}} & {idx,e0c_shift_sel[80 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[81 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[81]}} & {idx,e0c_shift_sel[81 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[82 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[82]}} & {idx,e0c_shift_sel[82 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[83 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[83]}} & {idx,e0c_shift_sel[83 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[84 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[84]}} & {idx,e0c_shift_sel[84 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[85 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[85]}} & {idx,e0c_shift_sel[85 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[86 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[86]}} & {idx,e0c_shift_sel[86 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[87 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[87]}} & {idx,e0c_shift_sel[87 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[88 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[88]}} & {idx,e0c_shift_sel[88 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[89 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[89]}} & {idx,e0c_shift_sel[89 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[90 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[90]}} & {idx,e0c_shift_sel[90 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[91 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[91]}} & {idx,e0c_shift_sel[91 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[92 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[92]}} & {idx,e0c_shift_sel[92 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[93 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[93]}} & {idx,e0c_shift_sel[93 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[94 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[94]}} & {idx,e0c_shift_sel[94 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[95 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[95]}} & {idx,e0c_shift_sel[95 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[96 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[96]}} & {idx,e0c_shift_sel[96 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[97 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[97]}} & {idx,e0c_shift_sel[97 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[98 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[98]}} & {idx,e0c_shift_sel[98 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[99 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[99]}} & {idx,e0c_shift_sel[99 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[100 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[100]}} & {idx,e0c_shift_sel[100 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[101 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[101]}} & {idx,e0c_shift_sel[101 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[102 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[102]}} & {idx,e0c_shift_sel[102 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[103 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[103]}} & {idx,e0c_shift_sel[103 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[104 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[104]}} & {idx,e0c_shift_sel[104 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[105 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[105]}} & {idx,e0c_shift_sel[105 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[106 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[106]}} & {idx,e0c_shift_sel[106 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[107 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[107]}} & {idx,e0c_shift_sel[107 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[108 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[108]}} & {idx,e0c_shift_sel[108 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[109 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[109]}} & {idx,e0c_shift_sel[109 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[110 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[110]}} & {idx,e0c_shift_sel[110 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[111 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[111]}} & {idx,e0c_shift_sel[111 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[112 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[112]}} & {idx,e0c_shift_sel[112 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[113 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[113]}} & {idx,e0c_shift_sel[113 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[114 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[114]}} & {idx,e0c_shift_sel[114 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[115 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[115]}} & {idx,e0c_shift_sel[115 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[116 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[116]}} & {idx,e0c_shift_sel[116 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[117 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[117]}} & {idx,e0c_shift_sel[117 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[118 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[118]}} & {idx,e0c_shift_sel[118 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[119 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[119]}} & {idx,e0c_shift_sel[119 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[120 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[120]}} & {idx,e0c_shift_sel[120 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[121 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[121]}} & {idx,e0c_shift_sel[121 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[122 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[122]}} & {idx,e0c_shift_sel[122 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[123 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[123]}} & {idx,e0c_shift_sel[123 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[124 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[124]}} & {idx,e0c_shift_sel[124 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[125 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[125]}} & {idx,e0c_shift_sel[125 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[126 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[126]}} & {idx,e0c_shift_sel[126 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[127 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[127]}} & {idx,e0c_shift_sel[127 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
    end
endgenerate
generate
    if (SLICE_LEN == 16) begin:gen_direct_compress16
        wire [16 - 1:0] ffs1_mask_body;
        assign ffs1_mask_body[1 - 1:0] = {1{1'b0}};
        assign ffs1_mask_body[1] = &mask_in[1:0];
        assign ffs1_mask_body[2] = mask_in[2] & ~ffs0_mask[2] & ~|(~ffs0_mask[1 +:1] & mask_in[1 +:1]);
        assign ffs1_mask_body[3] = mask_in[3] & ~ffs0_mask[3] & ~|(~ffs0_mask[1 +:2] & mask_in[1 +:2]);
        assign ffs1_mask_body[4] = mask_in[4] & ~ffs0_mask[4] & ~|(~ffs0_mask[1 +:3] & mask_in[1 +:3]);
        assign ffs1_mask_body[5] = mask_in[5] & ~ffs0_mask[5] & ~|(~ffs0_mask[1 +:4] & mask_in[1 +:4]);
        assign ffs1_mask_body[6] = mask_in[6] & ~ffs0_mask[6] & ~|(~ffs0_mask[1 +:5] & mask_in[1 +:5]);
        assign ffs1_mask_body[7] = mask_in[7] & ~ffs0_mask[7] & ~|(~ffs0_mask[1 +:6] & mask_in[1 +:6]);
        assign ffs1_mask_body[8] = mask_in[8] & ~ffs0_mask[8] & ~|(~ffs0_mask[1 +:7] & mask_in[1 +:7]);
        assign ffs1_mask_body[9] = mask_in[9] & ~ffs0_mask[9] & ~|(~ffs0_mask[1 +:8] & mask_in[1 +:8]);
        assign ffs1_mask_body[10] = mask_in[10] & ~ffs0_mask[10] & ~|(~ffs0_mask[1 +:9] & mask_in[1 +:9]);
        assign ffs1_mask_body[11] = mask_in[11] & ~ffs0_mask[11] & ~|(~ffs0_mask[1 +:10] & mask_in[1 +:10]);
        assign ffs1_mask_body[12] = mask_in[12] & ~ffs0_mask[12] & ~|(~ffs0_mask[1 +:11] & mask_in[1 +:11]);
        assign ffs1_mask_body[13] = mask_in[13] & ~ffs0_mask[13] & ~|(~ffs0_mask[1 +:12] & mask_in[1 +:12]);
        assign ffs1_mask_body[14] = mask_in[14] & ~ffs0_mask[14] & ~|(~ffs0_mask[1 +:13] & mask_in[1 +:13]);
        assign ffs1_mask_body[15] = mask_in[15] & ~ffs0_mask[15] & ~|(~ffs0_mask[1 +:14] & mask_in[1 +:14]);
        wire [16 - 1:0] ffs1_mask = ffs0_mask | ffs1_mask_body;
        assign mask[1] = |ffs1_mask_body;
        kv_onehot2bin #(
            .N(16)
        ) u_set1 (
            .in(ffs1_mask_body),
            .out(sel[1 * 4 +:4])
        );
        wire [16 - 1:0] ffs2_mask_body;
        assign ffs2_mask_body[2 - 1:0] = {2{1'b0}};
        assign ffs2_mask_body[2] = &mask_in[2:0];
        assign ffs2_mask_body[3] = mask_in[3] & ~ffs1_mask[3] & ~|(~ffs1_mask[2 +:1] & mask_in[2 +:1]);
        assign ffs2_mask_body[4] = mask_in[4] & ~ffs1_mask[4] & ~|(~ffs1_mask[2 +:2] & mask_in[2 +:2]);
        assign ffs2_mask_body[5] = mask_in[5] & ~ffs1_mask[5] & ~|(~ffs1_mask[2 +:3] & mask_in[2 +:3]);
        assign ffs2_mask_body[6] = mask_in[6] & ~ffs1_mask[6] & ~|(~ffs1_mask[2 +:4] & mask_in[2 +:4]);
        assign ffs2_mask_body[7] = mask_in[7] & ~ffs1_mask[7] & ~|(~ffs1_mask[2 +:5] & mask_in[2 +:5]);
        assign ffs2_mask_body[8] = mask_in[8] & ~ffs1_mask[8] & ~|(~ffs1_mask[2 +:6] & mask_in[2 +:6]);
        assign ffs2_mask_body[9] = mask_in[9] & ~ffs1_mask[9] & ~|(~ffs1_mask[2 +:7] & mask_in[2 +:7]);
        assign ffs2_mask_body[10] = mask_in[10] & ~ffs1_mask[10] & ~|(~ffs1_mask[2 +:8] & mask_in[2 +:8]);
        assign ffs2_mask_body[11] = mask_in[11] & ~ffs1_mask[11] & ~|(~ffs1_mask[2 +:9] & mask_in[2 +:9]);
        assign ffs2_mask_body[12] = mask_in[12] & ~ffs1_mask[12] & ~|(~ffs1_mask[2 +:10] & mask_in[2 +:10]);
        assign ffs2_mask_body[13] = mask_in[13] & ~ffs1_mask[13] & ~|(~ffs1_mask[2 +:11] & mask_in[2 +:11]);
        assign ffs2_mask_body[14] = mask_in[14] & ~ffs1_mask[14] & ~|(~ffs1_mask[2 +:12] & mask_in[2 +:12]);
        assign ffs2_mask_body[15] = mask_in[15] & ~ffs1_mask[15] & ~|(~ffs1_mask[2 +:13] & mask_in[2 +:13]);
        wire [16 - 1:0] ffs2_mask = ffs1_mask | ffs2_mask_body;
        assign mask[2] = |ffs2_mask_body;
        kv_onehot2bin #(
            .N(16)
        ) u_set2 (
            .in(ffs2_mask_body),
            .out(sel[2 * 4 +:4])
        );
        wire [16 - 1:0] ffs3_mask_body;
        assign ffs3_mask_body[3 - 1:0] = {3{1'b0}};
        assign ffs3_mask_body[3] = &mask_in[3:0];
        assign ffs3_mask_body[4] = mask_in[4] & ~ffs2_mask[4] & ~|(~ffs2_mask[3 +:1] & mask_in[3 +:1]);
        assign ffs3_mask_body[5] = mask_in[5] & ~ffs2_mask[5] & ~|(~ffs2_mask[3 +:2] & mask_in[3 +:2]);
        assign ffs3_mask_body[6] = mask_in[6] & ~ffs2_mask[6] & ~|(~ffs2_mask[3 +:3] & mask_in[3 +:3]);
        assign ffs3_mask_body[7] = mask_in[7] & ~ffs2_mask[7] & ~|(~ffs2_mask[3 +:4] & mask_in[3 +:4]);
        assign ffs3_mask_body[8] = mask_in[8] & ~ffs2_mask[8] & ~|(~ffs2_mask[3 +:5] & mask_in[3 +:5]);
        assign ffs3_mask_body[9] = mask_in[9] & ~ffs2_mask[9] & ~|(~ffs2_mask[3 +:6] & mask_in[3 +:6]);
        assign ffs3_mask_body[10] = mask_in[10] & ~ffs2_mask[10] & ~|(~ffs2_mask[3 +:7] & mask_in[3 +:7]);
        assign ffs3_mask_body[11] = mask_in[11] & ~ffs2_mask[11] & ~|(~ffs2_mask[3 +:8] & mask_in[3 +:8]);
        assign ffs3_mask_body[12] = mask_in[12] & ~ffs2_mask[12] & ~|(~ffs2_mask[3 +:9] & mask_in[3 +:9]);
        assign ffs3_mask_body[13] = mask_in[13] & ~ffs2_mask[13] & ~|(~ffs2_mask[3 +:10] & mask_in[3 +:10]);
        assign ffs3_mask_body[14] = mask_in[14] & ~ffs2_mask[14] & ~|(~ffs2_mask[3 +:11] & mask_in[3 +:11]);
        assign ffs3_mask_body[15] = mask_in[15] & ~ffs2_mask[15] & ~|(~ffs2_mask[3 +:12] & mask_in[3 +:12]);
        wire [16 - 1:0] ffs3_mask = ffs2_mask | ffs3_mask_body;
        assign mask[3] = |ffs3_mask_body;
        kv_onehot2bin #(
            .N(16)
        ) u_set3 (
            .in(ffs3_mask_body),
            .out(sel[3 * 4 +:4])
        );
        wire [16 - 1:0] ffs4_mask_body;
        assign ffs4_mask_body[4 - 1:0] = {4{1'b0}};
        assign ffs4_mask_body[4] = &mask_in[4:0];
        assign ffs4_mask_body[5] = mask_in[5] & ~ffs3_mask[5] & ~|(~ffs3_mask[4 +:1] & mask_in[4 +:1]);
        assign ffs4_mask_body[6] = mask_in[6] & ~ffs3_mask[6] & ~|(~ffs3_mask[4 +:2] & mask_in[4 +:2]);
        assign ffs4_mask_body[7] = mask_in[7] & ~ffs3_mask[7] & ~|(~ffs3_mask[4 +:3] & mask_in[4 +:3]);
        assign ffs4_mask_body[8] = mask_in[8] & ~ffs3_mask[8] & ~|(~ffs3_mask[4 +:4] & mask_in[4 +:4]);
        assign ffs4_mask_body[9] = mask_in[9] & ~ffs3_mask[9] & ~|(~ffs3_mask[4 +:5] & mask_in[4 +:5]);
        assign ffs4_mask_body[10] = mask_in[10] & ~ffs3_mask[10] & ~|(~ffs3_mask[4 +:6] & mask_in[4 +:6]);
        assign ffs4_mask_body[11] = mask_in[11] & ~ffs3_mask[11] & ~|(~ffs3_mask[4 +:7] & mask_in[4 +:7]);
        assign ffs4_mask_body[12] = mask_in[12] & ~ffs3_mask[12] & ~|(~ffs3_mask[4 +:8] & mask_in[4 +:8]);
        assign ffs4_mask_body[13] = mask_in[13] & ~ffs3_mask[13] & ~|(~ffs3_mask[4 +:9] & mask_in[4 +:9]);
        assign ffs4_mask_body[14] = mask_in[14] & ~ffs3_mask[14] & ~|(~ffs3_mask[4 +:10] & mask_in[4 +:10]);
        assign ffs4_mask_body[15] = mask_in[15] & ~ffs3_mask[15] & ~|(~ffs3_mask[4 +:11] & mask_in[4 +:11]);
        wire [16 - 1:0] ffs4_mask = ffs3_mask | ffs4_mask_body;
        assign mask[4] = |ffs4_mask_body;
        kv_onehot2bin #(
            .N(16)
        ) u_set4 (
            .in(ffs4_mask_body),
            .out(sel[4 * 4 +:4])
        );
        wire [16 - 1:0] ffs5_mask_body;
        assign ffs5_mask_body[5 - 1:0] = {5{1'b0}};
        assign ffs5_mask_body[5] = &mask_in[5:0];
        assign ffs5_mask_body[6] = mask_in[6] & ~ffs4_mask[6] & ~|(~ffs4_mask[5 +:1] & mask_in[5 +:1]);
        assign ffs5_mask_body[7] = mask_in[7] & ~ffs4_mask[7] & ~|(~ffs4_mask[5 +:2] & mask_in[5 +:2]);
        assign ffs5_mask_body[8] = mask_in[8] & ~ffs4_mask[8] & ~|(~ffs4_mask[5 +:3] & mask_in[5 +:3]);
        assign ffs5_mask_body[9] = mask_in[9] & ~ffs4_mask[9] & ~|(~ffs4_mask[5 +:4] & mask_in[5 +:4]);
        assign ffs5_mask_body[10] = mask_in[10] & ~ffs4_mask[10] & ~|(~ffs4_mask[5 +:5] & mask_in[5 +:5]);
        assign ffs5_mask_body[11] = mask_in[11] & ~ffs4_mask[11] & ~|(~ffs4_mask[5 +:6] & mask_in[5 +:6]);
        assign ffs5_mask_body[12] = mask_in[12] & ~ffs4_mask[12] & ~|(~ffs4_mask[5 +:7] & mask_in[5 +:7]);
        assign ffs5_mask_body[13] = mask_in[13] & ~ffs4_mask[13] & ~|(~ffs4_mask[5 +:8] & mask_in[5 +:8]);
        assign ffs5_mask_body[14] = mask_in[14] & ~ffs4_mask[14] & ~|(~ffs4_mask[5 +:9] & mask_in[5 +:9]);
        assign ffs5_mask_body[15] = mask_in[15] & ~ffs4_mask[15] & ~|(~ffs4_mask[5 +:10] & mask_in[5 +:10]);
        wire [16 - 1:0] ffs5_mask = ffs4_mask | ffs5_mask_body;
        assign mask[5] = |ffs5_mask_body;
        kv_onehot2bin #(
            .N(16)
        ) u_set5 (
            .in(ffs5_mask_body),
            .out(sel[5 * 4 +:4])
        );
        wire [16 - 1:0] ffs6_mask_body;
        assign ffs6_mask_body[6 - 1:0] = {6{1'b0}};
        assign ffs6_mask_body[6] = &mask_in[6:0];
        assign ffs6_mask_body[7] = mask_in[7] & ~ffs5_mask[7] & ~|(~ffs5_mask[6 +:1] & mask_in[6 +:1]);
        assign ffs6_mask_body[8] = mask_in[8] & ~ffs5_mask[8] & ~|(~ffs5_mask[6 +:2] & mask_in[6 +:2]);
        assign ffs6_mask_body[9] = mask_in[9] & ~ffs5_mask[9] & ~|(~ffs5_mask[6 +:3] & mask_in[6 +:3]);
        assign ffs6_mask_body[10] = mask_in[10] & ~ffs5_mask[10] & ~|(~ffs5_mask[6 +:4] & mask_in[6 +:4]);
        assign ffs6_mask_body[11] = mask_in[11] & ~ffs5_mask[11] & ~|(~ffs5_mask[6 +:5] & mask_in[6 +:5]);
        assign ffs6_mask_body[12] = mask_in[12] & ~ffs5_mask[12] & ~|(~ffs5_mask[6 +:6] & mask_in[6 +:6]);
        assign ffs6_mask_body[13] = mask_in[13] & ~ffs5_mask[13] & ~|(~ffs5_mask[6 +:7] & mask_in[6 +:7]);
        assign ffs6_mask_body[14] = mask_in[14] & ~ffs5_mask[14] & ~|(~ffs5_mask[6 +:8] & mask_in[6 +:8]);
        assign ffs6_mask_body[15] = mask_in[15] & ~ffs5_mask[15] & ~|(~ffs5_mask[6 +:9] & mask_in[6 +:9]);
        wire [16 - 1:0] ffs6_mask = ffs5_mask | ffs6_mask_body;
        assign mask[6] = |ffs6_mask_body;
        kv_onehot2bin #(
            .N(16)
        ) u_set6 (
            .in(ffs6_mask_body),
            .out(sel[6 * 4 +:4])
        );
        wire [16 - 1:0] ffs7_mask_body;
        assign ffs7_mask_body[7 - 1:0] = {7{1'b0}};
        assign ffs7_mask_body[7] = &mask_in[7:0];
        assign ffs7_mask_body[8] = mask_in[8] & ~ffs6_mask[8] & ~|(~ffs6_mask[7 +:1] & mask_in[7 +:1]);
        assign ffs7_mask_body[9] = mask_in[9] & ~ffs6_mask[9] & ~|(~ffs6_mask[7 +:2] & mask_in[7 +:2]);
        assign ffs7_mask_body[10] = mask_in[10] & ~ffs6_mask[10] & ~|(~ffs6_mask[7 +:3] & mask_in[7 +:3]);
        assign ffs7_mask_body[11] = mask_in[11] & ~ffs6_mask[11] & ~|(~ffs6_mask[7 +:4] & mask_in[7 +:4]);
        assign ffs7_mask_body[12] = mask_in[12] & ~ffs6_mask[12] & ~|(~ffs6_mask[7 +:5] & mask_in[7 +:5]);
        assign ffs7_mask_body[13] = mask_in[13] & ~ffs6_mask[13] & ~|(~ffs6_mask[7 +:6] & mask_in[7 +:6]);
        assign ffs7_mask_body[14] = mask_in[14] & ~ffs6_mask[14] & ~|(~ffs6_mask[7 +:7] & mask_in[7 +:7]);
        assign ffs7_mask_body[15] = mask_in[15] & ~ffs6_mask[15] & ~|(~ffs6_mask[7 +:8] & mask_in[7 +:8]);
        wire [16 - 1:0] ffs7_mask = ffs6_mask | ffs7_mask_body;
        assign mask[7] = |ffs7_mask_body;
        kv_onehot2bin #(
            .N(16)
        ) u_set7 (
            .in(ffs7_mask_body),
            .out(sel[7 * 4 +:4])
        );
        wire [16 - 1:0] ffs8_mask_body;
        assign ffs8_mask_body[8 - 1:0] = {8{1'b0}};
        assign ffs8_mask_body[8] = &mask_in[8:0];
        assign ffs8_mask_body[9] = mask_in[9] & ~ffs7_mask[9] & ~|(~ffs7_mask[8 +:1] & mask_in[8 +:1]);
        assign ffs8_mask_body[10] = mask_in[10] & ~ffs7_mask[10] & ~|(~ffs7_mask[8 +:2] & mask_in[8 +:2]);
        assign ffs8_mask_body[11] = mask_in[11] & ~ffs7_mask[11] & ~|(~ffs7_mask[8 +:3] & mask_in[8 +:3]);
        assign ffs8_mask_body[12] = mask_in[12] & ~ffs7_mask[12] & ~|(~ffs7_mask[8 +:4] & mask_in[8 +:4]);
        assign ffs8_mask_body[13] = mask_in[13] & ~ffs7_mask[13] & ~|(~ffs7_mask[8 +:5] & mask_in[8 +:5]);
        assign ffs8_mask_body[14] = mask_in[14] & ~ffs7_mask[14] & ~|(~ffs7_mask[8 +:6] & mask_in[8 +:6]);
        assign ffs8_mask_body[15] = mask_in[15] & ~ffs7_mask[15] & ~|(~ffs7_mask[8 +:7] & mask_in[8 +:7]);
        wire [16 - 1:0] ffs8_mask = ffs7_mask | ffs8_mask_body;
        assign mask[8] = |ffs8_mask_body;
        kv_onehot2bin #(
            .N(16)
        ) u_set8 (
            .in(ffs8_mask_body),
            .out(sel[8 * 4 +:4])
        );
        wire [16 - 1:0] ffs9_mask_body;
        assign ffs9_mask_body[9 - 1:0] = {9{1'b0}};
        assign ffs9_mask_body[9] = &mask_in[9:0];
        assign ffs9_mask_body[10] = mask_in[10] & ~ffs8_mask[10] & ~|(~ffs8_mask[9 +:1] & mask_in[9 +:1]);
        assign ffs9_mask_body[11] = mask_in[11] & ~ffs8_mask[11] & ~|(~ffs8_mask[9 +:2] & mask_in[9 +:2]);
        assign ffs9_mask_body[12] = mask_in[12] & ~ffs8_mask[12] & ~|(~ffs8_mask[9 +:3] & mask_in[9 +:3]);
        assign ffs9_mask_body[13] = mask_in[13] & ~ffs8_mask[13] & ~|(~ffs8_mask[9 +:4] & mask_in[9 +:4]);
        assign ffs9_mask_body[14] = mask_in[14] & ~ffs8_mask[14] & ~|(~ffs8_mask[9 +:5] & mask_in[9 +:5]);
        assign ffs9_mask_body[15] = mask_in[15] & ~ffs8_mask[15] & ~|(~ffs8_mask[9 +:6] & mask_in[9 +:6]);
        wire [16 - 1:0] ffs9_mask = ffs8_mask | ffs9_mask_body;
        assign mask[9] = |ffs9_mask_body;
        kv_onehot2bin #(
            .N(16)
        ) u_set9 (
            .in(ffs9_mask_body),
            .out(sel[9 * 4 +:4])
        );
        wire [16 - 1:0] ffs10_mask_body;
        assign ffs10_mask_body[10 - 1:0] = {10{1'b0}};
        assign ffs10_mask_body[10] = &mask_in[10:0];
        assign ffs10_mask_body[11] = mask_in[11] & ~ffs9_mask[11] & ~|(~ffs9_mask[10 +:1] & mask_in[10 +:1]);
        assign ffs10_mask_body[12] = mask_in[12] & ~ffs9_mask[12] & ~|(~ffs9_mask[10 +:2] & mask_in[10 +:2]);
        assign ffs10_mask_body[13] = mask_in[13] & ~ffs9_mask[13] & ~|(~ffs9_mask[10 +:3] & mask_in[10 +:3]);
        assign ffs10_mask_body[14] = mask_in[14] & ~ffs9_mask[14] & ~|(~ffs9_mask[10 +:4] & mask_in[10 +:4]);
        assign ffs10_mask_body[15] = mask_in[15] & ~ffs9_mask[15] & ~|(~ffs9_mask[10 +:5] & mask_in[10 +:5]);
        wire [16 - 1:0] ffs10_mask = ffs9_mask | ffs10_mask_body;
        assign mask[10] = |ffs10_mask_body;
        kv_onehot2bin #(
            .N(16)
        ) u_set10 (
            .in(ffs10_mask_body),
            .out(sel[10 * 4 +:4])
        );
        wire [16 - 1:0] ffs11_mask_body;
        assign ffs11_mask_body[11 - 1:0] = {11{1'b0}};
        assign ffs11_mask_body[11] = &mask_in[11:0];
        assign ffs11_mask_body[12] = mask_in[12] & ~ffs10_mask[12] & ~|(~ffs10_mask[11 +:1] & mask_in[11 +:1]);
        assign ffs11_mask_body[13] = mask_in[13] & ~ffs10_mask[13] & ~|(~ffs10_mask[11 +:2] & mask_in[11 +:2]);
        assign ffs11_mask_body[14] = mask_in[14] & ~ffs10_mask[14] & ~|(~ffs10_mask[11 +:3] & mask_in[11 +:3]);
        assign ffs11_mask_body[15] = mask_in[15] & ~ffs10_mask[15] & ~|(~ffs10_mask[11 +:4] & mask_in[11 +:4]);
        wire [16 - 1:0] ffs11_mask = ffs10_mask | ffs11_mask_body;
        assign mask[11] = |ffs11_mask_body;
        kv_onehot2bin #(
            .N(16)
        ) u_set11 (
            .in(ffs11_mask_body),
            .out(sel[11 * 4 +:4])
        );
        wire [16 - 1:0] ffs12_mask_body;
        assign ffs12_mask_body[12 - 1:0] = {12{1'b0}};
        assign ffs12_mask_body[12] = &mask_in[12:0];
        assign ffs12_mask_body[13] = mask_in[13] & ~ffs11_mask[13] & ~|(~ffs11_mask[12 +:1] & mask_in[12 +:1]);
        assign ffs12_mask_body[14] = mask_in[14] & ~ffs11_mask[14] & ~|(~ffs11_mask[12 +:2] & mask_in[12 +:2]);
        assign ffs12_mask_body[15] = mask_in[15] & ~ffs11_mask[15] & ~|(~ffs11_mask[12 +:3] & mask_in[12 +:3]);
        wire [16 - 1:0] ffs12_mask = ffs11_mask | ffs12_mask_body;
        assign mask[12] = |ffs12_mask_body;
        kv_onehot2bin #(
            .N(16)
        ) u_set12 (
            .in(ffs12_mask_body),
            .out(sel[12 * 4 +:4])
        );
        wire [16 - 1:0] ffs13_mask_body;
        assign ffs13_mask_body[13 - 1:0] = {13{1'b0}};
        assign ffs13_mask_body[13] = &mask_in[13:0];
        assign ffs13_mask_body[14] = mask_in[14] & ~ffs12_mask[14] & ~|(~ffs12_mask[13 +:1] & mask_in[13 +:1]);
        assign ffs13_mask_body[15] = mask_in[15] & ~ffs12_mask[15] & ~|(~ffs12_mask[13 +:2] & mask_in[13 +:2]);
        wire [16 - 1:0] ffs13_mask = ffs12_mask | ffs13_mask_body;
        assign mask[13] = |ffs13_mask_body;
        kv_onehot2bin #(
            .N(16)
        ) u_set13 (
            .in(ffs13_mask_body),
            .out(sel[13 * 4 +:4])
        );
        wire [16 - 1:0] ffs14_mask_body;
        assign ffs14_mask_body[14 - 1:0] = {14{1'b0}};
        assign ffs14_mask_body[14] = &mask_in[14:0];
        assign ffs14_mask_body[15] = mask_in[15] & ~ffs13_mask[15] & ~|(~ffs13_mask[14 +:1] & mask_in[14 +:1]);
        wire [16 - 1:0] ffs14_mask = ffs13_mask | ffs14_mask_body;
        assign mask[14] = |ffs14_mask_body;
        kv_onehot2bin #(
            .N(16)
        ) u_set14 (
            .in(ffs14_mask_body),
            .out(sel[14 * 4 +:4])
        );
        wire [16 - 1:0] ffs15_mask_body;
        assign ffs15_mask_body[15 - 1:0] = {15{1'b0}};
        assign ffs15_mask_body[15] = &mask_in[15:0];
        wire [16 - 1:0] ffs15_mask = ffs14_mask | ffs15_mask_body;
        assign mask[15] = |ffs15_mask_body;
        kv_onehot2bin #(
            .N(16)
        ) u_set15 (
            .in(ffs15_mask_body),
            .out(sel[15 * 4 +:4])
        );
        wire [16 - 1:0] nds_unused_mask = ffs15_mask;
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum0 = {{240 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[0]}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum1 = sel_sum0 | {{239 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[1]}},{1 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum2 = sel_sum1 | {{238 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[2]}},{2 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum3 = sel_sum2 | {{237 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[3]}},{3 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum4 = sel_sum3 | {{236 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[4]}},{4 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum5 = sel_sum4 | {{235 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[5]}},{5 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum6 = sel_sum5 | {{234 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[6]}},{6 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum7 = sel_sum6 | {{233 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[7]}},{7 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum8 = sel_sum7 | {{232 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[8]}},{8 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum9 = sel_sum8 | {{231 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[9]}},{9 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum10 = sel_sum9 | {{230 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[10]}},{10 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum11 = sel_sum10 | {{229 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[11]}},{11 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum12 = sel_sum11 | {{228 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[12]}},{12 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum13 = sel_sum12 | {{227 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[13]}},{13 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum14 = sel_sum13 | {{226 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[14]}},{14 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum15 = sel_sum14 | {{225 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[15]}},{15 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum16 = sel_sum15 | {{224 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[16]}},{16 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum17 = sel_sum16 | {{223 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[17]}},{17 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum18 = sel_sum17 | {{222 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[18]}},{18 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum19 = sel_sum18 | {{221 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[19]}},{19 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum20 = sel_sum19 | {{220 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[20]}},{20 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum21 = sel_sum20 | {{219 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[21]}},{21 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum22 = sel_sum21 | {{218 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[22]}},{22 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum23 = sel_sum22 | {{217 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[23]}},{23 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum24 = sel_sum23 | {{216 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[24]}},{24 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum25 = sel_sum24 | {{215 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[25]}},{25 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum26 = sel_sum25 | {{214 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[26]}},{26 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum27 = sel_sum26 | {{213 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[27]}},{27 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum28 = sel_sum27 | {{212 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[28]}},{28 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum29 = sel_sum28 | {{211 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[29]}},{29 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum30 = sel_sum29 | {{210 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[30]}},{30 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum31 = sel_sum30 | {{209 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[31]}},{31 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum32 = sel_sum31 | {{208 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[32]}},{32 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum33 = sel_sum32 | {{207 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[33]}},{33 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum34 = sel_sum33 | {{206 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[34]}},{34 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum35 = sel_sum34 | {{205 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[35]}},{35 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum36 = sel_sum35 | {{204 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[36]}},{36 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum37 = sel_sum36 | {{203 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[37]}},{37 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum38 = sel_sum37 | {{202 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[38]}},{38 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum39 = sel_sum38 | {{201 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[39]}},{39 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum40 = sel_sum39 | {{200 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[40]}},{40 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum41 = sel_sum40 | {{199 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[41]}},{41 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum42 = sel_sum41 | {{198 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[42]}},{42 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum43 = sel_sum42 | {{197 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[43]}},{43 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum44 = sel_sum43 | {{196 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[44]}},{44 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum45 = sel_sum44 | {{195 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[45]}},{45 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum46 = sel_sum45 | {{194 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[46]}},{46 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum47 = sel_sum46 | {{193 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[47]}},{47 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum48 = sel_sum47 | {{192 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[48]}},{48 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum49 = sel_sum48 | {{191 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[49]}},{49 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum50 = sel_sum49 | {{190 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[50]}},{50 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum51 = sel_sum50 | {{189 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[51]}},{51 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum52 = sel_sum51 | {{188 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[52]}},{52 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum53 = sel_sum52 | {{187 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[53]}},{53 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum54 = sel_sum53 | {{186 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[54]}},{54 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum55 = sel_sum54 | {{185 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[55]}},{55 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum56 = sel_sum55 | {{184 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[56]}},{56 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum57 = sel_sum56 | {{183 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[57]}},{57 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum58 = sel_sum57 | {{182 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[58]}},{58 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum59 = sel_sum58 | {{181 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[59]}},{59 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum60 = sel_sum59 | {{180 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[60]}},{60 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum61 = sel_sum60 | {{179 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[61]}},{61 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum62 = sel_sum61 | {{178 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[62]}},{62 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum63 = sel_sum62 | {{177 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[63]}},{63 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum64 = sel_sum63 | {{176 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[64]}},{64 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum65 = sel_sum64 | {{175 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[65]}},{65 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum66 = sel_sum65 | {{174 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[66]}},{66 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum67 = sel_sum66 | {{173 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[67]}},{67 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum68 = sel_sum67 | {{172 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[68]}},{68 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum69 = sel_sum68 | {{171 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[69]}},{69 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum70 = sel_sum69 | {{170 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[70]}},{70 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum71 = sel_sum70 | {{169 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[71]}},{71 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum72 = sel_sum71 | {{168 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[72]}},{72 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum73 = sel_sum72 | {{167 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[73]}},{73 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum74 = sel_sum73 | {{166 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[74]}},{74 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum75 = sel_sum74 | {{165 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[75]}},{75 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum76 = sel_sum75 | {{164 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[76]}},{76 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum77 = sel_sum76 | {{163 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[77]}},{77 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum78 = sel_sum77 | {{162 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[78]}},{78 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum79 = sel_sum78 | {{161 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[79]}},{79 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum80 = sel_sum79 | {{160 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[80]}},{80 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum81 = sel_sum80 | {{159 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[81]}},{81 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum82 = sel_sum81 | {{158 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[82]}},{82 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum83 = sel_sum82 | {{157 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[83]}},{83 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum84 = sel_sum83 | {{156 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[84]}},{84 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum85 = sel_sum84 | {{155 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[85]}},{85 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum86 = sel_sum85 | {{154 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[86]}},{86 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum87 = sel_sum86 | {{153 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[87]}},{87 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum88 = sel_sum87 | {{152 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[88]}},{88 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum89 = sel_sum88 | {{151 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[89]}},{89 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum90 = sel_sum89 | {{150 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[90]}},{90 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum91 = sel_sum90 | {{149 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[91]}},{91 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum92 = sel_sum91 | {{148 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[92]}},{92 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum93 = sel_sum92 | {{147 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[93]}},{93 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum94 = sel_sum93 | {{146 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[94]}},{94 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum95 = sel_sum94 | {{145 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[95]}},{95 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum96 = sel_sum95 | {{144 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[96]}},{96 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum97 = sel_sum96 | {{143 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[97]}},{97 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum98 = sel_sum97 | {{142 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[98]}},{98 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum99 = sel_sum98 | {{141 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[99]}},{99 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum100 = sel_sum99 | {{140 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[100]}},{100 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum101 = sel_sum100 | {{139 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[101]}},{101 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum102 = sel_sum101 | {{138 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[102]}},{102 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum103 = sel_sum102 | {{137 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[103]}},{103 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum104 = sel_sum103 | {{136 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[104]}},{104 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum105 = sel_sum104 | {{135 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[105]}},{105 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum106 = sel_sum105 | {{134 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[106]}},{106 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum107 = sel_sum106 | {{133 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[107]}},{107 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum108 = sel_sum107 | {{132 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[108]}},{108 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum109 = sel_sum108 | {{131 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[109]}},{109 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum110 = sel_sum109 | {{130 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[110]}},{110 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum111 = sel_sum110 | {{129 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[111]}},{111 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum112 = sel_sum111 | {{128 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[112]}},{112 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum113 = sel_sum112 | {{127 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[113]}},{113 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum114 = sel_sum113 | {{126 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[114]}},{114 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum115 = sel_sum114 | {{125 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[115]}},{115 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum116 = sel_sum115 | {{124 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[116]}},{116 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum117 = sel_sum116 | {{123 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[117]}},{117 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum118 = sel_sum117 | {{122 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[118]}},{118 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum119 = sel_sum118 | {{121 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[119]}},{119 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum120 = sel_sum119 | {{120 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[120]}},{120 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum121 = sel_sum120 | {{119 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[121]}},{121 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum122 = sel_sum121 | {{118 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[122]}},{122 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum123 = sel_sum122 | {{117 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[123]}},{123 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum124 = sel_sum123 | {{116 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[124]}},{124 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum125 = sel_sum124 | {{115 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[125]}},{125 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum126 = sel_sum125 | {{114 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[126]}},{126 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum127 = sel_sum126 | {{113 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[127]}},{127 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum128 = sel_sum127 | {{112 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[128]}},{128 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum129 = sel_sum128 | {{111 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[129]}},{129 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum130 = sel_sum129 | {{110 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[130]}},{130 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum131 = sel_sum130 | {{109 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[131]}},{131 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum132 = sel_sum131 | {{108 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[132]}},{132 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum133 = sel_sum132 | {{107 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[133]}},{133 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum134 = sel_sum133 | {{106 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[134]}},{134 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum135 = sel_sum134 | {{105 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[135]}},{135 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum136 = sel_sum135 | {{104 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[136]}},{136 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum137 = sel_sum136 | {{103 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[137]}},{137 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum138 = sel_sum137 | {{102 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[138]}},{138 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum139 = sel_sum138 | {{101 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[139]}},{139 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum140 = sel_sum139 | {{100 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[140]}},{140 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum141 = sel_sum140 | {{99 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[141]}},{141 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum142 = sel_sum141 | {{98 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[142]}},{142 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum143 = sel_sum142 | {{97 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[143]}},{143 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum144 = sel_sum143 | {{96 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[144]}},{144 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum145 = sel_sum144 | {{95 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[145]}},{145 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum146 = sel_sum145 | {{94 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[146]}},{146 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum147 = sel_sum146 | {{93 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[147]}},{147 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum148 = sel_sum147 | {{92 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[148]}},{148 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum149 = sel_sum148 | {{91 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[149]}},{149 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum150 = sel_sum149 | {{90 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[150]}},{150 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum151 = sel_sum150 | {{89 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[151]}},{151 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum152 = sel_sum151 | {{88 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[152]}},{152 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum153 = sel_sum152 | {{87 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[153]}},{153 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum154 = sel_sum153 | {{86 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[154]}},{154 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum155 = sel_sum154 | {{85 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[155]}},{155 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum156 = sel_sum155 | {{84 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[156]}},{156 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum157 = sel_sum156 | {{83 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[157]}},{157 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum158 = sel_sum157 | {{82 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[158]}},{158 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum159 = sel_sum158 | {{81 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[159]}},{159 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum160 = sel_sum159 | {{80 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[160]}},{160 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum161 = sel_sum160 | {{79 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[161]}},{161 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum162 = sel_sum161 | {{78 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[162]}},{162 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum163 = sel_sum162 | {{77 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[163]}},{163 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum164 = sel_sum163 | {{76 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[164]}},{164 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum165 = sel_sum164 | {{75 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[165]}},{165 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum166 = sel_sum165 | {{74 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[166]}},{166 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum167 = sel_sum166 | {{73 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[167]}},{167 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum168 = sel_sum167 | {{72 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[168]}},{168 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum169 = sel_sum168 | {{71 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[169]}},{169 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum170 = sel_sum169 | {{70 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[170]}},{170 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum171 = sel_sum170 | {{69 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[171]}},{171 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum172 = sel_sum171 | {{68 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[172]}},{172 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum173 = sel_sum172 | {{67 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[173]}},{173 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum174 = sel_sum173 | {{66 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[174]}},{174 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum175 = sel_sum174 | {{65 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[175]}},{175 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum176 = sel_sum175 | {{64 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[176]}},{176 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum177 = sel_sum176 | {{63 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[177]}},{177 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum178 = sel_sum177 | {{62 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[178]}},{178 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum179 = sel_sum178 | {{61 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[179]}},{179 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum180 = sel_sum179 | {{60 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[180]}},{180 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum181 = sel_sum180 | {{59 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[181]}},{181 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum182 = sel_sum181 | {{58 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[182]}},{182 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum183 = sel_sum182 | {{57 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[183]}},{183 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum184 = sel_sum183 | {{56 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[184]}},{184 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum185 = sel_sum184 | {{55 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[185]}},{185 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum186 = sel_sum185 | {{54 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[186]}},{186 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum187 = sel_sum186 | {{53 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[187]}},{187 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum188 = sel_sum187 | {{52 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[188]}},{188 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum189 = sel_sum188 | {{51 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[189]}},{189 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum190 = sel_sum189 | {{50 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[190]}},{190 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum191 = sel_sum190 | {{49 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[191]}},{191 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum192 = sel_sum191 | {{48 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[192]}},{192 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum193 = sel_sum192 | {{47 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[193]}},{193 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum194 = sel_sum193 | {{46 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[194]}},{194 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum195 = sel_sum194 | {{45 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[195]}},{195 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum196 = sel_sum195 | {{44 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[196]}},{196 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum197 = sel_sum196 | {{43 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[197]}},{197 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum198 = sel_sum197 | {{42 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[198]}},{198 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum199 = sel_sum198 | {{41 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[199]}},{199 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum200 = sel_sum199 | {{40 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[200]}},{200 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum201 = sel_sum200 | {{39 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[201]}},{201 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum202 = sel_sum201 | {{38 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[202]}},{202 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum203 = sel_sum202 | {{37 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[203]}},{203 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum204 = sel_sum203 | {{36 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[204]}},{204 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum205 = sel_sum204 | {{35 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[205]}},{205 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum206 = sel_sum205 | {{34 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[206]}},{206 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum207 = sel_sum206 | {{33 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[207]}},{207 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum208 = sel_sum207 | {{32 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[208]}},{208 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum209 = sel_sum208 | {{31 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[209]}},{209 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum210 = sel_sum209 | {{30 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[210]}},{210 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum211 = sel_sum210 | {{29 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[211]}},{211 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum212 = sel_sum211 | {{28 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[212]}},{212 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum213 = sel_sum212 | {{27 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[213]}},{213 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum214 = sel_sum213 | {{26 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[214]}},{214 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum215 = sel_sum214 | {{25 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[215]}},{215 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum216 = sel_sum215 | {{24 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[216]}},{216 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum217 = sel_sum216 | {{23 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[217]}},{217 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum218 = sel_sum217 | {{22 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[218]}},{218 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum219 = sel_sum218 | {{21 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[219]}},{219 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum220 = sel_sum219 | {{20 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[220]}},{220 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum221 = sel_sum220 | {{19 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[221]}},{221 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum222 = sel_sum221 | {{18 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[222]}},{222 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum223 = sel_sum222 | {{17 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[223]}},{223 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum224 = sel_sum223 | {{16 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[224]}},{224 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum225 = sel_sum224 | {{15 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[225]}},{225 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum226 = sel_sum225 | {{14 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[226]}},{226 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum227 = sel_sum226 | {{13 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[227]}},{227 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum228 = sel_sum227 | {{12 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[228]}},{228 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum229 = sel_sum228 | {{11 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[229]}},{229 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum230 = sel_sum229 | {{10 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[230]}},{230 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum231 = sel_sum230 | {{9 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[231]}},{231 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum232 = sel_sum231 | {{8 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[232]}},{232 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum233 = sel_sum232 | {{7 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[233]}},{233 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum234 = sel_sum233 | {{6 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[234]}},{234 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum235 = sel_sum234 | {{5 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[235]}},{235 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum236 = sel_sum235 | {{4 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[236]}},{236 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum237 = sel_sum236 | {{3 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[237]}},{237 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum238 = sel_sum237 | {{2 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[238]}},{238 * SLICE_LEN_LOG2{1'b0}}};
        wire [256 * SLICE_LEN_LOG2 - 1:0] sel_sum239 = sel_sum238 | {{1 * SLICE_LEN_LOG2{1'b0}},e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[239]}},{239 * SLICE_LEN_LOG2{1'b0}}};
        assign e0c_shift_sel = sel_sum239 | {e0c_sel & {16 * SLICE_LEN_LOG2{shift_onehot[240]}},{240 * SLICE_LEN_LOG2{1'b0}}};
        assign shift_sel[0 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[0]}} & {idx,e0c_shift_sel[0 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[1 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[1]}} & {idx,e0c_shift_sel[1 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[2 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[2]}} & {idx,e0c_shift_sel[2 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[3 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[3]}} & {idx,e0c_shift_sel[3 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[4 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[4]}} & {idx,e0c_shift_sel[4 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[5 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[5]}} & {idx,e0c_shift_sel[5 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[6 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[6]}} & {idx,e0c_shift_sel[6 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[7 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[7]}} & {idx,e0c_shift_sel[7 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[8 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[8]}} & {idx,e0c_shift_sel[8 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[9 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[9]}} & {idx,e0c_shift_sel[9 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[10 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[10]}} & {idx,e0c_shift_sel[10 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[11 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[11]}} & {idx,e0c_shift_sel[11 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[12 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[12]}} & {idx,e0c_shift_sel[12 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[13 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[13]}} & {idx,e0c_shift_sel[13 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[14 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[14]}} & {idx,e0c_shift_sel[14 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[15 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[15]}} & {idx,e0c_shift_sel[15 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[16 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[16]}} & {idx,e0c_shift_sel[16 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[17 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[17]}} & {idx,e0c_shift_sel[17 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[18 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[18]}} & {idx,e0c_shift_sel[18 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[19 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[19]}} & {idx,e0c_shift_sel[19 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[20 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[20]}} & {idx,e0c_shift_sel[20 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[21 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[21]}} & {idx,e0c_shift_sel[21 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[22 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[22]}} & {idx,e0c_shift_sel[22 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[23 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[23]}} & {idx,e0c_shift_sel[23 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[24 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[24]}} & {idx,e0c_shift_sel[24 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[25 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[25]}} & {idx,e0c_shift_sel[25 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[26 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[26]}} & {idx,e0c_shift_sel[26 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[27 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[27]}} & {idx,e0c_shift_sel[27 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[28 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[28]}} & {idx,e0c_shift_sel[28 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[29 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[29]}} & {idx,e0c_shift_sel[29 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[30 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[30]}} & {idx,e0c_shift_sel[30 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[31 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[31]}} & {idx,e0c_shift_sel[31 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[32 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[32]}} & {idx,e0c_shift_sel[32 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[33 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[33]}} & {idx,e0c_shift_sel[33 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[34 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[34]}} & {idx,e0c_shift_sel[34 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[35 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[35]}} & {idx,e0c_shift_sel[35 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[36 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[36]}} & {idx,e0c_shift_sel[36 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[37 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[37]}} & {idx,e0c_shift_sel[37 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[38 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[38]}} & {idx,e0c_shift_sel[38 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[39 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[39]}} & {idx,e0c_shift_sel[39 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[40 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[40]}} & {idx,e0c_shift_sel[40 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[41 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[41]}} & {idx,e0c_shift_sel[41 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[42 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[42]}} & {idx,e0c_shift_sel[42 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[43 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[43]}} & {idx,e0c_shift_sel[43 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[44 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[44]}} & {idx,e0c_shift_sel[44 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[45 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[45]}} & {idx,e0c_shift_sel[45 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[46 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[46]}} & {idx,e0c_shift_sel[46 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[47 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[47]}} & {idx,e0c_shift_sel[47 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[48 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[48]}} & {idx,e0c_shift_sel[48 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[49 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[49]}} & {idx,e0c_shift_sel[49 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[50 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[50]}} & {idx,e0c_shift_sel[50 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[51 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[51]}} & {idx,e0c_shift_sel[51 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[52 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[52]}} & {idx,e0c_shift_sel[52 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[53 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[53]}} & {idx,e0c_shift_sel[53 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[54 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[54]}} & {idx,e0c_shift_sel[54 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[55 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[55]}} & {idx,e0c_shift_sel[55 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[56 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[56]}} & {idx,e0c_shift_sel[56 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[57 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[57]}} & {idx,e0c_shift_sel[57 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[58 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[58]}} & {idx,e0c_shift_sel[58 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[59 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[59]}} & {idx,e0c_shift_sel[59 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[60 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[60]}} & {idx,e0c_shift_sel[60 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[61 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[61]}} & {idx,e0c_shift_sel[61 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[62 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[62]}} & {idx,e0c_shift_sel[62 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[63 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[63]}} & {idx,e0c_shift_sel[63 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[64 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[64]}} & {idx,e0c_shift_sel[64 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[65 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[65]}} & {idx,e0c_shift_sel[65 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[66 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[66]}} & {idx,e0c_shift_sel[66 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[67 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[67]}} & {idx,e0c_shift_sel[67 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[68 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[68]}} & {idx,e0c_shift_sel[68 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[69 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[69]}} & {idx,e0c_shift_sel[69 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[70 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[70]}} & {idx,e0c_shift_sel[70 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[71 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[71]}} & {idx,e0c_shift_sel[71 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[72 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[72]}} & {idx,e0c_shift_sel[72 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[73 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[73]}} & {idx,e0c_shift_sel[73 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[74 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[74]}} & {idx,e0c_shift_sel[74 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[75 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[75]}} & {idx,e0c_shift_sel[75 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[76 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[76]}} & {idx,e0c_shift_sel[76 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[77 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[77]}} & {idx,e0c_shift_sel[77 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[78 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[78]}} & {idx,e0c_shift_sel[78 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[79 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[79]}} & {idx,e0c_shift_sel[79 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[80 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[80]}} & {idx,e0c_shift_sel[80 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[81 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[81]}} & {idx,e0c_shift_sel[81 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[82 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[82]}} & {idx,e0c_shift_sel[82 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[83 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[83]}} & {idx,e0c_shift_sel[83 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[84 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[84]}} & {idx,e0c_shift_sel[84 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[85 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[85]}} & {idx,e0c_shift_sel[85 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[86 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[86]}} & {idx,e0c_shift_sel[86 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[87 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[87]}} & {idx,e0c_shift_sel[87 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[88 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[88]}} & {idx,e0c_shift_sel[88 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[89 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[89]}} & {idx,e0c_shift_sel[89 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[90 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[90]}} & {idx,e0c_shift_sel[90 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[91 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[91]}} & {idx,e0c_shift_sel[91 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[92 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[92]}} & {idx,e0c_shift_sel[92 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[93 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[93]}} & {idx,e0c_shift_sel[93 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[94 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[94]}} & {idx,e0c_shift_sel[94 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[95 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[95]}} & {idx,e0c_shift_sel[95 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[96 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[96]}} & {idx,e0c_shift_sel[96 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[97 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[97]}} & {idx,e0c_shift_sel[97 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[98 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[98]}} & {idx,e0c_shift_sel[98 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[99 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[99]}} & {idx,e0c_shift_sel[99 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[100 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[100]}} & {idx,e0c_shift_sel[100 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[101 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[101]}} & {idx,e0c_shift_sel[101 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[102 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[102]}} & {idx,e0c_shift_sel[102 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[103 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[103]}} & {idx,e0c_shift_sel[103 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[104 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[104]}} & {idx,e0c_shift_sel[104 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[105 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[105]}} & {idx,e0c_shift_sel[105 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[106 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[106]}} & {idx,e0c_shift_sel[106 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[107 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[107]}} & {idx,e0c_shift_sel[107 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[108 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[108]}} & {idx,e0c_shift_sel[108 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[109 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[109]}} & {idx,e0c_shift_sel[109 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[110 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[110]}} & {idx,e0c_shift_sel[110 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[111 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[111]}} & {idx,e0c_shift_sel[111 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[112 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[112]}} & {idx,e0c_shift_sel[112 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[113 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[113]}} & {idx,e0c_shift_sel[113 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[114 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[114]}} & {idx,e0c_shift_sel[114 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[115 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[115]}} & {idx,e0c_shift_sel[115 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[116 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[116]}} & {idx,e0c_shift_sel[116 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[117 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[117]}} & {idx,e0c_shift_sel[117 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[118 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[118]}} & {idx,e0c_shift_sel[118 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[119 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[119]}} & {idx,e0c_shift_sel[119 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[120 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[120]}} & {idx,e0c_shift_sel[120 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[121 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[121]}} & {idx,e0c_shift_sel[121 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[122 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[122]}} & {idx,e0c_shift_sel[122 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[123 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[123]}} & {idx,e0c_shift_sel[123 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[124 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[124]}} & {idx,e0c_shift_sel[124 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[125 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[125]}} & {idx,e0c_shift_sel[125 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[126 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[126]}} & {idx,e0c_shift_sel[126 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[127 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[127]}} & {idx,e0c_shift_sel[127 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[128 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[128]}} & {idx,e0c_shift_sel[128 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[129 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[129]}} & {idx,e0c_shift_sel[129 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[130 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[130]}} & {idx,e0c_shift_sel[130 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[131 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[131]}} & {idx,e0c_shift_sel[131 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[132 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[132]}} & {idx,e0c_shift_sel[132 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[133 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[133]}} & {idx,e0c_shift_sel[133 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[134 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[134]}} & {idx,e0c_shift_sel[134 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[135 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[135]}} & {idx,e0c_shift_sel[135 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[136 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[136]}} & {idx,e0c_shift_sel[136 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[137 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[137]}} & {idx,e0c_shift_sel[137 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[138 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[138]}} & {idx,e0c_shift_sel[138 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[139 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[139]}} & {idx,e0c_shift_sel[139 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[140 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[140]}} & {idx,e0c_shift_sel[140 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[141 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[141]}} & {idx,e0c_shift_sel[141 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[142 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[142]}} & {idx,e0c_shift_sel[142 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[143 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[143]}} & {idx,e0c_shift_sel[143 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[144 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[144]}} & {idx,e0c_shift_sel[144 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[145 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[145]}} & {idx,e0c_shift_sel[145 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[146 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[146]}} & {idx,e0c_shift_sel[146 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[147 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[147]}} & {idx,e0c_shift_sel[147 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[148 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[148]}} & {idx,e0c_shift_sel[148 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[149 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[149]}} & {idx,e0c_shift_sel[149 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[150 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[150]}} & {idx,e0c_shift_sel[150 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[151 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[151]}} & {idx,e0c_shift_sel[151 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[152 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[152]}} & {idx,e0c_shift_sel[152 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[153 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[153]}} & {idx,e0c_shift_sel[153 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[154 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[154]}} & {idx,e0c_shift_sel[154 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[155 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[155]}} & {idx,e0c_shift_sel[155 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[156 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[156]}} & {idx,e0c_shift_sel[156 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[157 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[157]}} & {idx,e0c_shift_sel[157 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[158 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[158]}} & {idx,e0c_shift_sel[158 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[159 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[159]}} & {idx,e0c_shift_sel[159 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[160 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[160]}} & {idx,e0c_shift_sel[160 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[161 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[161]}} & {idx,e0c_shift_sel[161 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[162 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[162]}} & {idx,e0c_shift_sel[162 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[163 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[163]}} & {idx,e0c_shift_sel[163 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[164 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[164]}} & {idx,e0c_shift_sel[164 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[165 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[165]}} & {idx,e0c_shift_sel[165 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[166 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[166]}} & {idx,e0c_shift_sel[166 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[167 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[167]}} & {idx,e0c_shift_sel[167 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[168 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[168]}} & {idx,e0c_shift_sel[168 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[169 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[169]}} & {idx,e0c_shift_sel[169 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[170 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[170]}} & {idx,e0c_shift_sel[170 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[171 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[171]}} & {idx,e0c_shift_sel[171 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[172 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[172]}} & {idx,e0c_shift_sel[172 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[173 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[173]}} & {idx,e0c_shift_sel[173 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[174 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[174]}} & {idx,e0c_shift_sel[174 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[175 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[175]}} & {idx,e0c_shift_sel[175 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[176 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[176]}} & {idx,e0c_shift_sel[176 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[177 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[177]}} & {idx,e0c_shift_sel[177 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[178 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[178]}} & {idx,e0c_shift_sel[178 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[179 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[179]}} & {idx,e0c_shift_sel[179 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[180 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[180]}} & {idx,e0c_shift_sel[180 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[181 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[181]}} & {idx,e0c_shift_sel[181 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[182 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[182]}} & {idx,e0c_shift_sel[182 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[183 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[183]}} & {idx,e0c_shift_sel[183 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[184 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[184]}} & {idx,e0c_shift_sel[184 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[185 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[185]}} & {idx,e0c_shift_sel[185 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[186 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[186]}} & {idx,e0c_shift_sel[186 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[187 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[187]}} & {idx,e0c_shift_sel[187 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[188 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[188]}} & {idx,e0c_shift_sel[188 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[189 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[189]}} & {idx,e0c_shift_sel[189 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[190 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[190]}} & {idx,e0c_shift_sel[190 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[191 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[191]}} & {idx,e0c_shift_sel[191 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[192 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[192]}} & {idx,e0c_shift_sel[192 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[193 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[193]}} & {idx,e0c_shift_sel[193 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[194 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[194]}} & {idx,e0c_shift_sel[194 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[195 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[195]}} & {idx,e0c_shift_sel[195 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[196 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[196]}} & {idx,e0c_shift_sel[196 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[197 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[197]}} & {idx,e0c_shift_sel[197 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[198 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[198]}} & {idx,e0c_shift_sel[198 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[199 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[199]}} & {idx,e0c_shift_sel[199 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[200 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[200]}} & {idx,e0c_shift_sel[200 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[201 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[201]}} & {idx,e0c_shift_sel[201 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[202 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[202]}} & {idx,e0c_shift_sel[202 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[203 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[203]}} & {idx,e0c_shift_sel[203 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[204 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[204]}} & {idx,e0c_shift_sel[204 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[205 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[205]}} & {idx,e0c_shift_sel[205 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[206 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[206]}} & {idx,e0c_shift_sel[206 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[207 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[207]}} & {idx,e0c_shift_sel[207 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[208 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[208]}} & {idx,e0c_shift_sel[208 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[209 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[209]}} & {idx,e0c_shift_sel[209 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[210 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[210]}} & {idx,e0c_shift_sel[210 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[211 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[211]}} & {idx,e0c_shift_sel[211 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[212 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[212]}} & {idx,e0c_shift_sel[212 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[213 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[213]}} & {idx,e0c_shift_sel[213 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[214 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[214]}} & {idx,e0c_shift_sel[214 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[215 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[215]}} & {idx,e0c_shift_sel[215 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[216 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[216]}} & {idx,e0c_shift_sel[216 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[217 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[217]}} & {idx,e0c_shift_sel[217 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[218 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[218]}} & {idx,e0c_shift_sel[218 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[219 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[219]}} & {idx,e0c_shift_sel[219 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[220 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[220]}} & {idx,e0c_shift_sel[220 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[221 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[221]}} & {idx,e0c_shift_sel[221 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[222 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[222]}} & {idx,e0c_shift_sel[222 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[223 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[223]}} & {idx,e0c_shift_sel[223 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[224 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[224]}} & {idx,e0c_shift_sel[224 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[225 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[225]}} & {idx,e0c_shift_sel[225 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[226 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[226]}} & {idx,e0c_shift_sel[226 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[227 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[227]}} & {idx,e0c_shift_sel[227 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[228 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[228]}} & {idx,e0c_shift_sel[228 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[229 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[229]}} & {idx,e0c_shift_sel[229 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[230 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[230]}} & {idx,e0c_shift_sel[230 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[231 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[231]}} & {idx,e0c_shift_sel[231 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[232 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[232]}} & {idx,e0c_shift_sel[232 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[233 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[233]}} & {idx,e0c_shift_sel[233 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[234 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[234]}} & {idx,e0c_shift_sel[234 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[235 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[235]}} & {idx,e0c_shift_sel[235 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[236 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[236]}} & {idx,e0c_shift_sel[236 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[237 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[237]}} & {idx,e0c_shift_sel[237 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[238 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[238]}} & {idx,e0c_shift_sel[238 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[239 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[239]}} & {idx,e0c_shift_sel[239 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[240 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[240]}} & {idx,e0c_shift_sel[240 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[241 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[241]}} & {idx,e0c_shift_sel[241 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[242 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[242]}} & {idx,e0c_shift_sel[242 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[243 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[243]}} & {idx,e0c_shift_sel[243 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[244 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[244]}} & {idx,e0c_shift_sel[244 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[245 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[245]}} & {idx,e0c_shift_sel[245 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[246 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[246]}} & {idx,e0c_shift_sel[246 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[247 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[247]}} & {idx,e0c_shift_sel[247 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[248 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[248]}} & {idx,e0c_shift_sel[248 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[249 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[249]}} & {idx,e0c_shift_sel[249 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[250 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[250]}} & {idx,e0c_shift_sel[250 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[251 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[251]}} & {idx,e0c_shift_sel[251 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[252 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[252]}} & {idx,e0c_shift_sel[252 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[253 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[253]}} & {idx,e0c_shift_sel[253 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[254 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[254]}} & {idx,e0c_shift_sel[254 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
        assign shift_sel[255 * LANE_LOG2 +:LANE_LOG2] = {LANE_LOG2{shift_mask[255]}} & {idx,e0c_shift_sel[255 * SLICE_LEN_LOG2 +:SLICE_LEN_LOG2]};
    end
endgenerate
always @(posedge vpu_vpermut_clk) begin
    if (e0c_en) begin
        {e0c_mask,e0c_sel} <= {mask,sel};
    end
end

assign shift_mask = {{2 * LANE - SLICE_LEN{1'b0}},e0c_mask} << shift;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

