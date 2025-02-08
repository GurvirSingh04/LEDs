# LEDs Project

This repository contains code for controlling LEDs using an AVR microcontroller. The project demonstrates basic LED blinking, pattern generation, and interactive LED control using buttons.

## Features
- Simple LED blinking
- LED patterns with delay control
- Button-controlled LED interaction
- Uses AVR assembly for efficient execution

## Prerequisites
- AVR microcontroller (e.g., ATmega series)
- AVR toolchain (AVR-GCC, AVRDUDE)
- Breadboard and LEDs
- Push buttons (for interactive modes)
- USBasp or another AVR programmer

## Installation
1. Clone this repository:
   ```sh
   git clone https://github.com/GurvirSingh04/LEDs.git
   cd LEDs
   ```
2. Install AVR toolchain if not already installed:
   ```sh
   sudo apt install gcc-avr avr-libc avrdude
   ```

## Usage
1. Compile the code using the AVR assembler:
   ```sh
   avr-gcc -mmcu=atmega328p -o leds.elf leds.s
   ```
2. Convert to HEX file:
   ```sh
   avr-objcopy -O ihex leds.elf leds.hex
   ```
3. Flash the HEX file to the microcontroller:
   ```sh
   avrdude -c usbasp -p m328p -U flash:w:leds.hex:i
   ```

## File Structure
- `leds.s` - Assembly code for LED control
- `Makefile` (if present) - Automates the build process
- `README.md` - Documentation for the project

## How It Works
- The program configures an AVR microcontroller’s GPIO pins as output.
- Implements simple loops and timers to control LED blinking patterns.
- Uses input from push buttons (if applicable) to change LED states dynamically.
