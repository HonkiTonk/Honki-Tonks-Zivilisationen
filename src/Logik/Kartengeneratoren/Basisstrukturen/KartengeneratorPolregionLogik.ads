private with KartenDatentypen;
private with KartenRecords;

package KartengeneratorPolregionLogik is
   pragma Elaborate_Body;

   procedure Polregion;

private

   SüdpolSchleifenkorrektur : KartenDatentypen.SenkrechteNatural;
   OstpolSchleifenkorrektur : KartenDatentypen.SenkrechteNatural;

   Schleifenbereiche : KartenRecords.LandgrößenNaturalRecord;

   procedure PolregionGenerieren;
   procedure Nordpol;
   procedure Südpol;
   procedure Westpol;
   procedure Ostpol;

end KartengeneratorPolregionLogik;
