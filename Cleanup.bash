#!/bin/bash -f

rm -r -f ./Lib/Common/Inc
rm -r -f ./Lib/Common/Lib
rm -r -f ./Lib
rm -r -f ./build/Output
rm       ./build/*.emSession
rm       ./build/*.jlink
rm       ./src/.clang-format

rm -r -f ./src/App
rm       ./src/BSP/MCU
rm       ./src/BSP/Clock
rm       ./src/BSP/Timer
rm       ./src/BSP/Ccm
rm       ./src/BSP/Dma
rm       ./src/BSP/Motors
rm       ./src/BSP/Pwm
rm       ./src/BSP/Spim
rm       ./src/BSP/Uart

