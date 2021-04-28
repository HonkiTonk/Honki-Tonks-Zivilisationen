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
   JaAnzeigeKonstante : constant Integer := 7;
   NeinAnzeigeKonstante : constant Integer := 8;

   OptionenErsteZeileKonstante : constant Integer := 9;
   OptionenLetzteZeileKonstante : constant Integer := 15;

   OptionenSonstigesErsteZeile : constant Integer := 16;
   OptionenSonstigesLetzteZeile : constant Integer := 20;
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
   LeererWertCursor : constant GlobaleRecords.CursorRecord := ('©',       -- CursorGrafik
                                                               (0, 0, 0), -- AchsenPosition
                                                               (0, 0, 0), -- AchsenPositionAlt
                                                               (1, 1));   -- AchsenPositionStadt

   LeererWertEinheit : constant GlobaleRecords.EinheitenGebautRecord := (0, (0, 0, 0), -- ID, AchsenPosition
                                                                         0, 0.00, 0, 0, -- Aktuelle Lebenspunkte, Aktuelle Bewegungspunkte, Aktuelle Erfahrungspunkte, Aktueller Rang
                                                                         GlobaleDatentypen.Keine, GlobaleDatentypen.Keine, -- Aktuelle Beschäftigung, Zweite Beschäftigung
                                                                         0, 0, -- Aktuelle Beschäftigungszeit, Zweite AktuelleBeschäftigungszeit
                                                                         (0, 1, 1), KIDatentypen.Keine_Aufgabe, -- Zielkoordinaten der KI, Beschäftigunggrad der KI
                                                                         (others => 0), 0); -- Platznummer der transportierten Einheiten, Platznummer der transportierenden Einheit

   LeererWertStadt : constant GlobaleRecords.StadtGebautRecord := (0, (0, 0, 0), False, 0, -- ID, AchsenPosition,Am Wasser, Einwohner
                                                                   0, 0, 0, 0, -- Aktuelle Nahrungsmittel, Aktuelle Nahrungsproduktion, Aktuelle Ressourcen, Aktuelle Produktionrate
                                                                   0, 0, 0, 0, -- Aktuelle Geldgewinnung, Aktuelle Forschungsrate, Aktuelles Bauprojekt, Verbleibende Bauzeit
                                                                   0, (others => False), To_Unbounded_Wide_Wide_String (Source => ""), -- Korruption, Gebäude Vorhanden, Stadtname
                                                                   (others => (others => False)), 0, 1, -- UmgebungBewirtschaftung, Arbeitende Einwohner, StadtUmgebungGröße
                                                                   KIDatentypen.Keine_Aufgabe); -- 19. Wert = KI aktuelle Beschäftigung

   LeererWertWichtigesZeug : constant GlobaleRecords.WichtigesRecord := (0, 0, -- Aktuelle Geldmenge, GeldZugewinn Pro Runde
                                                                         0, 0, 10_000, 0, -- Forschungsrate, Aktuelle Forschungsmenge, Verbleibende Forschungszeit, Forschungsprojekt
                                                                         (others => False)); -- Erforscht

   LeererWertKartenListe : constant DatenbankRecords.KartenListeRecord := (' ', -- KartenGrafik
                                                                           1, -- Passierbarkeit
                                                                           0, 0, 0, 0, 0); -- Nahrungsgewinnung, Ressourcengewinnung, Geldgewinnung, Wissensgewinnung, Verteidigungsbonus

   LeererWertWeltkarte : constant GlobaleRecords.KartenRecord := (0, False, (others => False), -- Kartengrund, Ist da ein Hügel?, Welche Rasse kann was sehen
                                                                  0, 0, 0, 0, -- Welcher Fluss, Welche Straße, Welche Verbesserung, Welche Ressource
                                                                  0, 0); -- Durch welche Stadt welcher Rasse belegter Grund, Felderbewertung
   -- Für die Leerwerte

end GlobaleKonstanten;
