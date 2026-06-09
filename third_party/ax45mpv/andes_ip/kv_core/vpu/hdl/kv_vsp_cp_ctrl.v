// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vsp_cp_ctrl (
    vpu_vsp_clk,
    vpu_reset_n,
    cp_cpu_rdata_valid,
    cp_cpu_rdata_ready,
    cp_cpu_rdata,
    ace_streaming_data_in,
    ace_streaming_data_in_ready,
    ace_streaming_data_in_valid,
    cp2srf_rvalid,
    cp2srf_rready,
    cp2srf_rlast,
    cp2srf_rdata,
    cp2vrf_rvalid,
    cp2vrf_rready,
    cp2vrf_rlast,
    cp2vrf_rdata,
    cp2vrf_dummy_ex_done,
    cp2vrf_dummy_ex_ready,
    veq_cmt_cp2ld_grant,
    veq_cmt_cp2ld_type,
    veq_cmt_cp2ld_dummy,
    vsp_cp_ctrl_standby_ready,
    vpu_sp_ex_done,
    vpu_sp_ex_store,
    vpu_sp_ex_error
);
parameter VSP_DATA_WIDTH = 512;
parameter VEQ_DEPTH = 4;
parameter ACE_SP_MODE = 0;
parameter RAR_SUPPORT = 0;
input vpu_vsp_clk;
input vpu_reset_n;
input cp_cpu_rdata_valid;
output cp_cpu_rdata_ready;
input [(VSP_DATA_WIDTH - 1):0] cp_cpu_rdata;
input [(VSP_DATA_WIDTH - 1):0] ace_streaming_data_in;
output ace_streaming_data_in_ready;
input ace_streaming_data_in_valid;
output cp2srf_rvalid;
input cp2srf_rready;
input cp2srf_rlast;
output [(VSP_DATA_WIDTH - 1):0] cp2srf_rdata;
output cp2vrf_rvalid;
input cp2vrf_rready;
input cp2vrf_rlast;
output [(VSP_DATA_WIDTH - 1):0] cp2vrf_rdata;
output cp2vrf_dummy_ex_done;
input cp2vrf_dummy_ex_ready;
input veq_cmt_cp2ld_grant;
input veq_cmt_cp2ld_type;
input veq_cmt_cp2ld_dummy;
output vsp_cp_ctrl_standby_ready;
input vpu_sp_ex_done;
input vpu_sp_ex_store;
input vpu_sp_ex_error;





