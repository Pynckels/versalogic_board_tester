/*
 * @file    Cascaded_74xx165.cpp
 * @project VersaLogic Board Tester
 * @brief   Code for the Cascaded_74xx165 class
 * @author  Filip Pynckels & Robin Pynckels
 * @version 1.0
 * @date    2025-09-09
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

#include "Cascaded_74xx165.h"


Cascaded_74xx165::Cascaded_74xx165(uint8_t numChips, uint8_t dataPin, uint8_t clockPin, uint8_t clockInhPin, uint8_t loadPin)
{
    _numChips    = numChips;
    _dataPin     = dataPin;
    _clockPin    = clockPin;
    _clockInhPin = clockInhPin;
    _loadPin     = loadPin;

    _buffer = new uint8_t[_numChips];
}


void Cascaded_74xx165::begin()
{
    pinMode(_loadPin, OUTPUT);
    pinMode(_clockPin, OUTPUT);
    pinMode(_clockInhPin, OUTPUT);
    pinMode(_dataPin, INPUT);

    digitalWrite(_loadPin, HIGH);
    digitalWrite(_clockPin, LOW);
    digitalWrite(_clockInhPin, HIGH);
}


void Cascaded_74xx165::readInputs()
{
    digitalWrite(_loadPin, LOW);                                    // Latch parallel inputs
    delayMicroseconds(5);
    digitalWrite(_loadPin, HIGH);
    delayMicroseconds(5);

    digitalWrite(_clockPin, HIGH);
    digitalWrite(_clockInhPin, LOW);                                // Enable shifting

    for (int8_t reg=_numChips-1; 0<=reg; reg--) {
        _buffer[reg] = shiftIn(_dataPin, _clockPin, MSBFIRST);
    }

    digitalWrite(_clockInhPin, HIGH);                               // Disable shifting
}


uint8_t Cascaded_74xx165::getBit(uint16_t index) const
{
    uint8_t regIndex = index / 8;
    uint8_t bitIndex = index % 8;
    if (_numChips <= regIndex) return 0;                            // Wrong index value
    return (_buffer[regIndex] >> bitIndex) & 0x01;
}


uint8_t Cascaded_74xx165::getByte(uint8_t regIndex) const
{
    if (_numChips <= regIndex) return 0;                            // Wrong index value
    return _buffer[regIndex];
}
