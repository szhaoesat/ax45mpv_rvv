// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_v0t_dlen (
    v0t_byte,
    element_byte,
    v0t_byte_mask
);
parameter DLEN = 512;
parameter DMLEN = 512 / 8;
parameter ELE_DLEN_WIDTH = $clog2(DLEN / 8);
parameter SHIFT = 0;
input [DMLEN - 1:0] v0t_byte;
input [ELE_DLEN_WIDTH - 1:0] element_byte;
output [DMLEN - 1:0] v0t_byte_mask;





// 88a53224 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [DMLEN - 1:0] shift_init;
wire [ELE_DLEN_WIDTH - 1:0] shift_value;
wire [DMLEN - 1:0] shift_result;
assign shift_init = {DMLEN{1'b1}};
assign v0t_byte_mask = shift_result & v0t_byte;
generate
    if (SHIFT == 0) begin:gen_first_v0t
        assign shift_value = element_byte;
        assign shift_result = shift_init << {{DMLEN - ELE_DLEN_WIDTH{1'b0}},shift_value};
    end
    else if (SHIFT == 1) begin:gen_last_v0t
        wire nds_unused_uf1;
        wire [6:0] max_num_dlen;
        assign max_num_dlen = (DLEN == 64) ? 7'd7 : (DLEN == 128) ? 7'd15 : (DLEN == 256) ? 7'd31 : (DLEN == 512) ? 7'd63 : 7'd127;
        assign {nds_unused_uf1,shift_value} = max_num_dlen[ELE_DLEN_WIDTH - 1:0] - element_byte;
        assign shift_result = shift_init >> {{DMLEN - ELE_DLEN_WIDTH{1'b0}},shift_value};
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

