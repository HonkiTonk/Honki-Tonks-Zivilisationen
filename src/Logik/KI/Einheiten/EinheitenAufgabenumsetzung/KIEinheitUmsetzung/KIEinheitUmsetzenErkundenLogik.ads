with RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with KartenRecords;

package KIEinheitUmsetzenErkundenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function Erkunden
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

private

   ZielKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitUmsetzenErkundenLogik;
