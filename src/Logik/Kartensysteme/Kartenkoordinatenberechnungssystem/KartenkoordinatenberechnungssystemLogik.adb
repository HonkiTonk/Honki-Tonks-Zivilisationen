with KartenRecordKonstanten;
with KartenartDatentypen;

with KartenkoordinateEAchseBerechnenLogik;
with KartenkoordinateYAchseBerechnenLogik;
with KartenkoordinateXAchseBerechnenLogik;
with KartenkoordinatenWerteLogik;

-- Mal Prüfungen für einzelne Achsen einbauen? äöü
-- Geht das überhaupt bei allen Achsen? äöü
-- Sollte bei der EAchse problemlos gehen, aber bei den anderen wird es eventuell kompiliziert. äöü

-- Sollte ich das hier und vielleicht generell alles mal in Logik und Grafik aufteilen? Oder Protected? äöü
package body KartenkoordinatenberechnungssystemLogik is

   -- Wenn man das in einen Grafik- und einen Logikteil aufteilt, könnte man dann Zufallsübergänge berechnen? äöü
   -- Nein, da auch der Kartengenerator Teil der Logik ist, wenn dann bräuchte man drei Teile, eventuell auch mehr. äöü
   -- Wobei, man könnte auch beim Kartengenerator dann einfach False statt True übergeben. Die Grafik sollte zu diesem Zeitpunkt ja nicht auf die Berechnungen zugreifen. äöü
   function Kartenkoordinatenberechnungssystem
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      if
        KoordinatenExtern = KartenRecordKonstanten.LeerKoordinate
      then
         return KartenRecordKonstanten.LeerKoordinate;
         
      else
         null;
      end if;
      
      case
        ÄnderungExtern.EAchse
      is
         when KartenKonstanten.LeerEAchseÄnderung =>
            NeueKoordinate (LogikGrafikExtern).EAchse := KoordinatenExtern.EAchse;
            
         when others =>
            NeueKoordinate (LogikGrafikExtern).EAchse := KartenkoordinateEAchseBerechnenLogik.KartenkoordinateEAchseBerechnen (EAchseExtern         => KoordinatenExtern.EAchse,
                                                                                                                               ÄnderungEAchseExtern => ÄnderungExtern.EAchse,
                                                                                                                               LogikGrafikExtern    => LogikGrafikExtern);
            
            if
              NeueKoordinate (LogikGrafikExtern).EAchse = KartenKonstanten.LeerEAchse
            then
               return KartenRecordKonstanten.LeerKoordinate;
            else
               null;
            end if;
      end case;
      
      KartenkoordinatenWerteLogik.YAchseVerschiebungSchreiben (LogikGrafikExtern => LogikGrafikExtern,
                                                               ÜbergangExtern    => KartenartDatentypen.Karte_Y_Kein_Übergang_Enum);
      
      case
        ÄnderungExtern.YAchse
      is
         when KartenKonstanten.LeerYAchseÄnderung =>
            NeueKoordinate (LogikGrafikExtern).YAchse := KoordinatenExtern.YAchse;
            
         when others =>
            NeueKoordinate (LogikGrafikExtern).YAchse := KartenkoordinateYAchseBerechnenLogik.KartenkoordinateYAchseBerechnen (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                                                               ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                                               LogikGrafikExtern    => LogikGrafikExtern);
      
            if
              NeueKoordinate (LogikGrafikExtern).YAchse = KartenKonstanten.LeerYAchse
            then
               return KartenRecordKonstanten.LeerKoordinate;
            
            else
               null;
            end if;
      end case;
      
      KartenkoordinatenWerteLogik.XAchseVerschiebungSchreiben (LogikGrafikExtern => LogikGrafikExtern,
                                                               ÜbergangExtern    => KartenartDatentypen.Karte_X_Kein_Übergang_Enum);
            
      case
        ÄnderungExtern.XAchse
      is
         when KartenKonstanten.LeerXAchseÄnderung =>
            NeueKoordinate (LogikGrafikExtern).XAchse := KoordinatenExtern.XAchse;
            
         when others =>
            NeueKoordinate (LogikGrafikExtern).XAchse := KartenkoordinateXAchseBerechnenLogik.KartenkoordinateXAchseBerechnen (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                                                               ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                                               LogikGrafikExtern    => LogikGrafikExtern);
            
            if
              NeueKoordinate (LogikGrafikExtern).XAchse = KartenKonstanten.LeerXAchse
            then
               return KartenRecordKonstanten.LeerKoordinate;
                  
            else
               null;
            end if;
      end case;
      
      case
        KartenkoordinatenWerteLogik.YAchseVerschiebungLesen (LogikGrafikExtern => LogikGrafikExtern)
      is
         when KartenartDatentypen.Karte_Y_Kein_Übergang_Enum | KartenartDatentypen.Karte_Y_Übergang_Enum =>
            null;
            
         when KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum | KartenartDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            NeueKoordinate (LogikGrafikExtern).XAchse := KartenkoordinateXAchseBerechnenLogik.XAchseVerschieben (XAchseExtern => NeueKoordinate (LogikGrafikExtern).XAchse);
      end case;
      
      case
        KartenkoordinatenWerteLogik.XAchseVerschiebungLesen (LogikGrafikExtern => LogikGrafikExtern)
      is
         when KartenartDatentypen.Karte_X_Kein_Übergang_Enum | KartenartDatentypen.Karte_X_Übergang_Enum =>
            null;
            
         when KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum | KartenartDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            NeueKoordinate (LogikGrafikExtern).YAchse := KartenkoordinateYAchseBerechnenLogik.YAchseVerschieben (YAchseExtern => NeueKoordinate (LogikGrafikExtern).YAchse);
      end case;
      
      return NeueKoordinate (LogikGrafikExtern);
      
   end Kartenkoordinatenberechnungssystem;

end KartenkoordinatenberechnungssystemLogik;
