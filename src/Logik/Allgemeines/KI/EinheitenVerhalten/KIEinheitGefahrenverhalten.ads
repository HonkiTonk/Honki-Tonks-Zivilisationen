pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;
with SonstigeVariablen;

package KIEinheitGefahrenverhalten is

   procedure GefahrenHandlungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeindlicheEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
          and
            FeindlicheEinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (FeindlicheEinheitExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (FeindlicheEinheitExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            EinheitRasseNummerExtern.Rasse /= FeindlicheEinheitExtern.Rasse);

end KIEinheitGefahrenverhalten;
