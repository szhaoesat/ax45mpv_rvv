// AX45MPV_PREMIUM v30.1.0

module sample_kv_clk_gen (
        	  clk_in,
        	  resetn,
        	  clk_en,
		  clk_out
);

parameter RATIO = 1;

input			clk_in;
input			resetn;
output			clk_en;
output			clk_out;





// 2cb5e87b rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif

wire			s0;

generate
if (RATIO == 1) begin : gen_ratio_1
	assign clk_en = 1'b1;
	assign s0 = clk_in;
end
else  begin : gen_ratio_2
	reg     s1;
	reg	s2;
	always @(posedge clk_in or negedge resetn) begin
		if (!resetn)
			s1 = 1'b0;
		else
			s1 = ~s1;
	end

	always @(posedge clk_in or negedge resetn) begin
		if (!resetn)
			s2 <= 1'b1;
		else
			s2 <= ~s2;
	end
	assign s0 = s1;
	assign clk_en   = s2;
end
endgenerate

`ifdef NDS_FPGA
	BUFGCE	TL_UL_CLK_MUX_INST (
		.I	(s0		),
		.CE	(1'b1			),
		.O	(clk_out		)
	);
`else
	assign clk_out = s0;
`endif

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

