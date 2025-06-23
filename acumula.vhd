ARCHITECTURE func OF acumula IS
   SIGNAL B,A,S : STD_LOGIC_VECTOR(3 DOWNTO 0);
   SIGNAL clrA  : STD_LOGIC;                     -- ❶ novo sinal

   COMPONENT reg4bits
      PORT ( clk  : IN  STD_LOGIC;
             clr  : IN  STD_LOGIC;
             D    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
             Q    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
   END COMPONENT;
BEGIN
   -- Conversão do Clear ativo-alto (C) para ativo-baixo do registrador
   clrA <= NOT C;                                -- ❷ inversão fora do PORT MAP

   -- Registrador B – LOAD
   RB : reg4bits
      PORT MAP ( clk => L,
                 clr => '1',
                 D   => D,
                 Q   => B );

   -- Somador
   S <= A + B;

   -- Registrador A – TRANSFER
   RA : reg4bits
      PORT MAP ( clk => T,
                 clr => clrA,                    -- ❸ passa o sinal já invertido
                 D   => S,
                 Q   => A );

   -- Saída
   R <= A;
END func;
