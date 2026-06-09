// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vsp_vs_ctrl (
    vpu_vsp_clk,
    vpu_reset_n,
    veq_dispatch_vs2st_grant,
    veq_dispatch_vs2st_idx,
    veq_cmt_vs2st_grant,
    veq_cmt_vs2st_kill,
    veq_cmt_vs2st_idx,
    vsp_vs3_rvalid,
    vsp_vs3_rready,
    vsp_vs3_rdata,
    vsp_vs3_rlast,
    vs3_wvalid,
    vs3_wready,
    vs3_wdata,
    vs3_wlast,
    vs3_widx,
    vsp_vs_ctrl_standby_ready
);
parameter DLEN = 512;
parameter VEQ_DEPTH = 4;
parameter VS3_DEPTH = 2;
parameter RAR_SUPPORT = 0;
input vpu_vsp_clk;
input vpu_reset_n;
input veq_dispatch_vs2st_grant;
input [VEQ_DEPTH - 1:0] veq_dispatch_vs2st_idx;
input veq_cmt_vs2st_grant;
input veq_cmt_vs2st_kill;
input [VEQ_DEPTH - 1:0] veq_cmt_vs2st_idx;
input vsp_vs3_rvalid;
output vsp_vs3_rready;
input [DLEN - 1:0] vsp_vs3_rdata;
input vsp_vs3_rlast;
output vs3_wvalid;
input vs3_wready;
output [DLEN - 1:0] vs3_wdata;
output vs3_wlast;
output [VEQ_DEPTH - 1:0] vs3_widx;
output vsp_vs_ctrl_standby_ready;





