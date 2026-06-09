// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vdiv_op (
    vpu_vdiv_clk,
    vpu_reset_n,
    e0_sew,
    e0_lmul,
    e0_sign,
    e0_mask,
    e0_vrem,
    e0_src1,
    e0_src2,
    e1_ex_req_ready,
    e1_ex_req_valid,
    e1_ex_wdata,
    e1_ex_mask,
    e1_ex_resp_valid,
    e1_ex_resp_ready
);
parameter VLEN = 512;
parameter DLEN = 512;
parameter ELEN = 64;
localparam LANE64_CNT = (DLEN / 64) > 0 ? (DLEN / 64) : 1;
localparam MASK_LEN = DLEN / 8;
localparam BYTE_LMULF8 = VLEN / 64;
localparam BYTE_LMULF4 = VLEN / 32;
localparam BYTE_LMULF2 = VLEN / 16;
input vpu_vdiv_clk;
input vpu_reset_n;
input [DLEN - 1:0] e0_src1;
input [DLEN - 1:0] e0_src2;
input [DLEN - 1:0] e0_mask;
input [1:0] e0_sew;
input [2:0] e0_lmul;
input e0_sign;
input e0_vrem;
output e1_ex_resp_valid;
input e1_ex_resp_ready;
output e1_ex_req_ready;
input e1_ex_req_valid;
output [DLEN - 1:0] e1_ex_wdata;
output [MASK_LEN - 1:0] e1_ex_mask;





// 24eda8cb rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [LANE64_CNT - 1:0] s0;
wire [LANE64_CNT - 1:0] s1;
wire [LANE64_CNT - 1:0] s2;
wire [LANE64_CNT - 1:0] s3;
assign e1_ex_resp_valid = &s0;
assign e1_ex_req_ready = ~(|s1);
generate
    genvar gen_i;
    for (gen_i = 0; gen_i < LANE64_CNT; gen_i = gen_i + 1) begin:gen_vdiv64
        kv_vdiv64 #(
            .ELEN(ELEN)
        ) vdiv64 (
            .clk(vpu_vdiv_clk),
            .rstn(vpu_reset_n),
            .vdiv_data64(e1_ex_wdata[(64 * gen_i) +:64]),
            .vdiv_mask8(e1_ex_mask[(8 * gen_i) +:8]),
            .vsew(e0_sew),
            .vdiv_valid(e1_ex_req_valid),
            .vdiv_ready(s0[gen_i]),
            .vdiv_idle(s3[gen_i]),
            .vdiv_busy(s1[gen_i]),
            .vdiv_busy_last(s2[gen_i]),
            .vdiv_wb_ready(e1_ex_resp_ready),
            .vdiv_mask_byte8(e0_mask[(8 * gen_i) +:8]),
            .vdiv_ex_ctrl(e0_vrem),
            .vdiv_op_sign(e0_sign),
            .vdiv_src64_1(e0_src2[(64 * gen_i) +:64]),
            .vdiv_src64_2(e0_src1[(64 * gen_i) +:64])
        );
    end
endgenerate
wire nds_unused_vdiv_op_wire = (|s2) | (|s3);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

