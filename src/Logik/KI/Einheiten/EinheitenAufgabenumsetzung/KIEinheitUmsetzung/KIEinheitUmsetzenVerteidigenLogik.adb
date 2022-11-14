with EinheitenKonstanten;

with KIGefahrErmittelnLogik;

package body KIEinheitUmsetzenVerteidigenLogik is

   function Verteidigen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type EinheitenRecords.RasseEinheitnummerRecord;
   begin
      
      if
        KIGefahrErmittelnLogik.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         null;
         
      else
         null;
      end if;
      
      return False;
      
   end Verteidigen;

end KIEinheitUmsetzenVerteidigenLogik;
