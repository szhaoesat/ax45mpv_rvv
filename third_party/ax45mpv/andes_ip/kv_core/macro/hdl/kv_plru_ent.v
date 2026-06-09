// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_plru_ent (
    clk,
    reset_n,
    p_en,
    c0_en,
    c1_en,
    p_sel,
    c0_sel,
    c1_sel,
    rvalue,
    wvalue,
    wen
);
input clk;
input reset_n;
output p_en;
input c0_en;
input c1_en;
input p_sel;
output c0_sel;
output c1_sel;
input rvalue;
output wvalue;
output wen;





// fc56ed71 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


assign c0_sel = p_sel & ~rvalue;
assign c1_sel = p_sel & rvalue;
assign p_en = c0_en | c1_en;
assign wen = p_en;
assign wvalue = c0_en;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

