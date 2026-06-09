// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0



module kv_onehot (
        	  out,
        	  in
);


parameter W = 8;

output	        out;
input	[W-1:0] in;





// 73e4521e rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire    [W-1:0] s0;

generate
genvar i;
for (i=0; i<W; i=i+1) begin : gen_tmp
	wire  [W-1:0] s1 = {{(W-1){1'b0}}, 1'b1} << i;
	assign s0[i] = in == s1;
end
endgenerate

assign out = |s0;

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule
