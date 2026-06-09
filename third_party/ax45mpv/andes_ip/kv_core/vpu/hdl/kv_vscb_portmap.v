// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vscb_portmap (
    fu,
    vs1_port,
    vs2_port,
    vs3_port,
    vd_port
);
parameter ACE_SP_WRITE_PORT = 3;
input [11 - 1:0] fu;
output [11 - 1:0] vs1_port;
output [11 - 1:0] vs2_port;
output [11 - 1:0] vs3_port;
output [6 - 1:0] vd_port;





// 0226d27a rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


assign vs1_port[0] = fu[0] | fu[8] | fu[9];
assign vs1_port[1] = fu[5];
assign vs1_port[2] = 1'b0;
assign vs1_port[3] = fu[3];
assign vs1_port[4] = 1'b0;
assign vs1_port[5] = 1'b0;
assign vs1_port[6] = fu[4] | fu[6] | fu[7];
assign vs1_port[7] = 1'b0;
assign vs2_port[0] = 1'b0;
assign vs2_port[1] = fu[0] | fu[8] | fu[9];
assign vs2_port[2] = fu[5];
assign vs2_port[3] = 1'b0;
assign vs2_port[4] = fu[3];
assign vs2_port[5] = 1'b0;
assign vs2_port[6] = fu[1];
assign vs2_port[7] = fu[4] | fu[6] | fu[7];
assign vs3_port[0] = fu[5];
assign vs3_port[1] = 1'b0;
assign vs3_port[2] = fu[0] | fu[8] | fu[9];
assign vs3_port[3] = 1'b0;
assign vs3_port[4] = 1'b0;
assign vs3_port[5] = fu[3];
assign vs3_port[6] = 1'b0;
assign vs3_port[7] = fu[1] | fu[2];
assign vd_port[0] = fu[0] | fu[8] | fu[9];
assign vd_port[1] = fu[3];
assign vd_port[2] = fu[5];
assign vd_port[3] = fu[1] | (fu[2] & (ACE_SP_WRITE_PORT == 3));
assign vd_port[4] = fu[4] | fu[6] | fu[7] | (fu[2] & (ACE_SP_WRITE_PORT == 4));
assign vs1_port[8] = fu[10];
assign vs1_port[9] = 1'b0;
assign vs1_port[10] = 1'b0;
assign vs2_port[8] = 1'b0;
assign vs2_port[9] = fu[10];
assign vs2_port[10] = 1'b0;
assign vs3_port[8] = 1'b0;
assign vs3_port[9] = 1'b0;
assign vs3_port[10] = fu[10];
assign vd_port[5] = fu[10];
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

