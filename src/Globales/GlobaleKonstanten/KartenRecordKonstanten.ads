pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with KartenRecords;
with KartenKonstanten;
with KartengrundDatentypen;
with KartenVerbesserungDatentypen;

with DatenbankRecords;

package KartenRecordKonstanten is

   LeerKartenKoordinaten : constant KartenRecords.AchsenKartenfeldNaturalRecord := (
                                                                                    EAchse => KartenKonstanten.LeerEAchse,
                                                                                    YAchse => KartenKonstanten.LeerYAchse,
                                                                                    XAchse => KartenKonstanten.LeerXAchse
                                                                                   );
   
   LeerKartenYXKoordinate : constant KartenRecords.YXAchsenKartenfeldNaturalRecord := (
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
                                                           BasisGrund              => KartengrundDatentypen.Leer_Grund_Enum,
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
                                                                    Nordpol => KartenDatentypen.Kartenpol_Vorhanden_Enum,
                                                                    Südpol  => KartenDatentypen.Kartenpol_Vorhanden_Enum,
                                                                    Westpol => KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum,
                                                                    Ostpol  => KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum
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
   
   ---------------------------- Das hier sollte woanders hin, oder?
   ---------------------------- Polgrund auch definierbar machen, so dass die Pole nicht nur aus Eis bestehen?
   Eisrand : constant KartenDatentypen.PolregionenArray := (
                                                            KartenDatentypen.Norden_Enum => 1,
                                                            KartenDatentypen.Süden_Enum  => 1,
                                                            KartenDatentypen.Westen_Enum => 0,
                                                            KartenDatentypen.Osten_Enum  => 0
                                                           );

   Eisschild : constant KartenDatentypen.PolregionenArray := (
                                                              KartenDatentypen.Norden_Enum => 3,
                                                              KartenDatentypen.Süden_Enum  => 3,
                                                              KartenDatentypen.Westen_Enum => 0,
                                                              KartenDatentypen.Osten_Enum  => 0
                                                             );

end KartenRecordKonstanten;
