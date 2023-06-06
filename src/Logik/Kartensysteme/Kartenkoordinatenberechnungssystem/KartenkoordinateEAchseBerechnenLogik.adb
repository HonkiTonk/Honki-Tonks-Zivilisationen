with KartenKonstanten;
with KartenartDatentypen;

with LeseWeltkarteneinstellungen;

package body KartenkoordinateEAchseBerechnenLogik is

   function KartenkoordinateEAchseBerechnen
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.Ebene
   is
      use type KartenDatentypen.Ebene;
   begin
      
      if
        EAchseExtern + ÄnderungEAchseExtern < KartenKonstanten.AnfangEAchse
      then
         return KartenkoordinateEAchseÜbergangUnten (EAchseExtern         => EAchseExtern,
                                                      ÄnderungEAchseExtern => ÄnderungEAchseExtern,
                                                      TaskExtern    => TaskExtern);
         
      elsif
        EAchseExtern + ÄnderungEAchseExtern > KartenKonstanten.EndeEAchse
      then
         return KartenkoordinateEAchseÜbergangOben (EAchseExtern         => EAchseExtern,
                                                     ÄnderungEAchseExtern => ÄnderungEAchseExtern,
                                                     TaskExtern    => TaskExtern);
         
      else
         return EAchseExtern + ÄnderungEAchseExtern;
      end if;
      
   end KartenkoordinateEAchseBerechnen;
   
   
   
   function KartenkoordinateEAchseÜbergangUnten
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.Ebene
   is begin
      
      case
        LeseWeltkarteneinstellungen.EAchseUnten
      is
         when KartenartDatentypen.Karte_E_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerEAchse;
            
         when others =>
            ZwischenwertEAchse (TaskExtern) := abs (Integer (ÄnderungEAchseExtern));
            ÜberhangEAchse (TaskExtern) := Integer (EAchseExtern);
      end case;
      
      EAchseKleinerSchleife:
      while ZwischenwertEAchse (TaskExtern) > 0 loop
            
         if
           ÜberhangEAchse (TaskExtern) - 1 < Integer (KartenKonstanten.AnfangEAchse)
         then
            ÜberhangEAchse (TaskExtern) := Positive (KartenKonstanten.EndeEAchse);
               
         else
            ÜberhangEAchse (TaskExtern) := ÜberhangEAchse (TaskExtern) - 1;
         end if;
            
         ZwischenwertEAchse (TaskExtern) := ZwischenwertEAchse (TaskExtern) - 1;
            
      end loop EAchseKleinerSchleife;
         
      return KartenDatentypen.EbeneVorhanden (ÜberhangEAchse (TaskExtern));
      
   end KartenkoordinateEAchseÜbergangUnten;
   
   
   
   function KartenkoordinateEAchseÜbergangOben
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.Ebene
   is begin
      
      case
        LeseWeltkarteneinstellungen.EAchseOben
      is
         when KartenartDatentypen.Karte_E_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerEAchse;
            
         when others =>
            ZwischenwertEAchse (TaskExtern) := (Positive (ÄnderungEAchseExtern));
            ÜberhangEAchse (TaskExtern) := Integer (EAchseExtern);
      end case;
               
      EAchseGrößerSchleife:
      while ZwischenwertEAchse (TaskExtern) > 0 loop
            
         if
           ÜberhangEAchse (TaskExtern) + 1 > Positive (KartenKonstanten.EndeEAchse)
         then
            ÜberhangEAchse (TaskExtern) := Integer (KartenKonstanten.AnfangEAchse);
               
         else
            ÜberhangEAchse (TaskExtern) := ÜberhangEAchse (TaskExtern) + 1;
         end if;
            
         ZwischenwertEAchse (TaskExtern) := ZwischenwertEAchse (TaskExtern) - 1;
            
      end loop EAchseGrößerSchleife;
         
      return KartenDatentypen.EbeneVorhanden (ÜberhangEAchse (TaskExtern));
      
   end KartenkoordinateEAchseÜbergangOben;

end KartenkoordinateEAchseBerechnenLogik;
