################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lib/source/i2c_driver.c \
../lib/source/init_module.c \
../lib/source/neorv32_aux.c \
../lib/source/neorv32_cfs.c \
../lib/source/neorv32_clint.c \
../lib/source/neorv32_cpu.c \
../lib/source/neorv32_dma.c \
../lib/source/neorv32_gpio.c \
../lib/source/neorv32_gptmr.c \
../lib/source/neorv32_neoled.c \
../lib/source/neorv32_newlib.c \
../lib/source/neorv32_onewire.c \
../lib/source/neorv32_pwm.c \
../lib/source/neorv32_rte.c \
../lib/source/neorv32_sdi.c \
../lib/source/neorv32_semihosting.c \
../lib/source/neorv32_slink.c \
../lib/source/neorv32_smp.c \
../lib/source/neorv32_spi.c \
../lib/source/neorv32_tracer.c \
../lib/source/neorv32_trng.c \
../lib/source/neorv32_twd.c \
../lib/source/neorv32_twi.c \
../lib/source/neorv32_uart.c \
../lib/source/neorv32_wdt.c \
../lib/source/utility.c 

OBJS += \
./lib/source/i2c_driver.o \
./lib/source/init_module.o \
./lib/source/neorv32_aux.o \
./lib/source/neorv32_cfs.o \
./lib/source/neorv32_clint.o \
./lib/source/neorv32_cpu.o \
./lib/source/neorv32_dma.o \
./lib/source/neorv32_gpio.o \
./lib/source/neorv32_gptmr.o \
./lib/source/neorv32_neoled.o \
./lib/source/neorv32_newlib.o \
./lib/source/neorv32_onewire.o \
./lib/source/neorv32_pwm.o \
./lib/source/neorv32_rte.o \
./lib/source/neorv32_sdi.o \
./lib/source/neorv32_semihosting.o \
./lib/source/neorv32_slink.o \
./lib/source/neorv32_smp.o \
./lib/source/neorv32_spi.o \
./lib/source/neorv32_tracer.o \
./lib/source/neorv32_trng.o \
./lib/source/neorv32_twd.o \
./lib/source/neorv32_twi.o \
./lib/source/neorv32_uart.o \
./lib/source/neorv32_wdt.o \
./lib/source/utility.o 

C_DEPS += \
./lib/source/i2c_driver.d \
./lib/source/init_module.d \
./lib/source/neorv32_aux.d \
./lib/source/neorv32_cfs.d \
./lib/source/neorv32_clint.d \
./lib/source/neorv32_cpu.d \
./lib/source/neorv32_dma.d \
./lib/source/neorv32_gpio.d \
./lib/source/neorv32_gptmr.d \
./lib/source/neorv32_neoled.d \
./lib/source/neorv32_newlib.d \
./lib/source/neorv32_onewire.d \
./lib/source/neorv32_pwm.d \
./lib/source/neorv32_rte.d \
./lib/source/neorv32_sdi.d \
./lib/source/neorv32_semihosting.d \
./lib/source/neorv32_slink.d \
./lib/source/neorv32_smp.d \
./lib/source/neorv32_spi.d \
./lib/source/neorv32_tracer.d \
./lib/source/neorv32_trng.d \
./lib/source/neorv32_twd.d \
./lib/source/neorv32_twi.d \
./lib/source/neorv32_uart.d \
./lib/source/neorv32_wdt.d \
./lib/source/utility.d 


# Each subdirectory must supply rules for building sources it contributes
lib/source/%.o: ../lib/source/%.c lib/source/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GNU RISC-V Cross C Compiler'
	riscv-none-elf-gcc -march=rv32i_zicsr_zifencei -mabi=ilp32 -mtune=size -mcmodel=medany -msmall-data-limit=8 -mstrict-align -msave-restore -O0 -fmessage-length=0 -ffunction-sections -fdata-sections -fno-builtin -g3 -I"C:\QuartusPrj\Omdazz\sdk\neorv32_demo\lib\include" -I"C:\QuartusPrj\Omdazz\sdk\neorv32_demo\src" -std=gnu11 -Wa,-adhlns="$@.lst" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


