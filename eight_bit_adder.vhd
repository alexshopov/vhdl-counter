library ieee;
use ieee.std_logic_1164.all;

entity eight_bit_adder is
  port (
    a, b: in std_ulogic_vector (7 downto 0);
    c_in: in std_ulogic;
    sum: out std_ulogic_vector (7 downto 0);
    c_out : out std_ulogic);
end entity eight_bit_adder;

architecture dataflow of eight_bit_adder is
  component full_adder is
    port (
      a, b, c_in : in std_ulogic;
      sum, c_out : out std_ulogic);
  end component;
  signal x: std_ulogic_vector (8 downto 0);
begin
  u0: full_adder port map (a => a(0), b => b(0), c_in => x(0), sum => sum(0), c_out => x(1));
  u1: full_adder port map (a => a(1), b => b(1), c_in => x(1), sum => sum(1), c_out => x(2));
  u2: full_adder port map (a => a(2), b => b(2), c_in => x(2), sum => sum(2), c_out => x(3));		  
  u3: full_adder port map (a => a(3), b => b(3), c_in => x(3), sum => sum(3), c_out => x(4));
  u4: full_adder port map (a => a(4), b => b(4), c_in => x(4), sum => sum(4), c_out => x(5));
  u5: full_adder port map (a => a(5), b => b(5), c_in => x(5), sum => sum(5), c_out => x(6));
  u6: full_adder port map (a => a(6), b => b(6), c_in => x(6), sum => sum(6), c_out => x(7));
  u7: full_adder port map (a => a(7), b => b(7), c_in => x(7), sum => sum(7), c_out => x(8));
	 
  x(0) <= '0';
  c_out <= x(8);
  
end architecture dataflow;
