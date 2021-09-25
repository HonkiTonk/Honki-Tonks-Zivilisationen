pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, GlobaleKonstanten, EinheitStadtRecords, NutzerRecords, KartenRecords, WichtigeRecords;

package GlobaleVariablen is

   -- Schreiben/Ausgabe
   -- Die einzelnen Textarrays hier rein oder in eine eigene Datei?
   type NutzerEinstellungenArray is array (1 .. 3) of Unbounded_Wide_Wide_String;
   NutzerEinstellungen : NutzerRecords.NutzerEinstellungenRecord := (
                                                                     -- Sprache
                                                                     To_Unbounded_Wide_Wide_String (Source => GlobaleKonstanten.LeerText),
                                                                     -- Anzahl Autosaves
                                                                     10,
                                                                     -- Rundenanzahl bis Autosave
                                                                     10
                                                                    );
   -- Schreiben/Ausgabe
   
   

   -- Cursor
   type CursorImSpielArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of KartenRecords.CursorRecord;
   CursorImSpiel : CursorImSpielArray := (others => GlobaleKonstanten.LeerCursor);
   -- Cursor
   
   

   -- Zeug
   RundenAnzahl : Positive := Positive'First;
   Rundengrenze : Natural := Natural'First;

   -- Nicht belegt, Menschlicher Spieler, KI
   RassenImSpiel : GlobaleDatentypen.RassenImSpielArray := (others => GlobaleDatentypen.Leer);
   RasseAmZugNachLaden : GlobaleDatentypen.Rassen_Enum := GlobaleDatentypen.Leer;

   Schwierigkeitsgrad : GlobaleDatentypen.Schwierigkeitsgrad_Verwendet_Enum;
   Gewonnen : Boolean := False;
   WeiterSpielen : Boolean := False;
   
   -- Später über Nutzereingaben neu belegbar machen.
   type GrenzenArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of WichtigeRecords.GrenzenRecord;
   Grenzen : GrenzenArray := (others => GlobaleKonstanten.LeerGrenzen);
   
   IronmanName : Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => GlobaleKonstanten.LeerString);
   -- Zeug
   

   
   -- Einheiten
   type EinheitenGebautArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.MaximaleEinheiten'Range) of EinheitStadtRecords.EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => GlobaleKonstanten.LeerEinheit));
   -- Einheiten
   
   

   -- Städte
   type StadtGebautArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.MaximaleStädte'Range) of EinheitStadtRecords.StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others => (others => GlobaleKonstanten.LeerStadt));
   -- Städte
   
   

   -- Wichtiges Zeug
   type WichtigesArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of WichtigeRecords.WichtigesRecord;
   Wichtiges : WichtigesArray := (others => GlobaleKonstanten.LeerWichtigesZeug);
   
   type DiplomatieArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of WichtigeRecords.DiplomatieRecord;
   Diplomatie : DiplomatieArray := (others => (others => GlobaleKonstanten.LeerDiplomatie));
   -- Wichtiges Zeug
                                               
end GlobaleVariablen;
