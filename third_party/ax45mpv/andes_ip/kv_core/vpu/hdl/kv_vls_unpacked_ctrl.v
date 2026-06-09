// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_unpacked_ctrl (
    vpu_vlsu_clk,
    vpu_reset_n,
    unpacked_req_en,
    unpacked_resp_finish,
    unpacked_vd_beats,
    unpacked_ctrl,
    unpacked_nf_cnt,
    unpacked_element_num_dlen,
    unpacked_start_buf_num,
    unpacked_start_buf_ptr,
    segbuf_unpacked_data_rvalid,
    segbuf_unpacked_data_rready,
    segbuf_unpacked_rdata,
    vlsbuf_unpacked_wsel,
    vlsbuf_unpacked_data_all,
    vlsbuf_unpacked_bwe
);
parameter VLEN = 512;
parameter DLEN = 512;
parameter DMLEN = 64;
parameter ELEN = 32;
parameter VRF_LW = 3;
parameter BUF_DEPTH = 8;
parameter BUF_DEPTH_LOG2 = 3;
parameter BIU_DATA_WIDTH = 256;
parameter ELE_DLEN_WIDTH = 6;
parameter SEG_DATA_WIDTH = 256;
localparam BUF_DEPTH_SEG = BUF_DEPTH;
localparam SEG_DEPTH = 2 ** VRF_LW;
input vpu_vlsu_clk;
input vpu_reset_n;
input unpacked_req_en;
output unpacked_resp_finish;
input [VRF_LW - 1:0] unpacked_vd_beats;
input [11 - 1:0] unpacked_ctrl;
input [3:0] unpacked_nf_cnt;
input [ELE_DLEN_WIDTH - 1:0] unpacked_element_num_dlen;
input [BUF_DEPTH_LOG2 - 1:0] unpacked_start_buf_num;
input [BUF_DEPTH - 1:0] unpacked_start_buf_ptr;
output segbuf_unpacked_data_rvalid;
input segbuf_unpacked_data_rready;
input [SEG_DATA_WIDTH - 1:0] segbuf_unpacked_rdata;
output [BUF_DEPTH - 1:0] vlsbuf_unpacked_wsel;
output [(BUF_DEPTH * DLEN) - 1:0] vlsbuf_unpacked_data_all;
output [DMLEN - 1:0] vlsbuf_unpacked_bwe;





