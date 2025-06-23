LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY acumulador IS
   PORT ( clk   : IN  STD_LOGIC;  -- PB3 (Key3)
          ok    : IN  STD_LOGIC;  -- SW17
          reset : IN  STD_LOGIC;  -- SW16
          Result: OUT STD_LOGIC_VECTOR(3 DOWNTO 0) ); -- LEDR17..14
END acumulador;

ARCHITECTURE func OF acumulador IS
   SIGNAL zera, carrega, guarda : STD_LOGIC;
   SIGNAL Dado                  : STD_LOGIC_VECTOR(3 DOWNTO 0);

   COMPONENT acumula
      PORT ( C,L,T : IN  STD_LOGIC;
             D     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
             R     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
   END COMPONENT;

   COMPONENT controle
      PORT ( clock : IN  STD_LOGIC;
             SS    : IN  STD_LOGIC;
             reset : IN  STD_LOGIC;
             C,L,T : OUT STD_LOGIC );
   END COMPONENT;

   COMPONENT leitor
      PORT ( reset, carrega : IN  STD_LOGIC;
             Dado          : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
   END COMPONENT;
BEGIN
   -- Controle de estados
   ctrl : controle PORT MAP ( clk, ok, reset, zera, carrega, guarda );

   -- Acumulador de 4 bits
   acum : acumula  PORT MAP ( zera, carrega, guarda, Dado, Result );

   -- Leitor de memória (gera o sinal Dado)
   ler  : leitor   PORT MAP ( reset, carrega, Dado );
END func;
