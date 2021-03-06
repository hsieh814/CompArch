library ieee;
use ieee.std_logic_1164.ALL;
use work.MIPSCPU_constants.ALL;
use ieee.numeric_std.ALL;

entity programCounter is
port(
	clk : IN STD_LOGIC;
	reset : IN STD_LOGIC;
	writeEnable : IN STD_LOGIC; -- high signifies writing to pc is enabled
	PCReady : OUT STD_LOGIC := '0'; --high signifies PC is ready to be updated
	PCIn : IN integer := 0;
	PCOut : OUT integer := 0
);
end programCounter;

--program counter provides a buffer between next address and the instruction fetcher
architecture BEHV of programCounter is
begin
	process(clk,reset)
	variable currentPC : integer := 0;
	begin
		if reset = '1' then
			currentPC := 0;
		elsif RISING_EDGE(clk) then 
			if writeEnable = '1' then
				currentPC := PCIn;
				PCReady<='1';
			else PCReady<='0';
			end if;
		end if;
		PCOut <= currentPC;
	end process;
end behv;