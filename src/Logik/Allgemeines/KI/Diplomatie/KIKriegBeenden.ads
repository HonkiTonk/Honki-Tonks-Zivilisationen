pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KIKriegBeenden is

   function KriegBeenden
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FeindlicheRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (EigeneRasseExtern) = RassenDatentypen.Spieler_KI_Enum
          and
            SonstigeVariablen.RassenImSpiel (FeindlicheRasseExtern) /= GlobaleDatentypen.Leer
          and
            EigeneRasseExtern /= FeindlicheRasseExtern);

end KIKriegBeenden;
