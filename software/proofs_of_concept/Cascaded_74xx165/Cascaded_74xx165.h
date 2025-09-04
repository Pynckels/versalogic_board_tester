/**
 * @file    Cascaded_74xx165.h
 * @project VersaLogic Board Tester
 * @brief   Interface description of the Cascaded_74xx165 class
 * @author  Filip Pynckels & Robin Pynckels
 * @version 1.0.alpha
 * @date    2025-09-03
 *
 * Description:
 *   This class is the interface between the program logic and one or more
 *   cascaded 74xx165 shift in registers.
 *
 * License:
 *   References the licenses used in:
 *   https://github.com/Pynckels/versalogic_board_tester
 *   Ensure compliance with the original license terms when redistributing or
 *   modifying.
 */

#pragma once

#include <Arduino.h>


class Cascaded_74xx165
{

    public:

        /**
        * @brief Constructor
        * @param numChips Number of cascaded 74xx165 chips.
        * @param dataPin Pin connected to QH.
        * @param clockPin Pin connected to CLK.
        * @param clockInhPin Pin connected to CLK_INH.
        * @param loadPin Pin connected to SH/~LD (latch).
        */
        Cascaded_74xx165(uint8_t numChips, uint8_t dataPin, uint8_t clockPin, uint8_t clockInhPin, uint8_t loadPin);

        /**
        * @brief Initialize the pins (call this in setup()).
        */
        void begin();

        /**
        * @brief Get the state of a single bit.
        * @param index  Bit index (0 = first bit of first register).
        * @return HIGH or LOW.
        */
        uint8_t getBit(uint16_t index) const;

        /**
        * @brief Get the state of a full register.
        * @param regIndex  Register index (0 = first).
        * @return Byte containing register inputs.
        */
        uint8_t getByte(uint8_t regIndex) const;

        /**
        * @brief Latch and read all inputs into the internal buffer.
        */
        void readInputs();

    private:

        uint8_t _numChips;

        uint8_t _dataPin;    
        uint8_t _clockPin;
        uint8_t _clockInhPin;
        uint8_t _loadPin;

        uint8_t* _buffer;                                           // internal shadow buffer
};

