private with KartenDatentypen;
private with KartenRecords;

package KartengeneratorAllgemeinesLogik is
   pragma Elaborate_Body;
   
   procedure GenerierungAllgemeines;
   
private
   
   Schleifenbereiche : KartenRecords.LandgrößenNaturalRecord;
   
   procedure GenerierungGrundlagen
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural);
   
   procedure PolbereicheBerechnen;

end KartengeneratorAllgemeinesLogik;
