// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vsrf (
    vpu_clk,
    vpu_reset_n,
    srf_standby_ready,
    vpermut_cmt_valid,
    vpermut_cmt_kill,
    vpermut_cmt_srf,
    vmask_cmt_valid,
    vmask_cmt_kill,
    vmask_cmt_srf,
    vsp_cmt_valid,
    vsp_cmt_kill,
    vsp_cmt_srf,
    vpu_srf_wvalid,
    vpu_srf_wready,
    vpu_srf_wfrf,
    vpu_srf_waddr,
    vpu_srf_wdata,
    vpermut_srf_wvalid,
    vpermut_srf_wready,
    vpermut_srf_wfrf,
    vpermut_srf_waddr,
    vpermut_srf_wdata,
    vmask_srf_wvalid,
    vmask_srf_wready,
    vmask_srf_wfrf,
    vmask_srf_waddr,
    vmask_srf_wdata,
    vsp_srf_wvalid,
    vsp_srf_wready,
    vsp_srf_wfrf,
    vsp_srf_waddr,
    vsp_srf_wdata,
    vace_srf_wvalid,
    vace_srf_wready,
    vace_srf_wfrf,
    vace_srf_waddr,
    vace_srf_wdata,
    vmac_fflags_set,
    vmac2_fflags_set,
    vfmis_fflags_set,
    vfdiv_fflags_set,
    vace_fflags_set,
    valu_vxsat_set,
    vmac_vxsat_set,
    vmac2_vxsat_set,
    vace_vxsat_set,
    vpu_fflags_set,
    vpu_vxsat_set
);
parameter MAX_VSP_SRF = 32;
localparam MAX_VMASK_SRF = 6;
localparam MAX_VPERMUT_SRF = 4;
input vpu_clk;
input vpu_reset_n;
output srf_standby_ready;
input vpermut_cmt_valid;
input vpermut_cmt_kill;
input vpermut_cmt_srf;
input vmask_cmt_valid;
input vmask_cmt_kill;
input vmask_cmt_srf;
input vsp_cmt_valid;
input vsp_cmt_kill;
input vsp_cmt_srf;
output vpu_srf_wvalid;
input vpu_srf_wready;
output vpu_srf_wfrf;
output [4:0] vpu_srf_waddr;
output [63:0] vpu_srf_wdata;
input vpermut_srf_wvalid;
output vpermut_srf_wready;
input vpermut_srf_wfrf;
input [4:0] vpermut_srf_waddr;
input [63:0] vpermut_srf_wdata;
input vmask_srf_wvalid;
output vmask_srf_wready;
input vmask_srf_wfrf;
input [4:0] vmask_srf_waddr;
input [63:0] vmask_srf_wdata;
input vsp_srf_wvalid;
output vsp_srf_wready;
input vsp_srf_wfrf;
input [4:0] vsp_srf_waddr;
input [63:0] vsp_srf_wdata;
input vace_srf_wvalid;
output vace_srf_wready;
input vace_srf_wfrf;
input [4:0] vace_srf_waddr;
input [63:0] vace_srf_wdata;
input [4:0] vmac_fflags_set;
input [4:0] vmac2_fflags_set;
input [4:0] vfmis_fflags_set;
input [4:0] vfdiv_fflags_set;
input [4:0] vace_fflags_set;
input valu_vxsat_set;
input vmac_vxsat_set;
input vmac2_vxsat_set;
input vace_vxsat_set;
output [4:0] vpu_fflags_set;
output vpu_vxsat_set;





// 65a49ebb rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif
localparam EB_DW = 64 + 5 + 1;


wire [EB_DW - 1:0] s0;
wire [EB_DW - 1:0] s1;
wire s2;
wire s3;
wire s4;
wire [MAX_VMASK_SRF - 1:0] s5;
wire s6;
wire s7;
kv_cnt_johnson #(
    .N(MAX_VMASK_SRF)
) u_vmask_srf_cnt (
    .clk(vpu_clk),
    .rst_n(vpu_reset_n),
    .up(s6),
    .dn(s7),
    .cnt(s5)
);
assign s4 = s5[0];
assign s6 = vmask_cmt_valid & vmask_cmt_srf & ~vmask_cmt_kill;
assign s7 = vmask_srf_wvalid & vmask_srf_wready;
wire s8;
wire [MAX_VSP_SRF - 1:0] s9;
wire s10;
wire s11;
kv_cnt_johnson #(
    .N(MAX_VSP_SRF)
) u_vsp_srf_cnt (
    .clk(vpu_clk),
    .rst_n(vpu_reset_n),
    .up(s10),
    .dn(s11),
    .cnt(s9)
);
assign s8 = s9[0];
assign s10 = vsp_cmt_valid & vsp_cmt_srf & ~vsp_cmt_kill;
assign s11 = vsp_srf_wvalid & vsp_srf_wready;
wire s12;
wire [MAX_VPERMUT_SRF - 1:0] s13;
wire s14;
wire s15;
kv_cnt_johnson #(
    .N(MAX_VPERMUT_SRF)
) u_vpermut_srf_cnt (
    .clk(vpu_clk),
    .rst_n(vpu_reset_n),
    .up(s14),
    .dn(s15),
    .cnt(s13)
);
assign s12 = s13[0];
assign s14 = vpermut_cmt_valid & vpermut_cmt_srf & ~vpermut_cmt_kill;
assign s15 = vpermut_srf_wvalid & vpermut_srf_wready;
wire [3:0] s16;
wire [3:0] s17;
wire [3:0] s18;
kv_arb_fp #(
    .N(4)
) u_arb_fil_int (
    .valid(s16),
    .ready(s17),
    .grant(s18)
);
assign s16[0] = s4 & vmask_srf_wvalid;
assign s16[1] = s12 & vpermut_srf_wvalid;
assign s16[2] = s8 & vsp_srf_wvalid;
assign s16[3] = vace_srf_wvalid;
assign vmask_srf_wready = s4 & s17[0] & s3;
assign vpermut_srf_wready = s12 & s17[1] & s3;
assign vsp_srf_wready = s8 & s17[2] & s3;
assign vace_srf_wready = s17[3] & s3;
assign s2 = |s16;
kv_mux_onehot #(
    .N(4),
    .W(1 + 5 + 64)
) u_vpu_srf (
    .out(s1),
    .sel(s18),
    .in({vace_srf_wfrf,vace_srf_waddr,vace_srf_wdata,vsp_srf_wfrf,vsp_srf_waddr,vsp_srf_wdata,vpermut_srf_wfrf,vpermut_srf_waddr,vpermut_srf_wdata,vmask_srf_wfrf,vmask_srf_waddr,vmask_srf_wdata})
);
assign vpu_fflags_set = vmac_fflags_set | vmac2_fflags_set | vfmis_fflags_set | vfdiv_fflags_set | vace_fflags_set;
assign vpu_vxsat_set = vmac_vxsat_set | vmac2_vxsat_set | valu_vxsat_set | vace_vxsat_set;
kv_fifo #(
    .DEPTH(2),
    .WIDTH(EB_DW)
) u_wdata (
    .clk(vpu_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wvalid(s2),
    .wready(s3),
    .wdata(s1),
    .rvalid(vpu_srf_wvalid),
    .rready(vpu_srf_wready),
    .rdata(s0)
);
assign {vpu_srf_wfrf,vpu_srf_waddr,vpu_srf_wdata} = s0;
assign srf_standby_ready = ~vpu_srf_wvalid;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

