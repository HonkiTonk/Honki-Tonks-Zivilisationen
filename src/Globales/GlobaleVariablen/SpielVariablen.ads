with SpeziesDatentypen;
with KartenRecords;
with SpielRecords;
with WichtigesRecordKonstanten;

package SpielVariablen is
   pragma Elaborate_Body;
   
   -- Muss gespeichert werden
   Speziesbelegung : SpielRecords.SpeziesbelegungArray := (others => WichtigesRecordKonstanten.LeerSpeziesbelegung);
   
   Allgemeines : SpielRecords.AllgemeinesRecord := WichtigesRecordKonstanten.LeerAllgemeines;
      
   type SpielzeigerArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of KartenRecords.ZeigerRecord;
   Spielzeiger : SpielzeigerArray := (others => WichtigesRecordKonstanten.LeerZeiger);
   
   -- Später über Nutzereingaben einstellbar machen. äöü
   type GrenzenArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of SpielRecords.GrenzenRecord;
   Grenzen : GrenzenArray := (others => WichtigesRecordKonstanten.LeerGrenzen);
      
   type WichtigesArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of SpielRecords.WichtigesRecord;
   Wichtiges : WichtigesArray := (others => WichtigesRecordKonstanten.LeerWichtigesZeug);
   
   type DiplomatieArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of SpielRecords.DiplomatieRecord;
   Diplomatie : DiplomatieArray := (others => (others => WichtigesRecordKonstanten.LeerDiplomatie));
   
   
   
   -- Muss nicht gespeichert werden
   

end SpielVariablen;
