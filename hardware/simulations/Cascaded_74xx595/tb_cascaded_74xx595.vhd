--! @file tb_cascaded_74xx595.vhd
--! @project 74xx595 Cascaded Testbench
--! @brief Testbench for two cascaded 74xx595 shift registers.
--! @author Filip Pynckels
--! @version 1.0.alpha
--! @date 2025-08-18
--!
--! @description
--!   This VHDL testbench simulates the functionality of two 74xx595 8-bit serial-in/parallel-out shift registers
--! connected in a cascaded configuration to form a single 16-bit register. The testbench performs the following steps:
--!     1. Initializes all input signals.
--!     2. Performs 16 shift cycles to serially load the data pattern x"AA55".
--!     3. Executes a parallel latch to update the outputs.
--!     4. Reports the progress of the shift and latch operations.
--!     5. Terminates the simulation after the data has been shifted and latched.
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
use ieee.numeric_std.all;
use std.env.all;

------------------------------------------------------------

entity tb_cascaded_74xx595 is                               -- The Testbench for the cascaded setup
end entity tb_cascaded_74xx595;

------------------------------------------------------------

architecture behavioral of tb_cascaded_74xx595 is

    component IC_74xx595 is                                 -- Component Declaration for the IC_74xx595
        port (
            SER         : in  std_logic;
            SRCLK       : in  std_logic;
            RCLK        : in  std_logic;
            SRCLR_n     : in  std_logic;
            OE_n        : in  std_logic;
            QA, QB, QC, QD, QE, QF, QG, QH : out std_logic;
            QH_prime    : out std_logic
        );
    end component;

    signal ser_sig      : std_logic := '0';                 -- Signals for the cascaded ICs
    signal srclk_sig    : std_logic := '0';
    signal rclk_sig     : std_logic := '0';
    signal srclr_n_sig  : std_logic := '1';
    signal oe_n_sig     : std_logic := '0';

    signal qh_prime_1_sig : std_logic;                      -- Serial output from the first IC
    signal qa1_sig        : std_logic;
    signal qb1_sig        : std_logic;
    signal qc1_sig        : std_logic;
    signal qd1_sig        : std_logic;
    signal qe1_sig        : std_logic;
    signal qf1_sig        : std_logic;
    signal qg1_sig        : std_logic;
    signal qh1_sig        : std_logic;

    signal qa2_sig        : std_logic;                      -- Serial output from the second IC
    signal qb2_sig        : std_logic;
    signal qc2_sig        : std_logic;
    signal qd2_sig        : std_logic;
    signal qe2_sig        : std_logic;
    signal qf2_sig        : std_logic;
    signal qg2_sig        : std_logic;
    signal qh2_sig        : std_logic;

    constant clk_period : time := 10 ns;                    -- Clock period definition
                                                            -- The data to be shifted in (16 bits)
    constant data_to_shift : std_logic_vector(15 downto 0) := x"AA55";

begin

    u1: IC_74xx595                                          -- Instantiate the first IC_74xx595
        port map (
            SER         => ser_sig,
            SRCLK       => srclk_sig,
            RCLK        => rclk_sig,
            SRCLR_n     => srclr_n_sig,
            OE_n        => oe_n_sig,
            QA          => qa1_sig,
            QB          => qb1_sig,
            QC          => qc1_sig,
            QD          => qd1_sig,
            QE          => qe1_sig,
            QF          => qf1_sig,
            QG          => qg1_sig,
            QH          => qh1_sig,
            QH_prime    => qh_prime_1_sig
        );
    u2: IC_74xx595                                          -- Instantiate the second IC_74xx595
        port map (
            SER         => qh_prime_1_sig,                  -- Cascading the registers
            SRCLK       => srclk_sig,
            RCLK        => rclk_sig,
            SRCLR_n     => srclr_n_sig,
            OE_n        => oe_n_sig,
            QA          => qa2_sig,
            QB          => qb2_sig,
            QC          => qc2_sig,
            QD          => qd2_sig,
            QE          => qe2_sig,
            QF          => qf2_sig,
            QG          => qg2_sig,
            QH          => qh2_sig,
            QH_prime    => open                             -- Output not used in this configuration
        );
    process                                                 -- SRCLK (Shift Register Clock) process
    begin
        srclk_sig <= '0';
        wait for clk_period/2;
        srclk_sig <= '1';
        wait for clk_period/2;
    end process;

    process                                                 -- Stimulus process
    begin

        ser_sig <= '0';                                     -- Initialize signals
        srclr_n_sig <= '1';
        oe_n_sig <= '0';

        wait for clk_period;

                                                            -- Shift in 16 bits of data
        report "Starting serial shift of data: " & to_string(data_to_shift) severity note;
        for i in 0 to 15 loop
            ser_sig <= data_to_shift(15 - i);
            wait until rising_edge(srclk_sig);
            report "Shift cycle " & integer'image(i + 1) & " of 16" severity note;
        end loop;

                                                            -- Latch the data to the outputs
        report "Latching data to parallel outputs." severity note;
        rclk_sig <= '1';
        wait for clk_period/2;
        rclk_sig <= '0';

        wait for clk_period * 2;

        report "Simulation finished." severity note;
        finish;

    end process;
end architecture behavioral;
