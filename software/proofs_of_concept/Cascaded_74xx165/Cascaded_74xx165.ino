/**
 * @file    Cascaded_74xx165.ino
 * @project VersaLogic Board Tester
 * @brief   Proof of concept for the Cascaded 74xx165 (Arduino IDE - Arduino UNO)
 * @author  Filip Pynckels & Robin Pynckels
 * @version 1.0.alpha
 * @date    2025-09-03
 *
 * Description:
 *   This program tests two cascaded 74xx165 IC's and the Cascaded_74xx165
 *   class by regIng serial data out of the last 74xx165. The parallel input
 *   is set with jumper wires on the breadboard. The serial output is visualized
 *   by this program.
 *
 *   UART communication goes via an USB-B cable.
 *
 * License:
 *   References the licenses used in:
 *   https://github.com/Pynckels/versalogic_board_tester
 *   Ensure compliance with the original license terms when redistributing or
 *   modifying.
 */

#include "Cascaded_74xx165.h"

/**
 * @brief Instance of Cascaded_74xx165 reading multiple shift registers.
 * 
 * This object manages 2 cascaded 74xx165 shift registers.
 * 
 * @param 2   Number of shift registers in cascade.
 * @param 13  Data pin      (QH)      connected to the first shift register.
 * @param 11  Clock pin     (CLK)     used for regIng data.
 * @param 12  Clock Inhibit (CLK_INH) used to enable/disable regIng.
 * @param 10  Load pin      (SH/~LD)  for latching parallel inputs.
 */
Cascaded_74xx165 regIn(2, 13, 11, 12, 10);

/**
 * @brief  Print a byte as 8 bits
 *
 * The byte will be printed from most significant bit to least
 * significant bit. Then one trailing space will be printed.
 *
 * @param  b  byte to print
 * @retval none
 */

void printByte(uint8_t b)
{
    for (int i=0;i<8;i++)
        Serial.print ("01" [bitRead(b,7-i)]);
    Serial.print(" ");
}

/**
 * @brief  Setup entry point of the program.
 *
 * Initializes hardware peripherals and global variables/classes.
 *
 * @param  none
 * @retval none
 */

void setup()
{
    Serial.begin(115200);
    regIn.begin();
}

/**
 * @brief  Main program loop of the program.
 *
 * Executes the main program logic.
 *
 * @param  none
 * @retval none
 *
 * @note   The logic in this function must yield regularly to give the
 *         underlaying code a chance to execute.
 */

void loop()
{
    uint8_t val;

    regIn.readInputs();

    for (uint8_t r = 0; r < 2; r++)
    {
        val = regIn.getByte(r);
        printByte(val);
    }
    Serial.println();

    while (Serial.available() == 0) {}
    while (Serial.available()) Serial.read();
}
