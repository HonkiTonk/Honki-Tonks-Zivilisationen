pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenRecords; use EinheitenRecords;
with KartenKonstanten;
with EinheitenKonstanten;

with KIDatentypen; use KIDatentypen;

with KIPruefungen;
with KIGefahrErmitteln;

package body KIEinheitAufgabeVerbesserungen is

   function StadtUmgebungVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      Kartenwert := KIPruefungen.StadtUmgebungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        Kartenwert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return -1;
            
         when others =>
            null;
      end case;
      
      if
        KIGefahrErmitteln.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         null;
         
      else
         return -1;
      end if;
      
      return 10;
            
   end StadtUmgebungVerbessern;

end KIEinheitAufgabeVerbesserungen;
