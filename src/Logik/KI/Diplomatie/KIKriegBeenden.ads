pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KIKriegBeenden is

   function KriegBeenden
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FeindlicheRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (EigeneRasseExtern) = RassenDatentypen.KI_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (FeindlicheRasseExtern) /= GlobaleDatentypen.Leer
               and
                 EigeneRasseExtern /= FeindlicheRasseExtern
              );

end KIKriegBeenden;
