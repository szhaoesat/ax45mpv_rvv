// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vdiv64 (
    clk,
    rstn,
    vdiv_data64,
    vdiv_mask8,
    vdiv_ready,
    vdiv_idle,
    vdiv_busy,
    vdiv_busy_last,
    vsew,
    vdiv_valid,
    vdiv_wb_ready,
    vdiv_mask_byte8,
    vdiv_ex_ctrl,
    vdiv_op_sign,
    vdiv_src64_2,
    vdiv_src64_1
);
input clk;
input rstn;
output [63:0] vdiv_data64;
output [7:0] vdiv_mask8;
output vdiv_ready;
output vdiv_idle;
output vdiv_busy;
output vdiv_busy_last;
input [1:0] vsew;
input vdiv_valid;
input vdiv_wb_ready;
input [7:0] vdiv_mask_byte8;
input vdiv_ex_ctrl;
input vdiv_op_sign;
input [63:0] vdiv_src64_2;
input [63:0] vdiv_src64_1;





// e4e06ee1 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


localparam ST_DIV_IDLE = 2'b00;
localparam ST_DIV_ABS_OP1 = 2'b01;
localparam ST_DIV_SEQ_EXE = 2'b11;
localparam ST_DIV_CONVERT = 2'b10;
parameter ELEN = 64;
localparam SEW8 = 2'd0;
localparam SEW16 = 2'd1;
localparam SEW32 = 2'd2;
localparam SEW64 = 2'd3;
localparam EDIV1 = 2'd0;
wire [63:0] s0 = vdiv_src64_1;
reg [7:0] s1;
reg s2;
reg s3;
reg [1:0] s4;
reg [1:0] s5;
wire [7:0] s6;
reg [127:0] s7;
reg [127:0] s8;
wire [63:0] s9 = s7[(64 * 1) +:64];
wire [63:0] s10 = s7[(64 * 0) +:64];
reg [63:0] s11;
reg [63:0] s12;
reg [1:0] s13;
reg [1:0] s14;
wire s15 = (s14 == ST_DIV_IDLE);
wire s16 = (s14 == ST_DIV_ABS_OP1);
wire s17 = (s14 == ST_DIV_SEQ_EXE);
wire s18 = (s14 == ST_DIV_CONVERT);
wire s19 = s16 | s17;
wire s20;
wire [6:0] s21;
wire [6:0] s22;
reg [6:0] s23;
wire s24 = s23[6];
wire [7:0] s25;
reg [7:0] s26;
wire [7:0] s27;
wire [7:0] s28;
wire [7:0] s29;
wire [7:0] s30;
wire [7:0] s31;
wire [7:0] s32;
wire [63:0] s33;
wire [63:0] s34;
wire [63:0] s35;
wire [7:0] s36;
wire [7:0] s37;
wire [7:0] s38;
wire [7:0] s39;
wire nds_unused_wire = (|s36) | (|s37) | (|s38) | (|s39);
wire [1:0] s40 = 2'b0;
always @(posedge clk) begin
    if (vdiv_valid) begin
        s1 <= vdiv_mask_byte8;
        s2 <= vdiv_ex_ctrl;
        s3 <= vdiv_op_sign;
        s26 <= s27;
    end
end

generate
    genvar gi;
    for (gi = 0; gi < 8; gi = gi + 1) begin:gen_divisor
        always @(posedge clk or negedge rstn) begin
            if (!rstn) begin
                s11[(8 * gi) +:8] <= 8'b0;
            end
            else if (vdiv_valid & vdiv_mask_byte8[gi]) begin
                s11[(8 * gi) +:8] <= vdiv_src64_2[(8 * gi) +:8];
            end
        end

    end
