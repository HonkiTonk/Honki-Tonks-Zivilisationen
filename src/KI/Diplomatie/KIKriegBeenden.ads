pragma SPARK_Mode (On);

package KIKriegBeenden is

   function KriegBeenden
     (EigeneRasseExtern, FeindlicheRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = GlobaleDatentypen.Spieler_KI
          and
            GlobaleVariablen.RassenImSpiel (FeindlicheRasseExtern) /= GlobaleDatentypen.Leer
          and
            EigeneRasseExtern /= FeindlicheRasseExtern);

end KIKriegBeenden;
