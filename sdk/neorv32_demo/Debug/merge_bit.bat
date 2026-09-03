@REM -------------------------------------------------------------------------------------------------------
@REM -------------------------------------------------------------------------------------------------------


@REM tool      : merge_bit.exe : merge a C binary file and a FPGA fabric fs file into a new fs file
@REM command   : merge_bit.exe bin_file fs_file itcm_size posp_file
@REM parameter :
@REM ----bin_file  : C binary file
@REM ----fs_file   : FPGA fabric fs file
@REM ----itcm_size : ITCM size (8KB, 16KB, 32KB, 64KB, 128KB, 256KB, 512KB)
@REM ----posp_file : posp file from PnR

call merge_bit.exe picorv32_load_demo.bin gowin_picorv32.fs 32 gowin_picorv32.posp
 
pause