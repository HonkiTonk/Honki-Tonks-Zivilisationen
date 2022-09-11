pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenErzeugenEntfernenLogik;

package body KIEinheitUmsetzenAufloesen is

   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      return False;
      
   end EinheitAuflösen;

end KIEinheitUmsetzenAufloesen;
