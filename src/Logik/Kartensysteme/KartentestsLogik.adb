pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

package body KartentestsLogik is

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
