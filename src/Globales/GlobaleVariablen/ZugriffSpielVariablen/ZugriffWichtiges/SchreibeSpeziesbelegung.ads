with SpeziesDatentypen;
with SpielRecords;

package SchreibeSpeziesbelegung is
   pragma Elaborate_Body;

   procedure Belegung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      BelegungExtern : in SpeziesDatentypen.Spieler_Enum);
   
   procedure Besiegt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum);
   
   procedure Standardeinstellungen;
   
   procedure GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EintragExtern : in SpielRecords.SpeziesRecords);
   
   procedure GanzesArray
     (ArrayExtern : in SpielRecords.SpeziesbelegungArray);

end SchreibeSpeziesbelegung;
