pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

with KIDatentypen;

package KIEinheitAufgabeNichts is

   function NichtsTun
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KIDatentypen.AufgabenWichtigkeitKlein
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitAufgabeNichts;
