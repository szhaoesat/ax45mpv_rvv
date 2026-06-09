// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vmac_veq (
    vpu_vmac_clk,
    vpu_reset_n,
    vmac_dispatch_valid,
    vmac_dispatch_ready,
    vmac_dispatch_ctrl,
    vmac_dispatch_vd_len,
    vmac_dispatch_frm,
    vmac_dispatch_vxrm,
    vmac_dispatch_op1_hazard,
    vmac_dispatch_op1,
    vmac_dispatch_v0t,
    vmac_cmt_valid,
    vmac_cmt_kill,
    vmac_cmt_op1,
    veq_ex_nxt_valid,
    veq_ex_nxt_ctrl,
    veq_ex_valid,
    veq_ex_flush,
    veq_ex_ready,
    veq_ex_ctrl,
    veq_ex_vd_len,
    veq_ex_frm,
    veq_ex_vxrm,
    veq_ex_op1_valid,
    veq_ex_op1,
    veq_ex_id,
    veq_ex_v0t,
    veq_ex_cmt,
    veq_ex_v0t_srl_dlen,
    veq_ex_v0t_srl_element
);
parameter XLEN = 64;
parameter FLEN = 64;
parameter DLEN = 512;
parameter VLEN = 512;
parameter VRF_LW = 4;
localparam DEPTH = 4;
input vpu_vmac_clk;
input vpu_reset_n;
input vmac_dispatch_valid;
output vmac_dispatch_ready;
input [58 - 1:0] vmac_dispatch_ctrl;
input [VRF_LW - 1:0] vmac_dispatch_vd_len;
input [2:0] vmac_dispatch_frm;
input [1:0] vmac_dispatch_vxrm;
input vmac_dispatch_op1_hazard;
input [XLEN - 1:0] vmac_dispatch_op1;
input [VLEN - 1:0] vmac_dispatch_v0t;
input vmac_cmt_valid;
input vmac_cmt_kill;
input [XLEN - 1:0] vmac_cmt_op1;
output veq_ex_nxt_valid;
output [58 - 1:0] veq_ex_nxt_ctrl;
output veq_ex_valid;
output veq_ex_flush;
input veq_ex_ready;
output [58 - 1:0] veq_ex_ctrl;
output [VRF_LW - 1:0] veq_ex_vd_len;
output [2:0] veq_ex_frm;
output [1:0] veq_ex_vxrm;
output veq_ex_op1_valid;
output [XLEN - 1:0] veq_ex_op1;
output [4:0] veq_ex_id;
output [DLEN / 8 - 1:0] veq_ex_v0t;
output veq_ex_cmt;
input veq_ex_v0t_srl_dlen;
input veq_ex_v0t_srl_element;





