// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vsp_vrf_ld_ctrl (
    vpu_vsp_clk,
    vpu_reset_n,
    cp2vrf_rvalid,
    cp2vrf_rready,
    cp2vrf_rdata,
    cp2vrf_rlast,
    cp2vrf_dummy_ex_done,
    cp2vrf_dummy_ex_ready,
    vd_wvalid,
    vd_wready,
    vd_wdata,
    vd_wmask,
    veq2vrf_ld_ctrl_valid,
    veq2vrf_ld_ctrl_idx,
    veq2vrf_ld_ctrl_offset,
    veq2vrf_ld_ctrl_cp_eew,
    veq2vrf_ld_ctrl_rf_eew,
    veq2vrf_ld_ctrl_emask,
    veq2vrf_ld_ctrl_cp2rf_element,
    veq2vrf_ld_ctrl_sext,
    veq2vrf_ld_ctrl_fcvt,
    veq2vrf_ld_ctrl_bf16,
    veq2vrf_ld_source_cp,
    veq2vrf_ld_destination_vrf,
    veq2vrf_ld_partial_cp,
    veq2vrf_ld_cp_last,
    veq2vrf_ld_dummy_vd,
    veq2vrf_ld_dummy_all,
    veq2vrf_ld_vrf_last,
    veq2vrf_ld_path_bypass,
    veq2vrf_ld_path_merge,
    veq2vrf_ld_ctrl_rf_grant,
    veq2vrf_ld_ctrl_cp_grant,
    vsp_vrf_ld_ctrl_standby_ready
);
parameter DLEN = 512;
parameter VSP_DATA_WIDTH = 512;
parameter VEQ_DEPTH = 4;
parameter LD_BUF_DEPTH = 2;
parameter VD_DEPTH = 2;
parameter OFFSET_BITS = $clog2(DLEN / 8);
parameter ACE_FSP_FP64_SUPPORT = 0;
parameter ACE_FSP_FP16_SUPPORT = 0;
parameter ACE_FSP_BF16_SUPPORT = 0;
parameter ACE_SP_MODE = 0;
parameter RAR_SUPPORT = 0;
input vpu_vsp_clk;
input vpu_reset_n;
input cp2vrf_rvalid;
output cp2vrf_rready;
input [(VSP_DATA_WIDTH - 1):0] cp2vrf_rdata;
output cp2vrf_rlast;
input cp2vrf_dummy_ex_done;
output cp2vrf_dummy_ex_ready;
output vd_wvalid;
input vd_wready;
output [(DLEN - 1):0] vd_wdata;
output [(DLEN / 8) - 1:0] vd_wmask;
input veq2vrf_ld_ctrl_valid;
input [VEQ_DEPTH - 1:0] veq2vrf_ld_ctrl_idx;
input [OFFSET_BITS - 1:0] veq2vrf_ld_ctrl_offset;
input [2:0] veq2vrf_ld_ctrl_cp_eew;
input [1:0] veq2vrf_ld_ctrl_rf_eew;
input [(DLEN / 8) - 1:0] veq2vrf_ld_ctrl_emask;
input [(DLEN / 8) - 1:0] veq2vrf_ld_ctrl_cp2rf_element;
input veq2vrf_ld_ctrl_sext;
input veq2vrf_ld_ctrl_fcvt;
input veq2vrf_ld_ctrl_bf16;
input veq2vrf_ld_source_cp;
input veq2vrf_ld_destination_vrf;
input veq2vrf_ld_partial_cp;
input veq2vrf_ld_cp_last;
input veq2vrf_ld_dummy_vd;
input veq2vrf_ld_dummy_all;
input veq2vrf_ld_vrf_last;
input veq2vrf_ld_path_bypass;
input veq2vrf_ld_path_merge;
output veq2vrf_ld_ctrl_rf_grant;
output veq2vrf_ld_ctrl_cp_grant;
output vsp_vrf_ld_ctrl_standby_ready;





// 505ad9ed rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


