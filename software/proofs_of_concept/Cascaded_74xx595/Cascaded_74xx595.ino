/**
 * @file    Cascaded_74xx595.ino
 * @project VersaLogic Board Tester
 * @brief   Proof of concept for the Cascaded 74xx595 (Arduino IDE - Arduino UNO)
 * @author  Filip Pynckels & Robin Pynckels
 * @version 1.0.alpha
 * @date    2025-09-03
 *
 * Description:
 *   This program tests two cascaded 74xx595 IC's and the Cascaded_74xx595
 *   class by shifting serial data in the first 74xx595. The parallel output
 *   can be tested with a logic analyzer or with a row of resistor-LED
 *   combinations.
 *
 *   Results of this program can be found in the corresponding hardware
 *   proof of concept directory.
 *
 *   UART communication goes via an USB-B cable.
 *
 * License:
 *   References the licenses used in:
 *   https://github.com/Pynckels/versalogic_board_tester
 *   Ensure compliance with the original license terms when redistributing or
 *   modifying.
 */

#include "Cascaded_74xx595.h"

/**
 * @brief Instance of Cascaded_74xx595 writing to multiple shift registers.
 * 
 * This object manages 2 cascaded 74xx595 shift registers.
 * 
 * @param 2  Number of shift registers in cascade.
 * @param 9  Data pin          (SER)   connected to the first shift register.
 * @param 12 Clock pin         (SRCLK) connected to the shift registers.
 * @param 11 Latch pin         (RCLK)  for updating outputs.
 * @param 10 Output Enable pin (OE)    (optional, if used in the library).
 * @param 13 Master Reset pin  (SRCLR) (optional, if used in the library).
 */
Cascaded_74xx595 regOut(2, 9, 12, 11, 10, 13);

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
    regOut.begin();
    regOut.enableOutput(true);                                        // make sure outputs are active
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
    for (int i=1; i<16; i++) {
        regOut.clear();
        regOut.setOutput(i, HIGH);
        regOut.update();
        delay(500);
    }

    for (int i=14; 0<=i; i--) {
        regOut.clear();
        regOut.setOutput(i, HIGH);
        regOut.update();
        delay(500);
    }
}
