private with KartenDatentypen;

package KartengeneratorOrbitLogik is
   pragma Elaborate_Body;

   procedure Orbit
     (LadezeitbasisExtern : in Float)
     with
       Pre => (
                 LadezeitbasisExtern > 0.00
               and
                 LadezeitbasisExtern <= 100.00
              );

private

   Kartenzeitwert : KartenDatentypen.SenkrechtePositiv;

end KartengeneratorOrbitLogik;
