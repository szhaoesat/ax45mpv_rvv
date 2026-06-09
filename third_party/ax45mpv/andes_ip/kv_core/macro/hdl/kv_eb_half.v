// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_eb_half (
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





// 647f429d rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg rvalid;
wire s0;
reg [WIDTH - 1:0] rdata;
wire s1 = wvalid & wready;
wire s2 = rvalid & rready;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        rvalid <= 1'b0;
    end
    else begin
        rvalid <= s0;
    end
end

generate
    if (RAR_SUPPORT == 1) begin:gen_rar_support
        always @(posedge clk or negedge reset_n) begin
            if (!reset_n) begin
                rdata <= {WIDTH{1'b0}};
            end
            else if (s1) begin
                rdata <= wdata;
            end
        end

    end
    else begin:gen_rar_not_support
        always @(posedge clk) begin
            if (s1) begin
                rdata <= wdata;
            end
        end

    end
endgenerate
assign s0 = s1 | (rvalid & ~s2);
assign wready = ~rvalid;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

