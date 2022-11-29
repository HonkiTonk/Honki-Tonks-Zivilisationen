with KartenRecordKonstanten;
with EinheitenDatentypen;

with LeseEinheitenGebaut;
with LeseWeltkarte;
-- with LeseAllgemeines;

with EinheitVerbessernLogik;

package body KIEinheitUmsetzenErkundenLogik is

   function Erkunden
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
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
         
      elsif
       -- LeseAllgemeines.Rundenanzahl mod 20 = 0
       -- and
          EinheitVerbessernLogik.EinheitVerbesserbar (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerID
      then
         return False;
         
      else
         return True;
      end if;
      
   end Erkunden;

end KIEinheitUmsetzenErkundenLogik;
