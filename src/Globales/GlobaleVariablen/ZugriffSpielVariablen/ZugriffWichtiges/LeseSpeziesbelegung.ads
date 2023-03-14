with SpeziesDatentypen;
with SpielRecords;

package LeseSpeziesbelegung is
   pragma Elaborate_Body;

   function Belegung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Spieler_Enum;
   pragma Inline (Belegung);
   
   function Besiegt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean;
   pragma Inline (Besiegt);
   
   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpielRecords.SpeziesRecords;
   pragma Inline (GanzerEintrag);
   
   function GanzesArray
     return SpielRecords.SpeziesbelegungArray;
   pragma Inline (GanzesArray);

end LeseSpeziesbelegung;
