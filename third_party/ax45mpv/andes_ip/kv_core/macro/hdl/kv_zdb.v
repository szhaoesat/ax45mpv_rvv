// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_zdb (
    clk,
    reset_n,
    wvalid,
    wdata,
    wready,
    rvalid,
    rdata,
    rready
);
parameter WIDTH = 8;
parameter RAR_SUPPORT = 0;
input clk;
input reset_n;
input wvalid;
input [WIDTH - 1:0] wdata;
output wready;
output rvalid;
output [WIDTH - 1:0] rdata;
input rready;





// 7dc7d050 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg s0;
wire s1;
wire s2;
wire s3;
wire s4;
reg [WIDTH - 1:0] s5;
wire s6 = wvalid & wready;
wire s7 = rvalid & rready;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        s0 <= 1'b0;
    end
    else begin
        s0 <= s1;
    end
end

generate
    if (RAR_SUPPORT == 1) begin:gen_rar_support
        always @(posedge clk or negedge reset_n) begin
            if (!reset_n) begin
                s5 <= {WIDTH{1'b0}};
            end
            else if (s4) begin
                s5 <= wdata;
            end
        end

    end
    else begin:gen_rar_not_support
        always @(posedge clk) begin
            if (s4) begin
                s5 <= wdata;
            end
        end

    end
endgenerate
assign rvalid = wvalid | s0;
assign rdata = s0 ? s5 : wdata;
assign wready = ~s0;
assign s4 = s2;
assign s1 = s2 | (s0 & ~s3);
assign s2 = s6 & ~rready;
assign s3 = s7;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

