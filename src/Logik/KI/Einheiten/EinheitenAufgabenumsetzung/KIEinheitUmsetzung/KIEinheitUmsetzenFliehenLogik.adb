with EinheitenRecords; use EinheitenRecords;
with EinheitenKonstanten;

with KIGefahrErmittelnLogik;

package body KIEinheitUmsetzenFliehenLogik is

   function Fliehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        KIGefahrErmittelnLogik.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         null;
         
      else
         null;
      end if;
      
      return False;
      
   end Fliehen;

end KIEinheitUmsetzenFliehenLogik;
