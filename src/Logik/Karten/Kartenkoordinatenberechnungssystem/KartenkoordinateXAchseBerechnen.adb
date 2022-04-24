pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with Karten;

-- Die zweidimensionalen Arrays existieren wegen der Parallelisierung der Kartenfelderbewertung und weil das hier von Logik und Grafik benötigt wird.
-- Die Überhangschleifen in den Berechnungen sind nötig, da zwar eine Einheitenbewegung nicht so groß sein kann, aber der Spieler eventuell soweit rauszoomt.
package body KartenkoordinateXAchseBerechnen is

   function KartenkoordinateXAchseBerechnen
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      WelcheVerschiebungXAchse (LogikGrafikExtern, ArrayPositionExtern) := KartenDatentypen.Karte_X_Kein_Übergang_Enum;
      
      if
        XAchseExtern + ÄnderungXAchseExtern < Karten.WeltkarteArray'First (3)
      then
         return ÜbergangWesten (XAchseExtern         => XAchseExtern,
                                 ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                 ArrayPositionExtern  => ArrayPositionExtern,
                                 LogikGrafikExtern    => LogikGrafikExtern);
        
      elsif
        XAchseExtern + ÄnderungXAchseExtern > Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße
      then
         return ÜbergangOsten (XAchseExtern         => XAchseExtern,
                                ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                ArrayPositionExtern  => ArrayPositionExtern,
                                LogikGrafikExtern    => LogikGrafikExtern);
         
      else
         return XAchseExtern + ÄnderungXAchseExtern;
      end if;
      
   end KartenkoordinateXAchseBerechnen;
   
   
   
   function ÜbergangWesten
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      case
        Karten.Kartenparameter.Kartenform.XAchseWesten
      is
         when KartenDatentypen.Karte_X_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerXAchse;
            
         when KartenDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum =>
            WelcheVerschiebungXAchse (LogikGrafikExtern, ArrayPositionExtern) := Karten.Kartenparameter.Kartenform.XAchseWesten;
      
            return KartenKonstanten.LeerXAchse;
            
         when KartenDatentypen.Karte_X_Übergang_Enum | KartenDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            WelcheVerschiebungXAchse (LogikGrafikExtern, ArrayPositionExtern) := Karten.Kartenparameter.Kartenform.XAchseWesten;
            
            return ÜbergangWestenNormal (XAchseExtern         => XAchseExtern,
                                          ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                          ArrayPositionExtern  => ArrayPositionExtern,
                                          LogikGrafikExtern    => LogikGrafikExtern);
      end case;
      
   end ÜbergangWesten;
   
   
   
   function ÜbergangWestenNormal
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) := Integer (XAchseExtern + ÄnderungXAchseExtern + Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße);
         
      XAchseKleinerSchleife:
      while ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) < Positive (Karten.WeltkarteArray'First (3)) loop
            
         ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) + Positive (Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße);

      end loop XAchseKleinerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern));
      
   end ÜbergangWestenNormal;
   
   
   
   function ÜbergangOsten
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      case
        Karten.Kartenparameter.Kartenform.XAchseOsten
      is
         when KartenDatentypen.Karte_X_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerXAchse;
            
         when KartenDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum =>
            WelcheVerschiebungXAchse (LogikGrafikExtern, ArrayPositionExtern) := Karten.Kartenparameter.Kartenform.XAchseOsten;
      
            return KartenKonstanten.LeerXAchse;
            
         when KartenDatentypen.Karte_X_Übergang_Enum | KartenDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            WelcheVerschiebungXAchse (LogikGrafikExtern, ArrayPositionExtern) := Karten.Kartenparameter.Kartenform.XAchseOsten;
            
            return ÜbergangOstenNormal (XAchseExtern         => XAchseExtern,
                                         ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                         ArrayPositionExtern  => ArrayPositionExtern,
                                         LogikGrafikExtern    => LogikGrafikExtern);
      end case;
      
   end ÜbergangOsten;
   
   
   
   function ÜbergangOstenNormal
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) := Positive (XAchseExtern + ÄnderungXAchseExtern - Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße);
         
      XAchseGrößerSchleife:
      while ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) > Positive (Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße) loop
            
         ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) - Positive (Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße);
            
      end loop XAchseGrößerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern));
      
   end ÜbergangOstenNormal;
   
      
   
   function XAchseVerschieben
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      if
        XAchseExtern + KartenfeldPositiv (HalberWert * Float (Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße)) > Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße
      then
         return XAchseExtern - KartenfeldPositiv (HalberWert * Float (Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße));

      else
         return XAchseExtern + KartenfeldPositiv (HalberWert * Float (Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße));
      end if;
      
   end XAchseVerschieben;

end KartenkoordinateXAchseBerechnen;
