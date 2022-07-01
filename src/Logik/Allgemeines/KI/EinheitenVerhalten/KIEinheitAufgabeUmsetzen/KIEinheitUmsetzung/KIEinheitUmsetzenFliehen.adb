pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenRecords; use EinheitenRecords;
with EinheitenKonstanten;

with KIGefahrErmitteln;

package body KIEinheitUmsetzenFliehen is

   function Fliehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        KIGefahrErmitteln.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         null;
         
      else
         null;
      end if;
      
      return False;
      
   end Fliehen;

end KIEinheitUmsetzenFliehen;
