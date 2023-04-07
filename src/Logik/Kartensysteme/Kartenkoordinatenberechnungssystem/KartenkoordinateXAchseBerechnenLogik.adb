with KartenKonstanten;

package body KartenkoordinateXAchseBerechnenLogik is

   function KartenkoordinateXAchseBerechnen
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      if
        XAchseExtern + ÄnderungXAchseExtern < KartenKonstanten.AnfangXAchse
      then
         return ÜbergangWesten (XAchseExtern         => XAchseExtern,
                                 ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                 LogikGrafikExtern    => LogikGrafikExtern);
        
      elsif
        XAchseExtern + ÄnderungXAchseExtern > LeseWeltkarteneinstellungen.XAchse
      then
         return ÜbergangOsten (XAchseExtern         => XAchseExtern,
                                ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                LogikGrafikExtern    => LogikGrafikExtern);
         
      else
         return XAchseExtern + ÄnderungXAchseExtern;
      end if;
      
   end KartenkoordinateXAchseBerechnen;
   
   
   
   function ÜbergangWesten
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      Kartenart (LogikGrafikExtern) := LeseWeltkarteneinstellungen.XAchseWesten;
      
      case
        Kartenart (LogikGrafikExtern)
      is
         when KartenartDatentypen.Karte_X_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerXAchse;
            
         when KartenartDatentypen.Karte_X_Übergang_Enum | KartenartDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.XAchseVerschiebungSchreiben (LogikGrafikExtern   => LogikGrafikExtern,
                                                                     ÜbergangExtern      => Kartenart (LogikGrafikExtern));
            
            return ÜbergangWestenNormal (XAchseExtern         => XAchseExtern,
                                          ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                          LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.XAchseVerschiebungSchreiben (LogikGrafikExtern   => LogikGrafikExtern,
                                                                     ÜbergangExtern      => Kartenart (LogikGrafikExtern));
      
            return ÜbergangWestenRückwärts (XAchseExtern         => XAchseExtern,
                                               ÄnderungXAchseExtern => ÄnderungXAchseExtern);
      end case;
      
   end ÜbergangWesten;
   
   
   
   function ÜbergangWestenNormal
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangXAchse (LogikGrafikExtern) := Integer (XAchseExtern + ÄnderungXAchseExtern + LeseWeltkarteneinstellungen.XAchse);
         
      XAchseKleinerSchleife:
      while ÜberhangXAchse (LogikGrafikExtern) < Positive (KartenKonstanten.AnfangXAchse) loop
            
         ÜberhangXAchse (LogikGrafikExtern) := ÜberhangXAchse (LogikGrafikExtern) + Positive (LeseWeltkarteneinstellungen.XAchse);

      end loop XAchseKleinerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangXAchse (LogikGrafikExtern));
      
   end ÜbergangWestenNormal;
   
   
   
   function ÜbergangWestenRückwärts
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      if
        XAchseExtern + ÄnderungXAchseExtern < KartenKonstanten.AnfangXAchse - 1
      then
         return KartenKonstanten.LeerXAchse;
         
      else
         return KartenKonstanten.AnfangXAchse + 1;
      end if;
            
   end ÜbergangWestenRückwärts;
   
   
   
   function ÜbergangOsten
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      Kartenart (LogikGrafikExtern) := LeseWeltkarteneinstellungen.XAchseOsten;
      
      case
        Kartenart (LogikGrafikExtern)
      is
         when KartenartDatentypen.Karte_X_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerXAchse;
            
         when KartenartDatentypen.Karte_X_Übergang_Enum | KartenartDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.XAchseVerschiebungSchreiben (LogikGrafikExtern => LogikGrafikExtern,
                                                                     ÜbergangExtern    => Kartenart (LogikGrafikExtern));
            
            return ÜbergangOstenNormal (XAchseExtern         => XAchseExtern,
                                         ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                         LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.XAchseVerschiebungSchreiben (LogikGrafikExtern => LogikGrafikExtern,
                                                                     ÜbergangExtern    => Kartenart (LogikGrafikExtern));
      
            return ÜbergangOstenRückwärts (XAchseExtern         => XAchseExtern,
                                              ÄnderungXAchseExtern => ÄnderungXAchseExtern);
      end case;
      
   end ÜbergangOsten;
   
   
   
   function ÜbergangOstenNormal
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangXAchse (LogikGrafikExtern) := Positive (XAchseExtern + ÄnderungXAchseExtern - LeseWeltkarteneinstellungen.XAchse);
         
      XAchseGrößerSchleife:
      while ÜberhangXAchse (LogikGrafikExtern) > Positive (LeseWeltkarteneinstellungen.XAchse) loop
            
         ÜberhangXAchse (LogikGrafikExtern) := ÜberhangXAchse (LogikGrafikExtern) - Positive (LeseWeltkarteneinstellungen.XAchse);
            
      end loop XAchseGrößerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangXAchse (LogikGrafikExtern));
      
   end ÜbergangOstenNormal;
   
   
   
   function ÜbergangOstenRückwärts
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      if
        XAchseExtern + ÄnderungXAchseExtern > LeseWeltkarteneinstellungen.XAchse + 1
      then
         return KartenKonstanten.LeerXAchse;
         
      else
         return LeseWeltkarteneinstellungen.XAchse - 1;
      end if;
      
   end ÜbergangOstenRückwärts;
   
      
   
   function XAchseVerschieben
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      if
        XAchseExtern + KartenDatentypen.KartenfeldPositiv (KartenkoordinatenWerteLogik.VerschiebungswertXAchse * Float (LeseWeltkarteneinstellungen.XAchse)) > LeseWeltkarteneinstellungen.XAchse
      then
         return XAchseExtern - KartenDatentypen.KartenfeldPositiv (KartenkoordinatenWerteLogik.VerschiebungswertXAchse * Float (LeseWeltkarteneinstellungen.XAchse));

      else
         return XAchseExtern + KartenDatentypen.KartenfeldPositiv (KartenkoordinatenWerteLogik.VerschiebungswertXAchse * Float (LeseWeltkarteneinstellungen.XAchse));
      end if;
      
   end XAchseVerschieben;

end KartenkoordinateXAchseBerechnenLogik;
