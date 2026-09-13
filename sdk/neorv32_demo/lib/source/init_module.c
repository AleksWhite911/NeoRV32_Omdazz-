/*******************************************
 * init_module.c
 *
 *  Created on: 19.06.2026 14:03:50
 *      Author: Anatoly Alekseev <RenAshbell>
 ******************************************/

/*******************************************
 * Includes
 ******************************************/
#include "init_module.h"



/*******************************************
 * Global variables
 ******************************************/
init_status_t status_struct;
uint32_t PRSC_LUT[8] = {2, 4, 8, 64, 128, 1024, 2048, 4096};	//I2C Prescaler const
uint8_t addr[10];	//I2C_Mass_addr

/**********************************************************************//**
 * Check available periphery.
 **************************************************************************/
void check_modules(void) {

	#if (_UART_0_)
		if (!neorv32_uart0_available()) {
			status_struct.uart_0 = 0;
		} else {
			status_struct.uart_0 = 1;
		}
	#endif

	#if (_UART_1_)
		if (!neorv32_uart1_available()) {
			status_struct.uart_1 = 0;
		} else {
			status_struct.uart_1 = 1;
		}
	#endif

	#if (_UART_CONSOLE_)

	#endif

	#if (_SDI_)
		if (!neorv32_sdi_available()) {
			status_struct.sdi = 0;
		} else {
			status_struct.sdi = 1;
		}
	#endif

	#if (_SDI_STD_)
		if (!neorv32_sdi_available()) {
			status_struct.sdi_std_mode = 0;
		} else {
			status_struct.sdi_std_mode = 1;
		}
	#endif

	#if (_CFS_)
		if (!neorv32_cfs_available()) {
			status_struct.custom_func = 0;
		} else {
			status_struct.custom_func = 1;
		}
	#endif

	#if (_GPIO_)
		if (!neorv32_gpio_available()) {
			status_struct.gpio_block = 0;
		} else {
			status_struct.gpio_block = 1;
		}
	#endif

	#if (_GPTMR_)
		if (!neorv32_gptmr_available()) {
			status_struct.general_timer = 0;
		} else {
			status_struct.general_timer = 1;
		}
	#endif

	#if (_CLINT_)
		if (!neorv32_clint_available()) {
			status_struct.clint_module = 0;
		} else {
			status_struct.clint_module = 1;
		}
	#endif

	#if (_DMA_)
		if (!neorv32_dma_available()) {
			status_struct.dma_block = 0;
		} else {
			status_struct.dma_block = 1;
		}
	#endif

	#if (_NEOLED_)
		if (!neorv32_neoled_available()) {
			status_struct.neoled_block = 0;
		} else {
			status_struct.neoled_block = 1;
		}
	#endif

	#if (_ONEWIRE_)
		if (!neorv32_onewire_available()) {
			status_struct.onewire_block = 0;
		} else {
			status_struct.onewire_block = 1;
		}
	#endif

	#if (_PWM_)
		if (!neorv32_pwm_available()) {
			status_struct.pwm = 0;
		} else {
			status_struct.pwm = 1;
		}
	#endif


	#if (_SLINK_)
		if (!neorv32_slink_available()) {
			status_struct.slink = 0;
		} else {
			status_struct.slink = 1;
		}
	#endif

	#if (_SPI_)
		if (!neorv32_spi_available()) {
			status_struct.spi = 0;
		} else {
			status_struct.spi = 1;
		}
	#endif

	#if (_TRACER_)
		if (!neorv32_tracer_available()) {
			status_struct.tracer = 0;
		} else {
			status_struct.tracer = 1;
		}
	#endif

	#if (_TRNG_)
		if (!neorv32_trng_available()) {
			status_struct.trng_module = 0;
		} else {
			status_struct.trng_module = 1;
		}
	#endif

	#if (_TWD_)
		if (!neorv32_twd_available()) {
			status_struct.twd = 0;
		} else {
			status_struct.twd = 1;
		}
	#endif

	#if (_TWI_)
		if (!neorv32_twi_available()) {
			status_struct.twi = 0;
		} else {
			status_struct.twi = 1;
		}
	#endif

	#if (_WDT_)
		if (!neorv32_wdt_available()) {
			status_struct.wdt = 0;
		} else {
			status_struct_wdt = 1;
		}
	#endif

	#if (_DISPLAY_)
		status_struct.display = 1;
	#endif
}


bool init_module(void) {
	neorv32_rte_setup();

	if (!status_struct.uart_0) {

		#if (_BEEP_)
			long_beep();
		#endif
		return false;
	} else {
		neorv32_uart0_setup(BAUD_RATE, 0);
		neorv32_uart0_printf("UART_0 - Init successful\n");
		#if (_BEEP_)
			short_beep();
		#endif
	}

	if (!status_struct.spi) {
		neorv32_uart0_printf("SPI - Not implement\n");
	#if (_BEEP_)
		long_beep();
	#endif
	} else {
		neorv32_spi_setup(0, 0, 0, 0); //CPOL = 0, CPHA = 0 CLK_DIVIDER = 8
		neorv32_spi_enable();
		neorv32_uart0_printf("SPI - Init successful\n");
	}

	if (!status_struct.uart_1) {
		neorv32_uart0_printf("UART_1 - Not implement\n");
		#if (_BEEP_)
			long_beep();
		#endif
	} else {
		neorv32_uart1_setup(BAUD_RATE, 0);
		neorv32_uart0_printf("UART_1 - Init successful\n");
		#if (_BEEP_)
			short_beep();
		#endif
	}

	if (!status_struct.twi) {
		neorv32_uart0_printf("I2C_Master - Not implement\n");
		#if (_BEEP_)
			long_beep();
		#endif
	} else {
		neorv32_twi_setup(I2C_PRSC, I2C_CDIV, 0);
		uint32_t clock = neorv32_sysinfo_get_clk() / (4 * PRSC_LUT[I2C_PRSC] * (1 + I2C_CDIV));
		neorv32_uart0_printf("I2C_Master - Clock is %d\n", clock);
		neorv32_uart0_printf("I2C_Master - Init successful\n");
		#if (_BEEP_)
			short_beep();
		#endif
	}

	if (!status_struct.sdi) {
		neorv32_uart0_printf("SDI - Not implement or another mode SDI\n");
	} else {
		neorv32_sdi_setup(0);
		#if (_BEEP_)
			short_beep();
		#endif
		neorv32_uart0_printf("SDI - Init successful \n");
	}

	if (!status_struct.display) {
		neorv32_uart0_printf("DISPLAY - Not set!");
	} else {

	}



	return true;
}
