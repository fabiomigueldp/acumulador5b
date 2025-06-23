LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY acumula IS
   PORT ( C,L,T : IN  STD_LOGIC;                      -- Clear, Load, Transfer
          D     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);   -- dado de entrada
          R     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) ); -- resultado
END acumula;

ARCHITECTURE func OF acumula IS
   SIGNAL B, A, S : STD_LOGIC_VECTOR(3 DOWNTO 0);
   SIGNAL clrA    : STD_LOGIC;                        -- sinal auxiliar p/ CLR

   COMPONENT reg4bits
      PORT ( clk  : IN  STD_LOGIC;
             clr  : IN  STD_LOGIC;
             D    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
             Q    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) );
   END COMPONENT;
BEGIN
   ------------------------------------------------------------------
   -- conversão Clear ativo-alto (C) → ativo-baixo do registrador
   ------------------------------------------------------------------
   clrA <= NOT C;

   -- Registrador B (LOAD)
   RB : reg4bits
      PORT MAP ( clk => L,
                 clr => '1',          -- nunca resetado
                 D   => D,
                 Q   => B );

   -- Somador
   S <= A + B;

   -- Registrador A (TRANSFERE resultado)
   RA : reg4bits
      PORT MAP ( clk => T,
                 clr => clrA,         -- clear na borda de C
                 D   => S,
                 Q   => A );

   R <= A;
END func;
