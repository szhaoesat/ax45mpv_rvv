// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfdiv_lane (
    clk,
    rstn,
    vfdiv_f1_ex_ctrl,
    vfdiv_f1_ex_frm,
    vfdiv_f1_op1,
    vfdiv_f1_vs1_src,
    vfdiv_f1_vs2_src,
    vfdiv_f1_byte_mask,
    vfdiv_f1_valid,
    vfdiv_f1_ready,
    vfdiv_f2_kill,
    vfdiv_f2_wdata,
    vfdiv_f2_flag_set,
    vfdiv_f2_resp_valid,
    vfdiv_f2_resp_ready
);
parameter XLEN = 64;
parameter ELEN = 64;
input clk;
input rstn;
input [39 - 1:0] vfdiv_f1_ex_ctrl;
input [2:0] vfdiv_f1_ex_frm;
input [XLEN - 1:0] vfdiv_f1_op1;
input [63:0] vfdiv_f1_vs1_src;
input [63:0] vfdiv_f1_vs2_src;
input [7:0] vfdiv_f1_byte_mask;
input vfdiv_f1_valid;
output vfdiv_f1_ready;
input vfdiv_f2_kill;
output [63:0] vfdiv_f2_wdata;
output [4:0] vfdiv_f2_flag_set;
output vfdiv_f2_resp_valid;
input vfdiv_f2_resp_ready;





// a89d8a17 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


generate
    if (ELEN == 64) begin:gen_one_elen_lane
        kv_vfdiv_elen #(
            .XLEN(XLEN),
            .ELEN(ELEN)
        ) u_kv_vfdiv_elen (
            .clk(clk),
            .rstn(rstn),
            .vfdiv_f1_ex_ctrl(vfdiv_f1_ex_ctrl),
            .vfdiv_f1_ex_frm(vfdiv_f1_ex_frm),
            .vfdiv_f1_op1(vfdiv_f1_op1),
            .vfdiv_f1_vs1_src(vfdiv_f1_vs1_src),
            .vfdiv_f1_vs2_src(vfdiv_f1_vs2_src),
            .vfdiv_f1_byte_mask(vfdiv_f1_byte_mask),
            .vfdiv_f1_valid(vfdiv_f1_valid),
            .vfdiv_f1_ready(vfdiv_f1_ready),
            .vfdiv_f2_kill(vfdiv_f2_kill),
            .vfdiv_f2_resp_valid(vfdiv_f2_resp_valid),
            .vfdiv_f2_resp_ready(vfdiv_f2_resp_ready),
            .vfdiv_f2_wdata(vfdiv_f2_wdata),
            .vfdiv_f2_flag_set(vfdiv_f2_flag_set)
        );
    end
    else begin:gen_two_elen_lane
        wire [4:0] s0;
        wire [4:0] s1;
        wire nds_unused_resp_valid;
        wire nds_unused_req_ready;
        assign vfdiv_f2_flag_set = s0 | s1;
        kv_vfdiv_elen #(
            .XLEN(XLEN),
            .ELEN(ELEN)
        ) u_kv_vfdiv_elen0 (
            .clk(clk),
            .rstn(rstn),
            .vfdiv_f1_ex_ctrl(vfdiv_f1_ex_ctrl),
            .vfdiv_f1_ex_frm(vfdiv_f1_ex_frm),
            .vfdiv_f1_op1(vfdiv_f1_op1),
            .vfdiv_f1_vs1_src(vfdiv_f1_vs1_src[31:0]),
            .vfdiv_f1_vs2_src(vfdiv_f1_vs2_src[31:0]),
            .vfdiv_f1_byte_mask(vfdiv_f1_byte_mask[3:0]),
            .vfdiv_f1_valid(vfdiv_f1_valid),
            .vfdiv_f1_ready(vfdiv_f1_ready),
            .vfdiv_f2_kill(vfdiv_f2_kill),
            .vfdiv_f2_resp_valid(vfdiv_f2_resp_valid),
            .vfdiv_f2_resp_ready(vfdiv_f2_resp_ready),
            .vfdiv_f2_wdata(vfdiv_f2_wdata[31:0]),
            .vfdiv_f2_flag_set(s0)
        );
        kv_vfdiv_elen #(
            .XLEN(XLEN),
            .ELEN(ELEN)
        ) u_kv_vfdiv_elen1 (
            .clk(clk),
            .rstn(rstn),
            .vfdiv_f1_ex_ctrl(vfdiv_f1_ex_ctrl),
            .vfdiv_f1_ex_frm(vfdiv_f1_ex_frm),
            .vfdiv_f1_op1(vfdiv_f1_op1),
            .vfdiv_f1_vs1_src(vfdiv_f1_vs1_src[63:32]),
            .vfdiv_f1_vs2_src(vfdiv_f1_vs2_src[63:32]),
            .vfdiv_f1_byte_mask(vfdiv_f1_byte_mask[7:4]),
            .vfdiv_f1_valid(vfdiv_f1_valid),
            .vfdiv_f1_ready(nds_unused_req_ready),
            .vfdiv_f2_kill(vfdiv_f2_kill),
            .vfdiv_f2_resp_valid(nds_unused_resp_valid),
            .vfdiv_f2_resp_ready(vfdiv_f2_resp_ready),
            .vfdiv_f2_wdata(vfdiv_f2_wdata[63:32]),
            .vfdiv_f2_flag_set(s1)
        );
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

