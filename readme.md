Modified from a modified copy of JiXin DAP-Link source codes, to fit STM32F103C6T6, which has only 32kB ROM and 10kB RAM.
There's only a HID interface for debug and a CDC serial port for COM-like usage.
HSE of STM32 is a 8MHz oscillator oscillator.
The hardware GPIO pins (which can be modifed in file "DAP_config.h"):
    A9: serial TX
    A10: serial RX
    A2: SWDIO
    A4: SWCLK
    A6: nRESET
    B8: Connected LED
    B12: Target Running LED

---------------------------- following is from original author -------------------------

本工程从“技新”开源的DAPLINK修改来。
修改 by：rush
1，解决了原工程缺文件无法编译问题。测试使用MDK474编译.由于某个文件RTL.h戳中了keil的G点，你需要注册机给keil注册下RTOS的功能！
2，原工程居然想当然去修改了设备名字！！！！导致了很多版本MDK无法识别！！
3，原工程注释掉部分描述符，不知道是不是复合设备不兼容他们的win7，总之这导致了在win10下复合设备不识别(看到只有串口没有HID)
4，原工程USBlib使用lib，但是提供了一份源码，为了完全开源我们改用源码编译，其中部分inline导致无法编译，已去除。
5，那个USBlib库不兼容GD等国产单片机，请老实花钱购买正常STM32芯片。
6，电路图就是常见的老古董STLINK2.0，还能刷JLINK OB的那种。我晶振是12M，用8M自行修改。