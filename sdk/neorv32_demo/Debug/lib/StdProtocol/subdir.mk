################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lib/StdProtocol/std_protocol_hal.c 

OBJS += \
./lib/StdProtocol/std_protocol_hal.o 

C_DEPS += \
./lib/StdProtocol/std_protocol_hal.d 


# Each subdirectory must supply rules for building sources it contributes
lib/StdProtocol/%.o: ../lib/StdProtocol/%.c lib/StdProtocol/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GNU RISC-V Cross C Compiler'
	riscv-none-elf-gcc -march=rv32i_zicsr_zifencei -mabi=ilp32 -mtune=size -mcmodel=medany -msmall-data-limit=8 -mstrict-align -msave-restore -O0 -fmessage-length=0 -ffunction-sections -fdata-sections -fno-builtin -g -I"D:\GwinPrj\Eclipse\neorv32_demo\lib\include" -I"D:\GwinPrj\Eclipse\neorv32_demo\lib\StdProtocol\inc" -I"D:\GwinPrj\Eclipse\neorv32_demo\lib\StdProtocol\src" -I"D:\GwinPrj\Eclipse\neorv32_demo\src" -std=gnu11 -Wa,-adhlns="$@.lst" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


