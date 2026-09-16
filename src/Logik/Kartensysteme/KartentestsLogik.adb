with KartengeneratorVariablenLogik;

package body KartentestsLogik is
   
   procedure Größenanpassung
   is begin

      Kartengröße := KartengeneratorVariablenLogik.KartengrößeLesen;
      
      if
        KartengeneratorVariablenLogik.SenkrechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Norden_Enum) > Kartengröße.Senkrechte / 2
      then
         KartengeneratorVariablenLogik.SenkrechterPolSchreiben (SenkrechteExtern      => Kartengröße.Senkrechte / 2,
                                                                HimmelsrichtungExtern => KartenartDatentypen.Norden_Enum);
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.SenkrechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Süden_Enum) > Kartengröße.Senkrechte / 2
      then
         KartengeneratorVariablenLogik.SenkrechterPolSchreiben (SenkrechteExtern      => Kartengröße.Senkrechte / 2,
                                                                HimmelsrichtungExtern => KartenartDatentypen.Süden_Enum);
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.WaagerechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Osten_Enum) > Kartengröße.Waagerechte / 2
      then
         KartengeneratorVariablenLogik.WaagerechterPolSchreiben (WaagerechteExtern     => Kartengröße.Waagerechte / 2,
                                                                 HimmelsrichtungExtern => KartenartDatentypen.Osten_Enum);
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.WaagerechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Westen_Enum) > Kartengröße.Waagerechte / 2
      then
         KartengeneratorVariablenLogik.WaagerechterPolSchreiben (WaagerechteExtern     => Kartengröße.Waagerechte / 2,
                                                                 HimmelsrichtungExtern => KartenartDatentypen.Westen_Enum);
         
      else
         null;
      end if;
      
      Landgrößen := KartengeneratorVariablenLogik.LandgrößenLesen;
      
      if
        Landgrößen.MinimaleSenkrechte > Kartengröße.Senkrechte / 2
      then
         Landgrößen.MinimaleSenkrechte := Kartengröße.Senkrechte / 2;
         
      else
         null;
      end if;
      
      if
        Landgrößen.MinimaleWaagerechte > Kartengröße.Waagerechte / 2
      then
         Landgrößen.MinimaleWaagerechte := Kartengröße.Waagerechte / 2;
         
      else
         null;
      end if;
      
      if
        Landgrößen.MaximaleSenkrechte > Kartengröße.Senkrechte / 2
      then
         Landgrößen.MaximaleSenkrechte := Kartengröße.Senkrechte / 2;
         
      else
         null;
      end if;
      
      if
        Landgrößen.MaximaleWaagerechte > Kartengröße.Waagerechte / 2
      then
         Landgrößen.MaximaleWaagerechte := Kartengröße.Waagerechte / 2;
         
      else
         null;
      end if;
      
      KartengeneratorVariablenLogik.LandgrößenSchreiben (GrößeExtern => Landgrößen);

   end Größenanpassung;
   
   

   function SenkrechteKartenpolePrüfen
     (PolgrößeExtern : in KartenDatentypen.SenkrechteNatural)
      return KartenartDatentypen.Kartenpole_Enum
   is begin
     
      case
        PolgrößeExtern
      is
         when 0 =>
            return KartenartDatentypen.Kartenpol_Nicht_Vorhanden_Enum;
            
         when others =>
            return KartenartDatentypen.Kartenpol_Vorhanden_Enum;
      end case;
     
   end SenkrechteKartenpolePrüfen;
   
   

   function WaagerechteKartenpolePrüfen
     (PolgrößeExtern : in KartenDatentypen.WaagerechteNatural)
      return KartenartDatentypen.Kartenpole_Enum
   is begin
     
      case
        PolgrößeExtern
      is
         when 0 =>
            return KartenartDatentypen.Kartenpol_Nicht_Vorhanden_Enum;
            
         when others =>
            return KartenartDatentypen.Kartenpol_Vorhanden_Enum;
      end case;
     
   end WaagerechteKartenpolePrüfen;
   
   
   
   function VorhandeneEbenen
     (EbenenExtern : in KartenRecords.KartenebenenVorhandenRecord)
      return KartenDatentypen.SenkrechtePositiv
   is
      use type KartenDatentypen.EbeneVorhanden;
   begin
            
      if
        EbenenExtern.EbeneEnde >= 0
      then
         return KartenDatentypen.SenkrechtePositiv ((abs (EbenenExtern.EbeneAnfang) + EbenenExtern.EbeneEnde) + 1);
                  
      else
         return KartenDatentypen.SenkrechtePositiv (abs (EbenenExtern.EbeneAnfang));
      end if;
      
   end VorhandeneEbenen;
   
   
   
   function PlanetenEbenen
     (EbenenExtern : in KartenRecords.KartenebenenVorhandenRecord)
      return KartenDatentypen.SenkrechtePositiv
   is
      use type KartenDatentypen.EbeneVorhanden;
   begin
      
      if
        EbenenExtern.EbeneEnde >= 0
      then
         return KartenDatentypen.SenkrechtePositiv (abs (EbenenExtern.EbeneAnfang) + 1);
         
      else
         return KartenDatentypen.SenkrechtePositiv (abs (EbenenExtern.EbeneAnfang));
      end if;
      
   end PlanetenEbenen;
   
end KartentestsLogik;
