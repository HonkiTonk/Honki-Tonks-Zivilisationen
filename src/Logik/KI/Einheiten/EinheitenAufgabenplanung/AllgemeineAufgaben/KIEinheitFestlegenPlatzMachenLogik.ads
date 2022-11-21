with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with KartenRecords;

package KIEinheitFestlegenPlatzMachenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function PlatzMachen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

private

   Einheitenkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitFestlegenPlatzMachenLogik;
