pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;

package KennenLernen is

   procedure Erstkontakt
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 SonstigeVariablen.RassenImSpiel (EigeneRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SonstigeVariablen.RassenImSpiel (FremdeRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   procedure ErstkontaktMenschMensch
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 SonstigeVariablen.RassenImSpiel (EigeneRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 SonstigeVariablen.RassenImSpiel (FremdeRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure ErstkontaktMenschKI
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 (SonstigeVariablen.RassenImSpiel (EigeneRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
                  or
                    SonstigeVariablen.RassenImSpiel (FremdeRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum)
              );

end KennenLernen;
