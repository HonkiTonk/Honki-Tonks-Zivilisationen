pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with KartenRecords;
with KartenKonstanten;
with KartengrundDatentypen;
with KartenVerbesserungDatentypen;

with DatenbankRecords;

package KartenRecordKonstanten is

   ----------------------------------------- Diese LeerKoordinaten mal überall irgendwie herausziehen und in einer Datei unterbringen, geht aktuell nicht wegen Kreislinkung in KartenKonstanten/StadtKonstanten.
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
                                                                    XAchseOsten                      => KartenDatentypen.Karte_X_Übergang_Enum
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
                                                                                                 Kartenart        => KartenDatentypen.Kartenart_Inseln_Enum,

                                                                                                 -- Kalt, Gemäßigt, Heiß, Eiszeit, Wüste
                                                                                                 Kartentemperatur => KartenDatentypen.Kartentemperatur_Kalt_Enum,

                                                                                                 -- Arm, Wenig, Mittel, Viel, Überfluss
                                                                                                 Kartenressourcen => KartenDatentypen.Kartenressourcen_Mittel_Enum,
                                                                              
                                                                                                 Kartenpole       => KartenpoleStandard
                                                                                                );
   
   ---------------------------- Das hier sollte woanders hin, oder? Oder aus dem Array ein Record machen.
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
   
   Inselgröße : constant KartenRecords.LandgrößenRecord := (
                                                                MinimaleYAchse => 3,
                                                                MaximaleYAchse => 4,
                                                                MinimaleXAchse => 3,
                                                                MaximaleXAchse => 4
                                                               );
   
   Kontinentgröße : constant KartenRecords.LandgrößenRecord := (
                                                                    MinimaleYAchse => 7,
                                                                    MaximaleYAchse => 8,
                                                                    MinimaleXAchse => 7,
                                                                    MaximaleXAchse => 8
                                                                   );
   
   Pangäagröße : constant KartenRecords.LandgrößenRecord := (
                                                                  MinimaleYAchse => 100,
                                                                  MaximaleYAchse => 100,
                                                                  MinimaleXAchse => 100,
                                                                  MaximaleXAchse => 100
                                                                 );
   
   Inselabstand : constant KartenRecords.LandabständeRecord := (
                                                                 MinimaleYAchse => 13,
                                                                 MaximaleYAchse => 15,
                                                                 MinimaleXAchse => 13,
                                                                 MaximaleXAchse => 15
                                                                );
   
   Kontinentabstand : constant KartenRecords.LandabständeRecord := (
                                                                     MinimaleYAchse => 20,
                                                                     MaximaleYAchse => 22,
                                                                     MinimaleXAchse => 20,
                                                                     MaximaleXAchse => 22
                                                                    );
   
   Pangäaabstand : constant KartenRecords.LandabständeRecord := (
                                                                   MinimaleYAchse => 100,
                                                                   MaximaleYAchse => 100,
                                                                   MinimaleXAchse => 100,
                                                                   MaximaleXAchse => 100
                                                                  );

end KartenRecordKonstanten;
