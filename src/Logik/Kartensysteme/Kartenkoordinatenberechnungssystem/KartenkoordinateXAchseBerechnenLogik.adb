with KartenKonstanten;
with KartenartDatentypen;

package body KartenkoordinateXAchseBerechnenLogik is

   function KartenkoordinateXAchseBerechnen
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      if
        XAchseExtern + ÄnderungXAchseExtern < Weltkarte.KarteArray'First (3)
      then
         return ÜbergangWesten (XAchseExtern         => XAchseExtern,
                                 ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                 ArrayPositionExtern  => ArrayPositionExtern,
                                 LogikGrafikExtern    => LogikGrafikExtern);
        
      elsif
        XAchseExtern + ÄnderungXAchseExtern > Weltkarte.Karteneinstellungen.Kartengröße.XAchse
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
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      case
        Weltkarte.Karteneinstellungen.Kartenform.XAchseWesten
      is
         when KartenartDatentypen.Karte_X_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerXAchse;
            
         when KartenartDatentypen.Karte_X_Übergang_Enum | KartenartDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.VerschiebungXAchse (LogikGrafikExtern, ArrayPositionExtern) := Weltkarte.Karteneinstellungen.Kartenform.XAchseWesten;
            
            return ÜbergangWestenNormal (XAchseExtern         => XAchseExtern,
                                          ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                          ArrayPositionExtern  => ArrayPositionExtern,
                                          LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.VerschiebungXAchse (LogikGrafikExtern, ArrayPositionExtern) := Weltkarte.Karteneinstellungen.Kartenform.XAchseWesten;
      
            return ÜbergangWestenRückwärts (XAchseExtern         => XAchseExtern,
                                               ÄnderungXAchseExtern => ÄnderungXAchseExtern);
      end case;
      
   end ÜbergangWesten;
   
   
   
   function ÜbergangWestenNormal
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) := Integer (XAchseExtern + ÄnderungXAchseExtern + Weltkarte.Karteneinstellungen.Kartengröße.XAchse);
         
      XAchseKleinerSchleife:
      while ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) < Positive (Weltkarte.KarteArray'First (3)) loop
            
         ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) + Positive (Weltkarte.Karteneinstellungen.Kartengröße.XAchse);

      end loop XAchseKleinerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern));
      
   end ÜbergangWestenNormal;
   
   
   
   function ÜbergangWestenRückwärts
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      if
        XAchseExtern + ÄnderungXAchseExtern < Weltkarte.KarteArray'First (3) - 1
      then
         return KartenKonstanten.LeerXAchse;
         
      else
         return Weltkarte.KarteArray'First (3) + 1;
      end if;
            
   end ÜbergangWestenRückwärts;
   
   
   
   function ÜbergangOsten
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      case
        Weltkarte.Karteneinstellungen.Kartenform.XAchseOsten
      is
         when KartenartDatentypen.Karte_X_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerXAchse;
            
         when KartenartDatentypen.Karte_X_Übergang_Enum | KartenartDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.VerschiebungXAchse (LogikGrafikExtern, ArrayPositionExtern) := Weltkarte.Karteneinstellungen.Kartenform.XAchseOsten;
            
            return ÜbergangOstenNormal (XAchseExtern         => XAchseExtern,
                                         ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                         ArrayPositionExtern  => ArrayPositionExtern,
                                         LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.VerschiebungXAchse (LogikGrafikExtern, ArrayPositionExtern) := Weltkarte.Karteneinstellungen.Kartenform.XAchseOsten;
      
            return ÜbergangOstenRückwärts (XAchseExtern         => XAchseExtern,
                                              ÄnderungXAchseExtern => ÄnderungXAchseExtern);
      end case;
      
   end ÜbergangOsten;
   
   
   
   function ÜbergangOstenNormal
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) := Positive (XAchseExtern + ÄnderungXAchseExtern - Weltkarte.Karteneinstellungen.Kartengröße.XAchse);
         
      XAchseGrößerSchleife:
      while ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) > Positive (Weltkarte.Karteneinstellungen.Kartengröße.XAchse) loop
            
         ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) - Positive (Weltkarte.Karteneinstellungen.Kartengröße.XAchse);
            
      end loop XAchseGrößerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern));
      
   end ÜbergangOstenNormal;
   
   
   
   function ÜbergangOstenRückwärts
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      if
        XAchseExtern + ÄnderungXAchseExtern > Weltkarte.Karteneinstellungen.Kartengröße.XAchse + 1
      then
         return KartenKonstanten.LeerXAchse;
         
      else
         return Weltkarte.Karteneinstellungen.Kartengröße.XAchse - 1;
      end if;
      
   end ÜbergangOstenRückwärts;
   
      
   
   function XAchseVerschieben
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      if
        XAchseExtern + KartenfeldPositiv (KartenkoordinatenWerteLogik.VerschiebungswertXAchse * Float (Weltkarte.Karteneinstellungen.Kartengröße.XAchse)) > Weltkarte.Karteneinstellungen.Kartengröße.XAchse
      then
         return XAchseExtern - KartenfeldPositiv (KartenkoordinatenWerteLogik.VerschiebungswertXAchse * Float (Weltkarte.Karteneinstellungen.Kartengröße.XAchse));

      else
         return XAchseExtern + KartenfeldPositiv (KartenkoordinatenWerteLogik.VerschiebungswertXAchse * Float (Weltkarte.Karteneinstellungen.Kartengröße.XAchse));
      end if;
      
   end XAchseVerschieben;

end KartenkoordinateXAchseBerechnenLogik;
