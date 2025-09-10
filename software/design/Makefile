###############################################################################
# @file    Makefile
# @project VersaLogic Board Tester
# @brief   Build system for AVR firmware project
# @author  Filip Pynckels & Robin Pynckels
# @version 1.0
# @date    2025-09-09
#
# Description:
#   This Makefile handles building, linking, and flashing the AVR firmware
#   for the VersaLogic Board Tester. Its responsibilities include:
#     1. Compiling C source files from src/ into object files in build/
#     2. Linking objects into a single ELF file
#     3. Generating a HEX file suitable for flashing
#     4. Uploading firmware via avrdude to the target microcontroller
#     5. Cleaning build artifacts
#
# Usage:
#   make          - builds firmware
#   make flash    - flashes firmware via avrdude
#   make clean    - removes build artifacts
#
# License:
#   References the licenses used in:
#   https://github.com/Pynckels/versalogic_board_tester
#   Ensure compliance with the original license terms when redistributing or
#   modifying.
###############################################################################

PROJECT         = versalogic_board_tester
VERSION         = 1.0
BUILD_DIR       = build
SRC_DIR         = src
INC_DIR         = include

# ------------------------------------------------------------------------------
# MCU settings
# ------------------------------------------------------------------------------
MCU             = atmega32
F_CPU           = 16000000UL
#MCU             = atmega328p
#F_CPU           = 16000000UL

# ------------------------------------------------------------------------------
# Toolchain commands
# ------------------------------------------------------------------------------
CC              = $(HOME)/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-gcc
OBJCOPY         = $(HOME)/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-objcopy
AVRDUDE         = $(HOME)/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/bin
AVRDUDE         = $(HOME)/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/bin/avrdude
AVRDUDE_CONF    = $(HOME)/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/etc/avrdude.conf

ARDUINO_CORE    = $(HOME)/.arduino15/packages/arduino/hardware/avr/1.8.6/cores/arduino
ARDUINO_VARIANT = $(HOME)/.arduino15/packages/arduino/hardware/avr/1.8.6/variants/standard

# ------------------------------------------------------------------------------
# Programmer settings (adjust to your setup)
#
#   AtMega with bootloader (programming via UART/serial):
#     PROGRAMMER = arduino        # Protocol for standard Arduino/AVR109 bootloaders
#     PORT       = /dev/ttyUSB0   # Serial port (use /dev/ttyUSB0, /dev/ttyS0, COMx, etc.)
#     BAUD       = 115200         # Must match the bootloader's baud rate
#
#   AtMega without bootloader (programming via ISP/SPI):
#     PROGRAMMER = usbasp         # USBasp programmer over ISP interface
#     PORT       =                # Leave empty for USB devices
#     BAUD       =                # Leave empty unless you need to override default speed
# ------------------------------------------------------------------------------
PROGRAMMER      = arduino
PORT            = /dev/ttyUSB0
BAUD            = 115200

# ------------------------------------------------------------------------------
# Compiler / Linker flags
# ------------------------------------------------------------------------------
CFLAGS          = -Wall -Wextra                 \
                  -mmcu=$(MCU) -DF_CPU=$(F_CPU) \
                  -Os                           \
                  -I$(INC_DIR)                  \
                  -I$(ARDUINO_CORE)             \
                  -I$(ARDUINO_VARIANT)

CSTD            = -std=c11
CXXSTD          = -std=gnu++11

COREFLAGS       = -w

LDFLAGS         = -mmcu=$(MCU)

# ------------------------------------------------------------------------------
# Source and object files
# ------------------------------------------------------------------------------

