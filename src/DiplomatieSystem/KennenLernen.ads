pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package KennenLernen is

   procedure Erstkontakt
     (EigeneRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= GlobaleDatentypen.Leer);

private

   procedure ErstkontaktMenschMensch
     (EigeneRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = GlobaleDatentypen.Spieler_Mensch
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = GlobaleDatentypen.Spieler_Mensch);

   procedure ErstkontaktMenschKI
     (EigeneRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = GlobaleDatentypen.Spieler_Mensch
             or
               GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = GlobaleDatentypen.Spieler_Mensch));

end KennenLernen;
