--! @file IC_74xx595.vhd
--! @project 74xx595 VHDL Model
--! @brief Behavioral model of the 74xx595 Serial-In, Parallel-Out Shift Register with Storage Register.
--! @author Filip Pynckels
--! @version 1.0.alpha
--! @date 2025-08-18
--!
--! @description
--!
--! This VHDL code provides a behavioral description of the 74xx595 IC. It includes
--! a shift register and a storage register, allowing for serial data input and
--! parallel data output.
--!
--! Key features of this model:
--!     - **Serial Shift (SRCLK rising edge):** On the rising edge of the Shift Register Clock (SRCLK), data from the SER input is shifted into the 8-bit shift register.
--!     - **Parallel Latch (RCLK rising edge):** On the rising edge of the Storage Register Clock (RCLK), the data from the shift register is copied to the storage register, which drives the parallel outputs (QA through QH).
--!     - **Output Enable (OE_n = '0'):** The parallel outputs are enabled when the Output Enable signal is low.
--!     - **Master Reset (SRCLR_n = '0'):** An active-low reset that clears the shift register.
--!     - **Serial Output (QH_prime):** The output QH' is the serial data output from the shift register.
--!
--! Note that the code is written to be explicit concerning the use of each pin.
--! Hence no data busses are used but rather the individual pin names.
--!
--! @license
--!
--! This code is provided for educational and illustrative purposes.
--! Use, modification, and distribution are permitted.
--!
--! There are no specific licenses referenced.
--! Refer to the VHDL standard (IEEE 1076) for language-related licenses.

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------

entity IC_74xx595 is                                        -- Define the entity for the 74xx595 component
    port (
        SER         : in  std_logic;                        -- Serial Data Input
        SRCLK       : in  std_logic;                        -- Control Signals
        RCLK        : in  std_logic;
        SRCLR_n     : in  std_logic;
        OE_n        : in  std_logic;
                                                            -- Parallel Data Outputs
        QA, QB, QC, QD, QE, QF, QG, QH : out std_logic;

        QH_prime    : out std_logic                         -- Serial Output from Shift Register
    );
end entity IC_74xx595;

------------------------------------------------------------

architecture behavioral of IC_74xx595 is

    signal shift_reg   : std_logic_vector(7 downto 0);      -- Internal shift register
    signal storage_reg : std_logic_vector(7 downto 0);      -- Internal storage register

begin

    process (SRCLK, SRCLR_n)                                -- Shift Register Process
    begin
        if SRCLR_n = '0' then
            shift_reg <= (others => '0');                   -- Master Reset
        elsif rising_edge(SRCLK) then
            shift_reg <= shift_reg(6 downto 0) & SER;       -- Shift data
        end if;
    end process;

    process (RCLK)                                          -- Storage Register Process
    begin
        if rising_edge(RCLK) then
            storage_reg <= shift_reg;                       -- Latch data from shift register
        end if;
    end process;

    QA <= storage_reg(0) when OE_n = '0' else 'Z';          -- Assign Outputs
    QB <= storage_reg(1) when OE_n = '0' else 'Z';
    QC <= storage_reg(2) when OE_n = '0' else 'Z';
    QD <= storage_reg(3) when OE_n = '0' else 'Z';
    QE <= storage_reg(4) when OE_n = '0' else 'Z';
    QF <= storage_reg(5) when OE_n = '0' else 'Z';
    QG <= storage_reg(6) when OE_n = '0' else 'Z';
    QH <= storage_reg(7) when OE_n = '0' else 'Z';

    QH_prime <= shift_reg(7);

end architecture behavioral;
