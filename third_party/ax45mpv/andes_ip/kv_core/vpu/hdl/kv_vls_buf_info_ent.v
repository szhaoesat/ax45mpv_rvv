// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_buf_info_ent (
    vpu_vlsu_clk,
    vpu_reset_n,
    buf_return_last,
    buf_init_wvalid,
    buf_init_value,
    buf_info_clr,
    buf_cnt_req_update,
    buf_cnt_resp_update,
    buf_cnt_resp_ualign_update,
    buf_req_dlen_last,
    buf_resp_dlen_last,
    buf_ubypass_dlen_last,
    buf_unbypass_dlen_last
);
parameter DLEN_BYTE_WIDTH = 6;
parameter BUF_INFO_DW = 8;
input vpu_vlsu_clk;
input vpu_reset_n;
input buf_return_last;
input buf_init_wvalid;
input [BUF_INFO_DW - 1:0] buf_init_value;
input buf_info_clr;
input buf_cnt_req_update;
input buf_cnt_resp_update;
input buf_cnt_resp_ualign_update;
output buf_req_dlen_last;
output buf_resp_dlen_last;
output buf_ubypass_dlen_last;
output buf_unbypass_dlen_last;





// b9474668 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0;
wire s1;
reg s2;
wire s3;
reg [BUF_INFO_DW - 1:0] s4;
wire [BUF_INFO_DW - 1:0] s5;
wire [1:0] s6;
wire [1:0] s7;
wire [BUF_INFO_DW - 1:0] s8;
wire s9;
wire s10;
wire [DLEN_BYTE_WIDTH - 1:0] s11;
wire [DLEN_BYTE_WIDTH - 1:0] s12;
wire [DLEN_BYTE_WIDTH - 1:0] s13;
reg [DLEN_BYTE_WIDTH - 1:0] s14;
wire s15;
wire nds_unused_ov1;
wire nds_unused_ov2;
wire nds_unused_ov3;
wire nds_unused_ov4;
wire nds_unused_ov5;
assign buf_req_dlen_last = s2 & (s14[1:0] == s8[1:0]);
assign buf_resp_dlen_last = s2 & (s14[DLEN_BYTE_WIDTH - 1:0] == s8[DLEN_BYTE_WIDTH - 1:0]);
assign buf_unbypass_dlen_last = s2 & (s14[1:0] == s7);
assign buf_ubypass_dlen_last = s2 & (s14[1:0] == s6);
assign s15 = buf_info_clr & buf_return_last;
assign s0 = buf_init_wvalid | s15;
assign s1 = buf_init_wvalid;
assign {nds_unused_ov3,s8} = {1'b0,s4} - {{BUF_INFO_DW{1'b0}},1'd1};
assign {nds_unused_ov4,s6} = {1'b0,s4[1:0]} - 3'd1;
assign {nds_unused_ov5,s7} = {1'b0,s4[1:0]} - 3'd2;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s2 <= 1'b0;
    end
    else if (s0) begin
        s2 <= s1;
    end
end

assign s3 = buf_init_wvalid | buf_info_clr;
assign s5 = s15 ? {BUF_INFO_DW{1'b0}} : buf_init_wvalid ? buf_init_value : {2'b0,s4[BUF_INFO_DW - 1:2]};
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s4 <= {BUF_INFO_DW{1'b0}};
    end
    else if (s3) begin
        s4 <= s5;
    end
end

assign s9 = buf_cnt_req_update | buf_cnt_resp_update | buf_cnt_resp_ualign_update;
assign s10 = s9 | buf_info_clr;
assign {nds_unused_ov1,s12} = s14 + {{DLEN_BYTE_WIDTH - 1{1'b0}},1'b1};
assign {nds_unused_ov2,s13} = s14 + {{DLEN_BYTE_WIDTH - 2{1'b0}},2'd2};
assign s11 = buf_info_clr ? {DLEN_BYTE_WIDTH{1'b0}} : (buf_cnt_resp_update & buf_cnt_resp_ualign_update) ? s13 : s12;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s14 <= {DLEN_BYTE_WIDTH{1'b0}};
    end
    else if (s10) begin
        s14 <= s11;
    end
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

