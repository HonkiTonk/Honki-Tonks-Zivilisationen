pragma SPARK_Mode (On);

with KartenKonstanten;

with KartePositionNormaleBerechnungen;

package body KartePositionNormaleKartenformen is

   function KartenPositionXZylinder
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenEAchseFest (EAchseExtern         => KoordinatenExtern.EAchse,
                                                                                                                            ÄnderungEAchseExtern => ÄnderungExtern.EAchse);
      
      case
        EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenKonstanten.LeerEAchse =>
            return KartenKonstanten.LeerKartenKoordinaten;

         when others =>
            YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenYAchseFest (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                                                                  ÄnderungYAchseExtern => ÄnderungExtern.YAchse);
      end case;
      
      case
        YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenKonstanten.LeerYAchse =>
            return KartenKonstanten.LeerKartenKoordinaten;

         when others =>
            XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                                                                ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                                LogikGrafikExtern    => LogikGrafikExtern);

            -- Hier ist ein Test unsinnig, da die XAchse durchgängig ist.
            return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      end case;
            
   end KartenPositionXZylinder;
   
   
   
   function KartenPositionYZylinder
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenEAchseFest (EAchseExtern         => KoordinatenExtern.EAchse,
                                                                                                                            ÄnderungEAchseExtern => ÄnderungExtern.EAchse);
      
      case
        EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenKonstanten.LeerEAchse =>
            return KartenKonstanten.LeerKartenKoordinaten;

         when others =>
            XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenXAchseFest (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                                                                  ÄnderungXAchseExtern => ÄnderungExtern.XAchse);
      end case;
      
      case
        XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenKonstanten.LeerXAchse =>
            return KartenKonstanten.LeerKartenKoordinaten;

         when others =>
            YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                                                                ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                                LogikGrafikExtern    => LogikGrafikExtern);

            -- Hier ist ein Test unsinnig, da die YAchse durchgängig ist.
            return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      end case;
      
   end KartenPositionYZylinder;
   
   
   
   function KartenPositionTorus
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenEAchseFest (EAchseExtern         => KoordinatenExtern.EAchse,
                                                                                                                            ÄnderungEAchseExtern => ÄnderungExtern.EAchse);
      
      case
        EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenKonstanten.LeerEAchse =>
            return KartenKonstanten.LeerKartenKoordinaten;

         when others =>
            -- Hier ist ein Test unsinnig, da die Achsen durchgängig sind.
            YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                                                                ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                                LogikGrafikExtern    => LogikGrafikExtern);
      
            XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                                                                ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                                LogikGrafikExtern    => LogikGrafikExtern);
      
            return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      end case;
      
   end KartenPositionTorus;
   
   
   
   function KartenPositionKugel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenEAchseFest (EAchseExtern         => KoordinatenExtern.EAchse,
                                                                                                                            ÄnderungEAchseExtern => ÄnderungExtern.EAchse);
      
      case
        EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenKonstanten.LeerEAchse =>
            return KartenKonstanten.LeerKartenKoordinaten;

         when others =>
            -- Hier ist ein Test unsinnig, da die Achsen durchgängig sind.
            -- Zwischenposition ist nötig um eine allgemeine Berechnung zu haben. Sonst bräuchte Kugel und Kugel gedreht jeweils eine eigene Berechnung.
            ZwischenPosition (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmen_Y_X_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                              ÄnderungExtern    => ÄnderungExtern,
                                                                                                                                              LogikGrafikExtern => LogikGrafikExtern);
      
            YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := ZwischenPosition (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse;
      
            XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => ZwischenPosition (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse,
                                                                                                                                ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                                LogikGrafikExtern    => LogikGrafikExtern);
      
            return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      end case;
      
   end KartenPositionKugel;
   
   
   
   function KartenPositionViereck
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenEAchseFest (EAchseExtern         => KoordinatenExtern.EAchse,
                                                                                                                            ÄnderungEAchseExtern => ÄnderungExtern.EAchse);
      
      case
        EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenKonstanten.LeerEAchse =>
            return KartenKonstanten.LeerKartenKoordinaten;

         when others =>
            YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenYAchseFest (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                                                                  ÄnderungYAchseExtern => ÄnderungExtern.YAchse);
      end case;
      
      case
        YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenKonstanten.LeerYAchse =>
            return KartenKonstanten.LeerKartenKoordinaten;

         when others =>
            XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenXAchseFest (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                                                                  ÄnderungXAchseExtern => ÄnderungExtern.XAchse);
      end case;
      
      case
        XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenKonstanten.LeerXAchse =>
            return KartenKonstanten.LeerKartenKoordinaten;

         when others =>
            return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      end case;
      
   end KartenPositionViereck;
   
   
   
   function KartenPositionKugelGedreht
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenEAchseFest (EAchseExtern         => KoordinatenExtern.EAchse,
                                                                                                                            ÄnderungEAchseExtern => ÄnderungExtern.EAchse);
      
      case
        EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenKonstanten.LeerEAchse =>
            return KartenKonstanten.LeerKartenKoordinaten;

         when others =>
            -- Hier ist ein Test unsinnig, da die Achsen durchgängig sind.
            -- Zwischenposition ist nötig um eine allgemeine Berechnung zu haben. Sonst bräuchte Kugel und Kugel gedreht jeweils eine eigene Berechnung.
            ZwischenPosition (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmen_X_Y_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                              ÄnderungExtern    => ÄnderungExtern,
                                                                                                                                              LogikGrafikExtern => LogikGrafikExtern);
      
            XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := ZwischenPosition (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse;
      
            YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => ZwischenPosition (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse,
                                                                                                                                ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                                LogikGrafikExtern    => LogikGrafikExtern);
            
            return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      end case;
      
   end KartenPositionKugelGedreht;

end KartePositionNormaleKartenformen;
