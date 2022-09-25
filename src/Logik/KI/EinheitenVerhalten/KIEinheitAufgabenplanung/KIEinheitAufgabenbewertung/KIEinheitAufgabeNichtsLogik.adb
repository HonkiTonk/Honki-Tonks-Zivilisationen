pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenRecords; use EinheitenRecords;
with EinheitenKonstanten;

with KIDatentypen; use KIDatentypen;

with KIGefahrErmittelnLogik;

package body KIEinheitAufgabeNichtsLogik is

   function NichtsTun
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      if
        KIGefahrErmittelnLogik.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         return 1;
         
      else
         return -1;
      end if;
      
   end NichtsTun;

end KIEinheitAufgabeNichtsLogik;
