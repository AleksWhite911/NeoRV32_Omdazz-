**For testing LCD1602:**

```c
int main(void) {
    neorv32_rte_setup();
    check_modules();
    init_module();
    scan_twi();

    neorv32_twi_setup(I2C_PRSC, I2C_CDIV, 0);

    lcd_init();
    lcd_clear();

    lcd_put_cur(0, 0);
    lcd_send_string("Hello world");

    lcd_put_cur(1, 0);
    lcd_send_string("from RISC-V");

    while (1) {
        neorv32_aux_delay_ms(CPU_CLOCK, 500);
    }
}
