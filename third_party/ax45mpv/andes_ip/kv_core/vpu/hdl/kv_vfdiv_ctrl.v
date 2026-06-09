// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfdiv_ctrl (
    vpu_vfdiv_clk,
    vpu_reset_n,
    vfdiv_cmt_valid,
    vfdiv_cmt_kill,
    vfdiv_standby_ready,
    veq_ex_valid,
    veq_ex_ready,
    veq_ex_ctrl,
    veq_ex_vd_len,
    veq_ex_vs1_len,
    veq_ex_vs2_len,
    veq_ex_byte_mask,
    veq_ex_cmt,
    veq_ex_op1_valid,
    veq_ex_byte_mask_srl,
    exs_nxt_cmt,
    f0_nxt_cmt,
    wb_standby,
    wb_us_valid,
    wb_us_ready,
    wb_us_flag_update,
    wb_us_flag,
    wb_us_flag_clr,
    wb_us_wdata,
    wb_us_bit_wen,
    wb_us_mask_wdata,
    wb_us_cmtted,
    wb_us_last,
    vrf_vs1_valid,
    vrf_vs1_rd,
    vrf_vs1_kill,
    vrf_vs1_srl,
    vrf_vs2_valid,
    vrf_vs2_rd,
    vrf_vs2_kill,
    vrf_vs2_srl,
    vfdiv_req_valid,
    vfdiv_req_ready,
    vfdiv_req_byte_mask,
    vfdiv_resp_wdata,
    vfdiv_resp_valid,
    vfdiv_resp_ready,
    vfdiv_resp_flag_set,
    vfdiv_kill
);
parameter VLEN = 1024;
parameter DLEN = 512;
parameter CLEN = 512;
parameter ELEN = 64;
parameter XLEN = 64;
parameter VRF_LW = 4;
localparam CBLEN = CLEN / 8;
localparam DBLEN = DLEN / 8;
localparam MASK_CAL_LSB = (CLEN == 1024) ? 4 : (CLEN == 512) ? 3 : (CLEN == 256) ? 2 : (CLEN == 128) ? 1 : 0;
localparam CLEN_CNT_BIT = $clog2(DLEN / CLEN);
localparam VLEN_NEQ_DLEN = $clog2(VLEN / DLEN);
localparam UOP_NUM = 3 + CLEN_CNT_BIT + VLEN_NEQ_DLEN;
localparam VL_MSB = MASK_CAL_LSB + UOP_NUM;
input vpu_vfdiv_clk;
input vpu_reset_n;
output vfdiv_standby_ready;
input vfdiv_cmt_valid;
input vfdiv_cmt_kill;
input veq_ex_valid;
output veq_ex_ready;
input [39 - 1:0] veq_ex_ctrl;
input [VLEN - 1:0] veq_ex_byte_mask;
input [VRF_LW - 1:0] veq_ex_vd_len;
input [VRF_LW - 1:0] veq_ex_vs1_len;
input [VRF_LW - 1:0] veq_ex_vs2_len;
input veq_ex_cmt;
input veq_ex_op1_valid;
output veq_ex_byte_mask_srl;
input exs_nxt_cmt;
output f0_nxt_cmt;
input wb_standby;
output wb_us_valid;
input wb_us_ready;
output wb_us_flag_update;
output [4:0] wb_us_flag;
output wb_us_flag_clr;
output [DLEN - 1:0] wb_us_wdata;
output [DLEN - 1:0] wb_us_bit_wen;
output [DLEN / 8 - 1:0] wb_us_mask_wdata;
output wb_us_cmtted;
output wb_us_last;
input vrf_vs1_valid;
output vrf_vs1_rd;
output vrf_vs1_kill;
output vrf_vs1_srl;
input vrf_vs2_valid;
output vrf_vs2_rd;
output vrf_vs2_kill;
output vrf_vs2_srl;
output vfdiv_req_valid;
input vfdiv_req_ready;
output [CLEN / 8 - 1:0] vfdiv_req_byte_mask;
input [CLEN - 1:0] vfdiv_resp_wdata;
input vfdiv_resp_valid;
output vfdiv_resp_ready;
input [4:0] vfdiv_resp_flag_set;
output vfdiv_kill;





