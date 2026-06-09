// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vsp_srf_ld_ctrl (
    vpu_vsp_clk,
    vpu_reset_n,
    cp2srf_rvalid,
    cp2srf_rready,
    cp2srf_rdata,
    cp2srf_rlast,
    vsp_srf_wvalid,
    vsp_srf_wready,
    vsp_srf_waddr,
    vsp_srf_wdata,
    vsp_srf_wfrf,
    veq2srf_ld_ctrl_valid,
    veq2srf_ld_ctrl_idx,
    veq2srf_ld_ctrl_offset,
    veq2srf_ld_ctrl_cp_eew,
    veq2srf_ld_ctrl_rf_eew,
    veq2srf_ld_ctrl_emask,
    veq2srf_ld_ctrl_cp2rf_element,
    veq2srf_ld_ctrl_sext,
    veq2srf_ld_ctrl_frf,
    veq2srf_ld_ctrl_srf_idx,
    veq2srf_ld_source_cp,
    veq2srf_ld_destination_srf,
    veq2srf_ld_partial_cp,
    veq2srf_ld_cp_last,
    veq2srf_ld_path_bypass,
    veq2srf_ld_path_merge,
    veq2srf_ld_ctrl_rf_grant,
    veq2srf_ld_ctrl_cp_grant,
    vsp_srf_ld_ctrl_standby_ready
);
parameter DLEN = 512;
parameter VSP_DATA_WIDTH = 512;
parameter VEQ_DEPTH = 4;
parameter OFFSET_BITS = $clog2(DLEN / 8);
parameter ACE_SP_MODE = 0;
parameter RAR_SUPPORT = 0;
input vpu_vsp_clk;
input vpu_reset_n;
input cp2srf_rvalid;
output cp2srf_rready;
input [(VSP_DATA_WIDTH - 1):0] cp2srf_rdata;
output cp2srf_rlast;
output vsp_srf_wvalid;
input vsp_srf_wready;
output [4:0] vsp_srf_waddr;
output [63:0] vsp_srf_wdata;
output vsp_srf_wfrf;
input veq2srf_ld_ctrl_valid;
input [VEQ_DEPTH - 1:0] veq2srf_ld_ctrl_idx;
input [OFFSET_BITS - 1:0] veq2srf_ld_ctrl_offset;
input [2:0] veq2srf_ld_ctrl_cp_eew;
input [1:0] veq2srf_ld_ctrl_rf_eew;
input [(DLEN / 8) - 1:0] veq2srf_ld_ctrl_emask;
input [(DLEN / 8) - 1:0] veq2srf_ld_ctrl_cp2rf_element;
input veq2srf_ld_ctrl_sext;
input veq2srf_ld_ctrl_frf;
input [4:0] veq2srf_ld_ctrl_srf_idx;
input veq2srf_ld_source_cp;
input veq2srf_ld_destination_srf;
input veq2srf_ld_partial_cp;
input veq2srf_ld_cp_last;
input veq2srf_ld_path_bypass;
input veq2srf_ld_path_merge;
output veq2srf_ld_ctrl_rf_grant;
output veq2srf_ld_ctrl_cp_grant;
output vsp_srf_ld_ctrl_standby_ready;





// 551b7cf0 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