endgenerate
assign s6 = s19 ? s1 : vdiv_valid ? vdiv_mask_byte8 : 8'b0;
generate
    for (gi = 0; gi < 8; gi = gi + 1) begin:gen_rem_quo
        always @(posedge clk or negedge rstn) begin
            if (!rstn) begin
                s7[64 + (8 * gi) +:8] <= 8'b0;
                s7[(8 * gi) +:8] <= 8'b0;
            end
            else if (s6[gi]) begin
                s7[64 + (8 * gi) +:8] <= s19 ? s8[64 + (8 * gi) +:8] : 8'b0;
                s7[(8 * gi) +:8] <= s19 ? s8[(8 * gi) +:8] : s0[(8 * gi) +:8];
            end
        end

    end
endgenerate
always @* begin
    case ({vsew[1:0],s40})
        {SEW16,EDIV1}: s5 = SEW16;
        {SEW32,EDIV1}: s5 = SEW32;
        {SEW64,EDIV1}: s5 = SEW64;
        default: s5 = SEW8;
    endcase
end

always @(posedge clk) begin
    if (vdiv_valid) begin
        s4 <= s5;
    end
end

wire s41 = (ELEN > 0) & (s4 == SEW8);
wire s42 = (ELEN > 8) & (s4 == SEW16);
wire s43 = (ELEN > 16) & (s4 == SEW32);
wire s44 = (ELEN > 32) & (s4 == SEW64);
wire [3:0] ssew_1hot = {s44,s43,s42,s41};
always @* begin
    case (s14)
        ST_DIV_ABS_OP1: s13 = ST_DIV_SEQ_EXE;
        ST_DIV_SEQ_EXE: s13 = s24 ? ST_DIV_CONVERT : s14;
        ST_DIV_CONVERT: s13 = vdiv_wb_ready ? (vdiv_valid ? ST_DIV_ABS_OP1 : ST_DIV_IDLE) : ST_DIV_CONVERT;
        default: s13 = vdiv_valid ? ST_DIV_ABS_OP1 : s14;
    endcase
end

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        s14 <= ST_DIV_IDLE;
    end
    else if (vdiv_valid | !s15) begin
        s14 <= s13;
    end
end

assign s20 = s16 | ~s24;
assign s22 = ({7{s44}} & 7'b000_0001) | ({7{s43}} & 7'b010_0001) | ({7{s42}} & 7'b011_0001) | ({7{s41}} & 7'b011_1001);
assign s21 = s16 ? s22 : s23 + 7'b1;
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        s23 <= 7'b0;
    end
    else if (s20) begin
        s23 <= s21;
    end
end

assign s27 = {vdiv_op_sign & s0[8 * 8 - 1],vdiv_op_sign & s0[8 * 7 - 1],vdiv_op_sign & s0[8 * 6 - 1],vdiv_op_sign & s0[8 * 5 - 1],vdiv_op_sign & s0[8 * 4 - 1],vdiv_op_sign & s0[8 * 3 - 1],vdiv_op_sign & s0[8 * 2 - 1],vdiv_op_sign & s0[8 * 1 - 1]};
assign s28 = {s3 & s11[8 * 8 - 1],s3 & s11[8 * 7 - 1],s3 & s11[8 * 6 - 1],s3 & s11[8 * 5 - 1],s3 & s11[8 * 4 - 1],s3 & s11[8 * 3 - 1],s3 & s11[8 * 2 - 1],s3 & s11[8 * 1 - 1]};
assign s25 = s26 & ~s30;
assign s29 = s25 ^ (s28 & {8{~s2}});
assign s30 = {(s41 & ~|s11[(8 * 8 - 1):8 * 7]) | (s42 & ~|s11[((16 * 4) - 1):16 * 3]) | (s43 & ~|s11[(32 * 2 - 1):32]) | (s44 & ~|s11[(64 - 1):0]),(s41 & ~|s11[(8 * 7 - 1):8 * 6]),(s41 & ~|s11[(8 * 6 - 1):8 * 5]) | (s42 & ~|s11[((16 * 3) - 1):16 * 2]),(s41 & ~|s11[(8 * 5 - 1):8 * 4]),(s41 & ~|s11[(8 * 4 - 1):8 * 3]) | (s42 & ~|s11[((16 * 2) - 1):16]) | (s43 & ~|s11[(32 - 1):0]),(s41 & ~|s11[(8 * 3 - 1):8 * 2]),(s41 & ~|s11[(8 * 2 - 1):8 * 1]) | (s42 & ~|s11[(16 - 1):0]),(s41 & ~|s11[(8 - 1):0])};
assign s31 = ~s28 | {8{~s17}};
reg [63:0] s45;
reg [7:0] s46;
wire [7:0] s47;
always @(posedge clk) begin
    if (s24 & s17) begin
        s46 <= s47;
    end
