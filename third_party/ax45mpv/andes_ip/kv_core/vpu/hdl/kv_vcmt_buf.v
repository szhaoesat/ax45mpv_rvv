// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vcmt_buf (
    vpu_clk,
    vpu_reset_n,
    vpu_req_valid,
    vpu_req_i0_fu,
    vpu_req_i1_fu,
    vpu_req_i0_srf,
    vpu_req_i1_srf,
    vpu_cmt_valid,
    vpu_cmt_kill,
    vpu_cmt_i0_op1,
    vpu_cmt_i1_op1,
    buf_i0_valid,
    buf_i0_kill,
    buf_i0_op1,
    buf_i0_fu,
    buf_i0_srf,
    buf_i0_ready,
    buf_i1_valid,
    buf_i1_kill,
    buf_i1_op1,
    buf_i1_fu,
    buf_i1_srf,
    buf_i1_ready
);
localparam XLEN = 64;
localparam DEPTH = 6;
localparam DW = XLEN + 1 + 11 + 1;
localparam CMT_FIFO_DW = 2 + 11 * 2 + 2;
localparam VPU_STATUS_BITS = 2;
input vpu_clk;
input vpu_reset_n;
input [1:0] vpu_req_valid;
input [11 - 1:0] vpu_req_i0_fu;
input [11 - 1:0] vpu_req_i1_fu;
input vpu_req_i0_srf;
input vpu_req_i1_srf;
input vpu_cmt_valid;
input [1:0] vpu_cmt_kill;
input [XLEN - 1:0] vpu_cmt_i0_op1;
input [XLEN - 1:0] vpu_cmt_i1_op1;
output buf_i0_valid;
output buf_i0_kill;
output [XLEN - 1:0] buf_i0_op1;
output [11 - 1:0] buf_i0_fu;
output buf_i0_srf;
input buf_i0_ready;
output buf_i1_valid;
output buf_i1_kill;
output [XLEN - 1:0] buf_i1_op1;
output [11 - 1:0] buf_i1_fu;
output buf_i1_srf;
input buf_i1_ready;





// e20fa31e rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [CMT_FIFO_DW - 1:0] s0;
wire s1;
wire s2;
wire [CMT_FIFO_DW - 1:0] s3;
wire s4;
wire s5;
wire [1:0] s6;
wire [11 - 1:0] s7;
wire [11 - 1:0] s8;
wire s9 = vpu_cmt_kill[0];
wire s10 = vpu_cmt_kill[1];
wire s11;
wire s12;
wire [1:0] wvalid;
wire [1:0] wready;
wire [1:0] s13 = wvalid & wready;
wire [DW - 1:0] s14;
wire [DW - 1:0] s15;
wire [1:0] rvalid;
wire [1:0] rready;
wire [1:0] s16 = rvalid & rready;
wire [DW - 1:0] s17;
wire [DW - 1:0] s18;
wire [DW * DEPTH - 1:0] s19;
wire [DW - 1:0] s20;
wire [DW - 1:0] s21;
reg [DEPTH - 1:0] s22;
wire [DEPTH - 1:0] s23;
wire s24;
wire [DEPTH - 1:0] s25 = {s22[DEPTH - 2:0],s22[DEPTH - 1]};
wire [DEPTH - 1:0] s26 = {s22[DEPTH - 3:0],s22[DEPTH - 1:DEPTH - 2]};
reg [DEPTH - 1:0] s27;
wire [DEPTH - 1:0] s28;
wire s29;
wire [DEPTH - 1:0] s30 = {s27[DEPTH - 2:0],s27[DEPTH - 1]};
wire [DEPTH - 1:0] s31 = {s27[DEPTH - 3:0],s27[DEPTH - 1:DEPTH - 2]};
reg [DEPTH - 1:0] s32;
wire [DEPTH - 1:0] s33;
wire s34;
wire [DEPTH + 1:0] s35;
wire [DEPTH + 1:0] s36;
wire s37 = vpu_cmt_valid;
kv_fifo #(
    .DEPTH(DEPTH),
    .WIDTH(CMT_FIFO_DW)
) u_cmt_fifo (
    .clk(vpu_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wdata(s0),
    .wvalid(s1),
    .wready(s2),
    .rdata(s3),
    .rvalid(s4),
    .rready(s5)
);
assign s1 = |vpu_req_valid;
assign s0 = {vpu_req_i1_srf,vpu_req_i0_srf,vpu_req_i1_fu,vpu_req_i0_fu,vpu_req_valid};
assign s5 = s37;
assign {s12,s11,s8,s7,s6} = s3;
assign wvalid[0] = vpu_cmt_valid & (s6[0] | s6[1]);
assign wvalid[1] = vpu_cmt_valid & (s6[0] & s6[1]);
assign s14 = s6[0] ? {s11,s7,s9,vpu_cmt_i0_op1} : {s12,s8,s10,vpu_cmt_i1_op1};
assign s15 = {s12,s8,s10,vpu_cmt_i1_op1};
assign wready = {2{1'b1}};
always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s32 <= {DEPTH{1'b0}};
    end
    else if (s34) begin
        s32 <= s33;
    end
end

always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s22 <= {{(DEPTH - 1){1'b0}},1'b1};
    end
    else if (s24) begin
        s22 <= s23;
    end
end

always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s27 <= {{(DEPTH - 1){1'b0}},1'b1};
    end
    else if (s29) begin
        s27 <= s28;
    end
end

assign s24 = s13[0];
assign s23 = s13[1] ? s26 : s25;
assign s29 = s16[0];
assign s28 = s16[1] ? s31 : s30;
assign s33 = s36[DEPTH - 1:0];
assign s36 = s16[1] ? {2'b0,s35[DEPTH + 1:2]} : s16[0] ? {1'b0,s35[DEPTH + 1:1]} : s35[DEPTH + 1:0];
assign s35 = wvalid[1] ? {s32[DEPTH - 1:0],2'd3} : wvalid[0] ? {1'b0,s32[DEPTH - 1:0],1'd1} : {2'b0,s32[DEPTH - 1:0]};
assign s34 = s16[0] | wvalid[0];
generate
    genvar i;
    for (i = 0; i < DEPTH; i = i + 1) begin:gen_ent
        reg [DW - 1:0] s38;
        wire s39;
        wire [DW - 1:0] s40;
        always @(posedge vpu_clk) begin
            if (s39) begin
                s38 <= s40;
            end
        end

        assign s39 = (s13[0] & s22[i]) | (s13[1] & s25[i]);
        assign s40 = s22[i] ? s14 : s15;
        assign s19[i * DW +:DW] = s38;
    end
endgenerate
kv_mux_onehot #(
    .N(DEPTH),
    .W(DW)
) u_mem_rdata0 (
    .out(s20),
    .sel(s27),
    .in(s19)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(DW)
) u_mem_rdata1 (
    .out(s21),
    .sel(s30),
    .in(s19)
);
assign rvalid[0] = s32[0] | wvalid[0];
assign rvalid[1] = s32[1] | (s32[0] & wvalid[0]) | wvalid[1];
assign s17 = s32[0] ? s20 : s14;
assign s18 = s32[1] ? s21 : s32[0] ? s14 : s15;
assign buf_i0_valid = rvalid[0];
assign buf_i1_valid = rvalid[1];
assign rready[0] = buf_i0_ready;
assign rready[1] = buf_i1_ready;
assign {buf_i0_srf,buf_i0_fu,buf_i0_kill,buf_i0_op1} = s17;
assign {buf_i1_srf,buf_i1_fu,buf_i1_kill,buf_i1_op1} = s18;
wire nds_unused_signal = |{s2,s4};
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

