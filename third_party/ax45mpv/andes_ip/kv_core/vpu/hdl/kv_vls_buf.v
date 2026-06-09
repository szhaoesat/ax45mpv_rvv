// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_buf (
    vpu_vlsu_clk,
    vpu_reset_n,
    vlsu_buf_pending,
    claim_vbuf_valid,
    claim_vbuf_size,
    claim_vbuf_cnt,
    claim_vbuf_ready,
    claim_buf_resp_num,
    claim_buf_resp_ptr,
    claim_buf_reset,
    uop_claim_buf_valid,
    uop_claim_buf_size,
    uop_claim_buf_grant,
    uop_claim_buf_resp_num,
    vlsbuf_uop_claim_sel,
    vlsbuf_return_sel,
    vlsbuf_kill_sel,
    vlsbuf_vs3_wsel,
    vlsbuf_vs3_wdata,
    vlsbuf_vs3_rptr,
    vlsbuf_vs3_rdata,
    vlsbuf_vs3_byte_mask,
    vlsbuf_vd_wsel,
    vlsbuf_vd_write_dlen_last,
    vlsbuf_vd_wdata,
    vlsbuf_vd_bwe,
    vlsbuf_vd_dlen_done,
    vlsbuf_vd_rdata,
    vlsbuf_vd_byte_mask,
    vlsbuf_vd_ualign_wsel,
    vlsbuf_vd_ualign_write_dlen_last,
    vlsbuf_vd_ualign_wdata,
    vlsbuf_vd_ualign_bwe,
    vlsbuf_vd_element_bwe_wsel,
    vlsbuf_vd_element_bwe,
    hr_vd_buf_ptr_dup_en,
    hr_vd_buf_ptr_dup_nx,
    hr_vd_mask_buf_ptr_dup_nx,
    vlsbuf_ent_occupied,
    vlsbuf_ent_mask_ready,
    vlsbuf_ent_mask_ready_nx,
    vlsbuf_ent_return_last,
    vlsq2buf_req_valid,
    vlsq2buf_byte_mask_wptr,
    vlsq2buf_byte_mask,
    vlsbuf_data_all,
    vlsbuf_packed_shift_sel,
    vlsbuf_packed_shift_eew_onehot,
    vlsbuf_unpacked_wsel,
    vlsbuf_unpacked_data_all,
    vlsbuf_unpacked_bwe,
    vlsbuf_ustride_unpacked_wsel,
    vlsbuf_ustride_unpacked_data_all
);
parameter VLEN = 512;
parameter DLEN = 512;
parameter DMLEN = DLEN / 8;
parameter BUF_UCNT_WIDTH = 2;
parameter BUF_DEPTH = 8;
parameter BUF_DEPTH_LOG2 = $clog2(BUF_DEPTH);
parameter ELE_DLEN_WIDTH = $clog2(DLEN / 8);
localparam DLEN_LMUL = (VLEN == DLEN) ? 8 : 16;
input vpu_vlsu_clk;
input vpu_reset_n;
output vlsu_buf_pending;
input claim_vbuf_valid;
input [BUF_DEPTH_LOG2 - 1:0] claim_vbuf_size;
input [BUF_DEPTH * BUF_UCNT_WIDTH - 1:0] claim_vbuf_cnt;
output claim_vbuf_ready;
output [BUF_DEPTH_LOG2 - 1:0] claim_buf_resp_num;
output [BUF_DEPTH - 1:0] claim_buf_resp_ptr;
input claim_buf_reset;
input uop_claim_buf_valid;
input [BUF_DEPTH_LOG2 - 1:0] uop_claim_buf_size;
output uop_claim_buf_grant;
output [BUF_DEPTH_LOG2 - 1:0] uop_claim_buf_resp_num;
input [BUF_DEPTH - 1:0] vlsbuf_uop_claim_sel;
input [BUF_DEPTH - 1:0] vlsbuf_return_sel;
input [BUF_DEPTH - 1:0] vlsbuf_kill_sel;
input [BUF_DEPTH - 1:0] vlsbuf_vs3_wsel;
input [DLEN - 1:0] vlsbuf_vs3_wdata;
input [BUF_DEPTH - 1:0] vlsbuf_vs3_rptr;
output [DLEN - 1:0] vlsbuf_vs3_rdata;
output [DMLEN - 1:0] vlsbuf_vs3_byte_mask;
input [BUF_DEPTH - 1:0] vlsbuf_vd_wsel;
input vlsbuf_vd_write_dlen_last;
input [DLEN - 1:0] vlsbuf_vd_wdata;
input [DMLEN - 1:0] vlsbuf_vd_bwe;
input [BUF_DEPTH - 1:0] vlsbuf_vd_dlen_done;
output [DLEN - 1:0] vlsbuf_vd_rdata;
output [DMLEN - 1:0] vlsbuf_vd_byte_mask;
input [BUF_DEPTH - 1:0] vlsbuf_vd_ualign_wsel;
input vlsbuf_vd_ualign_write_dlen_last;
input [DLEN - 1:0] vlsbuf_vd_ualign_wdata;
input [DMLEN - 1:0] vlsbuf_vd_ualign_bwe;
input [BUF_DEPTH - 1:0] vlsbuf_vd_element_bwe_wsel;
input [DMLEN - 1:0] vlsbuf_vd_element_bwe;
input hr_vd_buf_ptr_dup_en;
input [BUF_DEPTH - 1:0] hr_vd_buf_ptr_dup_nx;
input [BUF_DEPTH - 1:0] hr_vd_mask_buf_ptr_dup_nx;
output [BUF_DEPTH - 1:0] vlsbuf_ent_occupied;
output [BUF_DEPTH - 1:0] vlsbuf_ent_mask_ready;
output [BUF_DEPTH - 1:0] vlsbuf_ent_mask_ready_nx;
output [BUF_DEPTH - 1:0] vlsbuf_ent_return_last;
input vlsq2buf_req_valid;
input [BUF_DEPTH - 1:0] vlsq2buf_byte_mask_wptr;
input [DMLEN - 1:0] vlsq2buf_byte_mask;
output [(BUF_DEPTH * DLEN) - 1:0] vlsbuf_data_all;
input [BUF_DEPTH - 1:0] vlsbuf_packed_shift_sel;
input [3:0] vlsbuf_packed_shift_eew_onehot;
input [BUF_DEPTH - 1:0] vlsbuf_unpacked_wsel;
input [(BUF_DEPTH * DLEN) - 1:0] vlsbuf_unpacked_data_all;
input [DMLEN - 1:0] vlsbuf_unpacked_bwe;
input [BUF_DEPTH - 1:0] vlsbuf_ustride_unpacked_wsel;
input [(BUF_DEPTH * DLEN) - 1:0] vlsbuf_ustride_unpacked_data_all;





