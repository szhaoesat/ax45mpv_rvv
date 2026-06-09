// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfdiv_wb (
    vpu_vfdiv_clk,
    vpu_reset_n,
    exs_nxt_cmt,
    wb_standby,
    wb_us_valid,
    wb_us_ready,
    wb_us_wdata,
    wb_us_bit_wen,
    wb_us_mask_wdata,
    wb_us_cmtted,
    wb_us_last,
    wb_us_flag,
    wb_us_flag_clr,
    wb_us_flag_update,
    vfdiv_cmt_valid,
    vfdiv_cmt_kill,
    vfdiv_fflags_set,
    vfdiv_vd_wvalid,
    vfdiv_vd_wdata,
    vfdiv_vd_wmask,
    vfdiv_vd_wready
);
parameter DLEN = 512;
localparam DBLEN = DLEN / 8;
input vpu_vfdiv_clk;
input vpu_reset_n;
output wb_standby;
output exs_nxt_cmt;
input wb_us_valid;
output wb_us_ready;
input [DLEN - 1:0] wb_us_wdata;
input [DLEN - 1:0] wb_us_bit_wen;
input [DBLEN - 1:0] wb_us_mask_wdata;
input wb_us_cmtted;
input wb_us_last;
input [4:0] wb_us_flag;
input wb_us_flag_clr;
input wb_us_flag_update;
input vfdiv_cmt_valid;
input vfdiv_cmt_kill;
output [4:0] vfdiv_fflags_set;
output vfdiv_vd_wvalid;
output [DLEN - 1:0] vfdiv_vd_wdata;
output [DBLEN - 1:0] vfdiv_vd_wmask;
input vfdiv_vd_wready;





// 9a8f7b4d rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg s0;
reg s1;
reg [DLEN - 1:0] s2;
reg [DLEN - 1:0] s3;
reg [DBLEN - 1:0] s4;
reg [DBLEN - 1:0] s5;
reg s6;
reg s7;
wire s8 = wb_us_valid & wb_us_ready;
wire [DLEN - 1:0] s9;
wire [DLEN - 1:0] s10;
wire s11;
wire s12;
wire s13;
wire s14;
wire s15;
wire s16;
wire s17;
wire s18;
wire s19;
wire s20;
wire s21;
wire s22;
wire s23;
wire s24;
wire [4:0] s25;
wire [4:0] s26;
reg [4:0] s27;
reg [4:0] s28;
wire s29;
wire s30;
reg [4:0] vfdiv_fflags_set;
wire [4:0] s31;
reg [1:0] s32;
wire s33;
wire [1:0] s34;
reg [1:0] s35;
wire s36;
wire [1:0] s37;
wire s38 = (s32[0] == s35[0]) & (s32[1] != s35[1]);
wire s39 = (s32[0] == s35[0]) & (s32[1] == s35[1]);
wire s40 = ~s38 & ~s39;
wire s41;
wire s42;
wire s43;
wire s44;
wire s45;
wire s46;
assign s45 = s43 | (s38 & s32[0] & ~s6 & s7 & vfdiv_cmt_valid & vfdiv_cmt_kill) | (~s39 & ~s35[0] & ~s6 & vfdiv_cmt_valid & vfdiv_cmt_kill);
assign s46 = s43 | (s38 & ~s32[0] & ~s7 & s6 & vfdiv_cmt_valid & vfdiv_cmt_kill) | (~s39 & s35[0] & ~s7 & vfdiv_cmt_valid & vfdiv_cmt_kill);
assign s43 = (s38 & ~s6 & ~s7 & vfdiv_cmt_valid & vfdiv_cmt_kill & s35[0] & ~s1) | (s38 & ~s6 & ~s7 & vfdiv_cmt_valid & vfdiv_cmt_kill & ~s35[0] & ~s0);
assign s42 = (s38 & s35[0] & ~s6 & s7 & vfdiv_cmt_valid & vfdiv_cmt_kill) | (s38 & ~s35[0] & ~s7 & s6 & vfdiv_cmt_valid & vfdiv_cmt_kill);
assign s41 = (~s39 & ~s35[0] & ~s6 & vfdiv_cmt_valid & vfdiv_cmt_kill) | (~s39 & s35[0] & ~s7 & vfdiv_cmt_valid & vfdiv_cmt_kill);
assign s44 = vfdiv_cmt_valid & vfdiv_cmt_kill & exs_nxt_cmt & ~wb_us_cmtted;
wire [1:0] s47;
wire nds_unused_rptr_p1_co;
wire [1:0] s48;
wire nds_unused_wptr_p1_co;
wire [1:0] s49;
wire nds_unused_wptr_p3_co;
assign s33 = (s8 & ~s44) | s42;
assign {nds_unused_rptr_p1_co,s47} = s35 + 2'b01;
assign {nds_unused_wptr_p1_co,s48} = s32 + 2'b01;
assign {nds_unused_wptr_p3_co,s49} = s32 + 2'b11;
assign s34 = s42 ? s49 : s48;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s32 <= 2'b0;
    end
    else if (s33) begin
        s32 <= s34;
    end
