pragma SPARK_Mode (On);

with KartenRecordKonstanten;

with KartePositionNormaleKartenformen;
with KartePositionAbstrakteKartenformen;
with KartenEinstellungenKonstanten;
with KartePositionNormaleBerechnungen;
-- with KartePositionAbstrakteBerechnungen;

package body KarteKoordinatenPruefen is
   
   function KarteKoordinatenPrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      -- Neu schreiben. Läuft.
      -- Die Prüfung wird ständig aufgerufen, müssten die Renderer und die Mausbewegung sein. Kann man diese Aufrufe reduzieren?
      -- Die Arrays sind da wegen der Parallelisierung der Kartenfelderbewertung und weil das hier von Logik und Grafik benötigt wird.
      
      -- Berechnungen anders aufteilen, z. B. in Fest, Übergang, ÜbergangVerschoben, usw.
      case
        Karten.KartenformEingestellt.EAchseEinstellung
      is
         when KartenEinstellungenKonstanten.KartenformFesteEAchseKonstante =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).EAchse := KartePositionNormaleBerechnungen.PositionBestimmenEAchseFest (EAchseExtern         => KoordinatenExtern.EAchse,
                                                                                                                                                 ÄnderungEAchseExtern => ÄnderungExtern.EAchse);
            
         when KartenEinstellungenKonstanten.KartenformÜbergangEAchseKonstante =>
            null;
      end case;
      
      case
        NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return KartenRecordKonstanten.LeerKartenKoordinaten;
            
         when others =>
            null;
      end case;
      
      case
        Karten.KartenformEingestellt.YAchseEinstellung
      is
         when KartenEinstellungenKonstanten.KartenformFesteYAchseKonstante =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := KartePositionNormaleBerechnungen.PositionBestimmenYAchseFest (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                                                                                 ÄnderungYAchseExtern => ÄnderungExtern.YAchse);
            
         when KartenEinstellungenKonstanten.KartenformÜbergangYAchseKonstante =>
            null;
            
         when KartenEinstellungenKonstanten.KartenformÜbergangYAchseVerschobenKonstante =>
            null;
      end case;
      
      case
        NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse
      is
         when KartenKonstanten.LeerYAchse =>
            return KartenRecordKonstanten.LeerKartenKoordinaten;
            
         when others =>
            null;
      end case;
      
      case
        Karten.KartenformEingestellt.XAchseEinstellung
      is
         when KartenEinstellungenKonstanten.KartenformFesteXAchseKonstante =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse := KartePositionNormaleBerechnungen.PositionBestimmenXAchseFest (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                                                                                 ÄnderungXAchseExtern => ÄnderungExtern.XAchse);
            
         when KartenEinstellungenKonstanten.KartenformÜbergangXAchseKonstante =>
            null;
            
         when KartenEinstellungenKonstanten.KartenformÜbergangXAchseVerschobenKonstante =>
            null;
      end case;
      
      case
        NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return KartenRecordKonstanten.LeerKartenKoordinaten;
            
         when others =>
            -- return NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse);
            null;
      end case;
      
      case
        Karten.Kartenform
      is
         -- Normale Kartenformen
         when KartenEinstellungenKonstanten.KartenformXZylinderKonstante =>
            return KartePositionNormaleKartenformen.KartenPositionXZylinder (KoordinatenExtern => KoordinatenExtern,
                                                                             ÄnderungExtern    => ÄnderungExtern,
                                                                             LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformYZylinderKonstante =>
            return KartePositionNormaleKartenformen.KartenPositionYZylinder (KoordinatenExtern => KoordinatenExtern,
                                                                             ÄnderungExtern    => ÄnderungExtern,
                                                                             LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformTorusKonstante =>
            return KartePositionNormaleKartenformen.KartenPositionTorus (KoordinatenExtern => KoordinatenExtern,
                                                                         ÄnderungExtern    => ÄnderungExtern,
                                                                         LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformKugelKonstante =>
            return KartePositionNormaleKartenformen.KartenPositionKugel (KoordinatenExtern => KoordinatenExtern,
                                                                         ÄnderungExtern    => ÄnderungExtern,
                                                                         LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformViereckKonstante =>
            return KartePositionNormaleKartenformen.KartenPositionViereck (KoordinatenExtern => KoordinatenExtern,
                                                                           ÄnderungExtern    => ÄnderungExtern,
                                                                           LogikGrafikExtern => LogikGrafikExtern);

         when KartenEinstellungenKonstanten.KartenformKugelGedrehtKonstante =>
            return KartePositionNormaleKartenformen.KartenPositionKugelGedreht (KoordinatenExtern => KoordinatenExtern,
                                                                                ÄnderungExtern    => ÄnderungExtern,
                                                                                LogikGrafikExtern => LogikGrafikExtern);
            -- Normale Kartenformen
            
            
            
            -- Abstrakte Kartenformen
         when KartenEinstellungenKonstanten.KartenformTugelKonstante =>
            return KartePositionAbstrakteKartenformen.KartenPositionTugel (KoordinatenExtern => KoordinatenExtern,
                                                                           ÄnderungExtern    => ÄnderungExtern,
                                                                           LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformTugelGedrehtKonstante =>
            return KartePositionAbstrakteKartenformen.KartenPositionTugelGedreht (KoordinatenExtern => KoordinatenExtern,
                                                                                  ÄnderungExtern    => ÄnderungExtern,
                                                                                  LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformTugelExtremKonstante =>
            return KartePositionAbstrakteKartenformen.KartenPositionTugelExtrem (KoordinatenExtern => KoordinatenExtern,
                                                                                 ÄnderungExtern    => ÄnderungExtern,
                                                                                 LogikGrafikExtern => LogikGrafikExtern);
            
            
            -- Abstrakte Kartenformen
      end case;
      
   end KarteKoordinatenPrüfen;
   
end KarteKoordinatenPruefen;
