// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vdiv_ctrl (
    vpu_vdiv_clk,
    vpu_reset_n,
    e1_ex_valid,
    e1_ex_ready,
    e1_ex_id,
    e1_cmt_valid,
    e1_cmt_ready,
    e1_cmt_kill,
    e1_cmt_id,
    e1_ex_req_valid,
    e1_ex_req_ready,
    e1_ex_resp_valid,
    e1_ex_resp_ready,
    e1_vs_valid,
    e1_vs_ready,
    e1_vs_flush,
    e1_vs_last,
    e1_vd_valid,
    e1_vd_ready
);
parameter VLEN = 512;
parameter DLEN = 512;
parameter DEPTH = 64;
localparam LANE64_CNT = (DLEN / 64) > 0 ? (DLEN / 64) : 1;
localparam DLEN_F8 = DLEN / 8;
localparam VLEN_F8 = VLEN / 8;
localparam VS_NUM = VLEN / DLEN;
localparam BYTE_LMULF8 = VLEN_F8 / 8;
localparam BYTE_LMULF4 = VLEN_F8 / 4;
localparam BYTE_LMULF2 = VLEN_F8 / 2;
localparam IDLE = 0;
localparam WAIT_OP = 1;
localparam WAIT_VDIV = 2;
localparam VDIV_LAST = 3;
localparam STATES = 4;
input vpu_vdiv_clk;
input vpu_reset_n;
input e1_ex_valid;
output e1_ex_ready;
input [DEPTH - 1:0] e1_ex_id;
input e1_vs_valid;
output e1_vs_ready;
input e1_vs_last;
output e1_vs_flush;
input e1_ex_req_ready;
output e1_ex_req_valid;
input e1_ex_resp_valid;
output e1_ex_resp_ready;
output e1_vd_valid;
input e1_vd_ready;
input e1_cmt_valid;
input [DEPTH - 1:0] e1_cmt_id;
output e1_cmt_ready;
input e1_cmt_kill;





// 8a3cbec3 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [STATES - 1:0] s0;
reg [STATES - 1:0] s1;
reg s2;
wire s3 = s0[IDLE];
wire s4 = s0[WAIT_VDIV];
wire s5 = s0[WAIT_OP];
wire s6 = s0[VDIV_LAST];
wire s7;
wire s8;
wire s9;
wire s10;
assign s9 = e1_cmt_valid & e1_ex_valid & (e1_cmt_id == e1_ex_id);
assign s7 = s9 & e1_cmt_kill;
assign s8 = s9 & ~e1_cmt_kill;
assign s10 = (s4 | s6) & ~(e1_ex_resp_valid & e1_vd_ready);
assign e1_ex_ready = s7 & ~s10 | e1_ex_req_valid & e1_vs_last;
assign e1_cmt_ready = s7 & ~s10 | s6 & e1_ex_resp_valid & e1_ex_resp_ready;
assign e1_vs_flush = s7 & s3 | s7 & s5 | s7 & s4;
assign e1_vs_ready = e1_ex_req_valid;
assign e1_ex_req_valid = s3 & e1_vs_valid & e1_ex_valid & ~s7 | s5 & e1_vs_valid & ~s7 | s4 & e1_vs_valid & s8 & e1_ex_resp_valid & e1_ex_resp_ready;
assign e1_ex_resp_ready = e1_vd_ready & e1_cmt_valid;
assign e1_vd_valid = e1_ex_resp_valid & e1_ex_resp_ready & ~e1_cmt_kill;
always @* begin
    s1 = {STATES{1'b0}};
    case (1'b1)
        s0[IDLE]: begin
            if (s7) begin
                s1[IDLE] = 1'b1;
            end
            else if (~e1_vs_valid) begin
                s1[WAIT_OP] = 1'b1;
            end
            else if (~e1_vs_last) begin
                s1[WAIT_VDIV] = 1'b1;
            end
            else begin
                s1[VDIV_LAST] = 1'b1;
            end
            s2 = e1_ex_valid;
        end
        s0[WAIT_OP]: begin
            if (s7) begin
                s1[IDLE] = 1'b1;
            end
            else if (e1_vs_valid & e1_vs_last) begin
                s1[VDIV_LAST] = 1'b1;
            end
            else if (e1_vs_valid & ~e1_vs_last) begin
                s1[WAIT_VDIV] = 1'b1;
            end
            else begin
                s1[WAIT_OP] = 1'b1;
            end
            s2 = e1_vs_valid | s7;
        end
        s0[WAIT_VDIV]: begin
            if (s7) begin
                s1[IDLE] = 1'b1;
            end
            else if (~e1_vs_valid) begin
                s1[WAIT_OP] = 1'b1;
            end
            else if (~e1_vs_last) begin
                s1[WAIT_VDIV] = 1'b1;
            end
            else begin
                s1[VDIV_LAST] = 1'b1;
            end
            s2 = e1_ex_resp_valid & e1_ex_resp_ready;
        end
        s0[VDIV_LAST]: begin
            s1[IDLE] = 1'b1;
            s2 = e1_ex_resp_valid & e1_ex_resp_ready;
        end
        default: begin
            s1 = {STATES{1'b0}};
            s2 = 1'b0;
        end
    endcase
end

always @(posedge vpu_vdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s0 <= {{(STATES - 1){1'b0}},1'b1};
    end
    else if (s2) begin
        s0 <= s1;
    end
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

