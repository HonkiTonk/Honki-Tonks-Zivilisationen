pragma Warnings (Off, "*array aggregate*");

with EinheitenErzeugenEntfernenLogik;

package body KIEinheitUmsetzenAufloesenLogik is

   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      return False;
      
   end EinheitAuflösen;

end KIEinheitUmsetzenAufloesenLogik;
