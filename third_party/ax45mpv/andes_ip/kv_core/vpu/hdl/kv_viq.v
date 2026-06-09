// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_viq (
    vpu_clk,
    vpu_reset_n,
    vpu_req_valid,
    vpu_req_vtype,
    vpu_req_fp_mode,
    vpu_req_cmr_ctl,
    vpu_req_vstart,
    vpu_req_vl,
    vpu_req_frm,
    vpu_req_vxrm,
    vpu_req_ls_privilege,
    vpu_req_c2nc,
    vpu_req_milmb_ien,
    vpu_req_mdlmb_den,
    vpu_req_mstatus_mxr,
    vpu_req_mstatus_sum,
    vpu_req_translate_en,
    vpu_req_satp_mode,
    vpu_req_i0_ctrl,
    vpu_req_i0_instr,
    vpu_req_i0_op1,
    vpu_req_i0_op2,
    vpu_req_i1_ctrl,
    vpu_req_i1_instr,
    vpu_req_i1_op1,
    vpu_req_i1_op2,
    vpu_credit,
    viq_standby_ready,
    vpu_req_i0_fu,
    vpu_req_i1_fu,
    vpu_req_i0_srf,
    vpu_req_i1_srf,
    viq_i0_valid,
    viq_i0_ready,
    viq_i0_ctrl,
    viq_i0_instr,
    viq_i0_op1,
    viq_i0_op2,
    viq_i1_valid,
    viq_i1_ready,
    viq_i1_ctrl,
    viq_i1_instr,
    viq_i1_op1,
    viq_i1_op2
);
parameter VMAC2_TYPE = 0;
localparam XLEN = 64;
localparam DEPTH = 6;
localparam DW = 81 + 32 + XLEN + XLEN;
input vpu_clk;
input vpu_reset_n;
input [1:0] vpu_req_valid;
input [7:0] vpu_req_vtype;
input [1:0] vpu_req_fp_mode;
input [1:0] vpu_req_cmr_ctl;
input [9:0] vpu_req_vstart;
input [10:0] vpu_req_vl;
input [2:0] vpu_req_frm;
input [1:0] vpu_req_vxrm;
input [1:0] vpu_req_ls_privilege;
input vpu_req_c2nc;
input vpu_req_milmb_ien;
input vpu_req_mdlmb_den;
input vpu_req_mstatus_mxr;
input vpu_req_mstatus_sum;
input vpu_req_translate_en;
input [3:0] vpu_req_satp_mode;
input [(32 - 1):0] vpu_req_i0_ctrl;
input [31:0] vpu_req_i0_instr;
input [(XLEN - 1):0] vpu_req_i0_op1;
input [(XLEN - 1):0] vpu_req_i0_op2;
input [(32 - 1):0] vpu_req_i1_ctrl;
input [31:0] vpu_req_i1_instr;
input [(XLEN - 1):0] vpu_req_i1_op1;
input [(XLEN - 1):0] vpu_req_i1_op2;
output [3:0] vpu_credit;
output [11 - 1:0] viq_standby_ready;
output [11 - 1:0] vpu_req_i0_fu;
output [11 - 1:0] vpu_req_i1_fu;
output vpu_req_i0_srf;
output vpu_req_i1_srf;
output viq_i0_valid;
input viq_i0_ready;
output [(81 - 1):0] viq_i0_ctrl;
output [31:0] viq_i0_instr;
output [(XLEN - 1):0] viq_i0_op1;
output [(XLEN - 1):0] viq_i0_op2;
output viq_i1_valid;
input viq_i1_ready;
output [(81 - 1):0] viq_i1_ctrl;
output [31:0] viq_i1_instr;
output [(XLEN - 1):0] viq_i1_op1;
output [(XLEN - 1):0] viq_i1_op2;





