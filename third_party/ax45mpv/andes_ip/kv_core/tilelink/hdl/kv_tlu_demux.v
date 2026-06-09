// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_tlu_demux (
    us_a_sink,
    us_a_opcode,
    us_a_param,
    us_a_user,
    us_a_size,
    us_a_address,
    us_a_data,
    us_a_mask,
    us_a_source,
    us_a_corrupt,
    us_a_valid,
    us_a_ready,
    us_d_opcode,
    us_d_param,
    us_d_user,
    us_d_size,
    us_d_data,
    us_d_source,
    us_d_sink,
    us_d_denied,
    us_d_corrupt,
    us_d_valid,
    us_d_ready,
    ds_a_opcode,
    ds_a_param,
    ds_a_user,
    ds_a_size,
    ds_a_address,
    ds_a_source,
    ds_a_data,
    ds_a_mask,
    ds_a_corrupt,
    ds_a_valid,
    ds_a_ready,
    ds_d_opcode,
    ds_d_param,
    ds_d_size,
    ds_d_user,
    ds_d_data,
    ds_d_source,
    ds_d_sink,
    ds_d_denied,
    ds_d_corrupt,
    ds_d_valid,
    ds_d_ready,
    clk,
    resetn
);
parameter N = 2;
parameter AW = 32;
parameter DW = 32;
parameter TL_SIZE_WIDTH = 3;
parameter TL_SOURCE_WIDTH = 2;
parameter TL_SINK_WIDTH = 2;
parameter TL_A_USER_WIDTH = 2;
parameter TL_D_USER_WIDTH = 2;
localparam MAX_BYTE_LOG2 = {{32 - TL_SIZE_WIDTH{1'b0}},{TL_SIZE_WIDTH{1'b1}}};
localparam DATA_BYTE_WIDTH_LOG2 = $unsigned($clog2(DW / 8));
localparam BEAT_CNT_WIDTH = MAX_BYTE_LOG2 - DATA_BYTE_WIDTH_LOG2;
input [N - 1:0] us_a_sink;
input [2:0] us_a_opcode;
input [2:0] us_a_param;
input [TL_A_USER_WIDTH - 1:0] us_a_user;
input [TL_SIZE_WIDTH - 1:0] us_a_size;
input [AW - 1:0] us_a_address;
input [DW - 1:0] us_a_data;
input [(DW / 8) - 1:0] us_a_mask;
input [TL_SOURCE_WIDTH - 1:0] us_a_source;
input us_a_corrupt;
input us_a_valid;
output us_a_ready;
output [2:0] us_d_opcode;
output [1:0] us_d_param;
output [TL_D_USER_WIDTH - 1:0] us_d_user;
output [TL_SIZE_WIDTH - 1:0] us_d_size;
output [DW - 1:0] us_d_data;
output [TL_SOURCE_WIDTH - 1:0] us_d_source;
output [TL_SINK_WIDTH - 1:0] us_d_sink;
output us_d_denied;
output us_d_corrupt;
output us_d_valid;
input us_d_ready;
output [(3 * N) - 1:0] ds_a_opcode;
output [(3 * N) - 1:0] ds_a_param;
output [(TL_A_USER_WIDTH * N) - 1:0] ds_a_user;
output [(TL_SIZE_WIDTH * N) - 1:0] ds_a_size;
output [(AW * N) - 1:0] ds_a_address;
output [(TL_SOURCE_WIDTH * N) - 1:0] ds_a_source;
output [(DW * N) - 1:0] ds_a_data;
output [(DW * N / 8) - 1:0] ds_a_mask;
output [N - 1:0] ds_a_corrupt;
output [N - 1:0] ds_a_valid;
input [N - 1:0] ds_a_ready;
input [(3 * N) - 1:0] ds_d_opcode;
input [(2 * N) - 1:0] ds_d_param;
input [(TL_SIZE_WIDTH * N) - 1:0] ds_d_size;
input [(TL_D_USER_WIDTH * N) - 1:0] ds_d_user;
input [(DW * N) - 1:0] ds_d_data;
input [(TL_SOURCE_WIDTH * N) - 1:0] ds_d_source;
input [(TL_SINK_WIDTH * N) - 1:0] ds_d_sink;
input [N - 1:0] ds_d_denied;
input [N - 1:0] ds_d_corrupt;
input [N - 1:0] ds_d_valid;
output [N - 1:0] ds_d_ready;
input clk;
input resetn;





