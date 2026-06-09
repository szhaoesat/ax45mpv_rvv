// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vsp_st_ctrl (
    vpu_vsp_clk,
    vpu_reset_n,
    veq2st_ctrl_valid,
    veq2st_ctrl_cmted,
    veq2st_ctrl_error,
    veq2st_ctrl_kill,
    veq2st_ctrl_idx,
    veq2st_ctrl_op1,
    veq2st_ctrl_op1_hazard,
    veq2st_ctrl_offset,
    veq2st_ctrl_cp_eew,
    veq2st_ctrl_rf_eew,
    veq2st_ctrl_emask,
    veq2st_ctrl_ratio,
    veq2st_source_op1,
    veq2st_source_vs,
    veq2st_source_dummy_start,
    veq2st_source_dummy_end,
    veq2st_destination_cp,
    veq2st_drop_vs,
    veq2st_cp_last,
    veq2st_path_bypass,
    veq2st_path_merge,
    veq2st_ctrl_rf_grant,
    veq2st_ctrl_cp_grant,
    vs3_wvalid,
    vs3_wready,
    vs3_wdata,
    vs3_wlast,
    vs3_widx,
    cpu_cp_wdata_valid,
    cpu_cp_wdata_ready,
    cpu_cp_wdata,
    cpu_cp_wdata_bwe,
    ace_streaming_data_out_valid,
    ace_streaming_data_out_ready,
    ace_streaming_data_out,
    ace_streaming_data_out_bwe,
    vsp_st_ctrl_standby_ready
);
parameter XLEN = 64;
parameter DLEN = 512;
parameter VSP_DATA_WIDTH = 512;
parameter VEQ_DEPTH = 4;
parameter ST_BUF_DEPTH = 2;
parameter OFFSET_BITS = $clog2(DLEN / 8);
parameter ACE_SP_MODE = 0;
parameter RAR_SUPPORT = 0;
input vpu_vsp_clk;
input vpu_reset_n;
input veq2st_ctrl_valid;
input veq2st_ctrl_cmted;
input veq2st_ctrl_error;
input veq2st_ctrl_kill;
input [VEQ_DEPTH - 1:0] veq2st_ctrl_idx;
input [XLEN - 1:0] veq2st_ctrl_op1;
input veq2st_ctrl_op1_hazard;
input [OFFSET_BITS - 1:0] veq2st_ctrl_offset;
input [2:0] veq2st_ctrl_cp_eew;
input [1:0] veq2st_ctrl_rf_eew;
input [(DLEN / 8) - 1:0] veq2st_ctrl_emask;
input [3:0] veq2st_ctrl_ratio;
input veq2st_source_op1;
input veq2st_source_vs;
input veq2st_source_dummy_start;
input veq2st_source_dummy_end;
input veq2st_destination_cp;
input veq2st_drop_vs;
input veq2st_cp_last;
input veq2st_path_bypass;
input veq2st_path_merge;
output veq2st_ctrl_rf_grant;
output veq2st_ctrl_cp_grant;
input vs3_wvalid;
output vs3_wready;
input [DLEN - 1:0] vs3_wdata;
input vs3_wlast;
input [VEQ_DEPTH - 1:0] vs3_widx;
output cpu_cp_wdata_valid;
input cpu_cp_wdata_ready;
output [(VSP_DATA_WIDTH - 1):0] cpu_cp_wdata;
output [(VSP_DATA_WIDTH / 8) - 1:0] cpu_cp_wdata_bwe;
output ace_streaming_data_out_valid;
input ace_streaming_data_out_ready;
output [(VSP_DATA_WIDTH - 1):0] ace_streaming_data_out;
output [(VSP_DATA_WIDTH / 8) - 1:0] ace_streaming_data_out_bwe;
output vsp_st_ctrl_standby_ready;





