// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vmac_wb (
    vpu_vmac_clk,
    vpu_reset_n,
    wb_standby,
    wb_us_valid,
    wb_us_ready,
    wb_us_wdata,
    wb_us_bit_wen,
    wb_us_mask_wdata,
    wb_us_cmtted,
    wb_us_last,
    wb_us_skip,
    wb_us_flag_update,
    wb_us_flag,
    wb_us_flag_clr,
    exs_nxt_cmt,
    vmac_cmt_valid,
    vmac_cmt_kill,
    vmac_flag_set,
    vmac_vd_wvalid,
    vmac_vd_wdata,
    vmac_vd_wmask,
    vmac_vd_wready
);
parameter DLEN = 512;
localparam DBLEN = DLEN / 8;
input vpu_vmac_clk;
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
input wb_us_skip;
input [5:0] wb_us_flag;
input wb_us_flag_clr;
input wb_us_flag_update;
input vmac_cmt_valid;
input vmac_cmt_kill;
output [5:0] vmac_flag_set;
output vmac_vd_wvalid;
output [DLEN - 1:0] vmac_vd_wdata;
output [DBLEN - 1:0] vmac_vd_wmask;
input vmac_vd_wready;





// efe6061d rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg s0;
reg s1;
reg s2;
reg s3;
reg [DLEN - 1:0] s4;
reg [DLEN - 1:0] s5;
reg [DBLEN - 1:0] s6;
reg [DBLEN - 1:0] s7;
reg s8;
reg s9;
wire s10 = wb_us_valid & wb_us_ready;
wire [DLEN - 1:0] s11;
wire [DLEN - 1:0] s12;
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
wire s25;
wire s26;
wire [5:0] s27;
wire [5:0] s28;
reg [5:0] s29;
reg [5:0] s30;
wire s31;
wire s32;
reg [5:0] vmac_flag_set;
wire [5:0] s33;
reg [1:0] s34;
wire s35;
wire [1:0] s36;
wire [1:0] s37;
wire nds_unused_wptr_incr1_nx;
wire [1:0] s38;
wire nds_unused_wptr_incr3_nx;
reg [1:0] s39;
wire s40;
wire [1:0] s41;
wire [1:0] s42;
wire nds_unused_rptr_incr1_nx;
wire s43 = (s34[0] == s39[0]) & (s34[1] != s39[1]);
wire s44 = (s34[0] == s39[0]) & (s34[1] == s39[1]);
wire s45 = ~s43 & ~s44;
wire s46;
wire s47;
wire s48;
wire s49;
wire s50;
wire s51;
assign s51 = s39[0] ? s3 : s2;
assign s49 = s48 | (s43 & s34[0] & ~s8 & s9 & vmac_cmt_valid & vmac_cmt_kill) | (~s44 & ~s39[0] & ~s8 & vmac_cmt_valid & vmac_cmt_kill);
assign s50 = s48 | (s43 & ~s34[0] & ~s9 & s8 & vmac_cmt_valid & vmac_cmt_kill) | (~s44 & s39[0] & ~s9 & vmac_cmt_valid & vmac_cmt_kill);
assign s48 = (s43 & ~s8 & ~s9 & vmac_cmt_valid & vmac_cmt_kill & ~s39[0] & ~s0) | (s43 & ~s8 & ~s9 & vmac_cmt_valid & vmac_cmt_kill & s39[0] & ~s1);
assign s47 = (s43 & s39[0] & ~s8 & s9 & vmac_cmt_valid & vmac_cmt_kill) | (s43 & ~s39[0] & ~s9 & s8 & vmac_cmt_valid & vmac_cmt_kill);
assign s46 = (~s44 & ~s39[0] & ~s8 & vmac_cmt_valid & vmac_cmt_kill) | (~s44 & s39[0] & ~s9 & vmac_cmt_valid & vmac_cmt_kill);
assign s35 = s10 | s47;
assign {nds_unused_wptr_incr1_nx,s37} = s34 + 2'b01;
assign {nds_unused_wptr_incr3_nx,s38} = s34 + 2'b11;
assign s36 = s47 ? s38 : s37;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s34 <= 2'b0;
    end
    else if (s35) begin
        s34 <= s36;
    end
end

assign s40 = s48 | s46 | (~s44 & vmac_vd_wready) | (~s44 & s51);
assign {nds_unused_rptr_incr1_nx,s42} = s39 + 2'b01;
assign s41 = s48 ? s34 : s42;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s39 <= 2'b0;
    end
    else if (s40) begin
        s39 <= s41;
    end
end

assign exs_nxt_cmt = s44 | (s43 & ~s39[0] & ~s8 & ~s1 & ~s0) | (s43 & ~s39[0] & s8 & ~s9 & ~s1) | (s43 & ~s39[0] & s8 & s9) | (s43 & s39[0] & ~s9 & ~s0 & ~s1) | (s43 & s39[0] & s9 & ~s8 & ~s0) | (s43 & s39[0] & s9 & s8) | (s45 & ~s39[0] & ~s8 & ~s0) | (s45 & ~s39[0] & s8) | (s45 & s39[0] & ~s9 & ~s1) | (s45 & s39[0] & s9);
assign vmac_vd_wvalid = ~s44 & ~s51;
assign vmac_vd_wdata = ({DLEN{~s39[0]}} & s4) | ({DLEN{s39[0]}} & s5);
assign vmac_vd_wmask = ({DBLEN{~s39[0]}} & s6) | ({DBLEN{s39[0]}} & s7);
assign s11 = wb_us_bit_wen & {DLEN{~s34[0]}};
assign s12 = wb_us_bit_wen & {DLEN{s34[0]}};
assign s13 = ~s34[0] & s10;
assign s14 = s34[0] & s10;
generate
    genvar i;
    for (i = 0; i < DLEN; i = i + 1) begin:gen_vmac_vd_wdata
        always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s4[i] <= 1'b0;
            end
            else if (s11[i]) begin
                s4[i] <= wb_us_wdata[i];
            end
        end

        always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s5[i] <= 1'b0;
            end
            else if (s12[i]) begin
                s5[i] <= wb_us_wdata[i];
            end
        end

    end
