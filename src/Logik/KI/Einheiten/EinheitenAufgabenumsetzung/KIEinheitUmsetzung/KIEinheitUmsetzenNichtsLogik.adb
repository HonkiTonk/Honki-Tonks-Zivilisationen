pragma Warnings (Off, "*array aggregate*");

package body KIEinheitUmsetzenNichtsLogik is

   function NichtsTun
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
      
      return True;
      
   end NichtsTun;

end KIEinheitUmsetzenNichtsLogik;
