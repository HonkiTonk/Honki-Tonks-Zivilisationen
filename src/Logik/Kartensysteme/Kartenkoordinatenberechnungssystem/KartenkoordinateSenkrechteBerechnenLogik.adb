with KartenKonstanten;

package body KartenkoordinateSenkrechteBerechnenLogik is

   function KartenkoordinateSenkrechteBerechnen
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungSenkrechteExtern : in KartenDatentypen.Senkrechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.SenkrechteNatural
   is begin
      
      if
        SenkrechteExtern + ÄnderungSenkrechteExtern < KartenKonstanten.AnfangSenkrechte
      then
         return ÜbergangNorden (SenkrechteExtern         => SenkrechteExtern,
                                 ÄnderungSenkrechteExtern => ÄnderungSenkrechteExtern,
                                 TaskExtern    => TaskExtern);
        
      elsif
        SenkrechteExtern + ÄnderungSenkrechteExtern > LeseWeltkarteneinstellungen.Senkrechte
      then
         return ÜbergangSüden (SenkrechteExtern         => SenkrechteExtern,
                                 ÄnderungSenkrechteExtern => ÄnderungSenkrechteExtern,
                                 TaskExtern    => TaskExtern);
         
      else
         return SenkrechteExtern + ÄnderungSenkrechteExtern;
      end if;
      
   end KartenkoordinateSenkrechteBerechnen;
   
   
   
   function ÜbergangNorden
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungSenkrechteExtern : in KartenDatentypen.Senkrechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.SenkrechteNatural
   is begin
      
      Kartenart (TaskExtern) := LeseWeltkarteneinstellungen.SenkrechteNorden;
      
      case
        Kartenart (TaskExtern)
      is
         when KartenartDatentypen.Senkrechte_Übergangslos_Enum =>
            return KartenKonstanten.LeerSenkrechte;
                        
         when KartenartDatentypen.Senkrechte_Übergang_Enum | KartenartDatentypen.Senkrechte_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.SenkrechteVerschiebungSchreiben (TaskExtern     => TaskExtern,
                                                                     ÜbergangExtern => Kartenart (TaskExtern));
            
            return ÜbergangNordenNormal (SenkrechteExtern         => SenkrechteExtern,
                                          ÄnderungSenkrechteExtern => ÄnderungSenkrechteExtern,
                                          TaskExtern    => TaskExtern);
            
         when KartenartDatentypen.Senkrechte_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.SenkrechteVerschiebungSchreiben (TaskExtern     => TaskExtern,
                                                                     ÜbergangExtern => Kartenart (TaskExtern));
            
            return ÜbergangNordenRückwärts (SenkrechteExtern         => SenkrechteExtern,
                                               ÄnderungSenkrechteExtern => ÄnderungSenkrechteExtern);
      end case;
      
   end ÜbergangNorden;
   
   
   
   function ÜbergangNordenNormal
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungSenkrechteExtern : in KartenDatentypen.Senkrechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.SenkrechtePositiv
   is begin
      
      ÜberhangSenkrechte (TaskExtern) := Integer (SenkrechteExtern + ÄnderungSenkrechteExtern + LeseWeltkarteneinstellungen.Senkrechte);
      
      SenkrechteKleinerSchleife:
      while ÜberhangSenkrechte (TaskExtern) < Positive (KartenKonstanten.AnfangSenkrechte) loop
            
         ÜberhangSenkrechte (TaskExtern) := ÜberhangSenkrechte (TaskExtern) + Positive (LeseWeltkarteneinstellungen.Senkrechte);

      end loop SenkrechteKleinerSchleife;
         
      return KartenDatentypen.SenkrechtePositiv (ÜberhangSenkrechte (TaskExtern));
      
   end ÜbergangNordenNormal;
   
   
   
   function ÜbergangNordenRückwärts
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungSenkrechteExtern : in KartenDatentypen.Senkrechte)
      return KartenDatentypen.SenkrechteNatural
   is begin
      
      if
        SenkrechteExtern + ÄnderungSenkrechteExtern < KartenKonstanten.AnfangSenkrechte - 1
      then
         return KartenKonstanten.LeerSenkrechte;
         
      else
         return KartenKonstanten.AnfangSenkrechte + 1;
      end if;
      
   end ÜbergangNordenRückwärts;
   
   
   
   function ÜbergangSüden
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungSenkrechteExtern : in KartenDatentypen.Senkrechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.SenkrechteNatural
   is begin
      
      Kartenart (TaskExtern) := LeseWeltkarteneinstellungen.SenkrechteSüden;
      
      case
        Kartenart (TaskExtern)
      is
         when KartenartDatentypen.Senkrechte_Übergangslos_Enum =>
            return KartenKonstanten.LeerSenkrechte;
            
         when KartenartDatentypen.Senkrechte_Übergang_Enum | KartenartDatentypen.Senkrechte_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.SenkrechteVerschiebungSchreiben (TaskExtern     => TaskExtern,
                                                                     ÜbergangExtern => Kartenart (TaskExtern));
            
            return ÜbergangSüdenNormal (SenkrechteExtern         => SenkrechteExtern,
                                          ÄnderungSenkrechteExtern => ÄnderungSenkrechteExtern,
                                          TaskExtern    => TaskExtern);
            
         when KartenartDatentypen.Senkrechte_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.SenkrechteVerschiebungSchreiben (TaskExtern     => TaskExtern,
                                                                     ÜbergangExtern => Kartenart (TaskExtern));
            
            return ÜbergangSüdenRückwärts (SenkrechteExtern         => SenkrechteExtern,
                                               ÄnderungSenkrechteExtern => ÄnderungSenkrechteExtern);
      end case;
      
   end ÜbergangSüden;
   
   
   
   function ÜbergangSüdenNormal
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungSenkrechteExtern : in KartenDatentypen.Senkrechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.SenkrechtePositiv
   is begin
      
      ÜberhangSenkrechte (TaskExtern) := Positive (SenkrechteExtern + ÄnderungSenkrechteExtern - LeseWeltkarteneinstellungen.Senkrechte);
         
      SenkrechteGrößerSchleife:
      while ÜberhangSenkrechte (TaskExtern) > Positive (LeseWeltkarteneinstellungen.Senkrechte) loop
            
         ÜberhangSenkrechte (TaskExtern) := ÜberhangSenkrechte (TaskExtern) - Positive (LeseWeltkarteneinstellungen.Senkrechte);
            
      end loop SenkrechteGrößerSchleife;
         
      return KartenDatentypen.SenkrechtePositiv (ÜberhangSenkrechte (TaskExtern));
      
   end ÜbergangSüdenNormal;
   
   
   
   function ÜbergangSüdenRückwärts
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungSenkrechteExtern : in KartenDatentypen.Senkrechte)
      return KartenDatentypen.SenkrechteNatural
   is begin
      
      if
        SenkrechteExtern + ÄnderungSenkrechteExtern > LeseWeltkarteneinstellungen.Senkrechte + 1
      then
         return KartenKonstanten.LeerSenkrechte;
         
      else
         return LeseWeltkarteneinstellungen.Senkrechte - 1;
      end if;
      
   end ÜbergangSüdenRückwärts;
   
   
   
   function SenkrechteVerschieben
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechtePositiv
   is begin
      
      if
        SenkrechteExtern + KartenDatentypen.SenkrechtePositiv (Float (KartenkoordinatenWerteLogik.VerschiebungswertSenkrechte) * Float (LeseWeltkarteneinstellungen.Senkrechte)) > LeseWeltkarteneinstellungen.Senkrechte
      then
         return SenkrechteExtern - KartenDatentypen.SenkrechtePositiv (Float (KartenkoordinatenWerteLogik.VerschiebungswertSenkrechte) * Float (LeseWeltkarteneinstellungen.Senkrechte));

      else
         return SenkrechteExtern + KartenDatentypen.SenkrechtePositiv (Float (KartenkoordinatenWerteLogik.VerschiebungswertSenkrechte) * Float (LeseWeltkarteneinstellungen.Senkrechte));
      end if;
      
   end SenkrechteVerschieben;

end KartenkoordinateSenkrechteBerechnenLogik;
