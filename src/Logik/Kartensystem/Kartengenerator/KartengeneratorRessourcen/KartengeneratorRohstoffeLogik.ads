private with SystemDatentypenHTSEB;

private with KartenDatentypen;

package KartengeneratorRohstoffeLogik is
   pragma Elaborate_Body;
   
   procedure Rohstoffe;

private
   
   procedure GenerierungRohstoffe;
   
   procedure RohstoffeGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet;
      LadezeitbasisExtern : in SystemDatentypenHTSEB.LadezeitBasis)
     with
       Pre => (
                 LadezeitbasisExtern in SystemDatentypenHTSEB.LadezeitBasis'Range
              );

end KartengeneratorRohstoffeLogik;
