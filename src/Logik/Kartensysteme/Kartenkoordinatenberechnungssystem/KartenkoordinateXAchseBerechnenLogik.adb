with KartenKonstanten;

package body KartenkoordinateXAchseBerechnenLogik is

   function KartenkoordinateXAchseBerechnen
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      if
        XAchseExtern + ÄnderungXAchseExtern < KartenKonstanten.AnfangXAchse
      then
         return ÜbergangWesten (XAchseExtern         => XAchseExtern,
                                 ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                 TaskExtern    => TaskExtern);
        
      elsif
        XAchseExtern + ÄnderungXAchseExtern > LeseWeltkarteneinstellungen.XAchse
      then
         return ÜbergangOsten (XAchseExtern         => XAchseExtern,
                                ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                TaskExtern    => TaskExtern);
         
      else
         return XAchseExtern + ÄnderungXAchseExtern;
      end if;
      
   end KartenkoordinateXAchseBerechnen;
   
   
   
   function ÜbergangWesten
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      Kartenart (TaskExtern) := LeseWeltkarteneinstellungen.XAchseWesten;
      
      case
        Kartenart (TaskExtern)
      is
         when KartenartDatentypen.Karte_X_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerXAchse;
            
         when KartenartDatentypen.Karte_X_Übergang_Enum | KartenartDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.XAchseVerschiebungSchreiben (TaskExtern   => TaskExtern,
                                                                     ÜbergangExtern      => Kartenart (TaskExtern));
            
            return ÜbergangWestenNormal (XAchseExtern         => XAchseExtern,
                                          ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                          TaskExtern    => TaskExtern);
            
         when KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.XAchseVerschiebungSchreiben (TaskExtern   => TaskExtern,
                                                                     ÜbergangExtern      => Kartenart (TaskExtern));
      
            return ÜbergangWestenRückwärts (XAchseExtern         => XAchseExtern,
                                               ÄnderungXAchseExtern => ÄnderungXAchseExtern);
      end case;
      
   end ÜbergangWesten;
   
   
   
   function ÜbergangWestenNormal
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangXAchse (TaskExtern) := Integer (XAchseExtern + ÄnderungXAchseExtern + LeseWeltkarteneinstellungen.XAchse);
         
      XAchseKleinerSchleife:
      while ÜberhangXAchse (TaskExtern) < Positive (KartenKonstanten.AnfangXAchse) loop
            
         ÜberhangXAchse (TaskExtern) := ÜberhangXAchse (TaskExtern) + Positive (LeseWeltkarteneinstellungen.XAchse);

      end loop XAchseKleinerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangXAchse (TaskExtern));
      
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
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      Kartenart (TaskExtern) := LeseWeltkarteneinstellungen.XAchseOsten;
      
      case
        Kartenart (TaskExtern)
      is
         when KartenartDatentypen.Karte_X_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerXAchse;
            
         when KartenartDatentypen.Karte_X_Übergang_Enum | KartenartDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.XAchseVerschiebungSchreiben (TaskExtern => TaskExtern,
                                                                     ÜbergangExtern    => Kartenart (TaskExtern));
            
            return ÜbergangOstenNormal (XAchseExtern         => XAchseExtern,
                                         ÄnderungXAchseExtern => ÄnderungXAchseExtern,
                                         TaskExtern    => TaskExtern);
            
         when KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.XAchseVerschiebungSchreiben (TaskExtern => TaskExtern,
                                                                     ÜbergangExtern    => Kartenart (TaskExtern));
      
            return ÜbergangOstenRückwärts (XAchseExtern         => XAchseExtern,
                                              ÄnderungXAchseExtern => ÄnderungXAchseExtern);
      end case;
      
   end ÜbergangOsten;
   
   
   
   function ÜbergangOstenNormal
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangXAchse (TaskExtern) := Positive (XAchseExtern + ÄnderungXAchseExtern - LeseWeltkarteneinstellungen.XAchse);
         
      XAchseGrößerSchleife:
      while ÜberhangXAchse (TaskExtern) > Positive (LeseWeltkarteneinstellungen.XAchse) loop
            
         ÜberhangXAchse (TaskExtern) := ÜberhangXAchse (TaskExtern) - Positive (LeseWeltkarteneinstellungen.XAchse);
            
      end loop XAchseGrößerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangXAchse (TaskExtern));
      
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
