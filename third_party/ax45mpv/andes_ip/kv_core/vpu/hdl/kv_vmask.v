// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vmask (
    vpu_vmask_clk,
    vpu_reset_n,
    vmask_standby_ready,
    vmask_dispatch_valid,
    vmask_dispatch_op1,
    vmask_dispatch_ctrl,
    vmask_dispatch_v0t,
    vmask_dispatch_op1_hazard,
    vmask_dispatch_vd_len,
    vmask_dispatch_vs1_len,
    vmask_dispatch_vs2_len,
    vmask_dispatch_vs3_len,
    vmask_dispatch_ready,
    vmask_cmt_valid,
    vmask_cmt_kill,
    vmask_cmt_op1,
    vmask_vs1_rdata,
    vmask_vs1_rready,
    vmask_vs1_rvalid,
    vmask_vs1_rlast,
    vmask_vs2_rdata,
    vmask_vs2_rready,
    vmask_vs2_rvalid,
    vmask_vs2_rlast,
    vmask_vs3_rdata,
    vmask_vs3_rready,
    vmask_vs3_rvalid,
    vmask_vs3_rlast,
    vmask_vd_wvalid,
    vmask_vd_wready,
    vmask_vd_wdata,
    vmask_vd_wmask,
    vmask_vd_wlast,
    vmask_srf_wvalid,
    vmask_srf_wready,
    vmask_srf_wfrf,
    vmask_srf_waddr,
    vmask_srf_wdata
);
parameter VLEN = 512;
parameter DLEN = 512;
parameter RAR_SUPPORT = 0;
localparam XLEN = 64;
localparam ELEN = 64;
localparam LANE_NUM = DLEN / ELEN;
localparam LANE_ID_BITS = $clog2(LANE_NUM);
localparam D_ID_NUM = VLEN / DLEN;
localparam D_ID_BITS = (D_ID_NUM == 1) ? 1 : $clog2(D_ID_NUM);
localparam V_ID_NUM = 8 * (VLEN / DLEN);
localparam V_ID_BITS = $clog2(V_ID_NUM);
localparam CARRY_WIDTH = $clog2(ELEN);
localparam VFIRST_BITS = $clog2(VLEN);
localparam BIT_MASK_NUM = VLEN / ELEN;
localparam BIT_MASK_BITS = $clog2(BIT_MASK_NUM);
localparam BIT_MASK_OFFSET = $clog2(ELEN);
localparam VIOTA_CYCLE = (DLEN == 1024) ? 2 : 1;
localparam ID_WIDTH = 3;
localparam VRF_LW = (VLEN == DLEN) ? 3 : 4;
input vpu_vmask_clk;
input vpu_reset_n;
output vmask_standby_ready;
input vmask_dispatch_valid;
input [(XLEN - 1):0] vmask_dispatch_op1;
input [(44 - 1):0] vmask_dispatch_ctrl;
input [(VLEN - 1):0] vmask_dispatch_v0t;
input vmask_dispatch_op1_hazard;
input [(VRF_LW - 1):0] vmask_dispatch_vd_len;
input [(VRF_LW - 1):0] vmask_dispatch_vs1_len;
input [(VRF_LW - 1):0] vmask_dispatch_vs2_len;
input [(VRF_LW - 1):0] vmask_dispatch_vs3_len;
output vmask_dispatch_ready;
input vmask_cmt_valid;
input vmask_cmt_kill;
input [(XLEN - 1):0] vmask_cmt_op1;
input [(DLEN - 1):0] vmask_vs1_rdata;
output vmask_vs1_rready;
input vmask_vs1_rvalid;
input vmask_vs1_rlast;
input [(DLEN - 1):0] vmask_vs2_rdata;
output vmask_vs2_rready;
input vmask_vs2_rvalid;
input vmask_vs2_rlast;
input [(DLEN - 1):0] vmask_vs3_rdata;
output vmask_vs3_rready;
input vmask_vs3_rvalid;
input vmask_vs3_rlast;
output vmask_vd_wvalid;
input vmask_vd_wready;
output [(DLEN - 1):0] vmask_vd_wdata;
output [(DLEN / 8) - 1:0] vmask_vd_wmask;
input vmask_vd_wlast;
output vmask_srf_wvalid;
input vmask_srf_wready;
output vmask_srf_wfrf;
output [4:0] vmask_srf_waddr;
output [63:0] vmask_srf_wdata;





