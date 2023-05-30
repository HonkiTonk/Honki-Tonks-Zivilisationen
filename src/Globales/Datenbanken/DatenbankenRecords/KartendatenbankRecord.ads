with SpeziesDatentypen;
with KampfDatentypen;
with ProduktionDatentypen;
with DatenbankRecords;
with BewertungDatentypen;
with EinheitenDatentypen;

package KartendatenbankRecord is
   pragma Pure;

   type BewertungArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of BewertungDatentypen.Bewertung_Enum;
   type WirtschaftArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range, ProduktionDatentypen.Produktion_Enum'Range) of ProduktionDatentypen.Einzelproduktion;
   type KampfArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range, KampfDatentypen.Kampf_Enum'Range) of KampfDatentypen.KampfwerteKarte;
   type BewegungArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of EinheitenDatentypen.Bewegungspunkte;
   
   type KartenbasisgrundlisteRecord is record
      
      Bewertung : BewertungArray;
      Wirtschaft : WirtschaftArray;
      Kampf : KampfArray;
      
      Passierbarkeit : DatenbankRecords.PassierbarkeitArray;
      Bewegung : BewegungArray;
      
   end record;
   
   
   
   type KartenzusatzgrundlisteRecord is record
      
      Bewertung : BewertungArray;
      Wirtschaft : WirtschaftArray;
      Kampf : KampfArray;
      
      Bewegung : BewegungArray;
      
   end record;
   
   
   
   type BewertungsbonusArray is array (BewertungArray'Range) of Boolean;
   type WirtschaftsbonusArray is array (WirtschaftArray'Range (1), WirtschaftArray'Range (2)) of ProduktionDatentypen.Produktionsbonus;
   type KampfbonusArray is array (KampfArray'Range (1), KampfArray'Range (2)) of ProduktionDatentypen.Produktionsbonus;
   
   type KartenextraslisteRecord is record
      
      Bewertung : BewertungsbonusArray;
      
      Wirtschaft : WirtschaftsbonusArray;
      Kampf : KampfbonusArray;
      
   end record;
   
   
   
   -- Stadt überschreibt vorhandene Verbesserung, deswegen brauche ich für Verbesserungen keine Bewertung.
   -- Einen Bonus für die Feldbewertung erfolgt auf Basis der Umgebenden Verbesserungen.
   type VerbesserungenlisteRecord is record
      
      Wirtschaft : WirtschaftsbonusArray;
      Kampf : KampfbonusArray;
      
   end record;
   
   
   
   -- Stadt erzeugt beim Bau einen Weg, deswegen brauche ich für Verbesserungen keine Bewertung.
   -- Einen Bonus für die Feldbewertung erfolgt auf Basis der Umgebenden Wege.
   type WegelisteRecord is record
      
      Wirtschaft : WirtschaftsbonusArray;
      Kampf : KampfbonusArray;
      
      Passierbarkeit : DatenbankRecords.PassierbarkeitArray;
      Bewegung : BewegungArray;
      
   end record;

end KartendatenbankRecord;
