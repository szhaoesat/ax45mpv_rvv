// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_gen_buf_info_hvm (
    uop_start_buf_num,
    uop_ustride_cnt_hvm0,
    uop_ustride_cnt_hvm1,
    buf_info_ustride_value_hvm
);
parameter BUF_DEPTH = 8;
parameter BUF_DEPTH_LOG2 = 3;
parameter BUF_INFO_DW = 8;
input [BUF_DEPTH_LOG2 - 1:0] uop_start_buf_num;
input [BUF_INFO_DW - 1:0] uop_ustride_cnt_hvm0;
input [BUF_INFO_DW - 1:0] uop_ustride_cnt_hvm1;
output [BUF_DEPTH * BUF_INFO_DW - 1:0] buf_info_ustride_value_hvm;





// efc188f8 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [BUF_DEPTH * BUF_INFO_DW - 1:0] buf_info_ustride_value_hvm;
generate
    if (BUF_DEPTH == 8) begin:gen_ustride_buf8_info_hvm
        always @* begin
            buf_info_ustride_value_hvm = {BUF_DEPTH * BUF_INFO_DW{1'b0}};
            case (uop_start_buf_num)
                3'd0: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 0 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 1 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                3'd1: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 1 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 2 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                3'd2: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 2 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 3 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                3'd3: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 3 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 4 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                3'd4: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 4 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 5 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                3'd5: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 5 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 6 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                3'd6: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 6 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 7 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                3'd7: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 7 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 0 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                default: begin
                    buf_info_ustride_value_hvm = {BUF_INFO_DW * BUF_DEPTH{1'b0}};
                end
            endcase
        end

    end
    else if (BUF_DEPTH == 16) begin:gen_ustride_buf16_info_hvm
        always @* begin
            buf_info_ustride_value_hvm = {BUF_DEPTH * BUF_INFO_DW{1'b0}};
            case (uop_start_buf_num)
                4'd0: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 0 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 1 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                4'd1: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 1 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 2 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                4'd2: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 2 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 3 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                4'd3: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 3 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 4 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                4'd4: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 4 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 5 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                4'd5: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 5 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 6 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                4'd6: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 6 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 7 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                4'd7: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 7 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 8 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                4'd8: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 8 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 9 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                4'd9: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 9 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 10 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                4'd10: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 10 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 11 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                4'd11: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 11 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 12 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                4'd12: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 12 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 13 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                4'd13: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 13 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 14 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                4'd14: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 14 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 15 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                4'd15: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 15 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 0 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                default: begin
                    buf_info_ustride_value_hvm = {BUF_INFO_DW * BUF_DEPTH{1'b0}};
                end
            endcase
        end

    end
    else if (BUF_DEPTH == 32) begin:gen_ustride_buf32_info_hvm
        always @* begin
            buf_info_ustride_value_hvm = {BUF_DEPTH * BUF_INFO_DW{1'b0}};
            case (uop_start_buf_num)
                5'd0: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 0 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 1 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd1: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 1 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 2 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd2: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 2 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 3 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd3: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 3 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 4 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd4: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 4 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 5 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd5: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 5 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 6 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd6: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 6 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 7 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd7: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 7 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 8 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd8: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 8 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 9 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd9: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 9 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 10 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd10: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 10 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 11 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd11: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 11 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 12 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd12: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 12 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 13 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd13: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 13 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 14 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd14: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 14 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 15 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd15: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 15 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 16 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd16: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 16 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 17 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd17: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 17 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 18 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd18: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 18 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 19 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd19: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 19 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 20 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd20: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 20 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 21 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd21: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 21 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 22 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd22: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 22 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 23 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd23: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 23 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 24 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd24: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 24 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 25 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd25: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 25 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 26 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd26: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 26 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 27 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd27: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 27 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 28 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd28: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 28 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 29 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd29: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 29 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 30 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd30: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 30 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 31 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                5'd31: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 31 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 0 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                default: begin
                    buf_info_ustride_value_hvm = {BUF_INFO_DW * BUF_DEPTH{1'b0}};
                end
            endcase
        end

    end
    else if (BUF_DEPTH == 64) begin:gen_ustride_buf64_info_hvm
        always @* begin
            buf_info_ustride_value_hvm = {BUF_DEPTH * BUF_INFO_DW{1'b0}};
            case (uop_start_buf_num)
                6'd0: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 0 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 1 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd1: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 1 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 2 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd2: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 2 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 3 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd3: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 3 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 4 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd4: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 4 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 5 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd5: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 5 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 6 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd6: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 6 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 7 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd7: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 7 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 8 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd8: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 8 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 9 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd9: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 9 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 10 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd10: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 10 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 11 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd11: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 11 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 12 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd12: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 12 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 13 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd13: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 13 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 14 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd14: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 14 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 15 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd15: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 15 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 16 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd16: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 16 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 17 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd17: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 17 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 18 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd18: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 18 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 19 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd19: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 19 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 20 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd20: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 20 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 21 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd21: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 21 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 22 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd22: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 22 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 23 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd23: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 23 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 24 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd24: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 24 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 25 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd25: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 25 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 26 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd26: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 26 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 27 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd27: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 27 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 28 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd28: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 28 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 29 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd29: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 29 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 30 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd30: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 30 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 31 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd31: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 31 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 32 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd32: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 32 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 33 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd33: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 33 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 34 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd34: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 34 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 35 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd35: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 35 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 36 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd36: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 36 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 37 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd37: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 37 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 38 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd38: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 38 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 39 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd39: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 39 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 40 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd40: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 40 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 41 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd41: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 41 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 42 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd42: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 42 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 43 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd43: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 43 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 44 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd44: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 44 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 45 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd45: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 45 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 46 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd46: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 46 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 47 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd47: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 47 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 48 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd48: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 48 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 49 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd49: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 49 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 50 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd50: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 50 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 51 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd51: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 51 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 52 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd52: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 52 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 53 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd53: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 53 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 54 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd54: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 54 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 55 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd55: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 55 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 56 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd56: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 56 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 57 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd57: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 57 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 58 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd58: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 58 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 59 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd59: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 59 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 60 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd60: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 60 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 61 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd61: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 61 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 62 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd62: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 62 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 63 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                6'd63: begin
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 63 +:BUF_INFO_DW] = uop_ustride_cnt_hvm0;
                    buf_info_ustride_value_hvm[BUF_INFO_DW * 0 +:BUF_INFO_DW] = uop_ustride_cnt_hvm1;
                end
                default: begin
                    buf_info_ustride_value_hvm = {BUF_INFO_DW * BUF_DEPTH{1'b0}};
                end
            endcase
        end

    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

