// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_valu_veq (
    vpu_valu_clk,
    vpu_reset_n,
    valu_dispatch_valid,
    valu_dispatch_ready,
    valu_dispatch_ctrl,
    valu_dispatch_vd_len,
    valu_dispatch_vxrm,
    valu_dispatch_op1_hazard,
    valu_dispatch_op1,
    valu_dispatch_v0t_e_mask0,
    valu_dispatch_v0t_e_mask1,
    valu_dispatch_v0t_sew8,
    valu_dispatch_v0t_sew16,
    valu_dispatch_v0t_sew32,
    valu_dispatch_v0t_sew64,
    valu_cmt_valid,
    valu_cmt_kill,
    valu_cmt_op1,
    ex_nxt_cmt,
    veq_ex_valid,
    veq_ex_flush,
    veq_ex_ready,
    veq_ex_ctrl,
    veq_ex_ctrl_dup,
    veq_ex_vd_len,
    veq_ex_vxrm,
    veq_ex_scalar_valid,
    veq_ex_scalar_op,
    veq_ex_nrr_scalar_op,
    veq_ex_byte_mask,
    veq_ex_nrr_byte_mask,
    veq_ex_e_mask0,
    veq_ex_e_mask1,
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
parameter VRF_LW = 4;
localparam DEPTH = 3;
input vpu_valu_clk;
input vpu_reset_n;
input valu_dispatch_valid;
output valu_dispatch_ready;
input [58 - 1:0] valu_dispatch_ctrl;
input [VRF_LW - 1:0] valu_dispatch_vd_len;
input [1:0] valu_dispatch_vxrm;
input valu_dispatch_op1_hazard;
input [XLEN - 1:0] valu_dispatch_op1;
input [63:0] valu_dispatch_v0t_e_mask0;
input [63:0] valu_dispatch_v0t_e_mask1;
input [127:0] valu_dispatch_v0t_sew8;
input [127:0] valu_dispatch_v0t_sew16;
input [63:0] valu_dispatch_v0t_sew32;
input [31:0] valu_dispatch_v0t_sew64;
input valu_cmt_valid;
input valu_cmt_kill;
input [XLEN - 1:0] valu_cmt_op1;
input ex_nxt_cmt;
output veq_ex_valid;
output veq_ex_flush;
input veq_ex_ready;
output [58 - 1:0] veq_ex_ctrl;
output [58 - 1:0] veq_ex_ctrl_dup;
output [VRF_LW - 1:0] veq_ex_vd_len;
output [1:0] veq_ex_vxrm;
output veq_ex_scalar_valid;
output [XLEN - 1:0] veq_ex_scalar_op;
output [XLEN - 1:0] veq_ex_nrr_scalar_op;
output [127:0] veq_ex_byte_mask;
output [127:0] veq_ex_nrr_byte_mask;
output [63:0] veq_ex_e_mask0;
output [63:0] veq_ex_e_mask1;
output veq_ex_cmt;
input veq_ex_byte_mask_srl;
input veq_ex_nrr_byte_mask_srl;
output veq_ex_nxt_valid;
output [58 - 1:0] veq_ex_nxt_ctrl;





