pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtBauen;

package body KIEinheitUmsetzenSiedeln is

   function StadtErrichten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      return StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end StadtErrichten;

end KIEinheitUmsetzenSiedeln;
