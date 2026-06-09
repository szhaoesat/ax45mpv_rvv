// SPDX-License-Identifier: Apache-2.0
// Pipeline register for 512-bit VRF read data paths
// Inserts 1 cycle of latency with full valid/ready/last handshake.
// Uses a 2-entry skid buffer to preserve throughput.

module kv_vrf_read_pipe #(
    parameter DW = 512,
    parameter AW = 40,
    parameter FW = 4
) (
    input  logic         clk,
    input  logic         resetn,
    // Upstream (from VRF)
    input  logic         i_valid,
    output logic         i_ready,
    input  logic [DW-1:0] i_data,
    input  logic         i_last,
    input  logic [AW-1:0] i_addr,
    input  logic [4:0]   i_beat,
    input  logic [FW-1:0] i_fu,
    input  logic [1:0]   i_bypass_sel,
    input  logic         i_bypass_en,
    // Downstream (to FU)
    output logic         o_valid,
    input  logic         o_ready,
    output logic [DW-1:0] o_data,
    output logic         o_last,
    output logic [AW-1:0] o_addr,
    output logic [4:0]   o_beat,
    output logic [FW-1:0] o_fu,
    output logic [1:0]   o_bypass_sel,
    output logic         o_bypass_en
);

  // 2-entry skid buffer
  logic        buf_valid;
  logic        buf_last;
  logic [DW-1:0] buf_data;
  logic [AW-1:0] buf_addr;
  logic [4:0]  buf_beat;
  logic [FW-1:0] buf_fu;
  logic [1:0]  buf_bypass_sel;
  logic        buf_bypass_en;

  logic        pipe_valid;
  logic        pipe_last;
  logic [DW-1:0] pipe_data;
  logic [AW-1:0] pipe_addr;
  logic [4:0]  pipe_beat;
  logic [FW-1:0] pipe_fu;
  logic [1:0]  pipe_bypass_sel;
  logic        pipe_bypass_en;

  // i_ready: accept input when pipeline slot available or buffer empty
  assign i_ready = !pipe_valid || (o_ready && !buf_valid);

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      pipe_valid <= 1'b0;
      buf_valid  <= 1'b0;
    end else begin
      // Pipeline advance
      if (o_ready || !pipe_valid) begin
        if (buf_valid) begin
          // Drain buffer
          pipe_valid <= 1'b1;
          pipe_data  <= buf_data;
          pipe_last  <= buf_last;
          pipe_addr  <= buf_addr;
          pipe_beat  <= buf_beat;
          pipe_fu    <= buf_fu;
          pipe_bypass_sel <= buf_bypass_sel;
          pipe_bypass_en  <= buf_bypass_en;
          buf_valid  <= i_valid && i_ready;
          if (i_valid && i_ready) begin
            buf_data  <= i_data;
            buf_last  <= i_last;
            buf_addr  <= i_addr;
            buf_beat  <= i_beat;
            buf_fu    <= i_fu;
            buf_bypass_sel <= i_bypass_sel;
            buf_bypass_en  <= i_bypass_en;
          end
        end else begin
          // Load from input
          pipe_valid <= i_valid;
          pipe_data  <= i_data;
          pipe_last  <= i_last;
          pipe_addr  <= i_addr;
          pipe_beat  <= i_beat;
          pipe_fu    <= i_fu;
          pipe_bypass_sel <= i_bypass_sel;
          pipe_bypass_en  <= i_bypass_en;
        end
      end else if (i_valid && i_ready) begin
        // Pipeline stalled, store in buffer
        buf_valid  <= 1'b1;
        buf_data   <= i_data;
        buf_last   <= i_last;
        buf_addr   <= i_addr;
        buf_beat   <= i_beat;
        buf_fu     <= i_fu;
        buf_bypass_sel <= i_bypass_sel;
        buf_bypass_en  <= i_bypass_en;
      end
    end
  end

  assign o_valid      = pipe_valid;
  assign o_data       = pipe_data;
  assign o_last       = pipe_last;
  assign o_addr       = pipe_addr;
  assign o_beat       = pipe_beat;
  assign o_fu         = pipe_fu;
  assign o_bypass_sel = pipe_bypass_sel;
  assign o_bypass_en  = pipe_bypass_en;

endmodule
