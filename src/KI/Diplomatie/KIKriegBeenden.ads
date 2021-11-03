pragma SPARK_Mode (On);

package KIKriegBeenden is

   function KriegBeenden
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FeindlicheRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemDatentypen.Spieler_KI
          and
            GlobaleVariablen.RassenImSpiel (FeindlicheRasseExtern) /= GlobaleDatentypen.Leer
          and
            EigeneRasseExtern /= FeindlicheRasseExtern);

end KIKriegBeenden;
