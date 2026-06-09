// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vcmt_dis (
    vpu_clk,
    vpu_reset_n,
    dis_i0_grant,
    dis_i1_grant,
    cmt_i0_grant,
    cmt_i1_grant,
    cmt_i0_dispatched,
    cmt_i1_dispatched
);
parameter AGEN = 6;
input vpu_clk;
input vpu_reset_n;
input dis_i0_grant;
input dis_i1_grant;
input cmt_i0_grant;
input cmt_i1_grant;
output cmt_i0_dispatched;
output cmt_i1_dispatched;





// fc9b6cbe rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [AGEN - 1:0] s0;
wire [AGEN - 1:0] s1;
wire [AGEN - 1:0] s2;
wire s3;
always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s0 <= {AGEN{1'b0}};
    end
    else if (s3) begin
        s0 <= s1;
    end
end

assign s2 = (dis_i0_grant & dis_i1_grant) ? {s0[AGEN - 3:0],2'd3} : dis_i0_grant ? {s0[AGEN - 2:0],1'd1} : s0[AGEN - 1:0];
assign s1 = (cmt_i0_grant & cmt_i1_grant) ? {2'd0,s2[AGEN - 1:2]} : cmt_i0_grant ? {1'd0,s2[AGEN - 1:1]} : s2[AGEN - 1:0];
assign s3 = dis_i0_grant | dis_i1_grant | cmt_i0_grant | cmt_i1_grant;
assign cmt_i0_dispatched = s0[0];
assign cmt_i1_dispatched = s0[1];
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

