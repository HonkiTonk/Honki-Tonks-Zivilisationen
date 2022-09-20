pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with KartengeneratorVariablen;

package body KartentestsLogik is
   
   procedure Größenanpassung
   is begin

      if
        KartengeneratorVariablen.Polgrößen (KartenDatentypen.Norden_Enum) > KartengeneratorVariablen.Kartenparameter.Kartengröße.YAchse / 2
      then
         KartengeneratorVariablen.Polgrößen (KartenDatentypen.Norden_Enum) := KartengeneratorVariablen.Kartenparameter.Kartengröße.YAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablen.Polgrößen (KartenDatentypen.Süden_Enum) > KartengeneratorVariablen.Kartenparameter.Kartengröße.YAchse / 2
      then
         KartengeneratorVariablen.Polgrößen (KartenDatentypen.Süden_Enum) := KartengeneratorVariablen.Kartenparameter.Kartengröße.YAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablen.Polgrößen (KartenDatentypen.Osten_Enum) > KartengeneratorVariablen.Kartenparameter.Kartengröße.XAchse / 2
      then
         KartengeneratorVariablen.Polgrößen (KartenDatentypen.Osten_Enum) := KartengeneratorVariablen.Kartenparameter.Kartengröße.XAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablen.Polgrößen (KartenDatentypen.Westen_Enum) > KartengeneratorVariablen.Kartenparameter.Kartengröße.XAchse / 2
      then
         KartengeneratorVariablen.Polgrößen (KartenDatentypen.Westen_Enum) := KartengeneratorVariablen.Kartenparameter.Kartengröße.XAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablen.Landgrößen.MinimaleYAchse > KartengeneratorVariablen.Kartenparameter.Kartengröße.YAchse / 2
      then
         KartengeneratorVariablen.Landgrößen.MinimaleYAchse := KartengeneratorVariablen.Kartenparameter.Kartengröße.YAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablen.Landgrößen.MinimaleXAchse > KartengeneratorVariablen.Kartenparameter.Kartengröße.XAchse / 2
      then
         KartengeneratorVariablen.Landgrößen.MinimaleXAchse := KartengeneratorVariablen.Kartenparameter.Kartengröße.XAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablen.Landgrößen.MaximaleYAchse > KartengeneratorVariablen.Kartenparameter.Kartengröße.YAchse / 2
      then
         KartengeneratorVariablen.Landgrößen.MaximaleYAchse := KartengeneratorVariablen.Kartenparameter.Kartengröße.YAchse / 2;
         
      else
         null;
      end if;
      
      if
        KartengeneratorVariablen.Landgrößen.MaximaleXAchse > KartengeneratorVariablen.Kartenparameter.Kartengröße.XAchse / 2
      then
         KartengeneratorVariablen.Landgrößen.MaximaleXAchse := KartengeneratorVariablen.Kartenparameter.Kartengröße.XAchse / 2;
         
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
