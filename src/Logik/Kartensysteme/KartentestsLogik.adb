with KartengeneratorVariablenLogik;

package body KartentestsLogik is
   
   procedure Größenanpassung
   is begin

      if
        KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Norden_Enum) > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Senkrechte / 2
      then
         KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Norden_Enum) := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Senkrechte / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Süden_Enum) > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Senkrechte / 2
      then
         KartengeneratorVariablenLogik.SenkrechtePolgrößen (KartenartDatentypen.Süden_Enum) := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Senkrechte / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Osten_Enum) > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Waagerechte / 2
      then
         KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Osten_Enum) := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Waagerechte / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Westen_Enum) > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Waagerechte / 2
      then
         KartengeneratorVariablenLogik.WaagerechtePolgrößen (KartenartDatentypen.Westen_Enum) := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Waagerechte / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.Landgrößen.MinimaleSenkrechte > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Senkrechte / 2
      then
         KartengeneratorVariablenLogik.Landgrößen.MinimaleSenkrechte := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Senkrechte / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.Landgrößen.MinimaleWaagerechte > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Waagerechte / 2
      then
         KartengeneratorVariablenLogik.Landgrößen.MinimaleWaagerechte := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Waagerechte / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.Landgrößen.MaximaleSenkrechte > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Senkrechte / 2
      then
         KartengeneratorVariablenLogik.Landgrößen.MaximaleSenkrechte := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Senkrechte / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.Landgrößen.MaximaleWaagerechte > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Waagerechte / 2
      then
         KartengeneratorVariablenLogik.Landgrößen.MaximaleWaagerechte := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.Waagerechte / 2;
         
      else
         null;
      end if;

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
   
end KartentestsLogik;
