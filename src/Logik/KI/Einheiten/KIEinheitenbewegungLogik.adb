with KartenRecords;
with KartenRecordKonstanten;

with LeseEinheitenGebaut;

with KIEinheitHandlungstestsLogik;
with KIBewegungDurchfuehrenLogik;

package body KIEinheitenbewegungLogik is

   function Bewegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      case
        LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KartenRecordKonstanten.LeerKoordinate
      is
         when False =>
            KIBewegungDurchfuehrenLogik.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return KIEinheitHandlungstestsLogik.HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when True =>
            return False;
      end case;
      
   end Bewegen;

end KIEinheitenbewegungLogik;
