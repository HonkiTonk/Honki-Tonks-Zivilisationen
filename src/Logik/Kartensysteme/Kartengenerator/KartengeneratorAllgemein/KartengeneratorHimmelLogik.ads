package KartengeneratorHimmelLogik is
   pragma Elaborate_Body;

   procedure Himmel
     (LadezeitbasisExtern : in Float)
     with
       Pre => (
                 LadezeitbasisExtern > 0.00
               and
                 LadezeitbasisExtern <= 100.00
              );

end KartengeneratorHimmelLogik;
