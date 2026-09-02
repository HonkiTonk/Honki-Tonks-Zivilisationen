private with KartenDatentypen;

package KartengeneratorWeltraumLogik is
   pragma Elaborate_Body;

   procedure Weltraum
     (LadezeitbasisExtern : in Float)
     with
       Pre => (
                 LadezeitbasisExtern > 0.00
               and
                 LadezeitbasisExtern <= 100.00
              );

private

   Kartenzeitwert : KartenDatentypen.SenkrechtePositiv;

end KartengeneratorWeltraumLogik;
