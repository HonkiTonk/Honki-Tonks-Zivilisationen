pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with KartenDatentypen;

package KartenfelderBewerten is

   procedure KartenfelderBewerten
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
     with
       Pre => (
                 if RasseExtern /= RassenDatentypen.Keine_Rasse_Enum then SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   Oberflächenteiler : KartenDatentypen.KartenfeldPositiv;
   Unterflächenteiler : KartenDatentypen.KartenfeldPositiv;
   Kernflächenteiler : KartenDatentypen.KartenfeldPositiv;

end KartenfelderBewerten;
