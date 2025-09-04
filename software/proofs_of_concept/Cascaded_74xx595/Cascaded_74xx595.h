/**
 * @file    Cascaded_74xx595.h
 * @project VersaLogic Board Tester
 * @brief   Interface description of the Cascaded_74xx595 class
 * @author  Filip Pynckels & Robin Pynckels
 * @version 1.0.alpha
 * @date    2025-09-03
 *
 * Description:
 *   This class is the interface between the program logic and one or more
 *   cascaded 74xx595 shift out registers.
 *
 * License:
 *   References the licenses used in:
 *   https://github.com/Pynckels/versalogic_board_tester
 *   Ensure compliance with the original license terms when redistributing or
 *   modifying.
 */

#pragma once

#include <Arduino.h>


class Cascaded_74xx595
{

    public:

        /**
        * @brief Construct a new Cascaded_74xx595 object
        * @param numChips  Number of cascaded 74xx595 chips.
        * @param dataPin   Pin connected to SER (serial data input).
        * @param clockPin  Pin connected to SRCLK (shift register clock).
        * @param latchPin  Pin connected to RCLK (latch clock).
        * @param oePin     Pin connected to OE (output enable, active LOW). 
        *                  Pass 255 if not used (default).
        * @param srclrPin  Pin connected to SRCLR (shift register clear, active LOW).
        *                  Pass 255 if not used (default).
        */
        Cascaded_74xx595(uint8_t numChips, uint8_t dataPin, uint8_t clockPin, uint8_t latchPin, uint8_t oePin = 255, uint8_t srclrPin = 255);

        /**
        * @brief Initialize the pins (call this in setup()).
        */
        void begin();

        /**
        * @brief Clear all outputs (set to LOW).
        */
        void clear();

        /**
        * @brief Enable or disable the outputs (if OE pin is connected).
        * @param enable  true = outputs enabled, false = high impedance.
        */
        void enableOutput(bool enable);

        /**
        * @brief Hardware clear of the shift registers (if SRCLR pin is connected).
        */
        void hardwareClear();

        /**
        * @brief Set the value of a single output pin.
        * @param index  Index of the output (0 = first output of first chip).
        * @param value  HIGH or LOW.
        */
        void setOutput(uint16_t index, bool value);

        /**
        * @brief Commit the current state to the outputs (latch).
        */
        void update();

        /**
        * @brief Write raw byte data to the shift registers.
        * @param data   Pointer to byte array (size must match numChips).
        */
        void writeBytes(const uint8_t* data);

    private:
    
        uint8_t _numChips;

        uint8_t _dataPin;
        uint8_t _clockPin;
        uint8_t _latchPin;
        uint8_t _oePin;
        uint8_t _srclrPin;

        uint8_t* _buffer;                                           // internal shadow buffer
};