CORE_C_SRCS     = $(wildcard $(ARDUINO_CORE)/*.c)

CORE_CPP_SRCS   = $(wildcard $(ARDUINO_CORE)/*.cpp)

CORE_ASM_SRCS   = $(wildcard $(ARDUINO_CORE)/*.s) \
                  $(wildcard $(ARDUINO_CORE)/*.S)

CORE_OBJS       = $(patsubst $(ARDUINO_CORE)/%.c,$(BUILD_DIR)/core/%.o,$(CORE_C_SRCS))     \
                  $(patsubst $(ARDUINO_CORE)/%.cpp,$(BUILD_DIR)/core/%.o,$(CORE_CPP_SRCS)) \
                  $(patsubst $(ARDUINO_CORE)/%.s,$(BUILD_DIR)/core/%.o,$(CORE_ASM_SRCS))   \
                  $(patsubst $(ARDUINO_CORE)/%.S,$(BUILD_DIR)/core/%.o,$(CORE_ASM_SRCS))

SRCS            = $(shell find $(SRC_DIR) -name '*.c')   \
                  $(shell find $(SRC_DIR) -name '*.cpp') \
                  $(CORE_C_SRCS)                         \
                  $(CORE_CPP_SRCS)

OBJS            = $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(shell find $(SRC_DIR) -name '*.c'))     \
                  $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(shell find $(SRC_DIR) -name '*.cpp')) \
                  $(CORE_OBJS)

# ------------------------------------------------------------------------------
# Default target
# ------------------------------------------------------------------------------
all: $(BUILD_DIR)/$(PROJECT)_$(VERSION).hex

# ------------------------------------------------------------------------------
# Creating HEX file
# ------------------------------------------------------------------------------
$(BUILD_DIR)/$(PROJECT)_$(VERSION).hex: $(BUILD_DIR)/$(PROJECT)_$(VERSION).elf
	@echo "[HEX ] $@"
	@$(OBJCOPY) -O ihex -R .eeprom $< $@

# ------------------------------------------------------------------------------
# Linking
# ------------------------------------------------------------------------------
$(BUILD_DIR)/$(PROJECT)_$(VERSION).elf: $(OBJS)
	@echo "[LINK] $@"
	@mkdir -p $(dir $@)
	@$(CC) $(LDFLAGS) $^ -o $@

# ------------------------------------------------------------------------------
# Compiling C source
# ------------------------------------------------------------------------------
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "[COMP] $<"
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) $(CSTD) -c $< -o $@

# ------------------------------------------------------------------------------
# Compiling C++ source
# ------------------------------------------------------------------------------
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@echo "[C++ ] $<"
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -x c++ $(CXXSTD) -c $< -o $@

# ------------------------------------------------------------------------------
# Compiling Arduino core
# ------------------------------------------------------------------------------
$(BUILD_DIR)/core/%.o: $(ARDUINO_CORE)/%.c
	@echo "[CORE] $<"
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) $(CSTD) $(COREFLAGS) -c $< -o $@

$(BUILD_DIR)/core/%.o: $(ARDUINO_CORE)/%.cpp
	@echo "[CORE] $<"
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -x c++ $(CXXSTD) $(COREFLAGS) -c $< -o $@

$(BUILD_DIR)/core/%.o: $(ARDUINO_CORE)/%.S
	@echo "[CORE] $<"
	@mkdir -p $(dir $@)
	@$(CC) -c $< -o $@

# ------------------------------------------------------------------------------
# Flash target
# ------------------------------------------------------------------------------
flash: $(BUILD_DIR)/$(PROJECT)_$(VERSION).hex
	@echo "[FLSH] $<"
	@$(AVRDUDE)            \
        -C $(AVRDUDE_CONF) \
        -c $(PROGRAMMER)   \
        -p $(MCU)          \
        $(PORT:%=-P %)     \
        $(BAUD:%=-b %)     \
		-U flash:w:$<:i

# ------------------------------------------------------------------------------
# Clean target
# ------------------------------------------------------------------------------
clean:
	@echo "[CLN ] "
	@rm -rf $(BUILD_DIR)

# ------------------------------------------------------------------------------
.PHONY: all flash clean
