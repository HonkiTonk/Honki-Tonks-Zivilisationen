pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package KIDiplomatie is

   procedure Diplomatie
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_KI);

   procedure DiplomatieKIMensch
     (RasseMenschExtern, RasseKIExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseMenschExtern) = GlobaleDatentypen.Spieler_Mensch
          and
            GlobaleVariablen.RassenImSpiel (RasseKIExtern) = GlobaleDatentypen.Spieler_KI);

   procedure DiplomatieKIKI
     (EigeneRasseExtern, FremdeRasseKIExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = GlobaleDatentypen.Spieler_KI
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseKIExtern) = GlobaleDatentypen.Spieler_KI);

end KIDiplomatie;
