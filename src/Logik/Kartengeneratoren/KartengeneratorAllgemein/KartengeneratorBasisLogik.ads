private with KartenRecords;

package KartengeneratorBasisLogik is
   pragma Elaborate_Body;
   
   procedure Kartenbasis;
   
private
   
   Schleifenbereiche : KartenRecords.LandgrößenNaturalRecord;
   
   procedure PolbereicheBerechnen;

end KartengeneratorBasisLogik;
