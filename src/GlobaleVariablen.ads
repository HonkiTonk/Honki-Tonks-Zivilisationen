with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with Karten, GlobaleDatentypen, GlobaleRecords;

package GlobaleVariablen is

   -- Schreiben/Ausgabe
   type TexteEinlesenNeuArray is array (0 .. 21, 1 .. 84) of Unbounded_Wide_Wide_String;
   TexteEinlesenNeu : TexteEinlesenNeuArray := (others => (others => (To_Unbounded_Wide_Wide_String ("|"))));

   GewählteSprache : Unbounded_Wide_Wide_String;
   -- Schreiben/Ausgabe
   
   

   -- Cursor
   type CursorImSpielArray is array (GlobaleDatentypen.Rassen) of GlobaleRecords.CursorRecord;
   CursorImSpiel : CursorImSpielArray := (others => ('©', (0, 1, 1), (0, 1, 1), (1, 1)));
   -- Cursor
   
   

   -- Zeug?
   RundenAnzahl : Positive := 1;
   RundenBisAutosave : Positive := 10;

   RassenImSpiel : GlobaleDatentypen.RassenImSpielarray; -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
                                                         -- Ändern das alle RassenBereiche hierauf gehen?
   -- Zeug?
                                                         

   
   -- Einheiten
   type EinheitenGebautArray is array (GlobaleDatentypen.Rassen'Range, 1 .. 1_000) of GlobaleRecords.EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => (0, 0,    0, (0, 1, 1),    0, 0.00, 0, 0,    0, 0)));
   -- Einheiten
   
   

   -- Städte
   type StadtGebautArray is array (GlobaleDatentypen.Rassen'Range, 1 .. 100) of GlobaleRecords.StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others =>
                                        (others =>
                                           ((0, (0, 1, 1),    False,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,    "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => ""),    (others => (others => False)), 0, 1))));
   -- Städte
   
   

   -- Wichtiges Zeug
   type WichtigesArray is array (GlobaleDatentypen.Rassen'Range) of GlobaleRecords.WichtigesRecord;
   Wichtiges : WichtigesArray := (others => (0, 0, 0, 0, 10_000, 0, (others => 0)));
   
   type DiplomatieArray is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.Rassen'Range) of Integer; -- 0 = Kein Kontakt, -1 = Krieg, 1 = Neutral, 2 = Offene Grenzen, 3 = Nichtangriffspakt, 4 = Defensivbündnis, 5 = Offensivbündnis
   Diplomatie : DiplomatieArray := (others => (others => 1));
   -- Wichtiges Zeug
   
   
  
   -- Cheats
   FeindlicheInformationenSehen : Boolean := False;
   -- Cheats
                                               
end GlobaleVariablen;
