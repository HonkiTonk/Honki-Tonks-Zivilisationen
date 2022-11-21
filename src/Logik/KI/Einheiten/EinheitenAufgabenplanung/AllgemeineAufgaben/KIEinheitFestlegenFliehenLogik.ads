with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with KartenRecords;
private with KartenDatentypen;

with LeseGrenzen;

private with LeseWeltkarteneinstellungen;

package KIEinheitFestlegenFliehenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function Fliehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

private
   use type KartenDatentypen.Kartenfeld;

   ZielKoordinate : KartenRecords.AchsenKartenfeldNaturalRecord;

   function Ziel
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  Ziel'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  Ziel'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );

end KIEinheitFestlegenFliehenLogik;
