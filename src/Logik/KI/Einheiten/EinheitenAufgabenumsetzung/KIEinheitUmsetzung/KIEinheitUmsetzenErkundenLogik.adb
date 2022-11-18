with KartenRecordKonstanten;

with LeseEinheitenGebaut;
with LeseWeltkarte;

package body KIEinheitUmsetzenErkundenLogik is

   function Erkunden
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      ZielKoordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        ZielKoordinaten = KartenRecordKonstanten.LeerKoordinate
      then
         return False;
         
      elsif
        LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = ZielKoordinaten
      then
         return False;
         
      elsif
        True = LeseWeltkarte.Sichtbar (KoordinatenExtern => ZielKoordinaten,
                                       RasseExtern       => EinheitRasseNummerExtern.Rasse)
      then
         return False;
         
      else
         return True;
      end if;
      
   end Erkunden;

end KIEinheitUmsetzenErkundenLogik;
