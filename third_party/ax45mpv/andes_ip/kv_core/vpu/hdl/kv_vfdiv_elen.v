// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfdiv_elen (
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
localparam ELEN_BYTE = ELEN / 8;
input clk;
input rstn;
input [39 - 1:0] vfdiv_f1_ex_ctrl;
input [2:0] vfdiv_f1_ex_frm;
input [XLEN - 1:0] vfdiv_f1_op1;
input [ELEN - 1:0] vfdiv_f1_vs1_src;
input [ELEN - 1:0] vfdiv_f1_vs2_src;
input [ELEN_BYTE - 1:0] vfdiv_f1_byte_mask;
input vfdiv_f1_valid;
output vfdiv_f1_ready;
input vfdiv_f2_kill;
output [ELEN - 1:0] vfdiv_f2_wdata;
output [4:0] vfdiv_f2_flag_set;
output vfdiv_f2_resp_valid;
input vfdiv_f2_resp_ready;





// 92f1ba03 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [39 - 1:0] s0 = vfdiv_f1_ex_ctrl;
wire [2:0] s1 = vfdiv_f1_ex_frm;
wire [XLEN - 1:0] s2 = vfdiv_f1_op1;
wire [ELEN_BYTE - 1:0] s3 = vfdiv_f1_byte_mask;
wire wb_stall = ~vfdiv_f2_resp_ready;
wire s4 = vfdiv_f2_kill;
wire f1_valid = vfdiv_f1_valid;
wire [ELEN - 1:0] s5;
wire [4:0] s6;
wire s7;
assign vfdiv_f2_wdata = s5;
assign vfdiv_f2_resp_valid = s7;
assign vfdiv_f2_flag_set = s6;
reg [ELEN_BYTE - 1:0] s8;
wire [ELEN - 1:0] s9 = vfdiv_f1_vs1_src;
wire [ELEN - 1:0] s10 = vfdiv_f1_vs2_src;
wire f1_fp_mode = s0[1];
wire [3:0] f1_sew = s0[13 +:4];
wire s11;
wire [2:0] f1_round_mode = s1;
wire f1_vfdiv = s0[0];
wire f1_vfsqrt = s0[4];
wire f1_vfrece7 = s0[2];
wire f1_vfrsqrte7 = s0[3];
wire [1:0] s12 = s0[8 +:2];
wire [2:0] s13 = s0[10 +:3];
reg [3:0] s14;
wire [63:0] s15;
wire [4:0] s16;
wire [63:0] s17;
wire [4:0] s18;
wire [63:0] s19;
wire [4:0] s20;
wire [63:0] s21;
wire [4:0] s22;
wire [1:0] nds_unused_pipe0_result_type;
wire [4:0] nds_unused_pipe0_tag;
wire nds_unused_pipe0_standby_ready;
wire [63:0] s23;
wire [63:0] s24;
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        s14 <= 4'b0;
        s8 <= {ELEN_BYTE{1'b0}};
    end
    else if (f1_valid) begin
        s14 <= f1_sew;
        s8 <= s3;
    end
end

generate
    if (ELEN == 64) begin:gen_pipe0_elen64
        assign s23 = ({64{s12[0]}} & s10) | ({64{s12[1]}} & s2);
        assign s24 = ({64{s13[0]}} & s9) | ({64{s13[1]}} & s2) | ({64{s13[2]}} & s10);
    end
    else begin:gen_pipe0_elen32
        assign s23 = ({64{s12[0]}} & {32'b0,s10[31:0]}) | ({64{s12[1]}} & {32'b0,s2[31:0]});
        assign s24 = ({64{s13[0]}} & {32'b0,s9[31:0]}) | ({64{s13[1]}} & {32'b0,s2[31:0]}) | ({64{s13[2]}} & {32'b0,s10[31:0]});
    end
endgenerate
kv_vfp_fdiv #(
    .FLEN(ELEN)
) u_pipe0 (
    .fdiv_standby_ready(nds_unused_pipe0_standby_ready),
    .f4_wdata_en(s7),
    .f4_wdata(s15),
    .f4_flag_set(s16),
    .f4_result_type(nds_unused_pipe0_result_type),
    .f4_tag(nds_unused_pipe0_tag),
    .wb_stall(wb_stall),
    .f1_op1_data(s23),
    .f1_op2_data(s24),
    .f1_valid(f1_valid),
    .f1_round_mode(f1_round_mode),
    .f1_vfdiv(f1_vfdiv),
    .f1_vfsqrt(f1_vfsqrt),
    .f1_vfrece7(f1_vfrece7),
    .f1_vfrsqrte7(f1_vfrsqrte7),
    .f3_main_pipe_stall(1'b0),
    .f1_sew(f1_sew[3:1]),
    .f1_fp_mode(f1_fp_mode),
    .f1_ediv(2'b0),
    .f1_tag(5'b0),
    .req_ready(s11),
    .kill(s4),
    .vpu_vfdiv_clk(clk),
    .vpu_reset_n(rstn)
);
wire [1:0] nds_unused_pipe1_result_type;
wire [4:0] nds_unused_pipe1_tag;
wire nds_unused_pipe1_standby_ready;
wire nds_unused_pipe1_wdata_en;
wire nds_unused_pipe1_req_ready;
wire [63:0] s25 = ({64{s12[0]}} & {48'b0,s10[31:16]}) | ({64{s12[1]}} & {48'b0,s2[15:0]});
wire [63:0] s26 = ({64{s13[0]}} & {48'b0,s9[31:16]}) | ({64{s13[1]}} & {48'b0,s2[15:0]}) | ({64{s13[2]}} & {48'b0,s10[31:16]});
wire s27 = f1_valid & f1_sew[1];
kv_vfp_fdiv #(
    .FLEN(16)
) u_pipe1 (
    .fdiv_standby_ready(nds_unused_pipe1_standby_ready),
    .f4_wdata_en(nds_unused_pipe1_wdata_en),
    .f4_wdata(s17),
    .f4_flag_set(s18),
    .f4_result_type(nds_unused_pipe1_result_type),
    .f4_tag(nds_unused_pipe1_tag),
    .wb_stall(wb_stall),
    .f1_op1_data(s25),
    .f1_op2_data(s26),
    .f1_valid(s27),
    .f1_round_mode(f1_round_mode),
    .f1_vfdiv(f1_vfdiv),
    .f1_vfsqrt(f1_vfsqrt),
    .f1_vfrece7(f1_vfrece7),
    .f1_vfrsqrte7(f1_vfrsqrte7),
    .f3_main_pipe_stall(1'b0),
    .f1_sew(f1_sew[3:1]),
    .f1_fp_mode(f1_fp_mode),
    .f1_ediv(2'b0),
    .f1_tag(5'b0),
    .req_ready(nds_unused_pipe1_req_ready),
    .kill(s4),
    .vpu_vfdiv_clk(clk),
    .vpu_reset_n(rstn)
);
generate
    if (ELEN == 64) begin:gen_elen64_pipe2
        wire [1:0] nds_unused_pipe2_result_type;
        wire [4:0] nds_unused_pipe2_tag;
        wire nds_unused_pipe2_standby_ready;
        wire nds_unused_pipe2_wdata_en;
        wire nds_unused_pipe2_req_ready;
        wire [63:0] s28 = ({64{s12[0]}} & {32'b0,s10[63:32]}) | ({64{s12[1]}} & {32'b0,s2[31:0]});
        wire [63:0] s29 = ({64{s13[0]}} & {32'b0,s9[63:32]}) | ({64{s13[1]}} & {32'b0,s2[31:0]}) | ({64{s13[2]}} & {32'b0,s10[63:32]});
        wire s30 = (f1_valid & f1_sew[2]) | (f1_valid & f1_sew[1]);
        kv_vfp_fdiv #(
            .FLEN(32)
        ) u_pipe2 (
            .fdiv_standby_ready(nds_unused_pipe2_standby_ready),
            .f4_wdata_en(nds_unused_pipe2_wdata_en),
            .f4_wdata(s19),
            .f4_flag_set(s20),
            .f4_result_type(nds_unused_pipe2_result_type),
            .f4_tag(nds_unused_pipe2_tag),
            .wb_stall(wb_stall),
            .f1_op1_data(s28),
            .f1_op2_data(s29),
            .f1_valid(s30),
            .f1_round_mode(f1_round_mode),
            .f1_vfdiv(f1_vfdiv),
            .f1_vfsqrt(f1_vfsqrt),
            .f1_vfrece7(f1_vfrece7),
            .f1_vfrsqrte7(f1_vfrsqrte7),
            .f3_main_pipe_stall(1'b0),
            .f1_sew(f1_sew[3:1]),
            .f1_fp_mode(f1_fp_mode),
            .f1_ediv(2'b0),
            .f1_tag(5'b0),
            .req_ready(nds_unused_pipe2_req_ready),
            .kill(s4),
            .vpu_vfdiv_clk(clk),
            .vpu_reset_n(rstn)
        );
    end
    else begin:gen_pipe2_elen32
        assign s19 = 64'b0;
        assign s20 = 5'b0;
    end
endgenerate
generate
    if (ELEN == 64) begin:gen_elen64_pipe3
        wire [1:0] nds_unused_pipe3_result_type;
        wire [4:0] nds_unused_pipe3_tag;
        wire nds_unused_pipe3_standby_ready;
        wire nds_unused_pipe3_wdata_en;
        wire nds_unused_pipe3_req_ready;
        wire [63:0] s31 = ({64{s12[0]}} & {48'b0,s10[63:48]}) | ({64{s12[1]}} & {48'b0,s2[15:0]});
        wire [63:0] s32 = ({64{s13[0]}} & {48'b0,s9[63:48]}) | ({64{s13[1]}} & {48'b0,s2[15:0]}) | ({64{s13[2]}} & {48'b0,s10[63:48]});
        wire s33 = f1_valid & f1_sew[1];
        kv_vfp_fdiv #(
            .FLEN(16)
        ) u_pipe3 (
            .fdiv_standby_ready(nds_unused_pipe3_standby_ready),
            .f4_wdata_en(nds_unused_pipe3_wdata_en),
            .f4_wdata(s21),
            .f4_flag_set(s22),
            .f4_result_type(nds_unused_pipe3_result_type),
            .f4_tag(nds_unused_pipe3_tag),
            .wb_stall(wb_stall),
            .f1_op1_data(s31),
            .f1_op2_data(s32),
            .f1_valid(s33),
            .f1_round_mode(f1_round_mode),
            .f1_vfdiv(f1_vfdiv),
            .f1_vfsqrt(f1_vfsqrt),
            .f1_vfrece7(f1_vfrece7),
            .f1_vfrsqrte7(f1_vfrsqrte7),
            .f3_main_pipe_stall(1'b0),
            .f1_sew(f1_sew[3:1]),
            .f1_fp_mode(f1_fp_mode),
            .f1_ediv(2'b0),
            .f1_tag(5'b0),
            .req_ready(nds_unused_pipe3_req_ready),
            .kill(s4),
            .vpu_vfdiv_clk(clk),
            .vpu_reset_n(rstn)
        );
    end
    else begin:gen_pipe3_elen32
        assign s21 = 64'b0;
        assign s22 = 5'b0;
    end
endgenerate
generate
    if (ELEN == 64) begin:gen_elen64_result
        assign s5 = ({64{s14[3]}} & s15) | ({64{s14[2]}} & {s19[31:0],s15[31:0]}) | ({64{s14[1]}} & {s21[15:0],s19[15:0],s17[15:0],s15[15:0]});
        assign s6 = ({5{s8[0]}} & s16) | ({5{s8[2] & s14[1]}} & s18) | ({5{s8[4] & s14[2]}} & s20) | ({5{s8[4] & s14[1]}} & s20) | ({5{s8[6] & s14[1]}} & s22);
    end
    else begin:gen_elen32_result
        wire nds_unused_wire = (|s19) | (|s21) | (|s20) | (|s22);
        assign s5 = ({32{s14[2]}} & {s15[31:0]}) | ({32{s14[1]}} & {s17[15:0],s15[15:0]});
        assign s6 = ({5{s8[0]}} & s16) | ({5{s8[2] & s14[1]}} & s18);
    end
endgenerate
assign vfdiv_f1_ready = s11;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

