// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfmis_lane (
    clk,
    rstn,
    vfmis_f1_ex_ctrl,
    vfmis_f1_ex_frm,
    vfmis_f1_op1,
    vfmis_vs1_src,
    vfmis_vs2_src,
    vfmis_vs2_wsrc,
    vfmis_f1_byte_mask,
    vfmis_f1_nrr_byte_mask,
    vfmis_f1_valid,
    vfmis_f2_stall,
    vfmis_f1_wdata,
    vfmis_f1_cmp_bit,
    vfmis_f1_flag_set,
    vfmis_f2_wdata,
    vfmis_f2_narrow_wdata,
    vfmis_f2_flag_set
);
parameter XLEN = 64;
parameter ELEN = 64;
parameter FELEN = 64;
parameter IELEN = 64;
input clk;
input rstn;
input [71 - 1:0] vfmis_f1_ex_ctrl;
input [2:0] vfmis_f1_ex_frm;
input [XLEN - 1:0] vfmis_f1_op1;
input [63:0] vfmis_vs1_src;
input [63:0] vfmis_vs2_src;
input [31:0] vfmis_vs2_wsrc;
input [7:0] vfmis_f1_byte_mask;
input [7:0] vfmis_f1_nrr_byte_mask;
input vfmis_f1_valid;
input vfmis_f2_stall;
output [63:0] vfmis_f1_wdata;
output [3:0] vfmis_f1_cmp_bit;
output [4:0] vfmis_f1_flag_set;
output [63:0] vfmis_f2_wdata;
output [31:0] vfmis_f2_narrow_wdata;
output [4:0] vfmis_f2_flag_set;





// f3afe3df rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


generate
    if (ELEN == 64) begin:gen_one_elen_lane
        wire [63:0] vfmis_vs2_wide_src;
        assign vfmis_vs2_wide_src = {32'b0,vfmis_vs2_wsrc};
        kv_vfmis_elen #(
            .XLEN(XLEN),
            .ELEN(ELEN),
            .FELEN(FELEN),
            .IELEN(IELEN)
        ) u_kv_vfmis_elen (
            .clk(clk),
            .rstn(rstn),
            .vfmis_f1_ex_ctrl(vfmis_f1_ex_ctrl),
            .vfmis_f1_ex_frm(vfmis_f1_ex_frm),
            .vfmis_f1_op1(vfmis_f1_op1),
            .vfmis_vs1_src(vfmis_vs1_src),
            .vfmis_vs2_src(vfmis_vs2_src),
            .vfmis_vs2_wide_src(vfmis_vs2_wide_src),
            .vfmis_f1_byte_mask(vfmis_f1_byte_mask),
            .vfmis_f1_nrr_byte_mask(vfmis_f1_nrr_byte_mask),
            .vfmis_f1_valid(vfmis_f1_valid),
            .vfmis_f2_stall(vfmis_f2_stall),
            .vfmis_f1_wdata(vfmis_f1_wdata),
            .vfmis_f1_cmp_bit(vfmis_f1_cmp_bit),
            .vfmis_f1_flag_set(vfmis_f1_flag_set),
            .vfmis_f2_wdata(vfmis_f2_wdata),
            .vfmis_f2_flag_set(vfmis_f2_flag_set),
            .vfmis_f2_narrow_wdata(vfmis_f2_narrow_wdata)
        );
    end
    else begin:gen_two_elen_lane
        wire [63:0] vfmis_vs2_wide_src;
        assign vfmis_vs2_wide_src = {16'b0,vfmis_vs2_wsrc[31:16],16'b0,vfmis_vs2_wsrc[15:0]};
        wire [4:0] s0;
        wire [4:0] s1;
        wire [4:0] s2;
        wire [4:0] s3;
        assign vfmis_f2_flag_set = s0 | s1;
        assign vfmis_f1_flag_set = s2 | s3;
        kv_vfmis_elen #(
            .XLEN(XLEN),
            .ELEN(ELEN),
            .FELEN(FELEN),
            .IELEN(IELEN)
        ) u_kv_vfmis_elen0 (
            .clk(clk),
            .rstn(rstn),
            .vfmis_f1_ex_ctrl(vfmis_f1_ex_ctrl),
            .vfmis_f1_ex_frm(vfmis_f1_ex_frm),
            .vfmis_f1_op1(vfmis_f1_op1),
            .vfmis_vs1_src(vfmis_vs1_src[31:0]),
            .vfmis_vs2_src(vfmis_vs2_src[31:0]),
            .vfmis_vs2_wide_src(vfmis_vs2_wide_src[31:0]),
            .vfmis_f1_byte_mask(vfmis_f1_byte_mask[3:0]),
            .vfmis_f1_nrr_byte_mask(vfmis_f1_nrr_byte_mask[3:0]),
            .vfmis_f1_valid(vfmis_f1_valid),
            .vfmis_f2_stall(vfmis_f2_stall),
            .vfmis_f1_wdata(vfmis_f1_wdata[31:0]),
            .vfmis_f1_cmp_bit(vfmis_f1_cmp_bit[1:0]),
            .vfmis_f1_flag_set(s2),
            .vfmis_f2_wdata(vfmis_f2_wdata[31:0]),
            .vfmis_f2_flag_set(s0),
            .vfmis_f2_narrow_wdata(vfmis_f2_narrow_wdata[15:0])
        );
        kv_vfmis_elen #(
            .XLEN(XLEN),
            .ELEN(ELEN),
            .FELEN(FELEN),
            .IELEN(IELEN)
        ) u_kv_vfmis_elen1 (
            .clk(clk),
            .rstn(rstn),
            .vfmis_f1_ex_ctrl(vfmis_f1_ex_ctrl),
            .vfmis_f1_ex_frm(vfmis_f1_ex_frm),
            .vfmis_f1_op1(vfmis_f1_op1),
            .vfmis_vs1_src(vfmis_vs1_src[63:32]),
            .vfmis_vs2_src(vfmis_vs2_src[63:32]),
            .vfmis_vs2_wide_src(vfmis_vs2_wide_src[63:32]),
            .vfmis_f1_byte_mask(vfmis_f1_byte_mask[7:4]),
            .vfmis_f1_nrr_byte_mask(vfmis_f1_nrr_byte_mask[7:4]),
            .vfmis_f1_valid(vfmis_f1_valid),
            .vfmis_f2_stall(vfmis_f2_stall),
            .vfmis_f1_wdata(vfmis_f1_wdata[63:32]),
            .vfmis_f1_cmp_bit(vfmis_f1_cmp_bit[3:2]),
            .vfmis_f1_flag_set(s3),
            .vfmis_f2_wdata(vfmis_f2_wdata[63:32]),
            .vfmis_f2_flag_set(s1),
            .vfmis_f2_narrow_wdata(vfmis_f2_narrow_wdata[31:16])
        );
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

