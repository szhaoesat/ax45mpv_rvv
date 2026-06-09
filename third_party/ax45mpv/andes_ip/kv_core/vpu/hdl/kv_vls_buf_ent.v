// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_buf_ent (
    vpu_vlsu_clk,
    vpu_reset_n,
    buf_claim_valid,
    buf_claim_cnt,
    buf_kill_valid,
    buf_return_valid,
    buf_deq_valid,
    buf_occupied_set,
    buf_occupied_clr,
    buf_vs3_wvalid,
    buf_vs3_wdata,
    buf_vd_wvalid,
    buf_vd_wdata,
    buf_vd_bwe,
    buf_vd_ualign_wvalid,
    buf_vd_ualign_wdata,
    buf_vd_ualign_bwe,
    buf_vd_element_bwe_wvalid,
    buf_vd_element_bwe,
    buf_vd_seg_wvalid,
    buf_vd_seg_wdata,
    buf_vd_seg_bwe,
    buf_useg_wvalid,
    buf_useg_wdata,
    buf_byte_mask_wvalid,
    buf_byte_mask,
    buf_shift_valid,
    buf_shift_eew_onehot,
    buf_qout_done,
    buf_qout_pending,
    buf_qout_occupied,
    buf_qout_rdata,
    buf_qout_mask_ready,
    buf_qout_mask_ready_nx,
    buf_qout_byte_mask,
    buf_qout_return_last
);
parameter DLEN = 512;
parameter DMLEN = DLEN / 8;
parameter BUF_UCNT_WIDTH = 2;
localparam BUF_FSM_BITS = 3;
localparam BUF_FSM_INIT = 0;
localparam BUF_FSM_CLAIMED = 1;
localparam BUF_FSM_DONE = 2;
input vpu_vlsu_clk;
input vpu_reset_n;
input buf_claim_valid;
input [BUF_UCNT_WIDTH - 1:0] buf_claim_cnt;
input buf_kill_valid;
input buf_return_valid;
input buf_deq_valid;
input buf_occupied_set;
input buf_occupied_clr;
input buf_vs3_wvalid;
input [DLEN - 1:0] buf_vs3_wdata;
input buf_vd_wvalid;
input [DLEN - 1:0] buf_vd_wdata;
input [DMLEN - 1:0] buf_vd_bwe;
input buf_vd_ualign_wvalid;
input [DLEN - 1:0] buf_vd_ualign_wdata;
input [DMLEN - 1:0] buf_vd_ualign_bwe;
input buf_vd_element_bwe_wvalid;
input [DMLEN - 1:0] buf_vd_element_bwe;
input buf_vd_seg_wvalid;
input [DLEN - 1:0] buf_vd_seg_wdata;
input [DMLEN - 1:0] buf_vd_seg_bwe;
input buf_useg_wvalid;
input [DLEN - 1:0] buf_useg_wdata;
input buf_byte_mask_wvalid;
input [DMLEN - 1:0] buf_byte_mask;
input buf_shift_valid;
input [3:0] buf_shift_eew_onehot;
output buf_qout_done;
output buf_qout_pending;
output buf_qout_occupied;
output [DLEN - 1:0] buf_qout_rdata;
output buf_qout_mask_ready;
output buf_qout_mask_ready_nx;
output [DMLEN - 1:0] buf_qout_byte_mask;
output buf_qout_return_last;