// 1f04c0a4 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [DLEN / 8 - 1:0] vs3_wvalid_eew;
wire [DLEN / 8 - 1:0] op1_wvalid_eew;
wire [DLEN - 1:0] vs3_wdata_eew;
wire [DLEN - 1:0] op1_wdata_eew;
wire [DLEN / 8 - 1:0] wmask_eew;
wire [((2 * DLEN) / 8) - 1:0] dummy_valid;
wire bypass_wvalid;
wire [(2 * DLEN) - 1:0] bypass_wdata;
wire [((2 * DLEN) / 8) - 1:0] bypass_wmask;
wire [(DLEN / 8) - 1:0] merge_wvalid;
wire [((2 * DLEN) / 8) - 1:0] merge_wvalid_shift;
wire [(DLEN / 8) - 1:0] merge_wvalid_fold;
wire [DLEN - 1:0] merge_wdata_fold;
wire [(DLEN / 8) - 1:0] merge_wmask_fold;
wire [(DLEN / 8) - 1:0] buffer_wvalid;
wire [(DLEN / 8) - 1:0] buffer_wready;
wire [DLEN - 1:0] buffer_wdata;
wire [(DLEN / 8) - 1:0] buffer_wmask;
wire buffer_flush;
wire [(DLEN / 8) - 1:0] buffer_rvalid;
wire [(DLEN / 8) - 1:0] buffer_rready;
wire [DLEN - 1:0] buffer_rdata;
wire [(DLEN / 8) - 1:0] buffer_rmask;
wire buffer_credit;
wire rf_cp_ratio_1v1;
wire rf_cp_ratio_2v1;
wire rf_cp_ratio_4v1;
wire rf_cp_ratio_8v1;
wire [7:0] touched_buffer;
wire cp_wvalid;
wire cp_wready;
wire [(DLEN - 1):0] cp_wdata;
wire [((DLEN / 8) - 1):0] cp_wmask;
wire cp_grant;
wire cp_buf_wdata_valid;
wire cp_buf_wdata_ready;
wire [(VSP_DATA_WIDTH - 1):0] cp_buf_wdata;
wire [(VSP_DATA_WIDTH / 8) - 1:0] cp_buf_wdata_bwe;
kv_vsp_sizedn #(
    .IW(DLEN / 8),
    .OW(DLEN / 8),
    .EW(1)
) u_vs3_wvalid_eew (
    .src_eew(veq2st_ctrl_rf_eew),
    .dst_eew(veq2st_ctrl_cp_eew[1:0]),
    .din({(DLEN / 8){vs3_wvalid}}),
    .dout(vs3_wvalid_eew)
);
kv_vsp_sizedn #(
    .IW(XLEN / 8),
    .OW(DLEN / 8),
    .EW(1)
) u_op1_wvalid_eew (
    .src_eew(veq2st_ctrl_rf_eew),
    .dst_eew(veq2st_ctrl_cp_eew[1:0]),
    .din({(XLEN / 8){1'b1}}),
    .dout(op1_wvalid_eew)
);
kv_vsp_sizedn #(
    .IW(DLEN),
    .OW(DLEN),
    .EW(8)
) u_vs3_wdata_eew (
    .src_eew(veq2st_ctrl_rf_eew),
    .dst_eew(veq2st_ctrl_cp_eew[1:0]),
    .din(vs3_wdata),
    .dout(vs3_wdata_eew)
);
kv_vsp_sizedn #(
    .IW(XLEN),
    .OW(DLEN),
    .EW(8)
) u_op1_wdata_eew (
    .src_eew(veq2st_ctrl_rf_eew),
    .dst_eew(veq2st_ctrl_cp_eew[1:0]),
    .din(veq2st_ctrl_op1),
    .dout(op1_wdata_eew)
);
kv_vsp_sizedn #(
    .IW(DLEN / 8),
    .OW(DLEN / 8),
    .EW(1)
) u_wmask_eew (
    .src_eew(veq2st_ctrl_rf_eew),
    .dst_eew(veq2st_ctrl_cp_eew[1:0]),
    .din(veq2st_ctrl_emask),
    .dout(wmask_eew)
);
assign dummy_valid = {{(DLEN / 8){1'b0}},{(DLEN / 8){1'b1}}} << veq2st_ctrl_offset;
assign vs3_wready = veq2st_source_vs & veq2st_ctrl_rf_grant & ~veq2st_source_dummy_start;
assign bypass_wvalid = veq2st_ctrl_valid & veq2st_path_bypass & veq2st_ctrl_cmted & ((veq2st_source_op1 & ~veq2st_ctrl_op1_hazard) | (veq2st_source_vs & vs3_wvalid & ~veq2st_drop_vs));
assign bypass_wdata = ({DLEN{veq2st_source_vs}} & vs3_wdata_eew) << {veq2st_ctrl_offset,3'b000} | ({DLEN{veq2st_source_op1}} & op1_wdata_eew) << {veq2st_ctrl_offset,3'b000};
assign bypass_wmask = wmask_eew << veq2st_ctrl_offset;
assign merge_wvalid_shift = merge_wvalid << veq2st_ctrl_offset;
genvar i;
generate
    for (i = 0; i < (DLEN / 8); i = i + 1) begin:gen_merge_path
        assign merge_wvalid[i] = veq2st_ctrl_valid & veq2st_path_merge & ((veq2st_source_op1 & op1_wvalid_eew[i] & ~veq2st_ctrl_op1_hazard) | (veq2st_source_vs & vs3_wvalid_eew[i] & ~veq2st_drop_vs));
        assign merge_wvalid_fold[i] = merge_wvalid_shift[i] | merge_wvalid_shift[(DLEN / 8) + i] | (veq2st_ctrl_valid & veq2st_path_merge & veq2st_source_dummy_start & dummy_valid[(DLEN / 8) + i]) | (veq2st_ctrl_valid & veq2st_path_merge & veq2st_source_dummy_end & dummy_valid[i]);
        assign merge_wdata_fold[i * 8 +:8] = bypass_wdata[i * 8 +:8] | bypass_wdata[DLEN + (i * 8) +:8];
        assign merge_wmask_fold[i] = ~veq2st_source_dummy_start & ~veq2st_source_dummy_end & (bypass_wmask[i] | bypass_wmask[(DLEN / 8) + i]);
    end
