pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with KartenRecordKonstanten;
with KartenEinstellungenKonstanten;

with KartePositionKeinUebergangBerechnungen;
with KartePositionGeraderUebergangBerechnungen;
with KartePositionVerschobenerUebergangBerechnungen;
with KartePositionRueckwaertsUebergangBerechnungen;

package body KarteKoordinatenPruefen is
   
   function KarteKoordinatenPrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      -- Die Prüfung wird ständig aufgerufen, müssten die Renderer und die Mausbewegung sein. Kann man diese Aufrufe reduzieren?
      -- Die Arrays sind da wegen der Parallelisierung der Kartenfelderbewertung und weil das hier von Logik und Grafik benötigt wird.
      
      
      -- Eventuell muss in die Unterbereiche nicht immer alles und als kompletter Record übergeben werden, sondern es reichen auch einzelne Werte.
      -- Das hier gleich mal sauber mit einbauen!
      -- Danach die RückwärtsÜbergangSchleife einbauen.
      -- Dann das Menü zurecht biegen, das wird interessant.
      -- Generell mal ein besseres Menüsystem mit festen Plätzen bauen.
      
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
            return KartePositionKeinUebergangBerechnungen.PositionBestimmenEAchse (EAchseExtern         => KoordinatenExtern.EAchse,
                                                                                   ÄnderungEAchseExtern => ÄnderungExtern.EAchse);
            
         when KartenEinstellungenKonstanten.KartenformÜbergangEAchseKonstante =>
            return KartePositionGeraderUebergangBerechnungen.PositionBestimmenEAchse (EAchseExtern          => KoordinatenExtern.EAchse,
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
         YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionVerschobenerUebergangBerechnungen.PositionBestimmenYAchse (KoordinatenExtern => KoordinatenExtern,
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
            return KartePositionKeinUebergangBerechnungen.PositionBestimmenYAchse (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                   ÄnderungYAchseExtern => ÄnderungExtern.YAchse);
         
            ----------------- Kann man das so zusammenfassen oder kommt es da in bestimmten Fällen zu Fehlern?
         when KartenEinstellungenKonstanten.KartenformÜbergangYAchseKonstante | KartenEinstellungenKonstanten.KartenformÜbergangYAchseVerschobenKonstante =>
            return KartePositionGeraderUebergangBerechnungen.PositionBestimmenYAchse (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                      ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                      ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                      LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformRückwärtsVerschobenerÜbergangYAchseKonstante =>
            return KartePositionRueckwaertsUebergangBerechnungen.PositionBestimmenYAchse (KoordinatenExtern => KoordinatenExtern,
                                                                                          ÄnderungExtern    => ÄnderungExtern);
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
         XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionVerschobenerUebergangBerechnungen.PositionBestimmenXAchse (KoordinatenExtern => KoordinatenExtern,
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
            return KartePositionKeinUebergangBerechnungen.PositionBestimmenXAchse (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                   ÄnderungXAchseExtern => ÄnderungExtern.XAchse);
            
            ----------------- Kann man das so zusammenfassen oder kommt es da in bestimmten Fällen zu Fehlern?
         when KartenEinstellungenKonstanten.KartenformÜbergangXAchseKonstante | KartenEinstellungenKonstanten.KartenformÜbergangXAchseVerschobenKonstante =>
            return KartePositionGeraderUebergangBerechnungen.PositionBestimmenXAchse (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                      ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                      ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                      LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformRückwärtsVerschobenerÜbergangXAchseKonstante =>
            return KartePositionRueckwaertsUebergangBerechnungen.PositionBestimmenXAchse (KoordinatenExtern => KoordinatenExtern,
                                                                                          ÄnderungExtern    => ÄnderungExtern);
      end case;
      
   end XAchsePrüfenEinzelform;
   
end KarteKoordinatenPruefen;