// 4a3e27f0 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [XLEN - 1:0] s0[0:DEPTH - 1];
wire [DEPTH - 1:0] s1;
wire [XLEN - 1:0] s2[0:DEPTH - 1];
reg [VLEN - 1:0] s3[0:DEPTH - 1];
wire [VLEN - 1:0] s4[0:DEPTH - 1];
wire [DEPTH - 1:0] s5;
reg [58 - 1:0] s6[0:DEPTH - 1];
wire [58 - 1:0] s7[0:DEPTH - 1];
reg [VRF_LW - 1:0] s8[0:DEPTH - 1];
wire [VRF_LW - 1:0] s9[0:DEPTH - 1];
reg [2:0] s10[0:DEPTH - 1];
wire [2:0] s11[0:DEPTH - 1];
reg [1:0] s12[0:DEPTH - 1];
wire [1:0] s13[0:DEPTH - 1];
reg s14[0:DEPTH - 1];
wire s15[0:DEPTH - 1];
reg s16[0:DEPTH - 1];
wire s17[0:DEPTH - 1];
wire s18[0:DEPTH - 1];
reg [4:0] s19[0:DEPTH - 1];
wire [4:0] s20[0:DEPTH - 1];
wire [58 - 1:0] s21;
wire [VRF_LW - 1:0] s22;
wire [2:0] s23;
wire [1:0] s24;
wire s25;
wire [XLEN - 1:0] s26;
wire [4:0] s27;
wire [VLEN - 1:0] s28;
wire s29;
wire s30;
reg [DEPTH - 1:0] s31;
wire [DEPTH - 1:0] s32;
wire [DEPTH - 1:0] s33;
wire [DEPTH - 1:0] s34;
wire [DEPTH - 1:0] s35;
reg [DEPTH - 1:0] s36;
wire [DEPTH - 1:0] s37;
wire [DEPTH - 1:0] s38;
wire [DEPTH - 1:0] s39;
wire [DEPTH - 1:0] s40;
wire [DEPTH - 1:0] s41;
wire [DEPTH - 1:1] s42;
wire [DEPTH - 1:1] s43;
wire [58 - 1:0] s44 = s6[0];
wire [58 - 1:0] s45 = s6[1];
wire s46;
wire [1:0] s47;
wire s48 = (s47 == 2'b00);
wire s49 = (s47 == 2'b01);
wire s50 = (s47 == 2'b10);
wire s51 = (s47 == 2'b11);
wire nds_unused_wire = (|s44) | (|s45) | (|s51);
wire [XLEN - 1:0] s52 = vmac_cmt_op1;
wire [XLEN - 1:0] s53 = vmac_dispatch_op1;
reg [4:0] s54;
wire [4:0] s55;
wire s56;
assign s47 = s21[30 +:2];
assign s55 = s54 + 5'b0001;
assign s56 = vmac_dispatch_valid & vmac_dispatch_ready;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s54 <= 5'b0;
    end
    else if (s56) begin
        s54 <= s55;
    end
end

reg [4:0] s57;
wire [4:0] s58;
wire s59;
assign s58 = s57 + 5'b0001;
assign s59 = vmac_cmt_valid;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s57 <= 5'b0;
    end
    else if (s59) begin
        s57 <= s58;
    end
end

assign s21 = s6[0];
assign s22 = s8[0];
assign s23 = s10[0];
assign s24 = s12[0];
assign s25 = s14[0];
assign s26 = s0[0];
assign s27 = s19[0];
assign s28 = s3[0];
assign s29 = s16[0];
assign s30 = s16[1];
assign vmac_dispatch_ready = ~(&s31);
assign veq_ex_valid = s31[0] & ~(s29 & s36[0]);
assign veq_ex_flush = s31[0] & s36[0] & s29;
assign veq_ex_nxt_valid = s31[1] & s31[0] & ~(s30 & s36[1]);
assign veq_ex_nxt_ctrl = s6[1];
assign veq_ex_v0t = s28[DLEN / 8 - 1:0];
assign veq_ex_ctrl = s21;
assign veq_ex_vd_len = s22;
assign veq_ex_frm = s23;
assign veq_ex_vxrm = s24;
assign veq_ex_cmt = s36[0];
wire s60 = 1'b0;
assign veq_ex_op1_valid = (~s25 & ~s60) | (veq_ex_cmt & ~s60);
assign veq_ex_op1 = s26;
assign veq_ex_id = s27;
wire [1:0] s61 = veq_ex_ctrl[30 +:2];
assign s46 = (s31[0] & veq_ex_ready) | (s31[0] & s29 & s36[0]);
generate
    genvar i;
    for (i = 0; i < DEPTH; i = i + 1) begin:gen_fifo_entry
        if (i == 0) begin:gen_first
            assign s41[0] = (vmac_dispatch_valid & ~(|s31[DEPTH - 1:0])) | (vmac_dispatch_valid & s46 & ~s31[1]);
            assign s32[0] = s41[0] | s42[1];
            assign s33[0] = s46;
            assign s37[0] = (vmac_cmt_valid & (s57[4:0] == s27[4:0]) & s31[0] & ~s36[0] & ~veq_ex_ready) | (vmac_cmt_valid & s42[1] & s36[0] & ~s36[1]) | (s42[1] & s36[1]);
            assign s38[0] = s46;
            assign s7[0] = s31[1] ? s6[1] : vmac_dispatch_ctrl;
            assign s9[0] = s31[1] ? s8[1] : vmac_dispatch_vd_len;
            assign s11[0] = s31[1] ? s10[1] : vmac_dispatch_frm;
            assign s13[0] = s31[1] ? s12[1] : vmac_dispatch_vxrm;
            assign s15[0] = s31[1] ? s14[1] : vmac_dispatch_op1_hazard;
            assign s20[0] = s31[1] ? s19[1] : s54;
            assign s5[0] = s32[0] | veq_ex_v0t_srl_dlen | veq_ex_v0t_srl_element;
            assign s4[0] = s32[0] ? s31[1] ? s3[1] : vmac_dispatch_v0t : veq_ex_v0t_srl_dlen ? s48 ? {{DLEN / 8{1'b0}},s28[VLEN - 1:DLEN / 8]} : s49 ? {{DLEN / 16{1'b0}},s28[VLEN - 1:DLEN / 16]} : s50 ? {{DLEN / 32{1'b0}},s28[VLEN - 1:DLEN / 32]} : {{DLEN / 64{1'b0}},s28[VLEN - 1:DLEN / 64]} : (s61 == 2'b01) ? {2'b0,s28[VLEN - 1:2]} : (s61 == 2'b10) ? {4'b0,s28[VLEN - 1:4]} : {8'b0,s28[VLEN - 1:8]};
            assign s18[0] = s37[0];
            assign s17[0] = (s42[1] & s36[1]) ? s16[1] : vmac_cmt_kill;
            assign s1[0] = (s41[0] & ~vmac_dispatch_op1_hazard) | s43[1] | (s42[1] & s36[0] & ~s36[1] & s14[1] & vmac_cmt_valid) | (vmac_cmt_valid & (s57[4:0] == s27[4:0]) & s31[0] & ~s36[0] & ~veq_ex_ready & s14[0]);
            assign s2[0] = s41[0] ? s53 : s43[1] ? s0[1] : s52;
        end
        else if (i == (DEPTH - 1)) begin:gen_last
            assign s41[DEPTH - 1] = (vmac_dispatch_valid & (&s31[DEPTH - 2:0]) & ~s46 & ~s31[DEPTH - 1]);
            assign s42[DEPTH - 1] = s31[DEPTH - 1] & s46;
            assign s32[DEPTH - 1] = s41[DEPTH - 1];
            assign s33[DEPTH - 1] = s46;
            assign s37[DEPTH - 1] = (vmac_cmt_valid & s31[DEPTH - 2] & ~s46 & s36[DEPTH - 2]);
            assign s38[DEPTH - 1] = s42[DEPTH - 1];
            assign s7[DEPTH - 1] = vmac_dispatch_ctrl;
            assign s9[DEPTH - 1] = vmac_dispatch_vd_len;
            assign s11[DEPTH - 1] = vmac_dispatch_frm;
            assign s13[DEPTH - 1] = vmac_dispatch_vxrm;
            assign s15[DEPTH - 1] = vmac_dispatch_op1_hazard;
            assign s20[DEPTH - 1] = s54;
            assign s5[DEPTH - 1] = s32[DEPTH - 1];
            assign s4[DEPTH - 1] = vmac_dispatch_v0t;
            assign s18[DEPTH - 1] = s37[DEPTH - 1];
            assign s17[DEPTH - 1] = vmac_cmt_kill;
            assign s43[DEPTH - 1] = (s42[DEPTH - 1] & ~s14[DEPTH - 1]) | (s42[DEPTH - 1] & s14[DEPTH - 1] & s36[DEPTH - 1]);
            assign s1[DEPTH - 1] = (s41[DEPTH - 1] & ~vmac_dispatch_op1_hazard) | (s37[DEPTH - 1] & s14[DEPTH - 1]);
            assign s2[DEPTH - 1] = s41[DEPTH - 1] ? s53 : s52;
        end
        else begin:gen_normal
            assign s41[i] = (vmac_dispatch_valid & s31[i - 1] & ~s46 & ~s31[i]) | (vmac_dispatch_valid & s42[i] & ~s31[i + 1]);
            assign s42[i] = s31[i] & s46;
            assign s32[i] = s41[i] | s42[i + 1];
            assign s33[i] = s46;
            assign s37[i] = (vmac_cmt_valid & s31[i - 1] & ~s46 & s36[i - 1] & s31[i] & ~s36[i]) | (vmac_cmt_valid & s42[i + 1] & s36[i - 1] & s36[i] & ~s36[i + 1]) | (s42[i + 1] & s36[i + 1]);
            assign s38[i] = s42[i];
            assign s7[i] = s31[i + 1] ? s6[i + 1] : vmac_dispatch_ctrl;
            assign s9[i] = s31[i + 1] ? s8[i + 1] : vmac_dispatch_vd_len;
            assign s11[i] = s31[i + 1] ? s10[i + 1] : vmac_dispatch_frm;
            assign s13[i] = s31[i + 1] ? s12[i + 1] : vmac_dispatch_vxrm;
            assign s15[i] = s31[i + 1] ? s14[i + 1] : vmac_dispatch_op1_hazard;
            assign s20[i] = s31[i + 1] ? s19[i + 1] : s54;
            assign s5[i] = s32[i];
            assign s4[i] = s31[i + 1] ? s3[i + 1] : vmac_dispatch_v0t;
            assign s18[i] = s37[i];
            assign s17[i] = (s42[i + 1] & s36[i + 1]) ? s16[i + 1] : vmac_cmt_kill;
            assign s43[i] = (s42[i] & ~s14[i]) | (s42[i] & s14[i] & s36[i]);
            assign s1[i] = (s41[i] & ~vmac_dispatch_op1_hazard) | s43[i + 1] | (s42[i + 1] & s36[i] & ~s36[i + 1] & s14[i + 1] & vmac_cmt_valid) | (vmac_cmt_valid & s31[i - 1] & ~s46 & s36[i - 1] & s31[i] & ~s36[i] & s14[i]);
            assign s2[i] = s41[i] ? s53 : s43[i + 1] ? s0[i + 1] : s52;
        end
        assign s34[i] = (s31[i] & ~s33[i]) | s32[i];
        assign s35[i] = s32[i] | s33[i];
        assign s39[i] = (s36[i] & ~s38[i]) | s37[i];
        assign s40[i] = s37[i] | s38[i];
        always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s31[i] <= 1'b0;
            end
            else if (s35[i]) begin
                s31[i] <= s34[i];
            end
        end

        always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s36[i] <= 1'b0;
            end
            else if (s40[i]) begin
                s36[i] <= s39[i];
            end
        end

        always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s6[i] <= {58{1'b0}};
                s8[i] <= {VRF_LW{1'b0}};
                s10[i] <= 3'd0;
                s12[i] <= 2'd0;
                s14[i] <= 1'b0;
                s19[i] <= 5'b0;
            end
            else if (s32[i]) begin
                s6[i] <= s7[i];
                s8[i] <= s9[i];
                s10[i] <= s11[i];
                s12[i] <= s13[i];
                s14[i] <= s15[i];
                s19[i] <= s20[i];
            end
        end

        always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s3[i] <= {VLEN{1'b0}};
            end
            else if (s5[i]) begin
                s3[i] <= s4[i];
            end
        end

        always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s16[i] <= 1'b0;
            end
            else if (s18[i]) begin
                s16[i] <= s17[i];
            end
        end

        always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
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

