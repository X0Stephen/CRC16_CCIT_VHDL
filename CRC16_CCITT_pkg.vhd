library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package CRC16_CCITT_pkg is

    -- Define the CRC polynomial for CCITT
    constant CRC_POLYNOMIAL : std_logic_vector(15 downto 0) := "1000100000010001";

    -- Procedure to calculate CRC16 CCITT
    procedure calculate_CRC16_CCITT(
        data_in : in std_logic_vector(7 downto 0);
        crc_out : out std_logic_vector(15 downto 0)
    );

end package CRC16_CCITT_pkg;

package body CRC16_CCITT_pkg is

    procedure calculate_CRC16_CCITT(
        data_in : in std_logic_vector(7 downto 0);
        crc_out : out std_logic_vector(15 downto 0)
    ) is
        variable crc_register : std_logic_vector(15 downto 0) := (others => '0');
        variable data_with_crc : std_logic_vector(23 downto 0);
    begin
        -- Append the data with 16 bits of CRC value
        data_with_crc := data_in & crc_register;

        -- Perform CRC calculation
        for i in 0 to 7 loop
            if data_with_crc(23) = '1' then
                data_with_crc := data_with_crc xor CRC_POLYNOMIAL;
            end if;
            data_with_crc := data_with_crc sll 1;
        end loop;

        -- Extract the computed CRC value
        crc_out <= data_with_crc(15 downto 0);
    end procedure calculate_CRC16_CCITT;

end package body CRC16_CCITT_pkg;
