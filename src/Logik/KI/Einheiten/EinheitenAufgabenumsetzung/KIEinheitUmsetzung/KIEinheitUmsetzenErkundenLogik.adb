with KartenRecordKonstanten;
with EinheitenDatentypen;

with LeseEinheitenGebaut;
with LeseWeltkarte;
-- with LeseAllgemeines;

with EinheitVerbessernLogik;

package body KIEinheitUmsetzenErkundenLogik is

   function Erkunden
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
   begin
      
      ZielKoordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      if
        ZielKoordinaten = KartenRecordKonstanten.LeerKoordinate
      then
         return False;
         
      elsif
        LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = ZielKoordinaten
      then
         return False;
         
      elsif
        True = LeseWeltkarte.Sichtbar (KoordinatenExtern => ZielKoordinaten,
                                       SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies)
      then
         return False;
         
      elsif
        -- LeseAllgemeines.Rundenanzahl mod 20 = 0
        -- and
        EinheitVerbessernLogik.EinheitVerbesserbar (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) /= EinheitenKonstanten.LeerID
      then
         return False;
         
      else
         return True;
      end if;
      
   end Erkunden;

end KIEinheitUmsetzenErkundenLogik;
