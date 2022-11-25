with KartenRecordKonstanten;
with KartenartDatentypen;

with KartenkoordinateEAchseBerechnenLogik;
with KartenkoordinateYAchseBerechnenLogik;
with KartenkoordinateXAchseBerechnenLogik;
with KartenkoordinatenWerteLogik;

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
        and
          LogikGrafikExtern = False
      then
         return KartenRecordKonstanten.LeerKoordinate;
         
      else
         null;
      end if;
      
      case
        ÄnderungExtern.EAchse
      is
         when KartenKonstanten.LeerEAchseÄnderung =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).EAchse := KoordinatenExtern.EAchse;
            
         when others =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).EAchse := KartenkoordinateEAchseBerechnenLogik.KartenkoordinateEAchseBerechnen (EAchseExtern         => KoordinatenExtern.EAchse,
                                                                                                                                                         ÄnderungEAchseExtern => ÄnderungExtern.EAchse,
                                                                                                                                                         LogikGrafikExtern    => LogikGrafikExtern);
            
            if
              NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).EAchse = KartenKonstanten.LeerEAchse
            then
               return KartenRecordKonstanten.LeerKoordinate;
            else
               null;
            end if;
      end case;
      
      KartenkoordinatenWerteLogik.VerschiebungYAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartenartDatentypen.Karte_Y_Kein_Übergang_Enum;
      
      case
        ÄnderungExtern.YAchse
      is
         when KartenKonstanten.LeerYAchseÄnderung =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := KoordinatenExtern.YAchse;
            
         when others =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := KartenkoordinateYAchseBerechnenLogik.KartenkoordinateYAchseBerechnen (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                                                                                         ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                                                                         ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                                                         LogikGrafikExtern    => LogikGrafikExtern);
      
            if
              NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse = KartenKonstanten.LeerYAchse
            then
               return KartenRecordKonstanten.LeerKoordinate;
            
            else
               null;
            end if;
      end case;
      
      KartenkoordinatenWerteLogik.VerschiebungXAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartenartDatentypen.Karte_X_Kein_Übergang_Enum;
            
      case
        ÄnderungExtern.XAchse
      is
         when KartenKonstanten.LeerXAchseÄnderung =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse := KoordinatenExtern.XAchse;
            
         when others =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse := KartenkoordinateXAchseBerechnenLogik.KartenkoordinateXAchseBerechnen (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                                                                                         ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                                                                         ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                                                         LogikGrafikExtern    => LogikGrafikExtern);
            
            if
              NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse = KartenKonstanten.LeerXAchse
            then
               return KartenRecordKonstanten.LeerKoordinate;
                  
            else
               null;
            end if;
      end case;
      
      case
        KartenkoordinatenWerteLogik.VerschiebungYAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenartDatentypen.Karte_Y_Kein_Übergang_Enum | KartenartDatentypen.Karte_Y_Übergang_Enum =>
            null;
            
         when KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum | KartenartDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse
              := KartenkoordinateXAchseBerechnenLogik.XAchseVerschieben (XAchseExtern => NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse);
      end case;
      
      case
        KartenkoordinatenWerteLogik.VerschiebungXAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenartDatentypen.Karte_X_Kein_Übergang_Enum | KartenartDatentypen.Karte_X_Übergang_Enum =>
            null;
            
         when KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum | KartenartDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse
              := KartenkoordinateYAchseBerechnenLogik.YAchseVerschieben (YAchseExtern => NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse);
      end case;
      
      return NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse);
      
   end Kartenkoordinatenberechnungssystem;

end KartenkoordinatenberechnungssystemLogik;