// e251e12e rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire buf_release_valid;
wire buf_flush_en;
wire buf_deq_ptr_en;
wire [BUF_DEPTH - 1:0] buf_deq_ptr;
wire [BUF_DEPTH - 1:0] vlsbuf_deq_sel;
wire [BUF_DEPTH - 1:0] vlsbuf_claim_sel;
wire buf_num_en;
wire [BUF_DEPTH_LOG2 - 1:0] buf_num_nx;
wire [BUF_DEPTH_LOG2 - 1:0] buf_num_cnt;
wire [BUF_DEPTH_LOG2 - 1:0] buf_num_cnt_add1;
wire [BUF_DEPTH_LOG2 - 1:0] buf_num_sel;
reg [BUF_DEPTH_LOG2 - 1:0] buf_num;
wire [BUF_DEPTH - 1:0] vlsbuf_shift_sel;
wire [3:0] vlsbuf_shift_eew_onehot;
reg [((DLEN / 64) * BUF_DEPTH) - 1:0] hr_vd_data_buf_ptr;
reg [BUF_DEPTH - 1:0] hr_vd_mask_buf_ptr;
wire [BUF_DEPTH - 1:0] buf_ent_occupied;
wire [(DLEN * BUF_DEPTH) - 1:0] buf_ent_rdata;
wire [BUF_DEPTH - 1:0] buf_ent_mask_ready;
wire [BUF_DEPTH - 1:0] buf_ent_mask_ready_nx;
wire [(DMLEN * BUF_DEPTH) - 1:0] buf_ent_byte_mask;
wire [BUF_DEPTH - 1:0] buf_ent_done;
wire [BUF_DEPTH - 1:0] buf_ent_pending;
wire [BUF_DEPTH - 1:0] buf_ent_return_last;
wire [BUF_DEPTH - 1:0] vlsbuf_occupied_set;
wire [BUF_DEPTH - 1:0] vlsbuf_occupied_clr;
wire [DLEN - 1:0] vlsbuf_vd_rdata;
wire [DMLEN - 1:0] vlsbuf_vd_byte_mask;
wire [DLEN - 1:0] vlsbuf_vs3_rdata;
wire [BUF_DEPTH - 1:0] vlsbuf_vd_wsel;
wire [BUF_DEPTH - 1:0] vlsbuf_vs3_wsel;
wire vlsq2buf_req_valid;
wire vlsq2buf_req_ready;
wire vlsq2buf_req_grant;
wire [BUF_DEPTH - 1:0] vlsq2buf_byte_mask_wsel;
wire claim_vbuf_grant;
wire claim_vbuf_success;
wire [BUF_DEPTH_LOG2:0] claim_vbuf_size_add1;
wire remain_buf_jcnt_en;
reg [BUF_DEPTH - 1:0] remain_buf_jcnt;
wire [BUF_DEPTH - 1:0] remain_buf_jcnt_nx;
wire [BUF_DEPTH + 15:0] remain_buf_jcnt_ext;
wire claim_vbuf_size1;
wire claim_vbuf_size2;
wire claim_vbuf_size3;
wire claim_vbuf_size4;
wire claim_vbuf_size5;
wire claim_vbuf_size6;
wire claim_vbuf_size7;
wire claim_vbuf_size8;
wire claim_vbuf_size9;
wire claim_vbuf_size10;
wire claim_vbuf_size11;
wire claim_vbuf_size12;
wire claim_vbuf_size13;
wire claim_vbuf_size14;
wire claim_vbuf_size15;
wire claim_vbuf_size16;
wire nds_unused_ov1;
wire nds_unused_ov2;
kv_cnt_onehot #(
    .N(BUF_DEPTH)
) u_buf_deq_ptr (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(buf_deq_ptr_en),
    .up_dn(1'b1),
    .load(buf_flush_en),
    .data({{BUF_DEPTH - 1{1'b0}},1'b1}),
    .cnt(buf_deq_ptr)
);
kv_bin2onehot #(
    .N(BUF_DEPTH)
) u_claim_buf_resp_ptr (
    .out(claim_buf_resp_ptr),
    .in(claim_buf_resp_num)
);
kv_vls_gen_ones #(
    .MAX_NUM(DLEN_LMUL),
    .N(BUF_DEPTH),
    .W(BUF_DEPTH_LOG2 + 1)
) u_vlsbuf_claim_sel (
    .en(claim_vbuf_grant),
    .in(claim_buf_resp_ptr),
    .num(claim_vbuf_size_add1),
    .out(vlsbuf_claim_sel)
);
genvar i;
genvar j;
generate
    for (j = 0; j < DLEN / 64; j = j + 1) begin:gen_buf_ent_rdata_lane_x
        wire [BUF_DEPTH * 64 - 1:0] buf_ent_rdata_transpose;
        for (i = 0; i < BUF_DEPTH; i = i + 1) begin:gen_buf_ent_rdata_lane_y
            assign buf_ent_rdata_transpose[i * 64 +:64] = buf_ent_rdata[(i * DLEN + j * 64) +:64];
        end
        kv_mux_onehot #(
            .N(BUF_DEPTH),
            .W(64)
        ) u_vlsbuf_vd_rdata (
            .out(vlsbuf_vd_rdata[j * 64 +:64]),
            .sel(hr_vd_data_buf_ptr[j * BUF_DEPTH +:BUF_DEPTH]),
            .in(buf_ent_rdata_transpose)
        );
    end