endgenerate
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s6 <= {DBLEN{1'b0}};
    end
    else if (s13) begin
        s6 <= wb_us_mask_wdata;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s7 <= {DBLEN{1'b0}};
    end
    else if (s14) begin
        s7 <= wb_us_mask_wdata;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s0 <= 1'b0;
        s2 <= 1'b0;
    end
    else if (s13) begin
        s0 <= wb_us_last;
        s2 <= wb_us_skip;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s1 <= 1'b0;
        s3 <= 1'b0;
    end
    else if (s14) begin
        s1 <= wb_us_last;
        s3 <= wb_us_skip;
    end
end

assign s19 = (s13 & ~s34[0] & wb_us_cmtted) | (s13 & ~s34[0] & s44 & vmac_cmt_valid & ~wb_us_cmtted) | (s13 & ~s34[0] & ~s44 & ~wb_us_cmtted & s9 & s1 & vmac_cmt_valid) | (s13 & ~s34[0] & ~s44 & ~s9 & ~s1 & vmac_cmt_valid);
assign s20 = (s14 & s34[0] & wb_us_cmtted) | (s14 & s34[0] & s44 & vmac_cmt_valid & ~wb_us_cmtted) | (s14 & s34[0] & ~s44 & ~wb_us_cmtted & s8 & s0 & vmac_cmt_valid) | (s14 & s34[0] & ~s44 & ~s8 & ~s0 & vmac_cmt_valid);
assign s15 = s13 | (s43 & s39[0] & ~s1 & ~s8 & vmac_cmt_valid) | (s43 & s39[0] & s1 & s9 & ~s8 & vmac_cmt_valid) | (~s44 & ~s39[0] & ~s8 & vmac_cmt_valid);
assign s16 = s19 | (s43 & s39[0] & ~s1 & ~s8 & vmac_cmt_valid) | (s43 & s39[0] & s1 & s9 & ~s8 & vmac_cmt_valid) | (~s44 & ~s39[0] & ~s8 & vmac_cmt_valid);
assign s17 = s14 | (s43 & ~s39[0] & ~s0 & ~s9 & vmac_cmt_valid) | (s43 & ~s39[0] & s0 & s8 & ~s9 & vmac_cmt_valid) | (~s44 & s39[0] & ~s9 & vmac_cmt_valid);
assign s18 = s20 | (s43 & ~s39[0] & ~s0 & ~s9 & vmac_cmt_valid) | (s43 & ~s39[0] & s0 & s8 & ~s9 & vmac_cmt_valid) | (~s44 & s39[0] & ~s9 & vmac_cmt_valid);
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s8 <= 1'b0;
    end
    else if (s15) begin
        s8 <= s16;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s9 <= 1'b0;
    end
    else if (s17) begin
        s9 <= s18;
    end
end

assign s21 = wb_us_flag_update & ~s34[0];
assign s23 = s49 | (~s39[0] & ~s44 & vmac_vd_wready) | (~s39[0] & ~s44 & s2) | (s44 & vmac_cmt_valid & vmac_cmt_kill & wb_us_flag_clr) | (s45 & s39[0] & vmac_cmt_valid & vmac_cmt_kill & wb_us_flag_clr);
assign s27 = s23 ? 6'b0 : (s29 | wb_us_flag);
assign s25 = s21 | s23;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s29 <= 6'b0;
    end
    else if (s25) begin
        s29 <= s27;
    end
end

assign s22 = wb_us_flag_update & s34[0];
assign s24 = s50 | (s39[0] & ~s44 & vmac_vd_wready) | (s39[0] & ~s44 & s3) | (s44 & vmac_cmt_valid & vmac_cmt_kill & wb_us_flag_clr) | (s45 & ~s39[0] & vmac_cmt_valid & vmac_cmt_kill & wb_us_flag_clr);
assign s28 = s24 ? 6'b0 : (s30 | wb_us_flag);
assign s26 = s22 | s24;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s30 <= 6'b0;
    end
    else if (s26) begin
        s30 <= s28;
    end
end

assign wb_us_ready = ~s43;
assign s31 = |vmac_flag_set;
assign s33 = (vmac_vd_wvalid & vmac_vd_wready & s39[0]) ? s30 : (vmac_vd_wvalid & vmac_vd_wready & ~s39[0]) ? s29 : 6'b0;
assign s32 = (vmac_vd_wvalid & vmac_vd_wready) | s31;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vmac_flag_set <= 6'b0;
    end
    else if (s32) begin
        vmac_flag_set <= s33;
    end
end

assign wb_standby = s44 & ~(|vmac_flag_set);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

