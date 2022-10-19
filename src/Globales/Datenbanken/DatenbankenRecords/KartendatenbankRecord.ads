pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;
with KampfDatentypen;
with ProduktionDatentypen;
with DatenbankRecords;
with KartenDatentypen;

package KartendatenbankRecord is

   type BewertungArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of KartenDatentypen.Einzelbewertung;
   type WirtschaftArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, KartenDatentypen.Wirtschaft_Enum'Range) of ProduktionDatentypen.Einzelproduktion;
   type KampfArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, KartenDatentypen.Kampf_Enum'Range) of KampfDatentypen.KampfwerteAllgemein;
      
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