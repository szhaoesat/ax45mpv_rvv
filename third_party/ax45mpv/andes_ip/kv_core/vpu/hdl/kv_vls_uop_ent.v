// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_uop_ent (
    vpu_vlsu_clk,
    vpu_reset_n,
    uop_enq_valid,
    uop_deq_valid,
    uop_cmt_valid,
    uop_cmt_kill,
    uop_cmt_start_buf_num,
    uop_enq_pa,
    uop_enq_base_offset,
    uop_enq_vstart_byte,
    uop_enq_prestart_cross,
    uop_enq_ctrl,
    uop_enq_first,
    uop_enq_last,
    uop_enq_ele_dlen_last,
    uop_enq_vd_emul_len,
    uop_enq_vd_beats,
    uop_enq_vd_seg_beats,
    uop_enq_cross_4k,
    uop_enq_cross_4k_d1,
    uop_enq_cross_4k_d1_kill,
    uop_enq_alive,
    uop_enq_byte,
    uop_enq_total_byte,
    uop_enq_element_num_dlen,
    uop_req_grant_valid,
    uop_req_prestart_done,
    uop_pa_cross_nx,
    uop_remain_byte_nx,
    uop_remain_vstart_byte_nx,
    uop_alive_byte_update,
    uop_qout_ready,
    uop_qout_valid,
    uop_qout_cmt_ready,
    uop_qout_pa,
    uop_qout_ctrl,
    uop_qout_first,
    uop_qout_last,
    uop_qout_ele_dlen_last,
    uop_qout_vd_emul_len,
    uop_qout_vd_beats,
    uop_qout_vd_seg_beats,
    uop_qout_load,
    uop_qout_store,
    uop_qout_block_cmd,
    uop_qout_byte,
    uop_qout_alive_byte,
    uop_qout_total_byte,
    uop_qout_start_buf_num,
    uop_qout_element_num_dlen,
    uop_qout_vstart_byte,
    uop_qout_killed,
    uop_qout_claim_buf_valid,
    uop_qout_alive
);
parameter DLEN = 512;
parameter PALEN = 38;
parameter VRF_LW = 3;
parameter BUF_DEPTH_LOG2 = 3;
parameter MAX_BYTE_WIDTH = 10;
parameter ELE_CNT_WIDTH = 4;
parameter ELE_DLEN_WIDTH = $clog2(DLEN / 8);
parameter HR_OFFSET_WIDTH = 6;
parameter BIU_OFFSET_WIDTH = 6;
parameter HVM_OFFSET_WIDTH = 6;
localparam UOP_FSM_BITS = 4;
localparam UOP_FSM_INVALID = 0;
localparam UOP_FSM_VALID = 1;
localparam UOP_FSM_CMT = 2;
localparam UOP_FSM_KILL = 3;
input vpu_vlsu_clk;
input vpu_reset_n;
input uop_enq_valid;
input uop_deq_valid;
input uop_cmt_valid;
input uop_cmt_kill;
input [BUF_DEPTH_LOG2 - 1:0] uop_cmt_start_buf_num;
input [PALEN - 1:0] uop_enq_pa;
input [11:0] uop_enq_base_offset;
input [MAX_BYTE_WIDTH - 1:0] uop_enq_vstart_byte;
input uop_enq_prestart_cross;
input [25 - 1:0] uop_enq_ctrl;
input uop_enq_first;
input uop_enq_last;
input uop_enq_ele_dlen_last;
input [VRF_LW - 1:0] uop_enq_vd_emul_len;
input [VRF_LW - 1:0] uop_enq_vd_beats;
input [VRF_LW - 1:0] uop_enq_vd_seg_beats;
input uop_enq_cross_4k;
input uop_enq_cross_4k_d1;
input uop_enq_cross_4k_d1_kill;
input uop_enq_alive;
input [MAX_BYTE_WIDTH - 1:0] uop_enq_byte;
input [MAX_BYTE_WIDTH - 1:0] uop_enq_total_byte;
input [ELE_DLEN_WIDTH - 1:0] uop_enq_element_num_dlen;
input uop_req_grant_valid;
input uop_req_prestart_done;
input [PALEN - 1:0] uop_pa_cross_nx;
input [MAX_BYTE_WIDTH - 1:0] uop_remain_byte_nx;
input [MAX_BYTE_WIDTH - 1:0] uop_remain_vstart_byte_nx;
input [MAX_BYTE_WIDTH - 1:0] uop_alive_byte_update;
output uop_qout_ready;
output uop_qout_valid;
output uop_qout_cmt_ready;
output [PALEN - 1:0] uop_qout_pa;
output [25 - 1:0] uop_qout_ctrl;
output uop_qout_first;
output uop_qout_last;
output uop_qout_ele_dlen_last;
output [VRF_LW - 1:0] uop_qout_vd_emul_len;
output [VRF_LW - 1:0] uop_qout_vd_beats;
output [VRF_LW - 1:0] uop_qout_vd_seg_beats;
output uop_qout_load;
output uop_qout_store;
output uop_qout_block_cmd;
output [MAX_BYTE_WIDTH - 1:0] uop_qout_byte;
output [MAX_BYTE_WIDTH - 1:0] uop_qout_alive_byte;
output [MAX_BYTE_WIDTH - 1:0] uop_qout_total_byte;
output [BUF_DEPTH_LOG2 - 1:0] uop_qout_start_buf_num;
output [ELE_DLEN_WIDTH - 1:0] uop_qout_element_num_dlen;
output [MAX_BYTE_WIDTH - 1:0] uop_qout_vstart_byte;
output uop_qout_killed;
output uop_qout_claim_buf_valid;
output uop_qout_alive;





