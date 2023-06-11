with KartenKonstanten;

package body KartenkoordinateYAchseBerechnenLogik is

   function KartenkoordinateYAchseBerechnen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      if
        YAchseExtern + ÄnderungYAchseExtern < KartenKonstanten.AnfangYAchse
      then
         return ÜbergangNorden (YAchseExtern         => YAchseExtern,
                                 ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                 TaskExtern    => TaskExtern);
        
      elsif
        YAchseExtern + ÄnderungYAchseExtern > LeseWeltkarteneinstellungen.YAchse
      then
         return ÜbergangSüden (YAchseExtern         => YAchseExtern,
                                 ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                 TaskExtern    => TaskExtern);
         
      else
         return YAchseExtern + ÄnderungYAchseExtern;
      end if;
      
   end KartenkoordinateYAchseBerechnen;
   
   
   
   function ÜbergangNorden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      Kartenart (TaskExtern) := LeseWeltkarteneinstellungen.YAchseNorden;
      
      case
        Kartenart (TaskExtern)
      is
         when KartenartDatentypen.Karte_Y_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerYAchse;
                        
         when KartenartDatentypen.Karte_Y_Übergang_Enum | KartenartDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.YAchseVerschiebungSchreiben (TaskExtern     => TaskExtern,
                                                                     ÜbergangExtern => Kartenart (TaskExtern));
            
            return ÜbergangNordenNormal (YAchseExtern         => YAchseExtern,
                                          ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                          TaskExtern    => TaskExtern);
            
         when KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.YAchseVerschiebungSchreiben (TaskExtern     => TaskExtern,
                                                                     ÜbergangExtern => Kartenart (TaskExtern));
            
            return ÜbergangNordenRückwärts (YAchseExtern         => YAchseExtern,
                                               ÄnderungYAchseExtern => ÄnderungYAchseExtern);
      end case;
      
   end ÜbergangNorden;
   
   
   
   function ÜbergangNordenNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangYAchse (TaskExtern) := Integer (YAchseExtern + ÄnderungYAchseExtern + LeseWeltkarteneinstellungen.YAchse);
      
      YAchseKleinerSchleife:
      while ÜberhangYAchse (TaskExtern) < Positive (KartenKonstanten.AnfangYAchse) loop
            
         ÜberhangYAchse (TaskExtern) := ÜberhangYAchse (TaskExtern) + Positive (LeseWeltkarteneinstellungen.YAchse);

      end loop YAchseKleinerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangYAchse (TaskExtern));
      
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
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      Kartenart (TaskExtern) := LeseWeltkarteneinstellungen.YAchseSüden;
      
      case
        Kartenart (TaskExtern)
      is
         when KartenartDatentypen.Karte_Y_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerYAchse;
            
         when KartenartDatentypen.Karte_Y_Übergang_Enum | KartenartDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.YAchseVerschiebungSchreiben (TaskExtern     => TaskExtern,
                                                                     ÜbergangExtern => Kartenart (TaskExtern));
            
            return ÜbergangSüdenNormal (YAchseExtern         => YAchseExtern,
                                          ÄnderungYAchseExtern => ÄnderungYAchseExtern,
                                          TaskExtern    => TaskExtern);
            
         when KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.YAchseVerschiebungSchreiben (TaskExtern     => TaskExtern,
                                                                     ÜbergangExtern => Kartenart (TaskExtern));
            
            return ÜbergangSüdenRückwärts (YAchseExtern         => YAchseExtern,
                                               ÄnderungYAchseExtern => ÄnderungYAchseExtern);
      end case;
      
   end ÜbergangSüden;
   
   
   
   function ÜbergangSüdenNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      ÜberhangYAchse (TaskExtern) := Positive (YAchseExtern + ÄnderungYAchseExtern - LeseWeltkarteneinstellungen.YAchse);
         
      YAchseGrößerSchleife:
      while ÜberhangYAchse (TaskExtern) > Positive (LeseWeltkarteneinstellungen.YAchse) loop
            
         ÜberhangYAchse (TaskExtern) := ÜberhangYAchse (TaskExtern) - Positive (LeseWeltkarteneinstellungen.YAchse);
            
      end loop YAchseGrößerSchleife;
         
      return KartenDatentypen.KartenfeldPositiv (ÜberhangYAchse (TaskExtern));
      
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
