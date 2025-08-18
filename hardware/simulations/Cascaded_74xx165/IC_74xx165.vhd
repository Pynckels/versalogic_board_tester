--! @file IC_74xx165.vhd
--! @project 74xx165 VHDL Model
--! @brief Behavioral model of the 74xx165 Parallel-Load, 8-bit Serial-Out Shift Register.
--! @author Filip Pynckels
--! @version 1.0.alpha
--! @date 2025-08-18
--!
--! @description
--!   This VHDL code provides a behavioral description of the 74xx165 IC. It includes both
--!   asynchronous parallel load and synchronous serial shift operations.
--!   Key features of this model:
--!     - **Parallel Load (SH_LD_n = '0'):** The 8-bit parallel data from inputs A through H is loaded into the internal register. This operation is asynchronous.
--!     - **Serial Shift (SH_LD_n = '1' and CLK_INH_n = '0'):** On the rising edge of the clock (CLK), the data in the register is shifted one bit to the right. The new bit is loaded from the SER input.
--!     - **Clock Inhibit (CLK_INH_n = '1'):** When the clock inhibit signal is low, the clock is disabled, and no shifting occurs.
--!     - **Outputs (QH, QH_n):** The output QH provides the data from the most significant bit (MSB) of the internal register, with QH_n being its inverted counterpart.
--!   Note that the code is written to be explicit concerning the use of each pin. Hence no data busses are used but rather the individual pin names.
--!
--! @license
--!   This code is provided for educational and illustrative purposes.
--!   Use, modification, and distribution are permitted.
--!   There are no specific licenses referenced.
--!   Refer to the VHDL standard (IEEE 1076) for language-related licenses.

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------

entity IC_74xx165 is                                        -- Define the entity for the 74xx165 component
    port (
        A, B, C, D, E, F, G, H : in  std_logic;             -- Parallel Data Inputs

        CLK                    : in  std_logic;             -- Control Signals
        SH_LD_n                : in  std_logic;
        CLK_INH_n              : in  std_logic;
        SER                    : in  std_logic;

        QH                     : out std_logic;             -- Serial Outputs
        QH_n                   : out std_logic
    );
end entity IC_74xx165;

------------------------------------------------------------

architecture behavioral of IC_74xx165 is                    -- Define the behavioral architecture

    signal reg_data : std_logic_vector(7 downto 0);         -- Internal register to hold the data

begin

    process(CLK, SH_LD_n)                                   -- Load/Shift logic
    begin
        if SH_LD_n = '0' then                               -- Parallel Load (asynchronous)
            reg_data <= H & G & F & E & D & C & B & A;
        elsif rising_edge(CLK) and CLK_INH_n = '0' then     -- Serial Shift (synchronous)
            reg_data <= reg_data(6 downto 0) & SER;
        end if;
    end process;

    QH   <= reg_data(7);                                    -- Assign outputs
    QH_n <= not reg_data(7);

end architecture behavioral;
