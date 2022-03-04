pragma SPARK_Mode (On);

with KartenRecordKonstanten;
with KartenEinstellungenKonstanten;

with KartePositionFesteBerechnungen;
with KartePositionGeraderUebergangBerechnungen;
-- with KartePositionVerschobenerUebergangBerechnungen;

package body KarteKoordinatenPruefen is
   
   function KarteKoordinatenPrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      -- Die Prüfung wird ständig aufgerufen, müssten die Renderer und die Mausbewegung sein. Kann man diese Aufrufe reduzieren?
      -- Die Arrays sind da wegen der Parallelisierung der Kartenfelderbewertung und weil das hier von Logik und Grafik benötigt wird.
      -- Eventuell muss in die Unterbereiche nicht immer alles und als kompletter Record übergeben werden, sondern es reichen auch einzelne Werte
      
      -- Berechnungen anders aufteilen, z. B. in Fest, Übergang, ÜbergangVerschoben, usw.
      case
        Karten.KartenformEingestellt.EAchseEinstellung
      is
         when KartenEinstellungenKonstanten.KartenformFesteEAchseKonstante =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).EAchse := KartePositionFesteBerechnungen.PositionBestimmenEAchseFest (EAchseExtern         => KoordinatenExtern.EAchse,
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
        Karten.KartenformEingestellt.YZuerstBerechnenXZuerstBerechnen
      is
         when True =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := YAchsePrüfen (KoordinatenExtern => KoordinatenExtern,
                                                                                                  ÄnderungExtern   => ÄnderungExtern,
                                                                                                  LogikGrafikExtern => LogikGrafikExtern);
      
            if
              NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse = KartenKonstanten.LeerYAchse
            then
               return KartenRecordKonstanten.LeerKartenKoordinaten;
            
            else
               NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse := XAchsePrüfen (KoordinatenExtern => KoordinatenExtern,
                                                                                                     ÄnderungExtern    => ÄnderungExtern,
                                                                                                     LogikGrafikExtern => LogikGrafikExtern);
            end if;
            
         when False =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse := XAchsePrüfen (KoordinatenExtern => KoordinatenExtern,
                                                                                                  ÄnderungExtern   => ÄnderungExtern,
                                                                                                  LogikGrafikExtern => LogikGrafikExtern);
      
            if
              NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse = KartenKonstanten.LeerXAchse
            then
               return KartenRecordKonstanten.LeerKartenKoordinaten;
            
            else
               NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := YAchsePrüfen (KoordinatenExtern => KoordinatenExtern,
                                                                                                     ÄnderungExtern    => ÄnderungExtern,
                                                                                                     LogikGrafikExtern => LogikGrafikExtern);
            end if;
      end case;
      
      return NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse);
      
   end KarteKoordinatenPrüfen;
   
   
   
   function YAchsePrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
            
      case
        Karten.KartenformEingestellt.YAchseEinstellung
      is
         when KartenEinstellungenKonstanten.KartenformFesteYAchseKonstante =>
            return KartePositionFesteBerechnungen.PositionBestimmenYAchseFest (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                               ÄnderungYAchseExtern => ÄnderungExtern.YAchse);
            
         when KartenEinstellungenKonstanten.KartenformÜbergangYAchseKonstante =>
            return KartePositionGeraderUebergangBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                        ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                        ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                        LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformÜbergangYAchseVerschobenKonstante =>
            -- return KartePositionVerschobenerUebergangBerechnungen.PositionBestimmen_Y_X_Wechsel (KoordinatenExtern => KoordinatenExtern,
            --                                                                                      ÄnderungExtern    => ÄnderungExtern,
            --                                                                                     LogikGrafikExtern => LogikGrafikExtern);
            return 0;
      end case;
      
   end YAchsePrüfen;
   
   
   
   function XAchsePrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      case
        Karten.KartenformEingestellt.XAchseEinstellung
      is
         when KartenEinstellungenKonstanten.KartenformFesteXAchseKonstante =>
            return KartePositionFesteBerechnungen.PositionBestimmenXAchseFest (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                               ÄnderungXAchseExtern => ÄnderungExtern.XAchse);
            
         when KartenEinstellungenKonstanten.KartenformÜbergangXAchseKonstante =>
            return KartePositionGeraderUebergangBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                        ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                        ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                        LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformÜbergangXAchseVerschobenKonstante =>
          --  return KartePositionVerschobenerUebergangBerechnungen.PositionBestimmen_X_Y_Wechsel (KoordinatenExtern => KoordinatenExtern,
         --                                                                                        ÄnderungExtern    => ÄnderungExtern,
         --                                                                                        LogikGrafikExtern => LogikGrafikExtern);
            return 0;
      end case;
      
   end XAchsePrüfen;
   
end KarteKoordinatenPruefen;
