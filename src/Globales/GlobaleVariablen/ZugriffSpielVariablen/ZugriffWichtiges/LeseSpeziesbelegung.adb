with SpielVariablen;

package body LeseSpeziesbelegung is

   function Belegung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Spieler_Enum
   is begin
      
      return SpielVariablen.Speziesbelegung (SpeziesExtern).Belegung;
      
   end Belegung;
   
   
   
   function Besiegt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
   is begin
      
      return SpielVariablen.Speziesbelegung (SpeziesExtern).Besiegt;
      
   end Besiegt;
   
   
   
   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpielRecords.SpeziesRecords
   is begin
      
      return SpielVariablen.Speziesbelegung (SpeziesExtern);
      
   end GanzerEintrag;
   
   
   
   function GanzesArray
     return SpielRecords.SpeziesbelegungArray
   is begin
      
      return SpielVariablen.Speziesbelegung;
      
   end GanzesArray;

end LeseSpeziesbelegung;