endgenerate
kv_mux_onehot #(
    .N(BUF_DEPTH),
    .W(DMLEN)
) u_vlsbuf_vd_byte_mask (
    .out(vlsbuf_vd_byte_mask),
    .sel(hr_vd_mask_buf_ptr),
    .in(buf_ent_byte_mask)
);
kv_mux_onehot #(
    .N(BUF_DEPTH),
    .W(DLEN)
) u_vlsbuf_vs3_rdata (
    .out(vlsbuf_vs3_rdata),
    .sel(vlsbuf_vs3_rptr),
    .in(buf_ent_rdata)
);
kv_mux_onehot #(
    .N(BUF_DEPTH),
    .W(DMLEN)
) u_vlsbuf_vs3_byte_mask (
    .out(vlsbuf_vs3_byte_mask),
    .sel(vlsbuf_vs3_rptr),
    .in(buf_ent_byte_mask)
);
generate
    for (i = 0; i < BUF_DEPTH; i = i + 1) begin:gen_vls_buf_ent
        kv_vls_buf_ent #(
            .DLEN(DLEN),
            .DMLEN(DMLEN),
            .BUF_UCNT_WIDTH(BUF_UCNT_WIDTH)
        ) u_vls_buf_ent (
            .vpu_vlsu_clk(vpu_vlsu_clk),
            .vpu_reset_n(vpu_reset_n),
            .buf_claim_valid(vlsbuf_claim_sel[i]),
            .buf_claim_cnt(claim_vbuf_cnt[BUF_UCNT_WIDTH * i +:BUF_UCNT_WIDTH]),
            .buf_kill_valid(vlsbuf_kill_sel[i]),
            .buf_return_valid(vlsbuf_return_sel[i]),
            .buf_deq_valid(vlsbuf_deq_sel[i]),
            .buf_occupied_set(vlsbuf_occupied_set[i]),
            .buf_occupied_clr(vlsbuf_occupied_clr[i]),
            .buf_vd_wvalid(vlsbuf_vd_wsel[i]),
            .buf_vd_ualign_wvalid(vlsbuf_vd_ualign_wsel[i]),
            .buf_vs3_wvalid(vlsbuf_vs3_wsel[i]),
            .buf_vd_seg_wvalid(vlsbuf_unpacked_wsel[i]),
            .buf_vd_seg_wdata(vlsbuf_unpacked_data_all[DLEN * i +:DLEN]),
            .buf_vd_seg_bwe(vlsbuf_unpacked_bwe),
            .buf_vd_wdata(vlsbuf_vd_wdata),
            .buf_vd_bwe(vlsbuf_vd_bwe),
            .buf_vd_ualign_wdata(vlsbuf_vd_ualign_wdata),
            .buf_vd_ualign_bwe(vlsbuf_vd_ualign_bwe),
            .buf_vs3_wdata(vlsbuf_vs3_wdata),
            .buf_useg_wvalid(vlsbuf_ustride_unpacked_wsel[i]),
            .buf_useg_wdata(vlsbuf_ustride_unpacked_data_all[DLEN * i +:DLEN]),
            .buf_byte_mask_wvalid(vlsq2buf_byte_mask_wsel[i]),
            .buf_byte_mask(vlsq2buf_byte_mask),
            .buf_vd_element_bwe_wvalid(vlsbuf_vd_element_bwe_wsel[i]),
            .buf_vd_element_bwe(vlsbuf_vd_element_bwe),
            .buf_shift_valid(vlsbuf_shift_sel[i]),
            .buf_shift_eew_onehot(vlsbuf_shift_eew_onehot),
            .buf_qout_occupied(buf_ent_occupied[i]),
            .buf_qout_rdata(buf_ent_rdata[DLEN * i +:DLEN]),
            .buf_qout_mask_ready(buf_ent_mask_ready[i]),
            .buf_qout_mask_ready_nx(buf_ent_mask_ready_nx[i]),
            .buf_qout_byte_mask(buf_ent_byte_mask[DMLEN * i +:DMLEN]),
            .buf_qout_done(buf_ent_done[i]),
            .buf_qout_pending(buf_ent_pending[i]),
            .buf_qout_return_last(buf_ent_return_last[i])
        );
    end
