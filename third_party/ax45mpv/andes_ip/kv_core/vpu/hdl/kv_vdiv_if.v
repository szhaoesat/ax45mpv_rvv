// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vdiv_if (
    vpu_vdiv_clk,
    vpu_reset_n,
    vdiv_dispatch_valid,
    vdiv_dispatch_op1,
    vdiv_dispatch_ctrl,
    vdiv_dispatch_v0t,
    vdiv_dispatch_op1_hazard,
    vdiv_dispatch_ready,
    vdiv_cmt_valid,
    vdiv_cmt_kill,
    vdiv_cmt_op1,
    vdiv_vs1_rdata,
    vdiv_vs1_rready,
    vdiv_vs1_rvalid,
    vdiv_vs1_rlast,
    vdiv_vs2_rdata,
    vdiv_vs2_rready,
    vdiv_vs2_rvalid,
    vdiv_vs2_rlast,
    e1_ex_valid,
    e1_ex_ready,
    e1_ex_id,
    e1_cmt_valid,
    e1_cmt_ready,
    e1_cmt_kill,
    e1_cmt_id,
    e1_vs_valid,
    e1_vs_ready,
    e1_vs_flush,
    e1_vs_last,
    e1_ex_mask,
    e1_ex_vrem,
    e1_ex_sign,
    e1_ex_sew,
    e1_ex_lmul,
    e1_ex_src1,
    e1_ex_src2,
    e1_ex_req
);
parameter VLEN = 512;
parameter DLEN = 11'h512;
parameter ELEN = 64;
parameter DEPTH = 64;
localparam CMT_FIFO_WIDTH = 65 + DEPTH;
localparam IF_DEPTH = 1;
localparam DIS_CTRL_WIDTH = 30 + VLEN + 65 + DEPTH;
localparam VLEN_F8 = VLEN / 8;
localparam BYTE_LMULF8 = VLEN_F8 / 8;
localparam BYTE_LMULF4 = VLEN_F8 / 4;
localparam BYTE_LMULF2 = VLEN_F8 / 2;
localparam VL_SEW8 = DLEN / 8;
localparam VL_SEW16 = DLEN / 16;
localparam VL_SEW32 = DLEN / 32;
localparam VL_SEW64 = DLEN / 64;
localparam VL_SBIT8 = $clog2(VL_SEW8);
localparam VL_SBIT16 = $clog2(VL_SEW16);
localparam VL_SBIT32 = $clog2(VL_SEW32);
localparam VL_SBIT64 = $clog2(VL_SEW64);
input vpu_vdiv_clk;
input vpu_reset_n;
input vdiv_dispatch_valid;
input [63:0] vdiv_dispatch_op1;
input [(30 - 1):0] vdiv_dispatch_ctrl;
input [VLEN - 1:0] vdiv_dispatch_v0t;
input vdiv_dispatch_op1_hazard;
output vdiv_dispatch_ready;
input vdiv_cmt_valid;
input vdiv_cmt_kill;
input [63:0] vdiv_cmt_op1;
input [(DLEN - 1):0] vdiv_vs1_rdata;
output vdiv_vs1_rready;
input vdiv_vs1_rvalid;
input vdiv_vs1_rlast;
input [(DLEN - 1):0] vdiv_vs2_rdata;
output vdiv_vs2_rready;
input vdiv_vs2_rvalid;
input vdiv_vs2_rlast;
output e1_ex_valid;
input e1_ex_ready;
output e1_ex_vrem;
output e1_ex_sign;
output [1:0] e1_ex_sew;
output [2:0] e1_ex_lmul;
output [DLEN - 1:0] e1_ex_mask;
output [DLEN - 1:0] e1_ex_src1;
output [DLEN - 1:0] e1_ex_src2;
output e1_vs_last;
output e1_vs_valid;
input e1_vs_ready;
input e1_vs_flush;
input e1_ex_req;
output e1_cmt_kill;
output e1_cmt_valid;
output [DEPTH - 1:0] e1_cmt_id;
output [DEPTH - 1:0] e1_ex_id;
input e1_cmt_ready;





