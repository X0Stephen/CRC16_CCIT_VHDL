-- pkg_crc16_ccitt.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package pkg_crc16_ccitt is
    constant CRC_POLYNOMIAL : std_logic_vector(15 downto 0) := "1000100000010001"; -- 1021h -- x^16 + x^12 + x^5 + 1
    constant INITIAL_CRC_VALUE : std_logic_vector(15 downto 0) := "1111111111111111"; -- FFFFh
    function compute_crc(data_in: std_logic_vector(7 downto 0); current_crc: std_logic_vector(15 downto 0)) return std_logic_vector;
end package pkg_crc16_ccitt;

package body pkg_crc16_ccitt is
    function compute_crc(data_in: std_logic_vector(7 downto 0); current_crc: std_logic_vector(15 downto 0)) return std_logic_vector is
        variable crc_register : std_logic_vector(15 downto 0) := current_crc; -- Registre CRC actuel
    begin
        -- Traiter chaque bit des données d'entrée
        for i in 7 downto 0 loop
            -- Si le MSB du registre CRC XOR avec le bit de données actuel est '1', XOR avec le polynôme
            if (crc_register(15) xor data_in(i)) = '1' then
                crc_register := (crc_register(14 downto 0) & '0') xor CRC_POLYNOMIAL; -- Décalage à gauche et XOR avec le polynôme
            else
                crc_register := (crc_register(14 downto 0) & '0'); -- Décalage à gauche sans XOR
            end if;
        end loop;

        -- Retourner la valeur CRC calculée
        return crc_register;
    end function compute_crc;
end package body pkg_crc16_ccitt;
