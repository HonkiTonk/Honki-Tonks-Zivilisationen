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

   LeerEinheitStadtNummer : constant GlobaleDatentypen.MaximaleEinheitenMitNullWert := GlobaleDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerTransportiertWirdTransportiert :constant GlobaleDatentypen.MaximaleEinheitenMitNullWert := GlobaleDatentypen.MaximaleEinheitenMitNullWert'First;

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
   LeerKartenPosition : constant GlobaleRecords.AchsenKartenfeldPositivRecord := (EAchse => GlobaleDatentypen.EbeneVorhanden'First,
                                                                                  YAchse => GlobaleDatentypen.KartenfeldPositivMitNullwert'First,
                                                                                  XAchse => GlobaleDatentypen.KartenfeldPositivMitNullwert'First);

   LeerYXKartenWert : constant GlobaleDatentypen.KartenfeldPositivMitNullwert := GlobaleDatentypen.KartenfeldPositivMitNullwert'First;
   -- Für den KartePositionPruefen.KartenPositionBestimmen Rückgabewert



   -- Für die Leerwerte
   LeerCursor : constant GlobaleRecords.CursorRecord := (
                                                         CursorGrafik  => '©',
                                                         Position      => (0, 0, 0),
                                                         PositionAlt   => (0, 0, 0),
                                                         PositionStadt => (1, 1)
                                                        );

   LeerEinheit : constant GlobaleRecords.EinheitenGebautRecord := (
                                                                   ID                           => 0,
                                                                   Position                     => (0, 0, 0),
                                                                   Heimatstadt                  => 0,
                                                                   Lebenspunkte                 => 0,
                                                                   Bewegungspunkte              => 0.00,
                                                                   Erfahrungspunkte             => 0,
                                                                   Rang                         => 0,
                                                                   Beschäftigung                => GlobaleDatentypen.Nicht_Vorhanden,
                                                                   BeschäftigungNachfolger      => GlobaleDatentypen.Nicht_Vorhanden,
                                                                   Beschäftigungszeit           => 0,
                                                                   BeschäftigungszeitNachfolger => 0,
                                                                   KIZielKoordinaten            => (0, 0, 0),
                                                                   KIBeschäftigt                => KIDatentypen.Keine_Aufgabe,
                                                                   KIBewegungPlan               => (others => (0, 0, 0)),
                                                                   Transportiert                => (others => 0),
                                                                   WirdTransportiert            => 0
                                                                  );

   LeerStadt : constant GlobaleRecords.StadtGebautRecord := (
                                                             ID                      => GlobaleDatentypen.Leer,
                                                             Position                => (0, 0, 0),
                                                             AmWasser                => False,
                                                             EinwohnerArbeiter       => (0 , 0),
                                                             Nahrungsmittel          => 0,
                                                             Nahrungsproduktion      => 0,
                                                             Ressourcen              => 0,
                                                             Produktionrate          => 0,
                                                             Geldgewinnung           => 0,
                                                             Forschungsrate          => 0,
                                                             Bauprojekt              => 0,
                                                             Bauzeit                 => 0,
                                                             Korruption              => 0,
                                                             GebäudeVorhanden        => (others => False),
                                                             Name                    => To_Unbounded_Wide_Wide_String (Source => ""),
                                                             UmgebungBewirtschaftung => (others => (others => False)),
                                                             UmgebungGröße           => 1,
                                                             Meldungen               => (others => GlobaleDatentypen.Leer),
                                                             KIBeschäftigung         => KIDatentypen.Keine_Aufgabe
                                                            );

   LeerWichtigesZeug : constant GlobaleRecords.WichtigesRecord := (
                                                                   Geldmenge                  => 0,
                                                                   GeldZugewinnProRunde       => 0,
                                                                   GesamteForschungsrate      => 0,
                                                                   Forschungsmenge            => 0,
                                                                   VerbleibendeForschungszeit => 10_000,
                                                                   Forschungsprojekt          => 0,
                                                                   Erforscht                  => (others => False)
                                                                  );

   LeerKartenListe : constant DatenbankRecords.KartenListeRecord := (
                                                                     KartenGrafik        => ' ',
                                                                     Passierbarkeit      => (others => False),
                                                                     Nahrungsgewinnung   => 0,
                                                                     Ressourcengewinnung => 0,
                                                                     Geldgewinnung       => 0,
                                                                     Wissensgewinnung    => 0,
                                                                     Verteidigungsbonus  => 0
                                                                    );

   LeerWeltkarte : constant GlobaleRecords.KartenRecord := (
                                                            Grund                   => GlobaleDatentypen.Leer,
                                                            Hügel                   => False,
                                                            Sichtbar                => (others => False),
                                                            Fluss                   => GlobaleDatentypen.Leer,
                                                            VerbesserungStraße      => GlobaleDatentypen.Leer,
                                                            VerbesserungGebiet      => GlobaleDatentypen.Leer,
                                                            Ressource               => GlobaleDatentypen.Leer,
                                                            DurchStadtBelegterGrund => 0,
                                                            Felderwertung           => 0
                                                           );

   LeerVerbesserungListe : constant DatenbankRecords.VerbesserungListeRecord := (
                                                                                 VerbesserungGrafik => ' ',
                                                                                 Passierbarkeit     => (others => False),
                                                                                 Nahrungsbonus      => 0,
                                                                                 Ressourcenbonus    => 0,
                                                                                 Geldbonus          => 0,
                                                                                 Wissensbonus       => 0,
                                                                                 Verteidigungsbonus => 0
                                                                                );

   LeerEinheitListe : constant DatenbankRecords.EinheitenListeRecord := (
                                                                         EinheitenGrafik            => '@',
                                                                         EinheitArt                 => GlobaleDatentypen.Leer,
                                                                         PreisGeld                  => 0,
                                                                         PreisRessourcen            => 0,
                                                                         PermanenteKosten           => (others => 0),
                                                                         Anforderungen              => 0,
                                                                         Passierbarkeit             => (others => False),
                                                                         MaximaleLebenspunkte       => 1,
                                                                         MaximaleBewegungspunkte    => 0.00,
                                                                         WirdVerbessertZu           => 0,
                                                                         Beförderungsgrenze         => 1,
                                                                         MaximalerRang              => 1,
                                                                         Reichweite                 => 0,
                                                                         Angriff                    => 0,
                                                                         Verteidigung               => 1,
                                                                         KannTransportieren         => 0,
                                                                         KannTransportiertWerden    => 0,
                                                                         Transportkapazität         => 0
                                                                        );

   LeerForschungListe : constant DatenbankRecords.ForschungListeRecord := (
                                                                           PreisForschung       => 0,
                                                                           AnforderungForschung => (others => 0)
                                                                          );

   LeerGebäudeListe : constant DatenbankRecords.GebäudeListeRecord := (
                                                                         GebäudeGrafik               => ' ',
                                                                         PreisGeld                   => 0,
                                                                         PreisRessourcen             => 0,
                                                                         PermanenteKosten            => (others => 0),
                                                                         Anforderungen               => 0,
                                                                         ProduktionBonus             => 0,
                                                                         GeldBonus                   => 0,
                                                                         WissenBonus                 => 0,
                                                                         VerteidigungBonus           => 0,
                                                                         NahrungBonus                => 0,
                                                                         GebäudeSpezielleEigenschaft => GlobaleDatentypen.Leer
                                                                        );

   LeerRassenList : constant DatenbankRecords.RassenListeRecord := (
                                                                    Aggressivität       => 0,
                                                                    Expansion           => 0,
                                                                    Wissenschaft        => 0,
                                                                    Produktion          => 0,
                                                                    Wirtschaft          => 0,
                                                                    Bewirtschaftung     => 0,
                                                                    GültigeStaatsformen => (GlobaleDatentypen.Anarchie,
                                                                                             GlobaleDatentypen.Anarchie,
                                                                                             GlobaleDatentypen.Anarchie,
                                                                                             GlobaleDatentypen.Anarchie,
                                                                                             GlobaleDatentypen.Anarchie)
                                                                   );
   -- Für die Leerwerte

   -- Für die grafische Anzeige
   NichtSichtbar : constant Wide_Wide_Character := ' ';
   -- Für die grafische Anzeige

end GlobaleKonstanten;
