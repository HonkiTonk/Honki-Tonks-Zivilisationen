with RassenDatentypen;
with KartenRecords;
with SpielRecords;
with WichtigesRecordKonstanten;

package SpielVariablen is
      
   Rassenbelegung : SpielRecords.RassenbelegungArray := (others => WichtigesRecordKonstanten.LeerRassenbelegung);
   
   Allgemeines : SpielRecords.AllgemeinesRecord := WichtigesRecordKonstanten.LeerAllgemeines;
      
   type CursorImSpielArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of KartenRecords.CursorRecord;
   CursorImSpiel : CursorImSpielArray := (others => WichtigesRecordKonstanten.LeerCursor);
   
   -- Später über Nutzereingaben einstellbar machen. äöü
   type GrenzenArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of SpielRecords.GrenzenRecord;
   Grenzen : GrenzenArray := (others => WichtigesRecordKonstanten.LeerGrenzen);
      
   type WichtigesArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of SpielRecords.WichtigesRecord;
   Wichtiges : WichtigesArray := (others => WichtigesRecordKonstanten.LeerWichtigesZeug);
   
   type DiplomatieArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, RassenDatentypen.Rassen_Verwendet_Enum'Range) of SpielRecords.DiplomatieRecord;
   Diplomatie : DiplomatieArray := (others => (others => WichtigesRecordKonstanten.LeerDiplomatie));

end SpielVariablen;
