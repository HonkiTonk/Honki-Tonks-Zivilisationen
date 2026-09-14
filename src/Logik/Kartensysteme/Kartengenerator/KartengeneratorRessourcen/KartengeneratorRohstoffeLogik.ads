private with KartenDatentypen;

package KartengeneratorRohstoffeLogik is
   pragma Elaborate_Body;
   
   procedure GenerierungRohstoffe;

private
            
   procedure RohstoffeGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet;
      LadezeitbasisExtern : in Float)
     with
       Pre => (
                 LadezeitbasisExtern > 0.00
               and
                 LadezeitbasisExtern <= 100.00
              );

end KartengeneratorRohstoffeLogik;