// b7d2bf1d rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0;
wire s1;
wire [(VSP_DATA_WIDTH - 1):0] s2;
wire s3;
wire s4;
wire [(VSP_DATA_WIDTH - 1):0] s5;
wire nds_unused_veq_cmt_cp2ld_wready;
wire [1:0] s6;
wire [1:0] s7;
wire s8;
wire s9;
wire s10;
wire s11;
wire s12;
wire s13;
generate
    if (ACE_SP_MODE == 0) begin:gen_fsp
        kv_eb_full_i #(
            .DW(VSP_DATA_WIDTH)
        ) u_cp_rdata (
            .clk(vpu_vsp_clk),
            .resetn(vpu_reset_n),
            .clk_en(1'b1),
            .i_valid(cp_cpu_rdata_valid),
            .i_ready(cp_cpu_rdata_ready),
            .din(cp_cpu_rdata),
            .o_valid(s3),
            .o_ready(s4),
            .dout(s5)
        );
        wire nds_unused_ace_streaming_data_in_valid = ace_streaming_data_in_valid;
        wire [(VSP_DATA_WIDTH - 1):0] nds_unused_ace_streaming_data_in = ace_streaming_data_in;
        assign ace_streaming_data_in_ready = 1'b0;
        assign s0 = s12 & (s3 | s13);
        assign s4 = s1 & s12 & ~s13;
        assign s2 = s5 & {VSP_DATA_WIDTH{~s13}};
    end
    if (ACE_SP_MODE == 1) begin:gen_asp
        kv_eb_full_i #(
            .DW(VSP_DATA_WIDTH)
        ) u_cp_rdata (
            .clk(vpu_vsp_clk),
            .resetn(vpu_reset_n),
            .clk_en(1'b1),
            .i_valid(ace_streaming_data_in_valid),
            .i_ready(ace_streaming_data_in_ready),
            .din(ace_streaming_data_in),
            .o_valid(s3),
            .o_ready(s4),
            .dout(s5)
        );
        wire nds_unused_cp_cpu_rdata_valid = cp_cpu_rdata_valid;
        wire [(VSP_DATA_WIDTH - 1):0] nds_unused_cp_cpu_rdata = cp_cpu_rdata;
        assign cp_cpu_rdata_ready = 1'b0;
        assign s0 = s3;
        assign s4 = s1;
        assign s2 = s5;
        wire nds_unused_ace_load_error = s13;
    end
endgenerate
assign s6 = {veq_cmt_cp2ld_dummy,veq_cmt_cp2ld_type};
assign {s11,s10} = s7;
kv_fifo #(
    .DEPTH(VEQ_DEPTH),
    .WIDTH(2),
    .RAR_SUPPORT(RAR_SUPPORT)
) u_veq_cmt_cp2ld_info (
    .clk(vpu_vsp_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wvalid(veq_cmt_cp2ld_grant),
    .wready(nds_unused_veq_cmt_cp2ld_wready),
    .wdata(s6),
    .rvalid(s8),
    .rready(s9),
    .rdata(s7)
);
assign cp2srf_rvalid = s0 & s8 & ~s10;
assign cp2vrf_rvalid = s0 & s8 & s10 & ~s11;
assign cp2srf_rdata = s2;
assign cp2vrf_rdata = s2;
assign s1 = (cp2srf_rready & s8 & ~s10) | (cp2vrf_rready & s8 & s10 & ~s11);
assign s9 = (cp2srf_rvalid & cp2srf_rready & cp2srf_rlast & s8 & ~s10) | (cp2vrf_rvalid & cp2vrf_rready & cp2vrf_rlast & s8 & s10) | (cp2vrf_dummy_ex_done & cp2vrf_dummy_ex_ready & s11);
generate
    if (ACE_SP_MODE == 0) begin:gen_fsp_load_cnt
        wire s14 = vpu_sp_ex_done & ~vpu_sp_ex_store;
        wire nds_unused_load_sent_cnt_wready;
        wire s15 = vpu_sp_ex_error;
        wire s16;
        wire s17 = s9;
        wire s18;
        kv_fifo #(
            .DEPTH(VEQ_DEPTH + 6),
            .WIDTH(1),
            .RAR_SUPPORT(RAR_SUPPORT)
        ) u_load_sent_cnt (
            .clk(vpu_vsp_clk),
            .reset_n(vpu_reset_n),
            .flush(1'b0),
            .wvalid(s14),
            .wready(nds_unused_load_sent_cnt_wready),
            .wdata(s15),
            .rvalid(s16),
            .rready(s17),
            .rdata(s18)
        );
        assign s12 = s16;
        assign s13 = s16 & s18;
        assign vsp_cp_ctrl_standby_ready = ~s3 & ~s8 & ~s12;
    end
    if (ACE_SP_MODE == 1) begin:gen_asp_load_cnt
        wire nds_unused_vpu_sp_ex_done = vpu_sp_ex_done;
        wire nds_unused_vpu_sp_ex_store = vpu_sp_ex_store;
        wire nds_unused_vpu_sp_ex_error = vpu_sp_ex_error;
        assign s12 = 1'b1;
        assign s13 = 1'b0;
        assign vsp_cp_ctrl_standby_ready = ~s3 & ~s8;
    end
endgenerate
assign cp2vrf_dummy_ex_done = s12 & s8 & s10;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