// fa501ef6 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [CBLEN - 1:0] f0_ps_mask;
wire [CBLEN - 1:0] f0_tail_mask;
reg [UOP_NUM - 1:0] f0_uop_cnt;
wire f0_uop_cnt_en;
wire [UOP_NUM - 1:0] f0_uop_cnt_nx;
wire f0_uop_cnt_clr;
wire f0_uop_cnt_incr1;
wire f0_last;
wire f0_kill;
wire f0_cmt;
wire f0_valid;
wire [CLEN / 8 - 1:0] f0_v0t_byte_mask;
wire f0_no_mask;
wire [CLEN / 8 - 1:0] f0_byte_mask;
wire [2:0] nds_unused_f0_lmul;
wire f0_op1_ready;
wire f0_op2_ready;
wire [1:0] f0_op1_src;
wire [2:0] f0_op2_src;
reg f1_last;
wire f1_kill;
reg f1_valid;
wire f1_valid_nx;
wire f1_valid_en;
wire f1_pipe_en;
reg [CLEN / 8 - 1:0] f1_byte_mask;
reg [3:0] f1_clen_cal_cnt;
reg f1_cmt;
wire f1_cmt_set;
wire f1_cmt_clr;
wire f1_cmt_nx;
wire f1_cmt_en;
reg f1_clen_cal_last;
wire f0_pipe_to_f1;
wire [10:0] f0_vl;
wire [9:0] f0_vstart;
wire [3:0] f0_sew;
wire f0_clen_cal_last;
wire vrf_ill;
assign vrf_ill = (f0_op1_src[0] & (veq_ex_vd_len != veq_ex_vs2_len)) | (f0_op2_src[2] & (veq_ex_vd_len != veq_ex_vs2_len)) | (f0_op2_src[0] & (veq_ex_vd_len != veq_ex_vs1_len));
assign f0_valid = veq_ex_valid;
assign nds_unused_f0_lmul = veq_ex_ctrl[5 +:3];
assign f0_vl = veq_ex_ctrl[17 +:11];
assign f0_vstart = veq_ex_ctrl[29 +:10];
assign f0_no_mask = veq_ex_ctrl[28];
assign f0_cmt = veq_ex_cmt;
assign f0_op1_src = veq_ex_ctrl[8 +:2];
assign f0_op2_src = veq_ex_ctrl[10 +:3];
assign f0_sew = veq_ex_ctrl[13 +:4];
assign f0_kill = (f1_valid & f1_cmt & ~f0_cmt & vfdiv_cmt_valid & vfdiv_cmt_kill) | (f1_valid & ~f1_last & ~f1_cmt & exs_nxt_cmt & vfdiv_cmt_valid & vfdiv_cmt_kill) | (~f1_valid & exs_nxt_cmt & vfdiv_cmt_valid & vfdiv_cmt_kill);
generate
    if (CLEN == DLEN) begin:gen_last_clen_clen_eq_dlen
        assign f0_clen_cal_last = 1'b1;
        assign f0_last = (veq_ex_vd_len == f0_uop_cnt[VRF_LW - 1:0]);
    end
    else if (DLEN / CLEN == 2) begin:gen_last_clen_clen_dlen_2_1
        assign f0_clen_cal_last = f0_uop_cnt[0];
        assign f0_last = (veq_ex_vd_len == f0_uop_cnt[VRF_LW:1]) & f0_uop_cnt[0];
    end
    else if (DLEN / CLEN == 4) begin:gen_last_clen_clen_dlen_4_1
        assign f0_clen_cal_last = &f0_uop_cnt[1:0];
        assign f0_last = (veq_ex_vd_len == f0_uop_cnt[VRF_LW + 1:2]) & (&f0_uop_cnt[1:0]);
    end
    else if (DLEN / CLEN == 8) begin:gen_last_clen_clen_dlen_8_1
        assign f0_clen_cal_last = &f0_uop_cnt[2:0];
        assign f0_last = (veq_ex_vd_len == f0_uop_cnt[VRF_LW + 1:3]) & (&f0_uop_cnt[2:0]);
    end
    else if (DLEN / CLEN == 16) begin:gen_last_clen_clen_dlen_16_1
        assign f0_clen_cal_last = &f0_uop_cnt[3:0];
        assign f0_last = (veq_ex_vd_len == f0_uop_cnt[VRF_LW + 1:4]) & (&f0_uop_cnt[3:0]);
    end
