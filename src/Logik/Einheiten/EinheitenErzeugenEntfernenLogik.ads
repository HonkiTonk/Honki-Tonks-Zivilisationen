with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with KartenRecords;
with EinheitenRecords;
with EinheitenDatentypen;
with SpielVariablen;
with StadtRecords;
with Weltkarte;

package EinheitenErzeugenEntfernenLogik is
   pragma Elaborate_Body;

   procedure EinheitErzeugen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

   procedure EinheitEntfernen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   Transporterkapazität : EinheitenDatentypen.Transportplätze;

   EinheitNummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;

   procedure EinheitEntfernenLadung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure Entfernen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end EinheitenErzeugenEntfernenLogik;
