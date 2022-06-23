pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SonstigeVariablen;

package Karte is

   procedure AnzeigeKarte
     (RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseEinheitExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

end Karte;
