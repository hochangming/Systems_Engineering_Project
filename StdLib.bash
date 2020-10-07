#!/bin/bash -f

rm -r -f ./Lib
mkdir ./Lib/
mkdir ./Lib/Common

cd ./Lib/Common
ln -s ../../../../../StdLib/Common/Inc Inc 
ln -s ../../../../../StdLib/Common/Lib Lib
cd ../..

rm -r -f ./src/App
mkdir    ./src/App
ln -s ../../../StdLib/Common/Inc/.clang-format ./src/.clang-format


cd       ./src/BSP/

rm -r -f MCU
ln -s ../../../../../StdLib/stm32F7/BSP/MCU MCU

rm -r -f Clock
ln -s ../../../../../StdLib/stm32F7/BSP/Clock Clock


rm -r -f Timer
cd ../..
cd       ./src/BSP/
ln -s ../../../../../StdLib/stm32F7/BSP/Timer   Timer
ln -s ../../../../../StdLib/stm32F7/BSP/Spim    Spim
ln -s ../../../../../StdLib/stm32F7/BSP/Pwm     Pwm
ln -s ../../../../../StdLib/stm32F7/BSP/Motors  Motors
ln -s ../../../../../StdLib/stm32F7/BSP/Ccm     Ccm
ln -s ../../../../../StdLib/stm32F7/BSP/Uart    Uart
ln -s ../../../../../StdLib/stm32F7/BSP/Dma     Dma

cd ../App/
ln -s ../../../../../StdLib/Module/LCD          LCD
ln -s ../../../../../StdLib/FreeRTOS_CM7        RTOS
ln -s ../../../../../StdLib/Module/Terminal     Terminal
cd ../..
