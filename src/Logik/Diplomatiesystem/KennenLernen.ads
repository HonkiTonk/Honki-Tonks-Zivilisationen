pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with GlobaleVariablen;

package KennenLernen is

   procedure Erstkontakt
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

private

   procedure ErstkontaktMenschMensch
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = RassenDatentypen.Spieler_Mensch_Enum
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = RassenDatentypen.Spieler_Mensch_Enum);

   procedure ErstkontaktMenschKI
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = RassenDatentypen.Spieler_Mensch_Enum
             or
               GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = RassenDatentypen.Spieler_Mensch_Enum));

end KennenLernen;
