// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vscb_age_next (
    pending,
    age,
    age_next
);
parameter AGEN = 8;
output [AGEN - 1:0] age_next;
input [AGEN - 1:0] age;
input [AGEN - 1:0] pending;





// 56bcf813 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [AGEN - 1:0] s0;
wire [AGEN - 1:0] s1;
wire [AGEN * 2 - 1:0] s2;
wire [AGEN * 2 - 1:0] s3;
assign s0 = ~age + {{(AGEN - 1){1'b0}},1'b1};
assign s1 = s0 & ~age;
assign s2[AGEN - 1:0] = pending & s1;
assign s2[AGEN * 2 - 1:AGEN] = pending;
assign s3[0] = s2[0];
generate
    genvar i;
    for (i = 1; i < AGEN * 2; i = i + 1) begin:gen_pendingx2_age
        assign s3[i] = s2[i] & ~|s2[0 +:i];
    end
endgenerate
assign age_next = s3[AGEN - 1:0] | s3[AGEN * 2 - 1:AGEN];
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

