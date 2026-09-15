with KartenDatentypen;
with KartenRecords;
with KartenKonstanten;
with StadtDatentypen;
with StadtRecords;
with KartenartDatentypen;
with SpeziesKonstanten;
with KartenArrays;
with KartenrohstoffeDatentypen;

package KartenRecordKonstanten is
   pragma Elaborate_Body;

   LeerKoordinate : constant KartenRecords.KartenfeldNaturalRecord := (
                                                                       Ebene => KartenKonstanten.LeerEbene,
                                                                       Senkrechte => KartenKonstanten.LeerSenkrechte,
                                                                       Waagerechte => KartenKonstanten.LeerWaagerechte
                                                                      );
   
   LeerKoordinatenänderung : constant KartenRecords.KartenfeldRecord := (KartenKonstanten.LeerEbeneÄnderung, KartenKonstanten.LeerSenkrechteÄnderung, KartenKonstanten.LeerWaagerechteÄnderung);
   
   EbeneHoch : constant KartenRecords.KartenfeldRecord := (KartenKonstanten.EbeneHoch, KartenKonstanten.LeerSenkrechteÄnderung, KartenKonstanten.LeerWaagerechteÄnderung);
   EbeneRunter : constant KartenRecords.KartenfeldRecord := (KartenKonstanten.EbeneRunter, KartenKonstanten.LeerSenkrechteÄnderung, KartenKonstanten.LeerWaagerechteÄnderung);
   
   Nordbewegung : constant KartenRecords.KartenfeldRecord := (KartenKonstanten.LeerEbeneÄnderung, KartenKonstanten.SenkrechteNorden, KartenKonstanten.LeerWaagerechteÄnderung);
   Südbewegung : constant KartenRecords.KartenfeldRecord := (KartenKonstanten.LeerEbeneÄnderung, KartenKonstanten.SenkrechteSüden, KartenKonstanten.LeerWaagerechteÄnderung);
   Westbewegung : constant KartenRecords.KartenfeldRecord := (KartenKonstanten.LeerEbeneÄnderung, KartenKonstanten.LeerSenkrechteÄnderung, KartenKonstanten.WaagerechteWesten);
   OstBewegung : constant KartenRecords.KartenfeldRecord := (KartenKonstanten.LeerEbeneÄnderung, KartenKonstanten.LeerSenkrechteÄnderung, KartenKonstanten.WaagerechteOsten);
   Nordwestbewegung : constant KartenRecords.KartenfeldRecord := (KartenKonstanten.LeerEbeneÄnderung, KartenKonstanten.SenkrechteNorden, KartenKonstanten.WaagerechteWesten);
   Nordostbewegung : constant KartenRecords.KartenfeldRecord := (KartenKonstanten.LeerEbeneÄnderung, KartenKonstanten.SenkrechteNorden, KartenKonstanten.WaagerechteOsten);
   Südwestbewegung : constant KartenRecords.KartenfeldRecord := (KartenKonstanten.LeerEbeneÄnderung, KartenKonstanten.SenkrechteSüden, KartenKonstanten.WaagerechteWesten);
   Südostbewegung : constant KartenRecords.KartenfeldRecord := (KartenKonstanten.LeerEbeneÄnderung, KartenKonstanten.SenkrechteSüden, KartenKonstanten.WaagerechteOsten);
   
   LeerEffektbereich : constant KartenRecords.EffektbereichRecord := (
                                                                      SenkrechteAnfang => KartenKonstanten.LeerSenkrechte,
                                                                      SenkrechteEnde   => KartenKonstanten.LeerSenkrechte,
                                                                      WaagerechteAnfang => KartenKonstanten.LeerWaagerechte,
                                                                      WaagerechteEnde   => KartenKonstanten.LeerWaagerechte
                                                                     );
   
   LeerEffekte : constant KartenArrays.FeldeffektArray := (others => False);
   
   LeerSichtbarkeit : constant KartenRecords.SichtbarkeitArray := (others => False);
   
   -- Das nach StadtRecordKonstanten verschieben? äöü
   LeerDurchStadtBelegterGrund : constant StadtRecords.SpeziesStadtnummerRecord := (
                                                                                    Spezies => SpeziesKonstanten.LeerSpezies,
                                                                                    Nummer  => StadtDatentypen.StädtebereichBasis'First
                                                                                   );

   KartenformStandard : constant KartenRecords.KartenformRecord := (
                                                                    EbeneOben         => KartenartDatentypen.Ebene_Übergangslos_Enum,
                                                                    EbeneUnten        => KartenartDatentypen.Ebene_Übergangslos_Enum,
                                                                    SenkrechteNorden  => KartenartDatentypen.Senkrechte_Übergangslos_Enum,
                                                                    SenkrechteSüden   => KartenartDatentypen.Senkrechte_Übergangslos_Enum,
                                                                    WaagerechteWesten => KartenartDatentypen.Waagerechte_Übergang_Enum,
                                                                    WaagerechteOsten  => KartenartDatentypen.Waagerechte_Übergang_Enum
                                                                   );
   
   KartenpoleStandard : constant KartenRecords.KartenpoleRecord := (
                                                                    Nordpol => KartenartDatentypen.Kartenpol_Vorhanden_Enum,
                                                                    Südpol  => KartenartDatentypen.Kartenpol_Vorhanden_Enum,
                                                                    Westpol => KartenartDatentypen.Kartenpol_Nicht_Vorhanden_Enum,
                                                                    Ostpol  => KartenartDatentypen.Kartenpol_Nicht_Vorhanden_Enum
                                                                   );
   
   StandardKartenebenen : constant KartenRecords.KartenebenenVorhandenRecord := (KartenDatentypen.EbeneVorhanden'First, KartenDatentypen.EbeneVorhanden'Last);
   
   Standardkartenparameter : constant KartenRecords.PermanenteKartenparameterRecord := (
                                                                                        Kartengröße => (40, 40),
                                                                                        
                                                                                        Kartenebene => StandardKartenebenen,

                                                                                        -- Ebeneübergang, Senkrechteübergang, Waagerechteübergang
                                                                                        Kartenform  => KartenformStandard
                                                                                       );
   
   Standardkartengeneratorparameter : constant KartenRecords.TemporäreKartenparameterRecord := (
                                                                                                 Kartengröße      => Standardkartenparameter.Kartengröße,
                                                                                        
                                                                                                 Kartenebene      => (KartenDatentypen.EbeneVorhanden'First, KartenDatentypen.EbeneVorhanden'Last),

                                                                                                 -- Ebeneübergang, Senkrechteübergang, Waagerechteübergang
                                                                                                 Kartenform       => Standardkartenparameter.Kartenform,

                                                                                                 -- Inseln, Kontinente, Pangäa
                                                                                                 Kartenart        => KartenartDatentypen.Kartenart_Kontinente_Enum,

                                                                                                 -- Kalt, Gemäßigt, Heiß, Eiszeit, Wüste
                                                                                                 Kartentemperatur => KartenartDatentypen.Kartentemperatur_Gemäßigt_Enum,

                                                                                                 -- Arm, Wenig, Mittel, Viel, Überfluss
                                                                                                 Kartenrohstoffe  => KartenartDatentypen.Ein_Rohstoff_Enum,
                                                                              
                                                                                                 Kartenpole       => KartenpoleStandard
                                                                                                );
   
   -- Wenn das neue Rohstoffsystem da ist kann das weg. äöü
   StandardKartenrohstoffeWahrscheinlichkeiten : constant KartenArrays.StandardKartenrohstoffeWahrscheinlichkeitenArray := (
                                                                                                                            KartenartDatentypen.Ein_Rohstoff_Enum =>
                                                                                                                              (
                                                                                                                               KartenrohstoffeDatentypen.Fisch_Enum              => 3,
                                                                                                                               KartenrohstoffeDatentypen.Wal_Enum                => 3,
                                                                                                                               KartenrohstoffeDatentypen.Hochwertiges_Holz_Enum  => 3,
                                                                                                                               KartenrohstoffeDatentypen.Kohle_Enum              => 3,
                                                                                                                               KartenrohstoffeDatentypen.Eisen_Enum              => 3,
                                                                                                                               KartenrohstoffeDatentypen.Öl_Enum                 => 3,
                                                                                                                               KartenrohstoffeDatentypen.Hochwertiger_Boden_Enum => 3,
                                                                                                                               KartenrohstoffeDatentypen.Gold_Enum               => 3
                                                                                                                              ),

                                                                                                                            KartenartDatentypen.Zwei_Rohstoffe_Enum =>
                                                                                                                              (
                                                                                                                               KartenrohstoffeDatentypen.Fisch_Enum              => 2,
                                                                                                                               KartenrohstoffeDatentypen.Wal_Enum                => 2,
                                                                                                                               KartenrohstoffeDatentypen.Hochwertiges_Holz_Enum  => 2,
                                                                                                                               KartenrohstoffeDatentypen.Kohle_Enum              => 2,
                                                                                                                               KartenrohstoffeDatentypen.Eisen_Enum              => 2,
                                                                                                                               KartenrohstoffeDatentypen.Öl_Enum                 => 2,
                                                                                                                               KartenrohstoffeDatentypen.Hochwertiger_Boden_Enum => 2,
                                                                                                                               KartenrohstoffeDatentypen.Gold_Enum               => 2
                                                                                                                              ),

                                                                                                                            KartenartDatentypen.Drei_Rohstoffe_Enum =>
                                                                                                                              (
                                                                                                                               KartenrohstoffeDatentypen.Fisch_Enum              => 3,
                                                                                                                               KartenrohstoffeDatentypen.Wal_Enum                => 3,
                                                                                                                               KartenrohstoffeDatentypen.Hochwertiges_Holz_Enum  => 3,
                                                                                                                               KartenrohstoffeDatentypen.Kohle_Enum              => 3,
                                                                                                                               KartenrohstoffeDatentypen.Eisen_Enum              => 3,
                                                                                                                               KartenrohstoffeDatentypen.Öl_Enum                 => 3,
                                                                                                                               KartenrohstoffeDatentypen.Hochwertiger_Boden_Enum => 3,
                                                                                                                               KartenrohstoffeDatentypen.Gold_Enum               => 3
                                                                                                                              ),

                                                                                                                            KartenartDatentypen.Vier_Rohstoffe_Enum =>
                                                                                                                              (
                                                                                                                               KartenrohstoffeDatentypen.Fisch_Enum              => 4,
                                                                                                                               KartenrohstoffeDatentypen.Wal_Enum                => 4,
                                                                                                                               KartenrohstoffeDatentypen.Hochwertiges_Holz_Enum  => 4,
                                                                                                                               KartenrohstoffeDatentypen.Kohle_Enum              => 4,
                                                                                                                               KartenrohstoffeDatentypen.Eisen_Enum              => 4,
                                                                                                                               KartenrohstoffeDatentypen.Öl_Enum                 => 4,
                                                                                                                               KartenrohstoffeDatentypen.Hochwertiger_Boden_Enum => 4,
                                                                                                                               KartenrohstoffeDatentypen.Gold_Enum               => 4
                                                                                                                              )
                                                                                                                           );

end KartenRecordKonstanten;
