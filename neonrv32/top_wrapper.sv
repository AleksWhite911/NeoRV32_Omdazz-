module top_wrapper (
  input clk_i,
  input rstn_i,
  output [7:0] gpio_o,
  input uart0_rxd_i,
  output uart0_txd_o,
  inout sda_io,
  inout scl_io,
  inout sda_temp_io,
  inout scl_temp_io,

  //JTAG//
  input jtag_tck_i,
  input jtag_tdi_i,
  output jtag_tdo_o,
  input jtag_tms_i,

  //SPI//
  output spi_clk_o,
  output spi_dat_o,
  input spi_dat_i,
  output spi_csn_o

);

  wire cpu_clk;
  wire sda_in;
  wire sda_temp_in;
  wire scl_temp_in;
  wire scl_in;
  wire twi_sda_o;
  wire twi_scl_o;

  wire [31:0] xbus_adr_o;
  wire [31:0] xbus_dat_o;
  wire [2:0] xbus_cti_o;
  wire [2:0] xbus_tag_o;
  wire xbus_we_o;
  wire [3:0] xbus_sel_o;
  wire xbus_stb_o;
  wire xbus_cyc_o;
  wire [31:0] xbus_dat_i;
  wire xbus_ack_i;
  wire xbus_err_i;

  wire [7:0] spi_csn_o_wire;

  assign spi_csn_o = spi_csn_o_wire[0];


  //AXI4_Nets
  wire [31:0] m_axi_awaddr;
  wire [7:0]  m_axi_awlen;
  wire [2:0]  m_axi_awsize;
  wire [1:0]  m_axi_awburst;
  wire [3:0]  m_axi_awcache;
  wire [2:0]  m_axi_awprot;
  wire        m_axi_awvalid;
  wire        m_axi_awready;

  wire [31:0] m_axi_wdata;
  wire [3:0]  m_axi_wstrb;
  wire        m_axi_wlast;
  wire        m_axi_wvalid;
  wire        m_axi_wready;

  wire [31:0] m_axi_araddr;
  wire [7:0]  m_axi_arlen;
  wire [2:0]  m_axi_arsize;
  wire [1:0]  m_axi_arburst;
  wire [3:0]  m_axi_arcache;
  wire [2:0]  m_axi_arprot;
  wire  m_axi_arvalid;
  wire  m_axi_arready;

  wire [31:0] m_axi_rdata;
  wire [1:0]  m_axi_rresp;
  wire        m_axi_rlast;
  wire        m_axi_rvalid;
  wire        m_axi_rready;

  wire [1:0]  m_axi_bresp;
  wire  m_axi_bvalid;
  wire  m_axi_bready;

  
  

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
  .twi_scl_o(twi_scl_o),

  .spi_clk_o(spi_clk_o),
  .spi_dat_o(spi_dat_o),
  .spi_dat_i(spi_dat_i),
  .spi_csn_o(spi_csn_o_wire),

  .xbus_adr_o(xbus_adr_o),
  .xbus_dat_o(xbus_dat_o),
  .xbus_cti_o(xbus_cti_o),
  .xbus_tag_o(xbus_tag_o),
  .xbus_we_o(xbus_we_o),
  .xbus_sel_o(xbus_sel_o),
  .xbus_stb_o(xbus_stb_o),
  .xbus_cyc_o(xbus_cyc_o),
  .xbus_dat_i(xbus_dat_i),
  .xbus_ack_i(xbus_ack_i),
  .xbus_err_i(xbus_err_i)
);

pll pll_cpu (
  .c0(cpu_clk),  //100MHz
  .inclk0(clk_i)
);


xbus2axi4_bridge AXI_M (
  .clk(clk_i),
  .resetn(rstn_i),
  .xbus_adr_i(xbus_adr_o),
  .xbus_dat_i(xbus_dat_o),
  .xbus_cti_i(xbus_cti_o),
  .xbus_tag_i(xbus_tag_o),
  .xbus_we_i(xbus_we_o),
  .xbus_sel_i(xbus_sel_o),
  .xbus_stb_i(xbus_stb_o),
  .xbus_dat_o(xbus_dat_i),
  .xbus_ack_o(xbus_ack_i),
  .xbus_err_o(xbus_err_i),

  .m_axi_awaddr(m_axi_awaddr),
  .m_axi_awlen(m_axi_awlen),
  .m_axi_awsize(m_axi_awsize),
  .m_axi_awburst(m_axi_awburst),
  .m_axi_awcache(m_axi_awcache),
  .m_axi_awprot(m_axi_awprot),
  .m_axi_awvalid(m_axi_awvalid),
  .m_axi_awready(m_axi_awready),

  .m_axi_wdata(m_axi_wdata),
  .m_axi_wstrb(m_axi_wstrb),
  .m_axi_wlast(m_axi_wlast),
  .m_axi_wvalid(m_axi_wvalid),
  .m_axi_wready(m_axi_wready),

  .m_axi_araddr(m_axi_araddr),
  .m_axi_arlen(m_axi_arlen),
  .m_axi_arsize(m_axi_arsize),
  .m_axi_arburst(m_axi_arburst),
  .m_axi_arcache(m_axi_arcache),
  .m_axi_arprot(m_axi_arprot),
  .m_axi_arvalid(m_axi_arvalid),
  .m_axi_arready(m_axi_arready),

  .m_axi_rdata(m_axi_rdata),
  .m_axi_rresp(m_axi_rresp),
  .m_axi_rlast(m_axi_rlast),
  .m_axi_rvalid(m_axi_rvalid),
  .m_axi_rready(m_axi_rready),

  .m_axi_bresp(m_axi_bresp),
  .m_axi_bvalid(m_axi_bvalid),
  .m_axi_bready(m_axi_bready)
);


endmodule