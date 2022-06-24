pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

package KennenLernen is

   procedure Erstkontakt
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 SpielVariablen.RassenImSpiel (EigeneRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (FremdeRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   procedure ErstkontaktMenschMensch
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 SpielVariablen.RassenImSpiel (EigeneRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (FremdeRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure ErstkontaktMenschKI
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 (SpielVariablen.RassenImSpiel (EigeneRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
                  or
                    SpielVariablen.RassenImSpiel (FremdeRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum)
              );

end KennenLernen;
