pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package KennenLernen is

   procedure Erstkontakt
     (EigeneRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= GlobaleDatentypen.Leer);

private

   procedure ErstkontaktMenschMensch
     (EigeneRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SonstigeDatentypen.Spieler_Mensch
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = SonstigeDatentypen.Spieler_Mensch);

   procedure ErstkontaktMenschKI
     (EigeneRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SonstigeDatentypen.Spieler_Mensch
             or
               GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = SonstigeDatentypen.Spieler_Mensch));

end KennenLernen;
