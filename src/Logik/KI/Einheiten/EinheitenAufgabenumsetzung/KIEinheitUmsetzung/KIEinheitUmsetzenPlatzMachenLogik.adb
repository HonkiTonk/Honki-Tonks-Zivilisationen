pragma Warnings (Off, "*array aggregate*");

package body KIEinheitUmsetzenPlatzMachenLogik is

   function PlatzMachen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      -- Platzhalter
      case
        EinheitRasseNummerExtern.Rasse
      is
         when RassenDatentypen.Ekropa_Enum =>
            null;
            
         when others =>
            null;
      end case;
      
      return False;
      
   end PlatzMachen;

end KIEinheitUmsetzenPlatzMachenLogik;
