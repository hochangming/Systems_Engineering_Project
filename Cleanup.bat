echo %~dp0
pushd %~dp0
set CurrentDir=%CD%
chdir /d %CurrentDir%

rmdir /Q /S .\Lib\Common\Inc
rmdir /Q /S .\Lib\Common\Lib
rmdir /Q /S .\Lib
rmdir /Q /S build\Output
del build\*.emSession
del build\*.jlink
del build\DPGUI_GCC_M7_R10.a
del .\src\.clang-format

rmdir /Q /S .\src\App\RTOS
rmdir /Q /S .\src\App\USBDevice
rmdir /Q /S .\src\App\UWB
rmdir /Q /S .\src\App\LCD
rmdir /Q /S .\src\App\Terminal
rmdir /Q /S .\src\App\
rmdir /Q /S .\src\BSP\SPIM
rmdir /Q /S .\src\BSP\UART
rmdir /Q /S .\src\BSP\MCU
rmdir /Q /S .\src\BSP\USB
rmdir /Q /S .\src\BSP\Clock
rmdir /Q /S .\src\BSP\Timer
rmdir /Q /S .\src\BSP\Spim
rmdir /Q /S .\src\BSP\Dma