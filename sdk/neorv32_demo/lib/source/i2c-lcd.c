
/** Put this in the src folder **/

#include "i2c-lcd.h"
#include "init_module.h"
#define SLAVE_ADDRESS_LCD 0x4E // change this according to ur setup

//The initialization sequence follows the LCD1602 datasheet’s 4-bit startup procedure exactly
//    HAL_Delay(50);          // >40 ms power-on delay
//    lcd_send_cmd(0x30);
//    HAL_Delay(5);           // >4.1 ms
//    lcd_send_cmd(0x30);
//    HAL_Delay(1);           // >100 µs
//    lcd_send_cmd(0x30);
//    HAL_Delay(10);
//    lcd_send_cmd(0x20);     // switch to 4-bit mode
//
//    lcd_send_cmd(0x28);     // 4-bit, 2-line, 5×8 font
//    HAL_Delay(1);
//    lcd_send_cmd(0x08);     // display OFF
//    HAL_Delay(1);
//    lcd_send_cmd(0x01);     // clear display
//    HAL_Delay(2);
//    lcd_send_cmd(0x06);     // entry mode: cursor increment, no shift
//    HAL_Delay(1);
//    lcd_send_cmd(0x0C);     // display ON, cursor OFF, blink OFF
void lcd_send_cmd (char cmd)
{
  char data_u, data_l;
	uint8_t data_t[4];
	data_u = (cmd&0xf0);
	data_l = ((cmd<<4)&0xf0);
	data_t[0] = data_u|0x0C;  //en=1, rs=0 -> bxxxx1100
	data_t[1] = data_u|0x08;  //en=0, rs=0 -> bxxxx1000
	data_t[2] = data_l|0x0C;  //en=1, rs=0 -> bxxxx1100
	data_t[3] = data_l|0x08;  //en=0, rs=0 -> bxxxx1000
	//HAL_I2C_Master_Transmit (&hi2c1, SLAVE_ADDRESS_LCD,(uint8_t *) data_t, 4, 100);
	i2c_write_bytes(data_t, 4, SLAVE_ADDRESS_LCD);
}

void lcd_send_data (char data)
{
	char data_u, data_l;
	uint8_t data_t[4];
	data_u = (data&0xf0);
	data_l = ((data<<4)&0xf0);
	data_t[0] = data_u|0x0D;  //en=1, rs=0 -> bxxxx1101
	data_t[1] = data_u|0x09;  //en=0, rs=0 -> bxxxx1001
	data_t[2] = data_l|0x0D;  //en=1, rs=0 -> bxxxx1101
	data_t[3] = data_l|0x09;  //en=0, rs=0 -> bxxxx1001
	//HAL_I2C_Master_Transmit (&hi2c1, SLAVE_ADDRESS_LCD,(uint8_t *) data_t, 4, 100);
	i2c_write_bytes(data_t, 4, SLAVE_ADDRESS_LCD);
}

void lcd_clear (void)
{
	lcd_send_cmd (0x80);
	for (int i=0; i<70; i++)
	{
		lcd_send_data (' ');
	}
}

void lcd_put_cur(int row, int col)
{
    switch (row)
    {
        case 0:
            col |= 0x80;
            break;
        case 1:
            col |= 0xC0;
            break;
    }

    lcd_send_cmd (col);
}


void lcd_init (void)
{
	// 4 bit initialisation
	//HAL_Delay(50);  // wait for >40ms
	neorv32_aux_delay_ms(CPU_CLOCK, 50);
	lcd_send_cmd (0x30);
	//HAL_Delay(5);  // wait for >4.1ms
	neorv32_aux_delay_ms(CPU_CLOCK, 5);
	lcd_send_cmd (0x30);
	//HAL_Delay(1);  // wait for >100us
	neorv32_aux_delay_ms(CPU_CLOCK, 1);
	lcd_send_cmd (0x30);
	//HAL_Delay(10);
	neorv32_aux_delay_ms(CPU_CLOCK, 10);
	lcd_send_cmd (0x20);  // 4bit mode
	//HAL_Delay(10);
	neorv32_aux_delay_ms(CPU_CLOCK, 10);

  // dislay initialisation
	lcd_send_cmd (0x28); // Function set --> DL=0 (4 bit mode), N = 1 (2 line display) F = 0 (5x8 characters)
	//HAL_Delay(1);
	neorv32_aux_delay_ms(CPU_CLOCK, 1);
	lcd_send_cmd (0x08); //Display on/off control --> D=0,C=0, B=0  ---> display off
	//HAL_Delay(1);
	neorv32_aux_delay_ms(CPU_CLOCK, 1);
	lcd_send_cmd (0x01);  // clear display
	//HAL_Delay(1);
	neorv32_aux_delay_ms(CPU_CLOCK, 1);
	//HAL_Delay(1);
	neorv32_aux_delay_ms(CPU_CLOCK, 1);
	lcd_send_cmd (0x06); //Entry mode set --> I/D = 1 (increment cursor) & S = 0 (no shift)
	//HAL_Delay(1);
	neorv32_aux_delay_ms(CPU_CLOCK, 1);
	lcd_send_cmd (0x0C); //Display on/off control --> D = 1, C and B = 0. (Cursor and blink, last two bits)
}

void lcd_send_string (char *str)
{
	while (*str) lcd_send_data (*str++);
}