// 1a97c207 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [DIS_CTRL_WIDTH - 1:0] vdiv_dispatch_wdata;
wire vdiv_dispatch_en;
wire [DEPTH - 1:0] vdiv_dispatch_nx;
reg [DEPTH - 1:0] vdiv_dispatch_id;
wire [CMT_FIFO_WIDTH - 1:0] vdiv_cmt_wdata;
wire nds_unused_vdiv_cmt_ready;
wire [DLEN - 1:0] vdiv_op1;
wire [63:0] vdiv_op1_sel;
wire vdiv_vs_flush;
wire [DEPTH - 1:0] e1_ex_id;
wire [(30 - 1):0] e1_ex_ctrl;
wire [63:0] e1_ex_op1;
wire e1_ex_op1_hazard;
reg [DIS_CTRL_WIDTH:0] e1_ex_rdata;
wire vs1_rvalid;
wire [DLEN - 1:0] vs1_rdata;
wire rs1_rvalid;
wire vs1_rready;
wire vs1_rlast;
wire vs2_rvalid;
wire [DLEN - 1:0] vs2_rdata;
wire vs2_rready;
wire vs2_rlast;
reg [DLEN + 1:0] vs1_rdata_reg;
reg [DLEN + 1:0] vs2_rdata_reg;
wire [63:0] e1_cmt_op1;
wire [CMT_FIFO_WIDTH - 1:0] e1_cmt_rdata;
wire e1_dis_grant;
wire e1_ex_rs;
wire [9:0] e1_ex_vstart;
wire [3:0] e1_ex_sew_onehot;
wire [VLEN - 1:0] e1_ex_v0t;
wire e1_ex_vm;
wire [10:0] e1_ex_vl;
wire e1_sew8;
wire e1_sew16;
wire e1_sew32;
wire e1_sew64;
wire e1_lmul_f8;
wire e1_lmul_f4;
wire e1_lmul_f2;
wire e1_lmul_1;
wire e1_lmul_2;
wire e1_lmul_4;
wire e1_lmul_8;
wire e1_lmul_g;
wire [DLEN - 1:0] v0t_vl_mask;
wire [DLEN - 1:0] v0t_byte1_mask;
reg [DLEN - 1:0] v0t_byte2_mask;
reg [DLEN - 1:0] v0t_byte4_mask;
reg [DLEN - 1:0] v0t_byte8_mask;
wire [DLEN - 1:0] v0t_vl_mask_byte;
wire [VLEN - 1:0] v0t_mask;
reg [VLEN - 1:0] v0t_mask_reg;
wire [VLEN - 1:0] v0t_mask_nx;
wire v0t_mask_en;
wire [VLEN - 1:0] v0t_mask_init;
wire [VLEN - 1:0] vmask_init;
wire [VLEN_F8 - 1:0] lmul_mask;
reg [VLEN_F8 - 1:0] lmul_mask_reg;
wire [VLEN_F8 - 1:0] lmul_mask_nx;
wire lmul_mask_en;
wire [VLEN_F8 - 1:0] lmul_mask_init;
wire [10:0] e1_vl_mask;
reg [10:0] e1_vl_mask_reg;
wire [10:0] e1_vl_mask_nx;
wire e1_vl_mask_en;
wire [10:0] e1_vl_mask_next;
wire [10:0] e1vl_shift;
wire [DLEN - 1:0] vl_mask;
wire vl_gt_dlen;
wire [VLEN - 1:0] vstart_mask;
wire nds_unused_e1_vl_mask_next;
assign vdiv_dispatch_en = vdiv_dispatch_valid & vdiv_dispatch_ready;
assign vdiv_dispatch_nx = {vdiv_dispatch_id[DEPTH - 2:0],vdiv_dispatch_id[DEPTH - 1]};
always @(posedge vpu_vdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vdiv_dispatch_id <= {{(DEPTH - 1){1'b0}},{1'b1}};
    end
    else if (vdiv_dispatch_en) begin
        vdiv_dispatch_id <= vdiv_dispatch_nx;
    end
end

assign vdiv_dispatch_ready = ~e1_ex_valid | e1_ex_ready;
always @(posedge vpu_vdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        e1_ex_rdata <= {(DIS_CTRL_WIDTH + 1){1'b0}};
    end
    else if (vdiv_dispatch_valid & vdiv_dispatch_ready) begin
        e1_ex_rdata <= {1'b1,vdiv_dispatch_wdata};
    end
    else if (vdiv_dispatch_ready) begin
        e1_ex_rdata <= {1'b0,vdiv_dispatch_wdata};
    end
end

assign {e1_ex_valid,e1_ex_ctrl,e1_ex_op1,e1_ex_op1_hazard,e1_ex_id,e1_ex_v0t} = e1_ex_rdata;
assign vdiv_dispatch_wdata = {vdiv_dispatch_ctrl,vdiv_dispatch_op1,vdiv_dispatch_op1_hazard,vdiv_dispatch_id,vdiv_dispatch_v0t};
assign e1_ex_sew = e1_ex_ctrl[4 +:2];
assign e1_ex_vrem = e1_ex_ctrl[19];
assign e1_ex_sign = e1_ex_ctrl[6];
assign e1_ex_rs = e1_ex_ctrl[3];
assign e1_ex_lmul = e1_ex_ctrl[0 +:3];
assign e1_ex_vstart = e1_ex_ctrl[20 +:10];
assign e1_ex_vm = e1_ex_ctrl[18];
assign e1_ex_vl = e1_ex_ctrl[7 +:11];
kv_bin2onehot #(
    .N(4)
) u_req_sew_onehot (
    .out(e1_ex_sew_onehot),
    .in(e1_ex_sew)
);
wire que1dis_rvalid = e1_ex_valid & ~e1_ex_ready;
reg que1dis_rvalid_d1;
assign e1_dis_grant = ~que1dis_rvalid_d1 & que1dis_rvalid;
always @(posedge vpu_vdiv_clk) begin
    que1dis_rvalid_d1 <= que1dis_rvalid;
end

wire vdiv_cmt_en;
wire [DEPTH - 1:0] vdiv_cmt_id_nx;
reg [DEPTH - 1:0] vdiv_cmt_id;
assign vdiv_cmt_en = vdiv_cmt_valid;
assign vdiv_cmt_id_nx = {vdiv_cmt_id[DEPTH - 2:0],vdiv_cmt_id[DEPTH - 1]};
always @(posedge vpu_vdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vdiv_cmt_id <= {{(DEPTH - 1){1'b0}},{1'b1}};
    end
    else if (vdiv_cmt_en) begin
        vdiv_cmt_id <= vdiv_cmt_id_nx;
    end
end

assign vdiv_cmt_wdata = {vdiv_cmt_kill,vdiv_cmt_op1,vdiv_cmt_id};
assign {e1_cmt_kill,e1_cmt_op1,e1_cmt_id} = e1_cmt_rdata;
kv_fifo #(
    .DEPTH(2),
    .WIDTH(CMT_FIFO_WIDTH)
) u_cmt_fifo (
    .clk(vpu_vdiv_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wvalid(vdiv_cmt_valid),
    .wdata(vdiv_cmt_wdata),
    .wready(nds_unused_vdiv_cmt_ready),
    .rvalid(e1_cmt_valid),
    .rdata(e1_cmt_rdata),
    .rready(e1_cmt_ready)
);
assign vdiv_vs1_rready = ~vs1_rvalid | vs1_rready;
assign vdiv_vs2_rready = ~vs2_rvalid | vs2_rready;
assign vdiv_vs_flush = e1_vs_flush;
assign vs1_rready = e1_vs_ready & ~e1_ex_rs;
assign vs2_rready = e1_vs_ready;
always @(posedge vpu_vdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vs1_rdata_reg <= {(DLEN + 2){1'b0}};
    end
    else if (vdiv_vs_flush) begin
        vs1_rdata_reg <= {1'b0,vdiv_vs1_rlast,vdiv_vs1_rdata};
    end
    else if (vdiv_vs1_rready & vdiv_vs1_rvalid) begin
        vs1_rdata_reg <= {1'b1,vdiv_vs1_rlast,vdiv_vs1_rdata};
    end
    else if (vdiv_vs1_rready) begin
        vs1_rdata_reg <= {1'b0,vdiv_vs1_rlast,vdiv_vs1_rdata};
    end
end

always @(posedge vpu_vdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vs2_rdata_reg <= {(DLEN + 2){1'b0}};
    end
    else if (vdiv_vs_flush) begin
        vs2_rdata_reg <= {1'b0,vdiv_vs2_rlast,vdiv_vs2_rdata};
    end
    else if (vdiv_vs2_rready & vdiv_vs2_rvalid) begin
        vs2_rdata_reg <= {1'b1,vdiv_vs2_rlast,vdiv_vs2_rdata};
    end
    else if (vdiv_vs2_rready) begin
        vs2_rdata_reg <= {1'b0,vdiv_vs2_rlast,vdiv_vs2_rdata};
    end
end

assign vs1_rvalid = vs1_rdata_reg[DLEN + 1];
assign vs2_rvalid = vs2_rdata_reg[DLEN + 1];
assign vs1_rlast = vs1_rdata_reg[DLEN];
assign vs2_rlast = vs2_rdata_reg[DLEN];
assign vs1_rdata = vs1_rdata_reg[DLEN - 1:0];
assign vs2_rdata = vs2_rdata_reg[DLEN - 1:0];
assign rs1_rvalid = ~e1_ex_op1_hazard & e1_ex_valid | e1_ex_op1_hazard & e1_cmt_valid & (e1_cmt_id == e1_ex_id) & e1_ex_valid;
assign e1_vs_valid = (~e1_ex_rs & vs2_rvalid & vs1_rvalid) | (e1_ex_rs & vs2_rvalid & rs1_rvalid);
assign e1_ex_src1 = e1_ex_rs ? vdiv_op1 : vs1_rdata;
assign e1_ex_src2 = vs2_rdata;
assign e1_vs_last = vs2_rlast & (e1_ex_rs | vs1_rlast);
assign vdiv_op1_sel = e1_ex_op1_hazard ? e1_cmt_op1 : e1_ex_op1;
assign vdiv_op1 = ({DLEN{e1_ex_sew_onehot[0]}} & {(DLEN / 8){vdiv_op1_sel[7:0]}}) | ({DLEN{e1_ex_sew_onehot[1]}} & {(DLEN / 16){vdiv_op1_sel[15:0]}}) | ({DLEN{e1_ex_sew_onehot[2]}} & {(DLEN / 32){vdiv_op1_sel[31:0]}}) | ({DLEN{e1_ex_sew_onehot[3]}} & {(DLEN / 64){vdiv_op1_sel[63:0]}});
assign e1_sew8 = e1_ex_sew_onehot[0];
assign e1_sew16 = e1_ex_sew_onehot[1];
assign e1_sew32 = e1_ex_sew_onehot[2];
assign e1_sew64 = e1_ex_sew_onehot[3];
assign e1_lmul_f8 = (e1_ex_lmul == 3'b101);
assign e1_lmul_f4 = (e1_ex_lmul == 3'b110);
assign e1_lmul_f2 = (e1_ex_lmul == 3'b111);
assign e1_lmul_1 = (e1_ex_lmul == 3'b000);
assign e1_lmul_2 = (e1_ex_lmul == 3'b001);
assign e1_lmul_4 = (e1_ex_lmul == 3'b010);
assign e1_lmul_8 = (e1_ex_lmul == 3'b011);
assign vstart_mask = {VLEN{1'b1}} << e1_ex_vstart;
assign v0t_mask = e1_dis_grant ? vmask_init : v0t_mask_reg;
always @(posedge vpu_vdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        v0t_mask_reg <= {VLEN{1'b0}};
    end
    else if (v0t_mask_en) begin
        v0t_mask_reg <= v0t_mask_nx;
    end
end

assign v0t_mask_en = e1_dis_grant | e1_ex_req;
assign v0t_mask_nx = e1_dis_grant ? vmask_init : (v0t_mask_reg >> e1vl_shift);
assign v0t_mask_init = e1_ex_v0t | {VLEN{e1_ex_vm}};
assign vmask_init = vstart_mask & v0t_mask_init;
assign e1_vl_mask = e1_dis_grant ? e1_ex_vl : e1_vl_mask_reg;
always @(posedge vpu_vdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        e1_vl_mask_reg <= 11'b0;
    end
    else if (e1_vl_mask_en) begin
        e1_vl_mask_reg <= e1_vl_mask_nx;
    end
end

assign e1_vl_mask_en = e1_dis_grant | e1_ex_req;
assign e1_vl_mask_nx = e1_dis_grant ? e1_ex_vl : e1_vl_mask_next;
assign e1vl_shift = ({11{e1_sew8}} & VL_SEW8[10:0]) | ({11{e1_sew16}} & VL_SEW16[10:0]) | ({11{e1_sew32}} & VL_SEW32[10:0]) | ({11{e1_sew64}} & VL_SEW64[10:0]);
assign vl_gt_dlen = (e1_sew8 & (|e1_vl_mask[VL_SBIT8 +:(11 - VL_SBIT8)])) | (e1_sew16 & (|e1_vl_mask[VL_SBIT16 +:(11 - VL_SBIT16)])) | (e1_sew32 & (|e1_vl_mask[VL_SBIT32 +:(11 - VL_SBIT32)])) | (e1_sew64 & (|e1_vl_mask[VL_SBIT64 +:(11 - VL_SBIT64)]));
assign {nds_unused_e1_vl_mask_next,e1_vl_mask_next} = vl_gt_dlen ? (e1_vl_mask_reg - e1vl_shift) : 12'b0;
assign vl_mask = vl_gt_dlen ? {DLEN{1'b1}} : (~({DLEN{1'b1}} << {e1_vl_mask[6:0]}));
assign lmul_mask = e1_dis_grant ? lmul_mask_init : lmul_mask_reg;
always @(posedge vpu_vdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        lmul_mask_reg <= {VLEN_F8{1'b0}};
    end
    else if (lmul_mask_en) begin
        lmul_mask_reg <= lmul_mask_nx;
    end
end

assign lmul_mask_en = e1_dis_grant | e1_ex_req;
assign lmul_mask_nx = e1_dis_grant ? lmul_mask_init : (lmul_mask_reg >> (DLEN / 8));
assign e1_lmul_g = e1_lmul_1 | e1_lmul_2 | e1_lmul_4 | e1_lmul_8;
assign lmul_mask_init = ({VLEN_F8{e1_lmul_f8}} & {{(VLEN_F8 - BYTE_LMULF8){1'b1}},{BYTE_LMULF8{1'b0}}}) | ({VLEN_F8{e1_lmul_f4}} & {{(VLEN_F8 - BYTE_LMULF4){1'b1}},{BYTE_LMULF4{1'b0}}}) | ({VLEN_F8{e1_lmul_f2}} & {{(VLEN_F8 - BYTE_LMULF2){1'b1}},{BYTE_LMULF2{1'b0}}}) | ({VLEN_F8{e1_lmul_g}} & {VLEN_F8{1'b0}});
assign v0t_vl_mask = v0t_mask[DLEN - 1:0] & vl_mask[DLEN - 1:0];
integer k;
integer l;
integer m;
assign v0t_byte1_mask = v0t_vl_mask;
always @* begin
    for (k = 0; k < DLEN / 2; k = k + 1) begin
        v0t_byte2_mask[k * 2 +:2] = {2{v0t_vl_mask[k]}};
    end
end

always @* begin
    for (l = 0; l < DLEN / 4; l = l + 1) begin
        v0t_byte4_mask[l * 4 +:4] = {4{v0t_vl_mask[l]}};
    end
end

always @* begin
    for (m = 0; m < DLEN / 8; m = m + 1) begin
        v0t_byte8_mask[m * 8 +:8] = {8{v0t_vl_mask[m]}};
    end
end

assign v0t_vl_mask_byte = ({DLEN{e1_sew8}} & v0t_byte1_mask) | ({DLEN{e1_sew16}} & v0t_byte2_mask) | ({DLEN{e1_sew32}} & v0t_byte4_mask) | ({DLEN{e1_sew64}} & v0t_byte8_mask);
assign e1_ex_mask[VLEN_F8 - 1:0] = v0t_vl_mask_byte[VLEN_F8 - 1:0] & ~lmul_mask;
assign e1_ex_mask[DLEN - 1:VLEN_F8] = v0t_vl_mask_byte[DLEN - 1:VLEN_F8];
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

