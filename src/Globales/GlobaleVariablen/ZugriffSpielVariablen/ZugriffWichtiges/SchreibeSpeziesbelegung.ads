with SpeziesDatentypen;
with SpielRecords;

package SchreibeSpeziesbelegung is
   pragma Elaborate_Body;

   procedure Belegung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      BelegungExtern : in SpeziesDatentypen.Spieler_Enum);
   pragma Inline (Belegung);
   
   procedure Besiegt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum);
   pragma Inline (Besiegt);
   
   procedure Standardeinstellungen;
   pragma Inline (Standardeinstellungen);
   
   procedure GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EintragExtern : in SpielRecords.SpeziesRecords);
   pragma Inline (GanzerEintrag);
   
   procedure GanzesArray
     (ArrayExtern : in SpielRecords.SpeziesbelegungArray);
   pragma Inline (GanzesArray);

end SchreibeSpeziesbelegung;
