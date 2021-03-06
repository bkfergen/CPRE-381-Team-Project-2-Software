library IEEE;
use IEEE.std_logic_1164.all;

entity notequal_N is

  generic(N         : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic); -- 0 = equal, 1 = not equal

end notequal_N;

architecture structural of notequal_N is

  component xor_N is
    generic(N         : integer := 32);
    port(i_A          : in std_logic_vector(N-1 downto 0);
         i_B          : in std_logic_vector(N-1 downto 0);
         o_F          : out std_logic_vector(N-1 downto 0));
  end component;

  component org2 is
    port(i_A          : in std_logic;
         i_B          : in std_logic;
         o_F          : out std_logic);
  end component;

  signal s_Xor_Output : std_logic_vector(N-1 downto 0);
  signal s_Or_Output : std_logic_vector(N-1 downto 0) := (others => '0');

begin

  ALU_Xor: xor_N
  port map(i_A => i_A,
           i_B => i_B,
           o_F => s_Xor_Output);

  G_NBit_OR: for i in 1 to N-1 generate
    OrI: org2 port map(
              i_A      => s_Or_Output(i-1),
              i_B      => s_Xor_Output(i),
              o_F      => s_Or_Output(i));
  end generate G_NBit_OR;

  o_F <= s_Or_Output(N-1);
  
end structural;