pragma SPARK_Mode (On);

with KartenKonstanten;
with KartenRecordKonstanten;

with KartePositionNormaleBerechnungen;
with KartePositionAbstrakteBerechnungen;

package body KartePositionAbstrakteKartenformen is
   
   function KartenPositionTugel
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
            return KartenRecordKonstanten.LeerKartenKoordinaten;

         when others =>
            ZwischenPositionEins (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionAbstrakteBerechnungen.PositionBestimmen_Y_X_WechselTugel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                                         ÄnderungExtern    => ÄnderungExtern,
                                                                                                                                                         LogikGrafikExtern => LogikGrafikExtern);
            
            YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := ZwischenPositionEins (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse;
            
            XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
              := KartePositionNormaleBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => ZwischenPositionEins (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse,
                                                                             ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                             ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                             LogikGrafikExtern    => LogikGrafikExtern);
            
            return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      end case;
      
   end KartenPositionTugel;
   
   
   
   function KartenPositionTugelGedreht
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
            return KartenRecordKonstanten.LeerKartenKoordinaten;

         when others =>
            ZwischenPositionZwei (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionAbstrakteBerechnungen.PositionBestimmen_X_Y_WechselTugel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                                         ÄnderungExtern    => ÄnderungExtern,
                                                                                                                                                         LogikGrafikExtern => LogikGrafikExtern);
            
            XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := ZwischenPositionZwei (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse;
      
            YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
              := KartePositionNormaleBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => ZwischenPositionZwei (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse,
                                                                             ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                             ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                             LogikGrafikExtern    => LogikGrafikExtern);
      
            return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      end case;
      
   end KartenPositionTugelGedreht;
   
   
   
   function KartenPositionTugelExtrem
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
            return KartenRecordKonstanten.LeerKartenKoordinaten;

         when others =>
            ZwischenPositionEins (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionAbstrakteBerechnungen.PositionBestimmen_Y_X_WechselTugel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                                         ÄnderungExtern    => ÄnderungExtern,
                                                                                                                                                         LogikGrafikExtern => LogikGrafikExtern);
            
            ZwischenPositionZwei (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionAbstrakteBerechnungen.PositionBestimmen_X_Y_WechselTugel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                                         ÄnderungExtern    => ÄnderungExtern,
                                                                                                                                                         LogikGrafikExtern => LogikGrafikExtern);
            
            YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
              := KartePositionNormaleBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => ZwischenPositionZwei (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse,
                                                                             ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                             ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                             LogikGrafikExtern    => LogikGrafikExtern);
            
            XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
              := KartePositionNormaleBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => ZwischenPositionEins (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse,
                                                                             ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                             ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                             LogikGrafikExtern    => LogikGrafikExtern);
      
            return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      end case;
      
   end KartenPositionTugelExtrem;

end KartePositionAbstrakteKartenformen;
