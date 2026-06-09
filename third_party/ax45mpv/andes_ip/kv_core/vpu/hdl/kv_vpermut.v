// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vpermut (
    vpu_vpermut_clk,
    vpu_reset_n,
    vpermut_standby_ready,
    vpermut_dispatch_valid,
    vpermut_dispatch_op1,
    vpermut_dispatch_ctrl,
    vpermut_dispatch_v0t,
    vpermut_dispatch_op1_hazard,
    vpermut_dispatch_vs1_len,
    vpermut_dispatch_vs2_len,
    vpermut_dispatch_vd_len,
    vpermut_dispatch_ready,
    vpermut_cmt_valid,
    vpermut_cmt_kill,
    vpermut_cmt_op1,
    vpermut_vs1_rdata,
    vpermut_vs1_rready,
    vpermut_vs1_rvalid,
    vpermut_vs2_rdata,
    vpermut_vs2_rready,
    vpermut_vs2_rvalid,
    vpermut_vd_wvalid,
    vpermut_vd_wready,
    vpermut_vd_wdata,
    vpermut_vd_wmask,
    vpermut_srf_wvalid,
    vpermut_srf_wready,
    vpermut_srf_wfrf,
    vpermut_srf_waddr,
    vpermut_srf_wdata
);
parameter VLEN = 512;
parameter DLEN = 512;
parameter VPERMUT_DLEN = 512;
parameter VRF_LW = 3;
parameter RAR_SUPPORT = 0;
parameter VECTOR_SINT_SUPPORT_INT = 1;
localparam VP_LEN = VPERMUT_DLEN;
localparam VD_IDXW = (VLEN == 128) ? 7 : (VLEN == 256) ? 8 : (VLEN == 512) ? 9 : 10;
localparam VP_IDXW = (VLEN == 128) ? 7 : (VLEN == 256) ? 8 : (VLEN == 512) ? 9 : 10;
localparam VLBW = (VLEN == 128) ? 4 : (VLEN == 256) ? 5 : (VLEN == 512) ? 6 : 7;
localparam VPBW = (VP_LEN == 128) ? 4 : (VP_LEN == 256) ? 5 : (VP_LEN == 512) ? 6 : 7;
localparam VD_RATIO = VLEN / DLEN;
localparam DP_RATIO = DLEN / VP_LEN;
localparam VP_RATIO = VLEN / VP_LEN;
localparam VD_RATIO_IDX = $clog2(VD_RATIO);
localparam VP_RATIO_IDX = $clog2(VP_RATIO);
localparam DP_RATIO_IDX = $clog2(DP_RATIO);
localparam VS1_LEN = VP_RATIO == 1 ? 2 * VLEN : VLEN;
localparam VS1_RATIO = VP_RATIO == 4 ? 4 : 2;
localparam VS1_RATIO_IDX = $clog2(VS1_RATIO);
localparam VP_WEW = 8 * VP_RATIO;
localparam CMT_DEP_IDX = 2;
localparam XLEN = 64;
localparam BYPASS_DW = 41 + VLEN + VRF_LW * 3 + CMT_DEP_IDX;
localparam IDLE = 0;
localparam VSLIDEUP = 1;
localparam VSLIDEDN = 2;
localparam VRGATHER = 3;
localparam VCOMPRESS = 4;
localparam VMV_SFX = 5;
localparam VMV_FXS = 6;
localparam VMV_NR = 7;
localparam VZSEXT = 8;
localparam STATES = 9;
input vpu_vpermut_clk;
input vpu_reset_n;
output vpermut_standby_ready;
input vpermut_dispatch_valid;
input [XLEN - 1:0] vpermut_dispatch_op1;
input [(41 - 1):0] vpermut_dispatch_ctrl;
input [VLEN - 1:0] vpermut_dispatch_v0t;
input vpermut_dispatch_op1_hazard;
input [VRF_LW - 1:0] vpermut_dispatch_vs1_len;
input [VRF_LW - 1:0] vpermut_dispatch_vs2_len;
input [VRF_LW - 1:0] vpermut_dispatch_vd_len;
output vpermut_dispatch_ready;
input vpermut_cmt_valid;
input vpermut_cmt_kill;
input [XLEN - 1:0] vpermut_cmt_op1;
input [(DLEN - 1):0] vpermut_vs1_rdata;
output vpermut_vs1_rready;
input vpermut_vs1_rvalid;
input [(DLEN - 1):0] vpermut_vs2_rdata;
output vpermut_vs2_rready;
input vpermut_vs2_rvalid;
output vpermut_vd_wvalid;
input vpermut_vd_wready;
output [DLEN - 1:0] vpermut_vd_wdata;
output [(DLEN / 8) - 1:0] vpermut_vd_wmask;
output vpermut_srf_wvalid;
input vpermut_srf_wready;
output vpermut_srf_wfrf;
output [4:0] vpermut_srf_waddr;
output [63:0] vpermut_srf_wdata;





