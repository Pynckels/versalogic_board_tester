/*
 * file    Cascaded_74xx595.cpp
 * project VersaLogic Board Tester
 * brief   Code for the Cascaded_74xx595 class
 * author  Filip Pynckels & Robin Pynckels
 * version 1.0.alpha
 * date    2025-09-03
 *
 * Description:
 *   This class is the interface between the program logic and one or more
 *   cascaded 74xx595 shift registers.
 *
 * License:
 *   References the licenses used in:
 *   https://github.com/Pynckels/versalogic_board_tester
 *   Ensure compliance with the original license terms when redistributing or
 *   modifying.
 */

#include "Cascaded_74xx595.h"


Cascaded_74xx595::Cascaded_74xx595(uint8_t numChips, uint8_t dataPin, uint8_t clockPin, uint8_t latchPin, uint8_t oePin = 255, uint8_t srclrPin = 255)
{
    _numChips = numChips;
    _dataPin  = dataPin;
    _clockPin = clockPin;
    _latchPin = latchPin;
    _oePin    = oePin;
    _srclrPin = srclrPin;

    _buffer = new uint8_t[_numChips]();
}


void Cascaded_74xx595::begin()
{
    pinMode(_dataPin, OUTPUT);
    pinMode(_clockPin, OUTPUT);
    pinMode(_latchPin, OUTPUT);

    if (_oePin != 255) {
        pinMode(_oePin, OUTPUT);
        digitalWrite(_oePin, LOW);                                  // enable outputs by default
    }

    if (_srclrPin != 255) {
        pinMode(_srclrPin, OUTPUT);
        digitalWrite(_srclrPin, HIGH);                              // normal operation (not clearing)
    }

    clear();
}


void Cascaded_74xx595::clear()
{
    for (uint8_t i = 0; i < _numChips; i++) {
        _buffer[i] = 0;
    }
    update();
}


void Cascaded_74xx595::enableOutput(bool enable)
{
    if (_oePin == 255) return;                                      // not connected
    digitalWrite(_oePin, enable ? LOW : HIGH);                      // OE is active LOW
}


void Cascaded_74xx595::hardwareClear()
{
    if (_srclrPin == 255) return;                                   // not connected
    digitalWrite(_srclrPin, LOW);                                   // clear shift registers
    delayMicroseconds(1);                                           // tiny pulse
    digitalWrite(_srclrPin, HIGH);                                  // back to normal operation
    clear();                                                        // also reset buffer
}


void Cascaded_74xx595::setOutput(uint16_t index, bool value)
{
    if (index >= (_numChips * 8)) return;                           // out of range
    uint8_t chip = index / 8;
    uint8_t bit  = index % 8;
    if (value)
        _buffer[chip] |= (1 << bit);
    else
        _buffer[chip] &= ~(1 << bit);
}


void Cascaded_74xx595::update()
{
    digitalWrite(_latchPin, LOW);
    for (int8_t i = _numChips - 1; i >= 0; i--) {                   // Shift out from last to first chip
        shiftOut(_dataPin, _clockPin, MSBFIRST, _buffer[i]);
    }
    digitalWrite(_latchPin, HIGH);
}


void Cascaded_74xx595::writeBytes(const uint8_t* data)
{
    for (uint8_t i = 0; i < _numChips; i++) {
        _buffer[i] = data[i];
    }
}
