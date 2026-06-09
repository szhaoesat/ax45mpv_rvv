// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_xcpt_dec (
    load,
    store,
    fof,
    xcpt_status,
    xcpt_page_dcause,
    xcpt_ecc_code,
    xcpt_ecc_corr,
    xcpt_ecc_ramid,
    vls_status
);
localparam MISALIGN = 8;
localparam HIT_ILM = 7;
localparam HIT_DLM = 6;
localparam PMA_INCONSISTENT = 5;
localparam PMA_DEVICE = 4;
localparam PMA_EMPTY_HOLE = 3;
localparam PMP_VIOLATION = 2;
localparam PAGE_ACCESS_FAULT = 1;
localparam PAGE_FAULT = 0;
input load;
input store;
input fof;
input [8:0] xcpt_status;
input [2:0] xcpt_page_dcause;
input [7:0] xcpt_ecc_code;
input xcpt_ecc_corr;
input [3:0] xcpt_ecc_ramid;
output [22 - 1:0] vls_status;





// eb9888e5 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [3:0] s0;
wire [3:0] s1;
wire [3:0] s2;
wire [3:0] s3;
wire [2:0] s4;
wire s5;
wire s6;
wire s7;
wire s8;
wire s9;
wire s10;
wire s11;
wire s12;
wire s13;
wire s14;
wire s15;
assign s5 = |xcpt_status;
assign vls_status[0 +:4] = s0;
assign vls_status[4 +:3] = s4;
assign vls_status[21] = s5;
assign vls_status[20] = fof;
assign vls_status[7 +:8] = xcpt_ecc_code;
assign vls_status[15] = xcpt_ecc_corr;
assign vls_status[16 +:4] = xcpt_ecc_ramid;
assign s6 = xcpt_status[MISALIGN] & ~s10;
assign s7 = xcpt_status[MISALIGN] & s10;
assign s8 = xcpt_status[PMP_VIOLATION];
assign s9 = xcpt_status[PMA_INCONSISTENT];
assign s10 = xcpt_status[PMA_DEVICE];
assign s12 = xcpt_status[PAGE_FAULT];
assign s11 = xcpt_status[PAGE_ACCESS_FAULT];
assign s13 = xcpt_status[HIT_ILM];
assign s14 = xcpt_status[HIT_DLM];
assign s15 = s13 | s14;
assign s4 = s15 ? 3'd6 : s11 ? xcpt_page_dcause : s12 ? 3'd0 : s7 ? 3'd4 : s6 ? 3'd0 : s8 ? 3'd2 : (s9 | s10) ? 3'd6 : 3'd5;
assign s0 = (s15 | s11) ? s3 : s12 ? s2 : s6 ? s1 : s3;
assign s1 = load ? 4'd4 : 4'd6;
assign s2 = load ? 4'd13 : 4'd15;
assign s3 = load ? 4'd5 : 4'd7;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

