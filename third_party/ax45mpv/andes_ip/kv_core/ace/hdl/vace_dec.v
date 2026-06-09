// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0


module vace_dec (
        	  vace_dec_instr,
        	  vace_dec_vtype,
        	  vace_dec_vstart,
        	  vace_dec_vl,
        	  vace_dec_instr_fu_vace,
        	  vace_dec_vs1_ren,
        	  vace_dec_vs2_ren,
        	  vace_dec_vs3_ren,
        	  vace_dec_vd_wen,
        	  vace_dec_vs1_wholereg,
        	  vace_dec_vs1_nreg,
        	  vace_dec_vs1_x1,
        	  vace_dec_vs1_x2,
        	  vace_dec_vs1_eew1,
        	  vace_dec_vs1_eew8,
        	  vace_dec_vs1_eew16,
        	  vace_dec_vs1_eew32,
        	  vace_dec_vs1_eew64,
        	  vace_dec_vs2_wholereg,
        	  vace_dec_vs2_nreg,
        	  vace_dec_vs2_x1,
        	  vace_dec_vs2_x2,
        	  vace_dec_vs2_eew1,
        	  vace_dec_vs2_eew8,
        	  vace_dec_vs2_eew16,
        	  vace_dec_vs2_eew32,
        	  vace_dec_vs2_eew64,
        	  vace_dec_vd_wholereg,
        	  vace_dec_vd_nreg,
        	  vace_dec_vd_x1,
        	  vace_dec_vd_x2,
        	  vace_dec_vd_eew1,
        	  vace_dec_vd_eew8,
        	  vace_dec_vd_eew16,
        	  vace_dec_vd_eew32,
        	  vace_dec_vd_eew64,
        	  vace_dec_use_v0t,
        	  vace_dec_rs1_ren,
        	  vace_dec_rs2_ren,
        	  vace_dec_rd1_wen,
        	  vace_dec_frs1_ren,
        	  vace_dec_frd1_wen,
        	  vace_dec_sew8_ill,
        	  vace_dec_sew16_ill,
        	  vace_dec_sew32_ill,
        	  vace_dec_sew64_ill,
        	  vace_dec_vstart_ill,
        	  vace_dec_ctrl,
        	  vace_dec_legal_nfp,
        	  vace_dec_legal_fp
);
parameter VACE_CTRL_BITS = 32;

input                         [31:0] vace_dec_instr;
input                          [7:0] vace_dec_vtype;
input                          [9:0] vace_dec_vstart;
input                         [10:0] vace_dec_vl;

output                               vace_dec_instr_fu_vace;

output                               vace_dec_vs1_ren;
output                               vace_dec_vs2_ren;
output                               vace_dec_vs3_ren;
output                               vace_dec_vd_wen;



output                               vace_dec_vs1_wholereg;
output                         [2:0] vace_dec_vs1_nreg;
output                               vace_dec_vs1_x1;
output                               vace_dec_vs1_x2;
output                               vace_dec_vs1_eew1;
output                               vace_dec_vs1_eew8;
output                               vace_dec_vs1_eew16;
output                               vace_dec_vs1_eew32;
output                               vace_dec_vs1_eew64;

output                               vace_dec_vs2_wholereg;
output                         [2:0] vace_dec_vs2_nreg;
output                               vace_dec_vs2_x1;
output                               vace_dec_vs2_x2;
output                               vace_dec_vs2_eew1;
output                               vace_dec_vs2_eew8;
output                               vace_dec_vs2_eew16;
output                               vace_dec_vs2_eew32;
output                               vace_dec_vs2_eew64;

output                               vace_dec_vd_wholereg;
output                         [2:0] vace_dec_vd_nreg;
output                               vace_dec_vd_x1;
output                               vace_dec_vd_x2;
output                               vace_dec_vd_eew1;
output                               vace_dec_vd_eew8;
output                               vace_dec_vd_eew16;
output                               vace_dec_vd_eew32;
output                               vace_dec_vd_eew64;

output                               vace_dec_use_v0t;

output                               vace_dec_rs1_ren;
output                               vace_dec_rs2_ren;
output                               vace_dec_rd1_wen;
output                               vace_dec_frs1_ren;
output                               vace_dec_frd1_wen;

output                               vace_dec_sew8_ill;
output                               vace_dec_sew16_ill;
output                               vace_dec_sew32_ill;
output                               vace_dec_sew64_ill;

output                               vace_dec_vstart_ill;

output          [VACE_CTRL_BITS-1:0] vace_dec_ctrl;

output                               vace_dec_legal_nfp;
output                               vace_dec_legal_fp;





// 89f5f1f2 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif

assign vace_dec_instr_fu_vace = 1'b0;

assign vace_dec_ctrl = {VACE_CTRL_BITS{1'b0}};

assign vace_dec_legal_nfp = 1'b0;
assign vace_dec_legal_fp = 1'b0;

assign vace_dec_vs1_ren = 1'b0;
assign vace_dec_vs2_ren = 1'b0;
assign vace_dec_vs3_ren = 1'b0;
assign vace_dec_vd_wen  = 1'b0;

assign vace_dec_vs1_wholereg = 1'b0;
assign vace_dec_vs1_nreg     = 3'd0;
assign vace_dec_vs1_x1       = 1'b0;
assign vace_dec_vs1_x2       = 1'b0;
assign vace_dec_vs1_eew1     = 1'b0;
assign vace_dec_vs1_eew8     = 1'b0;
assign vace_dec_vs1_eew16    = 1'b0;
assign vace_dec_vs1_eew32    = 1'b0;
assign vace_dec_vs1_eew64    = 1'b0;

assign vace_dec_vs2_wholereg = 1'b0;
assign vace_dec_vs2_nreg     = 3'd0;
assign vace_dec_vs2_x1       = 1'b0;
assign vace_dec_vs2_x2       = 1'b0;
assign vace_dec_vs2_eew1     = 1'b0;
assign vace_dec_vs2_eew8     = 1'b0;
assign vace_dec_vs2_eew16    = 1'b0;
assign vace_dec_vs2_eew32    = 1'b0;
assign vace_dec_vs2_eew64    = 1'b0;

assign vace_dec_vd_wholereg  = 1'b0;
assign vace_dec_vd_nreg      = 3'd0;
assign vace_dec_vd_x1        = 1'b0;
assign vace_dec_vd_x2        = 1'b0;
assign vace_dec_vd_eew1      = 1'b0;
assign vace_dec_vd_eew8      = 1'b0;
assign vace_dec_vd_eew16     = 1'b0;
assign vace_dec_vd_eew32     = 1'b0;
assign vace_dec_vd_eew64     = 1'b0;

assign vace_dec_use_v0t      = 1'b0;

assign vace_dec_rs1_ren = 1'b0;
assign vace_dec_rs2_ren = 1'b0;
assign vace_dec_rd1_wen = 1'b0;

assign vace_dec_frs1_ren = 1'b0;
assign vace_dec_frd1_wen = 1'b0;

assign vace_dec_sew8_ill = 1'b0;
assign vace_dec_sew16_ill = 1'b0;
assign vace_dec_sew32_ill = 1'b0;
assign vace_dec_sew64_ill = 1'b0;

assign vace_dec_vstart_ill = 1'b0;

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

