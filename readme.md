```
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

Important: this is a Keil MDK5 project, but a compiler version 5 (ARMCC) is needed.


```


---------------------------- following is from original author -------------------------


本工程从“技新”开源的DAPLINK修改来。 修改 by：rush 1，解决了原工程缺文件无法编译问题。测试使用MDK474编译.由于某个文件RTL.h戳中了keil的G点，你需要注册机给keil注册下RTOS的功能！ 2，原工程居然想当然去修改了设备名字！！！！导致了很多版本MDK无法识别！！ 3，原工程注释掉部分描述符，不知道是不是复合设备不兼容他们的win7，总之这导致了在win10下复合设备不识别(看到只有串口没有HID) 4，原工程USBlib使用lib，但是提供了一份源码，为了完全开源我们改用源码编译，其中部分inline导致无法编译，已去除。 5，那个USBlib库不兼容GD等国产单片机，请老实花钱购买正常STM32芯片。 6，电路图就是常见的老古董STLINK2.0，还能刷JLINK OB的那种。我晶振是12M，用8M自行修改。


----------------------------------------------------


这帮搞嵌入式的说的有点点语焉不详 因此copy一份 顺便附上固件一份（8m晶振的）

CMSIS-DAP2mod/STM32/CMSIS-DAP.c
416行 在这里修改打开swj

```
	// Full SWJ Disabled (JTAG-DP + SW-DP) 
	GPIO_PinRemapConfig(GPIO_Remap_SWJ_Disable, ENABLE);
```

CMSIS-DAP2mod/STM32/DAP_config.h

259行去改swdio和swclk 可以让stm32f103小蓝板子的swdio接口完全一比一对上  闭眼插

```

	#define PIN_SWDIO_TMS_PORT      GPIOA
	#define PIN_SWDIO_TMS_PIN		13 //默认是2

	// SWCLK/TCK Pin
	#define PIN_SWCLK_TCK_PORT		GPIOA
	#define PIN_SWCLK_TCK_PIN		14 //默认是4


```

CMSIS-DAP2mod/STM32/STM32F10x_StdPeriph_Driver/inc/stm32f10x.h

115行改晶振 这里强制都是改成8m的了

```
#if !defined  HSE_VALUE
 #ifdef STM32F10X_CL   
  #define HSE_VALUE    ((uint32_t)8000000) /*!< Value of the External oscillator in Hz */
 #else 
  #define HSE_VALUE    ((uint32_t)8000000) /*!< Value of the External oscillator in Hz */
 #endif /* STM32F10X_CL */
#endif /* HSE_VALUE */
```


openocd链接stm32f103

```

.\bin\openocd -f interface/cmsis-dap.cfg -f target/stm32f1x.cfg 


```


就酱。




