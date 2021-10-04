pragma SPARK_Mode (On);

with SonstigeDatentypen, GlobaleVariablen;
use SonstigeDatentypen;

package KIDiplomatie is

   procedure Diplomatie
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_KI);

   procedure DiplomatieKIMensch
     (RasseMenschExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      RasseKIExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseMenschExtern) = SonstigeDatentypen.Spieler_Mensch
          and
            GlobaleVariablen.RassenImSpiel (RasseKIExtern) = SonstigeDatentypen.Spieler_KI);

   procedure DiplomatieKIKI
     (EigeneRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseKIExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SonstigeDatentypen.Spieler_KI
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseKIExtern) = SonstigeDatentypen.Spieler_KI);

end KIDiplomatie;
