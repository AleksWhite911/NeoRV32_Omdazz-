/*******************************************
 * utility.c
 *
 *  Created on: 24.08.2026 02:09:16
 *      Author: Anatoly Alekseev <RenAshbell>
 ******************************************/


#include "utility.h"



/**********************************************************************//**
 * Print byte as hex chars via UART0.
 *
 * @param data 8-bit data to be printed as two hex chars.
 **************************************************************************/
void print_hex_byte(uint8_t data) {


  static const char symbols[] = "0123456789abcdef";

  neorv32_uart0_putc(symbols[(data >> 4) & 15]);
  neorv32_uart0_putc(symbols[(data >> 0) & 15]);
}


/**********************************************************************//**
 * Short beep.
 **************************************************************************/
void short_beep() {
	for (uint32_t i=0; i<SHORT_BEEP; i++) {
		neorv32_aux_delay_us(CPU_CLOCK , 500);
		neorv32_gpio_pin_toggle(GPIO_BEEP);
	}
	neorv32_gpio_pin_set(GPIO_BEEP, 1);
	neorv32_aux_delay_ms(CPU_CLOCK, 100);
}


/**********************************************************************//**
 * Long beep.
 **************************************************************************/
void long_beep() {
	for (uint32_t i=0; i<LONG_BEEP; i++) {
		neorv32_aux_delay_us(CPU_CLOCK , 500);
		neorv32_gpio_pin_toggle(GPIO_BEEP);
	}
	neorv32_gpio_pin_set(GPIO_BEEP, 1);
	neorv32_aux_delay_ms(CPU_CLOCK, 100);
}
