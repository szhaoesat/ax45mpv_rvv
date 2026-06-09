// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vscb_vx (
    vpu_clk,
    vpu_reset_n,
    dis_i0_grant,
    dis_i0_vx_en,
    dis_i0_vx_addr,
    dis_i0_vx_len,
    dis_i1_grant,
    dis_i1_vx_en,
    dis_i1_vx_addr,
    dis_i1_vx_len,
    cmt_i0_grant,
    cmt_i0_kill,
    cmt_i1_grant,
    cmt_i1_kill,
    vrf_grant,
    pending,
    addr,
    len
);
parameter VRF_AW = 5;
parameter VRF_LW = 3;
input vpu_clk;
input vpu_reset_n;
input dis_i0_grant;
input dis_i0_vx_en;
input [VRF_AW - 1:0] dis_i0_vx_addr;
input [VRF_LW - 1:0] dis_i0_vx_len;
input dis_i1_grant;
input dis_i1_vx_en;
input [VRF_AW - 1:0] dis_i1_vx_addr;
input [VRF_LW - 1:0] dis_i1_vx_len;
input cmt_i0_grant;
input cmt_i0_kill;
input cmt_i1_grant;
input cmt_i1_kill;
input vrf_grant;
output pending;
output [VRF_AW - 1:0] addr;
output [VRF_LW - 1:0] len;





// 8c2d180f rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0;
reg pending;
wire s1;
reg [VRF_AW - 1:0] addr;
wire [VRF_AW - 1:0] s2;
wire [VRF_AW - 1:0] s3;
reg [VRF_LW - 1:0] len;
wire [VRF_LW - 1:0] s4 = len - {{(VRF_LW - 1){1'b0}},1'd1};
wire [VRF_LW - 1:0] s5;
wire s6 = ~|len;
wire s7;
always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        pending <= 1'b0;
    end
    else if (s0) begin
        pending <= s1;
    end
end

always @(posedge vpu_clk) begin
    if (s0) begin
        addr <= s2;
        len <= s5;
    end
end

assign s7 = (cmt_i0_grant & cmt_i0_kill) | (cmt_i1_grant & cmt_i1_kill);
assign s0 = dis_i0_grant | dis_i1_grant | vrf_grant | s7;
assign {s5,s2} = dis_i0_grant ? {dis_i0_vx_len,dis_i0_vx_addr} : dis_i1_grant ? {dis_i1_vx_len,dis_i1_vx_addr} : {s4,s3};
assign s3 = addr[VRF_AW - 1:0] + {{(VRF_AW - 1){1'b0}},1'd1};
assign s1 = s7 ? 1'b0 : dis_i0_grant ? dis_i0_vx_en : dis_i1_grant ? dis_i1_vx_en : ~s6;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

