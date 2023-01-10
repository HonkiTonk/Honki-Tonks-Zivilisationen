with EinheitenErzeugenEntfernenLogik;

package body KIEinheitUmsetzenAufloesenLogik is

   function EinheitAuflösen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      return False;
      
   end EinheitAuflösen;

end KIEinheitUmsetzenAufloesenLogik;
