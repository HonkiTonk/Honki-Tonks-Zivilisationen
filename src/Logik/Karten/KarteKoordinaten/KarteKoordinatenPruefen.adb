pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

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
      
      -- Die Prüfung wird ständig aufgerufen, müssten die Renderer und die Mausbewegung sein. Kann man diese Aufrufe reduzieren? --------------------
      -- Die Arrays sind da wegen der Parallelisierung der Kartenfelderbewertung und weil das hier von Logik und Grafik benötigt wird.
      -- Ist folgende Prüfung sinnvoll/bringt die bessere Performance? --------------------
      -- if
      --  ÄnderungExtern.EAchse = 0
      --  and
      --    ÄnderungExtern.YAchse = 0
      --    and
      --      ÄnderungExtern.XAchse = 0
      -- then
      --   return KartenRecordKonstanten.LeerKartenKoordinaten;
         
      -- else
      --   null;
      -- end if;
                  
      if
        ÄnderungExtern.EAchse /= 0
      then
         NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).EAchse := EAchsePrüfen (EAchseExtern         => KoordinatenExtern.EAchse,
                                                                                               ÄnderungEAchseExtern => ÄnderungExtern.EAchse,
                                                                                               LogikGrafikExtern    => LogikGrafikExtern);
         
         case
           NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).EAchse
         is
            when KartenKonstanten.LeerEAchse =>
               return KartenRecordKonstanten.LeerKartenKoordinaten;
            
            when others =>
               null;
         end case;
         
      else
         NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).EAchse := KoordinatenExtern.EAchse;
      end if;
         
      case
        Karten.KartenformEingestellt.YZuerstBerechnenXZuerstBerechnen
      is
         when True =>
            if
              ÄnderungExtern.YAchse /= 0
            then
               NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := YAchsePrüfen (KoordinatenExtern     => KoordinatenExtern,
                                                                                                     ÄnderungYXAchseExtern => (ÄnderungExtern.YAchse, ÄnderungExtern.XAchse),
                                                                                                     LogikGrafikExtern     => LogikGrafikExtern);
               
            else
               NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := KoordinatenExtern.YAchse;
            end if;
               
            if
              NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse = KartenKonstanten.LeerYAchse
            then
               return KartenRecordKonstanten.LeerKartenKoordinaten;
               
            elsif
              ÄnderungExtern.XAchse /= 0
            then
               NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse := XAchsePrüfen (KoordinatenExtern     => KoordinatenExtern,
                                                                                                     ÄnderungYXAchseExtern => (ÄnderungExtern.YAchse, ÄnderungExtern.XAchse),
                                                                                                     LogikGrafikExtern     => LogikGrafikExtern);
            
            else
               NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse := KoordinatenExtern.XAchse;
            end if;
            
         when False =>
            if
              ÄnderungExtern.XAchse /= 0
            then
               NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse := XAchsePrüfen (KoordinatenExtern     => KoordinatenExtern,
                                                                                                     ÄnderungYXAchseExtern => (ÄnderungExtern.YAchse, ÄnderungExtern.XAchse),
                                                                                                     LogikGrafikExtern     => LogikGrafikExtern);
               
            else
               NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse := KoordinatenExtern.XAchse;
            end if;
               
            if
              NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse = KartenKonstanten.LeerXAchse
            then
               return KartenRecordKonstanten.LeerKartenKoordinaten;
               
            elsif
              ÄnderungExtern.YAchse /= 0
            then
               NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := YAchsePrüfen (KoordinatenExtern     => KoordinatenExtern,
                                                                                                     ÄnderungYXAchseExtern => (ÄnderungExtern.YAchse, ÄnderungExtern.XAchse),
                                                                                                     LogikGrafikExtern     => LogikGrafikExtern);
            
            else
               NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := KoordinatenExtern.YAchse;
            end if;
      end case;
      
      return NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse);
      
   end KarteKoordinatenPrüfen;
   
   
   
   function EAchsePrüfen
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.Ebene
   is begin
      
      case
        Karten.KartenformEingestellt.EAchseEinstellung
      is
         when KartenEinstellungenKonstanten.KartenformKeinÜbergangEAchseKonstante =>
            return KartePositionKeinUebergangBerechnungen.PositionBestimmenEAchse (EAchseExtern         => EAchseExtern,
                                                                                   ÄnderungEAchseExtern => ÄnderungEAchseExtern);
            
         when KartenEinstellungenKonstanten.KartenformÜbergangEAchseKonstante =>
            return KartePositionGeraderUebergangBerechnungen.PositionBestimmenEAchse (EAchseExtern          => EAchseExtern,
                                                                                      ÄnderungEAchseExtern  => ÄnderungEAchseExtern,
                                                                                      ArrayPositionExtern   => EAchseExtern,
                                                                                      LogikGrafikExtern     => LogikGrafikExtern);
      end case;
      
   end EAchsePrüfen;
   
   
   
   function YAchsePrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungYXAchseExtern : in KartenRecords.YXAchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      if
        Karten.KartenformEingestellt.XAchseEinstellung = KartenEinstellungenKonstanten.KartenformÜbergangXAchseVerschobenKonstante
      then
         YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse)
           := KartePositionVerschobenerUebergangBerechnungen.PositionBestimmenYAchse (KoordinatenExtern => (KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                                                                      ÄnderungExtern    => ÄnderungYXAchseExtern);
         
         return YAchsePrüfenEinzelform (KoordinatenExtern     => (KoordinatenExtern.EAchse, YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse), KoordinatenExtern.XAchse),
                                         ÄnderungYAchseExtern => ÄnderungYXAchseExtern.YAchse,
                                         LogikGrafikExtern    => LogikGrafikExtern);
         
      else
         return YAchsePrüfenEinzelform (KoordinatenExtern     => KoordinatenExtern,
                                         ÄnderungYAchseExtern => ÄnderungYXAchseExtern.YAchse,
                                         LogikGrafikExtern    => LogikGrafikExtern);
      end if;
      
   end YAchsePrüfen;
   
   
   
   function YAchsePrüfenEinzelform
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      case
        Karten.KartenformEingestellt.YAchseEinstellung
      is
         when KartenEinstellungenKonstanten.KartenformKeinÜbergangYAchseKonstante =>
            return KartePositionKeinUebergangBerechnungen.PositionBestimmenYAchse (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                   ÄnderungYAchseExtern => ÄnderungYAchseExtern);
         
            ----------------- Kann man das so zusammenfassen oder kommt es da in bestimmten Fällen zu Fehlern?
         when KartenEinstellungenKonstanten.KartenformÜbergangYAchseKonstante | KartenEinstellungenKonstanten.KartenformÜbergangYAchseVerschobenKonstante =>
            return KartePositionGeraderUebergangBerechnungen.PositionBestimmenYAchse (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                      ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                                                                      ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                      LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformRückwärtsVerschobenerÜbergangYAchseKonstante =>
            return KartePositionRueckwaertsUebergangBerechnungen.PositionBestimmenYAchse (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                          ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                                                                          ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                          LogikGrafikExtern    => LogikGrafikExtern);
      end case;
      
   end YAchsePrüfenEinzelform;
   
   
   
   function XAchsePrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungYXAchseExtern : in KartenRecords.YXAchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      if
        Karten.KartenformEingestellt.YAchseEinstellung = KartenEinstellungenKonstanten.KartenformÜbergangYAchseVerschobenKonstante
      then
         XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse)
           := KartePositionVerschobenerUebergangBerechnungen.PositionBestimmenXAchse (KoordinatenExtern => (KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                                                                      ÄnderungExtern    => ÄnderungYXAchseExtern);
         
         return XAchsePrüfenEinzelform (KoordinatenExtern     => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse)),
                                         ÄnderungXAchseExtern => ÄnderungYXAchseExtern.XAchse,
                                         LogikGrafikExtern    => LogikGrafikExtern);
         
      else
         return XAchsePrüfenEinzelform (KoordinatenExtern     => KoordinatenExtern,
                                         ÄnderungXAchseExtern => ÄnderungYXAchseExtern.XAchse,
                                         LogikGrafikExtern    => LogikGrafikExtern);
      end if;
      
   end XAchsePrüfen;
   
   
   
   function XAchsePrüfenEinzelform
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
            
      case
        Karten.KartenformEingestellt.XAchseEinstellung
      is
         when KartenEinstellungenKonstanten.KartenformKeinÜbergangXAchseKonstante =>
            return KartePositionKeinUebergangBerechnungen.PositionBestimmenXAchse (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                   ÄnderungXAchseExtern => ÄnderungXAchseExtern);
            
            ----------------- Kann man das so zusammenfassen oder kommt es da in bestimmten Fällen zu Fehlern?
         when KartenEinstellungenKonstanten.KartenformÜbergangXAchseKonstante | KartenEinstellungenKonstanten.KartenformÜbergangXAchseVerschobenKonstante =>
            return KartePositionGeraderUebergangBerechnungen.PositionBestimmenXAchse (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                      ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                                                                      ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                      LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformRückwärtsVerschobenerÜbergangXAchseKonstante =>
            return KartePositionRueckwaertsUebergangBerechnungen.PositionBestimmenXAchse (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                          ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                                                                          ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                          LogikGrafikExtern    => LogikGrafikExtern);
      end case;
      
   end XAchsePrüfenEinzelform;
   
end KarteKoordinatenPruefen;
