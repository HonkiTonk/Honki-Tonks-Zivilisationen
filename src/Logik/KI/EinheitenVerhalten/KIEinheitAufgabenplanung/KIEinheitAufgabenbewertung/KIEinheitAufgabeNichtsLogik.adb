pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenRecords; use EinheitenRecords;
with EinheitenKonstanten;

with KIKonstanten;

with KIGefahrErmittelnLogik;

package body KIEinheitAufgabeNichtsLogik is

   function NichtsTun
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      if
        KIGefahrErmittelnLogik.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         return KIKonstanten.NichtsTunBewertung;
         
      else
         return KIKonstanten.UnmöglichAufgabenbewertung;
      end if;
      
   end NichtsTun;

end KIEinheitAufgabeNichtsLogik;
