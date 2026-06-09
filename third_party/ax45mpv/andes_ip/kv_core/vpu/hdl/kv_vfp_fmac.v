// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfp_fmac (
    f3_wdata,
    f3_wdata_en,
    f3_flag_set,
    f3_result_type,
    fpipe_stall,
    f1_fp_mode,
    f1_op1_data,
    f1_op2_data,
    f1_op3_data,
    f1_valid,
    f1_round_mode,
    f1_sew,
    f1_op_mask,
    f1_op1_sew16,
    f1_op1_sp,
    f1_op1_hp,
    f1_op1_bp,
    f1_op3_sew16,
    f1_op3_sp,
    f1_op3_hp,
    f1_op3_bp,
    f1_mul_instr,
    f1_madd_instr,
    f1_msub_instr,
    f1_nmadd_instr,
    f1_nmsub_instr,
    vpu_vmac_clk,
    vpu_reset_n
);
parameter FLEN = 32;
localparam BP_FRAC_BW = 7;
localparam HP_FRAC_BW = 10;
localparam SP_FRAC_BW = 23;
localparam DP_FRAC_BW = 52;
localparam EXP_MSB = 9;
localparam MAC_MSB = (FLEN == 64) ? 163 : (FLEN == 32) ? 134 : 121;
localparam MAC_LSB = (FLEN == 64) ? 0 : (FLEN == 32) ? 58 : 84;
localparam MAC_WIDTH = MAC_MSB - MAC_LSB + 1;
localparam MUL_MSB = DP_FRAC_BW;
localparam MUL_LSB = (FLEN == 64) ? MUL_MSB - DP_FRAC_BW : (FLEN == 32) ? MUL_MSB - SP_FRAC_BW : MUL_MSB - HP_FRAC_BW;
localparam LZA_MSB = MAC_MSB;
localparam LZA_LSB = MAC_LSB + 1;
localparam LZA_WIDTH = LZA_MSB - LZA_LSB + 1;
localparam HP_LZA_MSB = 163 - (DP_FRAC_BW - HP_FRAC_BW);
localparam BP_LZA_MSB = 163 - (DP_FRAC_BW - BP_FRAC_BW);
localparam ROUND_RNE = 3'b000;
localparam ROUND_RTZ = 3'b001;
localparam ROUND_RDN = 3'b010;
localparam ROUND_RUP = 3'b011;
localparam ROUND_RMM = 3'b100;
input vpu_vmac_clk;
input vpu_reset_n;
input fpipe_stall;
input f1_fp_mode;
input [31:0] f1_op1_data;
input [31:0] f1_op2_data;
input [31:0] f1_op3_data;
input f1_valid;
input [2:0] f1_round_mode;
input [1:0] f1_sew;
input f1_op_mask;
input f1_op1_sew16;
input f1_op1_sp;
input f1_op1_hp;
input f1_op1_bp;
input f1_op3_sew16;
input f1_op3_sp;
input f1_op3_hp;
input f1_op3_bp;
input f1_mul_instr;
input f1_madd_instr;
input f1_msub_instr;
input f1_nmadd_instr;
input f1_nmsub_instr;
output [63:0] f3_wdata;
output f3_wdata_en;
output [4:0] f3_flag_set;
output [1:0] f3_result_type;





