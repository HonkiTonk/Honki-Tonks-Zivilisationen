pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;

-- Die zweidimensionalen Arrays existieren wegen der Parallelisierung der Kartenfelderbewertung und weil das hier von Logik und Grafik benötigt wird.
-- Die Überhangschleifen in den Berechnungen sind nötig, da zwar eine Einheitenbewegung nicht so groß sein kann, aber der Spieler eventuell soweit rauszoomt.
-- Die Überhangsschleifen werden auch für den Kartengenerator benötigt.
package body KartenkoordinateYAchseBerechnen is

   function KartenkoordinateYAchseBerechnen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      WelcheVerschiebungYAchse (LogikGrafikExtern, ArrayPositionExtern) := KartenDatentypen.Karte_Y_Kein_Übergang_Enum;
      
      if
        YAchseExtern + ÄnderungYAchseExtern < Karten.WeltkarteArray'First (2)
      then
         return ÜbergangNorden (YAchseExtern         => YAchseExtern,
                                 ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                 ArrayPositionExtern  => ArrayPositionExtern,
                                 LogikGrafikExtern    => LogikGrafikExtern);
        
      elsif
        YAchseExtern + ÄnderungYAchseExtern > Karten.Karteneinstellungen.Kartengröße.YAchse
      then
         return ÜbergangSüden (YAchseExtern         => YAchseExtern,
                                 ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                 ArrayPositionExtern  => ArrayPositionExtern,
                                 LogikGrafikExtern    => LogikGrafikExtern);
         
      else
         return YAchseExtern + ÄnderungYAchseExtern;
      end if;
      
   end KartenkoordinateYAchseBerechnen;
   
   
   
   function ÜbergangNorden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      case
        Karten.Karteneinstellungen.Kartenform.YAchseNorden
      is
         when KartenDatentypen.Karte_Y_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerYAchse;
            
         when KartenDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum =>
            WelcheVerschiebungYAchse (LogikGrafikExtern, ArrayPositionExtern) := Karten.Karteneinstellungen.Kartenform.YAchseNorden;
            
            return ÜbergangNordenRückwärts (YAchseExtern         => YAchseExtern,
                                               ÄnderungYAchseExtern => ÄnderungYAchseExtern);
                        
         when KartenDatentypen.Karte_Y_Übergang_Enum | KartenDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            WelcheVerschiebungYAchse (LogikGrafikExtern, ArrayPositionExtern) := Karten.Karteneinstellungen.Kartenform.YAchseNorden;
            
            return ÜbergangNordenNormal (YAchseExtern         => YAchseExtern,
                                          ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                          ArrayPositionExtern  => ArrayPositionExtern,
                                          LogikGrafikExtern    => LogikGrafikExtern);
      end case;
      
   end ÜbergangNorden;
   
   
   
   function ÜbergangNordenNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := Integer (YAchseExtern + ÄnderungYAchseExtern + Karten.Karteneinstellungen.Kartengröße.YAchse);
         
      YAchseKleinerSchleife:
      while ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) < Positive (Karten.WeltkarteArray'First (2)) loop
            
         ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) + Positive (Karten.Karteneinstellungen.Kartengröße.YAchse);

      end loop YAchseKleinerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern));
      
   end ÜbergangNordenNormal;
   
   
   
   ------------------------- Die Überhangsschleife wird auch für den Kartengenerator benötigt, also muss sie hier auf jeden Fall noch eingebaut werden, oder?
   function ÜbergangNordenRückwärts
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      return YAchseExtern - (ÄnderungYAchseExtern + 1);
      
   end ÜbergangNordenRückwärts;
   
   
   
   function ÜbergangSüden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      case
        Karten.Karteneinstellungen.Kartenform.YAchseSüden
      is
         when KartenDatentypen.Karte_Y_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerYAchse;
            
         when KartenDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum =>
            WelcheVerschiebungYAchse (LogikGrafikExtern, ArrayPositionExtern) := Karten.Karteneinstellungen.Kartenform.YAchseSüden;
            
            return ÜbergangNordenRückwärts (YAchseExtern         => YAchseExtern,
                                               ÄnderungYAchseExtern => ÄnderungYAchseExtern);
            
         when KartenDatentypen.Karte_Y_Übergang_Enum | KartenDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            WelcheVerschiebungYAchse (LogikGrafikExtern, ArrayPositionExtern) := Karten.Karteneinstellungen.Kartenform.YAchseSüden;
            
            return ÜbergangSüdenNormal (YAchseExtern         => YAchseExtern,
                                          ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                          ArrayPositionExtern  => ArrayPositionExtern,
                                          LogikGrafikExtern    => LogikGrafikExtern);
      end case;
      
   end ÜbergangSüden;
   
   
   
   function ÜbergangSüdenNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := Positive (YAchseExtern + ÄnderungYAchseExtern - Karten.Karteneinstellungen.Kartengröße.YAchse);
         
      YAchseGrößerSchleife:
      while ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) > Positive (Karten.Karteneinstellungen.Kartengröße.YAchse) loop
            
         ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) - Positive (Karten.Karteneinstellungen.Kartengröße.YAchse);
            
      end loop YAchseGrößerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern));
      
   end ÜbergangSüdenNormal;
   
   
   
   ------------------------- Die Überhangsschleife wird auch für den Kartengenerator benötigt, also muss sie hier auf jeden Fall noch eingebaut werden, oder?
   function ÜbergangSüdenRückwärts
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      return YAchseExtern - (ÄnderungYAchseExtern - 1);
      
   end ÜbergangSüdenRückwärts;
   
   
   
   function YAchseVerschieben
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      if
        YAchseExtern + KartenfeldPositiv (HalberWert * Float (Karten.Karteneinstellungen.Kartengröße.YAchse)) > Karten.Karteneinstellungen.Kartengröße.YAchse
      then
         return YAchseExtern - KartenfeldPositiv (HalberWert * Float (Karten.Karteneinstellungen.Kartengröße.YAchse));

      else
         return YAchseExtern + KartenfeldPositiv (HalberWert * Float (Karten.Karteneinstellungen.Kartengröße.YAchse));
      end if;
      
   end YAchseVerschieben;

end KartenkoordinateYAchseBerechnen;
