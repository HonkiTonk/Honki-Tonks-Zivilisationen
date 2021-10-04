pragma SPARK_Mode (On);

package KIKriegBeenden is

   function KriegBeenden
     (EigeneRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      FeindlicheRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SonstigeDatentypen.Spieler_KI
          and
            GlobaleVariablen.RassenImSpiel (FeindlicheRasseExtern) /= GlobaleDatentypen.Leer
          and
            EigeneRasseExtern /= FeindlicheRasseExtern);

end KIKriegBeenden;
