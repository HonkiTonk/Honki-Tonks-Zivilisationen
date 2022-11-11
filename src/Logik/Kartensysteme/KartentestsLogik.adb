with KartengeneratorVariablenLogik;

package body KartentestsLogik is
   
   procedure Größenanpassung
   is begin

      if
        KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Norden_Enum) > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse / 2
      then
         KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Norden_Enum) := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Süden_Enum) > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse / 2
      then
         KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Süden_Enum) := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Osten_Enum) > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse / 2
      then
         KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Osten_Enum) := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Westen_Enum) > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse / 2
      then
         KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Westen_Enum) := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.Landgrößen.MinimaleYAchse > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse / 2
      then
         KartengeneratorVariablenLogik.Landgrößen.MinimaleYAchse := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.Landgrößen.MinimaleXAchse > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse / 2
      then
         KartengeneratorVariablenLogik.Landgrößen.MinimaleXAchse := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.Landgrößen.MaximaleYAchse > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse / 2
      then
         KartengeneratorVariablenLogik.Landgrößen.MaximaleYAchse := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.Landgrößen.MaximaleXAchse > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse / 2
      then
         KartengeneratorVariablenLogik.Landgrößen.MaximaleXAchse := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse / 2;
         
      else
         null;
      end if;

   end Größenanpassung;
   
   

   function KartenpolePrüfen
     (PolgrößeExtern : in KartenDatentypen.KartenfeldNatural)
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
     
   end KartenpolePrüfen;
   
end KartentestsLogik;
