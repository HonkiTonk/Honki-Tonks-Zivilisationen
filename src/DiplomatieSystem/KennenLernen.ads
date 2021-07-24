pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package KennenLernen is

   procedure Erstkontakt
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= GlobaleDatentypen.Leer);

end KennenLernen;