endgenerate
assign vlsu_buf_pending = |buf_ent_pending;
assign buf_num_en = claim_vbuf_grant | uop_claim_buf_grant;
assign buf_num_cnt = uop_claim_buf_grant ? uop_claim_buf_size : claim_vbuf_size;
assign buf_num_sel = claim_buf_reset ? {BUF_DEPTH_LOG2{1'b0}} : buf_num;
assign claim_buf_resp_num = buf_num_sel;
assign {nds_unused_ov1,buf_num_cnt_add1} = buf_num_cnt + {{BUF_DEPTH_LOG2 - 1{1'b0}},1'b1};
assign {nds_unused_ov2,buf_num_nx} = buf_num_sel + buf_num_cnt_add1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        buf_num <= {BUF_DEPTH_LOG2{1'b0}};
    end
    else if (buf_num_en) begin
        buf_num <= buf_num_nx;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_vd_data_buf_ptr <= {{(DLEN / 64) * BUF_DEPTH{1'b0}}};
        hr_vd_mask_buf_ptr <= {BUF_DEPTH{1'b0}};
    end
    else if (hr_vd_buf_ptr_dup_en) begin
        hr_vd_data_buf_ptr <= {DLEN / 64{hr_vd_buf_ptr_dup_nx}};
        hr_vd_mask_buf_ptr <= hr_vd_mask_buf_ptr_dup_nx;
    end
end

assign vlsbuf_deq_sel = buf_deq_ptr & buf_ent_done;
assign buf_flush_en = claim_buf_reset & claim_vbuf_grant;
assign buf_deq_ptr_en = (|vlsbuf_deq_sel) | buf_flush_en;
assign vlsq2buf_byte_mask_wsel = {BUF_DEPTH{vlsq2buf_req_grant}} & vlsq2buf_byte_mask_wptr;
assign vlsq2buf_req_grant = vlsq2buf_req_valid & vlsq2buf_req_ready;
assign vlsq2buf_req_ready = |(vlsq2buf_byte_mask_wptr & ~vlsbuf_ent_mask_ready);
assign vlsbuf_shift_sel = vlsbuf_packed_shift_sel;
assign vlsbuf_shift_eew_onehot = vlsbuf_packed_shift_eew_onehot;
assign vlsbuf_occupied_set = vlsbuf_vs3_wsel | ({BUF_DEPTH{vlsbuf_vd_write_dlen_last}} & vlsbuf_vd_wsel) | ({BUF_DEPTH{vlsbuf_vd_ualign_write_dlen_last}} & vlsbuf_vd_ualign_wsel) | vlsbuf_vd_dlen_done;
assign vlsbuf_occupied_clr = (vlsbuf_return_sel | vlsbuf_kill_sel);
assign vlsbuf_ent_occupied = buf_ent_occupied;
assign vlsbuf_ent_mask_ready = buf_ent_mask_ready;
assign vlsbuf_ent_mask_ready_nx = buf_ent_mask_ready_nx;
assign vlsbuf_ent_return_last = buf_ent_return_last;
assign claim_vbuf_grant = claim_vbuf_valid & claim_vbuf_ready;
assign claim_vbuf_ready = ((claim_buf_reset & ~vlsu_buf_pending) | (~claim_buf_reset & claim_vbuf_success));
assign claim_vbuf_size_add1 = {1'b0,claim_vbuf_size} + {{BUF_DEPTH_LOG2{1'b0}},1'b1};
assign uop_claim_buf_grant = uop_claim_buf_valid & claim_vbuf_success;
assign uop_claim_buf_resp_num = buf_num_sel;
assign buf_release_valid = |vlsbuf_deq_sel;
assign remain_buf_jcnt_en = buf_release_valid | claim_vbuf_grant;
assign vlsbuf_data_all = buf_ent_rdata;
assign claim_vbuf_size1 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2{1'b0}},1'd0});
assign claim_vbuf_size2 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2{1'b0}},1'd1});
assign claim_vbuf_size3 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2 - 1{1'b0}},2'd2});
assign claim_vbuf_size4 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2 - 1{1'b0}},2'd3});
assign claim_vbuf_size5 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2 - 2{1'b0}},3'd4});
assign claim_vbuf_size6 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2 - 2{1'b0}},3'd5});
assign claim_vbuf_size7 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2 - 2{1'b0}},3'd6});
assign claim_vbuf_size8 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2 - 2{1'b0}},3'd7});
generate
    if ((VLEN / DLEN) == 2) begin:gen_claim_vlen_dlen_2_1
        assign claim_vbuf_size9 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2 - 3{1'b0}},4'd8});
        assign claim_vbuf_size10 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2 - 3{1'b0}},4'd9});
        assign claim_vbuf_size11 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2 - 3{1'b0}},4'd10});
        assign claim_vbuf_size12 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2 - 3{1'b0}},4'd11});
        assign claim_vbuf_size13 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2 - 3{1'b0}},4'd12});
        assign claim_vbuf_size14 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2 - 3{1'b0}},4'd13});
        assign claim_vbuf_size15 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2 - 3{1'b0}},4'd14});
        assign claim_vbuf_size16 = ({1'b0,claim_vbuf_size} == {{BUF_DEPTH_LOG2 - 3{1'b0}},4'd15});
        assign claim_vbuf_success = claim_buf_reset ? ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 16]) : (claim_vbuf_size1 & ~|remain_buf_jcnt[BUF_DEPTH - 1] | claim_vbuf_size2 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 2]) | claim_vbuf_size3 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 3]) | claim_vbuf_size4 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 4]) | claim_vbuf_size5 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 5]) | claim_vbuf_size6 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 6]) | claim_vbuf_size7 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 7]) | claim_vbuf_size8 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 8]) | claim_vbuf_size9 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 9]) | claim_vbuf_size10 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 10]) | claim_vbuf_size11 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 11]) | claim_vbuf_size12 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 12]) | claim_vbuf_size13 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 13]) | claim_vbuf_size14 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 14]) | claim_vbuf_size15 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 15]) | claim_vbuf_size16 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 16]));
    end
    else begin:gen_claim_vlen_dlen_1_1
        assign claim_vbuf_size9 = 1'b0;
        assign claim_vbuf_size10 = 1'b0;
        assign claim_vbuf_size11 = 1'b0;
        assign claim_vbuf_size12 = 1'b0;
        assign claim_vbuf_size13 = 1'b0;
        assign claim_vbuf_size14 = 1'b0;
        assign claim_vbuf_size15 = 1'b0;
        assign claim_vbuf_size16 = 1'b0;
        assign claim_vbuf_success = claim_buf_reset ? ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 8]) : (claim_vbuf_size1 & ~|remain_buf_jcnt[BUF_DEPTH - 1] | claim_vbuf_size2 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 2]) | claim_vbuf_size3 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 3]) | claim_vbuf_size4 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 4]) | claim_vbuf_size5 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 5]) | claim_vbuf_size6 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 6]) | claim_vbuf_size7 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 7]) | claim_vbuf_size8 & ~(|remain_buf_jcnt[BUF_DEPTH - 1:BUF_DEPTH - 8]));
    end