// 7d023fab rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire uop_occupied;
reg uop_fsm_en;
reg [UOP_FSM_BITS - 1:0] uop_fsm;
reg [UOP_FSM_BITS - 1:0] uop_fsm_nx;
wire uop_enq_first_valid;
wire uop_enq_second_valid;
wire uop_pa_en;
wire [PALEN - 1:0] uop_pa_nx;
wire uop_enq_ustride_first;
wire [PALEN - 1:12] uop_enq_pa_prestart;
wire [PALEN - 1:12] uop_enq_pa_4k_sel;
wire [PALEN - 1:0] uop_enq_pa_base;
wire [PALEN - 1:0] uop_enq_pa_sel;
wire uop_eseg_pa_4k_en;
wire [PALEN - 1:0] uop_eseg_pa_cross_4k;
wire uop_byte_en;
wire [MAX_BYTE_WIDTH - 1:0] uop_byte_nx;
wire uop_alive_byte_en;
wire [MAX_BYTE_WIDTH - 1:0] uop_alive_byte_nx;
wire uop_alive_byte_zero;
wire uop_vstart_byte_en;
wire [MAX_BYTE_WIDTH - 1:0] uop_vstart_byte_nx;
reg [MAX_BYTE_WIDTH - 1:0] uop_vstart_byte;
reg [PALEN - 1:0] uop_pa;
reg [25 - 1:0] uop_ctrl;
reg uop_first;
reg uop_last;
reg uop_ele_dlen_last;
reg [VRF_LW - 1:0] uop_vd_emul_len;
reg [VRF_LW - 1:0] uop_vd_beats;
reg [VRF_LW - 1:0] uop_vd_seg_beats;
reg [MAX_BYTE_WIDTH - 1:0] uop_byte;
reg [MAX_BYTE_WIDTH - 1:0] uop_alive_byte;
reg [MAX_BYTE_WIDTH - 1:0] uop_total_byte;
reg [BUF_DEPTH_LOG2 - 1:0] uop_start_buf_num;
wire [BUF_DEPTH_LOG2 - 1:0] uop_start_buf_num_nx;
reg [ELE_DLEN_WIDTH - 1:0] uop_element_num_dlen;
wire uop_start_buf_num_en;
wire uop_enq_ustride;
wire uop_enq_element;
wire uop_enq_seg;
wire uop_enq_eseg;
wire uop_enq_eseg_coss_4k;
wire uop_first_alive_en;
wire uop_first_alive_nx;
reg uop_first_alive;
wire uop_second_alive_en;
wire uop_second_alive_nx;
reg uop_second_alive;
wire uop_eseg;
wire uop_eseg_wait_second_set;
wire uop_eseg_wait_second_clr;
wire uop_eseg_wait_second_en;
wire uop_eseg_wait_second_nx;
reg uop_eseg_wait_second;
wire uop_second_ppn_en;
wire [PALEN - 1:12] uop_second_ppn_nx;
reg [PALEN - 1:12] uop_second_ppn;
assign uop_eseg = uop_ctrl[14] & ~uop_ctrl[19];
assign uop_occupied = ~uop_fsm[UOP_FSM_INVALID];
assign uop_qout_ready = uop_fsm[UOP_FSM_INVALID] | (uop_fsm[UOP_FSM_VALID] & uop_eseg_wait_second);
assign uop_qout_cmt_ready = uop_fsm[UOP_FSM_VALID] & ~uop_eseg_wait_second;
assign uop_qout_valid = uop_fsm[UOP_FSM_CMT] & ~uop_eseg_wait_second;
assign uop_qout_killed = uop_fsm[UOP_FSM_KILL];
assign uop_qout_claim_buf_valid = 1'b0;
assign uop_qout_pa = uop_pa;
assign uop_qout_ctrl = uop_ctrl;
assign uop_qout_first = uop_first;
assign uop_qout_last = uop_last;
assign uop_qout_ele_dlen_last = uop_ele_dlen_last;
assign uop_qout_vd_emul_len = uop_vd_emul_len;
assign uop_qout_vd_beats = uop_vd_beats;
assign uop_qout_vd_seg_beats = uop_vd_seg_beats;
assign uop_qout_load = uop_occupied & uop_qout_ctrl[4];
assign uop_qout_store = uop_occupied & uop_qout_ctrl[17];
assign uop_qout_block_cmd = uop_occupied & (uop_qout_ctrl[18] | uop_qout_ctrl[3]);
assign uop_qout_byte = uop_byte;
assign uop_qout_alive_byte = uop_alive_byte;
assign uop_qout_total_byte = uop_total_byte;
assign uop_qout_start_buf_num = uop_start_buf_num;
assign uop_qout_element_num_dlen = uop_element_num_dlen;
assign uop_qout_vstart_byte = uop_vstart_byte;
assign uop_enq_ustride = uop_enq_ctrl[19];
assign uop_enq_element = ~uop_enq_ctrl[19];
assign uop_enq_seg = uop_enq_ctrl[14];
assign uop_enq_eseg = uop_enq_seg & uop_enq_element;
assign uop_enq_eseg_coss_4k = uop_enq_eseg & uop_enq_cross_4k;
assign uop_eseg_wait_second_set = (uop_enq_valid & uop_enq_eseg_coss_4k);
assign uop_eseg_wait_second_clr = (uop_enq_valid & uop_enq_eseg & ~uop_enq_cross_4k) | uop_enq_cross_4k_d1_kill | uop_deq_valid;
assign uop_eseg_wait_second_en = uop_eseg_wait_second_set | uop_eseg_wait_second_clr;
assign uop_eseg_wait_second_nx = uop_eseg_wait_second_clr ? 1'b0 : 1'b1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_eseg_wait_second <= 1'b0;
    end
    else if (uop_eseg_wait_second_en) begin
        uop_eseg_wait_second <= uop_eseg_wait_second_nx;
    end