// ad5a64ee rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0;
wire nds_unused_wait_cmt_wready;
wire [VEQ_DEPTH - 1:0] s1;
wire s2;
wire s3;
wire [VEQ_DEPTH - 1:0] s4;
wire s5;
wire nds_unused_cmted_wready;
wire [VEQ_DEPTH - 1:0] s6;
wire s7;
wire s8;
wire [VEQ_DEPTH - 1:0] s9;
wire [VS3_DEPTH - 1:0] s10;
wire [VS3_DEPTH - 1:0] s11;
wire [VS3_DEPTH * DLEN - 1:0] s12;
wire [VS3_DEPTH - 1:0] s13;
wire [VS3_DEPTH * VEQ_DEPTH - 1:0] s14;
wire [VS3_DEPTH - 1:0] s15;
wire [VS3_DEPTH - 1:0] s16;
wire [VS3_DEPTH * DLEN - 1:0] s17;
wire [VS3_DEPTH - 1:0] s18;
wire [VS3_DEPTH * VEQ_DEPTH - 1:0] s19;
wire [VS3_DEPTH - 1:0] s20;
wire s21;
wire s22;
wire s23;
reg [VS3_DEPTH - 1:0] s24;
reg [VS3_DEPTH - 1:0] s25;
assign s0 = veq_dispatch_vs2st_grant;
assign s1 = veq_dispatch_vs2st_idx;
assign s3 = veq_cmt_vs2st_grant & (veq_cmt_vs2st_idx == s4) | (~s7 & s22);
kv_fifo #(
    .DEPTH(VEQ_DEPTH),
    .WIDTH(VEQ_DEPTH)
) u_wait_cmt_idx (
    .clk(vpu_vsp_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wvalid(s0),
    .wready(nds_unused_wait_cmt_wready),
    .wdata(s1),
    .rvalid(s2),
    .rready(s3),
    .rdata(s4)
);
assign s5 = (veq_cmt_vs2st_grant & ~veq_cmt_vs2st_kill & s2 & (veq_cmt_vs2st_idx == s4) & ~s22) | (veq_cmt_vs2st_grant & ~veq_cmt_vs2st_kill & s2 & (veq_cmt_vs2st_idx == s4) & s22 & s7);
assign s6 = s4;
assign s8 = s22;
kv_fifo #(
    .DEPTH(VEQ_DEPTH),
    .WIDTH(VEQ_DEPTH)
) u_cmted_idx (
    .clk(vpu_vsp_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wvalid(s5),
    .wready(nds_unused_cmted_wready),
    .wdata(s6),
    .rvalid(s7),
    .rready(s8),
    .rdata(s9)
);
assign s21 = |(s10 & s11);
assign s22 = |(s10 & s11 & s13);
assign s23 = |(s15 & s16);
assign vsp_vs3_rready = |(s24 & s11);
always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s24 <= {{(VS3_DEPTH - 1){1'b0}},1'b1};
    end
    else if (s21) begin
        s24 <= {s24[VS3_DEPTH - 2:0],s24[VS3_DEPTH - 1]};
    end
end

always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s25 <= {{(VS3_DEPTH - 1){1'b0}},1'b1};
    end
    else if (s23) begin
        s25 <= {s25[VS3_DEPTH - 2:0],s25[VS3_DEPTH - 1]};
    end
end

genvar i;
generate
    for (i = 0; i < VS3_DEPTH; i = i + 1) begin:gen_vs3_buf
        reg s26;
        wire s27;
        wire s28;
        wire s29;
        reg s30;
        wire s31;
        wire s32;
        wire s33;
        reg [DLEN - 1:0] s34;
        reg s35;
        reg [VEQ_DEPTH - 1:0] s36;
        assign s10[i] = (s24[i] & vsp_vs3_rvalid & s7) | (s24[i] & vsp_vs3_rvalid & ~s7 & ~veq_cmt_vs2st_grant) | (s24[i] & vsp_vs3_rvalid & ~s7 & veq_cmt_vs2st_grant & ~veq_cmt_vs2st_kill) | (s24[i] & vsp_vs3_rvalid & ~s7 & veq_cmt_vs2st_grant & veq_cmt_vs2st_kill & ~(veq_cmt_vs2st_idx == s4));
        assign s11[i] = ~s26;
        assign s12[i * DLEN +:DLEN] = vsp_vs3_rdata;
        assign s13[i] = vsp_vs3_rlast;
        assign s14[i * VEQ_DEPTH +:VEQ_DEPTH] = s7 ? s9 : s4;
        assign s27 = (s10[i] & s11[i]);
        assign s28 = (s15[i] & s16[i]);
        assign s29 = s27;
        always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s26 <= 1'b0;
            end
            else if (s27 | s28) begin
                s26 <= s29;
            end
        end

        assign s31 = s26 & veq_cmt_vs2st_grant & veq_cmt_vs2st_kill & (s36 == veq_cmt_vs2st_idx);
        assign s32 = (s15[i] & s16[i]);
        assign s33 = s31 & ~s32;
        always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s30 <= 1'b0;
            end
            else if (s31 | s32) begin
                s30 <= s33;
            end
        end

        if (RAR_SUPPORT) begin:gen_vs3_buf_w_reset
            always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    s34 <= {DLEN{1'b0}};
                    s35 <= 1'b0;
                    s36 <= {VEQ_DEPTH{1'b0}};
                end
                else if (s27) begin
                    s34 <= s12[i * DLEN +:DLEN];
                    s35 <= s13[i];
                    s36 <= s14[i * VEQ_DEPTH +:VEQ_DEPTH];
                end
            end

        end
        else begin:gen_vs3_buf_wo_reset
            always @(posedge vpu_vsp_clk) begin
                if (s27) begin
                    s34 <= s12[i * DLEN +:DLEN];
                    s35 <= s13[i];
                    s36 <= s14[i * VEQ_DEPTH +:VEQ_DEPTH];
                end
            end

        end
        assign s15[i] = s26;
        assign s20[i] = s30;
        assign s16[i] = s25[i] & (vs3_wready | s30 | s31);
        assign s17[i * DLEN +:DLEN] = s34;
        assign s18[i] = s35;
        assign s19[i * VEQ_DEPTH +:VEQ_DEPTH] = s36;
    end
endgenerate
assign vs3_wvalid = |(s25 & s15 & ~s20);
kv_mux_onehot #(
    .N(VS3_DEPTH),
    .W(DLEN)
) u_vs3_wdata (
    .out(vs3_wdata),
    .sel(s25),
    .in(s17)
);
kv_mux_onehot #(
    .N(VS3_DEPTH),
    .W(1)
) u_vs3_wlast (
    .out(vs3_wlast),
    .sel(s25),
    .in(s18)
);
kv_mux_onehot #(
    .N(VS3_DEPTH),
    .W(VEQ_DEPTH)
) u_vs3_widx (
    .out(vs3_widx),
    .sel(s25),
    .in(s19)
);
assign vsp_vs_ctrl_standby_ready = ~(|s15) & ~s7 & ~s2;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

