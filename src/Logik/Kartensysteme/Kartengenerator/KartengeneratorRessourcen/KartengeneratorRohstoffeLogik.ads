private with KartenDatentypen;
private with KartenRecords;

package KartengeneratorRohstoffeLogik is
   pragma Elaborate_Body;
   
   procedure Rohstoffe;

private
   
   procedure GenerierungRohstoffe
     (SchleifenbereichtExtern : in KartenRecords.LandgrößenNaturalRecord);
   
   procedure RohstoffeGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet;
      LadezeitbasisExtern : in Float;
      SchleifenbereichtExtern : in KartenRecords.LandgrößenNaturalRecord)
     with
       Pre => (
                 LadezeitbasisExtern > 0.00
               and
                 LadezeitbasisExtern <= 100.00
              );

end KartengeneratorRohstoffeLogik;
