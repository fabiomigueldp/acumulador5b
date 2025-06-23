LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY acumula IS
   PORT (  C,L,T : IN  STD_LOGIC;                         -- Clear, Load, Transfer
          D      : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);      -- dado de entrada
          R      : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));     -- resultado acumulado
END acumula;

ARCHITECTURE func OF acumula IS
   SIGNAL B,A,S : STD_LOGIC_VECTOR(3 DOWNTO 0);

   COMPONENT reg4bits
      PORT ( clk  : IN  STD_LOGIC;
             clr  : IN  STD_LOGIC;
             D    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
             Q    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
   END COMPONENT;
BEGIN
   -- Registrador B (carrega o operando)
   RB : reg4bits
      PORT MAP ( clk => L,            -- pulso LOAD
                 clr => '1',          -- nunca é limpo
                 D   => D,
                 Q   => B );

   -- Somador A + B
   S <= A + B;

   -- Registrador A (armazena acumulação)
   RA : reg4bits
      PORT MAP ( clk => T,            -- pulso TRANSFER
                 clr => NOT C,        -- CLEAR ativo-alto → ativo-baixo do reg
                 D   => S,
                 Q   => A );

   -- Saída
   R <= A;
END func;
