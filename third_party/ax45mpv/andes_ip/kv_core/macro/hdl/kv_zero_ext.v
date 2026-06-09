// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_zero_ext #(
    parameter OW = 8,
    parameter IW = 8)  (
    out,
    in
);
output [OW - 1:0] out;
input [IW - 1:0] in;





// 6d93f230 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


assign out[IW - 1:0] = in[IW - 1:0];
generate
    if (OW > IW) begin:gen_msbs
        assign out[OW - 1:IW] = {(OW - IW){1'b0}};
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

