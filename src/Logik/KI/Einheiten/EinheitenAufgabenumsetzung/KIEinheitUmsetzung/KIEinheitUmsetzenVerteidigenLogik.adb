with KIGefahrErmittelnLogik;

package body KIEinheitUmsetzenVerteidigenLogik is

   function Verteidigen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type EinheitenRecords.SpeziesEinheitnummerRecord;
   begin
      
      if
        KIGefahrErmittelnLogik.GefahrErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = EinheitenKonstanten.LeerEinheit
      then
         null;
         
      else
         null;
      end if;
      
      return False;
      
   end Verteidigen;

end KIEinheitUmsetzenVerteidigenLogik;
