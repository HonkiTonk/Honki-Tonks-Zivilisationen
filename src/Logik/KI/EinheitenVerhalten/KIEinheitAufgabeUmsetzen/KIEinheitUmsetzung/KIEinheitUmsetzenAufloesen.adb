pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenErzeugenEntfernen;

package body KIEinheitUmsetzenAufloesen is

   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      return False;
      
   end EinheitAuflösen;

end KIEinheitUmsetzenAufloesen;
