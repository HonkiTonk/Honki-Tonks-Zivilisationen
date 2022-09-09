pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

package EinheitenTransporter is
   
   function KannTransportiertWerden
     (LadungExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 LadungExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (LadungExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (LadungExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 TransporterExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (TransporterExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end EinheitenTransporter;