// 08e15e58 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [CMT_DEP_IDX - 1:0] dis_id;
wire [CMT_DEP_IDX - 1:0] cmt_id;
wire nds_unused_cmt_rready;
wire cmt_wready;
wire dis_ready;
wire dis_valid = vpermut_dispatch_valid & cmt_wready;
wire dis_grant = vpermut_dispatch_valid & dis_ready;
wire vpermut_dispatch_ready = dis_ready & cmt_wready;
wire cmt_valid = vpermut_cmt_valid;
wire cmt_kill = vpermut_cmt_kill;
wire cmt_kill_valid = cmt_valid & cmt_kill;
reg [XLEN - 1:0] buf_op1;
reg buf_op1_hazard;
wire [CMT_DEP_IDX - 1:0] req_id;
wire [XLEN - 1:0] req_op1;
wire [(41 - 1):0] req_ctrl;
wire [VLEN - 1:0] req_v0t;
wire req_op1_hazard;
wire [VRF_LW - 1:0] req_vs1_len;
wire [VRF_LW - 1:0] req_vs2_len;
wire [VRF_LW - 1:0] req_vd_len;
wire [3:0] req_sew_onehot;
wire [7:0] req_lmul_onehot;
wire [4:0] req_rd_addr = req_ctrl[2 +:5];
wire [2:0] req_lmul = req_rd_addr[4 -:3];
wire [1:0] req_zsext_idx = req_rd_addr[0 +:2];
wire [1:0] req_sew = req_ctrl[7 +:2];
wire [9:0] req_vstart = req_ctrl[30 +:10];
wire [10:0] req_vl = req_ctrl[11 +:11];
wire req_vs1 = req_ctrl[27];
wire req_sub_func = req_ctrl[9];
wire req_float = req_ctrl[0];
wire req_fp_mode = req_ctrl[1];
wire req_vslideup = req_ctrl[29];
wire req_vslidedn = req_ctrl[28];
wire req_vrgather = req_ctrl[26];
wire req_vcompress = req_ctrl[10];
wire req_vmv_sfx = req_ctrl[25];
wire req_vmv_fxs = req_ctrl[23];
wire req_vmv_nr = req_ctrl[24];
wire req_vzsext = req_ctrl[40];
wire [VLEN - 1:0] req_v0_mask = {VLEN{req_ctrl[22]}} | req_v0t;
reg [STATES - 1:0] fsm_cs;
reg [STATES - 1:0] fsm_ns;
reg fsm_en;
reg fsm_sub_func;
reg fsm_float;
reg fsm_fp_mode;
wire fsm_done;
reg [9:0] fsm_vstart;
reg [10:0] fsm_vl;
reg fsm_vs1;
reg [VRF_LW - 1:0] fsm_vs1_len;
reg [VRF_LW - 1:0] fsm_vs2_len;
reg [VRF_LW - 1:0] fsm_vd_len;
reg [VLEN - 1:0] fsm_v0_mask8;
wire [VLEN - 1:0] fsm_v0_mask16;
wire [VLEN - 1:0] fsm_v0_mask32;
wire [VLEN - 1:0] fsm_v0_mask64;
reg fsm_op1_hazard;
wire e0b_vrgather_vd_buf_valid;
wire fsm_idle = fsm_cs[IDLE];
wire fsm_vrgatherei16 = fsm_cs[VRGATHER] & ~e0b_vrgather_vd_buf_valid & fsm_sub_func & fsm_vs1;
wire fsm_vrgather_vv = fsm_cs[VRGATHER] & ~e0b_vrgather_vd_buf_valid & ~fsm_sub_func & fsm_vs1;
wire fsm_vrgather_vxi = fsm_cs[VRGATHER] & ~e0b_vrgather_vd_buf_valid & ~fsm_op1_hazard & ~fsm_sub_func & ~fsm_vs1;
wire fsm_vslideup = fsm_cs[VSLIDEUP] & ~e0b_vrgather_vd_buf_valid & ~fsm_op1_hazard;
wire fsm_vslidedn = fsm_cs[VSLIDEDN] & ~e0b_vrgather_vd_buf_valid & ~fsm_op1_hazard;
wire fsm_vmv_sfx = fsm_cs[VMV_SFX] & ~e0b_vrgather_vd_buf_valid & ~fsm_op1_hazard;
wire fsm_vmv_fxs = fsm_cs[VMV_FXS] & ~e0b_vrgather_vd_buf_valid;
wire fsm_vmv_nr = fsm_cs[VMV_NR] & ~e0b_vrgather_vd_buf_valid;
wire fsm_vcompress = fsm_cs[VCOMPRESS] & ~e0b_vrgather_vd_buf_valid;
wire fsm_vzsext = fsm_cs[VZSEXT] & ~e0b_vrgather_vd_buf_valid;
wire fsm_vsext = fsm_cs[VZSEXT] & ~e0b_vrgather_vd_buf_valid & fsm_sub_func;
wire fsm_vfxi = fsm_cs[VMV_SFX] | fsm_cs[VSLIDEUP] | fsm_cs[VSLIDEDN] | (fsm_cs[VRGATHER] & ~fsm_sub_func & ~fsm_vs1);
wire req_valid;
wire req_ready;
reg req_committed;
wire req_kill = cmt_kill_valid & ~req_committed & (req_id == cmt_id);
wire req_cmt = cmt_valid & ~req_committed & (req_id == cmt_id);
wire req_grant;
wire [VLEN - 1:0] vstart_mask8;
wire [VLEN - 1:0] fsm_vstart_mask8;
wire vstart_sew8_high_gt_1;
wire [2 * VLEN - 1:0] vl_onehot8;
wire [VLEN - 1:0] vl_mask8;
wire [VLEN - 1:0] fsm_vl_mask8;
wire [VLEN - 1:0] fsm_vl_emask8;
wire [VLEN / 2 - 1:0] vstart_mask16;
wire [VLEN - 1:0] fsm_vstart_mask16;
wire [VLEN - 1:0] vl_onehot16;
wire [VLEN / 2 - 1:0] vl_mask16;
wire [VLEN - 1:0] fsm_vl_mask16;
wire [VLEN - 1:0] fsm_vl_emask16;
wire [VLEN / 4 - 1:0] vstart_mask32;
wire [VLEN - 1:0] fsm_vstart_mask32;
wire [VLEN / 2 - 1:0] vl_onehot32;
wire [VLEN / 4 - 1:0] vl_mask32;
wire [VLEN - 1:0] fsm_vl_mask32;
wire [VLEN - 1:0] fsm_vl_emask32;
wire [VLEN - 1:0] fsm_vstart_mask64;
wire [VLEN / 4 - 1:0] vl_onehot64;
wire [VLEN / 8 - 1:0] vl_mask64;
wire [VLEN / 8 - 1:0] vstart_mask64;
wire [VLEN - 1:0] fsm_vl_mask64;
wire [VLEN - 1:0] fsm_vl_emask64;
wire vd_wready;
wire vs2_rready;
wire vs1_rready;
wire [(DLEN - 1):0] vs2_rdata;
wire [(DLEN - 1):0] vs1_rdata;
wire vs2_vl_last;
wire vs1_vl_last;
wire vd_vl_last;
wire vd_dlen_last;
wire vs2_rready_en;
wire vs1_rready_en;
wire vd_idx_le_len;
wire vd_idx_eq_len;
wire una_vd_idx_le_len;
wire una_vd_idx_eq_len;
wire dl_vd_idx_le_len;
wire dl_vd_idx_eq_len;
reg [CMT_DEP_IDX - 1:0] fsm_id;
reg [7:0] fsm_lmul_onehot;
reg [3:0] fsm_sew_onehot;
reg [1:0] fsm_sew;
reg [4:0] fsm_rd_addr;
reg [XLEN - 1:0] fsm_op1;
reg [XLEN + 2:0] fsm_offsetb;
wire fsm_offsetb_lt_lmul;
wire fsm_offsetb_remainder;
reg fsm_vzsext_eew4x2;
reg fsm_vzsext_eew4x4;
reg fsm_vzsext_eew4x8;
reg fsm_vzsext_eew8x2;
reg fsm_vzsext_eew8x4;
reg fsm_vzsext_eew8x8;
reg fsm_vzsext_eew16x2;
reg fsm_vzsext_eew16x4;
reg fsm_vzsext_eew32x2;
reg fsm_committed;
wire fsm_kill = cmt_kill_valid & ~fsm_committed & (fsm_id == cmt_id);
wire fsm_cmt = cmt_valid & ~fsm_committed & (fsm_id == cmt_id);
wire [VLEN - 1:0] fsm_lmul_mask = ({VLEN / 01{fsm_lmul_onehot[3]}} | {{VLEN - VLEN / 02{1'b0}},{VLEN / 02{fsm_lmul_onehot[2]}}} | {{VLEN - VLEN / 04{1'b0}},{VLEN / 04{fsm_lmul_onehot[1]}}} | {{VLEN - VLEN / 08{1'b0}},{VLEN / 08{fsm_lmul_onehot[0]}}} | {{VLEN - VLEN / 16{1'b0}},{VLEN / 16{fsm_lmul_onehot[7]}}} | {{VLEN - VLEN / 32{1'b0}},{VLEN / 32{fsm_lmul_onehot[6]}}} | {{VLEN - VLEN / 64{1'b0}},{VLEN / 64{fsm_lmul_onehot[5]}}});
wire [VLEN - 1:0] lmul_mask_sew64_mf8;
wire [VLEN - 1:0] lmul_mask_sew64_mf4;
wire [VLEN - 1:0] lmul_mask_sew32_mf8;
generate
    if (VLEN == 128) begin:gen_vs1_mask128
        assign lmul_mask_sew64_mf4 = {{VLEN - VLEN / 128{1'b0}},{VLEN / 128{fsm_lmul_onehot[6]}}};
        assign lmul_mask_sew64_mf8 = {{VLEN - VLEN / 128{1'b0}},{VLEN / 128{fsm_lmul_onehot[5]}}};
        assign lmul_mask_sew32_mf8 = {{VLEN - VLEN / 128{1'b0}},{VLEN / 128{fsm_lmul_onehot[5]}}};
    end
    else if (VLEN == 256) begin:gen_vs1_mask256
        assign lmul_mask_sew64_mf4 = {{VLEN - VLEN / 256{1'b0}},{VLEN / 256{fsm_lmul_onehot[6]}}};
        assign lmul_mask_sew64_mf8 = {{VLEN - VLEN / 256{1'b0}},{VLEN / 256{fsm_lmul_onehot[5]}}};
        assign lmul_mask_sew32_mf8 = {{VLEN - VLEN / 256{1'b0}},{VLEN / 256{fsm_lmul_onehot[5]}}};
    end
    else begin:gen_vs1_mask_gt_256
        assign lmul_mask_sew64_mf4 = {{VLEN - VLEN / 256{1'b0}},{VLEN / 256{fsm_lmul_onehot[6]}}};
        assign lmul_mask_sew64_mf8 = {{VLEN - VLEN / 512{1'b0}},{VLEN / 512{fsm_lmul_onehot[5]}}};
        assign lmul_mask_sew32_mf8 = {{VLEN - VLEN / 256{1'b0}},{VLEN / 256{fsm_lmul_onehot[5]}}};
    end
endgenerate
wire [VLEN - 1:0] fsm_lmul_mask8 = fsm_lmul_mask;
wire [VLEN - 1:0] fsm_lmul_mask16 = ({{VLEN - VLEN / 002{1'b0}},{VLEN / 002{fsm_lmul_onehot[3]}}} | {{VLEN - VLEN / 004{1'b0}},{VLEN / 004{fsm_lmul_onehot[2]}}} | {{VLEN - VLEN / 008{1'b0}},{VLEN / 008{fsm_lmul_onehot[1]}}} | {{VLEN - VLEN / 016{1'b0}},{VLEN / 016{fsm_lmul_onehot[0]}}} | {{VLEN - VLEN / 032{1'b0}},{VLEN / 032{fsm_lmul_onehot[7]}}} | {{VLEN - VLEN / 064{1'b0}},{VLEN / 064{fsm_lmul_onehot[6]}}} | {{VLEN - VLEN / 128{1'b0}},{VLEN / 128{fsm_lmul_onehot[5]}}});
wire [VLEN - 1:0] fsm_lmul_mask32 = ({{VLEN - VLEN / 004{1'b0}},{VLEN / 004{fsm_lmul_onehot[3]}}} | {{VLEN - VLEN / 008{1'b0}},{VLEN / 008{fsm_lmul_onehot[2]}}} | {{VLEN - VLEN / 016{1'b0}},{VLEN / 016{fsm_lmul_onehot[1]}}} | {{VLEN - VLEN / 032{1'b0}},{VLEN / 032{fsm_lmul_onehot[0]}}} | {{VLEN - VLEN / 064{1'b0}},{VLEN / 064{fsm_lmul_onehot[7]}}} | {{VLEN - VLEN / 128{1'b0}},{VLEN / 128{fsm_lmul_onehot[6]}}} | lmul_mask_sew32_mf8);
wire [VLEN - 1:0] fsm_lmul_mask64 = ({{VLEN - VLEN / 008{1'b0}},{VLEN / 008{fsm_lmul_onehot[3]}}} | {{VLEN - VLEN / 016{1'b0}},{VLEN / 016{fsm_lmul_onehot[2]}}} | {{VLEN - VLEN / 032{1'b0}},{VLEN / 032{fsm_lmul_onehot[1]}}} | {{VLEN - VLEN / 064{1'b0}},{VLEN / 064{fsm_lmul_onehot[0]}}} | {{VLEN - VLEN / 128{1'b0}},{VLEN / 128{fsm_lmul_onehot[7]}}} | lmul_mask_sew64_mf4 | lmul_mask_sew64_mf8);
wire vmv_sfx_done;
wire vmv_fxs_done;
wire vmv_nr_done;
wire vcompress_done;
wire vzsext_done;
wire vslideup_done;
wire vslidedn_done;
wire vrgather_done;
wire vrgatherei16_done;
wire e0_valid;
wire [VLBW * (VP_LEN / 8) - 1:0] e0_vd_byte_sel;
wire [(VP_LEN / 8) - 1:0] e0_buf0_mask;
wire [(VP_LEN / 8) - 1:0] e0_buf1_mask;
wire [(VP_LEN / 8) - 1:0] e0_body_mask;
wire [(VP_LEN / 8) - 1:0] e0_op1_mask;
wire [(VP_LEN / 8) - 1:0] e0_vd_wmask;
wire e0_vd_wmask_en;
wire [1:0] e0_vd_wmask_part_wr;
wire e0_vd_buf1_sel;
wire e0_vd_wvalid;
wire e0_vd_idx_en;
wire [1:0] e0_op1_sel;
wire [63:0] e0_op1;
wire e0_vs2_idx_en;
wire e0_vs1_idx_en;
wire e0_committed;
wire [CMT_DEP_IDX - 1:0] e0_id;
wire e0_cmt;
wire e0_kill;
wire e0_vmv_fs = fsm_vmv_fxs & fsm_float;
wire e0_vcompress = fsm_vcompress;
wire [4:0] e0_rd_addr = fsm_rd_addr;
wire [3:0] e0_sew_onehot = fsm_sew_onehot;
wire e0_vmv_fxs = fsm_vmv_fxs;
wire e0_vzsext = fsm_vzsext;
wire e0_vsext = fsm_vsext;
wire e0_vzsext_eew4x2;
wire e0_vzsext_eew4x4;
wire e0_vzsext_eew4x8;
wire e0_vzsext_eew8x2;
wire e0_vzsext_eew16x2;
wire e0_vzsext_eew32x2;
wire e0_vzsext_eew8x4;
wire e0_vzsext_eew16x4;
wire e0_vzsext_eew8x8;
wire e0_vs2_buf_wdata_sel;
reg e1_valid;
reg e1_committed;
wire e1_valid_en;
wire e1_valid_nx;
wire e1_stall;
reg [CMT_DEP_IDX - 1:0] e1_id;
wire e1_cmt = cmt_valid & ~e1_committed & (e1_id == cmt_id);
wire e1_kill = cmt_kill_valid & ~e1_committed & (e1_id == cmt_id);
wire e0_stall = e1_valid & ~e1_kill & e1_stall;
wire e1_ctrl_en;
reg [VLBW * (VP_LEN / 8) - 1:0] e1_vd_byte_sel;
reg [(VP_LEN / 8) - 1:0] e1_buf0_mask;
reg [(VP_LEN / 8) - 1:0] e1_buf1_mask;
reg [(VP_LEN / 8) - 1:0] e1_body_mask;
reg [(VP_LEN / 8) - 1:0] e1_op1_mask;
reg [(VP_LEN / 8) - 1:0] e1_vd_wmask;
reg [1:0] e1_vd_wmask_part_wr;
reg e1_vd_wmask_en;
reg e1_vd_buf1_sel;
reg e1_vd_wvalid;
reg e1_vcompress;
reg [1:0] e1_op1_sel;
reg [63:0] e1_op1;
reg e1_vmv_fs;
wire e1_vmv_nr_cmd;
wire e1_vzsext_cmd;
reg e1_srf_wvalid;
reg [4:0] e1_rd_addr;
wire [VP_LEN - 1:0] e1_result0;
wire [VP_LEN - 1:0] e1_result1;
reg e1_vmv_fxs;
reg [3:0] e1_sew_onehot;
reg e1_vsext;
reg e1_vzsext;
reg e1_vzsext_eew4x2;
reg e1_vzsext_eew4x4;
reg e1_vzsext_eew4x8;
reg e1_vzsext_eew8x2;
reg e1_vzsext_eew8x4;
reg e1_vzsext_eew8x8;
reg e1_vzsext_eew16x2;
reg e1_vzsext_eew16x4;
reg e1_vzsext_eew32x2;
wire [VP_LEN - 1:0] vd_wdata;
reg e2_committed;
reg [CMT_DEP_IDX - 1:0] e2_id;
wire e2_cmt = cmt_valid & ~e2_committed & (e2_id == cmt_id);
wire e2_kill = cmt_kill_valid & ~e2_committed & (e2_id == cmt_id);
wire vd_stall;
reg vd_wvalid;
wire vd_wvalid_nx;
wire vd_wvalid_en;
wire vd_wvalid_set;
wire vd_wmask_en;
wire [(VP_LEN / 8) - 1:0] vd_wmask;
reg [(VP_LEN / 8) - 1:0] vd_wmask0;
reg [(VP_LEN / 8) - 1:0] vd_wmask1;
reg vd_buf1_sel;
reg vcmprs_vd_buf1_sel;
wire [VP_LEN - 1:0] vd_buf0;
wire [VP_LEN - 1:0] vd_buf1;
wire [(VP_LEN / 8) - 1:0] vd_buf0_bwe;
wire [(VP_LEN / 8) - 1:0] vd_buf1_bwe;
wire [VP_LEN - 1:0] vd_buf0_din;
wire [VP_LEN - 1:0] vd_buf1_din;
reg srf_wvalid;
reg srf_wfrf;
reg [4:0] srf_waddr;
wire srf_wvalid_nx;
wire srf_wvalid_en;
wire srf_wvalid_set;
wire [63:0] srf_wdata = vd_buf0[63:0];
wire srf_wready = vpermut_srf_wready;
wire srf_stall;
reg vs1_buf_valid;
wire vs1_buf_valid_nx;
wire vs1_buf_valid_en;
wire vs1_buf_valid_set;
wire vs1_buf_valid_clr;
wire [3:0] vs1_sew_onehot;
reg [VS1_LEN - 1:0] vs1_buf;
wire [VS1_LEN - 1:0] vs1_buf_nx;
wire [VS1_RATIO - 1:0] vs1_buf_we;
reg [8 * VLEN - 1:0] vs2_buf;
wire [VLEN * 8 - 1:0] vs2_buf_in;
wire [VLEN * 8 - 1:0] vs2_vd_shift;
wire [VP_WEW - 1:0] vs2_buf_we;
wire [VP_WEW - 1:0] vs2_shift_we;
wire [VP_WEW - 1:0] vs2_rdata_we;
wire [VP_WEW - 1:0] vslideup_vs2_rdata_we;
wire [VP_WEW - 1:0] vslidedn_vs2_rdata_we;
wire [VP_WEW - 1:0] vrgather_vs2_rdata_we;
wire [VP_WEW - 1:0] vrgather_vs2_shift_we;
reg vs2_buf_valid;
wire vs2_buf_valid_nx;
wire vs2_buf_valid_en;
wire vs2_buf_valid_set;
wire vs2_buf_valid_clr;
wire [$unsigned($clog2(VLEN)) - 1:0] vlmax_byte_idx = {{$unsigned($clog2(VLEN)) - $unsigned($clog2(VLEN / 64)){1'b0}},{$unsigned($clog2(VLEN / 64)){fsm_lmul_onehot[5]}}} | {{$unsigned($clog2(VLEN)) - $unsigned($clog2(VLEN / 32)){1'b0}},{$unsigned($clog2(VLEN / 32)){fsm_lmul_onehot[6]}}} | {{$unsigned($clog2(VLEN)) - $unsigned($clog2(VLEN / 16)){1'b0}},{$unsigned($clog2(VLEN / 16)){fsm_lmul_onehot[7]}}} | {{$unsigned($clog2(VLEN)) - $unsigned($clog2(VLEN / 08)){1'b0}},{$unsigned($clog2(VLEN / 08)){fsm_lmul_onehot[0]}}} | {{$unsigned($clog2(VLEN)) - $unsigned($clog2(VLEN / 04)){1'b0}},{$unsigned($clog2(VLEN / 04)){fsm_lmul_onehot[1]}}} | {{$unsigned($clog2(VLEN)) - $unsigned($clog2(VLEN / 02)){1'b0}},{$unsigned($clog2(VLEN / 02)){fsm_lmul_onehot[2]}}} | {$unsigned($clog2(VLEN / 01)){fsm_lmul_onehot[3]}};
wire [$unsigned($clog2(VLEN)) + 2:0] byte_sel_mask = ({$unsigned($clog2(VLEN)) + 3{fsm_sew_onehot[0]}} & {3'b0,vlmax_byte_idx}) | ({$unsigned($clog2(VLEN)) + 3{fsm_sew_onehot[1]}} & {2'b0,vlmax_byte_idx,1'b1}) | ({$unsigned($clog2(VLEN)) + 3{fsm_sew_onehot[2]}} & {1'b0,vlmax_byte_idx,2'b11}) | ({$unsigned($clog2(VLEN)) + 3{fsm_sew_onehot[3]}} & {vlmax_byte_idx,3'b111});
reg [2:0] vd_cmp_idx;
wire nds_unused_vd_cmp_idx_add_one;
wire [2:0] vd_cmp_idx_add_one;
wire [2:0] vd_cmp_idx_nx;
wire vd_cmp_idx_en;
wire vd_cmp_idx_en_pre;
wire vd_cmp_idx_clr;
wire vd_cmp_idx_last;
reg [VP_IDXW:VPBW] vd_idx;
wire nds_unused_vd_idx_add_one;
wire [VP_IDXW:VPBW] vd_idx_add_one;
wire [VP_IDXW:VPBW] vd_idx_nx;
wire vd_idx_en;
wire [XLEN - 1:VPBW] vd_idx_ext = {{(XLEN - VP_IDXW - 1){1'b0}},vd_idx};
wire [3:0] vd_len_idx = vd_idx[VP_IDXW -:4];
wire [VP_IDXW - VPBW:0] vd_sel_idx;
reg [VD_IDXW:VPBW] vs2_idx;
wire [VD_IDXW:VPBW] vs2_idx_dec_in;
wire [3:0] vs2_len_idx = vs2_idx[VD_IDXW -:4];
wire nds_unused_vs2_idx_add_one;
wire [VD_IDXW:VPBW] vs2_idx_add_one;
wire [VD_IDXW:VPBW] vs2_idx_nx;
wire vs2_idx_en;
wire [XLEN - 1:VPBW] vs2_idx_ext = {{(XLEN - VD_IDXW - 1){1'b0}},vs2_idx};
wire [16 * VP_RATIO - 1:0] vs2_idx_onehot;
wire [8 * VP_RATIO - 1:0] common_vs2_buf_we;
reg [VD_IDXW + 1:VPBW] vs1_idx;
wire [4:0] vs1_len_idx = vs1_idx[VD_IDXW + 1 -:5];
wire nds_unused_vs1_idx_add_one;
wire [VD_IDXW + 1:VPBW] vs1_idx_add_one;
wire [VD_IDXW + 1:VPBW] vs1_idx_nx;
wire vs1_idx_en;
wire vd_idx_lt_offset = vd_idx_ext[XLEN - 1:VPBW] < fsm_offsetb[XLEN - 1:VPBW] | ~fsm_offsetb_lt_lmul;
wire vd_idx_eq_offset = vd_idx_ext[XLEN - 1:VPBW] == fsm_offsetb[XLEN - 1:VPBW] & fsm_offsetb_lt_lmul;
wire vd_idx_ge_offset = vd_idx_ext[XLEN - 1:VPBW] >= fsm_offsetb[XLEN - 1:VPBW];
wire vs2_idx_gt_offset = vs2_idx_ext[XLEN - 1:VPBW] > fsm_offsetb[XLEN - 1:VPBW];
wire vs2_idx_ge_offset = vs2_idx_ext[XLEN - 1:VPBW] >= fsm_offsetb[XLEN - 1:VPBW];
wire vs2_idx_eq_offset = vs2_idx_ext[XLEN - 1:VPBW] == fsm_offsetb[XLEN - 1:VPBW];
wire vs1_idx_lt_lmul_sew64;
wire vs1_idx_lt_lmul_sew32;
wire vs1_idx_lt_lmul;
wire vs1_idx_lt_lmulx2;
wire vs2_idx_last;
wire vs2_idx_gt_vlmax;
wire vs2_idx_lt_vlmax;
wire vs2_idx_eq_vlmax;
wire vs2_idx_ge_vlmax;
reg vs2_idx_ge_vlmax_d;
wire vs2_idx_lt_lmul;
wire vs2_idx_ge_lmul;
wire vs2_idx_lt_vzsext_emul;
wire vs2_idx_lt_vf2_lmul;
wire vs2_idx_lt_vf4_lmul;
wire vs2_idx_lt_vf8_lmul;
wire dl_vs2_idx_le_len;
wire dl_vs2_idx_eq_len;
wire vs2_idx_le_len;
wire vs2_idx_eq_len;
wire vs1_idx_le_len;
wire vs1_idx_eq_len;
wire lmul_gt_m1;
wire lmul_le_vpermut_dlen;
wire vd_idx_last;
wire vd_idx_vf_last;
wire vd_idx_lt_lmul;
wire vd_idx_ge_lmul;
wire [VP_LEN / 8 - 1:0] nds_unused_sll_mask;
wire [VP_LEN / 8 - 1:0] sll_mask;
wire [VP_LEN / 8 - 1:0] slr_mask;
wire [VP_LEN / 8 - 1:0] mx_slr_mask;
wire [VLEN / 64 - 1:0] mf8_slr_mask;
wire e0b_vd_cmp_ready;
wire e0b_vd_cmp_valid;
wire [(VP_LEN / 8) - 1:0] e0_vrgather_buf0_mask;
wire [(VP_LEN / 8) - 1:0] e0_vrgather_body_mask;
wire [(VP_LEN / 8) - 1:0] e0b_vrgather_body_mask;
wire [(VP_LEN / 8) - 1:0] e0_vrgather_vd_wmask;
wire [(VP_LEN / 8) - 1:0] e0_vrgather_mask;
wire e0_vrgather_vd_wmask_part_wr;
wire e0b_vrgather_vd_wmask_part_wr;
wire [(VP_LEN / 8) - 1:0] e0b_vrgather_mask;
wire e0b_vrgather_vd_wvalid;
reg [CMT_DEP_IDX - 1:0] e0b_id;
reg e0b_committed;
wire e0b_cmt = cmt_valid & ~e0b_committed & (e0b_id == cmt_id);
wire e0b_kill = cmt_kill_valid & ~e0b_committed & (e0b_id == cmt_id);
wire vrgather_vd_cmp_valid;
wire e0_vd_cmp_ready;
wire e0_vd_cmp_valid;
wire vrgather_vd_cmp_idx_en;
wire [VLBW * VP_LEN / 8 - 1:0] vslideup_vd_byte_sel;
wire [VLBW * VP_LEN / 8 - 1:0] vslidedn_vd_byte_sel;
wire [VLBW * VP_LEN / 8 - 1:0] vrgather_vd_byte_sel;
wire [VLBW * VP_LEN / 8 - 1:0] vrgatherei16_vd_byte_sel;
wire [(VP_LEN / 8) - 1:0] vslideup_buf0_mask;
wire [(VP_LEN / 8) - 1:0] vslidedn_buf0_mask;
wire [(VP_LEN / 8) - 1:0] vrgather_buf0_mask;
wire [(VP_LEN / 8) - 1:0] vrgatherei16_buf0_mask;
wire [(VP_LEN / 8) - 1:0] vslideup_buf1_mask;
wire [(VP_LEN / 8) - 1:0] vslidedn_buf1_mask;
wire [(VP_LEN / 8) - 1:0] vrgather_buf1_mask;
wire [(VP_LEN / 8) - 1:0] vslideup_body_mask;
wire [(VP_LEN / 8) - 1:0] vslidedn_body_mask;
wire [(VP_LEN / 8) - 1:0] vslidedn_op1_mask;
wire [(VP_LEN / 8) - 1:0] vslideup_op1_mask;
wire [(VP_LEN / 8) - 1:0] vrgather_body_mask;
wire [(VP_LEN / 8) - 1:0] vrgatherei16_body_mask;
wire [(VP_LEN / 8) - 1:0] vslideup_vd_wmask;
wire [(VP_LEN / 8) - 1:0] vslidedn_vd_wmask;
wire [(VP_LEN / 8) - 1:0] vrgather_vd_wmask;
wire vslideup_e0_valid;
wire vslidedn_e0_valid;
wire vrgather_e0_valid;
wire vslideup_vd_wvalid;
wire vslidedn_vd_wvalid;
wire vrgather_vd_wvalid;
wire vslideup_vd_buf1_sel;
wire vslidedn_vd_buf1_sel;
wire vrgather_vd_buf1_sel;
wire vslideup_vd_wmask_part_wr;
wire vslidedn_vd_wmask_part_wr;
wire vrgather_vd_wmask_part_wr;
wire vslideup_vd_wmask_en;
wire vslidedn_vd_wmask_en;
wire vrgather_vd_wmask_en;
wire vslideup_vs2_rready;
wire vslidedn_vs2_rready;
wire vrgather_vs2_rready;
wire vslideup_vd_idx_en;
wire vslidedn_vd_idx_en;
wire vrgather_vd_idx_en;
wire vslideup_vs2_idx_en;
wire vslidedn_vs2_idx_en;
wire vrgather_vs1_rready;
wire vrgatherei16_vs1_idx_lt_lmul;
wire vrgatherei16_vs1_rready;
wire vrgatherei16_vs1_rlast;
wire vrgatherei16_vs1_wlast;
wire vslideup_vs2_buf_wdata_sel;
wire vslidedn_vs2_buf_wdata_sel;
wire [VLBW * VP_LEN / 8 - 1:0] vrgathervxi_vd_byte_sel;
wire [(VP_LEN / 8) - 1:0] vrgathervxi_buf0_mask;
wire [(VP_LEN / 8) - 1:0] vrgathervxi_buf1_mask;
wire [(VP_LEN / 8) - 1:0] vrgathervxi_body_mask;
wire [(VP_LEN / 8) - 1:0] vrgathervxi_vd_wmask;
wire vrgathervxi_vd_wmask_part_wr;
wire vrgathervxi_vd_wmask_en;
wire vrgathervxi_vd_wvalid;
wire vrgathervxi_vd_buf1_sel;
wire vrgathervxi_e0_valid;
wire vrgathervxi_vd_idx_en;
wire vrgathervxi_done;
wire vrgathervxi_vs2_rready;
wire [VP_WEW - 1:0] vrgathervxi_vs2_rdata_we;
wire vrgathervxi_vs2_buf_wdata_sel;
wire [VLBW * VP_LEN / 8 - 1:0] vmv_vd_byte_sel;
wire [(VP_LEN / 8) - 1:0] vmv_nr_buf0_mask;
wire [(VP_LEN / 8) - 1:0] vmv_nr_buf1_mask;
wire [(VP_LEN / 8) - 1:0] vmv_nr_vd_wmask;
wire vmv_nr_vd_wvalid;
wire vmv_nr_vd_buf1_sel;
wire vmv_nr_vd_wmask_part_wr;
wire vmv_nr_vd_wmask_en;
wire [(VP_LEN / 8) - 1:0] vmv_nr_body_mask;
wire vmv_nr_e0_valid;
wire vmv_nr_vd_idx_en;
wire vmv_nr_vs2_rready;
wire vmv_nr_vs2_idx_en;
wire [VP_WEW - 1:0] vmv_nr_vs2_rdata_we;
wire vmv_nr_vs2_buf_wdata_sel;
wire vmv_nr_vd_idx_last;
wire [DLEN / 8 - 1:0] vmv_nr_vstart_mask;
wire [VLEN - 1:0] fsm_vstart_mask;
wire [VLBW * VP_LEN / 8 - 1:0] vcompress_vd_byte_sel;
wire [(VP_LEN / 8) - 1:0] vcompress_buf0_mask;
wire [(VP_LEN / 8) - 1:0] vcompress_buf1_mask;
wire [(VP_LEN / 8) - 1:0] vcompress_vd_wmask;
wire vcompress_vd_wvalid;
wire vcompress_vd_avail;
wire vcompress_vd_buf1_sel;
wire [1:0] vcompress_vd_wmask_part_wr;
wire vcompress_vd_wmask_en;
wire [(VP_LEN / 8) - 1:0] vcompress_body_mask;
wire vcompress_e0_valid;
wire vcompress_e0c_en;
wire vcompress_e0c_valid;
wire vcompress_vd_idx_en;
wire vcompress_vs2_rready;
wire vcompress_vs2_idx_en;
wire [VP_WEW - 1:0] vcompress_vs2_rdata_we;
wire [VP_WEW - 1:0] vcompress_vs2_shift_we;
wire vcompress_vs2_buf_wdata_sel;
wire vcompress_vs1_rready;
wire [VLEN - 1:0] vcompress_vs1_buf_nx;
wire [VLEN - 1:0] vcompress_vs1_lmul_sew_mask;
wire vcompress_vs1_buf_en;
wire fsm_op1_nanbox_sew16 = &fsm_op1[63:16];
wire fsm_op1_nanbox_sew32 = &fsm_op1[63:32];
wire [63:0] vmv_sf_wdata;
wire [(VP_LEN / 8) - 1:0] vmv_sfx_buf0_mask;
wire [(VP_LEN / 8) - 1:0] vmv_sfx_buf1_mask;
wire [(VP_LEN / 8) - 1:0] vmv_sfx_op1_mask;
wire [(VP_LEN / 8) - 1:0] vmv_sfx_vd_wmask;
wire vmv_sfx_vd_wvalid;
wire vmv_sfx_vd_buf1_sel;
wire vmv_sfx_vd_wmask_part_wr;
wire vmv_sfx_vd_wmask_en;
wire [(VP_LEN / 8) - 1:0] vmv_sfx_body_mask;
wire vmv_sfx_e0_valid;
wire vmv_sfx_vd_idx_en;
wire vmv_sfx_vs2_rready;
wire vmv_sfx_vs2_buf_wdata_sel;
wire [(VP_LEN / 8) - 1:0] vmv_fxs_buf0_mask;
wire [(VP_LEN / 8) - 1:0] vmv_fxs_buf1_mask;
wire [(VP_LEN / 8) - 1:0] vmv_fxs_vd_wmask;
wire vmv_fxs_vd_wvalid;
wire vmv_fxs_vd_buf1_sel;
wire vmv_fxs_vd_wmask_part_wr;
wire vmv_fxs_vd_wmask_en;
wire [(VP_LEN / 8) - 1:0] vmv_fxs_body_mask;
wire vmv_fxs_e0_valid;
wire vmv_fxs_vd_idx_en;
wire vmv_fxs_vs2_rready;
wire [VP_WEW - 1:0] vmv_fxs_vs2_rdata_we;
wire vmv_fxs_vs2_buf_wdata_sel;
wire [VLBW * VP_LEN / 8 - 1:0] vmv_fxs_vd_byte_sel;
wire [VLBW * VP_LEN / 8 - 1:0] vmv_fxs_vd_byte_sel_eew8x8;
wire [VLBW * VP_LEN / 8 - 1:0] vmv_fxs_vd_byte_sel_eew16x4;
wire [VLBW * VP_LEN / 8 - 1:0] vmv_fxs_vd_byte_sel_eew32x2;
wire e0_srf_wvalid = fsm_vmv_fxs & vmv_fxs_e0_valid & ~|vs2_idx;
wire [(VP_LEN / 8) - 1:0] vzsext_buf0_mask;
wire [(VP_LEN / 8) - 1:0] vzsext_buf1_mask;
wire [(VP_LEN / 8) - 1:0] vzsext_vd_wmask;
wire vzsext_vd_wvalid;
wire vzsext_vd_buf1_sel;
wire vzsext_vd_wmask_part_wr;
wire vzsext_vd_wmask_en;
wire [(VP_LEN / 8) - 1:0] vzsext_body_mask;
wire vzsext_e0_valid;
wire vzsext_vd_idx_en;
wire vzsext_vd_idx_last;
wire vzsext_vs2_rready;
wire vzsext_vs2_idx_en;
wire [VP_WEW - 1:0] vzsext_vs2_rdata_we;
wire vzsext_vs2_buf_wdata_sel;
wire fsm_vzsext_vf2;
wire fsm_vzsext_vf4;
wire fsm_vzsext_vf8;
wire [VLBW * VP_LEN / 8 - 1:0] vzsext_vd_byte_sel;
wire [VLBW * VP_LEN / 8 - 1:0] vzsext_vd_byte_sel_eew4x2;
wire [VLBW * VP_LEN / 8 - 1:0] vzsext_vd_byte_sel_eew4x4;
wire [VLBW * VP_LEN / 8 - 1:0] vzsext_vd_byte_sel_eew4x8;
wire [VLBW * VP_LEN / 8 - 1:0] vzsext_vd_byte_sel_eew8x2;
wire [VLBW * VP_LEN / 8 - 1:0] vzsext_vd_byte_sel_eew8x4;
wire [VLBW * VP_LEN / 8 - 1:0] vzsext_vd_byte_sel_eew8x8;
wire [VLBW * VP_LEN / 8 - 1:0] vzsext_vd_byte_sel_eew16x2;
wire [VLBW * VP_LEN / 8 - 1:0] vzsext_vd_byte_sel_eew16x4;
wire [VLBW * VP_LEN / 8 - 1:0] vzsext_vd_byte_sel_eew32x2;
wire [VP_LEN / 8 - 1:0] vzsext_body_mask_eew8x2;
wire [VP_LEN / 8 - 1:0] vzsext_body_mask_eew8x4;
wire [VP_LEN / 8 - 1:0] vzsext_body_mask_eew8x8;
wire [VP_LEN / 8 - 1:0] vzsext_body_mask_eew16x2;
wire [VP_LEN / 8 - 1:0] vzsext_body_mask_eew16x4;
wire [VP_LEN / 8 - 1:0] vzsext_body_mask_eew32x2;
wire fsm_vslide1 = (fsm_sub_func | fsm_float);
wire fsm_ctrl_en;
wire fsm_op1_hazard_sel = fsm_op1_hazard & fsm_vfxi & ~fsm_kill;
wire req_op1_hazard_cmt = req_cmt & req_op1_hazard;
wire [XLEN - 1:0] fsm_op1_nx = (req_op1_hazard_cmt | fsm_op1_hazard_sel) ? vpermut_cmt_op1 : req_op1;
wire [XLEN + 2:0] req_offsetb = fsm_op1_hazard_sel ? ({{3{1'b0}},vpermut_cmt_op1} << fsm_sew) : ((req_vslideup | req_vslidedn) & (req_sub_func | req_float)) ? ({{XLEN + 2{1'b0}},1'b1} << req_sew) : req_op1_hazard_cmt ? ({{3{1'b0}},vpermut_cmt_op1} << req_sew) : ({{3{1'b0}},req_op1} << req_sew);
assign fsm_offsetb_lt_lmul = ((fsm_cs[VSLIDEUP] | fsm_cs[VSLIDEDN]) & fsm_vslide1) | (~|fsm_offsetb[XLEN + 2:VLBW + 4] & (|(fsm_lmul_onehot[0] & (~|fsm_offsetb[VLBW + 3:VLBW])) | (fsm_lmul_onehot[1] & (~|fsm_offsetb[VLBW + 3:VLBW + 1])) | (fsm_lmul_onehot[2] & (~|fsm_offsetb[VLBW + 3:VLBW + 2])) | (fsm_lmul_onehot[3] & (~|fsm_offsetb[VLBW + 3:VLBW + 3])) | (fsm_lmul_onehot[5] & (~|fsm_offsetb[VLBW + 3:VLBW - 3])) | (fsm_lmul_onehot[6] & (~|fsm_offsetb[VLBW + 3:VLBW - 2])) | (fsm_lmul_onehot[7] & (~|fsm_offsetb[VLBW + 3:VLBW - 1]))));
assign fsm_offsetb_remainder = |fsm_offsetb[VPBW - 1:0];
assign fsm_done = ((fsm_vslidedn & vslidedn_done) | (fsm_vslideup & vslideup_done) | (fsm_vrgather_vv & vrgather_done) | (fsm_vrgatherei16 & vrgatherei16_done) | (fsm_vrgather_vxi & vrgathervxi_done) | (fsm_vcompress & vcompress_done) | (fsm_vmv_sfx & vmv_sfx_done) | (fsm_vmv_fxs & vmv_fxs_done) | (fsm_vmv_nr & vmv_nr_done) | (fsm_vzsext & vzsext_done));
assign req_ready = fsm_idle | fsm_kill | fsm_done | req_kill;
wire dispatch_ptr_en = dis_grant & cmt_wready;
wire [CMT_DEP_IDX:0] dis_id_inc = {1'b0,dis_id} + {{CMT_DEP_IDX{1'b0}},1'b1};
wire nds_unused_dis_id_inc = dis_id_inc[CMT_DEP_IDX];
always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        dis_id <= {CMT_DEP_IDX{1'b0}};
    end
    else if (dispatch_ptr_en) begin
        dis_id <= dis_id_inc[CMT_DEP_IDX - 1:0];
    end
end

kv_fifo #(
    .WIDTH(CMT_DEP_IDX),
    .DEPTH(4)
) u_cmt_queue (
    .clk(vpu_vpermut_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wdata(dis_id),
    .wvalid(dis_grant),
    .wready(cmt_wready),
    .rdata(cmt_id),
    .rvalid(nds_unused_cmt_rready),
    .rready(cmt_valid)
);
kv_eb_bypass #(
    .DW(BYPASS_DW),
    .RAR_SUPPORT(RAR_SUPPORT)
) u_dispatch_buffer (
    .clk(vpu_vpermut_clk),
    .resetn(vpu_reset_n),
    .i_valid(dis_valid),
    .i_ready(dis_ready),
    .din({dis_id,vpermut_dispatch_ctrl,vpermut_dispatch_v0t,vpermut_dispatch_vs1_len,vpermut_dispatch_vs2_len,vpermut_dispatch_vd_len}),
    .o_valid(req_valid),
    .o_ready(req_ready),
    .dout({req_id,req_ctrl,req_v0t,req_vs1_len,req_vs2_len,req_vd_len})
);
wire req_cmt_hazard_valid = ~dis_ready & ~req_ready & req_cmt & buf_op1_hazard;
generate
    if (RAR_SUPPORT) begin:gen_req_stage_rar
        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                {buf_op1,buf_op1_hazard} <= 65'b0;
            end
            else if ((dis_valid & dis_ready & ~req_ready) | req_cmt_hazard_valid) begin
                {buf_op1,buf_op1_hazard} <= req_cmt_hazard_valid ? {vpermut_cmt_op1,1'b0} : {vpermut_dispatch_op1,vpermut_dispatch_op1_hazard};
            end
        end

    end
    else begin:gen_req_stage_no_rar
        always @(posedge vpu_vpermut_clk) begin
            if ((dis_valid & dis_ready & ~req_ready) | req_cmt_hazard_valid) begin
                {buf_op1,buf_op1_hazard} <= req_cmt_hazard_valid ? {vpermut_cmt_op1,1'b0} : {vpermut_dispatch_op1,vpermut_dispatch_op1_hazard};
            end
        end

    end
endgenerate
wire req_buf_valid = ~dis_ready;
wire req_committed_en = (req_buf_valid & ~req_ready & req_cmt) | (dis_valid & dis_ready & ~req_ready) | (req_buf_valid & req_ready);
wire req_committed_nx = req_buf_valid & ~req_ready & req_cmt & ~cmt_kill;
always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        req_committed <= 1'b0;
    end
    else if (req_committed_en) begin
        req_committed <= req_committed_nx;
    end
end

assign req_op1 = dis_ready ? vpermut_dispatch_op1 : buf_op1;
assign req_op1_hazard = dis_ready ? vpermut_dispatch_op1_hazard : buf_op1_hazard;
kv_bin2onehot #(
    .N(8)
) u_req_lmul_onehot (
    .out(req_lmul_onehot),
    .in(req_lmul)
);
kv_bin2onehot #(
    .N(4)
) u_req_sew_onehot (
    .out(req_sew_onehot),
    .in(req_sew)
);
assign vs2_rdata = vpermut_vs2_rdata;
assign vs1_rdata = vpermut_vs1_rdata;
assign lmul_gt_m1 = fsm_lmul_onehot[1] | fsm_lmul_onehot[2] | fsm_lmul_onehot[3];
wire vl_gt_vstart = ({1'b0,fsm_vstart} < fsm_vl);
wire [VS1_RATIO - 1:0] vs1_idx_onehot;
kv_bin2onehot #(
    .N(VS1_RATIO)
) u_vs1_idx_onehot (
    .out(vs1_idx_onehot),
    .in(vs1_idx[VPBW +:VS1_RATIO_IDX])
);
wire fsm_vslidedn_unaligned;
generate
    genvar z1;
    genvar z2;
    if (VP_RATIO == 1) begin:gen_vdp_ratio_111
        assign lmul_le_vpermut_dlen = |{fsm_lmul_onehot[7:5],fsm_lmul_onehot[0]};
        assign vrgatherei16_vs1_wlast = |{~fsm_sew_onehot[0],fsm_lmul_onehot[7:5],vs1_idx[VPBW]};
        assign dl_vd_idx_le_len = vd_idx_le_len;
        assign dl_vd_idx_eq_len = vd_idx_eq_len;
        assign vd_idx_le_len = vd_idx[VD_IDXW:VPBW] <= {1'b0,fsm_vd_len};
        assign vd_idx_eq_len = vd_idx[VD_IDXW:VPBW] == {1'b0,fsm_vd_len};
        assign una_vd_idx_le_len = vd_idx[VD_IDXW:VPBW] <= ({1'b0,fsm_vd_len} + {{VRF_LW{1'b0}},1'b1});
        assign una_vd_idx_eq_len = vd_idx[VD_IDXW:VPBW] == ({1'b0,fsm_vd_len} + {{VRF_LW{1'b0}},1'b1});
        assign vs2_idx_eq_len = vs2_idx == {1'b0,fsm_vs2_len};
        assign vs2_idx_le_len = vs2_idx <= {1'b0,fsm_vs2_len};
        assign dl_vs2_idx_eq_len = vs2_idx_eq_len;
        assign dl_vs2_idx_le_len = vs2_idx_le_len;
        assign vs2_rready_en = vs2_idx_le_len;
        assign vs1_rready_en = vs1_idx_le_len;
        assign vs1_vl_last = 1'b1;
        assign vs2_vl_last = 1'b1;
        assign vd_vl_last = 1'b1;
        assign vd_dlen_last = 1'b1;
        assign vmv_nr_vs2_rdata_we = common_vs2_buf_we;
        assign vzsext_vs2_rdata_we = common_vs2_buf_we;
        assign vmv_fxs_vs2_rdata_we = common_vs2_buf_we;
        assign vmv_nr_buf1_mask = {(VP_LEN / 8){1'b0}};
        assign vmv_nr_vd_idx_last = vd_idx_last;
        assign vzsext_vd_idx_last = vd_idx_last;
        assign vs2_idx_lt_vf2_lmul = (fsm_lmul_onehot[0] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[1] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[2] & (vs2_len_idx < 4'd2)) | (fsm_lmul_onehot[3] & (vs2_len_idx < 4'd4)) | (fsm_lmul_onehot[5] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[6] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[7] & (vs2_len_idx < 4'd1));
        assign vs2_idx_lt_vf4_lmul = (fsm_lmul_onehot[0] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[1] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[2] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[3] & (vs2_len_idx < 4'd2)) | (fsm_lmul_onehot[5] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[6] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[7] & (vs2_len_idx < 4'd1));
        assign vs2_idx_lt_vf8_lmul = (vs2_len_idx < 4'd1);
        kv_mux #(
            .N(VLEN * 8 / DLEN),
            .W(DLEN / 8)
        ) u_vstart_mask_mux (
            .out(vmv_nr_vstart_mask),
            .sel(vd_idx[VPBW +:3]),
            .in(fsm_vstart_mask)
        );
        assign vmv_nr_vd_buf1_sel = 1'b0;
        assign vs2_idx_dec_in = {4{fsm_vrgather_vv | fsm_vrgatherei16}} & vs2_len_idx;
        assign vd_sel_idx = vd_len_idx;
        assign vs1_buf_nx = e0_vs1_idx_en ? {2{vs1_rdata & ({VLEN{~fsm_vcompress}} | vcompress_vs1_lmul_sew_mask)}} : {2{vcompress_vs1_buf_nx}};
        assign vs1_buf_we = ({2{e0_vs1_idx_en & fsm_vrgatherei16 & fsm_sew_onehot[0]}} & vs1_idx_onehot) | {1'b0,e0_vs1_idx_en & ((fsm_vrgatherei16 & ~fsm_sew_onehot[0]) | fsm_vrgather_vv | fsm_vcompress)} | {1'b0,fsm_vcompress & vcompress_vs1_buf_en};
        assign vs2_idx_gt_vlmax = (fsm_lmul_onehot[0] & (vs2_len_idx > 4'd0)) | (fsm_lmul_onehot[1] & (vs2_len_idx > 4'd2)) | (fsm_lmul_onehot[2] & (vs2_len_idx > 4'd4)) | (fsm_lmul_onehot[3] & (vs2_len_idx > 4'd8)) | (fsm_lmul_onehot[5] & (vs2_len_idx > 4'd0)) | (fsm_lmul_onehot[6] & (vs2_len_idx > 4'd0)) | (fsm_lmul_onehot[7] & (vs2_len_idx > 4'd0));
        assign vs2_idx_lt_vlmax = ~vs2_idx_gt_vlmax & ~vs2_idx_eq_vlmax;
        assign vs2_idx_ge_vlmax = ~vs2_idx_lt_vlmax;
        assign vs2_idx_eq_vlmax = (fsm_lmul_onehot[0] & (vs2_len_idx == 4'd0)) | (fsm_lmul_onehot[1] & (vs2_len_idx == 4'd2)) | (fsm_lmul_onehot[2] & (vs2_len_idx == 4'd4)) | (fsm_lmul_onehot[3] & (vs2_len_idx == 4'd8)) | (fsm_lmul_onehot[5] & (vs2_len_idx == 4'd0)) | (fsm_lmul_onehot[6] & (vs2_len_idx == 4'd0)) | (fsm_lmul_onehot[7] & (vs2_len_idx == 4'd0));
    end
    else if (VD_RATIO == 1) begin:gen_vdp_ratio_221
        assign lmul_le_vpermut_dlen = |fsm_lmul_onehot[7:5];
        assign vrgatherei16_vs1_wlast = |{~fsm_sew_onehot[0],fsm_lmul_onehot[6:5],vs1_idx[VPBW]};
        assign vs1_vl_last = &vs1_idx[VPBW +:VP_RATIO_IDX];
        assign vs2_vl_last = &vs2_idx[VPBW +:VP_RATIO_IDX];
        assign vd_vl_last = &vd_idx[VPBW +:VP_RATIO_IDX];
        assign vd_dlen_last = 1'b1;
        assign dl_vd_idx_le_len = vd_idx[VPBW +:3] <= fsm_vd_len;
        assign dl_vd_idx_eq_len = vd_idx[VPBW +:3] == fsm_vd_len;
        assign vd_idx_le_len = vd_idx[VD_IDXW:VPBW] <= {1'b0,fsm_vd_len,1'b1};
        assign vd_idx_eq_len = vd_idx[VD_IDXW:VPBW] == {1'b0,fsm_vd_len,1'b1};
        assign una_vd_idx_le_len = vd_idx[VD_IDXW:VPBW] <= ({1'b0,fsm_vd_len,1'b1} + {{VRF_LW + 1{1'b0}},1'b1});
        assign una_vd_idx_eq_len = vd_idx[VD_IDXW:VPBW] == ({1'b0,fsm_vd_len,1'b1} + {{VRF_LW + 1{1'b0}},1'b1});
        assign vs2_idx_le_len = vs2_idx <= {1'b0,fsm_vs2_len,1'b1};
        assign vs2_idx_eq_len = vs2_idx == {1'b0,fsm_vs2_len,1'b1};
        assign dl_vs2_idx_le_len = vs2_idx[VPBW +:3] <= fsm_vs2_len;
        assign dl_vs2_idx_eq_len = vs2_idx[VPBW +:3] == fsm_vs2_len;
        assign vs2_rready_en = (fsm_vmv_nr | fsm_vzsext | fsm_vmv_fxs) ? dl_vs2_idx_le_len : &{vs2_idx[VPBW +:DP_RATIO_IDX],vs2_idx_le_len};
        assign vs1_rready_en = &{vs1_idx[VPBW +:DP_RATIO_IDX],vs1_idx_le_len};
        assign vmv_nr_vd_buf1_sel = 1'b0;
        assign vmv_nr_vs2_rdata_we = {8{2'b01}} | {14'b0,2'b10};
        assign vzsext_vs2_rdata_we = {16{1'b1}};
        assign vmv_fxs_vs2_rdata_we = {8{1'b0,~|vs2_idx}};
        assign vmv_nr_buf1_mask = vmv_nr_vstart_mask[DLEN / 8 - 1:VP_LEN / 8];
        assign vmv_nr_vd_idx_last = (fsm_lmul_onehot[0] & (vd_idx == 5'h0)) | (fsm_lmul_onehot[1] & (vd_idx == 5'h1)) | (fsm_lmul_onehot[2] & (vd_idx == 5'h3)) | (fsm_lmul_onehot[3] & (vd_idx == 5'h7));
        assign vzsext_vd_idx_last = (fsm_lmul_onehot[5] & (vd_idx == 5'h0)) | (fsm_lmul_onehot[6] & (vd_idx == 5'h0)) | (fsm_lmul_onehot[7] & (vd_idx == 5'h0)) | (fsm_lmul_onehot[0] & (vd_idx == 5'h0)) | (fsm_lmul_onehot[1] & (vd_idx == 5'h1)) | (fsm_lmul_onehot[2] & (vd_idx == 5'h3)) | (fsm_lmul_onehot[3] & (vd_idx == 5'h7));
        assign vs2_idx_lt_vf2_lmul = (fsm_lmul_onehot[0] & (vs2_idx < 5'h1)) | (fsm_lmul_onehot[1] & (vs2_idx < 5'h1)) | (fsm_lmul_onehot[2] & (vs2_idx < 5'h2)) | (fsm_lmul_onehot[3] & (vs2_idx < 5'h4)) | (fsm_lmul_onehot[5] & (vs2_idx < 5'h1)) | (fsm_lmul_onehot[6] & (vs2_idx < 5'h1)) | (fsm_lmul_onehot[7] & (vs2_idx < 5'h1));
        assign vs2_idx_lt_vf4_lmul = (fsm_lmul_onehot[0] & (vs2_idx < 5'h1)) | (fsm_lmul_onehot[1] & (vs2_idx < 5'h1)) | (fsm_lmul_onehot[2] & (vs2_idx < 5'h1)) | (fsm_lmul_onehot[3] & (vs2_idx < 5'h2)) | (fsm_lmul_onehot[5] & (vs2_idx < 5'h1)) | (fsm_lmul_onehot[6] & (vs2_idx < 5'h1)) | (fsm_lmul_onehot[7] & (vs2_idx < 5'h1));
        assign vs2_idx_lt_vf8_lmul = (vs2_idx < 5'd1);
        kv_mux #(
            .N(VLEN * 8 / DLEN),
            .W(DLEN / 8)
        ) u_vstart_mask_mux (
            .out(vmv_nr_vstart_mask),
            .sel(vd_idx[VPBW +:3]),
            .in(fsm_vstart_mask)
        );
        assign vd_sel_idx = {vd_len_idx,(fsm_vslidedn | fsm_vslideup) ? vs2_idx[VPBW +:VP_RATIO_IDX] : vd_idx[VPBW +:VP_RATIO_IDX]};
        assign vs2_idx_dec_in = {{4{fsm_vrgather_vv | fsm_vrgatherei16}} & vs2_len_idx,vs2_idx[VPBW +:VP_RATIO_IDX]};
        assign vs1_buf_nx = e0_vs1_idx_en ? vs1_rdata & ({VLEN{~fsm_vcompress}} | vcompress_vs1_lmul_sew_mask) : vcompress_vs1_buf_nx;
        assign vs1_buf_we = {2{fsm_vcompress & vcompress_vs1_buf_en}} | ({2{fsm_vcompress & e0_vs1_idx_en}} & vs1_idx_onehot) | ({2{fsm_vrgather_vv & e0_vs1_idx_en}} & vs1_idx_onehot) | ({2{fsm_vrgatherei16 & e0_vs1_idx_en & fsm_sew_onehot[0]}} & vs1_idx_onehot) | ({2{fsm_vrgatherei16 & e0_vs1_idx_en & fsm_sew_onehot[1]}} & vs1_idx_onehot) | ({2{fsm_vrgatherei16 & e0_vs1_idx_en & fsm_sew_onehot[2] & vd_idx_lt_lmul}} & vs1_idx_onehot) | ({2{fsm_vrgatherei16 & e0_vs1_idx_en & fsm_sew_onehot[3] & vd_idx_lt_lmul}} & vs1_idx_onehot);
        assign vs2_idx_gt_vlmax = (fsm_lmul_onehot[0] & (vs2_idx > 5'h02)) | (fsm_lmul_onehot[1] & (vs2_idx > 5'h04)) | (fsm_lmul_onehot[2] & (vs2_idx > 5'h08)) | (fsm_lmul_onehot[3] & (vs2_idx > 5'h10)) | (fsm_lmul_onehot[5] & (vs2_idx > 5'h00)) | (fsm_lmul_onehot[6] & (vs2_idx > 5'h00)) | (fsm_lmul_onehot[7] & (vs2_idx > 5'h00));
        assign vs2_idx_eq_vlmax = (fsm_lmul_onehot[0] & (vs2_idx == 5'h02)) | (fsm_lmul_onehot[1] & (vs2_idx == 5'h04)) | (fsm_lmul_onehot[2] & (vs2_idx == 5'h08)) | (fsm_lmul_onehot[3] & (vs2_idx == 5'h10)) | (fsm_lmul_onehot[5] & (vs2_idx == 5'h00)) | (fsm_lmul_onehot[6] & (vs2_idx == 5'h00)) | (fsm_lmul_onehot[7] & (vs2_idx == 5'h00));
        assign vs2_idx_lt_vlmax = ~vs2_idx_gt_vlmax & ~vs2_idx_eq_vlmax;
        assign vs2_idx_ge_vlmax = ~vs2_idx_lt_vlmax;
    end
    else if (DP_RATIO == 1) begin:gen_vdp_ratio_211
        assign lmul_le_vpermut_dlen = |fsm_lmul_onehot[7:5];
        assign vrgatherei16_vs1_wlast = |{~fsm_sew_onehot[0],fsm_lmul_onehot[6:5],vs1_idx[VPBW]};
        assign dl_vd_idx_le_len = vd_idx_le_len;
        assign dl_vd_idx_eq_len = vd_idx_eq_len;
        assign vd_idx_le_len = vd_idx[VD_IDXW:VPBW] <= {1'b0,fsm_vd_len};
        assign vd_idx_eq_len = vd_idx[VD_IDXW:VPBW] == {1'b0,fsm_vd_len};
        assign una_vd_idx_le_len = vd_idx[VD_IDXW:VPBW] <= ({1'b0,fsm_vd_len} + {{VRF_LW{1'b0}},1'b1});
        assign una_vd_idx_eq_len = vd_idx[VD_IDXW:VPBW] == ({1'b0,fsm_vd_len} + {{VRF_LW{1'b0}},1'b1});
        assign vs2_idx_eq_len = vs2_idx == {1'b0,fsm_vs2_len};
        assign vs2_idx_le_len = vs2_idx <= {1'b0,fsm_vs2_len};
        assign dl_vs2_idx_eq_len = vs2_idx_eq_len;
        assign dl_vs2_idx_le_len = vs2_idx_le_len;
        assign vs2_rready_en = vs2_idx_le_len;
        assign vs1_rready_en = vs1_idx_le_len;
        assign vd_sel_idx = {vd_len_idx,(fsm_vslidedn | fsm_vslideup) ? vs2_idx[VPBW +:VP_RATIO_IDX] : vd_idx[VPBW +:VP_RATIO_IDX]};
        assign vs1_vl_last = &vs1_idx[VPBW +:VP_RATIO_IDX];
        assign vs2_vl_last = &vs2_idx[VPBW +:VP_RATIO_IDX];
        assign vd_vl_last = &vd_idx[VPBW +:VP_RATIO_IDX];
        assign vd_dlen_last = vd_idx[VPBW];
        assign vs2_idx_dec_in = {{4{fsm_vrgather_vv | fsm_vrgatherei16}} & vs2_len_idx,vs2_idx[VPBW +:VP_RATIO_IDX]};
        assign vzsext_vs2_rdata_we = common_vs2_buf_we & {16{~vzsext_vd_idx_last}};
        assign vmv_nr_vs2_rdata_we = {8{2'b01}};
        assign vmv_fxs_vs2_rdata_we = {8{1'b0,~|vs2_idx}};
        assign vmv_nr_vd_buf1_sel = 1'b0;
        assign vmv_nr_buf1_mask = {(VP_LEN / 8){1'b0}};
        assign vmv_nr_vd_idx_last = vd_idx_last;
        assign vzsext_vd_idx_last = vd_idx_last;
        assign vs2_idx_lt_vf2_lmul = (fsm_lmul_onehot[0] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[1] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[2] & (vs2_len_idx < 4'd2)) | (fsm_lmul_onehot[3] & (vs2_len_idx < 4'd4)) | (fsm_lmul_onehot[5] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[6] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[7] & (vs2_len_idx < 4'd1));
        assign vs2_idx_lt_vf4_lmul = (fsm_lmul_onehot[0] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[1] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[2] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[3] & (vs2_len_idx < 4'd2)) | (fsm_lmul_onehot[5] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[6] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[7] & (vs2_len_idx < 4'd1));
        assign vs2_idx_lt_vf8_lmul = (vs2_len_idx < 4'd1);
        kv_mux #(
            .N(VLEN * 8 / DLEN),
            .W(DLEN / 8)
        ) u_vstart_mask_mux (
            .out(vmv_nr_vstart_mask),
            .sel(vd_idx[VPBW +:4]),
            .in(fsm_vstart_mask)
        );
        wire [DLEN - 1:0] vs1_lmul_sew_mask;
        kv_mux #(
            .N(VD_RATIO),
            .W(DLEN)
        ) u_vs1_mask_mux (
            .out(vs1_lmul_sew_mask),
            .sel(vs1_idx[VPBW +:VD_RATIO_IDX]),
            .in(vcompress_vs1_lmul_sew_mask)
        );
        assign vs1_buf_nx = e0_vs1_idx_en ? {VD_RATIO{vs1_rdata & ({DLEN{~fsm_vcompress}} | vs1_lmul_sew_mask)}} : vcompress_vs1_buf_nx;
        assign vs1_buf_we = {2{fsm_vcompress & vcompress_vs1_buf_en}} | ({2{fsm_vcompress & e0_vs1_idx_en}} & vs1_idx_onehot) | ({2{fsm_vrgather_vv & e0_vs1_idx_en}} & vs1_idx_onehot) | ({2{fsm_vrgatherei16 & e0_vs1_idx_en & fsm_sew_onehot[0]}} & vs1_idx_onehot) | ({2{fsm_vrgatherei16 & e0_vs1_idx_en & fsm_sew_onehot[1]}} & vs1_idx_onehot) | ({2{fsm_vrgatherei16 & e0_vs1_idx_en & fsm_sew_onehot[2] & vd_idx_lt_lmul}} & vs1_idx_onehot) | ({2{fsm_vrgatherei16 & e0_vs1_idx_en & fsm_sew_onehot[3] & vd_idx_lt_lmul}} & vs1_idx_onehot);
        assign vs2_idx_gt_vlmax = (fsm_lmul_onehot[0] & (vs2_idx > 5'h02)) | (fsm_lmul_onehot[1] & (vs2_idx > 5'h04)) | (fsm_lmul_onehot[2] & (vs2_idx > 5'h08)) | (fsm_lmul_onehot[3] & (vs2_idx > 5'h10)) | (fsm_lmul_onehot[5] & (vs2_idx > 5'h00)) | (fsm_lmul_onehot[6] & (vs2_idx > 5'h00)) | (fsm_lmul_onehot[7] & (vs2_idx > 5'h00));
        assign vs2_idx_eq_vlmax = (fsm_lmul_onehot[0] & (vs2_idx == 5'h02)) | (fsm_lmul_onehot[1] & (vs2_idx == 5'h04)) | (fsm_lmul_onehot[2] & (vs2_idx == 5'h08)) | (fsm_lmul_onehot[3] & (vs2_idx == 5'h10)) | (fsm_lmul_onehot[5] & (vs2_idx == 5'h00)) | (fsm_lmul_onehot[6] & (vs2_idx == 5'h00)) | (fsm_lmul_onehot[7] & (vs2_idx == 5'h00));
        assign vs2_idx_lt_vlmax = ~vs2_idx_gt_vlmax & ~vs2_idx_eq_vlmax;
        assign vs2_idx_ge_vlmax = ~vs2_idx_lt_vlmax;
    end
    else begin:gen_vdp_ratio_421
        assign lmul_le_vpermut_dlen = |fsm_lmul_onehot[6:5];
        assign vrgatherei16_vs1_wlast = |{~fsm_sew_onehot[0],fsm_lmul_onehot[5],vs1_idx[VPBW]};
        assign vs1_vl_last = &vs1_idx[VPBW +:VP_RATIO_IDX];
        assign vs2_vl_last = &vs2_idx[VPBW +:VP_RATIO_IDX];
        assign vd_vl_last = &vd_idx[VPBW +:VP_RATIO_IDX];
        assign vd_dlen_last = vd_idx[VPBW];
        assign dl_vd_idx_le_len = vd_idx[VPBW +:4] <= fsm_vd_len;
        assign dl_vd_idx_eq_len = vd_idx[VPBW +:4] == fsm_vd_len;
        assign vd_idx_le_len = vd_idx[VD_IDXW:VPBW] <= {1'b0,fsm_vd_len,1'b1};
        assign vd_idx_eq_len = vd_idx[VD_IDXW:VPBW] == {1'b0,fsm_vd_len,1'b1};
        assign una_vd_idx_le_len = vd_idx[VD_IDXW:VPBW] <= ({1'b0,fsm_vd_len,1'b1} + {{VRF_LW + 1{1'b0}},1'b1});
        assign una_vd_idx_eq_len = vd_idx[VD_IDXW:VPBW] == ({1'b0,fsm_vd_len,1'b1} + {{VRF_LW + 1{1'b0}},1'b1});
        assign vs2_idx_le_len = vs2_idx <= {1'b0,fsm_vs2_len[VRF_LW - 1:0],1'b1};
        assign vs2_idx_eq_len = vs2_idx == {1'b0,fsm_vs2_len[VRF_LW - 1:0],1'b1};
        assign dl_vs2_idx_le_len = vs2_idx[VPBW +:4] <= fsm_vs2_len[VRF_LW - 1:0];
        assign dl_vs2_idx_eq_len = vs2_idx[VPBW +:4] == fsm_vs2_len[VRF_LW - 1:0];
        assign vs2_rready_en = (fsm_vmv_nr | fsm_vzsext | fsm_vmv_fxs) ? dl_vs2_idx_le_len : &{vs2_idx[VPBW +:DP_RATIO_IDX],vs2_idx_le_len};
        assign vs1_rready_en = &{vs1_idx[VPBW +:DP_RATIO_IDX],vs1_idx_le_len};
        assign vd_sel_idx = {vd_len_idx,(fsm_vslidedn | fsm_vslideup) ? vs2_idx[VPBW +:VP_RATIO_IDX] : vd_idx[VPBW +:VP_RATIO_IDX]};
        assign vs2_idx_dec_in = {{4{fsm_vrgather_vv | fsm_vrgatherei16}} & vs2_len_idx,vs2_idx[VPBW +:VP_RATIO_IDX]};
        assign vzsext_vs2_rdata_we = {8{2'b00,{2{~vzsext_vd_idx_last}}}};
        assign vmv_nr_vs2_rdata_we = {8{4'b0001}} | {28'b0,4'b0010};
        assign vmv_fxs_vs2_rdata_we = {8{3'b0,~|vs2_idx}};
        assign vmv_nr_vd_buf1_sel = vd_idx[VPBW];
        assign vmv_nr_buf1_mask = vmv_nr_vstart_mask[DLEN / 8 - 1:VP_LEN / 8];
        assign vmv_nr_vd_idx_last = (fsm_lmul_onehot[0] & (vd_idx == 6'h1)) | (fsm_lmul_onehot[1] & (vd_idx == 6'h3)) | (fsm_lmul_onehot[2] & (vd_idx == 6'h7)) | (fsm_lmul_onehot[3] & (vd_idx == 6'hf)) | (fsm_lmul_onehot[5] & (vd_idx == 6'h1)) | (fsm_lmul_onehot[6] & (vd_idx == 6'h1)) | (fsm_lmul_onehot[7] & (vd_idx == 6'h1));
        assign vzsext_vd_idx_last = (fsm_lmul_onehot[5] & (vd_idx == 6'h1)) | (fsm_lmul_onehot[6] & (vd_idx == 6'h1)) | (fsm_lmul_onehot[7] & (vd_idx == 6'h1)) | (fsm_lmul_onehot[0] & (vd_idx == 6'h1)) | (fsm_lmul_onehot[1] & (vd_idx == 6'h3)) | (fsm_lmul_onehot[2] & (vd_idx == 6'h7)) | (fsm_lmul_onehot[3] & (vd_idx == 6'hf));
        assign vs2_idx_lt_vf2_lmul = (fsm_lmul_onehot[0] & (vs2_idx < 6'h2)) | (fsm_lmul_onehot[1] & (vs2_idx < 6'h2)) | (fsm_lmul_onehot[2] & (vs2_idx < 6'h4)) | (fsm_lmul_onehot[3] & (vs2_idx < 6'h8)) | (fsm_lmul_onehot[5] & (vs2_idx < 6'h2)) | (fsm_lmul_onehot[6] & (vs2_idx < 6'h2)) | (fsm_lmul_onehot[7] & (vs2_idx < 6'h2));
        assign vs2_idx_lt_vf4_lmul = (fsm_lmul_onehot[0] & (vs2_idx < 6'h2)) | (fsm_lmul_onehot[1] & (vs2_idx < 6'h2)) | (fsm_lmul_onehot[2] & (vs2_idx < 6'h2)) | (fsm_lmul_onehot[3] & (vs2_idx < 6'h4)) | (fsm_lmul_onehot[5] & (vs2_idx < 6'h2)) | (fsm_lmul_onehot[6] & (vs2_idx < 6'h2)) | (fsm_lmul_onehot[7] & (vs2_idx < 6'h2));
        assign vs2_idx_lt_vf8_lmul = (vs2_idx < 6'd2);
        kv_mux #(
            .N(VLEN * 8 / DLEN),
            .W(DLEN / 8)
        ) u_vstart_mask_mux (
            .out(vmv_nr_vstart_mask),
            .sel(vd_idx[VPBW +:4]),
            .in(fsm_vstart_mask)
        );
        wire [DLEN - 1:0] vs1_lmul_sew_mask;
        kv_mux #(
            .N(VD_RATIO),
            .W(DLEN)
        ) u_vs1_mask_mux (
            .out(vs1_lmul_sew_mask),
            .sel(vs1_idx[VPBW + 1 +:VD_RATIO_IDX]),
            .in(vcompress_vs1_lmul_sew_mask)
        );
        assign vs1_buf_nx = e0_vs1_idx_en ? {VD_RATIO{vs1_rdata & ({DLEN{~fsm_vcompress}} | vs1_lmul_sew_mask)}} : vcompress_vs1_buf_nx;
        assign vs1_buf_we = {4{fsm_vcompress & vcompress_vs1_buf_en}} | ({4{fsm_vcompress & e0_vs1_idx_en}} & vs1_idx_onehot) | ({4{fsm_vrgather_vv & e0_vs1_idx_en}} & vs1_idx_onehot) | ({4{fsm_vrgatherei16 & e0_vs1_idx_en & fsm_sew_onehot[0]}} & vs1_idx_onehot) | ({4{fsm_vrgatherei16 & e0_vs1_idx_en & fsm_sew_onehot[1]}} & vs1_idx_onehot) | ({4{fsm_vrgatherei16 & e0_vs1_idx_en & fsm_sew_onehot[2] & vd_idx_lt_lmul}} & vs1_idx_onehot) | ({4{fsm_vrgatherei16 & e0_vs1_idx_en & fsm_sew_onehot[3] & vd_idx_lt_lmul}} & vs1_idx_onehot);
        assign vs2_idx_gt_vlmax = (fsm_lmul_onehot[0] & (vs2_idx > 6'h04)) | (fsm_lmul_onehot[1] & (vs2_idx > 6'h08)) | (fsm_lmul_onehot[2] & (vs2_idx > 6'h10)) | (fsm_lmul_onehot[3] & (vs2_idx > 6'h20)) | (fsm_lmul_onehot[5] & (vs2_idx > 6'h00)) | (fsm_lmul_onehot[6] & (vs2_idx > 6'h00)) | (fsm_lmul_onehot[7] & (vs2_idx > 6'h02));
        assign vs2_idx_eq_vlmax = (fsm_lmul_onehot[0] & (vs2_idx == 6'h04)) | (fsm_lmul_onehot[1] & (vs2_idx == 6'h08)) | (fsm_lmul_onehot[2] & (vs2_idx == 6'h10)) | (fsm_lmul_onehot[3] & (vs2_idx == 6'h20)) | (fsm_lmul_onehot[5] & (vs2_idx == 6'h00)) | (fsm_lmul_onehot[6] & (vs2_idx == 6'h00)) | (fsm_lmul_onehot[7] & (vs2_idx == 6'h02));
        assign vs2_idx_lt_vlmax = ~vs2_idx_gt_vlmax & ~vs2_idx_eq_vlmax;
        assign vs2_idx_ge_vlmax = ~vs2_idx_lt_vlmax;
    end
endgenerate
always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        fsm_cs <= {{(STATES - 1){1'b0}},1'b1};
    end
    else if (fsm_en) begin
        fsm_cs <= fsm_ns;
    end
end

always @* begin
    fsm_ns[IDLE] = ~req_valid | req_kill;
    fsm_ns[VSLIDEUP] = ~fsm_ns[IDLE] & req_vslideup;
    fsm_ns[VSLIDEDN] = ~fsm_ns[IDLE] & req_vslidedn;
    fsm_ns[VRGATHER] = ~fsm_ns[IDLE] & req_vrgather;
    fsm_ns[VCOMPRESS] = ~fsm_ns[IDLE] & req_vcompress;
    fsm_ns[VMV_SFX] = ~fsm_ns[IDLE] & req_vmv_sfx;
    fsm_ns[VMV_FXS] = ~fsm_ns[IDLE] & req_vmv_fxs;
    fsm_ns[VMV_NR] = ~fsm_ns[IDLE] & req_vmv_nr;
    fsm_ns[VZSEXT] = ~fsm_ns[IDLE] & req_vzsext;
    fsm_en = (fsm_cs[IDLE] & req_valid & ~req_kill) | fsm_done | fsm_kill;
end

wire fsm_committed_nx = (req_buf_valid & req_committed) | (req_buf_valid & req_cmt & ~cmt_kill) | (~fsm_cs[IDLE] & fsm_cmt & ~cmt_kill & ~fsm_done);
always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        fsm_committed <= 1'b0;
    end
    else if ((~fsm_cs[IDLE] & fsm_cmt) | fsm_en) begin
        fsm_committed <= fsm_committed_nx;
    end
end

generate
    if (RAR_SUPPORT) begin:gen_fsm_stage_rar
        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                fsm_lmul_onehot <= {8{1'b0}};
                fsm_sew_onehot <= {4{1'b0}};
                fsm_sew <= {2{1'b0}};
                fsm_id <= {CMT_DEP_IDX{1'b0}};
                fsm_rd_addr <= {5{1'b0}};
                fsm_vstart <= {10{1'b0}};
                fsm_vl <= {11{1'b0}};
                fsm_vs1 <= 1'b0;
                fsm_vs1_len <= {VRF_LW{1'b0}};
                fsm_vs2_len <= {VRF_LW{1'b0}};
                fsm_vd_len <= {VRF_LW{1'b0}};
                fsm_v0_mask8 <= {VLEN{1'b0}};
                fsm_vzsext_eew4x2 <= 1'b0;
                fsm_vzsext_eew4x4 <= 1'b0;
                fsm_vzsext_eew4x8 <= 1'b0;
                fsm_vzsext_eew8x2 <= 1'b0;
                fsm_vzsext_eew8x4 <= 1'b0;
                fsm_vzsext_eew8x8 <= 1'b0;
                fsm_vzsext_eew16x2 <= 1'b0;
                fsm_vzsext_eew16x4 <= 1'b0;
                fsm_vzsext_eew32x2 <= 1'b0;
                fsm_sub_func <= 1'b0;
                fsm_float <= 1'b0;
                fsm_fp_mode <= 1'b0;
            end
            else if (fsm_ctrl_en) begin
                fsm_lmul_onehot <= req_lmul_onehot;
                fsm_sew_onehot <= req_sew_onehot;
                fsm_sew <= req_sew;
                fsm_id <= req_id;
                fsm_rd_addr <= req_rd_addr;
                fsm_vstart <= req_vstart;
                fsm_vl <= req_vl;
                fsm_vs1 <= req_vs1;
                fsm_vs1_len <= req_vs1_len;
                fsm_vs2_len <= req_vs2_len;
                fsm_vd_len <= req_vd_len;
                fsm_v0_mask8 <= req_v0_mask;
                fsm_vzsext_eew4x2 <= req_zsext_idx == 2'h1 & req_sew_onehot[0] & (VECTOR_SINT_SUPPORT_INT == 1);
                fsm_vzsext_eew4x4 <= req_zsext_idx == 2'h2 & req_sew_onehot[1] & (VECTOR_SINT_SUPPORT_INT == 1);
                fsm_vzsext_eew4x8 <= req_zsext_idx == 2'h3 & req_sew_onehot[2] & (VECTOR_SINT_SUPPORT_INT == 1);
                fsm_vzsext_eew8x2 <= req_zsext_idx == 2'h1 & req_sew_onehot[1];
                fsm_vzsext_eew8x4 <= req_zsext_idx == 2'h2 & req_sew_onehot[2];
                fsm_vzsext_eew8x8 <= req_zsext_idx == 2'h3 & req_sew_onehot[3];
                fsm_vzsext_eew16x2 <= req_zsext_idx == 2'h1 & req_sew_onehot[2];
                fsm_vzsext_eew16x4 <= req_zsext_idx == 2'h2 & req_sew_onehot[3];
                fsm_vzsext_eew32x2 <= req_zsext_idx == 2'h1 & req_sew_onehot[3];
                fsm_sub_func <= req_sub_func;
                fsm_float <= req_float;
                fsm_fp_mode <= req_fp_mode;
            end
        end

        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                fsm_op1_hazard <= 1'b0;
            end
            else if (fsm_en | fsm_cmt) begin
                fsm_op1_hazard <= fsm_en & req_valid & req_op1_hazard & ~req_cmt;
            end
        end

        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                fsm_op1 <= {XLEN{1'b0}};
            end
            else if (fsm_ctrl_en | (vpermut_cmt_valid & fsm_op1_hazard & fsm_vfxi)) begin
                fsm_op1 <= fsm_op1_nx;
            end
        end

        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                fsm_offsetb <= {XLEN + 3{1'b0}};
            end
            else if (fsm_ctrl_en | (vpermut_cmt_valid & fsm_op1_hazard & ~((fsm_cs[VSLIDEUP] | fsm_cs[VSLIDEDN]) & fsm_vslide1))) begin
                fsm_offsetb <= req_offsetb;
            end
        end

    end
    else begin:gen_fsm_stage_no_rar
        always @(posedge vpu_vpermut_clk) begin
            if (fsm_ctrl_en) begin
                fsm_lmul_onehot <= req_lmul_onehot;
                fsm_sew_onehot <= req_sew_onehot;
                fsm_sew <= req_sew;
                fsm_id <= req_id;
                fsm_rd_addr <= req_rd_addr;
                fsm_vstart <= req_vstart;
                fsm_vl <= req_vl;
                fsm_vs1 <= req_vs1;
                fsm_vs1_len <= req_vs1_len;
                fsm_vs2_len <= req_vs2_len;
                fsm_vd_len <= req_vd_len;
                fsm_v0_mask8 <= req_v0_mask;
                fsm_vzsext_eew4x2 <= req_zsext_idx == 2'h1 & req_sew_onehot[0] & (VECTOR_SINT_SUPPORT_INT == 1);
                fsm_vzsext_eew4x4 <= req_zsext_idx == 2'h2 & req_sew_onehot[1] & (VECTOR_SINT_SUPPORT_INT == 1);
                fsm_vzsext_eew4x8 <= req_zsext_idx == 2'h3 & req_sew_onehot[2] & (VECTOR_SINT_SUPPORT_INT == 1);
                fsm_vzsext_eew8x2 <= req_zsext_idx == 2'h1 & req_sew_onehot[1];
                fsm_vzsext_eew8x4 <= req_zsext_idx == 2'h2 & req_sew_onehot[2];
                fsm_vzsext_eew8x8 <= req_zsext_idx == 2'h3 & req_sew_onehot[3];
                fsm_vzsext_eew16x2 <= req_zsext_idx == 2'h1 & req_sew_onehot[2];
                fsm_vzsext_eew16x4 <= req_zsext_idx == 2'h2 & req_sew_onehot[3];
                fsm_vzsext_eew32x2 <= req_zsext_idx == 2'h1 & req_sew_onehot[3];
                fsm_sub_func <= req_sub_func;
                fsm_float <= req_float;
                fsm_fp_mode <= req_fp_mode;
            end
        end

        always @(posedge vpu_vpermut_clk) begin
            if (fsm_en | fsm_cmt) begin
                fsm_op1_hazard <= fsm_en & req_valid & req_op1_hazard & ~req_cmt;
            end
        end

        always @(posedge vpu_vpermut_clk) begin
            if (fsm_ctrl_en | (vpermut_cmt_valid & fsm_op1_hazard & fsm_vfxi)) begin
                fsm_op1 <= fsm_op1_nx;
            end
        end

        always @(posedge vpu_vpermut_clk) begin
            if (fsm_ctrl_en | (vpermut_cmt_valid & fsm_op1_hazard & ~((fsm_cs[VSLIDEUP] | fsm_cs[VSLIDEDN]) & fsm_vslide1))) begin
                fsm_offsetb <= req_offsetb;
            end
        end

    end
endgenerate
always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vs1_idx <= {VD_IDXW - VPBW + 2{1'b0}};
    end
    else if (vs1_idx_en) begin
        vs1_idx <= vs1_idx_nx;
    end
end

always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vs2_idx <= {VD_IDXW - VPBW + 1{1'b0}};
    end
    else if (vs2_idx_en) begin
        vs2_idx <= vs2_idx_nx;
    end
end

always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vd_cmp_idx <= 3'b0;
    end
    else if (vd_cmp_idx_en) begin
        vd_cmp_idx <= vd_cmp_idx_nx;
    end
end

always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vd_idx <= {VP_IDXW - VPBW + 1{1'b0}};
    end
    else if (vd_idx_en) begin
        vd_idx <= vd_idx_nx;
    end
end

always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vs2_idx_ge_vlmax_d <= 1'b0;
    end
    else if (req_grant | (fsm_vslidedn & vslidedn_vd_idx_en)) begin
        vs2_idx_ge_vlmax_d <= vs2_idx_ge_vlmax & ~req_grant;
    end
end

assign req_grant = req_valid & ~req_kill & (fsm_idle | fsm_done | fsm_kill);
kv_bin2onehot #(
    .N(16 * VP_RATIO)
) u_vs2_idx_onehot (
    .out(vs2_idx_onehot),
    .in(vs2_idx_dec_in)
);
assign common_vs2_buf_we = {8{vs2_idx_onehot[0 +:VP_RATIO]}};
assign fsm_ctrl_en = req_grant;
assign vs2_rready = ((fsm_vslideup & vslideup_vs2_rready) | (fsm_vslidedn & vslidedn_vs2_rready) | (fsm_vrgather_vxi & vrgathervxi_vs2_rready) | (fsm_vrgather_vv & vrgather_vs2_rready) | (fsm_vrgatherei16 & vrgather_vs2_rready) | (fsm_vcompress & vcompress_vs2_rready) | (fsm_vzsext & vzsext_vs2_rready) | (fsm_vmv_nr & vmv_nr_vs2_rready) | (fsm_vmv_fxs & vmv_fxs_vs2_rready) | (fsm_vmv_sfx & vmv_sfx_vs2_rready));
assign vpermut_vs2_rready = vs2_rready_en & vs2_rready;
assign vpermut_vs1_rready = vs1_rready_en & vs1_rready;
assign vs1_rready = fsm_vs1 & ((fsm_vrgather_vv & vrgather_vs1_rready) | (fsm_vrgatherei16 & vrgatherei16_vs1_rready) | (fsm_vcompress & vcompress_vs1_rready));
assign vs1_idx_le_len = vs1_len_idx <= {2'b0,fsm_vs1_len[VRF_LW - 1 -:3]};
assign vs1_idx_eq_len = vs1_len_idx == {2'b0,fsm_vs1_len[VRF_LW - 1 -:3]};
assign vs1_idx_lt_lmul_sew64 = (fsm_lmul_onehot[0] & (vs1_len_idx < 5'd1)) | (fsm_lmul_onehot[1] & (vs1_len_idx < 5'd1)) | (fsm_lmul_onehot[2] & (vs1_len_idx < 5'd1)) | (fsm_lmul_onehot[3] & (vs1_len_idx < 5'd2)) | (fsm_lmul_onehot[5] & (vs1_len_idx < 5'd1)) | (fsm_lmul_onehot[6] & (vs1_len_idx < 5'd1)) | (fsm_lmul_onehot[7] & (vs1_len_idx < 5'd1));
assign vs1_idx_lt_lmul_sew32 = (fsm_lmul_onehot[0] & (vs1_len_idx < 5'd1)) | (fsm_lmul_onehot[1] & (vs1_len_idx < 5'd1)) | (fsm_lmul_onehot[2] & (vs1_len_idx < 5'd2)) | (fsm_lmul_onehot[3] & (vs1_len_idx < 5'd4)) | (fsm_lmul_onehot[5] & (vs1_len_idx < 5'd1)) | (fsm_lmul_onehot[6] & (vs1_len_idx < 5'd1)) | (fsm_lmul_onehot[7] & (vs1_len_idx < 5'd1));
assign vs1_idx_lt_lmul = (fsm_lmul_onehot[0] & (vs1_len_idx < 5'd1)) | (fsm_lmul_onehot[1] & (vs1_len_idx < 5'd2)) | (fsm_lmul_onehot[2] & (vs1_len_idx < 5'd4)) | (fsm_lmul_onehot[3] & (vs1_len_idx < 5'd8)) | (fsm_lmul_onehot[5] & (vs1_len_idx < 5'd1)) | (fsm_lmul_onehot[6] & (vs1_len_idx < 5'd1)) | (fsm_lmul_onehot[7] & (vs1_len_idx < 5'd1));
assign vs1_idx_lt_lmulx2 = (fsm_lmul_onehot[0] & (vs1_len_idx < 5'h2)) | (fsm_lmul_onehot[1] & (vs1_len_idx < 5'h4)) | (fsm_lmul_onehot[2] & (vs1_len_idx < 5'h8)) | (fsm_lmul_onehot[3] & (vs1_len_idx < 5'h10)) | (fsm_lmul_onehot[5] & (vs1_len_idx < 5'h1)) | (fsm_lmul_onehot[6] & (vs1_len_idx < 5'h1)) | (fsm_lmul_onehot[7] & (vs1_len_idx < 5'h1));
assign vs2_idx_last = vs2_vl_last & ((fsm_lmul_onehot[0] & (vs2_len_idx == 4'd0)) | (fsm_lmul_onehot[1] & (vs2_len_idx == 4'd1)) | (fsm_lmul_onehot[2] & (vs2_len_idx == 4'd3)) | (fsm_lmul_onehot[3] & (vs2_len_idx == 4'd7)) | (fsm_lmul_onehot[5] & (vs2_len_idx == 4'd0)) | (fsm_lmul_onehot[6] & (vs2_len_idx == 4'd0)) | (fsm_lmul_onehot[7] & (vs2_len_idx == 4'd0)));
assign vs2_idx_lt_lmul = (fsm_lmul_onehot[0] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[1] & (vs2_len_idx < 4'd2)) | (fsm_lmul_onehot[2] & (vs2_len_idx < 4'd4)) | (fsm_lmul_onehot[3] & (vs2_len_idx < 4'd8)) | (fsm_lmul_onehot[5] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[6] & (vs2_len_idx < 4'd1)) | (fsm_lmul_onehot[7] & (vs2_len_idx < 4'd1));
assign vs2_idx_ge_lmul = ~vs2_idx_lt_lmul;
assign vs2_idx_lt_vzsext_emul = (fsm_vzsext_vf2 & vs2_idx_lt_vf2_lmul) | (fsm_vzsext_vf4 & vs2_idx_lt_vf4_lmul) | (fsm_vzsext_vf8 & vs2_idx_lt_vf8_lmul);
assign vd_idx_vf_last = |(fsm_vzsext_vf2 & vd_idx[VPBW +:1]) | (fsm_vzsext_vf4 & (&vd_idx[VPBW +:2])) | (fsm_vzsext_vf8 & (&vd_idx[VPBW +:3]));
assign vd_idx_last = vd_vl_last & ((fsm_lmul_onehot[0] & (vd_len_idx == 4'd0)) | (fsm_lmul_onehot[1] & (vd_len_idx == 4'd1)) | (fsm_lmul_onehot[2] & (vd_len_idx == 4'd3)) | (fsm_lmul_onehot[3] & (vd_len_idx == 4'd7)) | (fsm_lmul_onehot[5] & (vd_len_idx == 4'd0)) | (fsm_lmul_onehot[6] & (vd_len_idx == 4'd0)) | (fsm_lmul_onehot[7] & (vd_len_idx == 4'd0)));
assign vd_idx_lt_lmul = (fsm_lmul_onehot[0] & (vd_len_idx < 4'd1)) | (fsm_lmul_onehot[1] & (vd_len_idx < 4'd2)) | (fsm_lmul_onehot[2] & (vd_len_idx < 4'd4)) | (fsm_lmul_onehot[3] & (vd_len_idx < 4'd8)) | (fsm_lmul_onehot[5] & (vd_len_idx < 4'd1)) | (fsm_lmul_onehot[6] & (vd_len_idx < 4'd1)) | (fsm_lmul_onehot[7] & (vd_len_idx < 4'd1));
assign vd_idx_ge_lmul = ~vd_idx_lt_lmul;
assign vd_cmp_idx_last = (fsm_lmul_onehot[0] & (vd_cmp_idx == 3'd0)) | (fsm_lmul_onehot[1] & (vd_cmp_idx == 3'd1)) | (fsm_lmul_onehot[2] & (vd_cmp_idx == 3'd3)) | (fsm_lmul_onehot[3] & (vd_cmp_idx == 3'd7)) | (fsm_lmul_onehot[5] & (vd_cmp_idx == 3'd0)) | (fsm_lmul_onehot[6] & (vd_cmp_idx == 3'd0)) | (fsm_lmul_onehot[7] & (vd_cmp_idx == 3'd0));
assign vd_cmp_idx_clr = e0_kill | e1_kill | (fsm_vrgather_vv & vd_cmp_idx_last) | (fsm_vrgatherei16 & vd_cmp_idx_last);
assign vd_cmp_idx_en_pre = (fsm_vrgather_vv & vrgather_vd_cmp_idx_en) | (fsm_vrgatherei16 & vrgather_vd_cmp_idx_en);
assign vd_cmp_idx_en = e0_kill | e1_kill | (e0_vd_cmp_ready & vd_cmp_idx_en_pre);
assign {nds_unused_vd_cmp_idx_add_one,vd_cmp_idx_add_one} = {1'b0,vd_cmp_idx} + 4'b1;
assign vd_cmp_idx_nx = vd_cmp_idx_clr ? 3'd0 : vd_cmp_idx_add_one[2:0];
assign vs1_idx_en = req_grant | e0_vs1_idx_en;
assign {nds_unused_vs1_idx_add_one,vs1_idx_add_one} = {1'b0,vs1_idx} + {{(VD_IDXW - VPBW + 2){1'b0}},1'b1};
assign vs1_idx_nx = req_grant ? {VD_IDXW - VPBW + 2{1'b0}} : vs1_idx_add_one[VD_IDXW + 1:VPBW];
assign vs2_idx_en = req_grant | e0_vs2_idx_en;
assign {nds_unused_vs2_idx_add_one,vs2_idx_add_one} = {1'b0,vs2_idx} + {{(VD_IDXW - VPBW + 1){1'b0}},1'b1};
assign vs2_idx_nx = req_grant ? {VD_IDXW - VPBW + 1{1'b0}} : vs2_idx_add_one[VD_IDXW:VPBW];
assign vd_idx_en = req_grant | e0_vd_idx_en;
assign {nds_unused_vd_idx_add_one,vd_idx_add_one} = {1'b0,vd_idx} + {{(VD_IDXW - VPBW + 1){1'b0}},vd_idx_lt_lmul};
assign vd_idx_nx = req_grant ? {VP_IDXW - VPBW + 1{1'b0}} : vd_idx_add_one[VP_IDXW:VPBW];
assign e0_vd_idx_en = (fsm_vslideup & vslideup_vd_idx_en) | (fsm_vslidedn & vslidedn_vd_idx_en) | (fsm_vrgather_vv & vrgather_vd_idx_en) | (fsm_vrgatherei16 & vrgather_vd_idx_en) | (fsm_vrgather_vxi & vrgathervxi_vd_idx_en) | (fsm_vcompress & vcompress_vd_idx_en) | (fsm_vmv_fxs & vmv_fxs_vd_idx_en) | (fsm_vmv_nr & vmv_nr_vd_idx_en) | (fsm_vzsext & vzsext_vd_idx_en) | (fsm_vmv_sfx & vmv_sfx_vd_idx_en);
assign e0_vs2_idx_en = vpermut_vs2_rvalid & ~fsm_kill & vs2_rready & ((fsm_vmv_nr | fsm_vzsext) ? dl_vs2_idx_le_len : vs2_idx_le_len);
assign e0_vs1_idx_en = vpermut_vs1_rvalid & vs1_rready & ~fsm_kill & vs1_idx_le_len;
assign vs1_sew_onehot = fsm_sew_onehot;
wire vl_mask8_lt_lmul8;
generate
    if (VLEN < 1024) begin:gen_vl_mask8_eq_1024
        assign vl_mask8_lt_lmul8 = ~|fsm_vl[10:VD_IDXW + 1];
    end
    else begin:gen_vl_mask8_eq_1024
        assign vl_mask8_lt_lmul8 = 1'b1;
    end
endgenerate
kv_bin2onehot #(
    .N(2 * VLEN)
) u_vl_sew8 (
    .in(fsm_vl[VD_IDXW:0]),
    .out(vl_onehot8)
);
assign fsm_vl_emask8 = {VLEN{vl_mask8_lt_lmul8}} & vl_onehot8[VLEN:1];
kv_bin2onehot #(
    .N(VLEN)
) u_vl_sew16 (
    .in(fsm_vl[VD_IDXW - 1:0]),
    .out(vl_onehot16)
);
wire [VLEN / 2 - 1:0] vl_emask16 = {VLEN / 2{~|fsm_vl[10:VD_IDXW]}} & vl_onehot16[VLEN / 2:1];
kv_bit_expand #(
    .N(VLEN / 2),
    .M(2)
) u_vl_emask16 (
    .in(vl_emask16),
    .out(fsm_vl_emask16)
);
kv_bin2onehot #(
    .N(VLEN / 2)
) u_vl_sew32 (
    .in(fsm_vl[VD_IDXW - 2:0]),
    .out(vl_onehot32)
);
wire [VLEN / 4 - 1:0] vl_emask32 = {VLEN / 4{~|fsm_vl[10:VD_IDXW - 1]}} & vl_onehot32[VLEN / 4:1];
kv_bit_expand #(
    .N(VLEN / 4),
    .M(4)
) u_vl_emask32 (
    .in(vl_emask32),
    .out(fsm_vl_emask32)
);
kv_bin2onehot #(
    .N(VLEN / 4)
) u_vl_sew64 (
    .in(fsm_vl[VD_IDXW - 3:0]),
    .out(vl_onehot64)
);
wire [VLEN / 8 - 1:0] vl_emask64 = {VLEN / 8{~|fsm_vl[10:VD_IDXW - 2]}} & vl_onehot64[VLEN / 8:1];
kv_bit_expand #(
    .N(VLEN / 8),
    .M(8)
) u_vl_emask64 (
    .in(vl_emask64),
    .out(fsm_vl_emask64)
);
wire [VLEN - 1:0] fsm_vl_emask = fsm_lmul_mask & (({VLEN{fsm_sew_onehot[0]}} & fsm_vl_emask8) | ({VLEN{fsm_sew_onehot[1]}} & fsm_vl_emask16) | ({VLEN{fsm_sew_onehot[2]}} & fsm_vl_emask32) | ({VLEN{fsm_sew_onehot[3]}} & fsm_vl_emask64));
assign vl_mask8 = {VLEN{|fsm_vl[10:VD_IDXW - 0]}} | ~({VLEN{1'b1}} << fsm_vl[VD_IDXW - 1:0]);
assign fsm_vl_mask8 = vl_mask8;
assign vl_mask16 = {VLEN / 2{|fsm_vl[10:VD_IDXW - 1]}} | ~({VLEN / 2{1'b1}} << fsm_vl[VD_IDXW - 2:0]);
kv_bit_expand #(
    .N(VLEN / 2),
    .M(2)
) u_vl_mask16 (
    .in(vl_mask16),
    .out(fsm_vl_mask16)
);
assign vl_mask32 = {VLEN / 4{|fsm_vl[10:VD_IDXW - 2]}} | ~({VLEN / 4{1'b1}} << fsm_vl[VD_IDXW - 3:0]);
kv_bit_expand #(
    .N(VLEN / 4),
    .M(4)
) u_vl_mask32 (
    .in(vl_mask32),
    .out(fsm_vl_mask32)
);
assign vl_mask64 = {VLEN / 8{|fsm_vl[10:VD_IDXW - 3]}} | ~({VLEN / 8{1'b1}} << fsm_vl[VD_IDXW - 4:0]);
kv_bit_expand #(
    .N(VLEN / 8),
    .M(8)
) u_vl_mask64 (
    .in(vl_mask64),
    .out(fsm_vl_mask64)
);
wire [VLEN - 1:0] fsm_vl_mask = fsm_lmul_mask & (({VLEN{fsm_sew_onehot[0]}} & fsm_vl_mask8) | ({VLEN{fsm_sew_onehot[1]}} & fsm_vl_mask16) | ({VLEN{fsm_sew_onehot[2]}} & fsm_vl_mask32) | ({VLEN{fsm_sew_onehot[3]}} & fsm_vl_mask64));
generate
    if (VLEN < 1024) begin:gen_vlen_lt_1024
        assign vstart_sew8_high_gt_1 = |fsm_vstart[9:VD_IDXW - 0];
    end
    else begin:gen_vlen_eq_1024
        assign vstart_sew8_high_gt_1 = 1'b0;
    end
endgenerate
assign vstart_mask8 = {VLEN{~vstart_sew8_high_gt_1}} << fsm_vstart[VD_IDXW - 1:0];
assign fsm_vstart_mask8 = vstart_mask8;
assign vstart_mask16 = {VLEN / 2{~|fsm_vstart[9:VD_IDXW - 1]}} << fsm_vstart[VD_IDXW - 2:0];
kv_bit_expand #(
    .N(VLEN / 2),
    .M(2)
) u_vstart_mask16 (
    .in(vstart_mask16),
    .out(fsm_vstart_mask16)
);
assign vstart_mask32 = {VLEN / 4{~|fsm_vstart[9:VD_IDXW - 2]}} << fsm_vstart[VD_IDXW - 3:0];
kv_bit_expand #(
    .N(VLEN / 4),
    .M(4)
) u_vstart_mask32 (
    .in(vstart_mask32),
    .out(fsm_vstart_mask32)
);
assign vstart_mask64 = {VLEN / 8{~|fsm_vstart[9:VD_IDXW - 3]}} << fsm_vstart[VD_IDXW - 4:0];
kv_bit_expand #(
    .N(VLEN / 8),
    .M(8)
) u_vstart_mask64 (
    .in(vstart_mask64),
    .out(fsm_vstart_mask64)
);
assign fsm_vstart_mask = fsm_lmul_mask & (({VLEN{fsm_sew_onehot[0]}} & fsm_vstart_mask8) | ({VLEN{fsm_sew_onehot[1]}} & fsm_vstart_mask16) | ({VLEN{fsm_sew_onehot[2]}} & fsm_vstart_mask32) | ({VLEN{fsm_sew_onehot[3]}} & fsm_vstart_mask64));
wire [VLEN - 1:0] fsm_vstart_vl_mask = fsm_vstart_mask & fsm_vl_mask;
kv_bit_expand #(
    .N(VLEN / 2),
    .M(2)
) u_v0_mask16 (
    .in(fsm_v0_mask8[VLEN / 2 - 1:0]),
    .out(fsm_v0_mask16)
);
kv_bit_expand #(
    .N(VLEN / 4),
    .M(4)
) u_v0_mask32 (
    .in(fsm_v0_mask8[VLEN / 4 - 1:0]),
    .out(fsm_v0_mask32)
);
kv_bit_expand #(
    .N(VLEN / 8),
    .M(8)
) u_v0_mask64 (
    .in(fsm_v0_mask8[VLEN / 8 - 1:0]),
    .out(fsm_v0_mask64)
);
wire [VLEN - 1:0] fsm_v0_mask = fsm_lmul_mask & (({VLEN{fsm_sew_onehot[0]}} & fsm_v0_mask8) | ({VLEN{fsm_sew_onehot[1]}} & fsm_v0_mask16) | ({VLEN{fsm_sew_onehot[2]}} & fsm_v0_mask32) | ({VLEN{fsm_sew_onehot[3]}} & fsm_v0_mask64));
wire [VLEN - 1:0] fsm_v0_vstart_vl_mask = fsm_v0_mask & fsm_vstart_vl_mask;
wire [VP_LEN / 8 - 1:0] e0_vd_mask;
wire [VP_LEN / 8 - 1:0] e0_vd_una_mask;
assign fsm_vslidedn_unaligned = fsm_offsetb_remainder & fsm_offsetb_lt_lmul & ~lmul_le_vpermut_dlen & vl_gt_vstart;
wire [VP_IDXW - VPBW:0] vd_una_idx = vd_idx[VP_IDXW - 1:VPBW] + {VP_IDXW - VPBW{1'b1}};
wire nds_unused_v0_mask_idx_carry = vd_una_idx[VP_IDXW - VPBW];
kv_mux #(
    .N(VLEN * 8 / VP_LEN),
    .W(VP_LEN / 8)
) u_aligned_mask_mux (
    .out(e0_vd_mask),
    .sel(vd_idx[VP_IDXW - 1:VPBW]),
    .in(fsm_v0_vstart_vl_mask)
);
kv_mux #(
    .N(VLEN * 8 / VP_LEN),
    .W(VP_LEN / 8)
) u_unaligned_mask_mux (
    .out(e0_vd_una_mask),
    .sel(vd_una_idx[VP_IDXW - VPBW - 1:0]),
    .in(fsm_v0_vstart_vl_mask)
);
kv_vpermut_idx #(
    .RAR_SUPPORT(RAR_SUPPORT),
    .VS1_LEN(VS1_LEN),
    .VLEN(VLEN),
    .DLEN(DLEN),
    .VP_LEN(VP_LEN)
) u_idx (
    .vpu_vpermut_clk(vpu_vpermut_clk),
    .vpu_reset_n(vpu_reset_n),
    .lmul_onehot(fsm_lmul_onehot),
    .sew_onehot(vs1_sew_onehot),
    .req_grant(req_grant),
    .req_vcompress(req_vcompress),
    .fsm_vcompress(fsm_vcompress),
    .offsetb(fsm_offsetb[VLBW - 1:0]),
    .vs2_buf_valid(vs2_buf_valid),
    .vs1_buf_valid(vs1_buf_valid),
    .vs1_buf(vs1_buf),
    .vd_idx(vd_sel_idx),
    .vs2_idx(vs2_idx),
    .vd_cmp_idx(vd_cmp_idx),
    .vd_cmp_idx_last(vd_cmp_idx_last),
    .vmv_nr_vd_byte_sel(vmv_vd_byte_sel),
    .vslideup_vd_byte_sel(vslideup_vd_byte_sel),
    .vslidedn_vd_byte_sel(vslidedn_vd_byte_sel),
    .vcompress_vd_byte_sel(vcompress_vd_byte_sel),
    .vcompress_vd_buf1_sel(vcompress_vd_buf1_sel),
    .vcompress_e0c_en(vcompress_e0c_en),
    .vcompress_e0c_valid(vcompress_e0c_valid),
    .vcompress_vd_avail(vcompress_vd_avail),
    .vcompress_vd_wmask_part_wr(vcompress_vd_wmask_part_wr),
    .vcompress_buf0_mask(vcompress_buf0_mask),
    .vcompress_buf1_mask(vcompress_buf1_mask),
    .vcompress_vs1_buf_nx(vcompress_vs1_buf_nx),
    .vrgather_vd_byte_sel(vrgather_vd_byte_sel),
    .vrgathervxi_vd_byte_sel(vrgathervxi_vd_byte_sel),
    .vrgather_body_mask(vrgather_body_mask),
    .vrgather_buf0_mask(vrgather_buf0_mask),
    .vrgatherei16_vd_byte_sel(vrgatherei16_vd_byte_sel),
    .vrgatherei16_body_mask(vrgatherei16_body_mask),
    .vrgatherei16_buf0_mask(vrgatherei16_buf0_mask),
    .vmv_fxs_vd_byte_sel_eew8x8(vmv_fxs_vd_byte_sel_eew8x8),
    .vmv_fxs_vd_byte_sel_eew16x4(vmv_fxs_vd_byte_sel_eew16x4),
    .vmv_fxs_vd_byte_sel_eew32x2(vmv_fxs_vd_byte_sel_eew32x2),
    .vzsext_vd_byte_sel_eew4x2(vzsext_vd_byte_sel_eew4x2),
    .vzsext_vd_byte_sel_eew4x4(vzsext_vd_byte_sel_eew4x4),
    .vzsext_vd_byte_sel_eew4x8(vzsext_vd_byte_sel_eew4x8),
    .vzsext_vd_byte_sel_eew8x2(vzsext_vd_byte_sel_eew8x2),
    .vzsext_vd_byte_sel_eew8x4(vzsext_vd_byte_sel_eew8x4),
    .vzsext_vd_byte_sel_eew8x8(vzsext_vd_byte_sel_eew8x8),
    .vzsext_vd_byte_sel_eew16x2(vzsext_vd_byte_sel_eew16x2),
    .vzsext_vd_byte_sel_eew16x4(vzsext_vd_byte_sel_eew16x4),
    .vzsext_vd_byte_sel_eew32x2(vzsext_vd_byte_sel_eew32x2),
    .vzsext_body_mask_eew8x2(vzsext_body_mask_eew8x2),
    .vzsext_body_mask_eew8x4(vzsext_body_mask_eew8x4),
    .vzsext_body_mask_eew8x8(vzsext_body_mask_eew8x8),
    .vzsext_body_mask_eew16x2(vzsext_body_mask_eew16x2),
    .vzsext_body_mask_eew16x4(vzsext_body_mask_eew16x4),
    .vzsext_body_mask_eew32x2(vzsext_body_mask_eew32x2)
);
assign {nds_unused_sll_mask,sll_mask} = {(VP_LEN / 8){fsm_offsetb_lt_lmul}} << fsm_offsetb[VPBW - 1:0];
kv_bit_reverse #(
    .W(VP_LEN / 8)
) u_mx_slr_mask (
    .out(mx_slr_mask),
    .in(sll_mask)
);
kv_bit_reverse #(
    .W(VLEN / 64)
) u_mf8_slr_mask (
    .out(mf8_slr_mask),
    .in(sll_mask[VLEN / 64 - 1:0])
);
generate
    if (VP_RATIO == 4) begin:gen_slr_mask_vpermut_dlen_ratio_eq_4
        assign slr_mask = {{VLEN / 64{1'b0}},{VLEN / 64{fsm_lmul_onehot[5]}} & mf8_slr_mask} | ({VLEN / 32{fsm_lmul_onehot[3] | fsm_lmul_onehot[2] | fsm_lmul_onehot[1] | fsm_lmul_onehot[0] | fsm_lmul_onehot[7] | fsm_lmul_onehot[6]}} & mx_slr_mask);
    end
    else if (VP_RATIO == 2) begin:gen_slr_mask_vpermut_dlen_ratio_eq_2
        wire [VLEN / 32 - 1:0] mf4_slr_mask;
        kv_bit_reverse #(
            .W(VLEN / 32)
        ) u_mf4_slr_mask (
            .out(mf4_slr_mask),
            .in(sll_mask[VLEN / 32 - 1:0])
        );
        assign slr_mask = {{VLEN * 1 / 32{1'b0}},{VLEN / 32{fsm_lmul_onehot[6]}} & mf4_slr_mask} | {{VLEN * 3 / 64{1'b0}},{VLEN / 64{fsm_lmul_onehot[5]}} & mf8_slr_mask} | ({VLEN / 16{fsm_lmul_onehot[3] | fsm_lmul_onehot[2] | fsm_lmul_onehot[1] | fsm_lmul_onehot[0] | fsm_lmul_onehot[7]}} & mx_slr_mask);
    end
    else begin:gen_slr_mask_vpermut_dlen_ratio_eq_1
        wire [VLEN / 16 - 1:0] mf2_slr_mask;
        wire [VLEN / 32 - 1:0] mf4_slr_mask;
        kv_bit_reverse #(
            .W(VLEN / 32)
        ) u_mf4_slr_mask (
            .out(mf4_slr_mask),
            .in(sll_mask[VLEN / 32 - 1:0])
        );
        kv_bit_reverse #(
            .W(VLEN / 16)
        ) u_mf2_slr_mask (
            .out(mf2_slr_mask),
            .in(sll_mask[VLEN / 16 - 1:0])
        );
        assign slr_mask = {{VLEN * 1 / 16{1'b0}},{VLEN / 16{fsm_lmul_onehot[7]}} & mf2_slr_mask} | {{VLEN * 3 / 32{1'b0}},{VLEN / 32{fsm_lmul_onehot[6]}} & mf4_slr_mask} | {{VLEN * 7 / 64{1'b0}},{VLEN / 64{fsm_lmul_onehot[5]}} & mf8_slr_mask} | ({VLEN / 08{fsm_lmul_onehot[3] | fsm_lmul_onehot[2] | fsm_lmul_onehot[1] | fsm_lmul_onehot[0]}} & mx_slr_mask);
    end
endgenerate
assign vslideup_op1_mask = {VP_LEN / 8{fsm_vslide1 & ~|{vd_idx,fsm_vstart}}} & ({{VP_LEN / 8 - 1{1'b0}},fsm_sew_onehot[0]} | {{VP_LEN / 8 - 2{1'b0}},{2{fsm_sew_onehot[1]}}} | {{VP_LEN / 8 - 4{1'b0}},{4{fsm_sew_onehot[2]}}} | {{VP_LEN / 8 - 8{1'b0}},{8{fsm_sew_onehot[3]}}});
assign vslideup_buf0_mask = vslideup_op1_mask | ({VP_LEN / 8{vd_idx_ge_offset & fsm_offsetb_lt_lmul}} & (vs2_idx[VPBW] ? ~sll_mask : sll_mask));
assign vslideup_buf1_mask = ({VP_LEN / 8{vd_idx_ge_offset & fsm_offsetb_lt_lmul}} & (vs2_idx[VPBW] ? sll_mask : ~sll_mask));
assign vslideup_body_mask = {(VP_LEN / 8){1'b1}};
assign vslideup_vd_wvalid = vd_idx_lt_lmul & (vd_idx_lt_offset | vslideup_vs2_idx_en) & vd_idx_le_len;
assign vslideup_vd_buf1_sel = vs2_idx[VPBW];
assign vslideup_vd_wmask_part_wr = 1'b0;
assign vslideup_vd_wmask_en = 1'b1;
assign vslideup_vd_wmask = e0_vd_mask & ((vd_idx_eq_offset & ~fsm_vslide1) ? sll_mask : {(VP_LEN / 8){~vd_idx_lt_offset}});
assign vslideup_vd_idx_en = ~e0_stall & vslideup_vd_wvalid;
assign vslideup_vs2_rready = ~e0_stall & (vd_idx_ge_offset | ~fsm_offsetb_lt_lmul);
assign vslideup_vs2_idx_en = vpermut_vs2_rvalid & vslideup_vs2_rready;
assign vslideup_e0_valid = 1'b1;
assign vslideup_done = ~e0_stall & vs2_idx_last & vslideup_vs2_idx_en & vs2_idx_eq_len & (vd_idx_eq_len | ~vd_idx_le_len);
assign vslideup_vs2_rdata_we = common_vs2_buf_we;
assign vslideup_vs2_buf_wdata_sel = 1'b0;
wire [VP_LEN / 8 - 1:0] e0_vl_sel0_emask;
wire [VP_LEN / 8 - 1:0] e0_vl_una_emask;
kv_mux #(
    .N(VLEN * 8 / VP_LEN),
    .W(VP_LEN / 8)
) u_vl_sel0_emask_mux (
    .out(e0_vl_sel0_emask),
    .sel({VP_IDXW - VPBW{1'b0}}),
    .in(fsm_vl_emask)
);
kv_mux #(
    .N(VLEN * 8 / VP_LEN),
    .W(VP_LEN / 8)
) u_vl_vd_una_emask_mux (
    .out(e0_vl_una_emask),
    .sel(vd_una_idx[VP_IDXW - VPBW - 1:0]),
    .in(fsm_vl_emask)
);
wire [VP_LEN / 8 - 1:0] e0_vd_vl_emask = lmul_le_vpermut_dlen ? e0_vl_sel0_emask : e0_vl_una_emask;
assign vslidedn_op1_mask = {(VP_LEN / 8){fsm_vslide1 & vslidedn_vd_wvalid}} & e0_vd_vl_emask;
assign vslidedn_buf0_mask = vslidedn_op1_mask | ({(VP_LEN / 8){~fsm_offsetb_lt_lmul | lmul_le_vpermut_dlen | (fsm_offsetb_remainder ? vs2_idx_ge_vlmax_d : vs2_idx_ge_vlmax)}} | (((vd_idx[VPBW] & byte_sel_mask[VPBW] & fsm_offsetb_remainder) ? ~slr_mask : slr_mask) & {(VP_LEN / 8){vs2_idx_ge_offset}}));
assign vslidedn_buf1_mask = vslidedn_op1_mask | ({(VP_LEN / 8){~fsm_offsetb_lt_lmul | lmul_le_vpermut_dlen | (fsm_offsetb_remainder ? vs2_idx_ge_vlmax_d : vs2_idx_ge_vlmax)}} | (((vd_idx[VPBW] & byte_sel_mask[VPBW] & fsm_offsetb_remainder) ? slr_mask : ~slr_mask) & {(VP_LEN / 8){vs2_idx_ge_offset}}));
assign vslidedn_body_mask = vslidedn_op1_mask | ({(VP_LEN / 8){fsm_offsetb_lt_lmul}} & ({(VP_LEN / 8){vs2_idx_lt_vlmax}} | ({(VP_LEN / 8){lmul_le_vpermut_dlen | (fsm_offsetb_remainder & ~vs2_idx_ge_vlmax_d)}} & slr_mask)));
assign vslidedn_vd_wvalid = ((vpermut_vs2_rvalid & (~fsm_offsetb_lt_lmul | ~vl_gt_vstart)) | vs2_idx_ge_lmul | (vslidedn_vs2_idx_en & (vs2_idx_gt_offset | (vs2_idx_eq_offset & (~fsm_offsetb_remainder | lmul_le_vpermut_dlen))))) & (fsm_vslidedn_unaligned ? una_vd_idx_le_len : vd_idx_le_len);
assign vslidedn_vd_idx_en = ((vpermut_vs2_rvalid & (~fsm_offsetb_lt_lmul | ~vl_gt_vstart)) | vs2_idx_ge_lmul | (vslidedn_vs2_idx_en & (vs2_idx_ge_offset | lmul_le_vpermut_dlen))) & ~e0_stall;
assign vslidedn_vd_buf1_sel = fsm_offsetb_remainder & ~vd_idx[VPBW] & byte_sel_mask[VPBW] & fsm_offsetb_lt_lmul;
assign vslidedn_vd_wmask_part_wr = 1'b0;
assign vslidedn_vd_wmask_en = 1'b1;
assign vslidedn_vd_wmask = fsm_vslidedn_unaligned ? e0_vd_una_mask : e0_vd_mask;
assign vslidedn_vs2_rready = ~e0_stall & vs2_idx_lt_lmul;
assign vslidedn_vs2_idx_en = vpermut_vs2_rvalid & vslidedn_vs2_rready;
assign vslidedn_e0_valid = 1'b1;
assign vslidedn_done = ~e0_stall & vslidedn_vd_wvalid & (fsm_vslidedn_unaligned ? una_vd_idx_eq_len : vd_idx_eq_len) & (vs2_idx_eq_len | ~vs2_idx_le_len) & (fsm_vslidedn_unaligned ? vd_idx_ge_lmul : vd_idx_last);
assign vslidedn_vs2_rdata_we = common_vs2_buf_we;
assign vslidedn_vs2_buf_wdata_sel = 1'b0;
assign vmv_nr_buf0_mask = {(VP_LEN / 8){1'b1}};
assign vmv_nr_vd_wmask = vmv_nr_vstart_mask[VP_LEN / 8 - 1:0];
assign vmv_nr_vd_wmask_part_wr = 1'b0;
assign vmv_nr_vd_wmask_en = 1'b1;
assign vmv_nr_vd_wvalid = vmv_nr_vs2_idx_en & dl_vd_idx_le_len;
assign vmv_nr_body_mask = {(VP_LEN / 8){1'b1}};
assign vmv_nr_e0_valid = 1'b1;
assign vmv_nr_vd_idx_en = vmv_nr_vd_wvalid;
assign vmv_nr_done = vmv_nr_vd_wvalid & vmv_nr_vd_idx_last & dl_vd_idx_eq_len & dl_vs2_idx_eq_len & ~e0_stall;
assign vmv_nr_vs2_rready = ~e0_stall;
assign vmv_nr_vs2_idx_en = vpermut_vs2_rvalid & vmv_nr_vs2_rready;
assign vmv_nr_vs2_buf_wdata_sel = 1'b0;
assign vrgathervxi_buf0_mask = {(VP_LEN / 8){1'b1}};
assign vrgathervxi_buf1_mask = {(VP_LEN / 8){1'b0}};
assign vrgathervxi_body_mask = {(VP_LEN / 8){fsm_offsetb_lt_lmul}};
assign vrgathervxi_vd_wmask = e0_vd_mask;
assign vrgathervxi_vd_wmask_part_wr = 1'b0;
assign vrgathervxi_vd_wmask_en = 1'b1;
assign vrgathervxi_vd_wvalid = ((vpermut_vs2_rvalid & vrgathervxi_vs2_rready & (vs2_idx_eq_offset | (~fsm_offsetb_lt_lmul & vd_idx_lt_lmul))) | (vs2_buf_valid & vd_idx_lt_lmul)) & vd_idx_le_len;
assign vrgathervxi_vd_buf1_sel = 1'b0;
assign vrgathervxi_e0_valid = 1'b1;
assign vrgathervxi_vd_idx_en = vrgathervxi_vd_wvalid & ~e0_stall;
assign vrgathervxi_done = (vrgathervxi_vd_idx_en & vd_idx_last & vd_idx_eq_len & vs2_idx_ge_lmul & ~vs2_idx_le_len) | (((vrgathervxi_vd_idx_en & vd_idx_last & vd_idx_eq_len) | (~vd_idx_lt_lmul & ~vd_idx_le_len)) & vpermut_vs2_rvalid & vrgathervxi_vs2_rready & vs2_idx_last & vs2_idx_eq_len);
assign vrgathervxi_vs2_rready = ~e0_stall;
assign vrgathervxi_vs2_rdata_we = {VP_WEW{vpermut_vs2_rvalid & ~e0_stall & vs2_idx_eq_offset}} & common_vs2_buf_we;
assign vrgathervxi_vs2_buf_wdata_sel = 1'b0;
assign vrgather_buf1_mask = {(VP_LEN / 8){1'b0}};
assign vrgather_vd_wmask = e0_vd_mask;
assign vrgather_vd_wmask_part_wr = |vd_cmp_idx;
assign vrgather_vd_wmask_en = 1'b1;
assign vrgather_vd_cmp_valid = vs1_buf_valid & vs2_buf_valid & vd_idx_lt_lmul & vd_idx_le_len;
assign vrgather_vd_wvalid = vrgather_vd_cmp_valid & vd_cmp_idx_last;
assign vrgather_vd_buf1_sel = 1'b0;
assign vrgather_e0_valid = vd_idx_lt_lmul & vd_idx_le_len;
assign vrgather_vd_idx_en = vrgather_vd_wvalid & e0_vd_cmp_ready;
assign vrgather_done = vrgather_vd_wvalid & e0_vd_cmp_ready & vd_idx_last & vd_idx_eq_len & ~vs1_idx_le_len & ~vs2_idx_le_len;
assign vrgather_vs2_rready = ~vs2_buf_valid & ~e0_stall;
assign vrgather_vd_cmp_idx_en = vrgather_vd_cmp_valid & lmul_gt_m1;
assign vrgather_vs2_rdata_we = ({VP_WEW{fsm_lmul_onehot[0]}} & {8{vs2_idx_onehot[0 +:VP_RATIO]}}) | ({VP_WEW{fsm_lmul_onehot[1]}} & {4{vs2_idx_onehot[0 +:VP_RATIO * 2]}}) | ({VP_WEW{fsm_lmul_onehot[2]}} & {2{vs2_idx_onehot[0 +:VP_RATIO * 4]}}) | ({VP_WEW{fsm_lmul_onehot[3]}} & vs2_idx_onehot[0 +:VP_RATIO * 8]) | ({VP_WEW{fsm_lmul_onehot[5]}} & {8{vs2_idx_onehot[0 +:VP_RATIO]}}) | ({VP_WEW{fsm_lmul_onehot[6]}} & {8{vs2_idx_onehot[0 +:VP_RATIO]}}) | ({VP_WEW{fsm_lmul_onehot[7]}} & {8{vs2_idx_onehot[0 +:VP_RATIO]}});
assign vrgather_vs2_shift_we = {VP_WEW{e0b_vd_cmp_valid & e0b_vd_cmp_ready}};
assign vrgather_vs1_rready = (~vs1_buf_valid | (vrgather_vd_cmp_valid & e0_vd_cmp_ready & vd_cmp_idx_last)) & vs1_idx_lt_lmul;
wire vrgatherei16_vs1_idx_last = vs1_vl_last & ((fsm_lmul_onehot[0] & (fsm_sew_onehot[0] ? vs1_len_idx == 5'h1 : vs1_len_idx == 5'h0)) | (fsm_lmul_onehot[1] & (fsm_sew_onehot[0] ? vs1_len_idx == 5'h3 : fsm_sew_onehot[1] ? vs1_len_idx == 5'h1 : vs1_len_idx == 5'h0)) | (fsm_lmul_onehot[2] & (fsm_sew_onehot[0] ? vs1_len_idx == 5'h7 : fsm_sew_onehot[1] ? vs1_len_idx == 5'h3 : fsm_sew_onehot[2] ? vs1_len_idx == 5'h1 : vs1_len_idx == 5'h0)) | (fsm_lmul_onehot[3] & (fsm_sew_onehot[1] ? vs1_len_idx == 5'h7 : fsm_sew_onehot[2] ? vs1_len_idx == 5'h3 : vs1_len_idx == 5'h1)) | (fsm_lmul_onehot[5] & vs1_len_idx == 5'h0) | (fsm_lmul_onehot[6] & vs1_len_idx == 5'h0) | (fsm_lmul_onehot[7] & vs1_len_idx == 5'h0));
assign vrgatherei16_vs1_idx_lt_lmul = fsm_sew_onehot[0] & vs1_idx_lt_lmulx2 | fsm_sew_onehot[1] & vs1_idx_lt_lmul | fsm_sew_onehot[2] & vs1_idx_lt_lmul_sew32 | fsm_sew_onehot[3] & vs1_idx_lt_lmul_sew64;
assign vrgatherei16_done = ~vs2_idx_le_len & ((vrgatherei16_vs1_idx_last & vpermut_vs1_rvalid & vs1_idx_eq_len & vd_idx_ge_lmul) | (~vrgatherei16_vs1_idx_lt_lmul & ~vs1_idx_le_len & e0_vd_cmp_ready & vrgather_vd_wvalid & vd_idx_last & vd_idx_eq_len) | (vrgatherei16_vs1_idx_last & vpermut_vs1_rvalid & vs1_idx_eq_len & e0_vd_cmp_ready & vrgather_vd_wvalid & vd_idx_last & vd_idx_eq_len & vrgatherei16_vs1_idx_lt_lmul & ((vrgatherei16_vs1_rlast & e0_vd_cmp_ready & vd_cmp_idx_last) | ~vs1_buf_valid)));
assign vrgatherei16_vs1_rready = ((~vs1_buf_valid | (vrgatherei16_vs1_rlast & e0_vd_cmp_ready & vd_cmp_idx_last)) & vrgatherei16_vs1_idx_lt_lmul) | vd_idx_ge_lmul;
assign vrgatherei16_vs1_rlast = vrgather_vd_cmp_valid & |{|fsm_sew_onehot[1:0],fsm_sew_onehot[2] & vd_idx[VPBW],&{fsm_sew_onehot[3],vd_idx[VPBW + 1:VPBW]}};
assign vcompress_vs1_lmul_sew_mask = ({VLEN{fsm_sew_onehot[3]}} & {{VLEN - VLEN / 8{1'b0}},vl_mask64} & fsm_lmul_mask64) | ({VLEN{fsm_sew_onehot[2]}} & {{VLEN - VLEN / 4{1'b0}},vl_mask32} & fsm_lmul_mask32) | ({VLEN{fsm_sew_onehot[1]}} & {{VLEN / 2{1'b0}},vl_mask16} & fsm_lmul_mask16) | ({VLEN{fsm_sew_onehot[0]}} & vl_mask8 & fsm_lmul_mask8);
reg e0c_valid;
assign vcompress_vd_wmask = vcompress_buf0_mask;
assign vcompress_body_mask = {(VP_LEN / 8){1'b1}};
assign vcompress_vs1_rready = ~vs1_buf_valid;
assign vcompress_e0_valid = 1'b1;
assign vcompress_vd_wvalid = ((vcompress_vs2_idx_en & vcompress_vd_avail) | (vs2_buf_valid & vd_idx_lt_lmul)) & vd_idx_le_len;
assign vcompress_vd_wmask_en = e0c_valid;
assign vcompress_vd_idx_en = vcompress_e0_valid & vcompress_vd_wvalid & ~e0_stall;
assign vcompress_done = vcompress_vd_idx_en & vd_idx_last & vd_idx_eq_len & (vs2_idx_eq_len | ~vs2_idx_le_len) & ~vs1_idx_le_len;
assign vcompress_vs2_rready = e0c_valid & vs2_idx_lt_lmul & ~e0_stall;
assign vcompress_vs2_idx_en = vpermut_vs2_rvalid & vcompress_vs2_rready & fsm_vcompress;
assign vcompress_vs2_buf_wdata_sel = 1'b0;
assign vcompress_vs2_rdata_we = common_vs2_buf_we;
assign vcompress_vs2_shift_we = {VP_WEW{1'b0}};
wire e0c_valid_set = e0_vcompress & vs1_buf_valid & ~e0c_valid;
wire e0c_valid_clr = vcompress_done | e0_kill;
assign vcompress_vs1_buf_en = e0c_valid_set | vcompress_vs2_idx_en;
assign vcompress_e0c_en = vcompress_vs1_buf_en | (e0c_valid & vs2_buf_valid & ~e0_stall);
assign vcompress_e0c_valid = e0c_valid;
always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        e0c_valid <= 1'b0;
    end
    else if (e0c_valid_set | e0c_valid_clr) begin
        e0c_valid <= ~e0c_valid_clr;
    end
end

assign vmv_sf_wdata = ({64{fsm_sew_onehot[1] & fsm_op1_nanbox_sew16}} & {4{fsm_op1[15:0]}}) | ({64{fsm_sew_onehot[1] & ~fsm_op1_nanbox_sew16 & ~fsm_fp_mode}} & {4{16'h7e00}}) | ({64{fsm_sew_onehot[1] & ~fsm_op1_nanbox_sew16 & fsm_fp_mode}} & {4{16'h7fc0}}) | ({64{fsm_sew_onehot[2] & fsm_op1_nanbox_sew32}} & {2{fsm_op1[31:0]}}) | ({64{fsm_sew_onehot[2] & ~fsm_op1_nanbox_sew32}} & {2{32'h7fc00000}}) | ({64{fsm_sew_onehot[3]}} & {1{fsm_op1[63:0]}});
assign vmv_sfx_buf0_mask = {VP_LEN / 8{~|vd_idx}} & ({{(VP_LEN / 8 - 8){1'b0}},{8{fsm_sew_onehot[3]}}} | {{(VP_LEN / 8 - 4){1'b0}},{4{fsm_sew_onehot[2]}}} | {{(VP_LEN / 8 - 2){1'b0}},{2{fsm_sew_onehot[1]}}} | {{(VP_LEN / 8 - 1){1'b0}},{1{fsm_sew_onehot[0]}}});
assign vmv_sfx_buf1_mask = {(VP_LEN / 8){1'b0}};
assign vmv_sfx_op1_mask = vmv_sfx_buf0_mask;
assign vmv_sfx_vd_wmask = vmv_sfx_buf0_mask & {VP_LEN / 8{vl_gt_vstart}};
assign vmv_sfx_vd_wmask_part_wr = 1'b0;
assign vmv_sfx_vd_wmask_en = 1'b1;
assign vmv_sfx_vd_wvalid = 1'b1;
assign vmv_sfx_vd_buf1_sel = 1'b0;
assign vmv_sfx_body_mask = {(VP_LEN / 8){1'b1}};
assign vmv_sfx_e0_valid = 1'b1;
assign vmv_sfx_vd_idx_en = ~e0_stall;
assign vmv_sfx_done = ~e0_stall & vd_dlen_last & dl_vd_idx_eq_len;
assign vmv_sfx_vs2_rready = 1'b0;
assign vmv_sfx_vs2_buf_wdata_sel = 1'b0;
assign vmv_fxs_buf0_mask = {{(VP_LEN / 8) - 8{1'b0}},{8{1'b1}}};
assign vmv_fxs_buf1_mask = {(VP_LEN / 8){1'b0}};
assign vmv_fxs_vd_wmask = {(VP_LEN / 8){1'b0}};
assign vmv_fxs_vd_wmask_part_wr = 1'b0;
assign vmv_fxs_vd_wmask_en = 1'b0;
assign vmv_fxs_vd_wvalid = 1'b0;
assign vmv_fxs_vd_buf1_sel = 1'b0;
assign vmv_fxs_body_mask = {(VP_LEN / 8){1'b1}};
assign vmv_fxs_e0_valid = vpermut_vs2_rvalid & vmv_fxs_vs2_rready;
assign vmv_fxs_vd_idx_en = 1'b0;
assign vmv_fxs_done = vmv_fxs_e0_valid & dl_vs2_idx_eq_len;
assign vmv_fxs_vs2_rready = ~e0_stall;
assign vmv_fxs_vs2_buf_wdata_sel = 1'b0;
assign vmv_fxs_vd_byte_sel = ({(VLBW * VP_LEN / 8){fsm_sew_onehot[0]}} & vmv_fxs_vd_byte_sel_eew8x8) | ({(VLBW * VP_LEN / 8){fsm_sew_onehot[1]}} & vmv_fxs_vd_byte_sel_eew16x4) | ({(VLBW * VP_LEN / 8){fsm_sew_onehot[2]}} & vmv_fxs_vd_byte_sel_eew32x2) | ({(VLBW * VP_LEN / 8){fsm_sew_onehot[3]}} & vmv_vd_byte_sel);
assign vzsext_e0_valid = 1'b1;
assign vzsext_vd_buf1_sel = 1'b0;
assign vzsext_vd_wmask = vzsext_buf0_mask;
assign vzsext_vd_wmask_part_wr = 1'b0;
assign vzsext_vd_wmask_en = 1'b1;
assign vzsext_vd_wvalid = (vzsext_vs2_idx_en | vs2_buf_valid) & dl_vd_idx_le_len;
assign vzsext_vd_idx_en = (vzsext_vs2_idx_en | (vs2_buf_valid & ~e0_stall)) & dl_vd_idx_le_len;
assign vzsext_vs2_idx_en = vpermut_vs2_rvalid & vzsext_vs2_rready;
assign vzsext_vs2_buf_wdata_sel = 1'b0;
assign vzsext_vd_byte_sel = ({(VLBW * VP_LEN / 8){fsm_vzsext_eew4x2 & (VECTOR_SINT_SUPPORT_INT == 1)}} & vzsext_vd_byte_sel_eew4x2) | ({(VLBW * VP_LEN / 8){fsm_vzsext_eew4x4 & (VECTOR_SINT_SUPPORT_INT == 1)}} & vzsext_vd_byte_sel_eew4x4) | ({(VLBW * VP_LEN / 8){fsm_vzsext_eew4x8 & (VECTOR_SINT_SUPPORT_INT == 1)}} & vzsext_vd_byte_sel_eew4x8) | ({(VLBW * VP_LEN / 8){fsm_vzsext_eew8x2}} & vzsext_vd_byte_sel_eew8x2) | ({(VLBW * VP_LEN / 8){fsm_vzsext_eew8x4}} & vzsext_vd_byte_sel_eew8x4) | ({(VLBW * VP_LEN / 8){fsm_vzsext_eew8x8}} & vzsext_vd_byte_sel_eew8x8) | ({(VLBW * VP_LEN / 8){fsm_vzsext_eew16x2}} & vzsext_vd_byte_sel_eew16x2) | ({(VLBW * VP_LEN / 8){fsm_vzsext_eew16x4}} & vzsext_vd_byte_sel_eew16x4) | ({(VLBW * VP_LEN / 8){fsm_vzsext_eew32x2}} & vzsext_vd_byte_sel_eew32x2);
assign vzsext_body_mask = ({(VP_LEN / 8){fsm_vzsext_eew8x2}} & vzsext_body_mask_eew8x2) | ({(VP_LEN / 8){fsm_vzsext_eew8x4}} & vzsext_body_mask_eew8x4) | ({(VP_LEN / 8){fsm_vzsext_eew8x8}} & vzsext_body_mask_eew8x8) | ({(VP_LEN / 8){fsm_vzsext_eew16x2}} & vzsext_body_mask_eew16x2) | ({(VP_LEN / 8){fsm_vzsext_eew16x4}} & vzsext_body_mask_eew16x4) | ({(VP_LEN / 8){fsm_vzsext_eew32x2}} & vzsext_body_mask_eew32x2);
assign fsm_vzsext_vf2 = (fsm_vzsext_eew4x2 & (VECTOR_SINT_SUPPORT_INT == 1)) | fsm_vzsext_eew8x2 | fsm_vzsext_eew16x2 | fsm_vzsext_eew32x2;
assign fsm_vzsext_vf4 = (fsm_vzsext_eew4x4 & (VECTOR_SINT_SUPPORT_INT == 1)) | fsm_vzsext_eew8x4 | fsm_vzsext_eew16x4;
assign fsm_vzsext_vf8 = (fsm_vzsext_eew4x8 & (VECTOR_SINT_SUPPORT_INT == 1)) | fsm_vzsext_eew8x8;
generate
    if (VD_RATIO == 1) begin:gen_vzsext_dlen_eq_vlen
        assign vzsext_vs2_rready = ~e0_stall & vs2_idx_lt_vzsext_emul & ~vs2_buf_valid;
        assign vzsext_done = vzsext_vd_idx_en & vzsext_vd_idx_last & dl_vd_idx_eq_len & (lmul_gt_m1 ? ~dl_vs2_idx_le_len : dl_vs2_idx_eq_len);
    end
    else begin:gen_vzsext_dlen_lt_vlen
        wire vs2_lt_vlen = |{fsm_lmul_onehot[2] & fsm_vzsext_vf8,fsm_lmul_onehot[1] & |{fsm_vzsext_vf4,fsm_vzsext_vf8},fsm_lmul_onehot[0],fsm_lmul_onehot[7:5]};
        assign vzsext_vs2_rready = ~e0_stall & vs2_idx_lt_vzsext_emul & (~vs2_buf_valid | (vs2_lt_vlen & (~dl_vd_idx_le_len | dl_vd_idx_eq_len)));
        assign vzsext_done = vs2_lt_vlen ? (vzsext_vs2_idx_en & dl_vs2_idx_eq_len) : (vzsext_vd_idx_en & vzsext_vd_idx_last & dl_vd_idx_eq_len & ~dl_vs2_idx_le_len);
    end
endgenerate
assign vs2_buf_valid_en = vs2_buf_valid_set | vs2_buf_valid_clr;
assign vs2_buf_valid_nx = vs2_buf_valid_set | (vs2_buf_valid & ~vs2_buf_valid_clr);
assign vs2_buf_valid_clr = req_grant | (fsm_vzsext & vd_idx_vf_last & ~e0_stall) | (fsm_vrgather_vxi & vd_idx_last & ~e0_stall);
assign vs2_buf_valid_set = vpermut_vs2_rvalid & ~req_grant & ((fsm_vcompress & vcompress_vs2_rready & vs2_idx_last) | ((fsm_vrgather_vv | fsm_vrgatherei16) & vrgather_vs2_rready & vs2_idx_last) | (fsm_vrgather_vxi & vrgathervxi_vs2_rready & vs2_idx_eq_offset) | (fsm_vzsext & vzsext_vs2_rready));
assign vs1_buf_valid_en = vs1_buf_valid_set | vs1_buf_valid_clr;
assign vs1_buf_valid_nx = vs1_buf_valid_set | (vs1_buf_valid & ~vs1_buf_valid_clr);
assign vs1_buf_valid_clr = req_grant | (fsm_vrgather_vv & vrgather_vd_cmp_valid & e0_vd_cmp_ready & vd_cmp_idx_last) | (fsm_vrgatherei16 & vrgatherei16_vs1_rlast & e0_vd_cmp_ready & vd_cmp_idx_last & vrgatherei16_vs1_idx_lt_lmul);
assign vs1_buf_valid_set = (fsm_vrgather_vv & e0_vs1_idx_en) | (fsm_vrgatherei16 & vrgatherei16_vs1_wlast & e0_vs1_idx_en & ~vrgatherei16_done) | (fsm_vcompress & vs1_vl_last & e0_vs1_idx_en);
assign e0_vd_wvalid = (fsm_vslideup & vslideup_vd_wvalid) | (fsm_vslidedn & vslidedn_vd_wvalid) | (fsm_vrgather_vxi & vrgathervxi_vd_wvalid) | (fsm_vmv_fxs & vmv_fxs_vd_wvalid) | (fsm_vcompress & vcompress_vd_wvalid) | (fsm_vmv_nr & vmv_nr_vd_wvalid) | (fsm_vzsext & vzsext_vd_wvalid) | (fsm_vmv_sfx & vmv_sfx_vd_wvalid) | e0b_vrgather_vd_wvalid;
assign e0_vd_buf1_sel = (fsm_vslideup & vslideup_vd_buf1_sel) | (fsm_vslidedn & vslidedn_vd_buf1_sel) | (fsm_vrgather_vv & vrgather_vd_buf1_sel) | (fsm_vrgatherei16 & vrgather_vd_buf1_sel) | (fsm_vrgather_vxi & vrgathervxi_vd_buf1_sel) | (fsm_vmv_nr & vmv_nr_vd_buf1_sel) | (fsm_vmv_sfx & vmv_sfx_vd_buf1_sel) | (fsm_vmv_fxs & vmv_fxs_vd_buf1_sel) | (fsm_vcompress & vcompress_vd_buf1_sel) | (fsm_vmv_fxs & vmv_fxs_vd_buf1_sel) | (fsm_vzsext & vzsext_vd_buf1_sel);
assign e0_valid = (fsm_vslideup & vslideup_e0_valid) | (fsm_vslidedn & vslidedn_e0_valid) | (fsm_vrgather_vv & vrgather_e0_valid) | (fsm_vrgatherei16 & vrgather_e0_valid) | (fsm_vrgather_vxi & vrgathervxi_e0_valid) | (fsm_vmv_nr & vmv_nr_e0_valid) | (fsm_vcompress & vcompress_e0_valid) | (fsm_vmv_sfx & vmv_sfx_e0_valid) | (fsm_vmv_fxs & vmv_fxs_e0_valid) | (fsm_vzsext & vzsext_e0_valid) | e0b_vd_cmp_valid;
assign e0_op1 = fsm_float ? vmv_sf_wdata : (({64{fsm_sew_onehot[3]}} & {1{fsm_op1[63:0]}}) | ({64{fsm_sew_onehot[2]}} & {2{fsm_op1[31:0]}}) | ({64{fsm_sew_onehot[1]}} & {4{fsm_op1[15:0]}}) | ({64{fsm_sew_onehot[0]}} & {8{fsm_op1[07:0]}}));
assign e0_vd_cmp_valid = (fsm_vrgather_vv & vrgather_vd_cmp_valid) | (fsm_vrgatherei16 & vrgather_vd_cmp_valid);
wire e0b_committed_en = (e0b_vrgather_vd_buf_valid & ~e0b_vd_cmp_ready & e0b_cmt) | (e0_vd_cmp_valid & e0_vd_cmp_ready & ~e0b_vd_cmp_ready) | (e0b_vrgather_vd_buf_valid & e0b_vd_cmp_ready);
wire e0b_committed_nx = (~fsm_cs[IDLE] & fsm_committed) | (~fsm_cs[IDLE] & fsm_cmt & ~cmt_kill) | (e0b_vrgather_vd_buf_valid & e0b_cmt & ~cmt_kill & e0_stall);
always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        e0b_id <= {CMT_DEP_IDX{1'b0}};
    end
    else if (e0_vd_cmp_valid & e0_vd_cmp_ready & ~e0b_vd_cmp_ready) begin
        e0b_id <= fsm_id;
    end
end

always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        e0b_committed <= 1'b0;
    end
    else if (e0b_committed_en) begin
        e0b_committed <= e0b_committed_nx;
    end
end

wire [VLBW * VP_LEN / 8 - 1:0] e0b_vrgather_vd_byte_sel;
wire [VLBW * VP_LEN / 8 - 1:0] e0_vrgather_vd_byte_sel = {VP_LEN / 8{byte_sel_mask[VLBW - 1:0]}} & (({(VLBW * VP_LEN / 8){fsm_vrgatherei16}} & vrgatherei16_vd_byte_sel) | ({(VLBW * VP_LEN / 8){fsm_vrgather_vv}} & vrgather_vd_byte_sel));
assign e0_vrgather_buf0_mask = ({(VP_LEN / 8){fsm_vrgather_vv}} & vrgather_buf0_mask) | ({(VP_LEN / 8){fsm_vrgatherei16}} & vrgatherei16_buf0_mask);
assign e0_vrgather_body_mask = ({(VP_LEN / 8){fsm_vrgather_vv}} & vrgather_body_mask) | ({(VP_LEN / 8){fsm_vrgatherei16}} & vrgatherei16_body_mask);
assign e0_vrgather_vd_wmask = ({(VP_LEN / 8){fsm_vrgather_vv}} & vrgather_vd_wmask) | ({(VP_LEN / 8){fsm_vrgatherei16}} & vrgather_vd_wmask);
assign e0_vrgather_vd_wmask_part_wr = (fsm_vrgather_vv & vrgather_vd_wmask_part_wr) | (fsm_vrgatherei16 & vrgather_vd_wmask_part_wr);
assign e0_vrgather_mask = e0_vrgather_buf0_mask & e0_vrgather_vd_wmask;
assign e0b_vd_cmp_ready = ~e0_stall;
assign e0b_vrgather_vd_buf_valid = ~e0_vd_cmp_ready;
kv_eb_bypass #(
    .DW((VLBW + 2) * (VP_LEN / 8) + 2),
    .RAR_SUPPORT(RAR_SUPPORT)
) u_e0_vrgather_el_buffer (
    .clk(vpu_vpermut_clk),
    .resetn(vpu_reset_n),
    .i_valid(e0_vd_cmp_valid),
    .i_ready(e0_vd_cmp_ready),
    .o_valid(e0b_vd_cmp_valid),
    .o_ready(e0b_vd_cmp_ready),
    .din({vrgather_vd_wvalid,e0_vrgather_vd_wmask_part_wr,e0_vrgather_vd_byte_sel,e0_vrgather_body_mask,e0_vrgather_mask}),
    .dout({e0b_vrgather_vd_wvalid,e0b_vrgather_vd_wmask_part_wr,e0b_vrgather_vd_byte_sel,e0b_vrgather_body_mask,e0b_vrgather_mask})
);
assign e0_vd_byte_sel = {VP_LEN / 8{byte_sel_mask[VLBW - 1:0]}} & (({(VLBW * VP_LEN / 8){fsm_vslideup}} & vslideup_vd_byte_sel) | ({(VLBW * VP_LEN / 8){fsm_vslidedn}} & vslidedn_vd_byte_sel) | ({(VLBW * VP_LEN / 8){fsm_vrgather_vxi}} & vrgathervxi_vd_byte_sel) | ({(VLBW * VP_LEN / 8){fsm_vmv_nr}} & vmv_vd_byte_sel) | ({(VLBW * VP_LEN / 8){fsm_vcompress}} & vcompress_vd_byte_sel) | ({(VLBW * VP_LEN / 8){fsm_vzsext}} & vzsext_vd_byte_sel)) | e0b_vrgather_vd_byte_sel | ({(VLBW * VP_LEN / 8){fsm_vmv_sfx}} & vmv_vd_byte_sel) | ({(VLBW * VP_LEN / 8){fsm_vmv_fxs}} & vmv_fxs_vd_byte_sel);
assign e0_buf0_mask = ({(VP_LEN / 8){fsm_vslideup}} & vslideup_buf0_mask) | ({(VP_LEN / 8){fsm_vslidedn}} & vslidedn_buf0_mask) | ({(VP_LEN / 8){fsm_vrgather_vxi}} & vrgathervxi_buf0_mask) | e0b_vrgather_mask | ({(VP_LEN / 8){fsm_vmv_nr}} & vmv_nr_buf0_mask) | ({(VP_LEN / 8){fsm_vmv_sfx}} & vmv_sfx_buf0_mask) | ({(VP_LEN / 8){fsm_vmv_fxs}} & vmv_fxs_buf0_mask) | ({(VP_LEN / 8){fsm_vcompress}} & vcompress_buf0_mask) | ({(VP_LEN / 8){fsm_vzsext}} & vzsext_buf0_mask);
assign e0_buf1_mask = ({(VP_LEN / 8){fsm_vslideup}} & vslideup_buf1_mask) | ({(VP_LEN / 8){fsm_vslidedn}} & vslidedn_buf1_mask) | ({(VP_LEN / 8){fsm_vrgather_vv}} & vrgather_buf1_mask) | ({(VP_LEN / 8){fsm_vrgatherei16}} & vrgather_buf1_mask) | ({(VP_LEN / 8){fsm_vrgather_vxi}} & vrgathervxi_buf1_mask) | ({(VP_LEN / 8){fsm_vmv_nr}} & vmv_nr_buf1_mask) | ({(VP_LEN / 8){fsm_vmv_sfx}} & vmv_sfx_buf1_mask) | ({(VP_LEN / 8){fsm_vmv_fxs}} & vmv_fxs_buf1_mask) | ({(VP_LEN / 8){fsm_vcompress}} & vcompress_buf1_mask) | ({(VP_LEN / 8){fsm_vzsext}} & vzsext_buf1_mask);
assign e0_body_mask = ({(VP_LEN / 8){fsm_vslideup}} & vslideup_body_mask) | ({(VP_LEN / 8){fsm_vslidedn}} & vslidedn_body_mask) | ({(VP_LEN / 8){fsm_vrgather_vxi}} & vrgathervxi_body_mask) | e0b_vrgather_body_mask | ({(VP_LEN / 8){fsm_vmv_nr}} & vmv_nr_body_mask) | ({(VP_LEN / 8){fsm_vmv_sfx}} & vmv_sfx_body_mask) | ({(VP_LEN / 8){fsm_vmv_fxs}} & vmv_fxs_body_mask) | ({(VP_LEN / 8){fsm_vcompress}} & vcompress_body_mask) | ({(VP_LEN / 8){fsm_vzsext}} & vzsext_body_mask);
assign e0_op1_sel = ({2{fsm_vslidedn}} & 2'b11) | ({2{fsm_vslideup}} & 2'b01) | ({2{fsm_vmv_sfx}} & 2'b01);
assign e0_op1_mask = ({(VP_LEN / 8){fsm_vslidedn}} & vslidedn_op1_mask) | ({(VP_LEN / 8){fsm_vslideup}} & vslideup_op1_mask) | ({(VP_LEN / 8){fsm_vmv_sfx}} & vmv_sfx_op1_mask);
assign e0_vd_wmask = ({(VP_LEN / 8){fsm_vslideup}} & vslideup_vd_wmask) | ({(VP_LEN / 8){fsm_vslidedn}} & vslidedn_vd_wmask) | ({(VP_LEN / 8){fsm_vrgather_vxi}} & vrgathervxi_vd_wmask) | ({(VP_LEN / 8){fsm_vmv_nr}} & vmv_nr_vd_wmask) | ({(VP_LEN / 8){fsm_vmv_sfx}} & vmv_sfx_vd_wmask) | ({(VP_LEN / 8){fsm_vmv_fxs}} & vmv_fxs_vd_wmask) | ({(VP_LEN / 8){fsm_vcompress}} & vcompress_vd_wmask) | ({(VP_LEN / 8){fsm_vzsext}} & vzsext_vd_wmask) | e0b_vrgather_mask;
assign e0_vd_wmask_en = (fsm_vslideup & vslideup_vd_wmask_en) | (fsm_vslidedn & vslidedn_vd_wmask_en) | (fsm_vrgather_vv & vrgather_vd_wmask_en) | (fsm_vrgatherei16 & vrgather_vd_wmask_en) | e0b_vd_cmp_valid | (fsm_vrgather_vxi & vrgathervxi_vd_wmask_en) | (fsm_vmv_nr & vmv_nr_vd_wmask_en) | (fsm_vmv_sfx & vmv_sfx_vd_wmask_en) | (fsm_vmv_fxs & vmv_fxs_vd_wmask_en) | (fsm_vcompress & vcompress_vd_wmask_en) | (fsm_vzsext & vzsext_vd_wmask_en);
assign e0_vd_wmask_part_wr[0] = (fsm_vslideup & vslideup_vd_wmask_part_wr) | (fsm_vslidedn & vslidedn_vd_wmask_part_wr) | (fsm_vrgather_vxi & vrgathervxi_vd_wmask_part_wr) | e0b_vrgather_vd_wmask_part_wr | (fsm_vmv_nr & vmv_nr_vd_wmask_part_wr) | (fsm_vmv_sfx & vmv_sfx_vd_wmask_part_wr) | (fsm_vmv_fxs & vmv_fxs_vd_wmask_part_wr) | (fsm_vcompress & vcompress_vd_wmask_part_wr[0]) | (fsm_vzsext & vzsext_vd_wmask_part_wr);
assign e0_vd_wmask_part_wr[1] = fsm_vcompress & vcompress_vd_wmask_part_wr[1];
assign e0_vzsext_eew4x2 = fsm_vzsext_eew4x2 & (VECTOR_SINT_SUPPORT_INT == 1);
assign e0_vzsext_eew4x4 = fsm_vzsext_eew4x4 & (VECTOR_SINT_SUPPORT_INT == 1);
assign e0_vzsext_eew4x8 = fsm_vzsext_eew4x8 & (VECTOR_SINT_SUPPORT_INT == 1);
assign e0_vzsext_eew8x2 = fsm_vzsext_eew8x2;
assign e0_vzsext_eew16x2 = fsm_vzsext_eew16x2;
assign e0_vzsext_eew32x2 = fsm_vzsext_eew32x2;
assign e0_vzsext_eew8x4 = fsm_vzsext_eew8x4;
assign e0_vzsext_eew16x4 = fsm_vzsext_eew16x4;
assign e0_vzsext_eew8x8 = fsm_vzsext_eew8x8;
assign vs2_buf_we = vs2_rdata_we | vs2_shift_we;
generate
    if (RAR_SUPPORT) begin:gen_vs_buf_rar
        genvar v2;
        genvar v1;
        for (v2 = 0; v2 < VP_WEW; v2 = v2 + 1) begin:gen_vs2_buf_rar
            always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    vs2_buf[VP_LEN * v2 +:VP_LEN] <= {VP_LEN{1'b0}};
                end
                else if (vs2_buf_we[v2]) begin
                    vs2_buf[VP_LEN * v2 +:VP_LEN] <= vs2_buf_in[VP_LEN * v2 +:VP_LEN];
                end
            end

        end
        for (v1 = 0; v1 < VS1_RATIO; v1 = v1 + 1) begin:gen_vs1_buf_rar
            always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    vs1_buf[VP_LEN * v1 +:VP_LEN] <= {VP_LEN{1'b0}};
                end
                else if (vs1_buf_we[v1]) begin
                    vs1_buf[v1 * VP_LEN +:VP_LEN] <= vs1_buf_nx[v1 * VP_LEN +:VP_LEN];
                end
            end

        end
    end
    else begin:gen_vs_buf_no_rar
        integer v2;
        integer v1;
        always @(posedge vpu_vpermut_clk) begin
            for (v2 = 0; v2 < VP_WEW; v2 = v2 + 1)
            if (vs2_buf_we[v2]) begin
                vs2_buf[VP_LEN * v2 +:VP_LEN] <= vs2_buf_in[VP_LEN * v2 +:VP_LEN];
            end
        end

        always @(posedge vpu_vpermut_clk) begin
            for (v1 = 0; v1 < VS1_RATIO; v1 = v1 + 1)
            if (vs1_buf_we[v1]) begin
                vs1_buf[v1 * VP_LEN +:VP_LEN] <= vs1_buf_nx[v1 * VP_LEN +:VP_LEN];
            end
        end

    end
endgenerate
always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vs2_buf_valid <= 1'b0;
    end
    else if (vs2_buf_valid_en) begin
        vs2_buf_valid <= vs2_buf_valid_nx;
    end
end

always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vs1_buf_valid <= 1'b0;
    end
    else if (vs1_buf_valid_en) begin
        vs1_buf_valid <= vs1_buf_valid_nx;
    end
end

assign e0_vs2_buf_wdata_sel = (fsm_vslideup & vslideup_vs2_buf_wdata_sel) | (fsm_vslidedn & vslidedn_vs2_buf_wdata_sel) | (fsm_vrgather_vxi & vrgathervxi_vs2_buf_wdata_sel) | (fsm_vcompress & vcompress_vs2_buf_wdata_sel) | (fsm_vmv_nr & vmv_nr_vs2_buf_wdata_sel) | (fsm_vmv_sfx & vmv_sfx_vs2_buf_wdata_sel) | (fsm_vmv_fxs & vmv_fxs_vs2_buf_wdata_sel) | (fsm_vzsext & vzsext_vs2_buf_wdata_sel) | e0b_vd_cmp_valid;
assign vs2_shift_we = vrgather_vs2_shift_we | ({VP_WEW{fsm_vcompress}} & vcompress_vs2_shift_we);
assign vs2_rdata_we = ({VP_WEW{vpermut_vs2_rvalid & vs2_rready}} & (({VP_WEW{fsm_vrgather_vv}} & vrgather_vs2_rdata_we) | ({VP_WEW{fsm_vrgatherei16}} & vrgather_vs2_rdata_we) | ({VP_WEW{fsm_vcompress}} & vcompress_vs2_rdata_we) | ({VP_WEW{fsm_vmv_fxs}} & vmv_fxs_vs2_rdata_we) | ({VP_WEW{fsm_vmv_nr}} & vmv_nr_vs2_rdata_we) | ({VP_WEW{fsm_vzsext}} & vzsext_vs2_rdata_we) | ({VP_WEW{fsm_vslidedn}} & vslidedn_vs2_rdata_we) | ({VP_WEW{fsm_vslideup}} & vslideup_vs2_rdata_we))) | ({VP_WEW{fsm_vrgather_vxi}} & vrgathervxi_vs2_rdata_we);
assign vs2_buf_in = e0_vs2_buf_wdata_sel ? vs2_vd_shift : {8 * VD_RATIO{vs2_rdata}};
generate
    genvar j;
    for (j = 0; j < 7; j = j + 1) begin:gen_vd_shift
        assign vs2_vd_shift[VLEN * j +:VLEN] = vs2_buf[VLEN * (j + 1) +:VLEN];
    end
    assign vs2_vd_shift[VLEN * 7 +:VLEN] = vs2_buf[0 +:VLEN];
endgenerate
always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        e1_valid <= 1'b0;
    end
    else if (e1_valid_en) begin
        e1_valid <= e1_valid_nx;
    end
end

assign e0_id = e0b_vrgather_vd_buf_valid ? e0b_id : fsm_id;
assign e0_committed = e0b_vrgather_vd_buf_valid ? e0b_committed : fsm_committed;
assign e0_cmt = e0b_vrgather_vd_buf_valid ? e0b_cmt : fsm_cmt;
assign e0_kill = e0b_vrgather_vd_buf_valid ? e0b_kill : fsm_kill;
wire e1_committed_nx = (e0_valid & e0_committed) | (e0_valid & e0_cmt & ~cmt_kill) | (e1_valid & e1_cmt & ~cmt_kill & e1_stall);
always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        e1_committed <= 1'b0;
    end
    else if ((e1_valid & e1_cmt) | ~e0_stall) begin
        e1_committed <= e1_committed_nx;
    end
end

generate
    if (RAR_SUPPORT) begin:gen_e1_stage_rar
        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                e1_id <= {CMT_DEP_IDX{1'b0}};
                e1_vd_byte_sel <= {VLBW * (VP_LEN / 8){1'b0}};
                e1_buf0_mask <= {VP_LEN / 8{1'b0}};
                e1_buf1_mask <= {VP_LEN / 8{1'b0}};
                e1_body_mask <= {VP_LEN / 8{1'b0}};
                e1_op1_mask <= {VP_LEN / 8{1'b0}};
                e1_op1_sel <= 1'b0;
                e1_op1 <= {64{1'b0}};
                e1_vd_wmask <= {VP_LEN / 8{1'b0}};
                e1_vd_wmask_part_wr <= 1'b0;
                e1_vd_wmask_en <= 1'b0;
                e1_vd_buf1_sel <= 1'b0;
                e1_vd_wvalid <= 1'b0;
                e1_srf_wvalid <= 1'b0;
                e1_vcompress <= 1'b0;
                e1_vmv_fs <= 1'b0;
                e1_rd_addr <= 5'b0;
                e1_vmv_fxs <= 1'b0;
                e1_sew_onehot <= 4'b0;
                e1_vzsext <= 1'b0;
                e1_vsext <= 1'b0;
                e1_vzsext_eew4x2 <= 1'b0;
                e1_vzsext_eew4x4 <= 1'b0;
                e1_vzsext_eew4x8 <= 1'b0;
                e1_vzsext_eew8x2 <= 1'b0;
                e1_vzsext_eew8x4 <= 1'b0;
                e1_vzsext_eew8x8 <= 1'b0;
                e1_vzsext_eew16x2 <= 1'b0;
                e1_vzsext_eew16x4 <= 1'b0;
                e1_vzsext_eew32x2 <= 1'b0;
            end
            else if (e1_ctrl_en) begin
                e1_id <= e0_id;
                e1_vd_byte_sel <= e0_vd_byte_sel;
                e1_buf0_mask <= e0_buf0_mask;
                e1_buf1_mask <= e0_buf1_mask;
                e1_body_mask <= e0_body_mask;
                e1_op1_mask <= e0_op1_mask;
                e1_op1_sel <= e0_op1_sel;
                e1_op1 <= e0_op1;
                e1_vd_wmask <= e0_vd_wmask;
                e1_vd_wmask_part_wr <= e0_vd_wmask_part_wr;
                e1_vd_wmask_en <= e0_vd_wmask_en;
                e1_vd_buf1_sel <= e0_vd_buf1_sel;
                e1_vd_wvalid <= e0_vd_wvalid;
                e1_srf_wvalid <= e0_srf_wvalid;
                e1_vcompress <= e0_vcompress;
                e1_vmv_fs <= e0_vmv_fs;
                e1_rd_addr <= e0_rd_addr;
                e1_vmv_fxs <= e0_vmv_fxs;
                e1_sew_onehot <= e0_sew_onehot;
                e1_vzsext <= e0_vzsext;
                e1_vsext <= e0_vsext;
                e1_vzsext_eew4x2 <= e0_vzsext_eew4x2;
                e1_vzsext_eew4x4 <= e0_vzsext_eew4x4;
                e1_vzsext_eew4x8 <= e0_vzsext_eew4x8;
                e1_vzsext_eew8x2 <= e0_vzsext_eew8x2;
                e1_vzsext_eew8x4 <= e0_vzsext_eew8x4;
                e1_vzsext_eew8x8 <= e0_vzsext_eew8x8;
                e1_vzsext_eew16x2 <= e0_vzsext_eew16x2;
                e1_vzsext_eew16x4 <= e0_vzsext_eew16x4;
                e1_vzsext_eew32x2 <= e0_vzsext_eew32x2;
            end
        end

    end
    else begin:gen_e1_stage_no_rar
        always @(posedge vpu_vpermut_clk) begin
            if (e1_ctrl_en) begin
                e1_id <= e0_id;
                e1_vd_byte_sel <= e0_vd_byte_sel;
                e1_buf0_mask <= e0_buf0_mask;
                e1_buf1_mask <= e0_buf1_mask;
                e1_body_mask <= e0_body_mask;
                e1_op1_mask <= e0_op1_mask;
                e1_op1_sel <= e0_op1_sel;
                e1_op1 <= e0_op1;
                e1_vd_wmask <= e0_vd_wmask;
                e1_vd_wmask_part_wr <= e0_vd_wmask_part_wr;
                e1_vd_wmask_en <= e0_vd_wmask_en;
                e1_vd_buf1_sel <= e0_vd_buf1_sel;
                e1_vd_wvalid <= e0_vd_wvalid;
                e1_srf_wvalid <= e0_srf_wvalid;
                e1_vcompress <= e0_vcompress;
                e1_vmv_fs <= e0_vmv_fs;
                e1_rd_addr <= e0_rd_addr;
                e1_vmv_fxs <= e0_vmv_fxs;
                e1_sew_onehot <= e0_sew_onehot;
                e1_vzsext <= e0_vzsext;
                e1_vsext <= e0_vsext;
                e1_vzsext_eew4x2 <= e0_vzsext_eew4x2;
                e1_vzsext_eew4x4 <= e0_vzsext_eew4x4;
                e1_vzsext_eew4x8 <= e0_vzsext_eew4x8;
                e1_vzsext_eew8x2 <= e0_vzsext_eew8x2;
                e1_vzsext_eew8x4 <= e0_vzsext_eew8x4;
                e1_vzsext_eew8x8 <= e0_vzsext_eew8x8;
                e1_vzsext_eew16x2 <= e0_vzsext_eew16x2;
                e1_vzsext_eew16x4 <= e0_vzsext_eew16x4;
                e1_vzsext_eew32x2 <= e0_vzsext_eew32x2;
            end
        end

    end
endgenerate
assign vd_buf1_din = e1_result1;
assign vd_buf0_din = e1_result0;
kv_vpermut_pu #(
    .VLEN(VLEN),
    .DLEN(DLEN),
    .VP_LEN(VP_LEN)
) u_vd_pu (
    .result0(e1_result0[VP_LEN - 1:0]),
    .result1(e1_result1[VP_LEN - 1:0]),
    .idx(e1_vd_byte_sel),
    .body_mask(e1_body_mask),
    .op1_sel(e1_op1_sel),
    .op1_mask(e1_op1_mask),
    .op1(e1_op1),
    .vs2_buf(vs2_buf),
    .vmv_nr(e1_vmv_nr_cmd),
    .vmv_fs(e1_vmv_fs),
    .vmv_fxs(e1_vmv_fxs),
    .sew_onehot(e1_sew_onehot),
    .vzsext(e1_vzsext),
    .vsext(e1_vsext),
    .eew4x2(e1_vzsext_eew4x2),
    .eew4x4(e1_vzsext_eew4x4),
    .eew4x8(e1_vzsext_eew4x8),
    .eew8x2(e1_vzsext_eew8x2),
    .eew8x4(e1_vzsext_eew8x4),
    .eew8x8(e1_vzsext_eew8x8),
    .eew16x2(e1_vzsext_eew16x2),
    .eew16x4(e1_vzsext_eew16x4),
    .eew32x2(e1_vzsext_eew32x2)
);
assign e1_valid_en = ~e0_stall;
assign e1_ctrl_en = e1_valid_en & e0_valid;
assign e1_valid_nx = e0_valid & ~e0_kill;
assign e1_stall = vd_stall | srf_stall;
assign vd_buf0_bwe = {(VP_LEN / 8){e1_valid & ~e1_stall}} & e1_buf0_mask;
assign vd_buf1_bwe = {(VP_LEN / 8){e1_valid & ~e1_stall}} & e1_buf1_mask;
wire e2_committed_nx = (e1_valid & e1_committed) | (e1_valid & e1_cmt & ~cmt_kill) | (e2_cmt & ~cmt_kill & e1_stall);
always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        e2_committed <= 1'b0;
    end
    else if (e2_cmt | ~e1_stall) begin
        e2_committed <= e2_committed_nx;
    end
end

always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vd_wvalid <= 1'b0;
    end
    else if (vd_wvalid_en) begin
        vd_wvalid <= vd_wvalid_nx;
    end
end

generate
    if (RAR_SUPPORT) begin:gen_e2_stage_rar
        kv_dff_bwe_rar #(
            .BYTES(VP_LEN / 8)
        ) u_vd_buf0 (
            .rst_n(vpu_reset_n),
            .clk(vpu_vpermut_clk),
            .bwe(vd_buf0_bwe),
            .d(vd_buf0_din),
            .q(vd_buf0)
        );
        kv_dff_bwe_rar #(
            .BYTES(VP_LEN / 8)
        ) u_vd_buf1 (
            .rst_n(vpu_reset_n),
            .clk(vpu_vpermut_clk),
            .bwe(vd_buf1_bwe),
            .d(vd_buf1_din),
            .q(vd_buf1)
        );
        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                e2_id <= {CMT_DEP_IDX{1'b0}};
            end
            else if (~e1_stall | e2_kill) begin
                e2_id <= e1_id;
            end
        end

        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                vd_wmask0 <= {VP_LEN / 8{1'b0}};
            end
            else if (vd_wmask_en) begin
                vd_wmask0 <= e1_vd_wmask | ({VP_LEN / 8{e1_vd_wmask_part_wr[0]}} & vd_wmask0);
            end
        end

        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                vd_wmask1 <= {VP_LEN / 8{1'b0}};
            end
            else if (vd_wmask_en & (e1_vcompress | e1_vmv_nr_cmd | e1_vzsext_cmd)) begin
                vd_wmask1 <= e1_buf1_mask | ({VP_LEN / 8{e1_vd_wmask_part_wr[1]}} & vd_wmask1);
            end
        end

        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                vd_buf1_sel <= 1'b0;
                vcmprs_vd_buf1_sel <= 1'b0;
            end
            else if (vd_wvalid_set) begin
                vd_buf1_sel <= e1_vd_buf1_sel;
                vcmprs_vd_buf1_sel <= e1_vd_buf1_sel & e1_vcompress;
            end
        end

        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                srf_wfrf <= 1'b0;
                srf_waddr <= 5'b0;
            end
            else if (srf_wvalid_set) begin
                srf_wfrf <= e1_vmv_fs;
                srf_waddr <= e1_rd_addr;
            end
        end

    end
    else begin:gen_e2_stage_no_rar
        kv_dff_bwe #(
            .BYTES(VP_LEN / 8)
        ) u_vd_buf0 (
            .clk(vpu_vpermut_clk),
            .bwe(vd_buf0_bwe),
            .d(vd_buf0_din),
            .q(vd_buf0)
        );
        kv_dff_bwe #(
            .BYTES(VP_LEN / 8)
        ) u_vd_buf1 (
            .clk(vpu_vpermut_clk),
            .bwe(vd_buf1_bwe),
            .d(vd_buf1_din),
            .q(vd_buf1)
        );
        always @(posedge vpu_vpermut_clk) begin
            if (~e1_stall | e2_kill) begin
                e2_id <= e1_id;
            end
        end

        always @(posedge vpu_vpermut_clk) begin
            if (vd_wmask_en) begin
                vd_wmask0 <= e1_vd_wmask | ({VP_LEN / 8{e1_vd_wmask_part_wr[0]}} & vd_wmask0);
            end
        end

        always @(posedge vpu_vpermut_clk) begin
            if (vd_wmask_en & (e1_vcompress | e1_vmv_nr_cmd | e1_vzsext_cmd)) begin
                vd_wmask1 <= e1_buf1_mask | ({VP_LEN / 8{e1_vd_wmask_part_wr[1]}} & vd_wmask1);
            end
        end

        always @(posedge vpu_vpermut_clk) begin
            if (vd_wvalid_set) begin
                vd_buf1_sel <= e1_vd_buf1_sel;
                vcmprs_vd_buf1_sel <= e1_vd_buf1_sel & e1_vcompress;
            end
        end

        always @(posedge vpu_vpermut_clk) begin
            if (srf_wvalid_set) begin
                srf_wfrf <= e1_vmv_fs;
                srf_waddr <= e1_rd_addr;
            end
        end

    end
endgenerate
assign vd_wmask_en = e1_valid & ~e1_stall & e1_vd_wmask_en;
assign vd_wvalid_en = ~vd_stall;
assign vd_wvalid_set = e1_valid & e1_vd_wvalid & ~e1_stall & ~e1_kill;
assign vd_wvalid_nx = e1_valid & e1_vd_wvalid & ~srf_stall & ~e1_kill;
assign vd_wmask = vcmprs_vd_buf1_sel ? vd_wmask1 : vd_wmask0;
assign vd_wdata = vd_buf1_sel ? vd_buf1 : vd_buf0;
assign vd_stall = vd_wvalid & ~vd_wready & ~e2_kill;
generate
    if (DP_RATIO == 1) begin:gen_vpermut_dlen_equal
        assign vpermut_vd_wvalid = vd_wvalid;
        assign vpermut_vd_wmask = vd_wmask;
        assign vpermut_vd_wdata = vd_wdata;
        assign vd_wready = vpermut_vd_wready;
        assign e1_vmv_nr_cmd = 1'b0;
        assign e1_vzsext_cmd = 1'b0;
        assign vzsext_buf0_mask = e0_vd_mask & {(VP_LEN / 8){fsm_vzsext_vf2 | fsm_vzsext_vf4 | fsm_vzsext_vf8}};
        assign vzsext_buf1_mask = {(VP_LEN / 8){1'b0}};
    end
    else if (RAR_SUPPORT) begin:gen_vpermut_dlen_lt_dlen_rar
        wire [DLEN / 8 - 1:0] vzsext_buf_mask;
        kv_mux #(
            .N(VLEN * 8 / DLEN),
            .W(DLEN / 8)
        ) u_vzsext_buf_mask_mux (
            .out(vzsext_buf_mask),
            .sel(vd_idx[VPBW +:(3 + VD_RATIO_IDX)]),
            .in(fsm_v0_vstart_vl_mask)
        );
        assign vzsext_buf0_mask = vzsext_buf_mask[VP_LEN / 8 - 1:0] & {(VP_LEN / 8){fsm_vzsext_vf2 | fsm_vzsext_vf4 | fsm_vzsext_vf8}};
        assign vzsext_buf1_mask = vzsext_buf_mask[VP_LEN / 8 +:VP_LEN / 8] & {(VP_LEN / 8){fsm_vzsext_vf2 | fsm_vzsext_vf4 | fsm_vzsext_vf8}};
        reg e1_vmv_nr;
        reg e1_vmv_sfx;
        reg vd_full_dlen;
        reg vd_vmv_sfx;
        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                e1_vmv_nr <= 1'b0;
                e1_vmv_sfx <= 1'b0;
            end
            else if (e1_ctrl_en) begin
                e1_vmv_nr <= fsm_vmv_nr;
                e1_vmv_sfx <= fsm_vmv_sfx;
            end
        end

        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                vd_full_dlen <= 1'b0;
                vd_vmv_sfx <= 1'b0;
            end
            else if (vd_wvalid_en) begin
                vd_full_dlen <= e1_valid & (e1_vmv_nr | e1_vmv_sfx | e1_vzsext);
                vd_vmv_sfx <= e1_valid & e1_vmv_sfx;
            end
        end

        reg vd_upper_sel;
        reg [VP_LEN / 8 - 1:0] vd_lower_wmask;
        reg [VP_LEN - 1:0] vd_lower_wdata;
        wire vd_upper_sel_set = ~e2_kill & vd_wvalid & vd_wready & ~vd_full_dlen & ~vd_upper_sel;
        wire vd_upper_sel_clr = e2_kill | (vd_wvalid & vd_wready & ~vd_full_dlen & vd_upper_sel);
        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                vd_upper_sel <= 1'b0;
            end
            else if (vd_upper_sel_clr | vd_upper_sel_set) begin
                vd_upper_sel <= vd_upper_sel_set;
            end
        end

        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                vd_lower_wmask <= {VP_LEN / 8{1'b0}};
                vd_lower_wdata <= {VP_LEN{1'b0}};
            end
            else if (~vd_upper_sel & vd_wvalid & ~e2_kill & vd_wready) begin
                vd_lower_wmask <= vd_wmask;
                vd_lower_wdata <= vd_wdata;
            end
        end

        assign vd_wready = (~vd_full_dlen & ~vd_upper_sel) | vpermut_vd_wready;
        assign vpermut_vd_wvalid = (vd_upper_sel | vd_full_dlen) & vd_wvalid;
        assign vpermut_vd_wmask = vd_full_dlen ? {{VP_LEN / 8{~vd_vmv_sfx}} & vd_wmask1,vd_wmask0} : {vd_wmask,vd_lower_wmask};
        assign vpermut_vd_wdata = vd_full_dlen ? {vd_buf1,vd_buf0} : {vd_wdata,vd_lower_wdata};
        assign e1_vmv_nr_cmd = e1_vmv_nr;
        assign e1_vzsext_cmd = e1_vzsext;
    end
    else begin:gen_vpermut_dlen_lt_dlen_no_rar
        wire [DLEN / 8 - 1:0] vzsext_buf_mask;
        kv_mux #(
            .N(VLEN * 8 / DLEN),
            .W(DLEN / 8)
        ) u_vzsext_buf_mask_mux (
            .out(vzsext_buf_mask),
            .sel(vd_idx[VPBW +:(3 + VD_RATIO_IDX)]),
            .in(fsm_v0_vstart_vl_mask)
        );
        assign vzsext_buf0_mask = vzsext_buf_mask[VP_LEN / 8 - 1:0] & {(VP_LEN / 8){fsm_vzsext_vf2 | fsm_vzsext_vf4 | fsm_vzsext_vf8}};
        assign vzsext_buf1_mask = vzsext_buf_mask[VP_LEN / 8 +:VP_LEN / 8] & {(VP_LEN / 8){fsm_vzsext_vf2 | fsm_vzsext_vf4 | fsm_vzsext_vf8}};
        reg e1_vmv_nr;
        reg e1_vmv_sfx;
        reg vd_full_dlen;
        reg vd_vmv_sfx;
        always @(posedge vpu_vpermut_clk) begin
            if (e1_ctrl_en) begin
                e1_vmv_nr <= fsm_vmv_nr;
                e1_vmv_sfx <= fsm_vmv_sfx;
            end
        end

        always @(posedge vpu_vpermut_clk) begin
            if (vd_wvalid_en) begin
                vd_full_dlen <= e1_valid & (e1_vmv_nr | e1_vmv_sfx | e1_vzsext);
                vd_vmv_sfx <= e1_valid & e1_vmv_sfx;
            end
        end

        reg vd_upper_sel;
        reg [VP_LEN / 8 - 1:0] vd_lower_wmask;
        reg [VP_LEN - 1:0] vd_lower_wdata;
        wire vd_upper_sel_set = ~e2_kill & vd_wvalid & vd_wready & ~vd_full_dlen & ~vd_upper_sel;
        wire vd_upper_sel_clr = e2_kill | (vd_wvalid & vd_wready & ~vd_full_dlen & vd_upper_sel);
        always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                vd_upper_sel <= 1'b0;
            end
            else if (vd_upper_sel_clr | vd_upper_sel_set) begin
                vd_upper_sel <= vd_upper_sel_set;
            end
        end

        always @(posedge vpu_vpermut_clk) begin
            if (~vd_upper_sel & vd_wvalid & ~e2_kill & vd_wready) begin
                vd_lower_wmask <= vd_wmask;
                vd_lower_wdata <= vd_wdata;
            end
        end

        assign vd_wready = (~vd_full_dlen & ~vd_upper_sel) | vpermut_vd_wready;
        assign vpermut_vd_wvalid = (vd_upper_sel | vd_full_dlen) & vd_wvalid;
        assign vpermut_vd_wmask = vd_full_dlen ? {{VP_LEN / 8{~vd_vmv_sfx}} & vd_wmask1,vd_wmask0} : {vd_wmask,vd_lower_wmask};
        assign vpermut_vd_wdata = vd_full_dlen ? {vd_buf1,vd_buf0} : {vd_wdata,vd_lower_wdata};
        assign e1_vmv_nr_cmd = e1_vmv_nr;
        assign e1_vzsext_cmd = e1_vzsext;
    end
endgenerate
always @(posedge vpu_vpermut_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        srf_wvalid <= 1'b0;
    end
    else if (srf_wvalid_en) begin
        srf_wvalid <= srf_wvalid_nx;
    end
end

assign srf_stall = srf_wvalid & ~srf_wready & ~e2_kill;
assign srf_wvalid_en = ~srf_stall;
assign srf_wvalid_set = e1_valid & e1_srf_wvalid & ~e1_stall & ~e1_kill;
assign srf_wvalid_nx = e1_valid & e1_srf_wvalid & ~vd_stall & ~e1_kill;
assign vpermut_srf_wvalid = srf_wvalid;
assign vpermut_srf_wfrf = srf_wfrf;
assign vpermut_srf_waddr = srf_waddr;
assign vpermut_srf_wdata = srf_wdata;
assign vpermut_standby_ready = fsm_idle & ~e1_valid & ~vd_wvalid & ~srf_wvalid & dis_ready;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

