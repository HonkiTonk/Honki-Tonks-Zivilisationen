pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with KartenRecords;
with KartenKonstanten;
with KartenGrundDatentypen;
with KartenVerbesserungDatentypen;

with DatenbankRecords;

package KartenRecordKonstanten is

   LeerKartenKoordinaten : constant KartenRecords.AchsenKartenfeldPositivRecord := (
                                                                                    EAchse => KartenKonstanten.LeerEAchse,
                                                                                    YAchse => KartenKonstanten.LeerYAchse,
                                                                                    XAchse => KartenKonstanten.LeerXAchse
                                                                                   );
   
   LeerKartenListe : constant DatenbankRecords.KartenListeRecord := (
                                                                     Bewertung      => (others => KartenKonstanten.LeerBewertung),
                                                                     Wirtschaft     => (others => (others => KartenKonstanten.LeerWirtschaft)),
                                                                     Kampf          => (others => (others => KartenKonstanten.LeerKampf))
                                                                    );
   
   LeerKartenGrundListe : constant DatenbankRecords.KartenGrundListeRecord := (
                                                                               Passierbarkeit => (others => KartenKonstanten.LeerPassierbarkeit),
                                                                               Bewertung      => (others => KartenKonstanten.LeerBewertung),
                                                                               Wirtschaft     => (others => (others => KartenKonstanten.LeerWirtschaft)),
                                                                               Kampf          => (others => (others => KartenKonstanten.LeerKampf))
                                                                              );

   LeerWeltkarte : constant KartenRecords.KartenRecord := (
                                                           Grund                   => KartenGrundDatentypen.Leer_Grund_Enum,
                                                           Hügel                   => KartenKonstanten.LeerHügel,
                                                           Sichtbar                => (others => KartenKonstanten.LeerSichtbar),
                                                           Fluss                   => KartenGrundDatentypen.Leer_Fluss_Enum,
                                                           Ressource               => KartenGrundDatentypen.Leer_Ressource_Enum,
                                                           Weg                     => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                                           Verbesserung            => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                                           DurchStadtBelegterGrund => KartenKonstanten.LeerDurchStadtBelegterGrund,
                                                           Felderwertung           => (others => KartenKonstanten.LeerFelderwertung)
                                                          );

   KartenformStandard : constant KartenRecords.KartenformRecord := (
                                                                    EAchseOben                       => KartenDatentypen.Karte_E_Achse_Kein_Übergang_Enum,
                                                                    EAchseUnten                      => KartenDatentypen.Karte_E_Achse_Kein_Übergang_Enum,
                                                                    YAchseNorden                     => KartenDatentypen.Karte_Y_Achse_Kein_Übergang_Enum,
                                                                    YAchseSüden                      => KartenDatentypen.Karte_Y_Achse_Kein_Übergang_Enum,
                                                                    XAchseWesten                     => KartenDatentypen.Karte_X_Achse_Übergang_Enum,
                                                                    XAchseOsten                      => KartenDatentypen.Karte_X_Achse_Übergang_Enum,
                                                                    YZuerstBerechnenXZuerstBerechnen => True
                                                                   );

   LeerVerbesserungListe : constant DatenbankRecords.VerbesserungenWegeListeRecord := (
                                                                                       Passierbarkeit => (others => KartenKonstanten.LeerPassierbarkeit),
                                                                                       Bewertung      => (others => KartenKonstanten.LeerVerbesserungBewertung),
                                                                                       Wirtschaft     => (others => (others => KartenKonstanten.LeerVerbesserungWirtschaft)),
                                                                                       Kampf          => (others => (others => KartenKonstanten.LeerVerbesserungKampf))
                                                                                      );
   
   type EisgebietArray is array (KartenDatentypen.Kartengröße_Verwendet_Enum'Range) of KartenDatentypen.KartenfeldPositiv;
   Eisrand : constant EisgebietArray := (
                                         KartenDatentypen.Kartengröße_20_20_Enum     => 1,
                                         KartenDatentypen.Kartengröße_40_40_Enum     => 1,
                                         KartenDatentypen.Kartengröße_80_80_Enum     => 2,
                                         KartenDatentypen.Kartengröße_120_80_Enum    => 3,
                                         KartenDatentypen.Kartengröße_120_160_Enum   => 3,
                                         KartenDatentypen.Kartengröße_160_160_Enum   => 4,
                                         KartenDatentypen.Kartengröße_240_240_Enum   => 6,
                                         KartenDatentypen.Kartengröße_320_320_Enum   => 8,
                                         KartenDatentypen.Kartengröße_1000_1000_Enum => 24,
                                         KartenDatentypen.Kartengröße_Nutzer_Enum    => 1
                                        );

   Eisschild : constant EisgebietArray := (
                                           KartenDatentypen.Kartengröße_20_20_Enum     => 3,
                                           KartenDatentypen.Kartengröße_40_40_Enum     => 3,
                                           KartenDatentypen.Kartengröße_80_80_Enum     => 6,
                                           KartenDatentypen.Kartengröße_120_80_Enum    => 9,
                                           KartenDatentypen.Kartengröße_120_160_Enum   => 9,
                                           KartenDatentypen.Kartengröße_160_160_Enum   => 12,
                                           KartenDatentypen.Kartengröße_240_240_Enum   => 18,
                                           KartenDatentypen.Kartengröße_320_320_Enum   => 24,
                                           KartenDatentypen.Kartengröße_1000_1000_Enum => 72,
                                           KartenDatentypen.Kartengröße_Nutzer_Enum    => 1
                                          );

end KartenRecordKonstanten;
