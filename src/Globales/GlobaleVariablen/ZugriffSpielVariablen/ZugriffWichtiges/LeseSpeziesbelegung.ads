with SpeziesDatentypen;
with SpielRecords;

package LeseSpeziesbelegung is
   pragma Elaborate_Body;

   function Belegung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Spieler_Enum;
   
   function Besiegt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean;
   
   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpielRecords.SpeziesRecords;
   
   function GanzesArray
     return SpielRecords.SpeziesbelegungArray;

end LeseSpeziesbelegung;
