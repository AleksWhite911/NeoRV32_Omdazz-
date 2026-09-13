/*
 * st7789_hal.h
 *
 *  Created on: 18 апр. 2026 г.
 *      Author: RenAshbell
 */

#ifndef DRIVERS_DISPLAY_ST7789_HAL_H_
#define DRIVERS_DISPLAY_ST7789_HAL_H_


#include "../GPIO_MIO/GPIO_MIO.h"
#include "../SPI/SPI.h"

#define RESET_MIO_RESET	XGpioPs_WritePin(&gpio_ps, RESET_MIO_PIN, GPIO_PIN_RESET)
#define RESET_MIO_SET XGpioPs_WritePin(&gpio_ps, RESET_MIO_PIN, GPIO_PIN_SET)


#endif /* DRIVERS_DISPLAY_ST7789_HAL_H_ */