// 99b7bb69 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [XLEN - 1:0] s0[0:DEPTH - 1];
reg [XLEN - 1:0] s1;
wire [DEPTH - 1:0] s2;
wire [XLEN - 1:0] s3[0:DEPTH - 1];
reg [255:0] s4[0:DEPTH - 1];
wire [255:0] s5[0:DEPTH - 1];
wire [DEPTH - 1:0] s6;
reg [127:0] s7[0:DEPTH - 1];
wire [127:0] s8[0:DEPTH - 1];
wire [DEPTH - 1:0] s9;
reg [63:0] s10[0:DEPTH - 1];
wire [63:0] s11[0:DEPTH - 1];
reg [63:0] s12[0:DEPTH - 1];
wire [63:0] s13[0:DEPTH - 1];
reg [58 - 1:0] s14[0:DEPTH - 1];
reg [58 - 1:0] s15;
wire [58 - 1:0] s16[0:DEPTH - 1];
reg [VRF_LW - 1:0] s17[0:DEPTH - 1];
wire [VRF_LW - 1:0] s18[0:DEPTH - 1];
reg [1:0] s19[0:DEPTH - 1];
wire [1:0] s20[0:DEPTH - 1];
reg s21[0:DEPTH - 1];
wire s22[0:DEPTH - 1];
reg s23[0:DEPTH - 1];
wire s24[0:DEPTH - 1];
wire s25[0:DEPTH - 1];
wire [58 - 1:0] s26;
wire [VRF_LW - 1:0] s27;
wire [1:0] s28;
wire s29;
wire [XLEN - 1:0] s30;
wire [255:0] s31;
wire [127:0] s32;
wire [63:0] s33;
wire [63:0] s34;
wire s35;
wire s36;
reg [DEPTH - 1:0] s37;
wire [DEPTH - 1:0] s38;
wire [DEPTH - 1:0] s39;
wire [DEPTH - 1:0] s40;
wire [DEPTH - 1:0] s41;
reg [DEPTH - 1:0] s42;
wire [DEPTH - 1:0] s43;
wire [DEPTH - 1:0] s44;
wire [DEPTH - 1:0] s45;
wire [DEPTH - 1:0] s46;
wire [DEPTH - 1:0] s47;
wire [DEPTH - 1:1] s48;
wire [DEPTH - 1:1] s49;
wire s50;
wire [XLEN - 1:0] s51 = valu_cmt_op1;
wire [XLEN - 1:0] s52 = valu_dispatch_op1;
reg [4:0] s53;
wire s54;
wire [4:0] s55;
wire nds_unused_dis_id_nx_co;
wire [4:0] s56;
wire nds_unused_wire;
wire [4:0] s57[0:DEPTH - 1];
reg [4:0] s58[0:DEPTH - 1];
assign nds_unused_wire = |s56;
assign {nds_unused_dis_id_nx_co,s55} = s53 + 5'b1;
assign s54 = valu_dispatch_valid & valu_dispatch_ready;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s53 <= 5'b0;
    end
    else if (s54) begin
        s53 <= s55;
    end
end

