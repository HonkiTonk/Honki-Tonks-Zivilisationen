pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, GlobaleRecords;

package GlobaleVariablen is

   -- Schreiben/Ausgabe
   type TexteEinlesenNeuArray is array (0 .. 22, 1 .. 84) of Unbounded_Wide_Wide_String;
   TexteEinlesenNeu : TexteEinlesenNeuArray := (others => (others => (To_Unbounded_Wide_Wide_String ("|"))));

   GewählteSprache : Unbounded_Wide_Wide_String;
   -- Schreiben/Ausgabe
   
   

   -- Cursor
   -- Hier noch hinschreiben welcher Wert was ist!
   LeererWertCursor : constant GlobaleRecords.CursorRecord := ('©', (0, 1, 1), (0, 1, 1), (1, 1));

   type CursorImSpielArray is array (GlobaleDatentypen.Rassen'Range) of GlobaleRecords.CursorRecord;
   CursorImSpiel : CursorImSpielArray := (others => LeererWertCursor);
   -- Cursor
   
   

   -- Zeug?
   RundenAnzahl : Positive := 1;
   RundenBisAutosave : Positive := 10;

   RassenImSpiel : GlobaleDatentypen.RassenImSpielArray := (others => 0); -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
                                                         -- Ändern das alle RassenBereiche hierauf gehen?
   RasseAmZugNachLaden : GlobaleDatentypen.RassenMitNullwert := 0;
   -- Zeug?
                                                         

   
   -- Einheiten
   -- Hier noch hinschreiben welcher Wert was ist!
   LeererWertEinheit : constant GlobaleRecords.EinheitenGebautRecord := (0, 0,    0, (0, 1, 1),    0, 0.00, 0, 0,    0, 0);

   type EinheitenGebautArray is array (GlobaleDatentypen.Rassen'Range, 1 .. 1_000) of GlobaleRecords.EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => LeererWertEinheit));
   -- Einheiten
   
   

   -- Städte
   -- Hier noch hinschreiben welcher Wert was ist!
   LeererWertStadt : constant GlobaleRecords.StadtGebautRecord := (0, (0, 1, 1),    False,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                                   "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => ""),    (others => (others => False)), 0, 1,    0);

   type StadtGebautArray is array (GlobaleDatentypen.Rassen'Range, 1 .. 100) of GlobaleRecords.StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others => (others => LeererWertStadt));
   -- Städte
   
   

   -- Wichtiges Zeug
   -- Hier noch hinschreiben welcher Wert was ist!
   LeererWertWichtigesZeug : constant GlobaleRecords.WichtigesRecord := (0, 0, 0, 0, 10_000, 0, (others => 0));

   type WichtigesArray is array (GlobaleDatentypen.Rassen'Range) of GlobaleRecords.WichtigesRecord;
   Wichtiges : WichtigesArray := (others => (0, 0, 0, 0, 10_000, 0, (others => 0)));
   
   -- 0 = Kein Kontakt, -1 = Krieg, 1 = Neutral, 2 = Offene Grenzen, 3 = Nichtangriffspakt, 4 = Defensivbündnis, 5 = Offensivbündnis
   type DiplomatieArray is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.Rassen'Range) of Integer;
   Diplomatie : DiplomatieArray := (others => (others => 1));
   -- Wichtiges Zeug
   
   
  
   -- Cheats
   FeindlicheInformationenSehen : Boolean := False;
   -- Cheats
                                               
end GlobaleVariablen;