// 02ee2abf rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg buf_fsm_en;
reg [BUF_FSM_BITS - 1:0] buf_fsm_nx;
reg [BUF_FSM_BITS - 1:0] buf_fsm;
wire buf_valid;
wire buf_occupied_en;
wire buf_occupied_nx;
reg buf_occupied;
wire [DLEN - 1:0] buf_wdata;
wire [DLEN - 1:0] buf_vd_wdata_or;
wire [DMLEN - 1:0] buf_bwe;
wire buf_mask_ready_set;
wire buf_mask_ready_clr;
wire buf_mask_ready_en;
wire buf_mask_ready_nx;
reg buf_mask_ready;
wire [DMLEN - 1:0] buf_byte_mask_nx;
reg [DMLEN - 1:0] buf_qout_byte_mask;
wire [DMLEN - 1:0] buf_element_byte_mask_nx;
wire buf_eew8;
wire buf_eew16;
wire buf_eew32;
wire buf_eew64;
wire [DLEN - 1:0] buf_shift_wdata_eew8;
wire [DLEN - 1:0] buf_shift_wdata_eew16;
wire [DLEN - 1:0] buf_shift_wdata_eew32;
wire [DLEN - 1:0] buf_shift_wdata_eew64;
wire [DLEN - 1:0] buf_shift_wdata;
wire buf_retire_valid;
wire buf_ucnt_en;
wire [BUF_UCNT_WIDTH - 1:0] buf_ucnt_nx;
wire [BUF_UCNT_WIDTH - 1:0] buf_ucnt_minus1;
reg [BUF_UCNT_WIDTH - 1:0] buf_ucnt;
kv_dff_bwe #(
    .BYTES(DMLEN)
) u_vlsbuf_data (
    .clk(vpu_vlsu_clk),
    .bwe(buf_bwe),
    .d(buf_wdata),
    .q(buf_qout_rdata)
);
assign buf_qout_done = buf_fsm[BUF_FSM_DONE];
assign buf_qout_pending = buf_valid;
assign buf_valid = ~buf_fsm[BUF_FSM_INIT];
always @* begin
    buf_fsm_nx = {BUF_FSM_BITS{1'b0}};
    case (1'b1)
        buf_fsm[BUF_FSM_INIT]: begin
            buf_fsm_en = buf_claim_valid;
            buf_fsm_nx[BUF_FSM_CLAIMED] = 1'b1;
        end
        buf_fsm[BUF_FSM_CLAIMED]: begin
            buf_fsm_en = buf_kill_valid | buf_retire_valid;
            buf_fsm_nx[BUF_FSM_DONE] = 1'b1;
        end
        buf_fsm[BUF_FSM_DONE]: begin
            buf_fsm_en = buf_deq_valid;
            buf_fsm_nx[BUF_FSM_INIT] = 1'b1;
        end
        default: begin
            buf_fsm_en = 1'b0;
            buf_fsm_nx = {BUF_FSM_BITS{1'b0}};
        end
    endcase
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        buf_fsm <= {{BUF_FSM_BITS - 1{1'b0}},1'b1};
    end
    else if (buf_fsm_en) begin
        buf_fsm <= buf_fsm_nx;
    end
end

assign buf_qout_return_last = buf_ucnt == {BUF_UCNT_WIDTH{1'b0}};
assign buf_retire_valid = buf_return_valid & buf_qout_return_last;
assign buf_ucnt_en = buf_claim_valid | buf_return_valid | buf_kill_valid;
assign buf_ucnt_minus1 = buf_ucnt - {{BUF_UCNT_WIDTH - 1{1'b0}},1'b1};
assign buf_ucnt_nx = buf_claim_valid ? buf_claim_cnt : (buf_kill_valid | buf_retire_valid) ? {BUF_UCNT_WIDTH{1'b0}} : buf_ucnt_minus1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        buf_ucnt <= {BUF_UCNT_WIDTH{1'b0}};
    end
    else if (buf_ucnt_en) begin
        buf_ucnt <= buf_ucnt_nx;
    end
end

genvar i;
generate
    for (i = 0; i < DMLEN; i = i + 1) begin:gen_vd_wdata_combine
        assign buf_vd_wdata_or[(i * 8) +:8] = ({8{buf_vd_wvalid & buf_vd_bwe[i]}} & buf_vd_wdata[(i * 8) +:8]) | ({8{buf_vd_ualign_wvalid & buf_vd_ualign_bwe[i]}} & buf_vd_ualign_wdata[(i * 8) +:8]);
    end
endgenerate
assign buf_wdata = buf_vd_wdata_or | ({DLEN{buf_vd_seg_wvalid}} & buf_vd_seg_wdata) | ({DLEN{buf_vs3_wvalid}} & buf_vs3_wdata) | ({DLEN{buf_shift_valid}} & buf_shift_wdata) | ({DLEN{buf_useg_wvalid}} & buf_useg_wdata);
assign buf_bwe = ({DMLEN{buf_vd_wvalid}} & buf_vd_bwe) | ({DMLEN{buf_vd_ualign_wvalid}} & buf_vd_ualign_bwe) | ({DMLEN{buf_vd_seg_wvalid}} & buf_vd_seg_bwe) | {DMLEN{buf_shift_valid | buf_useg_wvalid | buf_vs3_wvalid}};
assign buf_qout_occupied = buf_occupied;
assign buf_occupied_en = buf_occupied_set | buf_occupied_clr;
assign buf_occupied_nx = buf_occupied_set;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        buf_occupied <= 1'b0;
    end
    else if (buf_occupied_en) begin
        buf_occupied <= buf_occupied_nx;
    end
end

assign buf_qout_mask_ready = buf_mask_ready;
assign buf_qout_mask_ready_nx = buf_mask_ready_set;
assign buf_mask_ready_set = buf_byte_mask_wvalid | buf_vd_element_bwe_wvalid;
assign buf_mask_ready_clr = buf_occupied_clr;
assign buf_mask_ready_en = buf_mask_ready_set | buf_mask_ready_clr;
assign buf_mask_ready_nx = buf_mask_ready_set;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        buf_mask_ready <= 1'b0;
    end
    else if (buf_mask_ready_en) begin
        buf_mask_ready <= buf_mask_ready_nx;
    end
end

assign buf_byte_mask_nx = buf_mask_ready_clr ? {DMLEN{1'b0}} : buf_byte_mask_wvalid ? buf_byte_mask : buf_element_byte_mask_nx;
assign buf_element_byte_mask_nx = buf_qout_byte_mask | buf_vd_element_bwe;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        buf_qout_byte_mask <= {DMLEN{1'b0}};
    end
    else if (buf_mask_ready_en) begin
        buf_qout_byte_mask <= buf_byte_mask_nx;
    end
end

assign buf_eew8 = buf_shift_eew_onehot[0];
assign buf_eew16 = buf_shift_eew_onehot[1];
assign buf_eew32 = buf_shift_eew_onehot[2];
assign buf_eew64 = buf_shift_eew_onehot[3];
assign buf_shift_wdata_eew8 = {8'b0,buf_qout_rdata[DLEN - 1:8]};
assign buf_shift_wdata_eew16 = {16'b0,buf_qout_rdata[DLEN - 1:16]};
assign buf_shift_wdata_eew32 = {32'b0,buf_qout_rdata[DLEN - 1:32]};
assign buf_shift_wdata_eew64 = {64'b0,buf_qout_rdata[DLEN - 1:64]};
assign buf_shift_wdata = ({DLEN{buf_eew8}} & buf_shift_wdata_eew8) | ({DLEN{buf_eew16}} & buf_shift_wdata_eew16) | ({DLEN{buf_eew32}} & buf_shift_wdata_eew32) | ({DLEN{buf_eew64}} & buf_shift_wdata_eew64);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

