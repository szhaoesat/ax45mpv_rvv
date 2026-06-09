// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_tlul_sizeup (
    us_a_opcode,
    us_a_param,
    us_a_user,
    us_a_size,
    us_a_address,
    us_a_source,
    us_a_data,
    us_a_mask,
    us_a_corrupt,
    us_a_valid,
    us_a_stall,
    us_a_ready,
    us_d_opcode,
    us_d_param,
    us_d_size,
    us_d_user,
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
    ds_a_data,
    ds_a_mask,
    ds_a_source,
    ds_a_corrupt,
    ds_a_valid,
    ds_a_stall,
    ds_a_ready,
    ds_d_opcode,
    ds_d_param,
    ds_d_user,
    ds_d_size,
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
parameter AW = 32;
parameter US_DW = 32;
parameter DS_DW = 64;
parameter OW = 2;
parameter IW = 2;
parameter A_UW = 2;
parameter D_UW = 2;
parameter OST_GET_NUM = 2;
parameter RAR_SUPPORT = 0;
localparam RATIO = DS_DW / US_DW;
localparam RATIO_LOG2 = $unsigned($clog2(RATIO));
input [2:0] us_a_opcode;
input [2:0] us_a_param;
input [A_UW - 1:0] us_a_user;
input [2:0] us_a_size;
input [AW - 1:0] us_a_address;
input [OW - 1:0] us_a_source;
input [US_DW - 1:0] us_a_data;
input [(US_DW / 8) - 1:0] us_a_mask;
input us_a_corrupt;
input us_a_valid;
input us_a_stall;
output us_a_ready;
output [2:0] us_d_opcode;
output [1:0] us_d_param;
output [2:0] us_d_size;
output [D_UW - 1:0] us_d_user;
output [US_DW - 1:0] us_d_data;
output [OW - 1:0] us_d_source;
output [IW - 1:0] us_d_sink;
output us_d_denied;
output us_d_corrupt;
output us_d_valid;
input us_d_ready;
output [2:0] ds_a_opcode;
output [2:0] ds_a_param;
output [A_UW - 1:0] ds_a_user;
output [2:0] ds_a_size;
output [AW - 1:0] ds_a_address;
output [DS_DW - 1:0] ds_a_data;
output [(DS_DW / 8) - 1:0] ds_a_mask;
output [OW - 1:0] ds_a_source;
output ds_a_corrupt;
output ds_a_valid;
output ds_a_stall;
input ds_a_ready;
input [2:0] ds_d_opcode;
input [1:0] ds_d_param;
input [D_UW - 1:0] ds_d_user;
input [2:0] ds_d_size;
input [DS_DW - 1:0] ds_d_data;
input [OW - 1:0] ds_d_source;
input [IW - 1:0] ds_d_sink;
input ds_d_denied;
input ds_d_corrupt;
input ds_d_valid;
output ds_d_ready;
input clk;
input resetn;





// 88eaa8e8 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire a_opcode_get = us_a_opcode == 3'd4;
wire d_opcode_accessackdata = us_d_opcode == 3'd1;
wire [OST_GET_NUM - 1:0] ent_d_hit;
wire [OST_GET_NUM - 1:0] ent_valid;
wire [OST_GET_NUM - 1:0] ent_invalid = ~ent_valid;
wire [OST_GET_NUM - 1:0] free_ptr;
wire ent_full = &ent_valid;
wire [(RATIO_LOG2 * OST_GET_NUM) - 1:0] ent_offset;
wire [RATIO_LOG2 - 1:0] us_a_offset = us_a_address[$clog2(US_DW / 8) +:$clog2(RATIO)];
wire [RATIO - 1:0] us_a_offset_oh;
wire [(DS_DW / 8) - 1:0] us_a_mmask;
wire [RATIO_LOG2 - 1:0] us_d_offset;
kv_bin2onehot #(
    .N(RATIO)
) u_us_a_offset_onehot (
    .out(us_a_offset_oh),
    .in(us_a_offset)
);
kv_bit_expand #(
    .N(RATIO),
    .M(US_DW / 8)
) u_us_a_mmask (
    .out(us_a_mmask),
    .in(us_a_offset_oh)
);
kv_mux_onehot #(
    .N(OST_GET_NUM),
    .W(RATIO_LOG2)
) u_d_offset (
    .out(us_d_offset),
    .sel(ent_d_hit),
    .in(ent_offset)
);
kv_mux #(
    .N(RATIO),
    .W(US_DW)
) u_us_d_data_mux (
    .out(us_d_data),
    .in(ds_d_data),
    .sel(us_d_offset)
);
assign ds_a_opcode = us_a_opcode;
assign ds_a_param = us_a_param;
assign ds_a_user = us_a_user;
assign ds_a_size = us_a_size;
assign ds_a_address = us_a_address;
assign ds_a_source = us_a_source;
assign ds_a_data = {RATIO{us_a_data}};
assign ds_a_mask = {RATIO{us_a_mask}} & us_a_mmask;
assign ds_a_corrupt = us_a_corrupt;
assign ds_a_valid = us_a_valid & ~ent_full;
assign ds_a_stall = us_a_stall;
assign us_a_ready = ds_a_ready & ~ent_full;
assign us_d_opcode = ds_d_opcode;
assign us_d_param = ds_d_param;
assign us_d_size = ds_d_size;
assign us_d_user = ds_d_user;
assign us_d_source = ds_d_source;
assign us_d_sink = ds_d_sink;
assign us_d_denied = ds_d_denied;
assign us_d_corrupt = ds_d_corrupt;
assign us_d_valid = ds_d_valid;
assign ds_d_ready = us_d_ready;
generate
    if (OST_GET_NUM > 1) begin:gen_free_ptr
        kv_ffs #(
            .WIDTH(OST_GET_NUM)
        ) u_free_ptr (
            .out(free_ptr),
            .in(ent_invalid)
        );
    end
    else begin:gen_free_ptr_stub
        assign free_ptr = ent_invalid[0];
    end
endgenerate
generate
    genvar j;
    for (j = 0; j < OST_GET_NUM; j = j + 1) begin:gen_ent
        reg valid;
        wire valid_set;
        wire valid_clr;
        wire valid_en;
        wire valid_nx;
        reg [OW - 1:0] source;
        reg [RATIO_LOG2 - 1:0] offset;
        always @(posedge clk or negedge resetn) begin
            if (!resetn) begin
                valid <= 1'b0;
            end
            else if (valid_en) begin
                valid <= valid_nx;
            end
        end

        if (RAR_SUPPORT) begin:gen_ent_w_reset
            always @(posedge clk or negedge resetn) begin
                if (!resetn) begin
                    source <= {OW{1'b0}};
                    offset <= {RATIO_LOG2{1'b0}};
                end
                else if (valid_set) begin
                    source <= us_a_source;
                    offset <= us_a_offset;
                end
            end

        end
        else begin:gen_ent_wo_reset
            always @(posedge clk) begin
                if (valid_set) begin
                    source <= us_a_source;
                    offset <= us_a_offset;
                end
            end

        end
        assign valid_en = valid_set | valid_clr;
        assign valid_set = us_a_valid & us_a_ready & ~us_a_stall & free_ptr[j] & a_opcode_get;
        assign valid_clr = ds_d_valid & ds_d_ready & ent_d_hit[j] & d_opcode_accessackdata;
        assign valid_nx = valid_set | (valid & ~valid_clr);
        assign ent_valid[j] = valid;
        assign ent_offset[j * RATIO_LOG2 +:RATIO_LOG2] = offset;
        assign ent_d_hit[j] = valid & (ds_d_source == source);
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

