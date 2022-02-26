pragma SPARK_Mode (On);

with SystemDatentypen;
with KartenDatentypen;
with KartenRecords;
with KartenKonstanten;
with KartenGrundKonstanten;
with KartenVerbesserungKonstanten;
with KartenEinstellungenKonstanten;

with DatenbankRecords;

package KartenRecordKonstanten is

   LeerKartenKoordinaten : constant KartenRecords.AchsenKartenfeldPositivRecord := (EAchse => KartenKonstanten.LeerEAchse,
                                                                                    YAchse => KartenKonstanten.LeerYAchse,
                                                                                    XAchse => KartenKonstanten.LeerXAchse);
   
   LeerKartenListe : constant DatenbankRecords.KartenListeRecord := (
                                                                     KartenGrafik   => KartenKonstanten.LeerKartenGrafik,
                                                                     Passierbarkeit => (others => KartenKonstanten.LeerPassierbarkeit),
                                                                     Bewertung      => (others => KartenKonstanten.LeerBewertung),
                                                                     Wirtschaft     => (others => (others => KartenKonstanten.LeerWirtschaft)),
                                                                     Kampf          => (others => (others => KartenKonstanten.LeerKampf))
                                                                    );

   LeerWeltkarte : constant KartenRecords.KartenRecord := (
                                                           Grund                   => KartenGrundKonstanten.LeerGrund,
                                                           Hügel                   => KartenKonstanten.LeerHügel,
                                                           Sichtbar                => (others => KartenKonstanten.LeerSichtbar),
                                                           Fluss                   => KartenGrundKonstanten.LeerGrund,
                                                           VerbesserungWeg         => KartenVerbesserungKonstanten.LeerVerbesserungWeg,
                                                           VerbesserungGebiet      => KartenVerbesserungKonstanten.LeerVerbesserungGebiet,
                                                           Ressource               => KartenGrundKonstanten.LeerGrund,
                                                           DurchStadtBelegterGrund => KartenKonstanten.LeerDurchStadtBelegterGrund,
                                                           Felderwertung           => (others => KartenKonstanten.LeerFelderwertung)
                                                          );

   KartenformStandard : constant KartenRecords.KartenformRecord := (SystemDatentypen.Karte_E_Achse_Fest,
                                                                    SystemDatentypen.Karte_Y_Achse_Fest,
                                                                    SystemDatentypen.Karte_X_Achse_Normaler_Übergang);

   LeerVerbesserungListe : constant DatenbankRecords.VerbesserungListeRecord := (
                                                                                 VerbesserungGrafik => KartenKonstanten.LeerVerbesserungGrafik,
                                                                                 Passierbarkeit     => (others => KartenKonstanten.LeerPassierbarkeit),
                                                                                 Bewertung          => (others => KartenKonstanten.LeerVerbesserungBewertung),
                                                                                 Wirtschaft         => (others => (others => KartenKonstanten.LeerVerbesserungWirtschaft)),
                                                                                 Kampf              => (others => (others => KartenKonstanten.LeerVerbesserungKampf))
                                                                                );
   
   type EisgebietArray is array (KartenDatentypen.Kartengröße_Verwendet_Enum'Range) of KartenDatentypen.KartenfeldPositiv;
   Eisrand : constant EisgebietArray := (
                                         KartenEinstellungenKonstanten.Kartengröße2020Konstante     => 1,
                                         KartenEinstellungenKonstanten.Kartengröße4040Konstante     => 1,
                                         KartenEinstellungenKonstanten.Kartengröße8080Konstante     => 2,
                                         KartenEinstellungenKonstanten.Kartengröße12080Konstante    => 3,
                                         KartenEinstellungenKonstanten.Kartengröße120160Konstante   => 3,
                                         KartenEinstellungenKonstanten.Kartengröße160160Konstante   => 4,
                                         KartenEinstellungenKonstanten.Kartengröße240240Konstante   => 6,
                                         KartenEinstellungenKonstanten.Kartengröße320320Konstante   => 8,
                                         KartenEinstellungenKonstanten.Kartengröße10001000Konstante => 24,
                                         KartenEinstellungenKonstanten.KartengrößeNutzerKonstante   => 1
                                        );

   Eisschild : constant EisgebietArray := (
                                           KartenEinstellungenKonstanten.Kartengröße2020Konstante     => 3,
                                           KartenEinstellungenKonstanten.Kartengröße4040Konstante     => 3,
                                           KartenEinstellungenKonstanten.Kartengröße8080Konstante     => 6,
                                           KartenEinstellungenKonstanten.Kartengröße12080Konstante    => 9,
                                           KartenEinstellungenKonstanten.Kartengröße120160Konstante   => 9,
                                           KartenEinstellungenKonstanten.Kartengröße160160Konstante   => 12,
                                           KartenEinstellungenKonstanten.Kartengröße240240Konstante   => 18,
                                           KartenEinstellungenKonstanten.Kartengröße320320Konstante   => 24,
                                           KartenEinstellungenKonstanten.Kartengröße10001000Konstante => 72,
                                           KartenEinstellungenKonstanten.KartengrößeNutzerKonstante   => 1
                                          );

end KartenRecordKonstanten;
