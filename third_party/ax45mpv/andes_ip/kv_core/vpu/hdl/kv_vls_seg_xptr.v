// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_seg_xptr (
    nf_add1,
    emul_len,
    start_ptr,
    seg_ptr,
    xptr0,
    xptr1,
    xptr2,
    xptr3,
    xptr4,
    xptr5,
    xptr6,
    xptr7
);
parameter VLEN = 512;
parameter DLEN = 512;
parameter BUF_DEPTH = 8;
parameter XPTR_READY = 0;
input [3:0] nf_add1;
input [3:0] emul_len;
input [BUF_DEPTH - 1:0] start_ptr;
output [BUF_DEPTH - 1:0] seg_ptr;
output [BUF_DEPTH - 1:0] xptr0;
output [BUF_DEPTH - 1:0] xptr1;
output [BUF_DEPTH - 1:0] xptr2;
output [BUF_DEPTH - 1:0] xptr3;
output [BUF_DEPTH - 1:0] xptr4;
output [BUF_DEPTH - 1:0] xptr5;
output [BUF_DEPTH - 1:0] xptr6;
output [BUF_DEPTH - 1:0] xptr7;





// 7a1e28f2 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0;
wire s1;
wire s2;
wire s3;
wire s4;
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
wire s16;
wire s17;
wire [BUF_DEPTH + 0:0] s18;
wire [BUF_DEPTH - 1:0] s19;
wire [BUF_DEPTH + 1:0] s20;
wire [BUF_DEPTH - 1:0] s21;
wire [BUF_DEPTH + 2:0] s22;
wire [BUF_DEPTH - 1:0] s23;
wire [BUF_DEPTH + 3:0] s24;
wire [BUF_DEPTH - 1:0] s25;
wire [BUF_DEPTH + 4:0] s26;
wire [BUF_DEPTH - 1:0] s27;
wire [BUF_DEPTH + 5:0] s28;
wire [BUF_DEPTH - 1:0] s29;
wire [BUF_DEPTH + 6:0] s30;
wire [BUF_DEPTH - 1:0] s31;
assign s11 = (nf_add1 == 4'd2);
assign s12 = (nf_add1 == 4'd3);
assign s13 = (nf_add1 == 4'd4);
assign s14 = (nf_add1 == 4'd5);
assign s15 = (nf_add1 == 4'd6);
assign s16 = (nf_add1 == 4'd7);
assign s17 = (nf_add1 == 4'd8);
assign s0 = s11 | s12 | s13 | s14 | s15 | s16 | s17;
assign s1 = s12 | s13 | s14 | s15 | s16 | s17;
assign s2 = s13 | s14 | s15 | s16 | s17;
assign s3 = s14 | s15 | s16 | s17;
assign s4 = s15 | s16 | s17;
assign s5 = s16 | s17;
assign s6 = s17;
assign seg_ptr = xptr0 | xptr1 | xptr2 | xptr3 | xptr4 | xptr5 | xptr6 | xptr7;
generate
    if (VLEN == DLEN) begin:gen_seg_xptr_1_1
        assign s18 = {start_ptr,1'b0};
        assign s19 = s18[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 1{1'b0}},s18[BUF_DEPTH + 0:BUF_DEPTH]};
        assign s20 = {start_ptr,2'b0};
        assign s21 = s20[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 2{1'b0}},s20[BUF_DEPTH + 1:BUF_DEPTH]};
        assign s22 = {start_ptr,3'b0};
        assign s23 = s22[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 3{1'b0}},s22[BUF_DEPTH + 2:BUF_DEPTH]};
        assign s24 = {start_ptr,4'b0};
        assign s25 = s24[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 4{1'b0}},s24[BUF_DEPTH + 3:BUF_DEPTH]};
        assign s26 = {start_ptr,5'b0};
        assign s27 = s26[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 5{1'b0}},s26[BUF_DEPTH + 4:BUF_DEPTH]};
        assign s28 = {start_ptr,6'b0};
        assign s29 = s28[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 6{1'b0}},s28[BUF_DEPTH + 5:BUF_DEPTH]};
        assign s30 = {start_ptr,7'b0};
        assign s31 = s30[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 7{1'b0}},s30[BUF_DEPTH + 6:BUF_DEPTH]};
        assign s7 = (emul_len == 4'd0);
        assign s8 = (emul_len == 4'd1);
        assign s9 = (emul_len == 4'd2);
        assign s10 = (emul_len == 4'd3);
        assign xptr0 = start_ptr;
        assign xptr1 = ({BUF_DEPTH{s0 & s7}} & s19) | ({BUF_DEPTH{s0 & s8}} & s21) | ({BUF_DEPTH{s0 & s9}} & s23) | ({BUF_DEPTH{s0 & s10}} & s25);
        assign xptr2 = ({BUF_DEPTH{s1 & s7}} & s21) | ({BUF_DEPTH{s1 & s8}} & s25);
        assign xptr3 = ({BUF_DEPTH{s2 & s7}} & s23) | ({BUF_DEPTH{s2 & s8}} & s29);
        assign xptr4 = ({BUF_DEPTH{s3 & s7}} & s25);
        assign xptr5 = ({BUF_DEPTH{s4 & s7}} & s27);
        assign xptr6 = ({BUF_DEPTH{s5 & s7}} & s29);
        assign xptr7 = ({BUF_DEPTH{s6 & s7}} & s31);
    end
    else begin:gen_seg_xptr_2_1
        wire s32;
        wire s33;
        wire s34;
        wire s35;
        wire [BUF_DEPTH + 7:0] s36;
        wire [BUF_DEPTH - 1:0] s37;
        wire [BUF_DEPTH + 8:0] s38;
        wire [BUF_DEPTH - 1:0] s39;
        wire [BUF_DEPTH + 9:0] s40;
        wire [BUF_DEPTH - 1:0] s41;
        wire [BUF_DEPTH + 10:0] s42;
        wire [BUF_DEPTH - 1:0] s43;
        wire [BUF_DEPTH + 11:0] s44;
        wire [BUF_DEPTH - 1:0] s45;
        wire [BUF_DEPTH + 12:0] s46;
        wire [BUF_DEPTH - 1:0] s47;
        wire [BUF_DEPTH + 13:0] s48;
        wire [BUF_DEPTH - 1:0] s49;
        assign s18 = {start_ptr,1'b0};
        assign s19 = s18[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 1{1'b0}},s18[BUF_DEPTH + 0:BUF_DEPTH]};
        assign s20 = {start_ptr,2'b0};
        assign s21 = s20[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 2{1'b0}},s20[BUF_DEPTH + 1:BUF_DEPTH]};
        assign s22 = {start_ptr,3'b0};
        assign s23 = s22[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 3{1'b0}},s22[BUF_DEPTH + 2:BUF_DEPTH]};
        assign s24 = {start_ptr,4'b0};
        assign s25 = s24[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 4{1'b0}},s24[BUF_DEPTH + 3:BUF_DEPTH]};
        assign s26 = {start_ptr,5'b0};
        assign s27 = s26[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 5{1'b0}},s26[BUF_DEPTH + 4:BUF_DEPTH]};
        assign s28 = {start_ptr,6'b0};
        assign s29 = s28[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 6{1'b0}},s28[BUF_DEPTH + 5:BUF_DEPTH]};
        assign s30 = {start_ptr,7'b0};
        assign s31 = s30[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 7{1'b0}},s30[BUF_DEPTH + 6:BUF_DEPTH]};
        assign s36 = {start_ptr,8'b0};
        assign s37 = s36[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 8{1'b0}},s36[BUF_DEPTH + 7:BUF_DEPTH]};
        assign s38 = {start_ptr,9'b0};
        assign s39 = s38[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 9{1'b0}},s38[BUF_DEPTH + 8:BUF_DEPTH]};
        assign s40 = {start_ptr,10'b0};
        assign s41 = s40[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 10{1'b0}},s40[BUF_DEPTH + 9:BUF_DEPTH]};
        assign s42 = {start_ptr,11'b0};
        assign s43 = s42[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 11{1'b0}},s42[BUF_DEPTH + 10:BUF_DEPTH]};
        assign s44 = {start_ptr,12'b0};
        assign s45 = s44[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 12{1'b0}},s44[BUF_DEPTH + 11:BUF_DEPTH]};
        assign s46 = {start_ptr,13'b0};
        assign s47 = s46[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 13{1'b0}},s46[BUF_DEPTH + 12:BUF_DEPTH]};
        assign s48 = {start_ptr,14'b0};
        assign s49 = s48[BUF_DEPTH - 1:0] | {{BUF_DEPTH - 14{1'b0}},s48[BUF_DEPTH + 13:BUF_DEPTH]};
        wire [BUF_DEPTH - 1:0] nds_unused_buf_sl_wrap_11 = s43;
        wire [BUF_DEPTH - 1:0] nds_unused_buf_sl_wrap_13 = s47;
        assign s7 = (emul_len == 4'd0);
        assign s8 = (emul_len == 4'd1);
        assign s9 = (emul_len == 4'd2);
        assign s10 = (emul_len == 4'd3);
        assign s32 = (emul_len == 4'd4);
        assign s33 = (emul_len == 4'd5);
        assign s34 = (emul_len == 4'd6);
        assign s35 = (emul_len == 4'd7);
        assign xptr0 = start_ptr;
        assign xptr1 = ({BUF_DEPTH{s0 & s7}} & s19) | ({BUF_DEPTH{s0 & s8}} & s21) | ({BUF_DEPTH{s0 & s9}} & s23) | ({BUF_DEPTH{s0 & s10}} & s25) | ({BUF_DEPTH{s0 & s32}} & s27) | ({BUF_DEPTH{s0 & s33}} & s29) | ({BUF_DEPTH{s0 & s34}} & s31) | ({BUF_DEPTH{s0 & s35}} & s37);
        assign xptr2 = ({BUF_DEPTH{s1 & s7}} & s21) | ({BUF_DEPTH{s1 & s8}} & s25) | ({BUF_DEPTH{s1 & s9}} & s29) | ({BUF_DEPTH{s1 & s10}} & s37);
        assign xptr3 = ({BUF_DEPTH{s2 & s7}} & s23) | ({BUF_DEPTH{s2 & s8}} & s29) | ({BUF_DEPTH{s2 & s9}} & s39) | ({BUF_DEPTH{s2 & s10}} & s45);
        assign xptr4 = ({BUF_DEPTH{s3 & s7}} & s25) | ({BUF_DEPTH{s3 & s8}} & s37);
        assign xptr5 = ({BUF_DEPTH{s4 & s7}} & s27) | ({BUF_DEPTH{s4 & s8}} & s41);
        assign xptr6 = ({BUF_DEPTH{s5 & s7}} & s29) | ({BUF_DEPTH{s5 & s8}} & s45);
        assign xptr7 = ({BUF_DEPTH{s6 & s7}} & s31) | ({BUF_DEPTH{s6 & s8}} & s49);
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

