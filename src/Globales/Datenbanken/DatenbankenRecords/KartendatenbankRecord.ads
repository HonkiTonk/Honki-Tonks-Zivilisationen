pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;
with KampfDatentypen;
with ProduktionDatentypen;
with DatenbankRecords;
with BewertungDatentypen;

package KartendatenbankRecord is
   pragma Pure;

   type BewertungArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of BewertungDatentypen.Bewertung_Enum;
   type WirtschaftArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, ProduktionDatentypen.Wirtschaft_Enum'Range) of ProduktionDatentypen.Einzelproduktion;
   type KampfArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, KampfDatentypen.Kampf_Enum'Range) of KampfDatentypen.KampfwerteKarte;
      
   type KartenlistenRecord is record
            
      Bewertung : BewertungArray;
      Wirtschaft : WirtschaftArray;
      Kampf : KampfArray;
      
   end record;
   
   
   
   type KartenpassierbarkeitslistenRecord is record
      
      Bewertung : BewertungArray;
      Wirtschaft : WirtschaftArray;
      Kampf : KampfArray;
      
      Passierbarkeit : DatenbankRecords.PassierbarkeitArray;
      
   end record;

end KartendatenbankRecord;
