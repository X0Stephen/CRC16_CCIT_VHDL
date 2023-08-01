-- pkg_crc16_ccitt.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package pkg_crc16_ccitt is
    constant CRC_POLYNOMIAL : std_logic_vector(15 downto 0) := "1000100000010001"; -- x^16 + x^12 + x^5 + 1
    function compute_crc(data_in: std_logic_vector(7 downto 0)) return std_logic_vector;
end package pkg_crc16_ccitt;

package body pkg_crc16_ccitt is
    function compute_crc(data_in: std_logic_vector(7 downto 0)) return std_logic_vector is
        variable crc_register : std_logic_vector(15 downto 0) := (others => '0');
        variable data_with_crc : std_logic_vector(23 downto 0);
    begin
        -- Append the data with 16 bits of CRC value
        data_with_crc := data_in & crc_register;

        -- Perform CRC calculation
        for i in 0 to 7 loop
            if data_with_crc(23) = '1' then
                data_with_crc := data_with_crc xor (CRC_POLYNOMIAL & "0000000000000000");
            end if;
            data_with_crc := data_with_crc(22 downto 0) & '0'; -- Shift one bit to the left
        end loop;

        -- Extract the computed CRC value
        return data_with_crc(15 downto 0);
    end function compute_crc;
end package body pkg_crc16_ccitt;
