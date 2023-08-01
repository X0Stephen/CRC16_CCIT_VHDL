library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CRC16_CCITT_TB is
end CRC16_CCITT_TB;

architecture Behavioral of CRC16_CCITT_TB is
    signal output_enable_tb : std_logic;
    signal data_in_tb : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_out_tb : std_logic_vector(15 downto 0);
    
    -- Constants for expected CRC values
    constant CRC_EXPECTED_1 : std_logic_vector(15 downto 0) := "0000000000000000";
    constant CRC_EXPECTED_2 : std_logic_vector(15 downto 0) := "0000000000000000";
    constant CRC_EXPECTED_3 : std_logic_vector(15 downto 0) := "0000000000000000";
    constant CRC_EXPECTED_4 : std_logic_vector(15 downto 0) := "0000000000000000";
    constant CRC_EXPECTED_5 : std_logic_vector(15 downto 0) := "0000000000000000";
    
    -- Function to convert std_logic_vector to a string
    function std_logic_vector_to_string(v: std_logic_vector) return string is
        variable str : string(1 to v'length);
    begin
        for i in v'range loop
            str(v'length - i) := std_logic'image(v(i))(2); -- extracts the second character of the image result
        end loop;
        return str;
    end function;
    
begin
    -- Instantiate the DUT (Design Under Test)
    DUT : entity work.CRC16_CCITT
    port map (
        output_enable => output_enable_tb,
        data_in => data_in_tb,
        crc_out => crc_out_tb
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial state 
        output_enable_tb <= '0';
        wait for 10 ns; 

        -- Test 1: 01010101
        output_enable_tb <= '1';
        data_in_tb <= "01010101";
        wait for 5 ns;
        assert crc_out_tb = CRC_EXPECTED_1
            report "Test 1 failed! Expected CRC: " & std_logic_vector_to_string(CRC_EXPECTED_1) & ", Computed CRC: " & std_logic_vector_to_string(crc_out_tb)
            severity error;
        wait for 5 ns;

        -- Test 2: 11001100
        data_in_tb <= "11001100";
        wait for 5 ns;
        assert crc_out_tb = CRC_EXPECTED_2
            report "Test 2 failed! Expected CRC: " & std_logic_vector_to_string(CRC_EXPECTED_2) & ", Computed CRC: " & std_logic_vector_to_string(crc_out_tb)
            severity error;

        -- Test 3: 10011001
        data_in_tb <= "10011001";
        wait for 5 ns;
        assert crc_out_tb = CRC_EXPECTED_3
            report "Test 3 failed! Expected CRC: " & std_logic_vector_to_string(CRC_EXPECTED_3) & ", Computed CRC: " & std_logic_vector_to_string(crc_out_tb)
            severity error;

        -- Test 4: 00000000
        data_in_tb <= "00000000";
        wait for 5 ns;
        assert crc_out_tb = CRC_EXPECTED_4
            report "Test 4 failed! Expected CRC: " & std_logic_vector_to_string(CRC_EXPECTED_4) & ", Computed CRC: " & std_logic_vector_to_string(crc_out_tb)
            severity error;

        -- Test 5: 10101010
        data_in_tb <= "10101010";
        wait for 5 ns;
        assert crc_out_tb = CRC_EXPECTED_5
            report "Test 5 failed! Expected CRC: " & std_logic_vector_to_string(CRC_EXPECTED_5) & ", Computed CRC: " & std_logic_vector_to_string(crc_out_tb)
            severity error;

        -- End the simulation
        wait;
    end process stim_proc;
end Behavioral;
