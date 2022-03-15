pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with KartePositionKeinUebergangBerechnungen;

package body KartePositionRueckwaertsUebergangBerechnungen is

   function PositionBestimmenYAchse
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      -- Hier noch Parallelisierung und Grafik mit einbauen.
      YAchseZwischenwert (LogikGrafikExtern, ArrayPositionExtern) := KartePositionKeinUebergangBerechnungen.PositionBestimmenYAchse (YAchseExtern         => YAchseExtern,
                                                                                                                                     ÄnderungYAchseExtern => ÄnderungYAchseExtern);
      
      case
        YAchseZwischenwert (LogikGrafikExtern, ArrayPositionExtern)
      is
         when KartenKonstanten.LeerYAchse =>
            null;
            
         when others =>
            return YAchseZwischenwert (LogikGrafikExtern, ArrayPositionExtern);
      end case;
      
      -----------------------
      -- Hier muss jetzt eine Schleife rein die die Reichweite und Kartengrenzen berücksichtigt.
      -- Beziehungsweise müsste hier rein, wenn man mehr als ein Feld weit eine Einheit bewegen könnte.
      
      if
        ÄnderungYAchseExtern >= 1
      then
         return YAchseExtern + 1 - ÄnderungYAchseExtern;
         
      else
         return YAchseExtern - 1 + ÄnderungYAchseExtern;
      end if;
      
   end PositionBestimmenYAchse;
     
     

   function PositionBestimmenXAchse
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      XAchseZwischenwert (LogikGrafikExtern, ArrayPositionExtern) := KartePositionKeinUebergangBerechnungen.PositionBestimmenXAchse (XAchseExtern         => XAchseExtern,
                                                                                                                                     ÄnderungXAchseExtern => ÄnderungXAchseExtern);
      
      case
        XAchseZwischenwert (LogikGrafikExtern, ArrayPositionExtern)
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            return XAchseZwischenwert (LogikGrafikExtern, ArrayPositionExtern);
      end case;
      
      -----------------------
      -- Hier muss jetzt eine Schleife rein die die Reichweite und Kartengrenzen berücksichtigt.
      -- Beziehungsweise müsste hier rein, wenn man mehr als ein Feld weit eine Einheit bewegen könnte.
      
      if
        ÄnderungXAchseExtern >= 1
      then
         return XAchseExtern + 1 - ÄnderungXAchseExtern;
         
      else
         return XAchseExtern - 1 + ÄnderungXAchseExtern;
      end if;
      
   end PositionBestimmenXAchse;

end KartePositionRueckwaertsUebergangBerechnungen;
