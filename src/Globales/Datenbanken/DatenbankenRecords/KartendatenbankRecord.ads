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
   
   type BewertungsbonusArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of Boolean;
   type WirtschaftsbonusArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range, ProduktionDatentypen.Wirtschaft_Enum'Range) of ProduktionDatentypen.Produktionsbonus;
   type KampfbonusArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range, KampfDatentypen.Kampf_Enum'Range) of ProduktionDatentypen.Produktionsbonus;
      
   type KartenlistenRecord is record
            
      Bewertung : BewertungArray;
      Wirtschaft : WirtschaftArray;
      Kampf : KampfArray;
      
   end record;
   
   
   
   -- Das hier später besser benennen oder brauche ich diesen Record nur bei Ressourcen? äöü
   type RessourcenlisteRecord is record
      
      Bewertung : BewertungsbonusArray;
      
      Wirtschaft : WirtschaftsbonusArray;
      Kampf : KampfbonusArray;
      
   end record;
   
   
   
   -- Brauche ich bei Verbesserungen eine Bewertung? Wenn dann müsste ich ja eher die Umgabung nach einer Verbesserung überprüfen. äöü
   -- Sollte auch bei Wegen gelten. äöü
   type VerbesserungenlisteRecord is record
      
      Wirtschaft : WirtschaftsbonusArray;
      Kampf : KampfbonusArray;
      
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
