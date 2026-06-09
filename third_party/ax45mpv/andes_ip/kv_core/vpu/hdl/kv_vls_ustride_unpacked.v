// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_ustride_unpacked (
    vpu_vlsu_clk,
    vpu_reset_n,
    ustride_unpacked_req,
    ustride_unpacked_vd_beats,
    ustride_unpacked_ctrl,
    ustride_unpacked_start_buf_num,
    ustride_seg_rdata,
    ustride_seg_data_clr,
    ustride_seg_data_done,
    vlsbuf_useg_rptr,
    useg_occupied,
    vlsbuf_data_all,
    vlsbuf_ustride_unpacked_wsel,
    vlsbuf_ustride_unpacked_data_all
);
parameter VLEN = 512;
parameter DLEN = 512;
parameter BUF_DEPTH = 8;
parameter BUF_DEPTH_LOG2 = 3;
parameter VRF_LW = 3;
localparam USEG_FSM_BITS = 3;
localparam FSM_INVALID = 0;
localparam FSM_BUSY = 1;
localparam FSM_DONE = 2;
localparam BUF_DEPTH_SEG = BUF_DEPTH;
input vpu_vlsu_clk;
input vpu_reset_n;
input ustride_unpacked_req;
input [VRF_LW - 1:0] ustride_unpacked_vd_beats;
input [11 - 1:0] ustride_unpacked_ctrl;
input [BUF_DEPTH_LOG2 - 1:0] ustride_unpacked_start_buf_num;
output [DLEN - 1:0] ustride_seg_rdata;
input ustride_seg_data_clr;
input ustride_seg_data_done;
input [BUF_DEPTH - 1:0] vlsbuf_useg_rptr;
output useg_occupied;
input [DLEN * BUF_DEPTH - 1:0] vlsbuf_data_all;
output [BUF_DEPTH - 1:0] vlsbuf_ustride_unpacked_wsel;
output [DLEN * BUF_DEPTH - 1:0] vlsbuf_ustride_unpacked_data_all;





