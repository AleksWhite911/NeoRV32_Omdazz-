-- ================================================================================ --
-- NEORV32 - Test Setup Using The UART-Bootloader To Upload And Run Executables     --
-- -------------------------------------------------------------------------------- --
-- The NEORV32 RISC-V Processor - https://github.com/stnolting/neorv32              --
-- Copyright (c) NEORV32 contributors.                                              --
-- Copyright (c) 2020 - 2025 Stephan Nolting. All rights reserved.                  --
-- Licensed under the BSD-3-Clause license, see LICENSE for details.                --
-- SPDX-License-Identifier: BSD-3-Clause                                            --
-- ================================================================================ --

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.neorv32_package.all;

entity tang_nano_9k is

-- Memory map:
-- 0x00000000 - 0x00008000: 32kb IMEM (Gowin User SRAM)
-- 0x80000000 - 0x80008000: 32kb DMEM (Gowin User SRAM)
  generic (
    -- adapt these for your setup --
    CLOCK_FREQUENCY   : natural := 50000000;  -- clock frequency of clk_i in Hz
    MEM_INT_IMEM_SIZE : natural := 16 * 1024;   -- size of processor-internal instruction memory in bytes
    MEM_INT_DMEM_SIZE : natural :=  8 * 1024   -- size of processor-internal data memory in bytes

  );
  port (
    -- Global control --
    clk_i       : in  std_ulogic; -- global clock, rising edge
    rstn_i      : in  std_ulogic; -- global reset, low-active, async
    -- GPIO --
    gpio_o     : out std_ulogic_vector(7 downto 0); -- parallel output
    -- UART0 --
    uart0_txd_o : out std_ulogic; -- UART0 send data
    uart0_rxd_i : in  std_ulogic;  -- UART0 receive data

    -- JTAG --
    jtag_tck_i     : in  std_ulogic;                                -- serial clock
    jtag_tdi_i     : in  std_ulogic;                                -- serial data input
    jtag_tdo_o     : out std_ulogic;                                -- serial data output
    jtag_tms_i     : in  std_ulogic;                                -- mode select

    -- SPI --
    spi_clk_o      : out std_ulogic;                                -- serial clock (in)
    spi_dat_o      : out std_ulogic;                                -- serial data input
    spi_dat_i      : in std_ulogic;                               -- serial data output
    spi_csn_o      : out std_ulogic_vector(7 downto 0);             -- serial data chip selectn

    -- I2C --
    twi_sda_i      : in  std_ulogic;
    twi_sda_o      : out std_ulogic;      
    twi_scl_i      : in  std_ulogic;
    twi_scl_o      : out std_ulogic;

    -- XBUS --
    xbus_adr_o     : out std_ulogic_vector(31 downto 0);                     -- address
    xbus_dat_o     : out std_ulogic_vector(31 downto 0);                     -- write data
    xbus_cti_o     : out std_ulogic_vector(2 downto 0);                      -- cycle type
    xbus_tag_o     : out std_ulogic_vector(2 downto 0);                      -- access tag
    xbus_we_o      : out std_ulogic;                                         -- read/write
    xbus_sel_o     : out std_ulogic_vector(3 downto 0);                      -- byte enable
    xbus_stb_o     : out std_ulogic;                                         -- strobe
    xbus_cyc_o     : out std_ulogic;                                         -- valid cycle
    xbus_dat_i     : in  std_ulogic_vector(31 downto 0);                     -- read data
    xbus_ack_i     : in  std_ulogic;                                         -- transfer acknowledge
    xbus_err_i     : in  std_ulogic                                          -- transfer error

  );
end entity;

