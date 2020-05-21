Readme - Hello World Software Example

DESCRIPTION:	
Simple program that prints "Hello from Nios II"

The purpose of this example is to demonstrate the smallest possible Hello 
World application, using the Nios II HAL BSP. The memory footprint
of this hosted application is intended to be less than 1 kbytes by default using a standard 
reference design.  For a more fully featured Hello World application
example, see the example titled "Hello World".

The memory footprint of this example has been reduced by making the
following changes to the normal "Hello World" example.
Check in the Nios II Software Developers Handbook for a more complete 
description.
 
In the SW Application project:
 - In the C/C++ Build page
    - Set the Optimization Level to -Os

In BSP project:
 - In the C/C++ Build page

    - Set the Optimization Level to -Os
 
    - Define the preprocessor option ALT_NO_INSTRUCTION_EMULATION 
      This removes software exception handling, which means that you cannot 
      run code compiled for Nios II cpu with a hardware multiplier on a core 
      without a the multiply unit. Check the Nios II Software Developers 
      Manual for more details.

  - In the BSP:
    - Set Periodic system timer and Timestamp timer to none
      This prevents the automatic inclusion of the timer driver.

    - Set Max file descriptors to 4
      This reduces the size of the file handle pool.

    - Uncheck Clean exit (flush buffers)
      This removes the call to exit, and when main is exitted instead of 
      calling exit the software will just spin in a loop.

    - Check Small C library
      This uses a reduced functionality C library, which lacks  
      support for buffering, file IO, floating point and getch(), etc. 
      Check the Nios II Software Developers Manual for a complete list.

    - Check Reduced device drivers
      This uses reduced functionality drivers if they're available. For the
      standard design this means you get polled UART and JTAG UART drivers,
      no support for the LCD driver and you lose the ability to program 
      CFI compliant flash devices.


PERIPHERALS USED:
This example exercises the following peripherals:
- STDOUT device (UART or JTAG UART)

SOFTWARE SOURCE FILES:
This example includes the following software source files:
- small_hello_world.c: 

BOARD/HOST REQUIREMENTS:
This example requires only a JTAG connection with a Nios Development board. If
the host communication settings are changed from JTAG UART (default) to use a
conventional UART, a serial cable between board DB-9 connector  and the host is
required.
