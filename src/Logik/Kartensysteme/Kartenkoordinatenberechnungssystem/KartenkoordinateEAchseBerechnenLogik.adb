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
            ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) := abs (Integer (ÄnderungEAchseExtern));
            ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := Integer (EAchseExtern);
      end case;
      
      EAchseKleinerSchleife:
      while ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) > 0 loop
            
         if
           ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) - 1 < Integer (KartenKonstanten.AnfangEAchse)
         then
            ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := Positive (KartenKonstanten.EndeEAchse);
               
         else
            ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) - 1;
         end if;
            
         ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) := ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) - 1;
            
      end loop EAchseKleinerSchleife;
         
      return KartenDatentypen.EbeneVorhanden (ÜberhangEAchse (LogikGrafikExtern, EAchseExtern));
      
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
            ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) := (Positive (ÄnderungEAchseExtern));
            ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := Integer (EAchseExtern);
      end case;
               
      EAchseGrößerSchleife:
      while ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) > 0 loop
            
         if
           ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) + 1 > Positive (KartenKonstanten.EndeEAchse)
         then
            ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := Integer (KartenKonstanten.AnfangEAchse);
               
         else
            ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) + 1;
         end if;
            
         ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) := ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) - 1;
            
      end loop EAchseGrößerSchleife;
         
      return KartenDatentypen.EbeneVorhanden (ÜberhangEAchse (LogikGrafikExtern, EAchseExtern));
      
   end KartenkoordinateEAchseÜbergangOben;

end KartenkoordinateEAchseBerechnenLogik;
