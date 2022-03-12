pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with KartenRecordKonstanten;
with KartenEinstellungenKonstanten;

with KartePositionFesteBerechnungen;
with KartePositionGeraderUebergangBerechnungen;
with KartePositionVerschobenerUebergangBerechnungen;

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
         when KartenEinstellungenKonstanten.KartenformKeinÜbergangEAchseKonstante =>
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
      
      if
        Karten.KartenformEingestellt.XAchseEinstellung = KartenEinstellungenKonstanten.KartenformÜbergangXAchseVerschobenKonstante
      then
         YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionVerschobenerUebergangBerechnungen.PositionBestimmenYAchseVerschoben (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                                               ÄnderungExtern    => ÄnderungExtern);
         
         return YAchsePrüfenEinzelform (KoordinatenExtern => (KoordinatenExtern.EAchse, YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse), KoordinatenExtern.XAchse),
                                         ÄnderungExtern    => ÄnderungExtern,
                                         LogikGrafikExtern => LogikGrafikExtern);
         
      else
         return YAchsePrüfenEinzelform (KoordinatenExtern => KoordinatenExtern,
                                        ÄnderungExtern    => ÄnderungExtern,
                                        LogikGrafikExtern => LogikGrafikExtern);
      end if;
      
   end YAchsePrüfen;
   
   
   
   function YAchsePrüfenEinzelform
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      case
        Karten.KartenformEingestellt.YAchseEinstellung
      is
         when KartenEinstellungenKonstanten.KartenformKeinÜbergangYAchseKonstante =>
            return KartePositionFesteBerechnungen.PositionBestimmenYAchseFest (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                               ÄnderungYAchseExtern => ÄnderungExtern.YAchse);
         
         when KartenEinstellungenKonstanten.KartenformÜbergangYAchseKonstante =>
            return KartePositionGeraderUebergangBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                        ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                        ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                        LogikGrafikExtern    => LogikGrafikExtern);
         
         when KartenEinstellungenKonstanten.KartenformÜbergangYAchseVerschobenKonstante =>
            return 0;
      end case;
      
   end YAchsePrüfenEinzelform;
   
   
   
   function XAchsePrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      if
        Karten.KartenformEingestellt.YAchseEinstellung = KartenEinstellungenKonstanten.KartenformÜbergangYAchseVerschobenKonstante
      then
         XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionVerschobenerUebergangBerechnungen.PositionBestimmenXAchseVerschoben (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                                               ÄnderungExtern    => ÄnderungExtern);
         
         return XAchsePrüfenEinzelform (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse)),
                                         ÄnderungExtern    => ÄnderungExtern,
                                         LogikGrafikExtern => LogikGrafikExtern);
         
      else
         return XAchsePrüfenEinzelform (KoordinatenExtern => KoordinatenExtern,
                                        ÄnderungExtern    => ÄnderungExtern,
                                        LogikGrafikExtern => LogikGrafikExtern);
      end if;
      
   end XAchsePrüfen;
   
   
   
   function XAchsePrüfenEinzelform
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
            
      case
        Karten.KartenformEingestellt.XAchseEinstellung
      is
         when KartenEinstellungenKonstanten.KartenformKeinÜbergangXAchseKonstante =>
            return KartePositionFesteBerechnungen.PositionBestimmenXAchseFest (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                               ÄnderungXAchseExtern => ÄnderungExtern.XAchse);
            
         when KartenEinstellungenKonstanten.KartenformÜbergangXAchseKonstante =>
            return KartePositionGeraderUebergangBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                        ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                        ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                        LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformÜbergangXAchseVerschobenKonstante =>
            return 0;
      end case;
      
   end XAchsePrüfenEinzelform;
   
end KarteKoordinatenPruefen;
