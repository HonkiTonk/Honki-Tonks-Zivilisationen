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
   type CursorImSpielArray is array (GlobaleDatentypen.Rassen'Range) of GlobaleRecords.CursorRecord;
   CursorImSpiel : CursorImSpielArray := (others => GlobaleKonstanten.LeererWertCursor);
   -- Cursor
   
   

   -- Zeug
   RundenAnzahl : Positive := 1;

   -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
   RassenImSpiel : GlobaleDatentypen.RassenImSpielArray := (others => GlobaleDatentypen.Leer);
   RasseAmZugNachLaden : GlobaleDatentypen.RassenMitNullwert := 0;

   -- Hier über LoopMinusDreiBisDrei nachdenken
   Schwierigkeitsgrad : Positive;
   -- Zeug
   

   
   -- Einheiten
   type EinheitenGebautArray is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.MaximaleEinheiten'Range) of GlobaleRecords.EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => GlobaleKonstanten.LeererWertEinheit));
   -- Einheiten
   
   

   -- Städte
   type StadtGebautArray is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.MaximaleStädte'Range) of GlobaleRecords.StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others => (others => GlobaleKonstanten.LeererWertStadt));
   -- Städte
   
   

   -- Wichtiges Zeug
   type WichtigesArray is array (GlobaleDatentypen.Rassen'Range) of GlobaleRecords.WichtigesRecord;
   Wichtiges : WichtigesArray := (others => GlobaleKonstanten.LeererWertWichtigesZeug);
   
   type DiplomatieArray is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.Rassen'Range) of GlobaleDatentypen.StatusUntereinander;
   Diplomatie : DiplomatieArray := (others => (others => GlobaleDatentypen.Kein_Kontakt));
   -- Wichtiges Zeug
   
   
  
   -- Cheats
   FeindlicheInformationenSehen : Boolean := False;
   -- Cheats
                                               
end GlobaleVariablen;
