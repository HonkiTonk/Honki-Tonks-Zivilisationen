pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitStadtRecords;
with SonstigeVariablen;
with KartengrundDatentypen;
with KartenRecords;

package WaldAnlegen is

   procedure WaldAnlegen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

private

   NeuerGrund : KartengrundDatentypen.Kartengrund_Vorhanden_Enum;

   Koordinaten : KartenRecords.AchsenKartenfeldPositivRecord;

end WaldAnlegen;
