with KartenKonstanten;

package body KartenkoordinateWaagerechteBerechnenLogik is

   function KartenkoordinateWaagerechteBerechnen
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungWaagerechteExtern : in KartenDatentypen.Waagerechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.WaagerechteNatural
   is begin
      
      if
        WaagerechteExtern + ÄnderungWaagerechteExtern < KartenKonstanten.AnfangWaagerechte
      then
         return ÜbergangWesten (WaagerechteExtern         => WaagerechteExtern,
                                 ÄnderungWaagerechteExtern => ÄnderungWaagerechteExtern,
                                 TaskExtern    => TaskExtern);
        
      elsif
        WaagerechteExtern + ÄnderungWaagerechteExtern > LeseWeltkarteneinstellungen.Waagerechte
      then
         return ÜbergangOsten (WaagerechteExtern         => WaagerechteExtern,
                                ÄnderungWaagerechteExtern => ÄnderungWaagerechteExtern,
                                TaskExtern    => TaskExtern);
         
      else
         return WaagerechteExtern + ÄnderungWaagerechteExtern;
      end if;
      
   end KartenkoordinateWaagerechteBerechnen;
   
   
   
   function ÜbergangWesten
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungWaagerechteExtern : in KartenDatentypen.Waagerechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.WaagerechteNatural
   is begin
      
      Kartenart (TaskExtern) := LeseWeltkarteneinstellungen.WaagerechteWesten;
      
      case
        Kartenart (TaskExtern)
      is
         when KartenartDatentypen.Waagerechte_Übergangslos_Enum =>
            return KartenKonstanten.LeerWaagerechte;
            
         when KartenartDatentypen.Waagerechte_Übergang_Enum | KartenartDatentypen.Waagerechte_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.WaagerechteVerschiebungSchreiben (TaskExtern   => TaskExtern,
                                                                     ÜbergangExtern      => Kartenart (TaskExtern));
            
            return ÜbergangWestenNormal (WaagerechteExtern         => WaagerechteExtern,
                                          ÄnderungWaagerechteExtern => ÄnderungWaagerechteExtern,
                                          TaskExtern    => TaskExtern);
            
         when KartenartDatentypen.Waagerechte_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.WaagerechteVerschiebungSchreiben (TaskExtern   => TaskExtern,
                                                                     ÜbergangExtern      => Kartenart (TaskExtern));
      
            return ÜbergangWestenRückwärts (WaagerechteExtern         => WaagerechteExtern,
                                               ÄnderungWaagerechteExtern => ÄnderungWaagerechteExtern);
      end case;
      
   end ÜbergangWesten;
   
   
   
   function ÜbergangWestenNormal
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungWaagerechteExtern : in KartenDatentypen.Waagerechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.WaagerechtePositiv
   is begin
      
      ÜberhangWaagerechte (TaskExtern) := Integer (WaagerechteExtern + ÄnderungWaagerechteExtern + LeseWeltkarteneinstellungen.Waagerechte);
         
      WaagerechteKleinerSchleife:
      while ÜberhangWaagerechte (TaskExtern) < Positive (KartenKonstanten.AnfangWaagerechte) loop
            
         ÜberhangWaagerechte (TaskExtern) := ÜberhangWaagerechte (TaskExtern) + Positive (LeseWeltkarteneinstellungen.Waagerechte);

      end loop WaagerechteKleinerSchleife;
         
      return KartenDatentypen.WaagerechtePositiv (ÜberhangWaagerechte (TaskExtern));
      
   end ÜbergangWestenNormal;
   
   
   
   function ÜbergangWestenRückwärts
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungWaagerechteExtern : in KartenDatentypen.Waagerechte)
      return KartenDatentypen.WaagerechteNatural
   is begin
      
      if
        WaagerechteExtern + ÄnderungWaagerechteExtern < KartenKonstanten.AnfangWaagerechte - 1
      then
         return KartenKonstanten.LeerWaagerechte;
         
      else
         return KartenKonstanten.AnfangWaagerechte + 1;
      end if;
            
   end ÜbergangWestenRückwärts;
   
   
   
   function ÜbergangOsten
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungWaagerechteExtern : in KartenDatentypen.Waagerechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.WaagerechteNatural
   is begin
      
      Kartenart (TaskExtern) := LeseWeltkarteneinstellungen.WaagerechteOsten;
      
      case
        Kartenart (TaskExtern)
      is
         when KartenartDatentypen.Waagerechte_Übergangslos_Enum =>
            return KartenKonstanten.LeerWaagerechte;
            
         when KartenartDatentypen.Waagerechte_Übergang_Enum | KartenartDatentypen.Waagerechte_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.WaagerechteVerschiebungSchreiben (TaskExtern     => TaskExtern,
                                                                     ÜbergangExtern => Kartenart (TaskExtern));
            
            return ÜbergangOstenNormal (WaagerechteExtern         => WaagerechteExtern,
                                         ÄnderungWaagerechteExtern => ÄnderungWaagerechteExtern,
                                         TaskExtern    => TaskExtern);
            
         when KartenartDatentypen.Waagerechte_Rückwärts_Verschobener_Übergang_Enum =>
            KartenkoordinatenWerteLogik.WaagerechteVerschiebungSchreiben (TaskExtern     => TaskExtern,
                                                                     ÜbergangExtern => Kartenart (TaskExtern));
      
            return ÜbergangOstenRückwärts (WaagerechteExtern         => WaagerechteExtern,
                                              ÄnderungWaagerechteExtern => ÄnderungWaagerechteExtern);
      end case;
      
   end ÜbergangOsten;
   
   
   
   function ÜbergangOstenNormal
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungWaagerechteExtern : in KartenDatentypen.Waagerechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.WaagerechtePositiv
   is begin
      
      ÜberhangWaagerechte (TaskExtern) := Positive (WaagerechteExtern + ÄnderungWaagerechteExtern - LeseWeltkarteneinstellungen.Waagerechte);
         
      WaagerechteGrößerSchleife:
      while ÜberhangWaagerechte (TaskExtern) > Positive (LeseWeltkarteneinstellungen.Waagerechte) loop
            
         ÜberhangWaagerechte (TaskExtern) := ÜberhangWaagerechte (TaskExtern) - Positive (LeseWeltkarteneinstellungen.Waagerechte);
            
      end loop WaagerechteGrößerSchleife;
         
      return KartenDatentypen.WaagerechtePositiv (ÜberhangWaagerechte (TaskExtern));
      
   end ÜbergangOstenNormal;
   
   
   
   function ÜbergangOstenRückwärts
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungWaagerechteExtern : in KartenDatentypen.Waagerechte)
      return KartenDatentypen.WaagerechteNatural
   is begin
      
      if
        WaagerechteExtern + ÄnderungWaagerechteExtern > LeseWeltkarteneinstellungen.Waagerechte + 1
      then
         return KartenKonstanten.LeerWaagerechte;
         
      else
         return LeseWeltkarteneinstellungen.Waagerechte - 1;
      end if;
      
   end ÜbergangOstenRückwärts;
   
      
   
   function WaagerechteVerschieben
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechtePositiv
   is begin
      
      if
        WaagerechteExtern + KartenDatentypen.WaagerechtePositiv (Float (KartenkoordinatenWerteLogik.VerschiebungswertWaagerechte) * Float (LeseWeltkarteneinstellungen.Waagerechte)) > LeseWeltkarteneinstellungen.Waagerechte
      then
         return WaagerechteExtern - KartenDatentypen.WaagerechtePositiv (Float (KartenkoordinatenWerteLogik.VerschiebungswertWaagerechte) * Float (LeseWeltkarteneinstellungen.Waagerechte));

      else
         return WaagerechteExtern + KartenDatentypen.WaagerechtePositiv (Float (KartenkoordinatenWerteLogik.VerschiebungswertWaagerechte) * Float (LeseWeltkarteneinstellungen.Waagerechte));
      end if;
      
   end WaagerechteVerschieben;

end KartenkoordinateWaagerechteBerechnenLogik;
