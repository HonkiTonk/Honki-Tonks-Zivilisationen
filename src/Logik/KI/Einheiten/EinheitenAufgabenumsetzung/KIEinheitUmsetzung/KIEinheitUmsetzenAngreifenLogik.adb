with KartenRecordKonstanten;
with KartenRecords;

with LeseEinheitenGebaut;

package body KIEinheitUmsetzenAngreifenLogik is

   function Angreifen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      case
        LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KartenRecordKonstanten.LeerKoordinate
      is
         when True =>
            return False;
            
         when False =>
            return True;
      end case;
      
   end Angreifen;

end KIEinheitUmsetzenAngreifenLogik;