end

assign s34 = ({64{s16}} & 64'b0) | ({64{s17}} & s9) | ({64{s18}} & 64'b0);
assign s35 = ({64{s16}} & s10) | ({64{s17}} & s11) | ({64{s18}} & s45);
kv_vdiv_adder71 vdiv_adder(
    .sub(s31),
    .sign(1'b0),
    .ssew_1hot(ssew_1hot),
    .src1(s34),
    .src2(s35),
    .ci(8'b0),
    .rup(8'b0),
    .ovf(s36),
    .neg(s32),
    .zero(s37),
    .co(s38),
    .uco(s39),
    .sum(s33)
);
wire [31:0] s48[0:1];
wire [15:0] s49[0:3];
wire [7:0] s50[0:7];
wire [31:0] s51[0:1];
wire [15:0] s52[0:3];
wire [7:0] s53[0:7];
integer s54;
always @* begin
    casez (ssew_1hot)
        4'b1???: begin
            s8 = ({128{s16 & ~s25[7]}} & {s9[0 +:63],s10[0 +:64],1'b0}) | ({128{s16 & s25[7]}} & {s9[0 +:63],s33[0 +:64],1'b0}) | ({128{s17 & s32[7]}} & {s9[0 +:63],s10[0 +:64],1'b0}) | ({128{s17 & ~s32[7]}} & {s33[0 +:63],s10[0 +:64],1'b1});
            s45 = s2 ? {s46[7],s9[(64 * 0 + 1) +:64 - 1]} : s10;
            s12 = ({64{~s29[7]}} & s45) | ({64{s29[7]}} & s33);
        end
        4'b01??: begin
            s8 = {s48[1],s48[0],s51[1],s51[0]};
            for (s54 = 0; s54 < 2; s54 = s54 + 1) begin
                s45[(32 * s54) +:32] = s2 ? {s46[s54 * 4 + 3],s9[(32 * s54 + 1) +:32 - 1]} : s10[(32 * s54) +:32];
                s12[(32 * s54) +:32] = ({32{~s29[s54 * 4 + 3]}} & s45[(32 * s54) +:32]) | ({32{s29[s54 * 4 + 3]}} & s33[(32 * s54) +:32]);
            end
        end
        4'b001?: begin
            s8 = {s49[3],s49[2],s49[1],s49[0],s52[3],s52[2],s52[1],s52[0]};
            for (s54 = 0; s54 < 4; s54 = s54 + 1) begin
                s45[(16 * s54) +:16] = s2 ? {s46[s54 * 2 + 1],s9[(16 * s54 + 1) +:16 - 1]} : s10[(16 * s54) +:16];
                s12[(16 * s54) +:16] = ({16{~s29[s54 * 2 + 1]}} & s45[(16 * s54) +:16]) | ({16{s29[s54 * 2 + 1]}} & s33[(16 * s54) +:16]);
            end
        end
        default: begin
            s8 = {s50[7],s50[6],s50[5],s50[4],s50[3],s50[2],s50[1],s50[0],s53[7],s53[6],s53[5],s53[4],s53[3],s53[2],s53[1],s53[0]};
            for (s54 = 0; s54 < 8; s54 = s54 + 1) begin
                s45[(8 * s54) +:8] = s2 ? {s46[s54],s9[(8 * s54 + 1) +:8 - 1]} : s10[(8 * s54) +:8];
                s12[(8 * s54) +:8] = ({8{~s29[s54]}} & s45[(8 * s54) +:8]) | ({8{s29[s54]}} & s33[(8 * s54) +:8]);
            end
        end
    endcase
end

genvar k;
generate
    for (k = 0; k < 2; k = k + 1) begin:gen_rem_quo_nx_32
        assign s48[k] = ({32{s16 & ~s25[k * 4 + 3]}} & {s9[32 * k +:31],s10[32 * k + 31]}) | ({32{s16 & s25[k * 4 + 3]}} & {s9[32 * k +:31],s33[32 * k + 31]}) | ({32{s17 & s32[k * 4 + 1]}} & {s9[32 * k +:31],s10[32 * k + 31]}) | ({32{s17 & ~s32[k * 4 + 1]}} & {s33[32 * k +:31],s10[32 * k + 31]});
        assign s51[k] = ({32{s16 & ~s25[k * 4 + 3]}} & {s10[32 * k +:31],1'b0}) | ({32{s16 & s25[k * 4 + 3]}} & {s33[32 * k +:31],1'b0}) | ({32{s17 & s32[k * 4 + 1]}} & {s10[32 * k +:31],1'b0}) | ({32{s17 & ~s32[k * 4 + 1]}} & {s10[32 * k +:31],1'b1});
    end
endgenerate
generate
    for (k = 0; k < 4; k = k + 1) begin:gen_rem_quo_nx_16
        assign s49[k] = ({16{s16 & ~s25[k * 2 + 1]}} & {s9[16 * k +:15],s10[16 * k + 15]}) | ({16{s16 & s25[k * 2 + 1]}} & {s9[16 * k +:15],s33[16 * k + 15]}) | ({16{s17 & s32[k * 2]}} & {s9[16 * k +:15],s10[16 * k + 15]}) | ({16{s17 & ~s32[k * 2]}} & {s33[16 * k +:15],s10[16 * k + 15]});
        assign s52[k] = ({16{s16 & ~s25[k * 2 + 1]}} & {s10[16 * k +:15],1'b0}) | ({16{s16 & s25[k * 2 + 1]}} & {s33[16 * k +:15],1'b0}) | ({16{s17 & s32[k * 2]}} & {s10[16 * k +:15],1'b0}) | ({16{s17 & ~s32[k * 2]}} & {s10[16 * k +:15],1'b1});
    end
endgenerate
generate
    for (k = 0; k < 8; k = k + 1) begin:gen_rem_quo_nx_8
        assign s50[k] = ({8{s16 & ~s25[k]}} & {s9[8 * k +:7],s10[8 * k + 7]}) | ({8{s16 & s25[k]}} & {s9[8 * k +:7],s33[8 * k + 7]}) | ({8{s17 & s32[k]}} & {s9[8 * k +:7],s10[8 * k + 7]}) | ({8{s17 & ~s32[k]}} & {s33[8 * k +:7],s10[8 * k + 7]});
        assign s53[k] = ({8{s16 & ~s25[k]}} & {s10[8 * k +:7],1'b0}) | ({8{s16 & s25[k]}} & {s33[8 * k +:7],1'b0}) | ({8{s17 & s32[k]}} & {s10[8 * k +:7],1'b0}) | ({8{s17 & ~s32[k]}} & {s10[8 * k +:7],1'b1});
        assign s47[k] = s32[k] ? s9[8 * k + 7] : s33[8 * k + 7];
    end
endgenerate
assign vdiv_mask8 = s1;
assign vdiv_data64 = s12;
assign vdiv_ready = s18;
assign vdiv_idle = s15;
assign vdiv_busy_last = s24;
assign vdiv_busy = s16 | s17;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

