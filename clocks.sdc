create_clock -name clk_i -period 20 -waveform {0 10} [get_ports {clk_i}]
create_clock -name jtag_tck_i -period 10000 -waveform {0 5000} [get_ports {jtag_tck_i}]