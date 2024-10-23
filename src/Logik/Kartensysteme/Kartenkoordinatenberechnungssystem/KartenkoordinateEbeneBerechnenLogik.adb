with KartenKonstanten;
with KartenartDatentypen;

with LeseWeltkarteneinstellungen;

package body KartenkoordinateEbeneBerechnenLogik is

   function KartenkoordinateEbeneBerechnen
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEbeneExtern : in KartenDatentypen.Ebene;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.Ebene
   is
      use type KartenDatentypen.Ebene;
   begin
      
      if
        EbeneExtern + ÄnderungEbeneExtern < KartenKonstanten.AnfangEbene
      then
         return KartenkoordinateEbeneÜbergangUnten (EbeneExtern         => EbeneExtern,
                                                      ÄnderungEbeneExtern => ÄnderungEbeneExtern,
                                                      TaskExtern    => TaskExtern);
         
      elsif
        EbeneExtern + ÄnderungEbeneExtern > KartenKonstanten.EndeEbene
      then
         return KartenkoordinateEbeneÜbergangOben (EbeneExtern         => EbeneExtern,
                                                     ÄnderungEbeneExtern => ÄnderungEbeneExtern,
                                                     TaskExtern    => TaskExtern);
         
      else
         return EbeneExtern + ÄnderungEbeneExtern;
      end if;
      
   end KartenkoordinateEbeneBerechnen;
   
   
   
   function KartenkoordinateEbeneÜbergangUnten
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEbeneExtern : in KartenDatentypen.Ebene;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.Ebene
   is begin
      
      case
        LeseWeltkarteneinstellungen.EbeneUnten
      is
         when KartenartDatentypen.Ebene_Übergangslos_Enum =>
            return KartenKonstanten.LeerEbene;
            
         when others =>
            ZwischenwertEbene (TaskExtern) := abs (Integer (ÄnderungEbeneExtern));
            ÜberhangEbene (TaskExtern) := Integer (EbeneExtern);
      end case;
      
      EbeneKleinerSchleife:
      while ZwischenwertEbene (TaskExtern) > 0 loop
            
         if
           ÜberhangEbene (TaskExtern) - 1 < Integer (KartenKonstanten.AnfangEbene)
         then
            ÜberhangEbene (TaskExtern) := Positive (KartenKonstanten.EndeEbene);
               
         else
            ÜberhangEbene (TaskExtern) := ÜberhangEbene (TaskExtern) - 1;
         end if;
            
         ZwischenwertEbene (TaskExtern) := ZwischenwertEbene (TaskExtern) - 1;
            
      end loop EbeneKleinerSchleife;
         
      return KartenDatentypen.EbeneVorhanden (ÜberhangEbene (TaskExtern));
      
   end KartenkoordinateEbeneÜbergangUnten;
   
   
   
   function KartenkoordinateEbeneÜbergangOben
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEbeneExtern : in KartenDatentypen.Ebene;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.Ebene
   is begin
      
      case
        LeseWeltkarteneinstellungen.EbeneOben
      is
         when KartenartDatentypen.Ebene_Übergangslos_Enum =>
            return KartenKonstanten.LeerEbene;
            
         when others =>
            ZwischenwertEbene (TaskExtern) := (Positive (ÄnderungEbeneExtern));
            ÜberhangEbene (TaskExtern) := Integer (EbeneExtern);
      end case;
               
      EbeneGrößerSchleife:
      while ZwischenwertEbene (TaskExtern) > 0 loop
            
         if
           ÜberhangEbene (TaskExtern) + 1 > Positive (KartenKonstanten.EndeEbene)
         then
            ÜberhangEbene (TaskExtern) := Integer (KartenKonstanten.AnfangEbene);
               
         else
            ÜberhangEbene (TaskExtern) := ÜberhangEbene (TaskExtern) + 1;
         end if;
            
         ZwischenwertEbene (TaskExtern) := ZwischenwertEbene (TaskExtern) - 1;
            
      end loop EbeneGrößerSchleife;
         
      return KartenDatentypen.EbeneVorhanden (ÜberhangEbene (TaskExtern));
      
   end KartenkoordinateEbeneÜbergangOben;

end KartenkoordinateEbeneBerechnenLogik;