// ce5b2d60 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0;
wire s1;
reg s2;
reg [USEG_FSM_BITS - 1:0] s3;
reg [USEG_FSM_BITS - 1:0] s4;
wire [3:0] s5;
wire [2:0] s6;
wire [3:0] s7;
wire [BUF_DEPTH_LOG2 - 1:0] s8;
wire s9;
wire s10;
wire s11;
wire s12;
wire s13;
wire s14;
wire s15;
wire [1:0] s16;
wire s17;
wire s18;
wire s19;
wire s20;
wire s21;
wire s22;
wire s23;
wire [BUF_DEPTH_LOG2 - 1:0] s24;
wire [BUF_DEPTH_LOG2 - 1:0] s25;
wire [BUF_DEPTH_LOG2 - 1:0] s26;
reg [BUF_DEPTH_LOG2 - 1:0] s27;
wire [DLEN * BUF_DEPTH_SEG * 2 - 1:0] s28;
wire s29;
wire [3:0] s30;
wire [6:0] s31;
wire [63:0] s32;
wire s33;
reg [VRF_LW - 1:0] s34;
wire [VRF_LW - 1:0] s35;
wire s36;
wire s37;
wire [2:0] s38;
reg [2:0] s39;
wire s40;
wire s41;
wire s42;
wire s43;
wire [DLEN - 1:0] s44;
wire s45;
wire s46;
wire s47;
wire s48;
reg useg_occupied;
wire [DLEN * BUF_DEPTH_SEG - 1:0] s49;
wire [DLEN * 2 * BUF_DEPTH_SEG - 1:0] s50;
reg [DLEN * BUF_DEPTH_SEG - 1:0] s51;
wire [DLEN - 1:0] s52;
wire [DLEN - 1:0] s53;
wire [DLEN - 1:0] s54;
wire [DLEN - 1:0] s55;
wire [DLEN - 1:0] s56;
wire [DLEN - 1:0] s57;
wire [DLEN - 1:0] s58;
wire [DLEN - 1:0] s59;
wire [DLEN - 1:0] s60;
wire [DLEN - 1:0] s61;
wire [DLEN - 1:0] s62;
wire [DLEN - 1:0] s63;
wire [DLEN - 1:0] s64;
wire [DLEN - 1:0] s65;
wire [DLEN - 1:0] s66;
wire [DLEN - 1:0] s67;
wire [DLEN - 1:0] s68;
wire [DLEN - 1:0] s69;
wire [DLEN - 1:0] s70;
wire [DLEN - 1:0] s71;
wire [DLEN - 1:0] s72;
wire [DLEN - 1:0] s73;
wire [DLEN - 1:0] s74;
wire [DLEN - 1:0] s75;
wire [DLEN - 1:0] s76;
wire [DLEN - 1:0] s77;
wire [DLEN - 1:0] s78;
wire [DLEN - 1:0] s79;
wire [DLEN - 1:0] s80;
wire [DLEN - 1:0] s81;
wire [DLEN - 1:0] s82;
wire [DLEN - 1:0] s83;
wire [DLEN - 1:0] s84;
wire [DLEN - 1:0] s85;
wire [DLEN - 1:0] s86;
wire nds_unused_ov1;
kv_mux_onehot #(
    .N(4),
    .W(DLEN)
) u_nf2_data (
    .out(s80),
    .sel({s20,s19,s18,s17}),
    .in({s55,s54,s53,s52})
);
kv_mux_onehot #(
    .N(4),
    .W(DLEN)
) u_nf3_data (
    .out(s81),
    .sel({s20,s19,s18,s17}),
    .in({s59,s58,s57,s56})
);
kv_mux_onehot #(
    .N(4),
    .W(DLEN)
) u_nf4_data (
    .out(s82),
    .sel({s20,s19,s18,s17}),
    .in({s63,s62,s61,s60})
);
kv_mux_onehot #(
    .N(4),
    .W(DLEN)
) u_nf5_data (
    .out(s83),
    .sel({s20,s19,s18,s17}),
    .in({s67,s66,s65,s64})
);
kv_mux_onehot #(
    .N(4),
    .W(DLEN)
) u_nf6_data (
    .out(s84),
    .sel({s20,s19,s18,s17}),
    .in({s71,s70,s69,s68})
);
kv_mux_onehot #(
    .N(4),
    .W(DLEN)
) u_nf7_data (
    .out(s85),
    .sel({s20,s19,s18,s17}),
    .in({s75,s74,s73,s72})
);
kv_mux_onehot #(
    .N(4),
    .W(DLEN)
) u_nf8_data (
    .out(s86),
    .sel({s20,s19,s18,s17}),
    .in({s79,s78,s77,s76})
);
kv_mux_onehot #(
    .N(7),
    .W(DLEN)
) u_ustride_seg_wdata (
    .out(s44),
    .sel({s15,s14,s13,s12,s11,s10,s9}),
    .in({s86,s85,s84,s83,s82,s81,s80})
);
kv_dff_gen #(
    .W(DLEN)
) u_ustride_seg_data (
    .clk(vpu_vlsu_clk),
    .en(s43),
    .d(s44),
    .q(ustride_seg_rdata)
);
kv_zero_ext #(
    .OW(DLEN * BUF_DEPTH_SEG * 2),
    .IW(DLEN * BUF_DEPTH_SEG)
) u_vlsbuf_data_all_zext (
    .out(s28),
    .in(vlsbuf_data_all[BUF_DEPTH_SEG * DLEN - 1:0])
);
assign s0 = s3[FSM_BUSY];
assign s1 = s3[FSM_DONE];
always @* begin
    s4 = {USEG_FSM_BITS{1'b0}};
    case (1'b1)
        s3[FSM_INVALID]: begin
            s2 = ustride_unpacked_req;
            s4[FSM_BUSY] = 1'b1;
        end
        s3[FSM_BUSY]: begin
            s2 = s43 & s22;
            s4[FSM_DONE] = 1'b1;
        end
        s3[FSM_DONE]: begin
            s2 = ustride_seg_data_done;
            s4[FSM_INVALID] = 1'b1;
        end
        default: begin
            s2 = 1'b0;
            s4 = {USEG_FSM_BITS{1'b0}};
        end
    endcase
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s3 <= {{USEG_FSM_BITS - 1{1'b0}},1'b1};
    end
    else if (s2) begin
        s3 <= s4;
    end
end

assign s41 = s0;
assign s42 = (useg_occupied & ustride_seg_data_clr) | (~useg_occupied);
assign s43 = s41 & s42;
assign s29 = s0 & s36 & (ustride_seg_data_clr | (~useg_occupied));
assign s30 = (1'b1 << s16);
assign s31 = {s30,3'b0};
assign s50 = s28 >> s31;
assign s49 = s50[DLEN * BUF_DEPTH_SEG - 1:0] | {s32,{DLEN * BUF_DEPTH_SEG - 64{1'b0}}};
generate
    if (BUF_DEPTH > BUF_DEPTH_SEG) begin:gen_buf_gt_buf_seg
        assign vlsbuf_ustride_unpacked_data_all = {{DLEN * (BUF_DEPTH - BUF_DEPTH_SEG){1'b0}},s49};
    end
    else begin:gen_buf_eq_buf_seg
        assign vlsbuf_ustride_unpacked_data_all = s49;
    end
endgenerate
assign vlsbuf_ustride_unpacked_wsel = {BUF_DEPTH{s29}} & vlsbuf_useg_rptr;
assign s21 = (s34 == {VRF_LW{1'b0}}) & (s39 == 3'b0);
assign s22 = s36 & s40;
assign s23 = s43;
assign s24 = s21 ? ustride_unpacked_start_buf_num : s27;
assign {nds_unused_ov1,s25} = s24 + s8[BUF_DEPTH_LOG2 - 1:0];
assign s26 = s36 ? ustride_unpacked_start_buf_num : s25;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s27 <= {BUF_DEPTH_LOG2{1'b0}};
    end
    else if (s23) begin
        s27 <= s26;
    end
end

assign s33 = s43;
assign s35 = s36 ? {VRF_LW{1'b0}} : s34 + {{VRF_LW - 1{1'b0}},1'b1};
assign s36 = (s34 == ustride_unpacked_vd_beats);
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s34 <= {VRF_LW{1'b0}};
    end
    else if (s33) begin
        s34 <= s35;
    end
end

assign s37 = s43 & s36;
assign s38 = s22 ? 3'b0 : s39 + 3'b1;
assign s40 = (s39 == s6);
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s39 <= 3'b0;
    end
    else if (s37) begin
        s39 <= s38;
    end
end

assign s45 = s0;
assign s46 = ustride_seg_data_clr & s1;
assign s47 = s45 | s46;
assign s48 = s46 ? 1'b0 : 1'b1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        useg_occupied <= 1'b0;
    end
    else if (s47) begin
        useg_occupied <= s48;
    end
end

generate
    if (BUF_DEPTH == 8) begin:gen_buf8_useg_data_sel
        always @* begin
            case (s24)
                3'd0: s51 = vlsbuf_data_all[DLEN * 8 - 1:0];
                3'd1: s51 = {vlsbuf_data_all[DLEN * 1 - 1:0],vlsbuf_data_all[DLEN * 8 - 1:DLEN * 1]};
                3'd2: s51 = {vlsbuf_data_all[DLEN * 2 - 1:0],vlsbuf_data_all[DLEN * 8 - 1:DLEN * 2]};
                3'd3: s51 = {vlsbuf_data_all[DLEN * 3 - 1:0],vlsbuf_data_all[DLEN * 8 - 1:DLEN * 3]};
                3'd4: s51 = {vlsbuf_data_all[DLEN * 4 - 1:0],vlsbuf_data_all[DLEN * 8 - 1:DLEN * 4]};
                3'd5: s51 = {vlsbuf_data_all[DLEN * 5 - 1:0],vlsbuf_data_all[DLEN * 8 - 1:DLEN * 5]};
                3'd6: s51 = {vlsbuf_data_all[DLEN * 6 - 1:0],vlsbuf_data_all[DLEN * 8 - 1:DLEN * 6]};
                3'd7: s51 = {vlsbuf_data_all[DLEN * 7 - 1:0],vlsbuf_data_all[DLEN * 8 - 1:DLEN * 7]};
                default: begin
                    s51 = {DLEN * BUF_DEPTH_SEG{1'b0}};
                end
            endcase
        end

    end
    else if (BUF_DEPTH == 16) begin:gen_buf16_useg_data_sel
        always @* begin
            case (s24)
                4'd0: s51 = vlsbuf_data_all[DLEN * 16 - 1:0];
                4'd1: s51 = {vlsbuf_data_all[DLEN * 1 - 1:0],vlsbuf_data_all[DLEN * 16 - 1:DLEN * 1]};
                4'd2: s51 = {vlsbuf_data_all[DLEN * 2 - 1:0],vlsbuf_data_all[DLEN * 16 - 1:DLEN * 2]};
                4'd3: s51 = {vlsbuf_data_all[DLEN * 3 - 1:0],vlsbuf_data_all[DLEN * 16 - 1:DLEN * 3]};
                4'd4: s51 = {vlsbuf_data_all[DLEN * 4 - 1:0],vlsbuf_data_all[DLEN * 16 - 1:DLEN * 4]};
                4'd5: s51 = {vlsbuf_data_all[DLEN * 5 - 1:0],vlsbuf_data_all[DLEN * 16 - 1:DLEN * 5]};
                4'd6: s51 = {vlsbuf_data_all[DLEN * 6 - 1:0],vlsbuf_data_all[DLEN * 16 - 1:DLEN * 6]};
                4'd7: s51 = {vlsbuf_data_all[DLEN * 7 - 1:0],vlsbuf_data_all[DLEN * 16 - 1:DLEN * 7]};
                4'd8: s51 = {vlsbuf_data_all[DLEN * 8 - 1:0],vlsbuf_data_all[DLEN * 16 - 1:DLEN * 8]};
                4'd9: s51 = {vlsbuf_data_all[DLEN * 9 - 1:0],vlsbuf_data_all[DLEN * 16 - 1:DLEN * 9]};
                4'd10: s51 = {vlsbuf_data_all[DLEN * 10 - 1:0],vlsbuf_data_all[DLEN * 16 - 1:DLEN * 10]};
                4'd11: s51 = {vlsbuf_data_all[DLEN * 11 - 1:0],vlsbuf_data_all[DLEN * 16 - 1:DLEN * 11]};
                4'd12: s51 = {vlsbuf_data_all[DLEN * 12 - 1:0],vlsbuf_data_all[DLEN * 16 - 1:DLEN * 12]};
                4'd13: s51 = {vlsbuf_data_all[DLEN * 13 - 1:0],vlsbuf_data_all[DLEN * 16 - 1:DLEN * 13]};
                4'd14: s51 = {vlsbuf_data_all[DLEN * 14 - 1:0],vlsbuf_data_all[DLEN * 16 - 1:DLEN * 14]};
                4'd15: s51 = {vlsbuf_data_all[DLEN * 15 - 1:0],vlsbuf_data_all[DLEN * 16 - 1:DLEN * 15]};
                default: begin
                    s51 = {DLEN * BUF_DEPTH_SEG{1'b0}};
                end
            endcase
        end

    end
    else if (BUF_DEPTH == 32) begin:gen_buf32_useg_data_sel
        always @* begin
            case (s24)
                5'd0: s51 = vlsbuf_data_all[DLEN * 32 - 1:0];
                5'd1: s51 = {vlsbuf_data_all[DLEN * 1 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 1]};
                5'd2: s51 = {vlsbuf_data_all[DLEN * 2 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 2]};
                5'd3: s51 = {vlsbuf_data_all[DLEN * 3 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 3]};
                5'd4: s51 = {vlsbuf_data_all[DLEN * 4 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 4]};
                5'd5: s51 = {vlsbuf_data_all[DLEN * 5 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 5]};
                5'd6: s51 = {vlsbuf_data_all[DLEN * 6 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 6]};
                5'd7: s51 = {vlsbuf_data_all[DLEN * 7 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 7]};
                5'd8: s51 = {vlsbuf_data_all[DLEN * 8 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 8]};
                5'd9: s51 = {vlsbuf_data_all[DLEN * 9 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 9]};
                5'd10: s51 = {vlsbuf_data_all[DLEN * 10 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 10]};
                5'd11: s51 = {vlsbuf_data_all[DLEN * 11 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 11]};
                5'd12: s51 = {vlsbuf_data_all[DLEN * 12 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 12]};
                5'd13: s51 = {vlsbuf_data_all[DLEN * 13 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 13]};
                5'd14: s51 = {vlsbuf_data_all[DLEN * 14 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 14]};
                5'd15: s51 = {vlsbuf_data_all[DLEN * 15 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 15]};
                5'd16: s51 = {vlsbuf_data_all[DLEN * 16 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 16]};
                5'd17: s51 = {vlsbuf_data_all[DLEN * 17 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 17]};
                5'd18: s51 = {vlsbuf_data_all[DLEN * 18 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 18]};
                5'd19: s51 = {vlsbuf_data_all[DLEN * 19 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 19]};
                5'd20: s51 = {vlsbuf_data_all[DLEN * 20 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 20]};
                5'd21: s51 = {vlsbuf_data_all[DLEN * 21 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 21]};
                5'd22: s51 = {vlsbuf_data_all[DLEN * 22 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 22]};
                5'd23: s51 = {vlsbuf_data_all[DLEN * 23 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 23]};
                5'd24: s51 = {vlsbuf_data_all[DLEN * 24 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 24]};
                5'd25: s51 = {vlsbuf_data_all[DLEN * 25 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 25]};
                5'd26: s51 = {vlsbuf_data_all[DLEN * 26 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 26]};
                5'd27: s51 = {vlsbuf_data_all[DLEN * 27 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 27]};
                5'd28: s51 = {vlsbuf_data_all[DLEN * 28 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 28]};
                5'd29: s51 = {vlsbuf_data_all[DLEN * 29 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 29]};
                5'd30: s51 = {vlsbuf_data_all[DLEN * 30 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 30]};
                5'd31: s51 = {vlsbuf_data_all[DLEN * 31 - 1:0],vlsbuf_data_all[DLEN * 32 - 1:DLEN * 31]};
                default: begin
                    s51 = {DLEN * BUF_DEPTH_SEG{1'b0}};
                end
            endcase
        end

    end
    else if (BUF_DEPTH == 64) begin:gen_buf64_useg_data_sel
        always @* begin
            case (s24)
                6'd0: s51 = vlsbuf_data_all[DLEN * 64 - 1:0];
                6'd1: s51 = {vlsbuf_data_all[DLEN * 1 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 1]};
                6'd2: s51 = {vlsbuf_data_all[DLEN * 2 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 2]};
                6'd3: s51 = {vlsbuf_data_all[DLEN * 3 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 3]};
                6'd4: s51 = {vlsbuf_data_all[DLEN * 4 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 4]};
                6'd5: s51 = {vlsbuf_data_all[DLEN * 5 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 5]};
                6'd6: s51 = {vlsbuf_data_all[DLEN * 6 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 6]};
                6'd7: s51 = {vlsbuf_data_all[DLEN * 7 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 7]};
                6'd8: s51 = {vlsbuf_data_all[DLEN * 8 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 8]};
                6'd9: s51 = {vlsbuf_data_all[DLEN * 9 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 9]};
                6'd10: s51 = {vlsbuf_data_all[DLEN * 10 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 10]};
                6'd11: s51 = {vlsbuf_data_all[DLEN * 11 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 11]};
                6'd12: s51 = {vlsbuf_data_all[DLEN * 12 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 12]};
                6'd13: s51 = {vlsbuf_data_all[DLEN * 13 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 13]};
                6'd14: s51 = {vlsbuf_data_all[DLEN * 14 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 14]};
                6'd15: s51 = {vlsbuf_data_all[DLEN * 15 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 15]};
                6'd16: s51 = {vlsbuf_data_all[DLEN * 16 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 16]};
                6'd17: s51 = {vlsbuf_data_all[DLEN * 17 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 17]};
                6'd18: s51 = {vlsbuf_data_all[DLEN * 18 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 18]};
                6'd19: s51 = {vlsbuf_data_all[DLEN * 19 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 19]};
                6'd20: s51 = {vlsbuf_data_all[DLEN * 20 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 20]};
                6'd21: s51 = {vlsbuf_data_all[DLEN * 21 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 21]};
                6'd22: s51 = {vlsbuf_data_all[DLEN * 22 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 22]};
                6'd23: s51 = {vlsbuf_data_all[DLEN * 23 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 23]};
                6'd24: s51 = {vlsbuf_data_all[DLEN * 24 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 24]};
                6'd25: s51 = {vlsbuf_data_all[DLEN * 25 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 25]};
                6'd26: s51 = {vlsbuf_data_all[DLEN * 26 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 26]};
                6'd27: s51 = {vlsbuf_data_all[DLEN * 27 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 27]};
                6'd28: s51 = {vlsbuf_data_all[DLEN * 28 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 28]};
                6'd29: s51 = {vlsbuf_data_all[DLEN * 29 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 29]};
                6'd30: s51 = {vlsbuf_data_all[DLEN * 30 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 30]};
                6'd31: s51 = {vlsbuf_data_all[DLEN * 31 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 31]};
                6'd32: s51 = {vlsbuf_data_all[DLEN * 32 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 32]};
                6'd33: s51 = {vlsbuf_data_all[DLEN * 33 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 33]};
                6'd34: s51 = {vlsbuf_data_all[DLEN * 34 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 34]};
                6'd35: s51 = {vlsbuf_data_all[DLEN * 35 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 35]};
                6'd36: s51 = {vlsbuf_data_all[DLEN * 36 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 36]};
                6'd37: s51 = {vlsbuf_data_all[DLEN * 37 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 37]};
                6'd38: s51 = {vlsbuf_data_all[DLEN * 38 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 38]};
                6'd39: s51 = {vlsbuf_data_all[DLEN * 39 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 39]};
                6'd40: s51 = {vlsbuf_data_all[DLEN * 40 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 40]};
                6'd41: s51 = {vlsbuf_data_all[DLEN * 41 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 41]};
                6'd42: s51 = {vlsbuf_data_all[DLEN * 42 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 42]};
                6'd43: s51 = {vlsbuf_data_all[DLEN * 43 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 43]};
                6'd44: s51 = {vlsbuf_data_all[DLEN * 44 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 44]};
                6'd45: s51 = {vlsbuf_data_all[DLEN * 45 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 45]};
                6'd46: s51 = {vlsbuf_data_all[DLEN * 46 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 46]};
                6'd47: s51 = {vlsbuf_data_all[DLEN * 47 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 47]};
                6'd48: s51 = {vlsbuf_data_all[DLEN * 48 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 48]};
                6'd49: s51 = {vlsbuf_data_all[DLEN * 49 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 49]};
                6'd50: s51 = {vlsbuf_data_all[DLEN * 50 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 50]};
                6'd51: s51 = {vlsbuf_data_all[DLEN * 51 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 51]};
                6'd52: s51 = {vlsbuf_data_all[DLEN * 52 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 52]};
                6'd53: s51 = {vlsbuf_data_all[DLEN * 53 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 53]};
                6'd54: s51 = {vlsbuf_data_all[DLEN * 54 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 54]};
                6'd55: s51 = {vlsbuf_data_all[DLEN * 55 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 55]};
                6'd56: s51 = {vlsbuf_data_all[DLEN * 56 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 56]};
                6'd57: s51 = {vlsbuf_data_all[DLEN * 57 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 57]};
                6'd58: s51 = {vlsbuf_data_all[DLEN * 58 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 58]};
                6'd59: s51 = {vlsbuf_data_all[DLEN * 59 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 59]};
                6'd60: s51 = {vlsbuf_data_all[DLEN * 60 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 60]};
                6'd61: s51 = {vlsbuf_data_all[DLEN * 61 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 61]};
                6'd62: s51 = {vlsbuf_data_all[DLEN * 62 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 62]};
                6'd63: s51 = {vlsbuf_data_all[DLEN * 63 - 1:0],vlsbuf_data_all[DLEN * 64 - 1:DLEN * 63]};
                default: begin
                    s51 = {DLEN * BUF_DEPTH_SEG{1'b0}};
                end
            endcase
        end

    end
    assign s32 = ({64{s17}} & {vlsbuf_data_all[7:0],56'b0}) | ({64{s18}} & {vlsbuf_data_all[15:0],48'b0}) | ({64{s19}} & {vlsbuf_data_all[31:0],32'b0}) | ({64{s20}} & {vlsbuf_data_all[63:0]});
endgenerate
genvar i;
generate
    for (i = 0; i < DLEN / 8; i = i + 1) begin:gen_nfx_eew8_data
        assign s52[8 * i +:8] = s51[(8 * 2) * i +:8];
        assign s56[8 * i +:8] = s51[(8 * 3) * i +:8];
        assign s60[8 * i +:8] = s51[(8 * 4) * i +:8];
        assign s64[8 * i +:8] = s51[(8 * 5) * i +:8];
        assign s68[8 * i +:8] = s51[(8 * 6) * i +:8];
        assign s72[8 * i +:8] = s51[(8 * 7) * i +:8];
        assign s76[8 * i +:8] = s51[(8 * 8) * i +:8];
    end
    for (i = 0; i < DLEN / 16; i = i + 1) begin:gen_nfx_eew16_data
        assign s53[16 * i +:16] = s51[(16 * 2) * i +:16];
        assign s57[16 * i +:16] = s51[(16 * 3) * i +:16];
        assign s61[16 * i +:16] = s51[(16 * 4) * i +:16];
        assign s65[16 * i +:16] = s51[(16 * 5) * i +:16];
        assign s69[16 * i +:16] = s51[(16 * 6) * i +:16];
        assign s73[16 * i +:16] = s51[(16 * 7) * i +:16];
        assign s77[16 * i +:16] = s51[(16 * 8) * i +:16];
    end
    for (i = 0; i < DLEN / 32; i = i + 1) begin:gen_nfx_eew32_data
        assign s54[32 * i +:32] = s51[(32 * 2) * i +:32];
        assign s58[32 * i +:32] = s51[(32 * 3) * i +:32];
        assign s62[32 * i +:32] = s51[(32 * 4) * i +:32];
        assign s66[32 * i +:32] = s51[(32 * 5) * i +:32];
        assign s70[32 * i +:32] = s51[(32 * 6) * i +:32];
        assign s74[32 * i +:32] = s51[(32 * 7) * i +:32];
        assign s78[32 * i +:32] = s51[(32 * 8) * i +:32];
    end
    for (i = 0; i < DLEN / 64; i = i + 1) begin:gen_nfx_eew64_data
        assign s55[64 * i +:64] = s51[(64 * 2) * i +:64];
        assign s59[64 * i +:64] = s51[(64 * 3) * i +:64];
        assign s63[64 * i +:64] = s51[(64 * 4) * i +:64];
        assign s67[64 * i +:64] = s51[(64 * 5) * i +:64];
        assign s71[64 * i +:64] = s51[(64 * 6) * i +:64];
        assign s75[64 * i +:64] = s51[(64 * 7) * i +:64];
        assign s79[64 * i +:64] = s51[(64 * 8) * i +:64];
    end
endgenerate
assign s5 = ustride_unpacked_ctrl[7 +:4];
assign s6 = ustride_unpacked_ctrl[1 +:3];
assign s7 = ustride_unpacked_ctrl[1 +:3] + 3'b001;
generate
    if (BUF_DEPTH_LOG2 > 4) begin:gen_buf_depth_gt_4
        assign s8 = {{BUF_DEPTH_LOG2 - 4{1'b0}},s7};
    end
    else begin:gen_buf_depth_le_4
        assign s8 = s7[BUF_DEPTH_LOG2 - 1:0];
    end
endgenerate
assign s16 = ustride_unpacked_ctrl[5 +:2];
assign s17 = s5[0];
assign s18 = s5[1];
assign s19 = s5[2];
assign s20 = s5[3];
assign s9 = (s6 == 3'd1);
assign s10 = (s6 == 3'd2);
assign s11 = (s6 == 3'd3);
assign s12 = (s6 == 3'd4);
assign s13 = (s6 == 3'd5);
assign s14 = (s6 == 3'd6);
assign s15 = (s6 == 3'd7);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

