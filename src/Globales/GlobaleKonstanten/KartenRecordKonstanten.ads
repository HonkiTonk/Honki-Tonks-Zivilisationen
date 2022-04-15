pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;
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
                                                                    EAchseEinstellung                => RueckgabeDatentypen.Karte_E_Achse_Kein_Übergang_Enum,
                                                                    YAchseEinstellung                => RueckgabeDatentypen.Karte_Y_Achse_Kein_Übergang_Enum,
                                                                    XAchseEinstellung                => RueckgabeDatentypen.Karte_X_Achse_Übergang_Enum,
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
                                         RueckgabeDatentypen.Karte_Größe_20_20_Enum     => 1,
                                         RueckgabeDatentypen.Karte_Größe_40_40_Enum     => 1,
                                         RueckgabeDatentypen.Karte_Größe_80_80_Enum     => 2,
                                         RueckgabeDatentypen.Karte_Größe_120_80_Enum    => 3,
                                         RueckgabeDatentypen.Karte_Größe_120_160_Enum   => 3,
                                         RueckgabeDatentypen.Karte_Größe_160_160_Enum   => 4,
                                         RueckgabeDatentypen.Karte_Größe_240_240_Enum   => 6,
                                         RueckgabeDatentypen.Karte_Größe_320_320_Enum   => 8,
                                         RueckgabeDatentypen.Karte_Größe_1000_1000_Enum => 24,
                                         RueckgabeDatentypen.Karte_Größe_Nutzer_Enum    => 1
                                        );

   Eisschild : constant EisgebietArray := (
                                           RueckgabeDatentypen.Karte_Größe_20_20_Enum     => 3,
                                           RueckgabeDatentypen.Karte_Größe_40_40_Enum     => 3,
                                           RueckgabeDatentypen.Karte_Größe_80_80_Enum     => 6,
                                           RueckgabeDatentypen.Karte_Größe_120_80_Enum    => 9,
                                           RueckgabeDatentypen.Karte_Größe_120_160_Enum   => 9,
                                           RueckgabeDatentypen.Karte_Größe_160_160_Enum   => 12,
                                           RueckgabeDatentypen.Karte_Größe_240_240_Enum   => 18,
                                           RueckgabeDatentypen.Karte_Größe_320_320_Enum   => 24,
                                           RueckgabeDatentypen.Karte_Größe_1000_1000_Enum => 72,
                                           RueckgabeDatentypen.Karte_Größe_Nutzer_Enum    => 1
                                          );

end KartenRecordKonstanten;
