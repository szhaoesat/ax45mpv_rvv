// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_sint_to_fp (
    fp_mode,
    sign,
    sew,
    rdata,
    wdata
);
parameter FLEN = 32;
localparam EXP_WIDTH = (FLEN == 64) ? 11 : 8;
localparam SIG_WIDTH = (FLEN == 64) ? 53 : (FLEN == 32) ? 24 : 11;
localparam INT_WIDTH = 8;
localparam HP = 4'b0010;
localparam SP = 4'b0100;
localparam DP = 4'b1000;
input fp_mode;
input sign;
input [3:0] sew;
input [7:0] rdata;
output [(FLEN - 1):0] wdata;





// db55c795 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0 = (sew == HP) & ~fp_mode;
wire s1 = (sew == HP) & fp_mode;
wire s2 = (sew == SP) && (FLEN >= 32);
wire s3 = (sew == DP) && (FLEN >= 64);
wire [(INT_WIDTH - 1):0] s4;
wire nds_unused_f1_data_2sc_co;
wire s5;
wire [2:0] s6;
wire [2:0] s7;
wire [(EXP_WIDTH - 4):0] s8;
wire [(EXP_WIDTH - 1):0] s9;
wire s10;
wire [(INT_WIDTH - 1):0] s11;
wire s12;
wire [(INT_WIDTH - 1):0] s13;
wire [(INT_WIDTH - 1):0] s14;
wire [(INT_WIDTH - 1):0] s15;
wire [(INT_WIDTH - 1):0] s16;
assign s10 = (rdata != {INT_WIDTH{1'b0}});
assign {nds_unused_f1_data_2sc_co,s4} = (rdata ^ {INT_WIDTH{s12}}) + {{(INT_WIDTH - 1){1'b0}},s12};
assign s5 = (s4[(INT_WIDTH - 1):1] != {(INT_WIDTH - 1){1'b0}});
kv_lzc_encode #(
    .WIDTH(INT_WIDTH)
) lzc_encode (
    .lza_str(s4),
    .lzc(s6)
);
assign s13 = s4;
assign s14 = s6[2] ? {s13[((INT_WIDTH - 1) - 4):0],{4{1'b0}}} : s13;
assign s15 = s6[1] ? {s14[((INT_WIDTH - 1) - 2):0],{2{1'b0}}} : s14;
assign s16 = s6[0] ? {s15[((INT_WIDTH - 1) - 1):0],{1{1'b0}}} : s15;
assign s7 = s5 ? ~(s6 + 3'd1) : s6;
assign s12 = sign & rdata[(INT_WIDTH - 1)];
assign s11 = s16;
assign s9 = {s8,s7} & {EXP_WIDTH{s10}};
generate
    if (FLEN == 64) begin:gen_dp
        assign s8 = ({EXP_WIDTH - 3{s3}} & {({8{s5}} ^ 8'h7f)}) | ({EXP_WIDTH - 3{s2}} & {3'd0,({5{s5}} ^ 5'h0f)}) | ({EXP_WIDTH - 3{s1}} & {3'd0,({5{s5}} ^ 5'h0f)}) | ({EXP_WIDTH - 3{s0}} & {6'd0,({2{s5}} ^ 2'h1)});
        assign wdata = ({64{s3}} & {s12,s9,s11[(INT_WIDTH - 2):0],{(52 - 7){1'b0}}}) | ({64{s2}} & {{32{1'b1}},s12,s9[7:0],s11[(INT_WIDTH - 2):0],{(23 - 7){1'b0}}}) | ({64{s0}} & {{48{1'b1}},s12,s9[4:0],s11[(INT_WIDTH - 2):0],{(10 - 7){1'b0}}}) | ({64{s1}} & {{48{1'b1}},s12,s9[7:0],s11[(INT_WIDTH - 2):0]});
    end
    else if (FLEN == 32) begin:gen_sp
        assign s8 = ({EXP_WIDTH - 3{s2}} & {({5{s5}} ^ 5'h0f)}) | ({EXP_WIDTH - 3{s1}} & {({5{s5}} ^ 5'h0f)}) | ({EXP_WIDTH - 3{s0}} & {3'd0,({2{s5}} ^ 2'h1)});
        assign wdata = ({32{s2}} & {s12,s9[7:0],s11[(INT_WIDTH - 2):0],{(23 - 7){1'b0}}}) | ({32{s0}} & {{16{1'b1}},s12,s9[4:0],s11[(INT_WIDTH - 2):0],{(10 - 7){1'b0}}}) | ({32{s1}} & {{16{1'b1}},s12,s9[7:0],s11[(INT_WIDTH - 2):0]});
        wire nds_unused_wire_sp = s3;
    end
    else begin:gen_hp
        assign s8 = ({EXP_WIDTH - 3{s1}} & {({5{s5}} ^ 5'h0f)}) | ({EXP_WIDTH - 3{s0}} & {3'd0,({2{s5}} ^ 2'h1)});
        assign wdata = ({16{s0}} & {s12,s9[4:0],s11[(INT_WIDTH - 2):0],{(10 - 7){1'b0}}}) | ({16{s1}} & {s12,s9[7:0],s11[(INT_WIDTH - 2):0]});
        wire nds_unused_wire_hp = s3 | s2;
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

