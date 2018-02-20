---
layout: default
title: USB Serial firmware for ATmega32U4
tags: usb serial atmega32u4 adafruit
---

This post shows how to create USB Serial firmware for the ATmega32U4 found on Adrafruit's excellent [breakout board](https://www.adafruit.com/products/296), using Atmel Studio 7\. The design of the breakout board is [available](https://github.com/adafruit/Atmega32u4-Breakout-Board) at GitHub, so is the [Fritzing part](https://github.com/adafruit/Fritzing-Library) used in the figure below. The source code of the USB Serial firmware discussed here can also be [forked](https://github.com/tewarid/atmega32u4-usb-serial) at GitHub.

![Adafruit's ATmega32U4 breakout](/assets/img/fritzing-atmega32u4-adafruit.png)

## Source code

Creation of source code using Atmel Studio 7 is described in post [Arduino USB Serial firmware from scratch]({{ site.baseurl }}{% post_url 2016-08-10-arduino-usb-serial-firmware-from-scratch %}). Choose adafruit_u4 as the board for LUFA Board Support (driver).

the breakout board has just one programmable LED hence the code has been adapted to blink the same LED when receiving and transmitting data.

See the wiring diagram above to see how JTAGICE3 can be wired to the ICSP header on the breakout board. The Device Programming dialog can then be used to program flash memory on the MCU as shown below.

![Device Programming](/assets/img/atmel-studio-device-programming-usb-serial.png)

## Testing and troubleshooting

The converter can be tested by using another USB Serial converter connected to RX and TX wires shown in the wiring diagram. Note that the wire ending with TX should be connected to RX on the other converter, similarly the wire ending with RX should be connected to TX.

The firmware requires that the host send SetLineCoding request to set the baud rate, as described in Universal Serial Bus Communications Class Subclass Specification for PSTN Devices. If the host fails to do that, the serial port will not get initialized, and data cannot be received from or sent to the host.

The breakout board ships from Adafruit in USB powered mode. That makes it ideal as a USB Serial adapter because it can be powered from the PC it is plugged into. If your USB host device does not provide enough current on VBUS, you can [cut the VCC solder jumper](https://learn.adafruit.com/atmega32u4-breakout/design) on the other side, and provide 3.3V at the VCC header pin.

![Screen Shot 2016-11-14 at 12.11.11.png](/assets/img/atmega32u4-breakout-adafruit-vcc.png)

Atmel has a detailed [application note](http://ww1.microchip.com/downloads/en/AppNotes/doc8388.pdf) on USB that has recommendations you should take into consideration in your designs.