pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with Weltkarte;

package body KartenkoordinateEAchseBerechnenLogik is

   function KartenkoordinateEAchseBerechnen
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Ebene;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.Ebene
   is begin
      
      if
        EAchseExtern + ÄnderungEAchseExtern < Weltkarte.KarteArray'First (1)
      then
         return KartenkoordinateEAchseÜbergangUnten (EAchseExtern         => EAchseExtern,
                                                      ÄnderungEAchseExtern => ÄnderungEAchseExtern,
                                                      LogikGrafikExtern    => LogikGrafikExtern);
         
      elsif
        EAchseExtern + ÄnderungEAchseExtern > Weltkarte.KarteArray'Last (1)
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
        Weltkarte.Karteneinstellungen.Kartenform.EAchseUnten
      is
         when KartenDatentypen.Karte_E_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerEAchse;
            
         when others =>
            ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) := abs (Integer (ÄnderungEAchseExtern));
            ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := Integer (EAchseExtern);
      end case;
         
      EAchseKleinerSchleife:
      while ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) > 0 loop
            
         if
           ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) - 1 < Integer (Weltkarte.KarteArray'First (1))
         then
            ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := Positive (Weltkarte.KarteArray'Last (1));
               
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
        Weltkarte.Karteneinstellungen.Kartenform.EAchseOben
      is
         when KartenDatentypen.Karte_E_Kein_Übergang_Enum =>
            return KartenKonstanten.LeerEAchse;
            
         when others =>
            ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) := (Positive (ÄnderungEAchseExtern));
            ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := Integer (EAchseExtern);
      end case;
               
      EAchseGrößerSchleife:
      while ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) > 0 loop
            
         if
           ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) + 1 > Positive (Weltkarte.KarteArray'Last (1))
         then
            ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := Integer (Weltkarte.KarteArray'First (1));
               
         else
            ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) := ÜberhangEAchse (LogikGrafikExtern, EAchseExtern) + 1;
         end if;
            
         ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) := ZwischenwertEAchse (LogikGrafikExtern, EAchseExtern) - 1;
            
      end loop EAchseGrößerSchleife;
         
      return KartenDatentypen.EbeneVorhanden (ÜberhangEAchse (LogikGrafikExtern, EAchseExtern));
      
   end KartenkoordinateEAchseÜbergangOben;

end KartenkoordinateEAchseBerechnenLogik;