architecture top_rtl of tang_nano_9k is

  signal con_gpio_out : std_ulogic_vector(31 downto 0);


  begin
  -- The Core Of The Problem ----------------------------------------------------------------
  -- -------------------------------------------------------------------------------------------
  neorv32_top_inst: neorv32_top
  generic map (
    -- Clocking --
    CLOCK_FREQUENCY     => CLOCK_FREQUENCY,   -- clock frequency of clk_i in Hz
    -- Boot Configuration --
    BOOT_MODE_SELECT    => 0,                 -- boot via internal bootloader
    -- RISC-V CPU Extensions --
    RISCV_ISA_C         => true,              -- implement compressed extension?
    RISCV_ISA_M         => true,              -- implement mul/div extension?
    RISCV_ISA_Zicntr    => true,              -- implement base counters?
    RISCV_ISA_Xcfu      => true,              -- implement custom (instr.) functions unit
    -- Internal Instruction memory --
    IMEM_EN             => true,              -- implement processor-internal instruction memory
    IMEM_SIZE           => MEM_INT_IMEM_SIZE, -- size of processor-internal instruction memory in bytes
    IMEM_OUTREG_EN      => true,
    -- Internal Data memory --
    DMEM_EN             => true,              -- implement processor-internal data memory
    DMEM_SIZE           => MEM_INT_DMEM_SIZE, -- size of processor-internal data memory in bytes
    DMEM_OUTREG_EN      => true,
    -- Processor peripherals --
    IO_GPIO_NUM         => 8,                 -- number of GPIO input/output pairs (0..32)
    IO_CLINT_EN         => true,              -- implement core local interruptor (CLINT)?
    IO_UART0_EN         => true,              -- implement primary universal asynchronous receiver/transmitter (UART0)?
    IO_SPI_EN           => true,              -- implement serial peripheral interface (SPI)
    IO_SPI_FIFO         => 8,                 -- RTX FIFO depth, has to be zero or a power of two, min 1

    -- I2C --
    IO_TWI_EN           => true,
    IO_TWI_FIFO         => 8,

    OCD_EN              => true,              -- implement JTAG interface
    OCD_NUM_HW_TRIGGERS => 1,
    OCD_AUTHENTICATION  => true,



    XBUS_EN           => true,              -- implement X-Bus interface
    XBUS_TIMEOUT      => 0                  -- Disable timeout, flash erase can take a long time
  )
  port map (
    -- Global control --
    clk_i        => clk_i,        -- global clock, rising edge
    rstn_i       => rstn_i,       -- global reset, low-active, async


    -- GPIO (available if IO_GPIO_NUM > 0) --
    gpio_o      => con_gpio_out, -- parallel output

    -- primary UART0 (available if IO_UART0_EN = true) --
    uart0_txd_o => uart0_txd_o,  -- UART0 send data
    uart0_rxd_i => uart0_rxd_i,   -- UART0 receive data

    -- JTAG (available if IO_JTAG_EN = true) --
    jtag_tck_i => jtag_tck_i,                                 -- serial clock
    jtag_tdi_i => jtag_tdi_i,                                 -- serial data input
    jtag_tdo_o => jtag_tdo_o,                                 -- serial data output
    jtag_tms_i => jtag_tms_i,                                 -- mode select


    spi_clk_o => spi_clk_o,
    spi_dat_o => spi_dat_o,
    spi_dat_i => spi_dat_i,
    spi_csn_o => spi_csn_o,

    twi_sda_i => twi_sda_i,
    twi_sda_o => twi_sda_o,     
    twi_scl_i => twi_scl_i,
    twi_scl_o => twi_scl_o,

    -- Xbus signals
    xbus_adr_o => xbus_adr_o,
    xbus_dat_o => xbus_dat_o,
    xbus_cti_o => xbus_cti_o,
    xbus_tag_o => xbus_tag_o,
    xbus_we_o => xbus_we_o,
    xbus_sel_o => xbus_sel_o,
    xbus_stb_o => xbus_stb_o,
    xbus_cyc_o => xbus_cyc_o,
    xbus_dat_i => xbus_dat_i,
    xbus_ack_i => xbus_ack_i,
    xbus_err_i => xbus_err_i

  );

  -- GPIO output --
  gpio_o <= con_gpio_out(7 downto 0);


end architecture;