end

assign s36 = s43 | s41 | (vfdiv_vd_wvalid & vfdiv_vd_wready);
assign s37 = s43 ? s32 : s47;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s35 <= 2'b0;
    end
    else if (s36) begin
        s35 <= s37;
    end
end

wire s50 = ~s35[0];
wire s51 = s35[0];
assign exs_nxt_cmt = s39 | (s38 & s51 & s6 & s0) | (s38 & s51 & ~s6 & ~s7 & ~s1 & ~s0) | (s38 & s51 & ~s6 & s7 & ~s0) | (s38 & s50 & s7 & s1) | (s38 & s50 & ~s7 & ~s6 & ~s0 & ~s1) | (s38 & s50 & ~s7 & s6 & ~s1) | (s40 & ~s35[0] & ~s6 & ~s0) | (s40 & ~s35[0] & s6 & s0) | (s40 & s35[0] & ~s7 & ~s1) | (s40 & s35[0] & s7 & s1);
assign vfdiv_vd_wvalid = ~s39;
assign vfdiv_vd_wdata = ({DLEN{~s35[0]}} & s2) | ({DLEN{s35[0]}} & s3);
assign vfdiv_vd_wmask = ({DBLEN{~s35[0]}} & s4) | ({DBLEN{s35[0]}} & s5);
assign s9 = wb_us_bit_wen & {DLEN{~s32[0]}};
assign s10 = wb_us_bit_wen & {DLEN{s32[0]}};
assign s11 = ~s32[0] & s8;
assign s12 = s32[0] & s8;
generate
    genvar i;
    for (i = 0; i < DLEN; i = i + 1) begin:gen_vfdiv_vd_wdata
        always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s2[i] <= 1'b0;
            end
            else if (s9[i]) begin
                s2[i] <= wb_us_wdata[i];
            end
        end

        always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s3[i] <= 1'b0;
            end
            else if (s10[i]) begin
                s3[i] <= wb_us_wdata[i];
            end
        end

    end
endgenerate
generate
    genvar j;
    for (j = 0; j < DLEN / 8; j = j + 1) begin:gen_vfdiv_vd_wmask
        always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s4[j] <= 1'b0;
            end
            else if (s9[j * 8]) begin
                s4[j] <= wb_us_mask_wdata[j];
            end
        end

        always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s5[j] <= 1'b0;
            end
            else if (s10[j * 8]) begin
                s5[j] <= wb_us_mask_wdata[j];
            end
        end

    end
endgenerate
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s0 <= 1'b0;
    end
    else if (s11) begin
        s0 <= wb_us_last;
    end
end

always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s1 <= 1'b0;
    end
    else if (s12) begin
        s1 <= wb_us_last;
    end
end

