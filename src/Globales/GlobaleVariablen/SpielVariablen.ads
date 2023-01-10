with SpeziesDatentypen;
with KartenRecords;
with SpielRecords;
with WichtigesRecordKonstanten;

package SpielVariablen is
   pragma Elaborate_Body;
      
   Speziesbelegung : SpielRecords.SpeziesbelegungArray := (others => WichtigesRecordKonstanten.LeerSpeziesbelegung);
   
   Allgemeines : SpielRecords.AllgemeinesRecord := WichtigesRecordKonstanten.LeerAllgemeines;
      
   type CursorImSpielArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of KartenRecords.CursorRecord;
   CursorImSpiel : CursorImSpielArray := (others => WichtigesRecordKonstanten.LeerCursor);
   
   -- Später über Nutzereingaben einstellbar machen. äöü
   type GrenzenArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of SpielRecords.GrenzenRecord;
   Grenzen : GrenzenArray := (others => WichtigesRecordKonstanten.LeerGrenzen);
      
   type WichtigesArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of SpielRecords.WichtigesRecord;
   Wichtiges : WichtigesArray := (others => WichtigesRecordKonstanten.LeerWichtigesZeug);
   
   type DiplomatieArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range, SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of SpielRecords.DiplomatieRecord;
   Diplomatie : DiplomatieArray := (others => (others => WichtigesRecordKonstanten.LeerDiplomatie));

end SpielVariablen;
