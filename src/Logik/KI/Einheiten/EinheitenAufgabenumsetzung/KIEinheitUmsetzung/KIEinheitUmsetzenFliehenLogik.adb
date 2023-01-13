with KIGefahrErmittelnLogik;

package body KIEinheitUmsetzenFliehenLogik is

   function Fliehen
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
      
   end Fliehen;

end KIEinheitUmsetzenFliehenLogik;
