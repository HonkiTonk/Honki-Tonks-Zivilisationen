pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with KartenDatentypen;

package KartenfelderBewertenLogik is

   procedure KartenfelderBewerten
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
     with
       Pre => (
                 if RasseExtern /= RassenDatentypen.Keine_Rasse_Enum then SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   type KartenzeitwertArray is array (KartenDatentypen.EbenePlanet'Range) of KartenDatentypen.KartenfeldNatural;
   Kartenzeitwert : KartenzeitwertArray;

   procedure Kartenbewertung
     (RasseExtern : in RassenDatentypen.Rassen_Enum;
      EbeneExtern : in KartenDatentypen.EbenePlanet)
     with
       Pre => (
                 if RasseExtern /= RassenDatentypen.Keine_Rasse_Enum then SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end KartenfelderBewertenLogik;
