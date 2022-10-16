pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with KartenRecords;
with KartenKonstanten;
with StadtDatentypen;
with RassenDatentypen;
with StadtRecords;
with KartendatenbankRecord;

package KartenRecordKonstanten is

   LeerKoordinate : constant KartenRecords.AchsenKartenfeldNaturalRecord := (
                                                                             EAchse => KartenKonstanten.LeerEAchse,
                                                                             YAchse => KartenKonstanten.LeerYAchse,
                                                                             XAchse => KartenKonstanten.LeerXAchse
                                                                            );
   
   LeerYXKoordinate : constant KartenRecords.YXAchsenKartenfeldNaturalRecord := (
                                                                                 YAchse => KartenKonstanten.LeerYAchse,
                                                                                 XAchse => KartenKonstanten.LeerXAchse
                                                                                );
   
   LeerKartenListe : constant KartendatenbankRecord.KartenlistenRecord := (
                                                                           Bewertung      => (others => KartenKonstanten.LeerBewertung),
                                                                           Wirtschaft     => (others => (others => KartenKonstanten.LeerWirtschaft)),
                                                                           Kampf          => (others => (others => KartenKonstanten.LeerKampf))
                                                                          );
   
   LeerKartenGrundListe : constant KartendatenbankRecord.KartenpassierbarkeitslistenRecord := (
                                                                                               Passierbarkeit => (others => KartenKonstanten.LeerPassierbarkeit),
                                                                                               Bewertung      => (others => KartenKonstanten.LeerBewertung),
                                                                                               Wirtschaft     => (others => (others => KartenKonstanten.LeerWirtschaft)),
                                                                                               Kampf          => (others => (others => KartenKonstanten.LeerKampf))
                                                                                              );
   
   LeerDurchStadtBelegterGrund : constant StadtRecords.RasseStadtnummerRecord := (
                                                                                  Rasse  => RassenDatentypen.Keine_Rasse_Enum,
                                                                                  Nummer => StadtDatentypen.MaximaleStädteMitNullWert'First
                                                                                 );

   KartenformStandard : constant KartenRecords.KartenformRecord := (
                                                                    EAchseOben   => KartenDatentypen.Karte_E_Kein_Übergang_Enum,
                                                                    EAchseUnten  => KartenDatentypen.Karte_E_Kein_Übergang_Enum,
                                                                    YAchseNorden => KartenDatentypen.Karte_Y_Kein_Übergang_Enum,
                                                                    YAchseSüden  => KartenDatentypen.Karte_Y_Kein_Übergang_Enum,
                                                                    XAchseWesten => KartenDatentypen.Karte_X_Übergang_Enum,
                                                                    XAchseOsten  => KartenDatentypen.Karte_X_Übergang_Enum
                                                                   );
   
   KartenpoleStandard : constant KartenRecords.KartenpoleRecord := (
                                                                    Nordpol => KartenDatentypen.Kartenpol_Vorhanden_Enum,
                                                                    Südpol  => KartenDatentypen.Kartenpol_Vorhanden_Enum,
                                                                    Westpol => KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum,
                                                                    Ostpol  => KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum
                                                                   );

   LeerVerbesserungListe : constant KartendatenbankRecord.KartenpassierbarkeitslistenRecord := (
                                                                                                Passierbarkeit => (others => KartenKonstanten.LeerPassierbarkeit),
                                                                                                Bewertung      => (others => KartenKonstanten.LeerVerbesserungBewertung),
                                                                                                Wirtschaft     => (others => (others => KartenKonstanten.LeerVerbesserungWirtschaft)),
                                                                                                Kampf          => (others => (others => KartenKonstanten.LeerVerbesserungKampf))
                                                                                               );
   
   Standardkartenparameter : constant KartenRecords.PermanenteKartenparameterRecord := (
                                                                                        Kartengröße => (40, 40),

                                                                                        -- EAchsenübergang, YAchsenübergang, XAchsenübergang
                                                                                        Kartenform  => KartenformStandard
                                                                                       );
   
   Standardkartengeneratorparameter : constant KartenRecords.TemporäreKartenparameterRecord := (
                                                                                                 Kartengröße      => Standardkartenparameter.Kartengröße,

                                                                                                 -- EAchsenübergang, YAchsenübergang, XAchsenübergang
                                                                                                 Kartenform       => Standardkartenparameter.Kartenform,

                                                                                                 -- Inseln, Kontinente, Pangäa
                                                                                                 Kartenart        => KartenDatentypen.Kartenart_Kontinente_Enum,

                                                                                                 -- Kalt, Gemäßigt, Heiß, Eiszeit, Wüste
                                                                                                 Kartentemperatur => KartenDatentypen.Kartentemperatur_Gemäßigt_Enum,

                                                                                                 -- Arm, Wenig, Mittel, Viel, Überfluss
                                                                                                 Kartenressourcen => KartenDatentypen.Kartenressourcen_Mittel_Enum,
                                                                              
                                                                                                 Kartenpole       => KartenpoleStandard
                                                                                                );

end KartenRecordKonstanten;
