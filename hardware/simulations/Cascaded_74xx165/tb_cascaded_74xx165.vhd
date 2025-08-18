--! @file tb_cascaded_74xx165.vhd
--! @project 74xx165 Cascaded Testbench
--! @brief Testbench for two cascaded 74xx165 shift registers.
--! @author Filip Pynckels
--! @version 1.0.alpha
--! @date 2025-08-18
--!
--! @description
--!   This VHDL testbench simulates the functionality of two 74xx165 8-bit parallel-in/serial-out shift registers
--!   connected in a cascaded configuration to form a single 16-bit register. The testbench performs the following steps:
--!     1. Initializes all input signals.
--!     2. Performs a parallel load of two distinct 8-bit data patterns (x"AA" and x"55") into the two registers.
--!     3. Switches to shift mode.
--!     4. Executes 16 shift cycles, serially shifting out the combined 16-bit data.
--!     5. Reports the progress of the shift operation.
--!     6. Terminates the simulation after the data has been shifted out.
--!   Note that the code is written to be explicit concerning the use of each pin. Hence no data busses are used but rather the individual pin names.
--!
--! @license
--!   This code is provided for educational and illustrative purposes.
--!   Use, modification, and distribution are permitted.
--!   There are no specific licenses referenced.
--!   Refer to the VHDL standard (IEEE 1076) for language-related licenses.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;

------------------------------------------------------------

entity tb_cascaded_74xx165 is                               -- The Testbench for the cascaded setup
end entity tb_cascaded_74xx165;

------------------------------------------------------------

architecture behavioral of tb_cascaded_74xx165 is

    component IC_74xx165 is                                 -- Component Declaration for the IC_74xx165
        port (
            A, B, C, D, E, F, G, H : in  std_logic;
            CLK                    : in  std_logic;
            SH_LD_n                : in  std_logic;
            CLK_INH_n              : in  std_logic;
            SER                    : in  std_logic;
            QH                     : out std_logic;
            QH_n                   : out std_logic
        );
    end component;

    signal a1_sig       : std_logic := '0';                 -- Signals for the first IC_74xx165
    signal b1_sig       : std_logic := '0';
    signal c1_sig       : std_logic := '0';
    signal d1_sig       : std_logic := '0';
    signal e1_sig       : std_logic := '0';
    signal f1_sig       : std_logic := '0';
    signal g1_sig       : std_logic := '0';
    signal h1_sig       : std_logic := '0';
    signal clk_sig      : std_logic := '0';
    signal sh_ld_n_sig  : std_logic := '1';
    signal clk_inh_n_sig: std_logic := '0';
    signal ser_in_1_sig : std_logic := '0';
    signal qh_1_sig     : std_logic;
    signal qh_n_1_sig   : std_logic;

    signal a2_sig       : std_logic := '0';                 -- Signals for the second IC_74xx165
    signal b2_sig       : std_logic := '0';
    signal c2_sig       : std_logic := '0';
    signal d2_sig       : std_logic := '0';
    signal e2_sig       : std_logic := '0';
    signal f2_sig       : std_logic := '0';
    signal g2_sig       : std_logic := '0';
    signal h2_sig       : std_logic := '0';
    signal ser_in_2_sig : std_logic := '0';                 -- Not used
    signal qh_2_sig     : std_logic;
    signal qh_n_2_sig   : std_logic;

    constant clk_period : time := 10 ns;                    -- Clock period definition

begin

    u1: IC_74xx165                                          -- Instantiate the first IC_74xx165
        port map (
            A         => a1_sig,
            B         => b1_sig,
            C         => c1_sig,
            D         => d1_sig,
            E         => e1_sig,
            F         => f1_sig,
            G         => g1_sig,
            H         => h1_sig,
            CLK       => clk_sig,
            SH_LD_n   => sh_ld_n_sig,
            CLK_INH_n => clk_inh_n_sig,
            SER       => ser_in_1_sig,
            QH        => qh_1_sig,
            QH_n      => qh_n_1_sig
        );

    u2: IC_74xx165                                          -- Instantiate the second IC_74xx165
        port map (
            A         => a2_sig,
            B         => b2_sig,
            C         => c2_sig,
            D         => d2_sig,
            E         => e2_sig,
            F         => f2_sig,
            G         => g2_sig,
            H         => h2_sig,
            CLK       => clk_sig,
            SH_LD_n   => sh_ld_n_sig,
            CLK_INH_n => clk_inh_n_sig,
            SER       => qh_1_sig,                          -- Cascading the registers
            QH        => qh_2_sig,
            QH_n      => qh_n_2_sig
        );


    process                                                 -- Clock process
    begin
        clk_sig <= '0';
        wait for clk_period/2;
        clk_sig <= '1';
        wait for clk_period/2;
    end process;


    process                                                 -- Stimulus process
                                                            -- Use std_logic_vector for easier data assignment
        variable data_in_1_vector : std_logic_vector(7 downto 0);
        variable data_in_2_vector : std_logic_vector(7 downto 0);

    begin

        sh_ld_n_sig   <= '1';                               -- Initialize signals
        ser_in_1_sig  <= '0';
        ser_in_2_sig  <= '0';                               -- Not used

        wait for 2 * clk_period;

        sh_ld_n_sig      <= '0';                            -- Parallel Load
        data_in_1_vector := x"AA";                          -- 1010 1010
        data_in_2_vector := x"55";                          -- 0101 0101

        h1_sig <= data_in_1_vector(7);                      -- Assign the vectors to individual signals
        g1_sig <= data_in_1_vector(6);
        f1_sig <= data_in_1_vector(5);
        e1_sig <= data_in_1_vector(4);
        d1_sig <= data_in_1_vector(3);
        c1_sig <= data_in_1_vector(2);
        b1_sig <= data_in_1_vector(1);
        a1_sig <= data_in_1_vector(0);

        h2_sig <= data_in_2_vector(7);
        g2_sig <= data_in_2_vector(6);
        f2_sig <= data_in_2_vector(5);
        e2_sig <= data_in_2_vector(4);
        d2_sig <= data_in_2_vector(3);
        c2_sig <= data_in_2_vector(2);
        b2_sig <= data_in_2_vector(1);
        a2_sig <= data_in_2_vector(0);

        wait for clk_period;
        
        sh_ld_n_sig <= '1';                                 -- Shift Mode
        wait for clk_period;

        for i in 1 to 16 loop                               -- Perform 16 shifts
            wait until rising_edge(clk_sig);
            report "Shift cycle " & integer'image(i) & " of 16" severity note;
        end loop;

        wait for clk_period * 2;                            -- Wait for final results
        
        report "Simulation finished." severity note;        -- Terminate the simulation
        finish;

    end process;
end architecture behavioral;
