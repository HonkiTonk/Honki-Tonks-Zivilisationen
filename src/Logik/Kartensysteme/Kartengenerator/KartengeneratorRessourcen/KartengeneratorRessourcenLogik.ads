private with KartenDatentypen;

package KartengeneratorRessourcenLogik is
   pragma Elaborate_Body;
   
   procedure GenerierungRessourcen;

private
            
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet;
      LadezeitbasisExtern : in Float)
     with
       Pre => (
                 LadezeitbasisExtern > 0.00
               and
                 LadezeitbasisExtern <= 100.00
              );

end KartengeneratorRessourcenLogik;
