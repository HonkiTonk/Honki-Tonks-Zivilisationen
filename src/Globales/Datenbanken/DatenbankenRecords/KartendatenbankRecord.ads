with SpeziesDatentypen;
with KampfDatentypen;
with ProduktionDatentypen;
with DatenbankRecords;
with BewertungDatentypen;
with EinheitenDatentypen;

package KartendatenbankRecord is
   pragma Pure;

   type BewertungArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of BewertungDatentypen.Bewertung_Enum;
   type WirtschaftArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range, ProduktionDatentypen.Wirtschaft_Enum'Range) of ProduktionDatentypen.Einzelproduktion;
   type KampfArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range, KampfDatentypen.Kampf_Enum'Range) of KampfDatentypen.KampfwerteKarte;
   type BewegungArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of EinheitenDatentypen.Bewegungspunkte;
      
   type KartenlistenRecord is record
            
      Bewertung : BewertungArray;
      Wirtschaft : WirtschaftArray;
      Kampf : KampfArray;
      
   end record;
   
   
   
   type KartenzusatzgrundlisteRecord is record
      
      Bewertung : BewertungArray;
      Wirtschaft : WirtschaftArray;
      Kampf : KampfArray;
      
      Bewegung : BewegungArray;
      
   end record;
   
   
   
   type KartenpassierbarkeitslistenRecord is record
      
      Bewertung : BewertungArray;
      Wirtschaft : WirtschaftArray;
      Kampf : KampfArray;
      
      Passierbarkeit : DatenbankRecords.PassierbarkeitArray;
      Bewegung : BewegungArray;
      
   end record;

end KartendatenbankRecord;