// fcc72565 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [3:0] unpacked_vd_beats_zext;
wire [BUF_DEPTH - 1:0] unpacked_wptr;
reg [VRF_LW - 1:0] unpacked_vd_beats_d1;
reg [3:0] unpacked_eew_onehot_d1;
wire unpacked_wsel_d1_en;
wire [BUF_DEPTH - 1:0] unpacked_wsel_d0;
reg [BUF_DEPTH - 1:0] unpacked_wsel_d1;
reg [ELE_DLEN_WIDTH - 1:0] unpacked_element_num_dlen_d1;
reg [BUF_DEPTH_LOG2 - 1:0] unpacked_start_buf_num_d1;
wire unpacked_eew8_d1;
wire unpacked_eew16_d1;
wire unpacked_eew32_d1;
wire unpacked_eew64_d1;
wire [DMLEN - 1:0] vlsbuf_unpacked8_bwe_d1;
wire [DMLEN - 1:0] vlsbuf_unpacked16_bwe_d1;
wire [DMLEN - 1:0] vlsbuf_unpacked32_bwe_d1;
wire [DMLEN - 1:0] vlsbuf_unpacked64_bwe_d1;
wire [DMLEN - 1:0] unpacked_ele_mask_d1;
wire [7:0] nf1_eew8_data;
wire [7:0] nf2_eew8_data;
wire [7:0] nf3_eew8_data;
wire [7:0] nf4_eew8_data;
wire [7:0] nf5_eew8_data;
wire [7:0] nf6_eew8_data;
wire [7:0] nf7_eew8_data;
wire [7:0] nf8_eew8_data;
wire [15:0] nf1_eew16_data;
wire [15:0] nf2_eew16_data;
wire [15:0] nf3_eew16_data;
wire [15:0] nf4_eew16_data;
wire [15:0] nf5_eew16_data;
wire [15:0] nf6_eew16_data;
wire [15:0] nf7_eew16_data;
wire [15:0] nf8_eew16_data;
wire [31:0] nf1_eew32_data;
wire [31:0] nf2_eew32_data;
wire [31:0] nf3_eew32_data;
wire [31:0] nf4_eew32_data;
wire [31:0] nf5_eew32_data;
wire [31:0] nf6_eew32_data;
wire [31:0] nf7_eew32_data;
wire [31:0] nf8_eew32_data;
wire [63:0] nf1_eew64_data;
wire [63:0] nf2_eew64_data;
wire [63:0] nf3_eew64_data;
wire [63:0] nf4_eew64_data;
wire [63:0] nf5_eew64_data;
wire [63:0] nf6_eew64_data;
wire [63:0] nf7_eew64_data;
wire [63:0] nf8_eew64_data;
wire [63:0] nf1_eew8_data6300;
wire [63:0] nf2_eew8_data6300;
wire [63:0] nf3_eew8_data6300;
wire [63:0] nf4_eew8_data6300;
wire [63:0] nf5_eew8_data6300;
wire [63:0] nf6_eew8_data6300;
wire [63:0] nf7_eew8_data6300;
wire [63:0] nf8_eew8_data6300;
wire [63:0] nf1_eew16_data6300;
wire [63:0] nf2_eew16_data6300;
wire [63:0] nf3_eew16_data6300;
wire [63:0] nf4_eew16_data6300;
wire [63:0] nf5_eew16_data6300;
wire [63:0] nf6_eew16_data6300;
wire [63:0] nf7_eew16_data6300;
wire [63:0] nf8_eew16_data6300;
wire [63:0] nf1_eew32_data6300;
wire [63:0] nf2_eew32_data6300;
wire [63:0] nf3_eew32_data6300;
wire [63:0] nf4_eew32_data6300;
wire [63:0] nf5_eew32_data6300;
wire [63:0] nf6_eew32_data6300;
wire [63:0] nf7_eew32_data6300;
wire [63:0] nf8_eew32_data6300;
wire [63:0] nf1_eew64_data6300;
wire [63:0] nf2_eew64_data6300;
wire [63:0] nf3_eew64_data6300;
wire [63:0] nf4_eew64_data6300;
wire [63:0] nf5_eew64_data6300;
wire [63:0] nf6_eew64_data6300;
wire [63:0] nf7_eew64_data6300;
wire [63:0] nf8_eew64_data6300;
wire [63:0] nf1_data_sel;
wire [63:0] nf2_data_sel;
wire [63:0] nf3_data_sel;
wire [63:0] nf4_data_sel;
wire [63:0] nf5_data_sel;
wire [63:0] nf6_data_sel;
wire [63:0] nf7_data_sel;
wire [63:0] nf8_data_sel;
wire [DLEN - 1:0] nf1_data_dlen;
wire [DLEN - 1:0] nf2_data_dlen;
wire [DLEN - 1:0] nf3_data_dlen;
wire [DLEN - 1:0] nf4_data_dlen;
wire [DLEN - 1:0] nf5_data_dlen;
wire [DLEN - 1:0] nf6_data_dlen;
wire [DLEN - 1:0] nf7_data_dlen;
wire [DLEN - 1:0] nf8_data_dlen;
reg [DLEN - 1:0] data_dlen0;
reg [DLEN - 1:0] data_dlen1;
reg [DLEN - 1:0] data_dlen2;
reg [DLEN - 1:0] data_dlen3;
reg [DLEN - 1:0] data_dlen4;
reg [DLEN - 1:0] data_dlen5;
reg [DLEN - 1:0] data_dlen6;
reg [DLEN - 1:0] data_dlen7;
reg [DLEN - 1:0] data_dlen8;
reg [DLEN - 1:0] data_dlen9;
reg [DLEN - 1:0] data_dlen10;
reg [DLEN - 1:0] data_dlen11;
reg [DLEN - 1:0] data_dlen12;
reg [DLEN - 1:0] data_dlen13;
reg [DLEN - 1:0] data_dlen14;
reg [DLEN - 1:0] data_dlen15;
wire [(SEG_DEPTH * DLEN) - 1:0] data_dlen_all;
wire [(BUF_DEPTH_SEG * DLEN) - 1:0] data_dlen_all_zext;
reg [(BUF_DEPTH_SEG * DLEN) - 1:0] data_dlen_sel;
wire [BUF_DEPTH - 1:0] nds_unused_vlsbuf_wptr0;
wire [BUF_DEPTH - 1:0] nds_unused_vlsbuf_wptr1;
wire [BUF_DEPTH - 1:0] nds_unused_vlsbuf_wptr2;
wire [BUF_DEPTH - 1:0] nds_unused_vlsbuf_wptr3;
wire [BUF_DEPTH - 1:0] nds_unused_vlsbuf_wptr4;
wire [BUF_DEPTH - 1:0] nds_unused_vlsbuf_wptr5;
wire [BUF_DEPTH - 1:0] nds_unused_vlsbuf_wptr6;
wire [BUF_DEPTH - 1:0] nds_unused_vlsbuf_wptr7;
kv_vls_seg_xptr #(
    .VLEN(VLEN),
    .DLEN(DLEN),
    .BUF_DEPTH(BUF_DEPTH)
) u_vlsbuf_seg_wptr (
    .nf_add1(unpacked_nf_cnt),
    .emul_len(unpacked_vd_beats_zext),
    .start_ptr(unpacked_start_buf_ptr),
    .seg_ptr(unpacked_wptr),
    .xptr0(nds_unused_vlsbuf_wptr0),
    .xptr1(nds_unused_vlsbuf_wptr1),
    .xptr2(nds_unused_vlsbuf_wptr2),
    .xptr3(nds_unused_vlsbuf_wptr3),
    .xptr4(nds_unused_vlsbuf_wptr4),
    .xptr5(nds_unused_vlsbuf_wptr5),
    .xptr6(nds_unused_vlsbuf_wptr6),
    .xptr7(nds_unused_vlsbuf_wptr7)
);
kv_zero_ext #(
    .OW(4),
    .IW(VRF_LW)
) u_unpacked_vd_beats_zext (
    .out(unpacked_vd_beats_zext),
    .in(unpacked_vd_beats)
);
assign unpacked_wsel_d0 = {BUF_DEPTH{unpacked_req_en}} & unpacked_wptr;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        unpacked_vd_beats_d1 <= {VRF_LW{1'b0}};
        unpacked_eew_onehot_d1 <= 4'b0;
        unpacked_element_num_dlen_d1 <= {ELE_DLEN_WIDTH{1'b0}};
        unpacked_start_buf_num_d1 <= {BUF_DEPTH_LOG2{1'b0}};
    end
    else if (unpacked_req_en) begin
        unpacked_vd_beats_d1 <= unpacked_vd_beats;
        unpacked_eew_onehot_d1 <= unpacked_ctrl[7 +:4];
        unpacked_element_num_dlen_d1 <= unpacked_element_num_dlen;
        unpacked_start_buf_num_d1 <= unpacked_start_buf_num;
    end
end

assign unpacked_wsel_d1_en = 1'b1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        unpacked_wsel_d1 <= {BUF_DEPTH{1'b0}};
    end
    else if (unpacked_wsel_d1_en) begin
        unpacked_wsel_d1 <= unpacked_wsel_d0;
    end
end

assign segbuf_unpacked_data_rvalid = 1'b1;
assign unpacked_resp_finish = 1'b1;
assign vlsbuf_unpacked_wsel = unpacked_wsel_d1;
assign unpacked_eew8_d1 = unpacked_eew_onehot_d1[0];
assign unpacked_eew16_d1 = unpacked_eew_onehot_d1[1];
assign unpacked_eew32_d1 = unpacked_eew_onehot_d1[2];
assign unpacked_eew64_d1 = unpacked_eew_onehot_d1[3];
assign unpacked_ele_mask_d1 = 1'b1 << unpacked_element_num_dlen_d1;
assign vlsbuf_unpacked8_bwe_d1 = unpacked_ele_mask_d1;
genvar m;
genvar n;
genvar o;
generate
    for (m = 0; m < DMLEN / 2; m = m + 1) begin:gen_element16_seg_byte_mask
        assign vlsbuf_unpacked16_bwe_d1[m * 2 +:2] = {2{unpacked_ele_mask_d1[m]}};
    end
endgenerate
generate
    for (n = 0; n < DMLEN / 4; n = n + 1) begin:gen_element32_seg_byte_mask
        assign vlsbuf_unpacked32_bwe_d1[n * 4 +:4] = {4{unpacked_ele_mask_d1[n]}};
    end
endgenerate
generate
    for (o = 0; o < DMLEN / 8; o = o + 1) begin:gen_element64_seg_byte_mask
        assign vlsbuf_unpacked64_bwe_d1[o * 8 +:8] = {8{unpacked_ele_mask_d1[o]}};
    end
endgenerate
assign vlsbuf_unpacked_bwe = ({DMLEN{unpacked_eew8_d1}} & vlsbuf_unpacked8_bwe_d1) | ({DMLEN{unpacked_eew16_d1}} & vlsbuf_unpacked16_bwe_d1) | ({DMLEN{unpacked_eew32_d1}} & vlsbuf_unpacked32_bwe_d1) | ({DMLEN{unpacked_eew64_d1}} & vlsbuf_unpacked64_bwe_d1);
kv_zero_ext #(
    .OW(BUF_DEPTH * DLEN),
    .IW(BUF_DEPTH_SEG * DLEN)
) u_vlsbuf_unpacked_data_all (
    .out(vlsbuf_unpacked_data_all),
    .in(data_dlen_sel)
);
kv_zero_ext #(
    .OW(BUF_DEPTH_SEG * DLEN),
    .IW(SEG_DEPTH * DLEN)
) u_data_dlen_all_zext (
    .out(data_dlen_all_zext),
    .in(data_dlen_all)
);
assign nf1_eew8_data = segbuf_unpacked_rdata[(8 * 0) +:8];
assign nf1_eew16_data = segbuf_unpacked_rdata[(16 * 0) +:16];
assign nf1_eew32_data = segbuf_unpacked_rdata[(32 * 0) +:32];
assign nf2_eew8_data = segbuf_unpacked_rdata[(8 * 1) +:8];
assign nf2_eew16_data = segbuf_unpacked_rdata[(16 * 1) +:16];
assign nf2_eew32_data = segbuf_unpacked_rdata[(32 * 1) +:32];
assign nf3_eew8_data = segbuf_unpacked_rdata[(8 * 2) +:8];
assign nf3_eew16_data = segbuf_unpacked_rdata[(16 * 2) +:16];
assign nf3_eew32_data = segbuf_unpacked_rdata[(32 * 2) +:32];
assign nf4_eew8_data = segbuf_unpacked_rdata[(8 * 3) +:8];
assign nf4_eew16_data = segbuf_unpacked_rdata[(16 * 3) +:16];
assign nf4_eew32_data = segbuf_unpacked_rdata[(32 * 3) +:32];
assign nf5_eew8_data = segbuf_unpacked_rdata[(8 * 4) +:8];
assign nf5_eew16_data = segbuf_unpacked_rdata[(16 * 4) +:16];
assign nf5_eew32_data = segbuf_unpacked_rdata[(32 * 4) +:32];
assign nf6_eew8_data = segbuf_unpacked_rdata[(8 * 5) +:8];
assign nf6_eew16_data = segbuf_unpacked_rdata[(16 * 5) +:16];
assign nf6_eew32_data = segbuf_unpacked_rdata[(32 * 5) +:32];
assign nf7_eew8_data = segbuf_unpacked_rdata[(8 * 6) +:8];
assign nf7_eew16_data = segbuf_unpacked_rdata[(16 * 6) +:16];
assign nf7_eew32_data = segbuf_unpacked_rdata[(32 * 6) +:32];
assign nf8_eew8_data = segbuf_unpacked_rdata[(8 * 7) +:8];
assign nf8_eew16_data = segbuf_unpacked_rdata[(16 * 7) +:16];
assign nf8_eew32_data = segbuf_unpacked_rdata[(32 * 7) +:32];
generate
    if (ELEN == 64) begin:gen_nfx_eew64_unpacked_data
        assign nf1_eew64_data = segbuf_unpacked_rdata[(64 * 0) +:64];
        assign nf2_eew64_data = segbuf_unpacked_rdata[(64 * 1) +:64];
        assign nf3_eew64_data = segbuf_unpacked_rdata[(64 * 2) +:64];
        assign nf4_eew64_data = segbuf_unpacked_rdata[(64 * 3) +:64];
        assign nf5_eew64_data = segbuf_unpacked_rdata[(64 * 4) +:64];
        assign nf6_eew64_data = segbuf_unpacked_rdata[(64 * 5) +:64];
        assign nf7_eew64_data = segbuf_unpacked_rdata[(64 * 6) +:64];
        assign nf8_eew64_data = segbuf_unpacked_rdata[(64 * 7) +:64];
    end
    else begin:gen_nfx_eew64_unpacked_data_stub
        assign nf1_eew64_data = 64'b0;
        assign nf2_eew64_data = 64'b0;
        assign nf3_eew64_data = 64'b0;
        assign nf4_eew64_data = 64'b0;
        assign nf5_eew64_data = 64'b0;
        assign nf6_eew64_data = 64'b0;
        assign nf7_eew64_data = 64'b0;
        assign nf8_eew64_data = 64'b0;
    end
endgenerate
assign nf1_eew8_data6300 = {8{nf1_eew8_data}};
assign nf1_eew16_data6300 = {4{nf1_eew16_data}};
assign nf1_eew32_data6300 = {2{nf1_eew32_data}};
assign nf1_eew64_data6300 = {1{nf1_eew64_data}};
assign nf2_eew8_data6300 = {8{nf2_eew8_data}};
assign nf2_eew16_data6300 = {4{nf2_eew16_data}};
assign nf2_eew32_data6300 = {2{nf2_eew32_data}};
assign nf2_eew64_data6300 = {1{nf2_eew64_data}};
assign nf3_eew8_data6300 = {8{nf3_eew8_data}};
assign nf3_eew16_data6300 = {4{nf3_eew16_data}};
assign nf3_eew32_data6300 = {2{nf3_eew32_data}};
assign nf3_eew64_data6300 = {1{nf3_eew64_data}};
assign nf4_eew8_data6300 = {8{nf4_eew8_data}};
assign nf4_eew16_data6300 = {4{nf4_eew16_data}};
assign nf4_eew32_data6300 = {2{nf4_eew32_data}};
assign nf4_eew64_data6300 = {1{nf4_eew64_data}};
assign nf5_eew8_data6300 = {8{nf5_eew8_data}};
assign nf5_eew16_data6300 = {4{nf5_eew16_data}};
assign nf5_eew32_data6300 = {2{nf5_eew32_data}};
assign nf5_eew64_data6300 = {1{nf5_eew64_data}};
assign nf6_eew8_data6300 = {8{nf6_eew8_data}};
assign nf6_eew16_data6300 = {4{nf6_eew16_data}};
assign nf6_eew32_data6300 = {2{nf6_eew32_data}};
assign nf6_eew64_data6300 = {1{nf6_eew64_data}};
assign nf7_eew8_data6300 = {8{nf7_eew8_data}};
assign nf7_eew16_data6300 = {4{nf7_eew16_data}};
assign nf7_eew32_data6300 = {2{nf7_eew32_data}};
assign nf7_eew64_data6300 = {1{nf7_eew64_data}};
assign nf8_eew8_data6300 = {8{nf8_eew8_data}};
assign nf8_eew16_data6300 = {4{nf8_eew16_data}};
assign nf8_eew32_data6300 = {2{nf8_eew32_data}};
assign nf8_eew64_data6300 = {1{nf8_eew64_data}};
assign nf1_data_sel = ({64{unpacked_eew8_d1}} & nf1_eew8_data6300) | ({64{unpacked_eew16_d1}} & nf1_eew16_data6300) | ({64{unpacked_eew32_d1}} & nf1_eew32_data6300) | ({64{unpacked_eew64_d1}} & nf1_eew64_data6300);
assign nf2_data_sel = ({64{unpacked_eew8_d1}} & nf2_eew8_data6300) | ({64{unpacked_eew16_d1}} & nf2_eew16_data6300) | ({64{unpacked_eew32_d1}} & nf2_eew32_data6300) | ({64{unpacked_eew64_d1}} & nf2_eew64_data6300);
assign nf3_data_sel = ({64{unpacked_eew8_d1}} & nf3_eew8_data6300) | ({64{unpacked_eew16_d1}} & nf3_eew16_data6300) | ({64{unpacked_eew32_d1}} & nf3_eew32_data6300) | ({64{unpacked_eew64_d1}} & nf3_eew64_data6300);
assign nf4_data_sel = ({64{unpacked_eew8_d1}} & nf4_eew8_data6300) | ({64{unpacked_eew16_d1}} & nf4_eew16_data6300) | ({64{unpacked_eew32_d1}} & nf4_eew32_data6300) | ({64{unpacked_eew64_d1}} & nf4_eew64_data6300);
assign nf5_data_sel = ({64{unpacked_eew8_d1}} & nf5_eew8_data6300) | ({64{unpacked_eew16_d1}} & nf5_eew16_data6300) | ({64{unpacked_eew32_d1}} & nf5_eew32_data6300) | ({64{unpacked_eew64_d1}} & nf5_eew64_data6300);
assign nf6_data_sel = ({64{unpacked_eew8_d1}} & nf6_eew8_data6300) | ({64{unpacked_eew16_d1}} & nf6_eew16_data6300) | ({64{unpacked_eew32_d1}} & nf6_eew32_data6300) | ({64{unpacked_eew64_d1}} & nf6_eew64_data6300);
assign nf7_data_sel = ({64{unpacked_eew8_d1}} & nf7_eew8_data6300) | ({64{unpacked_eew16_d1}} & nf7_eew16_data6300) | ({64{unpacked_eew32_d1}} & nf7_eew32_data6300) | ({64{unpacked_eew64_d1}} & nf7_eew64_data6300);
assign nf8_data_sel = ({64{unpacked_eew8_d1}} & nf8_eew8_data6300) | ({64{unpacked_eew16_d1}} & nf8_eew16_data6300) | ({64{unpacked_eew32_d1}} & nf8_eew32_data6300) | ({64{unpacked_eew64_d1}} & nf8_eew64_data6300);
assign nf1_data_dlen = {DLEN / 64{nf1_data_sel}};
assign nf2_data_dlen = {DLEN / 64{nf2_data_sel}};
assign nf3_data_dlen = {DLEN / 64{nf3_data_sel}};
assign nf4_data_dlen = {DLEN / 64{nf4_data_sel}};
assign nf5_data_dlen = {DLEN / 64{nf5_data_sel}};
assign nf6_data_dlen = {DLEN / 64{nf6_data_sel}};
assign nf7_data_dlen = {DLEN / 64{nf7_data_sel}};
assign nf8_data_dlen = {DLEN / 64{nf8_data_sel}};
generate
    if (VRF_LW == 3) begin:gen_vlen_dlen_1_1_segdata_dlen
        wire nds_unused_data_dlenx = (|data_dlen8) | (|data_dlen9) | (|data_dlen10) | (|data_dlen11) | (|data_dlen12) | (|data_dlen13) | (|data_dlen14) | (|data_dlen15);
        assign data_dlen_all = {data_dlen7,data_dlen6,data_dlen5,data_dlen4,data_dlen3,data_dlen2,data_dlen1,data_dlen0};
        always @* begin
            data_dlen8 = {DLEN{1'b0}};
            data_dlen9 = {DLEN{1'b0}};
            data_dlen10 = {DLEN{1'b0}};
            data_dlen11 = {DLEN{1'b0}};
            data_dlen12 = {DLEN{1'b0}};
            data_dlen13 = {DLEN{1'b0}};
            data_dlen14 = {DLEN{1'b0}};
            data_dlen15 = {DLEN{1'b0}};
            case (unpacked_vd_beats_d1)
                3'b000: begin
                    data_dlen0 = nf1_data_dlen;
                    data_dlen1 = nf2_data_dlen;
                    data_dlen2 = nf3_data_dlen;
                    data_dlen3 = nf4_data_dlen;
                    data_dlen4 = nf5_data_dlen;
                    data_dlen5 = nf6_data_dlen;
                    data_dlen6 = nf7_data_dlen;
                    data_dlen7 = nf8_data_dlen;
                end
                3'b001: begin
                    data_dlen0 = nf1_data_dlen;
                    data_dlen1 = {DLEN{1'b0}};
                    data_dlen2 = nf2_data_dlen;
                    data_dlen3 = {DLEN{1'b0}};
                    data_dlen4 = nf3_data_dlen;
                    data_dlen5 = {DLEN{1'b0}};
                    data_dlen6 = nf4_data_dlen;
                    data_dlen7 = {DLEN{1'b0}};
                end
                3'b010: begin
                    data_dlen0 = nf1_data_dlen;
                    data_dlen1 = {DLEN{1'b0}};
                    data_dlen2 = {DLEN{1'b0}};
                    data_dlen3 = nf2_data_dlen;
                    data_dlen4 = {DLEN{1'b0}};
                    data_dlen5 = {DLEN{1'b0}};
                    data_dlen6 = nf3_data_dlen;
                    data_dlen7 = {DLEN{1'b0}};
                end
                3'b011: begin
                    data_dlen0 = nf1_data_dlen;
                    data_dlen1 = {DLEN{1'b0}};
                    data_dlen2 = {DLEN{1'b0}};
                    data_dlen3 = {DLEN{1'b0}};
                    data_dlen4 = nf2_data_dlen;
                    data_dlen5 = {DLEN{1'b0}};
                    data_dlen6 = {DLEN{1'b0}};
                    data_dlen7 = {DLEN{1'b0}};
                end
                default: begin
                    data_dlen0 = {DLEN{1'b0}};
                    data_dlen1 = {DLEN{1'b0}};
                    data_dlen2 = {DLEN{1'b0}};
                    data_dlen3 = {DLEN{1'b0}};
                    data_dlen4 = {DLEN{1'b0}};
                    data_dlen5 = {DLEN{1'b0}};
                    data_dlen6 = {DLEN{1'b0}};
                    data_dlen7 = {DLEN{1'b0}};
                end
            endcase
        end

    end
    else begin:gen_vlen_dlen_2_1_segdata_dlen
        assign data_dlen_all = {data_dlen15,data_dlen14,data_dlen13,data_dlen12,data_dlen11,data_dlen10,data_dlen9,data_dlen8,data_dlen7,data_dlen6,data_dlen5,data_dlen4,data_dlen3,data_dlen2,data_dlen1,data_dlen0};
        always @* begin
            case (unpacked_vd_beats_d1)
                4'd0: begin
                    data_dlen0 = nf1_data_dlen;
                    data_dlen1 = nf2_data_dlen;
                    data_dlen2 = nf3_data_dlen;
                    data_dlen3 = nf4_data_dlen;
                    data_dlen4 = nf5_data_dlen;
                    data_dlen5 = nf6_data_dlen;
                    data_dlen6 = nf7_data_dlen;
                    data_dlen7 = nf8_data_dlen;
                    data_dlen8 = {DLEN{1'b0}};
                    data_dlen9 = {DLEN{1'b0}};
                    data_dlen10 = {DLEN{1'b0}};
                    data_dlen11 = {DLEN{1'b0}};
                    data_dlen12 = {DLEN{1'b0}};
                    data_dlen13 = {DLEN{1'b0}};
                    data_dlen14 = {DLEN{1'b0}};
                    data_dlen15 = {DLEN{1'b0}};
                end
                4'd1: begin
                    data_dlen0 = nf1_data_dlen;
                    data_dlen2 = nf2_data_dlen;
                    data_dlen4 = nf3_data_dlen;
                    data_dlen6 = nf4_data_dlen;
                    data_dlen8 = nf5_data_dlen;
                    data_dlen10 = nf6_data_dlen;
                    data_dlen12 = nf7_data_dlen;
                    data_dlen14 = nf8_data_dlen;
                    data_dlen1 = {DLEN{1'b0}};
                    data_dlen3 = {DLEN{1'b0}};
                    data_dlen5 = {DLEN{1'b0}};
                    data_dlen7 = {DLEN{1'b0}};
                    data_dlen9 = {DLEN{1'b0}};
                    data_dlen11 = {DLEN{1'b0}};
                    data_dlen13 = {DLEN{1'b0}};
                    data_dlen15 = {DLEN{1'b0}};
                end
                4'd2: begin
                    data_dlen0 = nf1_data_dlen;
                    data_dlen3 = nf2_data_dlen;
                    data_dlen6 = nf3_data_dlen;
                    data_dlen9 = nf4_data_dlen;
                    data_dlen12 = nf5_data_dlen;
                    data_dlen15 = nf6_data_dlen;
                    data_dlen1 = {DLEN{1'b0}};
                    data_dlen2 = {DLEN{1'b0}};
                    data_dlen4 = {DLEN{1'b0}};
                    data_dlen5 = {DLEN{1'b0}};
                    data_dlen7 = {DLEN{1'b0}};
                    data_dlen8 = {DLEN{1'b0}};
                    data_dlen10 = {DLEN{1'b0}};
                    data_dlen11 = {DLEN{1'b0}};
                    data_dlen13 = {DLEN{1'b0}};
                    data_dlen14 = {DLEN{1'b0}};
                end
                4'd3: begin
                    data_dlen0 = nf1_data_dlen;
                    data_dlen4 = nf2_data_dlen;
                    data_dlen8 = nf3_data_dlen;
                    data_dlen12 = nf4_data_dlen;
                    data_dlen1 = {DLEN{1'b0}};
                    data_dlen2 = {DLEN{1'b0}};
                    data_dlen3 = {DLEN{1'b0}};
                    data_dlen5 = {DLEN{1'b0}};
                    data_dlen6 = {DLEN{1'b0}};
                    data_dlen7 = {DLEN{1'b0}};
                    data_dlen9 = {DLEN{1'b0}};
                    data_dlen10 = {DLEN{1'b0}};
                    data_dlen11 = {DLEN{1'b0}};
                    data_dlen13 = {DLEN{1'b0}};
                    data_dlen14 = {DLEN{1'b0}};
                    data_dlen15 = {DLEN{1'b0}};
                end
                4'd4: begin
                    data_dlen0 = nf1_data_dlen;
                    data_dlen5 = nf2_data_dlen;
                    data_dlen15 = nf3_data_dlen;
                    data_dlen1 = {DLEN{1'b0}};
                    data_dlen2 = {DLEN{1'b0}};
                    data_dlen3 = {DLEN{1'b0}};
                    data_dlen4 = {DLEN{1'b0}};
                    data_dlen6 = {DLEN{1'b0}};
                    data_dlen7 = {DLEN{1'b0}};
                    data_dlen8 = {DLEN{1'b0}};
                    data_dlen9 = {DLEN{1'b0}};
                    data_dlen10 = {DLEN{1'b0}};
                    data_dlen11 = {DLEN{1'b0}};
                    data_dlen12 = {DLEN{1'b0}};
                    data_dlen13 = {DLEN{1'b0}};
                    data_dlen14 = {DLEN{1'b0}};
                end
                4'd5: begin
                    data_dlen0 = nf1_data_dlen;
                    data_dlen6 = nf2_data_dlen;
                    data_dlen12 = nf3_data_dlen;
                    data_dlen1 = {DLEN{1'b0}};
                    data_dlen2 = {DLEN{1'b0}};
                    data_dlen3 = {DLEN{1'b0}};
                    data_dlen4 = {DLEN{1'b0}};
                    data_dlen5 = {DLEN{1'b0}};
                    data_dlen7 = {DLEN{1'b0}};
                    data_dlen8 = {DLEN{1'b0}};
                    data_dlen9 = {DLEN{1'b0}};
                    data_dlen10 = {DLEN{1'b0}};
                    data_dlen11 = {DLEN{1'b0}};
                    data_dlen13 = {DLEN{1'b0}};
                    data_dlen14 = {DLEN{1'b0}};
                    data_dlen15 = {DLEN{1'b0}};
                end
                4'd6: begin
                    data_dlen0 = nf1_data_dlen;
                    data_dlen7 = nf2_data_dlen;
                    data_dlen14 = nf3_data_dlen;
                    data_dlen1 = {DLEN{1'b0}};
                    data_dlen2 = {DLEN{1'b0}};
                    data_dlen3 = {DLEN{1'b0}};
                    data_dlen4 = {DLEN{1'b0}};
                    data_dlen5 = {DLEN{1'b0}};
                    data_dlen6 = {DLEN{1'b0}};
                    data_dlen8 = {DLEN{1'b0}};
                    data_dlen9 = {DLEN{1'b0}};
                    data_dlen10 = {DLEN{1'b0}};
                    data_dlen11 = {DLEN{1'b0}};
                    data_dlen12 = {DLEN{1'b0}};
                    data_dlen13 = {DLEN{1'b0}};
                    data_dlen15 = {DLEN{1'b0}};
                end
                4'd7: begin
                    data_dlen0 = nf1_data_dlen;
                    data_dlen8 = nf2_data_dlen;
                    data_dlen1 = {DLEN{1'b0}};
                    data_dlen2 = {DLEN{1'b0}};
                    data_dlen3 = {DLEN{1'b0}};
                    data_dlen4 = {DLEN{1'b0}};
                    data_dlen5 = {DLEN{1'b0}};
                    data_dlen6 = {DLEN{1'b0}};
                    data_dlen7 = {DLEN{1'b0}};
                    data_dlen9 = {DLEN{1'b0}};
                    data_dlen10 = {DLEN{1'b0}};
                    data_dlen11 = {DLEN{1'b0}};
                    data_dlen12 = {DLEN{1'b0}};
                    data_dlen13 = {DLEN{1'b0}};
                    data_dlen14 = {DLEN{1'b0}};
                    data_dlen15 = {DLEN{1'b0}};
                end
                default: begin
                    data_dlen0 = {DLEN{1'b0}};
                    data_dlen1 = {DLEN{1'b0}};
                    data_dlen2 = {DLEN{1'b0}};
                    data_dlen3 = {DLEN{1'b0}};
                    data_dlen4 = {DLEN{1'b0}};
                    data_dlen5 = {DLEN{1'b0}};
                    data_dlen6 = {DLEN{1'b0}};
                    data_dlen7 = {DLEN{1'b0}};
                    data_dlen8 = {DLEN{1'b0}};
                    data_dlen9 = {DLEN{1'b0}};
                    data_dlen10 = {DLEN{1'b0}};
                    data_dlen11 = {DLEN{1'b0}};
                    data_dlen12 = {DLEN{1'b0}};
                    data_dlen13 = {DLEN{1'b0}};
                    data_dlen14 = {DLEN{1'b0}};
                    data_dlen15 = {DLEN{1'b0}};
                end
            endcase
        end

    end
endgenerate
generate
    if (BUF_DEPTH == 8) begin:gen_buf8_eseg_data_sel
        always @* begin
            case (unpacked_start_buf_num_d1)
                3'd0: data_dlen_sel = data_dlen_all_zext;
                3'd1: data_dlen_sel = {data_dlen_all_zext[DLEN * 7 - 1:0],data_dlen_all_zext[DLEN * 8 - 1:DLEN * 7]};
                3'd2: data_dlen_sel = {data_dlen_all_zext[DLEN * 6 - 1:0],data_dlen_all_zext[DLEN * 8 - 1:DLEN * 6]};
                3'd3: data_dlen_sel = {data_dlen_all_zext[DLEN * 5 - 1:0],data_dlen_all_zext[DLEN * 8 - 1:DLEN * 5]};
                3'd4: data_dlen_sel = {data_dlen_all_zext[DLEN * 4 - 1:0],data_dlen_all_zext[DLEN * 8 - 1:DLEN * 4]};
                3'd5: data_dlen_sel = {data_dlen_all_zext[DLEN * 3 - 1:0],data_dlen_all_zext[DLEN * 8 - 1:DLEN * 3]};
                3'd6: data_dlen_sel = {data_dlen_all_zext[DLEN * 2 - 1:0],data_dlen_all_zext[DLEN * 8 - 1:DLEN * 2]};
                3'd7: data_dlen_sel = {data_dlen_all_zext[DLEN * 1 - 1:0],data_dlen_all_zext[DLEN * 8 - 1:DLEN * 1]};
                default: begin
                    data_dlen_sel = {DLEN * BUF_DEPTH_SEG{1'b0}};
                end
            endcase
        end

    end
    else if (BUF_DEPTH == 16) begin:gen_buf16_eseg_data_sel
        always @* begin
            case (unpacked_start_buf_num_d1)
                4'd0: data_dlen_sel = data_dlen_all_zext;
                4'd1: data_dlen_sel = {data_dlen_all_zext[DLEN * 15 - 1:0],data_dlen_all_zext[DLEN * 16 - 1:DLEN * 15]};
                4'd2: data_dlen_sel = {data_dlen_all_zext[DLEN * 14 - 1:0],data_dlen_all_zext[DLEN * 16 - 1:DLEN * 14]};
                4'd3: data_dlen_sel = {data_dlen_all_zext[DLEN * 13 - 1:0],data_dlen_all_zext[DLEN * 16 - 1:DLEN * 13]};
                4'd4: data_dlen_sel = {data_dlen_all_zext[DLEN * 12 - 1:0],data_dlen_all_zext[DLEN * 16 - 1:DLEN * 12]};
                4'd5: data_dlen_sel = {data_dlen_all_zext[DLEN * 11 - 1:0],data_dlen_all_zext[DLEN * 16 - 1:DLEN * 11]};
                4'd6: data_dlen_sel = {data_dlen_all_zext[DLEN * 10 - 1:0],data_dlen_all_zext[DLEN * 16 - 1:DLEN * 10]};
                4'd7: data_dlen_sel = {data_dlen_all_zext[DLEN * 9 - 1:0],data_dlen_all_zext[DLEN * 16 - 1:DLEN * 9]};
                4'd8: data_dlen_sel = {data_dlen_all_zext[DLEN * 8 - 1:0],data_dlen_all_zext[DLEN * 16 - 1:DLEN * 8]};
                4'd9: data_dlen_sel = {data_dlen_all_zext[DLEN * 7 - 1:0],data_dlen_all_zext[DLEN * 16 - 1:DLEN * 7]};
                4'd10: data_dlen_sel = {data_dlen_all_zext[DLEN * 6 - 1:0],data_dlen_all_zext[DLEN * 16 - 1:DLEN * 6]};
                4'd11: data_dlen_sel = {data_dlen_all_zext[DLEN * 5 - 1:0],data_dlen_all_zext[DLEN * 16 - 1:DLEN * 5]};
                4'd12: data_dlen_sel = {data_dlen_all_zext[DLEN * 4 - 1:0],data_dlen_all_zext[DLEN * 16 - 1:DLEN * 4]};
                4'd13: data_dlen_sel = {data_dlen_all_zext[DLEN * 3 - 1:0],data_dlen_all_zext[DLEN * 16 - 1:DLEN * 3]};
                4'd14: data_dlen_sel = {data_dlen_all_zext[DLEN * 2 - 1:0],data_dlen_all_zext[DLEN * 16 - 1:DLEN * 2]};
                4'd15: data_dlen_sel = {data_dlen_all_zext[DLEN * 1 - 1:0],data_dlen_all_zext[DLEN * 16 - 1:DLEN * 1]};
                default: begin
                    data_dlen_sel = {DLEN * BUF_DEPTH_SEG{1'b0}};
                end
            endcase
        end

    end
    else if (BUF_DEPTH == 32) begin:gen_buf32_eseg_data_sel
        always @* begin
            case (unpacked_start_buf_num_d1)
                5'd0: data_dlen_sel = data_dlen_all_zext;
                5'd1: data_dlen_sel = {data_dlen_all_zext[DLEN * 31 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 31]};
                5'd2: data_dlen_sel = {data_dlen_all_zext[DLEN * 30 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 30]};
                5'd3: data_dlen_sel = {data_dlen_all_zext[DLEN * 29 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 29]};
                5'd4: data_dlen_sel = {data_dlen_all_zext[DLEN * 28 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 28]};
                5'd5: data_dlen_sel = {data_dlen_all_zext[DLEN * 27 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 27]};
                5'd6: data_dlen_sel = {data_dlen_all_zext[DLEN * 26 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 26]};
                5'd7: data_dlen_sel = {data_dlen_all_zext[DLEN * 25 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 25]};
                5'd8: data_dlen_sel = {data_dlen_all_zext[DLEN * 24 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 24]};
                5'd9: data_dlen_sel = {data_dlen_all_zext[DLEN * 23 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 23]};
                5'd10: data_dlen_sel = {data_dlen_all_zext[DLEN * 22 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 22]};
                5'd11: data_dlen_sel = {data_dlen_all_zext[DLEN * 21 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 21]};
                5'd12: data_dlen_sel = {data_dlen_all_zext[DLEN * 20 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 20]};
                5'd13: data_dlen_sel = {data_dlen_all_zext[DLEN * 19 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 19]};
                5'd14: data_dlen_sel = {data_dlen_all_zext[DLEN * 18 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 18]};
                5'd15: data_dlen_sel = {data_dlen_all_zext[DLEN * 17 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 17]};
                5'd16: data_dlen_sel = {data_dlen_all_zext[DLEN * 16 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 16]};
                5'd17: data_dlen_sel = {data_dlen_all_zext[DLEN * 15 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 15]};
                5'd18: data_dlen_sel = {data_dlen_all_zext[DLEN * 14 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 14]};
                5'd19: data_dlen_sel = {data_dlen_all_zext[DLEN * 13 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 13]};
                5'd20: data_dlen_sel = {data_dlen_all_zext[DLEN * 12 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 12]};
                5'd21: data_dlen_sel = {data_dlen_all_zext[DLEN * 11 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 11]};
                5'd22: data_dlen_sel = {data_dlen_all_zext[DLEN * 10 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 10]};
                5'd23: data_dlen_sel = {data_dlen_all_zext[DLEN * 9 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 9]};
                5'd24: data_dlen_sel = {data_dlen_all_zext[DLEN * 8 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 8]};
                5'd25: data_dlen_sel = {data_dlen_all_zext[DLEN * 7 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 7]};
                5'd26: data_dlen_sel = {data_dlen_all_zext[DLEN * 6 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 6]};
                5'd27: data_dlen_sel = {data_dlen_all_zext[DLEN * 5 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 5]};
                5'd28: data_dlen_sel = {data_dlen_all_zext[DLEN * 4 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 4]};
                5'd29: data_dlen_sel = {data_dlen_all_zext[DLEN * 3 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 3]};
                5'd30: data_dlen_sel = {data_dlen_all_zext[DLEN * 2 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 2]};
                5'd31: data_dlen_sel = {data_dlen_all_zext[DLEN * 1 - 1:0],data_dlen_all_zext[DLEN * 32 - 1:DLEN * 1]};
                default: begin
                    data_dlen_sel = {DLEN * BUF_DEPTH_SEG{1'b0}};
                end
            endcase
        end

    end
    else if (BUF_DEPTH == 64) begin:gen_buf64_eseg_data_sel
        always @* begin
            case (unpacked_start_buf_num_d1)
                6'd0: data_dlen_sel = data_dlen_all_zext;
                6'd1: data_dlen_sel = {data_dlen_all_zext[DLEN * 63 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 63]};
                6'd2: data_dlen_sel = {data_dlen_all_zext[DLEN * 62 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 62]};
                6'd3: data_dlen_sel = {data_dlen_all_zext[DLEN * 61 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 61]};
                6'd4: data_dlen_sel = {data_dlen_all_zext[DLEN * 60 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 60]};
                6'd5: data_dlen_sel = {data_dlen_all_zext[DLEN * 59 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 59]};
                6'd6: data_dlen_sel = {data_dlen_all_zext[DLEN * 58 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 58]};
                6'd7: data_dlen_sel = {data_dlen_all_zext[DLEN * 57 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 57]};
                6'd8: data_dlen_sel = {data_dlen_all_zext[DLEN * 56 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 56]};
                6'd9: data_dlen_sel = {data_dlen_all_zext[DLEN * 55 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 55]};
                6'd10: data_dlen_sel = {data_dlen_all_zext[DLEN * 54 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 54]};
                6'd11: data_dlen_sel = {data_dlen_all_zext[DLEN * 53 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 53]};
                6'd12: data_dlen_sel = {data_dlen_all_zext[DLEN * 52 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 52]};
                6'd13: data_dlen_sel = {data_dlen_all_zext[DLEN * 51 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 51]};
                6'd14: data_dlen_sel = {data_dlen_all_zext[DLEN * 50 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 50]};
                6'd15: data_dlen_sel = {data_dlen_all_zext[DLEN * 49 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 49]};
                6'd16: data_dlen_sel = {data_dlen_all_zext[DLEN * 48 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 48]};
                6'd17: data_dlen_sel = {data_dlen_all_zext[DLEN * 47 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 47]};
                6'd18: data_dlen_sel = {data_dlen_all_zext[DLEN * 46 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 46]};
                6'd19: data_dlen_sel = {data_dlen_all_zext[DLEN * 45 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 45]};
                6'd20: data_dlen_sel = {data_dlen_all_zext[DLEN * 44 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 44]};
                6'd21: data_dlen_sel = {data_dlen_all_zext[DLEN * 43 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 43]};
                6'd22: data_dlen_sel = {data_dlen_all_zext[DLEN * 42 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 42]};
                6'd23: data_dlen_sel = {data_dlen_all_zext[DLEN * 41 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 41]};
                6'd24: data_dlen_sel = {data_dlen_all_zext[DLEN * 40 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 40]};
                6'd25: data_dlen_sel = {data_dlen_all_zext[DLEN * 39 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 39]};
                6'd26: data_dlen_sel = {data_dlen_all_zext[DLEN * 38 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 38]};
                6'd27: data_dlen_sel = {data_dlen_all_zext[DLEN * 37 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 37]};
                6'd28: data_dlen_sel = {data_dlen_all_zext[DLEN * 36 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 36]};
                6'd29: data_dlen_sel = {data_dlen_all_zext[DLEN * 35 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 35]};
                6'd30: data_dlen_sel = {data_dlen_all_zext[DLEN * 34 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 34]};
                6'd31: data_dlen_sel = {data_dlen_all_zext[DLEN * 33 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 33]};
                6'd32: data_dlen_sel = {data_dlen_all_zext[DLEN * 32 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 32]};
                6'd33: data_dlen_sel = {data_dlen_all_zext[DLEN * 31 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 31]};
                6'd34: data_dlen_sel = {data_dlen_all_zext[DLEN * 30 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 30]};
                6'd35: data_dlen_sel = {data_dlen_all_zext[DLEN * 29 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 29]};
                6'd36: data_dlen_sel = {data_dlen_all_zext[DLEN * 28 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 28]};
                6'd37: data_dlen_sel = {data_dlen_all_zext[DLEN * 27 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 27]};
                6'd38: data_dlen_sel = {data_dlen_all_zext[DLEN * 26 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 26]};
                6'd39: data_dlen_sel = {data_dlen_all_zext[DLEN * 25 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 25]};
                6'd40: data_dlen_sel = {data_dlen_all_zext[DLEN * 24 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 24]};
                6'd41: data_dlen_sel = {data_dlen_all_zext[DLEN * 23 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 23]};
                6'd42: data_dlen_sel = {data_dlen_all_zext[DLEN * 22 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 22]};
                6'd43: data_dlen_sel = {data_dlen_all_zext[DLEN * 21 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 21]};
                6'd44: data_dlen_sel = {data_dlen_all_zext[DLEN * 20 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 20]};
                6'd45: data_dlen_sel = {data_dlen_all_zext[DLEN * 19 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 19]};
                6'd46: data_dlen_sel = {data_dlen_all_zext[DLEN * 18 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 18]};
                6'd47: data_dlen_sel = {data_dlen_all_zext[DLEN * 17 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 17]};
                6'd48: data_dlen_sel = {data_dlen_all_zext[DLEN * 16 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 16]};
                6'd49: data_dlen_sel = {data_dlen_all_zext[DLEN * 15 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 15]};
                6'd50: data_dlen_sel = {data_dlen_all_zext[DLEN * 14 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 14]};
                6'd51: data_dlen_sel = {data_dlen_all_zext[DLEN * 13 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 13]};
                6'd52: data_dlen_sel = {data_dlen_all_zext[DLEN * 12 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 12]};
                6'd53: data_dlen_sel = {data_dlen_all_zext[DLEN * 11 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 11]};
                6'd54: data_dlen_sel = {data_dlen_all_zext[DLEN * 10 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 10]};
                6'd55: data_dlen_sel = {data_dlen_all_zext[DLEN * 9 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 9]};
                6'd56: data_dlen_sel = {data_dlen_all_zext[DLEN * 8 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 8]};
                6'd57: data_dlen_sel = {data_dlen_all_zext[DLEN * 7 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 7]};
                6'd58: data_dlen_sel = {data_dlen_all_zext[DLEN * 6 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 6]};
                6'd59: data_dlen_sel = {data_dlen_all_zext[DLEN * 5 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 5]};
                6'd60: data_dlen_sel = {data_dlen_all_zext[DLEN * 4 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 4]};
                6'd61: data_dlen_sel = {data_dlen_all_zext[DLEN * 3 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 3]};
                6'd62: data_dlen_sel = {data_dlen_all_zext[DLEN * 2 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 2]};
                6'd63: data_dlen_sel = {data_dlen_all_zext[DLEN * 1 - 1:0],data_dlen_all_zext[DLEN * 64 - 1:DLEN * 1]};
                default: begin
                    data_dlen_sel = {DLEN * BUF_DEPTH_SEG{1'b0}};
                end
            endcase
        end

    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

