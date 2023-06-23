with KartenRecords;
with KartenKonstanten;
with StadtDatentypen;
with StadtRecords;
with KartenartDatentypen;
with SpeziesKonstanten;

package KartenRecordKonstanten is
   pragma Elaborate_Body;

   LeerKoordinate : constant KartenRecords.AchsenKartenfeldNaturalRecord := (
                                                                             EAchse => KartenKonstanten.LeerEAchse,
                                                                             YAchse => KartenKonstanten.LeerYAchse,
                                                                             XAchse => KartenKonstanten.LeerXAchse
                                                                            );
   
   LeerKoordinatenänderung : constant KartenRecords.AchsenKartenfeldRecord
     := (KartenKonstanten.LeerEAchseÄnderung, KartenKonstanten.LeerYAchseÄnderung, KartenKonstanten.LeerXAchseÄnderung);
   
   EbeneHoch : constant KartenRecords.AchsenKartenfeldRecord := (KartenKonstanten.EbeneHoch, KartenKonstanten.LeerYAchseÄnderung, KartenKonstanten.LeerXAchseÄnderung);
   EbeneRunter : constant KartenRecords.AchsenKartenfeldRecord := (KartenKonstanten.EbeneRunter, KartenKonstanten.LeerYAchseÄnderung, KartenKonstanten.LeerXAchseÄnderung);
   
   Nordbewegung : constant KartenRecords.AchsenKartenfeldRecord := (KartenKonstanten.LeerEAchseÄnderung, KartenKonstanten.YAchseNorden, KartenKonstanten.LeerXAchseÄnderung);
   Südbewegung : constant KartenRecords.AchsenKartenfeldRecord := (KartenKonstanten.LeerEAchseÄnderung, KartenKonstanten.YAchseSüden, KartenKonstanten.LeerXAchseÄnderung);
   Westbewegung : constant KartenRecords.AchsenKartenfeldRecord := (KartenKonstanten.LeerEAchseÄnderung, KartenKonstanten.LeerYAchseÄnderung, KartenKonstanten.XAchseWesten);
   OstBewegung : constant KartenRecords.AchsenKartenfeldRecord := (KartenKonstanten.LeerEAchseÄnderung, KartenKonstanten.LeerYAchseÄnderung, KartenKonstanten.XAchseOsten);
   Nordwestbewegung : constant KartenRecords.AchsenKartenfeldRecord := (KartenKonstanten.LeerEAchseÄnderung, KartenKonstanten.YAchseNorden, KartenKonstanten.XAchseWesten);
   Nordostbewegung : constant KartenRecords.AchsenKartenfeldRecord := (KartenKonstanten.LeerEAchseÄnderung, KartenKonstanten.YAchseNorden, KartenKonstanten.XAchseOsten);
   Südwestbewegung : constant KartenRecords.AchsenKartenfeldRecord := (KartenKonstanten.LeerEAchseÄnderung, KartenKonstanten.YAchseSüden, KartenKonstanten.XAchseWesten);
   Südostbewegung : constant KartenRecords.AchsenKartenfeldRecord := (KartenKonstanten.LeerEAchseÄnderung, KartenKonstanten.YAchseSüden, KartenKonstanten.XAchseOsten);
   
   LeerEffektbereich : constant KartenRecords.EffektbereichRecord := (
                                                                      YAchseAnfang => KartenKonstanten.LeerYAchse,
                                                                      YAchseEnde   => KartenKonstanten.LeerYAchse,
                                                                      XAchseAnfang => KartenKonstanten.LeerXAchse,
                                                                      XAchseEnde   => KartenKonstanten.LeerXAchse
                                                                     );
   
   LeerEffekte : constant KartenRecords.FeldeffektArray := (others => False);
   
   LeerSichtbarkeit : constant KartenRecords.SichtbarkeitArray := (others => False);
   
   -- Das nach StadtRecordKonstanten verschieben? äöü
   LeerDurchStadtBelegterGrund : constant StadtRecords.SpeziesStadtnummerRecord := (
                                                                                    Spezies => SpeziesKonstanten.LeerSpezies,
                                                                                    Nummer  => StadtDatentypen.MaximaleStädteMitNullWert'First
                                                                                   );

   KartenformStandard : constant KartenRecords.KartenformRecord := (
                                                                    EAchseOben   => KartenartDatentypen.Karte_E_Kein_Übergang_Enum,
                                                                    EAchseUnten  => KartenartDatentypen.Karte_E_Kein_Übergang_Enum,
                                                                    YAchseNorden => KartenartDatentypen.Karte_Y_Kein_Übergang_Enum,
                                                                    YAchseSüden  => KartenartDatentypen.Karte_Y_Kein_Übergang_Enum,
                                                                    XAchseWesten => KartenartDatentypen.Karte_X_Übergang_Enum,
                                                                    XAchseOsten  => KartenartDatentypen.Karte_X_Übergang_Enum
                                                                   );
   
   KartenpoleStandard : constant KartenRecords.KartenpoleRecord := (
                                                                    Nordpol => KartenartDatentypen.Kartenpol_Vorhanden_Enum,
                                                                    Südpol  => KartenartDatentypen.Kartenpol_Vorhanden_Enum,
                                                                    Westpol => KartenartDatentypen.Kartenpol_Nicht_Vorhanden_Enum,
                                                                    Ostpol  => KartenartDatentypen.Kartenpol_Nicht_Vorhanden_Enum
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
                                                                                                 Kartenart        => KartenartDatentypen.Kartenart_Kontinente_Enum,

                                                                                                 -- Kalt, Gemäßigt, Heiß, Eiszeit, Wüste
                                                                                                 Kartentemperatur => KartenartDatentypen.Kartentemperatur_Gemäßigt_Enum,

                                                                                                 -- Arm, Wenig, Mittel, Viel, Überfluss
                                                                                                 Kartenressourcen => KartenartDatentypen.Kartenressourcen_Mittel_Enum,
                                                                              
                                                                                                 Kartenpole       => KartenpoleStandard
                                                                                                );

end KartenRecordKonstanten;