// afabc8d8 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire f1_op2_sew16 = f1_op1_sew16;
wire f1_op2_sp = f1_op1_sp;
wire f1_op2_hp = f1_op1_hp;
wire f1_op2_bp = f1_op1_bp;
wire f1_abs_amount_gt128;
wire f1_op1_sign;
wire f1_op2_sign;
wire f1_op3_sign;
wire f1_mul_sign;
wire [EXP_MSB:0] f1_op1_exp;
wire [EXP_MSB:0] f1_op2_exp;
wire [EXP_MSB:0] f1_op3_exp;
wire [52:0] f1_op1_frac;
wire [52:0] f1_op2_frac;
wire [52:0] f1_op3_frac;
wire f1_op1_subnorm_hp;
wire f1_op1_subnorm_bp;
wire f1_op1_subnorm_sp;
wire f1_op2_subnorm_hp;
wire f1_op2_subnorm_bp;
wire f1_op2_subnorm_sp;
wire f1_op3_subnorm_hp;
wire f1_op3_subnorm_bp;
wire f1_op3_subnorm_sp;
wire [2:0] f1_round_mode;
wire f1_eff_sub;
wire f2_eff_sub_nx;
wire f1_frd_hp;
wire f1_frd_bp;
wire f1_frd_sp;
wire [107:(MAC_LSB + 2)] f1_mul_result;
wire [MAC_MSB:MAC_LSB] f1_pre_lsh_frac;
wire [MAC_MSB:MAC_LSB] f1_abs_l1;
wire [MAC_MSB:MAC_LSB] f1_abs_l2;
wire [MAC_MSB:MAC_LSB] f1_abs_l3;
wire [MAC_MSB:MAC_LSB] f1_abs_l4;
wire [MAC_MSB:MAC_LSB] f1_abs_l5;
wire [MAC_MSB:MAC_LSB] f1_abs_l6;
wire [MAC_MSB:MAC_LSB] f1_abs_l7;
wire [MAC_MSB:MAC_LSB] f1_abs_final_out;
wire [EXP_MSB:0] f1_abs_amount;
wire f1_abs_amount_zero;
wire f1_abs_sticky_l1;
wire f1_abs_sticky_l2;
wire f1_abs_sticky_l3;
wire f1_abs_sticky_l4;
wire f1_abs_sticky_l5;
wire f1_abs_sticky_l6;
wire f1_abs_sticky_l7;
wire f1_frd_zero;
wire f1_frd_inf;
wire f1_frd_nan;
wire f1_frd_zero_sign;
wire f1_frd_inf_sign;
wire f1_mac_exp_sel_mul;
wire f1_mul_exp_bigger;
wire [EXP_MSB:0] f1_align_diff;
wire [EXP_MSB:0] f1_op1_exp_no_bias;
wire [EXP_MSB:0] f1_op2_exp_no_bias;
wire [EXP_MSB:0] f1_op3_exp_no_bias;
wire [EXP_MSB:0] f1_mul_exp_no_bias;
wire [EXP_MSB:0] f1_abs_csa_sum;
wire [EXP_MSB:0] f1_abs_csa_cout;
wire [EXP_MSB:0] f1_mac_align_diff;
wire f1_nv_exception;
wire f1_mul_is_zero;
wire [EXP_MSB:0] f2_mac_exp_op1_nx;
wire [EXP_MSB:0] f2_mac_exp_op2_nx;
wire f1_arith_sign;
wire [8:1] f2_abs_sticky_nx;
wire [107:MAC_LSB + 2] f2_mul_result_nx;
reg [107:MAC_LSB + 2] f2_mul_result;
reg f2_valid;
reg f2_nv_exception;
reg f2_frd_inf;
reg f2_frd_zero;
reg f2_frd_nan;
reg f2_arith_sign;
reg f2_eff_sub;
reg [2:0] f2_round_mode;
reg [EXP_MSB:0] f2_mac_exp_op2;
reg [EXP_MSB:0] f2_mac_exp_op1;
reg [8:1] f2_abs_sticky_reg;
reg [MAC_MSB:MAC_LSB] f2_abs_final_out;
wire f2_frd_hp;
wire f2_frd_bp;
wire f2_frd_sp;
wire f2_pipe_en;
wire [7:0] f2_pos_lzc;
wire [7:0] f2_neg_lzc;
wire [MAC_MSB:MAC_LSB] f2_mac_added_pos;
wire [MAC_MSB:MAC_LSB] f2_mac_added_neg;
wire [MAC_MSB:MAC_LSB] f2_mac_add_op1;
wire [MAC_MSB:MAC_LSB] f2_mac_add_op2;
wire [MAC_MSB:MAC_LSB] f2_ha_sum;
wire [MAC_MSB:MAC_LSB] f2_ha_cout;
wire [MAC_MSB:MAC_LSB] f2_ha_cout_inv;
wire [MAC_MSB:MAC_LSB] f2_nbs_sum_l0;
wire [MAC_MSB:MAC_LSB] f2_nbs_sum_l1;
wire [MAC_MSB:MAC_LSB] f2_nbs_sum_l2;
wire [MAC_MSB:MAC_LSB] f2_nbs_sum_l3;
wire [MAC_MSB:MAC_LSB] f2_nbs_sum_l4;
wire [MAC_MSB:MAC_LSB] f2_nbs_sum_l5;
wire [LZA_MSB:LZA_LSB] f2_pos_lza_result0;
wire [LZA_MSB:LZA_LSB] f2_pos_lza_result1;
wire [LZA_MSB:LZA_LSB] f2_neg_lza_result0;
wire [LZA_MSB:LZA_LSB] f2_neg_lza_result1;
wire [LZA_MSB:LZA_LSB] f2_pos_a_string;
wire [LZA_MSB:LZA_LSB] f2_pos_p_string;
wire [LZA_MSB:LZA_LSB] f2_neg_a_string;
wire [LZA_MSB:LZA_LSB] f2_neg_p_string;
wire [LZA_MSB:LZA_LSB] f2_neg_e_string;
wire [LZA_MSB:LZA_LSB] f2_pos_e_string;
wire [LZA_MSB:LZA_LSB] f2_neg_lza_string;
wire [LZA_MSB:LZA_LSB] f2_pos_lza_string;
wire f2_sub_and_no_sticky;
wire f2_complement;
wire f2_abs_sticky;
wire [7:0] f2_lzc;
wire [7:0] f2_lzc_after_subnorm_pred;
wire f2_ovf_check_disable;
wire [EXP_MSB:0] f2_mac_exp;
wire [EXP_MSB:0] f2_subnorm_bound;
wire f2_lzc_sel_subnorm;
wire [EXP_MSB:0] f2_lzc_subnorm_pred;
wire f2_round_rne;
wire f2_round_rmm;
wire f2_round_rdn;
wire f2_round_rup;
wire f2_round_rtz;
wire f2_ri;
wire f2_rn;
wire f2_rz;
reg f3_valid;
reg f3_nv_exception;
reg f3_frd_inf;
reg f3_frd_zero;
reg f3_frd_nan;
reg f3_arith_sign;
reg f3_abs_sticky;
reg [EXP_MSB:0] f3_mac_exp;
reg f3_lzc_after_subnorm_pred_00;
reg f3_lzc_after_subnorm_pred_01;
reg f3_lzc_after_subnorm_pred_10;
reg f3_lzc_after_subnorm_pred_11;
wire f3_lzc_after_subnorm_pred_00_nx;
wire f3_lzc_after_subnorm_pred_01_nx;
wire f3_lzc_after_subnorm_pred_10_nx;
wire f3_lzc_after_subnorm_pred_11_nx;
reg f3_ovf_check_disable;
reg [2:0] f3_round_mode;
reg [MAC_MSB:MAC_LSB] f3_nbs_sum_l5;
reg f3_ri;
reg f3_rn;
reg f3_rz;
wire f3_frd_hp;
wire f3_frd_bp;
wire f3_frd_sp;
wire [MAC_MSB:MAC_LSB] f3_nbs_sum_l7;
wire [EXP_MSB:0] f3_mac_exp_nx;
wire f3_pipe_en;
wire f3_sp_subnorm_pred;
wire f3_hp_subnorm_pred;
wire f3_bp_subnorm_pred;
wire f3_subnorm_pred;
wire f3_nx_exception;
wire [MAC_MSB:113] f3_y0;
wire [MAC_MSB:113] f3_y1;
wire [4:0] f3_round_no_ovf;
wire [4:0] f3_round_with_ovf;
wire [4:0] f3_low_part;
wire [113:109] f3_z;
wire [MAC_MSB:113] f3_y;
wire f3_lza_error;
wire f3_increase_exp;
wire [(MAC_MSB - 1):110] f3_frac;
wire [(MAC_MSB - 1):110] f3_frac_corrected;
wire [4:0] f3_low_part_round_no_ovf;
wire [4:0] f3_low_part_round_with_ovf;
wire f3_sticky;
wire f3_sticky_ovf;
wire f3_low_part_carry_to_y0;
wire f3_arith_sign_nx;
wire f3_zero_sign;
wire [31:0] f3_arith_wdata;
wire [31:0] f3_non_arith_wdata;
wire f3_non_arith_wdata_en;
wire [1:0] f3_round_digit;
wire [1:0] f3_round_digit_ovf;
wire [1:0] f3_round_ha;
wire [1:0] f3_round_ha_ovf;
wire [EXP_MSB:0] f3_adjust_exp_bias;
wire f3_tie;
wire f3_tie_round_bit;
wire f3_tie_sticky_bit;
wire f3_exp_s_gt_ovf_bound;
wire f3_exp_s_gt_sub_bound;
wire f3_exp_s_gt_udf_bound;
wire f3_exp_h_gt_ovf_bound;
wire f3_exp_h_gt_sub_bound;
wire f3_exp_h_gt_udf_bound;
wire f3_exp_b_gt_ovf_bound;
wire f3_exp_b_gt_sub_bound;
wire f3_exp_b_gt_udf_bound;
wire f3_exp_p0_s_gt_ovf_bound;
wire f3_exp_p0_s_gt_sub_bound;
wire f3_exp_p0_s_gt_udf_bound;
wire f3_exp_p0_h_gt_ovf_bound;
wire f3_exp_p0_h_gt_sub_bound;
wire f3_exp_p0_h_gt_udf_bound;
wire f3_exp_p0_b_gt_ovf_bound;
wire f3_exp_p0_b_gt_sub_bound;
wire f3_exp_p0_b_gt_udf_bound;
wire f3_exp_p1_s_gt_ovf_bound;
wire f3_exp_p1_s_gt_sub_bound;
wire f3_exp_p1_s_gt_udf_bound;
wire f3_exp_p1_h_gt_ovf_bound;
wire f3_exp_p1_h_gt_sub_bound;
wire f3_exp_p1_h_gt_udf_bound;
wire f3_exp_p1_b_gt_ovf_bound;
wire f3_exp_p1_b_gt_sub_bound;
wire f3_exp_p1_b_gt_udf_bound;
wire f3_sp_of_exception;
wire f3_hp_of_exception;
wire f3_bp_of_exception;
wire f3_sp_subnorm;
wire f3_hp_subnorm;
wire f3_bp_subnorm;
wire f3_sp_uf_exception;
wire f3_hp_uf_exception;
wire f3_bp_uf_exception;
wire f3_of_exception;
wire f3_uf_exception;
wire f3_subnorm_to_normal;
wire f3_subnorm;
wire f3_frac_all_zero;
wire f3_frd_result_zero;
wire f3_frd_result_inf;
wire f3_frd_result_largest;
wire f3_frd_result_smallest;
wire f3_frd_special;
wire f3_frd_nan_hp;
wire f3_frd_nan_bp;
wire f3_frd_nan_sp;
wire f3_frd_result_inf_hp;
wire f3_frd_result_inf_bp;
wire f3_frd_result_inf_sp;
wire f3_frd_result_zero_hp;
wire f3_frd_result_zero_bp;
wire f3_frd_result_zero_sp;
wire f3_frd_result_largest_hp;
wire f3_frd_result_largest_bp;
wire f3_frd_result_largest_sp;
wire f3_frd_result_smallest_hp;
wire f3_frd_result_smallest_bp;
wire f3_frd_result_smallest_sp;
wire f3_uf_to_subnorm;
wire f3_subnorm_set_uf_cond1;
wire f3_subnorm_set_uf_cond2;
wire [EXP_MSB:0] f3_subnorm_amount;
wire [EXP_MSB:0] f3_adjust_exp;
wire f3_subnorm_set_uf;
wire f3_subnorm_uf_cond1;
wire f3_subnorm_uf_cond2;
wire f1_sew16 = (f1_sew[1:0] == 2'b01);
wire f1_sew32 = (f1_sew[1:0] == 2'b10);
assign f1_frd_hp = f1_sew16 & ~f1_fp_mode;
assign f1_frd_bp = f1_sew16 & f1_fp_mode;
assign f1_frd_sp = f1_sew32;
wire f1_op1_h_sign = f1_op1_data[15];
wire [4:0] f1_op1_h_exp = f1_op1_data[14:10];
wire [9:0] f1_op1_h_frac = f1_op1_data[9:0];
wire f1_op2_h_sign = f1_op2_data[15];
wire [4:0] f1_op2_h_exp = f1_op2_data[14:10];
wire [9:0] f1_op2_h_frac = f1_op2_data[9:0];
wire f1_op3_h_sign = f1_op3_data[15];
wire [4:0] f1_op3_h_exp = f1_op3_data[14:10];
wire [9:0] f1_op3_h_frac = f1_op3_data[9:0];
wire f1_op1_b_sign = f1_op1_data[15];
wire [7:0] f1_op1_b_exp = f1_op1_data[14:7];
wire [6:0] f1_op1_b_frac = f1_op1_data[6:0];
wire f1_op2_b_sign = f1_op2_data[15];
wire [7:0] f1_op2_b_exp = f1_op2_data[14:7];
wire [6:0] f1_op2_b_frac = f1_op2_data[6:0];
wire f1_op3_b_sign = f1_op3_data[15];
wire [7:0] f1_op3_b_exp = f1_op3_data[14:7];
wire [6:0] f1_op3_b_frac = f1_op3_data[6:0];
wire f1_op1_s_sign = f1_op1_data[31];
wire [7:0] f1_op1_s_exp = f1_op1_data[30:23];
wire [22:0] f1_op1_s_frac = f1_op1_data[22:0];
wire f1_op2_s_sign = f1_op2_data[31];
wire [7:0] f1_op2_s_exp = f1_op2_data[30:23];
wire [22:0] f1_op2_s_frac = f1_op2_data[22:0];
wire f1_op3_s_sign = f1_op3_data[31];
wire [7:0] f1_op3_s_exp = f1_op3_data[30:23];
wire [22:0] f1_op3_s_frac = f1_op3_data[22:0];
wire f1_op1_exp_all1 = (f1_op1_sp & (&f1_op1_s_exp)) | (f1_op1_hp & (&f1_op1_h_exp)) | (f1_op1_bp & (&f1_op1_b_exp));
wire f1_op2_exp_all1 = (f1_op2_sp & (&f1_op2_s_exp)) | (f1_op2_hp & (&f1_op2_h_exp)) | (f1_op2_bp & (&f1_op2_b_exp));
wire f1_op3_exp_all1 = (f1_op3_sp & (&f1_op3_s_exp)) | (f1_op3_hp & (&f1_op3_h_exp)) | (f1_op3_bp & (&f1_op3_b_exp));
wire f1_op1_exp_all0 = (f1_op1_sp & ~(|f1_op1_s_exp)) | (f1_op1_hp & ~(|f1_op1_h_exp)) | (f1_op1_bp & ~(|f1_op1_b_exp));
wire f1_op2_exp_all0 = (f1_op2_sp & ~(|f1_op2_s_exp)) | (f1_op2_hp & ~(|f1_op2_h_exp)) | (f1_op2_bp & ~(|f1_op2_b_exp));
wire f1_op3_exp_all0 = (f1_op3_sp & ~(|f1_op3_s_exp)) | (f1_op3_hp & ~(|f1_op3_h_exp)) | (f1_op3_bp & ~(|f1_op3_b_exp));
wire f1_op1_frac_all0 = (f1_op1_sp & ~(|f1_op1_s_frac)) | (f1_op1_hp & ~(|f1_op1_h_frac)) | (f1_op1_bp & ~(|f1_op1_b_frac));
wire f1_op2_frac_all0 = (f1_op2_sp & ~(|f1_op2_s_frac)) | (f1_op2_hp & ~(|f1_op2_h_frac)) | (f1_op2_bp & ~(|f1_op2_b_frac));
wire f1_op3_frac_all0 = (f1_op3_sp & ~(|f1_op3_s_frac)) | (f1_op3_hp & ~(|f1_op3_h_frac)) | (f1_op3_bp & ~(|f1_op3_b_frac));
wire f1_op1_signaling_bit = (f1_op1_sp & f1_op1_data[22]) | (f1_op1_hp & f1_op1_data[9]) | (f1_op1_bp & f1_op1_data[6]);
wire f1_op2_signaling_bit = (f1_op2_sp & f1_op2_data[22]) | (f1_op2_hp & f1_op2_data[9]) | (f1_op2_bp & f1_op2_data[6]);
wire f1_op3_signaling_bit = (f1_op3_sp & f1_op3_data[22]) | (f1_op3_hp & f1_op3_data[9]) | (f1_op3_bp & f1_op3_data[6]);
wire f1_op1_is_inf = f1_op1_exp_all1 & f1_op1_frac_all0;
wire f1_op2_is_inf = f1_op2_exp_all1 & f1_op2_frac_all0;
wire f1_op3_is_inf = f1_op3_exp_all1 & f1_op3_frac_all0;
wire f1_op1_is_nan = (f1_op1_exp_all1 & ~f1_op1_frac_all0);
wire f1_op2_is_nan = (f1_op2_exp_all1 & ~f1_op2_frac_all0);
wire f1_op3_is_nan = (f1_op3_exp_all1 & ~f1_op3_frac_all0);
wire f1_op1_is_snan = f1_op1_is_nan & ~f1_op1_signaling_bit;
wire f1_op2_is_snan = f1_op2_is_nan & ~f1_op2_signaling_bit;
wire f1_op3_is_snan = f1_op3_is_nan & ~f1_op3_signaling_bit;
wire f1_op1_is_zero = f1_op1_exp_all0 & f1_op1_frac_all0;
wire f1_op2_is_zero = f1_op2_exp_all0 & f1_op2_frac_all0;
wire f1_op3_is_zero = f1_op3_exp_all0 & f1_op3_frac_all0;
wire f1_op1_sew16_sign = f1_fp_mode ? f1_op1_b_sign : f1_op1_h_sign;
wire f1_op2_sew16_sign = f1_fp_mode ? f1_op2_b_sign : f1_op2_h_sign;
wire f1_op3_sew16_sign = f1_fp_mode ? f1_op3_b_sign : f1_op3_h_sign;
assign f1_op1_sign = ((f1_op1_sp & f1_op1_s_sign) | (f1_op1_sew16 & f1_op1_sew16_sign));
assign f1_op2_sign = ((f1_op2_sp & f1_op2_s_sign) | (f1_op2_sew16 & f1_op2_sew16_sign));
assign f1_op3_sign = ((f1_op3_sp & f1_op3_s_sign) | (f1_op3_sew16 & f1_op3_sew16_sign));
assign f1_mul_sign = f1_op1_sign ^ f1_op2_sign ^ (f1_nmadd_instr | f1_nmsub_instr);
assign f1_eff_sub = (f1_mul_sign ^ f1_op3_sign ^ (f1_msub_instr | f1_nmadd_instr));
wire f1_mul_to_inf = f1_op1_is_inf & ~(f1_op2_is_zero | f1_op2_is_nan) | f1_op2_is_inf & ~(f1_op1_is_zero | f1_op1_is_nan);
wire f1_mul_to_zero = f1_op1_is_zero & ~(f1_op2_is_inf | f1_op2_is_nan) | f1_op2_is_zero & ~(f1_op1_is_inf | f1_op1_is_nan);
wire f1_mul_to_nan = (f1_op1_is_nan | f1_op2_is_nan) | (f1_op1_is_inf & f1_op2_is_zero) | (f1_op2_is_inf & f1_op1_is_zero);
wire f1_mul_to_nv_exc = (f1_op1_is_snan | f1_op2_is_snan) | (f1_op1_is_inf & f1_op2_is_zero) | (f1_op2_is_inf & f1_op1_is_zero);
assign f1_frd_zero = f1_mul_to_zero & f1_op3_is_zero;
assign f1_frd_inf = (f1_mul_to_inf & ~f1_op3_is_nan & ~(f1_op3_is_inf & f1_eff_sub)) | (f1_op3_is_inf & ~f1_mul_to_nan & ~(f1_mul_to_inf & f1_eff_sub));
assign f1_frd_nan = (f1_mul_to_nan | f1_op3_is_nan) | (f1_mul_to_inf & f1_op3_is_inf & f1_eff_sub);
assign f1_nv_exception = (f1_mul_to_nv_exc | f1_op3_is_snan) | (f1_mul_to_inf & f1_op3_is_inf & f1_eff_sub);
assign f1_frd_zero_sign = (f1_mul_instr & f1_mul_sign) | (f1_madd_instr & f1_mul_sign & f1_op3_sign) | (f1_nmadd_instr & f1_mul_sign & ~f1_op3_sign) | (f1_msub_instr & f1_mul_sign & ~f1_op3_sign) | (f1_nmsub_instr & f1_mul_sign & f1_op3_sign) | (f1_eff_sub & (f1_round_mode == ROUND_RDN));
assign f1_frd_inf_sign = (f1_madd_instr & (f1_op3_is_inf ? f1_op3_sign : f1_mul_sign)) | (f1_nmadd_instr & (f1_op3_is_inf ? ~f1_op3_sign : f1_mul_sign)) | (f1_msub_instr & (f1_op3_is_inf ? ~f1_op3_sign : f1_mul_sign)) | (f1_nmsub_instr & (f1_op3_is_inf ? f1_op3_sign : f1_mul_sign)) | (f1_mul_instr & f1_mul_sign);
assign f1_op1_subnorm_hp = (f1_op1_data[14:10] == 5'b0);
assign f1_op1_subnorm_bp = (f1_op1_data[14:7] == 8'b0);
assign f1_op1_subnorm_sp = (f1_op1_data[30:23] == 8'b0);
assign f1_op2_subnorm_hp = (f1_op2_data[14:10] == 5'b0);
assign f1_op2_subnorm_bp = (f1_op2_data[14:7] == 8'b0);
assign f1_op2_subnorm_sp = (f1_op2_data[30:23] == 8'b0);
assign f1_op3_subnorm_hp = (f1_op3_data[14:10] == 5'b0);
assign f1_op3_subnorm_bp = (f1_op3_data[14:7] == 8'b0);
assign f1_op3_subnorm_sp = (f1_op3_data[30:23] == 8'b0);
assign f1_op1_exp = ({10{f1_op1_hp}} & {5'b0,f1_op1_data[14:11],f1_op1_data[10] | f1_op1_subnorm_hp}) | ({10{f1_op1_bp}} & {2'b0,f1_op1_data[14:8],f1_op1_data[7] | f1_op1_subnorm_bp}) | ({10{f1_op1_sp}} & {2'b0,f1_op1_data[30:24],f1_op1_data[23] | f1_op1_subnorm_sp});
assign f1_op2_exp = ({10{f1_op2_hp}} & {5'b0,f1_op2_data[14:11],f1_op2_data[10] | f1_op2_subnorm_hp}) | ({10{f1_op2_bp}} & {2'b0,f1_op2_data[14:8],f1_op2_data[7] | f1_op2_subnorm_bp}) | ({10{f1_op2_sp}} & {2'b0,f1_op2_data[30:24],f1_op2_data[23] | f1_op2_subnorm_sp});
assign f1_op3_exp = ({10{f1_op3_hp}} & {5'b0,f1_op3_data[14:11],f1_op3_data[10] | f1_op3_subnorm_hp}) | ({10{f1_op3_bp}} & {2'b0,f1_op3_data[14:8],f1_op3_data[7] | f1_op3_subnorm_bp}) | ({10{f1_op3_sp}} & {2'b0,f1_op3_data[30:24],f1_op3_data[23] | f1_op3_subnorm_sp});
assign f1_op1_frac = ({53{f1_op1_hp}} & {~f1_op1_subnorm_hp,f1_op1_data[9:0],42'b0}) | ({53{f1_op1_bp}} & {~f1_op1_subnorm_bp,f1_op1_data[6:0],45'b0}) | ({53{f1_op1_sp}} & {~f1_op1_subnorm_sp,f1_op1_data[22:0],29'b0});
assign f1_op2_frac = ({53{f1_op2_hp}} & {~f1_op2_subnorm_hp,f1_op2_data[9:0],42'b0}) | ({53{f1_op2_bp}} & {~f1_op2_subnorm_bp,f1_op2_data[6:0],45'b0}) | ({53{f1_op2_sp}} & {~f1_op2_subnorm_sp,f1_op2_data[22:0],29'b0});
assign f1_op3_frac = ({53{f1_op3_hp}} & {~f1_op3_subnorm_hp,f1_op3_data[9:0],42'b0}) | ({53{f1_op3_bp}} & {~f1_op3_subnorm_bp,f1_op3_data[6:0],45'b0}) | ({53{f1_op3_sp}} & {~f1_op3_subnorm_sp,f1_op3_data[22:0],29'b0});
assign f1_mul_result = {{(MUL_MSB - MUL_LSB + 1){1'b0}},f1_op1_frac[MUL_MSB:MUL_LSB]} * {{(MUL_MSB - MUL_LSB + 1){1'b0}},f1_op2_frac[MUL_MSB:MUL_LSB]};
assign f2_mul_result_nx = f1_mul_result;
wire nds_unused_3;
wire nds_unused_4;
wire [EXP_MSB + 1:0] f1_abs_csa_in0;
wire [EXP_MSB + 1:0] f1_abs_csa_in1;
wire [EXP_MSB + 1:0] f1_abs_csa_cin;
assign f1_abs_csa_in0 = {f1_op3_exp[EXP_MSB],f1_op3_exp};
assign f1_abs_csa_in1 = ~{f1_op1_exp[EXP_MSB],f1_op1_exp};
assign f1_abs_csa_cin = ~{f1_op2_exp[EXP_MSB],f1_op2_exp};
assign {nds_unused_3,f1_abs_csa_sum[EXP_MSB:0]} = f1_abs_csa_in0 ^ f1_abs_csa_in1 ^ f1_abs_csa_cin;
assign {nds_unused_4,f1_abs_csa_cout[EXP_MSB:0]} = (f1_abs_csa_in0 & f1_abs_csa_in1) | (f1_abs_csa_in0 & f1_abs_csa_cin) | (f1_abs_csa_in1 & f1_abs_csa_cin);
wire [9:0] f1_op1_exp_no_bias_sub_op1;
wire [9:0] f1_op1_exp_no_bias_sub_op2;
wire [9:0] f1_op2_exp_no_bias_sub_op1;
wire [9:0] f1_op2_exp_no_bias_sub_op2;
wire [9:0] f1_op3_exp_no_bias_sub_op1;
wire [9:0] f1_op3_exp_no_bias_sub_op2;
assign f1_op1_exp_no_bias_sub_op1 = f1_op1_exp;
assign f1_op2_exp_no_bias_sub_op1 = f1_op2_exp;
assign f1_op3_exp_no_bias_sub_op1 = f1_op3_exp;
assign f1_op1_exp_no_bias_sub_op2 = (f1_op1_hp ? 10'd15 : 10'd127) & {10{~f1_op1_is_zero}};
assign f1_op2_exp_no_bias_sub_op2 = (f1_op2_hp ? 10'd15 : 10'd127) & {10{~f1_op2_is_zero}};
assign f1_op3_exp_no_bias_sub_op2 = (f1_op3_hp ? 10'd15 : 10'd127) & {10{~f1_op3_is_zero}};
wire nds_unused_f1_op1_exp_no_bias_co;
wire nds_unused_f1_op2_exp_no_bias_co;
wire nds_unused_f1_op3_exp_no_bias_co;
assign {nds_unused_f1_op1_exp_no_bias_co,f1_op1_exp_no_bias} = f1_op1_exp_no_bias_sub_op1 - f1_op1_exp_no_bias_sub_op2;
assign {nds_unused_f1_op2_exp_no_bias_co,f1_op2_exp_no_bias} = f1_op2_exp_no_bias_sub_op1 - f1_op2_exp_no_bias_sub_op2;
assign {nds_unused_f1_op3_exp_no_bias_co,f1_op3_exp_no_bias} = f1_op3_exp_no_bias_sub_op1 - f1_op3_exp_no_bias_sub_op2;
wire nds_unused_f1_mul_exp_no_bias_co;
assign {nds_unused_f1_mul_exp_no_bias_co,f1_mul_exp_no_bias} = f1_op1_exp_no_bias + f1_op2_exp_no_bias;
assign f1_mul_is_zero = f1_op1_is_zero | f1_op2_is_zero;
wire [9:0] f1_mac_align_diff_add_op1;
wire [9:0] f1_mac_align_diff_add_op3;
assign f1_mac_align_diff_add_op1 = {f1_abs_csa_cout[EXP_MSB - 1:0],1'b1};
assign f1_mac_align_diff_add_op3 = ({10{f1_op1_sew16 & f1_op2_sew16 & ~f1_op3_sew16 & f1_frd_sp & ~f1_fp_mode}} & 10'h3a0) | ({10{f1_op1_sew16 & f1_op2_sew16 & f1_op3_sew16 & f1_frd_sp & ~f1_fp_mode}} & 10'h10) | ({10{f1_op1_sew16 & f1_op2_sew16 & f1_op3_sew16 & f1_fp_mode}} & 10'h80) | ({10{f1_op1_sew16 & f1_op2_sew16 & f1_op3_sp & f1_fp_mode}} & 10'h80) | ({10{f1_op1_sew16 & f1_op2_sew16 & f1_op3_sew16 & f1_frd_hp}} & 10'h10) | ({10{f1_op1_sp & f1_op2_sp & f1_op3_sp & f1_frd_sp}} & 10'h80);
wire [1:0] nds_unused_f1_mac_align_diff_co;
assign {nds_unused_f1_mac_align_diff_co,f1_mac_align_diff} = f1_mac_align_diff_add_op1 + f1_abs_csa_sum[EXP_MSB:0] + f1_mac_align_diff_add_op3;
assign f1_align_diff = (f1_mul_is_zero | f1_op3_is_zero) ? 10'b0 : f1_mac_align_diff;
assign f1_abs_amount_zero = f1_abs_amount[EXP_MSB];
assign f1_mul_exp_bigger = f1_align_diff[9];
assign f1_mac_exp_sel_mul = (f1_mul_exp_bigger & ~f1_mul_is_zero) | f1_op3_is_zero;
assign f2_mac_exp_op1_nx = f1_mac_exp_sel_mul ? f1_mul_exp_no_bias : f1_op3_exp_no_bias;
assign f2_mac_exp_op2_nx = ({10{f1_mac_exp_sel_mul & f1_frd_hp}} & 10'd14) | ({10{f1_mac_exp_sel_mul & f1_frd_bp}} & 10'd11) | ({10{f1_mac_exp_sel_mul & f1_frd_sp}} & 10'd27) | ({10{~f1_mac_exp_sel_mul & ~f1_abs_amount_zero}} & f1_abs_amount);
assign f2_eff_sub_nx = f1_eff_sub & ~f1_frd_inf;
assign f1_arith_sign = f1_frd_zero ? f1_frd_zero_sign : f1_frd_inf ? f1_frd_inf_sign : f1_mul_sign;
generate
    if (FLEN > 16) begin:gen_f1_abs_l1_for_sp
        assign f1_pre_lsh_frac = ({MAC_WIDTH{f1_frd_hp}} & ({14'b0,f1_op3_frac,10'd0} ^ {MAC_WIDTH{f1_eff_sub}})) | ({MAC_WIDTH{f1_frd_bp}} & ({17'b0,f1_op3_frac,7'd0} ^ {MAC_WIDTH{f1_eff_sub}})) | ({MAC_WIDTH{f1_frd_sp}} & ({1'b0,f1_op3_frac,23'd0} ^ {MAC_WIDTH{f1_eff_sub}}));
        wire [9:0] f1_abs_amount_sub_op1;
        wire [9:0] f1_abs_amount_sub_op2;
        assign f1_abs_amount_sub_op1 = ({10{f1_frd_bp}} & 10'd11) | ({10{f1_frd_hp}} & 10'd14) | ({10{f1_frd_sp}} & 10'd27);
        assign f1_abs_amount_sub_op2 = f1_align_diff;
        wire nds_unused_f1_abs_amount_co;
        assign {nds_unused_f1_abs_amount_co,f1_abs_amount} = f1_abs_amount_sub_op1 - f1_abs_amount_sub_op2;
        assign f1_abs_l1 = (~f1_abs_amount[EXP_MSB] & f1_abs_amount[6]) ? {{64{f1_eff_sub}},f1_pre_lsh_frac[MAC_MSB:(MAC_LSB + 64)]} : f1_pre_lsh_frac;
    end
    else begin:gen_f1_abs_l1_for_hp
        assign f1_pre_lsh_frac = ({MAC_WIDTH{f1_frd_hp}} & ({1'b0,f1_op3_frac[52:42],26'b0} ^ {MAC_WIDTH{f1_eff_sub}})) | ({MAC_WIDTH{f1_frd_bp}} & ({4'b0,f1_op3_frac[52:45],26'b0} ^ {MAC_WIDTH{f1_eff_sub}}));
        wire [9:0] f1_abs_amount_sub_op1;
        assign f1_abs_amount_sub_op1 = ({10{f1_frd_hp}} & 10'd14) | ({10{f1_frd_bp}} & 10'd11);
        wire nds_unused_f1_abs_amount_co;
        assign {nds_unused_f1_abs_amount_co,f1_abs_amount} = f1_abs_amount_sub_op1 - f1_align_diff;
        assign f1_abs_l1 = (~f1_abs_amount[EXP_MSB] & f1_abs_amount[6]) ? {MAC_WIDTH{f1_eff_sub}} : f1_pre_lsh_frac;
    end
endgenerate
assign f1_abs_amount_gt128 = |f1_abs_amount[EXP_MSB - 1:7] & ~f1_abs_amount_zero & ~f1_mul_is_zero;
assign f1_abs_l2 = (~f1_abs_amount_zero & f1_abs_amount[5]) ? {{32{f1_eff_sub}},f1_abs_l1[MAC_MSB:(MAC_LSB + 32)]} : f1_abs_l1;
assign f1_abs_l3 = (~f1_abs_amount_zero & f1_abs_amount[4]) ? {{16{f1_eff_sub}},f1_abs_l2[MAC_MSB:(MAC_LSB + 16)]} : f1_abs_l2;
assign f1_abs_l4 = (~f1_abs_amount_zero & f1_abs_amount[3]) ? {{8{f1_eff_sub}},f1_abs_l3[MAC_MSB:(MAC_LSB + 8)]} : f1_abs_l3;
assign f1_abs_l5 = (~f1_abs_amount_zero & f1_abs_amount[2]) ? {{4{f1_eff_sub}},f1_abs_l4[MAC_MSB:(MAC_LSB + 4)]} : f1_abs_l4;
assign f1_abs_l6 = (~f1_abs_amount_zero & f1_abs_amount[1]) ? {{2{f1_eff_sub}},f1_abs_l5[MAC_MSB:(MAC_LSB + 2)]} : f1_abs_l5;
assign f1_abs_l7 = (~f1_abs_amount_zero & f1_abs_amount[0]) ? {{f1_eff_sub},f1_abs_l6[MAC_MSB:(MAC_LSB + 1)]} : f1_abs_l6;
assign f1_abs_final_out = f1_abs_amount_gt128 ? {MAC_WIDTH{f1_eff_sub}} : f1_abs_l7;
generate
    if (FLEN > 16) begin:gen_f1_abs_sticky_l1_for_sp
        assign f1_abs_sticky_l1 = ~f1_abs_amount_zero & f1_abs_amount[6] & (|({64{f1_eff_sub}} ^ f1_pre_lsh_frac[(MAC_LSB + 63):MAC_LSB]));
    end
    else begin:gen_f1_abs_sticky_l1_for_hp
        assign f1_abs_sticky_l1 = (~f1_abs_amount[EXP_MSB] & f1_abs_amount[6]);
    end
endgenerate
assign f1_abs_sticky_l2 = ~f1_abs_amount_zero & f1_abs_amount[5] & (|({32{f1_eff_sub}} ^ f1_abs_l1[(MAC_LSB + 31):MAC_LSB]));
assign f1_abs_sticky_l3 = ~f1_abs_amount_zero & f1_abs_amount[4] & (|({16{f1_eff_sub}} ^ f1_abs_l2[(MAC_LSB + 15):MAC_LSB]));
assign f1_abs_sticky_l4 = ~f1_abs_amount_zero & f1_abs_amount[3] & (|({8{f1_eff_sub}} ^ f1_abs_l3[(MAC_LSB + 7):MAC_LSB]));
assign f1_abs_sticky_l5 = ~f1_abs_amount_zero & f1_abs_amount[2] & (|({4{f1_eff_sub}} ^ f1_abs_l4[(MAC_LSB + 3):MAC_LSB]));
assign f1_abs_sticky_l6 = ~f1_abs_amount_zero & f1_abs_amount[1] & (|({2{f1_eff_sub}} ^ f1_abs_l5[(MAC_LSB + 1):MAC_LSB]));
assign f1_abs_sticky_l7 = ~f1_abs_amount_zero & f1_abs_amount[0] & (f1_eff_sub ^ f1_abs_l6[MAC_LSB]);
assign f2_abs_sticky_nx = {f1_abs_amount_gt128,f1_abs_sticky_l1,f1_abs_sticky_l2,f1_abs_sticky_l3,f1_abs_sticky_l4,f1_abs_sticky_l5,f1_abs_sticky_l6,f1_abs_sticky_l7};
wire nds_unused_f2_mac_exp_co;
assign {nds_unused_f2_mac_exp_co,f2_mac_exp} = f2_mac_exp_op1 + f2_mac_exp_op2;
assign f2_mac_add_op1 = f2_abs_final_out;
assign f2_mac_add_op2 = {{(((108 - MAC_LSB) / 2) + 2){1'b0}},f2_mul_result,2'b0};
assign f2_abs_sticky = |f2_abs_sticky_reg;
assign f2_sub_and_no_sticky = ~f2_abs_sticky & f2_eff_sub;
assign f2_pos_lza_result0 = {f2_ha_sum[LZA_MSB:LZA_LSB]};
assign f2_pos_lza_result1 = {f2_ha_cout[LZA_MSB - 1:LZA_LSB],1'b0};
assign f2_neg_lza_result0 = {f2_ha_sum[LZA_MSB:LZA_LSB]};
assign f2_neg_lza_result1 = {f2_ha_cout_inv[LZA_MSB - 1:LZA_LSB],1'b0};
assign f2_pos_a_string = f2_pos_lza_result1 | f2_pos_lza_result0;
assign f2_pos_p_string = f2_pos_lza_result1 ~^ f2_pos_lza_result0;
assign f2_pos_e_string = {f2_pos_p_string[LZA_MSB:(LZA_LSB + 1)] & f2_pos_a_string[(LZA_MSB - 1):LZA_LSB],1'b1};
assign f2_neg_a_string = f2_neg_lza_result1 | f2_neg_lza_result0;
assign f2_neg_p_string = f2_neg_lza_result1 ~^ f2_neg_lza_result0;
assign f2_neg_e_string = {f2_neg_p_string[LZA_MSB:(LZA_LSB + 1)] & f2_neg_a_string[(LZA_MSB - 1):LZA_LSB],1'b1};
generate
    if (FLEN == 32) begin:gen_lza_string_sp
        assign f2_pos_lza_string = ({LZA_WIDTH{f2_frd_hp}} & {f2_pos_e_string[HP_LZA_MSB:LZA_LSB],13'b0}) | ({LZA_WIDTH{f2_frd_bp}} & {f2_pos_e_string[BP_LZA_MSB:LZA_LSB],16'b0}) | ({LZA_WIDTH{f2_frd_sp}} & f2_pos_e_string);
        assign f2_neg_lza_string = ({LZA_WIDTH{f2_frd_hp}} & {f2_neg_e_string[HP_LZA_MSB:LZA_LSB],13'b0}) | ({LZA_WIDTH{f2_frd_bp}} & {f2_neg_e_string[BP_LZA_MSB:LZA_LSB],16'b0}) | ({LZA_WIDTH{f2_frd_sp}} & f2_neg_e_string);
        assign f2_pos_lzc[7] = 1'b0;
        assign f2_neg_lzc[7] = 1'b0;
        kv_lzc_encode #(
            .WIDTH(128)
        ) lzc_encode_pos (
            .lza_str({f2_pos_lza_string,{(128 - LZA_WIDTH){1'b0}}}),
            .lzc(f2_pos_lzc[6:0])
        );
        kv_lzc_encode #(
            .WIDTH(128)
        ) lzc_encode_neg (
            .lza_str({f2_neg_lza_string,{(128 - LZA_WIDTH){1'b0}}}),
            .lzc(f2_neg_lzc[6:0])
        );
    end
    else begin:gen_lza_string_hp
        assign f2_pos_lza_string = f2_pos_e_string;
        assign f2_neg_lza_string = f2_neg_e_string;
        assign f2_pos_lzc[7:6] = 2'b0;
        assign f2_neg_lzc[7:6] = 2'b0;
        kv_lzc_encode #(
            .WIDTH(64)
        ) lzc_encode_pos (
            .lza_str({f2_pos_lza_string,{(64 - LZA_WIDTH){1'b0}}}),
            .lzc(f2_pos_lzc[5:0])
        );
        kv_lzc_encode #(
            .WIDTH(64)
        ) lzc_encode_neg (
            .lza_str({f2_neg_lza_string,{(64 - LZA_WIDTH){1'b0}}}),
            .lzc(f2_neg_lzc[5:0])
        );
    end
endgenerate
assign f2_lzc = f2_complement ? f2_neg_lzc : f2_pos_lzc;
assign f2_ha_cout = (f2_mac_add_op2 & f2_mac_add_op1);
assign f2_ha_cout_inv = ~(f2_mac_add_op2 | f2_mac_add_op1);
assign f2_ha_sum = (f2_mac_add_op2 ^ f2_mac_add_op1);
wire [MAC_WIDTH - 1:0] f2_mac_added_pos_add_op3;
assign f2_mac_added_pos_add_op3 = {{(MAC_WIDTH - 1){1'b0}},f2_sub_and_no_sticky};
wire [1:0] nds_unused_f2_mac_added_pos_co;
assign {nds_unused_f2_mac_added_pos_co,f2_mac_added_pos} = f2_mac_add_op1 + f2_mac_add_op2 + f2_mac_added_pos_add_op3;
wire [MAC_MSB:MAC_LSB] f2_mac_added_neg_op2;
assign f2_mac_added_neg_op2 = {f2_ha_cout_inv[MAC_MSB - 1:MAC_LSB],f2_sub_and_no_sticky};
wire nds_unused_f2_mac_added_neg_co;
assign {nds_unused_f2_mac_added_neg_co,f2_mac_added_neg} = f2_ha_sum + f2_mac_added_neg_op2;
assign f2_complement = f2_eff_sub & ((~f2_mac_add_op1) > f2_mac_add_op2);
assign f2_nbs_sum_l0 = f2_complement ? f2_mac_added_neg : f2_mac_added_pos;
assign f2_subnorm_bound = ({10{f2_frd_hp}} & 10'd14) | ({10{f2_frd_bp}} & 10'd126) | ({10{f2_frd_sp}} & 10'd126);
wire nds_unused_f2_lzc_subnorm_pred_co;
assign {nds_unused_f2_lzc_subnorm_pred_co,f2_lzc_subnorm_pred} = f2_mac_exp + f2_subnorm_bound;
assign f2_lzc_after_subnorm_pred[7:2] = ({2'b0,f2_lzc[7:2]} > f2_lzc_subnorm_pred[9:2]) ? f2_lzc_subnorm_pred[7:2] : f2_lzc[7:2];
assign f2_lzc_sel_subnorm = {2'b0,f2_lzc} > f2_lzc_subnorm_pred;
assign f2_lzc_after_subnorm_pred[1:0] = f2_lzc_sel_subnorm ? f2_lzc_subnorm_pred[1:0] : f2_lzc[1:0];
assign f2_ovf_check_disable = f2_lzc_sel_subnorm;
generate
    if (FLEN > 16) begin:gen_f2_nbs_sum_l1_for_sp
        assign f2_nbs_sum_l1 = f2_lzc_after_subnorm_pred[6] ? {f2_nbs_sum_l0[(MAC_MSB - 64):MAC_LSB],64'b0} : f2_nbs_sum_l0;
    end
    else begin:gen_f2_nbs_sum_l1_for_hp
        assign f2_nbs_sum_l1 = f2_lzc_after_subnorm_pred[6] ? {MAC_WIDTH{1'b0}} : f2_nbs_sum_l0;
    end
endgenerate
assign f2_nbs_sum_l2 = f2_lzc_after_subnorm_pred[5] ? {f2_nbs_sum_l1[(MAC_MSB - 32):MAC_LSB],32'b0} : f2_nbs_sum_l1;
assign f2_nbs_sum_l3 = f2_lzc_after_subnorm_pred[4] ? {f2_nbs_sum_l2[(MAC_MSB - 16):MAC_LSB],16'b0} : f2_nbs_sum_l2;
assign f2_nbs_sum_l4 = f2_lzc_after_subnorm_pred[3] ? {f2_nbs_sum_l3[(MAC_MSB - 8):MAC_LSB],8'b0} : f2_nbs_sum_l3;
assign f2_nbs_sum_l5 = f2_lzc_after_subnorm_pred[2] ? {f2_nbs_sum_l4[(MAC_MSB - 4):MAC_LSB],4'b0} : f2_nbs_sum_l4;
assign f3_lzc_after_subnorm_pred_00_nx = (f2_lzc_after_subnorm_pred[1:0] == 2'b00);
assign f3_lzc_after_subnorm_pred_01_nx = (f2_lzc_after_subnorm_pred[1:0] == 2'b01);
assign f3_lzc_after_subnorm_pred_10_nx = (f2_lzc_after_subnorm_pred[1:0] == 2'b10);
assign f3_lzc_after_subnorm_pred_11_nx = (f2_lzc_after_subnorm_pred[1:0] == 2'b11);
assign f3_nbs_sum_l7 = ({MAC_WIDTH{f3_lzc_after_subnorm_pred_00}} & f3_nbs_sum_l5) | ({MAC_WIDTH{f3_lzc_after_subnorm_pred_10}} & {f3_nbs_sum_l5[(MAC_MSB - 2):MAC_LSB],2'b0}) | ({MAC_WIDTH{f3_lzc_after_subnorm_pred_01}} & {f3_nbs_sum_l5[(MAC_MSB - 1):MAC_LSB],1'b0}) | ({MAC_WIDTH{f3_lzc_after_subnorm_pred_11}} & {f3_nbs_sum_l5[(MAC_MSB - 3):MAC_LSB],3'b0});
assign f3_arith_sign_nx = f2_arith_sign ^ f2_complement;
wire [EXP_MSB:0] f3_mac_exp_nx_sub_op2;
assign f3_mac_exp_nx_sub_op2 = {2'b0,f2_lzc};
wire nds_unused_f3_mac_exp_nx_co;
assign {nds_unused_f3_mac_exp_nx_co,f3_mac_exp_nx} = f2_mac_exp - f3_mac_exp_nx_sub_op2;
assign f2_round_rne = (f2_round_mode == ROUND_RNE);
assign f2_round_rtz = (f2_round_mode == ROUND_RTZ);
assign f2_round_rdn = (f2_round_mode == ROUND_RDN);
assign f2_round_rup = (f2_round_mode == ROUND_RUP);
assign f2_round_rmm = (f2_round_mode == ROUND_RMM);
assign f2_rn = f2_round_rne | f2_round_rmm;
assign f2_ri = (~f3_arith_sign_nx & f2_round_rup) | (f3_arith_sign_nx & f2_round_rdn);
assign f2_rz = f2_round_rtz | (~f3_arith_sign_nx & f2_round_rdn) | (f3_arith_sign_nx & f2_round_rup);
assign f3_y0[MAC_MSB:113] = f3_nbs_sum_l7[MAC_MSB:113];
assign f3_y1[MAC_MSB:113] = f3_nbs_sum_l7[MAC_MSB:113] + {{(MAC_MSB - 113){1'b0}},1'b1};
assign f3_sticky = f3_abs_sticky | (|f3_nbs_sum_l7[108:MAC_LSB + 2]);
assign f3_sticky_ovf = f3_sticky | f3_nbs_sum_l7[109];
assign f3_round_digit = {(f3_sticky & f3_ri),(f3_rn | f3_ri)};
assign f3_round_digit_ovf = {(f3_sticky_ovf & f3_ri),(f3_rn | f3_ri)};
assign f3_round_ha = {(f3_round_digit[1] & f3_round_digit[0]),(f3_round_digit[1] ^ f3_round_digit[0])};
assign f3_round_ha_ovf = {(f3_round_digit_ovf[1] & f3_round_digit_ovf[0]),(f3_round_digit_ovf[1] ^ f3_round_digit_ovf[0])};
assign f3_round_no_ovf = {3'b0,f3_round_ha};
assign f3_round_with_ovf = {2'b0,f3_round_ha_ovf,1'b0};
assign f3_low_part = {1'b0,f3_nbs_sum_l7[112:109]};
wire nds_unused_f3_low_part_round_no_ovf_co;
wire nds_unused_f3_low_part_round_with_ovf_co;
assign {nds_unused_f3_low_part_round_no_ovf_co,f3_low_part_round_no_ovf} = f3_low_part[4:0] + f3_round_no_ovf[4:0];
assign {nds_unused_f3_low_part_round_with_ovf_co,f3_low_part_round_with_ovf} = f3_low_part[4:0] + f3_round_with_ovf[4:0];
assign f3_z[113:109] = f3_lza_error ? f3_low_part_round_with_ovf : f3_low_part_round_no_ovf;
assign f3_low_part_carry_to_y0 = f3_z[113];
assign f3_y[MAC_MSB:113] = f3_low_part_carry_to_y0 ? f3_y1 : f3_y0;
assign f3_frac = f3_lza_error ? {f3_y[MAC_MSB:113],f3_z[112:111]} : {f3_y[(MAC_MSB - 1):113],f3_z[112:110]};
assign f3_frac_all_zero = ~(|f3_frac_corrected[(MAC_MSB - 1):110] | f3_increase_exp);
assign f3_frd_result_zero = ~f3_frd_nan & ~f3_frd_inf & (f3_frd_zero | f3_frac_all_zero | (f3_uf_exception & ~f3_subnorm & (f3_rn | f3_rz)));
assign f3_frd_result_smallest = f3_uf_exception & ~f3_subnorm & f3_ri;
assign f3_frd_result_inf = ~f3_frd_nan & (f3_frd_inf | (f3_of_exception & (f3_rn | f3_ri)));
assign f3_frd_result_largest = f3_of_exception & f3_rz;
assign f3_uf_to_subnorm = f3_subnorm_pred & (f3_frac_corrected[(MAC_MSB - 1):111] == {(MAC_MSB - 111){1'b0}}) & f3_frac_corrected[110];
assign f3_tie_round_bit = f3_lza_error ? f3_low_part[1] : f3_low_part[0];
assign f3_tie_sticky_bit = f3_sticky | (f3_lza_error & f3_nbs_sum_l7[109]);
assign f3_tie = f3_tie_round_bit & ~f3_tie_sticky_bit;
assign f3_frac_corrected[110] = f3_frac[110] & ~(f3_tie & (f3_round_mode == ROUND_RNE));
assign f3_frac_corrected[(MAC_MSB - 1):111] = f3_frac[(MAC_MSB - 1):111];
assign f3_exp_p0_s_gt_ovf_bound = ~f3_mac_exp[9] & (f3_mac_exp[8:0] > 9'd127);
assign f3_exp_p0_s_gt_sub_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd126);
assign f3_exp_p0_s_gt_udf_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd150);
assign f3_exp_p0_h_gt_ovf_bound = ~f3_mac_exp[9] & (f3_mac_exp[8:0] > 9'd15);
assign f3_exp_p0_h_gt_sub_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd14);
assign f3_exp_p0_h_gt_udf_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd25);
assign f3_exp_p0_b_gt_ovf_bound = ~f3_mac_exp[9] & (f3_mac_exp[8:0] > 9'd127);
assign f3_exp_p0_b_gt_sub_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd126);
assign f3_exp_p0_b_gt_udf_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd134);
assign f3_exp_p1_s_gt_ovf_bound = ~f3_mac_exp[9] & (f3_mac_exp[8:0] > 9'd126);
assign f3_exp_p1_s_gt_sub_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd127);
assign f3_exp_p1_s_gt_udf_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd151);
assign f3_exp_p1_h_gt_ovf_bound = ~f3_mac_exp[9] & (f3_mac_exp[8:0] > 9'd14);
assign f3_exp_p1_h_gt_sub_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd15);
assign f3_exp_p1_h_gt_udf_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd26);
assign f3_exp_p1_b_gt_ovf_bound = ~f3_mac_exp[9] & (f3_mac_exp[8:0] > 9'd126);
assign f3_exp_p1_b_gt_sub_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd127);
assign f3_exp_p1_b_gt_udf_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd135);
assign f3_exp_s_gt_ovf_bound = f3_increase_exp ? f3_exp_p1_s_gt_ovf_bound : f3_exp_p0_s_gt_ovf_bound;
assign f3_exp_s_gt_sub_bound = f3_increase_exp ? f3_exp_p1_s_gt_sub_bound : f3_exp_p0_s_gt_sub_bound;
assign f3_exp_s_gt_udf_bound = f3_increase_exp ? f3_exp_p1_s_gt_udf_bound : f3_exp_p0_s_gt_udf_bound;
assign f3_exp_h_gt_ovf_bound = f3_increase_exp ? f3_exp_p1_h_gt_ovf_bound : f3_exp_p0_h_gt_ovf_bound;
assign f3_exp_h_gt_sub_bound = f3_increase_exp ? f3_exp_p1_h_gt_sub_bound : f3_exp_p0_h_gt_sub_bound;
assign f3_exp_h_gt_udf_bound = f3_increase_exp ? f3_exp_p1_h_gt_udf_bound : f3_exp_p0_h_gt_udf_bound;
assign f3_exp_b_gt_ovf_bound = f3_increase_exp ? f3_exp_p1_b_gt_ovf_bound : f3_exp_p0_b_gt_ovf_bound;
assign f3_exp_b_gt_sub_bound = f3_increase_exp ? f3_exp_p1_b_gt_sub_bound : f3_exp_p0_b_gt_sub_bound;
assign f3_exp_b_gt_udf_bound = f3_increase_exp ? f3_exp_p1_b_gt_udf_bound : f3_exp_p0_b_gt_udf_bound;
assign f3_sp_subnorm_pred = ~f3_exp_p0_s_gt_sub_bound & f3_exp_p1_s_gt_udf_bound;
assign f3_hp_subnorm_pred = ~f3_exp_p0_h_gt_sub_bound & f3_exp_p1_h_gt_udf_bound;
assign f3_bp_subnorm_pred = ~f3_exp_p0_b_gt_sub_bound & f3_exp_p1_b_gt_udf_bound;
assign f3_subnorm_pred = (f3_frd_hp & f3_hp_subnorm_pred & f3_valid & ~(f3_frd_inf | f3_frd_zero | f3_frd_nan)) | (f3_frd_bp & f3_bp_subnorm_pred & f3_valid & ~(f3_frd_inf | f3_frd_zero | f3_frd_nan)) | (f3_frd_sp & f3_sp_subnorm_pred & f3_valid & ~(f3_frd_inf | f3_frd_zero | f3_frd_nan));
assign f3_sp_of_exception = f3_exp_s_gt_ovf_bound;
assign f3_sp_subnorm = ~f3_exp_s_gt_sub_bound & (f3_exp_s_gt_udf_bound | f3_uf_to_subnorm);
assign f3_sp_uf_exception = ~f3_exp_s_gt_udf_bound;
assign f3_hp_of_exception = f3_exp_h_gt_ovf_bound;
assign f3_hp_subnorm = ~f3_exp_h_gt_sub_bound & (f3_exp_h_gt_udf_bound | f3_uf_to_subnorm);
assign f3_hp_uf_exception = ~f3_exp_h_gt_udf_bound;
assign f3_bp_of_exception = f3_exp_b_gt_ovf_bound;
assign f3_bp_subnorm = ~f3_exp_b_gt_sub_bound & (f3_exp_b_gt_udf_bound | f3_uf_to_subnorm);
assign f3_bp_uf_exception = ~f3_exp_b_gt_udf_bound;
assign f3_frd_special = f3_frd_inf | f3_frd_nan | f3_frd_zero;
assign f3_of_exception = (f3_frd_hp & f3_hp_of_exception & ~f3_frd_special) | (f3_frd_bp & f3_bp_of_exception & ~f3_frd_special) | (f3_frd_sp & f3_sp_of_exception & ~f3_frd_special);
assign f3_subnorm = (f3_frd_hp & f3_hp_subnorm & ~f3_frd_special) | (f3_frd_bp & f3_bp_subnorm & ~f3_frd_special) | (f3_frd_sp & f3_sp_subnorm & ~f3_frd_special);
wire [9:0] f3_adjust_exp_sel_op1;
wire [9:0] f3_adjust_exp_sel_op1_add_op1;
wire [9:0] f3_adjust_exp_sel_op1_add_op2;
assign f3_adjust_exp_sel_op1_add_op1 = f3_mac_exp;
assign f3_adjust_exp_sel_op1_add_op2 = 10'b1;
wire nds_unused_f3_adjust_exp_sel_op1_co;
assign {nds_unused_f3_adjust_exp_sel_op1_co,f3_adjust_exp_sel_op1} = f3_adjust_exp_sel_op1_add_op1 + f3_adjust_exp_sel_op1_add_op2;
assign f3_adjust_exp = f3_lza_error ? f3_adjust_exp_sel_op1 : f3_mac_exp;
wire [9:0] f3_subnorm_amount_sub_op1;
wire [9:0] f3_subnorm_amount_sub_op2;
assign f3_subnorm_amount_sub_op1 = ~f3_adjust_exp;
assign f3_subnorm_amount_sub_op2 = ({10{f3_frd_hp}} & 10'd13) | ({10{f3_frd_bp}} & 10'd125) | ({10{f3_frd_sp}} & 10'd125);
wire nds_unused_f3_subnorm_amount_co;
assign {nds_unused_f3_subnorm_amount_co,f3_subnorm_amount} = f3_subnorm_amount_sub_op1 - f3_subnorm_amount_sub_op2;
assign f3_subnorm_set_uf_cond1 = f3_subnorm_uf_cond1 & ~(f3_round_ha[1] | (f3_round_ha[0] & f3_nbs_sum_l7[108]));
assign f3_subnorm_set_uf_cond2 = f3_subnorm_uf_cond2 & (f3_tie_sticky_bit | f3_tie_round_bit) & (f3_ri & ~f3_rn);
assign f3_subnorm_set_uf = (f3_subnorm_amount == 10'b1) & (f3_subnorm_set_uf_cond1 | f3_subnorm_set_uf_cond2);
wire f3_uf_exception_cond1;
wire f3_uf_exception_cond2;
wire f3_uf_exception_raw;
assign f3_uf_exception_cond1 = f3_subnorm & (f3_tie_round_bit | f3_tie_sticky_bit) & (~f3_subnorm_to_normal | f3_subnorm_set_uf);
assign f3_uf_exception_cond2 = f3_uf_exception_raw & ~f3_nv_exception & ~f3_frd_special & ~(f3_frac_all_zero & ~f3_tie_round_bit & ~f3_tie_sticky_bit);
assign f3_uf_exception_raw = (f3_frd_hp & f3_hp_uf_exception) | (f3_frd_bp & f3_bp_uf_exception) | (f3_frd_sp & f3_sp_uf_exception);
assign f3_uf_exception = f3_uf_exception_cond1 | f3_uf_exception_cond2;
assign f3_nx_exception = ~(f3_frd_nan | f3_frd_zero) & ((f3_tie_round_bit | f3_tie_sticky_bit) & ~(f3_nv_exception | f3_frd_inf) | f3_of_exception | f3_uf_exception);
assign f3_zero_sign = (f3_frac_all_zero & ~f3_tie_round_bit & ~f3_tie_sticky_bit & ~f3_frd_zero) ? (f3_round_mode == ROUND_RDN) : f3_arith_sign;
assign f3_frd_nan_hp = f3_frd_hp & f3_frd_nan;
assign f3_frd_nan_bp = f3_frd_bp & f3_frd_nan;
assign f3_frd_nan_sp = f3_frd_sp & f3_frd_nan;
assign f3_frd_result_inf_hp = f3_frd_hp & f3_frd_result_inf;
assign f3_frd_result_inf_bp = f3_frd_bp & f3_frd_result_inf;
assign f3_frd_result_inf_sp = f3_frd_sp & f3_frd_result_inf;
assign f3_frd_result_zero_hp = f3_frd_hp & f3_frd_result_zero;
assign f3_frd_result_zero_bp = f3_frd_bp & f3_frd_result_zero;
assign f3_frd_result_zero_sp = f3_frd_sp & f3_frd_result_zero;
assign f3_frd_result_largest_hp = f3_frd_hp & f3_frd_result_largest;
assign f3_frd_result_largest_bp = f3_frd_bp & f3_frd_result_largest;
assign f3_frd_result_largest_sp = f3_frd_sp & f3_frd_result_largest;
assign f3_frd_result_smallest_hp = f3_frd_hp & f3_frd_result_smallest;
assign f3_frd_result_smallest_bp = f3_frd_bp & f3_frd_result_smallest;
assign f3_frd_result_smallest_sp = f3_frd_sp & f3_frd_result_smallest;
assign f3_non_arith_wdata = ({32{f3_frd_nan_hp}} & {16'hffff,1'b0,5'h1f,10'h200}) | ({32{f3_frd_nan_bp}} & {16'hffff,1'b0,8'hff,7'h40}) | ({32{f3_frd_nan_sp}} & {1'b0,8'hff,23'h400000}) | ({32{f3_frd_result_inf_hp}} & {16'hffff,f3_arith_sign,5'h1f,10'h0}) | ({32{f3_frd_result_inf_bp}} & {16'hffff,f3_arith_sign,8'hff,7'h0}) | ({32{f3_frd_result_inf_sp}} & {f3_arith_sign,8'hff,23'h0}) | ({32{f3_frd_result_zero_hp}} & {16'hffff,f3_zero_sign,5'h00,10'h0}) | ({32{f3_frd_result_zero_bp}} & {16'hffff,f3_zero_sign,8'h00,7'h0}) | ({32{f3_frd_result_zero_sp}} & {f3_zero_sign,8'h00,23'h0}) | ({32{f3_frd_result_largest_hp}} & {16'hffff,f3_arith_sign,5'h1e,10'h3ff}) | ({32{f3_frd_result_largest_bp}} & {16'hffff,f3_arith_sign,8'hfe,7'h7f}) | ({32{f3_frd_result_largest_sp}} & {f3_arith_sign,8'hfe,23'h7fffff}) | ({32{f3_frd_result_smallest_hp}} & {16'hffff,f3_arith_sign,5'h00,10'h1}) | ({32{f3_frd_result_smallest_bp}} & {16'hffff,f3_arith_sign,8'h00,7'h1}) | ({32{f3_frd_result_smallest_sp}} & {f3_arith_sign,8'h00,23'h1});
assign f3_non_arith_wdata_en = f3_frd_result_inf | f3_frd_result_zero | f3_frd_nan | f3_frd_result_largest | f3_frd_result_smallest;
assign f3_flag_set = {5{f3_valid}} & {f3_nv_exception,1'b0,f3_of_exception,f3_uf_exception,f3_nx_exception};
assign f3_wdata = f3_non_arith_wdata_en ? {32'hffffffff,f3_non_arith_wdata} : {32'hffffffff,f3_arith_wdata};
assign f3_wdata_en = f3_valid;
assign f3_result_type = f3_frd_hp | f3_frd_bp ? 2'b01 : 2'b10;
generate
    if (FLEN == 32) begin:gen_fpu_sp
        wire f3_lza_error_bit;
        wire f3_low_part_all_1;
        assign f3_lza_error_bit = (f3_frd_hp & f3_y0[121]) | (f3_frd_bp & f3_y0[118]) | (f3_frd_sp & f3_y0[134]);
        assign f3_low_part_all_1 = (f3_frd_hp & (&f3_y0[120:113])) | (f3_frd_bp & (&f3_y0[117:113])) | (f3_frd_sp & (&f3_y0[133:113]));
        assign f3_lza_error = f3_lza_error_bit & ~f3_ovf_check_disable;
        assign f3_increase_exp = f3_lza_error | (f3_low_part_carry_to_y0 & f3_low_part_all_1);
        assign f3_subnorm_to_normal = (f3_frd_hp & f3_frac[120]) | (f3_frd_bp & f3_frac[117]) | (f3_frd_sp & f3_frac[133]);
        wire [9:0] f3_adjust_exp_bias_sel1;
        wire [9:0] f3_adjust_exp_bias_sel2;
        wire [9:0] f3_adjust_exp_bias_sel2_add1;
        wire [9:0] f3_adjust_exp_bias_sel2_add2;
        wire nds_unused_f3_adjust_exp_bias_sel2_add2_co;
        wire [9:0] f3_exp_bias;
        assign f3_exp_bias = ({10{f3_frd_hp}} & 10'd15) | ({10{f3_frd_bp}} & 10'd127) | ({10{f3_frd_sp}} & 10'd127);
        assign f3_adjust_exp_bias_sel1 = {9'b0,f3_subnorm_to_normal};
        assign f3_adjust_exp_bias_sel2_add1 = f3_mac_exp;
        assign {nds_unused_f3_adjust_exp_bias_sel2_add2_co,f3_adjust_exp_bias_sel2_add2} = f3_exp_bias + {9'b0,f3_increase_exp};
        wire nds_unused_f3_adjust_exp_bias_sel2_co;
        assign {nds_unused_f3_adjust_exp_bias_sel2_co,f3_adjust_exp_bias_sel2} = f3_adjust_exp_bias_sel2_add1 + f3_adjust_exp_bias_sel2_add2;
        assign f3_adjust_exp_bias = f3_subnorm ? f3_adjust_exp_bias_sel1 : f3_adjust_exp_bias_sel2;
        assign f3_arith_wdata = ({32{f3_frd_hp}} & {16'hffff,f3_arith_sign,f3_adjust_exp_bias[4:0],f3_frac_corrected[119:110]}) | ({32{f3_frd_bp}} & {16'hffff,f3_arith_sign,f3_adjust_exp_bias[7:0],f3_frac_corrected[116:110]}) | ({32{f3_frd_sp}} & {f3_arith_sign,f3_adjust_exp_bias[7:0],f3_frac_corrected[132:110]});
        assign f3_subnorm_uf_cond1 = (f3_frd_hp & (f3_nbs_sum_l7[119:109] == 11'h7ff)) | (f3_frd_bp & (f3_nbs_sum_l7[116:109] == 8'hff)) | (f3_frd_sp & (f3_nbs_sum_l7[132:109] == 24'hffffff));
        assign f3_subnorm_uf_cond2 = (f3_frd_hp & (f3_nbs_sum_l7[119:109] == 11'h7fe)) | (f3_frd_bp & (f3_nbs_sum_l7[116:109] == 8'hfe)) | (f3_frd_sp & (f3_nbs_sum_l7[132:109] == 24'hfffffe));
    end
    else begin:gen_fpu_hp
        wire f3_lza_error_bit;
        wire f3_low_part_all_1;
        assign f3_lza_error_bit = (f3_frd_hp & f3_y0[121]) | (f3_frd_bp & f3_y0[118]);
        assign f3_low_part_all_1 = (f3_frd_hp & (&f3_y0[120:113])) | (f3_frd_bp & (&f3_y0[117:113]));
        assign f3_lza_error = f3_lza_error_bit & ~f3_ovf_check_disable;
        assign f3_increase_exp = f3_lza_error | (f3_low_part_carry_to_y0 & f3_low_part_all_1);
        assign f3_subnorm_to_normal = (f3_frd_hp & f3_frac[120]) | (f3_frd_bp & f3_frac[117]);
        wire [9:0] f3_adjust_exp_bias_sel1;
        wire [9:0] f3_adjust_exp_bias_sel2;
        wire [9:0] f3_adjust_exp_bias_sel2_add1;
        wire [9:0] f3_adjust_exp_bias_sel2_add2;
        wire [9:0] f3_exp_bias;
        assign f3_exp_bias = ({10{f3_frd_hp}} & 10'd15) | ({10{f3_frd_bp}} & 10'd127);
        assign f3_adjust_exp_bias_sel1 = {9'b0,f3_subnorm_to_normal};
        assign f3_adjust_exp_bias_sel2_add1 = f3_mac_exp;
        assign f3_adjust_exp_bias_sel2_add2 = f3_exp_bias + {9'b0,f3_increase_exp};
        wire nds_unused_f3_adjust_exp_bias_sel2_co;
        assign {nds_unused_f3_adjust_exp_bias_sel2_co,f3_adjust_exp_bias_sel2} = f3_adjust_exp_bias_sel2_add1 + f3_adjust_exp_bias_sel2_add2;
        assign f3_adjust_exp_bias = f3_subnorm ? f3_adjust_exp_bias_sel1 : f3_adjust_exp_bias_sel2;
        assign f3_arith_wdata = ({32{f3_frd_hp}} & {16'hffff,f3_arith_sign,f3_adjust_exp_bias[4:0],f3_frac_corrected[119:110]}) | ({32{f3_frd_bp}} & {16'hffff,f3_arith_sign,f3_adjust_exp_bias[7:0],f3_frac_corrected[116:110]});
        assign f3_subnorm_uf_cond1 = (f3_frd_hp & (f3_nbs_sum_l7[119:109] == 11'h7ff)) | (f3_frd_bp & (f3_nbs_sum_l7[116:109] == 8'hff));
        assign f3_subnorm_uf_cond2 = (f3_frd_hp & (f3_nbs_sum_l7[119:109] == 11'h7fe)) | (f3_frd_bp & (f3_nbs_sum_l7[116:109] == 8'hfe));
    end
endgenerate
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        f2_valid <= 1'b0;
        f3_valid <= 1'b0;
    end
    else if (~fpipe_stall) begin
        f2_valid <= f1_valid;
        f3_valid <= f2_valid;
    end
end

assign f2_pipe_en = f1_valid & ~fpipe_stall;
generate
    if (FLEN >= 32) begin:gen_frd_type_F32
        reg f2_frd_hp_r;
        reg f3_frd_hp_r;
        reg f2_frd_bp_r;
        reg f3_frd_bp_r;
        reg f2_frd_sp_r;
        reg f3_frd_sp_r;
        always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                f2_frd_hp_r <= 1'b0;
                f2_frd_bp_r <= 1'b0;
                f2_frd_sp_r <= 1'b0;
            end
            else if (f2_pipe_en) begin
                f2_frd_hp_r <= f1_frd_hp;
                f2_frd_bp_r <= f1_frd_bp;
                f2_frd_sp_r <= f1_frd_sp;
            end
        end

        always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                f3_frd_hp_r <= 1'b0;
                f3_frd_bp_r <= 1'b0;
                f3_frd_sp_r <= 1'b0;
            end
            else if (f3_pipe_en) begin
                f3_frd_hp_r <= f2_frd_hp;
                f3_frd_bp_r <= f2_frd_bp;
                f3_frd_sp_r <= f2_frd_sp;
            end
        end

        assign f2_frd_hp = f2_frd_hp_r;
        assign f2_frd_bp = f2_frd_bp_r;
        assign f2_frd_sp = f2_frd_sp_r;
        assign f3_frd_hp = f3_frd_hp_r;
        assign f3_frd_bp = f3_frd_bp_r;
        assign f3_frd_sp = f3_frd_sp_r;
    end
    else begin:gen_frd_type_F16
        reg f2_frd_hp_r;
        reg f3_frd_hp_r;
        reg f2_frd_bp_r;
        reg f3_frd_bp_r;
        always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                f2_frd_hp_r <= 1'b0;
                f2_frd_bp_r <= 1'b0;
            end
            else if (f2_pipe_en) begin
                f2_frd_hp_r <= f1_frd_hp;
                f2_frd_bp_r <= f1_frd_bp;
            end
        end

        always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                f3_frd_hp_r <= 1'b0;
                f3_frd_bp_r <= 1'b0;
            end
            else if (f3_pipe_en) begin
                f3_frd_hp_r <= f2_frd_hp;
                f3_frd_bp_r <= f2_frd_bp;
            end
        end

        assign f2_frd_hp = f2_frd_hp_r;
        assign f2_frd_bp = f2_frd_bp_r;
        assign f3_frd_hp = f3_frd_hp_r;
        assign f3_frd_bp = f3_frd_bp_r;
        assign f2_frd_sp = 1'b0;
        assign f3_frd_sp = 1'b0;
    end
endgenerate
always @(posedge vpu_vmac_clk) begin
    if (f2_pipe_en) begin
        f2_frd_inf <= f1_frd_inf;
        f2_frd_zero <= f1_frd_zero;
        f2_frd_nan <= f1_frd_nan;
        f2_eff_sub <= f2_eff_sub_nx;
        f2_arith_sign <= f1_arith_sign;
        f2_mac_exp_op1 <= f2_mac_exp_op1_nx;
        f2_mac_exp_op2 <= f2_mac_exp_op2_nx;
        f2_round_mode <= f1_round_mode;
        f2_nv_exception <= f1_nv_exception;
        f2_abs_sticky_reg <= f2_abs_sticky_nx;
        f2_abs_final_out <= f1_abs_final_out;
        f2_mul_result <= f2_mul_result_nx;
    end
end

assign f3_pipe_en = f2_valid & ~fpipe_stall;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        f3_frd_inf <= 1'b0;
        f3_frd_zero <= 1'b0;
        f3_frd_nan <= 1'b0;
        f3_abs_sticky <= 1'b0;
        f3_arith_sign <= 1'b0;
        f3_mac_exp <= 10'b0;
        f3_round_mode <= 3'b0;
        f3_nv_exception <= 1'b0;
        f3_nbs_sum_l5 <= {MAC_WIDTH{1'b0}};
        f3_ovf_check_disable <= 1'b0;
        f3_lzc_after_subnorm_pred_00 <= 1'b0;
        f3_lzc_after_subnorm_pred_01 <= 1'b0;
        f3_lzc_after_subnorm_pred_10 <= 1'b0;
        f3_lzc_after_subnorm_pred_11 <= 1'b0;
        f3_ri <= 1'b0;
        f3_rn <= 1'b0;
        f3_rz <= 1'b0;
    end
    else if (f3_pipe_en) begin
        f3_lzc_after_subnorm_pred_00 <= f3_lzc_after_subnorm_pred_00_nx;
        f3_lzc_after_subnorm_pred_01 <= f3_lzc_after_subnorm_pred_01_nx;
        f3_lzc_after_subnorm_pred_10 <= f3_lzc_after_subnorm_pred_10_nx;
        f3_lzc_after_subnorm_pred_11 <= f3_lzc_after_subnorm_pred_11_nx;
        f3_frd_inf <= f2_frd_inf;
        f3_frd_zero <= f2_frd_zero;
        f3_frd_nan <= f2_frd_nan;
        f3_abs_sticky <= f2_abs_sticky;
        f3_arith_sign <= f3_arith_sign_nx;
        f3_mac_exp <= f3_mac_exp_nx;
        f3_round_mode <= f2_round_mode;
        f3_nv_exception <= f2_nv_exception;
        f3_nbs_sum_l5 <= f2_nbs_sum_l5;
        f3_ovf_check_disable <= f2_ovf_check_disable;
        f3_ri <= f2_ri;
        f3_rn <= f2_rn;
        f3_rz <= f2_rz;
    end
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

