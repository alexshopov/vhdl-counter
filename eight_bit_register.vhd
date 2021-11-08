library ieee;
use ieee.std_logic_1164.all;

entity reg8 is
  port (clk, clear: in std_ulogic;
        d: in std_ulogic_vector (7 downto 0);
        q: out std_ulogic_vector (7 downto 0));
end reg8;

architecture dataflow of reg8 is
begin
  regstd_behavior: process (clear, clk) is
  begin	 
  	 if clear = '1' then
	   q <= "00000000";
	elsif clk'event and clk = '1' then
		q <= d;
	end if;
  end process regstd_behavior;
end dataflow;  


