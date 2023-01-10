with KartenRecordKonstanten;
with KartenRecords;

with LeseEinheitenGebaut;

package body KIEinheitUmsetzenAngreifenLogik is

   function Angreifen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      case
        LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = KartenRecordKonstanten.LeerKoordinate
      is
         when True =>
            return False;
            
         when False =>
            return True;
      end case;
      
   end Angreifen;

end KIEinheitUmsetzenAngreifenLogik;
