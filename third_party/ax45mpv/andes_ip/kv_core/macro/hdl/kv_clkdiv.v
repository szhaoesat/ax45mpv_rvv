// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_clkdiv (
    	  clk_in,
    	  resetn,
    	  clk_en,
    	  clk_out
);

parameter RATIO = 2;

input  clk_in;
input  resetn;
output clk_en;
output clk_out;





// c4974c46 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif

reg  [RATIO-1:0] s0;
wire [RATIO-1:0] s1;
reg  [RATIO-1:0] s2;
wire [RATIO-1:0] s3;

assign s1 = {s0[RATIO-2:0], s0[RATIO-1]};
always @(posedge clk_in or negedge resetn) begin
    if (!resetn) begin
        s0 = {{RATIO-(RATIO/2){1'b1}}, {(RATIO/2){1'b0}}};
    end
    else begin
        s0 = s1;
    end
end

assign s3 = {s2[RATIO-2:0], s2[RATIO-1]};
always @(posedge clk_in or negedge resetn) begin
    if (!resetn) begin
        s2 <= {{(RATIO-1){1'b0}}, 1'b1};
    end
    else begin
        s2 <= s3;
    end
end

assign clk_en = s2[0];

`ifdef NDS_FPGA
    BUFGCE  CLK_MUX_INST (
        .I  (s0[0]               ),
        .CE (1'b1                   ),
        .O  (clk_out                )
    );
`else
    assign clk_out = s0[0];
`endif







`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