// d260ec40 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


assign ds_a_opcode = {N{us_a_opcode}};
assign ds_a_param = {N{us_a_param}};
assign ds_a_user = {N{us_a_user}};
assign ds_a_size = {N{us_a_size}};
assign ds_a_address = {N{us_a_address}};
assign ds_a_source = {N{us_a_source}};
assign ds_a_data = {N{us_a_data}};
assign ds_a_mask = {N{us_a_mask}};
assign ds_a_corrupt = {N{us_a_corrupt}};
assign ds_a_valid = {N{us_a_valid}} & us_a_sink;
kv_mux_onehot #(
    .N(N),
    .W(1)
) u_us_a_ready (
    .out(us_a_ready),
    .sel(us_a_sink),
    .in(ds_a_ready)
);
wire [N - 1:0] arb_d_valid;
wire [N - 1:0] arb_d_ready;
wire [N - 1:0] arb_d_last;
wire [N - 1:0] arb_d_grant;
wire arb_d_valid_out;
wire arb_d_en = us_d_valid & us_d_ready;
kv_arb_rr_mb #(
    .N(N)
) u_arb_d (
    .clk(clk),
    .resetn(resetn),
    .en(arb_d_en),
    .valid(arb_d_valid),
    .last(arb_d_last),
    .ready(arb_d_ready),
    .grant(arb_d_grant),
    .valid_out(arb_d_valid_out)
);
assign arb_d_valid = ds_d_valid;
assign arb_d_last = {N{1'b1}};
assign us_d_valid = arb_d_valid_out;
assign ds_d_ready = {N{us_d_ready}} & arb_d_ready;
kv_mux_onehot #(
    .N(N),
    .W(3)
) u_us_d_opcode (
    .out(us_d_opcode),
    .sel(arb_d_grant),
    .in(ds_d_opcode)
);
kv_mux_onehot #(
    .N(N),
    .W(2)
) u_us_d_param (
    .out(us_d_param),
    .sel(arb_d_grant),
    .in(ds_d_param)
);
kv_mux_onehot #(
    .N(N),
    .W(TL_D_USER_WIDTH)
) u_us_d_user (
    .out(us_d_user),
    .sel(arb_d_grant),
    .in(ds_d_user)
);
kv_mux_onehot #(
    .N(N),
    .W(TL_SIZE_WIDTH)
) u_us_d_size (
    .out(us_d_size),
    .sel(arb_d_grant),
    .in(ds_d_size)
);
kv_mux_onehot #(
    .N(N),
    .W(DW)
) u_us_d_data (
    .out(us_d_data),
    .sel(arb_d_grant),
    .in(ds_d_data)
);
kv_mux_onehot #(
    .N(N),
    .W(TL_SOURCE_WIDTH)
) u_us_d_source (
    .out(us_d_source),
    .sel(arb_d_grant),
    .in(ds_d_source)
);
kv_mux_onehot #(
    .N(N),
    .W(TL_SINK_WIDTH)
) u_us_d_sink (
    .out(us_d_sink),
    .sel(arb_d_grant),
    .in(ds_d_sink)
);
kv_mux_onehot #(
    .N(N),
    .W(1)
) u_us_d_denied (
    .out(us_d_denied),
    .sel(arb_d_grant),
    .in(ds_d_denied)
);
kv_mux_onehot #(
    .N(N),
    .W(1)
) u_us_d_corrupt (
    .out(us_d_corrupt),
    .sel(arb_d_grant),
    .in(ds_d_corrupt)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

