pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;
with SonstigeVariablen;

package KIEinheit is

   procedure Einheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

private

   FeindlicheEinheit : EinheitenRecords.RasseEinheitnummerRecord;

end KIEinheit;
