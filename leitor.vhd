LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY leitor IS
   PORT( reset, carrega : IN  STD_LOGIC;
         Dado           : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END leitor;

ARCHITECTURE ler OF leitor IS
   COMPONENT contadorMod5
      PORT( clk, clear : IN  STD_LOGIC;
            cont       : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
   END COMPONENT;

   COMPONENT memoria
      PORT( dado_lido   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            endereco    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            dado_gravar : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            hab_grava   : IN  STD_LOGIC;
            clock       : IN  STD_LOGIC );
   END COMPONENT;

   SIGNAL contagem    : STD_LOGIC_VECTOR(2 DOWNTO 0);
   SIGNAL addr        : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL Dado8bits   : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL proximo     : STD_LOGIC;
BEGIN
   -- contador (proximo = pulso de leitura ou reset)
   proximo <= reset OR carrega;
   cont : contadorMod5 PORT MAP (proximo, reset, contagem);

   -- endereço (3 LSBs do contador)
   addr <= "00000" & contagem;

   -- memória (somente leitura)
   mem : memoria
      PORT MAP ( dado_lido   => Dado8bits,
                 endereco    => addr,
                 dado_gravar => (OTHERS => '0'),
                 hab_grava   => '0',
                 clock       => carrega );

   -- saída limitada a 4 bits
   Dado <= Dado8bits(3 DOWNTO 0);
END ler;