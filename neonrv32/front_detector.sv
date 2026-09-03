module front_detector (
  input input_signal,
  input clk,
  input rst_n,
  output logic output_signal
);

  logic signal_ff, signal_detect;
  logic [1:0] sync_shift_reg;

  assign signal_detect = ~signal_ff & input_signal;
  assign output_signal = sync_shift_reg[1];

  always_ff @(posedge clk) begin
    if (~rst_n) begin
      signal_ff <= '0;
    end else begin
      signal_ff <= input_signal;
    end
  end


  always_ff @(posedge clk) begin
    if (~rst_n) sync_shift_reg <= '0;
    else sync_shift_reg <= {sync_shift_reg[0], signal_detect};
  end

endmodule