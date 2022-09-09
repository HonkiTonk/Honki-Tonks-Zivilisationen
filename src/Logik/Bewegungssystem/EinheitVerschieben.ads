pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with KartenRecords;
private with KartenDatentypen;
private with EinheitenDatentypen;
private with StadtRecords;

package EinheitVerschieben is

   procedure VonEigenemLandWerfen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (KontaktierteRasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure EinheitVerschieben
     (RasseLandExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (RasseLandExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   UmgebungPrüfen : KartenDatentypen.Sichtweite;
   BereitsGeprüft : KartenDatentypen.SichtweiteNatural;
   
   EinheitNummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenwertVerschieben : KartenRecords.AchsenKartenfeldNaturalRecord;
   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   Einheitenkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure EinheitenErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (KontaktierteRasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end EinheitVerschieben;
