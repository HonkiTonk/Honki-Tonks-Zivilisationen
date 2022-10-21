pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenRecords; use EinheitenRecords;
with EinheitenKonstanten;

with KIKonstanten;

with KIGefahrErmittelnLogik;

package body KIEinheitAufgabeErkundenLogik is

   function Erkunden
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      if
        KIGefahrErmittelnLogik.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         null;
         
      else
         return KIKonstanten.UnmöglichAufgabenbewertung;
      end if;
      
      return 5;
      
   end Erkunden;

end KIEinheitAufgabeErkundenLogik;
