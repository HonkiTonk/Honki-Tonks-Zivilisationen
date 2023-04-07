with KartenKonstanten;
with KartenartDatentypen;

with LeseWeltkarteneinstellungen;

package body KartenkoordinateEAchseBerechnenLogik is

   function KartenkoordinateEAchseBerechnen
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.Ebene
   is
      use type KartenDatentypen.Ebene;
   begin
      
      if
        EAchseExtern + ÄnderungEAchseExtern < KartenKonstanten.AnfangEAchse
      then
         return KartenkoordinateEAchseÜbergangUnten (EAchseExtern         => EAchseExtern,
                                                      ÄnderungEAchseExtern => ÄnderungEAchseExtern,
                                                      LogikGrafikExtern    => LogikGrafikExtern);
         
      elsif
        EAchseExtern + ÄnderungEAchseExtern > KartenKonstanten.EndeEAchse
      then
         return KartenkoordinateEAchseÜbergangOben (EAchseExtern         => EAchseExtern,
                                                     ÄnderungEAchseExtern => ÄnderungEAchseExtern,
                                                     LogikGrafikExtern    => LogikGrafikExtern);
         
      else
         return EAchseExtern + ÄnderungEAchseExtern;
      end if;
      
   end KartenkoordinateEAchseBerechnen;
   
   
   
   function KartenkoordinateEAchseÜbergangUnten
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.Ebene
   is begin
      
      case
        LeseWeltkarteneinstellungen.EAchseUnten
      is
         when KartenartDatentypen.Karte_E_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerEAchse;
            
         when others =>
            ZwischenwertEAchse (LogikGrafikExtern) := abs (Integer (ÄnderungEAchseExtern));
            ÜberhangEAchse (LogikGrafikExtern) := Integer (EAchseExtern);
      end case;
      
      EAchseKleinerSchleife:
      while ZwischenwertEAchse (LogikGrafikExtern) > 0 loop
            
         if
           ÜberhangEAchse (LogikGrafikExtern) - 1 < Integer (KartenKonstanten.AnfangEAchse)
         then
            ÜberhangEAchse (LogikGrafikExtern) := Positive (KartenKonstanten.EndeEAchse);
               
         else
            ÜberhangEAchse (LogikGrafikExtern) := ÜberhangEAchse (LogikGrafikExtern) - 1;
         end if;
            
         ZwischenwertEAchse (LogikGrafikExtern) := ZwischenwertEAchse (LogikGrafikExtern) - 1;
            
      end loop EAchseKleinerSchleife;
         
      return KartenDatentypen.EbeneVorhanden (ÜberhangEAchse (LogikGrafikExtern));
      
   end KartenkoordinateEAchseÜbergangUnten;
   
   
   
   function KartenkoordinateEAchseÜbergangOben
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.Ebene
   is begin
      
      case
        LeseWeltkarteneinstellungen.EAchseOben
      is
         when KartenartDatentypen.Karte_E_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerEAchse;
            
         when others =>
            ZwischenwertEAchse (LogikGrafikExtern) := (Positive (ÄnderungEAchseExtern));
            ÜberhangEAchse (LogikGrafikExtern) := Integer (EAchseExtern);
      end case;
               
      EAchseGrößerSchleife:
      while ZwischenwertEAchse (LogikGrafikExtern) > 0 loop
            
         if
           ÜberhangEAchse (LogikGrafikExtern) + 1 > Positive (KartenKonstanten.EndeEAchse)
         then
            ÜberhangEAchse (LogikGrafikExtern) := Integer (KartenKonstanten.AnfangEAchse);
               
         else
            ÜberhangEAchse (LogikGrafikExtern) := ÜberhangEAchse (LogikGrafikExtern) + 1;
         end if;
            
         ZwischenwertEAchse (LogikGrafikExtern) := ZwischenwertEAchse (LogikGrafikExtern) - 1;
            
      end loop EAchseGrößerSchleife;
         
      return KartenDatentypen.EbeneVorhanden (ÜberhangEAchse (LogikGrafikExtern));
      
   end KartenkoordinateEAchseÜbergangOben;

end KartenkoordinateEAchseBerechnenLogik;