endgenerate
assign remain_buf_jcnt_ext = claim_vbuf_grant ? (({BUF_DEPTH + 16{claim_vbuf_size1}} & {15'b0,remain_buf_jcnt[BUF_DEPTH - 1:0],1'h1}) | ({BUF_DEPTH + 16{claim_vbuf_size2}} & {14'b0,remain_buf_jcnt[BUF_DEPTH - 1:0],2'h3}) | ({BUF_DEPTH + 16{claim_vbuf_size3}} & {13'b0,remain_buf_jcnt[BUF_DEPTH - 1:0],3'h7}) | ({BUF_DEPTH + 16{claim_vbuf_size4}} & {12'b0,remain_buf_jcnt[BUF_DEPTH - 1:0],4'hf}) | ({BUF_DEPTH + 16{claim_vbuf_size5}} & {11'b0,remain_buf_jcnt[BUF_DEPTH - 1:0],5'h1f}) | ({BUF_DEPTH + 16{claim_vbuf_size6}} & {10'b0,remain_buf_jcnt[BUF_DEPTH - 1:0],6'h3f}) | ({BUF_DEPTH + 16{claim_vbuf_size7}} & {9'b0,remain_buf_jcnt[BUF_DEPTH - 1:0],7'h7f}) | ({BUF_DEPTH + 16{claim_vbuf_size8}} & {8'b0,remain_buf_jcnt[BUF_DEPTH - 1:0],8'hff}) | ({BUF_DEPTH + 16{claim_vbuf_size9}} & {7'b0,remain_buf_jcnt[BUF_DEPTH - 1:0],9'h1ff}) | ({BUF_DEPTH + 16{claim_vbuf_size10}} & {6'b0,remain_buf_jcnt[BUF_DEPTH - 1:0],10'h3ff}) | ({BUF_DEPTH + 16{claim_vbuf_size11}} & {5'b0,remain_buf_jcnt[BUF_DEPTH - 1:0],11'h7ff}) | ({BUF_DEPTH + 16{claim_vbuf_size12}} & {4'b0,remain_buf_jcnt[BUF_DEPTH - 1:0],12'hfff}) | ({BUF_DEPTH + 16{claim_vbuf_size13}} & {3'b0,remain_buf_jcnt[BUF_DEPTH - 1:0],13'h1fff}) | ({BUF_DEPTH + 16{claim_vbuf_size14}} & {2'b0,remain_buf_jcnt[BUF_DEPTH - 1:0],14'h3fff}) | ({BUF_DEPTH + 16{claim_vbuf_size15}} & {1'b0,remain_buf_jcnt[BUF_DEPTH - 1:0],15'h7fff}) | ({BUF_DEPTH + 16{claim_vbuf_size16}} & {remain_buf_jcnt[BUF_DEPTH - 1:0],16'hffff})) : {16'b0,remain_buf_jcnt[BUF_DEPTH - 1:0]};
assign remain_buf_jcnt_nx = buf_release_valid ? remain_buf_jcnt_ext[BUF_DEPTH:1] : remain_buf_jcnt_ext[BUF_DEPTH - 1:0];
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        remain_buf_jcnt <= {BUF_DEPTH{1'b0}};
    end
    else if (remain_buf_jcnt_en) begin
        remain_buf_jcnt <= remain_buf_jcnt_nx;
    end
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

