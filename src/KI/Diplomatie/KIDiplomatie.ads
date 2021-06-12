pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package KIDiplomatie is

   procedure Diplomatie
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 2);

   procedure DiplomatieKIMensch
     (RasseMenschExtern, RasseKIExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseMenschExtern) = 1
          and
            GlobaleVariablen.RassenImSpiel (RasseKIExtern) = 2);

   procedure DiplomatieKIKI
     (EigeneRasseExtern, FremdeRasseKIExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = 2
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseKIExtern) = 2);

end KIDiplomatie;
