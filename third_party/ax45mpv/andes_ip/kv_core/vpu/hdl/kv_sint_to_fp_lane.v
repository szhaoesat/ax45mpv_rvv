// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_sint_to_fp_lane (
    fp_mode,
    sign,
    sew,
    rdata,
    sint_byte,
    sint_nibble,
    wdata
);
input sign;
input [3:0] sew;
input [31:0] rdata;
output [63:0] wdata;
input sint_byte;
input sint_nibble;
input fp_mode;





// c0619c49 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [31:0] s0;
wire [15:0] s1;
wire [31:0] s2;
wire [15:0] s3;
wire [7:0] s4;
wire [7:0] s5;
wire [7:0] s6;
wire [7:0] s7;
assign wdata = ({64{sew[1]}} & {s3,s2[15:0],s1,s0[15:0]}) | ({64{sew[2]}} & {s2,s0});
assign s4 = ({8{sint_nibble & sign}} & {{4{rdata[3]}},rdata[3:0]}) | ({8{sint_nibble & ~sign}} & {4'b0,rdata[3:0]}) | ({8{sint_byte}} & rdata[7:0]);
assign s5 = ({8{sint_nibble & sign}} & {{4{rdata[7]}},rdata[7:4]}) | ({8{sint_nibble & ~sign}} & {4'b0,rdata[7:4]}) | ({8{sint_byte}} & rdata[15:8]);
assign s6 = ({8{sint_nibble & sign & sew[2]}} & {{4{rdata[7]}},rdata[7:4]}) | ({8{sint_nibble & sign & sew[1]}} & {{4{rdata[11]}},rdata[11:8]}) | ({8{sint_nibble & ~sign & sew[2]}} & {4'b0,rdata[7:4]}) | ({8{sint_nibble & ~sign & sew[1]}} & {4'b0,rdata[11:8]}) | ({8{sint_byte & sew[2]}} & rdata[15:8]) | ({8{sint_byte & sew[1]}} & rdata[23:16]);
assign s7 = ({8{sint_nibble & sign}} & {{4{rdata[15]}},rdata[15:12]}) | ({8{sint_nibble & ~sign}} & {4'b0,rdata[15:12]}) | ({8{sint_byte}} & rdata[31:24]);
kv_sint_to_fp #(
    .FLEN(32)
) u_sint_to_fp_dpath0 (
    .fp_mode(fp_mode),
    .sign(sign),
    .sew(sew),
    .rdata(s4),
    .wdata(s0)
);
kv_sint_to_fp #(
    .FLEN(16)
) u_sint_to_fp_dpath1 (
    .fp_mode(fp_mode),
    .sign(sign),
    .sew(sew),
    .rdata(s5),
    .wdata(s1)
);
kv_sint_to_fp #(
    .FLEN(32)
) u_sint_to_fp_dpath2 (
    .fp_mode(fp_mode),
    .sign(sign),
    .sew(sew),
    .rdata(s6),
    .wdata(s2)
);
kv_sint_to_fp #(
    .FLEN(16)
) u_sint_to_fp_dpath3 (
    .fp_mode(fp_mode),
    .sign(sign),
    .sew(sew),
    .rdata(s7),
    .wdata(s3)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

