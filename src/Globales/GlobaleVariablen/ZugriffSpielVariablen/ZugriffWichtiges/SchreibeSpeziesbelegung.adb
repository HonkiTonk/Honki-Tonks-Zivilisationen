with WichtigesRecordKonstanten;
with SpielVariablen;

package body SchreibeSpeziesbelegung is

   procedure Belegung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      BelegungExtern : in SpeziesDatentypen.Spieler_Enum)
   is begin
      
      SpielVariablen.Speziesbelegung (SpeziesExtern).Belegung := BelegungExtern;
      
   end Belegung;
   
   
   
   procedure Besiegt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      SpielVariablen.Speziesbelegung (SpeziesExtern).Besiegt := True;
      
   end Besiegt;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      SpielVariablen.Speziesbelegung := (others => WichtigesRecordKonstanten.LeerSpeziesbelegung);
      
   end Standardeinstellungen;
   
   
   
   procedure GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EintragExtern : in SpielRecords.SpeziesRecords)
   is begin
      
      SpielVariablen.Speziesbelegung (SpeziesExtern) := EintragExtern;
      
   end GanzerEintrag;
   
   
   
   procedure GanzesArray
     (ArrayExtern : in SpielRecords.SpeziesbelegungArray)
   is begin
      
      SpielVariablen.Speziesbelegung := ArrayExtern;
      
   end GanzesArray;

end SchreibeSpeziesbelegung;
