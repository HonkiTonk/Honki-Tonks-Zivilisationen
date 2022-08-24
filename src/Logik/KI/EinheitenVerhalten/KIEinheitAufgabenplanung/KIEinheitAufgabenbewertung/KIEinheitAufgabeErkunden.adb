pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenRecords; use EinheitenRecords;
with EinheitenKonstanten;

with KIDatentypen; use KIDatentypen;

with KIGefahrErmitteln;

package body KIEinheitAufgabeErkunden is

   function Erkunden
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      if
        KIGefahrErmitteln.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         null;
         
      else
         return -1;
      end if;
      
      return 5;
      
   end Erkunden;

end KIEinheitAufgabeErkunden;
