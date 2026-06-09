// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfmis_veq (
    vpu_vfmis_clk,
    vpu_reset_n,
    vfmis_dispatch_valid,
    vfmis_dispatch_ready,
    vfmis_dispatch_ctrl,
    vfmis_dispatch_vd_len,
    vfmis_dispatch_frm,
    vfmis_dispatch_op1_hazard,
    vfmis_dispatch_op1,
    vfmis_dispatch_v0t_e_mask,
    vfmis_dispatch_v0t_sew8,
    vfmis_dispatch_v0t_sew16,
    vfmis_dispatch_v0t_sew32,
    vfmis_dispatch_v0t_sew64,
    vfmis_cmt_valid,
    vfmis_cmt_kill,
    vfmis_cmt_op1,
    ex_nxt_cmt,
    veq_ex_valid,
    veq_ex_flush,
    veq_ex_ready,
    veq_ex_ctrl,
    veq_ex_vd_len,
    veq_ex_frm,
    veq_ex_op1_valid,
    veq_ex_op1,
    veq_ex_byte_mask,
    veq_ex_nrr_byte_mask,
    veq_ex_e_mask,
    veq_ex_cmt,
    veq_ex_byte_mask_srl,
    veq_ex_nrr_byte_mask_srl,
    veq_ex_nxt_valid,
    veq_ex_nxt_ctrl
);
parameter XLEN = 64;
parameter ELEN = 64;
parameter VLEN = 512;
parameter DLEN = 512;
parameter VRF_LW = 3;
localparam DEPTH = 3;
input vpu_vfmis_clk;
input vpu_reset_n;
input vfmis_dispatch_valid;
output vfmis_dispatch_ready;
input [71 - 1:0] vfmis_dispatch_ctrl;
input [VRF_LW - 1:0] vfmis_dispatch_vd_len;
input [2:0] vfmis_dispatch_frm;
input vfmis_dispatch_op1_hazard;
input [XLEN - 1:0] vfmis_dispatch_op1;
input [63:0] vfmis_dispatch_v0t_e_mask;
input [127:0] vfmis_dispatch_v0t_sew8;
input [63:0] vfmis_dispatch_v0t_sew16;
input [31:0] vfmis_dispatch_v0t_sew32;
input [15:0] vfmis_dispatch_v0t_sew64;
input vfmis_cmt_valid;
input vfmis_cmt_kill;
input [XLEN - 1:0] vfmis_cmt_op1;
input ex_nxt_cmt;
output veq_ex_valid;
output veq_ex_flush;
input veq_ex_ready;
output [71 - 1:0] veq_ex_ctrl;
output [VRF_LW - 1:0] veq_ex_vd_len;
output [2:0] veq_ex_frm;
output veq_ex_op1_valid;
output [XLEN - 1:0] veq_ex_op1;
output [127:0] veq_ex_byte_mask;
output [127:0] veq_ex_nrr_byte_mask;
output [63:0] veq_ex_e_mask;
output veq_ex_cmt;
input veq_ex_byte_mask_srl;
input veq_ex_nrr_byte_mask_srl;
output veq_ex_nxt_valid;
output [71 - 1:0] veq_ex_nxt_ctrl;





