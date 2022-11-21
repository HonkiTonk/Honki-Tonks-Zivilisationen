with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;
with StadtRecords;

private with EinheitenDatentypen;
private with KartenDatentypen;
private with KartenRecords;

with LeseGrenzen;

package SichtbarkeitsberechnungssystemLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure SichtbarkeitsprüfungFürEinheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure SichtbarkeitsprüfungFürStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   SichtweiteObjekt : KartenDatentypen.Sichtweite;

   EinheitID : EinheitenDatentypen.EinheitenIDMitNullWert;

   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Einheitenkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

   procedure SichtbarkeitsprüfungOhneBlockade
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      SichtweiteExtern : in KartenDatentypen.Sichtweite)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end SichtbarkeitsberechnungssystemLogik;
