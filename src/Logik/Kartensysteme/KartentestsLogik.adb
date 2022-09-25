pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with KartengeneratorVariablenLogik;

package body KartentestsLogik is
   
   procedure Größenanpassung
   is begin

      if
        KartengeneratorVariablenLogik.Polgrößen (KartenDatentypen.Norden_Enum) > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse / 2
      then
         KartengeneratorVariablenLogik.Polgrößen (KartenDatentypen.Norden_Enum) := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.Polgrößen (KartenDatentypen.Süden_Enum) > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse / 2
      then
         KartengeneratorVariablenLogik.Polgrößen (KartenDatentypen.Süden_Enum) := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.Polgrößen (KartenDatentypen.Osten_Enum) > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse / 2
      then
         KartengeneratorVariablenLogik.Polgrößen (KartenDatentypen.Osten_Enum) := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablenLogik.Polgrößen (KartenDatentypen.Westen_Enum) > KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse / 2
      then
         KartengeneratorVariablenLogik.Polgrößen (KartenDatentypen.Westen_Enum) := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse / 2;
         
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
      return KartenDatentypen.Kartenpole_Enum
   is begin
     
      case
        PolgrößeExtern
      is
         when 0 =>
            return KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum;
            
         when others =>
            return KartenDatentypen.Kartenpol_Vorhanden_Enum;
      end case;
     
   end KartenpolePrüfen;
   
end KartentestsLogik;
