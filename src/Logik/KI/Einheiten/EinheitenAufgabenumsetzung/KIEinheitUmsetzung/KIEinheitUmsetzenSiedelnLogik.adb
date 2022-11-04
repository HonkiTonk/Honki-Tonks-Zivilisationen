pragma Warnings (Off, "*array aggregate*");

with StadtBauenLogik;

package body KIEinheitUmsetzenSiedelnLogik is

   function StadtErrichten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      return StadtBauenLogik.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end StadtErrichten;

end KIEinheitUmsetzenSiedelnLogik;
