// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfdiv_veq (
    vpu_vfdiv_clk,
    vpu_reset_n,
    vfdiv_dispatch_valid,
    vfdiv_dispatch_vd_len,
    vfdiv_dispatch_vs1_len,
    vfdiv_dispatch_vs2_len,
    vfdiv_dispatch_ready,
    vfdiv_dispatch_ctrl,
    vfdiv_dispatch_frm,
    vfdiv_dispatch_op1_hazard,
    vfdiv_dispatch_op1,
    vfdiv_dispatch_v0t,
    vfdiv_cmt_valid,
    vfdiv_cmt_kill,
    vfdiv_cmt_op1,
    f0_nxt_cmt,
    veq_ex_valid,
    veq_ex_vd_len,
    veq_ex_vs1_len,
    veq_ex_vs2_len,
    veq_ex_ready,
    veq_ex_ctrl,
    veq_ex_frm,
    veq_ex_op1_valid,
    veq_ex_op1,
    veq_ex_byte_mask,
    veq_ex_cmt,
    veq_ex_byte_mask_srl
);
parameter XLEN = 64;
parameter ELEN = 64;
parameter DLEN = 512;
parameter VLEN = 512;
parameter VRF_LW = 4;
input vpu_vfdiv_clk;
input vpu_reset_n;
input [VRF_LW - 1:0] vfdiv_dispatch_vd_len;
input [VRF_LW - 1:0] vfdiv_dispatch_vs1_len;
input [VRF_LW - 1:0] vfdiv_dispatch_vs2_len;
input vfdiv_dispatch_valid;
output vfdiv_dispatch_ready;
input [39 - 1:0] vfdiv_dispatch_ctrl;
input [2:0] vfdiv_dispatch_frm;
input vfdiv_dispatch_op1_hazard;
input [XLEN - 1:0] vfdiv_dispatch_op1;
input [VLEN - 1:0] vfdiv_dispatch_v0t;
input vfdiv_cmt_valid;
input vfdiv_cmt_kill;
input [XLEN - 1:0] vfdiv_cmt_op1;
input f0_nxt_cmt;
output veq_ex_valid;
input veq_ex_ready;
output [39 - 1:0] veq_ex_ctrl;
output [VRF_LW - 1:0] veq_ex_vd_len;
output [VRF_LW - 1:0] veq_ex_vs1_len;
output [VRF_LW - 1:0] veq_ex_vs2_len;
output [2:0] veq_ex_frm;
output veq_ex_op1_valid;
output [XLEN - 1:0] veq_ex_op1;
output [VLEN - 1:0] veq_ex_byte_mask;
output veq_ex_cmt;
input veq_ex_byte_mask_srl;





// 93464678 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [XLEN - 1:0] s0;
wire s1;
wire [XLEN - 1:0] s2;
reg [VLEN - 1:0] s3;
wire [VLEN - 1:0] s4;
wire s5;
reg [39 - 1:0] s6;
wire [39 - 1:0] s7;
reg [VRF_LW - 1:0] s8;
reg [VRF_LW - 1:0] s9;
reg [VRF_LW - 1:0] s10;
wire [VRF_LW - 1:0] s11;
wire [VRF_LW - 1:0] s12;
wire [VRF_LW - 1:0] s13;
reg [2:0] s14;
wire [2:0] s15;
reg s16;
wire s17;
reg s18;
wire s19;
wire s20;
wire s21;
wire s22;
reg s23;
wire s24;
wire s25;
wire s26;
wire s27;
wire s28;
assign vfdiv_dispatch_ready = ~s18;
assign veq_ex_valid = s18;
assign veq_ex_byte_mask = s3;
assign veq_ex_ctrl = s6;
assign veq_ex_vd_len = s8;
assign veq_ex_vs1_len = s9;
assign veq_ex_vs2_len = s10;
assign veq_ex_frm = s14;
assign veq_ex_cmt = s23;
assign veq_ex_op1_valid = ~s16 | veq_ex_cmt;
assign veq_ex_op1 = s0;
assign s28 = (vfdiv_dispatch_valid & ~s18);
assign s19 = s28;
assign s20 = veq_ex_ready;
assign s21 = (s18 & ~s20) | s19;
assign s22 = s19 | s20;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s18 <= 1'b0;
    end
    else if (s22) begin
        s18 <= s21;
    end
end

assign s24 = (vfdiv_cmt_valid & f0_nxt_cmt & s18 & ~s23);
assign s25 = veq_ex_ready | (f0_nxt_cmt & vfdiv_cmt_kill & vfdiv_cmt_valid);
assign s26 = (s23 | s24) & ~s25;
assign s27 = s24 | s25;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s23 <= 1'b0;
    end
    else if (s27) begin
        s23 <= s26;
    end
end

wire [3:0] s29 = vfdiv_dispatch_ctrl[13 +:4] & {(ELEN == 64),3'b111};
reg [VLEN - 1:0] s30;
reg [VLEN - 1:0] s31;
reg [VLEN - 1:0] s32;
wire [VLEN - 1:0] s33;
integer s34;
integer s35;
integer s36;
assign s33 = ({VLEN{s29[1]}} & s30) | ({VLEN{s29[2]}} & s31) | ({VLEN{s29[3]}} & s32);
always @* begin
    for (s34 = 0; s34 < VLEN / 2; s34 = s34 + 1) begin
        s30[s34 * 2 +:2] = {2{vfdiv_dispatch_v0t[s34]}};
    end
end

always @* begin
    for (s35 = 0; s35 < VLEN / 4; s35 = s35 + 1) begin
        s31[s35 * 4 +:4] = {4{vfdiv_dispatch_v0t[s35]}};
    end
end

always @* begin
    for (s36 = 0; s36 < VLEN / 8; s36 = s36 + 1) begin
        s32[s36 * 8 +:8] = {8{vfdiv_dispatch_v0t[s36]}};
    end
end

assign s7 = vfdiv_dispatch_ctrl;
assign s15 = vfdiv_dispatch_frm;
assign s17 = vfdiv_dispatch_op1_hazard;
assign s11 = vfdiv_dispatch_vd_len;
assign s12 = vfdiv_dispatch_vs1_len;
assign s13 = vfdiv_dispatch_vs2_len;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s6 <= {39{1'b0}};
        s14 <= 3'd0;
        s16 <= 1'b0;
        s8 <= {VRF_LW{1'b0}};
        s9 <= {VRF_LW{1'b0}};
        s10 <= {VRF_LW{1'b0}};
    end
    else if (s19) begin
        s6 <= s7;
        s14 <= s15;
        s16 <= s17;
        s8 <= s11;
        s9 <= s12;
        s10 <= s13;
    end
end

assign s5 = s19 | veq_ex_byte_mask_srl;
assign s4 = s19 ? s33 : {{(DLEN / 8){1'b0}},s3[VLEN - 1:DLEN / 8]};
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s3 <= {VLEN{1'b0}};
    end
    else if (s5) begin
        s3 <= s4;
    end
end

assign s1 = (s28 & ~vfdiv_dispatch_op1_hazard) | (vfdiv_cmt_valid & f0_nxt_cmt & s18 & ~s23 & ~veq_ex_ready & s16);
assign s2 = s28 ? vfdiv_dispatch_op1 : vfdiv_cmt_op1;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s0 <= {XLEN{1'b0}};
    end
    else if (s1) begin
        s0 <= s2;
    end
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