// 4132bfb8 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [XLEN - 1:0] s0[0:DEPTH - 1];
wire [DEPTH - 1:0] s1;
wire [XLEN - 1:0] s2[0:DEPTH - 1];
reg [127:0] s3[0:DEPTH - 1];
wire [127:0] s4[0:DEPTH - 1];
wire [DEPTH - 1:0] s5;
reg [127:0] s6[0:DEPTH - 1];
wire [127:0] s7[0:DEPTH - 1];
wire [DEPTH - 1:0] s8;
reg [63:0] s9[0:DEPTH - 1];
wire [63:0] s10[0:DEPTH - 1];
reg [71 - 1:0] s11[0:DEPTH - 1];
wire [71 - 1:0] s12[0:DEPTH - 1];
reg [4:0] s13[0:DEPTH - 1];
wire [4:0] s14[0:DEPTH - 1];
reg [VRF_LW - 1:0] s15[0:DEPTH - 1];
wire [VRF_LW - 1:0] s16[0:DEPTH - 1];
reg [2:0] s17[0:DEPTH - 1];
wire [2:0] s18[0:DEPTH - 1];
reg s19[0:DEPTH - 1];
wire s20[0:DEPTH - 1];
reg s21[0:DEPTH - 1];
wire [DEPTH - 1:0] s22;
wire [DEPTH - 1:0] s23;
wire [71 - 1:0] s24;
wire [VRF_LW - 1:0] s25;
wire [2:0] s26;
wire s27;
wire [XLEN - 1:0] s28;
wire [127:0] s29;
wire [127:0] s30;
wire [63:0] s31;
wire s32;
wire s33;
reg [DEPTH - 1:0] s34;
wire [DEPTH - 1:0] s35;
wire [DEPTH - 1:0] s36;
wire [DEPTH - 1:0] s37;
wire [DEPTH - 1:0] s38;
reg [DEPTH - 1:0] s39;
wire [DEPTH - 1:0] s40;
wire [DEPTH - 1:0] s41;
wire [DEPTH - 1:0] s42;
wire [DEPTH - 1:0] s43;
wire [DEPTH - 1:0] s44;
wire [DEPTH - 1:1] s45;
wire [DEPTH - 1:1] s46;
wire s47;
wire [XLEN - 1:0] s48 = vfmis_cmt_op1;
wire [XLEN - 1:0] s49 = vfmis_dispatch_op1;
reg [4:0] s50;
wire s51;
wire [4:0] s52;
wire nds_unused_dis_id_nx_co;
assign {nds_unused_dis_id_nx_co,s52} = s50 + 5'b1;
assign s51 = vfmis_dispatch_valid & vfmis_dispatch_ready;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s50 <= 5'b0;
    end
    else if (s51) begin
        s50 <= s52;
    end
end

