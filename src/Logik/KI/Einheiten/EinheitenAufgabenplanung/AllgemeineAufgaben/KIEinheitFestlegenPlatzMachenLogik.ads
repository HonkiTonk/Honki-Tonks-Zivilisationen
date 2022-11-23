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
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

private

   Einheitenkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitFestlegenPlatzMachenLogik;
