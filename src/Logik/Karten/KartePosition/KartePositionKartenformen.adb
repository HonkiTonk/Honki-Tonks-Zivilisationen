pragma SPARK_Mode (On);

with KartenKonstanten;

with KartePositionBerechnungen;

package body KartePositionKartenformen is

   function KartenPositionXZylinder
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                                     ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYAchseFest (YAchseExtern          => KoordinatenExtern.YAchse,
                                                                                                                     ÄnderungYAchseExtern  => ÄnderungExtern.YAchse);
      
      case
        YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.KartenfeldPositivMitNullwert'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXWechsel (XAchseExtern          => KoordinatenExtern.XAchse,
                                                                                                                   ÄnderungXAchseExtern  => ÄnderungExtern.XAchse,
                                                                                                                   ArrayPositionExtern   => KoordinatenExtern.EAchse,
                                                                                                                   LogikGrafikExtern     => LogikGrafikExtern);

      return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      
      
   end KartenPositionXZylinder;
   
   
   
   function KartenPositionYZylinder
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                                     ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXAchseFest (XAchseExtern          => KoordinatenExtern.XAchse,
                                                                                                                     ÄnderungXAchseExtern  => ÄnderungExtern.XAchse);
      
      case
        XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.KartenfeldPositivMitNullwert'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                                                   ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                                   ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                   LogikGrafikExtern    => LogikGrafikExtern);

      return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      
   end KartenPositionYZylinder;
   
   
   
   function KartenPositionTorus
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                                     ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                                                   ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                                   ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                   LogikGrafikExtern    => LogikGrafikExtern);
      
      XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                                                   ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                                   ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                   LogikGrafikExtern    => LogikGrafikExtern);
      
      return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      
   end KartenPositionTorus;
   
   
   
   function KartenPositionKugel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                                     ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      ZwischenPositionAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_Y_X_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                      ÄnderungExtern    => ÄnderungExtern,
                                                                                                                                      LogikGrafikExtern => LogikGrafikExtern);
      
      YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := ZwischenPositionAchse (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse;
      
      XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => ZwischenPositionAchse (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse,
                                                                                                                   ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                                   ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                   LogikGrafikExtern    => LogikGrafikExtern);
      
      return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      
   end KartenPositionKugel;
   
   
   
   function KartenPositionViereck
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                                     ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYAchseFest (YAchseExtern          => KoordinatenExtern.YAchse,
                                                                                                                     ÄnderungYAchseExtern  => ÄnderungExtern.YAchse);
      
      case
        YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.KartenfeldPositivMitNullwert'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;
      
      XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXAchseFest (XAchseExtern          => KoordinatenExtern.XAchse,
                                                                                                                     ÄnderungXAchseExtern  => ÄnderungExtern.XAchse);
      
      case
        XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.KartenfeldPositivMitNullwert'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      
   end KartenPositionViereck;
   
   
   
   function KartenPositionKugelGedreht
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                                     ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      ZwischenPositionAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_X_Y_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                      ÄnderungExtern    => ÄnderungExtern,
                                                                                                                                      LogikGrafikExtern => LogikGrafikExtern);
      
      XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := ZwischenPositionAchse (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse;
      
      YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => ZwischenPositionAchse (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse,
                                                                                                                   ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                                   ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                   LogikGrafikExtern    => LogikGrafikExtern);
      
      return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      
   end KartenPositionKugelGedreht;
   
   
   
   -- Die Tugel brauchen wahrscheinlich neue Berechnungen
   function KartenPositionTugel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                                     ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;
            
      ZwischenPositionAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_Y_X_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                      ÄnderungExtern    => ÄnderungExtern,
                                                                                                                                      LogikGrafikExtern => LogikGrafikExtern);
      
      ZwischenPositionTugelAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_X_Y_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                           ÄnderungExtern    => ÄnderungExtern,
                                                                                                                                           LogikGrafikExtern => LogikGrafikExtern);
      
      YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => ZwischenPositionTugelAchse (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse,
                                                                                                                   ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                                   ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                   LogikGrafikExtern    => LogikGrafikExtern);
            
      XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => ZwischenPositionAchse (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse,
                                                                                                                   ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                                   ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                   LogikGrafikExtern    => LogikGrafikExtern);
      
      return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      
   end KartenPositionTugel;
   
   
   
   function KartenPositionTugelGedreht
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                                     ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;
            
      ZwischenPositionAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_Y_X_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                      ÄnderungExtern    => ÄnderungExtern,
                                                                                                                                      LogikGrafikExtern => LogikGrafikExtern);
      
      ZwischenPositionTugelAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_X_Y_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                           ÄnderungExtern    => ÄnderungExtern,
                                                                                                                                           LogikGrafikExtern => LogikGrafikExtern);
      
      YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => ZwischenPositionTugelAchse (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse,
                                                                                                                   ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                                   ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                   LogikGrafikExtern    => LogikGrafikExtern);
            
      XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => ZwischenPositionAchse (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse,
                                                                                                                   ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                                   ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                   LogikGrafikExtern    => LogikGrafikExtern);
      
      return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      
   end KartenPositionTugelGedreht;
   
   
     
   function KartenPositionTugelExtrem
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                                     ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;
            
      ZwischenPositionAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_Y_X_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                      ÄnderungExtern    => ÄnderungExtern,
                                                                                                                                      LogikGrafikExtern => LogikGrafikExtern);
      
      ZwischenPositionTugelAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_X_Y_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                           ÄnderungExtern    => ÄnderungExtern,
                                                                                                                                           LogikGrafikExtern => LogikGrafikExtern);
      
      YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => ZwischenPositionTugelAchse (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse,
                                                                                                                   ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                                   ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                   LogikGrafikExtern    => LogikGrafikExtern);
            
      XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => ZwischenPositionAchse (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse,
                                                                                                                   ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                                   ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                   LogikGrafikExtern    => LogikGrafikExtern);
      
      return (EAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), YAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
      
   end KartenPositionTugelExtrem;

end KartePositionKartenformen;
