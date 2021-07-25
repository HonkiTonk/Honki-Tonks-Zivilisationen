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
   -- Wird für die Textanzeige benötigt
   EinheitBefehlAbzug : constant Positive := 19;

   RückgabeEinheitStadtNummerFalsch : constant GlobaleDatentypen.MaximaleEinheitenMitNullWert := 0;

   GebäudeAufschlag : constant Positive := 1_000;
   EinheitAufschlag : constant Positive := 10_000;

   RassenMulitplikationWert : constant GlobaleDatentypen.BelegterGrund := 1_000;
   type FeldBelegungArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.Anfang_Ende_Verwendet'Range) of GlobaleDatentypen.BelegterGrund;
   FeldBelegung : constant FeldBelegungArray := (
                                                 GlobaleDatentypen.Rasse_1 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (1) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (1) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_2 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (2) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (2) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_3 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (3) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (3) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_4 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (4) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (4) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_5 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (5) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (5) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_6 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (6) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (6) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_7 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (7) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (7) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_8 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (8) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (8) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_9 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (9) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (9) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_10 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (10) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (10) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_11 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (11) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (11) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_12 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (12) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (12) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_13 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (13) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (13) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_14 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (14) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (14) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_15 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (15) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (15) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_16 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (16) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (16) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_17 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (17) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (17) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last)),

                                                 GlobaleDatentypen.Rasse_18 =>
                                                   (
                                                    GlobaleDatentypen.Anfangswert => GlobaleDatentypen.BelegterGrund (18) * RassenMulitplikationWert,
                                                    GlobaleDatentypen.Endwert => GlobaleDatentypen.BelegterGrund (18) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last))
                                                );
   -- Für Einheiten/Städte



   -- Für die Kartengenerierung
   Eisrand : constant GlobaleDatentypen.LoopRangeMinusEinsZuEins := 1;
   Eisschild : constant GlobaleDatentypen.LoopRangeMinusDreiZuDrei := 3;
   -- Für die Kartengenerierung



   -- Für den KartePositionPruefen.KartenPositionBestimmen Rückgabewert
   RückgabeKartenPositionFalsch : constant GlobaleRecords.AchsenKartenfeldPositivRecord := (GlobaleDatentypen.EbeneVorhanden'First,
                                                                                             GlobaleDatentypen.KartenfeldPositivMitNullwert'First,
                                                                                             GlobaleDatentypen.KartenfeldPositivMitNullwert'First);
   -- Für den KartePositionPruefen.KartenPositionBestimmen Rückgabewert



   -- Für die Leerwerte
   LeererWertCursor : constant GlobaleRecords.CursorRecord := (
                                                               -- CursorGrafik
                                                               '©',
                                                               -- AchsenPosition
                                                               (0, 0, 0),
                                                               -- AchsenPositionAlt
                                                               (0, 0, 0),
                                                               -- AchsenPositionStadt
                                                               (1, 1)
                                                              );

   LeererWertEinheit : constant GlobaleRecords.EinheitenGebautRecord := (
                                                                         -- ID, AchsenPosition
                                                                         0, (0, 0, 0),
                                                                         -- Lebenspunkte, Bewegungspunkte, Erfahrungspunkte, Rang
                                                                         0, 0.00, 0, 0,
                                                                         -- Beschäftigung, Zweite Beschäftigung
                                                                         GlobaleDatentypen.Nicht_Vorhanden, GlobaleDatentypen.Nicht_Vorhanden,
                                                                         -- Beschäftigungszeit, Zweite Beschäftigungszeit
                                                                         0, 0,
                                                                         -- Zielkoordinaten der KI, Beschäftigung der KI, Bewegungsplan der KI
                                                                         (0, 0, 0), KIDatentypen.Keine_Aufgabe, (others => (0, 0, 0)),
                                                                         -- Platznummer der transportierten Einheiten, Platznummer der transportierenden Einheit
                                                                         (others => 0), 0
                                                                        );

   LeererWertStadt : constant GlobaleRecords.StadtGebautRecord := (
                                                                   -- ID, AchsenPosition, Am Wasser, (Einwohner, Arbeiter)
                                                                   GlobaleDatentypen.Leer, (0, 0, 0), False, (0 , 0),
                                                                   -- Aktuelle Nahrungsmittel, Aktuelle Nahrungsproduktion, Aktuelle Ressourcen, Aktuelle Produktionrate
                                                                   0, 0, 0, 0,
                                                                   -- Aktuelle Geldgewinnung, Aktuelle Forschungsrate, Aktuelles Bauprojekt, Verbleibende Bauzeit
                                                                   0, 0, 0, 0,
                                                                   -- Korruption, Gebäude Vorhanden, Stadtname
                                                                   0, (others => False), To_Unbounded_Wide_Wide_String (Source => ""),
                                                                   -- UmgebungBewirtschaftung, UmgebungGröße
                                                                   (others => (others => False)), 1,
                                                                   -- Aktuelle Meldungen
                                                                   (others => GlobaleDatentypen.Keine),
                                                                   -- KI aktuelle Beschäftigung
                                                                   KIDatentypen.Keine_Aufgabe
                                                                  );

   LeererWertWichtigesZeug : constant GlobaleRecords.WichtigesRecord := (
                                                                         -- Aktuelle Geldmenge, GeldZugewinn Pro Runde
                                                                         0, 0,
                                                                         -- Forschungsrate, Aktuelle Forschungsmenge, Verbleibende Forschungszeit, Forschungsprojekt
                                                                         0, 0, 10_000, 0,
                                                                         -- Erforscht
                                                                         (others => False)
                                                                        );

   LeererWertKartenListe : constant DatenbankRecords.KartenListeRecord := (
                                                                           -- KartenGrafik
                                                                           ' ',
                                                                           -- Passierbarkeit
                                                                           (others => False),
                                                                           -- Nahrungsgewinnung, Ressourcengewinnung, Geldgewinnung, Wissensgewinnung, Verteidigungsbonus
                                                                           0, 0, 0, 0, 0
                                                                          );

   LeererWertWeltkarte : constant GlobaleRecords.KartenRecord := (
                                                                  -- Kartengrund, Ist da ein Hügel?, Welche Rasse kann was sehen
                                                                  GlobaleDatentypen.Leer, False, (others => False),
                                                                  -- Welcher Fluss, Welche Straße, Welche Verbesserung, Welche Ressource
                                                                  GlobaleDatentypen.Leer, GlobaleDatentypen.Leer, GlobaleDatentypen.Leer, GlobaleDatentypen.Leer,
                                                                  -- Durch welche Stadt welcher Rasse belegter Grund, Felderbewertung
                                                                  0, 0
                                                                 );

   LeererWertVerbesserungListe : constant DatenbankRecords.VerbesserungListeRecord := (
                                                                                       -- VerbesserungGrafik
                                                                                       ' ',
                                                                                       -- Passierbarkeit
                                                                                       (others => False),
                                                                                       -- Nahrungsbonus, Ressourcenbonus, Geldbonus, Wissensbonus, Verteidigungsbonus
                                                                                       0, 0, 0, 0, 0
                                                                                      );

   LeererWertEinheitListe : constant DatenbankRecords.EinheitenListeRecord := (
                                                                               -- EinheitenGrafik, EinheitTyp, PreisGeld, PreisRessourcen, Anforderungen
                                                                               '@', GlobaleDatentypen.Leer, 0, 0, 0,
                                                                               -- Passierbarkeit
                                                                               (others => False),
                                                                               -- MaximaleLebenspunkte, MaximaleBewegungspunkte, WirdVerbesserZu
                                                                               1, 0.00, 0,
                                                                               -- Beförderungsgrenze, MaximalerRang, Reichweite, Angriff, Verteidigung
                                                                               1, 1, 0, 0, 1,
                                                                               -- Kann Dinge transportieren, Kann transportiert werden, Transportkapazität
                                                                               0, 0, 0
                                                                              );

   LeererWertForschungListe : constant DatenbankRecords.ForschungListeRecord := (
                                                                                 -- PreisForschung, AnforderungForschung
                                                                                 0, (others => 0)
                                                                                );

   LeererWertGebäudeListe : constant DatenbankRecords.GebäudeListeRecord := (
                                                                               -- GebäudeGrafik, PreisGeld, PreisRessourcen, Anforderungen, PermanenteKosten
                                                                               ' ', 0, 0, 0, 0,
                                                                               -- ProduktionBonus, GeldBonus, WissenBonus, VerteidigungBonus, NahrungBonus, Anderes
                                                                               0, 0, 0, 0, 0, False
                                                                              );
   -- Für die Leerwerte

   -- Für die grafische Anzeige
   NichtSichtbar : constant Wide_Wide_Character := ' ';
   -- Für die grafische Anzeige

end GlobaleKonstanten;
