################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lib/StdProtocol/src/std_protocol.c \
../lib/StdProtocol/src/std_protocol_actions.c \
../lib/StdProtocol/src/std_protocol_app.c \
../lib/StdProtocol/src/std_protocol_const.c \
../lib/StdProtocol/src/std_protocol_hal.c 

OBJS += \
./lib/StdProtocol/src/std_protocol.o \
./lib/StdProtocol/src/std_protocol_actions.o \
./lib/StdProtocol/src/std_protocol_app.o \
./lib/StdProtocol/src/std_protocol_const.o \
./lib/StdProtocol/src/std_protocol_hal.o 

C_DEPS += \
./lib/StdProtocol/src/std_protocol.d \
./lib/StdProtocol/src/std_protocol_actions.d \
./lib/StdProtocol/src/std_protocol_app.d \
./lib/StdProtocol/src/std_protocol_const.d \
./lib/StdProtocol/src/std_protocol_hal.d 


# Each subdirectory must supply rules for building sources it contributes
lib/StdProtocol/src/%.o: ../lib/StdProtocol/src/%.c lib/StdProtocol/src/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GNU RISC-V Cross C Compiler'
	riscv-none-elf-gcc -march=rv32i_zicsr_zifencei -mabi=ilp32 -mtune=size -mcmodel=medany -msmall-data-limit=8 -mstrict-align -msave-restore -O0 -fmessage-length=0 -ffunction-sections -fdata-sections -fno-builtin -g3 -I"D:\GwinPrj\neorv32_repo\tang_primer_risc_v\sdk\neorv32_demo\lib\include" -I"D:\GwinPrj\neorv32_repo\tang_primer_risc_v\sdk\neorv32_demo\src" -std=gnu11 -Wa,-adhlns="$@.lst" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


