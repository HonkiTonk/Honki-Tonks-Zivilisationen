pragma SPARK_Mode (On);

with KartenKonstanten;

with KartePositionBerechnungen;

package body KartePositionKartenformen is

   function KartenPositionXZylinder
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                  ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      YAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYAchseFest (YAchseExtern          => KoordinatenExtern.YAchse,
                                                                                                  ÄnderungYAchseExtern  => ÄnderungExtern.YAchse);
      
      case
        YAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.KartenfeldPositivMitNullwert'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      XAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                                ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse);

      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
      
   end KartenPositionXZylinder;
   
   
   
   function KartenPositionYZylinder
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                  ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      XAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXAchseFest (XAchseExtern          => KoordinatenExtern.XAchse,
                                                                                                  ÄnderungXAchseExtern  => ÄnderungExtern.XAchse);
      
      case
        XAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.KartenfeldPositivMitNullwert'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      YAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                                ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse);

      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
   end KartenPositionYZylinder;
   
   
   
   function KartenPositionTorus
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                  ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      YAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                                ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse);
      
      XAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                                ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse);
      
      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
   end KartenPositionTorus;
   
   
   
   function KartenPositionKugel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                  ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      ZwischenPositionAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_Y_X_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                   ÄnderungExtern    => ÄnderungExtern);
      
      YAchse (KoordinatenExtern.EAchse) := ZwischenPositionAchse (KoordinatenExtern.EAchse).YAchse;
      
      XAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => ZwischenPositionAchse (KoordinatenExtern.EAchse).XAchse,
                                                                                                ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse);
      
      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
   end KartenPositionKugel;
   
   
   
   function KartenPositionViereck
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                  ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      YAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYAchseFest (YAchseExtern          => KoordinatenExtern.YAchse,
                                                                                                  ÄnderungYAchseExtern  => ÄnderungExtern.YAchse);
      
      case
        YAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.KartenfeldPositivMitNullwert'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;
      
      XAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXAchseFest (XAchseExtern          => KoordinatenExtern.XAchse,
                                                                                                  ÄnderungXAchseExtern  => ÄnderungExtern.XAchse);
      
      case
        XAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.KartenfeldPositivMitNullwert'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
   end KartenPositionViereck;
   
   
   
   function KartenPositionKugelGedreht
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                  ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;

      ZwischenPositionAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_X_Y_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                   ÄnderungExtern    => ÄnderungExtern);
      
      XAchse (KoordinatenExtern.EAchse) := ZwischenPositionAchse (KoordinatenExtern.EAchse).XAchse;
      
      YAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => ZwischenPositionAchse (KoordinatenExtern.EAchse).YAchse,
                                                                                                ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse);
      
      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
   end KartenPositionKugelGedreht;
   
   
   
   -- Die Tugel brauchen wahrscheinlich neue Berechnungen
   function KartenPositionTugel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                  ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;
            
      ZwischenPositionAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_Y_X_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                   ÄnderungExtern    => ÄnderungExtern);
      
      ZwischenPositionTugelAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_X_Y_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                        ÄnderungExtern    => ÄnderungExtern);
      
      YAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => ZwischenPositionTugelAchse (KoordinatenExtern.EAchse).YAchse,
                                                                                                ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse);
            
      XAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => ZwischenPositionAchse (KoordinatenExtern.EAchse).XAchse,
                                                                                                ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse);
      
      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
   end KartenPositionTugel;
   
   
   
   function KartenPositionTugelGedreht
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                  ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;
            
      ZwischenPositionAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_Y_X_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                   ÄnderungExtern    => ÄnderungExtern);
      
      ZwischenPositionTugelAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_X_Y_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                        ÄnderungExtern    => ÄnderungExtern);
      
      YAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => ZwischenPositionTugelAchse (KoordinatenExtern.EAchse).YAchse,
                                                                                                ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse);
            
      XAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => ZwischenPositionAchse (KoordinatenExtern.EAchse).XAchse,
                                                                                                ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse);
      
      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
   end KartenPositionTugelGedreht;
   
   
     
   function KartenPositionTugelExtrem
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      EAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenEAchseFest (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                                  ÄnderungEAchseExtern  => ÄnderungExtern.EAchse);
      
      case
        EAchse (KoordinatenExtern.EAchse)
      is
         when GlobaleDatentypen.Ebene'First =>
            return KartenKonstanten.LeerKartenPosition;

         when others =>
            null;
      end case;
            
      ZwischenPositionAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_Y_X_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                   ÄnderungExtern    => ÄnderungExtern);
      
      ZwischenPositionTugelAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmen_X_Y_Wechsel (KoordinatenExtern => KoordinatenExtern,
                                                                                                                        ÄnderungExtern    => ÄnderungExtern);
      
      YAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => ZwischenPositionTugelAchse (KoordinatenExtern.EAchse).YAchse,
                                                                                                ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse);
            
      XAchse (KoordinatenExtern.EAchse) := KartePositionBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => ZwischenPositionAchse (KoordinatenExtern.EAchse).XAchse,
                                                                                                ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                ArrayPositionExtern  => KoordinatenExtern.EAchse);
      
      return (EAchse (KoordinatenExtern.EAchse), YAchse (KoordinatenExtern.EAchse), XAchse (KoordinatenExtern.EAchse));
      
   end KartenPositionTugelExtrem;

end KartePositionKartenformen;
