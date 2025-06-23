LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY controle IS
   PORT ( clock : IN  STD_LOGIC;
          SS    : IN  STD_LOGIC;
          reset : IN  STD_LOGIC;
          C,L,T : OUT STD_LOGIC);
END controle;

ARCHITECTURE ctrl OF controle IS
   ------------------------------------------------------------------
   -- definição dos estados (Moore)
   ------------------------------------------------------------------
   TYPE Estado IS (ZERA, CARREGA, SALVA, RESULT);
   SIGNAL estado : Estado;
   SIGNAL S      : STD_LOGIC_VECTOR(2 DOWNTO 0);  -- {C,L,T}
BEGIN
   ------------------------------------------------------------------
   -- Função F – transição de estados
   ------------------------------------------------------------------
   PROCESS (clock, reset)
   BEGIN
      IF reset = '1' THEN
         estado <= ZERA;
      ELSIF rising_edge(clock) THEN
         CASE estado IS
            WHEN ZERA =>
               IF SS='1' THEN
                  estado <= CARREGA;
               END IF;

            WHEN CARREGA =>
               IF SS='1' THEN
                  estado <= SALVA;
               ELSE
                  estado <= RESULT;
               END IF;

            WHEN SALVA =>
               IF SS='1' THEN
                  estado <= CARREGA;
               ELSE
                  estado <= RESULT;
               END IF;

            WHEN RESULT =>
               IF SS='1' THEN
                  estado <= ZERA;
               END IF;
         END CASE;
      END IF;
   END PROCESS;

   ------------------------------------------------------------------
   -- Função G – saídas (depende só do estado)
   ------------------------------------------------------------------
   WITH estado SELECT
      S <= "000" WHEN ZERA,       -- C=0 L=0 T=0
           "110" WHEN CARREGA,    -- C=1 L=1 T=0
           "101" WHEN SALVA,      -- C=1 L=0 T=1
           "100" WHEN RESULT,     -- C=1 L=0 T=0
           "000" WHEN OTHERS;

   C <= S(2);
   L <= S(1);
   T <= S(0);
END ctrl;
