// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfdiv_dlen (
    clk,
    rstn,
    vfdiv_req_ex_ctrl,
    vfdiv_req_ex_frm,
    vfdiv_req_op1,
    vfdiv_req_vs1_src,
    vfdiv_req_vs2_src,
    vfdiv_req_byte_mask,
    vfdiv_req_valid,
    vfdiv_req_ready,
    vfdiv_kill,
    vfdiv_resp_wdata,
    vfdiv_resp_flag_set,
    vfdiv_resp_valid,
    vfdiv_resp_ready
);
parameter XLEN = 64;
parameter ELEN = 64;
parameter FLEN = 64;
parameter DLEN = 512;
input clk;
input rstn;
input [39 - 1:0] vfdiv_req_ex_ctrl;
input [2:0] vfdiv_req_ex_frm;
input [XLEN - 1:0] vfdiv_req_op1;
input [DLEN - 1:0] vfdiv_req_vs1_src;
input [DLEN - 1:0] vfdiv_req_vs2_src;
input [DLEN / 8 - 1:0] vfdiv_req_byte_mask;
input vfdiv_req_valid;
output vfdiv_req_ready;
input vfdiv_kill;
output [DLEN - 1:0] vfdiv_resp_wdata;
output [4:0] vfdiv_resp_flag_set;
output vfdiv_resp_valid;
input vfdiv_resp_ready;





// 874d7621 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [4:0] vfdiv_f2_flag_set;
wire [DLEN / 64 - 1:0] s0;
wire [DLEN / 64 - 1:0] s1;
wire [DLEN / 64 - 1:0] s2;
wire [DLEN / 64 - 1:0] s3;
wire [DLEN / 64 - 1:0] s4;
wire [DLEN / 64 - 1:0] s5;
wire [DLEN / 64 - 1:0] s6;
assign vfdiv_resp_valid = s5[0];
assign vfdiv_req_ready = s6[0];
assign vfdiv_resp_flag_set = vfdiv_f2_flag_set;
assign vfdiv_f2_flag_set[0] = |s0;
assign vfdiv_f2_flag_set[1] = |s1;
assign vfdiv_f2_flag_set[2] = |s2;
assign vfdiv_f2_flag_set[3] = |s3;
assign vfdiv_f2_flag_set[4] = |s4;
generate
    genvar i;
    for (i = 0; i < DLEN / 64; i = i + 1) begin:gen_vfdiv
        reg [39 - 1:0] vfdiv_f1_ex_ctrl;
        reg [2:0] vfdiv_f1_ex_frm;
        reg [XLEN - 1:0] vfdiv_f1_op1;
        reg [63:0] vfdiv_f1_vs1_src;
        reg [63:0] vfdiv_f1_vs2_src;
        reg [7:0] vfdiv_f1_byte_mask;
        reg vfdiv_f1_valid;
        wire s7;
        wire s8;
        wire s9;
        wire s10;
        wire vfdiv_f1_ready;
        wire s11;
        wire s12;
        wire s13;
        wire [63:0] s14;
        wire [3:0] s15;
        wire s16;
        wire [4:0] s17;
        assign s0[i] = s17[0];
        assign s1[i] = s17[1];
        assign s2[i] = s17[2];
        assign s3[i] = s17[3];
        assign s4[i] = s17[4];
        assign s6[i] = vfdiv_f1_ready & ~vfdiv_f1_valid;
        assign s9 = vfdiv_req_ready & vfdiv_req_valid;
        assign s7 = vfdiv_req_valid | vfdiv_f1_valid | vfdiv_kill;
        assign s8 = (vfdiv_req_ready & vfdiv_req_valid);
        always @(posedge clk or negedge rstn) begin
            if (!rstn) begin
                vfdiv_f1_valid <= 1'b0;
            end
            else if (s7) begin
                vfdiv_f1_valid <= s8;
            end
        end

        assign s10 = vfdiv_f1_valid & ~vfdiv_kill;
        assign s15 = vfdiv_req_ex_ctrl[13 +:4];
        assign s16 = vfdiv_req_ex_ctrl[1];
        assign s11 = ((FLEN == 64) & (&vfdiv_req_op1[63:16])) | ((FLEN == 32) & (&vfdiv_req_op1[31:16]));
        assign s12 = ((FLEN == 64) & (&vfdiv_req_op1[63:32])) | (FLEN == 32);
        assign s13 = 1'b1;
        assign s14 = ({64{s15[1] & s11 & ~s16}} & {4{vfdiv_req_op1[15:0]}}) | ({64{s15[1] & ~s11 & ~s16}} & {4{16'h7e00}}) | ({64{s15[1] & s11 & s16}} & {4{vfdiv_req_op1[15:0]}}) | ({64{s15[1] & ~s11 & s16}} & {4{16'h7fc0}}) | ({64{s15[2] & s12}} & {2{vfdiv_req_op1[31:0]}}) | ({64{s15[2] & ~s12}} & {2{32'h7fc00000}}) | ({64{s15[3] & s13}} & vfdiv_req_op1[63:0]) | ({64{s15[3] & ~s13}} & 64'h7ff8000000000000);
        always @(posedge clk or negedge rstn) begin
            if (!rstn) begin
                vfdiv_f1_ex_ctrl <= {39{1'b0}};
                vfdiv_f1_ex_frm <= 3'd0;
                vfdiv_f1_op1 <= {XLEN{1'b0}};
                vfdiv_f1_vs1_src <= 64'b0;
                vfdiv_f1_vs2_src <= 64'b0;
                vfdiv_f1_byte_mask <= 8'b0;
            end
            else if (s9) begin
                vfdiv_f1_ex_ctrl <= vfdiv_req_ex_ctrl;
                vfdiv_f1_ex_frm <= vfdiv_req_ex_frm;
                vfdiv_f1_op1 <= s14;
                vfdiv_f1_vs1_src <= vfdiv_req_vs1_src[i * 64 +:64];
                vfdiv_f1_vs2_src <= vfdiv_req_vs2_src[i * 64 +:64];
                vfdiv_f1_byte_mask <= vfdiv_req_byte_mask[i * 8 +:8];
            end
        end

        kv_vfdiv_lane #(
            .XLEN(XLEN),
            .ELEN(ELEN)
        ) u_kv_vfdiv_lane (
            .clk(clk),
            .rstn(rstn),
            .vfdiv_f1_ex_ctrl(vfdiv_f1_ex_ctrl),
            .vfdiv_f1_ex_frm(vfdiv_f1_ex_frm),
            .vfdiv_f1_op1(vfdiv_f1_op1),
            .vfdiv_f1_vs1_src(vfdiv_f1_vs1_src),
            .vfdiv_f1_vs2_src(vfdiv_f1_vs2_src),
            .vfdiv_f1_byte_mask(vfdiv_f1_byte_mask),
            .vfdiv_f1_valid(s10),
            .vfdiv_f1_ready(vfdiv_f1_ready),
            .vfdiv_f2_kill(vfdiv_kill),
            .vfdiv_f2_resp_valid(s5[i]),
            .vfdiv_f2_resp_ready(vfdiv_resp_ready),
            .vfdiv_f2_wdata(vfdiv_resp_wdata[i * 64 +:64]),
            .vfdiv_f2_flag_set(s17)
        );
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

