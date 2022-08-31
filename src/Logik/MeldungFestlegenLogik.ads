pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

package MeldungFestlegenLogik is

   procedure MeldungFestlegen
     (MeldungExtern : in Positive);

   procedure SpielermeldungFestlegen
     (MeldungExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end MeldungFestlegenLogik;
