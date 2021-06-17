pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with KIDatentypen;

with DatenbankRecords;

package GlobaleKonstanten is

   -- Für die Auswahl
   StartNormalKonstante : constant Positive := 1;
   HauptmenüKonstante : constant Natural := 0;
   SpielBeendenKonstante : constant Integer := -1;
   ZurückKonstante : constant Integer := -2;
   JaKonstante : constant Integer := -3;
   NeinKonstante : constant Integer := -4;
   SpeichernKonstante : constant Positive := 2;
   LadenKonstante : constant Positive := 3;
   OptionenKonstante : constant Positive := 4;
   InformationenKonstante : constant Positive := 5;
   WiederherstellenKonstante : constant Positive := 6;
   WürdigungenKonstante : constant Positive := 7;
   -- Für die Auswahl



   -- Für die Eingabe
   GanzeZahlAbbruchKonstante : constant Integer := -1_000_000_000;
   -- Für die Eingabe



   -- Für die Optionen/Menüs
   JaAnzeigeKonstante : constant Positive := 7;
   NeinAnzeigeKonstante : constant Positive := 8;

   OptionenErsteZeileKonstante : constant Positive := 9;
   OptionenLetzteZeileKonstante : constant Positive := 15;

   OptionenSonstigesErsteZeile : constant Positive := 16;
   OptionenSonstigesLetzteZeile : constant Positive := 20;
   -- Für die Optionen/Menüs



   -- Für Einheiten/Städte
   EinheitBefehlAbzug : constant Positive := 19;

   RückgabeEinheitStadtNummerFalsch : constant GlobaleDatentypen.MaximaleEinheitenMitNullWert := 0;

   GebäudeAufschlag : constant Positive := 1_000;
   EinheitAufschlag : constant Positive := 10_000;

   RassenMulitplikationWert : constant GlobaleDatentypen.BelegterGrund := 1_000;
   type FeldBelegungArray is array (GlobaleDatentypen.Rassen'Range, 1 .. 2) of GlobaleDatentypen.BelegterGrund;
   FeldBelegung : constant FeldBelegungArray := (1 => (1 => GlobaleDatentypen.BelegterGrund (1) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (1) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 2 => (1 => GlobaleDatentypen.BelegterGrund (2) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (2) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 3 => (1 => GlobaleDatentypen.BelegterGrund (3) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (3) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 4 => (1 => GlobaleDatentypen.BelegterGrund (4) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (4) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 5 => (1 => GlobaleDatentypen.BelegterGrund (5) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (5) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 6 => (1 => GlobaleDatentypen.BelegterGrund (6) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (6) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 7 => (1 => GlobaleDatentypen.BelegterGrund (7) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (7) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 8 => (1 => GlobaleDatentypen.BelegterGrund (8) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (8) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 9 => (1 => GlobaleDatentypen.BelegterGrund (9) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (9) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 10 => (1 => GlobaleDatentypen.BelegterGrund (10) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (10) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 11 => (1 => GlobaleDatentypen.BelegterGrund (11) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (11) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 12 => (1 => GlobaleDatentypen.BelegterGrund (12) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (12) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 13 => (1 => GlobaleDatentypen.BelegterGrund (13) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (13) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 14 => (1 => GlobaleDatentypen.BelegterGrund (14) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (14) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 15 => (1 => GlobaleDatentypen.BelegterGrund (15) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (15) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 16 => (1 => GlobaleDatentypen.BelegterGrund (16) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (16) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 17 => (1 => GlobaleDatentypen.BelegterGrund (17) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (17) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 18 => (1 => GlobaleDatentypen.BelegterGrund (18) * RassenMulitplikationWert,
                                                       2 => GlobaleDatentypen.BelegterGrund (18) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)));
   -- Für Einheiten/Städte



   -- Für die Kartengenerierung
   Eisrand : constant GlobaleDatentypen.KartenfeldPositiv := 1;
   -- Für die Kartengenerierung



   -- Für den KartenPruefungen.KartenPositionBestimmen Rückgabewert
   RückgabeKartenPositionFalsch : constant GlobaleRecords.AchsenKartenfeldPositivRecord := (GlobaleDatentypen.EbeneVorhanden'First,
                                                                                             GlobaleDatentypen.KartenfeldPositivMitNullwert'First,
                                                                                             GlobaleDatentypen.KartenfeldPositivMitNullwert'First);
   -- Für den KartenPruefungen.KartenPositionBestimmen Rückgabewert



   -- Für die Leerwerte
   LeererWertCursor : constant GlobaleRecords.CursorRecord := ('©',       -- CursorGrafik
                                                               (0, 0, 0), -- AchsenPosition
                                                               (0, 0, 0), -- AchsenPositionAlt
                                                               (1, 1));   -- AchsenPositionStadt

   LeererWertEinheit : constant GlobaleRecords.EinheitenGebautRecord := (0, (0, 0, 0), -- ID, AchsenPosition
                                                                         0, 0.00, 0, 0, -- Aktuelle Lebenspunkte, Aktuelle Bewegungspunkte, Aktuelle Erfahrungspunkte, Aktueller Rang
                                                                         GlobaleDatentypen.Keine, GlobaleDatentypen.Keine, -- Aktuelle Beschäftigung, Zweite Beschäftigung
                                                                         0, 0, -- Aktuelle Beschäftigungszeit, Zweite AktuelleBeschäftigungszeit
                                                                         (0, 0, 0), KIDatentypen.Keine_Aufgabe, (others => (0, 0, 0)), -- Zielkoordinaten der KI, Beschäftigung der KI, Bewegungsplan der KI
                                                                         (others => 0), 0); -- Platznummer der transportierten Einheiten, Platznummer der transportierenden Einheit

   LeererWertStadt : constant GlobaleRecords.StadtGebautRecord := (0, (0, 0, 0), False, (0 , 0),
                                                                   -- ID, AchsenPosition, Am Wasser, (Einwohner, Arbeiter)
                                                                   0, 0, 0, 0,
                                                                   -- Aktuelle Nahrungsmittel, Aktuelle Nahrungsproduktion, Aktuelle Ressourcen, Aktuelle Produktionrate
                                                                   0, 0, 0, 0,
                                                                   -- Aktuelle Geldgewinnung, Aktuelle Forschungsrate, Aktuelles Bauprojekt, Verbleibende Bauzeit
                                                                   0, (others => False), To_Unbounded_Wide_Wide_String (Source => ""),
                                                                   -- Korruption, Gebäude Vorhanden, Stadtname
                                                                   (others => (others => False)), 1,
                                                                   -- UmgebungBewirtschaftung, UmgebungGröße
                                                                   (others => GlobaleDatentypen.Keine),
                                                                   -- Aktuelle Meldungen
                                                                   KIDatentypen.Keine_Aufgabe);
   -- KI aktuelle Beschäftigung

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


   -- Für die grafische Anzeige
   NichtSichtbar : constant Wide_Wide_Character := ' ';
   -- Für die grafische Anzeige

end GlobaleKonstanten;
