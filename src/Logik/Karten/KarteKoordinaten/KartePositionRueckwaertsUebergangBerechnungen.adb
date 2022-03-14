pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with KartePositionKeinUebergangBerechnungen;

package body KartePositionRueckwaertsUebergangBerechnungen is

   function PositionBestimmenYAchse
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      -- Hier noch Parallelisierung und Grafik mit einbauen.
      YAchseZwischenwert := KartePositionKeinUebergangBerechnungen.PositionBestimmenYAchse (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                            ÄnderungYAchseExtern => ÄnderungExtern.YAchse);
      
      case
        YAchseZwischenwert
      is
         when KartenKonstanten.LeerYAchse =>
            null;
            
         when others =>
            return YAchseZwischenwert;
      end case;
      
      if
        ÄnderungExtern.YAchse = 1
        or
        ÄnderungExtern.YAchse = -1
      then
         return KoordinatenExtern.YAchse;
         
      else
         null;
      end if;
      
      -- Hier muss jetzt eine Schleife rein die die Reichweite und Kartengrenzen berücksichtigt.
      
      return 0;
      
   end PositionBestimmenYAchse;
     
     

   function PositionBestimmenXAchse
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      XAchseZwischenwert := KartePositionKeinUebergangBerechnungen.PositionBestimmenXAchse (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                            ÄnderungXAchseExtern => ÄnderungExtern.XAchse);
      
      case
        XAchseZwischenwert
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            return XAchseZwischenwert;
      end case;
      
      if
        ÄnderungExtern.XAchse = 1
        or
          ÄnderungExtern.XAchse = -1
      then
         return KoordinatenExtern.XAchse;
         
      else
         null;
      end if;
      
      return 0;
      
   end PositionBestimmenXAchse;

end KartePositionRueckwaertsUebergangBerechnungen;
