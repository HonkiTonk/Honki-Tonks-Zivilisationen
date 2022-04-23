pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecordKonstanten;

with KartePositionKeinUebergangBerechnungen;
with KartePositionGeraderUebergangBerechnungen;
with KartePositionVerschobenerUebergangBerechnungen;
with KartePositionRueckwaertsUebergangBerechnungen;

-- Die Arrays sind da wegen der Parallelisierung der Kartenfelderbewertung und weil das hier von Logik und Grafik benötigt wird.
package body KarteKoordinatenPruefen is
   
   ---------------------- Die neue Version hier gleich mal überarbeiten. Dabei auch die Post => Anforderungen beachten.
   function KarteKoordinatenPrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      -------------------- Ist folgende Prüfung sinnvoll/bringt die bessere Performance?
      if
        ÄnderungExtern.EAchse = 0
        and
          ÄnderungExtern.YAchse = 0
          and
            ÄnderungExtern.XAchse = 0
      then
         return KoordinatenExtern;
         
      else
         null;
      end if;
      
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
        Karten.Kartenparameter.Kartenform.YZuerstBerechnenXZuerstBerechnen
      is
         when True =>
            if
              ÄnderungExtern.YAchse /= 0
            then
               NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := YAchsePrüfen (KoordinatenExtern     => KoordinatenExtern,
                                                                                                     ÄnderungYXAchseExtern => (ÄnderungExtern.YAchse, ÄnderungExtern.XAchse),
                                                                                                     LogikGrafikExtern     => LogikGrafikExtern);
               
               case
                 NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse
               is
                  when KartenKonstanten.LeerYAchse =>
                     return KartenRecordKonstanten.LeerKartenKoordinaten;
                     
                  when others =>
                     null;
               end case;
               
            else
               NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := KoordinatenExtern.YAchse;
            end if;
               
            if
              ÄnderungExtern.XAchse /= 0
            then
               NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse := XAchsePrüfen (KoordinatenExtern     => KoordinatenExtern,
                                                                                                     ÄnderungYXAchseExtern => (ÄnderungExtern.YAchse, ÄnderungExtern.XAchse),
                                                                                                     LogikGrafikExtern     => LogikGrafikExtern);
               
               case
                 NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse
               is
                  when KartenKonstanten.LeerXAchse =>
                     return KartenRecordKonstanten.LeerKartenKoordinaten;
                     
                  when others =>
                     null;
               end case;
            
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
               
               case
                 NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse
               is
                  when KartenKonstanten.LeerXAchse =>
                     return KartenRecordKonstanten.LeerKartenKoordinaten;
                     
                  when others =>
                     null;
               end case;
               
            else
               NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse := KoordinatenExtern.XAchse;
            end if;
               
            if
              ÄnderungExtern.YAchse /= 0
            then
               NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := YAchsePrüfen (KoordinatenExtern     => KoordinatenExtern,
                                                                                                     ÄnderungYXAchseExtern => (ÄnderungExtern.YAchse, ÄnderungExtern.XAchse),
                                                                                                     LogikGrafikExtern     => LogikGrafikExtern);
               
               case
                 NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse
               is
                  when KartenKonstanten.LeerYAchse =>
                     return KartenRecordKonstanten.LeerKartenKoordinaten;
                     
                  when others =>
                     null;
               end case;
            
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
        Karten.Kartenparameter.Kartenform.EAchseOben
      is
         when KartenDatentypen.Karte_E_Achse_Kein_Übergang_Enum =>
            return KartePositionKeinUebergangBerechnungen.PositionBestimmenEAchse (EAchseExtern         => EAchseExtern,
                                                                                   ÄnderungEAchseExtern => ÄnderungEAchseExtern);
            
         when KartenDatentypen.Karte_E_Achse_Übergang_Enum =>
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
        Karten.Kartenparameter.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Achse_Verschobener_Übergang_Enum
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
        Karten.Kartenparameter.Kartenform.YAchseNorden
      is
         when KartenDatentypen.Karte_Y_Achse_Kein_Übergang_Enum =>
            return KartePositionKeinUebergangBerechnungen.PositionBestimmenYAchse (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                   ÄnderungYAchseExtern => ÄnderungYAchseExtern);
         
            ----------------- Kann man das so zusammenfassen oder kommt es da in bestimmten Fällen zu Fehlern?
         when KartenDatentypen.Karte_Y_Achse_Übergang_Enum | KartenDatentypen.Karte_Y_Achse_Verschobener_Übergang_Enum =>
            return KartePositionGeraderUebergangBerechnungen.PositionBestimmenYAchse (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                      ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                                                                      ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                      LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenDatentypen.Karte_Y_Achse_Rückwärts_Verschobener_Übergang_Enum =>
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
        Karten.Kartenparameter.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Achse_Verschobener_Übergang_Enum
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
        Karten.Kartenparameter.Kartenform.XAchseWesten
      is
         when KartenDatentypen.Karte_X_Achse_Kein_Übergang_Enum =>
            return KartePositionKeinUebergangBerechnungen.PositionBestimmenXAchse (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                   ÄnderungXAchseExtern => ÄnderungXAchseExtern);
            
            ----------------- Kann man das so zusammenfassen oder kommt es da in bestimmten Fällen zu Fehlern?
         when KartenDatentypen.Karte_X_Achse_Übergang_Enum | KartenDatentypen.Karte_X_Achse_Verschobener_Übergang_Enum =>
            return KartePositionGeraderUebergangBerechnungen.PositionBestimmenXAchse (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                      ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                                                                      ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                      LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenDatentypen.Karte_X_Achse_Rückwärts_Verschobener_Übergang_Enum =>
            return KartePositionRueckwaertsUebergangBerechnungen.PositionBestimmenXAchse (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                          ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                                                                          ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                          LogikGrafikExtern    => LogikGrafikExtern);
      end case;
      
   end XAchsePrüfenEinzelform;
   
end KarteKoordinatenPruefen;