assign cp2vrf_dummy_ex_ready = veq2vrf_ld_ctrl_rf_grant & veq2vrf_ld_dummy_all & veq2vrf_ld_vrf_last;
genvar i;
generate
    if ((DLEN == VSP_DATA_WIDTH) & (ACE_SP_MODE == 0)) begin:gen_cp_rdata_dlen_vsp_1v1_fsp
        wire bypass_wvalid;
        wire [DLEN - 1:0] bypass_wdata;
        wire [((2 * DLEN) / 8) - 1:0] cp_partial_wvalid;
        wire [(DLEN / 8) - 1:0] cp_buffer_wvalid;
        wire [(DLEN / 8) - 1:0] buffer_wvalid;
        wire [(DLEN / 8) - 1:0] buffer_wready;
        wire [(DLEN / 8) - 1:0] buffer_wmask;
        wire [DLEN - 1:0] buffer_wdata;
        wire buffer_wgrant_all;
        wire [(DLEN / 8) - 1:0] buffer_wgrant;
        wire buffer_flush;
        wire [(DLEN / 8) - 1:0] buffer_rvalid;
        wire [(DLEN / 8) - 1:0] buffer_rready;
        wire [(DLEN / 8) - 1:0] nds_unused_buffer_rmask;
        wire [DLEN - 1:0] buffer_rdata;
        wire merge_wvalid;
        wire [(2 * DLEN) - 1:0] merge_wdata_raw;
        wire [DLEN - 1:0] merge_wdata;
        wire merge_wgrant;
        wire cvt_buf_wvalid;
        wire cvt_buf_wready;
        wire [(DLEN + (DLEN / 8) + 1 + 1 + 1 + 2 + 3) - 1:0] cvt_buf_wdata;
        wire cvt_buf_rvalid;
        wire cvt_buf_rready;
        wire [(DLEN + (DLEN / 8) + 1 + 1 + 1 + 2 + 3) - 1:0] cvt_buf_rdata;
        wire [2:0] cvt_cp_eew;
        wire [1:0] cvt_rf_eew;
        wire cvt_bf16;
        wire cvt_sext;
        wire cvt_nop;
        wire [(DLEN / 8) - 1:0] cvt_mask;
        wire [DLEN - 1:0] cvt_data;
        wire [DLEN - 1:0] cvted_data;
        assign bypass_wvalid = (veq2vrf_ld_path_bypass & veq2vrf_ld_destination_vrf & veq2vrf_ld_source_cp & cp2vrf_rvalid) | (veq2vrf_ld_path_bypass & veq2vrf_ld_destination_vrf & veq2vrf_ld_dummy_all & cp2vrf_dummy_ex_done) | (veq2vrf_ld_path_bypass & veq2vrf_ld_destination_vrf & veq2vrf_ld_dummy_vd & ~veq2vrf_ld_dummy_all);
        kv_vsp_sizeup #(
            .IW(DLEN),
            .OW(DLEN),
            .EW(8)
        ) u_bypass_wdata (
            .src_eew(veq2vrf_ld_ctrl_cp_eew),
            .dst_eew(veq2vrf_ld_ctrl_rf_eew),
            .sext(veq2vrf_ld_ctrl_sext),
            .din(cp2vrf_rdata),
            .dout(bypass_wdata)
        );
        assign cp_partial_wvalid = {{(DLEN / 8){1'b0}},{(DLEN / 8){1'b1}}} << veq2vrf_ld_ctrl_offset;
        for (i = 0; i < (DLEN / 8); i = i + 1) begin:gen_merge_path
            assign cp_buffer_wvalid[i] = (veq2vrf_ld_path_merge & veq2vrf_ld_destination_vrf & veq2vrf_ld_source_cp & veq2vrf_ld_partial_cp & cp2vrf_rvalid & cp_partial_wvalid[i]) | (veq2vrf_ld_path_merge & veq2vrf_ld_destination_vrf & veq2vrf_ld_source_cp & ~veq2vrf_ld_partial_cp & cp2vrf_rvalid);
            assign buffer_wgrant[i] = ~cp_buffer_wvalid[i] | (cp_buffer_wvalid[i] & buffer_wready[i]);
        end
        assign buffer_wgrant_all = &buffer_wgrant;
        assign buffer_wvalid = {(DLEN / 8){buffer_wgrant_all}} & cp_buffer_wvalid;
        assign buffer_wmask = {(DLEN / 8){1'b1}};
        assign buffer_wdata = cp2vrf_rdata;
        assign buffer_flush = veq2vrf_ld_ctrl_rf_grant & veq2vrf_ld_vrf_last;
        kv_vsp_merge_buf #(
            .DEPTH(LD_BUF_DEPTH),
            .BYTES(DLEN / 8),
            .RAR_SUPPORT(RAR_SUPPORT)
        ) u_vsp_ld_buf (
            .clk(vpu_vsp_clk),
            .reset_n(vpu_reset_n),
            .flush(buffer_flush),
            .wvalid(buffer_wvalid),
            .wready(buffer_wready),
            .wmask(buffer_wmask),
            .wdata(buffer_wdata),
            .rvalid(buffer_rvalid),
            .rready(buffer_rready),
            .rmask(nds_unused_buffer_rmask),
            .rdata(buffer_rdata)
        );
        assign merge_wgrant = &(~veq2vrf_ld_ctrl_cp2rf_element | (veq2vrf_ld_ctrl_cp2rf_element & buffer_rvalid)) | (~veq2vrf_ld_source_cp & |buffer_rvalid);
        assign merge_wvalid = (veq2vrf_ld_destination_vrf & merge_wgrant) | (veq2vrf_ld_destination_vrf & veq2vrf_ld_dummy_all & cp2vrf_dummy_ex_done) | (veq2vrf_ld_destination_vrf & veq2vrf_ld_dummy_vd & ~veq2vrf_ld_dummy_all);
        assign buffer_rready = (veq2vrf_ld_ctrl_cp2rf_element & {(DLEN / 8){veq2vrf_ld_destination_vrf & ~veq2vrf_ld_ctrl_fcvt & merge_wgrant & vd_wready & ~cvt_buf_rvalid}}) | (veq2vrf_ld_ctrl_cp2rf_element & {(DLEN / 8){veq2vrf_ld_destination_vrf & veq2vrf_ld_ctrl_fcvt & merge_wgrant & cvt_buf_wready}});
        assign merge_wdata_raw = {buffer_rdata,buffer_rdata} >> {veq2vrf_ld_ctrl_offset,3'b000};
        kv_vsp_sizeup #(
            .IW(DLEN),
            .OW(DLEN),
            .EW(8)
        ) u_merge_wdata (
            .src_eew(veq2vrf_ld_ctrl_cp_eew),
            .dst_eew(veq2vrf_ld_ctrl_rf_eew),
            .sext(veq2vrf_ld_ctrl_sext),
            .din(merge_wdata_raw[DLEN - 1:0]),
            .dout(merge_wdata)
        );
        assign cp2vrf_rready = (veq2vrf_ld_path_bypass & veq2vrf_ld_source_cp & vd_wready & ~cvt_buf_rvalid) | (veq2vrf_ld_path_merge & veq2vrf_ld_source_cp & buffer_wgrant_all);
        assign cp2vrf_rlast = veq2vrf_ld_cp_last;
        assign cvt_buf_wvalid = merge_wvalid & veq2vrf_ld_ctrl_fcvt;
        assign cvt_buf_wdata = {veq2vrf_ld_ctrl_cp_eew,veq2vrf_ld_ctrl_rf_eew,veq2vrf_ld_ctrl_bf16,veq2vrf_ld_ctrl_sext,veq2vrf_ld_dummy_vd,veq2vrf_ld_ctrl_emask,merge_wdata};
        kv_eb_pipelined #(
            .DW(DLEN + (DLEN / 8) + 1 + 1 + 1 + 2 + 3)
        ) u_vsp_cvt_buf (
            .clk(vpu_vsp_clk),
            .resetn(vpu_reset_n),
            .i_valid(cvt_buf_wvalid),
            .i_ready(cvt_buf_wready),
            .din(cvt_buf_wdata),
            .o_valid(cvt_buf_rvalid),
            .o_ready(cvt_buf_rready),
            .dout(cvt_buf_rdata)
        );
        assign {cvt_cp_eew,cvt_rf_eew,cvt_bf16,cvt_sext,cvt_nop,cvt_mask,cvt_data} = cvt_buf_rdata;
        kv_vsp_cvt #(
            .DLEN(DLEN),
            .ACE_FSP_FP64_SUPPORT(ACE_FSP_FP64_SUPPORT),
            .ACE_FSP_FP16_SUPPORT(ACE_FSP_FP16_SUPPORT),
            .ACE_FSP_BF16_SUPPORT(ACE_FSP_BF16_SUPPORT)
        ) u_cvted_data (
            .cp_eew(cvt_cp_eew),
            .rf_eew(cvt_rf_eew),
            .csr_bf16(cvt_bf16),
            .sext(cvt_sext),
            .nop(cvt_nop),
            .din(cvt_data),
            .dout(cvted_data)
        );
        assign cvt_buf_rready = vd_wready;
        assign vd_wvalid = cvt_buf_rvalid | (~veq2vrf_ld_ctrl_fcvt & merge_wvalid) | bypass_wvalid;
        assign vd_wdata = ({DLEN{cvt_buf_rvalid}} & cvted_data) | ({DLEN{(~cvt_buf_rvalid & ~veq2vrf_ld_ctrl_fcvt & merge_wvalid)}} & merge_wdata) | ({DLEN{(~cvt_buf_rvalid & bypass_wvalid)}} & bypass_wdata);
        assign vd_wmask = ({(DLEN / 8){cvt_buf_rvalid}} & cvt_mask) | ({(DLEN / 8){(~cvt_buf_rvalid & ~veq2vrf_ld_ctrl_fcvt & merge_wvalid)}} & veq2vrf_ld_ctrl_emask) | ({(DLEN / 8){(~cvt_buf_rvalid & bypass_wvalid)}} & veq2vrf_ld_ctrl_emask);
        assign veq2vrf_ld_ctrl_rf_grant = (~veq2vrf_ld_ctrl_fcvt & ~cvt_buf_rvalid & merge_wvalid & vd_wready) | (~veq2vrf_ld_ctrl_fcvt & ~cvt_buf_rvalid & bypass_wvalid & vd_wready) | (veq2vrf_ld_ctrl_fcvt & cvt_buf_wvalid & cvt_buf_wready);
        assign veq2vrf_ld_ctrl_cp_grant = cp2vrf_rvalid & cp2vrf_rready;
        assign vsp_vrf_ld_ctrl_standby_ready = ~(|buffer_rvalid) & ~cvt_buf_rvalid;
    end
    else if ((DLEN == (2 * VSP_DATA_WIDTH)) & (ACE_SP_MODE == 0)) begin:gen_cp_rdata_dlen_vsp_2v1_fsp
        reg [1:0] idx;
        wire idx_en;
        wire [1:0] idx_nx;
        wire [((2 * DLEN) / 8) - 1:0] cp_partial_wvalid;
        wire [(DLEN / 8) - 1:0] cp_buffer_wvalid;
        wire [(DLEN / 8) - 1:0] buffer_wvalid;
        wire [(DLEN / 8) - 1:0] buffer_wready;
        wire [(DLEN / 8) - 1:0] buffer_wmask;
        wire [DLEN - 1:0] buffer_wdata;
        wire buffer_wgrant_all;
        wire [(DLEN / 8) - 1:0] buffer_wgrant;
        wire buffer_flush;
        wire [(DLEN / 8) - 1:0] buffer_rvalid;
        wire [(DLEN / 8) - 1:0] buffer_rready;
        wire [(DLEN / 8) - 1:0] nds_unused_buffer_rmask;
        wire [DLEN - 1:0] buffer_rdata;
        wire merge_wvalid;
        wire [(2 * DLEN) - 1:0] merge_wdata_raw;
        wire [DLEN - 1:0] merge_wdata;
        wire merge_wgrant;
        wire cvt_buf_wvalid;
        wire cvt_buf_wready;
        wire [(DLEN + (DLEN / 8) + 1 + 1 + 1 + 2 + 3) - 1:0] cvt_buf_wdata;
        wire cvt_buf_rvalid;
        wire cvt_buf_rready;
        wire [(DLEN + (DLEN / 8) + 1 + 1 + 1 + 2 + 3) - 1:0] cvt_buf_rdata;
        wire [2:0] cvt_cp_eew;
        wire [1:0] cvt_rf_eew;
        wire cvt_bf16;
        wire cvt_sext;
        wire cvt_nop;
        wire [(DLEN / 8) - 1:0] cvt_mask;
        wire [DLEN - 1:0] cvt_data;
        wire [DLEN - 1:0] cvted_data;
        assign cp_partial_wvalid = {{(DLEN / 8){1'b0}},{(DLEN / 8){1'b1}}} << veq2vrf_ld_ctrl_offset;
        always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                idx <= 2'b01;
            end
            else if (idx_en) begin
                idx <= idx_nx;
            end
        end

        assign idx_en = cp2vrf_rvalid & cp2vrf_rready;
        assign idx_nx = cp2vrf_rlast ? 2'b01 : {idx[0],idx[1]};
        for (i = 0; i < (DLEN / 8); i = i + 1) begin:gen_merge_path
            assign cp_buffer_wvalid[i] = (idx[i / (DLEN / 16)] & veq2vrf_ld_path_merge & veq2vrf_ld_destination_vrf & veq2vrf_ld_source_cp & veq2vrf_ld_partial_cp & cp2vrf_rvalid & cp_partial_wvalid[i]) | (idx[i / (DLEN / 16)] & veq2vrf_ld_path_merge & veq2vrf_ld_destination_vrf & veq2vrf_ld_source_cp & ~veq2vrf_ld_partial_cp & cp2vrf_rvalid);
            assign buffer_wgrant[i] = ~cp_buffer_wvalid[i] | (cp_buffer_wvalid[i] & buffer_wready[i]);
        end
        assign buffer_wgrant_all = &buffer_wgrant;
        assign buffer_wvalid = {(DLEN / 8){buffer_wgrant_all}} & cp_buffer_wvalid;
        assign buffer_wmask = {(DLEN / 8){1'b1}};
        assign buffer_wdata = {cp2vrf_rdata,cp2vrf_rdata};
        assign buffer_flush = veq2vrf_ld_ctrl_rf_grant & veq2vrf_ld_vrf_last;
        kv_vsp_merge_buf #(
            .DEPTH(LD_BUF_DEPTH),
            .BYTES(DLEN / 8),
            .RAR_SUPPORT(RAR_SUPPORT)
        ) u_vsp_ld_buf (
            .clk(vpu_vsp_clk),
            .reset_n(vpu_reset_n),
            .flush(buffer_flush),
            .wvalid(buffer_wvalid),
            .wready(buffer_wready),
            .wmask(buffer_wmask),
            .wdata(buffer_wdata),
            .rvalid(buffer_rvalid),
            .rready(buffer_rready),
            .rmask(nds_unused_buffer_rmask),
            .rdata(buffer_rdata)
        );
        assign merge_wgrant = (veq2vrf_ld_source_cp & (&(~veq2vrf_ld_ctrl_cp2rf_element | (veq2vrf_ld_ctrl_cp2rf_element & buffer_rvalid)))) | (~veq2vrf_ld_source_cp & (|buffer_rvalid));
        assign merge_wvalid = (veq2vrf_ld_destination_vrf & merge_wgrant) | (veq2vrf_ld_destination_vrf & veq2vrf_ld_dummy_all & cp2vrf_dummy_ex_done) | (veq2vrf_ld_destination_vrf & veq2vrf_ld_dummy_vd & ~veq2vrf_ld_dummy_all);
        assign buffer_rready = (veq2vrf_ld_ctrl_cp2rf_element & {(DLEN / 8){veq2vrf_ld_destination_vrf & ~veq2vrf_ld_ctrl_fcvt & merge_wgrant & vd_wready & ~cvt_buf_rvalid}}) | (veq2vrf_ld_ctrl_cp2rf_element & {(DLEN / 8){veq2vrf_ld_destination_vrf & veq2vrf_ld_ctrl_fcvt & merge_wgrant & cvt_buf_wready}});
        assign merge_wdata_raw = {buffer_rdata,buffer_rdata} >> {veq2vrf_ld_ctrl_offset,3'b000};
        kv_vsp_sizeup #(
            .IW(DLEN),
            .OW(DLEN),
            .EW(8)
        ) u_merge_wdata (
            .src_eew(veq2vrf_ld_ctrl_cp_eew),
            .dst_eew(veq2vrf_ld_ctrl_rf_eew),
            .sext(veq2vrf_ld_ctrl_sext),
            .din(merge_wdata_raw[DLEN - 1:0]),
            .dout(merge_wdata)
        );
        assign cp2vrf_rready = (veq2vrf_ld_path_merge & veq2vrf_ld_source_cp & buffer_wgrant_all);
        assign cp2vrf_rlast = veq2vrf_ld_cp_last;
        assign cvt_buf_wvalid = merge_wvalid & veq2vrf_ld_ctrl_fcvt;
        assign cvt_buf_wdata = {veq2vrf_ld_ctrl_cp_eew,veq2vrf_ld_ctrl_rf_eew,veq2vrf_ld_ctrl_bf16,veq2vrf_ld_ctrl_sext,veq2vrf_ld_dummy_vd,veq2vrf_ld_ctrl_emask,merge_wdata};
        kv_eb_pipelined #(
            .DW(DLEN + (DLEN / 8) + 1 + 1 + 1 + 2 + 3)
        ) u_vsp_cvt_buf (
            .clk(vpu_vsp_clk),
            .resetn(vpu_reset_n),
            .i_valid(cvt_buf_wvalid),
            .i_ready(cvt_buf_wready),
            .din(cvt_buf_wdata),
            .o_valid(cvt_buf_rvalid),
            .o_ready(cvt_buf_rready),
            .dout(cvt_buf_rdata)
        );
        assign {cvt_cp_eew,cvt_rf_eew,cvt_bf16,cvt_sext,cvt_nop,cvt_mask,cvt_data} = cvt_buf_rdata;
        kv_vsp_cvt #(
            .DLEN(DLEN),
            .ACE_FSP_FP64_SUPPORT(ACE_FSP_FP64_SUPPORT),
            .ACE_FSP_FP16_SUPPORT(ACE_FSP_FP16_SUPPORT),
            .ACE_FSP_BF16_SUPPORT(ACE_FSP_BF16_SUPPORT)
        ) u_cvted_data (
            .cp_eew(cvt_cp_eew),
            .rf_eew(cvt_rf_eew),
            .csr_bf16(cvt_bf16),
            .sext(cvt_sext),
            .nop(cvt_nop),
            .din(cvt_data),
            .dout(cvted_data)
        );
        assign cvt_buf_rready = vd_wready;
        assign vd_wvalid = cvt_buf_rvalid | (~veq2vrf_ld_ctrl_fcvt & merge_wvalid);
        assign vd_wdata = ({DLEN{cvt_buf_rvalid}} & cvted_data) | ({DLEN{(~cvt_buf_rvalid & ~veq2vrf_ld_ctrl_fcvt & merge_wvalid)}} & merge_wdata);
        assign vd_wmask = ({(DLEN / 8){cvt_buf_rvalid}} & cvt_mask) | ({(DLEN / 8){(~cvt_buf_rvalid & ~veq2vrf_ld_ctrl_fcvt & merge_wvalid)}} & veq2vrf_ld_ctrl_emask);
        assign veq2vrf_ld_ctrl_rf_grant = (~veq2vrf_ld_ctrl_fcvt & ~cvt_buf_rvalid & merge_wvalid & vd_wready) | (veq2vrf_ld_ctrl_fcvt & cvt_buf_wvalid & cvt_buf_wready);
        assign veq2vrf_ld_ctrl_cp_grant = cp2vrf_rvalid & cp2vrf_rready;
        assign vsp_vrf_ld_ctrl_standby_ready = ~(|buffer_rvalid) & ~cvt_buf_rvalid;
    end
    else if ((DLEN == VSP_DATA_WIDTH) & (ACE_SP_MODE == 1)) begin:gen_cp_rdata_dlen_vsp_1v1_asp
        wire nds_unused_veq2vrf_ld_ctrl_fcvt = veq2vrf_ld_ctrl_fcvt;
        wire bypass_wvalid;
        wire [DLEN - 1:0] bypass_wdata;
        wire [((2 * DLEN) / 8) - 1:0] cp_partial_wvalid;
        wire [(DLEN / 8) - 1:0] cp_buffer_wvalid;
        wire [(DLEN / 8) - 1:0] buffer_wvalid;
        wire [(DLEN / 8) - 1:0] buffer_wready;
        wire [(DLEN / 8) - 1:0] buffer_wmask;
        wire [DLEN - 1:0] buffer_wdata;
        wire buffer_wgrant_all;
        wire [(DLEN / 8) - 1:0] buffer_wgrant;
        wire buffer_flush;
        wire [(DLEN / 8) - 1:0] buffer_rvalid;
        wire [(DLEN / 8) - 1:0] buffer_rready;
        wire [(DLEN / 8) - 1:0] nds_unused_buffer_rmask;
        wire [DLEN - 1:0] buffer_rdata;
        wire merge_wvalid;
        wire [(2 * DLEN) - 1:0] merge_wdata_raw;
        wire [DLEN - 1:0] merge_wdata;
        wire merge_wgrant;
        assign bypass_wvalid = (veq2vrf_ld_path_bypass & veq2vrf_ld_destination_vrf & veq2vrf_ld_source_cp & cp2vrf_rvalid) | (veq2vrf_ld_path_bypass & veq2vrf_ld_destination_vrf & veq2vrf_ld_dummy_all & cp2vrf_dummy_ex_done) | (veq2vrf_ld_path_bypass & veq2vrf_ld_destination_vrf & veq2vrf_ld_dummy_vd & ~veq2vrf_ld_dummy_all);
        kv_vsp_sizeup #(
            .IW(DLEN),
            .OW(DLEN),
            .EW(8)
        ) u_bypass_wdata (
            .src_eew(veq2vrf_ld_ctrl_cp_eew),
            .dst_eew(veq2vrf_ld_ctrl_rf_eew),
            .sext(veq2vrf_ld_ctrl_sext),
            .din(cp2vrf_rdata),
            .dout(bypass_wdata)
        );
        assign cp_partial_wvalid = {{(DLEN / 8){1'b0}},{(DLEN / 8){1'b1}}} << veq2vrf_ld_ctrl_offset;
        for (i = 0; i < (DLEN / 8); i = i + 1) begin:gen_merge_path
            assign cp_buffer_wvalid[i] = (veq2vrf_ld_path_merge & veq2vrf_ld_destination_vrf & veq2vrf_ld_source_cp & veq2vrf_ld_partial_cp & cp2vrf_rvalid & cp_partial_wvalid[i]) | (veq2vrf_ld_path_merge & veq2vrf_ld_destination_vrf & veq2vrf_ld_source_cp & ~veq2vrf_ld_partial_cp & cp2vrf_rvalid);
            assign buffer_wgrant[i] = ~cp_buffer_wvalid[i] | (cp_buffer_wvalid[i] & buffer_wready[i]);
        end
        assign buffer_wgrant_all = &buffer_wgrant;
        assign buffer_wvalid = {(DLEN / 8){buffer_wgrant_all}} & cp_buffer_wvalid;
        assign buffer_wmask = {(DLEN / 8){1'b1}};
        assign buffer_wdata = cp2vrf_rdata;
        assign buffer_flush = veq2vrf_ld_ctrl_rf_grant & veq2vrf_ld_vrf_last;
        kv_vsp_merge_buf #(
            .DEPTH(LD_BUF_DEPTH),
            .BYTES(DLEN / 8),
            .RAR_SUPPORT(RAR_SUPPORT)
        ) u_vsp_ld_buf (
            .clk(vpu_vsp_clk),
            .reset_n(vpu_reset_n),
            .flush(buffer_flush),
            .wvalid(buffer_wvalid),
            .wready(buffer_wready),
            .wmask(buffer_wmask),
            .wdata(buffer_wdata),
            .rvalid(buffer_rvalid),
            .rready(buffer_rready),
            .rmask(nds_unused_buffer_rmask),
            .rdata(buffer_rdata)
        );
        assign merge_wgrant = &(~veq2vrf_ld_ctrl_cp2rf_element | (veq2vrf_ld_ctrl_cp2rf_element & buffer_rvalid)) | (~veq2vrf_ld_source_cp & |buffer_rvalid);
        assign merge_wvalid = (veq2vrf_ld_destination_vrf & merge_wgrant) | (veq2vrf_ld_destination_vrf & veq2vrf_ld_dummy_all & cp2vrf_dummy_ex_done) | (veq2vrf_ld_destination_vrf & veq2vrf_ld_dummy_vd & ~veq2vrf_ld_dummy_all);
        assign buffer_rready = (veq2vrf_ld_ctrl_cp2rf_element & {(DLEN / 8){veq2vrf_ld_destination_vrf & merge_wgrant & vd_wready}});
        assign merge_wdata_raw = {buffer_rdata,buffer_rdata} >> {veq2vrf_ld_ctrl_offset,3'b000};
        kv_vsp_sizeup #(
            .IW(DLEN),
            .OW(DLEN),
            .EW(8)
        ) u_merge_wdata (
            .src_eew(veq2vrf_ld_ctrl_cp_eew),
            .dst_eew(veq2vrf_ld_ctrl_rf_eew),
            .sext(veq2vrf_ld_ctrl_sext),
            .din(merge_wdata_raw[DLEN - 1:0]),
            .dout(merge_wdata)
        );
        assign cp2vrf_rready = (veq2vrf_ld_path_bypass & veq2vrf_ld_source_cp & vd_wready) | (veq2vrf_ld_path_merge & veq2vrf_ld_source_cp & buffer_wgrant_all);
        assign cp2vrf_rlast = veq2vrf_ld_cp_last;
        assign vd_wvalid = merge_wvalid | bypass_wvalid;
        assign vd_wdata = ({DLEN{merge_wvalid}} & merge_wdata) | ({DLEN{bypass_wvalid}} & bypass_wdata);
        assign vd_wmask = ({(DLEN / 8){merge_wvalid}} & veq2vrf_ld_ctrl_emask) | ({(DLEN / 8){bypass_wvalid}} & veq2vrf_ld_ctrl_emask);
        assign veq2vrf_ld_ctrl_rf_grant = (merge_wvalid & vd_wready) | (bypass_wvalid & vd_wready);
        assign veq2vrf_ld_ctrl_cp_grant = cp2vrf_rvalid & cp2vrf_rready;
        assign vsp_vrf_ld_ctrl_standby_ready = ~(|buffer_rvalid);
    end
    else if ((DLEN == (2 * VSP_DATA_WIDTH)) & (ACE_SP_MODE == 1)) begin:gen_cp_rdata_dlen_vsp_2v1_asp
        wire nds_unused_veq2vrf_ld_ctrl_fcvt = veq2vrf_ld_ctrl_fcvt;
        reg [1:0] idx;
        wire idx_en;
        wire [1:0] idx_nx;
        wire [((2 * DLEN) / 8) - 1:0] cp_partial_wvalid;
        wire [(DLEN / 8) - 1:0] cp_buffer_wvalid;
        wire [(DLEN / 8) - 1:0] buffer_wvalid;
        wire [(DLEN / 8) - 1:0] buffer_wready;
        wire [(DLEN / 8) - 1:0] buffer_wmask;
        wire [DLEN - 1:0] buffer_wdata;
        wire buffer_wgrant_all;
        wire [(DLEN / 8) - 1:0] buffer_wgrant;
        wire buffer_flush;
        wire [(DLEN / 8) - 1:0] buffer_rvalid;
        wire [(DLEN / 8) - 1:0] buffer_rready;
        wire [(DLEN / 8) - 1:0] nds_unused_buffer_rmask;
        wire [DLEN - 1:0] buffer_rdata;
        wire merge_wvalid;
        wire [(2 * DLEN) - 1:0] merge_wdata_raw;
        wire [DLEN - 1:0] merge_wdata;
        wire merge_wgrant;
        assign cp_partial_wvalid = {{(DLEN / 8){1'b0}},{(DLEN / 8){1'b1}}} << veq2vrf_ld_ctrl_offset;
        always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                idx <= 2'b01;
            end
            else if (idx_en) begin
                idx <= idx_nx;
            end
        end

        assign idx_en = cp2vrf_rvalid & cp2vrf_rready;
        assign idx_nx = cp2vrf_rlast ? 2'b01 : {idx[0],idx[1]};
        for (i = 0; i < (DLEN / 8); i = i + 1) begin:gen_merge_path
            assign cp_buffer_wvalid[i] = (idx[i / (DLEN / 16)] & veq2vrf_ld_path_merge & veq2vrf_ld_destination_vrf & veq2vrf_ld_source_cp & veq2vrf_ld_partial_cp & cp2vrf_rvalid & cp_partial_wvalid[i]) | (idx[i / (DLEN / 16)] & veq2vrf_ld_path_merge & veq2vrf_ld_destination_vrf & veq2vrf_ld_source_cp & ~veq2vrf_ld_partial_cp & cp2vrf_rvalid);
            assign buffer_wgrant[i] = ~cp_buffer_wvalid[i] | (cp_buffer_wvalid[i] & buffer_wready[i]);
        end
        assign buffer_wgrant_all = &buffer_wgrant;
        assign buffer_wvalid = {(DLEN / 8){buffer_wgrant_all}} & cp_buffer_wvalid;
        assign buffer_wmask = {(DLEN / 8){1'b1}};
        assign buffer_wdata = {cp2vrf_rdata,cp2vrf_rdata};
        assign buffer_flush = veq2vrf_ld_ctrl_rf_grant & veq2vrf_ld_vrf_last;
        kv_vsp_merge_buf #(
            .DEPTH(LD_BUF_DEPTH),
            .BYTES(DLEN / 8),
            .RAR_SUPPORT(RAR_SUPPORT)
        ) u_vsp_ld_buf (
            .clk(vpu_vsp_clk),
            .reset_n(vpu_reset_n),
            .flush(buffer_flush),
            .wvalid(buffer_wvalid),
            .wready(buffer_wready),
            .wmask(buffer_wmask),
            .wdata(buffer_wdata),
            .rvalid(buffer_rvalid),
            .rready(buffer_rready),
            .rmask(nds_unused_buffer_rmask),
            .rdata(buffer_rdata)
        );
        assign merge_wgrant = (veq2vrf_ld_source_cp & (&(~veq2vrf_ld_ctrl_cp2rf_element | (veq2vrf_ld_ctrl_cp2rf_element & buffer_rvalid)))) | (~veq2vrf_ld_source_cp & (|buffer_rvalid));
        assign merge_wvalid = (veq2vrf_ld_destination_vrf & merge_wgrant) | (veq2vrf_ld_destination_vrf & veq2vrf_ld_dummy_all & cp2vrf_dummy_ex_done) | (veq2vrf_ld_destination_vrf & veq2vrf_ld_dummy_vd & ~veq2vrf_ld_dummy_all);
        assign buffer_rready = (veq2vrf_ld_ctrl_cp2rf_element & {(DLEN / 8){veq2vrf_ld_destination_vrf & merge_wgrant & vd_wready}});
        assign merge_wdata_raw = {buffer_rdata,buffer_rdata} >> {veq2vrf_ld_ctrl_offset,3'b000};
        kv_vsp_sizeup #(
            .IW(DLEN),
            .OW(DLEN),
            .EW(8)
        ) u_merge_wdata (
            .src_eew(veq2vrf_ld_ctrl_cp_eew),
            .dst_eew(veq2vrf_ld_ctrl_rf_eew),
            .sext(veq2vrf_ld_ctrl_sext),
            .din(merge_wdata_raw[DLEN - 1:0]),
            .dout(merge_wdata)
        );
        assign cp2vrf_rready = (veq2vrf_ld_path_merge & veq2vrf_ld_source_cp & buffer_wgrant_all);
        assign cp2vrf_rlast = veq2vrf_ld_cp_last;
        assign vd_wvalid = merge_wvalid;
        assign vd_wdata = ({DLEN{merge_wvalid}} & merge_wdata);
        assign vd_wmask = ({(DLEN / 8){merge_wvalid}} & veq2vrf_ld_ctrl_emask);
        assign veq2vrf_ld_ctrl_rf_grant = (merge_wvalid & vd_wready);
        assign veq2vrf_ld_ctrl_cp_grant = cp2vrf_rvalid & cp2vrf_rready;
        assign vsp_vrf_ld_ctrl_standby_ready = ~(|buffer_rvalid);
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

