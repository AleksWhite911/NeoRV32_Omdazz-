module top_wrapper (
  input clk_i,
  input rstn_i,
  output [4:0] gpio_o,
  input uart0_rxd_i,
  output uart0_txd_o,
  inout sda_io,
  inout scl_io,
  inout sda_temp_io,
  inout scl_temp_io,

  input jtag_tck_i,
  input jtag_tdi_i,
  output jtag_tdo_o,
  input jtag_tms_i

);

  wire cpu_clk;
  wire sda_in;
  wire sda_temp_in;
  wire scl_temp_in;
  wire scl_in;
  wire twi_sda_o;
  wire twi_scl_o;


  
  

// sda_io    <= '0' when (twi_sda_o = '0') else 'Z'; -- drive
// scl_io    <= '0' when (twi_scl_o = '0') else 'Z'; -- drive
// twi_sda_i <= std_ulogic(sda_io); -- sense
// twi_scl_i <= std_ulogic(scl_io); -- sense
assign sda_temp_io = twi_sda_o ? 1'bz : 1'b0;
assign scl_temp_io = twi_scl_o ? 1'bz : 1'b0;

assign sda_io = twi_sda_o ? 1'bz : 1'b0;
assign scl_io = twi_scl_o ? 1'bz : 1'b0;
assign sda_in = sda_io & sda_temp_io;
assign scl_in = scl_io & scl_temp_io;



tang_nano_9k RISC_V_Core (
  .clk_i(clk_i),
  .rstn_i(rstn_i),
  .uart0_txd_o(uart0_txd_o),
  .uart0_rxd_i(uart0_rxd_i),
  .gpio_o(gpio_o),
  .jtag_tdi_i(jtag_tdi_i), //input jtag_TDI
  .jtag_tdo_o(jtag_tdo_o), //output jtag_TDO
  .jtag_tck_i(jtag_tck_i), //input jtag_TCK
  .jtag_tms_i(jtag_tms_i), //input jtag_TMS
  .twi_sda_i(sda_in),
  .twi_sda_o(twi_sda_o),
  .twi_scl_i(scl_in),
  .twi_scl_o(twi_scl_o)
);

pll pll_cpu (
  .c0(cpu_clk),  //100MHz
  .inclk0(clk_i)
);


endmodule