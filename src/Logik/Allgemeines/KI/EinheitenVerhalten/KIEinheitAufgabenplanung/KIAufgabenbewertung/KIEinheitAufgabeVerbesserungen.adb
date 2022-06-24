pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;

with KIPruefungen;

package body KIEinheitAufgabeVerbesserungen is

   function StadtUmgebungVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeit
   is begin
      
      case
        KIPruefungen.StadtUmgebungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern).XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return 0;
            
         when others =>
            return 5;
      end case;
            
   end StadtUmgebungVerbessern;

end KIEinheitAufgabeVerbesserungen;
