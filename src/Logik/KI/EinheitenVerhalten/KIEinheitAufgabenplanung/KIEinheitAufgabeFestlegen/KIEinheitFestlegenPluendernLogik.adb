pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body KIEinheitFestlegenPluendernLogik is

   function StadtumgebungZerstören
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
      
   end StadtumgebungZerstören;

end KIEinheitFestlegenPluendernLogik;
