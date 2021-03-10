pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; 
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, GlobaleRecords, KIDatentypen;

package GlobaleVariablen is

   -- Schreiben/Ausgabe
   type SprachenEinlesenArray is array (1 .. 100) of Unbounded_Wide_Wide_String;
   SprachenEinlesen : SprachenEinlesenArray;

   type TexteEinlesenNeuArray is array (1 .. 24, 1 .. 93) of Unbounded_Wide_Wide_String;
   TexteEinlesenNeu : TexteEinlesenNeuArray := (others => (others => (To_Unbounded_Wide_Wide_String (Source => "|"))));
   
   GewählteSprache : Unbounded_Wide_Wide_String;
   -- Schreiben/Ausgabe
   
   

   -- Cursor
   LeererWertCursor : constant GlobaleRecords.CursorRecord := ('©',       -- 1. Wert = CursorGrafik
                                                               (0, 1, 1), -- 2. Wert = AchsenPosition
                                                               (0, 1, 1), -- 3. Wert = AchsenPositionAlt
                                                               (1, 1));   -- 4. Wert = AchsenPositionStadt

   type CursorImSpielArray is array (GlobaleDatentypen.Rassen'Range) of GlobaleRecords.CursorRecord;
   CursorImSpiel : CursorImSpielArray := (others => LeererWertCursor);
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
   LeererWertEinheit : constant GlobaleRecords.EinheitenGebautRecord := (0, 0,          -- 1. Wert = Aktuelle Beschäftigung, 2. Wert = Zweite aktuelle Beschäftigung
                                                                         0, (0, 1, 1),  -- 3. Wert = ID, 4. Wert = AchsenPosition
                                                                         0, 0.00, 0, 0, -- 5. Wert = Aktuelle Lebenspunkte, 6. Wert = Aktuelle Bewegungspunkte, 7. Wert = Aktuelle Erfahrungspunkte, 8. Wert = Aktueller Rang
                                                                         0, 0,          -- 9. Wert = Aktuelle Beschäftigungszeit, 10. Wert = Zweite AktuelleBeschäftigungszeit
                                                                         (0, 1, 1), KIDatentypen.Keine_Aufgabe);    -- 11. Wert = Zielkoordinaten der KI, 12. Wert = Beschäftigunggrad der KI

   type EinheitenGebautArray is array (GlobaleDatentypen.Rassen'Range, 1 .. 1_000) of GlobaleRecords.EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => LeererWertEinheit));
   -- Einheiten
   
   

   -- Städte
   LeererWertStadt : constant GlobaleRecords.StadtGebautRecord := (0, (0, 1, 1), False, 0, -- 1. Wert = ID, 2. Wert = AchsenPosition, 3. Wert = Am Wasser, 4. Wert = Einwohner
                                                                   0, 0, 0, 0, -- 5. Wert = Aktuelle Nahrungsmittel, 6. Wert = Aktuelle Nahrungsproduktion, 7. Wert = Aktuelle Ressourcen, 8. Wert = Aktuelle Produktionrate
                                                                   0, 0, 0, 0, -- 9. Wert = Aktuelle Geldgewinnung, 10. Wert = Aktuelle Forschungsrate, 11. Wert = Aktuelles Bauprojekt, 12. Wert = Verbleibende Bauzeit
                                                                   0, (others => False), To_Unbounded_Wide_Wide_String (Source => ""), -- 13. Wert = Korruption, 14. Wert = Gebäude Vorhanden, 15. Wert = Stadtname
                                                                   (others => (others => False)), 0, 1, -- 16. Wert = UmgebungBewirtschaftung, 17. Wert = Arbeitende Einwohner, 18. Wert = StadtUmgebungGröße
                                                                   0); -- 19. Wert = KI aktuelle Beschäftigung

   type StadtGebautArray is array (GlobaleDatentypen.Rassen'Range, 1 .. 100) of GlobaleRecords.StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others => (others => LeererWertStadt));
   -- Städte
   
   

   -- Wichtiges Zeug   
   LeererWertWichtigesZeug : constant GlobaleRecords.WichtigesRecord := (0, 0,            -- 1. Wert = Aktuelle Geldmenge, 2. Wert = GeldZugewinn Pro Runde
                                                                         0, 0, 10_000, 0, -- 3. Wert = Forschungsrate, 4. Wert = Aktuelle Forschungsmenge, 5. Wert = Verbleibende Forschungszeit, 6. Wert = Forschungsprojekt
                                                                         (others => False));  -- 7. Wert = Erforscht

   type WichtigesArray is array (GlobaleDatentypen.Rassen'Range) of GlobaleRecords.WichtigesRecord;
   Wichtiges : WichtigesArray := (others => LeererWertWichtigesZeug);
   
   type StatusUntereinander is (Kein_Kontakt, Krieg, Neutral, Offene_Grenzen, Nichtangriffspakt, Defensivbündnis, Offensivbündnis);
   type DiplomatieArray is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.Rassen'Range) of StatusUntereinander;
   Diplomatie : DiplomatieArray := (others => (others => Kein_Kontakt));
   -- Wichtiges Zeug
   
   
  
   -- Cheats
   FeindlicheInformationenSehen : Boolean := False;
   -- Cheats
                                               
end GlobaleVariablen;