endgenerate
assign {rf_cp_ratio_8v1,rf_cp_ratio_4v1,rf_cp_ratio_2v1,rf_cp_ratio_1v1} = veq2st_ctrl_ratio;
assign touched_buffer[0] = ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b111) & (|veq2st_ctrl_offset[OFFSET_BITS - 4:0])) | ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b000) & (~&veq2st_ctrl_offset[OFFSET_BITS - 4:0]));
assign touched_buffer[1] = ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b000) & (|veq2st_ctrl_offset[OFFSET_BITS - 4:0])) | ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b001) & (~&veq2st_ctrl_offset[OFFSET_BITS - 4:0]));
assign touched_buffer[2] = ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b001) & (|veq2st_ctrl_offset[OFFSET_BITS - 4:0])) | ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b010) & (~&veq2st_ctrl_offset[OFFSET_BITS - 4:0]));
assign touched_buffer[3] = ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b010) & (|veq2st_ctrl_offset[OFFSET_BITS - 4:0])) | ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b011) & (~&veq2st_ctrl_offset[OFFSET_BITS - 4:0]));
assign touched_buffer[4] = ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b011) & (|veq2st_ctrl_offset[OFFSET_BITS - 4:0])) | ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b100) & (~&veq2st_ctrl_offset[OFFSET_BITS - 4:0]));
assign touched_buffer[5] = ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b100) & (|veq2st_ctrl_offset[OFFSET_BITS - 4:0])) | ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b101) & (~&veq2st_ctrl_offset[OFFSET_BITS - 4:0]));
assign touched_buffer[6] = ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b101) & (|veq2st_ctrl_offset[OFFSET_BITS - 4:0])) | ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b110) & (~&veq2st_ctrl_offset[OFFSET_BITS - 4:0]));
assign touched_buffer[7] = ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b110) & (|veq2st_ctrl_offset[OFFSET_BITS - 4:0])) | ((veq2st_ctrl_offset[OFFSET_BITS - 1:OFFSET_BITS - 3] == 3'b111) & (~&veq2st_ctrl_offset[OFFSET_BITS - 4:0]));
generate
    if (DLEN == VSP_DATA_WIDTH) begin:gen_buffer_credit_1v1
        assign buffer_credit = (buffer_wready[0] & rf_cp_ratio_1v1) | (buffer_wready[0] & rf_cp_ratio_2v1 & (|{touched_buffer[0],touched_buffer[7],touched_buffer[6],touched_buffer[5]})) | (buffer_wready[(DLEN / 16)] & rf_cp_ratio_2v1 & (|{touched_buffer[4],touched_buffer[3],touched_buffer[2],touched_buffer[1]})) | (buffer_wready[0] & rf_cp_ratio_4v1 & (|{touched_buffer[0],touched_buffer[7]})) | (buffer_wready[(DLEN / 32) * 1] & rf_cp_ratio_4v1 & (|{touched_buffer[2],touched_buffer[1]})) | (buffer_wready[(DLEN / 32) * 2] & rf_cp_ratio_4v1 & (|{touched_buffer[4],touched_buffer[3]})) | (buffer_wready[(DLEN / 32) * 3] & rf_cp_ratio_4v1 & (|{touched_buffer[6],touched_buffer[5]})) | (buffer_wready[0] & rf_cp_ratio_8v1 & touched_buffer[0]) | (buffer_wready[(DLEN / 64) * 1] & rf_cp_ratio_8v1 & touched_buffer[1]) | (buffer_wready[(DLEN / 64) * 2] & rf_cp_ratio_8v1 & touched_buffer[2]) | (buffer_wready[(DLEN / 64) * 3] & rf_cp_ratio_8v1 & touched_buffer[3]) | (buffer_wready[(DLEN / 64) * 4] & rf_cp_ratio_8v1 & touched_buffer[4]) | (buffer_wready[(DLEN / 64) * 5] & rf_cp_ratio_8v1 & touched_buffer[5]) | (buffer_wready[(DLEN / 64) * 6] & rf_cp_ratio_8v1 & touched_buffer[6]) | (buffer_wready[(DLEN / 64) * 7] & rf_cp_ratio_8v1 & touched_buffer[7]) | veq2st_source_dummy_end;
    end
    else if (DLEN == (2 * VSP_DATA_WIDTH)) begin:gen_buffer_credit_2v1
        assign buffer_credit = (buffer_wready[0] & rf_cp_ratio_1v1 & buffer_wready[(DLEN / 16)]) | (buffer_wready[0] & rf_cp_ratio_2v1 & (|{touched_buffer[0],touched_buffer[7],touched_buffer[6],touched_buffer[5]})) | (buffer_wready[(DLEN / 16)] & rf_cp_ratio_2v1 & (|{touched_buffer[4],touched_buffer[3],touched_buffer[2],touched_buffer[1]})) | (buffer_wready[0] & rf_cp_ratio_4v1 & (|{touched_buffer[0],touched_buffer[7]})) | (buffer_wready[(DLEN / 32) * 1] & rf_cp_ratio_4v1 & (|{touched_buffer[2],touched_buffer[1]})) | (buffer_wready[(DLEN / 32) * 2] & rf_cp_ratio_4v1 & (|{touched_buffer[4],touched_buffer[3]})) | (buffer_wready[(DLEN / 32) * 3] & rf_cp_ratio_4v1 & (|{touched_buffer[6],touched_buffer[5]})) | (buffer_wready[0] & rf_cp_ratio_8v1 & touched_buffer[0]) | (buffer_wready[(DLEN / 64) * 1] & rf_cp_ratio_8v1 & touched_buffer[1]) | (buffer_wready[(DLEN / 64) * 2] & rf_cp_ratio_8v1 & touched_buffer[2]) | (buffer_wready[(DLEN / 64) * 3] & rf_cp_ratio_8v1 & touched_buffer[3]) | (buffer_wready[(DLEN / 64) * 4] & rf_cp_ratio_8v1 & touched_buffer[4]) | (buffer_wready[(DLEN / 64) * 5] & rf_cp_ratio_8v1 & touched_buffer[5]) | (buffer_wready[(DLEN / 64) * 6] & rf_cp_ratio_8v1 & touched_buffer[6]) | (buffer_wready[(DLEN / 64) * 7] & rf_cp_ratio_8v1 & touched_buffer[7]) | veq2st_source_dummy_end;
    end
endgenerate
assign buffer_wvalid = {(DLEN / 8){buffer_credit & veq2st_destination_cp}} & merge_wvalid_fold;
assign buffer_wdata = merge_wdata_fold;
assign buffer_wmask = merge_wmask_fold;
assign buffer_flush = veq2st_ctrl_kill | (cp_grant & veq2st_cp_last);
kv_vsp_merge_buf #(
    .DEPTH(ST_BUF_DEPTH),
    .BYTES(DLEN / 8),
    .RAR_SUPPORT(RAR_SUPPORT)
) u_vsp_st_buf (
    .clk(vpu_vsp_clk),
    .reset_n(vpu_reset_n),
    .flush(buffer_flush),
    .wvalid(buffer_wvalid),
    .wready(buffer_wready),
    .wmask(buffer_wmask),
    .wdata(buffer_wdata),
    .rvalid(buffer_rvalid),
    .rready(buffer_rready),
    .rmask(buffer_rmask),
    .rdata(buffer_rdata)
);
assign cp_wvalid = bypass_wvalid | (buffer_rvalid[(DLEN / 8) - 1] & veq2st_ctrl_cmted);
assign buffer_rready = {(DLEN / 8){cp_wvalid & cp_wready}};
assign cp_wdata = ({DLEN{bypass_wvalid}} & bypass_wdata[DLEN - 1:0]) | ({DLEN{buffer_rvalid[(DLEN / 8) - 1]}} & buffer_rdata);
assign cp_wmask = ({(DLEN / 8){bypass_wvalid}} & bypass_wmask[(DLEN / 8) - 1:0]) | ({(DLEN / 8){buffer_rvalid[(DLEN / 8) - 1]}} & buffer_rmask);
assign veq2st_ctrl_rf_grant = (veq2st_drop_vs & veq2st_source_vs & vs3_wvalid) | (veq2st_path_bypass & veq2st_ctrl_cmted & cp_wready & veq2st_source_vs & vs3_wvalid) | (veq2st_path_bypass & veq2st_ctrl_cmted & cp_wready & veq2st_source_op1) | (veq2st_path_merge & buffer_credit & veq2st_source_vs & vs3_wvalid) | (veq2st_path_merge & buffer_credit & veq2st_source_op1 & ~veq2st_ctrl_op1_hazard) | (veq2st_path_merge & veq2st_source_dummy_start) | (veq2st_path_merge & buffer_credit & ~veq2st_source_vs & veq2st_source_dummy_end);
assign veq2st_ctrl_cp_grant = cp_grant;
generate
    if (DLEN == VSP_DATA_WIDTH) begin:gen_cp_wdata_dlen_vsp_1v1
        wire [DLEN + (DLEN / 8) - 1:0] din;
        wire [DLEN + (DLEN / 8) - 1:0] dout;
        wire cp_wvalid_buf;
        wire cp_wready_buf;
        assign din = {cp_wmask,cp_wdata};
        assign {cp_buf_wdata_bwe,cp_buf_wdata} = dout;
        kv_eb_full_o #(
            .DW(DLEN + (DLEN / 8))
        ) u_cp_wdata (
            .clk(vpu_vsp_clk),
            .resetn(vpu_reset_n),
            .clk_en(1'b1),
            .i_valid(cp_wvalid_buf),
            .i_ready(cp_wready_buf),
            .din(din),
            .o_valid(cp_buf_wdata_valid),
            .o_ready(cp_buf_wdata_ready),
            .dout(dout)
        );
        assign cp_grant = cp_wvalid & cp_wready;
        assign cp_wvalid_buf = cp_wvalid & ~veq2st_ctrl_error;
        assign cp_wready = cp_wready_buf | veq2st_ctrl_error;
    end
    else if (DLEN == (2 * VSP_DATA_WIDTH)) begin:gen_cp_wdata_dlen_vsp_2v1
        wire i_valid;
        wire i_ready;
        wire i_valid_buf;
        wire i_ready_buf;
        wire [VSP_DATA_WIDTH + (VSP_DATA_WIDTH / 8) - 1:0] din;
        wire [VSP_DATA_WIDTH + (VSP_DATA_WIDTH / 8) - 1:0] dout;
        reg [1:0] idx;
        wire idx_en;
        wire [1:0] idx_nx;
        always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                idx <= 2'b01;
            end
            else if (idx_en) begin
                idx <= idx_nx;
            end
        end

        assign idx_en = i_valid & i_ready;
        assign idx_nx = veq2st_cp_last ? 2'b01 : {idx[0],idx[1]};
        assign i_valid = cp_wvalid;
        assign cp_wready = i_ready & (idx[1] | veq2st_cp_last);
        assign din = ({(VSP_DATA_WIDTH + (VSP_DATA_WIDTH / 8)){idx[0]}} & {cp_wmask[0 +:(VSP_DATA_WIDTH / 8)],cp_wdata[0 +:VSP_DATA_WIDTH]}) | ({(VSP_DATA_WIDTH + (VSP_DATA_WIDTH / 8)){idx[1]}} & {cp_wmask[(VSP_DATA_WIDTH / 8) +:(VSP_DATA_WIDTH / 8)],cp_wdata[VSP_DATA_WIDTH +:VSP_DATA_WIDTH]});
        assign {cp_buf_wdata_bwe,cp_buf_wdata} = dout;
        kv_eb_full_o #(
            .DW(VSP_DATA_WIDTH + (VSP_DATA_WIDTH / 8))
        ) u_cp_wdata (
            .clk(vpu_vsp_clk),
            .resetn(vpu_reset_n),
            .clk_en(1'b1),
            .i_valid(i_valid_buf),
            .i_ready(i_ready_buf),
            .din(din),
            .o_valid(cp_buf_wdata_valid),
            .o_ready(cp_buf_wdata_ready),
            .dout(dout)
        );
        assign cp_grant = i_valid & i_ready;
        assign i_valid_buf = i_valid & ~veq2st_ctrl_error;
        assign i_ready = i_ready_buf | veq2st_ctrl_error;
    end
    if (ACE_SP_MODE == 0) begin:gen_fsp
        assign cpu_cp_wdata_valid = cp_buf_wdata_valid;
        assign cp_buf_wdata_ready = cpu_cp_wdata_ready;
        assign cpu_cp_wdata = cp_buf_wdata;
        assign cpu_cp_wdata_bwe = cp_buf_wdata_bwe;
        assign ace_streaming_data_out_valid = 1'b0;
        assign ace_streaming_data_out = {VSP_DATA_WIDTH{1'b0}};
        assign ace_streaming_data_out_bwe = {(VSP_DATA_WIDTH / 8){1'b0}};
        wire nds_unused_ace_streaming_data_out_ready = ace_streaming_data_out_ready;
    end
    if (ACE_SP_MODE == 1) begin:gen_asp
        assign ace_streaming_data_out_valid = cp_buf_wdata_valid;
        assign cp_buf_wdata_ready = ace_streaming_data_out_ready;
        assign ace_streaming_data_out = cp_buf_wdata;
        assign ace_streaming_data_out_bwe = cp_buf_wdata_bwe;
        assign cpu_cp_wdata_valid = 1'b0;
        assign cpu_cp_wdata = {VSP_DATA_WIDTH{1'b0}};
        assign cpu_cp_wdata_bwe = {(VSP_DATA_WIDTH / 8){1'b0}};
        wire nds_unused_cpu_cp_wdata_ready = cpu_cp_wdata_ready;
    end
endgenerate
assign vsp_st_ctrl_standby_ready = ~cp_buf_wdata_valid;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