assign s56 = s58[0];
assign s26 = s14[0];
assign s27 = s17[0];
assign s28 = s19[0];
assign s29 = s21[0];
assign s30 = s0[0];
assign s31 = s4[0];
assign s32 = s7[0];
assign s33 = s10[0];
assign s34 = s12[0];
assign s35 = s23[0];
assign s36 = s23[1];
assign valu_dispatch_ready = ~(&s37);
assign veq_ex_valid = s37[0] & (~(s35 & s42[0]));
assign veq_ex_flush = s37[0] & s42[0] & s35;
assign veq_ex_nxt_valid = s37[1] & s37[0] & (~(s36 & s42[1]));
assign veq_ex_nxt_ctrl = s14[1];
assign veq_ex_byte_mask = s31[127:0];
assign veq_ex_nrr_byte_mask = s32[127:0];
assign veq_ex_e_mask0 = s33;
assign veq_ex_e_mask1 = s34;
assign veq_ex_ctrl = s26;
assign veq_ex_ctrl_dup = s15;
assign veq_ex_vd_len = s27;
assign veq_ex_vxrm = s28;
assign veq_ex_cmt = s42[0];
wire s59 = 1'b0;
assign veq_ex_scalar_valid = (~s29 & ~s59) | (veq_ex_cmt & ~s59);
assign veq_ex_scalar_op = s30;
assign veq_ex_nrr_scalar_op = s1;
assign s50 = (s37[0] & veq_ex_ready) | (s37[0] & s35 & s42[0]);
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s15 <= {58{1'b0}};
    end
    else if (s38[0]) begin
        s15 <= s16[0];
    end
end

always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s1 <= {XLEN{1'b0}};
    end
    else if (s2[0]) begin
        s1 <= s3[0];
    end
end

wire [3:0] s60 = valu_dispatch_ctrl[24 +:4] & {(ELEN == 64),3'b111};
wire [255:0] s61;
reg [255:0] s62;
reg [255:0] s63;
reg [255:0] s64;
wire [255:0] s65;
wire [127:0] s66;
integer s67;
integer s68;
integer s69;
assign s65 = ({256{s60[0]}} & s61) | ({256{s60[1]}} & s62) | ({256{s60[2]}} & s63) | ({256{s60[3]}} & s64);
assign s66 = ({128{s60[0]}} & s62[127:0]) | ({128{s60[1]}} & s63[127:0]) | ({128{s60[2]}} & s64[127:0]);
assign s61 = {2{valu_dispatch_v0t_sew8}};
always @* begin
    for (s67 = 0; s67 < 256 / 2; s67 = s67 + 1) begin
        s62[s67 * 2 +:2] = {2{valu_dispatch_v0t_sew16[s67]}};
    end
end

always @* begin
    for (s68 = 0; s68 < 256 / 4; s68 = s68 + 1) begin
        s63[s68 * 4 +:4] = {4{valu_dispatch_v0t_sew32[s68]}};
    end
end

always @* begin
    for (s69 = 0; s69 < 256 / 8; s69 = s69 + 1) begin
        s64[s69 * 8 +:8] = {8{valu_dispatch_v0t_sew64[s69]}};
    end
end

wire [255:0] s70;
wire [255:0] s71;
assign s70 = s65;
assign s71 = s37[1] ? s4[1] : s70;
wire [127:0] s72;
wire [127:0] s73;
assign s72 = s66 & {{64{VLEN != DLEN}},64'hffffffffffffffff};
assign s73 = s37[1] ? s7[1] : s72;
generate
    genvar i;
    for (i = 0; i < DEPTH; i = i + 1) begin:gen_fifo_entry
        if (i == 0) begin:gen_first
            assign s47[0] = (valu_dispatch_valid & ~s37[0] & ~s37[1] & ~s37[2]) | (valu_dispatch_valid & s50 & ~s37[1]);
            assign s38[0] = s47[0] | s48[1];
            assign s43[0] = (valu_cmt_valid & ex_nxt_cmt & s37[0] & ~s42[0] & ~veq_ex_ready) | (valu_cmt_valid & s48[1] & s42[0] & ~s42[1]) | (s48[1] & s42[1]);
            assign s16[0] = s37[1] ? s14[1] : valu_dispatch_ctrl;
            assign s57[0] = s37[1] ? s58[1] : s53;
            assign s18[0] = s37[1] ? s17[1] : valu_dispatch_vd_len;
            assign s20[0] = s37[1] ? s19[1] : valu_dispatch_vxrm;
            assign s22[0] = s37[1] ? s21[1] : valu_dispatch_op1_hazard;
            assign s6[0] = s38[0] | veq_ex_byte_mask_srl;
            assign s5[0] = s38[0] ? s71 : {8'b0,s31[255:8]};
            assign s9[0] = s38[0] | veq_ex_nrr_byte_mask_srl;
            assign s8[0] = s38[0] ? s73 : {8'b0,s32[127:8]};
            assign s11[0] = s37[1] ? s10[1] : valu_dispatch_v0t_e_mask0;
            assign s13[0] = s37[1] ? s12[1] : valu_dispatch_v0t_e_mask1;
            assign s25[0] = s43[0];
            assign s24[0] = (s48[1] & s42[1]) ? s23[1] : valu_cmt_kill;
            assign s2[0] = (s47[0] & ~valu_dispatch_op1_hazard) | s49[1] | (s48[1] & s42[0] & ~s42[1] & s21[1] & valu_cmt_valid) | (valu_cmt_valid & ex_nxt_cmt & s37[0] & ~s42[0] & ~veq_ex_ready & s21[0]);
            assign s3[0] = s47[0] ? s52 : s49[1] ? s0[1] : s51;
        end
        else if (i == (DEPTH - 1)) begin:gen_last
            assign s47[DEPTH - 1] = (valu_dispatch_valid & (&s37[DEPTH - 2:0]) & ~s50 & ~s37[DEPTH - 1]);
            assign s48[DEPTH - 1] = s50 & s37[DEPTH - 1];
            assign s38[DEPTH - 1] = s47[DEPTH - 1];
            assign s43[DEPTH - 1] = (valu_cmt_valid & (&s37[DEPTH - 2:0]) & ~s50 & s42[DEPTH - 2]);
            assign s16[DEPTH - 1] = valu_dispatch_ctrl;
            assign s57[DEPTH - 1] = s53;
            assign s18[DEPTH - 1] = valu_dispatch_vd_len;
            assign s20[DEPTH - 1] = valu_dispatch_vxrm;
            assign s22[DEPTH - 1] = valu_dispatch_op1_hazard;
            assign s6[DEPTH - 1] = s38[DEPTH - 1];
            assign s5[DEPTH - 1] = s70;
            assign s9[DEPTH - 1] = s38[DEPTH - 1];
            assign s8[DEPTH - 1] = s72;
            assign s11[DEPTH - 1] = valu_dispatch_v0t_e_mask0;
            assign s13[DEPTH - 1] = valu_dispatch_v0t_e_mask1;
            assign s25[DEPTH - 1] = s43[DEPTH - 1];
            assign s24[DEPTH - 1] = valu_cmt_kill;
            assign s2[DEPTH - 1] = (s47[DEPTH - 1] & ~valu_dispatch_op1_hazard) | (s43[DEPTH - 1] & s21[DEPTH - 1]);
            assign s49[DEPTH - 1] = (s48[DEPTH - 1] & ~s21[DEPTH - 1]) | (s48[DEPTH - 1] & s21[DEPTH - 1] & s42[DEPTH - 1]);
            assign s3[DEPTH - 1] = s47[DEPTH - 1] ? s52 : s51;
        end
        else begin:gen_mid
            assign s47[i] = (valu_dispatch_valid & (&s37[i - 1:0]) & ~s50 & ~s37[i]) | (valu_dispatch_valid & s48[i] & ~s37[i + 1]);
            assign s48[i] = s50 & s37[i];
            assign s38[i] = s47[i] | s48[i + 1];
            assign s43[i] = (valu_cmt_valid & (&s37[i - 1:0]) & ~s50 & s42[i - 1] & ~s42[i]) | (valu_cmt_valid & s48[i + 1] & (&s42[i]) & ~s42[i + 1]) | (s48[i + 1] & s42[i + 1]);
            assign s16[i] = s37[i + 1] ? s14[i + 1] : valu_dispatch_ctrl;
            assign s57[i] = s37[i + 1] ? s58[i + 1] : s53;
            assign s18[i] = s37[i + 1] ? s17[i + 1] : valu_dispatch_vd_len;
            assign s20[i] = s37[i + 1] ? s19[i + 1] : valu_dispatch_vxrm;
            assign s22[i] = s37[i + 1] ? s21[i + 1] : valu_dispatch_op1_hazard;
            assign s6[i] = s38[i];
            assign s5[i] = s37[i + 1] ? s4[i + 1] : s70;
            assign s9[i] = s38[i];
            assign s8[i] = s37[i + 1] ? s7[i + 1] : s72;
            assign s11[i] = s37[i + 1] ? s10[i + 1] : valu_dispatch_v0t_e_mask0;
            assign s13[i] = s37[i + 1] ? s12[i + 1] : valu_dispatch_v0t_e_mask1;
            assign s25[i] = s43[i];
            assign s24[i] = (s48[i + 1] & s42[i + 1]) ? s23[i + 1] : valu_cmt_kill;
            assign s49[i] = (s48[i] & ~s21[i]) | (s48[i] & s21[i] & s42[i]);
            assign s2[i] = (s47[i] & ~valu_dispatch_op1_hazard) | s49[i + 1] | (s48[i + 1] & s42[i] & ~s42[i + 1] & s21[i + 1] & valu_cmt_valid) | (valu_cmt_valid & (&s37[i:0]) & ~s50 & s42[i - 1] & ~s42[i] & s21[i]);
            assign s3[i] = s47[i] ? s52 : s49[i + 1] ? s0[i + 1] : s51;
        end
        assign s39[i] = s50;
        assign s40[i] = (s37[i] & ~s39[i]) | s38[i];
        assign s41[i] = s39[i] | s38[i];
        always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s37[i] <= 1'b0;
            end
            else if (s41[i]) begin
                s37[i] <= s40[i];
            end
        end

        assign s44[i] = s50;
        assign s45[i] = (s42[i] & ~s44[i]) | s43[i];
        assign s46[i] = s44[i] | s43[i];
        always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s42[i] <= 1'b0;
            end
            else if (s46[i]) begin
                s42[i] <= s45[i];
            end
        end

        always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s14[i] <= {58{1'b0}};
                s58[i] <= 5'b0;
                s17[i] <= {VRF_LW{1'b0}};
                s19[i] <= 2'd0;
                s21[i] <= 1'b0;
                s10[i] <= 64'b0;
                s12[i] <= 64'b0;
            end
            else if (s38[i]) begin
                s14[i] <= s16[i];
                s58[i] <= s57[i];
                s17[i] <= s18[i];
                s19[i] <= s20[i];
                s21[i] <= s22[i];
                s10[i] <= s11[i];
                s12[i] <= s13[i];
            end
        end

        always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s4[i] <= 256'b0;
            end
            else if (s6[i]) begin
                s4[i] <= s5[i];
            end
        end

        always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s7[i] <= 128'b0;
            end
            else if (s9[i]) begin
                s7[i] <= s8[i];
            end
        end

        always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s23[i] <= 1'b0;
            end
            else if (s25[i]) begin
                s23[i] <= s24[i];
            end
        end

        always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s0[i] <= {XLEN{1'b0}};
            end
            else if (s2[i]) begin
                s0[i] <= s3[i];
            end
        end

    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

