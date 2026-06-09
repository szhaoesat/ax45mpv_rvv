// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vimac_lane_stub (
    clk,
    rstn,
    vsew,
    vxrm,
    vmac_valid,
    vmac_mask_byte8,
    vmac_negmul,
    vmac_op_wide,
    vmac_op_sign,
    vmac_src_sign,
    vmac_instr_qmac,
    vmac_instr_vsmul,
    vmac_instr_vd4dot,
    vmac_ret_hi,
    vmac_src64_1,
    vmac_src64_2,
    vmac_src64_3,
    vmac_stall,
    vmac_data64,
    vmac_vxsat_set
);
input clk;
input rstn;
input [1:0] vsew;
input [1:0] vxrm;
input vmac_valid;
input [7:0] vmac_mask_byte8;
input vmac_negmul;
input vmac_op_wide;
input vmac_op_sign;
input vmac_src_sign;
input vmac_instr_qmac;
input vmac_instr_vsmul;
input vmac_instr_vd4dot;
input vmac_ret_hi;
input [63:0] vmac_src64_1;
input [63:0] vmac_src64_2;
input [63:0] vmac_src64_3;
input vmac_stall;
output [63:0] vmac_data64;
output vmac_vxsat_set;





// 249f8dc9 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


parameter ELEN = 64;
assign vmac_data64 = 64'b0;
assign vmac_vxsat_set = 1'b0;
wire nds_unused_input = clk | rstn | (|vsew) | (|vxrm) | vmac_valid | (|vmac_mask_byte8) | vmac_negmul | vmac_op_wide | vmac_op_sign | vmac_src_sign | vmac_instr_qmac | vmac_instr_vsmul | vmac_instr_vd4dot | vmac_ret_hi | (|vmac_src64_1) | (|vmac_src64_2) | (|vmac_src64_3) | vmac_stall;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

