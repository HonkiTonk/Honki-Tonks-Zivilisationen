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
      
      NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).EAchse := EAchsePrüfen (KoordinatenExtern => KoordinatenExtern,
                                                                                            ÄnderungExtern    => ÄnderungExtern,
                                                                                            LogikGrafikExtern => LogikGrafikExtern);
      
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
   
   
   
   function EAchsePrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.Ebene
   is begin
      
      case
        Karten.KartenformEingestellt.EAchseEinstellung
      is
         when KartenEinstellungenKonstanten.KartenformFesteEAchseKonstante =>
            return KartePositionFesteBerechnungen.PositionBestimmenEAchseFest (EAchseExtern         => KoordinatenExtern.EAchse,
                                                                               ÄnderungEAchseExtern => ÄnderungExtern.EAchse);
            
         when KartenEinstellungenKonstanten.KartenformÜbergangEAchseKonstante =>
            return KartePositionGeraderUebergangBerechnungen.PositionBestimmenEWechsel (EAchseExtern          => KoordinatenExtern.EAchse,
                                                                                        ÄnderungEAchseExtern  => ÄnderungExtern.EAchse,
                                                                                        ArrayPositionExtern   => KoordinatenExtern.EAchse,
                                                                                        LogikGrafikExtern     => LogikGrafikExtern);
      end case;
      
   end EAchsePrüfen;
   
   
   
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
            return 0;
            -- return KartePositionVerschobenerUebergangBerechnungen.PositionBestimmen_Y_X_Wechsel (KoordinatenExtern => KoordinatenExtern,
            --                                                                                      ÄnderungExtern    => ÄnderungExtern,
            --                                                                                      LogikGrafikExtern => LogikGrafikExtern);
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
            return 0;
            -- return KartePositionVerschobenerUebergangBerechnungen.PositionBestimmen_X_Y_Wechsel (KoordinatenExtern => KoordinatenExtern,
            --                                                                                      ÄnderungExtern    => ÄnderungExtern,
            --                                                                                      LogikGrafikExtern => LogikGrafikExtern);
      end case;
      
   end XAchsePrüfen;
   
end KarteKoordinatenPruefen;