genvar i;
generate
    if ((DLEN == VSP_DATA_WIDTH) & (ACE_SP_MODE == 0)) begin:gen_cp_rdata_dlen_vsp_1v1_fsp
        wire bypass_wvalid;
        wire [63:0] bypass_wdata;
        wire [(VSP_DATA_WIDTH - 1):0] cp2srf_rdata_shift;
        wire [((2 * DLEN) / 8) - 1:0] cp_partial_wvalid;
        wire [(DLEN / 8) - 1:0] cp_buffer_wvalid;
        wire [7:0] cp_buffer_wvalid_vor;
        wire [DLEN - 1:0] cp_buffer_wdata_en;
        wire [DLEN - 1:0] cp_buffer_wdata_masked;
        wire [63:0] cp_buffer_wdata_vor;
        wire [7:0] buffer_wvalid;
        wire [7:0] nds_unused_buffer_wready;
        wire [7:0] buffer_wmask;
        wire [63:0] buffer_wdata;
        wire buffer_flush;
        wire [7:0] cp2rf_element_vor;
        wire [7:0] buffer_rvalid;
        wire [7:0] buffer_rready;
        wire [7:0] nds_unused_buffer_rmask;
        wire [63:0] buffer_rdata;
        wire merge_wvalid;
        wire [127:0] merge_wdata_raw;
        wire [63:0] merge_wdata;
        wire merge_wgrant;
        assign bypass_wvalid = veq2srf_ld_path_bypass & veq2srf_ld_destination_srf & veq2srf_ld_source_cp & cp2srf_rvalid;
        assign cp2srf_rdata_shift = cp2srf_rdata >> {veq2srf_ld_ctrl_offset,3'b000};
        kv_vsp_sizeup #(
            .IW(64),
            .OW(64),
            .EW(8)
        ) u_bypass_wdata (
            .src_eew(veq2srf_ld_ctrl_cp_eew),
            .dst_eew(veq2srf_ld_ctrl_rf_eew),
            .sext(veq2srf_ld_ctrl_sext),
            .din(cp2srf_rdata_shift[63:0]),
            .dout(bypass_wdata)
        );
        assign cp_partial_wvalid = {{(DLEN / 8){1'b0}},{(DLEN / 8){1'b1}}} << veq2srf_ld_ctrl_offset;
        for (i = 0; i < (DLEN / 8); i = i + 1) begin:gen_cp_buffer_wvalid
            assign cp_buffer_wvalid[i] = (veq2srf_ld_path_merge & veq2srf_ld_destination_srf & veq2srf_ld_source_cp & veq2srf_ld_partial_cp & cp2srf_rvalid & cp_partial_wvalid[i] & veq2srf_ld_ctrl_cp2rf_element[i]) | (veq2srf_ld_path_merge & veq2srf_ld_destination_srf & veq2srf_ld_source_cp & ~veq2srf_ld_partial_cp & cp2srf_rvalid & veq2srf_ld_ctrl_cp2rf_element[i]);
        end
        kv_vor #(
            .N(DLEN / 64),
            .W(8)
        ) u_cp_buffer_wvalid_vor (
            .in(cp_buffer_wvalid),
            .out(cp_buffer_wvalid_vor)
        );
        kv_vsp_sizeup #(
            .IW(DLEN / 8),
            .OW(DLEN),
            .EW(1)
        ) u_cp_buffer_wdata_mask (
            .src_eew(3'b000),
            .dst_eew(2'b11),
            .sext(1'b1),
            .din(cp_buffer_wvalid),
            .dout(cp_buffer_wdata_en)
        );
        assign cp_buffer_wdata_masked = cp_buffer_wdata_en & cp2srf_rdata;
        kv_vor #(
            .N(DLEN / 64),
            .W(64)
        ) u_cp_buffer_wdata_vor (
            .in(cp_buffer_wdata_masked),
            .out(cp_buffer_wdata_vor)
        );
        assign buffer_wvalid = cp_buffer_wvalid_vor;
        assign buffer_wmask = {8{1'b1}};
        assign buffer_wdata = cp_buffer_wdata_vor;
        assign buffer_flush = veq2srf_ld_ctrl_rf_grant;
        kv_vsp_eb_pipelined #(
            .BYTES(8),
            .RAR_SUPPORT(RAR_SUPPORT)
        ) u_pipelined_buf (
            .clk(vpu_vsp_clk),
            .reset_n(vpu_reset_n),
            .flush(buffer_flush),
            .wvalid(buffer_wvalid),
            .wready(nds_unused_buffer_wready),
            .wmask(buffer_wmask),
            .wdata(buffer_wdata),
            .rvalid(buffer_rvalid),
            .rready(buffer_rready),
            .rmask(nds_unused_buffer_rmask),
            .rdata(buffer_rdata)
        );
        kv_vor #(
            .N(DLEN / 64),
            .W(8)
        ) u_cp2rf_element_vor (
            .in(veq2srf_ld_ctrl_cp2rf_element),
            .out(cp2rf_element_vor)
        );
        assign merge_wgrant = &(~cp2rf_element_vor | (cp2rf_element_vor & buffer_rvalid));
        assign merge_wvalid = veq2srf_ld_destination_srf & merge_wgrant;
        assign buffer_rready = cp2rf_element_vor & {8{veq2srf_ld_destination_srf & merge_wgrant & vsp_srf_wready}};
        assign merge_wdata_raw = {buffer_rdata,buffer_rdata} >> {veq2srf_ld_ctrl_offset[2:0],3'b000};
        kv_vsp_sizeup #(
            .IW(64),
            .OW(64),
            .EW(8)
        ) u_merge_wdata (
            .src_eew(veq2srf_ld_ctrl_cp_eew),
            .dst_eew(veq2srf_ld_ctrl_rf_eew),
            .sext(veq2srf_ld_ctrl_sext),
            .din(merge_wdata_raw[63:0]),
            .dout(merge_wdata)
        );
        assign cp2srf_rready = (veq2srf_ld_path_bypass & veq2srf_ld_source_cp & vsp_srf_wready) | (veq2srf_ld_path_merge & veq2srf_ld_source_cp);
        assign cp2srf_rlast = veq2srf_ld_cp_last;
        assign vsp_srf_wvalid = bypass_wvalid | merge_wvalid;
        assign vsp_srf_waddr = veq2srf_ld_ctrl_srf_idx;
        assign vsp_srf_wfrf = veq2srf_ld_ctrl_frf;
        for (i = 0; i < 8; i = i + 1) begin:gen_vsp_srf_wdata
            assign vsp_srf_wdata[i * 8 +:8] = ({8{bypass_wvalid & veq2srf_ld_ctrl_emask[i]}} & bypass_wdata[i * 8 +:8]) | ({8{merge_wvalid & veq2srf_ld_ctrl_emask[i]}} & merge_wdata[i * 8 +:8]) | {8{~veq2srf_ld_ctrl_emask[i]}};
        end
        assign vsp_srf_ld_ctrl_standby_ready = ~(|buffer_rvalid);
    end
    else if ((DLEN == VSP_DATA_WIDTH) & (ACE_SP_MODE == 1)) begin:gen_cp_rdata_dlen_vsp_1v1_asp
        wire nds_unused_veq2srf_ld_path_merge = veq2srf_ld_path_merge;
        wire bypass_wvalid;
        wire [63:0] bypass_wdata;
        wire [(VSP_DATA_WIDTH - 1):0] cp2srf_rdata_shift;
        assign bypass_wvalid = veq2srf_ld_path_bypass & veq2srf_ld_destination_srf & veq2srf_ld_source_cp & cp2srf_rvalid;
        assign cp2srf_rdata_shift = cp2srf_rdata >> {veq2srf_ld_ctrl_offset,3'b000};
        kv_vsp_sizeup #(
            .IW(64),
            .OW(64),
            .EW(8)
        ) u_bypass_wdata (
            .src_eew(veq2srf_ld_ctrl_cp_eew),
            .dst_eew(veq2srf_ld_ctrl_rf_eew),
            .sext(veq2srf_ld_ctrl_sext),
            .din(cp2srf_rdata_shift[63:0]),
            .dout(bypass_wdata)
        );
        assign cp2srf_rready = (veq2srf_ld_path_bypass & veq2srf_ld_source_cp & vsp_srf_wready);
        assign cp2srf_rlast = veq2srf_ld_cp_last;
        assign vsp_srf_wvalid = bypass_wvalid;
        assign vsp_srf_waddr = veq2srf_ld_ctrl_srf_idx;
        assign vsp_srf_wfrf = veq2srf_ld_ctrl_frf;
        for (i = 0; i < 8; i = i + 1) begin:gen_vsp_srf_wdata
            assign vsp_srf_wdata[i * 8 +:8] = ({8{bypass_wvalid & veq2srf_ld_ctrl_emask[i]}} & bypass_wdata[i * 8 +:8]) | {8{~veq2srf_ld_ctrl_emask[i]}};
        end
        assign vsp_srf_ld_ctrl_standby_ready = 1'b1;
    end
    else if (DLEN == (2 * VSP_DATA_WIDTH)) begin:gen_cp_rdata_dlen_vsp_2v1
        reg [1:0] idx;
        wire idx_en;
        wire [1:0] idx_nx;
        wire [((2 * DLEN) / 8) - 1:0] cp_partial_wvalid;
        wire [(DLEN / 8) - 1:0] cp_buffer_wvalid;
        wire [7:0] cp_buffer_wvalid_vor;
        wire [DLEN - 1:0] cp_buffer_wdata_en;
        wire [DLEN - 1:0] cp_buffer_wdata_masked;
        wire [63:0] cp_buffer_wdata_vor;
        wire [7:0] buffer_wvalid;
        wire [7:0] nds_unused_buffer_wready;
        wire [7:0] buffer_wmask;
        wire [63:0] buffer_wdata;
        wire buffer_flush;
        wire [7:0] cp2rf_element_vor;
        wire [7:0] buffer_rvalid;
        wire [7:0] buffer_rready;
        wire [7:0] nds_unused_buffer_rmask;
        wire [63:0] buffer_rdata;
        wire merge_wvalid;
        wire [127:0] merge_wdata_raw;
        wire [63:0] merge_wdata;
        wire merge_wgrant;
        always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                idx <= 2'b01;
            end
            else if (idx_en) begin
                idx <= idx_nx;
            end
        end

        assign idx_en = cp2srf_rvalid & cp2srf_rready;
        assign idx_nx = cp2srf_rlast ? 2'b01 : {idx[0],idx[1]};
        assign cp_partial_wvalid = {{(DLEN / 8){1'b0}},{(DLEN / 8){1'b1}}} << veq2srf_ld_ctrl_offset;
        for (i = 0; i < (DLEN / 8); i = i + 1) begin:gen_cp_buffer_wvalid
            assign cp_buffer_wvalid[i] = ((idx[i / (DLEN / 16)] | cp2srf_rlast) & veq2srf_ld_path_merge & veq2srf_ld_destination_srf & veq2srf_ld_source_cp & veq2srf_ld_partial_cp & cp2srf_rvalid & cp_partial_wvalid[i] & veq2srf_ld_ctrl_cp2rf_element[i]) | ((idx[i / (DLEN / 16)] | cp2srf_rlast) & veq2srf_ld_path_merge & veq2srf_ld_destination_srf & veq2srf_ld_source_cp & ~veq2srf_ld_partial_cp & cp2srf_rvalid & veq2srf_ld_ctrl_cp2rf_element[i]);
        end
        kv_vor #(
            .N(DLEN / 64),
            .W(8)
        ) u_cp_buffer_wvalid_vor (
            .in(cp_buffer_wvalid),
            .out(cp_buffer_wvalid_vor)
        );
        kv_vsp_sizeup #(
            .IW(DLEN / 8),
            .OW(DLEN),
            .EW(1)
        ) u_cp_buffer_wdata_mask (
            .src_eew(3'b000),
            .dst_eew(2'b11),
            .sext(1'b1),
            .din(cp_buffer_wvalid),
            .dout(cp_buffer_wdata_en)
        );
        assign cp_buffer_wdata_masked = cp_buffer_wdata_en & {cp2srf_rdata,cp2srf_rdata};
        kv_vor #(
            .N(DLEN / 64),
            .W(64)
        ) u_cp_buffer_wdata_vor (
            .in(cp_buffer_wdata_masked),
            .out(cp_buffer_wdata_vor)
        );
        assign buffer_wvalid = cp_buffer_wvalid_vor;
        assign buffer_wmask = {8{1'b1}};
        assign buffer_wdata = cp_buffer_wdata_vor;
        assign buffer_flush = veq2srf_ld_ctrl_rf_grant;
        kv_vsp_eb_pipelined #(
            .BYTES(8),
            .RAR_SUPPORT(RAR_SUPPORT)
        ) u_pipelined_buf (
            .clk(vpu_vsp_clk),
            .reset_n(vpu_reset_n),
            .flush(buffer_flush),
            .wvalid(buffer_wvalid),
            .wready(nds_unused_buffer_wready),
            .wmask(buffer_wmask),
            .wdata(buffer_wdata),
            .rvalid(buffer_rvalid),
            .rready(buffer_rready),
            .rmask(nds_unused_buffer_rmask),
            .rdata(buffer_rdata)
        );
        kv_vor #(
            .N(DLEN / 64),
            .W(8)
        ) u_cp2rf_element_vor (
            .in(veq2srf_ld_ctrl_cp2rf_element),
            .out(cp2rf_element_vor)
        );
        assign merge_wgrant = &(~cp2rf_element_vor | (cp2rf_element_vor & buffer_rvalid));
        assign merge_wvalid = veq2srf_ld_destination_srf & merge_wgrant;
        assign buffer_rready = cp2rf_element_vor & {8{veq2srf_ld_destination_srf & merge_wgrant & vsp_srf_wready}};
        assign merge_wdata_raw = {buffer_rdata,buffer_rdata} >> {veq2srf_ld_ctrl_offset[2:0],3'b000};
        kv_vsp_sizeup #(
            .IW(64),
            .OW(64),
            .EW(8)
        ) u_merge_wdata (
            .src_eew(veq2srf_ld_ctrl_cp_eew),
            .dst_eew(veq2srf_ld_ctrl_rf_eew),
            .sext(veq2srf_ld_ctrl_sext),
            .din(merge_wdata_raw[63:0]),
            .dout(merge_wdata)
        );
        assign cp2srf_rready = (veq2srf_ld_path_merge & veq2srf_ld_source_cp);
        assign cp2srf_rlast = veq2srf_ld_cp_last;
        assign vsp_srf_wvalid = merge_wvalid;
        assign vsp_srf_waddr = veq2srf_ld_ctrl_srf_idx;
        assign vsp_srf_wfrf = veq2srf_ld_ctrl_frf;
        for (i = 0; i < 8; i = i + 1) begin:gen_vsp_srf_wdata
            assign vsp_srf_wdata[i * 8 +:8] = ({8{merge_wvalid & veq2srf_ld_ctrl_emask[i]}} & merge_wdata[i * 8 +:8]) | {8{~veq2srf_ld_ctrl_emask[i]}};
        end
        assign vsp_srf_ld_ctrl_standby_ready = ~(|buffer_rvalid);
    end
endgenerate
assign veq2srf_ld_ctrl_rf_grant = vsp_srf_wvalid & vsp_srf_wready;
assign veq2srf_ld_ctrl_cp_grant = cp2srf_rvalid & cp2srf_rready;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

