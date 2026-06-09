// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_sync_l2l (
    resetn,
    clk,
    d,
    q
);
parameter SYNC_STAGE = 2;
parameter RESET_VALUE = 1'b0;
input resetn;
input clk;
input d;
output q;





// 5d7dac0c rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [SYNC_STAGE - 1:0] s0;
assign q = s0[SYNC_STAGE - 1];
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        s0 <= {SYNC_STAGE{RESET_VALUE}};
    end
    else begin
        s0 <= {s0[SYNC_STAGE - 2:0],d};
    end
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

