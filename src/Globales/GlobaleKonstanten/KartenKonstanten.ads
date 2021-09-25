pragma SPARK_Mode (On);

with GlobaleDatentypen, KartenRecords;

with DatenbankRecords;

package KartenKonstanten is
   
   -- Für die grafische Anzeige
   NichtSichtbar : constant Wide_Wide_Character := ' ';
   -- Für die grafische Anzeige
   
   

   -- Für die Kartengenerierung
   -- An Kartengröße und/oder Temperatur anpassen?
   type EisgebietArray is array (GlobaleDatentypen.Kartengröße_Verwendet_Enum'Range) of GlobaleDatentypen.KartenfeldPositiv;
   Eisrand : constant EisgebietArray := (
                                         GlobaleDatentypen.Karte_20_20     => 1,
                                         GlobaleDatentypen.Karte_40_40     => 1,
                                         GlobaleDatentypen.Karte_80_80     => 2,
                                         GlobaleDatentypen.Karte_120_80    => 3,
                                         GlobaleDatentypen.Karte_120_160   => 3,
                                         GlobaleDatentypen.Karte_160_160   => 4,
                                         GlobaleDatentypen.Karte_240_240   => 6,
                                         GlobaleDatentypen.Karte_320_320   => 8,
                                         GlobaleDatentypen.Karte_1000_1000 => 24,
                                         GlobaleDatentypen.Karte_Nutzer    => 1
                                        );

   Eisschild : constant EisgebietArray := (
                                           GlobaleDatentypen.Karte_20_20     => 3,
                                           GlobaleDatentypen.Karte_40_40     => 3,
                                           GlobaleDatentypen.Karte_80_80     => 6,
                                           GlobaleDatentypen.Karte_120_80    => 9,
                                           GlobaleDatentypen.Karte_120_160   => 9,
                                           GlobaleDatentypen.Karte_160_160   => 12,
                                           GlobaleDatentypen.Karte_240_240   => 18,
                                           GlobaleDatentypen.Karte_320_320   => 24,
                                           GlobaleDatentypen.Karte_1000_1000 => 72,
                                           GlobaleDatentypen.Karte_Nutzer    => 1
                                          );
   -- Für die Kartengenerierung



   -- Für den KartePositionPruefen.KartenPositionBestimmen Rückgabewert
   LeerKartenPosition : constant KartenRecords.AchsenKartenfeldPositivRecord := (EAchse => GlobaleDatentypen.EbeneVorhanden'First,
                                                                                 YAchse => GlobaleDatentypen.KartenfeldPositivMitNullwert'First,
                                                                                 XAchse => GlobaleDatentypen.KartenfeldPositivMitNullwert'First);

   LeerYXKartenWert : constant GlobaleDatentypen.KartenfeldPositivMitNullwert := GlobaleDatentypen.KartenfeldPositivMitNullwert'First;
   -- Für den KartePositionPruefen.KartenPositionBestimmen Rückgabewert
   
   LeerKartenListe : constant DatenbankRecords.KartenListeRecord := (
                                                                     KartenGrafik        => NichtSichtbar,
                                                                     Passierbarkeit      => (others => False),
                                                                     FeldWerte           => (others => (others => 0))
                                                                    );

   LeerWeltkarte : constant KartenRecords.KartenRecord := (
                                                           Grund                   => GlobaleDatentypen.Leer,
                                                           Hügel                   => False,
                                                           Sichtbar                => (others => False),
                                                           Fluss                   => GlobaleDatentypen.Leer,
                                                           VerbesserungWeg         => GlobaleDatentypen.Leer,
                                                           VerbesserungGebiet      => GlobaleDatentypen.Leer,
                                                           Ressource               => GlobaleDatentypen.Leer,
                                                           DurchStadtBelegterGrund => 0,
                                                           Felderwertung           => (others => 0)
                                                          );

   LeerVerbesserungListe : constant DatenbankRecords.VerbesserungListeRecord := (
                                                                                 VerbesserungGrafik => NichtSichtbar,
                                                                                 Passierbarkeit     => (others => False),
                                                                                 VerbesserungWerte  => (others => (others => 0))
                                                                                );

end KartenKonstanten;
