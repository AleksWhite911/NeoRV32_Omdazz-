/*******************************************
 * i2c_driver.h
 *
 *  Created on: 24.08.2026 02:07:37
 *      Author: Anatoly Alekseev <RenAshbell>
 ******************************************/

#ifndef LIB_INCLUDE_I2C_DRIVER_FLASH_H_
#define LIB_INCLUDE_I2C_DRIVER_FLASH_H_

#include "neorv32_twi.h"
#include "utility.h"

#define FLASH_BANK_0		0xA0
#define FLASH_BANK_1		0xA2
#define FLASH_BANK_3		0xA4
#define FLASH_BANK_4		0xA6
#define TEMP_SENSE			0x90
#define MAX_ADDR_I2C		0xFF
#define	MAX_BANK			0x100
#define I2C_FLASH_MAX_BANKS	0x04
#define MAX_I2C_MEMORY		3FF

#define MASK_READ  			0x01
#define MASK_WRITE			0xFE
#define MASK_RX_DATA_AVAILABLE	0x40000000
#define MAX_DEVICE_ADDR

void scan_twi(void);
uint8_t i2c_read_byte(uint8_t device_address, uint8_t word_address);
void i2c_write_byte(uint8_t data, uint8_t device_address, uint8_t word_address);
uint8_t i2c_read_temp_byte(uint8_t device_address, uint8_t word_address);
void i2c_write_word(uint32_t data, uint8_t device_address, uint8_t word_address);
uint32_t i2c_read_word(uint8_t device_address, uint8_t word_address);
void flash_write_word(uint8_t device_id_flash, uint16_t address_word, uint32_t data);



#endif /* LIB_INCLUDE_I2C_DRIVER_FLASH_H_ */
