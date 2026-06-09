// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0


module vace (
		  vace_clk,
		  vace_reset_n,
		  vace_standby_ready,
		  vace_fflags_set,
		  vace_vxsat_set,
		  vace_dispatch_valid,
		  vace_dispatch_op1,
		  vace_dispatch_ctrl,
		  vace_dispatch_frm,
		  vace_dispatch_vxrm,
		  vace_dispatch_umisc_ctl,
		  vace_dispatch_v0t,
		  vace_dispatch_op1_hazard,
		  vace_dispatch_ready,
		  vace_dispatch_vd_len,
		  vace_dispatch_vs1_len,
		  vace_dispatch_vs2_len,
		  vace_dispatch_vs3_len,
		  vace_cmt_valid,
		  vace_cmt_kill,
		  vace_cmt_op1,
		  vace_vs1_rdata,
		  vace_vs1_rready,
		  vace_vs1_rvalid,
		  vace_vs1_rlast,
		  vace_vs2_rdata,
		  vace_vs2_rready,
		  vace_vs2_rvalid,
		  vace_vs2_rlast,
		  vace_vs3_rdata,
		  vace_vs3_rready,
		  vace_vs3_rvalid,
		  vace_vs3_rlast,
		  vace_vd_wvalid,
		  vace_vd_wready,
		  vace_vd_wdata,
		  vace_vd_wmask,
		  vace_vd_wlast,
		  vace_srf_wvalid,
		  vace_srf_wready,
		  vace_srf_wfrf,
		  vace_srf_waddr,
		  vace_srf_wdata
);

parameter VLEN           = 512;
parameter DLEN           = 512;
parameter VRF_LW         = 3;
parameter VACE_CTRL_BITS = 32;

input                                  vace_clk;
input                                  vace_reset_n;

output                                 vace_standby_ready;

output                           [4:0] vace_fflags_set;
output                                 vace_vxsat_set;

input                                  vace_dispatch_valid;
input                           [63:0] vace_dispatch_op1;
input             [VACE_CTRL_BITS-1:0] vace_dispatch_ctrl;
input                            [2:0] vace_dispatch_frm;
input                            [1:0] vace_dispatch_vxrm;
input                            [3:0] vace_dispatch_umisc_ctl;
input                       [VLEN-1:0] vace_dispatch_v0t;
input                                  vace_dispatch_op1_hazard;
output                                 vace_dispatch_ready;
input                   [(VRF_LW-1):0] vace_dispatch_vd_len;
input                   [(VRF_LW-1):0] vace_dispatch_vs1_len;
input                   [(VRF_LW-1):0] vace_dispatch_vs2_len;
input                   [(VRF_LW-1):0] vace_dispatch_vs3_len;
input                                  vace_cmt_valid;
input                                  vace_cmt_kill;
input                           [63:0] vace_cmt_op1;

input                     [(DLEN-1):0] vace_vs1_rdata;
output                                 vace_vs1_rready;
input                                  vace_vs1_rvalid;
input                                  vace_vs1_rlast;
input                     [(DLEN-1):0] vace_vs2_rdata;
output                                 vace_vs2_rready;
input                                  vace_vs2_rvalid;
input                                  vace_vs2_rlast;
input                     [(DLEN-1):0] vace_vs3_rdata;
output                                 vace_vs3_rready;
input                                  vace_vs3_rvalid;
input                                  vace_vs3_rlast;
output                                 vace_vd_wvalid;
input                                  vace_vd_wready;
output                      [DLEN-1:0] vace_vd_wdata;
output                  [(DLEN/8)-1:0] vace_vd_wmask;
input                                  vace_vd_wlast;

output                                 vace_srf_wvalid;
input                                  vace_srf_wready;
output                                 vace_srf_wfrf;
output                           [4:0] vace_srf_waddr;
output                          [63:0] vace_srf_wdata;





// 3d31fef2 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif

assign vace_standby_ready = 1'b1;

assign vace_dispatch_ready = 1'b0;

assign vace_vs1_rready     = 1'b0;
assign vace_vs2_rready     = 1'b0;
assign vace_vs3_rready     = 1'b0;

assign vace_vd_wvalid      = 1'b0;
assign vace_vd_wdata       = {DLEN{1'd0}};
assign vace_vd_wmask       = {(DLEN/8){1'b0}};

assign vace_srf_wvalid = 1'b0;
assign vace_srf_wfrf   = 1'b0;
assign vace_srf_waddr  = 5'd0;
assign vace_srf_wdata  = 64'd0;

assign vace_fflags_set = 5'd0;
assign vace_vxsat_set  = 1'd0;

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