endgenerate
assign f0_op1_ready = (f0_op1_src[0] & vrf_vs2_valid) | (f0_op1_src[1] & veq_ex_op1_valid) | (~(|f0_op1_src));
assign f0_op2_ready = (f0_op2_src[0] & vrf_vs1_valid) | (f0_op2_src[1] & veq_ex_op1_valid) | (f0_op2_src[2] & vrf_vs2_valid) | (~(|f0_op2_src));
assign vfdiv_req_valid = veq_ex_valid & f0_op1_ready & f0_op2_ready & ~vrf_ill & ~f0_kill;
assign vfdiv_req_byte_mask = f0_byte_mask;
assign vfdiv_kill = f1_kill;
assign vfdiv_resp_ready = wb_us_ready;
assign vrf_vs1_rd = (~vrf_vs1_valid & veq_ex_valid & f0_op2_src[0]);
assign vrf_vs1_srl = vfdiv_req_valid & vfdiv_req_ready & f0_op2_src[0] & ~f0_clen_cal_last & (DLEN != CLEN);
assign vrf_vs1_kill = (f0_valid & f0_op2_src[0] & f0_kill) | (vfdiv_req_valid & vfdiv_req_ready & f0_op2_src[0] & f0_clen_cal_last & ~f0_kill);
assign vrf_vs2_rd = (~vrf_vs2_valid & veq_ex_valid & f0_op1_src[0]) | (~vrf_vs2_valid & veq_ex_valid & f0_op2_src[2]);
assign vrf_vs2_srl = (vfdiv_req_valid & vfdiv_req_ready & f0_op1_src[0] & ~f0_clen_cal_last & (DLEN != CLEN)) | (vfdiv_req_valid & vfdiv_req_ready & f0_op2_src[2] & ~f0_clen_cal_last & (DLEN != CLEN));
assign vrf_vs2_kill = (f0_valid & f0_op2_src[2] & f0_kill) | (f0_valid & f0_op1_src[0] & f0_kill) | (vfdiv_req_valid & vfdiv_req_ready & f0_op1_src[0] & f0_clen_cal_last & ~f0_kill) | (vfdiv_req_valid & vfdiv_req_ready & f0_op2_src[2] & f0_clen_cal_last & ~f0_kill);
assign f0_uop_cnt_clr = (vfdiv_req_valid & vfdiv_req_ready & f0_last) | f0_kill;
assign f0_uop_cnt_incr1 = vfdiv_req_valid & vfdiv_req_ready;
assign f0_uop_cnt_nx = f0_uop_cnt_clr ? {UOP_NUM{1'b0}} : f0_uop_cnt + {{UOP_NUM - 1{1'b0}},1'b1};
assign f0_uop_cnt_en = f0_uop_cnt_clr | f0_uop_cnt_incr1;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        f0_uop_cnt <= {UOP_NUM{1'b0}};
    end
    else if (f0_uop_cnt_en) begin
        f0_uop_cnt <= f0_uop_cnt_nx;
    end
end

assign f0_nxt_cmt = (exs_nxt_cmt & ~f1_valid & f0_valid & ~f0_cmt) | (exs_nxt_cmt & f1_valid & ~f1_cmt & ~f1_last) | (f1_valid & f1_last & f1_cmt & ~f0_cmt);
assign veq_ex_ready = (vfdiv_req_valid & vfdiv_req_ready & f0_last) | f0_kill;
assign veq_ex_byte_mask_srl = vfdiv_req_valid & vfdiv_req_ready & ~f0_last;
assign f0_pipe_to_f1 = (f0_valid & f0_op1_ready & f0_op2_ready & vfdiv_req_ready & ~f0_kill);
assign f1_kill = exs_nxt_cmt & vfdiv_cmt_valid & vfdiv_cmt_kill & ~f1_cmt;
assign f1_valid_nx = f0_pipe_to_f1 | (f1_valid & ~f1_kill & ~vfdiv_resp_valid);
assign f1_valid_en = f0_pipe_to_f1 | (vfdiv_resp_valid & vfdiv_resp_ready) | (f1_valid & f1_kill);
assign f1_pipe_en = (f0_valid & f0_op1_ready & f0_op2_ready & vfdiv_req_ready & ~f0_kill);
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        f1_valid <= 1'b0;
    end
    else if (f1_valid_en) begin
        f1_valid <= f1_valid_nx;
    end
end

always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        f1_last <= 1'b0;
        f1_byte_mask <= {CLEN / 8{1'b0}};
        f1_clen_cal_cnt <= 4'b0;
        f1_clen_cal_last <= 1'b0;
    end
    else if (f1_pipe_en) begin
        f1_last <= f0_last;
        f1_byte_mask <= f0_byte_mask;
        f1_clen_cal_cnt <= f0_uop_cnt[3:0];
        f1_clen_cal_last <= f0_clen_cal_last;
    end
end

assign f1_cmt_set = (f0_pipe_to_f1 & f0_cmt) | (f1_valid & ~f1_last & ~f1_cmt & f0_pipe_to_f1 & ~f0_cmt & exs_nxt_cmt & vfdiv_cmt_valid & ~vfdiv_cmt_kill) | (~f1_valid & f0_pipe_to_f1 & ~f0_cmt & exs_nxt_cmt & vfdiv_cmt_valid & ~vfdiv_cmt_kill) | (f1_valid & ~vfdiv_resp_valid & ~f1_cmt & exs_nxt_cmt & vfdiv_cmt_valid & ~vfdiv_cmt_kill & ~f1_kill) | (f1_valid & ~wb_us_ready & ~f1_cmt & exs_nxt_cmt & vfdiv_cmt_valid & ~vfdiv_cmt_kill & ~f1_kill);
assign f1_cmt_clr = f1_kill | (f1_valid & vfdiv_resp_valid & wb_us_ready);
assign f1_cmt_nx = (f1_cmt & ~f1_cmt_clr) | f1_cmt_set;
assign f1_cmt_en = f1_cmt_set | f1_cmt_clr;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        f1_cmt <= 1'b0;
    end
    else if (f1_cmt_en) begin
        f1_cmt <= f1_cmt_nx;
    end
end

integer i;
wire dlen_all_ps_vd_eew64;
wire dlen_all_ps_vd_eew32;
wire dlen_all_ps_vd_eew16;
wire part_dlen_ps_vd_eew64;
wire part_dlen_ps_vd_eew32;
wire part_dlen_ps_vd_eew16;
wire [CBLEN / 4 - 1:0] ps_element_mask_vd_eew32;
wire [CBLEN / 2 - 1:0] ps_element_mask_vd_eew16;
wire dlen_all_tail_vd_eew64;
wire dlen_all_tail_vd_eew32;
wire dlen_all_tail_vd_eew16;
wire part_dlen_tail_vd_eew64;
wire part_dlen_tail_vd_eew32;
wire part_dlen_tail_vd_eew16;
wire [CBLEN / 4 - 1:0] tail_element_mask_vd_eew32;
wire [CBLEN / 2 - 1:0] tail_element_mask_vd_eew16;
wire sew64_vl_high_part_zero = ~(|f0_vl[10:VL_MSB]);
wire sew32_vl_high_part_zero = ~(|f0_vl[10:VL_MSB + 1]);
generate
    if ((VL_MSB + 2) == 10) begin:gen_tail_ctrl_max
        assign dlen_all_tail_vd_eew16 = (f0_uop_cnt[0 +:UOP_NUM] > f0_vl[(MASK_CAL_LSB + 2) +:UOP_NUM]) & ~f0_vl[10];
        assign part_dlen_tail_vd_eew16 = (f0_uop_cnt[0 +:UOP_NUM] == f0_vl[(MASK_CAL_LSB + 2) +:UOP_NUM]) & ~f0_vl[10];
    end
    else begin:gen_tail_ctrl_nmax
        wire sew16_vl_high_part_zero = ~(|f0_vl[10:VL_MSB + 2]);
        assign dlen_all_tail_vd_eew16 = (f0_uop_cnt[0 +:UOP_NUM] > f0_vl[(MASK_CAL_LSB + 2) +:UOP_NUM]) & sew16_vl_high_part_zero;
        assign part_dlen_tail_vd_eew16 = (f0_uop_cnt[0 +:UOP_NUM] == f0_vl[(MASK_CAL_LSB + 2) +:UOP_NUM]) & sew16_vl_high_part_zero;
    end
endgenerate
assign dlen_all_tail_vd_eew64 = (f0_uop_cnt[0 +:UOP_NUM] > f0_vl[MASK_CAL_LSB +:UOP_NUM]) & sew64_vl_high_part_zero;
assign dlen_all_tail_vd_eew32 = (f0_uop_cnt[0 +:UOP_NUM] > f0_vl[(MASK_CAL_LSB + 1) +:UOP_NUM]) & sew32_vl_high_part_zero;
assign part_dlen_tail_vd_eew64 = (f0_uop_cnt[0 +:UOP_NUM] == f0_vl[MASK_CAL_LSB +:UOP_NUM]) & sew64_vl_high_part_zero;
assign part_dlen_tail_vd_eew32 = (f0_uop_cnt[0 +:UOP_NUM] == f0_vl[(MASK_CAL_LSB + 1) +:UOP_NUM]) & sew32_vl_high_part_zero;
assign tail_element_mask_vd_eew32 = part_dlen_tail_vd_eew32 ? (~({CLEN / 32{1'b1}} << f0_vl[MASK_CAL_LSB:0])) : {CLEN / 32{~dlen_all_tail_vd_eew32 & ~part_dlen_tail_vd_eew32}};
assign tail_element_mask_vd_eew16 = part_dlen_tail_vd_eew16 ? (~({CLEN / 16{1'b1}} << f0_vl[MASK_CAL_LSB + 1:0])) : {CLEN / 16{~dlen_all_tail_vd_eew16 & ~part_dlen_tail_vd_eew16}};
generate
    if ((VL_MSB + 2) == 10) begin:gen_ps_ctrl_sew32_max
        assign dlen_all_ps_vd_eew16 = (f0_uop_cnt[0 +:UOP_NUM] < f0_vstart[(MASK_CAL_LSB + 2) +:UOP_NUM]);
        assign part_dlen_ps_vd_eew16 = (f0_uop_cnt[0 +:UOP_NUM] == f0_vstart[(MASK_CAL_LSB + 2) +:UOP_NUM]);
        assign dlen_all_ps_vd_eew32 = (f0_uop_cnt[0 +:UOP_NUM] < f0_vstart[(MASK_CAL_LSB + 1) +:UOP_NUM]) | f0_vstart[9];
        assign part_dlen_ps_vd_eew32 = (f0_uop_cnt[0 +:UOP_NUM] == f0_vstart[(MASK_CAL_LSB + 1) +:UOP_NUM]) & ~f0_vstart[9];
    end
    else if ((VL_MSB + 2) == 9) begin:gen_ps_ctrl_sew32_mid
        assign dlen_all_ps_vd_eew16 = (f0_uop_cnt[0 +:UOP_NUM] < f0_vstart[(MASK_CAL_LSB + 2) +:UOP_NUM]) | f0_vstart[9];
        assign part_dlen_ps_vd_eew16 = (f0_uop_cnt[0 +:UOP_NUM] == f0_vstart[(MASK_CAL_LSB + 2) +:UOP_NUM]) & ~f0_vstart[9];
        assign dlen_all_ps_vd_eew32 = (f0_uop_cnt[0 +:UOP_NUM] < f0_vstart[(MASK_CAL_LSB + 1) +:UOP_NUM]) | (|f0_vstart[9:VL_MSB + 1]);
        assign part_dlen_ps_vd_eew32 = (f0_uop_cnt[0 +:UOP_NUM] == f0_vstart[(MASK_CAL_LSB + 1) +:UOP_NUM]) & (~|f0_vstart[9:VL_MSB + 1]);
    end
    else begin:gen_ps_ctrl_sew32_all
        assign dlen_all_ps_vd_eew16 = (f0_uop_cnt[0 +:UOP_NUM] < f0_vstart[(MASK_CAL_LSB + 2) +:UOP_NUM]) | (|f0_vstart[9:VL_MSB + 2]);
        assign part_dlen_ps_vd_eew16 = (f0_uop_cnt[0 +:UOP_NUM] == f0_vstart[(MASK_CAL_LSB + 2) +:UOP_NUM]) & (~|f0_vstart[9:VL_MSB + 2]);
        assign dlen_all_ps_vd_eew32 = (f0_uop_cnt[0 +:UOP_NUM] < f0_vstart[(MASK_CAL_LSB + 1) +:UOP_NUM]) | (|f0_vstart[9:VL_MSB + 1]);
        assign part_dlen_ps_vd_eew32 = (f0_uop_cnt[0 +:UOP_NUM] == f0_vstart[(MASK_CAL_LSB + 1) +:UOP_NUM]) & (~|f0_vstart[9:VL_MSB + 1]);
    end
endgenerate
assign dlen_all_ps_vd_eew64 = (f0_uop_cnt[0 +:UOP_NUM] < f0_vstart[MASK_CAL_LSB +:UOP_NUM]) | (|f0_vstart[9:VL_MSB]);
assign part_dlen_ps_vd_eew64 = (f0_uop_cnt[0 +:UOP_NUM] == f0_vstart[MASK_CAL_LSB +:UOP_NUM]) & ~(|f0_vstart[9:VL_MSB]);
assign ps_element_mask_vd_eew32 = ({CLEN / 32{part_dlen_ps_vd_eew32}} << f0_vstart[MASK_CAL_LSB:0]) | {CLEN / 32{~dlen_all_ps_vd_eew32 & ~part_dlen_ps_vd_eew32}};
assign ps_element_mask_vd_eew16 = ({CLEN / 16{part_dlen_ps_vd_eew16}} << f0_vstart[MASK_CAL_LSB + 1:0]) | {CLEN / 16{~dlen_all_ps_vd_eew16 & ~part_dlen_ps_vd_eew16}};
generate
    if (CLEN > 128) begin:gen_ex_ps_tail_mask_dlen_gt128
        wire [CBLEN / 8 - 1:0] ps_element_mask_vd_eew64;
        reg [CBLEN - 1:0] ps_byte_mask_vd_eew64;
        reg [CBLEN - 1:0] ps_byte_mask_vd_eew32;
        reg [CBLEN - 1:0] ps_byte_mask_vd_eew16;
        wire [CBLEN / 8 - 1:0] tail_element_mask_vd_eew64;
        reg [CBLEN - 1:0] tail_byte_mask_vd_eew64;
        reg [CBLEN - 1:0] tail_byte_mask_vd_eew32;
        reg [CBLEN - 1:0] tail_byte_mask_vd_eew16;
        assign ps_element_mask_vd_eew64 = ({CLEN / 64{part_dlen_ps_vd_eew64}} << f0_vstart[MASK_CAL_LSB - 1:0]) | {CLEN / 64{~dlen_all_ps_vd_eew64 & ~part_dlen_ps_vd_eew64}};
        assign tail_element_mask_vd_eew64 = part_dlen_tail_vd_eew64 ? (~({CLEN / 64{1'b1}} << f0_vl[MASK_CAL_LSB - 1:0])) : {CLEN / 64{~dlen_all_tail_vd_eew64 & ~part_dlen_tail_vd_eew64}};
        integer i;
        always @* begin
            for (i = 0; i < CLEN / 64; i = i + 1) begin
                ps_byte_mask_vd_eew64[i * 8 +:8] = {8{ps_element_mask_vd_eew64[i]}};
                tail_byte_mask_vd_eew64[i * 8 +:8] = {8{tail_element_mask_vd_eew64[i]}};
            end
            for (i = 0; i < CLEN / 32; i = i + 1) begin
                ps_byte_mask_vd_eew32[i * 4 +:4] = {4{ps_element_mask_vd_eew32[i]}};
                tail_byte_mask_vd_eew32[i * 4 +:4] = {4{tail_element_mask_vd_eew32[i]}};
            end
            for (i = 0; i < CLEN / 16; i = i + 1) begin
                ps_byte_mask_vd_eew16[i * 2 +:2] = {2{ps_element_mask_vd_eew16[i]}};
                tail_byte_mask_vd_eew16[i * 2 +:2] = {2{tail_element_mask_vd_eew16[i]}};
            end
        end

        assign f0_ps_mask = (ps_byte_mask_vd_eew64 & {CBLEN{f0_sew[3]}}) | (ps_byte_mask_vd_eew32 & {CBLEN{f0_sew[2]}}) | (ps_byte_mask_vd_eew16 & {CBLEN{f0_sew[1]}});
        assign f0_tail_mask = (tail_byte_mask_vd_eew64 & {CBLEN{f0_sew[3]}}) | (tail_byte_mask_vd_eew32 & {CBLEN{f0_sew[2]}}) | (tail_byte_mask_vd_eew16 & {CBLEN{f0_sew[1]}});
    end
    else if (CLEN == 128) begin:gen_ex_ps_mask_dlen128
        wire [CBLEN / 8 - 1:0] ps_element_mask_vd_eew64;
        reg [CBLEN - 1:0] ps_byte_mask_vd_eew64;
        reg [CBLEN - 1:0] ps_byte_mask_vd_eew32;
        reg [CBLEN - 1:0] ps_byte_mask_vd_eew16;
        wire [CBLEN / 8 - 1:0] tail_element_mask_vd_eew64;
        reg [CBLEN - 1:0] tail_byte_mask_vd_eew64;
        reg [CBLEN - 1:0] tail_byte_mask_vd_eew32;
        reg [CBLEN - 1:0] tail_byte_mask_vd_eew16;
        integer i;
        assign ps_element_mask_vd_eew64 = ({CLEN / 64{part_dlen_ps_vd_eew64}} << f0_vstart[0]) | {CLEN / 64{~dlen_all_ps_vd_eew64 & ~part_dlen_ps_vd_eew64}};
        assign tail_element_mask_vd_eew64 = part_dlen_tail_vd_eew64 ? (~({CLEN / 64{1'b1}} << f0_vl[0])) : {CLEN / 64{~dlen_all_tail_vd_eew64 & ~part_dlen_tail_vd_eew64}};
        always @* begin
            for (i = 0; i < CLEN / 64; i = i + 1) begin
                ps_byte_mask_vd_eew64[i * 8 +:8] = {8{ps_element_mask_vd_eew64[i]}};
                tail_byte_mask_vd_eew64[i * 8 +:8] = {8{tail_element_mask_vd_eew64[i]}};
            end
            for (i = 0; i < CLEN / 32; i = i + 1) begin
                ps_byte_mask_vd_eew32[i * 4 +:4] = {4{ps_element_mask_vd_eew32[i]}};
                tail_byte_mask_vd_eew32[i * 4 +:4] = {4{tail_element_mask_vd_eew32[i]}};
            end
            for (i = 0; i < CLEN / 16; i = i + 1) begin
                ps_byte_mask_vd_eew16[i * 2 +:2] = {2{ps_element_mask_vd_eew16[i]}};
                tail_byte_mask_vd_eew16[i * 2 +:2] = {2{tail_element_mask_vd_eew16[i]}};
            end
        end

        assign f0_ps_mask = (ps_byte_mask_vd_eew64 & {CBLEN{f0_sew[3]}}) | (ps_byte_mask_vd_eew32 & {CBLEN{f0_sew[2]}}) | (ps_byte_mask_vd_eew16 & {CBLEN{f0_sew[1]}});
        assign f0_tail_mask = (tail_byte_mask_vd_eew64 & {CBLEN{f0_sew[3]}}) | (tail_byte_mask_vd_eew32 & {CBLEN{f0_sew[2]}}) | (tail_byte_mask_vd_eew16 & {CBLEN{f0_sew[1]}});
    end
    else begin:gen_ex_ps_mask_dlen64
        wire ps_element_mask_vd_eew64;
        reg [CBLEN - 1:0] ps_byte_mask_vd_eew64;
        reg [CBLEN - 1:0] ps_byte_mask_vd_eew32;
        reg [CBLEN - 1:0] ps_byte_mask_vd_eew16;
        wire tail_element_mask_vd_eew64;
        reg [CBLEN - 1:0] tail_byte_mask_vd_eew64;
        reg [CBLEN - 1:0] tail_byte_mask_vd_eew32;
        reg [CBLEN - 1:0] tail_byte_mask_vd_eew16;
        integer i;
        wire nds_unused_wire = |part_dlen_ps_vd_eew64;
        assign ps_element_mask_vd_eew64 = ~dlen_all_ps_vd_eew64;
        assign tail_element_mask_vd_eew64 = ~dlen_all_tail_vd_eew64 & ~part_dlen_tail_vd_eew64;
        always @* begin
            ps_byte_mask_vd_eew64[7:0] = {8{ps_element_mask_vd_eew64}};
            tail_byte_mask_vd_eew64[7:0] = {8{tail_element_mask_vd_eew64}};
            for (i = 0; i < CLEN / 32; i = i + 1) begin
                ps_byte_mask_vd_eew32[i * 4 +:4] = {4{ps_element_mask_vd_eew32[i]}};
                tail_byte_mask_vd_eew32[i * 4 +:4] = {4{tail_element_mask_vd_eew32[i]}};
            end
            for (i = 0; i < CLEN / 16; i = i + 1) begin
                ps_byte_mask_vd_eew16[i * 2 +:2] = {2{ps_element_mask_vd_eew16[i]}};
                tail_byte_mask_vd_eew16[i * 2 +:2] = {2{tail_element_mask_vd_eew16[i]}};
            end
        end

        assign f0_ps_mask = (ps_byte_mask_vd_eew64 & {CBLEN{f0_sew[3]}}) | (ps_byte_mask_vd_eew32 & {CBLEN{f0_sew[2]}}) | (ps_byte_mask_vd_eew16 & {CBLEN{f0_sew[1]}});
        assign f0_tail_mask = (tail_byte_mask_vd_eew64 & {CBLEN{f0_sew[3]}}) | (tail_byte_mask_vd_eew32 & {CBLEN{f0_sew[2]}}) | (tail_byte_mask_vd_eew16 & {CBLEN{f0_sew[1]}});
    end
endgenerate
assign f0_v0t_byte_mask = (veq_ex_byte_mask[CBLEN - 1:0] | {CBLEN{f0_no_mask}});
assign f0_byte_mask = f0_v0t_byte_mask & f0_tail_mask & f0_ps_mask;
assign wb_us_flag = vfdiv_resp_flag_set;
assign wb_us_flag_clr = (f1_valid & f1_kill) | (~f1_valid & f0_valid & f0_kill);
assign wb_us_flag_update = f1_valid & vfdiv_resp_valid & wb_us_ready;
generate
    if (CLEN == DLEN) begin:gen_wb_ctrl_clen_eq_dlen
        assign wb_us_wdata = vfdiv_resp_wdata;
        assign wb_us_bit_wen = {DLEN{wb_us_valid}};
        assign wb_us_mask_wdata = f1_byte_mask & {DBLEN{vfdiv_resp_valid}};
    end
    else if (DLEN / CLEN == 2) begin:gen_wb_ctrl_dlen_clen_2_1
        assign wb_us_wdata = ({DLEN{~f1_clen_cal_cnt[0]}} & {{CLEN{1'b0}},vfdiv_resp_wdata}) | ({DLEN{f1_clen_cal_cnt[0]}} & {vfdiv_resp_wdata,{CLEN{1'b0}}});
        assign wb_us_bit_wen = ({DLEN{~f1_clen_cal_cnt[0]}} & {{CLEN{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}}}) | ({DLEN{f1_clen_cal_cnt[0]}} & {{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN{1'b0}}});
        assign wb_us_mask_wdata = ({DBLEN{~f1_clen_cal_cnt[0] & vfdiv_resp_valid}} & {{CBLEN{1'b0}},f1_byte_mask}) | ({DBLEN{f1_clen_cal_cnt[0] & vfdiv_resp_valid}} & {f1_byte_mask,{CBLEN{1'b0}}});
    end
    else if (DLEN / CLEN == 4) begin:gen_wb_ctrl_dlen_clen_4_1
        assign wb_us_wdata = ({DLEN{f1_clen_cal_cnt[1:0] == 2'b00}} & {{CLEN * 3{1'b0}},vfdiv_resp_wdata}) | ({DLEN{f1_clen_cal_cnt[1:0] == 2'b01}} & {{CLEN * 2{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[1:0] == 2'b10}} & {{CLEN * 1{1'b0}},vfdiv_resp_wdata,{CLEN * 2{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[1:0] == 2'b11}} & {vfdiv_resp_wdata,{CLEN * 3{1'b0}}});
        assign wb_us_bit_wen = ({DLEN{f1_clen_cal_cnt[1:0] == 2'b00}} & {{CLEN * 3{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}}}) | ({DLEN{f1_clen_cal_cnt[1:0] == 2'b01}} & {{CLEN * 2{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[1:0] == 2'b10}} & {{CLEN * 1{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 2{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[1:0] == 2'b11}} & {{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 3{1'b0}}});
        assign wb_us_mask_wdata = ({DBLEN{(f1_clen_cal_cnt[1:0] == 2'b00) & vfdiv_resp_valid}} & {{CBLEN * 3{1'b0}},f1_byte_mask}) | ({DBLEN{(f1_clen_cal_cnt[1:0] == 2'b01) & vfdiv_resp_valid}} & {{CBLEN * 2{1'b0}},f1_byte_mask,{CBLEN * 1{1'b0}}}) | ({DBLEN{(f1_clen_cal_cnt[1:0] == 2'b10) & vfdiv_resp_valid}} & {{CBLEN * 1{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{(f1_clen_cal_cnt[1:0] == 2'b11) & vfdiv_resp_valid}} & {f1_byte_mask,{CBLEN * 3{1'b0}}});
    end
    else if (DLEN / CLEN == 8) begin:gen_wb_ctrl_dlen_clen_8_1
        assign wb_us_wdata = ({DLEN{f1_clen_cal_cnt[2:0] == 3'd0}} & {{CLEN * 7{1'b0}},vfdiv_resp_wdata}) | ({DLEN{f1_clen_cal_cnt[2:0] == 3'd1}} & {{CLEN * 6{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[2:0] == 3'd2}} & {{CLEN * 5{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[2:0] == 3'd3}} & {{CLEN * 4{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[2:0] == 3'd4}} & {{CLEN * 3{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[2:0] == 3'd5}} & {{CLEN * 3{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[2:0] == 3'd6}} & {{CLEN * 1{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[2:0] == 3'd7}} & {vfdiv_resp_wdata,{CLEN * 7{1'b0}}});
        assign wb_us_bit_wen = ({DLEN{f1_clen_cal_cnt[2:0] == 3'd0}} & {{CLEN * 7{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}}}) | ({DLEN{f1_clen_cal_cnt[2:0] == 3'd1}} & {{CLEN * 6{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[2:0] == 3'd2}} & {{CLEN * 5{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 2{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[2:0] == 3'd3}} & {{CLEN * 4{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 3{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[2:0] == 3'd4}} & {{CLEN * 3{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 4{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[2:0] == 3'd5}} & {{CLEN * 2{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 5{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[2:0] == 3'd6}} & {{CLEN * 1{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 6{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[2:0] == 3'd7}} & {{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 7{1'b0}}});
        assign wb_us_mask_wdata = ({DBLEN{f1_clen_cal_cnt[2:0] == 3'd0}} & {{CBLEN * 7{1'b0}},f1_byte_mask}) | ({DBLEN{f1_clen_cal_cnt[2:0] == 3'd1}} & {{CBLEN * 6{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[2:0] == 3'd2}} & {{CBLEN * 5{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[2:0] == 3'd3}} & {{CBLEN * 4{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[2:0] == 3'd4}} & {{CBLEN * 3{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[2:0] == 3'd5}} & {{CBLEN * 2{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[2:0] == 3'd6}} & {{CBLEN * 1{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[2:0] == 3'd7}} & {f1_byte_mask,{CBLEN * 7{1'b0}}});
    end
    else if (DLEN / CLEN == 16) begin:gen_wb_ctrl_dlen_clen_16_1
        assign wb_us_wdata = ({DLEN{f1_clen_cal_cnt[3:0] == 4'h0}} & {{CLEN * 15{1'b0}},vfdiv_resp_wdata}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h1}} & {{CLEN * 14{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h2}} & {{CLEN * 13{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h3}} & {{CLEN * 12{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h4}} & {{CLEN * 11{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h5}} & {{CLEN * 10{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h6}} & {{CLEN * 9{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h7}} & {{CLEN * 8{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h8}} & {{CLEN * 7{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h9}} & {{CLEN * 6{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'ha}} & {{CLEN * 5{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'hb}} & {{CLEN * 4{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'hc}} & {{CLEN * 3{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'hd}} & {{CLEN * 2{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'he}} & {{CLEN * 1{1'b0}},vfdiv_resp_wdata,{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h7}} & {vfdiv_resp_wdata,{CLEN * 15{1'b0}}});
        assign wb_us_bit_wen = ({DLEN{f1_clen_cal_cnt[3:0] == 4'h0}} & {{CLEN * 15{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h1}} & {{CLEN * 14{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h2}} & {{CLEN * 13{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h3}} & {{CLEN * 12{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h4}} & {{CLEN * 11{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h5}} & {{CLEN * 10{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h6}} & {{CLEN * 9{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h7}} & {{CLEN * 8{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h8}} & {{CLEN * 7{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h9}} & {{CLEN * 6{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'ha}} & {{CLEN * 5{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'hb}} & {{CLEN * 4{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'hc}} & {{CLEN * 3{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'hd}} & {{CLEN * 2{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'he}} & {{CLEN * 1{1'b0}},{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 1{1'b0}}}) | ({DLEN{f1_clen_cal_cnt[3:0] == 4'h7}} & {{CLEN{vfdiv_resp_valid & wb_us_ready}},{CLEN * 15{1'b0}}});
        assign wb_us_mask_wdata = ({DBLEN{f1_clen_cal_cnt[3:0] == 4'h0}} & {{CBLEN * 15{1'b0}},f1_byte_mask}) | ({DBLEN{f1_clen_cal_cnt[3:0] == 4'h1}} & {{CBLEN * 14{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[3:0] == 4'h2}} & {{CBLEN * 13{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[3:0] == 4'h3}} & {{CBLEN * 12{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[3:0] == 4'h4}} & {{CBLEN * 11{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[3:0] == 4'h5}} & {{CBLEN * 10{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[3:0] == 4'h6}} & {{CBLEN * 9{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[3:0] == 4'h7}} & {{CBLEN * 8{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[3:0] == 4'h8}} & {{CBLEN * 7{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[3:0] == 4'h9}} & {{CBLEN * 6{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[3:0] == 4'ha}} & {{CBLEN * 5{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[3:0] == 4'hb}} & {{CBLEN * 4{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[3:0] == 4'hc}} & {{CBLEN * 3{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[3:0] == 4'hd}} & {{CBLEN * 2{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[3:0] == 4'he}} & {{CBLEN * 1{1'b0}},f1_byte_mask,{CBLEN * 2{1'b0}}}) | ({DBLEN{f1_clen_cal_cnt[3:0] == 4'hf}} & {f1_byte_mask,{CBLEN * 15{1'b0}}});
    end
endgenerate
assign wb_us_valid = f1_valid & vfdiv_resp_valid & f1_clen_cal_last;
assign wb_us_cmtted = f1_cmt;
assign wb_us_last = f1_last;
assign vfdiv_standby_ready = ~veq_ex_valid & ~f0_valid & ~f1_valid & wb_standby;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