// 9855180e rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire nds_unused_vmask_rw_last = vmask_vs1_rlast | vmask_vs2_rlast | vmask_vs3_rlast | vmask_vd_wlast;
wire [(XLEN - 1):0] nds_unused_vmask_dispatch_op1 = vmask_dispatch_op1;
wire nds_unused_vmask_dispatch_op1_hazard = vmask_dispatch_op1_hazard;
wire [(XLEN - 1):0] nds_unused_vmask_cmt_op1 = vmask_cmt_op1;
assign vmask_srf_wfrf = 1'b0;
reg [(ID_WIDTH - 1):0] vmask_cmt_id;
reg ve0_dispatch_valid;
wire ve0_dispatch_valid_en;
wire ve0_dispatch_valid_set;
wire ve0_dispatch_valid_clr;
wire ve0_dispatch_valid_nx;
wire ve0_dispatch_ready;
reg [(44 - 1):0] ve0_dispatch_ctrl;
reg [2:0] ve0_dispatch_vd_len;
reg [2:0] ve0_dispatch_vs1_len;
reg [2:0] ve0_dispatch_vs2_len;
reg [2:0] ve0_dispatch_vs3_len;
reg [(VLEN - 1):0] ve0_dispatch_v0t;
reg [(ID_WIDTH - 1):0] ve0_dispatch_id;
wire [(ID_WIDTH - 1):0] ve0_dispatch_id_nx;
wire ve0_dispatch_kill;
reg ve0_dispatch_commited;
wire ve0_dispatch_commited_en;
wire ve0_dispatch_commited_nx;
reg ve0_valid;
wire ve0_valid_en;
wire ve0_valid_set;
wire ve0_valid_clr;
wire ve0_valid_nx;
wire ve0_ready;
wire ve0_first;
wire ve0_dummy;
reg ve0_commited;
wire ve0_commited_en;
wire ve0_commited_nx;
reg [(44 - 1):0] ve0_ctrl;
reg [2:0] ve0_vd_len;
reg [2:0] ve0_vs1_len;
reg [2:0] ve0_vs2_len;
reg [2:0] ve0_vs3_len;
wire ve0_ctrl_to_ve1;
wire ve0_ctrl_to_ve2;
reg [(VLEN - 1):0] ve0_v0t;
reg [(ID_WIDTH - 1):0] ve0_id;
wire ve0_kill;
wire ve0_to_ve1_valid;
wire ve0_to_ve2_valid;
wire ve1_to_ve0_ready;
wire ve2_to_ve0_ready;
wire [(D_ID_BITS - 1):0] ve0_d_id;
wire [(D_ID_BITS - 1):0] ve0_d_cnt_vs2;
wire [(D_ID_BITS - 1):0] ve0_d_cnt_vs0;
reg ve0_vs3_valid;
wire ve0_vs3_valid_en;
wire ve0_vs3_valid_set;
wire ve0_vs3_valid_clr;
wire ve0_vs3_valid_nx;
wire ve0_vs3_ready;
reg [(DLEN - 1):0] ve0_vs3_data;
wire ve0_vs3_last;
reg ve0_vs2_valid;
wire ve0_vs2_valid_en;
wire ve0_vs2_valid_set;
wire ve0_vs2_valid_clr;
wire ve0_vs2_valid_nx;
wire ve0_vs2_ready;
reg [(DLEN - 1):0] ve0_vs2_data;
wire [(ELEN - 1):0] ve0_vs2_unmasked_data[0:(LANE_NUM - 1)];
wire [(ELEN - 1):0] ve0_vs2_viota_unmasked_data[0:(LANE_NUM - 1)];
wire [(ELEN - 1):0] ve0_vs2_viota_v0t_data[0:(LANE_NUM - 1)];
wire [(ELEN - 1):0] ve0_vs2_viota_masked_data[0:(LANE_NUM - 1)];
wire ve0_vs2_last;
reg ve0_vs1_valid;
wire ve0_vs1_valid_en;
wire ve0_vs1_valid_set;
wire ve0_vs1_valid_clr;
wire ve0_vs1_valid_nx;
wire ve0_vs1_ready;
reg [(DLEN - 1):0] ve0_vs1_data;
wire ve0_vs1_last;
wire vmask_vs0_rready;
reg ve0_vs0_valid;
wire ve0_vs0_valid_en;
wire ve0_vs0_valid_set;
wire ve0_vs0_valid_clr;
wire ve0_vs0_valid_nx;
wire ve0_vs0_ready;
wire ve0_vs0_last;
wire ve0_vsx_consumed;
reg [(V_ID_BITS - 1):0] ve0_vsx_consumed_cnt;
wire [V_ID_BITS:0] ve0_vsx_consumed_cnt_nx;
wire ve0_vsx_consumed_en;
wire ve0_vsx_consumed_viota;
wire [(DLEN - 1):0] ve0_vd_wdata;
wire [(CARRY_WIDTH - 1):0] ve0_vfirst_wdata[0:(LANE_NUM - 1)];
wire [(LANE_NUM - 1):0] ve0_vfirst_has_1;
wire [(ELEN - 1):0] ve0_viota_wdata[0:(LANE_NUM - 1)];
wire [((ELEN / 8) - 1):0] ve0_viota_wmask[0:(LANE_NUM - 1)];
wire [8:0] ve0_viota_carry_out[0:(LANE_NUM - 1)];
wire [CARRY_WIDTH:0] ve0_vpopc_carry_out[0:(LANE_NUM - 1)];
reg ve1_valid;
wire ve1_valid_en;
wire ve1_valid_set;
wire ve1_valid_clr;
wire ve1_valid_nx;
wire ve1_ready;
reg ve1_first;
reg ve1_last;
reg ve1_dummy;
reg ve1_commited;
wire ve1_commited_en;
wire ve1_commited_nx;
reg [(ID_WIDTH - 1):0] ve1_id;
wire ve1_kill;
reg ve1_vfirst;
reg ve1_vpopc;
reg ve1_viota;
reg [1:0] ve1_sew;
reg [4:0] ve1_idx;
reg [(D_ID_BITS - 1):0] ve1_d_id;
reg [(CARRY_WIDTH - 1):0] ve1_vfirst_rdata[0:(LANE_NUM - 1)];
reg [(LANE_NUM - 1):0] ve1_vfirst_has_1;
wire [63:0] ve1_vfirst_wdata;
reg [(ELEN - 1):0] ve1_viota_rdata[0:(LANE_NUM - 1)];
reg [((ELEN / 8) - 1):0] ve1_viota_rmask[0:(LANE_NUM - 1)];
reg [8:0] ve1_viota_carry_in[0:(LANE_NUM - 1)];
wire [8:0] ve1_viota_carry_out[0:(VIOTA_CYCLE - 1)];
reg [CARRY_WIDTH:0] ve1_vpopc_carry_in[0:(LANE_NUM - 1)];
reg [63:0] ve1_vpopc_wdata;
reg nds_unused_ve1_vpopc_wdata_carry;
wire [(DLEN - 1):0] ve1_vd_wdata;
wire [((DLEN / 8) - 1):0] ve1_vd_wmask;
wire [63:0] ve1_srf_wdata;
reg ve2_valid;
wire ve2_valid_en;
wire ve2_valid_set;
wire ve2_valid_clr;
wire ve2_valid_nx;
wire ve2_ready;
reg ve2_last;
reg ve2_dummy;
reg ve2_commited;
wire ve2_commited_en;
wire ve2_commited_nx;
reg [(ID_WIDTH - 1):0] ve2_id;
wire ve2_kill;
wire [(ID_WIDTH - 1):0] ve2_id_nx;
reg ve2_srf;
reg ve2_viota;
reg [1:0] ve2_sew;
reg [4:0] ve2_idx;
reg [(DLEN - 1):0] ve2_vd_data;
wire [(DLEN - 1):0] ve2_vd_data_final;
reg [((DLEN / 8) - 1):0] ve2_vd_mask;
reg [63:0] ve2_srf_data;
wire [(DLEN - 1):0] ve2_vd_data_nx;
wire [((DLEN / 8) - 1):0] ve2_vd_mask_nx;
wire [63:0] ve2_srf_data_nx;
reg [8:0] ve2_viota_carry_out[0:(VIOTA_CYCLE - 1)];
reg ve2_vfirst_has_1;
wire ve2_vfirst_has_1_nx;
wire vd_buf_i_valid;
wire vd_buf_i_ready;
wire srf_buf_i_valid;
wire srf_buf_i_ready;
wire veq_full;
assign veq_full = (ve0_valid & ~ve0_dispatch_valid & (ve0_dispatch_id == ve0_id)) | (ve1_valid & ~ve0_dispatch_valid & (ve0_dispatch_id == ve1_id)) | (ve2_valid & ~ve0_dispatch_valid & (ve0_dispatch_id == ve2_id)) | (ve0_valid & ve0_dispatch_valid & (ve0_dispatch_id_nx == ve0_id)) | (ve1_valid & ve0_dispatch_valid & (ve0_dispatch_id_nx == ve1_id)) | (ve2_valid & ve0_dispatch_valid & (ve0_dispatch_id_nx == ve2_id));
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vmask_cmt_id <= {ID_WIDTH{1'b0}};
    end
    else if (vmask_cmt_valid) begin
        vmask_cmt_id <= vmask_cmt_id + {{(ID_WIDTH - 1){1'b0}},1'b1};
    end
end

assign ve0_dispatch_valid_set = vmask_dispatch_valid & vmask_dispatch_ready;
assign ve0_dispatch_valid_clr = (ve0_dispatch_valid & ve0_dispatch_ready) | ve0_dispatch_kill;
assign ve0_dispatch_valid_en = ve0_dispatch_valid_set | ve0_dispatch_valid_clr;
assign ve0_dispatch_valid_nx = ve0_dispatch_valid_set;
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve0_dispatch_valid <= 1'b0;
    end
    else if (ve0_dispatch_valid_en) begin
        ve0_dispatch_valid <= ve0_dispatch_valid_nx;
    end
end

generate
    if (RAR_SUPPORT) begin:gen_ve0_dispatch_ctrl_w_reset
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve0_dispatch_ctrl <= {44{1'b0}};
                ve0_dispatch_vd_len <= 3'b0;
                ve0_dispatch_vs1_len <= 3'b0;
                ve0_dispatch_vs2_len <= 3'b0;
                ve0_dispatch_vs3_len <= 3'b0;
                ve0_dispatch_v0t <= {VLEN{1'b0}};
            end
            else if (ve0_dispatch_valid_en) begin
                ve0_dispatch_ctrl <= vmask_dispatch_ctrl;
                ve0_dispatch_vd_len <= vmask_dispatch_vd_len[(VRF_LW - 1):(VRF_LW - 3)];
                ve0_dispatch_vs1_len <= vmask_dispatch_vs1_len[(VRF_LW - 1):(VRF_LW - 3)];
                ve0_dispatch_vs2_len <= vmask_dispatch_vs2_len[(VRF_LW - 1):(VRF_LW - 3)];
                ve0_dispatch_vs3_len <= vmask_dispatch_vs3_len[(VRF_LW - 1):(VRF_LW - 3)];
                ve0_dispatch_v0t <= vmask_dispatch_v0t;
            end
        end

    end
    else begin:gen_ve0_dispatch_ctrl_wo_reset
        always @(posedge vpu_vmask_clk) begin
            if (ve0_dispatch_valid_en) begin
                ve0_dispatch_ctrl <= vmask_dispatch_ctrl;
                ve0_dispatch_vd_len <= vmask_dispatch_vd_len[(VRF_LW - 1):(VRF_LW - 3)];
                ve0_dispatch_vs1_len <= vmask_dispatch_vs1_len[(VRF_LW - 1):(VRF_LW - 3)];
                ve0_dispatch_vs2_len <= vmask_dispatch_vs2_len[(VRF_LW - 1):(VRF_LW - 3)];
                ve0_dispatch_vs3_len <= vmask_dispatch_vs3_len[(VRF_LW - 1):(VRF_LW - 3)];
                ve0_dispatch_v0t <= vmask_dispatch_v0t;
            end
        end

    end
endgenerate
assign ve0_dispatch_id_nx = ve0_dispatch_id + {{(ID_WIDTH - 1){1'b0}},1'b1};
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve0_dispatch_id <= {ID_WIDTH{1'b0}};
    end
    else if (ve0_dispatch_valid_clr) begin
        ve0_dispatch_id <= ve0_dispatch_id_nx;
    end
end

assign ve0_dispatch_commited_en = (vmask_cmt_valid & ve0_dispatch_valid) | ve0_dispatch_valid_clr;
assign ve0_dispatch_commited_nx = (ve0_dispatch_id == vmask_cmt_id) & (~ve0_dispatch_valid_clr);
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve0_dispatch_commited <= 1'b0;
    end
    else if (ve0_dispatch_commited_en) begin
        ve0_dispatch_commited <= ve0_dispatch_commited_nx;
    end
end

assign ve0_dispatch_kill = vmask_cmt_valid & vmask_cmt_kill & (ve0_dispatch_id == vmask_cmt_id);
assign ve0_dispatch_ready = ~ve0_valid | (ve0_valid & ve0_valid_clr);
assign vmask_dispatch_ready = ((~ve0_dispatch_valid) | (ve0_dispatch_valid & ve0_dispatch_valid_clr)) & ~veq_full;
assign ve0_valid_set = ve0_dispatch_valid & ~ve0_dispatch_kill & ve0_dispatch_ready;
assign ve0_valid_clr = ve0_valid & ve0_ready | ve0_kill;
assign ve0_valid_en = ve0_valid_set | ve0_valid_clr;
assign ve0_valid_nx = ve0_valid_set;
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve0_valid <= 1'b0;
    end
    else if (ve0_valid_en) begin
        ve0_valid <= ve0_valid_nx;
    end
end

generate
    if (RAR_SUPPORT) begin:gen_ve0_ctrl_w_reset
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve0_ctrl <= {44{1'b0}};
                ve0_vd_len <= 3'b0;
                ve0_vs1_len <= 3'b0;
                ve0_vs2_len <= 3'b0;
                ve0_vs3_len <= 3'b0;
            end
            else if (ve0_valid_set) begin
                ve0_ctrl <= ve0_dispatch_ctrl;
                ve0_vd_len <= ve0_dispatch_vd_len;
                ve0_vs1_len <= ve0_dispatch_vs1_len;
                ve0_vs2_len <= ve0_dispatch_vs2_len;
                ve0_vs3_len <= ve0_dispatch_vs3_len;
            end
        end

    end
    else begin:gen_ve0_ctrl_wo_reset
        always @(posedge vpu_vmask_clk) begin
            if (ve0_valid_set) begin
                ve0_ctrl <= ve0_dispatch_ctrl;
                ve0_vd_len <= ve0_dispatch_vd_len;
                ve0_vs1_len <= ve0_dispatch_vs1_len;
                ve0_vs2_len <= ve0_dispatch_vs2_len;
                ve0_vs3_len <= ve0_dispatch_vs3_len;
            end
        end

    end
endgenerate
genvar nmask;
generate
    for (nmask = 0; nmask < BIT_MASK_NUM; nmask = nmask + 1) begin:gen_ve0_v0t
        wire [(ELEN - 1):0] bit_start_mask;
        wire [(ELEN - 1):0] bit_vl_mask;
        wire [(ELEN - 1):0] bit_mask;
        wire [9:0] vstart = ve0_dispatch_ctrl[33 +:10];
        wire [10:0] vl = ve0_dispatch_ctrl[12 +:11];
        wire vstart_gt_nmask = (vstart[BIT_MASK_OFFSET +:BIT_MASK_BITS] > nmask[(BIT_MASK_BITS - 1):0]);
        wire vstart_lt_nmask;
        if (nmask == 0) begin:gen_vstart_lt_nmask_0
            assign vstart_lt_nmask = 1'b0;
        end
        else begin:gen_vstart_lt_nmask_n
            assign vstart_lt_nmask = (vstart[BIT_MASK_OFFSET +:BIT_MASK_BITS] < nmask[(BIT_MASK_BITS - 1):0]);
        end
        wire vstart_eq_nmask = (vstart[BIT_MASK_OFFSET +:BIT_MASK_BITS] == nmask[(BIT_MASK_BITS - 1):0]);
        wire vl_gt_nmask = (vl[BIT_MASK_OFFSET +:BIT_MASK_BITS + 1] > nmask[BIT_MASK_BITS:0]);
        wire vl_lt_nmask;
        if (nmask == 0) begin:gen_vl_lt_nmask_0
            assign vl_lt_nmask = 1'b0;
        end
        else begin:gen_vl_lt_nmask_n
            assign vl_lt_nmask = (vl[BIT_MASK_OFFSET +:BIT_MASK_BITS + 1] < nmask[BIT_MASK_BITS:0]);
        end
        wire vl_eq_nmask = (vl[BIT_MASK_OFFSET +:BIT_MASK_BITS + 1] == nmask[BIT_MASK_BITS:0]);
        wire vstart_ge_vl = (vstart[BIT_MASK_OFFSET - 1:0] >= vl[BIT_MASK_OFFSET - 1:0]);
        wire nop = vstart_gt_nmask | vl_lt_nmask | (vstart_eq_nmask & vl_eq_nmask & vstart_ge_vl);
        assign bit_start_mask = vstart_lt_nmask ? {ELEN{1'b1}} : ({ELEN{1'b1}} << vstart[BIT_MASK_OFFSET - 1:0]);
        assign bit_vl_mask = vl_gt_nmask ? {ELEN{1'b0}} : ({ELEN{1'b1}} << vl[BIT_MASK_OFFSET - 1:0]);
        assign bit_mask = {ELEN{~nop}} & ((bit_start_mask ^ bit_vl_mask) & ({ELEN{ve0_dispatch_ctrl[23]}} | ve0_dispatch_v0t[nmask * ELEN +:ELEN]));
        if (RAR_SUPPORT) begin:gen_ve0_v0t_w_reset
            always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    ve0_v0t[nmask * ELEN +:ELEN] <= {ELEN{1'b0}};
                end
                else if (ve0_valid_set) begin
                    ve0_v0t[nmask * ELEN +:ELEN] <= bit_mask;
                end
            end

        end
        else begin:gen_ve0_v0t_wo_reset
            always @(posedge vpu_vmask_clk) begin
                if (ve0_valid_set) begin
                    ve0_v0t[nmask * ELEN +:ELEN] <= bit_mask;
                end
            end

        end
    end
endgenerate
assign ve0_ctrl_to_ve1 = ve0_ctrl[9] | ve0_ctrl[27] | ve0_ctrl[11] | ve0_ctrl[10];
assign ve0_ctrl_to_ve2 = ve0_ctrl[0] | ve0_ctrl[6] | ve0_ctrl[43] | ve0_ctrl[24] | ve0_ctrl[25] | ve0_ctrl[26];
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve0_id <= {ID_WIDTH{1'b0}};
    end
    else if (ve0_valid_en) begin
        ve0_id <= ve0_dispatch_id;
    end
end

assign ve0_commited_en = (vmask_cmt_valid & ve0_valid & (ve0_id == vmask_cmt_id)) | ve0_valid_en;
assign ve0_commited_nx = (vmask_cmt_valid & ~vmask_cmt_kill & ve0_valid & (ve0_id == vmask_cmt_id) & ~ve0_valid_clr) | (vmask_cmt_valid & ~vmask_cmt_kill & ve0_dispatch_valid & ve0_dispatch_ready & (ve0_dispatch_id == vmask_cmt_id)) | (ve0_dispatch_valid & ve0_dispatch_ready & ve0_dispatch_commited);
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve0_commited <= 1'b0;
    end
    else if (ve0_commited_en) begin
        ve0_commited <= ve0_commited_nx;
    end
end

assign ve0_kill = vmask_cmt_valid & vmask_cmt_kill & (ve0_id == vmask_cmt_id);
assign ve0_to_ve1_valid = ve0_valid & ((~ve0_ctrl[30]) | (ve0_ctrl[30] & ve0_vs2_valid)) & ((~ve0_ctrl[10]) | (ve0_ctrl[10] & ve0_vs0_valid));
assign ve0_to_ve2_valid = ve0_valid & ((~ve0_ctrl[32]) | (ve0_ctrl[32] & ve0_vs3_valid)) & ((~ve0_ctrl[30]) | (ve0_ctrl[30] & ve0_vs2_valid)) & ((~ve0_ctrl[28]) | (ve0_ctrl[28] & ve0_vs1_valid));
assign ve1_to_ve0_ready = ve0_ctrl_to_ve1 & (~ve1_valid | (ve1_valid & ve1_valid_clr));
assign ve2_to_ve0_ready = ve0_ctrl_to_ve2 & ~ve1_valid & (~ve2_valid | (ve2_valid & ve2_valid_clr));
assign ve0_ready = (ve1_to_ve0_ready | ve2_to_ve0_ready) & ((~ve0_ctrl[32]) | (ve0_ctrl[32] & ve0_vs3_valid & ve0_vs3_ready & ve0_vs3_last)) & ((~ve0_ctrl[30]) | (ve0_ctrl[30] & ve0_vs2_valid & ve0_vs2_ready & ve0_vs2_last)) & ((~ve0_ctrl[28]) | (ve0_ctrl[28] & ve0_vs1_valid & ve0_vs1_ready & ve0_vs1_last)) & ((~ve0_ctrl[10]) | (ve0_ctrl[10] & ve0_vs0_valid & ve0_vs0_ready & ve0_vs0_last));
assign ve0_first = ve0_vsx_consumed_cnt == {V_ID_BITS{1'b0}};
assign ve0_vs3_valid_set = vmask_vs3_rvalid & vmask_vs3_rready;
assign ve0_vs3_valid_clr = ve0_vs3_ready;
assign ve0_vs3_valid_en = ve0_vs3_valid_set | ve0_vs3_valid_clr;
assign ve0_vs3_valid_nx = ve0_vs3_valid_set;
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve0_vs3_valid <= 1'b0;
    end
    else if (ve0_vs3_valid_en) begin
        ve0_vs3_valid <= ve0_vs3_valid_nx;
    end
end

generate
    if (RAR_SUPPORT) begin:gen_ve0_vs3_data_w_reset
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve0_vs3_data <= {DLEN{1'b0}};
            end
            else if (ve0_vs3_valid_en) begin
                ve0_vs3_data <= vmask_vs3_rdata;
            end
        end

    end
    else begin:gen_ve0_vs3_data_wo_reset
        always @(posedge vpu_vmask_clk) begin
            if (ve0_vs3_valid_en) begin
                ve0_vs3_data <= vmask_vs3_rdata;
            end
        end

    end
endgenerate
assign ve0_vs3_ready = (ve0_ctrl[32] & ve0_kill) | (ve0_ctrl[32] & ve0_to_ve2_valid & ve2_to_ve0_ready);
generate
    if (D_ID_NUM == 1) begin:gen_ve0_vs3_last_1v1
        assign ve0_vs3_last = 1'b1;
    end
    else if (D_ID_NUM == 2) begin:gen_ve0_vs3_last_2v1
        reg ve0_vs3_cnt;
        wire ve0_vs3_cnt_nx;
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve0_vs3_cnt <= 1'b0;
            end
            else if (ve0_vs3_valid_clr) begin
                ve0_vs3_cnt <= ve0_vs3_cnt_nx;
            end
        end

        assign ve0_vs3_cnt_nx = ve0_kill ? 1'b0 : ~ve0_vs3_cnt;
        assign ve0_vs3_last = ve0_vs3_cnt;
    end
    else begin:gen_ve0_vs3_last_nv1
        reg [(D_ID_BITS - 1):0] ve0_vs3_cnt;
        wire [D_ID_BITS:0] ve0_vs3_cnt_nx;
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve0_vs3_cnt <= {D_ID_BITS{1'b0}};
            end
            else if (ve0_vs3_valid_clr) begin
                ve0_vs3_cnt <= ve0_vs3_cnt_nx[(D_ID_BITS - 1):0];
            end
        end

        assign ve0_vs3_cnt_nx = ve0_kill ? {(D_ID_BITS + 1){1'b0}} : ve0_vs3_cnt + {{(D_ID_BITS - 1){1'b0}},1'b1};
        assign ve0_vs3_last = &ve0_vs3_cnt;
    end
endgenerate
assign vmask_vs3_rready = (~ve0_valid_clr & ve0_valid & ve0_ctrl[32] & (ve0_vs3_len == 3'b0) & ~ve0_kill & ((~ve0_vs3_valid) | (ve0_vs3_valid & ve0_vs3_valid_clr))) | (ve0_valid_clr & ve0_valid_set & ve0_dispatch_ctrl[32] & (ve0_dispatch_vs3_len == 3'b0) & ~ve0_kill & ((~ve0_vs3_valid) | (ve0_vs3_valid & ve0_vs3_valid_clr))) | (~ve0_valid & ve0_valid_set & ve0_dispatch_ctrl[32] & (ve0_dispatch_vs3_len == 3'b0) & ((~ve0_vs3_valid) | (ve0_vs3_valid & ve0_vs3_valid_clr)));
assign ve0_vs2_valid_set = vmask_vs2_rvalid & vmask_vs2_rready;
assign ve0_vs2_valid_clr = ve0_vs2_ready;
assign ve0_vs2_valid_en = ve0_vs2_valid_set | ve0_vs2_valid_clr;
assign ve0_vs2_valid_nx = ve0_vs2_valid_set;
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve0_vs2_valid <= 1'b0;
    end
    else if (ve0_vs2_valid_en) begin
        ve0_vs2_valid <= ve0_vs2_valid_nx;
    end
end

generate
    if (RAR_SUPPORT) begin:gen_ve0_vs2_data_w_reset
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve0_vs2_data <= {DLEN{1'b0}};
            end
            else if (ve0_vs2_valid_en) begin
                ve0_vs2_data <= vmask_vs2_rdata;
            end
        end

    end
    else begin:gen_ve0_vs2_data_wo_reset
        always @(posedge vpu_vmask_clk) begin
            if (ve0_vs2_valid_en) begin
                ve0_vs2_data <= vmask_vs2_rdata;
            end
        end

    end
endgenerate
assign ve0_vs2_ready = (ve0_ctrl[30] & ve0_kill) | (ve0_ctrl[30] & ve0_to_ve1_valid & ve1_to_ve0_ready & ve0_vsx_consumed) | (ve0_ctrl[30] & ve0_to_ve2_valid & ve2_to_ve0_ready);
generate
    if (D_ID_NUM == 1) begin:gen_ve0_vs2_last_1v1
        assign ve0_vs2_last = 1'b1;
        assign ve0_d_cnt_vs2 = 1'b0;
        wire nds_unused_ve0_d_cnt_vs2 = ve0_d_cnt_vs2;
    end
    else if (D_ID_NUM == 2) begin:gen_ve0_vs2_last_2v1
        reg ve0_vs2_cnt;
        wire ve0_vs2_cnt_nx;
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve0_vs2_cnt <= 1'b0;
            end
            else if (ve0_vs2_valid_clr) begin
                ve0_vs2_cnt <= ve0_vs2_cnt_nx;
            end
        end

        assign ve0_vs2_cnt_nx = ve0_kill ? 1'b0 : ~ve0_vs2_cnt;
        assign ve0_vs2_last = ve0_vs2_cnt;
        assign ve0_d_cnt_vs2 = ve0_vs2_cnt;
    end
    else begin:gen_ve0_vs2_last_nv1
        reg [(D_ID_BITS - 1):0] ve0_vs2_cnt;
        wire [D_ID_BITS:0] ve0_vs2_cnt_nx;
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve0_vs2_cnt <= {D_ID_BITS{1'b0}};
            end
            else if (ve0_vs2_valid_clr) begin
                ve0_vs2_cnt <= ve0_vs2_cnt_nx[(D_ID_BITS - 1):0];
            end
        end

        assign ve0_vs2_cnt_nx = ve0_kill ? {(D_ID_BITS + 1){1'b0}} : ve0_vs2_cnt + {{(D_ID_BITS - 1){1'b0}},1'b1};
        assign ve0_vs2_last = &ve0_vs2_cnt;
        assign ve0_d_cnt_vs2 = ve0_vs2_cnt;
    end
endgenerate
assign vmask_vs2_rready = (~ve0_valid_clr & ve0_valid & ve0_ctrl[30] & (ve0_vs2_len == 3'b0) & ~ve0_kill & ((~ve0_vs2_valid) | (ve0_vs2_valid & ve0_vs2_valid_clr))) | (ve0_valid_clr & ve0_valid_set & ve0_dispatch_ctrl[30] & (ve0_dispatch_vs2_len == 3'b0) & ~ve0_kill & ((~ve0_vs2_valid) | (ve0_vs2_valid & ve0_vs2_valid_clr))) | (~ve0_valid & ve0_valid_set & ve0_dispatch_ctrl[30] & (ve0_dispatch_vs2_len == 3'b0) & ((~ve0_vs2_valid) | (ve0_vs2_valid & ve0_vs2_valid_clr)));
assign ve0_vs1_valid_set = vmask_vs1_rvalid & vmask_vs1_rready;
assign ve0_vs1_valid_clr = ve0_vs1_ready;
assign ve0_vs1_valid_en = ve0_vs1_valid_set | ve0_vs1_valid_clr;
assign ve0_vs1_valid_nx = ve0_vs1_valid_set;
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve0_vs1_valid <= 1'b0;
    end
    else if (ve0_vs1_valid_en) begin
        ve0_vs1_valid <= ve0_vs1_valid_nx;
    end
end

generate
    if (RAR_SUPPORT) begin:gen_ve0_vs1_data_w_reset
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve0_vs1_data <= {DLEN{1'b0}};
            end
            else if (ve0_vs1_valid_en) begin
                ve0_vs1_data <= vmask_vs1_rdata;
            end
        end

    end
    else begin:gen_ve0_vs1_data_wo_reset
        always @(posedge vpu_vmask_clk) begin
            if (ve0_vs1_valid_en) begin
                ve0_vs1_data <= vmask_vs1_rdata;
            end
        end

    end
endgenerate
assign ve0_vs1_ready = (ve0_ctrl[28] & ve0_kill) | (ve0_ctrl[28] & ve0_to_ve2_valid & ve2_to_ve0_ready);
generate
    if (D_ID_NUM == 1) begin:gen_ve0_vs1_last_1v1
        assign ve0_vs1_last = 1'b1;
    end
    else if (D_ID_NUM == 2) begin:gen_ve0_vs1_last_2v1
        reg ve0_vs1_cnt;
        wire ve0_vs1_cnt_nx;
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve0_vs1_cnt <= 1'b0;
            end
            else if (ve0_vs1_valid_clr) begin
                ve0_vs1_cnt <= ve0_vs1_cnt_nx;
            end
        end

        assign ve0_vs1_cnt_nx = ve0_kill ? 1'b0 : ~ve0_vs1_cnt;
        assign ve0_vs1_last = ve0_vs1_cnt;
    end
    else begin:gen_ve0_vs1_last_nv1
        reg [(D_ID_BITS - 1):0] ve0_vs1_cnt;
        wire [D_ID_BITS:0] ve0_vs1_cnt_nx;
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve0_vs1_cnt <= {D_ID_BITS{1'b0}};
            end
            else if (ve0_vs1_valid_clr) begin
                ve0_vs1_cnt <= ve0_vs1_cnt_nx[(D_ID_BITS - 1):0];
            end
        end

        assign ve0_vs1_cnt_nx = ve0_kill ? {(D_ID_BITS + 1){1'b0}} : ve0_vs1_cnt + {{(D_ID_BITS - 1){1'b0}},1'b1};
        assign ve0_vs1_last = &ve0_vs1_cnt;
    end
endgenerate
assign vmask_vs1_rready = (~ve0_valid_clr & ve0_valid & ve0_ctrl[28] & (ve0_vs1_len == 3'b0) & ~ve0_kill & ((~ve0_vs1_valid) | (ve0_vs1_valid & ve0_vs1_valid_clr))) | (ve0_valid_clr & ve0_valid_set & ve0_dispatch_ctrl[28] & (ve0_dispatch_vs1_len == 3'b0) & ~ve0_kill & ((~ve0_vs1_valid) | (ve0_vs1_valid & ve0_vs1_valid_clr))) | (~ve0_valid & ve0_valid_set & ve0_dispatch_ctrl[28] & (ve0_dispatch_vs1_len == 3'b0) & ((~ve0_vs1_valid) | (ve0_vs1_valid & ve0_vs1_valid_clr)));
assign ve0_vs0_valid_set = vmask_vs0_rready;
assign ve0_vs0_valid_clr = ve0_vs0_ready;
assign ve0_vs0_valid_en = ve0_vs0_valid_set | ve0_vs0_valid_clr;
assign ve0_vs0_valid_nx = ve0_vs0_valid_set;
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve0_vs0_valid <= 1'b0;
    end
    else if (ve0_vs0_valid_en) begin
        ve0_vs0_valid <= ve0_vs0_valid_nx;
    end
end

assign ve0_vs0_ready = (ve0_ctrl[10] & ve0_kill) | (ve0_ctrl[10] & ve0_to_ve1_valid & ve1_to_ve0_ready & ve0_vsx_consumed);
generate
    if (D_ID_NUM == 1) begin:gen_ve0_vs0_last_1v1
        assign ve0_vs0_last = 1'b1;
        assign ve0_d_cnt_vs0 = 1'b0;
        wire nds_unused_ve0_d_cnt_vs0 = ve0_d_cnt_vs0;
    end
    else if (D_ID_NUM == 2) begin:gen_ve0_vs0_last_2v1
        reg ve0_vs0_cnt;
        wire ve0_vs0_cnt_nx;
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve0_vs0_cnt <= 1'b0;
            end
            else if (ve0_vs0_valid_clr) begin
                ve0_vs0_cnt <= ve0_vs0_cnt_nx;
            end
        end

        assign ve0_vs0_cnt_nx = ve0_kill ? 1'b0 : ~ve0_vs0_cnt;
        assign ve0_vs0_last = ve0_vs0_cnt;
        assign ve0_d_cnt_vs0 = ve0_vs0_cnt;
    end
    else begin:gen_ve0_vs0_last_nv1
        reg [(D_ID_BITS - 1):0] ve0_vs0_cnt;
        wire [D_ID_BITS:0] ve0_vs0_cnt_nx;
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve0_vs0_cnt <= {D_ID_BITS{1'b0}};
            end
            else if (ve0_vs0_valid_clr) begin
                ve0_vs0_cnt <= ve0_vs0_cnt_nx[(D_ID_BITS - 1):0];
            end
        end

        assign ve0_vs0_cnt_nx = ve0_kill ? {(D_ID_BITS + 1){1'b0}} : ve0_vs0_cnt + {{(D_ID_BITS - 1){1'b0}},1'b1};
        assign ve0_vs0_last = &ve0_vs0_cnt;
        assign ve0_d_cnt_vs0 = ve0_vs0_cnt;
    end
endgenerate
assign ve0_d_id = (D_ID_NUM == 1) ? {D_ID_BITS{1'b0}} : (ve0_ctrl[10] ? ve0_d_cnt_vs0 : ve0_d_cnt_vs2);
assign vmask_vs0_rready = (~ve0_valid_clr & ve0_valid & ve0_ctrl[10] & ~ve0_kill & ((~ve0_vs0_valid) | (ve0_vs0_valid & ve0_vs0_valid_clr))) | (ve0_valid_clr & ve0_valid_set & ve0_dispatch_ctrl[10] & ~ve0_kill & ((~ve0_vs0_valid) | (ve0_vs0_valid & ve0_vs0_valid_clr))) | (~ve0_valid & ve0_valid_set & ve0_dispatch_ctrl[10] & ((~ve0_vs0_valid) | (ve0_vs0_valid & ve0_vs0_valid_clr)));
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve0_vsx_consumed_cnt <= {V_ID_BITS{1'b0}};
    end
    else if (ve0_vsx_consumed_en) begin
        ve0_vsx_consumed_cnt <= ve0_vsx_consumed_cnt_nx[(V_ID_BITS - 1):0];
    end
end

assign ve0_vsx_consumed_cnt_nx = ve0_valid_clr ? {(V_ID_BITS + 1){1'b0}} : ve0_vsx_consumed_cnt + {{(V_ID_BITS - 1){1'b0}},1'b1};
assign ve0_vsx_consumed_en = (ve0_to_ve1_valid & ve1_to_ve0_ready) | (ve0_to_ve2_valid & ve2_to_ve0_ready) | ve0_valid_clr;
assign ve0_vsx_consumed = (ve0_ctrl[11] | ve0_ctrl[10]) ? ve0_vsx_consumed_viota : 1'b1;
generate
    if (D_ID_NUM == 1) begin:gen_ve0_vsx_consumed_viota_1v1
        assign ve0_vsx_consumed_viota = (ve0_vd_len == 3'b000) | ((ve0_vd_len == 3'b001) & ve0_vsx_consumed_cnt[0]) | ((ve0_vd_len == 3'b011) & (&ve0_vsx_consumed_cnt[1:0])) | ((ve0_vd_len == 3'b111) & (&ve0_vsx_consumed_cnt[2:0]));
        assign ve0_dummy = 1'b0;
    end
    else if (D_ID_NUM == 2) begin:gen_ve0_vsx_consumed_viota_2v1
        reg ve0_dummy_r;
        wire ve0_dummy_en;
        wire ve0_dummy_nx;
        assign ve0_vsx_consumed_viota = ((ve0_vd_len == 3'b000) & ve0_vsx_consumed_cnt[0]) | ((ve0_vd_len == 3'b001) & (&ve0_vsx_consumed_cnt[1:0])) | ((ve0_vd_len == 3'b011) & (&ve0_vsx_consumed_cnt[2:0])) | ((ve0_vd_len == 3'b111) & (ve0_ctrl[7 +:2] == 2'b11) & (&ve0_vsx_consumed_cnt[3:0])) | ((ve0_vd_len == 3'b111) & (ve0_ctrl[7 +:2] == 2'b10) & (&ve0_vsx_consumed_cnt[3:0])) | ((ve0_vd_len == 3'b111) & (ve0_ctrl[7 +:2] == 2'b01) & (&ve0_vsx_consumed_cnt[3:0])) | ((ve0_vd_len == 3'b111) & (ve0_ctrl[7 +:2] == 2'b00) & (&ve0_vsx_consumed_cnt[2:0])) | ve0_dummy_r;
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve0_dummy_r <= 1'b0;
            end
            else if (ve0_dummy_en) begin
                ve0_dummy_r <= ve0_dummy_nx;
            end
        end

        assign ve0_dummy = ve0_dummy_r;
        assign ve0_dummy_en = (ve0_vs0_valid & ve0_vs0_ready) | (ve0_vs1_valid & ve0_vs1_ready) | (ve0_vs2_valid & ve0_vs2_ready) | (ve0_vs3_valid & ve0_vs3_ready) | ve0_kill;
        assign ve0_dummy_nx = (~ve0_valid_clr & ~ve0_kill & (ve0_dummy_r | (ve0_vd_len == 3'b000) & ve0_vsx_consumed_cnt[0])) | (~ve0_valid_clr & ~ve0_kill & (ve0_dummy_r | (ve0_vd_len == 3'b001) & (&ve0_vsx_consumed_cnt[1:0]))) | (~ve0_valid_clr & ~ve0_kill & (ve0_dummy_r | (ve0_vd_len == 3'b011) & (&ve0_vsx_consumed_cnt[2:0]))) | (~ve0_valid_clr & ~ve0_kill & (ve0_dummy_r | (ve0_vd_len == 3'b111) & (&ve0_vsx_consumed_cnt[3:0])));
    end
endgenerate
genvar lane;
genvar lane4;
genvar itr;
generate
    for (lane = 0; lane < LANE_NUM; lane = lane + 1) begin:gen_ve0_lane
        wire [(ELEN - 1):0] ve0_lane_v0t = ve0_v0t[{ve0_d_id,lane[(LANE_ID_BITS - 1):0]} * ELEN +:ELEN];
        assign ve0_vs2_unmasked_data[lane] = ve0_vs2_data[lane * ELEN +:ELEN];
        wire [(ELEN - 1):0] ve0_vs2_viota_data_sew8;
        wire [(ELEN - 1):0] ve0_vs2_viota_data_sew16;
        wire [(ELEN - 1):0] ve0_vs2_viota_data_sew32;
        wire [(ELEN - 1):0] ve0_vs2_viota_data_sew64;
        wire [(ELEN - 1):0] ve0_vs2_viota_v0t_sew8;
        wire [(ELEN - 1):0] ve0_vs2_viota_v0t_sew16;
        wire [(ELEN - 1):0] ve0_vs2_viota_v0t_sew32;
        wire [(ELEN - 1):0] ve0_vs2_viota_v0t_sew64;
        for (itr = 0; itr < ELEN / 8; itr = itr + 1) begin:gen_viota_data_sew8
            assign ve0_vs2_viota_data_sew8[itr * 8 +:8] = ve0_ctrl[10] ? {8{1'b1}} : ve0_vs2_data[itr * LANE_NUM * 8 + lane * 8 +:8];
            assign ve0_vs2_viota_v0t_sew8[itr * 8 +:8] = ve0_v0t[itr * LANE_NUM * 8 + lane * 8 + (ve0_d_id * DLEN) +:8];
        end
        for (itr = 0; itr < ELEN / 4; itr = itr + 1) begin:gen_viota_data_sew16
            assign ve0_vs2_viota_data_sew16[itr * 4 +:4] = ve0_ctrl[10] ? {4{1'b1}} : ve0_vs2_data[itr * LANE_NUM * 4 + lane * 4 +:4];
            assign ve0_vs2_viota_v0t_sew16[itr * 4 +:4] = ve0_v0t[itr * LANE_NUM * 4 + lane * 4 + (ve0_d_id * DLEN) +:4];
        end
        for (itr = 0; itr < ELEN / 2; itr = itr + 1) begin:gen_viota_data_sew32
            assign ve0_vs2_viota_data_sew32[itr * 2 +:2] = ve0_ctrl[10] ? {2{1'b1}} : ve0_vs2_data[itr * LANE_NUM * 2 + lane * 2 +:2];
            assign ve0_vs2_viota_v0t_sew32[itr * 2 +:2] = ve0_v0t[itr * LANE_NUM * 2 + lane * 2 + (ve0_d_id * DLEN) +:2];
        end
        for (itr = 0; itr < ELEN; itr = itr + 1) begin:gen_viota_data_sew64
            assign ve0_vs2_viota_data_sew64[itr * 1 +:1] = ve0_ctrl[10] ? 1'b1 : ve0_vs2_data[itr * LANE_NUM * 1 + lane * 1 +:1];
            assign ve0_vs2_viota_v0t_sew64[itr * 1 +:1] = ve0_v0t[itr * LANE_NUM * 1 + lane * 1 + (ve0_d_id * DLEN) +:1];
        end
        assign ve0_vs2_viota_unmasked_data[lane] = ({ELEN{(ve0_ctrl[7 +:2] == 2'b11)}} & ve0_vs2_viota_data_sew64) | ({ELEN{(ve0_ctrl[7 +:2] == 2'b10)}} & ve0_vs2_viota_data_sew32) | ({ELEN{(ve0_ctrl[7 +:2] == 2'b01)}} & ve0_vs2_viota_data_sew16) | ({ELEN{(ve0_ctrl[7 +:2] == 2'b00)}} & ve0_vs2_viota_data_sew8);
        assign ve0_vs2_viota_v0t_data[lane] = ({ELEN{(ve0_ctrl[7 +:2] == 2'b11)}} & ve0_vs2_viota_v0t_sew64) | ({ELEN{(ve0_ctrl[7 +:2] == 2'b10)}} & ve0_vs2_viota_v0t_sew32) | ({ELEN{(ve0_ctrl[7 +:2] == 2'b01)}} & ve0_vs2_viota_v0t_sew16) | ({ELEN{(ve0_ctrl[7 +:2] == 2'b00)}} & ve0_vs2_viota_v0t_sew8);
        assign ve0_vs2_viota_masked_data[lane] = ve0_vs2_viota_v0t_data[lane] & ve0_vs2_viota_unmasked_data[lane];
        wire [8:0] lane_viota_carry_in;
        wire lane_vfirst_has_1;
        if (lane == 0) begin:gen_lane_has_1_in_0
            assign lane_vfirst_has_1 = ~ve0_first & (ve2_id == ve0_id) & ve2_vfirst_has_1;
        end
        else begin:gen_lane_has_1_in_n
            assign lane_vfirst_has_1 = (~ve0_first & (ve2_id == ve0_id) & ve2_vfirst_has_1) | (|ve0_vfirst_has_1[lane - 1:0]);
        end
        kv_vmask_ve0 #(
            .VLEN(VLEN),
            .DLEN(DLEN),
            .ELEN(ELEN)
        ) u_ve0 (
            .ve0_lane_id(lane[(LANE_ID_BITS - 1):0]),
            .ve0_d_id(ve0_d_id),
            .ve0_v_id(ve0_vsx_consumed_cnt),
            .ve0_ctrl(ve0_ctrl),
            .ve0_v0t(ve0_lane_v0t),
            .ve0_vs3_data(ve0_vs3_data[lane * ELEN +:ELEN]),
            .ve0_vs2_unmasked_data(ve0_vs2_unmasked_data[lane]),
            .ve0_vs2_viota_unmasked_data(ve0_vs2_viota_unmasked_data[lane]),
            .ve0_vs2_viota_masked_data(ve0_vs2_viota_masked_data[lane]),
            .ve0_vs2_viota_v0t(ve0_vs2_viota_v0t_data[lane]),
            .ve0_vs1_data(ve0_vs1_data[lane * ELEN +:ELEN]),
            .ve2_vfirst_has_1(lane_vfirst_has_1),
            .ve2_vd_wdata(ve0_vd_wdata[lane * ELEN +:ELEN]),
            .ve1_vfirst_wdata(ve0_vfirst_wdata[lane]),
            .ve1_vfirst_has_1(ve0_vfirst_has_1[lane]),
            .ve1_viota_wdata(ve0_viota_wdata[lane]),
            .ve1_viota_wmask(ve0_viota_wmask[lane]),
            .ve1_viota_carry_in(lane_viota_carry_in),
            .ve1_viota_carry_out(ve0_viota_carry_out[lane]),
            .ve1_vpopc_carry_out(ve0_vpopc_carry_out[lane])
        );
        assign lane_viota_carry_in = 9'b0;
    end
endgenerate
assign ve1_valid_set = ve0_to_ve1_valid & ~ve0_kill & ve1_to_ve0_ready;
assign ve1_valid_clr = ve1_valid & ve1_ready | ve1_kill;
assign ve1_valid_en = ve1_valid_set | ve1_valid_clr;
assign ve1_valid_nx = ve1_valid_set;
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve1_valid <= 1'b0;
        ve1_first <= 1'b1;
    end
    else if (ve1_valid_en) begin
        ve1_valid <= ve1_valid_nx;
        ve1_first <= ve0_first;
    end
end

generate
    if (RAR_SUPPORT) begin:gen_ve1_ctrl_w_reset
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve1_vfirst <= 1'b0;
                ve1_viota <= 1'b0;
                ve1_vpopc <= 1'b0;
                ve1_idx <= 1'b0;
                ve1_sew <= 1'b0;
                ve1_d_id <= {D_ID_BITS{1'b0}};
                ve1_last <= 1'b0;
                ve1_dummy <= 1'b0;
            end
            else if (ve1_valid_set) begin
                ve1_vfirst <= ve0_ctrl[9];
                ve1_viota <= ve0_ctrl[11] | ve0_ctrl[10];
                ve1_vpopc <= ve0_ctrl[27];
                ve1_idx <= ve0_ctrl[1 +:5];
                ve1_sew <= ve0_ctrl[7 +:2];
                ve1_d_id <= ve0_d_id;
                ve1_last <= ve0_ready;
                ve1_dummy <= ve0_dummy;
            end
        end

    end
    else begin:gen_ve1_ctrl_wo_reset
        always @(posedge vpu_vmask_clk) begin
            if (ve1_valid_set) begin
                ve1_vfirst <= ve0_ctrl[9];
                ve1_viota <= ve0_ctrl[11] | ve0_ctrl[10];
                ve1_vpopc <= ve0_ctrl[27];
                ve1_idx <= ve0_ctrl[1 +:5];
                ve1_sew <= ve0_ctrl[7 +:2];
                ve1_d_id <= ve0_d_id;
                ve1_last <= ve0_ready;
                ve1_dummy <= ve0_dummy;
            end
        end

    end
endgenerate
generate
    for (lane = 0; lane < LANE_NUM; lane = lane + 1) begin:gen_ve1_lane
        if (RAR_SUPPORT) begin:gen_ve1_lane_w_reset
            always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    ve1_vfirst_rdata[lane] <= {CARRY_WIDTH{1'b0}};
                    ve1_vfirst_has_1[lane] <= 1'b0;
                    ve1_viota_rdata[lane] <= {ELEN{1'b0}};
                    ve1_viota_rmask[lane] <= {(ELEN / 8){1'b0}};
                    ve1_vpopc_carry_in[lane] <= {(CARRY_WIDTH + 1){1'b0}};
                end
                else if (ve1_valid_set) begin
                    ve1_vfirst_rdata[lane] <= ve0_vfirst_wdata[lane];
                    ve1_vfirst_has_1[lane] <= ve0_vfirst_has_1[lane];
                    ve1_viota_rdata[lane] <= ve0_viota_wdata[lane];
                    ve1_viota_rmask[lane] <= ve0_viota_wmask[lane];
                    ve1_vpopc_carry_in[lane] <= ve0_vpopc_carry_out[lane];
                end
            end

        end
        else begin:gen_ve1_lane_wo_reset
            always @(posedge vpu_vmask_clk) begin
                if (ve1_valid_set) begin
                    ve1_vfirst_rdata[lane] <= ve0_vfirst_wdata[lane];
                    ve1_vfirst_has_1[lane] <= ve0_vfirst_has_1[lane];
                    ve1_viota_rdata[lane] <= ve0_viota_wdata[lane];
                    ve1_viota_rmask[lane] <= ve0_viota_wmask[lane];
                    ve1_vpopc_carry_in[lane] <= ve0_vpopc_carry_out[lane];
                end
            end

        end
    end
    for (lane = 0; lane < LANE_NUM; lane = lane + 1) begin:gen_lane_viota_carry_in
        if (RAR_SUPPORT) begin:gen_lane_viota_carry_in_w_reset
            always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    ve1_viota_carry_in[lane] <= 9'b0;
                end
                else if (ve1_valid_set) begin
                    ve1_viota_carry_in[lane] <= ve0_viota_carry_out[lane];
                end
            end

        end
        else begin:gen_lane_viota_carry_in_wo_reset
            always @(posedge vpu_vmask_clk) begin
                if (ve1_valid_set) begin
                    ve1_viota_carry_in[lane] <= ve0_viota_carry_out[lane];
                end
            end

        end
    end
endgenerate
genvar viota_cycle;
generate
    for (viota_cycle = 0; viota_cycle < VIOTA_CYCLE; viota_cycle = viota_cycle + 1) begin:gen_lane_viota_data_outter
        for (lane = 0; lane < (LANE_NUM / VIOTA_CYCLE); lane = lane + 1) begin:gen_lane_viota_data_inner
            reg [(ELEN - 1):0] ve1_viota_data_sew8;
            reg [(ELEN - 1):0] ve1_viota_data_sew16;
            reg [(ELEN - 1):0] ve1_viota_data_sew32;
            reg [(ELEN - 1):0] ve1_viota_data_sew64;
            wire [8:0] lane_viota_carry_init;
            reg [8:0] lane_viota_carry;
            reg [(ELEN / 8) - 1:0] nds_unused_ve1_viota_data_sew8;
            reg [(ELEN / 16) - 1:0] nds_unused_ve1_viota_data_sew16;
            reg [(ELEN / 32) - 1:0] nds_unused_ve1_viota_data_sew32;
            reg [(ELEN / 64) - 1:0] nds_unused_ve1_viota_data_sew64;
            if (VIOTA_CYCLE > 1) begin:gen_lane_viota_carry_n
                wire nds_unused_lane_viota_carry_init_c;
                assign {nds_unused_lane_viota_carry_init_c,lane_viota_carry_init} = ve2_viota_carry_out[0] + ve2_viota_carry_out[1];
            end
            else begin:gen_lane_viota_carry_1
                assign lane_viota_carry_init = ve2_viota_carry_out[0];
            end
            if (lane > 0) begin:gen_lane_viota_carry_lane_n
                integer viota_idx;
                reg nds_unused_lane_viota_carry;
                always @* begin
                    lane_viota_carry = {9{~ve1_first & (ve2_id == ve1_id)}} & lane_viota_carry_init;
                    for (viota_idx = 0; viota_idx < lane; viota_idx = viota_idx + 1) begin
                        {nds_unused_lane_viota_carry,lane_viota_carry} = lane_viota_carry + ve1_viota_carry_in[(viota_cycle * (LANE_NUM / VIOTA_CYCLE)) + viota_idx];
                    end
                end

            end
            else begin:gen_lane_viota_carry_lane_0
                always @* begin
                    lane_viota_carry = {9{~ve1_first & (ve2_id == ve1_id)}} & lane_viota_carry_init;
                end

            end
            for (itr = 0; itr < (ELEN / 8); itr = itr + 1) begin:gen_ve1_viota_data_sew8
                always @* begin
                    {nds_unused_ve1_viota_data_sew8[itr],ve1_viota_data_sew8[itr * 8 +:8]} = ve1_viota_rdata[viota_cycle * (LANE_NUM / VIOTA_CYCLE) + lane][itr * 8 +:8] + lane_viota_carry[0 +:8];
                end

            end
            for (itr = 0; itr < (ELEN / 16); itr = itr + 1) begin:gen_ve1_viota_data_sew16
                always @* begin
                    {nds_unused_ve1_viota_data_sew16[itr],ve1_viota_data_sew16[itr * 16 +:16]} = ve1_viota_rdata[viota_cycle * (LANE_NUM / VIOTA_CYCLE) + lane][itr * 16 +:16] + {{(16 - 9){1'b0}},lane_viota_carry[0 +:9]};
                end

            end
            for (itr = 0; itr < (ELEN / 32); itr = itr + 1) begin:gen_ve1_viota_data_sew32
                always @* begin
                    {nds_unused_ve1_viota_data_sew32[itr],ve1_viota_data_sew32[itr * 32 +:32]} = ve1_viota_rdata[viota_cycle * (LANE_NUM / VIOTA_CYCLE) + lane][itr * 32 +:32] + {{(32 - 8){1'b0}},lane_viota_carry[0 +:8]};
                end

            end
            for (itr = 0; itr < (ELEN / 64); itr = itr + 1) begin:gen_ve1_viota_data_sew64
                always @* begin
                    {nds_unused_ve1_viota_data_sew64[itr],ve1_viota_data_sew64[itr * 64 +:64]} = ve1_viota_rdata[viota_cycle * (LANE_NUM / VIOTA_CYCLE) + lane][itr * 64 +:64] + {{(64 - 7){1'b0}},lane_viota_carry[0 +:7]};
                end

            end
            assign ve1_vd_wdata[(viota_cycle * (LANE_NUM / VIOTA_CYCLE) * ELEN) + lane * ELEN +:ELEN] = ({ELEN{(ve1_sew == 2'b11)}} & ve1_viota_data_sew64) | ({ELEN{(ve1_sew == 2'b10)}} & ve1_viota_data_sew32) | ({ELEN{(ve1_sew == 2'b01)}} & ve1_viota_data_sew16) | ({ELEN{(ve1_sew == 2'b00)}} & ve1_viota_data_sew8);
            assign ve1_vd_wmask[(viota_cycle * (LANE_NUM / VIOTA_CYCLE) * (ELEN / 8)) + lane * (ELEN / 8) +:(ELEN / 8)] = ve1_viota_rmask[(viota_cycle * (LANE_NUM / VIOTA_CYCLE)) + lane];
        end
    end
endgenerate
generate
    for (viota_cycle = 0; viota_cycle < VIOTA_CYCLE; viota_cycle = viota_cycle + 1) begin:gen_ve1_viota_carry_out
        reg [8:0] lane_viota_carry;
        reg nds_unused_lane_viota_carry;
        integer viota_idx;
        always @* begin
            nds_unused_lane_viota_carry = 1'b0;
            lane_viota_carry = {9{~ve1_first & (ve2_id == ve1_id)}} & ve2_viota_carry_out[viota_cycle];
            for (viota_idx = 0; viota_idx < (LANE_NUM / VIOTA_CYCLE); viota_idx = viota_idx + 1) begin
                {nds_unused_lane_viota_carry,lane_viota_carry} = lane_viota_carry + ve1_viota_carry_in[(viota_cycle * (LANE_NUM / VIOTA_CYCLE)) + viota_idx];
            end
        end

        assign ve1_viota_carry_out[viota_cycle] = ({9{(ve1_sew == 2'b11)}} & {2'b0,lane_viota_carry[0 +:7]}) | ({9{(ve1_sew == 2'b10)}} & {1'b0,lane_viota_carry[0 +:8]}) | ({9{(ve1_sew == 2'b01)}} & lane_viota_carry[0 +:9]) | ({9{(ve1_sew == 2'b00)}} & {1'b0,lane_viota_carry[0 +:8]});
    end
endgenerate
wire [(LANE_NUM - 1):0] ve1_vfirst_has_1_minus_1 = ve1_vfirst_has_1 - {{(LANE_NUM - 1){1'b0}},1'b1};
wire [(LANE_NUM - 1):0] ve1_vfirst_has_1_sbf = ~ve1_vfirst_has_1 & ve1_vfirst_has_1_minus_1;
wire [(LANE_NUM - 1):0] ve1_vfirst_has_1_sif = {ve1_vfirst_has_1_sbf[(LANE_NUM - 2):0],1'b1};
wire [(LANE_NUM - 1):0] ve1_vfirst_has_1_sof = ve1_vfirst_has_1_sif ^ ve1_vfirst_has_1_sbf;
wire [63:0] ve1_vfirst_wdata_has1;
wire [64 * LANE_NUM - 1:0] ve1_vfirst_idx;
generate
    for (itr = 0; itr < LANE_NUM; itr = itr + 1) begin:gen_ve1_vfirst_idx
        assign ve1_vfirst_idx[itr * 64 +:64] = {{(64 - D_ID_BITS - LANE_ID_BITS - CARRY_WIDTH){1'b0}},ve1_d_id,itr[(LANE_ID_BITS - 1):0],ve1_vfirst_rdata[itr]};
    end
endgenerate
kv_mux_onehot #(
    .N(LANE_NUM),
    .W(64)
) u_ve1_vfirst_wdata_has1 (
    .out(ve1_vfirst_wdata_has1),
    .sel(ve1_vfirst_has_1_sof),
    .in(ve1_vfirst_idx)
);
assign ve1_vfirst_wdata = (~ve1_first & (ve2_id == ve1_id) & ve2_vfirst_has_1) ? ve2_srf_data : (|ve1_vfirst_has_1) ? ve1_vfirst_wdata_has1 : {64{1'b1}};
integer vpopc_idx;
always @* begin
    {nds_unused_ve1_vpopc_wdata_carry,ve1_vpopc_wdata} = (~ve1_first & (ve2_id == ve1_id)) ? {1'b0,ve2_srf_data} : {(64 + 1){1'b0}};
    for (vpopc_idx = 0; vpopc_idx < LANE_NUM; vpopc_idx = vpopc_idx + 1) begin
        {nds_unused_ve1_vpopc_wdata_carry,ve1_vpopc_wdata} = ve1_vpopc_wdata + {{(64 - (CARRY_WIDTH + 1)){1'b0}},ve1_vpopc_carry_in[vpopc_idx]};
    end
end

assign ve1_srf_wdata = (ve1_valid & ve1_vfirst) ? ve1_vfirst_wdata : ve1_vpopc_wdata;
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve1_id <= {ID_WIDTH{1'b0}};
    end
    else if (ve1_valid_en) begin
        ve1_id <= ve0_id;
    end
end

assign ve1_commited_en = (vmask_cmt_valid & ve1_valid & (ve1_id == vmask_cmt_id)) | ve1_valid_en;
assign ve1_commited_nx = (vmask_cmt_valid & ~vmask_cmt_kill & ve1_valid & (ve1_id == vmask_cmt_id) & ~ve1_valid_clr) | (vmask_cmt_valid & ~vmask_cmt_kill & ve0_to_ve1_valid & ve1_to_ve0_ready & (ve0_id == vmask_cmt_id)) | (ve0_to_ve1_valid & ve1_to_ve0_ready & ve0_commited);
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve1_commited <= 1'b0;
    end
    else if (ve1_commited_en) begin
        ve1_commited <= ve1_commited_nx;
    end
end

assign ve1_kill = vmask_cmt_valid & vmask_cmt_kill & (ve1_id == vmask_cmt_id);
assign ve1_ready = ~ve2_valid | (ve2_valid & ve2_valid_clr);
assign ve2_valid_set = (ve1_valid & ve1_ready & ~ve1_kill) | (~ve1_valid & ve0_to_ve2_valid & ~ve0_kill & ve2_to_ve0_ready);
assign ve2_valid_clr = ve2_valid & ve2_ready | ve2_kill;
assign ve2_valid_en = ve2_valid_set | ve2_valid_clr;
assign ve2_valid_nx = ve2_valid_set;
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve2_valid <= 1'b0;
    end
    else if (ve2_valid_en) begin
        ve2_valid <= ve2_valid_nx;
    end
end

generate
    for (itr = 0; itr < VIOTA_CYCLE; itr = itr + 1) begin:gen_ve2_viota_carry_out
        if (RAR_SUPPORT) begin:gen_ve2_viota_carry_out_w_reset
            always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    ve2_viota_carry_out[itr] <= 9'b0;
                end
                else if (ve2_valid_set) begin
                    ve2_viota_carry_out[itr] <= ve1_viota_carry_out[itr];
                end
            end

        end
        else begin:gen_ve2_viota_carry_out_wo_reset
            always @(posedge vpu_vmask_clk) begin
                if (ve2_valid_set) begin
                    ve2_viota_carry_out[itr] <= ve1_viota_carry_out[itr];
                end
            end

        end
    end
endgenerate
generate
    if (RAR_SUPPORT) begin:gen_ve2_ctrl_w_reset
        always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                ve2_srf <= 1'b0;
                ve2_viota <= 1'b0;
                ve2_sew <= 2'b0;
                ve2_idx <= 5'b0;
                ve2_vd_data <= {DLEN{1'b0}};
                ve2_vd_mask <= {(DLEN / 8){1'b0}};
                ve2_srf_data <= 64'b0;
                ve2_vfirst_has_1 <= 1'b0;
                ve2_last <= 1'b0;
                ve2_dummy <= 1'b0;
            end
            else if (ve2_valid_set) begin
                ve2_srf <= ve1_valid & (ve1_vfirst | ve1_vpopc);
                ve2_viota <= ve1_valid & ve1_viota;
                ve2_sew <= ve1_sew;
                ve2_idx <= ve1_idx;
                ve2_vd_data <= ve2_vd_data_nx;
                ve2_vd_mask <= ve2_vd_mask_nx;
                ve2_srf_data <= ve2_srf_data_nx;
                ve2_vfirst_has_1 <= ve2_vfirst_has_1_nx;
                ve2_last <= ve1_valid & ve1_last;
                ve2_dummy <= ve1_valid & ve1_dummy;
            end
        end

    end
    else begin:gen_ve2_ctrl_wo_reset
        always @(posedge vpu_vmask_clk) begin
            if (ve2_valid_set) begin
                ve2_srf <= ve1_valid & (ve1_vfirst | ve1_vpopc);
                ve2_viota <= ve1_valid & ve1_viota;
                ve2_sew <= ve1_sew;
                ve2_idx <= ve1_idx;
                ve2_vd_data <= ve2_vd_data_nx;
                ve2_vd_mask <= ve2_vd_mask_nx;
                ve2_srf_data <= ve2_srf_data_nx;
                ve2_vfirst_has_1 <= ve2_vfirst_has_1_nx;
                ve2_last <= ve1_valid & ve1_last;
                ve2_dummy <= ve1_valid & ve1_dummy;
            end
        end

    end
endgenerate
assign ve2_vd_data_nx = ve1_valid ? ve1_vd_wdata : ve0_vd_wdata;
assign ve2_vd_mask_nx = ve1_valid ? ve1_vd_wmask : {(DLEN / 8){1'b1}};
assign ve2_srf_data_nx = ve1_valid ? ve1_srf_wdata : ve2_srf_data;
assign ve2_vfirst_has_1_nx = (ve1_valid & ve1_vfirst & ((~ve1_first & (ve2_id == ve1_id) & ve2_vfirst_has_1) | (|ve1_vfirst_has_1))) | (ve0_valid & ve0_ctrl[26] & ((~ve0_first & (ve2_id == ve0_id) & ve2_vfirst_has_1) | (|ve0_vfirst_has_1))) | (ve0_valid & ve0_ctrl[25] & ((~ve0_first & (ve2_id == ve0_id) & ve2_vfirst_has_1) | (|ve0_vfirst_has_1))) | (ve0_valid & ve0_ctrl[24] & ((~ve0_first & (ve2_id == ve0_id) & ve2_vfirst_has_1) | (|ve0_vfirst_has_1)));
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve2_id <= {ID_WIDTH{1'b0}};
    end
    else if (ve2_valid_en) begin
        ve2_id <= ve2_id_nx;
    end
end

assign ve2_id_nx = ve1_valid ? ve1_id : ve0_id;
assign ve2_commited_en = (vmask_cmt_valid & ve2_valid & (ve2_id == vmask_cmt_id)) | ve2_valid_en;
assign ve2_commited_nx = (vmask_cmt_valid & ~vmask_cmt_kill & ve2_valid & (ve2_id == vmask_cmt_id) & ~ve2_valid_clr) | (vmask_cmt_valid & ~vmask_cmt_kill & ve0_to_ve2_valid & ve2_to_ve0_ready & (ve0_id == vmask_cmt_id)) | (ve0_to_ve2_valid & ve2_to_ve0_ready & ve0_commited) | (vmask_cmt_valid & ~vmask_cmt_kill & ve1_valid & ve1_ready & (ve1_id == vmask_cmt_id)) | (ve1_valid & ve1_ready & ve1_commited);
always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        ve2_commited <= 1'b0;
    end
    else if (ve2_commited_en) begin
        ve2_commited <= ve2_commited_nx;
    end
end

assign ve2_kill = vmask_cmt_valid & vmask_cmt_kill & (ve2_id == vmask_cmt_id);
assign ve2_ready = (ve2_commited | (vmask_cmt_valid & ~vmask_cmt_kill & ve2_valid & (ve2_id == vmask_cmt_id))) & (ve2_srf ? srf_buf_i_ready : vd_buf_i_ready);
generate
    if (VIOTA_CYCLE == 1) begin:gen_ve2_vd_data_final_bypass
        wire nds_unused_ve2_viota = ve2_viota;
        assign ve2_vd_data_final = ve2_vd_data;
        wire [1:0] nds_unused_ve2_sew = ve2_sew;
    end
    else begin:gen_ve2_vd_data_final_viota
        wire [8:0] ve1_viota_carry_wo_ve2;
        reg [8:0] ve2_viota_carry_wo_ve2;
        reg [8:0] lane_viota_carry;
        reg nds_unused_lane_viota_carry;
        integer viota_idx;
        always @* begin
            nds_unused_lane_viota_carry = 1'b0;
            lane_viota_carry = 9'b0;
            for (viota_idx = 0; viota_idx < (LANE_NUM / VIOTA_CYCLE); viota_idx = viota_idx + 1) begin
                {nds_unused_lane_viota_carry,lane_viota_carry} = lane_viota_carry + ve1_viota_carry_in[viota_idx];
            end
        end

        assign ve1_viota_carry_wo_ve2 = ({9{(ve1_sew == 2'b11)}} & {2'b0,lane_viota_carry[0 +:7]}) | ({9{(ve1_sew == 2'b10)}} & {1'b0,lane_viota_carry[0 +:8]}) | ({9{(ve1_sew == 2'b01)}} & lane_viota_carry[0 +:9]) | ({9{(ve1_sew == 2'b00)}} & {1'b0,lane_viota_carry[0 +:8]});
        if (RAR_SUPPORT) begin:gen_ve2_viota_carry_wo_ve2_w_reset
            always @(posedge vpu_vmask_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    ve2_viota_carry_wo_ve2 <= 9'b0;
                end
                else if (ve2_valid_set) begin
                    ve2_viota_carry_wo_ve2 <= ve1_viota_carry_wo_ve2;
                end
            end

        end
        else begin:gen_ve2_viota_carry_wo_ve2_wo_reset
            always @(posedge vpu_vmask_clk) begin
                if (ve2_valid_set) begin
                    ve2_viota_carry_wo_ve2 <= ve1_viota_carry_wo_ve2;
                end
            end

        end
        assign ve2_vd_data_final[(DLEN / 2) - 1:0] = ve2_vd_data[(DLEN / 2) - 1:0];
        for (lane = 0; lane < (LANE_NUM / VIOTA_CYCLE); lane = lane + 1) begin:gen_lane_ve2_vd_data_final_viota
            reg [(ELEN - 1):0] ve2_viota_data_sew8;
            reg [(ELEN - 1):0] ve2_viota_data_sew16;
            reg [(ELEN - 1):0] ve2_viota_data_sew32;
            reg [(ELEN - 1):0] ve2_viota_data_sew64;
            reg [(ELEN / 8) - 1:0] nds_unused_ve2_viota_data_sew8;
            reg [(ELEN / 16) - 1:0] nds_unused_ve2_viota_data_sew16;
            reg [(ELEN / 32) - 1:0] nds_unused_ve2_viota_data_sew32;
            reg [(ELEN / 64) - 1:0] nds_unused_ve2_viota_data_sew64;
            for (itr = 0; itr < (ELEN / 8); itr = itr + 1) begin:gen_ve2_viota_data_sew8
                always @* begin
                    {nds_unused_ve2_viota_data_sew8[itr],ve2_viota_data_sew8[itr * 8 +:8]} = ve2_vd_data[(DLEN / VIOTA_CYCLE) + (lane * ELEN) + itr * 8 +:8] + ve2_viota_carry_wo_ve2[0 +:8];
                end

            end
            for (itr = 0; itr < (ELEN / 16); itr = itr + 1) begin:gen_ve2_viota_data_sew16
                always @* begin
                    {nds_unused_ve2_viota_data_sew16[itr],ve2_viota_data_sew16[itr * 16 +:16]} = ve2_vd_data[(DLEN / VIOTA_CYCLE) + (lane * ELEN) + itr * 16 +:16] + {{(16 - 9){1'b0}},ve2_viota_carry_wo_ve2[0 +:9]};
                end

            end
            for (itr = 0; itr < (ELEN / 32); itr = itr + 1) begin:gen_ve2_viota_data_sew32
                always @* begin
                    {nds_unused_ve2_viota_data_sew32[itr],ve2_viota_data_sew32[itr * 32 +:32]} = ve2_vd_data[(DLEN / VIOTA_CYCLE) + (lane * ELEN) + itr * 32 +:32] + {{(32 - 8){1'b0}},ve2_viota_carry_wo_ve2[0 +:8]};
                end

            end
            for (itr = 0; itr < (ELEN / 64); itr = itr + 1) begin:gen_ve2_viota_data_sew64
                always @* begin
                    {nds_unused_ve2_viota_data_sew64[itr],ve2_viota_data_sew64[itr * 64 +:64]} = ve2_vd_data[(DLEN / VIOTA_CYCLE) + (lane * ELEN) + itr * 64 +:64] + {{(64 - 7){1'b0}},ve2_viota_carry_wo_ve2[0 +:7]};
                end

            end
            assign ve2_vd_data_final[((DLEN / 2) + lane * ELEN) +:ELEN] = ({ELEN{ve2_viota}} & {ELEN{(ve2_sew == 2'b11)}} & ve2_viota_data_sew64) | ({ELEN{ve2_viota}} & {ELEN{(ve2_sew == 2'b10)}} & ve2_viota_data_sew32) | ({ELEN{ve2_viota}} & {ELEN{(ve2_sew == 2'b01)}} & ve2_viota_data_sew16) | ({ELEN{ve2_viota}} & {ELEN{(ve2_sew == 2'b00)}} & ve2_viota_data_sew8) | ({ELEN{~ve2_viota}} & ve2_vd_data[((DLEN / 2) + lane * ELEN) +:ELEN]);
        end
    end
endgenerate
kv_eb_full_o #(
    .DW((DLEN / 8) + DLEN)
) u_vd_buf (
    .clk(vpu_vmask_clk),
    .resetn(vpu_reset_n),
    .clk_en(1'b1),
    .i_valid(vd_buf_i_valid),
    .i_ready(vd_buf_i_ready),
    .din({ve2_vd_mask,ve2_vd_data_final}),
    .o_valid(vmask_vd_wvalid),
    .o_ready(vmask_vd_wready),
    .dout({vmask_vd_wmask,vmask_vd_wdata})
);
kv_eb_full_o #(
    .DW(64 + 5)
) u_srf_buf (
    .clk(vpu_vmask_clk),
    .resetn(vpu_reset_n),
    .clk_en(1'b1),
    .i_valid(srf_buf_i_valid),
    .i_ready(srf_buf_i_ready),
    .din({ve2_idx,ve2_srf_data}),
    .o_valid(vmask_srf_wvalid),
    .o_ready(vmask_srf_wready),
    .dout({vmask_srf_waddr,vmask_srf_wdata})
);
assign vd_buf_i_valid = (ve2_commited | (vmask_cmt_valid & ~vmask_cmt_kill & ve2_valid & (ve2_id == vmask_cmt_id))) & (ve2_valid & ~ve2_srf & ~ve2_dummy);
assign srf_buf_i_valid = (ve2_commited | (vmask_cmt_valid & ~vmask_cmt_kill & ve2_valid & (ve2_id == vmask_cmt_id))) & (ve2_valid & ve2_srf & ve2_last);
assign vmask_standby_ready = ~ve0_dispatch_valid & ~ve0_valid & ~ve1_valid & ~ve2_valid & ~vmask_vd_wvalid & ~vmask_srf_wvalid;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

