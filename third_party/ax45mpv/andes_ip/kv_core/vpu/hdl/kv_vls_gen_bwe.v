// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_gen_bwe (
    offset,
    mask_cnt,
    mask_in,
    bwe
);
parameter OFFSET_WIDTH = 6;
parameter MW_CNT = 7;
parameter MW_IN = 64;
parameter MW_OUT = 64;
parameter MASK_READY = 0;
input [OFFSET_WIDTH - 1:0] offset;
input [MW_CNT - 1:0] mask_cnt;
input [MW_IN - 1:0] mask_in;
output [MW_OUT - 1:0] bwe;





// 476c9249 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [MW_IN - 1:0] mask;
wire [MW_OUT - 1:0] mask_zext;
generate
    if (MASK_READY == 1) begin:gen_mask_ready
        assign mask = mask_in;
    end
    else begin:gen_mask_not_ready
        kv_vls_gen_mask #(
            .MW_CNT(MW_CNT),
            .MW(MW_IN)
        ) u_vls_gen_mask (
            .mask_cnt(mask_cnt),
            .mask_out(mask)
        );
    end
endgenerate
assign bwe = mask_zext << offset;
generate
    if (MW_OUT > MW_IN) begin:gen_mask_zext_gt_out
        assign mask_zext = {{MW_OUT - MW_IN{1'b0}},mask[MW_IN - 1:0]};
    end
    else if (MW_OUT == MW_IN) begin:gen_mask_zext_eq_out
        assign mask_zext = mask[MW_IN - 1:0];
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

