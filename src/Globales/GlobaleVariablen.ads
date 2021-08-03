pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; 
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, GlobaleRecords, GlobaleKonstanten;

package GlobaleVariablen is

   -- Schreiben/Ausgabe
   -- Die einzelnen Textarrays hier rein oder in eine eigene Datei?
   type NutzerEinstellungenArray is array (1 .. 3) of Unbounded_Wide_Wide_String;
   NutzerEinstellungen : GlobaleRecords.NutzerEinstellungenRecord := (
                                                                      -- Sprache
                                                                      To_Unbounded_Wide_Wide_String (Source => "|"),
                                                                      -- Anzahl Autosaves
                                                                      10,
                                                                      -- Rundenanzahl bis Autosave
                                                                      10
                                                                     );
   -- Schreiben/Ausgabe
   
   

   -- Cursor
   type CursorImSpielArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of GlobaleRecords.CursorRecord;
   CursorImSpiel : CursorImSpielArray := (others => GlobaleKonstanten.LeerCursor);
   -- Cursor
   
   

   -- Zeug
   RundenAnzahl : Positive := 1;
   Rundengrenze : Natural := 0;

   -- Nicht belegt, Menschlicher Spieler, KI
   RassenImSpiel : GlobaleDatentypen.RassenImSpielArray := (others => GlobaleDatentypen.Leer);
   RasseAmZugNachLaden : GlobaleDatentypen.Rassen_Enum := GlobaleDatentypen.Leer;

   Schwierigkeitsgrad : GlobaleDatentypen.Schwierigkeitsgrad_Verwendet_Enum;   
   Gewonnen : Boolean := False;
   
   -- Später über Nutzereingaben neu belegbar machen.
   type GrenzenArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of GlobaleRecords.GrenzenRecord;
   Grenzen : GrenzenArray := (others => GlobaleKonstanten.LeerGrenzen);
   
   IronmanName : Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => "");
   -- Zeug
   

   
   -- Einheiten
   type EinheitenGebautArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.MaximaleEinheiten'Range) of GlobaleRecords.EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => GlobaleKonstanten.LeerEinheit));
   -- Einheiten
   
   

   -- Städte
   type StadtGebautArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.MaximaleStädte'Range) of GlobaleRecords.StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others => (others => GlobaleKonstanten.LeerStadt));
   -- Städte
   
   

   -- Wichtiges Zeug
   type WichtigesArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of GlobaleRecords.WichtigesRecord;
   Wichtiges : WichtigesArray := (others => GlobaleKonstanten.LeerWichtigesZeug);
   
   type DiplomatieArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of GlobaleRecords.DiplomatieRecord;
   Diplomatie : DiplomatieArray := (others => (others => GlobaleKonstanten.LeerDiplomatie));
   -- Wichtiges Zeug
   
   
  
   -- Cheats
   FeindlicheInformationenSehen : Boolean := False;
   -- Cheats
                                               
end GlobaleVariablen;
