pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package DiplomatischerZustand is

   procedure KriegDurchDirektenAngriff
     (AngreifendeRasseExtern, VerteidigendeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (AngreifendeRasseExtern /= VerteidigendeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (AngreifendeRasseExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (VerteidigendeRasseExtern) /= GlobaleDatentypen.Leer);

   function DiplomatischenStatusPrüfen
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.Status_Untereinander_Enum
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= GlobaleDatentypen.Leer);

end DiplomatischerZustand;
