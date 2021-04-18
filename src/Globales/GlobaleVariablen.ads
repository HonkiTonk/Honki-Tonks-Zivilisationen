pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; 
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, GlobaleRecords, GlobaleKonstanten;

package GlobaleVariablen is

   -- Schreiben/Ausgabe
   type SprachenEinlesenArray is array (1 .. 100) of Unbounded_Wide_Wide_String;
   SprachenEinlesen : SprachenEinlesenArray;

   type TexteEinlesenNeuArray is array (1 .. 24, 1 .. 93) of Unbounded_Wide_Wide_String;
   TexteEinlesenNeu : TexteEinlesenNeuArray := (others => (others => (To_Unbounded_Wide_Wide_String (Source => "|"))));
   
   GewählteSprache : Unbounded_Wide_Wide_String;
   -- Schreiben/Ausgabe
   
   

   -- Cursor
   type CursorImSpielArray is array (GlobaleDatentypen.Rassen'Range) of GlobaleRecords.CursorRecord;
   CursorImSpiel : CursorImSpielArray := (others => GlobaleKonstanten.LeererWertCursor);
   -- Cursor
   
   

   -- Zeug
   RundenAnzahl : Positive := 1;
   RundenBisAutosave : Positive := 10;
   AnzahlAutosave : Natural := 10;

   RassenImSpiel : GlobaleDatentypen.RassenImSpielArray := (others => 0); -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
   RasseAmZugNachLaden : GlobaleDatentypen.RassenMitNullwert := 0;

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
