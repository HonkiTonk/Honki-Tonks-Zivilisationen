pragma Warnings (Off, "*array aggregate*");

package body KIEinheitUmsetzenVerteidigungskriegLogik is

   function VerteidigungskriegVorbereiten
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
      
   end VerteidigungskriegVorbereiten;

end KIEinheitUmsetzenVerteidigungskriegLogik;
