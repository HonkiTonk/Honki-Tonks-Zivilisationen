pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with ZahlenDatentypen;
with KartenDatentypen;
with SonstigeVariablen;

package KartenfelderBewerten is

   procedure KartenfelderBewerten
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
     with
       Pre => (
                 if RasseExtern /= RassenDatentypen.Keine_Rasse_Enum then SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   type MultiplikatorArray is array (KartenDatentypen.EbenePlanet'Range) of ZahlenDatentypen.EigenesPositive;
   Multiplikator : MultiplikatorArray;

end KartenfelderBewerten;
