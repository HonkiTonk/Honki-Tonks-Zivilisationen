with AufgabenDatentypen;
with KartenRecords;
with KartenRecordKonstanten;

with LeseEinheitenGebaut;

with KIDatentypen;

with KIEinheitAufgabenumsetzungLogik;
with KIEinheitHandlungstestsLogik;

package body KIEinheitenAufgabenumsetzungLogik is

   function Aufgabenumsetzung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type KIDatentypen.Einheit_Aufgabe_Enum;
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      if
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Leer_Aufgabe_Enum
        and
          LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
        and
          LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KartenRecordKonstanten.LeerKoordinate
      then
         KIEinheitAufgabenumsetzungLogik.AufgabeUmsetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         return KIEinheitHandlungstestsLogik.HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         return False;
      end if;
      
   end Aufgabenumsetzung;

end KIEinheitenAufgabenumsetzungLogik;