wire [4:0] s53;
assign s53 = s13[0];
wire nds_unused_wire = |s53;
assign s24 = s11[0];
assign s25 = s15[0];
assign s26 = s17[0];
assign s27 = s19[0];
assign s28 = s0[0];
assign s29 = s3[0];
assign s30 = s6[0];
assign s31 = s9[0];
assign s32 = s21[0];
assign s33 = s21[1];
assign vfmis_dispatch_ready = (~s34[0] | ~s34[1] | ~s34[2]);
assign veq_ex_valid = s34[0] & ~(s32 & s39[0]);
assign veq_ex_flush = s34[0] & s39[0] & s32;
assign veq_ex_nxt_valid = s34[1] & s34[0] & ~(s33 & s39[1]);
assign veq_ex_nxt_ctrl = s11[1];
assign veq_ex_byte_mask = s29;
assign veq_ex_nrr_byte_mask = s30;
assign veq_ex_e_mask = s31;
assign veq_ex_ctrl = s24;
assign veq_ex_vd_len = s25;
assign veq_ex_frm = s26;
assign veq_ex_cmt = s39[0];
assign veq_ex_op1_valid = ~s27 | veq_ex_cmt;
assign veq_ex_op1 = s28;
wire [3:0] s54 = vfmis_dispatch_ctrl[44 +:4] & {(ELEN == 64),3'b111};
wire [127:0] s55;
reg [127:0] s56;
reg [127:0] s57;
reg [127:0] s58;
wire [127:0] s59;
wire [127:0] s60;
integer s61;
integer s62;
integer s63;
assign s59 = ({128{s54[0]}} & s55) | ({128{s54[1]}} & s56) | ({128{s54[2]}} & s57) | ({128{s54[3]}} & s58);
assign s60 = ({128{s54[0]}} & s56) | ({128{s54[1]}} & s57) | ({128{s54[2]}} & s58);
assign s55 = vfmis_dispatch_v0t_sew8;
always @* begin
    for (s61 = 0; s61 < 128 / 2; s61 = s61 + 1) begin
        s56[s61 * 2 +:2] = {2{vfmis_dispatch_v0t_sew16[s61]}};
    end
end

always @* begin
    for (s62 = 0; s62 < 128 / 4; s62 = s62 + 1) begin
        s57[s62 * 4 +:4] = {4{vfmis_dispatch_v0t_sew32[s62]}};
    end
end

always @* begin
    for (s63 = 0; s63 < 128 / 8; s63 = s63 + 1) begin
        s58[s63 * 8 +:8] = {8{vfmis_dispatch_v0t_sew64[s63]}};
    end
end

wire [127:0] s64;
wire [127:0] s65;
assign s64 = (s59 & {{64{VLEN != DLEN}},64'hffffffffffffffff});
assign s65 = s34[1] ? s3[1] : s64;
wire [127:0] s66;
wire [127:0] s67;
assign s66 = s60 & {{64{VLEN != DLEN}},64'hffffffffffffffff};
assign s67 = s34[1] ? s6[1] : s66;
assign s47 = (s34[0] & veq_ex_ready) | (s34[0] & s32 & s39[0]);
generate
    genvar i;
    for (i = 0; i < DEPTH; i = i + 1) begin:gen_fifo_entry
        if (i == 0) begin:gen_first
            assign s44[0] = (vfmis_dispatch_valid & ~s34[0] & ~s34[1] & ~s34[2]) | (vfmis_dispatch_valid & s47 & ~s34[1]);
            assign s35[0] = s44[0] | s45[1];
            assign s40[0] = (vfmis_cmt_valid & ~vfmis_cmt_kill & ex_nxt_cmt & s34[0] & ~s39[0] & ~veq_ex_ready) | (vfmis_cmt_valid & s45[1] & s39[0]) | (s45[1] & s39[1]);
            assign s12[0] = s34[1] ? s11[1] : vfmis_dispatch_ctrl;
            assign s14[0] = s34[1] ? s13[1] : s50;
            assign s16[0] = s34[1] ? s15[1] : vfmis_dispatch_vd_len;
            assign s18[0] = s34[1] ? s17[1] : vfmis_dispatch_frm;
            assign s20[0] = s34[1] ? s19[1] : vfmis_dispatch_op1_hazard;
            assign s10[0] = s34[1] ? s9[1] : vfmis_dispatch_v0t_e_mask;
            assign s5[0] = s35[0] | veq_ex_byte_mask_srl;
            assign s4[0] = s35[0] ? s65 : {8'b0,s29[127:8]};
            assign s8[0] = s35[0] | veq_ex_nrr_byte_mask_srl;
            assign s7[0] = s35[0] ? s67 : {8'b0,s30[127:8]};
            assign s23[0] = s40[0];
            assign s22[0] = (s45[1] & s39[1]) ? s21[1] : vfmis_cmt_kill;
            assign s1[0] = (s44[0] & ~vfmis_dispatch_op1_hazard) | s46[1] | (s45[1] & s39[0] & ~s39[1] & s19[1] & vfmis_cmt_valid) | (vfmis_cmt_valid & ex_nxt_cmt & s34[0] & ~s39[0] & ~s47 & s19[0]);
            assign s2[0] = s44[0] ? s49 : s46[1] ? s0[1] : s48;
        end
        else if (i == DEPTH - 1) begin:gen_last
            assign s44[DEPTH - 1] = vfmis_dispatch_valid & s34[DEPTH - 2] & ~s47 & ~s34[DEPTH - 1];
            assign s45[DEPTH - 1] = (s47 & s34[DEPTH - 1]);
            assign s35[DEPTH - 1] = s44[DEPTH - 1];
            assign s40[DEPTH - 1] = (vfmis_cmt_valid & ~s47 & (&s34[DEPTH - 1]) & s39[DEPTH - 2]);
            assign s12[DEPTH - 1] = vfmis_dispatch_ctrl;
            assign s14[DEPTH - 1] = s50;
            assign s16[DEPTH - 1] = vfmis_dispatch_vd_len;
            assign s18[DEPTH - 1] = vfmis_dispatch_frm;
            assign s20[DEPTH - 1] = vfmis_dispatch_op1_hazard;
            assign s10[DEPTH - 1] = vfmis_dispatch_v0t_e_mask;
            assign s5[DEPTH - 1] = s35[DEPTH - 1];
            assign s4[DEPTH - 1] = s64;
            assign s8[DEPTH - 1] = s35[DEPTH - 1];
            assign s7[DEPTH - 1] = s66;
            assign s23[DEPTH - 1] = s40[DEPTH - 1];
            assign s22[DEPTH - 1] = vfmis_cmt_kill;
            assign s46[DEPTH - 1] = (s45[DEPTH - 1] & ~s19[DEPTH - 1]) | (s45[DEPTH - 1] & s19[DEPTH - 1] & s39[DEPTH - 1]);
            assign s1[DEPTH - 1] = (s44[DEPTH - 1] & ~vfmis_dispatch_op1_hazard) | (s40[DEPTH - 1] & s19[DEPTH - 1]);
            assign s2[2] = s44[2] ? s49 : s48;
        end
        else begin:gen_mid
            assign s44[i] = (vfmis_dispatch_valid & s34[i - 1] & ~s47 & ~s34[i]) | (vfmis_dispatch_valid & s45[i] & ~s34[i + 1]);
            assign s45[i] = (s47 & s34[i]);
            assign s35[i] = s44[i] | s45[i + 1];
            assign s40[1] = (vfmis_cmt_valid & ~s47 & s39[i - 1] & s34[i] & ~s39[i]) | (vfmis_cmt_valid & s45[2] & s39[i] & ~s39[i + 1]) | (s45[i + 1] & s39[i + 1]);
            assign s12[i] = s34[i + 1] ? s11[i + 1] : vfmis_dispatch_ctrl;
            assign s14[i] = s34[i + 1] ? s13[i + 1] : s50;
            assign s16[i] = s34[i + 1] ? s15[i + 1] : vfmis_dispatch_vd_len;
            assign s18[i] = s34[i + 1] ? s17[i + 1] : vfmis_dispatch_frm;
            assign s20[i] = s34[i + 1] ? s19[i + 1] : vfmis_dispatch_op1_hazard;
            assign s10[i] = s34[i + 1] ? s9[i + 1] : vfmis_dispatch_v0t_e_mask;
            assign s5[i] = s35[i];
            assign s4[i] = s34[i + 1] ? s3[i + 1] : s64;
            assign s8[i] = s35[i];
            assign s7[i] = s34[i + 1] ? s6[i + 1] : s66;
            assign s23[i] = s40[i];
            assign s22[i] = (s45[i + 1] & s39[i + 1]) ? s21[i + 1] : vfmis_cmt_kill;
            assign s46[i] = (s45[i] & ~s19[i]) | (s45[i] & s19[i] & s39[i]);
            assign s1[i] = (s44[i] & ~vfmis_dispatch_op1_hazard) | s46[i + 1] | (s45[i + 1] & s39[i] & ~s39[i + 1] & s19[i + 1] & vfmis_cmt_valid) | (vfmis_cmt_valid & ~s47 & s34[i] & s39[i - 1] & ~s39[i] & s19[1]);
            assign s2[1] = s44[i] ? s49 : s46[i + 1] ? s0[2] : s48;
        end
        assign s36[i] = s47;
        assign s37[i] = (s34[i] & ~s36[i]) | s35[i];
        assign s38[i] = s35[i] | s36[i];
        always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s34[i] <= 1'b0;
            end
            else if (s38[i]) begin
                s34[i] <= s37[i];
            end
        end

        assign s41[i] = s47;
        assign s42[i] = (s39[i] & ~s41[i]) | s40[i];
        assign s43[i] = s40[i] | s41[i];
        always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s39[i] <= 1'b0;
            end
            else if (s43[i]) begin
                s39[i] <= s42[i];
            end
        end

        always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s11[i] <= {71{1'b0}};
                s13[i] <= 5'b0;
                s15[i] <= {VRF_LW{1'b0}};
                s17[i] <= 3'd0;
                s19[i] <= 1'b0;
                s9[i] <= 64'b0;
            end
            else if (s35[i]) begin
                s11[i] <= s12[i];
                s13[i] <= s14[i];
                s15[i] <= s16[i];
                s17[i] <= s18[i];
                s19[i] <= s20[i];
                s9[i] <= s10[i];
            end
        end

        always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s3[i] <= 128'b0;
            end
            else if (s5[i]) begin
                s3[i] <= s4[i];
            end
        end

        always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s6[i] <= 128'b0;
            end
            else if (s8[i]) begin
                s6[i] <= s7[i];
            end
        end

        always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s21[i] <= 1'b0;
            end
            else if (s23[i]) begin
                s21[i] <= s22[i];
            end
        end

        always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s0[i] <= {XLEN{1'b0}};
            end
            else if (s1[i]) begin
                s0[i] <= s2[i];
            end
        end

    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

