pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with KartenRecords;
with KartenKonstanten;
with KartengrundDatentypen;
with KartenVerbesserungDatentypen;

with DatenbankRecords;

package KartenRecordKonstanten is

   LeerKartenKoordinaten : constant KartenRecords.AchsenKartenfeldPositivRecord := (
                                                                                    EAchse => KartenKonstanten.LeerEAchse,
                                                                                    YAchse => KartenKonstanten.LeerYAchse,
                                                                                    XAchse => KartenKonstanten.LeerXAchse
                                                                                   );
   
   LeerKartenYXKoordinate : constant KartenRecords.YXAchsenKartenfeldMitNullwertRecord := (
                                                                                           YAchse => KartenKonstanten.LeerYAchse,
                                                                                           XAchse => KartenKonstanten.LeerXAchse
                                                                                          );
   
   LeerKartenListe : constant DatenbankRecords.KartenlisteRecord := (
                                                                     Bewertung      => (others => KartenKonstanten.LeerBewertung),
                                                                     Wirtschaft     => (others => (others => KartenKonstanten.LeerWirtschaft)),
                                                                     Kampf          => (others => (others => KartenKonstanten.LeerKampf))
                                                                    );
   
   LeerKartenGrundListe : constant DatenbankRecords.KartengrundlisteRecord := (
                                                                               Passierbarkeit => (others => KartenKonstanten.LeerPassierbarkeit),
                                                                               Bewertung      => (others => KartenKonstanten.LeerBewertung),
                                                                               Wirtschaft     => (others => (others => KartenKonstanten.LeerWirtschaft)),
                                                                               Kampf          => (others => (others => KartenKonstanten.LeerKampf))
                                                                              );

   LeerWeltkarte : constant KartenRecords.KartenRecord := (
                                                           AktuellerGrund          => KartengrundDatentypen.Leer_Grund_Enum,
                                                           -------------------------------- Hügel wird aktuell noch nicht richtig belegt, später im Kartengenerator einbauen und hier wieder auf Leer setzen.
                                                           BasisGrund              => KartengrundDatentypen.Flachland_Enum,
                                                           Sichtbar                => (others => KartenKonstanten.LeerSichtbar),
                                                           Fluss                   => KartengrundDatentypen.Leer_Fluss_Enum,
                                                           Ressource               => KartengrundDatentypen.Leer_Ressource_Enum,
                                                           Weg                     => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                                           Verbesserung            => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                                           DurchStadtBelegterGrund => KartenKonstanten.LeerDurchStadtBelegterGrund,
                                                           Felderwertung           => (others => KartenKonstanten.LeerFelderwertung)
                                                          );

   KartenformStandard : constant KartenRecords.KartenformRecord := (
                                                                    EAchseOben                       => KartenDatentypen.Karte_E_Kein_Übergang_Enum,
                                                                    EAchseUnten                      => KartenDatentypen.Karte_E_Kein_Übergang_Enum,
                                                                    YAchseNorden                     => KartenDatentypen.Karte_Y_Kein_Übergang_Enum,
                                                                    YAchseSüden                      => KartenDatentypen.Karte_Y_Kein_Übergang_Enum,
                                                                    XAchseWesten                     => KartenDatentypen.Karte_X_Übergang_Enum,
                                                                    XAchseOsten                      => KartenDatentypen.Karte_X_Übergang_Enum,
                                                                    YZuerstBerechnenXZuerstBerechnen => True
                                                                   );
   
   KartenpoleStandard : constant KartenRecords.KartenpoleRecord := (
                                                                    YAchseNorden => KartenDatentypen.Kartenpol_Vorhanden_Enum,
                                                                    YAchseSüden  => KartenDatentypen.Kartenpol_Vorhanden_Enum,
                                                                    XAchseWesten => KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum,
                                                                    XAchseOsten  => KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum
                                                                   );

   LeerVerbesserungListe : constant DatenbankRecords.VerbesserungenWegeListeRecord := (
                                                                                       Passierbarkeit => (others => KartenKonstanten.LeerPassierbarkeit),
                                                                                       Bewertung      => (others => KartenKonstanten.LeerVerbesserungBewertung),
                                                                                       Wirtschaft     => (others => (others => KartenKonstanten.LeerVerbesserungWirtschaft)),
                                                                                       Kampf          => (others => (others => KartenKonstanten.LeerVerbesserungKampf))
                                                                                      );
   
   KartenparameterStandard : constant KartenRecords.KartenparameterRecord := (
                                                                              Kartengröße      => KartenDatentypen.Kartengröße_40_40_Enum,

                                                                              -- Inseln, Kontinente, Pangäa, Nur Land, Chaos
                                                                              Kartenart        => KartenDatentypen.Kartenart_Inseln_Enum,

                                                                              -- Kalt, Gemäßigt, Heiß, Eiszeit, Wüste
                                                                              Kartentemperatur => KartenDatentypen.Kartentemperatur_Kalt_Enum,

                                                                              -- Arm, Wenig, Mittel, Viel, Überfluss
                                                                              Kartenressourcen => KartenDatentypen.Kartenressourcen_Mittel_Enum,

                                                                              Kartenpole       => KartenpoleStandard,

                                                                              -- EAchsenübergang, YAchsenübergang, XAchsenübergang
                                                                              Kartenform       => KartenformStandard
                                                                             );
   
   ---------------------------- Das hier sollte woanders hin, oder? Auch vom Nutzer konfigurierbar machen? Positionsabhängige Dicke ermöglichen?
   ---------------------------- Polgrund auch definierbar machen, so dass die Pole nicht nur aus Eis bestehen?
   ---------------------------- Bei der Nutzereinstellung darauf achten dass die maximale Größe pro Polregion auf die halbe Kartengröße beschränkt ist.
   type EisgebietArray is array (KartenDatentypen.Kartengröße_Verwendet_Enum'Range, KartenDatentypen.Himmelsrichtungen_Enum'Range) of KartenDatentypen.KartenfeldPositivMitNullwert;
   Eisrand : constant EisgebietArray := (
                                         KartenDatentypen.Kartengröße_20_20_Enum =>
                                           (
                                            KartenDatentypen.Norden_Enum => 1,
                                            KartenDatentypen.Süden_Enum  => 1,
                                            KartenDatentypen.Westen_Enum => 1,
                                            KartenDatentypen.Osten_Enum  => 1
                                           ),
                                             
                                         KartenDatentypen.Kartengröße_40_40_Enum =>
                                           (
                                            KartenDatentypen.Norden_Enum => 1,
                                            KartenDatentypen.Süden_Enum  => 1,
                                            KartenDatentypen.Westen_Enum => 1,
                                            KartenDatentypen.Osten_Enum  => 1
                                           ),
                                           
                                         KartenDatentypen.Kartengröße_80_80_Enum =>
                                           (
                                            KartenDatentypen.Norden_Enum => 2,
                                            KartenDatentypen.Süden_Enum  => 2,
                                            KartenDatentypen.Westen_Enum => 2,
                                            KartenDatentypen.Osten_Enum  => 2
                                           ),
                                           
                                         KartenDatentypen.Kartengröße_120_80_Enum =>
                                           (
                                            KartenDatentypen.Norden_Enum => 3,
                                            KartenDatentypen.Süden_Enum  => 3,
                                            KartenDatentypen.Westen_Enum => 3,
                                            KartenDatentypen.Osten_Enum  => 3
                                           ),
                                           
                                         KartenDatentypen.Kartengröße_120_160_Enum =>
                                           (
                                            KartenDatentypen.Norden_Enum => 3,
                                            KartenDatentypen.Süden_Enum  => 3,
                                            KartenDatentypen.Westen_Enum => 3,
                                            KartenDatentypen.Osten_Enum  => 3
                                           ),
                                           
                                         KartenDatentypen.Kartengröße_160_160_Enum =>
                                           (
                                            KartenDatentypen.Norden_Enum => 4,
                                            KartenDatentypen.Süden_Enum  => 4,
                                            KartenDatentypen.Westen_Enum => 4,
                                            KartenDatentypen.Osten_Enum  => 4
                                           ),
                                           
                                         KartenDatentypen.Kartengröße_240_240_Enum =>
                                           (
                                            KartenDatentypen.Norden_Enum => 6,
                                            KartenDatentypen.Süden_Enum  => 6,
                                            KartenDatentypen.Westen_Enum => 6,
                                            KartenDatentypen.Osten_Enum  => 6
                                           ),
                                           
                                         KartenDatentypen.Kartengröße_320_320_Enum =>
                                           (
                                            KartenDatentypen.Norden_Enum => 8,
                                            KartenDatentypen.Süden_Enum  => 8,
                                            KartenDatentypen.Westen_Enum => 8,
                                            KartenDatentypen.Osten_Enum  => 8
                                           ),
                                           
                                         KartenDatentypen.Kartengröße_1000_1000_Enum =>
                                           (
                                            KartenDatentypen.Norden_Enum => 24,
                                            KartenDatentypen.Süden_Enum  => 24,
                                            KartenDatentypen.Westen_Enum => 24,
                                            KartenDatentypen.Osten_Enum  => 24
                                           ),
                                           
                                         KartenDatentypen.Kartengröße_Nutzer_Enum =>
                                           (
                                            KartenDatentypen.Norden_Enum => 1,
                                            KartenDatentypen.Süden_Enum  => 1,
                                            KartenDatentypen.Westen_Enum => 1,
                                            KartenDatentypen.Osten_Enum  => 1
                                           )
                                        );

   Eisschild : constant EisgebietArray := (
                                           KartenDatentypen.Kartengröße_20_20_Enum =>
                                             (
                                              KartenDatentypen.Norden_Enum => 3,
                                              KartenDatentypen.Süden_Enum  => 3,
                                              KartenDatentypen.Westen_Enum => 3,
                                              KartenDatentypen.Osten_Enum  => 3
                                             ),
                                               
                                           KartenDatentypen.Kartengröße_40_40_Enum =>
                                             (
                                              KartenDatentypen.Norden_Enum => 3,
                                              KartenDatentypen.Süden_Enum  => 3,
                                              KartenDatentypen.Westen_Enum => 3,
                                              KartenDatentypen.Osten_Enum  => 3
                                             ),
                                               
                                           KartenDatentypen.Kartengröße_80_80_Enum =>
                                             (
                                              KartenDatentypen.Norden_Enum => 6,
                                              KartenDatentypen.Süden_Enum  => 6,
                                              KartenDatentypen.Westen_Enum => 6,
                                              KartenDatentypen.Osten_Enum  => 6
                                             ),
                                               
                                           KartenDatentypen.Kartengröße_120_80_Enum =>
                                             (
                                              KartenDatentypen.Norden_Enum => 9,
                                              KartenDatentypen.Süden_Enum  => 9,
                                              KartenDatentypen.Westen_Enum => 9,
                                              KartenDatentypen.Osten_Enum  => 9
                                             ),
                                               
                                           KartenDatentypen.Kartengröße_120_160_Enum =>
                                             (
                                              KartenDatentypen.Norden_Enum => 9,
                                              KartenDatentypen.Süden_Enum  => 9,
                                              KartenDatentypen.Westen_Enum => 9,
                                              KartenDatentypen.Osten_Enum  => 9
                                             ),
                                               
                                           KartenDatentypen.Kartengröße_160_160_Enum =>
                                             (
                                              KartenDatentypen.Norden_Enum => 12,
                                              KartenDatentypen.Süden_Enum  => 12,
                                              KartenDatentypen.Westen_Enum => 12,
                                              KartenDatentypen.Osten_Enum  => 12
                                             ),
                                               
                                           KartenDatentypen.Kartengröße_240_240_Enum =>
                                             (
                                              KartenDatentypen.Norden_Enum => 18,
                                              KartenDatentypen.Süden_Enum  => 18,
                                              KartenDatentypen.Westen_Enum => 18,
                                              KartenDatentypen.Osten_Enum  => 18
                                             ),
                                               
                                           KartenDatentypen.Kartengröße_320_320_Enum =>
                                             (
                                              KartenDatentypen.Norden_Enum => 24,
                                              KartenDatentypen.Süden_Enum  => 24,
                                              KartenDatentypen.Westen_Enum => 24,
                                              KartenDatentypen.Osten_Enum  => 24
                                             ),
                                           
                                           KartenDatentypen.Kartengröße_1000_1000_Enum =>
                                             (
                                              KartenDatentypen.Norden_Enum => 72,
                                              KartenDatentypen.Süden_Enum  => 72,
                                              KartenDatentypen.Westen_Enum => 72,
                                              KartenDatentypen.Osten_Enum  => 72
                                             ),
                                               
                                           KartenDatentypen.Kartengröße_Nutzer_Enum =>
                                             (
                                              KartenDatentypen.Norden_Enum => 1,
                                              KartenDatentypen.Süden_Enum  => 1,
                                              KartenDatentypen.Westen_Enum => 1,
                                              KartenDatentypen.Osten_Enum  => 1
                                             )
                                          );

end KartenRecordKonstanten;
