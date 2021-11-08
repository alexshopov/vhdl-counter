library ieee;
use ieee.std_logic_1164.all;

-- increment	PIN_U30	KEY2
-- reset			PIN_U29	KEY3

entity vhdlcounter is
  port (clk: in std_ulogic;
        reset, increment: in std_ulogic;
        lo_segments, hi_segments: buffer std_ulogic_vector(1 to 7));	-- HEX6
end entity vhdlcounter;


architecture dataflow of vhdlcounter is
  attribute chip_pin: string;
  attribute chip_pin of reset: signal is "R24";			-- reset to value 0 when KEY3 is pressed
  attribute chip_pin of increment: signal is "N21";	-- increment counter by 1 when KEY2 is pressed
  attribute chip_pin of lo_segments: signal is "G18, F22, E17, L26, L25, J22, H22";
  attribute chip_pin of hi_segments: signal is "M24, Y22, W21, W22, W25, U23, U24";
  
  component eight_bit_adder is
    port (
      a, b : in std_ulogic_vector (7 downto 0);
		c_in : in std_ulogic;
      sum: out std_ulogic_vector (7 downto 0);
		c_out: out std_ulogic);
  end component;
  
  component reg8 is
    port (clk: in std_ulogic;
	       clear: in std_ulogic;
          d: in std_ulogic_vector (7 downto 0);
          q: out std_ulogic_vector (7 downto 0));
  end component;
  
  component segment_display is
    port (
      val: in std_ulogic_vector(3 downto 0);
      segments: buffer std_ulogic_vector(1 to 7));
	end component;
	
	signal adder_in, adder_out: std_ulogic_vector (7 downto 0);
	signal reg_in, reg_out: std_ulogic_vector (7 downto 0);
	signal lo_in, hi_in: std_ulogic_vector (3 downto 0);
	signal lo_out, hi_out: std_ulogic_vector (1 to 7);
	
	signal test_sig: std_ulogic_vector (7 downto 0);
begin
  add: eight_bit_adder port map (a => reg_out, b => "00000001", c_in => '0', sum => adder_out);
  reg: reg8 port map (clk => not increment, clear => not reset, d => adder_out, q => reg_out);
  lo: segment_display port map (val => lo_in, segments => lo_out);
  hi: segment_display port map (val => hi_in, segments => hi_out);

  lo_in <= reg_out (3 downto 0);
  lo_segments <= lo_out;
	 
  hi_in <= reg_out (7 downto 4);
  hi_segments <= hi_out;
 
end architecture dataflow;
