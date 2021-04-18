pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, GlobaleRecords, KIDatentypen, DatenbankRecords;

package GlobaleKonstanten is

   -- Für die Auswahl
   StartNormalKonstante : constant Integer := 1;
   HauptmenüKonstante : constant Integer := 0;
   SpielBeendenKonstante : constant Integer := -1;
   ZurückKonstante : constant Integer := -2;
   JaKonstante : constant Integer := -3;
   NeinKonstante : constant Integer := -4;
   SpeichernKonstante : constant Integer := 2;
   LadenKonstante : constant Integer := 3;
   OptionenKonstante : constant Integer := 4;
   InformationenKonstante : constant Integer := 5;
   -- Für die Auswahl



   -- Für die Eingabe
   GanzeZahlAbbruchKonstante : constant Integer := -1_000_000_000;
   -- Für die Eingabe



   -- Für die Optionen/Menüs
   JaAnzeigeKonstante : constant Integer := 10;
   NeinAnzeigeKonstante : constant Integer := 11;

   OptionenErsteZeileKonstante : constant Integer := 14;
   OptionenLetzteZeileKonstante : constant Integer := 20;

   OptionenSonstigesErsteZeile : constant Integer := 23;
   OptionenSonstigesLetzteZeile : constant Integer := 27;
   -- Für die Optionen/Menüs



   -- Für Einheiten/Städte
   RückgabeEinheitStadtNummerFalsch : constant GlobaleDatentypen.MaximaleEinheitenMitNullWert := 0;

   GebäudeAufschlag : constant Positive := 1_000;
   EinheitAufschlag : constant Positive := 10_000;
   -- Für Einheiten/Städte



   -- Für die Kartengenerierung
   Eisrand : constant GlobaleDatentypen.KartenfeldPositiv := 1;
   -- Für die Kartengenerierung



   -- Für die Leerwerte
   LeererWertCursor : constant GlobaleRecords.CursorRecord := ('©',       -- 1. Wert = CursorGrafik
                                                               (0, 1, 1), -- 2. Wert = AchsenPosition
                                                               (0, 1, 1), -- 3. Wert = AchsenPositionAlt
                                                               (1, 1));   -- 4. Wert = AchsenPositionStadt

   LeererWertEinheit : constant GlobaleRecords.EinheitenGebautRecord := (0, (0, 1, 1),  -- 1. Wert = ID, 2. Wert = AchsenPosition
                                                                         0, 0.00, 0, 0, -- 3. Wert = Aktuelle Lebenspunkte, 4. Wert = Aktuelle Bewegungspunkte, 5. Wert = Aktuelle Erfahrungspunkte, 6. Wert = Aktueller Rang
                                                                         GlobaleDatentypen.Keine, GlobaleDatentypen.Keine, -- 7. Wert = Aktuelle Beschäftigung, 8. Wert = Zweite Beschäftigung
                                                                         0, 0,          -- 9. Wert = Aktuelle Beschäftigungszeit, 10. Wert = Zweite AktuelleBeschäftigungszeit
                                                                         (0, 1, 1), KIDatentypen.Keine_Aufgabe,    -- 11. Wert = Zielkoordinaten der KI, 12. Wert = Beschäftigunggrad der KI
                                                                         (others => 0), 0); -- 13. Wert = Platznummer der transportierten Einheiten, 14. Wert = Platznummer der transportierenden Einheit

   LeererWertStadt : constant GlobaleRecords.StadtGebautRecord := (0, (0, 1, 1), False, 0, -- 1. Wert = ID, 2. Wert = AchsenPosition, 3. Wert = Am Wasser, 4. Wert = Einwohner
                                                                   0, 0, 0, 0, -- 5. Wert = Aktuelle Nahrungsmittel, 6. Wert = Aktuelle Nahrungsproduktion, 7. Wert = Aktuelle Ressourcen, 8. Wert = Aktuelle Produktionrate
                                                                   0, 0, 0, 0, -- 9. Wert = Aktuelle Geldgewinnung, 10. Wert = Aktuelle Forschungsrate, 11. Wert = Aktuelles Bauprojekt, 12. Wert = Verbleibende Bauzeit
                                                                   0, (others => False), To_Unbounded_Wide_Wide_String (Source => ""), -- 13. Wert = Korruption, 14. Wert = Gebäude Vorhanden, 15. Wert = Stadtname
                                                                   (others => (others => False)), 0, 1, -- 16. Wert = UmgebungBewirtschaftung, 17. Wert = Arbeitende Einwohner, 18. Wert = StadtUmgebungGröße
                                                                   0); -- 19. Wert = KI aktuelle Beschäftigung

   LeererWertWichtigesZeug : constant GlobaleRecords.WichtigesRecord := (0, 0,            -- 1. Wert = Aktuelle Geldmenge, 2. Wert = GeldZugewinn Pro Runde
                                                                         0, 0, 10_000, 0, -- 3. Wert = Forschungsrate, 4. Wert = Aktuelle Forschungsmenge, 5. Wert = Verbleibende Forschungszeit, 6. Wert = Forschungsprojekt
                                                                         (others => False));  -- 7. Wert = Erforscht

   LeererWertKartenListe : constant DatenbankRecords.KartenListeRecord := (' ', -- 1. Wert = KartenGrafik
                                                                           1, -- 2. Wert = Passierbarkeit
                                                                           0, 0, 0, 0, 0); -- 3. Wert = Nahrungsgewinnung, 4. Wert = Ressourcengewinnung, 5. Wert = Geldgewinnung, 6. Wert = Wissensgewinnung,
                                                                                           -- 7. Wert = Verteidigungsbonus

   LeererWertWeltkarte : constant GlobaleRecords.KartenRecord := (0, False, (others => False), -- 1. Wert = Kartengrund, 2. Wert = Ist da ein Hügel?, 3. Wert = Welche Rasse kann was sehen
                                                                  0, 0, 0, 0, -- 4. Wert = Welcher Fluss, 5. Wert = Welche Straße, 6. Wert = Welche Verbesserung, 7. Wert = Welche Ressource
                                                                  0, 0); -- 8. Wert = Durch welche Stadt welcher Rasse belegter Grund, 9. Wert = Felderbewertung
   -- Für die Leerwerte

end GlobaleKonstanten;
