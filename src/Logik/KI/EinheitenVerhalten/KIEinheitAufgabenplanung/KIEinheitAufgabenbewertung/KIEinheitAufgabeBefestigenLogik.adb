pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenRecords; use EinheitenRecords;
with EinheitenDatentypen;
with EinheitenKonstanten;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with KIDatentypen; use KIDatentypen;

with KIGefahrErmittelnLogik;

package body KIEinheitAufgabeBefestigenLogik is

   function SichBefestigen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      if
        KIGefahrErmittelnLogik.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         return -1;
         
      else
         null;
      end if;
      
      case
        LeseEinheitenDatenbank.Einheitenart (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when EinheitenDatentypen.Einheitenart_Kampf_Enum'Range =>
            return 5;
            
         when others =>
            return 10;
      end case;
      
   end SichBefestigen;

end KIEinheitAufgabeBefestigenLogik;