end

always @* begin
    uop_fsm_nx = {UOP_FSM_BITS{1'b0}};
    case (1'b1)
        uop_fsm[UOP_FSM_INVALID]: begin
            uop_fsm_en = uop_enq_valid;
            uop_fsm_nx[UOP_FSM_VALID] = 1'b1;
        end
        uop_fsm[UOP_FSM_VALID]: begin
            uop_fsm_en = uop_cmt_valid;
            if (uop_deq_valid) begin
                uop_fsm_nx[UOP_FSM_INVALID] = 1'b1;
            end
            else begin
                uop_fsm_nx[UOP_FSM_CMT] = ~uop_cmt_kill;
                uop_fsm_nx[UOP_FSM_KILL] = uop_cmt_kill;
            end
        end
        uop_fsm[UOP_FSM_CMT]: begin
            uop_fsm_en = uop_deq_valid;
            uop_fsm_nx[UOP_FSM_INVALID] = 1'b1;
        end
        uop_fsm[UOP_FSM_KILL]: begin
            uop_fsm_en = uop_deq_valid;
            uop_fsm_nx[UOP_FSM_INVALID] = 1'b1;
        end
        default: begin
            uop_fsm_en = 1'b0;
            uop_fsm_nx = {UOP_FSM_BITS{1'b0}};
        end
    endcase
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_fsm <= {{UOP_FSM_BITS - 1{1'b0}},1'b1};
    end
    else if (uop_fsm_en) begin
        uop_fsm <= uop_fsm_nx;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_ctrl <= {25{1'b0}};
        uop_vd_emul_len <= {VRF_LW{1'b0}};
        uop_vd_beats <= {VRF_LW{1'b0}};
        uop_vd_seg_beats <= {VRF_LW{1'b0}};
        uop_element_num_dlen <= {ELE_DLEN_WIDTH{1'b0}};
        uop_total_byte <= {MAX_BYTE_WIDTH{1'b0}};
    end
    else if (uop_enq_first_valid) begin
        uop_ctrl <= uop_enq_ctrl;
        uop_vd_emul_len <= uop_enq_vd_emul_len;
        uop_vd_beats <= uop_enq_vd_beats;
        uop_vd_seg_beats <= uop_enq_vd_seg_beats;
        uop_element_num_dlen <= uop_enq_element_num_dlen;
        uop_total_byte <= uop_enq_total_byte;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_first <= 1'b0;
    end
    else if (uop_enq_first_valid) begin
        uop_first <= uop_enq_first;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_last <= 1'b0;
        uop_ele_dlen_last <= 1'b0;
    end
    else if (uop_enq_valid) begin
        uop_last <= uop_enq_last;
        uop_ele_dlen_last <= uop_enq_ele_dlen_last;
    end
end

assign uop_qout_alive = uop_alive_byte_zero ? uop_second_alive : uop_first_alive;
assign uop_alive_byte_zero = uop_alive_byte == {MAX_BYTE_WIDTH{1'b0}};
assign uop_first_alive_en = uop_deq_valid | uop_enq_first_valid;
assign uop_second_alive_en = uop_deq_valid | uop_enq_valid;
assign uop_first_alive_nx = uop_deq_valid ? 1'b0 : uop_enq_alive;
assign uop_second_alive_nx = uop_deq_valid ? 1'b0 : uop_enq_alive;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_first_alive <= 1'b0;
    end
    else if (uop_first_alive_en) begin
        uop_first_alive <= uop_first_alive_nx;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_second_alive <= 1'b0;
    end
    else if (uop_second_alive_en) begin
        uop_second_alive <= uop_second_alive_nx;
    end
end

assign uop_start_buf_num_nx = uop_cmt_start_buf_num;
assign uop_start_buf_num_en = uop_cmt_valid;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_start_buf_num <= {BUF_DEPTH_LOG2{1'b0}};
    end
    else if (uop_start_buf_num_en) begin
        uop_start_buf_num <= uop_start_buf_num_nx;
    end
end

assign uop_enq_first_valid = uop_enq_valid & ~uop_eseg_wait_second;
assign uop_enq_second_valid = uop_enq_valid & uop_eseg_wait_second;
assign uop_enq_ustride_first = uop_enq_ustride & ~uop_enq_cross_4k_d1;
assign uop_enq_pa_prestart = uop_enq_pa[PALEN - 1:12] - {{PALEN - 13{1'b0}},1'b1};
assign uop_enq_pa_4k_sel = uop_enq_prestart_cross ? uop_enq_pa_prestart : uop_enq_pa[PALEN - 1:12];
assign uop_enq_pa_base = {uop_enq_pa_4k_sel,uop_enq_base_offset[11:0]};
assign uop_enq_pa_sel = uop_enq_ustride_first ? uop_enq_pa_base : uop_enq_pa;
assign uop_eseg_pa_4k_en = uop_eseg & (uop_pa_cross_nx[PALEN - 1:12] != uop_pa[PALEN - 1:12]);
assign uop_eseg_pa_cross_4k = {uop_second_ppn,12'b0};
assign uop_pa_en = uop_enq_first_valid | uop_req_grant_valid;
assign uop_pa_nx = (uop_req_grant_valid & uop_eseg_pa_4k_en) ? uop_eseg_pa_cross_4k : uop_req_grant_valid ? uop_pa_cross_nx : uop_enq_pa_sel;
always @(posedge vpu_vlsu_clk) begin
    if (uop_pa_en) begin
        uop_pa <= uop_pa_nx;
    end
end

assign uop_vstart_byte_en = uop_enq_first_valid | (uop_req_grant_valid & uop_ctrl[19]);
assign uop_vstart_byte_nx = uop_enq_valid ? uop_enq_vstart_byte : uop_remain_vstart_byte_nx;
always @(posedge vpu_vlsu_clk) begin
    if (uop_vstart_byte_en) begin
        uop_vstart_byte <= uop_vstart_byte_nx;
    end
end

assign uop_byte_en = uop_enq_valid | uop_req_grant_valid;
assign uop_byte_nx = uop_enq_valid ? uop_enq_second_valid ? uop_enq_total_byte : uop_enq_byte : uop_remain_byte_nx;
always @(posedge vpu_vlsu_clk) begin
    if (uop_byte_en) begin
        uop_byte <= uop_byte_nx;
    end
end

assign uop_second_ppn_nx = uop_enq_pa[PALEN - 1:12];
assign uop_second_ppn_en = uop_enq_second_valid;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_second_ppn <= {PALEN - 12{1'b0}};
    end
    else if (uop_second_ppn_en) begin
        uop_second_ppn <= uop_second_ppn_nx;
    end
end

assign uop_alive_byte_en = uop_enq_first_valid | (uop_enq_second_valid & uop_enq_alive) | (uop_req_grant_valid & uop_qout_alive);
assign uop_alive_byte_nx = uop_req_grant_valid ? uop_alive_byte_update : uop_enq_first_valid ? uop_enq_byte : uop_enq_total_byte;
always @(posedge vpu_vlsu_clk) begin
    if (uop_alive_byte_en) begin
        uop_alive_byte <= uop_alive_byte_nx;
    end
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

