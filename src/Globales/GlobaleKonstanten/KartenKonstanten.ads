pragma SPARK_Mode (On);

pragma SPARK_Mode (On);

with GlobaleDatentypen, KartenRecords, SystemKonstanten;

with DatenbankRecords;

package KartenKonstanten is

   LeerEAchse : constant GlobaleDatentypen.EbeneVorhanden := GlobaleDatentypen.EbeneVorhanden'First;
   LeerYAchse : constant GlobaleDatentypen.KartenfeldPositivMitNullwert := GlobaleDatentypen.KartenfeldPositivMitNullwert'First;
   LeerXAchse : constant GlobaleDatentypen.KartenfeldPositivMitNullwert := GlobaleDatentypen.KartenfeldPositivMitNullwert'First;

   LeerKartenPosition : constant KartenRecords.AchsenKartenfeldPositivRecord := (EAchse => LeerEAchse,
                                                                                 YAchse => LeerYAchse,
                                                                                 XAchse => LeerXAchse);
   
   LeerKartenGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
   LeerPassierbarkeit : constant Boolean := False;
   LeerFeldWerte : constant GlobaleDatentypen.ProduktionElement := 0;
   
   LeerKartenListe : constant DatenbankRecords.KartenListeRecord := (
                                                                     KartenGrafik        => LeerKartenGrafik,
                                                                     Passierbarkeit      => (others => LeerPassierbarkeit),
                                                                     FeldWerte           => (others => (others => LeerFeldWerte))
                                                                    );
   
   LeerGrund : constant GlobaleDatentypen.Karten_Grund_Enum := GlobaleDatentypen.Leer;
   LeerHügel : constant Boolean := False;
   LeerSichtbar : constant Boolean := False;
   LeerFluss : constant GlobaleDatentypen.Karten_Grund_Enum := GlobaleDatentypen.Leer;
   LeerVerbesserungWeg : constant GlobaleDatentypen.Karten_Verbesserung_Enum := GlobaleDatentypen.Leer;
   LeerVerbesserungGebiet : constant GlobaleDatentypen.Karten_Verbesserung_Enum := GlobaleDatentypen.Leer;
   LeerRessource : constant GlobaleDatentypen.Karten_Grund_Enum := GlobaleDatentypen.Leer;
   LeerDurchStadtBelegterGrund : constant GlobaleDatentypen.BelegterGrund := GlobaleDatentypen.BelegterGrund'First;
   LeerFelderwertung : constant GlobaleDatentypen.GesamtproduktionStadt := 0;

   LeerWeltkarte : constant KartenRecords.KartenRecord := (
                                                           Grund                   => LeerGrund,
                                                           Hügel                   => LeerHügel,
                                                           Sichtbar                => (others => LeerSichtbar),
                                                           Fluss                   => LeerFluss,
                                                           VerbesserungWeg         => LeerVerbesserungWeg,
                                                           VerbesserungGebiet      => LeerVerbesserungGebiet,
                                                           Ressource               => LeerRessource,
                                                           DurchStadtBelegterGrund => LeerDurchStadtBelegterGrund,
                                                           Felderwertung           => (others => LeerFelderwertung)
                                                          );
   
   LeerVerbesserungGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
   LeerVerbesserungWerte : constant GlobaleDatentypen.ProduktionElement := 0;

   LeerVerbesserungListe : constant DatenbankRecords.VerbesserungListeRecord := (
                                                                                 VerbesserungGrafik => LeerVerbesserungGrafik,
                                                                                 Passierbarkeit     => (others => LeerPassierbarkeit),
                                                                                 VerbesserungWerte  => (others => (others => LeerVerbesserungWerte))
                                                                                );
   
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

end KartenKonstanten;
