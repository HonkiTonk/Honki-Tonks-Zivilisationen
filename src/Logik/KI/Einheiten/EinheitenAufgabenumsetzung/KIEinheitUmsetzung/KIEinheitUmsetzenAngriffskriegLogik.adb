package body KIEinheitUmsetzenAngriffskriegLogik is

   function AngriffskriegVorbereiten
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
      
   end AngriffskriegVorbereiten;

end KIEinheitUmsetzenAngriffskriegLogik;
