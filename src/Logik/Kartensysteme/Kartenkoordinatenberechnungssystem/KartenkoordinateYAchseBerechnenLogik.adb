with KartenKonstanten;

package body KartenkoordinateYAchseBerechnenLogik is

   function KartenkoordinateYAchseBerechnen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      if
        YAchseExtern + ÄnderungYAchseExtern < KartenKonstanten.AnfangYAchse
      then
         return ÜbergangNorden (YAchseExtern         => YAchseExtern,
                                 ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                 LogikGrafikExtern    => LogikGrafikExtern);
        
      elsif
        YAchseExtern + ÄnderungYAchseExtern > LeseWeltkarteneinstellungen.YAchse
      then
         return ÜbergangSüden (YAchseExtern         => YAchseExtern,
                                 ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                 LogikGrafikExtern    => LogikGrafikExtern);
         
      else
         return YAchseExtern + ÄnderungYAchseExtern;
      end if;
      
   end KartenkoordinateYAchseBerechnen;
   
   
   
   function ÜbergangNorden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      Kartenart (LogikGrafikExtern) := LeseWeltkarteneinstellungen.YAchseNorden;
      
      case
        Kartenart (LogikGrafikExtern)
      is
         when KartenartDatentypen.Karte_Y_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerYAchse;
                        
         when KartenartDatentypen.Karte_Y_Übergang_Enum | KartenartDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.YAchseVerschiebungSchreiben (LogikGrafikExtern => LogikGrafikExtern,
                                                                     ÜbergangExtern    => Kartenart (LogikGrafikExtern));
            
            return ÜbergangNordenNormal (YAchseExtern         => YAchseExtern,
                                          ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                          LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.YAchseVerschiebungSchreiben (LogikGrafikExtern => LogikGrafikExtern,
                                                                     ÜbergangExtern    => Kartenart (LogikGrafikExtern));
            
            return ÜbergangNordenRückwärts (YAchseExtern         => YAchseExtern,
                                               ÄnderungYAchseExtern => ÄnderungYAchseExtern);
      end case;
      
   end ÜbergangNorden;
   
   
   
   function ÜbergangNordenNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangYAchse (LogikGrafikExtern) := Integer (YAchseExtern + ÄnderungYAchseExtern + LeseWeltkarteneinstellungen.YAchse);
      
      YAchseKleinerSchleife:
      while ÜberhangYAchse (LogikGrafikExtern) < Positive (KartenKonstanten.AnfangYAchse) loop
            
         ÜberhangYAchse (LogikGrafikExtern) := ÜberhangYAchse (LogikGrafikExtern) + Positive (LeseWeltkarteneinstellungen.YAchse);

      end loop YAchseKleinerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangYAchse (LogikGrafikExtern));
      
   end ÜbergangNordenNormal;
   
   
   
   function ÜbergangNordenRückwärts
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      if
        YAchseExtern + ÄnderungYAchseExtern < KartenKonstanten.AnfangYAchse - 1
      then
         return KartenKonstanten.LeerYAchse;
         
      else
         return KartenKonstanten.AnfangYAchse + 1;
      end if;
      
   end ÜbergangNordenRückwärts;
   
   
   
   function ÜbergangSüden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      Kartenart (LogikGrafikExtern) := LeseWeltkarteneinstellungen.YAchseSüden;
      
      case
        Kartenart (LogikGrafikExtern)
      is
         when KartenartDatentypen.Karte_Y_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerYAchse;
            
         when KartenartDatentypen.Karte_Y_Übergang_Enum | KartenartDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.YAchseVerschiebungSchreiben (LogikGrafikExtern => LogikGrafikExtern,
                                                                     ÜbergangExtern    => Kartenart (LogikGrafikExtern));
            
            return ÜbergangSüdenNormal (YAchseExtern         => YAchseExtern,
                                          ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                          LogikGrafikExtern    => LogikGrafikExtern);
            
         when KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.YAchseVerschiebungSchreiben (LogikGrafikExtern => LogikGrafikExtern,
                                                                     ÜbergangExtern    => Kartenart (LogikGrafikExtern));
            
            return ÜbergangSüdenRückwärts (YAchseExtern         => YAchseExtern,
                                               ÄnderungYAchseExtern => ÄnderungYAchseExtern);
      end case;
      
   end ÜbergangSüden;
   
   
   
   function ÜbergangSüdenNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangYAchse (LogikGrafikExtern) := Positive (YAchseExtern + ÄnderungYAchseExtern - LeseWeltkarteneinstellungen.YAchse);
         
      YAchseGrößerSchleife:
      while ÜberhangYAchse (LogikGrafikExtern) > Positive (LeseWeltkarteneinstellungen.YAchse) loop
            
         ÜberhangYAchse (LogikGrafikExtern) := ÜberhangYAchse (LogikGrafikExtern) - Positive (LeseWeltkarteneinstellungen.YAchse);
            
      end loop YAchseGrößerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangYAchse (LogikGrafikExtern));
      
   end ÜbergangSüdenNormal;
   
   
   
   function ÜbergangSüdenRückwärts
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      if
        YAchseExtern + ÄnderungYAchseExtern > LeseWeltkarteneinstellungen.YAchse + 1
      then
         return KartenKonstanten.LeerYAchse;
         
      else
         return LeseWeltkarteneinstellungen.YAchse - 1;
      end if;
      
   end ÜbergangSüdenRückwärts;
   
   
   
   function YAchseVerschieben
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      if
        YAchseExtern + KartenDatentypen.KartenfeldPositiv (KartenkoordinatenWerteLogik.VerschiebungswertYAchse * Float (LeseWeltkarteneinstellungen.YAchse)) > LeseWeltkarteneinstellungen.YAchse
      then
         return YAchseExtern - KartenDatentypen.KartenfeldPositiv (KartenkoordinatenWerteLogik.VerschiebungswertYAchse * Float (LeseWeltkarteneinstellungen.YAchse));

      else
         return YAchseExtern + KartenDatentypen.KartenfeldPositiv (KartenkoordinatenWerteLogik.VerschiebungswertYAchse * Float (LeseWeltkarteneinstellungen.YAchse));
      end if;
      
   end YAchseVerschieben;

end KartenkoordinateYAchseBerechnenLogik;
