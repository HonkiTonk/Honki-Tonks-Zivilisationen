pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with KartenRecordKonstanten;

with KartenkoordinateEAchseBerechnen;
with KartenkoordinateYAchseBerechnen;
with KartenkoordinateXAchseBerechnen;

-- Die zweidimensionalen Arrays existieren wegen der Parallelisierung der Kartenfelderbewertung und weil das hier von Logik und Grafik benötigt wird.
-- Die Überhangschleifen in den Berechnungen sind nötig, da zwar eine Einheitenbewegung nicht so groß sein kann, aber der Spieler eventuell soweit rauszoomt.
package body Kartenkoordinatenberechnungssystem is

   -- Mal überall die KoordinatenRecords anpassen. äöü
   function Kartenkoordinatenberechnungssystem
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      -- Wenn man das in einen Grafik- und einen Logikteil aufteilt, könnte man dann Zufallsübergänge berechnen? äöü
      -- Nein, da auch der Kartengenerator Teil der Logik ist, wenn dann bräuchte man drei Teile, eventuell auch mehr. äöü
      -- Wobei, man könnte auch beim Kartengenerator dann einfach False statt True übergeben. Die Grafik sollte zu diesem Zeitpunkt ja nicht auf die Berechnungen zugreifen. äöü
      
      if
        ÄnderungExtern.EAchse = KartenKonstanten.LeerEAchseÄnderung
        and
          ÄnderungExtern.YAchse = KartenKonstanten.LeerYAchseÄnderung
          and
            ÄnderungExtern.XAchse = KartenKonstanten.LeerXAchseÄnderung
      then
         return KoordinatenExtern;
         
      else
         null;
      end if;
      
      case
        ÄnderungExtern.EAchse
      is
         when KartenKonstanten.LeerEAchseÄnderung =>
            -- Hier mal herausfinden warum das gerne mal falsch ist. äöü
            -- Put_Line (KoordinatenExtern.EAchse'Wide_Wide_Image);
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).EAchse := KoordinatenExtern.EAchse;
            
         when others =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).EAchse := KartenkoordinateEAchseBerechnen.KartenkoordinateEAchseBerechnen (EAchseExtern         => KoordinatenExtern.EAchse,
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
      
      NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := KartenkoordinateYAchseBerechnen.KartenkoordinateYAchseBerechnen (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                                                                              ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                                                              ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                                              LogikGrafikExtern    => LogikGrafikExtern);
      
      case
        NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse
      is
         when KartenKonstanten.LeerYAchse =>
            return KartenRecordKonstanten.LeerKoordinate;
            
         when others =>
            null;
      end case;
      
      NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse := KartenkoordinateXAchseBerechnen.KartenkoordinateXAchseBerechnen (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                                                                              ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                                                              ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                                              LogikGrafikExtern    => LogikGrafikExtern);
      
      case
        NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return KartenRecordKonstanten.LeerKoordinate;
            
         when others =>
            null;
      end case;
      
      case
        KartenkoordinateYAchseBerechnen.WelcheVerschiebungYAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.Karte_Y_Kein_Übergang_Enum | KartenDatentypen.Karte_Y_Übergang_Enum =>
            null;
            
         when KartenDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum | KartenDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse := KartenkoordinateXAchseBerechnen.XAchseVerschieben (XAchseExtern => NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse);
      end case;
      
      case
        KartenkoordinateXAchseBerechnen.WelcheVerschiebungXAchse (LogikGrafikExtern, KoordinatenExtern.EAchse)
      is
         when KartenDatentypen.Karte_X_Kein_Übergang_Enum | KartenDatentypen.Karte_X_Übergang_Enum =>
            null;
            
         when KartenDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum | KartenDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse := KartenkoordinateYAchseBerechnen.YAchseVerschieben (YAchseExtern => NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse);
      end case;
      
      return NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse);
      
   end Kartenkoordinatenberechnungssystem;

end Kartenkoordinatenberechnungssystem;
