// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_stall_filter (
    clk,
    reset_n,
    valid_pre,
    stall,
    valid
);
input clk;
input reset_n;
input valid_pre;
input stall;
output valid;





// bf6104b0 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg s0;
wire s1;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        s0 <= 1'b0;
    end
    else begin
        s0 <= s1;
    end
end

assign s1 = stall & (s0 | valid);
assign valid = valid_pre & ~s0;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