// 2ec455c4 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0 = 1'b0;
wire s1 = 1'b0;
wire [31:0] s2 = 32'b0;
wire [31:0] s3 = 32'b0;
wire [10:0] s4 = 11'b0;
wire [10:0] s5 = 11'b0;
wire [15:0] s6 = 16'b0;
wire [15:0] s7 = 16'b0;
wire [10:0] s8;
wire [10:0] s9;
wire [31:0] s10;
wire [31:0] s11;
assign s8 = (~s0) ? vpu_req_i0_ctrl[10:0] : s4;
assign s9 = (~s1) ? vpu_req_i1_ctrl[10:0] : s5;
assign s10 = (~s0) ? vpu_req_i0_ctrl : {s6,16'b0};
assign s11 = (~s1) ? vpu_req_i1_ctrl : {s7,16'b0};
wire s12 = vpu_req_valid[0];
wire [31:0] s13 = (~s0) ? vpu_req_i0_instr : s2;
wire [XLEN - 1:0] s14 = vpu_req_i0_op1;
wire [XLEN - 1:0] s15 = vpu_req_i0_op2;
wire [81 - 1:0] s16;
wire s17 = vpu_req_valid[1];
wire [31:0] s18 = (~s1) ? vpu_req_i1_instr : s3;
wire [XLEN - 1:0] s19 = vpu_req_i1_op1;
wire [XLEN - 1:0] s20 = vpu_req_i1_op2;
wire [81 - 1:0] s21;
wire s22 = s8[6];
wire s23 = s8[4];
wire s24 = s9[6];
wire s25 = s9[4];
wire [DW - 1:0] s26;
wire [DW - 1:0] s27;
wire [1:0] s28;
wire [DW - 1:0] s29;
wire [DW - 1:0] s30;
wire [1:0] s31;
wire [DW - 1:0] s32;
wire [DW - 1:0] s33;
wire [1:0] s34;
wire [1:0] s35 = s31 & s34;
reg [DEPTH - 1:0] s36;
wire [DEPTH - 1:0] s37;
wire s38;
wire [DEPTH - 1:0] s39 = {s36[DEPTH - 2:0],s36[DEPTH - 1]};
wire [DEPTH - 1:0] s40 = {s36[DEPTH - 3:0],s36[DEPTH - 1:DEPTH - 2]};
reg [DEPTH - 1:0] s41;
wire [DEPTH - 1:0] s42;
wire s43;
wire [DEPTH - 1:0] s44 = {s41[DEPTH - 2:0],s41[DEPTH - 1]};
wire [DEPTH - 1:0] s45 = {s41[DEPTH - 3:0],s41[DEPTH - 1:DEPTH - 2]};
reg [DEPTH - 1:0] s46;
wire [DEPTH - 1:0] s47;
wire s48;
wire [DEPTH + 1:0] s49;
wire [DEPTH * DW - 1:0] s50;
wire [DW - 1:0] s51;
wire [DW - 1:0] s52;
wire [1:0] s53;
wire s54;
wire req_i0_fu_vmac2;
wire s55;
wire req_i1_fu_vmac2;
wire [DEPTH - 1:0] s56;
wire [DEPTH - 1:0] s57;
wire [DEPTH * 2 - 1:0] s58 = {s57,s57};
wire [DEPTH - 1:0] s59;
generate
    genvar k;
    for (k = 0; k < DEPTH - 1; k = k + 1) begin:gen_viq_valid_wires
        assign s59[k] = ^s46[k +:1];
        assign s57[k] = s41[DEPTH - 1 - k];
    end
endgenerate
assign s59[DEPTH - 1] = s46[DEPTH - 1];
assign s57[DEPTH - 1] = s41[0];
generate
    genvar l;
    for (l = 0; l < DEPTH; l = l + 1) begin:gen_viq_valid
        assign s56[l] = |(s58[(DEPTH - 1 - l) +:DEPTH] & s59);
    end
endgenerate
assign vpu_req_i0_fu[0] = s8[1];
assign vpu_req_i0_fu[1] = s8[7];
assign vpu_req_i0_fu[2] = s8[10];
assign vpu_req_i0_fu[3] = s54;
assign vpu_req_i0_fu[10] = req_i0_fu_vmac2;
assign vpu_req_i0_fu[4] = s8[2];
assign vpu_req_i0_fu[5] = s8[5];
assign vpu_req_i0_fu[6] = s8[9];
assign vpu_req_i0_fu[7] = s8[3];
assign vpu_req_i0_fu[8] = s8[8];
assign vpu_req_i0_fu[9] = s8[0];
assign vpu_req_i1_fu[0] = s9[1];
assign vpu_req_i1_fu[1] = s9[7];
assign vpu_req_i1_fu[2] = s9[10];
assign vpu_req_i1_fu[3] = s55;
assign vpu_req_i1_fu[10] = req_i1_fu_vmac2;
assign vpu_req_i1_fu[4] = s9[2];
assign vpu_req_i1_fu[5] = s9[5];
assign vpu_req_i1_fu[6] = s9[9];
assign vpu_req_i1_fu[7] = s9[3];
assign vpu_req_i1_fu[8] = s9[8];
assign vpu_req_i1_fu[9] = s9[0];
generate
    if (VMAC2_TYPE != 0) begin:gen_vmac2_arb
        reg s60;
        wire s61;
        wire s62;
        wire s63;
        wire s64;
        wire s65;
        always @(posedge vpu_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s60 <= 1'b0;
            end
            else if (s61) begin
                s60 <= ~s60;
            end
        end

        assign s62 = s22 | s23;
        assign s63 = s24 | s25;
        assign s64 = (VMAC2_TYPE == 1) ? s23 : (VMAC2_TYPE == 2) ? s22 : s62;
        assign s65 = (VMAC2_TYPE == 1) ? s25 : (VMAC2_TYPE == 2) ? s24 : s63;
        assign req_i0_fu_vmac2 = s64 & s60;
        assign req_i1_fu_vmac2 = s65 & (s60 ^ (s12 & s64));
        assign s54 = s62 & ~req_i0_fu_vmac2;
        assign s55 = s63 & ~req_i1_fu_vmac2;
        assign s61 = (s12 & s64) ^ (s17 & s65);
    end
    else begin:gen_vmac2_arb
        assign s54 = s22 | s23;
        assign s55 = s24 | s25;
        assign req_i0_fu_vmac2 = 1'b0;
        assign req_i1_fu_vmac2 = 1'b0;
    end
endgenerate
assign vpu_req_i0_srf = vpu_req_i0_ctrl[12];
assign vpu_req_i1_srf = vpu_req_i1_ctrl[12];
assign s16[37] = s10[19];
assign s16[52] = s10[23];
assign s16[56] = s10[27];
assign s16[60] = s10[31];
assign s16[49 +:3] = s10[20 +:3];
assign s16[53 +:3] = s10[24 +:3];
assign s16[57 +:3] = s10[28 +:3];
assign s16[34 +:3] = s10[16 +:3];
assign s21[37] = s11[19];
assign s21[52] = s11[23];
assign s21[56] = s11[27];
assign s21[60] = s11[31];
assign s21[49 +:3] = s11[20 +:3];
assign s21[53 +:3] = s11[24 +:3];
assign s21[57 +:3] = s11[28 +:3];
assign s21[34 +:3] = s11[16 +:3];
assign s16[31] = vpu_req_i0_ctrl[13];
assign s16[32] = vpu_req_i0_ctrl[14];
assign s16[33] = vpu_req_i0_ctrl[15];
assign s16[25] = vpu_req_i0_ctrl[11];
assign s21[31] = vpu_req_i1_ctrl[13];
assign s21[32] = vpu_req_i1_ctrl[14];
assign s21[33] = vpu_req_i1_ctrl[15];
assign s21[25] = vpu_req_i1_ctrl[11];
assign s16[13] = vpu_req_i0_fu[1];
assign s16[18] = vpu_req_i0_fu[2];
assign s16[9] = vpu_req_i0_fu[0];
assign s16[14] = vpu_req_i0_fu[3];
assign s16[15] = vpu_req_i0_fu[10];
assign s16[10] = vpu_req_i0_fu[4];
assign s16[12] = vpu_req_i0_fu[5];
assign s16[17] = vpu_req_i0_fu[6];
assign s16[11] = vpu_req_i0_fu[7];
assign s16[16] = vpu_req_i0_fu[8];
assign s16[8] = vpu_req_i0_fu[9];
assign s21[13] = vpu_req_i1_fu[1];
assign s21[18] = vpu_req_i1_fu[2];
assign s21[9] = vpu_req_i1_fu[0];
assign s21[14] = vpu_req_i1_fu[3];
assign s21[15] = vpu_req_i1_fu[10];
assign s21[10] = vpu_req_i1_fu[4];
assign s21[12] = vpu_req_i1_fu[5];
assign s21[17] = vpu_req_i1_fu[6];
assign s21[11] = vpu_req_i1_fu[7];
assign s21[16] = vpu_req_i1_fu[8];
assign s21[8] = vpu_req_i1_fu[9];
assign s16[71 +:8] = vpu_req_vtype;
assign s16[3 +:2] = vpu_req_fp_mode;
assign s16[1 +:2] = vpu_req_cmr_ctl;
assign s16[61 +:10] = vpu_req_vstart;
assign s16[38 +:11] = vpu_req_vl;
assign s16[5 +:3] = vpu_req_frm;
assign s16[79 +:2] = vpu_req_vxrm;
assign s16[19 +:2] = vpu_req_ls_privilege;
assign s16[0] = vpu_req_c2nc;
assign s16[22] = vpu_req_milmb_ien;
assign s16[21] = vpu_req_mdlmb_den;
assign s16[23] = vpu_req_mstatus_mxr;
assign s16[24] = vpu_req_mstatus_sum;
assign s16[30] = vpu_req_translate_en;
assign s16[26 +:4] = vpu_req_satp_mode;
assign s21[71 +:8] = vpu_req_vtype;
assign s21[3 +:2] = vpu_req_fp_mode;
assign s21[1 +:2] = vpu_req_cmr_ctl;
assign s21[61 +:10] = vpu_req_vstart;
assign s21[38 +:11] = vpu_req_vl;
assign s21[5 +:3] = vpu_req_frm;
assign s21[79 +:2] = vpu_req_vxrm;
assign s21[19 +:2] = vpu_req_ls_privilege;
assign s21[0] = vpu_req_c2nc;
assign s21[22] = vpu_req_milmb_ien;
assign s21[21] = vpu_req_mdlmb_den;
assign s21[23] = vpu_req_mstatus_mxr;
assign s21[24] = vpu_req_mstatus_sum;
assign s21[30] = vpu_req_translate_en;
assign s21[26 +:4] = vpu_req_satp_mode;
assign s26 = {s15,s14,s16,s13};
assign s27 = {s20,s19,s21,s18};
assign s28[0] = s12 | s17;
assign s28[1] = s12 & s17;
assign s29 = s12 ? s26 : s27;
assign s30 = s27;
assign vpu_credit = s46[DEPTH - 1:DEPTH - 4];
wire [DEPTH - 1:0] s66;
wire [DEPTH - 1:0] s67;
wire [DEPTH - 1:0] s68;
wire [DEPTH - 1:0] s69;
wire [DEPTH - 1:0] s70;
wire [DEPTH - 1:0] s71;
wire [DEPTH - 1:0] s72;
wire [DEPTH - 1:0] s73;
wire [DEPTH - 1:0] s74;
wire [DEPTH - 1:0] s75;
wire [DEPTH - 1:0] s76;
generate
    genvar j;
    for (j = 0; j < DEPTH; j = j + 1) begin:gen_ent_fu
        assign s66[j] = s50[j * DW + 32 + 13];
        assign s67[j] = s50[j * DW + 32 + 18];
        assign s68[j] = s50[j * DW + 32 + 9];
        assign s69[j] = s50[j * DW + 32 + 10];
        assign s70[j] = s50[j * DW + 32 + 12];
        assign s71[j] = s50[j * DW + 32 + 17];
        assign s72[j] = s50[j * DW + 32 + 11];
        assign s73[j] = s50[j * DW + 32 + 16];
        assign s74[j] = s50[j * DW + 32 + 8];
        assign s75[j] = s50[j * DW + 32 + 14];
        assign s76[j] = s50[j * DW + 32 + 15];
    end
endgenerate
assign viq_standby_ready[6] = (~|(s56 & s66)) & ~(s12 & s8[7]) & ~(s17 & s9[7]);
assign viq_standby_ready[10] = (~|(s56 & s67)) & ~(s12 & s8[10]) & ~(s17 & s9[10]);
assign viq_standby_ready[2] = (~|(s56 & s68)) & ~(s12 & s8[1]) & ~(s17 & s9[1]);
assign viq_standby_ready[3] = (~|(s56 & s69)) & ~(s12 & s8[2]) & ~(s17 & s9[2]);
assign viq_standby_ready[5] = (~|(s56 & s70)) & ~(s12 & s8[5]) & ~(s17 & s9[5]);
assign viq_standby_ready[9] = (~|(s56 & s71)) & ~(s12 & s8[9]) & ~(s17 & s9[9]);
assign viq_standby_ready[4] = (~|(s56 & s72)) & ~(s12 & s8[3]) & ~(s17 & s9[3]);
assign viq_standby_ready[8] = (~|(s56 & s73)) & ~(s12 & s8[8]) & ~(s17 & s9[8]);
assign viq_standby_ready[1] = (~|(s56 & s74)) & ~(s12 & s8[0]) & ~(s17 & s9[0]);
assign viq_standby_ready[7] = (~|(s56 & s75)) & (~|(s56 & s76)) & ~(s12 & s8[4]) & ~(s12 & s8[6]) & ~(s17 & s9[4]) & ~(s17 & s9[6]);
assign viq_standby_ready[0] = ~|s46 & ~s12 & ~s17;
always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s46 <= {DEPTH{1'b0}};
    end
    else if (s48) begin
        s46 <= s47;
    end
end

always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s36 <= {{(DEPTH - 1){1'b0}},1'b1};
    end
    else if (s38) begin
        s36 <= s37;
    end
end

always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s41 <= {{(DEPTH - 1){1'b0}},1'b1};
    end
    else if (s43) begin
        s41 <= s42;
    end
end

assign s47 = s35[1] ? s49[DEPTH + 1:2] : s35[0] ? s49[DEPTH:1] : s49[DEPTH - 1:0];
assign s49 = s28[1] ? {s46[DEPTH - 1:0],2'd3} : s28[0] ? {1'b0,s46[DEPTH - 1:0],1'd1} : {2'b0,s46[DEPTH - 1:0]};
assign s48 = s35[0] | s28[0];
assign s38 = s28[0];
assign s37 = s28[1] ? s40 : s39;
assign s43 = s35[0];
assign s42 = s35[1] ? s45 : s44;
generate
    genvar i;
    for (i = 0; i < DEPTH; i = i + 1) begin:gen_ent
        reg [DW - 1:0] s77;
        wire s78;
        wire [DW - 1:0] s79;
        always @(posedge vpu_clk) begin
            if (s78) begin
                s77 <= s79;
            end
        end

        assign s78 = (s53[0] & s36[i]) | (s53[1] & s39[i]);
        assign s79 = s36[i] ? s29 : s30;
        assign s50[i * DW +:DW] = s77;
    end
endgenerate
kv_mux_onehot #(
    .N(DEPTH),
    .W(DW)
) u_viq_rdata0 (
    .out(s51),
    .sel(s41),
    .in(s50)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(DW)
) u_viq_rdata1 (
    .out(s52),
    .sel(s44),
    .in(s50)
);
assign s53[0] = (s28[0] & ~s35[0]) | (s28[0] & s46[0] & ~s35[1]) | (s28[0] & s46[1]);
assign s53[1] = (s28[1] & ~s35[1]) | (s28[1] & s46[0]) | (s28[1] & s46[1]);
assign s31[1:0] = s46[1] ? 2'b11 : s46[0] ? {s28[0],1'b1} : s28[1:0];
assign s32 = s46[0] ? s51 : s29;
assign s33 = s46[1] ? s52 : s46[0] ? s29 : s30;
assign {viq_i0_op2,viq_i0_op1,viq_i0_ctrl,viq_i0_instr} = s32;
assign {viq_i1_op2,viq_i1_op1,viq_i1_ctrl,viq_i1_instr} = s33;
assign {viq_i1_valid,viq_i0_valid} = s31;
assign s34 = {viq_i1_ready,viq_i0_ready};
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