assign s17 = (s11 & ~s32[0] & wb_us_cmtted) | (s11 & ~s32[0] & s39 & vfdiv_cmt_valid & ~wb_us_cmtted) | (s11 & ~s32[0] & ~s39 & ~wb_us_cmtted & s7 & s1 & vfdiv_cmt_valid) | (s11 & ~s32[0] & ~s39 & ~s7 & ~s1 & vfdiv_cmt_valid);
assign s18 = (s12 & s32[0] & wb_us_cmtted) | (s12 & s32[0] & s39 & vfdiv_cmt_valid & ~wb_us_cmtted) | (s12 & s32[0] & ~s39 & ~wb_us_cmtted & s6 & s0 & vfdiv_cmt_valid) | (s12 & s32[0] & ~s39 & ~s6 & ~s0 & vfdiv_cmt_valid);
assign s13 = s11 | (s38 & s35[0] & ~s1 & ~s6 & vfdiv_cmt_valid) | (s38 & s35[0] & s1 & s7 & ~s6 & vfdiv_cmt_valid) | (~s39 & ~s35[0] & ~s6 & vfdiv_cmt_valid);
assign s14 = s17 | (s38 & s35[0] & ~s1 & ~s6 & vfdiv_cmt_valid) | (s38 & s35[0] & s1 & s7 & ~s6 & vfdiv_cmt_valid) | (~s39 & ~s35[0] & ~s6 & vfdiv_cmt_valid);
assign s15 = s12 | (s38 & ~s35[0] & ~s0 & ~s7 & vfdiv_cmt_valid) | (s38 & ~s35[0] & s0 & s6 & ~s7 & vfdiv_cmt_valid) | (~s39 & s35[0] & ~s7 & vfdiv_cmt_valid);
assign s16 = s18 | (s38 & ~s35[0] & ~s0 & ~s7 & vfdiv_cmt_valid) | (s38 & ~s35[0] & s0 & s6 & ~s7 & vfdiv_cmt_valid) | (~s39 & s35[0] & ~s7 & vfdiv_cmt_valid);
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s6 <= 1'b0;
    end
    else if (s13) begin
        s6 <= s14;
    end
end

always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s7 <= 1'b0;
    end
    else if (s15) begin
        s7 <= s16;
    end
end

assign s19 = wb_us_flag_update & ~s32[0];
assign s21 = s45 | (~s35[0] & vfdiv_vd_wvalid & vfdiv_vd_wready) | (s39 & vfdiv_cmt_valid & vfdiv_cmt_kill & wb_us_flag_clr) | (s40 & s35[0] & vfdiv_cmt_valid & vfdiv_cmt_kill & wb_us_flag_clr);
assign s25 = s21 ? 5'b0 : (s27 | wb_us_flag);
assign s23 = s19 | s21;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s27 <= 5'b0;
    end
    else if (s23) begin
        s27 <= s25;
    end
end

assign s20 = wb_us_flag_update & s32[0];
assign s22 = s46 | (s35[0] & vfdiv_vd_wvalid & vfdiv_vd_wready) | (s39 & vfdiv_cmt_valid & vfdiv_cmt_kill & wb_us_flag_clr) | (s40 & ~s35[0] & vfdiv_cmt_valid & vfdiv_cmt_kill & wb_us_flag_clr);
assign s26 = s22 ? 5'b0 : (s28 | wb_us_flag);
assign s24 = s20 | s22;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s28 <= 5'b0;
    end
    else if (s24) begin
        s28 <= s26;
    end
end

assign wb_us_ready = ~s38;
assign s29 = |vfdiv_fflags_set;
assign s31 = (vfdiv_vd_wvalid & vfdiv_vd_wready & s35[0]) ? s28 : (vfdiv_vd_wvalid & vfdiv_vd_wready & ~s35[0]) ? s27 : 5'b0;
assign s30 = (vfdiv_vd_wvalid & vfdiv_vd_wready) | s29;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vfdiv_fflags_set <= 5'b0;
    end
    else if (s30) begin
        vfdiv_fflags_set <= s31;
    end
end

assign wb_standby = s39 & ~(|vfdiv_fflags_set);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

