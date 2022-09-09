pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

package PZBEingesetztLogik is

   function PZBEingesetzt
     (EinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (EinheitExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitExtern.Rasse).Einheitengrenze
              );

end PZBEingesetztLogik;
