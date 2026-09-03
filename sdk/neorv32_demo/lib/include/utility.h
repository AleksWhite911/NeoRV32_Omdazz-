/*******************************************
 * utility.h
 *
 *  Created on: 24.08.2026 02:09:25
 *      Author: Anatoly Alekseev <RenAshbell>
 ******************************************/

#ifndef LIB_INCLUDE_UTILITY_H_
#define LIB_INCLUDE_UTILITY_H_

#include <stdint.h>
#include "neorv32_uart.h"

#define SHORT_BEEP 			1000
#define LONG_BEEP			3000

void print_hex_byte(uint8_t data);
void short_beep();
void long_beep();

#endif /* LIB_INCLUDE_UTILITY_H_ */
